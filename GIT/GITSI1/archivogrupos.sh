#!/bin/bash

while true; do
    echo "------------------------------"
    echo "  Gestion de grupos - Menu   "
    echo "------------------------------"
    echo "1 - Crear grupo"
    echo "2 - Eliminar grupo"
    echo "3 - Modificar nombre de grupo"
    echo "4 - Listar grupos"
    echo "5 - Salir"
    echo "------------------------------"
    read -p "Seleccione una opcion: " opcion

    case $opcion in
        1)
            read -p "Ingrese el nombre del nuevo grupo: " nuevo_grupo
            if grep -q "^$nuevo_grupo:" /etc/group; then
                echo "El grupo ya existe."
	else
                sudo groupadd $nuevo_grupo
                echo "Grupo $nuevo_grupo creado con exito."
            fi
            ;;
        2)
            read -p "Ingrese el nombre del grupo a eliminar: " grupo_eliminar
            if grep -q "^$grupo_eliminar:" /etc/group; then
                if ! grep -q ":.*:$grupo_eliminar$" /etc/passwd; then
                    sudo groupdel $grupo_eliminar
                    echo "Grupo $grupo_eliminar eliminado con exito."
                else
                    echo "No se puede eliminar, es el grupo principal de alguien"
                fi
            else
                echo "El grupo no existe."
            fi
            ;;
	3)
            read -p "Ingrese el nombre del grupo a modificar: " grupo_actual
            read -p "Ingrese el nuevo nombre para el grupo: " grupo_nuevo
            if grep -q "^$grupo_actual:" /etc/group; then
                sudo groupmod -n $grupo_nuevo $grupo_actual
                echo "Grupo $grupo_actual cambiado a $grupo_nuevo con �xito."
            else
                echo "El grupo no existe."
            fi
            ;;
        4)
            echo "Lista de grupos en el sistema:"
            cut -d: -f1 /etc/group
            ;;
        5)
            echo "Saliendo..."
            exit 0
            ;;
        *)
            echo "Opcion no valida, intente de nuevo."
            ;;
    esac
    echo ""
done
