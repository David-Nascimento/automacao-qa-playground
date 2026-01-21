Before do
    Capybara.current_session.driver.browser.manage.window.maximize
end

Before('@flaky') do
    mark_flaky
end

After do |scenario|
    next unless scenario.failed?

    # Garante que o diretório de screenshots existe
    screenshots_dir = File.join(Dir.pwd, 'reports', 'screenshots')
    FileUtils.mkdir_p(screenshots_dir) unless Dir.exist?(screenshots_dir)

    screenshot = page.save_screenshot("reports/screenshots/#{scenario.name.gsub(' ', '_')}.png")

    # Adiciona anexo apenas se o Allure estiver ativo
    begin
        Allure.add_attachment(
            name: "Screenshot",
            source: File.open(screenshot),
            type: Allure::ContentType::PNG,
            test_case: true
        )
    rescue => e
        puts "Erro ao adicionar anexo ao Allure: #{e.message}"
    end
end