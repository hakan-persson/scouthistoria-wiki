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

# Set some configuration
/opt/scouterna/scouthistoria-wiki/scripts/configure_settings.sh

# Configure extensions
/opt/scouterna/scouthistoria-wiki/scripts/configure_extensions.sh

# Create an init bot
/opt/scouterna/scouthistoria-wiki/scripts/create_bot.sh
