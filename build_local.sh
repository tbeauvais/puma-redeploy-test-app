#!/bin/ash

bundle config timeout 30
bundle config deployment 'true'
bundle config retry 4

cd /app

# shellcheck disable=SC2016
rake build_archive["${ARCHIVE_NAME}"]

cp ./pkg/"${ARCHIVE_NAME}"_*.zip /build/pkg/
