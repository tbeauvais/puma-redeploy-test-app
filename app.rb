# frozen_string_literal: true

require 'sinatra'
require 'json'

require 'pry' if %w[development test].include? ENV['RACK_ENV']

# app for testing puma reloader
class App < Sinatra::Base
  get '/ping' do
    JSON.generate({ message: 'pong' })
  end

  # new endpoint for testing redeploy
  get '/ding' do
    JSON.generate({ message: 'dong' })
  end
end
