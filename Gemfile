# frozen_string_literal: true
source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "bootsnap", require: false
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.3"
gem "sprockets-rails"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

gem "devise"
gem "rspec-rails"
gem "seed-fu", "~> 2.3"
gem "slim-rails"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]

  gem "awesome_print"
  gem "prettier"
  gem "rubocop", require: false
  gem "rubocop-rails", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
