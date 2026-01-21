require 'allure-cucumber'
require 'fileutils'

# Garante que o diretório reports existe
results_dir = File.join(Dir.pwd, 'reports', 'allure-results')
FileUtils.mkdir_p(results_dir) unless Dir.exist?(results_dir)

# Configura o Allure Cucumber
AllureCucumber.configure do |config|
    config.results_directory = results_dir
    config.clean_results_directory = false  # Não limpar para manter histórico
    config.logging_level = Logger::INFO

    config.environment_properties = {
    'Browser' => ENV['BROWSER'] || 'chrome',
    'Base URL' => ENV['BASE_URL'] || 'https://qa-playground-azure.vercel.app',
    'Environment' => ENV['ENV'] || 'local'
    }
end

# O Allure Cucumber se registra automaticamente quando requerido
# Mas precisamos garantir que ele seja carregado antes dos testes