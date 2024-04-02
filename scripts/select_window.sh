#!/bin/bash

# Obtener una lista de identificadores de ventanas visibles
window_ids=$(xdotool search --onlyvisible .)

# Iterar sobre los identificadores y obtener los nombres de las ventanas
for window_id in $window_ids; do
    window_name=$(xdotool getwindowname $window_id)
    echo "ID: $window_id, Nombre: $window_name"
done
