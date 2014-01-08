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

export PATH="$HOME/bin:$PATH"

PROMPT="$ "
RPROMPT="%{$fg_bold[white]%}[%{$reset_color%}%{$fg[cyan]%}%~%{$reset_color%}%{$fg_bold[white]%}]%{$reset_color%}"
SPROMPT="%{$fg_bold[red]%}correct%{$reset_color%}: %R -> %r ? "

bindkey -e
autoload -U compinit
compinit -u
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
autoload -U colors
colors
export LSCOLORS=HxFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' menu select=1
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "+"
zstyle ':vcs_info:git:*' unstagedstr "-"
zstyle ':vcs_info:git:*' actionformats '%F{5}[%f%s%F{5}]%F{3}%F{5}[%f%r%F{5}]%F{3}%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f%F{1}%u%f%F{6}%c%f'
zstyle ':vcs_info:git:*' formats       '%F{5}[%f%s%F{5}]%F{3}%F{5}[%f%r%F{5}]%F{3}%F{5}[%F{2}%b%F{5}]%F{1}%u%f%F{6}%c%f'
precmd() { vcs_info }
RPROMPT='${vcs_info_msg_0_}%f'

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
        F=`find $1 -type d -name '.svn|.git' -prune -o -type f`
        shift 1
        echo $F | grep $@
    else
        find . -type d -name '.svn|.git' -prune -o -type f | grep $@
    fi
}

fd() {
    if [ -d $1 ] ; then
        F=`find $1 -type d -name '.svn|.git' -prune -o -type d`
        shift 1
        echo $F | grep $@
    else
        find . -type d -name '.svn|.git' -prune -o -type d | grep $@
    fi
}

fs() {
    if [ -d $1 ] ; then
        F=`find $1 -type d -name '.svn|.git' -prune -o -type f`
        shift 1
        grep $@ $F
    else
        find . -type d -name '.svn|.git' -prune -o -type f | xargs grep $@
    fi
}

HISTFILE=~/.zsh_history
HISTSIZE=9999
SAVEHIST=9999
