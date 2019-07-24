#!/bin/bash

# Terminate already running compton instances
killall -q compton

# Wait until the processes have been shut down
while pgrep -u $UID -x compton >/dev/null; do sleep 1; done

# Launch compton in background, using default config location ~/.config/compton/compton.conf
compton -b --config $HOME/.config/compton/compton.conf

echo "Compton launched..."
