#!/usr/bin/env fish

argparse -- $argv

# Descarga e instala la última versión de un proyecto de GitHub, según un patrón.

set repository "$argv[1]"; set project "$argv[2]"
set pattern "$argv[3]"; set antipattern "$argv[4]"
if not test "$repository" || not test "$project"
	echo "Repositorio o proyecto no especificado."
	return
end
if not test $pattern; set pattern 'amd64.deb'; end

set link (get-latest-url-gh "$repository" "$project" "$pattern" "$antipattern")
if not test "$link"
	echo "Ningún enlace encontrado para $repository/$project."
	get-latest-url-gh "$repository" "$project" | head
	return
end
if test "$link[2]"
	echo "Más de un enlace encontrado para $repository/$project."
	return
end
if not test \
(compare-version-gh "$repository" "$project")
	echo "No hay una nueva versión disponible para $repository/$project."
	return
end
set file (echo "$link" | rev | cut -d "/" -f 1 | rev)

if test (echo $pattern | grep '.deb')
	wget "$link" && sudo dpkg -i ./"$file" && rm ./"$file"
else if test (echo "$pattern" | grep '.tar.')
	set dir "$repository/$project"
	mkdir -p "$dir" && wget "$link" && tar -xf "$file" -C "$dir"
	if test -d "$dir" && test (find "$dir" -iname "*.deb")[2]
		echo "Más de un archivo binario encontrado."
	else if test -d "$dir" && test (find "$dir" -iname "*.deb")
		sudo dpkg -i (find "$dir" -iname "*.deb") && rm -r "$dir"
	else
		echo "Ningún archivo binario encontrado."
	end
	rm ./"$file"
else
	echo "No se reconoce el caso:
	$file"
end
