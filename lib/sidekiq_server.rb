# frozen_string_literal: true

require 'sidekiq'
require_relative 'workers/sample_worker'

Sidekiq.configure_server do |config|
  host = ENV.fetch('REDIS_HOST', 'localhost')
  port = ENV.fetch('REDIS_PORT', '6379')
  config.redis = { url: "redis://#{host}:#{port}" }
end
