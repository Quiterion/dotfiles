#!/bin/bash

i3lock -ti "$(find /home/quiterion/Pictures/Wallpapers -type f -name '*.png' | shuf | head -1)" -p win
