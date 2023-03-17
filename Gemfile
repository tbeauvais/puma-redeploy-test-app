# frozen_string_literal: true

source 'https://rubygems.org'

gem 'puma', '~> 6.1', '>= 6.1.1'
gem 'puma-redeploy', git: 'https://github.com/tbeauvais/puma-redeploy.git' # , branch: 'deploy_archive'
gem 'rubocop', '~> 1.42'
gem 'sinatra', '~> 3.0', '>= 3.0.5'

group :test do
  gem 'rack-test', '~> 1.1'
  gem 'rspec', '~> 3.9'
end

group :development, :test do
  gem 'pry', '~> 0.12.2'
  gem 'rake', '~> 13.0', '>= 13.0.6'
end
