#!/usr/bin/env fish

if not test (which apt)
	echo "El paquete apt no está instalando. Omitiendo el proceso..."
	return
end

set packagetxt $HOME/Sync/Scripts/Sistema/conf/packages.txt

# Update
sudo apt-get update
sudo apt-get upgrade -y

# Remove
xargs -a \
(awk '($1 == "#" && $2 !~ /.fp|.fb|.pi|.np/) {print $NF}' $packagetxt | psub) \
-r -- sudo apt-get remove

# Autoremove
sudo apt-get autoremove

# Install (stable)
xargs -a \
(awk '($1 !~ /#|~|.bp|.fp|.fb|.pi|.np|.ot/) {print $NF}' $packagetxt | psub) \
-r -- sudo apt-get install

# Install (stable-backports)
xargs -a \
(awk '($1 == ".bp") {print $NF}' $packagetxt | psub) -r -- \
sudo apt-get -t bookworm-backports install
