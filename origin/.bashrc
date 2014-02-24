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

if [ -f ~/etc/git-completion/git-completion.bash -a -f ~/etc/git-completion/git-prompt.sh ] ; then
    . ~/etc/git-completion/git-completion.bash
    . ~/etc/git-completion/git-prompt.sh
    export PS1='[\h \W $(__git_ps1 "@%s")]$ '
else
    export PS1='[\h \W]$ '
fi

export PATH="$HOME/bin:$PATH"

cvs() {
    if [ $1 = "cat" ] ; then
        command cvs update -p $2
    else
        command cvs $@
    fi
}

ff() {
    if [ -d $1 ] ; then
        F=`find $1 -type d -name '.svn' -prune -o -type d -name '.git' -prune -o -type f`
        shift 1
        echo $F | grep $@
    else
        find . -type d -name '.svn' -prune -o -type d -name '.git' -prune -o -type f | grep $@
    fi
}

fd() {
    if [ -d $1 ] ; then
        F=`find $1 -type d -name '.svn' -prune -o -type d -name '.git' -prune -o -type d`
        shift 1
        echo $F | grep $@
    else
        find . -type d -name '.svn' -prune -o -type d -name '.git' -prune -o -type d | grep $@
    fi
}

fs() {
    if [ -d $1 ] ; then
        F=`find $1 -type d -name '.svn' -prune -o -type d -name '.git' -prune -o -type f`
        shift 1
        echo $F | xargs grep $@
    else
        find . -type d -name '.svn' -prune -o -type d -name '.git' -prune -o -type f | xargs grep $@
    fi
}

HISTFILE=~/.bash_history
HISTSIZE=9999
HISTFILESIZE=9999
