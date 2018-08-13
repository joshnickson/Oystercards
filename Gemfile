# frozen_string_literal: true

source "https://rubygems.org"

ruby "2.5.1"

group :test, :development do
  gem "rspec"
end

group :development do
  gem "rubocop", "0.56.0"
end

group :test do
  gem "simplecov", require: false
  gem "simplecov-console", require: false
end

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# gem "rails"
