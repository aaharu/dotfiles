#!/bin/bash

if [ -x "$(which go)" ] ; then
    go get -u github.com/motemen/ghq
    go get -u github.com/peco/peco/cmd/peco
    go get -u github.com/github/hub
    go get -u github.com/monochromegane/the_platinum_searcher
fi
