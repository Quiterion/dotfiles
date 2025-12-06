#!/bin/bash

img=$(find /home/quiterion/Pictures/Wallpapers/github-wallpapers/ -type f -name '*.jpg' | shuf | head -1)

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    swaylock -i "$img" --scaling fill
else
    convert -resize 1920x1080 "$img" RGB:- | i3lock --raw=1920x1080:rgb --image /dev/stdin -t -p win
fi
