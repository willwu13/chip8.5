source 'https://rubygems.org'

ruby '2.6.6'
gem 'rails', '4.2.11'
gem 'ffi', '1.14.2'
gem 'faraday', '~> 1.10'

gem 'sass-rails', '~> 5.0.3'
gem 'uglifier', '>= 2.7.1'

gem 'jquery-rails'
gem 'bigdecimal', '1.3.5'
gem 'web-console', '~> 2.0'

group :development, :test do
  gem 'byebug'                  # no version
  gem 'database_cleaner', '~> 1.7'
  gem 'cucumber-rails', require: false
  gem 'rspec-rails', '~> 3.8'   # updated to 3.8 which exists
  gem 'webmock', '>= 2.3.2'

  gem 'pry'                      # no version, will use latest compatible
  gem 'pry-byebug'               # no version

  gem 'sqlite3', '~> 1.3.13'
end

group :production do
  gem 'pg', '~> 1.1'
  gem 'rails_12factor', '~> 0.0.3'
end
