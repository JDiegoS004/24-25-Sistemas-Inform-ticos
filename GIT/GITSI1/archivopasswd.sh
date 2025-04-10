#!/bin/bash
echo "Introduce el nombre de usuario:"
read usuario

if ! id "$usuario" &>/dev/null; then
    echo "ERROR: El usuario $usuario no existe."
    exit 1
fi

while true; do
  echo "=========================================="
  echo "GESTION DE CONTRASEÑA"
  echo "1 - Limite de caracteres de la contraseña"
  echo "2 - Tiempo de validez y advertencias"
  echo "3 - Salir"
  echo "=========================================="
  read -p "Seleccione una opcion: " opcion

  case $opcion in
    1)
        
        echo "Introduce la longitud mínima de la contraseña (por ejemplo, 8):"
        read longitud

        if ! [[ "$longitud" =~ ^[0-9]+$ ]]; then
            echo "ERROR: La longitud debe ser un número."
            exit 1
        fi

        echo "Configurando la longitud mínima de la contraseña..."
        sudo sed -i "s/^# minlen=[0-9]*$/minlen=$longitud/" /etc/security/pwquality.conf
        echo "Longitud mínima de la contraseña cambiada a $longitud."
        ;;
    2)
       
        echo "Introduce el tiempo de expiración de la contraseña en días (por ejemplo, 90):"
        read expiracion

        if ! [[ "$expiracion" =~ ^[0-9]+$ ]]; then
            echo "ERROR: El tiempo de expiración debe ser un número."
            exit 1
        fi

        echo "Configurando el tiempo de expiración de la contraseña..."
        sudo chage -M "$expiracion" "$usuario"
        echo "Tiempo de expiración de la contraseña cambiado a $expiracion días."
        ;;

    3)
        echo "Saliendo del script..."
        exit 0
        ;;

    *)
        echo "ERROR: Opción no válida."
        exit 1
        ;;
esac
done
