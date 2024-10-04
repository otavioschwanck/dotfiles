#!/bin/bash

sleep 0.02
PICTURE=/tmp/i3lock.png
SCREENSHOT="scrot $PICTURE"

BLUR="33x33"

$SCREENSHOT
convert $PICTURE -blur $BLUR $PICTURE
i3lock -i $PICTURE
rm $PICTURE
