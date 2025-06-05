*** Settings ***    
Documentation    Arquivo de testes para Endpoint/produtos  
Resource    ../keywords/produtos_keywords.robot
Resource    ../keywords/login_keywords.robot
Resource    ../keywords/usuarios_keywords.robot
Resource    ../keywords/carrinho_keywords.robot

Suite Setup     Criar Sessao  

*** Test Cases ***
CT-017:Cadastro de produto válido

    [Tags]    Postproduto

    Criar dados validos

    Enviar requisição POST para /usuarios

    Gerar credenciais

    Enviar requisição POST para /login
    
    Salvar token gerado

    Cadastrar produto
    
    ${response_produto}=    Enviar requisição POST para /produtos com token

    ${idproduto}=    Extrair ID do produto   ${response_produto}  

    Validar status code 201
    
    Verificar mensagem de sucesso e presença do ID do produto

CT-021 - - Atualização de produto válido

    [Tags]    Putproduto
    
    Alterar nome produto

    Enviar requisição PUT para /produtos/id com token    ${idproduto}
    
    Validar status code "200"
    
    Verificar mensagem de sucesso e alterações aplicadas

CT-023 - - Listagem de produtos válida
    
    [Tags]    Getprodutos
    
    Criar dados validos

    Enviar requisição POST para /usuarios

    Gerar credenciais
    
    Enviar requisição GET para /produtos com token
    
    Validar status code 200
    
    Verificar que a lista contém produtos válidos

CT-025 - - Exclusão de produto válido

    Criar dados validos

    Enviar requisição POST para /usuarios

    Gerar credenciais

    Enviar requisição POST para /login
    
    Salvar token gerado

    Cadastrar produto
    
    ${response_produto}=    Enviar requisição POST para /produtos com token

    Extrair ID do produto   ${response_produto} 

    Enviar requisição DELETE para /produtos/id com token    ${idproduto} 
    
    Validar status code 200
    
    Verificar mensagem de sucesso, e exclusao de produto 


CT-026 - - Exclusão de produto vinculado a carrinho
    
    Criar dados validos

    Enviar requisição POST para /usuarios

    Gerar credenciais

    Enviar requisição POST para /login
    
    Salvar token gerado

    
    Cadastrar produto

    ${response_produto}=    Enviar requisição POST para /produtos com token
    
    Extrair ID do produto   ${response_produto}
    
    
    Criar carrinho

    Enviar requisição POST para /carrinhos

    Extrair ID do carrinho    ${response}
    
    Enviar requisição DELETE para /produtos/id com token    ${idproduto} 
    
    Validar status code 400
    
    Verificar mensagem indicando vínculo com carrinho

