#! /bin/bash
set -Eeuo pipefail

function clean_up {
  CODE=$?
  docker-compose down
  exit ${CODE}
}
trap clean_up EXIT

( cd config-updater && ./initial_fetch.bash )
HOSTNAME=${HOSTNAME} docker-compose up -d
( cd config-updater && ./update.bash )

