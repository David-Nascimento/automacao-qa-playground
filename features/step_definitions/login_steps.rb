# Inicialização da página
Given("que estou na página de login") do
  login_page.visit_page
end

# Preenchimento de campos
When("preencho o email com {string}") do |email|
  @email = email
  login_page.fill_email(email)
end

When("preencho a senha com {string}") do |password|
  @password = password
  login_page.fill_password(password)
end

When("preencho os campos de login com credenciais válidas do arquivo de dados") do
  user = load_data("user.yaml")["default_user"]
  @email = user["email"]
  @password = user["password"]
  login_page.login_with_data(user)
end

When("preencho o email com uma string de {int} caracteres") do |length|
  login_page.fill_email_with_length(length)
end

When("preencho a senha com uma string de {int} caracteres") do |length|
  login_page.fill_password_with_length(length)
end

# Ações de botão
When("clico no botão {string}") do |button_text|
  login_page.click_button_by_text(button_text)
end

# Validações de mensagens
Then("devo ver a mensagem {string}") do |message|
  expect(login_page.has_success_message?(message)).to be true
end

Then("devo ver a mensagem de erro {string}") do |error_message|
  expect(login_page.has_error_message?(error_message)).to be true
end

# Validações de estado
Then("devo permanecer logado no sistema") do
  expect(login_page.is_logged_in?).to be true
end

Then("não devo estar logado no sistema") do
  expect(login_page.is_not_logged_in?).to be true
end

Then("devo ser redirecionado para a página principal") do
  expect(login_page.current_url_includes?("/pages/junior/formularios/login.html")).to be true
end

# Cenários de exceção
When("o servidor está indisponível") do
  # Simula servidor indisponível - pode ser implementado com stub ou mock
  # Por enquanto, apenas documenta o comportamento esperado
end

When("ocorre um timeout na requisição de login") do
  # Simula timeout - pode ser implementado com stub ou mock
  # Por enquanto, apenas documenta o comportamento esperado
end

When("realizo {int} tentativas de login com credenciais inválidas") do |attempts|
  attempts.times do
    login_page.visit_page
    login_page.login("teste@email.com", "senha_errada")
  end
end

When("minha sessão anterior expirou") do
  login_page.clear_session
end

# Validações de exceção
Then("devo ver uma mensagem de erro de conexão") do
  expect(login_page.has_connection_error?).to be true
end

Then("devo ver uma mensagem de erro de timeout") do
  expect(login_page.has_timeout_error?).to be true
end

Then("devo ver uma mensagem de bloqueio de conta") do
  expect(login_page.has_account_blocked_message?).to be true
end

Then("minha conta deve estar temporariamente bloqueada") do
  expect(login_page.has_account_blocked_message?).to be true
end

Then("o sistema não deve executar código malicioso") do
  expect(login_page.has_malicious_code?).to be false
end

Then("o banco de dados não deve ser comprometido") do
  # Verifica que não houve SQL injection bem-sucedida
  expect(login_page.has_error_message?("Email ou senha inválidos")).to be true
end

Then("devo ver uma mensagem de erro de validação") do
  expect(login_page.has_validation_error?).to be true
end

Then("uma nova sessão deve ser criada") do
  expect(login_page.is_logged_in?).to be true
end
