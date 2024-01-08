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

## Update LocalSettings.php file with some settings
cat /opt/scouterna/scouthistoria-wiki/config/misc-settings.txt >> "$MEDIAWIKI_CONF_FILE"

## Update DB with Semantic stuff
# cd /opt/bitnami/mediawiki/extensions/SemanticMediaWiki/maintenance
# MW_INSTALL_PATH="/opt/bitnami/mediawiki" php setupStore.php

# Configure logo

## Update LocalSettings.php file
cat <<EOF >> "$MEDIAWIKI_CONF_FILE"
# Logo settings
# \$wgLogo = "/skins/Vector/resources/src/logo.png";
# \$wgFavicon = "/skins/Vector/resources/src/favicon.ico";
# \$wgFooterIcons['poweredby']['scoutwiki'] = array(
#     'src' => "/skins/Vector/resources/src/poweredby_scoutwiki.png",
#     'url' => "https://scoutwiki.scouterna.se/",
#     'alt' => "ScoutWiki",
# );
\$wgLogos = [
        '1x' => "$wgResourceBasePath/images/sams.png",
        'icon' => "$wgResourceBasePath/images/sams.png",
];
EOF

## Copy logo to the right place
cp /opt/scouterna/scouthistoria-wiki/images/sams.png $MEDIAWIKI_BASE_DIR/images/sams.png

# Configure extensions

# Update LocalSettings.php file
cat /opt/scouterna/scouthistoria-wiki/config/extension-settings.txt >> "$MEDIAWIKI_CONF_FILE"

# Create an init bot
/opt/scouterna/scouthistoria-wiki/scripts/create_bot.sh
