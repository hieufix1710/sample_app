source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "2.6.6"
gem "bcrypt", "3.1.12"
gem "bootstrap-sass", "~>3.4.1"
gem "jquery-rails", "4.3.1"
gem "pg"
gem "puma", "~> 5.0"
gem "rails", "~> 6.1.1"
gem 'figaro'
gem "rails-i18n"
gem "sass-rails", ">= 6"
gem "webpacker", "~> 5.0"
gem "jbuilder", "~> 2.7"
gem "turbolinks", "~> 5"
gem "config"
gem 'pg'

gem "image_processing", "1.9.3"
gem "mini_magick", "4.9.5"
gem "active_storage_validations", "0.8.2"
# gem "will_paginate", "3.1.7"
gem "bootstrap-will_paginate", "1.0.0"

gem "bootsnap", ">= 1.4.4", require: false

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "listen", "~> 3.3"
  gem "rack-mini-profiler", "~> 2.0"
  gem "spring"
  gem "web-console", ">= 4.1.0"

  gem "rubocop", "~> 0.74.0", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", "~> 2.3.2", require: false
end

group :test do
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver"
  gem "webdrivers"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
