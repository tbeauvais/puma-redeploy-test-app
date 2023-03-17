#!/bin/ash


unzip -o -K /app/pkg/my_application_0.0.1.zip -d /app

ls -la

bundle exec puma -C config/puma.rb

