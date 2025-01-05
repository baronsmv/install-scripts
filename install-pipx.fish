#!/usr/bin/env fish

if not test (which pipx)
	echo "El paquete pipx no está instalando. Omitiendo el proceso..."
	return
end

set packagetxt $HOME/Sync/Scripts/Sistema/conf/packages.txt

# Remove
for package in (awk '($1 == "#" && $2 == ".pi") {print $NF}' $packagetxt)
	pipx uninstall $package
end

# Install/Update
for package in (awk '($1 == ".pi") {print $NF}' $packagetxt)
	pipx install $package
	pipx upgrade $package
end
