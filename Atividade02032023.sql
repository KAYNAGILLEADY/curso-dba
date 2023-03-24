-- 2)
CREATE TABLE alunos (
	id_aluno serial PRIMARY KEY,
	nome varchar,
	curso varchar,
	nota numeric,
	situacao varchar default 'Em andamento'
);

INSERT INTO alunos (nome, curso, nota) VALUES
('Kaynã Gilleady', 'Engenharia de Software', 6.5),
('Mateus', 'DBA', 7),
('Raphael Abenom', 'ADS', 10),
('Leonardo', 'ADS', 6);


DO 
$$
DECLARE
	nota RECORD;
BEGIN
	FOR nota IN select * from alunos LOOP
		IF nota.nota >= 7 THEN
			RAISE NOTICE '%', nota.nota;
		END IF;
	END LOOP;
END;
$$;
------------------------------------------------------
-- 3)
SELECT * FROM alunos;

INSERT INTO alunos (nome, curso, nota) VALUES
('Gabriel', 'Administrador de Redes', 4);

DO 
$$
DECLARE
	aluno RECORD;
BEGIN
	FOR aluno IN SELECT * FROM alunos LOOP
		IF aluno.nota >= 6 AND aluno.nota < 7 THEN
			UPDATE alunos SET situacao = 'Recuperação'
			WHERE id_aluno = aluno.id_aluno;
		ELSIF aluno.nota >= 7 THEN
			UPDATE alunos SET situacao = 'Aprovado'
			WHERE id_aluno = aluno.id_aluno;
		ELSE
			UPDATE alunos SET situacao = 'Reprovado'
			WHERE id_aluno = aluno.id_aluno;
		END IF;
	END LOOP;
END;
$$;
------------------------------------------------------
-- 4)
CREATE OR REPLACE FUNCTION situacao ()
RETURNS TRIGGER LANGUAGE plpgsql AS $$

DECLARE
	aluno RECORD;
	msg varchar := 'Sem sucesso';
BEGIN
	FOR aluno IN SELECT * FROM alunos LOOP
		IF aluno.nota >= 6 AND aluno.nota < 7 THEN
			UPDATE alunos SET situacao = 'Recuperação'
			WHERE id_aluno = aluno.id_aluno;
		ELSIF aluno.nota >= 7 THEN
			UPDATE alunos SET situacao = 'Aprovado'
			WHERE id_aluno = aluno.id_aluno;
		ELSE
			UPDATE alunos SET situacao = 'Reprovado'
			WHERE id_aluno = aluno.id_aluno;
		END IF;
	END LOOP;
	msg := 'Concluido com sucesso';
	RAISE NOTICE '%', msg;
	RETURN NEW;
END;
$$;

SELECT situacao();

------------------------------------------------------
-- 5)
CREATE OR REPLACE TRIGGER log_situacao
AFTER INSERT ON alunos
FOR EACH ROW
EXECUTE PROCEDURE logFunction_situacao();

CREATE OR REPLACE FUNCTION logFunction_situacao ()
RETURNS TRIGGER LANGUAGE plpgsql AS $$

DECLARE
	msg varchar := 'Sem sucesso';
BEGIN
		IF NEW.nota >= 6 AND NEW.nota < 7 THEN
			UPDATE alunos SET situacao = 'Recuperação'
			WHERE id_aluno = NEW.id_aluno;
		ELSIF NEW.nota >= 7 THEN
			UPDATE alunos SET situacao = 'Aprovado'
			WHERE id_aluno = NEW.id_aluno;
		ELSE
			UPDATE alunos SET situacao = 'Reprovado'
			WHERE id_aluno = NEW.id_aluno;
		END IF;
	msg := 'Concluido com sucesso';
	RAISE NOTICE '%', msg;
	RETURN NEW;
END;
$$;

INSERT INTO alunos (nome, curso, nota) VALUES
('Luciano', 'Músico', 5);

DELETE FROM alunos where id_aluno in (13,14,15)

SELECT * FROM alunos ORDER BY id_aluno;

------------------------------------------------------
-- 6)

------------------------------------------------------
-- 7)
ALTER TABLE alunos
ALTER COLUMN situacao
	DROP DEFAULT;
	
ALTER TABLE alunos
ALTER COLUMN situacao
	SET DEFAULT 'Cursando';
	
ALTER TABLE alunos
ALTER COLUMN nota
	SET DEFAULT 0.0;

------------------------------------------------------
-- 8)
CREATE OR REPLACE TRIGGER log_situacao
BEFORE UPDATE ON alunos
FOR EACH ROW
EXECUTE PROCEDURE logFunction_situacao();

CREATE OR REPLACE FUNCTION logFunction_situacao ()
RETURNS TRIGGER LANGUAGE plpgsql AS $$

DECLARE
	msg varchar := 'Sem sucesso';
	valorSituacao varchar;
BEGIN
		IF NEW.nota >= 6 AND NEW.nota < 7 THEN
			valorSituacao = 'Aprovado';
		ELSIF NEW.nota >= 7 THEN
			valorSituacao = 'Recuperação';
		ELSE
			valorSituacao = 'Reprovado';
		END IF;
	msg := 'Concluido com sucesso';
	RAISE NOTICE '%', msg;
	NEW.situacao = valorSituacao;
	RETURN NEW;
END;
$$;

SELECT * FROM alunos ORDER BY id_aluno desc;

INSERT INTO alunos (nome, curso) VALUES
('Marcos', 'DBA');

UPDATE alunos SET nota = 10 WHERE id_aluno = 19;