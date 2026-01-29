require "capybara/cucumber"
require "selenium-webdriver"
require "dotenv/load"
require "allure-cucumber"

# Configuração do Allure antes dos demais support (necessário para gerar os JSON)
require File.join(__dir__, "allure.rb")

Dir[File.join(__dir__, "..", "support", "**", "*.rb")].each { |file| require file unless file.end_with?("allure.rb") }
Dir[File.join(__dir__, "..", "pages", "**", "*.rb")].each { |file| require file }
