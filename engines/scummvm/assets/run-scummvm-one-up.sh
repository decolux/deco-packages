#!/bin/bash

ORIGINALPWD="$PWD"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

if [ ! -f scummvm.ini ]; then
    echo "No scummvm.ini file detected, so creating"
    echo -e "[scummvm]" >> scummvm.ini
    echo -e "gfx_mode=surfacesdl" >> scummvm.ini
fi

if [[ -d "../Original" ]]; then
    echo "Assuming original path for scummvm"
    LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/scummvm -c scummvm.ini --add --path=../Original --recursive
else
    if [[ $DIR == *"ScummVM_Windows"* ]]; then
        echo "Running parent path"
        LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/scummvm -c scummvm.ini --add --path=../../ --recursive
    else
        echo "Running normal path"
        LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/scummvm -c scummvm.ini --add --path=../ --recursive
    fi
fi

cd "$ORIGINALPWD"
cd ..

LD_LIBRARY_PATH="$ORIGINALPWD/scum/lib:$LD_LIBRARY_PATH" "$ORIGINALPWD/scum/bin/scummvm" -c "$ORIGINALPWD/scum/scummvm.ini" --fullscreen --themepath="$ORIGINALPWD/scum/share/scummvm" --add --path=.
LD_LIBRARY_PATH="$ORIGINALPWD/scum/lib:$LD_LIBRARY_PATH" "$ORIGINALPWD/scum/bin/scummvm" -c "$ORIGINALPWD/scum/scummvm.ini" --fullscreen --themepath="$ORIGINALPWD/scum/share/scummvm"
