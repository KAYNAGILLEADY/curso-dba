	

	SELECT * FROM autores WHERE nacionalidade = 'Brasileiro';
	SELECT * FROM autores WHERE nacionalidade = 'Machado de Assis' OR nome  = 'George R.R. Martin';

	SELECT * FROM categorias WHERE descricao <> 'Romance';
	SELECT * FROM categorias WHERE descricao = 'Fantasia' AND idcategoria = 2;

	SELECT * FROM livros WHERE ano >= 1950;
	SELECT * FROM livros WHERE ano >= 1950 AND titulo LIKE 'A%';

	SELECT * FROM livrosautores WHERE idautor = 1;
	SELECT * FROM livrosautores WHERE idautor = 1 OR NOT idautor = 1;