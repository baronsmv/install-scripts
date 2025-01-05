#!/usr/bin/env fish

install-repo \
pgadmin \
'https://www.pgadmin.org/static/packages_pgadmin_org.pub' \
'https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/'(lsb_release -cs 2> /dev/null)' pgadmin4 main'

# Desktop mode only:	sudo apt install pgadmin4-desktop
# Web mode only:		sudo apt install pgadmin4-web
# Configure the webserver, if you installed pgadmin4-web:
# sudo /usr/pgadmin4/bin/setup-web.sh
