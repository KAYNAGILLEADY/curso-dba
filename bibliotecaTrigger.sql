CREATE OR REPLACE FUNCTION estoque_livros (operacao varchar) 
RETURNS TRIGGER LANGUAGE plpgsql AS $$ 
	
DECLARE
--variaveis
	qtde_exemplares INTEGER := 0;

BEGIN
--corpo da função
	SELECT exemplares FROM livro
	WHERE id = NEW.fklivro
	INTO qtde_exemplares;

IF operacao = 'emprestimo' THEN
	IF qtde_exemplares > 0 THEN
		UPDATE livro SET exemplares = exemplares - 1
		WHERE id = NEW.fklivro;
	ELSE 
		RAISE EXCEPTION 'livro indisponível no momento';
	END IF;
ELSE IF operacao = 'devolucao' THEN
	UPDATE livro SET exemplares = exemplares + 1 
	WHERE id = NEW.fklivro;
END IF;
	RETURN NEW;
END;
$$;

CREATE OR REPLACE TRIGGER log_emprestimo
BEFORE INSERT ON emprestimo
FOR EACH ROW
EXECUTE PROCEDURE estoque_livros('emprestimo');

CREATE OR REPLACE TRIGGER log_devolucao
BEFORE UPDATE ON emprestimo
FOR EACH ROW
EXECUTE PROCEDURE estoque_livros('devolucao');

INSERT INTO emprestimo(dataretirada, datadevolucao, multa, fklivro,fkusuario) VALUES
('2023-02-10', '2023-02-17', 0,1,1);

SELECT id, exemplares FROM livro ORDER BY id;