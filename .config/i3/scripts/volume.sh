#!/bin/bash

# Get current volume level and mute status using amixer
VOLUME=$(amixer get Master | grep -o -m 1 '[0-9]*%' | head -n1 | tr -d '%')
MUTE=$(amixer get Master | grep '\[on\]' > /dev/null && echo "on" || echo "off")

# Display the volume with a symbol
if [ "$MUTE" == "off" ]; then
    echo " Muted"
else
    echo " $VOLUME%"
fi

# Handle click events
case $BLOCK_BUTTON in
    3) # Left click opens pavucontrol
        pavucontrol &
        ;;
    1) # Right click toggles mute/unmute
        amixer set Master toggle
        ;;
esac
