# Load our dotfiles like ~/.bash_prompt, etc…
#   ~/.extra can be used for settings you don’t want to commit,
#   Use it to configure your PATH, thus it being first in line.
for file in ~/.{extra,bash_prompt,exports,aliases,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file

if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# highlighting inside manpages and elsewhere
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

function prompt {
  local BLACK="\[\033[0;30m\]"
  local BLACKBOLD="\[\033[1;30m\]"
  local RED="\[\033[0;31m\]"
  local REDBOLD="\[\033[1;31m\]"
  local GREEN="\[\033[0;32m\]"
  local GREENBOLD="\[\033[1;32m\]"
  local YELLOW="\[\033[0;33m\]"
  local YELLOWBOLD="\[\033[1;33m\]"
  local BLUE="\[\033[0;34m\]"
  local BLUEBOLD="\[\033[1;34m\]"
  local PURPLE="\[\033[0;35m\]"
  local PURPLEBOLD="\[\033[1;35m\]"
  local CYAN="\[\033[0;36m\]"
  local CYANBOLD="\[\033[1;36m\]"
  local WHITE="\[\033[0;37m\]"
  local WHITEBOLD="\[\033[1;37m\]"
  local RESETCOLOR="\[\e[00m\]"

  export PS1="\n$RED\u $PURPLE@ $GREEN\w $RESETCOLOR$GREENBOLD\$(git branch 2> /dev/null)\n $YELLOW[\#] → $RESETCOLOR"
  #export PS1="\[\033[38;5;0m\]\[\033[48;5;15m\]\d \t\[$(tput sgr0)\]\[\033[38;5;15m\]\[\033[48;5;16m\] \[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;232m\]\[\033[48;5;11m\]\u\[$(tput sgr0)\]\[\033[38;5;0m\]\[\033[48;5;15m\]@\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[48;5;1m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\]\[\033[48;5;16m\]:\[$(tput bold)\]\[$(tput sgr0)\]\[\033[48;5;20m\][\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[48;5;21m\]\w\[$(tput bold)\]\[$(tput sgr0)\]\[\033[48;5;20m\]]\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[48;5;16m\]\\$ \[$(tput sgr0)\]"
  export PS2=" | → $RESETCOLOR"
}

# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space

ulimit -n 200000
ulimit -u 2048


prompt