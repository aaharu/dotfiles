if [ "$(uname)" = "Linux" ] ; then
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
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'

export GOPATH="$HOME"
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="$HOME/.nodebrew/current/bin:$PATH"
export PATH="$HOME/bin:$PATH:$GOPATH/bin:$HOME/.vim/dein/repos/github.com/junegunn/fzf/bin"

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

autoload -Uz is-at-least
if is-at-least 4.3.10; then
    autoload -Uz vcs_info
    zstyle ':vcs_info:*' enable git svn
    zstyle ':vcs_info:*' formats '%F{red}[%s %b]%f '
    precmd () {
        LANG=en_US.UTF-8 vcs_info
        PROMPT="${vcs_info_msg_0_}% %(?.%F{green}%B(´･_･%)%b%f.%F{red}%B($(echo '\`')･_･%)%b%f) %(?.%F{yellow}.%F{red})%(!.#.$)%f "
    }
else
    PROMPT="%(?.%F{green}%B(´･_･%)%b%f.%F{red}%B($(echo '\`')･_･%)%b%f) %(?.%F{yellow}.%F{red})%(!.#.$)%f "
fi
RED=$'%{\e[0;31m%}'
GREEN=$'%{\e[0;32m%}'
BLUE=$'%{\e[0;34m%}'
YELLOW=$'%{\e[1;33m%}'
LIGHT_PURPLE=$'%{\e[1;35m%}'
DEFAULT=$'%{\e[1;m%}'
RPROMPT="%(?..$RED%?)$DEFAULT $YELLOW%*$DEFAULT $BLUE${USER}$DEFAULT@$GREEN$(hostname)$DEFAULT:$LIGHT_PURPLE%~$DEFAULT"

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

function cvs() {
    if [ "$1" = "cat" ] ; then
        command cvs update -p "$2"
    else
        command cvs "$@"
    fi
}

function ff() {
    if [ -d "$1" ] ; then
        F=$(find "$1" -type d \( -name ".svn" -o -name ".git" \) -prune -o -type f)
        shift 1
        echo "$F" | grep "$@"
    else
        find . -type d \( -name ".svn" -o -name ".git" \) -prune -o -type f -print | grep "$@"
    fi
}

function fd() {
    if [ -d "$1" ] ; then
        F=$(find "$1" -type d \( -name ".svn" -o -name ".git" \) -prune -o -type d)
        shift 1
        echo "$F" | grep "$@"
    else
        find . -type d \( -name ".svn" -o -name ".git" \) -prune -o -type d -print | grep "$@"
    fi
}

function fs() {
    if [ -d "$1" ] ; then
        F=$(find "$1" -type d \( -name ".svn" -o -name ".git" \) -prune -o -type f)
        shift 1
        echo "$F" | xargs grep "$@"
    else
        find . -type d \( -name ".svn" -o -name ".git" \) -prune -o -type f -print0 | xargs -0 grep "$@"
    fi
}

if [ -x "$(which fzf)" ] ; then
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
    alias -g F='| fzf --ansi --select-1'
    alias cdg='cd $(ghq list -p | fzf --ansi --exit-0)'

    function ptvi() {
        vim $(pt "$@" | fzf --exit-0 --select-1 | awk -F':' '{print "-c " $2 " " $1}')
    }
    function rgvi() {
        vim $(rg --line-number "$@" | fzf --exit-0 --select-1 | awk -F':' '{print "-c " $2 " " $1}')
    }
elif [ -x "$(which peco)" ] ; then
    alias -g P='| peco --select-1'
    alias cdg='cd $(ghq list -p | peco)'

    function peco-select-history() {
        local tac
        if which tac > /dev/null; then
            tac="tac"
        else
            tac="tail -r"
        fi
        BUFFER=$(history -n 1 | eval $tac | peco --query "$LBUFFER")
        CURSOR=$#BUFFER
        zle clear-screen
    }
    zle -N peco-select-history
    bindkey '^r' peco-select-history

    function ptvi() {
        vim $(pt "$@" | peco --select-1 --query "$LBUFFER" | awk -F':' '{print "-c " $2 " " $1}')
    }
    function rgvi() {
        vim $(rg --line-number "$@" | peco --select-1 --query "$LBUFFER" | awk -F':' '{print "-c " $2 " " $1}')
    }
fi

HISTFILE=~/.zsh_history
HISTSIZE=99999
SAVEHIST=99999
