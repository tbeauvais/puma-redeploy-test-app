#!/bin/ash

# TODO: This is a temporary implementation which is used when the app first comes up to pull the current app version.
# TODO: We need to have the puma-redeploy gem know how to do this based on the configured handler (e.g. file vs S3)
ARCHIVE_FILE=$(cat "${WATCH_FILE}")

unzip -o -K "${ARCHIVE_FILE}" -d /app

export GEM_HOME=/app/vendor/bundle/ruby/3.2.0

export PATH=$PATH:/app/vendor/bundle/ruby/3.2.0/bin

bundle exec puma -C config/puma.rb
