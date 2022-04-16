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
leerPath(){
	echo ${TEXTO_INPUT}
	while read PATH_INPUT
	do
		PATH_INPUT=$(echo $PATH_INPUT | sed 's:/*$::')
		verificarPath $PATH_BACKUP
		if [ "$?" -eq 0 ]; then
			echo "Intente ingresar un path valido"
			echo ${TEXTO_INPUT}
		else
			return $PATH_INPUT
		fi
	done < "${1:-/dev/stdin}"

}
TEXTO_INPUT="Ingresar path original:"
leerPath
PATH_ORIGINAL=$?
echo "${PATH_ORIGINAL}"


#Buscar todos los archivos en el directorio actual e imprimir en el archivo "permisos:userPropietario:grupo:nombreArchivo"
#find -depth -printf '%m:%u:%g:%p\0' >archivoPermisos.txt

#while IFS=: read -r -d '' mod user group file; do
#  chown -- "$user:$group" "$file"
#  chmod "$mod" "$file"
#done <archivoPermisos.txt 
