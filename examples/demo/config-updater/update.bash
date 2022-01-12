#! /bin/bash
set -Eeuo pipefail

DELAY=30
if [ $# -eq 1 ]; then
  DELAY=${1}
fi

while ./update_once.bash; do
  sleep ${DELAY}
done
