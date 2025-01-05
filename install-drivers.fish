#!/usr/bin/env fish

set dirdrivers $HOME/Sync/Scripts/Sistema/conf/drivers

# Epson Perfection V550 (64-bits)
# https://download2.ebz.epson.net/iscan/plugin/perfection-v550/deb/x64/iscan-perfection-v550-bundle-2.30.4.x64.deb.tar.gz
sudo bash $dirdrivers/iscan-perfection-v550-bundle-2.30.4.x64.deb/install-iscan.sh

# Epson M105 Series (64-bits)
# http://download.ebz.epson.net/dsc/du/02/DriverDownloadInfo.do?LG2=ES&CN2=&DSCMI=20908&DSCCHK=d170e166d1aaf2cee77d35a0d3141c1ac358a882
sudo dpkg -i $dirdrivers/lsb-compat_9.20161125_amd64.deb && \
sudo dpkg -i $dirdrivers/epson-inkjet-printer-201215w_1.0.0-1lsb3.2_amd64.deb
