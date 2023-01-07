# frozen_string_literal: true

require 'sinatra'
require 'sinatra/contrib'

require 'rack/test'

require File.join(File.dirname(__FILE__), '..', 'app')

# setup test environment
set :environment, :test
set :run, false
set :raise_errors, true

def app
  App
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
end
