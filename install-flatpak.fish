#!/usr/bin/env fish

if not test (which flatpak)
	echo "El paquete flatpak no está instalando. Omitiendo el proceso..."
	return
end

set packagetxt $HOME/Sync/Scripts/Sistema/conf/packages.txt

# Update
flatpak update -y

# Remove
xargs -a \
(awk '($1 == "#" && $2 ~ /.fp|.fb/) {print $NF}' $packagetxt | psub) -r -- \
flatpak remove

# Autoremove
flatpak uninstall --unused

# Install (Flathub)
xargs -a \
(awk '($1 == ".fp") {print $NF}' $packagetxt | psub) -r -- \
flatpak install flathub

# Install (Flathub Beta)
xargs -a \
(awk '($1 == ".fb") {print $NF}' $packagetxt | psub) -r -- \
flatpak install flathub-beta
