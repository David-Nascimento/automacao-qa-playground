require 'rake'
require 'fileutils'

ALLURE_RESULTS = 'reports/allure-results'
ALLURE_REPORT  = 'reports/allure-report'

def run(cmd)
  puts "\nExecutando: #{cmd}"
  sh cmd
end

# Configuráveis por ENV
# Tags: use TEST=@tag ou TAGS=@tag (ex: TEST=@test rake, TEST=@smoke rake)
PROFILE = ENV.fetch('PROFILE', 'default')
BROWSER = ENV.fetch('BROWSER', '')

namespace :allure do
  desc 'Gera relatório do Allure a partir dos resultados (se existirem)'
  task :generate do
    if Dir.exist?(ALLURE_RESULTS)
      run "allure generate #{ALLURE_RESULTS} --clean -o #{ALLURE_REPORT}"
    else
      puts "No results to generate Allure report."
    end
  end

  desc 'Abre o relatório Allure no navegador (gera antes se não existir)'
  task :open do
    Rake::Task['allure:generate'].invoke unless Dir.exist?(ALLURE_REPORT) && !Dir.empty?(ALLURE_REPORT)
    if Dir.exist?(ALLURE_REPORT)
      run "allure open #{ALLURE_REPORT}"
    else
      puts "Nenhum relatório Allure encontrado. Rode os testes antes: rake test"
    end
  end
end

file ALLURE_RESULTS do
  FileUtils.mkdir_p(ALLURE_RESULTS)
end

# Normaliza tag: evita "@register rake" (Cucumber exige uma expressão válida, sem espaço solto)
def normalize_tag(value)
  return '' if value.to_s.strip.empty?
  s = value.to_s.strip
  # Se veio "VAR=valor" (ex: TEST=@register no PowerShell como arg), usa só o valor
  s = $1.strip if s =~ /^(?:TEST|TAGS)=(.+)$/i
  # Se ainda tiver espaço, usa só a primeira tag (ex: "@register rake" -> "@register")
  s = s.split(/\s+/).find { |t| t.start_with?('@') } || s.split(/\s+/).first || s
  s.to_s.strip
end

namespace :test do
  desc 'Executa testes (usa ENV TAGS ou TEST para tag, ex: TEST=@test rake)'
  task :run do
    raw_tags = ENV['TAGS'].to_s.strip
    raw_tags = ENV['TEST'].to_s.strip if raw_tags.empty?
    tags = normalize_tag(raw_tags)
    profile_flag = PROFILE == 'default' ? '' : "-p #{PROFILE}"
    tags_flag = tags && !tags.empty? ? %Q(-t "#{tags}") : ''
    browser_prefix = BROWSER && !BROWSER.empty? ? "BROWSER=#{BROWSER} " : ''

    cmd = ["bundle exec cucumber", profile_flag, tags_flag].reject(&:empty?).join(' ')
    run "#{browser_prefix}#{cmd}"
    Rake::Task['allure:generate'].invoke
  end
end

desc 'Limpa relatórios gerados'
task :clean do
  FileUtils.rm_rf('reports')
  puts 'reports removidos.'
end

# Simples aliases para facilitar execução
task :flaky, [:tags] do |t, args|
  ENV['TAGS'] = args[:tags] || '@flaky'
  Rake::Task['test:run'].invoke
end

task :smoke, [:tags] do |t, args|
  ENV['TAGS'] = args[:tags] || '@smoke'
  Rake::Task['test:run'].invoke
end

task :headless, [:tags] do |t, args|
  ENV['BROWSER'] = 'headless'
  ENV['TAGS'] = args[:tags] if args[:tags]
  Rake::Task['test:run'].invoke
end

# Generic top-level task that runs tests by tag (or all if no tag)
# Usage:
#   bundle exec rake test         # runs all tests
#   bundle exec rake test["@flaky"]  # runs tests with @flaky
#   rake @register  # passa @register como tag (evite "rake TEST=@x" no PowerShell; use $env:TEST="@x"; rake)
task :test, [:tags] do |t, args|
  arg = args[:tags].to_s.strip
  # Se alguém rodou "rake TEST=@register" no PowerShell, o arg vem como "TEST=@register" -> usar só a tag
  arg = $1.strip if arg =~ /^(?:TEST|TAGS)=(.+)$/i
  ENV['TAGS'] = normalize_tag(arg) if arg && !arg.empty?
  Rake::Task['test:run'].invoke
end

task :t, [:tags] => [:test]

# Atalho padrão (roda tudo). Ex: rake | TEST=@test rake | TEST=@smoke rake
task default: :test