CREATE OR REPLACE TRIGGER trg_cliente_bi
  -- +=================================================================+
  -- |             Copyright (c) 2025 Source2IT Tecnologia             |
  -- |      São José do Rio Preto, Brasil, All rights reserved.        |
  -- +=================================================================+
  -- | FILENAME                                                        |
  -- |   TRG_CLIENTE_BI.trg                                            |
  -- |                                                                 |
  -- | DESCRIPTION                                                     |
  -- | Trigger Insert de Clientes                                      |
  -- |                                                                 |
  -- | PARAMETERS                                                      |
  -- |                                                                 |
  -- | CREATED BY                                                      |
  -- |   João Barbosa                        - 13/01/2026              |
  -- |                                                                 |
  -- | UPDATED BY                                                      |
  -- |                                                                 |
  -- +=================================================================+
BEFORE INSERT ON tb_cliente
FOR EACH ROW
BEGIN
  IF :NEW.id_cliente IS NULL THEN
    :NEW.id_cliente := seq_cliente.NEXTVAL;
  END IF;

  IF :NEW.dt_criacao IS NULL THEN
    :NEW.dt_criacao := SYSTIMESTAMP;
  END IF;
END;
