#!/usr/bin/env fish

argparse -- $argv

set repository $argv[1]; set project $argv[2]
set pattern $argv[3]; set antipattern $argv[4]
if not test "$repository" || not test "$project"
	echo "Repositorio o proyecto no especificado."
	return
end
if not test $pattern; set pattern 'amd64.deb'; end

if test \
(curl -s https://api.github.com/repos/"$repository"/"$project"/releases/latest \
| grep browser_download_url)[1]
	set key "/latest"
else
	set key ""
end

curl -s https://api.github.com/repos/"$repository"/"$project"/releases"$key" \
| grep -F (get-latest-version-gh "$repository" "$project") \
| grep browser_download_url \
| grep -F "$pattern" \
| grep (if test "$antipattern"; echo "-Fv"; end) "$antipattern" \
| head -n 1 \
| rev \
| cut -d'"' -f 2 \
| rev
