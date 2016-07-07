#!/bin/bash

cd "$(dirname "$0")"
[ ! -d ./build ] && mkdir build

find ./origin -mindepth 1 \( -type d -name '.git' -prune -o \( -type f -o -type d \) \) | while read -r ORIGIN
do
    FILE=${ORIGIN#./origin/}
    case $FILE in
        */\.git) continue ;;
    esac
    if [ -d "$ORIGIN" ] ; then
        mkdir -p "build/${FILE}"
        continue
    fi

    REPLACE="./replace/${FILE}"
    if [ -f "$REPLACE" ] ; then
        cp "$REPLACE" "build/${FILE}"
        continue
    fi

    CATENATE="./catenate/${FILE}"
    if [ -f "$CATENATE" ] ; then
        cat "$ORIGIN" "$CATENATE" > "build/${FILE}"
        continue
    fi

    cp "$ORIGIN" "build/${FILE}"
done

find ./replace -mindepth 1 \( -type d -name '.git' -prune -o \( -type f -o -type d \) \) | while read -r REPLACE
do
    FILE=${REPLACE#./replace/}
    case $FILE in
        ".gitkeep"|*/\.git) continue ;;
    esac
    [ -e "build/${FILE}" ] && continue
    if [ -d "$REPLACE" ] ; then
        mkdir -p "build/${FILE}"
        continue
    fi
    cp "$REPLACE" "build/${FILE}"
done

find ./catenate -mindepth 1 \( -type d -name '.git' -prune -o \( -type f -o -type d \) \) | while read -r CATENATE
do
    FILE=${CATENATE#./catenate/}
    case $FILE in
        ".gitkeep"|*/\.git) continue ;;
    esac
    [ -e "build/${FILE}" ] && continue
    if [ -d "$CATENATE" ] ; then
        mkdir -p "build/${FILE}"
        continue
    fi
    cp "$CATENATE" "build/${FILE}"
done

SKIP=""
find ./build -mindepth 1 \( -type d -name '.git' -prune -o \( -type f -o -type d \) \) | while read -r BUILD
do
    FILE=${BUILD#./build/}
    case $FILE in
        */\.git) continue ;;
    esac
    [ ! "${SKIP}" = "" ] && case $FILE in
        ${SKIP}/*) continue ;;
    esac
    if [ -L "$HOME/$FILE" ] ; then
        SKIP=$FILE
        continue
    elif [ -d "$HOME/$FILE" ] && [ -d "$BUILD" ] ; then
        continue
    elif [ -d "$HOME/$FILE" ] && [ -f "$BUILD" ] ; then
        echo "conflict ${HOME}/${FILE} and ${BUILD}"
        exit 1
    fi
    echo ""
    echo "[info] create ${FILE}"
    ln -ins "$(pwd)${BUILD#.}" "$HOME/$FILE"
    if [ -d "$BUILD" ] ; then
        SKIP=$FILE
    fi
done
