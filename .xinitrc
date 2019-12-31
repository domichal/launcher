session=${1:-gameshell}

case $session in
hdmi )
	exec ~/mylauncher/aria2c --conf-path=/home/cpi/mylauncher/aria2.conf &
	feh --bg-center ~/mylauncher/sys.py/gameshell/wallpaper/desktopbg.jpg
        cd ~/mylauncher/sys.py/ ; python appinstaller.py > /tmp/appinstaller.log & cd ~/
	exec ~/mylauncher/load.sh &
	exec ~/mylauncher/sys.py/gsnotify/gsnotify-arm daemon &
	#exec /usr/bin/twm -f ~/mylauncher/.twmrc
	exec ~/mylauncher/dwm-mod
	;;
gameshell )
	exec ~/mylauncher/aria2c --conf-path=/home/cpi/launcher/aria2.conf & 
	feh --bg-center ~/mylauncher/sys.py/gameshell/wallpaper/loading.png
        cd ~/mylauncher/sys.py/ ; python appinstaller.py > /tmp/appinstaller.log  & cd ~/
	exec ~/mylauncher/load.sh &
	exec ~/mylauncher/sys.py/gsnotify/gsnotify-arm &
	#exec awesome -c ~/mylauncher/awesome/rc.lua
	exec ~/mylauncher/dwm-mod -w
	;;
*) 
	exec $1;;
esac

