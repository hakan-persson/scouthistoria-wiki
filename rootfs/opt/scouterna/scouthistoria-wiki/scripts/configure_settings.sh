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

# Update LocalSettings.php file
cat /opt/scouterna/scouthistoria-wiki/config/extension-settings.txt >> "$MEDIAWIKI_CONF_FILE"

# Update DB with Semantic stuff
cd /opt/bitnami/mediawiki/extensions/SemanticMediaWiki/maintenance
MW_INSTALL_PATH="/opt/bitnami/mediawiki" php setupStore.php
