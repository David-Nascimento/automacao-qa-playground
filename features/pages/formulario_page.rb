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

  def select_cor_palette
    find('#input-color').set('#22C50D')
    expect(find('.color-preview')[:style]).to include('rgb(34, 197, 13)')
  end

  def set_range(range)
    find("input-range").set(range)
  end

end