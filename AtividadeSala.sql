/*
	ALUNO: Kaynã Gilleady
	DIA: 09-02-2023
	DESCRICAO: Exercícios em sala com duas tabelas (alunos, cursos)
*/

----- Configurações da Tabela -----
CREATE table alunos (
	aluno_id varchar,
  	nome varchar,
  	dataNasc DATE,
  	cidade varchar,
  	Fkcurso varchar,
  	PRIMARY KEY (aluno_id),
  	FOREIGN KEY(Fkcurso) REFERENCES cursos(curso_id)
);

CREATE TABLE cursos (
	curso_id varchar PRIMARY KEY,
  	descricao VARCHAR,
  	segmento varchar,
  	unidade varchar
);

INSERT into cursos
VALUES 
	('001', 'Engenharia Eletrónica', 'TI', 'Uni-Goiás'),
	('002', 'Engenharia de Software', 'TI', 'PUC-GO');

INSERT INTO alunos 
VALUES 
	('001', 'Raphael Abenom', '1943-05-20', 'New York', '002'), 
	('002', 'Biel', '2005-01-21', 'Trindade', '001'),
    ('003', 'Curinga', '2012-10-25', 'Moscou', '002');


SELECT * FROM alunos;
SELECT * FROM cursos;


-- 1) Crie uma consulta que mostre a quantidade de alunos por curso.
-- Ordene o Result Set de modo decrescente.

SELECT descricao, COUNT(alunos.*) AS qtd_Alunos
FROM alunos, cursos
GROUP BY descricao
ORDER BY qtd_Alunos DESC;

-------- Com JOIN ---------
SELECT descricao, COUNT(alunos.*) AS qtd_Alunos
FROM alunos
FULL OUTER JOIN cursos
ON alunos.Fkcurso = cursos.id
GROUP BY descricao
ORDER BY qtd_Alunos DESC;



-- 2) Crie uma consulta que mostre o total de alunos por segmento.
-- Ordene o Result Set de modo decresente

SELECT segmento, COUNT(*) AS qtd_Alunos
FROM alunos, cursos
GROUP BY segmento
ORDER BY qtd_Alunos DESC;

-------- Com JOIN ---------
SELECT segmento, COUNT(*) AS qtd_Alunos
FROM alunos
FULL OUTER JOIN cursos
ON alunos.Fkcurso = cursos.id
GROUP BY segmento
ORDER BY qtd_Alunos DESC;



-- 3) Calcule a idade dos alunos e acrescente uma coluna com esta informação à tabela original
SELECT (CURRENT_DATE - dataNasc) / 365 AS idade FROM alunos;

ALTER TABLE alunos
ADD COLUMN idade NUMERIC;

UPDATE alunos SET idade = (CURRENT_DATE - dataNasc) / 365::int;



-- 4) Conte quantos estudantes existem em cada uma das seguintes faixas etárias:

------ intervalos fechados -------
--		12 a 18 anos
--		19 a 24 anos
-- 		25 a 42 anos
--		43 anos ou mais

SELECT 
	(SELECT COUNT(*) FROM alunos WHERE idade BETWEEN 12 AND 18) AS faixaetaria12a18,
	(SELECT COUNT(*) FROM alunos WHERE idade BETWEEN 19 AND 24) AS faixaetaria19a24,
	(SELECT COUNT(*) FROM alunos WHERE idade BETWEEN 25 AND 42) AS faixaetaria25a42,
	(SELECT COUNT(*) FROM alunos WHERE idade > 43) AS faixaetariamaisde43