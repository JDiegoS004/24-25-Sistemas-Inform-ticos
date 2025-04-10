#!/bin/bash

LOG_DIR=~/Documentos/Logwatch
archivos=( $(ls -t "$LOG_DIR"/*informe_logwatch.log 2>/dev/null) )

    archivo="${archivos[$i]}"
    echo "----------------------------------"
    echo "Archivos disponibles"
    echo "----------------------------------"
# Limit to the last 5 files
for i in "${!archivos[@]}"; do
    if [ "$i" -ge 5 ]; then
        break
    fi
echo "${archivos[$i]}"
done
echo "=================================="


