#!/bin/bash
###########################################################################
#Modulo recover
recoverBkp(){
	# TODO validar path ingresado
	# TODO mover o eliminar los arhcivos a ser reemplazado
	read -p "Ingrese la ruta absoluta del backup a restaurar:" PATH_RESTORE
	echo "Restaurando....."
	sudo tar -Pzxvf ${PATH_RESTORE}
	sleep 2
}
###########################################################################
#Modulo de backup
crear_backup(){
	echo "Creando el .tar del backup"
	sudo tar -Pzcvf ${PATH_BACKUP_ACTUAL} ${LISTA_PATH[@]} 

	sleep 2
}
###########################################################################
#Modulo de lectura, se obtiene y se valida los parametros inciales para el backup/recover
verificarPath(){
	# TODO validar que el path no tenga wildcards
	if [[ ! -f $1 && ! -d $1 ]]; then
		echo "$1 -- no es un path valido"
		return 0
	elif [[ "$1" != /* ]]; then
		echo "$1 -- no es una ruta absoluta"
		return 0
	else
		return 1
	fi
}
imprimirContenidoPath(){
	clear >$(tty)
	echo "El directorio contiene lo siguiente:"
	sudo ls -ltrh $1
}
imprimirListaPath(){
	echo "La lista actual de paths es la siguiente:"
	printf '%s\n' "${LISTA_PATH[@]}"
	echo "En el caso de haber ingresado el path incorrecto, termine con CTRL-c y vuelva a ejecutar"
}
leerPaths(){
	while read -p "Ingrese el path o Intro para terminar:" PATH_INPUT
	do
		if [ -z $PATH_INPUT ]; then
			break
		else
			$PATH_INPUT=$(echo $PATH_INPUT | sed 's:/*$::')
			verificarPath $PATH_INPUT
			if [ "$?" -eq 0 ]; then
				echo "Intente ingresar un path valido"
			else
				imprimirContenidoPath $PATH_INPUT
				LISTA_PATH+=($PATH_INPUT)
				imprimirListaPath 
			fi
		fi
	done < "${1:-/dev/stdin}"
}
leerNombrePase(){
	read -p "Ingrese el nombre del pase, ex:OC3213, SO2345:" NOMBRE_PASE 
}
leerDirectorioBkp(){
	clear >$(tty)
	leerNombrePase
	while read -p "Ingrese el PATH del directorio de los backup:" PATH_BACKUP
	do
		PATH_BACKUP=$(echo $PATH_BACKUP | sed 's:/*$::')
		verificarPath $PATH_BACKUP
		if [ "$?" -eq 0 ]; then
			echo "Intente ingresar un path valido"
		else
			PATH_BACKUP_ACTUAL="${PATH_BACKUP}/${NOMBRE_PASE}.tar.gz"
			break
		fi
	done < "${1:-/dev/stdin}"
}
#########################################################################
#Modulo Inicial, main del script
imprimir_menu(){
	echo "Backup y recover"	
	echo "Ingrese el numero de la accion que desea realizar"
	echo "1-Backup"
	echo "2-Recover"
	echo "3-Salir"
}
menu(){
	leerPaths
	leerDirectorioBkp
	imprimir_menu
	while read OPCION; do
		if [ "${OPCION}" -eq 1 ]; then
			crear_backup
			imprimir_menu

		elif [ "${OPCION}" -eq 2 ]; then 
			echo "2...${OPCION}"
			recoverBkp
			imprimir_menu

		elif [ "${OPCION}" -eq 3 ]; then 
			exit 0
		else
			clear >$(tty)
			imprimir_menu
			echo "ERROR!!! Opcion incorrecta vuelva a intentarlo!!!"
		fi
	done
}
###########################################################################
LISTA_PATH=()
NOMBRE_PASE="Contendra el nombre del pase"
PATH_BACKUP="Contendra el el path del directorio de backups"
PATH_BACKUP_ACTUAL="Contendra el path del backup actual"
#leerPaths
menu
echo "fin"
imprimirListaPath "${listaPath[@]}"

