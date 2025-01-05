#!/usr/bin/env fish

argparse -- $argv

set repository $argv[1]; set project $argv[2]
if not test "$repository" || not test "$project"
	echo "Repositorio o proyecto no especificado."
	return
end

curl -s https://api.github.com/repos/"$repository"/"$project"/releases \
| grep -Fiv "Continuous" \
| grep '^    "tag_name":' \
| head -n 1 \
| rev \
| cut -d \" -f 2 \
| rev \
| sed 's/[a-z,A-Z, ,(,)]//g'
