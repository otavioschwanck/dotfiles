#!/bin/bash

temp_file="/tmp/events_list.tsv"

if [ -f "$temp_file" ] && [ -s "$temp_file" ]; then
    events=$(cat "$temp_file")
else
    events=$(~/.pyenv/shims/gcalcli --nocolor agenda --nodeclined --details=url --details=title --tsv)
fi

if [ -z "$events" ]; then
    notify-send "Sem reuniões" --urgency=normal
    exit 0
fi

format_date() {
    echo "$1" | awk -F'-' '{ print $3"/"$2"/"$1 }'
}

formatted_events=$(echo "$events" | awk -F'\t' 'NR>1 { 
    cmd="date -d "$1" +\"%d/%m\""; cmd | getline newdate; close(cmd);
    printf "%s %s-%s - %s\n", newdate, $2, $4, $7
}')

dir="~/.config/i3/scripts/rofi"

selected_event=$(echo "$formatted_events" | rofi -dmenu -p "Reuniões"  -theme $dir/meet.rasi)

if [ -n "$selected_event" ]; then
    selected_event_date=$(echo "$selected_event" | awk '{print $1}')

    selected_event_time=$(echo "$selected_event" | awk '{print $2}' | cut -d'-' -f1)

    selected_event_date_formatted=$(echo "$selected_event_date" | awk -F'/' '{print $2 "/" $1}')

    selected_event_full=$(echo "$events" | awk -F'\t' -v date="$selected_event_date_formatted" -v time="$selected_event_time" \
        'NR > 1 {
            split($1, event_date_parts, "-");
            event_month_day = event_date_parts[2] "/" event_date_parts[3];
            if (event_month_day == date && $2 == time) {
                print
            }
        }')

    event_url=$(echo "$selected_event_full" | awk -F'\t' '{ if ($6 != "") print $6; else print $5 }')

    if [ -n "$event_url" ]; then
        xdg-open "$event_url"
    else
        notify-send "URL não encontrada" --urgency=critical
    fi
fi
