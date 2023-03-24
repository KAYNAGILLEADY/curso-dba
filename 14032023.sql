-- Transação emprestimo
BEGIN;

INSERT INTO emprestimo (id, dataretirada, datadevolucao, fklivro, fkusuario)
VALUES (2, '2023-03-14', '2023-03-14', 1, 1);

UPDATE livro
SET exemplares = exemplares - 1
WHERE id = 2;

COMMIT;


CREATE OR REPLACE TRIGGER log_emprestimo
BEFORE INSERT ON emprestimo
FOR EACH ROW
WHEN (
	(select exemplares from livro where id = new.fklivro) > 0 
)
EXECUTE PROCEDURE UPDATE livro SET exemplares = exemplares - 1 WHERE id = new.fklivro;

drop trigger log_emprestimo

CREATE OR REPLACE FUNCTION realizar_emprestimo()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN

	INSERT INTO emprestimo (id, dataretirada, datadevolucao, fklivro, fkusuario)
	VALUES (2, '2023-03-14', '2023-03-14', 1, 1);

	UPDATE livro
	SET exemplares = exemplares - 1
	WHERE id = new.fklivro;

	COMMIT;

RETURN NEW;
END;
$$;

DROP FUNCTION realizar_emprestimo();