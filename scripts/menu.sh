#!/bin/bash

. .conf

cat gameshell
sleep 1

title="Launcher Tools"
menu="What to do?"

opts=(1 "switch launcher"
      2 "update mylauncher (git)"
      3 "update system (apt)")

x=$(whiptail --title "$title" \
         --menu "$msg" \
         $MENU_HEIGHT $WIDTH $CHOICE_HEIGHT \
         "${opts[@]}" \
         2>&1 >/dev/tty)

if [ $x -eq 1 ]; then
    ./switch_launcher.sh
elif [ $x -eq 2 ]; then
    ./update_launcher.sh
elif [ $x -eq 3 ]; then
    ./update_system.sh
fi

#exit 0
