#!/bin/bash

if dunstctl is-paused | grep -q "true"; then
    ICON=" "
else
    ICON=" "
fi

if [ "$BLOCK_BUTTON" == "1" ]; then
    dunstctl set-paused toggle
fi

echo "$ICON"
