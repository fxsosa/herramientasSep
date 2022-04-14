#!/bin/bash

verificarPath(){
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
	echo "El directorio contiene lo siguiente:"
	sudo ls -ltrh $1
}
imprimirListaPath(){
	listaPath=("$@")
	echo "La lista de paths actuales es la siguiente:"
	printf '%s\n' "${listaPath[@]}"
}
leerPaths(){
	while read -p "ingrese el path o Intro para terminar:" path
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
	done < "${1:-/dev/stdin}"
}
listaPath=()
leerPaths
echo "fin"
imprimirListaPath "${listaPath[@]}"

