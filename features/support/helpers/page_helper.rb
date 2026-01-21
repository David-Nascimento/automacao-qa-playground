module PageHelper
  def login_page
    @login_page ||= LoginPage.new
  end

  # Método para resetar a instância quando necessário
  def reset_login_page
    @login_page = nil
  end
end

World(PageHelper)
