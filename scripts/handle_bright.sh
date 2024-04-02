#!/bin/bash

# Verifica si se proporciona un valor de incremento y dirección
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Uso: $0 [incremento] [direccion: up o down]"
    exit 1
fi

# Define el incremento y la dirección
increment=$1
direction=$2

# Obtén el nombre de la pantalla
screen_name=$(xrandr --listmonitors | awk 'NR==2 {print $4}')

# Ajusta el brillo con xrandr
if [ "$direction" == "up" ]; then
    brightness_aux=$(xrandr --verbose | grep -i brightness | awk '{print int($2 * 100)}')
    if [ $brightness_aux -ge 150 ]; then
        exit 0
    fi
    xrandr --output "$screen_name" --brightness $(awk "BEGIN {print $(xrandr --verbose | grep -m 1 -i brightness | awk '{print $2}') + $increment}")
else
    brightness_aux=$(xrandr --verbose | grep -i brightness | awk '{print int($2 * 100)}')
    if [ $brightness_aux -le 60 ]; then
        exit 0
    fi
    xrandr --output "$screen_name" --brightness $(awk "BEGIN {print $(xrandr --verbose | grep -m 1 -i brightness | awk '{print $2}') - $increment}")
fi

exit 1