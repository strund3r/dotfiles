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
CODESTATS_API_KEY="SFMyNTY.YzNSeWRXNWtNM0k9IyNOams0TkE9PQ.gVoX5c-KlIpsVx4BmCfKQffVOqfLJiU1pHAGkryhZVE"

zplug "code-stats/code-stats-zsh", from:gitlab, use:"codestats.plugin.zsh"
zplug "hlissner/zsh-autopair", defer:2

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    aws
    docker
    fd
    git
    jsontools
    kubectl
    macports
    osx
    python
    sudo
    torrent
    web-search
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
)

# Lad Gti completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

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
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time root_indicator background_jobs history battery time)



# Add a second prompt line for the command
POWERLEVEL9K_PROMPT_ON_NEWLINE=true

# Add a space in the first prompt 
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%f"

# Visual customisation of the second prompt line
# local user_symbol="$"
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

# Alias
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
alias upgrade='update; sudo apt -y upgrade'
alias install='sudo apt -y install'
alias shutdown='sudo /sbin/shutdown -P now'
alias kabum='init 0'

alias docker-ip="docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"
alias docker-server="docker -H localhost:2374"
alias docker-stop="docker stop $(docker ps -a -q)"
alias docker-remove="docker rm $(docker ps -a -q)"

ulimit -n 200000
ulimit -u 2048

function cd {
   builtin cd "$@" && colorls --all --sort-files --report
}

alias gsup="git status"
alias gcom="git commit --gpg-sign --message"
alias gadd="git add"

alias ls="colorls --sort-files"

alias look="sudo find . -name"
alias search="sudo grep --color -rnw ./ -e "
alias ports="sudo lsof -PiTCP -sTCP:LISTEN"

alias xclip="xclip -selection c"

alias speedtest="wget -O /dev/null cachefly.cachefly.net/100mb.test"

export LSCOLORS=""

export PROMPT_COMMAND="history -a; history -n"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

#source $(dirname $(gem which colorls))/tab_complete.sh
source /home/$(id -un)/.rvm/gems/ruby-2.7.1/gems/colorls-1.4.1/lib/tab_complete.sh

test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
echo "eval \$($(brew --prefix)/bin/brew shellenv)" >> ~/.profile 

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

export GPG_TTY=$(tty)
export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
export LIBGL_ALWAYS_INDIRECT=1