require "capybara/cucumber"
require "selenium-webdriver"

Capybara.configure do |config|
    config.default_driver = :selenium_chrome
    config.app_host = ENV["BASE_URL"] || "https://qa-playground-azure.vercel.app"
    config.default_max_wait_time = 5
end