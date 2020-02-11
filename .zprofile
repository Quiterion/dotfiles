#
# ~/.zprofile
#

# Environment variables
export RANGER_LOAD_DEFAULT_RC='FALSE'
export XDG_CONFIG_HOME="$HOME/.config/"
export QT_QPA_PLATFORMTHEME=qt5ct  # Enable GTK themes with Qt using qt5ct

# Export custom scripts to path
export PATH="$HOME/.local/bin:$PATH"

# Set trackpoint acceleration to warp speed
xinput --set-prop "TPPS/2 IBM TrackPoint" "libinput Accel Speed" 1

# if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
#     exec startx
 fi
