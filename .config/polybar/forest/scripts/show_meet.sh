#!/bin/bash

ALERT_TIME=3
MESSAGE_TIME=10

current_time=$(date +%H:%M)

next_event=$(gcalcli --nocolor agenda "$current_time" "23:59" --nostarted --nodeclined --details=url --details=title --tsv | grep "$(date +%Y-%m-%d)" | head -n 1)

current_minute=$(date +%M)

if [ $((current_minute % 3)) -eq 0 ]; then
  temp_file="/tmp/events_list.tsv"

  gcalcli --nocolor agenda --nodeclined --details=url --details=title --tsv > "$temp_file"
fi

if [ -n "$next_event" ]; then
    event_time=$(echo "$next_event" | awk '{print $2}')
    event_url=$(echo "$next_event" | awk '{print $6}')
    event_title=$(echo "$next_event" | awk -F'\t' '{print $7}')

    current_time=$(date +%H:%M)

    if [[ $event_time =~ ^[0-9]{2}:[0-9]{2}$ ]]; then
        event_timestamp=$(date -d "$event_time" +%s)
        current_timestamp=$(date +%s)
        time_diff=$(( (event_timestamp - current_timestamp) / 60 ))

        if [ "$time_diff" -lt 30 ]; then
          echo "$event_title começa em $time_diff minutos ($event_time)"
        else
            echo "$event_title às $event_time"
        fi

        if [ "$time_diff" -eq "$MESSAGE_TIME" ]; then
            notify-send "Próxima reunião: $event_title começa em $MESSAGE_TIME minutos" --urgency=normal --expire-time=600000
        fi

        if [ "$time_diff" -eq "$ALERT_TIME" ]; then
            xdg-open "$event_url"
        fi
    else
        echo "Formato de horário inválido: $event_time"
    fi
else
    echo "Sem mais reuniões hoje"
fi
