#!/bin/bash
 
# shellcheck disable=SC1090,SC1091

set -o errexit
set -o nounset
# set -o pipefail
# set -o xtrace # Uncomment this line for debugging purposes

# Load MediaWiki environment
. /opt/bitnami/scripts/mediawiki-env.sh

# Load library with logging functions
. /opt/bitnami/scripts/liblog.sh

# Create a init bot user
cd /opt/bitnami/mediawiki
BOT_PWD=$(cat /dev/urandom | tr -dc '[:digit:]' | fold -w ${1:-32} | head -n 1)
BOT_INFO=$(php maintenance/createBotPassword.php ${MEDIAWIKI_USERNAME^} $BOT_PWD --appid initbot --grants basic,highvolume,createeditmovepage,delete,uploadeditmovefile,editsiteconfig)
info $BOT_INFO
