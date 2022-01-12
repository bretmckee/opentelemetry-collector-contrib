#! /bin/bash
set -Eeuo pipefail

BASE_DIR=files
CURRENT_DIR=${BASE_DIR}/current
NEXT_DIR=${BASE_DIR}/next
CONFIG_FILE=etc/otel-collector-config.yaml

rm -rf ${BASE_DIR}
./fetcher --config fetcher_config.yml -v 2 --logtostderr ${CONFIG_FILE}
mv ${NEXT_DIR} ${CURRENT_DIR}
