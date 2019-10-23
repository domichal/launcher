#!/bin/bash

. .conf

cat gameshell
sleep 1

title="Launcher Tools"
menu="What to do?"

i=0
opts=($((++i)) "switch launcher")
if [ -d "$LAUNCHERDIR/.git" ]; then
	opts+=($((++i)) "update mylauncher (git)")
fi
opts+=($((++i)) "update system (apt)")

x=$(whiptail --title "$title" \
         --menu "$msg" \
         $MENU_HEIGHT $WIDTH $CHOICE_HEIGHT \
         "${opts[@]}" \
         2>&1 >/dev/tty)

if [[ $x -eq 1 ]]; then
    ./switch_launcher.sh
elif [[ $x -eq 2 ]]; then
    ./update_launcher.sh
elif [[ $x -eq 3 ]]; then
    ./update_system.sh
fi

#exit 0

