# History control
# don't use duplicate lines or lines starting with space
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
# append to the history file instead of overwrite
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# FIX: OSX crash complaining of operation `in progress in another thread when fork() was called`
OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# Aliases
alias cp='cp --recursive --verbose'
alias ls='ls --color=auto -ACF'
alias ll='ls --color=auto -alF'
alias grep='grep --color=auto'
alias mkdir='mkdir --parents --verbose'
alias mv='mv --verbose'
alias wget='wget --continue'

alias gadd='git add'
alias gcom='git commit'
alias gsup='git status'

alias pip='pip3'
alias pym='python3 manage.py'
alias mkenv='python3 -m venv env'
alias startenv='source env/bin/activate && which python3'
alias stopenv='deactivate'

# Use programs without a root-equivalent group
alias docker='sudo docker'
alias npm='sudo npm'

# System
alias update='sudo apt-get update'
alias upgrade='update; sudo apt-get -y upgrade'
alias install='sudo apt-get -y install'
alias shutdown='sudo /sbin/shutdown -P now'
alias kabum='init 0'

# Docker
alias docker-ip="docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"
alias docker-server="docker -H localhost:2374"
alias docker-stop="docker stop $(docker ps -a -q)"
alias docker-remove="docker rm $(docker ps -a -q)"

# Show contents of dir after action
function cd () {
    builtin cd "$1"
    ls -aCF
}

function countdown(){
   echo -ne "\n"
   date1=$((`date +%s` + $1)); 
   while [ "$date1" -ge `date +%s` ]; do 
     echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
     sleep 0.1
   done
   echo -ne "\n"
}

function stopwatch(){
   echo -ne "\n"
   date1=`date +%s`; 
   while true; do
    echo -ne  '$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r';
    sleep 0.1
   done
   echo -ne "\n"
}

# Vim
export EDITOR=/usr/bin/vim

# Color prompt
export TERM=xterm-256color

txtblk='\[\e[0;30m\]' # Black - Regular
txtred='\[\e[0;31m\]' # Red
txtgrn='\[\e[0;32m\]' # Green
txtylw='\[\e[0;93m\]' # Yellow
txtblu='\[\e[0;34m\]' # Blue
txtpur='\[\e[0;35m\]' # Purple
txtcyn='\[\e[0;96m\]' # Cyan
txtwht='\[\e[0;37m\]' # White
bldblk='\[\e[1;30m\]' # Black - Bold
bldred='\[\e[1;31m\]' # Red
bldgrn='\[\e[1;32m\]' # Green
bldylw='\[\e[1;33m\]' # Yellow
bldblu='\[\e[1;34m\]' # Blue
bldpur='\[\e[1;35m\]' # Purple
bldcyn='\[\e[1;36m\]' # Cyan
bldwht='\[\e[1;37m\]' # White
unkblk='\[\e[4;30m\]' # Black - Underline
undred='\[\e[4;31m\]' # Red
undgrn='\[\e[4;32m\]' # Green
undylw='\[\e[4;33m\]' # Yellow
undblu='\[\e[4;34m\]' # Blue
undpur='\[\e[4;35m\]' # Purple
undcyn='\[\e[4;36m\]' # Cyan
undwht='\[\e[4;37m\]' # White
bakblk='\[\e[40m\]'   # Black - Background
bakred='\[\e[41m\]'   # Red
badgrn='\[\e[42m\]'   # Green
bakylw='\[\e[43m\]'   # Yellow
bakblu='\[\e[44m\]'   # Blue
bakpur='\[\e[45m\]'   # Purple
bakcyn='\[\e[46m\]'   # Cyan
bakwht='\[\e[47m\]'   # White
txtrst='\[\e[0m\]'    # Text Reset

# Prompt colours
atC="${txtpur}"
nameC="${txtblu}"
hostC="${txtpur}"
pathC="${txtcyn}"
gitC="${txtpur}"
pointerC="${txtwht}"
normalC="${txtrst}"

# Red pointer for root
if [ "${UID}" -eq "0" ]; then
    pointerC="${txtred}"
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

complete -C /usr/local/bin/terraform terraform
