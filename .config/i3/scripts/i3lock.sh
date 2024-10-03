#!/bin/bash

sleep 0.02
PICTURE=/tmp/i3lock.png
SCREENSHOT="scrot $PICTURE"

BLUR="10x4"

$SCREENSHOT
convert $PICTURE -blur $BLUR $PICTURE
i3lock -i $PICTURE
rm $PICTURE
