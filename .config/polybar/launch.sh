#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar (on multiple monitors if detected)
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar top &
    MONITOR=$m polybar bottom &
  done
else
  polybar top &
  polybar bottom &
fi
echo "Polybar launched..."
