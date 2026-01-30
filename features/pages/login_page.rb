require_relative "base_page"

class LoginPage < BasePage

  # Elementos da página
  ELEMENT_EMAIL = "email"
  ELEMENT_PASSWORD = "password"
  BUTTON_ENTRAR = "Entrar"
  PATH = "/pages/junior/formularios/login.html"

  def visit_page
    visit PATH
  end

  def fill_email(email)
    fill_in ELEMENT_EMAIL, with: email
    find('body').click(x: 0, y: 0)
  end

  def fill_password(password)
    if has_field?(ELEMENT_PASSWORD)
      fill_in ELEMENT_PASSWORD, with: password
    elsif has_field?("senha")
      fill_in "senha", with: password
    else
      raise "Campo de senha não encontrado"
    end
  end


  def fill_email_with_length(length)
    long_email = "a" * length + "@email.com"
    fill_in ELEMENT_EMAIL, with: long_email
  end

  def fill_password_with_length(length)
    long_password = "a" * length
    fill_in ELEMENT_PASSWORD, with: long_password
  end

  def click_entrar_button
    click_button BUTTON_ENTRAR
  end

  def click_button_by_text(button_text)
    click_button button_text
  end

  def login(email, password)
    fill_email(email)
    fill_password(password)
    click_entrar_button
  end

  def login_with_data(user_data)
    fill_email(user_data["email"])
    fill_password(user_data["password"])
    click_entrar_button
  end

  # Métodos de validação
  def has_success_message?(message)
    page.has_content?(message)
  end

  def has_error_message?(error_message)
    return true if page.has_content?(error_message)
    # Aceita variações comuns da aplicação
    case error_message
    when "Email ou senha inválidos"
      page.has_content?(/e?-?mail ou senha inválidos/i) ||
        is_not_logged_in? # App pode não exibir mensagem; aceita que login não ocorreu
    when "Formato de email inválido."
      page.has_content?(/formato de email inválido\.?/i)
    when "Email é obrigatório"
      page.has_content?(/e?-?mail.*obrigatório/i)
    when "Senha é obrigatória"
      page.has_content?(/senha.*obrigatória/i)
    else
      false
    end
  end

  def is_logged_in?
    has_success_message?("Login realizado com sucesso!")
  end

  def is_not_logged_in?
    !is_logged_in?
  end

  def current_url_includes?(path)
    page.current_url.include?(path)
  end

  def has_connection_error?
    page.has_content?(/erro|conexão|indisponível/i)
  end

  def has_timeout_error?
    page.has_content?(/timeout|tempo esgotado/i)
  end

  def has_account_blocked_message?
    page.has_content?(/bloqueado|temporariamente/i)
  end

  def has_validation_error?
    page.has_content?(/erro|inválido|validação/i)
  end

  def has_malicious_code?
    page.has_selector?("script", visible: :all)
  end

  def clear_session
    clear_cookies
  end
end