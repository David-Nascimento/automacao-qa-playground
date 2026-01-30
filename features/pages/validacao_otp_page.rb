require_relative "base_page"

class ValidacaoOtpPage < BasePage
  PATH = "/pages/junior/formularios/otp.html"

  def visit_page
    visit PATH
  end

  def fill_email(email)
    fill_in "otp-email", with: email
  end

  def fill_otp(otp)
    otp.chars.each_with_index do |char, index|
      fill_in "otp-email-#{index + 1}", with: char
      puts "Preenchendo o campo #{index} com o valor #{char}"
    end
  end

  def fill_otp_sms(otp)
    otp.chars.each_with_index do |char, index|
      fill_in "otp-sms-#{index + 1}", with: char
      puts "Preenchendo o campo #{index} com o valor #{char}"
    end
  end

  def has_otp_email_success_message?(message)
    page.has_content?(message)
  end 

  def has_otp_sms_success_message?(message)
    page.has_content?(message)
  end

  def fill_phone(phone)
    fill_in "otp-telefone", with: phone
  end

end