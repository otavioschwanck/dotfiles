#!/bin/bash

# Obtém a lista de eventos para o dia com detalhes e títulos
events=$(gcalcli --nocolor agenda --nodeclined --details=url --details=title --tsv)

# Testando o valor de $events
# Verifica se há eventos
if [ -z "$events" ]; then
    notify-send "Sem reuniões" --urgency=normal
    exit 0
fi

# Função para converter a data de YYYY-MM-DD para dd/mm/YYYY
format_date() {
    echo "$1" | awk -F'-' '{ print $3"/"$2"/"$1 }'
}

# Formata os eventos para exibir no rofi com data no formato dd/mm/YYYY
formatted_events=$(echo "$events" | awk -F'\t' 'NR>1 { 
    cmd="date -d "$1" +\"%d/%m\""; cmd | getline newdate; close(cmd);
    printf "%s %s-%s - %s\n", newdate, $2, $4, $7
}')

dir="~/.config/polybar/forest/scripts/rofi"

# Usa o rofi para exibir a lista de eventos e selecionar um
selected_event=$(echo "$formatted_events" | rofi -dmenu -p "Reuniões"  -theme $dir/meet.rasi)

# Se um evento foi selecionado
if [ -n "$selected_event" ]; then
    # Extrai a data e a hora do evento selecionado (agora no formato dd/mm/YYYY)
    selected_event_date=$(echo "$selected_event" | awk '{print $1}')
    selected_event_time=$(echo "$selected_event" | awk '{print $2}' | cut -d'-' -f1)

    # Converte a data selecionada de volta para o formato YYYY-MM-DD para comparar
    selected_event_date_iso=$(echo "$selected_event_date" | awk -F'/' '{ print $3"-"$2"-"$1 }')

    # Busca a linha correspondente ao evento selecionado
    selected_event_full=$(echo "$events" | awk -F'\t' -v date="$selected_event_date_iso" -v time="$selected_event_time" \
        'NR>1 && $1==date && $2==time {print}')

    # Extrai a URL do evento (tentando pegar a URL certa, seja html_link ou hangout_link)
    event_url=$(echo "$selected_event_full" | awk -F'\t' '{ if ($6 != "") print $6; else print $5 }')

    # Se a URL foi encontrada, abre o link no navegador
    if [ -n "$event_url" ]; then
        xdg-open "$event_url"
    else
        notify-send "URL não encontrada" --urgency=critical
    fi
fi
