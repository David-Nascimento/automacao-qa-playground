class BasePage
  include Capybara::DSL

  def initialize
    # Inicialização comum para todas as páginas
  end

  def current_url
    page.current_url
  end

  def page_title
    page.title
  end

  def has_content?(text)
    page.has_content?(text)
  end

  def wait_for_element(selector, timeout: 5)
    page.has_selector?(selector, wait: timeout)
  end

  def clear_cookies
    page.driver.browser.manage.delete_all_cookies
  end

  def refresh_page
    page.refresh
  end

  def wait_for_element_to_be_visible(selector, timeout: 5)
    page.has_selector?(selector, wait: timeout, visible: true)
  end
end
