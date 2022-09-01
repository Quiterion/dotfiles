#!/bin/bash

USER_PID=1000

while [ true ]
do
	sudo -u $USER DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$USER_PID/bus notify-send -u critical 'Check yay Status!'
	sleep 240s
done
