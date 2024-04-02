#!/bin/bash

# Archivo temporal para almacenar el workspace
workspace_file="/tmp/workspace_guardado.txt"

# Obtener el número del workspace activo antes de mover la ventana
previous_workspace=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused == true).num')

echo "La ventana activa se encontraba en el escritorio: $previous_workspace"

# Guardar el valor del workspace en un archivo temporal


# Mover la ventana al workspace 10 si no está allí
if [ "$previous_workspace" != "10" ]; then
    echo "$previous_workspace" > "$workspace_file"
    i3-msg "move window to workspace 10"
    echo "La ventana ha sido movida al escritorio 10."
fi
