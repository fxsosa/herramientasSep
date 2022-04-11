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
	ls -ltrh $1
}
imprimirListaPath(){
	echo "La lista de paths actuales es la siguiente:"
	printf '%s\n' "${1[@]}"
}
leerPath(){
	echo "Ingrese el path"
	listaPath=()
	while read path
	do
		if [ -z $path ]; then
			break
		else
			verificarPath $path
			if [ "$?" -eq 0 ]; then
				echo "Intente ingresar un path valido"
			else
				imprimirContenidoPath $path
				listaPath+=($path)
				imprimirListaPath $listaPath
	printf '%s\n' "${listaPath[@]}"
			fi
		fi
		echo "Ingrese el path"
	done < "${1:-/dev/stdin}"
	echo fin
}

leerPath
