[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

[ -s $HOME/.nvm/nvm.sh ] && . $HOME/.nvm/nvm.sh # This loads NVM

if [ `uname` = "Linux" ] ; then
    alias ls='ls -F --color'
    alias la='ls -ahF --color'
    alias ll='ls -lhF --color'
    alias llt='ls -lhFtr --color'
    alias lla='ls -lahF --color'
else
    alias ls='ls -FG'
    alias la='ls -ahFG'
    alias ll='ls -lhFG'
    alias llt='ls -lhFtrG'
    alias lla='ls -lahFG'
fi
alias vi='vim'
alias em='emacs -nw'
alias sc='screen'
alias svi='sudo vim'

alias -g L='| less'
alias -g M='| more'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'

export PATH="$HOME/bin:$PATH"

bindkey -e
autoload -U compinit
compinit -u
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[-_.]=**'
autoload -U colors
colors
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30'
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'
local          RED=$'%{\e[0;31m%}'
local        GREEN=$'%{\e[0;32m%}'
local         BLUE=$'%{\e[0;34m%}'
local    DARK_GRAY=$'%{\e[1;30m%}'
local       YELLOW=$'%{\e[1;33m%}'
local LIGHT_PURPLE=$'%{\e[1;35m%}'
local      DEFAULT=$'%{\e[1;m%}'
autoload -Uz is-at-least
if is-at-least 4.3.10; then
    autoload -Uz vcs_info
    zstyle ':vcs_info:*' enable git svn
    zstyle ':vcs_info:*' formats '%{'${fg[red]}'%}[%s %b] %{'$reset_color'%}'
    precmd () {
        LANG=en_US.UTF-8 vcs_info
        PROMPT="${vcs_info_msg_0_}% $GREEN%B%(?.(´･_･%).($(echo '\`')･_･%))%b$DEFAULT  %(?.$YELLOW.$RED)%(!.#.$) $DEFAULT"
    }
else
    PROMPT="$GREEN%B%(?.(´･_･%).($(echo '\`')･_･%))%b$DEFAULT %(?.$YELLOW.$RED)%(!.#.$) $DEFAULT"
fi
SHORTHOST=`hostname`
RPROMPT="%(?..$RED%?) $DARK_GRAY%* $BLUE${USER}$DEFAULT@$GREEN$SHORTHOST$DEFAULT:$LIGHT_PURPLE%~$DEFAULT"

setopt no_beep
unsetopt complete_aliases
setopt magic_equal_subst
setopt list_packed
setopt auto_list
setopt prompt_subst
setopt list_types
setopt auto_menu
setopt numeric_glob_sort
setopt print_eight_bit
setopt auto_param_keys
setopt auto_param_slash
setopt correct
setopt append_history
unsetopt ignore_eof
setopt hist_ignore_dups
setopt globdots

bindkey "^[[Z" reverse-menu-complete

cvs() {
    if [ $1 = "cat" ] ; then
        command cvs update -p $2
    else
        command cvs $@
    fi
}

ff() {
    if [ -d $1 ] ; then
        F=`find $1 -type d -name (.svn|.git) -prune -o -type f`
        shift 1
        echo $F | grep $@
    else
        find . -type d -name (.svn|.git) -prune -o -type f | grep $@
    fi
}

fd() {
    if [ -d $1 ] ; then
        F=`find $1 -type d -name (.svn|.git) -prune -o -type d`
        shift 1
        echo $F | grep $@
    else
        find . -type d -name (.svn|.git) -prune -o -type d | grep $@
    fi
}

fs() {
    if [ -d $1 ] ; then
        F=`find $1 -type d -name (.svn|.git) -prune -o -type f`
        shift 1
        echo $F | xargs grep $@
    else
        find . -type d -name (.svn|.git) -prune -o -type f | xargs grep $@
    fi
}

HISTFILE=~/.zsh_history
HISTSIZE=9999
SAVEHIST=9999
