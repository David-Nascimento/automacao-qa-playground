require "capybara/cucumber"
require "selenium-webdriver"
require "dotenv/load"
require "allure-cucumber"

Dir[File.join(__dir__, "..", "support", "**", "*.rb")].each { |file| require file }
Dir[File.join(__dir__, "..", "pages", "**", "*.rb")].each { |file| require file }
