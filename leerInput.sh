#!/bin/bash

verificarPath(){

	if [[ ! -f $1 && ! -d $1 ]]; then
		echo "$1 -- no es un archivo o directorio valido"
		return 0
	else
		return 1
	fi
}
imprimirContenidoPath(){
	echo "El directorio contiene lo siguiente:"
	sudo ls -ltrh $1
}
imprimirListaPath(){
	listaPath=("$@")
	echo "La lista de paths actuales es la siguiente:"
	printf '%s\n' "${listaPath[@]}"
}
leerPaths(){
	echo "Ingrese el path o INTRO para terminar"
	while read path
	do
		if [ -z $path ]; then
			break
		else
			path=$(echo $path | sed 's:/*$::')
			verificarPath $path
			if [ "$?" -eq 0 ]; then
				echo "Intente ingresar un path valido"
			else
				imprimirContenidoPath $path
				listaPath+=($path)
				imprimirListaPath "${listaPath[@]}"
			fi
		fi
		echo "Ingrese el path"
	done < "${1:-/dev/stdin}"
}
listaPath=()
leerPaths
echo "fin"
imprimirListaPath "${listaPath[@]}"

