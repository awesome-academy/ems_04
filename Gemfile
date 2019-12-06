source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "bcrypt", "3.1.12"
gem "bootstrap", "~> 4.1.3"
gem "coffee-rails", "~> 4.2"
gem "config"
gem "faker", "1.7.3"
gem "figaro"
gem "i18n-js"
gem "jbuilder", "~> 2.5"
gem "jquery-rails"
gem "mysql2", ">= 0.3.18", "< 0.6.0"
gem "puma", "~> 3.12"
gem "rails", "~> 5.1.7"
gem "rb-readline"
gem "rubocop", "~> 0.54.0", require: false
gem "sass-rails", "~> 5.0"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
gem "will_paginate", "3.1.6"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara", "~> 3.29"
  gem "database_cleaner", "~> 1.7"
  gem "factory_bot_rails", "~> 5.1"
  gem "rails-controller-testing"
  gem "rspec-rails", "~> 3.8", ">= 3.8.2"
  gem "selenium-webdriver"
  gem "shoulda-matchers"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
