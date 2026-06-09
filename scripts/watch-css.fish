#!/usr/bin/env fish
#
# This script is basically a live version of build-css.fish
# You start it once in an open terminal and it tracks your changes to your src/css files
# and automatically builds a new custom.css file each time

set script_dir (dirname (status --current-filename))
set project_dir (dirname $script_dir)

echo "Watching CSS-Files in: $project_dir/src/css"
echo "Changes are being built in dist/custom.css automatically."
echo "Deploy is manual."
echo "Ctrl+c to end."

$script_dir/build-css.fish

while true
    inotifywait -e modify,create,delete,move "$project_dir/src/css" >/dev/null 2>&1

    echo "Change noticed. New CSS was built."
    $script_dir/build-css.fish
end
