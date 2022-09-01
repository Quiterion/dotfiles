#!/bin/bash

echo -n "Cat text: "
read cat_text

echo -n "Musician text: "
read musician_text

echo -n "Drum text: "
read drum_text

echo -n "File name: "
read file_name

cat_text_list=( $cat_text )
cat_len=${#cat_text_list[@]}
musician_text_list=( $musician_text )
musician_len=${#musician_text_list[@]}
drum_text_list=( $drum_text )
drum_len=${#drum_text_list[@]}

if [ -f /tmp/catfile.txt ]
then
	rm /tmp/catfile.txt
fi

if [ -f /tmp/musicianfile.txt ]
then
	rm /tmp/musicianfile.txt
fi

if [ -f /tmp/drumfile.txt ]
then
	rm /tmp/drumfile.txt
fi

for (( i=1; i<$cat_len+1; i+=6))
do
	((j=$i+5))
	echo $cat_text | cut -d " " -f$i-$j >> /tmp/catfile.txt
done

for (( k=1; k<$musician_len+1; k+=6))
do
	((l=$k+5))
	echo $musician_text | cut -d " " -f$k-$l >> /tmp/musicianfile.txt
done

for (( x=1; x<$drum_len+1; x+=6))
do
	((y=$x+5))
	echo $drum_text | cut -d " " -f$x-$fy>> /tmp/drumfile.txt
done

ffmpeg -i ~/Downloads/Cat_Bongo.mp4 -vf \
	drawtext="fontfile=/usr/share/fonts/cantarell/Cantarell-Bold.otf: textfile=/tmp/catfile.txt: \
		fontcolor=white: borderw=2: bordercolor=black: fontsize=45: box=0: x=(366 - text_w/2): y=750, \
	drawtext=fontfile=/usr/share/fonts/cantarell/Cantarell-Bold.otf: textfile=/tmp/musicianfile.txt: \
		fontcolor=white: borderw=2: bordercolor=black: fontsize=45: box=0: x=(1240 - text_w/2): y=540, \
	drawtext=fontfile=/usr/share/fonts/cantarell/Cantarell-Bold.otf: textfile=/tmp/drumfile.txt: \
		fontcolor=white: borderw=2: bordercolor=black: fontsize=45: box=0: x=(1300 - text_w/2): y=860" \
	-vcodec h264 -acodec mp3 "/home/$USER/$file_name.mp4"
