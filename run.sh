#!/bin/ash

# archive-loader is a puma-redeploy cli tool to load the archive prior to starting puma
archive-loader -a /app -w "$WATCH_FILE"

bundle exec puma -C config/puma.rb
