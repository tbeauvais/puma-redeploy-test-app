#!/bin/ash

# load_archive is a puma-redeploy cli tool to load the archive prior to starting puma
load_archive /app "$WATCH_FILE"

bundle exec puma -C config/puma.rb
