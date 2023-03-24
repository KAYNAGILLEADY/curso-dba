-- Mostre por estado a etnia dominante que tem maior quantidade de aldeias.
SELECT nomuf, MAX(etnia_nome)
FROM (
SELECT aldeias.nomuf, COUNT(terras.etnia_nome) AS numero_etnias, Max((SELECT COUNT(terras.etnia_nome) FROM terras)), terras.etnia_nome FROM terras
FULL JOIN aldeias
ON aldeias.cod_aldeia = terras.terrai_codigo
GROUP BY aldeias.nomuf, terras.etnia_nome
) AS tabela
GROUP BY aldeias.nomuf, terras.etnia_nome

SELECT nomuf, 
	(
		SELECT nomuf, COUNT(etnia_nome) AS numero_etnias FROM terras, aldeias
		GROUP BY  nomuf
		ORDER BY nomuf 
	) FROM aldeias
	
	
-- 4) Mostre as etnias cuja quantidade de aldeias seja superior à média.
SELECT *
FROM public.numero_aldeias
WHERE numero_de_aldeias > 
	(SELECT AVG(numero_de_aldeias)::int FROM public.numero_aldeias)
ORDER BY numero_de_aldeias DESC;

-- 5) Mostre o nome de cada aldeia existente no estado com maior
-- número de aldeias.
SELECT nome_aldeia FROM aldeias
WHERE nomuf = (
	SELECT nomuf FROM aldeias_por_estado
	WHERE qtdaldeias = (SELECT MAX(qtdaldeias) FROM aldeias_por_estado)
)

SELECT nomuf FROM aldeias_por_estado
WHERE qtdaldeias = (SELECT MAX(qtdaldeias) FROM aldeias_por_estado)

CREATE VIEW aldeias_por_estado AS
SELECT nomuf, COUNT(*) AS qtdaldeias FROM aldeias GROUP BY nomuf;