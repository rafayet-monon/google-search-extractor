source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.4'

gem 'bootsnap', '>= 1.4.2', require: false # Reduces boot times through caching; required in config/boot.rb
gem 'pg', '>= 0.18', '< 2.0' # Use postgresql as the database for Active Record
gem 'puma', '~> 4.1' # Use Puma as the app server
gem 'rails', '~> 6.0.2', '>= 6.0.2.1' # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'sidekiq' # background processing for Ruby
gem 'turbolinks', '~> 5' # Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'foreman' # Manage Procfile-based applications
gem 'pagy', '~> 3.5' # Pagination gem

# Authentications
gem 'devise' # Authentication solution for Rails with Warden

# Assets
gem 'sass-rails', '>= 6' # Use SCSS for stylesheets
gem 'webpacker', '~> 4.0' # Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker

gem 'selenium-webdriver' # for web page scraping

group :development do
  gem 'better_errors' # Better error page for Rails and other Rack apps
  gem 'spring' # Spring speeds up development by keeping your application running in the background.
  gem 'spring-commands-rspec' # This gem implements the rspec command for Spring.
  gem 'spring-watcher-listen', '2.0.1' # Makes Spring watch the filesystem for changes using Listen
end

group :development, :test do
  gem 'brakeman', require: false # A static analysis security vulnerability scanner for Ruby on Rails applications
  gem 'bullet' # help to kill N+1 queries and unused eager loading
  gem 'factory_bot_rails'
  gem 'listen', '3.1.5' # Listens to file modifications
  gem 'pry-byebug' # Step by step debugging and stack navigation in Pry
  gem 'pry-rails' # Call 'binding.pry' anywhere in the code to stop execution and get a debugger console
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'sassc-rails' # Gem to generate scss source maps.
end

group :test do
  gem 'database_cleaner' # Use Database Cleaner
  gem 'rspec-rails', '>=4.0.0.beta2' # Rails testing engine
  gem 'shoulda-matchers' # Tests common Rails functionalities
  gem 'simplecov', require: false # code coverage analysis tool for Ruby
  gem 'vcr' # Gem for recording test suite's HTTP interactions
  gem 'webdrivers' # Run Selenium tests more easily with automatic installation and updates for all supported webdrivers
  gem 'webmock' # Library for stubbing and setting expectations on HTTP requests in Ruby
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'service-nakama'
gem 'activeadmin'