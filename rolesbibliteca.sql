
-- 1)
CREATE ROLE bibliotecario WITH
LOGIN ENCRYPTED PASSWORD 'bibli123'
CONNECTION LIMIT 5;

CREATE ROLE leitor WITH
LOGIN ENCRYPTED PASSWORD 'leitor123';

CREATE ROLE gerente WITH
LOGIN ENCRYPTED PASSWORD 'gerente123'
CONNECTION LIMIT 2;


----------------------------------
-- 2)
-- bibliotecario
GRANT SELECT ON 
	autor, 
	editora,
	livro,
	usuario
TO bibliotecario
WITH GRANT OPTION;

GRANT INSERT, UPDATE ON 
	emprestimo
TO bibliotecario
WITH GRANT OPTION;

-- leitor
GRANT SELECT ON 
	autor, 
	editora,
	livro
TO leitor
WITH GRANT OPTION;

-- gerente
GRANT SELECT, INSERT, UPDATE, DELETE ON
	autor,
	editora,
	livro
TO gerente
WITH GRANT OPTION;

GRANT SELECT ON 
	usuario
TO gerente
WITH GRANT OPTION;

-----------------------------------------
-- 3)
GRANT TRIGGER ON TABLE livro TO gerente;

GRANT TRIGGER ON TABLE livro TO bibliotecario;
