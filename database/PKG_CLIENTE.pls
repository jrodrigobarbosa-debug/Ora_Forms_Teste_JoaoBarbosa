create or replace PACKAGE pkg_cliente AUTHID CURRENT_USER AS
  -- +=================================================================+
  -- |      São José do Rio Preto, Brasil, All rights reserved.        |
  -- +=================================================================+
  -- | FILENAME                                                        |
  -- |   PKG_CLIENTE.pls                                               |
  -- |                                                                 |
  -- | Package Specification                                           |
  -- | CRUD de Clientes                                                |
  -- |                                                                 |
  -- | DESCRIPTION                                                     |
  -- | CRUD de Clientes                                                |
  -- |                                                                 |
  -- | PARAMETERS                                                      |
  -- |                                                                 |
  -- | CREATED BY                                                      |
  -- |   João Barbosa                        - 13/01/2026              |
  -- |                                                                 |
  -- | UPDATED BY                                                      |
  -- |                                                                 |
  -- +=================================================================+


  TYPE g_rCliente IS RECORD(id_cliente     tb_cliente.id_cliente %TYPE 
                          , nome           tb_cliente.nome       %TYPE 
                          , email          tb_cliente.email      %TYPE 
                          , cep            tb_cliente.cep        %TYPE 
                          , logradouro     tb_cliente.logradouro %TYPE 
                          , bairro         tb_cliente.bairro     %TYPE 
                          , cidade         tb_cliente.cidade     %TYPE 
                          , uf             tb_cliente.uf         %TYPE 
                          , ativo          tb_cliente.cidade     %TYPE 
                          , dt_criacao     tb_cliente.dt_criacao %TYPE
                          , dt_atualizacao tb_cliente.dt_criacao %TYPE);

  TYPE g_tab_cliente IS TABLE OF g_rCliente
  INDEX BY BINARY_INTEGER;

  TYPE g_rec_Cliente_cur IS REF CURSOR RETURN g_rCliente;

  TYPE g_rSqlCliente IS REF CURSOR;

  PROCEDURE prc_listar_clientes(p_nome           IN     tb_cliente.nome       %TYPE
                              , p_email          IN     tb_cliente.email      %TYPE
                              , p_ClienteCur     IN OUT g_tab_cliente);

  PROCEDURE prc_ins_clientes(p_ClienteCur     IN OUT g_tab_cliente);

  PROCEDURE prc_alt_clientes(p_ClienteCur     IN OUT g_tab_cliente);

  PROCEDURE prc_exc_clientes(p_ClienteCur     IN OUT g_tab_cliente);

  PROCEDURE prc_loc_clientes(p_ClienteCur     IN OUT g_tab_cliente);


END pkg_cliente;
