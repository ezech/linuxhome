#!/bin/sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config
polybar laptop &
[ "$(polybar -m | grep HDMI | wc -l)" == "1" ] && polybar monitor &

echo "Polybar launched..."
