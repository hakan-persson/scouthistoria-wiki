#!/bin/bash
 
# shellcheck disable=SC1090,SC1091

set -o errexit
set -o nounset
# set -o pipefail
# set -o xtrace # Uncomment this line for debugging purposes

# Load library with logging functions
. /opt/bitnami/scripts/liblog.sh

info "** Starting scouthistoria wiki setup **"
/opt/scouterna/scouthistoria-wiki/config/setup.sh
info "** scouthistoria wiki setup finished! **"
