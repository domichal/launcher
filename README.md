# mylauncher - Slightly modded GameShell launcher
With customisable menu location providing isolation for easier and update proof personalisation

Quick Install:
```
curl -sSL https://raw.githubusercontent.com/domichal/GameSH-etc/master/install-mylauncher.sh | bash
```

![Screenshot_Mylauncher](https://github.com/domichal/GameSH-etc/raw/master/images/mylauncher.png)


# What's my launcher?

**mylauncher** is a modification of the ClockworkPi's Python launcher and beside the improvements listed below it does not differ from the original.

Original README.md by clockworkpi can be found [here](https://github.com/clockworkpi/launcher/blob/master/README.md).

**mylauncher** can be used side by side with both original launchers (launcher and launchergo) and they can all be switched between easily with a provided script. It can also run on it's own, however it's advised to leave the original launcher intact to keep the functionality up to date with oncoming clockworkpi additions.

# Why?

Poorly organised, growing list of items on GameShell's main page and updates that were messing with my tidying ups.
I like to move things around, categorize games in folders and don't want new items to pop up on my home screen uninvited, but I also don't want to miss out on what clockworkpi adds so want to be able to update GameShell launcher without a hassle too.
I needed an up to date bare bone launcher that won't mess with my content and this is it.

# Features

* User Menu is moved outside the repository allowing complete separation*
* Icon matching mechanism added, no need for icon location to follow menu structure anymore!
* [UI] Focus is set on the first, most left page item*
* [UI] Refreshed icon set thanks to this great [source](https://www.figma.com/file/Mzfms2wlOR9l4c7OgP1GhNd5/GameShell?node-id=102%3A486)

_*These can be changed back to defaults in the [config](#configuration)_

## Added scripts

### Launcher tools

![Launcher_tools](https://github.com/domichal/GameSH-etc/raw/master/images/launcher_tools.png)


### Launcher switch

To be able to switch between all launchers, it was necessary to make original "switch to launcher/launcher go" methods dysfunctional to prevent them from breaking xstartup scripts when called from ``mylauncher``.

This script is not required by the launcher to run, but it makes life easier. Other way to use different launchers would be to rename launcher folders, or manually modifying ``.bashrc``. This scripts handles the latter.

![Launcher_tools](https://github.com/domichal/GameSH-etc/raw/master/images/switch_launcher.png)

The script will detect any number of launchers as long as they are located in ``/home/cpi`` and their name contain lowercase word ``launcher``.
**mylauncher** folder can also be renamed in accordance to the above.

# Installation

## Requirements

There's one for installation script: ``zip``.

I don't remember if it was installed on GameShell by default, but if not:
```
sudo apt install -y zip
```

## Quick installation

**Note:** The script will install the launcher and modify ``.bashrc`` file. Fore details, see [manual installation](#install-manually) steps.

Install from GameShell console:
```
curl -sSL https://raw.githubusercontent.com/domichal/GameSH-etc/master/install-mylauncher.sh | bash
```
Then proceed with [adding contents](#add-contents).

## Download installation script

Download [here](https://raw.githubusercontent.com/domichal/GameSH-etc/master/install-mylauncher.sh).

The script can also be run on PC to install **mylauncher** on sd card. In this case download the script and change ``homedir`` variable to point to the correct cpi home location before running it.

After installing go to [add contents](#add-contents).

## Install manually

Download [mylauncher.zip](https://github.com/domichal/mylauncher/archive/master.zip) and unzip the contents inside ``/home/cpi``

Rename unzipped folder to ``/home/cpi/mylauncher``

### Create a file ``/home/cpi/.startrc``
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
chmod 644 /home/cpi/.startrc
```

### Edit ``/home/cpi/.bashrc`` and add this code:
```
if [ -f /home/cpi/.start ]; then
   . /home/cpi/.start
el
```
JUST BEFORE (no spaces, new lines, nada!) the following "if" statement at the end of the file:
(there may be "$HOME" instead of "/home/cpi" there, but it points to the same thing at this point, so no worries)
```
if [ -f /home/cpi/launcher/.cpirc ]; then
   . /home/cpi/launcher/.cpirc
fi
```
so you end up with something like this:
```
if [ -f /home/cpi/.startrc ]; then
   . /home/cpi/.startrc
elif [ -f /home/cpi/launcher/.cpirc ]; then
   . /home/cpi/launcher/.cpirc
fi
```
That's it!
Ok, not entirely, the launcher will work, but it will have nothing but a power button in it, so let's

## Add Contents

Add your own contents to ``myMenu`` as you normally would, but if it comes to launcher functionalities, unless you are determined to get rid of the original launcher, don't copy things over, link them!
This way you'll keep original clockworkpi functionalities up to date if they're changed or if stuff is added after an update.

PowerOFF is a link too, see?:
```
$ ls -la ~/Menu/GameShell
total 8
drwxr-xr-x 2 cpi cpi 4096 Oct 19 01:59 .
drwxr-xr-x 3 cpi cpi 4096 Oct 19 01:59 ..
lrwxrwxrwx 1 cpi cpi   45 Oct 19 01:58 99_PowerOFF -> /home/cpi/launcher/Menu/GameShell/99_PowerOFF
```
This is the only item in this folder and it's recommended to keep it this way.

### Linking contents

Time to play with the separated menu, so log in as cpi, if you aren't:
```
su cpi
```
and move to the new menu folder:
```
cd ~/mylauncher/myMenu
```
I like my GameShell related items to be in their own folder, so I've done this:
```
mkdir 98_GameSH\>
ln -s ~/launcher/Menu/GameShell/10_Settings 98_GameSH\>/
ln -s ~/launcher/Menu/GameShell/30_RetroArch.sh 98_GameSH\>/
ln -s ~/launcher/Menu/GameShell/98_TinyCloud 90_GameSH\>/
ln -s ~/launcher/Menu/GameShell/90_Reload\ UI.sh 98_GameSH\>/
```
[Launcher tools](#launcher-tools) will go there too:
```
ln -s ~/mylauncher/scripts/91_Launcher\ Tools.sh 98_GameSH\>/
```
I'll also link [Switch Launcher script](#launcher-switch) to the ``~apps/Menu`` fso it's available from other launchers:
```
ln -s ~/mylauncher/scripts/92_Switch\ Launcher.sh ~/apps/Menu/
```
Music player to the main screen:
```
ln -s ~/launcher/Menu/GameShell/97_Music\ Player .
```
Utils will be nice to have, but let's call it Applications:
```
ln -s ~/apps/Menu/60_Utils 60_Apllications
```
and games, of course:
```
ln -s ~/apps/Menu/20_Retro\ Games .
ln -s ~/apps/Menu/21_Indie\ Games .
```
So now I have this structure in the menu:
```
myMenu
├── 20_Retro Games -> /home/cpi/apps/Menu/20_Retro Games
├── 21_Indie Games -> /home/cpi/apps/Menu/21_Indie Games
├── 60_Applications -> /home/cpi/apps/Menu/60_Utils
├── 97_Music Player -> /home/cpi/launcher/Menu/GameShell/97_Music Player
└── 98_GameSH>
    ├── 10_Settings -> /home/cpi/launcher/Menu/GameShell/10_Settings
    ├── 30_RetroArch.sh -> /home/cpi/launcher/Menu/GameShell/30_RetroArch.sh
    ├── 90_Reload UI.sh -> /home/cpi/launcher/Menu/GameShell/90_Reload UI.sh
    ├── 91_Launcher Tools.sh -> /home/cpi/mylauncher/scripts/91_Launcher Tools.sh
    └── 98_TinyCloud -> /home/cpi/launcher/Menu/GameShell/98_TinyCloud
```
while all the original items are still in the original launcher folder. Cool, huh?
But hold on, there's more:

### Icons

If you tried to organise things your way on GameShell previously, you know that now it should be time for some folder traversing to be done to move icons where they should be. Sure you can do that, but guess what, you don't have to!

**mylauncher** is modified to look for icons in application launcher parent folders, so for all the items put in ``GameSh>`` if the icons aren't there, it will look in ``myMenu`` too. By default it searches up to two levels up, so if you want to grow big trees in your menu, you will need to increase this value - look for this line: ``allowed = "../.."`` in the ``skin manager.py``.

Cascade search for Icon is done in the following order:
- original location and up - this location isn't searched for icons in the original launcher.
- user set skin and up
- default skin and up

Ok, it's time to restart. Your gameshell should boot into **mylauncher** now.

# Configuration

Just a tiny bit of.
All the launcher related settings (both of them) can be found in ``sys.py/myconfig.py`` and perhaps the comments will make it clear of what these settings change.
```
# ADDMENU_PATH - Path to the secondary menu folder, feel free to move it outside the launcher folder
# DEFAULT_FOCUSED_ITEM - Item to be highlighted by default on page render
#
# The values below will make the launcher behave/look like original
#
# ADDMENU_PATH = "/home/cpi/apps/Menu"
# DEFAULT_FOCUSED_ITEM = 1

ADDMENU_PATH = "/home/cpi/mylauncher/myMenu"
DEFAULT_FOCUSED_ITEM = 0
```

# Directory structure

```
/home/cpi/
├── apps
│   ├── emulators
│   └── Menu   <- By default, this is not used by mylauncher
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

# Compatibility

**mylauncher** is fully compatible with the default clockworkpi gameshell builds and can work without any disturbance to other launchers and vice versa.

# Updates

[Update mylauncher (git)](#launcher-tools) option is only available if the launcher folder is checked out with the repository.

No regular updates are planned. I will try to sync this repo with the clockworkpi repository from time to time though. Some improvements in the future are possible too. We'll see.

# Uninstallation

Whether you installed **mylauncher** manually or using installation script, reverse the changes listed in manual installation [steps](#install-manually).

---
You may also like my GameShell [dark skin](https://github.com/domichal/GameSH-Theme-Greey).
