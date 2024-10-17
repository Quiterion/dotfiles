#!/bin/bash

color1=$(xrdb -get color1)
color3=$(xrdb -get color3)
color6=$(xrdb -get color6)
foreground=$(xrdb -get foreground)
background_opaq=$(xrdb -get background)
background="${background_opaq}CC"
${XDG_CONFIG_HOME%/}/


if command -v rofi &> /dev/null; then
    for i in ${XDG_CONFIG_HOME%/}/rofi/templates/*.rasi; do
        sed -e "s/\${color1}/$color1/" \
            -e "s/\${color3}/$color3/" \
            -e "s/\${color6}/$color6/" \
            -e "s/\${foreground}/$foreground/" \
            -e "s/\${background}/$background/" $i > "${i/templates/themes}"
    done
fi

if command -v dunst &> /dev/null; then
    killall dunst;
    sed -e "s/\${color1}/$color1/" \
        -e "s/\${color3}/$color3/" \
        -e "s/\${color6}/$color6/" \
        -e "s/\${foreground}/$foreground/" \
        -e "s/\${background}/$background/" \
        "${XDG_CONFIG_HOME%/}/dunst/templates/dunstrc" > "${XDG_CONFIG_HOME%/}/dunst/dunstrc"
fi

