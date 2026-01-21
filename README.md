# Automação QA Playground

Suite de testes automatizados em Ruby usando **Cucumber**, **Capybara** e **Selenium WebDriver** para validar o fluxo de login do site de exemplo [QA Playground](https://qa-playground-azure.vercel.app/pages/junior/formularios/login.html).

O projeto utiliza **BDD (Behavior-Driven Development)** com escrita de cenários em **Gherkin** e implementação seguindo o padrão **Page Object Model (POM)**.

## Requisitos

- **Ruby** (versão 3.1 ou superior recomendada)
- **Google Chrome** instalado
- **Bundler** (`gem install bundler`)

## Instalação

1. Clone o repositório:
```bash
git clone <url-do-repositorio>
cd automacao-qa-playground
```

2. Instale as dependências:
```bash
bundle install
```

## Como Executar

### Executar todos os testes
```bash
bundle exec cucumber
```

### Executar um cenário específico
```bash
bundle exec cucumber features/login.feature:10
```

### Executar com tags
```bash
# Executar apenas testes de smoke
bundle exec cucumber -t @smoke

# Executar apenas testes de regressão
bundle exec cucumber -t @regression
```

### Executar em modo headless (sem interface gráfica)
```bash
BROWSER=headless bundle exec cucumber
```

### Usar perfis do Cucumber
```bash
# Perfil smoke
bundle exec cucumber -p smoke

# Perfil regression
bundle exec cucumber -p regression

# Perfil headless
bundle exec cucumber -p headless
```

## Estrutura do Projeto

```
automacao-qa-playground/
├── features/
│   ├── data/
│   │   └── user.yaml              # Massa de dados dos usuários
│   ├── pages/
│   │   ├── base_page.rb           # Classe base para Page Objects
│   │   └── login_page.rb          # Page Object da página de login
│   ├── step_definitions/
│   │   └── login_steps.rb         # Step definitions dos cenários
│   ├── support/
│   │   ├── browser_helper.rb      # Configuração de drivers (Chrome/Headless)
│   │   ├── capybara.rb            # Configuração do Capybara
│   │   ├── data_helper.rb         # Helper para carregar dados YAML
│   │   ├── env.rb                 # Carregamento automático de arquivos
│   │   └── hooks.rb               # Hooks do Cucumber (Before/After)
│   └── login.feature              # Arquivo Gherkin com cenários de teste
├── reports/
│   └── screenshots/               # Screenshots de falhas (gerado automaticamente)
├── cucumber.yaml                  # Perfis de execução do Cucumber
├── Gemfile                        # Dependências do projeto
└── README.md                      # Este arquivo
```

## Funcionalidades

### Cenários de Teste

O projeto contém **19 cenários** organizados em três categorias:

#### Cenários Positivos
- Login com credenciais válidas
- Login usando dados do arquivo YAML

#### Cenários Negativos
- Email inválido
- Senha incorreta
- Credenciais completamente inválidas
- Campos vazios
- Email em formato inválido
- Email inexistente
- Senha muito curta
- E outros...

#### Cenários de Exceção
- Servidor indisponível
- Timeout na requisição
- Múltiplas tentativas falhadas (bloqueio de conta)
- Tentativas de XSS e SQL Injection
- Campos muito longos
- Sessão expirada

## Arquitetura

### Page Object Model (POM)

O projeto utiliza o padrão **Page Object Model** para melhor organização e manutenibilidade:

#### BasePage
Classe base que contém métodos comuns para todas as páginas:
- `current_url` - Retorna a URL atual
- `page_title` - Retorna o título da página
- `has_content?` - Verifica se o conteúdo existe
- `wait_for_element` - Aguarda elemento aparecer
- `clear_cookies` - Limpa cookies
- `refresh_page` - Atualiza a página

#### LoginPage
Page Object específico da página de login com métodos para:
- **Preenchimento**: `fill_email`, `fill_password`, `fill_email_with_length`, `fill_password_with_length`
- **Ações**: `click_entrar_button`, `click_button_by_text`, `login`, `login_with_data`
- **Validações**: `has_success_message?`, `has_error_message?`, `is_logged_in?`, `is_not_logged_in?`, etc.

### Step Definitions

Os step definitions estão organizados em categorias:
- **Inicialização**: Setup da página
- **Preenchimento**: Preencher campos do formulário
- **Ações**: Clicar em botões
- **Validações**: Verificar mensagens e estados

## Configurações

### Capybara
- **Driver padrão**: `selenium_chrome`
- **URL base**: `https://qa-playground-azure.vercel.app` (configurável via `BASE_URL` no `.env`)
- **Timeout padrão**: 5 segundos

### Variáveis de Ambiente

Crie um arquivo `.env` na raiz do projeto para configurar variáveis:

```env
BASE_URL=https://qa-playground-azure.vercel.app
BROWSER=chrome
```

### Dados de Teste

Os dados dos usuários estão em `features/data/user.yaml`:

```yaml
default_user:
  email: "teste@email.com"
  password: "senha123"

invalid_user:
  email: "teste@qaplayground.com"
  password: "senha_errada"
```

## Screenshots

O projeto captura automaticamente screenshots quando um cenário falha. Os arquivos são salvos em `reports/screenshots/` com o nome do cenário.

## Gems Utilizadas

- **cucumber** - Framework BDD
- **capybara** - DSL para testes de interface web
- **selenium-webdriver** - Automação de navegadores
- **webdrivers** - Gerenciamento automático de drivers
- **rspec** - Framework de testes (para expectativas)
- **dotenv** - Gerenciamento de variáveis de ambiente
- **faker** - Geração de dados fake
- **pry** - Debug interativo

## Exemplo de Cenário

```gherkin
Feature: Login no sistema
  As a user
  I want to login to the system
  In order to access restricted features

  Scenario: Realizar login com sucesso usando credenciais válidas
    Given que estou na página de login
    When preencho o email com "teste@email.com"
    And preencho a senha com "senha123"
    And clico no botão "Entrar"
    Then devo ver a mensagem "Login realizado com sucesso!"
    And devo permanecer logado no sistema
```

## Troubleshooting

### Erro: "uninitialized constant"
- Certifique-se de que executou `bundle install`
- Verifique se todas as gems estão instaladas

### Erro: "Driver not found"
- O `webdrivers` baixa automaticamente o driver do Chrome
- Certifique-se de que o Chrome está instalado

### Screenshots não são gerados
- Verifique se a pasta `reports/screenshots/` existe
- O diretório é criado automaticamente em caso de falha

## Contribuindo

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/nova-funcionalidade`)
3. Commit suas mudanças (`git commit -m 'Adiciona nova funcionalidade'`)
4. Push para a branch (`git push origin feature/nova-funcionalidade`)
5. Abra um Pull Request

## Licença

Este projeto é de código aberto e está disponível sob a licença MIT.

## Autor

Desenvolvido para automação de testes do QA Playground.

---

**Nota**: Este projeto é um exemplo de automação de testes e pode ser adaptado para outros projetos seguindo a mesma estrutura.