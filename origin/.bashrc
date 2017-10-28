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

if [ -f ~/etc/git-completion/git-completion.bash ] && [ -f ~/etc/git-completion/git-prompt.sh ] ; then
    . ~/etc/git-completion/git-completion.bash
    . ~/etc/git-completion/git-prompt.sh
    export PS1='[\h \W $(__git_ps1 "@%s")]$ '
else
    export PS1='[\h \W]$ '
fi

export GOPATH="$HOME"
export PATH="$HOME/bin:$PATH:$GOPATH/bin:$HOME/.vim/dein/repos/github.com/junegunn/fzf/bin"

cvs() {
    if [ "$1" = "cat" ] ; then
        command cvs update -p "$2"
    else
        command cvs "$@"
    fi
}

ff() {
    if [ -d "$1" ] ; then
        F=$(find $1 -type d -name '.svn' -prune -o -type d -name '.git' -prune -o -type f)
        shift 1
        echo "$F" | grep "$@"
    else
        find . -type d -name '.svn' -prune -o -type d -name '.git' -prune -o -type f -print | grep "$@"
    fi
}

fd() {
    if [ -d "$1" ] ; then
        F=$(find $1 -type d -name '.svn' -prune -o -type d -name '.git' -prune -o -type d)
        shift 1
        echo "$F" | grep "$@"
    else
        find . -type d -name '.svn' -prune -o -type d -name '.git' -prune -o -type d -print | grep "$@"
    fi
}

fs() {
    if [ -d "$1" ] ; then
        F=$(find $1 -type d -name '.svn' -prune -o -type d -name '.git' -prune -o -type f)
        shift 1
        echo "$F" | xargs grep "$@"
    else
        find . -type d -name '.svn' -prune -o -type d -name '.git' -prune -o -type f -print0 | xargs -0 grep "$@"
    fi
}

if [ -x "$(which fzf)" ] ; then
    [ -f ~/.fzf.bash ] && source ~/.fzf.bash
    alias cdg='cd $(ghq list -p | fzf --ansi --exit-0)'

    ptvi() {
        vim $(pt "$@" | fzf --exit-0 --select-1 | awk -F':' '{print "-c " $2 " " $1}')
    }
    rgvi() {
        vim $(rg --line-number "$@" | fzf --exit-0 --select-1 | awk -F':' '{print "-c " $2 " " $1}')
    }
elif [ -x "$(which peco)" ] ; then
    alias -g P='| peco --select-1'
    alias cdg='cd $(ghq list -p | peco)'

    peco-select-history() {
        declare l=$(HISTTIMEFORMAT= history | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$READLINE_LINE")
        READLINE_LINE="$l"
        READLINE_POINT=${#l}
    }
    bind -x '"\C-r": peco-select-history'

    ptvi() {
        vim $(pt "$@" | peco --select-1 --query "$LBUFFER" | awk -F':' '{print "-c " $2 " " $1}')
    }
    rgvi() {
        vim $(rg --line-number "$@" | peco --select-1 --query "$LBUFFER" | awk -F':' '{print "-c " $2 " " $1}')
    }
fi

HISTFILE=~/.bash_history
HISTSIZE=9999
HISTFILESIZE=9999
