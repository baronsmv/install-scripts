#!/usr/bin/env fish

set packagedir "$HOME/Sync/Scripts/Sistema/bin/install/direct/packages/"

for file in (find "$packagedir" -iname "*.fish" -a -not -iname ".*" | sort)
	fish "$file"
end
