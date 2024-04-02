#!/bin/bash

poweroff_function() {
    echo 'your_user_password' | sudo -S /sbin/poweroff
}

reboot_function() {
    echo 'your_user_password' | sudo -S /sbin/reboot
}

options=" Apagar\n Reiniciar\n Cerrar Sesión"

selected_option=$(echo -e "$options" | rofi -dmenu -i -p "Selecciona una opción:" -width 20 -lines 3 -font "hack 10" -padding 30 -separator-style none)

case "$selected_option" in
    " Apagar") poweroff_function ;;
    " Reiniciar") reboot_function ;;
    " Cerrar Sesión") i3-msg exit ;;
esac 
