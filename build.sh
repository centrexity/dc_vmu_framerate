#!/bin/bash

echo -e ""
echo -e ""
echo -e ""

#exit on any non 0 return
set -e


if [ ! -d "out" ]; then
    mkdir out
fi

./waterbear assemble main.asm -o out/game.vms



#waterbear can generate vmi
./waterbear vmi out/game.vms --game

