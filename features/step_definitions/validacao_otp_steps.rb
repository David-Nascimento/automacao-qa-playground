Given("que estou na página de validacao OTP") do
  validacao_otp_page.visit_page
end

When("preencho o campo email com {string}") do |email|
  validacao_otp_page.fill_email(email)
end

Then("devo enviar o OTP por email") do
  validacao_otp_page.click_button_by_testid('btn-solicitar-otp-email')
end

And("preencher o campo OTP com {string}") do |otp|
  validacao_otp_page.fill_otp otp
end

And("clicar no botão validar OTP por email") do
  validacao_otp_page.click_button_by_testid('btn-validar-otp-email')
end

And("clicar no botão validar OTP por SMS") do
  validacao_otp_page.click_button_by_testid('btn-validar-otp-sms')
end

Then("devo ver a mensagem OTP email {string}") do |message|
  expect(validacao_otp_page.has_otp_email_success_message?(message)).to be true
end

When("preencho o campo telefone com {string}") do |phone|
  phone = load_data("user.yaml")["default_user"]["telefone"]
  validacao_otp_page.fill_phone(phone)
end

Then("devo enviar o OTP por SMS") do
  validacao_otp_page.click_button_by_testid('btn-solicitar-otp-sms')
end

And("preencher o campo OTP SMS com {string}") do |otp|
  validacao_otp_page.fill_otp_sms otp
end

Then("devo ver a mensagem OTP SMS {string}") do |message|
  expect(validacao_otp_page.has_otp_sms_success_message?(message)).to be true
end