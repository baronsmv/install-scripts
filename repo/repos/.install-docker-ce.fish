#!/usr/bin/env fish

set os (lsb_release -is 2> /dev/null)
set os_lower (echo "$os" | tr '[:upper:]' '[:lower:]')
set os_codename (lsb_release -cs 2> /dev/null)
set os_version (lsb_release -rs 2> /dev/null | tr '[:upper:]' '[:lower:]')

install-repo \
docker \
"https://download.docker.com/linux/$os_lower/gpg" \
"https://download.docker.com/linux/$os_lower $os_codename stable"
