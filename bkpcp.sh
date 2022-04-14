listaPath=("$@")
read -p "Ingrese el nombre del pase, ex:OC3213, SO2345" nombrePase
read -p "Ingrese el path del directorio de los backup(ubicado en el directorio padre del origininal, ex: original->/var/www, bkp /var/backup)" pathBackup

# TODO validar el path y la forma de nombrePase
pathBackupActual="${pathBackup}/${nombrePase}"
mkdir "${pathBackupActual}"

for path in "${listaPath[@]}"
do
	echo "$path"
done


