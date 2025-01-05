#!/usr/bin/env fish

argparse -- $argv

set repository $argv[1]; set project $argv[2]; set binary $argv[3]
set configure $argv[4]; set install $argv[5]
if not test "$repository" || not test "$project" || not test "$binary"
	echo "Repositorio, proyecto o binario no especificado."
	return
end

if not test \
(compare-version-gh "$repository" "$project")
	echo "No hay una nueva versión disponible para $project."; return
end

git clone "https://github.com/$repository/$project"
cd "$project" || return
if not test -f ./"$binary.sh"
	echo "No se encontró el binario especificado."
	return
end
./"$binary.sh"
if test "$configure"; ./"$configure"; else;	./configure && make; end
if test "$install"; ./"$install"; else; sudo make install; end

cd
git trash "$project"
