#!/bin/ash

git clone --depth 1 https://github.com/$REPO_NAME.git

cd sinatra-api-base

bundle config timeout 30
bundle config deployment 'true'
bundle config retry 4

echo 'repo !!!!'
echo "$REPO_NAME"

rake build_archive

cp ./pkg/my_application_0.0.1.zip /build/pkg/my_application_0.0.1.zip
