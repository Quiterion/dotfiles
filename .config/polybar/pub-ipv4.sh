#!/bin/bash

if pgrep -x openvpn 2>&1 > /dev/null; then
	suffix="%{F#82E0AA}VPN%{A}%{F-}"
	echo "$(curl -s https://ipinfo.io/ip) ($suffix)"
else
	suffix="%{F#f00}No VPN%{A}%{F-}"
	echo "($suffix)"
fi

