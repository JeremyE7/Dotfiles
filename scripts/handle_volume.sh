#!/bin/bash

# Límite máximo de volumen
MAX_VOLUME=140

# Comando para generar notificaciones con iconos
NOTIFY_COMMAND="notify-send -i audio-volume-high -t 2000"

# Comando para refrescar i3status
REFRESH_I3STATUS="killall -SIGUSR1 i3status"

# Función para obtener el nivel actual de volumen
get_current_volume() {

# Obtener el volumen actual
volume=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n 1 | awk -F / '{print $2}' | tr -d ' %')

echo " $volume"

}

# Función para subir el volumen
increase_volume() {
  if [ $(get_current_volume) -ge $MAX_VOLUME ]; then
    $NOTIFY_COMMAND "Volume: $(get_current_volume)%"
    exit 0
  fi
  pactl set-sink-volume @DEFAULT_SINK@ +10% && $REFRESH_I3STATUS
}

# Función para bajar el volumen
decrease_volume() {
  pactl set-sink-volume @DEFAULT_SINK@ -10% && $REFRESH_I3STATUS
}

# Función para silenciar/desilenciar el volumen
toggle_mute() {
  pactl set-sink-mute @DEFAULT_SINK@ toggle && $REFRESH_I3STATUS
}

# Función para silenciar/desilenciar el micrófono
toggle_mic_mute() {
  pactl set-source-mute @DEFAULT_SOURCE@ toggle && $REFRESH_I3STATUS
}

# Obtener el argumento del script
case "$1" in
  "increase")
    increase_volume
    ;;
  "decrease")
    decrease_volume
    ;;
  "toggle_mute")
    toggle_mute
    ;;
  "toggle_mic_mute")
    toggle_mic_mute
    ;;
  *)
    echo "Uso: $0 {increase|decrease|toggle_mute|toggle_mic_mute}"
    exit 1
    ;;
esac

exit 0
