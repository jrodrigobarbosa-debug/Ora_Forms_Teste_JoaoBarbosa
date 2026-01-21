create or replace PACKAGE BODY pkg_cliente AS
  -- +=================================================================+
  -- |      São José do Rio Preto, Brasil, All rights reserved.        |
  -- +=================================================================+
  -- | FILENAME                                                        |
  -- |   PKG_CLIENTE.pls                                               |
  -- |                                                                 |
  -- | Package Body                                                    |
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

  CURSOR g_cur_clientes(pc_nome  IN VARCHAR2
                      , pc_email IN VARCHAR2) IS
  SELECT id_cliente     
       , nome           
       , email          
       , cep            
       , logradouro     
       , bairro         
       , cidade         
       , uf             
       , ativo          
       , dt_criacao     
       , dt_atualizacao 
    FROM tb_cliente
   WHERE 1=1
     AND ((nome LIKE '%'  || pc_nome || '%') OR
         (pc_nome IS NULL))                      
     AND ((email LIKE '%' || pc_email || '%') OR
         (pc_nome IS NULL));                   
/*         
CREATE OR REPLACE PROCEDURE valida_cadastro (
    p_email  IN VARCHAR2,
    p_uf     IN VARCHAR2,
    p_cep    IN VARCHAR2,
    p_nome   IN VARCHAR2,
    p_ativo  IN NUMBER
) IS
BEGIN
    valida_email(p_email);
    valida_email_unico(p_email);
    valida_uf(p_uf);
    valida_cep(p_cep);
    valida_nome(p_nome);
    valida_ativo(p_ativo);
END;
*/  
  PROCEDURE prc_listar_clientes(p_nome               IN tb_cliente.nome       %TYPE
                              , p_email              IN tb_cliente.email      %TYPE
                              , p_ClienteCur     IN OUT g_tab_cliente) IS


    /**********************************************************************************/
    /* NOME PROGRAMA: prc_listar_clientes                                             */
    /* DESCRIÇÃO: Consulta Clientes                                                   */
    /* AUTOR: JoaoBarbosa - 13/01/2026                                                */
    /* REVISÕES:                                                                      */
    /**********************************************************************************/
    v_nInd NUMBER;     
  BEGIN
    BEGIN
      FOR r_cliente IN g_cur_clientes(p_nome
                                    , p_email ) LOOP
        v_nInd := NVL(v_nInd,0)+1;
        p_ClienteCur(v_nInd).id_cliente     := r_cliente.id_cliente;
        p_ClienteCur(v_nInd).nome           := r_cliente.nome;
        p_ClienteCur(v_nInd).email          := r_cliente.email;
        p_ClienteCur(v_nInd).cep            := r_cliente.cep;
        p_ClienteCur(v_nInd).logradouro     := r_cliente.logradouro;
        p_ClienteCur(v_nInd).bairro         := r_cliente.bairro;
        p_ClienteCur(v_nInd).cidade         := r_cliente.cidade;
        p_ClienteCur(v_nInd).uf             := r_cliente.uf;
        p_ClienteCur(v_nInd).ativo          := r_cliente.cidade;
        p_ClienteCur(v_nInd).dt_criacao     := r_cliente.dt_criacao;
        p_ClienteCur(v_nInd).dt_atualizacao := r_cliente.dt_atualizacao;
      END LOOP;
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;

  END prc_listar_clientes;                              
  --
  PROCEDURE prc_ins_clientes(p_ClienteCur     IN OUT g_tab_cliente) IS
    /**********************************************************************************/
    /* NOME PROGRAMA: prc_ins_clientes                                                */
    /* DESCRIÇÃO: Insere Clientes                                                     */
    /* AUTOR: JoaoBarbosa - 13/01/2026                                                */
    /* REVISÕES:                                                                      */
    /**********************************************************************************/
  BEGIN
    BEGIN
      IF p_ClienteCur.COUNT = 0 THEN
        RETURN;
      END IF;
      --
      FOR i IN 1 .. p_ClienteCur.COUNT LOOP
        --
        IF p_ClienteCur(i).id_cliente IS NULL THEN
          SELECT seq_cliente.NEXTVAL INTO p_ClienteCur(i).id_cliente FROM dual;
        END IF;
        --
      END LOOP;
      -- 
      FORALL i IN INDICES OF p_ClienteCur
        --
        INSERT INTO tb_cliente(id_cliente
                            , email
                            , uf
                            , cep
                            , nome
                            , ativo)
                       VALUES(p_ClienteCur(i).id_cliente
                            , p_ClienteCur(i).email
                            , p_ClienteCur(i).uf
                            , p_ClienteCur(i).cep
                            , p_ClienteCur(i).nome
                            , p_ClienteCur(i).ativo);

  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      RAISE_APPLICATION_ERROR(-20001, 'Já existe um cadastro com este e-mail.');
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20002, 'Falha ao inserir registro(s).');      
    END;
  END prc_ins_clientes;

  PROCEDURE prc_alt_clientes(p_ClienteCur     IN OUT g_tab_cliente) IS
    /**********************************************************************************/
    /* NOME PROGRAMA: prc_alt_clientes                                                */
    /* DESCRIÇÃO: Altera Clientes                                                     */
    /* AUTOR: JoaoBarbosa - 13/01/2026                                                */
    /* REVISÕES:                                                                      */
    /**********************************************************************************/
  
  BEGIN
    BEGIN
      IF p_ClienteCur.COUNT = 0 THEN
        RETURN;
      END IF;
      --
      FORALL i IN INDICES OF p_ClienteCur
        UPDATE tb_cliente
           SET email    = p_ClienteCur(i).email
             , uf       = p_ClienteCur(i).uf
             , cep      = p_ClienteCur(i).cep
             , nome     = p_ClienteCur(i).nome
             , ativo    = p_ClienteCur(i).ativo
       WHERE id_cliente = p_ClienteCur(i).id_cliente;


    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        RAISE_APPLICATION_ERROR(-20003, 'Já existe um cadastro com este e-mail.');
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20004, 'Falha ao atualizar registro(s).');
    END;    
  END prc_alt_clientes;    

  PROCEDURE prc_exc_clientes(p_ClienteCur     IN OUT g_tab_cliente) IS
    /**********************************************************************************/
    /* NOME PROGRAMA: prc_exc_clientes                                                */
    /* DESCRIÇÃO: Excluir Clientes                                                    */
    /* AUTOR: JoaoBarbosa - 13/01/2026                                                */
    /* REVISÕES:                                                                      */
    /**********************************************************************************/

  BEGIN
    BEGIN
      --
      IF p_ClienteCur.COUNT = 0 THEN
        RETURN;
      END IF;

      FORALL i IN INDICES OF p_ClienteCur
        DELETE FROM tb_cliente
         WHERE id_cliente = p_ClienteCur(i).id_cliente;

    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20005, 'Falha ao excluir registro(s).');
    END;
  END prc_exc_clientes;
  --
  PROCEDURE prc_loc_clientes(p_ClienteCur     IN OUT g_tab_cliente) IS
    /**********************************************************************************/
    /* NOME PROGRAMA: prc_loc_clientes                                                */
    /* DESCRIÇÃO: Reservar/Bloquear Clientes                                          */
    /* AUTOR: JoaoBarbosa - 13/01/2026                                                */
    /* REVISÕES:                                                                      */
    /**********************************************************************************/

    v_nExists NUMBER;
  BEGIN
    BEGIN
      --
      IF p_ClienteCur.COUNT = 0 THEN
        RETURN;
      END IF;
      --
      FOR i IN 1 .. p_ClienteCur.COUNT LOOP
        SELECT 1
          INTO v_nExists
          FROM tb_cliente
         WHERE id_cliente = p_ClienteCur(i).id_cliente
         FOR UPDATE NOWAIT;
      END LOOP;

  EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE = -54 THEN
        RAISE_APPLICATION_ERROR(-20006, 'Registro em uso por outro usuário. Tente novamente.');
      ELSE
        RAISE_APPLICATION_ERROR(-20007, 'Falha ao bloquear registro(s).');
      END IF;
    END;
  END prc_loc_clientes;
  --

END pkg_cliente;
