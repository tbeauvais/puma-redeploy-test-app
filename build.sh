#!/bin/ash

git clone --depth 1 -b "${BRANCH_NAME}" --single-branch https://github.com/"$REPO_NAME".git "${ARCHIVE_NAME}"

# shellcheck disable=SC2164
cd "${ARCHIVE_NAME}"

bundle config timeout 30
bundle config deployment 'true'
bundle config retry 4

echo "repo !!!! ${REPO_NAME}"

# shellcheck disable=SC2016
rake build_archive["${ARCHIVE_NAME}"]

cp ./pkg/"${ARCHIVE_NAME}"_*.zip /build/pkg/
