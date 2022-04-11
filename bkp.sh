#!/bin/bash
verificarPath(){
	if [[ ! -f $1 && ! -d $1 ]]; then
		echo "$1 -- no es un archivo o directorio valido"
		return 0
	else
		return 1
	fi
}
leerPath(){
	while read path
	do
		if [ -z $path ]; then
			break
		else
			verificarPath $path
			if [ "$?" -eq 0 ]; then
				echo "condicion no verificada"
			else
				echo "condicion verificada"
			fi

		fi
	done < "${1:-/dev/stdin}"
	echo fin
}
leerPath
