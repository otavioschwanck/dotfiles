dir="~/.config/i3/scripts/rofi"

selected_file=$(fdfind . --type f --hidden --exclude '.*' $HOME --exec stat --printf "%Y\t%n\n" | \
awk -v home="$HOME" '{print $0 "\t" ($2 ~ "^" home "/Downloads" || $2 ~ "^" home "/Imagens" ? 0 : 1)}' | \
sort -k3,3n -k1,1nr | cut -f2- | sed -e 's/\t[01]$//' -e "s|$HOME/||" | rofi -theme $dir/find_files.rasi -show-icons -dmenu -i -p "Arquivos:" -no-custom -l 20 -kb-custom-1 "Ctrl+c")

# Verifica se a tecla ESC foi pressionada
ret_val=$?
file=$(echo "$selected_file" | sed 's/[[:space:]]*$//')

if [ $ret_val -eq 1 ]; then
    # Se ESC foi pressionado, não faz nada e sai
    exit 0
elif [ $ret_val -eq 10 ]; then
    # Copiar o caminho completo do arquivo para a área de transferência
    notify-send "Copiado para a área de transferência" "$file"
    nautilus --no-desktop --select "$HOME/$file"
else
    # Abrir o arquivo selecionado
    xdg-open "$HOME/$file"
fi
