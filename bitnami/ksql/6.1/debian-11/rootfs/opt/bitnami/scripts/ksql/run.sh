#!/bin/bash

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # Uncomment this line for debugging purpose

# Load libraries
. /opt/bitnami/scripts/liblog.sh
. /opt/bitnami/scripts/libos.sh

# Load KSQL environment variables
. /opt/bitnami/scripts/ksql-env.sh

info "** Starting KSQL **"

__run_cmd="${KSQL_BIN_DIR}/ksql-server-start"
__run_flags=("$KSQL_CONF_FILE" "$@")

if am_i_root; then
    exec gosu "$KSQL_DAEMON_USER" "$__run_cmd" "${__run_flags[@]}"
else
    exec "$__run_cmd" "${__run_flags[@]}"
fi
