CREATE OR REPLACE TRIGGER trg_cliente_bu
  -- +=================================================================+
  -- |             Copyright (c) 2025 Source2IT Tecnologia             |
  -- |      São José do Rio Preto, Brasil, All rights reserved.        |
  -- +=================================================================+
  -- | FILENAME                                                        |
  -- |   TRG_CLIENTE_BU.trg                                            |
  -- |                                                                 |
  -- |                                                                 |
  -- | DESCRIPTION                                                     |
  -- | Trigger de Update de Clientes                                   |
  -- |                                                                 |
  -- | PARAMETERS                                                      |
  -- |                                                                 |
  -- | CREATED BY                                                      |
  -- |   João Barbosa                        - 13/01/2026              |
  -- |                                                                 |
  -- | UPDATED BY                                                      |
  -- |                                                                 |
  -- +=================================================================+
BEFORE UPDATE ON tb_cliente
FOR EACH ROW
BEGIN
  IF :NEW.dt_atualizacao IS NULL THEN
    :NEW.dt_atualizacao := SYSTIMESTAMP;
  END IF;
END;
