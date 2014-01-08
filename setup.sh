#!/bin/sh -eu

if [ -d ./build ] ; then
#    mv -f ./build /tmp
    rm -rf ./build
fi
mkdir build

find ./origin | while read ORIGIN
do
    FILE=${ORIGIN#./origin/}
    if [ $FILE = "./origin" ] ; then
        continue
    fi
    if [ -d $ORIGIN ] ; then
        mkdir -p "build/${FILE}"
        continue
    fi

    REPLACE="./replace/${FILE}"
    if [ -f $REPLACE ] ; then
        cp $REPLACE "build/${FILE}"
        continue
    fi

    CATENATE="./catenate/${FILE}"
    if [ -f $CATENATE ] ; then
        cat $ORIGIN $CATENATE > "build/${FILE}"
        continue
    fi

    cp $ORIGIN "build/${FILE}"
done

find ./replace | while read REPLACE
do
    FILE=${REPLACE#./replace/}
    case $FILE in
        "./replace"|".gitkeep") continue ;;
    esac
    if [ -e "build/${FILE}" ] ; then
        mkdir -p "build/${FILE}"
        continue
    fi
    cp $REPLACE "build/${FILE}"
done

find ./catenate | while read CATENATE
do
    FILE=${CATENATE#./catenate/}
    case $FILE in
        "./catenate"|".gitkeep") continue ;;
    esac
    if [ -e "build/${FILE}" ] ; then
        mkdir -p "build/${FILE}"
        continue
    fi
    cp $CATENATE "build/${FILE}"
done

for BUILD in ./build/* ./build/.*
do
    FILE=${BUILD#./build/}
    case $FILE in
        "."|"..") continue ;;
    esac
    echo "================"
    echo "create ${FILE}"
    ln -ins `pwd`/$BUILD $HOME/$FILE
done
