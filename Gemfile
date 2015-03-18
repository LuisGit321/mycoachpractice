source 'https://rubygems.org'
ruby '1.9.3'
gem 'rails'

gem "mongoid", git: "git://github.com/mongoid/mongoid.git"
gem "bson_ext"

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

gem 'nokogiri'
gem 'jquery-rails'
gem "haml-rails"

gem "devise"
gem "devise_invitable"
gem "cancan", ">= 1.6.7"
gem 'activeadmin-mongoid', git: "git://github.com/elia/activeadmin-mongoid.git"

gem "bootstrap-sass", ">= 2.0.3"
gem "simple_form"
gem "client_side_validations"
gem "omniauth"
gem "gdata", git: "git://github.com/platform45/gdata.git"
gem "google-api-client"
gem "prawn"
gem "carrierwave"

gem 'eventmachine', ">= 1.0.0.rc.4"
gem 'thin'
gem 'heroku'
#gem 'new_relic_rpm'

gem 'csv-mapper'

group :test, :development do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

group :test do
  gem 'cucumber-rails', :require => false
  gem 'mongoid-rspec'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'launchy'
  gem 'simplecov'
  gem 'email_spec'
  gem 'shoulda'
  # gem 'spork'
end

#group :production do
#  gem 'pg'
#  gem 'unicorn'
#end
