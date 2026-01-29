Given("que estou na página de registro") do
  register_page.visit_page
end

When("preencho os campos de registro com credenciais válidas do arquivo de dados") do
  user = load_data("user.yaml")["register_user"]
  register_page.fill_name(user["nome"])
  register_page.fill_email(user["email"])
  register_page.fill_cpf(user["cpf"])
  register_page.fill_data_nascimento(user["data_nascimento"])
  register_page.fill_telefone(user["telefone"])
  register_page.dropdown_genero(user["genero"])
  register_page.fill_cep(user["cep"])
  register_page.fill_endereco(user["endereco"])
  register_page.fill_numero(user["numero"])
  register_page.fill_complemento(user["complemento"])
  register_page.fill_bairro(user["bairro"])
  register_page.fill_cidade(user["cidade"])
  register_page.dropdown_estado(user["estado"])
  register_page.fill_password(user["password"])
  register_page.fill_confirm_password(user["password"])
  register_page.click_termo_de_uso_checkbox
end

