CREATE OR REPLACE TRIGGER cliente_log
AFTER INSERT OR UPDATE OR DELETE
ON clientes
FOR EACH ROW
EXECUTE PROCEDURE cliente_log_table('001');

CREATE OR REPLACE FUNCTION cliente_log_table()
RETURNS TRIGGER LANGUAGE plpgsql AS $$

BEGIN

	INSERT INTO clientes_auditoria (operacao, dataehora, id_funcionario) VALUES
	(TG_OP, CURRENT_TIMESTAMP, TG_ARGV[0]);

RETURN NEW;
END;
$$;


CREATE OR REPLACE TRIGGER funcionario_log
AFTER INSERT OR UPDATE OR DELETE
ON funcionarios
FOR EACH ROW
EXECUTE PROCEDURE funcionario_log_table('001');

CREATE OR REPLACE FUNCTION funcionario_log_table()
RETURNS TRIGGER LANGUAGE plpgsql AS $$

BEGIN

	INSERT INTO funcionarios_auditoria (operacao, dataehora, id_funcionario) VALUES
	(TG_OP, CURRENT_TIMESTAMP, NEW.id_funcionario);

RETURN NEW;
END;
$$;


CREATE OR REPLACE TRIGGER produto_log
AFTER INSERT OR UPDATE OR DELETE
ON produtos
FOR EACH ROW
EXECUTE PROCEDURE produto_log_table('001');

CREATE OR REPLACE FUNCTION produto_log_table()
RETURNS TRIGGER LANGUAGE plpgsql AS $$

BEGIN

	INSERT INTO produtos_auditoria (operacao, dataehora, id_funcionario) VALUES
	(TG_OP, CURRENT_TIMESTAMP, TG_ARGV[0]);

RETURN NEW;
END;
$$;

CREATE OR REPLACE TRIGGER produto_venda_log
AFTER INSERT OR UPDATE OR DELETE
ON vendas
FOR EACH ROW
EXECUTE PROCEDURE venda_log_table('001');

CREATE OR REPLACE FUNCTION venda_log_table()
RETURNS TRIGGER LANGUAGE plpgsql AS $$

BEGIN

	INSERT INTO vendas_auditoria (operacao, dataehora, id_funcionario) VALUES
	(TG_OP, CURRENT_TIMESTAMP, TG_ARGV[0]);

RETURN NEW;
END;
$$;

CREATE OR REPLACE TRIGGER produto_venda_log
AFTER INSERT OR UPDATE OR DELETE
ON produtos_vendas
FOR EACH ROW
EXECUTE PROCEDURE produto_venda_log_table('001');

CREATE OR REPLACE FUNCTION produto_venda_log_table()
RETURNS TRIGGER LANGUAGE plpgsql AS $$

BEGIN

	INSERT INTO produtos_vendas_auditoria (operacao, dataehora, id_funcionario) VALUES
	(TG_OP, CURRENT_TIMESTAMP, TG_ARGV[0]);

RETURN NEW;
END;
$$;
