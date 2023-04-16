#!/bin/ash

# load_archive is a puma-redeploy cli tool to load an archive
# Load the archive before starting the app
load_archive /app "$WATCH_FILE"

# Load gems from vendor/bundle
export GEM_HOME=/app/vendor/bundle/ruby/3.2.0
export PATH=$PATH:/app/vendor/bundle/ruby/3.2.0/bin

bundle exec puma -C config/puma.rb
