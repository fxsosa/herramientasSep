read -p "Ingrese el nombre del pase, ex:OC3213, SO2345:" NOMBRE_PASE
read -p "Ingrese el PATH del directorio de los backup:" PATH_BACKUP
PATH_BACKUP_ACTUAL="${PATH_BACKUP}/${NOMBRE_PASE}/"
PATH_BACKUP_ACTUAL_RECOVER="${PATH_BACKUP}/${NOMBRE_PASE}/recoverPath"
# TODO corroborar si existe el path
while IFS=: read -r -d '\n' SOURCE DESTINATION; do
	sudo cp -a "${SOURCE} "${DESTINATION}"
done<$PATH_BACKUP_ACTUAL_RECOVER

