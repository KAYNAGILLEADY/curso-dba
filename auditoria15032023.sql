CREATE TABLE livros_auditoria (
	id_log serial PRIMARY KEY,
	operacao varchar,
	dataHora timestamp with time zone,
	fk_livro integer REFERENCES livro(id),
	fk_usuario integer REFERENCES usuario(id)
);

CREATE OR REPLACE
TRIGGER log_livros
AFTER INSERT OR UPDATE OR DELETE ON livro
FOR EACH ROW
EXECUTE FUNCTION auditoria_livro(1);


CREATE OR REPLACE 
FUNCTION auditoria_livro()
RETURNS TRIGGER LANGUAGE plpgsql 
AS $$

BEGIN
	
	INSERT INTO livros_auditoria (operacao, datahora, id_livro, id_usuario) 
	VALUES
	(TG_OP, CURRENT_TIMESTAMP, NEW.id, TG_ARGV[0]::int);
	
RETURN NEW;
END;
$$;

UPDATE livro SET exemplares = exemplares - 1 where ID = 5;

select * from public.livros_auditoria;