session=${1:-gameshell}

case $session in
hdmi )
	feh --bg-center ~/mylauncher/sys.py/gameshell/wallpaper/desktopbg.jpg
	exec ~/mylauncher/load.sh &
	exec ~/mylauncher/sys.py/gsnotify/gsnotify-arm daemon &
	#exec /usr/bin/twm -f ~/mylauncher/.twmrc
	exec ~/mylauncher/dwm-mod
	;;
gameshell ) 
	feh --bg-center ~/mylauncher/sys.py/gameshell/wallpaper/loading.png
	exec ~/mylauncher/load.sh &
	exec ~/mylauncher/sys.py/gsnotify/gsnotify-arm &
	#exec awesome -c ~/mylauncher/awesome/rc.lua
	exec ~/mylauncher/dwm-mod -w
	;;
*) 
	exec $1;;
esac

