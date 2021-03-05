#!/bin/bash

USER_NAME=quiterion
USER_PID=1000

while [ true ]
do
	sudo -u $USER_NAME DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$USER_PID/bus notify-send -u critical 'Check yay Status!'
	sleep 240s
done
