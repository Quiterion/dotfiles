#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar (on multiple monitors if detected)
if type "xrandr"; then
    IFS=$'\n'  # must set internal field separator to avoid dumb
    for entry in $(xrandr --query | grep " connected"); do
        mon_name=$(cut -d " " -f1 <<< "$entry")
        mon_status=$(cut -d " " -f3 <<< "$entry")

        tray_pos="none"
        if [ "$mon_status" == "primary" ]; then
            tray_pos="center"
        fi

        #MONITOR=$mon_name TRAY_POS=$tray_pos polybar -r top 2>&1 | tee -a /tmp/polybar-monitor-"$mon".log & disown
        MONITOR=$mon_name TRAY_POS=$tray_pos polybar -r bottom 2>&1 | tee -a /tmp/polybar-monitor-"$mon".log & disown
    done
    unset IFS  # avoid mega dumb by resetting the IFS
else
    #polybar -r top 2>&1 | tee -a /tmp/polybar.log & disown
    polybar -r bottom 2>&1 | tee -a /tmp/polybar.log & disown
fi
echo "Bars launched..."
