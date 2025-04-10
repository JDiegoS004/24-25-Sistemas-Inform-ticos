#!/bin/bash
while true;do

echo "=========================="
echo "Gestión de Usuarios - Menú"
echo "=========================="
echo "1 - Crear Usuario"
echo "2 - Eliminar Usuario"
echo "3 - Bloquear Usuario"
echo "4 - Desbloquear Usuario"
echo "5 - Listar Usuarios"
echo "0 - Salir"
echo "=========================="

echo "Seleccione una opción"
read Eleccion

case $Eleccion in
#CREACIÓN DE USUARIOS
1)
echo "Introduzca el nombre del nuevo usuario:"
read nuevoUsuario
echo "A que grupo pertenecerá el nuevo usuario. Introduzca (profesores) o (alumnos)"
read group

if getent group "$group" > /dev/null; then
	echo "El grupo $group ya existe"
else
	sudo groupadd "$group"
fi
if [id"$usuario"&>/dev/null];then
echo "ERROR:El usuario ya existe"
else
sudo useradd -m -g "$group" "$nuevoUsuario"
echo "El usuario ha sido añadido al grupo $group"
fi
;;
#ELIMINACIÓN DE USUARIOS

2)
echo "Ingrese el nombre del usuario a eliminar:"
read usuario
sudo userdel -r -f "$usuario"
if [ $? -eq 0 ]; then
        echo "Se ha eliminado al usuario $usuario"
else
        echo "ERROR"
fi

;;
#BLOQUEAR USUARIOS
3)
echo "Ingresa el nombre del usuario a bloquear:"
read usuario
sudo usermod -L $usuario
if [ $? -eq 0 ]; then
        echo "Se ha bloqueado al usuario $usuario"
else
        echo "ERROR"
fi

;;
#DESBLOQUEAR USUARIOS
4)
echo "Ingrese el nombre del usuario a desbloquear"
read usuario

sudo usermod -U $usuario

if [ $? -eq 0 ]; then
        echo "Se ha desbloqueado al usuario $usuario"
else
        echo "ERROR"
fi

;;
#LISTAR USUARIOS
5)
getent passwd
;;
0)
echo "Saliendo..."
exit
;;
*)
echo "ERROR"
;;
esac
done
