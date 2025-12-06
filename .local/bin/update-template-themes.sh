#!/bin/bash

# Source colors from pywal cache (works on both X11 and Wayland)
# This replaces xrdb which only works on X11
WAL_COLORS="$HOME/.cache/wal/colors.sh"

if [[ ! -f "$WAL_COLORS" ]]; then
    echo "Error: pywal colors not found at $WAL_COLORS" >&2
    echo "Run 'wal -i <image>' first to generate colors" >&2
    exit 1
fi

# Source the colors - provides $color0-$color15, $foreground, $background
source "$WAL_COLORS"

# Add transparency to background for compositing
background_opaq="$background"
background="${background}CC"

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

if command -v rofi &> /dev/null; then
    for i in "${XDG_CONFIG_HOME}"/rofi/templates/*.rasi; do
        [[ -f "$i" ]] || continue
        sed -e "s/\${color1}/$color1/" \
            -e "s/\${color3}/$color3/" \
            -e "s/\${color6}/$color6/" \
            -e "s/\${foreground}/$foreground/" \
            -e "s/\${background}/$background/" "$i" > "${i/templates/themes}"
    done
fi

if command -v dunst &> /dev/null; then
    killall dunst 2>/dev/null || true
    sed -e "s/\${color1}/$color1/" \
        -e "s/\${color3}/$color3/" \
        -e "s/\${color6}/$color6/" \
        -e "s/\${foreground}/$foreground/" \
        -e "s/\${background}/$background/" \
        "${XDG_CONFIG_HOME}/dunst/templates/dunstrc" > "${XDG_CONFIG_HOME}/dunst/dunstrc"
fi
