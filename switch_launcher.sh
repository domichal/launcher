#!/bin/bash

path="$HOME"
bashrcvar="LAUNCHER"

# UI SETUP
MENU_HEIGHT=10
ALERT_HEIGHT=8
WIDTH=40

current=$(sed -n "/$bashrcvar=[^\s\\]/p" "$path/.bashrc" | sed -e s/$bashrcvar=//)
launchers=()
i=0

abort(){
        whiptail --title "Aborted" --msgbox "Launcher Switch has been aborted" $ALERT_HEIGHT $WIDTH
	exit 0
}

while IFS= read -r -d $'\0'; do
    if [ -f "$REPLY/.cpirc" ]; then
	name=$(basename "$REPLY")
	if [ "$name" != "$current" ]; then
	    launchers[$((++i))]="$name"
	fi
    fi
done < <(find "$path/" -maxdepth 1 -type d -name "*launcher*" -print0 | sort -z)

options=($(for i in "${!launchers[@]}";do echo "$i" "${launchers[i]}";done))
x=$(whiptail --title "Switch Launcher" \
	--menu "Currently using [$current].\nOther available launchers:" \
	$MENU_HEIGHT $WIDTH 0 \
	"${options[@]}" \
	2>&1 >/dev/tty)

if [ -z $x ]; then
	abort
fi

selected=${launchers[x]}

whiptail --title "Confirm" --yesno "GameShell will now reboot to [$selected]. Continue?" $ALERT_HEIGHT $WIDTH
x=$?

if [ $x -eq 0 ]; then
	sed -i "s/$bashrcvar=$current/$bashrcvar=$selected/" "$path/.bashrc"
	sudo reboot
fi

abort
