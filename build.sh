#!/bin/ash

echo 'branch !!!!'
echo "$BRANCH_NAME"


git clone --depth 1 -b $BRANCH_NAME --single-branch https://github.com/$REPO_NAME.git

cd sinatra-api-base

bundle config timeout 30
bundle config deployment 'true'
bundle config retry 4

echo 'repo !!!!'
echo "$REPO_NAME"

rake build_archive['sample_app']

cp ./pkg/sample_app_*.zip /build/pkg/
