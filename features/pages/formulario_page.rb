require_relative "base_page"

class FormularioPage < BasePage
    PATH = "/pages/junior/formularios/web-inputs.html"

  def visit_page
    visit PATH
  end

  def fill_email(email)
    fill_in "input-email", with: email
  end

  def fill_senha(senha)
    fill_in "input-password", with: senha
  end

  def fill_numero(numero)
    fill_in "input-number", with: numero
  end

  def fill_data(data)
    fill_in "input-date", with: data
  end

  def fill_hora(hora)
    fill_in "input-time", with: hora
  end

  # Seleciona uma cor no input type="color" usando JavaScript.
  # O Capybara .set() em inputs type="color" abre o diálogo nativo do browser.
  # Usar o driver Selenium diretamente garante que o valor seja aplicado.
  #
  # @param cor_hex [String] Cor em formato hexadecimal (ex: '#22C50D')
  def select_cor_palette(cor_hex = '#22C50D')
    element = find('[data-testid="input-color"]')
    page.driver.browser.execute_script(
      "arguments[0].value = arguments[1]; " \
      "arguments[0].dispatchEvent(new Event('input', { bubbles: true })); " \
      "arguments[0].dispatchEvent(new Event('change', { bubbles: true }));",
      element.native,
      cor_hex
    )
  end

  def set_range(range)
    find("#input-range").set(range)
  end

  def accept_terms
    find("#input-checkbox").click
    find("#input-checkbox").set(true)
  end

end