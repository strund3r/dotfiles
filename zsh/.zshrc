# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export TERM="xterm-256color"
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:/usr/local/packer:~/Library/Python/3.7/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/$(id -un)/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
POWERLEVEL9K_MODE='nerdfont-complete'
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Ignore permission issues and load the completion system normally.
ZSH_DISABLE_COMPFIX=true

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

source ~/.zplug/init.zsh

# CODE::STATS
#CODESTATS_API_KEY="SFMyNTY.YzNSeWRXNWtNM0k9IyNOams0TkE9PQ.gVoX5c-KlIpsVx4BmCfKQffVOqfLJiU1pHAGkryhZVE"

#zplug "code-stats/code-stats-zsh", from:gitlab, use:"codestats.plugin.zsh"
zplug "hlissner/zsh-autopair", defer:2
zplug romkatv/powerlevel10k, as:theme, depth:1

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    aws
    docker
    fd
    git
    fzf
    jsontools
    kubectl
    macports
    macos
    python
    sudo
    torrent
    web-search
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
)
#zsh-apple-touchbar
#zsh-syntax-highlighting

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bold,underline" #bg=cyan

# Lad Gti completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)
fpath=(~/.zsh_functions $fpath)
autoload -Uz $fpath[1]/*(.:t)

export FZF_BASE=/home/linuxbrew/.linuxbrew/bin/fzf

source $ZSH/oh-my-zsh.sh

autoload -U compinit && compinit

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Reload the plugin to highlight the commands each time Iterm2 starts
# source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


### VISUAL CUSTOMISATION ###


# Elements options of left prompt
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir_writable dir ssh docker_machine vcs aws_prompt_info)
# Elements options of right prompt
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(aws kubecontext status command_execution_time root_indicator background_jobs history battery time)

# Add a second prompt line for the command
POWERLEVEL9K_PROMPT_ON_NEWLINE=true

# Add a space in the first prompt
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%f"

# Visual customisation of the second prompt line
# local user_symbmainol="$"
# if [[ $(print -P "%#") =~ "#" ]]; then
#     user_symbol = "#"
# fi
local usr_symbol="$"
if [ `whoami` = 'root' ]; then
    usr_symbol="#"
fi
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%{%B%F{black}%K{green}%} $usr_symbol%{%b%f%k%F{green}%} %{%f%}"


# Change the git status to red when something isn't committed and pushed
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='red'

# Add a new line after the global prompt
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

# Battery background color
#POWERLEVEL9K_BATTERY_STAGES="▁▂▃▄▅▆▇█"
POWERLEVEL9K_BATTERY_ICON='\U1F50B'
POWERLEVEL9K_BATTERY_LEVEL_BACKGROUND=(red3 darkorange3 darkgoldenrod gold3 yellow3 chartreuse2 mediumspringgreen green3 green3 green4 darkgreen)
POWERLEVEL9K_BATTERY_LOW_THRESHOLD=35

# Display the git hash / changeset
POWERLEVEL9K_SHOW_CHANGESET=true

# Remove folder icon
POWERLEVEL9K_HOME_SUB_ICON=''
POWERLEVEL9K_FOLDER_ICON=''

# Show last command execution time
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=2

# AWS
POWERLEVEL9K_IP_INTERFACE=eth0

# Show prompt segment "kubecontext" only when the command you are
# typing invokes kubectl, helm, kubens or kubectx.
POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx'

# Show aws only when the the command you are typing invokes one of these tools.
# Tip: Remove the next line to always show aws.
POWERLEVEL9K_AWS_SHOW_ON_COMMAND='aws|awless|terraform|pulumi|terragrunt'

# Truncate directory
#POWERLEVEL9K_SHORTEN_STRATEGY=none
#POWERLEVEL9K_SHORTEN_STRATEGY=truncate_middle
#POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
#POWERLEVEL9K_SHORTEN_DELIMITER='..'


# Colorise the top Tabs of Iterm2 with the same color as background
# Just change the 18/26/33 wich are the rgb values
echo -e "\033]6;1;bg;red;brightness;18\a"
echo -e "\033]6;1;bg;green;brightness;26\a"
echo -e "\033]6;1;bg;blue;brightness;33\a"

# Only suggest corrections for commands, not arguments
setopt CORRECT
unsetopt CORRECTALL

########## Aliases ##########
alias cp='cp --recursive --verbose'
alias grep='grep --color=auto'
alias mkdir='mkdir --parents --verbose'
alias mv='mv --verbose'
alias wget='wget --continue'

alias cls="clear"
alias down="cd ~/Downloads"
alias ..="cd .."
alias ....="cd ../.."

alias update='sudo apt update'
alias upgrade='update; sudo apt -y upgrade; brew upgrade'
alias install='sudo apt -y install'
# alias update="pamac update --no-confirm --aur; brew upgrade"
# alias upgrade='sudo pacman -Syu; yay -Syu'
# alias install-{pac,pacman}='sudo pacman -S'
# alias install-yay='yay -S'
alias shutdown='sudo /sbin/shutdown -P now'
alias kabum='init 0'

alias docker-ip="docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"
alias docker-server="docker -H localhost:2374"
alias docker-stop="docker stop $(docker ps -a -q)"
alias docker-remove="docker rm $(docker ps -a -q)"

ulimit -n 200000
ulimit -S -u 30306

function cd {
   builtin cd "$@" && colorls --all --sort-files --report --git-status
}

#alias {dk,disable-keyboard}="id=$(xinput list | grep "AT Translated Set 2 keyboard" | awk '{print $7}' | sed 's/id=//') | slave=$(xinput list | grep "AT Translated Set 2 keyboard" | awk '{print $10}' | tr -d '()]') | export ID=$id | export SLAVE=$slave | xinput float $id | echo \"LAPTOP KEYBOARD DISABLED!\n\nID = $id \nSLAVE = $slave\""
#alias {ek,enable-keyboard}="xinput reattach $ID $SLAVE | echo \"LAPTOP KEYBOARD ENABLED!\""

alias gsup="git status"
alias gcom="git commit --gpg-sign --message"
alias gadd="git add"

alias ls="colorls --sort-files --git-status --report"

alias look="sudo find . -name"
alias search="sudo grep --color -rnw ./ -e "
alias ports="sudo lsof -PiTCP -sTCP:LISTEN"

alias xclip="xclip -selection c"

alias speedtest="wget -O /dev/null cachefly.cachefly.net/100mb.test"

alias vault-login='(){ stonectl vault login $1 }' #'(){ vault login -no-print -method=oidc -address="https://vault.$1.stone.credit/" role=azure; }'
alias watch-gdm='(){ watch -bpcd -n 1 stonectl gdm status --ticket GDM-$1; }'
alias watch-pods='(){ watch -bpcd -n 1 kubectl get pods -n $1; }'
alias {jumpbox,jb}='stonectl teleport jumpbox $1'
alias gdm='EDITOR=code stonectl gdm'

alias {kb,keyboard}-us="setxkbmap -layout us -variant intl"
alias {kb,keyboard}-br="setxkbmap -model abnt2 -layout br -variant abnt2"

alias {vpn-up,vu}="nmcli --colors yes --terse con up id franzwagner@stonebanking_devops_vpn --ask"
alias {vpn-down,vd}="nmcli --colors yes --terse con down id franzwagner@stonebanking_devops_vpn" #; clear-klogin

alias gcp="gcloud cloud-shell ssh --authorize-session"

alias clear-klogin="klogin clear"
alias kctx='kubectx k8s-$1'
# alias kctxhomolog="kubectx k8s-homolog"
# alias kctxsandbox="kubectx k8s-sandbox"
# alias kctxprod="kubectx k8s-production"

alias whoah="gif-for-cli 23029400"

# devopsdays
export DOD_YEAR="2024"            # set this to your year
export DOD_CITY="goiania"   # set this to your city
export DODPATH=~/devopsdays-web   # location of Git files
alias dod='cd $DODPATH'
alias dods='cd $DODPATH/content/events/$DOD_YEAR-$DOD_CITY/speakers'
alias dodp='cd $DODPATH/content/events/$DOD_YEAR-$DOD_CITY/program'
alias dodi='cd $DODPATH/static/events/$DOD_YEAR-$DOD_CITY/speakers'
alias dodyml='dod && $EDITOR data/events/$DOD_YEAR-$DOD_CITY.yml'
alias dodfind='dod && find data/events/$DOD_YEAR-$DOD_CITY.yml content/events/$DOD_YEAR-$DOD_CITY/{speakers,program} static/events/$DOD_YEAR-$DOD_CITY/speakers'
alias dodhugo='dod && echo open http://localhost:1313 ; hugo server -w --baseURL="http://localhost:1313"'


# gather spotify status
alias gssstart="npm run start --prefix ~/mod-spotify-as-status > '/home/franzwagner/mod-spotify-as-status/log.txt' 2>&1 &"
alias gssstop="kill \$(ps -aux | grep 'node dist/index.js' | awk 'NR==1 { print \$2 }')"

########## Aliases ##########

TF_VAR_environment=$(terraform workspace list | awk '{ printf "%s", $2 }')

########## Kafka Info ##########

export ZOOKEEPER_HOSTS_HOMOLOG="z-1.kafka-msk-2-oriented-e.xhf8jx.c4.kafka.us-east-1.amazonaws.com:2181,z-2.kafka-msk-2-oriented-e.xhf8jx.c4.kafka.us-east-1.amazonaws.com:2181,z-3.kafka-msk-2-oriented-e.xhf8jx.c4.kafka.us-east-1.amazonaws.com:2181"
export BOOTSTRAP_SERVERS_HOMOLOG="kafka-1.homolog.stone.credit:9092,kafka-2.homolog.stone.credit:9092,kafka-3.homolog.stone.credit:9092"

export ZOOKEEPER_HOSTS_SANDBOX="z-2.kafka-msk-gentle-snipe.qgyfpn.c5.kafka.us-east-1.amazonaws.com:2181,z-3.kafka-msk-gentle-snipe.qgyfpn.c5.kafka.us-east-1.amazonaws.com:2181,z-1.kafka-msk-gentle-snipe.qgyfpn.c5.kafka.us-east-1.amazonaws.com:2181"
export BOOTSTRAP_SERVERS_SANDBOX="kafka-1.sandbox.stone.credit:9092,kafka-2.sandbox.stone.credit:9092,kafka-3.sandbox.stone.credit:9092"

export ZOOKEEPER_HOSTS_PRODUCTION="z-1.kafka-msk-neutral-leo.nyhn6q.c12.kafka.us-east-1.amazonaws.com:2181,z-3.kafka-msk-neutral-leo.nyhn6q.c12.kafka.us-east-1.amazonaws.com:2181,z-2.kafka-msk-neutral-leo.nyhn6q.c12.kafka.us-east-1.amazonaws.com:2181"
export BOOTSTRAP_SERVERS_PRODUCTION="kafka-1.production.stone.credit:9092,kafka-2.production.stone.credit:9092,kafka-3.production.stone.credit:9092"

export ZOOKEEPER_HOSTS_DATA_PRODUCTION="z-3.risktransactionalgrat.6fr5g6.c24.kafka.us-east-1.amazonaws.com:2181,z-2.risktransactionalgrat.6fr5g6.c24.kafka.us-east-1.amazonaws.com:2181,z-1.risktransactionalgrat.6fr5g6.c24.kafka.us-east-1.amazonaws.com:2181"
export BOOTSTRAP_SERVERS_DATA_PRODUCTION="b1-risk-transactional.datascience-production.stone.credit:9092,b2-risk-transactional.datascience-production.stone.credit:9092,b3-risk-transactional.datascience-production.stone.credit:9092"

########## Kafka Info ##########


export LSCOLORS=""

export PROMPT_COMMAND="history -a; history -n"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

#source $(dirname $(gem which colorls))/tab_complete.sh
#source /home/$(id -un)/.rvm/gems/ruby-2.7.1/gems/colorls-1.4.1/lib/tab_complete.sh

#test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
#echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/franzwagner/.zprofile
#echo "eval \$($(brew --prefix)/bin/brew shellenv)" >> ~/.profile

echo '# Set PATH, MANPATH, etc., for Homebrew.' >> /home/franzwagner/.zprofile
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/franzwagner/.zprofile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

# eval "$(rbenv init -)"

eval "$(navi widget zsh)"

export DOCKER_HOST=unix:///var/run/docker.sock

export GPG_TTY=$TTY
#export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
export LIBGL_ALWAYS_INDIRECT=1

#source /opt/asdf-vm/asdf.sh

export PUPPETEER_EXECUTABLE_PATH="/opt/google/chrome/chrome"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source /home/franzwagner/.asdf/asdf.sh

export SSH_ASKPASS='/usr/bin/ksshaskpass'
export SSH_ASKPASS_REQUIRE=prefer

export JIRA_API_TOKEN="$(cat ~/.jira-api-token)"

# eval $(thefuck --alias)
