# encoding: utf-8

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Capybara settings
require 'capybara/rspec'
require 'capybara/rails'
require 'capybara-webkit' #brew install qt
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, :timeout => 60)
end

# Needed to access Rack::Sessions
require 'rack_session_access/capybara'

Capybara.run_server = true
Capybara.server_port = 57124
Capybara.app_host = "http://localhost:#{Capybara.server_port}"

# brew install chromedriver
Capybara.register_driver :chrome do |app|   
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.register_driver :webkit do |app|
  Capybara::Driver::Webkit.new(app, :ignore_ssl_errors => true)
end

#Capybara.javascript_driver = :webkit # :selenium, :chrome or :safari
#Capybara.current_driver = :selenium # :selenium

RSpec.configure do |config|

  # Somehow necessary for running Capybara
  config.include Capybara::DSL

  # :focus filtering for faster testing
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true

end
