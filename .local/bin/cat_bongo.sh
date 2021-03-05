#!/bin/bash
read -p "Cat text: " cat_text
read -p "Bongo text: " bongo_text
read -p "File name: " file_name
ffmpeg -i ~/Downloads/Cat_Bongo.mp4 -vf drawtext="fontfile=/usr/share/fonts/cantarell/Cantarell-Bold.otf: \
text=$cat_text: fontcolor=white: fontsize=45: box=0: \
x=(366 - text_w/2): y=750, drawtext=fontfile=/usr/share/fonts/cantarell/Cantarell-Bold.otf: \
text=$bongo_text: fontcolor=white: fontsize=45: box=0: \
x=(1200 - text_w/2): y=720" -vcodec h264 -acodec mp3 "/home/quiterion/$file_name.mp4"
