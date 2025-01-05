#!/usr/bin/env fish

set os (lsb_release -is 2> /dev/null)
set os_lower (echo "$os" | tr '[:upper:]' '[:lower:]')
set os_arch (dpkg --print-architecture)
set os_codename (lsb_release -cs 2> /dev/null)
set os_version (lsb_release -rs 2> /dev/null | tr '[:upper:]' '[:lower:]')

install-repo \
fish \
"https://download.opensuse.org/repositories/shells:fish/$os""_$os_version/Release.key" \
"http://download.opensuse.org/repositories/shells:/fish/$os""_$os_version/ /"
