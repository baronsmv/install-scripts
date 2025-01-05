#!/usr/bin/env fish

argparse -- $argv

set link "$argv[1]"
set file (echo "$link" | rev | cut -d "/" -f 1 | rev)

wget "$link" && sudo dpkg -i ./"$file" && rm ./"$file"
