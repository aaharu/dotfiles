if [ -e `which zsh` ] ; then
    exec zsh -l
else
    . ~/.bashrc
fi
