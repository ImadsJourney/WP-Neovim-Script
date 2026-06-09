#!/usr/bin/env fish
#
# This is the deployment script that sends my custom.css file over to my server via ftp
# so I can type ./scripts/deploy-css.fish + refresh the site and see the changes instantly

set plugin_dir (dirname (dirname (status --current-filename)))
set secrets_file "$plugin_dir/config/ftp-secrets.fish"
set local_css "$plugin_dir/dist/custom.css"

# You need to have your exact path that is on the FTP Section on your Server 
set remote_dir "/chez-maurice-restaurant.de/wp-content/plugins/chez-maurice-site/dist"

if not test -f "$secrets_file"
    echo "Error: Missing config/ftp-secrets.fish"
    echo "Create it with:"
    echo 'set -g ftp_host "HOST"'
    echo 'set -g ftp_user "USER_NAME"'
    echo 'set -g ftp_pass "YOUR_FTP_PASSWORD"'
    exit 1
end

source "$secrets_file"

if not set -q ftp_host; or not set -q ftp_user; or not set -q ftp_pass
    echo "Error: FTP credentials are incomplete."
    echo "Please check config/ftp-secrets.fish"
    exit 1
end

if not test -f "$local_css"
    echo "Error: dist/custom.css was not found."
    echo "Run ./scripts/build-css.fish first."
    exit 1
end

set ftp_pass (string trim -- "$ftp_pass")

echo "Local file: $local_css"
echo "Remote directory: $remote_dir"
echo "Uploading custom.css..."

# You need to have lftp installed
lftp -c "
set ftp:ssl-allow no;
open -u '$ftp_user','$ftp_pass' ftp://$ftp_host;
cd '$remote_dir';
put '$local_css' -o custom.css;
bye;
"

if test $status -eq 0
    echo "Deployment was successful."
else
    echo "Deployment failed."
    exit 1
end
