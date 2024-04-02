#!/bin/bash

output="/home/jeremy/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"

case "$1" in
    "select") scrot "$output" --select --line mode=edge -e 'xclip -selection c -t image/png < $f'|| exit ;;
    "window") scrot "$output" --focused --border || exit ;;
    *) scrot "$output" || exit ;;
esac

notify-send "Imagen capturada y copiada al portapapeles." -t 1000
exit 1
