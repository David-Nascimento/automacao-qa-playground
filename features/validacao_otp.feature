Feature: Validacao OTP
    As a user
    I want to validate the OTP
    In order to access restricted features

    # ============================================
    # CENÁRIOS POSITIVOS
    # ============================================
    @smoke @regression @otpEmail
    Scenario: Validar OTP por Email
        Given que estou na página de validacao OTP
        When preencho o campo email com "teste@email.com"
        Then devo enviar o OTP por email
        And preencher o campo OTP com "123456"
        And clicar no botão validar OTP por email
        Then devo ver a mensagem OTP email "Código OTP validado com sucesso!"

    # ============================================
    # CENÁRIOS NEGATIVOS
    # ============================================
    @smoke @regression @otpEmailInvalido
    Scenario: Validar OTP por Email com OTP inválido
        Given que estou na página de validacao OTP
        When preencho o campo email com "teste@email.com"
        Then devo enviar o OTP por email
        And preencher o campo OTP com "223344"
        And clicar no botão validar OTP por email
        Then devo ver a mensagem OTP email "Código inválido. Use 123456 para testes."

    # ============================================
    # CENÁRIOS POSITIVOS
    # ============================================
    @smoke @regression @otpSMS
    Scenario: Validar OTP por SMS
        Given que estou na página de validacao OTP
        When preencho o campo telefone com "11999999999"
        Then devo enviar o OTP por SMS
        And preencher o campo OTP SMS com "1234"
        And clicar no botão validar OTP por SMS
        Then devo ver a mensagem OTP SMS "Código OTP validado com sucesso!"

    # ============================================
    # CENÁRIOS NEGATIVOS
    # ============================================
    @smoke @regression @otpSMSInvalido
    Scenario: Validar OTP por SMS com OTP inválido
        Given que estou na página de validacao OTP
        When preencho o campo telefone com "11999999999"
        Then devo enviar o OTP por SMS
        And preencher o campo OTP SMS com "2233"
        And clicar no botão validar OTP por SMS
        Then devo ver a mensagem OTP SMS "Código inválido. Use 1234 para testes."