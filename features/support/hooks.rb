Before do
    Capybara.current_session.driver.browser.manage.window.maximize
end

After do |scenario|
    next unless scenario.failed?

    screenshot = page.save_screenshot("reports/screenshots/#{scenario.name.gsub(' ', '_')}.png")

    Allure.add_attachment(
        name: "Screenshot",
        source: File.open(screenshot),
        type: Allure::ContentType::PNG,
        test_case: true
    )
end