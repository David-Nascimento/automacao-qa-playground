require 'allure-cucumber'

AllureCucumber.configure do |config|
    config.results_directory = 'reports/allure-results'
    config.clean_results_directory = true
    config.logging_level = Logger::INFO

    config.environment_properties = {
    'Browser' => ENV['BROWSER'],
    'Base URL' => ENV['BASE_URL'],
    'Environment' => ENV['ENV'] || 'local'
    }
end