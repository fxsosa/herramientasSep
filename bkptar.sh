#!/bin/bash
crear_backup(){
	sudo tar -Pzcvf ${PATH_BACKUP_ACTUAL} ${LISTA_PATH[@]} 
}

LISTA_PATH=("$@")

read -p "Ingrese el nombre del pase, ex:OC3213, SO2345:" NOMBRE_PASE
read -p "Ingrese el PATH del directorio de los backup:" PATH_BACKUP

# TODO validar el PATH y la forma de NOMBRE_PASE
PATH_BACKUP_ACTUAL="${PATH_BACKUP}/${NOMBRE_PASE}.tar.gz"
crear_backup
