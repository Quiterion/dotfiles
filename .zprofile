#
# ~/.zprofile
#

# Environment variables
export RANGER_LOAD_DEFAULT_RC='FALSE'
export BROWSER='qutebrowser'
export XDG_CONFIG_HOME="$HOME/.config/"
export QT_QPA_PLATFORMTHEME=qt5ct  # Enable GTK themes with Qt using qt5ct

# Export custom scripts to path
export PATH="$HOME/.local/bin:$PATH"

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    exec startx
fi
