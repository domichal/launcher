# mylauncher - Slightly modded GameShell launcher
## With customisable menu location that allows better isolation and easier, update proof personalisation

*mylauncher* is a modification of the ClockworkPi's Python launcher and beside the improvements listed below Mylauncher does not differ from the original.

Original README.md by clockworkpi can be found [here](https://github.com/clockworkpi/launcher/blob/master/README.md).

*mylauncher* be used side by side with both original launchers (launcher and launchergo) and they can all be switched between easily with an available script. It can also run on it's own, however it's advised to keep the original launcher intact to keep the functionality up to date with oncoming clockworkpi additions.

# Screenshots

[TODO] to be updated
![Screenshot](https://github.com/clockworkpi/GameShellDocs/blob/master/screenshot.png)

# Why?

Disorganised, growing list of items on the main page and updates was messing with my tidying ups.
I wanted to be able to keep my homescreen tidy but I didn't want to miss out on what clockworkpi adds so wanted to be able to update GameShell without a hassle too.

# Features

* User Menu is moved outside the repository allowing complete separation*
* Alternative launcher switcher added
* Icon matching mechanism improved, no need for icon location to follow menu strusture anymore!
* [UI] Focus is set on the first, most left page item*

_*These can be restored back to defaults in the [config](#configuration)_

# Compatibility

Beside making the original *Switch Launcher* functionality dysfunctional, this launcher is fully compatible with the default clockworkpi gameshell builds and can work without any disturbance to other launchers and vice versa.

# Installation

## Use installation script

[TODO] Add a link

Installation script can be run on GameShell:
- Move it to the menu and click on it
- run it from the console by typing ``. [script location]``

Or using the PC, but in this case, before running it make sure to change ``homedir`` variable to point to cpi home directory on the sd card.

## Install manually

Download [mylauncher.zip](https://github.com/domichal/mylauncher/archive/master.zip) and unzip the contents inside ``/home/cpi``

Rename unzipped folder to ``/home/cpi/mylauncher``

### Create a file ``/home/cpi/.start``
and paste there the following code:
```
#!/bin/bash

LAUNCHER=mylauncher

if [ -f "$homedir/\$LAUNCHER/.cpirc" ] && [ -z "\$SSH_CLIENT" ] && [ -z "\$SSH_TTY" ]; then
    echo "Starting \$LAUNCHER"
    . "$homedir/\$LAUNCHER/.cpirc"
fi
```
*Optional:* Change file permissions to ``rw-r--r--``
```
chmod 644 /home/cpi/.start
```

### Edit ``/home/cpi/.bashrc`` and add this code:
```
if [ -f /home/cpi/.start ]; then
   . /home/cpi/.start
fi
```
BEFORE the following "if" statement at the end of the file:
```
if [ -f /home/cpi/launcher/.cpirc ]; then
   . /home/cpi/launcher/.cpirc
fi
```
(there may be "~" instead of "/home/cpi" there, but it's the same thing at this point, so no worries)

so you end up with something like this:
```
if [ -f /home/cpi/.start ]; then
   . /home/cpi/.start
fi

if [ -f /home/cpi/launcher/.cpirc ]; then
   . /home/cpi/launcher/.cpirc
fi
```
You may as well comment the original code as it's not going to be reachable anyway, but keep it there in case you wanted to bring the console back to the original state
```
if [ -f /home/cpi/.start ]; then
   . /home/cpi/.start
fi

#if [ -f /home/cpi/launcher/.cpirc ]; then
#   . /home/cpi/launcher/.cpirc
#fi
```
That's it!
Ok, not entirely, the launcher will work, but it will have nothing but a power button in it, so let's

## Add Contents

Add your own contents to ``myMenu`` as you normally would, but if it comes to launcher functionalities, unless you are determined to get rid of the original launcher, don't copy things over, link them!

PowerOFF is a link too, see?:
_(I'm logged in as cpi, modify the paths if you are logged as different user)_
```
$ ls -la ~/Menu/GameShell
total 8
drwxr-xr-x 2 cpi cpi 4096 Oct 19 01:59 .
drwxr-xr-x 3 cpi cpi 4096 Oct 19 01:59 ..
lrwxrwxrwx 1 cpi cpi   45 Oct 19 01:58 99_PowerOFF -> /home/cpi/launcher/Menu/GameShell/99_PowerOFF
```
This way you'll keep original clockworkpi functionalities up to date if they're changed or if stuff is added after an update.

### Examples

I like my GameShell related items to be in their own folder, so I've done this:
```
cd ~/mylauncher/myMenu
mkdir 98_GameSH\>
ln -s ~/launcher/Menu/GameShell/10_Settings 98_GameSH\>/
ln -s ~/launcher/Menu/GameShell/30_RetroArch.sh 98_GameSH\>/
ln -s ~/launcher/Menu/GameShell/98_TinyCloud 90_GameSH\>/
ln -s ~/launcher/Menu/GameShell/90_Reload\ UI.sh 98_GameSH\>/
```
I want the music player to be on the main screen too, so:
```
ln -s ~/launcher/Menu/GameShell/97_Music\ Player .
```
and let's say I want all the contets from apps/Menu in it's own folder as a first item in my menu:
```
ln -s ~/apps/Menu 00_Apps\ Menu
```
So now I have this structure in the menu:
```
myMenu
├── 00_Apps Menu -> /home/cpi/apps/Menu
│   ├── 20_Retro Games
│   ├── 21_Indie Games
│   └── [...]
├── 97_Music Player -> /home/cpi/launcher/Menu/GameShell/97_Music Player
└── 98_GameSH>
    ├── 10_Settings -> /home/cpi/launcher/Menu/GameShell/10_Settings
    ├── 30_RetroArch.sh -> /home/cpi/launcher/Menu/GameShell/30_RetroArch.sh
    ├── 90_Reload UI.sh -> /home/cpi/launcher/Menu/GameShell/90_Reload UI.sh
    └── 98_TinyCloud -> /home/cpi/launcher/Menu/GameShell/98_TinyCloud
```
while all the original items are still in the original launcher folder. Cool, huh? You've got the idea!
But hold on, there's more:

### Icons

If you tried to organise things on GameShell your way previously, you know that now it should be time for some folder traversing to be done to add icons in. But no, you don't have to! You can just drop all the icons in the root folder of your menu (or skin, whatever your preference is).
*mylauncher* is modified to look for icons in application launcher parent folders (up to two levels up by default, so if you want to grow big trees in your menu, you will need to increase it - look for this line: ``allowed = "../.."`` in the ``skin manager.py``)

# Configuration

Just a bit of.
All the launcher related settings (both) can be found in ``sys.py/myconfig.py`` and perhaps the comments will make it clear of what these settings change.
```
# The values below will make the launcher behave/look like original
# 
# Path to the secondary menu folder, feel free to move it outside the launcher folder
# ADDMENU_PATH = "/home/cpi/apps/Menu"
# Item to be highlighted by default on page render
# DEFAULT_FOCUSED_ITEM = 1

ADDMENU_PATH = "/home/cpi/mylauncher/myMenu"
DEFAULT_FOCUSED_ITEM = 0
```

# Directory structure

```
/home/cpi/
├── apps
│   ├── emulators
│   └── Menu   <- By default, this is not used by this launcher
├── launcher
├── launchergo
├── mylauncher <- We are here
│   ├── Menu
│   ├── myMenu <- Default menu location used by the launcher
│   ├── skin
│   └── sys.py
├── games
│   ├── FreeDM
│   ├── MAME
│   └── nxengine
├── music
└── skins
```
# Updates

*mylauncher* features heavily rely on clockworkpi launcher updates, therefore no regular updates are planned or really necessary as long as things work. I will try to update the codebase with the clockworkpi repository from time to time though. Some improvements on the way are possible too. We'll see.

# Uninstalation

Whether you installed *mylauncher* manually or using installation script, reverse the changes listed in manual installation [steps](#installmanually).

# Disclaimer

Use at your own risk ;)

# Before moving to main [TODO]
* tidy up default skin
* make icon selector rotate? :)) [optional]

# Next steps
* add skins to gameshell-other repo
* add skins to gameshell-other icons drop repo

```
  .------------------------.
  | .--------------------. |
  | |                    | |
,-| |                    | |-.
| | |                    | | |
'-| |                    | |-'
  | |                    | |
  | |                    | |
  | `--------------------' |
  |  GameSH>               |
  | ,--. ,-.    ,--. ,--.  |
  | '--' '-'    '--' '--'  |
  |     _          ,-.     |
  |   _| |_     ,-.'-',-.  |
  |  |_ O _|    '-',-.'-'  |
  |    |_|         '-'     |
  |                        |
  |  ::::::::::::::::::::  |
  | o                    o |
  `------------------------'
```
