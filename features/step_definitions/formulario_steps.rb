Given("que estou na pagina de formulário") do
  formulario_page.visit_page
end

When("preencho os campos do formulário com dados válidos") do
    user = load_data("user.yaml")["formulario_user"]
    fill_in "input-text", with: "Preenchendo os campos do formulário com dados válidos"
    formulario_page.fill_email(user["email"])
    formulario_page.fill_senha(user["senha"])
    formulario_page.fill_numero(user["numero"])
end

When("preencho a data com {string}") do |data|
  @data = data
  formulario_page.fill_data(@data)
end

When("preencho a hora com {string}") do |hora|
  @hora = hora
  formulario_page.fill_hora(@hora)
end

When("seleciono uma cor na paleta de cores") do
  formulario_page.select_cor_palette
end

When("deixo o range no valor {int}") do |valor|
  @valor = valor
  formulario_page.set_range(@valor)
end

When("aceito os termos e condições") do
  formulario_page.accept_terms
end