#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Insert dumb settings that shouldn't really go here
# Does anyone /really/ know what the proper X dotfiles are?
xinput --set-prop "TPPS/2 IBM TrackPoint" "libinput Accel Speed" 1
xinput --set-prop "Synaptics TM3276-022" "libinput Disable While Typing Enabled" 0


# Swap capslock and escape keys because I'm a vim-using sadist
#setxkbmap -option caps:swapescape

exec i3
