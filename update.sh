#!/bin/bash

cd /home/cpi/mylauncher 
#feh --bg-center /home/cpi/mylauncher/sys.py/gameshell/wallpaper/updating.png
git pull
git reset --hard $1
git submodule init
git submodule update

#cd ~/apps/Menu && git pull && cd -

feh --bg-center /home/cpi/mylauncher/sys.py/gameshell/wallpaper/loading.png 
./load.sh

