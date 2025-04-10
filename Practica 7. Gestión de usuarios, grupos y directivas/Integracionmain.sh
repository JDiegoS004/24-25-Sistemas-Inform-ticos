#!/bin/bash

while true; do
	echo "================================="
	echo " Configuracion del Sistema - Menú"
	echo "================================="
	echo "1 - Configurar usuarios"
	echo "2 - Configurar grupos"
	echo "3 - Configurar directivas de cuenta y contraseña"
	echo "0 - Salir"
	echo "=================================="
	echo -n "Selecione una opcion:"
	read opcion

	case $opcion in
1)
sudo bash ./archivo.sh
;;
2)
sudo bash ./archivogrupos.sh
;;
3)
sudo bash ./archivopasswd.sh
;;
0)	echo "Saliendo..."
exit 0
;;
*)	echo "Opcion inválida, por favor intente nuevamente."
;;
esac

	echo "Presione cualquier tecla para continuar..."
	read -n 1 -s
done
