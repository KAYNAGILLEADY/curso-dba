/*
	ALUNO: 'Kaynã Gileady',
	DIA: '25-01-2023'
	DESCRICAO: 'Exercício 2 na tabela bebe'
*/

-- Alterando tipos na minha tabela.

ALTER TABLE bebe
ALTER COLUMN id TYPE integer
USING id::integer;

ALTER TABLE bebe
ALTER COLUMN idademae TYPE integer
USING idademae::integer;

ALTER TABLE bebe
ALTER COLUMN peso TYPE numeric
USING peso::numeric;

ALTER TABLE bebe
ALTER COLUMN obito TYPE integer
USING obito::integer;

-- Exercícios SQL Agrupamento
SELECT * FROM bebe;

-- 1) Conte os recém-nascidos agrupados pelo critério de malformacao (conte quantos têm malformacao e quantos não têm).
SELECT malformacao, COUNT(*)::int AS total FROM bebe
GROUP BY malformacao
HAVING malformacao NOTNULL
ORDER BY total DESC;

-- 2) Calcule a idade media da mãe agrupado pelo estado civil da mãe.
SELECT estadocivilmae, AVG(idademae)::numeric(50,2) AS media FROM bebe
GROUP BY estadocivilmae
HAVING estadocivilmae NOTNULL
ORDER BY media DESC;

-- 3) Calcule a media de semanas de gestação de acordo com o tipo de parto
SELECT tipoparto, ROUND(AVG(qtdsemanas),2) AS media FROM bebe
GROUP BY tipoparto
HAVING tipoparto NOTNULL
ORDER BY media ASC;

-- 4) Dos partos prematuros (inferiores a 36 semanas), conte quantos vieram a óbito e quantos sobreviveram.
SELECT obito::boolean, COUNT(*)::int AS total FROM bebe
WHERE qtdsemanas < 36
GROUP BY obito
ORDER BY total DESC;

-- 5) Calcule quantos bebês vieram a óbito por estado civil da mãe utilizando GROUP BY.
SELECT estadocivilmae, COUNT(obito) FROM bebe
GROUP BY estadocivilmae
HAVING estadocivilmae NOTNULL;

-- 6) Mostre a idade da mãe mais jovem e da mãe mais velha, agrupado por estado civil.
SELECT estadocivilmae, MIN(idademae), MAX(idademae)
FROM bebe
GROUP BY estadocivilmae
HAVING estadocivilmae NOTNULL
ORDER BY min ASC;

-- 7) Dos bebes que vieram a obito quantos tinham malformacao? Isso representa qual percentual do total de bebes falecidos?
SELECT COUNT(*)::int AS obitomalformacao,
	(COUNT(*) * 100 / (SELECT COUNT(obito) FROM bebe WHERE obito = 1))::int AS porcentagemapro
FROM bebe
WHERE obito = 1 AND malformacao = 'sim';
