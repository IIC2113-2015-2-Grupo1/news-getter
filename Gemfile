# encoding: utf-8
source 'http://rubygems.org/'

ruby '2.2.3'

gem 'rake'

# Declare the sinatra dependency
gem 'sinatra'
gem 'sinatra-contrib'

# Puma webserver
gem 'puma'

# Database
gem 'pg'

# Scrapping
gem 'nokogiri'

# Crons
gem 'rufus-scheduler'

# Threading
gem 'concurrent-ruby'

group :development do
  # Metrics
  gem 'metric_fu'
end
# Setup our test group and require rspec
group :test do
  # Styleguide
  gem 'rubocop', require: false

  # Test framework
  gem 'rspec'
end
