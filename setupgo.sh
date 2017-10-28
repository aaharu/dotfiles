#!/bin/bash

if [ -x "$(which go)" ] && [ "$GOPATH" = "$HOME" ] ; then
    go get -u -v github.com/motemen/ghq
    go get -u -v github.com/peco/peco/cmd/peco
    go get -u -v github.com/github/hub
    go get -u -v github.com/monochromegane/the_platinum_searcher/cmd/pt
fi
