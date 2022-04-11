#!/bin/bash
verificarPath(){
	if [[ ! -f $1 && ! -d $1 ]]; then
	    echo "$1 -- no es un archivo o directorio valido"
	fi
}
leerPath(){
	while read path
	do
		verificarPath $path
	done < "${1:-/dev/stdin}"
}
leerPath
