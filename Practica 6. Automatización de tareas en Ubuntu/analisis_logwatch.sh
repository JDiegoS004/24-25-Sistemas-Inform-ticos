#!/bin/bash

LOG_DIR=~/Documentos/Logwatch

while true; do
    echo "==============================="
    echo "  Menú de Análisis - Archivos de Log"
    echo "==============================="
    echo "1 - Intentos de conexión fallidos"
    echo "2 - Errores del sistema"
    echo "3 - Actividad de usuarios"
    echo "0 - Salir"
    echo "==============================="
    echo -n "Seleccione una opción: "
    read opcion_analisis

    if [ "$opcion_analisis" -eq 0 ]; then
        echo "Saliendo del programa..."
        break
    elif [[ "$opcion_analisis" -ne 1 && "$opcion_analisis" -ne 2 && "$opcion_analisis" -ne 3 ]]; then
        # Caso de opción inválida
        echo "Opción inválida. Por favor, seleccione una opción válida."
        continue
    fi

    echo "Selecciona el archivo para analizar:"
    archivos=( $(ls -t "$LOG_DIR"/*informe_logwatch.log 2>/dev/null) )

    if [ ${#archivos[@]} -eq 0 ]; then
        echo "No se encontraron archivos de log en el directorio $LOG_DIR."
        continue
    fi

    for i in "${!archivos[@]}"; do
        echo "$((i+1)) - ${archivos[$i]}"
    done

    echo "0 - Cancelar"
    echo -n "Seleccione un archivo: "
    read archivo_opcion

    if [ "$archivo_opcion" -eq 0 ]; then
        echo "Operación cancelada."
        continue
    elif [ "$archivo_opcion" -le ${#archivos[@]} ] && [ "$archivo_opcion" -ge 1 ]; then
        archivo_seleccionado="${archivos[$((archivo_opcion-1))]}"
        echo "Archivo seleccionado: $archivo_seleccionado"

        case $opcion_analisis in
            1)
                # Buscar intentos de conexión fallidos
                sudo grep "Failed password" "$archivo_seleccionado"
                ;;
            2)
                # Buscar errores del sistema
                sudo grep -i "error" "$archivo_seleccionado"
                ;;
            3)
                # Buscar actividad de usuarios
                sudo grep "session opened for user" "$archivo_seleccionado"
                ;;
        esac
    else
        echo "Opción inválida. Por favor, inténtelo de nuevo."
    fi
done

