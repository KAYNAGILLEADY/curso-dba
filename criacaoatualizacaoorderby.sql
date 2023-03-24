
/*CRIAÇÃO COLUNA || ATUALIZÃO DE DADOS*/


ALTER TABLE autores ADD idade int;
UPDATE autores SET idade = 25 /*Dados duvidosos*/ WHERE nacionalidade = 'Brasileiro' OR nacionalidade = 'Brasileira';
UPDATE autores SET idade = 20 /*Dados duvidosos*/ WHERE nacionalidade LIKE 'N%';

ALTER TABLE categorias ADD avaliacao numeric;
UPDATE categorias SET avaliacao = 5.2 /*Dados duvidosos*/ WHERE descricao LIKE '_o%';
UPDATE categorias SET avaliacao = 7.5 /*Dados duvidosos*/ WHERE descricao LIKE '_a%';

ALTER TABLE livros ADD generoliterario varchar;
UPDATE livros SET generoliterario = 'Romance' /*FONTE: professora*/ WHERE titulo <> 'Mundo de Gelo e Fogo';
UPDATE livros SET generoliterario = 'Enciclopédia' /*FONTE: professora*/ WHERE titulo = 'Mundo de Gelo e Fogo';



/*SELEÇÃO*/

SELECT idautor, idade FROM autores
ORDER BY idade DESC;

SELECT idcategoria ,avaliacao FROM categorias
ORDER BY avaliacao DESC;

SELECT idlivro ,generoliterario FROM livros
ORDER BY generoliterario DESC;