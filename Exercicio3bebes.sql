/*
	ALUNO: 'Kaynã Gilleady'
	DIA: '26-01-2023'
	DESCRICAO: 'Exercício de fixação 2'
*/

-- 1) Selecione apenas os registros cujo estado civil da mãe seja solteira, casada ou viúva. Orderne o Result Set pelo id dos registros.
SELECT * FROM bebe
WHERE estadocivilmae IN('solteira', 'casada', 'viuva')
ORDER BY id ASC;

-- 2) Selecione apenas os registros cujas semanas de gestação estejam entre 36 e 42. Ordene o Result Set pelo id dos registros.
SELECT * FROM bebe
WHERE qtdsemanas BETWEEN 36 AND 42
ORDER BY id ASC;

-- 3) Mostre o estado civil e a idade da mãe do bebê de menor idade gestacional.
SELECT estadocivilmae, idademae, qtdsemanas
FROM bebe
WHERE qtdsemanas = (SELECT MIN(qtdsemanas) FROM bebe) 
	AND estadocivilmae NOTNULL;

	-- OU PODE SER FEITO DESSA OUTRA MANEIRA // Creditos: Raphael Abenom --

SELECT estadocivilmae, idademae, qtdsemanas
FROM bebe
GROUP BY estadocivilmae, idademae, qtdsemanas
ORDER BY qtdsemanas, idademae;


-- 4) Mostre o id e a coluna óbito dos registros que possuem malformação.
SELECT id, obito FROM bebe
WHERE malformacao LIKE 'sim';

/* 
	5) Mostre no mesmo Result Set, separado por estado civil, apenas dentre as mães
	solteiras, casadas e viúvas:
	
	- A menor idade da mãe
	- A maior idade da mãe
	- A média de idade das mães
	
	Formate os números para que sejam exibidos como valores inteiros. Crie
	também um Alias para cada coluna do Result Set.
*/
SELECT estadocivilmae,
	MIN(idademae)::int AS menoridade,
	MAX(idademae)::int AS maioridade,
	AVG(idademae)::int AS mediaidade
FROM bebe
WHERE estadocivilmae IN('solteira', 'casada', 'viuva')
GROUP BY estadocivilmae
ORDER BY menoridade ASC, maioridade DESC, mediaidade ASC;


/*
	6) Crie uma view que mostre:
	
		- O peso mínimo do bebê
		- O peso máximo do bebê
		- O peso médio do bebê
		
	Separado por tipo de parto. Formate os números para que apareçam com apenas 2 casas
	decimais após a vírgula. Crie um alias para cada uma das colunas.
*/
CREATE VIEW tipos_de_peso_em_parto AS
SELECT tipoparto,
	MIN(peso)::numeric(50,2) AS pesomin,
	MAX(peso)::numeric(50,2) AS pesomax,
	AVG(peso)::numeric(50,2) AS pesomedia
	FROM bebe
GROUP BY tipoparto
HAVING tipoparto NOTNULL
ORDER BY tipoparto;

-- 7) Mostre o id e o peso dos registros cujo peso do bebê seja maior do que a média.
SELECT id::int, peso::int FROM bebe
WHERE peso > (SELECT AVG(peso) FROM bebe)
ORDER BY id ASC;