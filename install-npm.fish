#!/usr/bin/env fish

if not test (which npm)
	echo "El paquete npm no está instalando. Omitiendo el proceso..."
	return
end

set packagetxt $HOME/Sync/Scripts/Sistema/conf/packages.txt
set npm_g_dir "/usr/local/lib/node_modules" "/usr/lib/node_modules/"

function npm-preinstall \
-d "Preinstall"
	sudo curl -fsSL https://deb.nodesource.com/setup_20.x \
	| sudo -E bash - && sudo apt install nodejs -y
	sudo npm install -g corepack
	corepack enable
	sudo yarn
	sudo npm install -g typescript
end

function npm-install \
-d "Install"
	# npm-preinstall
	xargs -a \
	(awk '($1 == ".np") {print $NF}' $packagetxt | psub) -r -- \
	sudo npm install -g
end

function npm-uninstall \
-d "Uninstall"
	xargs -a \
	(awk '($1 == "#" && $2 == ".np") {print $NF}' $packagetxt | psub) -r -- \
	sudo npm uninstall -g
end

function npm-update \
-d "Update"
	if not test -d "$npm_g_dir[1]"; npm-install; return; end
	xargs -a \
	(awk '($1 == ".np") {print $NF}' $packagetxt | psub) -r -- \
	sudo npm update -g
	npm-uninstall
end

function npm-purge \
-d "Purge"
	for folder in "$npm_g_dir[1]" "$HOME/node_modules" "$HOME/.npm"
		sudo rm -r "$folder"
	end
end

	npm-update
#	npm-purge
