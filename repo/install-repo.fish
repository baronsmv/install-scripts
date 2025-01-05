#!/usr/bin/env fish

argparse -- $argv

set reponame "$argv[1]"; set keyurl "$argv[2]"; set listdeb "$argv[3]"

if not test "$reponame" || not test "$keyurl" || not test "$listdeb"
	echo "Se necesitan tres argumentos. Cancelando la operación..."; return
end
set os_arch (dpkg --print-architecture)
set listdir "/etc/apt/sources.list.d"; set list "$listdir/$reponame.list"
set keydir "/etc/apt/keyrings"; set key "$keydir/$reponame.gpg"
if test -e "$list" && test -e "$key"; return; end

sudo mkdir -p "$listdir"; sudo mkdir -p "$keydir"
curl -fsSL "$keyurl" | gpg --dearmor | sudo tee "$key" > /dev/null
echo "deb [arch=$os_arch signed-by=$key] $listdeb" | sudo tee "$list" > /dev/null
sudo apt-get update && sudo apt-get upgrade
