#!/bin/bash

img=$(find /home/quiterion/Pictures/Wallpapers/github-wallpapers/ -type f -name '*.jpg' | shuf | head -1)

convert -resize 1920x1080 "$img" RGB:- | i3lock --raw=1920x1080:rgb --image /dev/stdin -t -p win
