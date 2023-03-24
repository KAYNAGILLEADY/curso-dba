-- 1) Crie e popule as tabelas do banco de dados conforme Atividade 5 - UC2.

-- 2) Acrescente o campo "dataPrevista" à tabela emprestimo.
SELECT * FROM emprestimo;

ALTER TABLE emprestimo
ADD COLUMN dataPrevista date;

-- 3) Crie uma trigger + função que verifique, antes de um 
-- empréstimo ocorrer, se há exemplares disponíveis.
-- Se não houver, o usúario...

CREATE OR REPLACE FUNCTION baixa_estoque() 
   RETURNS TRIGGER 
   LANGUAGE plpgsql
AS $$
DECLARE 
	qtde_Exemplares int;
	
BEGIN
	SELECT exemplares 
    FROM livro
	WHERE id = NEW.fklivro
	INTO qtde_Exemplares;
		
    IF qtde_Exemplares < 0 THEN
        RAISE EXCEPTION 'Não há exemplares disponíveis para este livro';
	ELSE
		UPDATE livro SET exemplares = exemplares - 1
		WHERE id = NEW.fklivro;
    END IF;
	
	RETURN NEW;
END;
$$;

CREATE TRIGGER log_baixa_estoque
BEFORE INSERT ON emprestimo
FOR EACH ROW
EXECUTE FUNCTION baixa_estoque();

SELECT * FROM livro;
SELECT * FROM emprestimo;

INSERT INTO emprestimo (id, dataretirada, datadevolucao, multa, fklivro, fkusuario, dataprevista) VALUES
(4, CURRENT_DATE, '2023-05-10', 0, 30, 1, CURRENT_DATE + 7);

-- 4) Crie outra trigger + função para registrar
-- a devolução de um livro.
-- Se a data atual for maior...

CREATE OR REPLACE FUNCTION devolucao_livro ()
RETURNS TRIGGER LANGUAGE plpgsql AS $$

DECLARE
	dataAtraso integer;

BEGIN
	
	dataAtraso := NEW.datadevolucao - NEW.dataPrevista;
	
	IF dataAtraso > 0 THEN
		NEW.multa = dataAtraso * 1;
	END IF;

	UPDATE livro SET exemplares = exemplares + 1
	WHERE id = NEW.fklivro;
	
	RETURN NEW;
END;
$$;


CREATE OR REPLACE TRIGGER log_devolucao_livro
BEFORE UPDATE ON emprestimo
FOR EACH ROW
EXECUTE FUNCTION devolucao_livro();

UPDATE emprestimo SET datadevolucao = '2023-03-16'
WHERE id = 2;

-- 5) Crie uma trigger + procedure que popule uma tabela
-- chamada emprestimos_bkp com os mesmos dados que
-- forem inseridos na tabela emprestimos.

CREATE TABLE emprestimos_bkp (
	id serial,
    dataretirada date NOT NULL,
    datadevolucao date NOT NULL,
    multa numeric(10,2),
    fklivro integer,
    fkusuario integer,
	dataprevista date
);

CREATE OR REPLACE TRIGGER log_bkp_emprestimo
BEFORE INSERT OR UPDATE OR DELETE ON emprestimo
FOR EACH ROW
EXECUTE PROCEDURE bkp_emprestimo();

CREATE OR REPLACE FUNCTION bkp_emprestimo ()
RETURNS TRIGGER LANGUAGE plpgsql AS $$

DECLARE
	registro RECORD;
BEGIN
	TRUNCATE emprestimos_bkp;
	
	FOR registro IN SELECT * FROM emprestimo LOOP
		INSERT INTO emprestimos_bkp (id, dataretirada, datadevolucao, multa, fklivro, fkusuario, dataprevista) VALUES
		(NEW.id, NEW.dataretirada, NEW.datadevolucao, NEW.multa, NEW.fklivro, NEW.fkusuario, NEW.dataprevista);
	END LOOP;
	RETURN NEW;
END;
$$;


select * from emprestimos_bkp