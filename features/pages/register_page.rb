require_relative "base_page"

class RegisterPage < BasePage
    PATH = "/pages/junior/formularios/registro.html"

    def visit_page
      visit PATH
    end

    def fill_name(name)
      fill_in "nome", with: name
    end

    def fill_email(email)
      fill_in "email", with: email
    end

    def fill_password(password)
        fill_in "senha", with: password
    end

    def fill_confirm_password(confirm_password)
        fill_in "confirmar-senha", with: confirm_password
    end

    def fill_cpf(cpf)
        fill_in "cpf", with: cpf
    end

    def fill_data_nascimento(data_nascimento)
        fill_in "nascimento", with: data_nascimento
    end

    def fill_telefone(telefone)
        fill_in "telefone", with: telefone
    end

    def fill_cep(cep)
        fill_in "cep", with: cep
    end

    def fill_endereco(endereco)
        fill_in "endereco", with: endereco
    end

    def fill_numero(numero)
        fill_in "numero", with: numero
    end

    def fill_complemento(complemento)
        fill_in "complemento", with: complemento
    end

    def fill_bairro(bairro)
        fill_in "bairro", with: bairro
    end

    def fill_cidade(cidade)
        fill_in "cidade", with: cidade
    end

    def fill_estado(estado)
        fill_in "estado", with: estado
    end

    def dropdown_genero(genero)
      select genero, from: "genero"
    end

    def dropdown_estado(estado)
      select estado, from: "estado"
    end

    def click_termo_de_uso_checkbox
      check "aceite-termos"
    end
end