#! /bin/bash
set -Eeuo pipefail

BASE_DIR=files
CURRENT_DIR=${BASE_DIR}/current
NEXT_DIR=${BASE_DIR}/next
CONFIG_FILE=etc/otel-collector-config.yaml

function clean_up {
  CODE=$?
  rm -rf ${NEXT_DIR}
  exit ${CODE}
}
trap clean_up EXIT

./fetcher --config fetcher_config.yml -v 2 --logtostderr ${CONFIG_FILE}

if cmp -s ${CURRENT_DIR}/${CONFIG_FILE} ${NEXT_DIR}/${CONFIG_FILE}; then
  echo "unchanged"
  exit 0
fi
if [ $? = 2 ]; then
  echo "an error occurred" 1>&2 
  exit 1
fi
echo "changed"
mv -f ${NEXT_DIR}/${CONFIG_FILE} ${CURRENT_DIR}/${CONFIG_FILE}
docker-compose restart otel-collector
