require 'pry'
require 'capybara/rspec'
require 'dotenv'
Dotenv.load

Capybara.configure do |config|
  config.run_server = false
  config.default_driver = :selenium
  config.app_host = 'https://auth.api.sonyentertainmentnetwork.com/'
end
