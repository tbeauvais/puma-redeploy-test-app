# frozen_string_literal: true

require 'sinatra'
require 'json'

require 'pry' if %w[development test].include? ENV['RACK_ENV']

# app for testing puma reloader
class App < Sinatra::Base
  VERSION = File.read('VERSION').strip

  get '/ping' do
    JSON.generate({ message: 'pong' })
  end

  get '/version' do
    JSON.generate({ version: VERSION })
  end

  # new endpoint for testing redeploy
  # get '/ding' do
  #   JSON.generate({ message: 'dong' })
  # end
end
