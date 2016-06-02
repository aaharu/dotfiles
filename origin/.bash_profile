if [ -z "${BASH_EXECUTION_STRING}" ] ; then
    ZSH=$(which zsh)
    [ -x "${ZSH}" ] && SHELL="${ZSH}" exec "${ZSH}" -l
else
    . ~/.bashrc
fi
