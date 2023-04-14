#!/bin/ash

# Load the archive before starting the app
load_archive /app /app/pkg/watch.me

export GEM_HOME=/app/vendor/bundle/ruby/3.2.0

export PATH=$PATH:/app/vendor/bundle/ruby/3.2.0/bin

bundle exec puma -C config/puma.rb
