#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

function dynamic_hosts() {
    app_hosts=$( \
        yc compute instance list --format json \
        | jq 'map(select(.name == "reddit-app-stage")) | .[0].network_interfaces[0].primary_v4_address.one_to_one_nat.address'\
    )
    db_hosts=$( \
        yc compute instance list --format json \
        | jq 'map(select(.name == "reddit-db-stage")) | .[0].network_interfaces[0].primary_v4_address.one_to_one_nat.address'\
    )
    list_hosts "$app_hosts" "$db_hosts"
}

function static_hosts() {
    list_hosts '"62.84.126.90"' '"51.250.9.48"'
}

function list_hosts() {
    printf '{
    "app": {
        "hosts": [%s]
    },
    "db": {
        "hosts": [%s]
    },
    "_meta": {
        "hostvars": {}
    }
}
' "$1" "$2"
}

case ${1-} in
    --list)
        static_hosts;;
    *)
        echo "Usage: ./inventory.sh --list"
esac
