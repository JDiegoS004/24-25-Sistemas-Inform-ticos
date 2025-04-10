#!/bin/bash

while true; do
echo "============================="
echo "Menu Principal - Logwatch"
echo "============================="
echo "1 - Realizar informe ahora mismo"
echo "2 - Ver informes disponibles"
echo "3 - Analizar informacion"
echo "0 - Salir"
echo "============================="

read -p "Seleccione una opcion:" op

case $op in

1)
	#CREACION DE INFORMES
	sudo logwatch --output file --filename $(date +%Y-%m-%d_%H:%M:%S)_informe_logwatch.log --range All --detail High
	echo "Informe generado con exito."
	;;
2)
	#LISTADO DE INFORMES
	./select_log.sh
	;;
3)
	#MENU DE ANALISIS DE USUARIOS
	./analisis_logwatch.sh
	;;
0)
	echo "Saliendo..."
	break
	;;
*)
	echo "Opcion Invalida"
	;;
esac
done
