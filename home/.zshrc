
# Auto-complete (added by compinstall)
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle :compinstall filename '/home/narc/.zshrc'

autoload -Uz compinit
compinit

# History! (added by zsh-newuser-install, heavily edited)
mkdir -p ~/.zsh
HISTFILE=~/.zsh/history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_fcntl_lock hist_ignore_space hist_ignore_dups \
       hist_no_functions hist_no_store hist_reduce_blanks hist_save_no_dups \
       inc_append_history extended_history \
       auto_cd auto_list list_packed \
       equals correct print_exit_value auto_continue
unsetopt beep list_ambiguous bang_hist flow_control
bindkey -e
# End of auto-configured original stuff.

# Flow control is bad and you should feel bad.
stty -ixon

# Useful ANSI bits:
export SCREEN_TITLE_START=$'\ek'
export SCREEN_TITLE_END=$'\e\\'
export XTERM_TITLE_START=$'\e]2;'
export XTERM_TITLE_END=$'\a'

# Anonymous function so the "local"s are actually local
function {
    local COLOR_BOLD=`tput bold 2>/dev/null`
    local COLOR_RED=`tput setaf 1 2>/dev/null`
    local COLOR_GREEN=`tput setaf 2 2>/dev/null`
    local COLOR_BLUE=`tput setaf 4 2>/dev/null`
    local COLOR_NORMAL=`tput sgr0 2>/dev/null`

    local TITLE=''
    case "$TERM" in
    screen*)
        local TITLE='%{'${SCREEN_TITLE_START}'%~'${SCREEN_TITLE_END}'%}'
        ;;
    xterm*|cygwin)
        local TITLE='%{'${XTERM_TITLE_START}'%~'${XTERM_TITLE_END}'%}'
        ;;
    esac

    local CP_USER='%{'${COLOR_BOLD}${COLOR_BLUE}'%}%n%{'${COLOR_NORMAL}'%}'
    local CP_HOST='%{'${COLOR_BOLD}${COLOR_RED}'%}%m%{'${COLOR_NORMAL}'%}'
    local CP_PATH='%{'${COLOR_BOLD}${COLOR_GREEN}'%}%~%{'${COLOR_NORMAL}'%}'

    export PROMPT=${TITLE}'['${CP_USER}'@'${CP_HOST}' '${CP_PATH}']%# '
    export RPROMPT='< %D{%b %d %H:%M:%S}'
}

preexec () {
    local ex_time=' \e[A\e[2000C\e[26D Executed: '${(%):-'%D{%b %d %H:%M:%S}'}
    case $TERM in
    screen*)
        echo -e "${SCREEN_TITLE_START}${1}${SCREEN_TITLE_END}${ex_time}"
        ;;
    xterm*|cygwin)
        echo -e "${XTERM_TITLE_START}[${USER}@${HOST}] - ${1}${XTERM_TITLE_END}${ex_time}"
        ;;
    esac
}

export ACK_OPTIONS='--ignore-dir=venv'

alias ls='ls --color'
alias ll='ls -l'
alias l.='ls -a'
alias ll.='ls -la'

alias grep='grep --color=auto'
alias diff='diff -u'
alias less='less -r'
alias df='df -T --si -xtmpfs -xusbfs'

alias mcpc='(PROJ=${PWD##*/} && cd ../.. && python runtime/recompile_mods.py ${PROJ})'

export dotfiles="$HOME/.homesick/repos/dotfiles/home"
: ~dotfiles

spawn() {
    echo "#$*" >>~/spawn-out.txt
    $* >>~/spawn-out.txt 2>&1 &
    disown %%
}

if [ -x ~/bin ]; then
    typeset -U path
    path=(~/bin $path)
fi
if [ -x ~/python ]; then
    export PYTHONPATH="$HOME/python:$PYTHONPATH"
fi
if [ -x ~/.homesick ]; then
    source ~/.homesick/repos/homeshick/homeshick.sh
    alias hs='homeshick'
fi

if [[ -r ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi

