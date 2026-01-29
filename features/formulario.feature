Feature: Formulário
    As a user
    I want to fill the form
    In order to submit it

    # ============================================
    # CENÁRIOS POSITIVOS
    # ============================================
    @smoke @regression @formulario
    Scenario: Fill the form with valid data
        Given que estou na pagina de formulário
        When preencho os campos do formulário com dados válidos
        And preencho a data com "10-07-1995"
        And preencho a hora com "12:00"
        And seleciono uma cor na paleta de cores
        And deixo o range no valor 75
        And aceito os termos e condições
        And clico no botão "Enviar"
        Then devo ver a mensagem "Formulário enviado com sucesso!"