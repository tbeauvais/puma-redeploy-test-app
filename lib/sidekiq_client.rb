# frozen_string_literal: true

require 'sidekiq'

Sidekiq.configure_client do |config|
  host = ENV.fetch('REDIS_HOST', 'localhost')
  port = ENV.fetch('REDIS_PORT', '6379')
  config.redis = { url: "redis://#{host}:#{port}" }
end
