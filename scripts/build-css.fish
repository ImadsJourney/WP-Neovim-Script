#!/usr/bin/env fish

# this file manually creates your whole custom.css file that contains your css snippets
# by typing ./scripts/build-css.fish in the terminal
# You need to stay in your root directory and scripts dir needs to be in your root dir
# This script is fundamental for watch-css.fish
# Don't forget to enable your execute right with chmod +x build-css.fish

set plugin_dir (dirname (dirname (status --current-filename)))

mkdir -p "$plugin_dir/dist"

cat "$plugin_dir"/src/css/*.css >"$plugin_dir/dist/custom.css"

echo "CSS was built: dist/custom.css"
