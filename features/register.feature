@register
Feature: Register no sistema
    As a user
    I want to register to the system
    In order to access restricted features

    # ============================================
    # CENÁRIOS POSITIVOS
    # ============================================
    @smoke @regression
    Scenario: Realizar registro com sucesso usando credenciais válidas
        Given que estou na página de registro
        When preencho os campos de registro com credenciais válidas do arquivo de dados
        And clico no botão "Criar Conta"
        Then devo ver a mensagem "Conta criada com sucesso!"

    # ============================================
    # CENÁRIOS NEGATIVOS
    # ============================================
    @smoke @regression
    Scenario: Tentar realizar registro com email inválido
        Given que estou na página de registro
        When preencho o email com "email_invalido"
        And preencho a senha com "senha123"

    # ============================================
    # CENÁRIOS FLAKY
    # ============================================
    @regression @flaky_register
    Scenario: Tentar realizar registro com caracteres especiais maliciosos
        Given que estou na página de registro
        When preencho o email com "<script>alert('xss')</script>"
        And devo ver a mensagem de erro "Formato de email inválido."

    @regression @flaky_register
    Scenario: Tentar realizar registro com SQL injection no campo email
        Given que estou na página de registro
        When preencho o email com "admin' OR '1'='1"
        And devo ver a mensagem de erro "Formato de email inválido."