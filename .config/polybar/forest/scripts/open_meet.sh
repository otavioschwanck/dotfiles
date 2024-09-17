#!/bin/bash

current_time=$(date +%H:%M)

next_event=$(gcalcli --nocolor agenda "$current_time" "23:59" --nodeclined --details=url --details=title --tsv | grep "$(date +%Y-%m-%d)" | head -n 1)

if [ -n "$next_event" ]; then
    event_url=$(echo "$next_event" | awk '{print $6}')
    event_title=$(echo "$next_event" | awk -F'\t' '{print $7}')

    notify-send "Iniciando reunião $event_title"

    xdg-open "$event_url"
else
  notify-send "Sem reuniões para hoje"
fi

