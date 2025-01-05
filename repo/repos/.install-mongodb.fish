#!/usr/bin/env fish

set os (lsb_release -is 2> /dev/null)
set os_lower (echo "$os" | tr '[:upper:]' '[:lower:]')
set os_arch (dpkg --print-architecture)
set os_codename (lsb_release -cs 2> /dev/null)
set os_version (lsb_release -rs 2> /dev/null | tr '[:upper:]' '[:lower:]')

install-repo \
mongodb \
"https://www.mongodb.org/static/pgp/server-8.0.asc" \
"http://repo.mongodb.org/apt/$os_lower $os_codename/mongodb-org/8.0 main"
