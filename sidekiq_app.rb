# frozen_string_literal: true

require 'sidekiq'
require_relative 'lib/workers/sample_worker'

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://host.docker.internal:6379' }
end
