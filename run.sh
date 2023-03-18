#!/bin/ash


unzip -o -K /app/pkg/my_application_0.0.1.zip -d /app

ls -la

export GEM_HOME=/app/vendor/bundle/ruby/3.2.0

export PATH=$PATH:/app/vendor/bundle/ruby/3.2.0/bin

bundle exec puma -C config/puma.rb

