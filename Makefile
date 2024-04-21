.PHONY: all
all: fonts omz dotfiles colorls  ## Installs the dotfiles, brew and oh-my-zsh plugins.

.PHONY: fonts
fonts:
	mkdir -p ~/.local/share/fonts
	cd ~/.local/share/fonts && curl -fLO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf && curl -fLO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf  && curl -fLO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf  && curl -fLO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
	cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip && unzip FiraCode.zip && rm FiraCode.zip README.md LICENSE

.PHONY: dotfiles
dotfiles: ## Installs the dotfiles.
	# add aliases for dotfiles
	for file in $(shell find $(CURDIR) -name ".*" -not -name ".gitignore" -not -name ".travis.yml" -not -name ".git" -not -name ".*.swp" -not -name ".gnupg"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done; \
	gpg --list-keys || true;
	ln -sfn $(CURDIR)/.gnupg/gpg.conf $(HOME)/.gnupg/gpg.conf;
	ln -sfn $(CURDIR)/.gnupg/gpg-agent.conf $(HOME)/.gnupg/gpg-agent.conf;
	ln -snf "$(CURDIR)/.vimrc" "$(HOME)/.vimrc"
	ln -snf "$(CURDIR)/bash/.bashrc" "$(HOME)/.bashrc"
	ln -snf $(CURDIR)/.bash_profile $(HOME)/.profile;
	ln -snf "$(CURDIR)/zsh/.zshrc" "$(HOME)/.zshrc"
	sudo ln -snf "$(CURDIR)/functions/alogin" "/usr/local/bin/alogin"
	sudo ln -snf "$(CURDIR)/functions/klogin" "/usr/local/bin/klogin"
	sudo ln -snf "$(CURDIR)/functions/k8s-pod-events" "/usr/local/bin/k8s-pod-events"
	sudo ln -snf "$(CURDIR)/functions/k8s-decrypt-secret" "/usr/local/bin/k8s-decrypt-secret"
	git update-index --skip-worktree $(CURDIR)/.gitconfig;
	curl https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh

.PHONY: brew
brew: # Install Brew and installs apps with Brew
	chmod +x $(CURDIR)/brew/installBrew.sh && $(CURDIR)/brew/installBrew.sh
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
	brew bundle install --file $(CURDIR)/brew/Brewfile

.PHONY: omz
omz: # Installs oh-my-zsh plugins
	sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
	git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

.PHONY: colorls
colorls:
	gem install colorls

.PHONY: test
test: shellcheck ## Runs all the tests on the files in the repository.

# if this session isn't interactive, then we don't want to allocate a
# TTY, which would fail, but if it is interactive, we do want to attach
# so that the user can send e.g. ^C through.
INTERACTIVE := $(shell [ -t 0 ] && echo 1 || echo 0)
ifeq ($(INTERACTIVE), 1)
	DOCKER_FLAGS += -t
endif

.PHONY: shellcheck
shellcheck: ## Runs the shellcheck tests on the scripts.
	docker run --rm -i $(DOCKER_FLAGS) \
		--name df-shellcheck \
		-v $(CURDIR):/usr/src:ro \
		--workdir /usr/src \
		r.j3ss.co/shellcheck ./test.sh

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
