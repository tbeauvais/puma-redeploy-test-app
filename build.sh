#!/bin/ash

git clone --depth 1 https://github.com/$REPO_NAME.git

cd sinatra-api-base

bundle config timeout 30
bundle config deployment 'true'
bundle config retry 4

echo 'repo !!!!'
echo "$REPO_NAME"

rake build_archive['sample_app']

cp ./pkg/sample_app_*.zip /build/pkg/
