-- TABELA ENTIDADE
SELECT * FROM autores;
SELECT * FROM livros;
SELECT * FROM categorias;
-- TABELA RELAÇÃO (livros , autores)
SELECT * FROM livrosautores;

--Criação e atualização.
ALTER TABLE autores ADD idade int;
UPDATE autores SET idade = 25 /*Dados duvidosos*/ WHERE nacionalidade = 'Brasileiro' OR nacionalidade = 'Brasileira';
UPDATE autores SET idade = 20 /*Dados duvidosos*/ WHERE nacionalidade LIKE 'N%';

ALTER TABLE categorias ADD classificacao int;
UPDATE categorias SET classificacao = 5 /*Dados duvidosos*/ WHERE descricao LIKE '_o%';
UPDATE categorias SET classificacao = 10 /*Dados duvidosos*/ WHERE descricao LIKE '_a%';

ALTER TABLE livros ADD generoliterario varchar;
UPDATE livros SET generoliterario = 'Romance' /*FONTE: professora*/ WHERE titulo <> 'Mundo de Gelo e Fogo';
UPDATE livros SET generoliterario = 'Enciclopédia' /*FONTE: professora*/ WHERE titulo = 'Mundo de Gelo e Fogo';

ALTER TABLE categorias
RENAME COLUMN classificacao TO avaliacao;

ALTER TABLE categorias
ALTER COLUMN avaliacao TYPE numeric(2,1);

UPDATE categorias SET avaliacao = 5.2 /*Dados duvidosos*/ WHERE descricao LIKE '_o%';
UPDATE categorias SET avaliacao = 7.5 /*Dados duvidosos*/ WHERE descricao LIKE '_a%';

SELECT idautor, idade FROM autores
ORDER BY idade ASC;

SELECT idcategoria ,avaliacao FROM categorias
ORDER BY avaliacao ASC;

SELECT idlivro ,generoliterario FROM livros
ORDER BY generoliterario ASC;


SELECT idautor, idade FROM autores
ORDER BY idade DESC;

SELECT idcategoria ,avaliacao FROM categorias
ORDER BY avaliacao DESC;

SELECT idlivro ,generoliterario FROM livros
ORDER BY generoliterario DESC;