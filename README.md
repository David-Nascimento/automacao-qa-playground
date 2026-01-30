# Automação QA Playground

Suite de testes automatizados em Ruby usando **Cucumber**, **Capybara** e **Selenium WebDriver** para validar os fluxos de **login**, **registro**, **formulário** e **validação OTP** do site de exemplo [QA Playground](https://qa-playground-azure.vercel.app).

O projeto utiliza **BDD (Behavior-Driven Development)** com escrita de cenários em **Gherkin** e implementação seguindo o padrão **Page Object Model (POM)**. Relatórios são gerados com **Allure**.

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

### Usando Rake (recomendado)

O Rake usa as variáveis de ambiente **`TEST`** ou **`TAGS`** para filtrar por tag. Se nenhuma tag for informada, todos os cenários são executados. Após os testes, o relatório Allure é gerado automaticamente.

| Ação | Comando |
|------|--------|
| Todos os testes | `bundle exec rake` ou `bundle exec rake test` |
| Por tag (env) | `TEST=@tag rake` (Linux/Mac/Git Bash) |
| Por tag (arg) | `bundle exec rake test["@flaky"]` ou `bundle exec rake t["@flaky"]` |
| Smoke | `bundle exec rake smoke` |
| Flaky | `bundle exec rake flaky` (cenários com tag @flaky) |
| Headless | `bundle exec rake headless` |
| Limpar relatórios | `bundle exec rake clean` |
| Só gerar Allure | `bundle exec rake allure:generate` |
| Abrir Allure | `bundle exec rake allure:open` |

**Exemplos por tag:**

```bash
# Linux / Mac / Git Bash
TEST=@test rake
TEST=@smoke rake
TEST=@regression rake
TAGS=@flaky rake
```

```powershell
# Windows PowerShell
$env:TEST = "@smoke"; rake
$env:TEST = "@regression"; rake
```

```cmd
# Windows CMD
set TEST=@smoke && rake
```

**Outras variáveis de ambiente:**

- **`PROFILE`** – perfil do Cucumber (ex.: `default`, `smoke`, `regression`); padrão: `default`
- **`BROWSER`** – driver do navegador (ex.: `chrome`, `headless`)

### Execução rápida com hook (Git Bash)

O script `scripts/test_hook.sh` detecta quando você digita apenas `TEST='@tag'` e executa o Rake automaticamente.

1. Carregar o hook na sessão atual:

```bash
source scripts/test_hook.sh
```

2. Para ativar permanentemente (uma vez):

```bash
echo "source $(pwd)/scripts/test_hook.sh" >> ~/.bashrc
```

Depois de carregar o hook:

```bash
TEST='@smoke'
```

O hook roda `bundle exec rake test` com a tag definida.

### Executar Cucumber diretamente

- Rodar por tag:

```bash
bundle exec cucumber -t "@flaky"
bundle exec cucumber -t "@regression" -t "not @flaky"   # regressão sem cenários flaky
```

- Rodar cenário específico:

```bash
bundle exec cucumber features/login.feature:10
```

- Usar perfil com retry para cenários flaky (`cucumber.yaml`):

```bash
bundle exec cucumber -p retry_flaky
```

## Estrutura do Projeto

```
automacao-qa-playground/
├── features/
│   ├── data/
│   │   └── user.yaml              # Massa de dados (login e registro)
│   ├── pages/
│   │   ├── base_page.rb           # Classe base para Page Objects
│   │   ├── formulario_page.rb     # Page Object do formulário
│   │   ├── login_page.rb          # Page Object da página de login
│   │   ├── register_page.rb       # Page Object da página de registro
│   │   └── validacao_otp_page.rb  # Page Object da validação OTP
│   ├── step_definitions/
│   │   ├── formulario_steps.rb    # Step definitions do formulário
│   │   ├── login_steps.rb         # Step definitions do login
│   │   ├── register_steps.rb      # Step definitions do registro
│   │   └── validacao_otp_steps.rb # Step definitions da validação OTP
│   ├── support/
│   │   ├── allure.rb              # Configuração do Allure
│   │   ├── capybara.rb            # Configuração do Capybara
│   │   ├── env.rb                 # Carregamento automático de arquivos
│   │   ├── hooks.rb               # Hooks (Before/After, mark_flaky para @flaky)
│   │   └── helpers/
│   │       ├── browser_helper.rb  # Configuração de drivers (Chrome/Headless)
│   │       ├── data_helper.rb     # Helper para carregar dados YAML
│   │       └── page_helper.rb     # Helper de páginas (Page Object)
│   ├── formulario.feature         # Cenários do formulário
│   ├── login.feature              # Cenários de login
│   ├── register.feature           # Cenários de registro
│   └── validacao_otp.feature       # Cenários de validação OTP (email e SMS)
├── reports/
│   ├── allure-results/            # Resultados do Allure (gerado na execução)
│   ├── allure-report/             # Relatório Allure (gerado após testes)
│   └── screenshots/               # Screenshots de falhas (gerado automaticamente)
├── scripts/
│   └── test_hook.sh               # Hook para TEST=@tag (Git Bash)
├── cucumber.yaml                  # Perfis (default, retry_flaky, smoke, regression)
├── Gemfile                        # Dependências do projeto
├── Rakefile                       # Tasks de teste, Allure e limpeza
└── README.md                      # Este arquivo
```

## Funcionalidades

### Cenários de Teste

O projeto contém cenários de **login**, **registro**, **formulário** e **validação OTP**, organizados por tags.

#### Tags principais

| Tag | Uso |
|-----|-----|
| `@smoke` | Conjunto reduzido de cenários críticos |
| `@regression` | Suíte de regressão completa |
| `@flaky` | Cenários instáveis ou dependentes de comportamento não garantido pela aplicação (marcados como flaky no Allure) |
| `@flaky_register` | Cenários flaky específicos do registro |
| `@formulario` | Cenários do formulário |
| `@otpEmail`, `@otpSMS` | Validação OTP por e-mail ou SMS |

#### Login (`login.feature`)
- **Positivos:** login com credenciais válidas; login usando dados do YAML
- **Negativos:** email/senha inválidos, campos vazios, formato inválido (mensagens alinhadas à aplicação: *Formato de email inválido.*, *Email ou senha inválidos* ou ausência de login)
- **Exceção (@flaky):** servidor indisponível, timeout, múltiplas falhas, XSS/SQL injection, campos longos, sessão expirada

#### Registro (`register.feature`)
- **Positivos:** registro com sucesso usando dados do arquivo YAML
- **Negativos:** registro com email inválido; cenários com caracteres especiais/SQL injection (`@flaky_register`)

#### Formulário (`formulario.feature`)
- **Positivos:** preenchimento e envio do formulário com dados válidos (data, hora, cor, range, termos)

#### Validação OTP (`validacao_otp.feature`)
- **OTP por e-mail:** envio e validação com código correto ou inválido
- **OTP por SMS:** envio e validação com código correto ou inválido

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
Page Object da página de login com métodos para preenchimento, ações (login, clicar em botões) e validações (mensagens de sucesso/erro, estado logado). As mensagens de erro aceitam variações da aplicação (ex.: *Formato de email inválido.*, *Email ou senha inválidos* ou fallback *não logado*).

#### RegisterPage
Page Object da página de registro com métodos para preencher campos (nome, email, senha, telefone, endereço, cidade, etc.), ações (criar conta) e validações (mensagem de sucesso).

#### FormularioPage
Page Object do formulário com preenchimento de campos (data, hora, cor, range), termos e envio.

#### ValidacaoOtpPage
Page Object da validação OTP com fluxos por e-mail e por SMS (envio e preenchimento dos dígitos).

### Step Definitions

Os step definitions estão em arquivos por feature (`login_steps`, `register_steps`, `formulario_steps`, `validacao_otp_steps`) e organizados em categorias:
- **Inicialização**: Setup da página
- **Preenchimento**: Preencher campos do formulário
- **Ações**: Clicar em botões
- **Validações**: Verificar mensagens e estados

### Hooks (`support/hooks.rb`)
- **Before:** maximiza a janela do navegador
- **Before('@flaky'):** marca o cenário como flaky no Allure (`Allure.set_flaky`) para relatórios
- **After (falha):** captura screenshot e anexa ao Allure

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

Os dados estão em `features/data/user.yaml`:

```yaml
default_user:
  email: "teste@email.com"
  password: "senha123"

invalid_user:
  email: "teste@qaplayground.com"
  password: "senha_errada"

register_user:
  nome: "John Doe"
  email: "teste@email.com"
  cpf: "002.002.002-02"
  data_nascimento: "10-07-1995"
  telefone: "1234567890"
  cep: "61814300"
  endereco: "Rua das Flores"
  numero: 123
  complemento: "Apto 101"
  bairro: "Centro"
  cidade: "Fortaleza"
  estado: "Ceará"
  password: "senha123"
  genero: "Masculino"
```

## Screenshots

O projeto captura automaticamente screenshots quando um cenário falha. Os arquivos são salvos em `reports/screenshots/` com o nome do cenário.

## Relatórios Allure

O relatório Allure é **gerado automaticamente** ao final de cada execução via Rake (`rake`, `rake test`, `TEST=@smoke rake`, etc.). Os resultados ficam em `reports/allure-results/` e o relatório em `reports/allure-report/`.

### Gerar ou regerar o relatório

```bash
bundle exec rake allure:generate
```

### Abrir o relatório no navegador

**Linux / Mac / Git Bash:**

```bash
allure open reports/allure-report
```

**Windows (PowerShell):** use o Allure CLI da mesma forma após instalado:

```powershell
allure open reports/allure-report
```

### Instalar Allure CLI no Windows

**Opção 1: Instalação Manual (Mais Confiável)**

1. Baixe o Allure em: https://github.com/allure-framework/allure2/releases
   - Escolha a versão mais recente (ex: `allure-2.24.1.zip`)
   - Baixe o arquivo ZIP para Windows

2. Extraia o arquivo ZIP em um diretório (ex: `C:\allure`)

3. Adicione ao PATH do sistema:
   - Abra "Variáveis de Ambiente" no Windows
   - Edite a variável `Path` do sistema
   - Adicione o caminho `C:\allure\bin` (ou o caminho onde você extraiu)
   - Clique em OK para salvar

4. Reinicie o PowerShell e teste:
   ```powershell
   allure --version
   ```

**Opção 2: Usando Scoop (Requer Scoop instalado)**

Se você já tem o Scoop instalado:
```powershell
scoop install allure
```

Se não tem o Scoop, instale primeiro:
```powershell
# Instalar Scoop
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex

# Depois instalar Allure
scoop install allure
```

**Opção 3: Usando Docker (Não requer instalação local)**

```powershell
# Gerar relatório
docker run --rm -v "${PWD}/reports/allure-results:/app/allure-results" -v "${PWD}/reports/allure-report:/app/allure-report" "frankescobar/allure-docker-service" allure generate /app/allure-results -o /app/allure-report --clean

# Abrir relatório (requer servidor web local)
docker run --rm -p 5050:5050 -v "${PWD}/reports/allure-report:/app/allure-report" "frankescobar/allure-docker-service" allure open /app/allure-report --host 0.0.0.0 --port 5050
```

**Nota:** O pacote `allure-commandline` não está mais disponível no Chocolatey. Use uma das opções acima.

## Gems Utilizadas

- **cucumber** - Framework BDD
- **capybara** - DSL para testes de interface web
- **selenium-webdriver** - Automação de navegadores
- **webdrivers** - Gerenciamento automático de drivers
- **allure-cucumber** - Integração Allure com Cucumber (relatórios e anexos)
- **allure-rspec** - Suporte Allure para expectativas
- **rspec** - Framework de testes (para expectativas)
- **dotenv** - Gerenciamento de variáveis de ambiente
- **faker** - Geração de dados fake
- **pry** - Debug interativo
- **rake** - Tasks de build e execução

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

### Cenários com tag @flaky falham
- Cenários marcados como `@flaky` testam comportamentos que a aplicação de exemplo pode não implementar (ex.: bloqueio de conta, timeout, mensagens de exceção). Eles são marcados como flaky no Allure para análise. Para rodar só a suíte estável: `bundle exec cucumber -t "@regression" -t "not @flaky"`.

### Relatório Allure vazio ou sem resultados
- Execute os testes antes (`rake test` ou `rake`). Os JSON são gravados em `reports/allure-results/`. Depois execute `rake allure:generate` e `rake allure:open` (ou use o Allure CLI diretamente).

## Contribuindo

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/nova-funcionalidade`)
3. Commit suas mudanças (`git commit -m 'Adiciona nova funcionalidade'`)
4. Push para a branch (`git push origin feature/nova-funcionalidade`)
5. Abra um Pull Request
