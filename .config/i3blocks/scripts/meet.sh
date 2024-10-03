#!/bin/bash

/home/$USER/.config/i3/scripts/show_meet.sh

case $BLOCK_BUTTON in
    3)
        /home/$USER/.config/i3/scripts/list_meets.sh &
        ;;
    1)
        /home/$USER/.config/i3/scripts/open_meet.sh &
        ;;
esac

