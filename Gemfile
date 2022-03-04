# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.4', '>= 6.1.4.2'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.4'
# Use Puma as the app server
gem 'puma', '~> 5.6.2'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'image_processing', '~> 1.12.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

# Authentication
gem 'knock', git: 'https://github.com/nsarno/knock', branch: 'master',
             ref: '9214cd027422df8dc31eb67c60032fbbf8fc100b'

# serialization
gem 'active_model_serializers', '~> 0.10.0'

# pagination
gem 'api-pagination', '~> 5.0.0'
gem 'kaminari'

# external services
gem 'ilovepdf'

# database
gem 'pg'

gem 'simplecov', require: false, group: :test

group :development, :test do
  gem 'brakeman'
  gem 'bundler-audit'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'faker', git: 'https://github.com/faker-ruby/faker.git', branch: 'master'
  gem 'fasterer'
  gem 'rspec-rails', '~> 4.0.2'
  # ruby lint
  gem 'rubocop', '~> 1.25', require: false
  gem 'rubocop-rails', '~> 2.13', '>= 2.13.2'
  gem 'rubocop-rspec', '~> 2.9'
  # gem 'shoulda'
  gem 'shoulda-matchers', '~> 5.0'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'pry', '~> 0.13.1'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  gem 'knapsack_pro'
  gem 'vcr'
  gem 'webmock'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
