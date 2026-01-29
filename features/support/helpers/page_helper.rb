module PageHelper
  def login_page
    @login_page ||= LoginPage.new
  end

  def register_page
    @register_page ||= RegisterPage.new
  end

  def formulario_page
    @formulario_page ||= FormularioPage.new
  end

  # Método para resetar a instância quando necessário
  def reset_login_page
    @login_page = nil
  end
end

World(PageHelper)
