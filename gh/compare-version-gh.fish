#!/usr/bin/env fish

argparse -- $argv

set repository $argv[1]; set project $argv[2]
if not test "$repository" || not test "$project"
	echo "Repositorio o proyecto no especificado."
	return
end

set versiontxt \
"$HOME/Sync/Scripts/Sistema/bin/install/gh/.versions/"(hostname)"/$repository-$project.txt"
mkdir -p (dirname "$versiontxt")

if test -f "$versiontxt"
	if not test \
	(cat "$versiontxt") = (get-latest-version-gh "$repository" "$project")
		echo "Hay una nueva versión disponible"
		get-latest-version-gh "$repository" "$project" > "$versiontxt"
	end
else
	get-latest-version-gh "$repository" "$project" > "$versiontxt"
	echo "Nueva versión registrada en el archivo correspondiente."
end
