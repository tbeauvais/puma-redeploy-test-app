# frozen_string_literal: true

require 'json'
require 'sidekiq'
require_relative 'lib/workers/sample_worker'
require 'sinatra'

# app for testing puma reloader
class App < Sinatra::Base
  VERSION = File.read('VERSION').strip

  get '/ping' do
    JSON.generate({ message: 'pong' })
  end

  get '/version' do
    JSON.generate({ version: VERSION })
  end

  get '/worker' do
    SampleWorker.perform_async
  end

  # new endpoint for testing redeploy
  # get '/ding' do
  #   JSON.generate({ message: 'dong' })
  # end
end
