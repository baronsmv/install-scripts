#!/usr/bin/env fish

argparse -- $argv

# Descarga e instala la última versión de un proyecto de GitHub, según un patrón.

set repository $argv[1]; set project $argv[2]
set pattern $argv[3]; set antipattern $argv[4]
if not test "$repository" || not test "$project"
	echo "Repositorio o proyecto no especificado."
	return
end
if not test $pattern; set pattern 'amd64'; end

set link (get-latest-url-gh "$repository" "$project" "$pattern" "$antipattern")
if not test "$link"
	echo "Ningún enlace encontrado."; return
end
if test "$link[2]"
	echo "Más de un enlace encontrado."; return
end
if not test \
(compare-version-gh "$repository" "$project")
	echo "No hay una nueva versión disponible para $project."; return
end
set file (echo "$link" | rev | cut -d "/" -f 1 | rev)

cd "$HOME/.bin"
wget "$link"
mv -f "./$file" "./$project"
chmod +x "./$project"
