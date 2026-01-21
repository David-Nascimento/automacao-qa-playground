Feature: Login no sistema
  As a user
  I want to login to the system
  In order to access restricted features

  # ============================================
  # CENÁRIOS POSITIVOS
  # ============================================

  @smoke @regression
  Scenario: Realizar login com sucesso usando credenciais válidas
    Given que estou na página de login
    When preencho o email com "teste@email.com"
    And preencho a senha com "senha123"
    And clico no botão "Entrar"
    Then devo ver a mensagem "Login realizado com sucesso!"
    And devo permanecer logado no sistema

  @regression
  Scenario: Realizar login com sucesso usando dados do arquivo YAML
    Given que estou na página de login
    When preencho os campos de login com credenciais válidas do arquivo de dados
    And clico no botão "Entrar"
    Then devo ver a mensagem "Login realizado com sucesso!"
    And devo ser redirecionado para a página principal

  # ============================================
  # CENÁRIOS NEGATIVOS
  # ============================================

  @smoke @regression
  Scenario: Tentar realizar login com email inválido
    Given que estou na página de login
    When preencho o email com "email_invalido"
    And preencho a senha com "senha123"
    And clico no botão "Entrar"
    Then devo ver a mensagem de erro "Email ou senha inválidos"
    And não devo estar logado no sistema

  @smoke @regression
  Scenario: Tentar realizar login com senha incorreta
    Given que estou na página de login
    When preencho o email com "teste@email.com"
    And preencho a senha com "senha_incorreta"
    And clico no botão "Entrar"
    Then devo ver a mensagem de erro "Email ou senha inválidos"
    And não devo estar logado no sistema

  @regression
  Scenario: Tentar realizar login com credenciais completamente inválidas
    Given que estou na página de login
    When preencho o email com "teste@qaplayground.com"
    And preencho a senha com "senha_errada"
    And clico no botão "Entrar"
    Then devo ver a mensagem de erro "Email ou senha inválidos"
    And não devo estar logado no sistema

  @regression
  Scenario: Tentar realizar login com email vazio
    Given que estou na página de login
    When preencho o email com ""
    And preencho a senha com "senha123"
    And clico no botão "Entrar"
    Then devo ver a mensagem de erro "Email é obrigatório"
    And não devo estar logado no sistema

  @regression
  Scenario: Tentar realizar login com senha vazia
    Given que estou na página de login
    When preencho o email com "teste@email.com"
    And preencho a senha com ""
    And clico no botão "Entrar"
    Then devo ver a mensagem de erro "Senha é obrigatória"
    And não devo estar logado no sistema

  @regression
  Scenario: Tentar realizar login com ambos os campos vazios
    Given que estou na página de login
    When preencho o email com ""
    And preencho a senha com ""
    And clico no botão "Entrar"
    Then devo ver a mensagem de erro "Email é obrigatório"
    And não devo estar logado no sistema

  @regression
  Scenario: Tentar realizar login com email em formato inválido
    Given que estou na página de login
    When preencho o email com "email_sem_arroba"
    And preencho a senha com "senha123"
    And clico no botão "Entrar"
    Then devo ver a mensagem de erro "Email ou senha inválidos"
    And não devo estar logado no sistema

  @regression
  Scenario: Tentar realizar login com email inexistente
    Given que estou na página de login
    When preencho o email com "naoexiste@email.com"
    And preencho a senha com "senha123"
    And clico no botão "Entrar"
    Then devo ver a mensagem de erro "Email ou senha inválidos"
    And não devo estar logado no sistema

  @regression
  Scenario: Tentar realizar login com email contendo caracteres especiais inválidos
    Given que estou na página de login
    When preencho o email com "teste@@email.com"
    And preencho a senha com "senha123"
    And clico no botão "Entrar"
    Then devo ver a mensagem de erro "Email ou senha inválidos"
    And não devo estar logado no sistema

  @regression
  Scenario: Tentar realizar login com senha muito curta
    Given que estou na página de login
    When preencho o email com "teste@email.com"
    And preencho a senha com "123"
    And clico no botão "Entrar"
    Then devo ver a mensagem de erro "Email ou senha inválidos"
    And não devo estar logado no sistema

  # ============================================
  # CENÁRIOS DE EXCEÇÃO
  # ============================================

  @regression
  Scenario: Tentar realizar login quando o servidor está indisponível
    Given que estou na página de login
    When o servidor está indisponível
    And preencho o email com "teste@email.com"
    And preencho a senha com "senha123"
    And clico no botão "Entrar"
    Then devo ver uma mensagem de erro de conexão
    And não devo estar logado no sistema

  @regression
  Scenario: Tentar realizar login com timeout na requisição
    Given que estou na página de login
    When ocorre um timeout na requisição de login
    And preencho o email com "teste@email.com"
    And preencho a senha com "senha123"
    And clico no botão "Entrar"
    Then devo ver uma mensagem de erro de timeout
    And não devo estar logado no sistema

  @regression
  Scenario: Tentar realizar login com múltiplas tentativas falhadas
    Given que estou na página de login
    When realizo 5 tentativas de login com credenciais inválidas
    And preencho o email com "teste@email.com"
    And preencho a senha com "senha_errada"
    And clico no botão "Entrar"
    Then devo ver uma mensagem de bloqueio de conta
    And minha conta deve estar temporariamente bloqueada
    And não devo estar logado no sistema

  @regression
  Scenario: Tentar realizar login com caracteres especiais maliciosos
    Given que estou na página de login
    When preencho o email com "<script>alert('xss')</script>"
    And preencho a senha com "senha123"
    And clico no botão "Entrar"
    Then devo ver a mensagem de erro "Email ou senha inválidos"
    And não devo estar logado no sistema
    And o sistema não deve executar código malicioso

  @regression
  Scenario: Tentar realizar login com SQL injection no campo email
    Given que estou na página de login
    When preencho o email com "admin' OR '1'='1"
    And preencho a senha com "senha123"
    And clico no botão "Entrar"
    Then devo ver a mensagem de erro "Email ou senha inválidos"
    And não devo estar logado no sistema
    And o banco de dados não deve ser comprometido

  @regression
  Scenario: Tentar realizar login com campos muito longos
    Given que estou na página de login
    When preencho o email com uma string de 500 caracteres
    And preencho a senha com uma string de 500 caracteres
    And clico no botão "Entrar"
    Then devo ver uma mensagem de erro de validação
    And não devo estar logado no sistema

  @regression
  Scenario: Tentar realizar login após sessão expirada
    Given que estou na página de login
    When minha sessão anterior expirou
    And preencho o email com "teste@email.com"
    And preencho a senha com "senha123"
    And clico no botão "Entrar"
    Then devo ver a mensagem "Login realizado com sucesso!"
    And uma nova sessão deve ser criada
