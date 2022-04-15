#!/bin/bash
crear_backup(){
	mkdir "${PATH_BACKUP_ACTUAL}"
	sudo cp -a ${LISTA_PATH[@]} -t ${PATH_BACKUP_ACTUAL}
}
crear_recover(){
	PATH_RECOVER="${PATH_BACKUP_ACTUAL}recoverPath"
	touch "${PATH_RECOVER}"
	for DIRECTORIO in "${LISTA_PATH[@]}"
	do
		NOMBRE_ARCHIVO=$(basename "${DIRECTORIO}")
		PATH_BACKUP_ARCHIVO="${PATH_BACKUP_ACTUAL}${NOMBRE_ARCHIVO}"
		PATH_DESTINO_ORIGINAL=$(dirname "${DIRECTORIO}")
		echo "${PATH_BACKUP_ARCHIVO}:${PATH_DESTINO_ORIGINAL}" >> "${PATH_RECOVER}"
	done
}

LISTA_PATH=("$@")

read -p "Ingrese el nombre del pase, ex:OC3213, SO2345:" NOMBRE_PASE
read -p "Ingrese el PATH del directorio de los backup:" PATH_BACKUP

# TODO validar el PATH y la forma de NOMBRE_PASE
PATH_BACKUP_ACTUAL="${PATH_BACKUP}/${NOMBRE_PASE}/"

crear_backup
crear_recover

