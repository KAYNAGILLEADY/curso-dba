----<  importação da tabela terras  >----
CREATE TABLE terras (
	terrai_codigo varchar,
	terrai_nome varchar,
	etnia_nome varchar,
	municipio_nome varchar,
	uf_sigla varchar,
	superficie_perimetro_ha varchar,
	fase_ti varchar,
	modalidade_ti varchar,
	reestudo_ti varchar,
	cr varchar,
	faixa_fronteira varchar,
	undadm_codigo varchar,
	undadm_nome varchar,
	undadm_sigla varchar,
	dominio_uniao varchar,
	data_atualizacao varchar,
	epsg varchar
);

--se precisar apagar a tabela para refaze-la
DROP TABLE terras;

COPY terras
FROM 'C:\terras.csv'
DELIMITER ';'
CSV HEADER;

SELECT * FROM terras;


----<  importação da tabela aldeias  >----
CREATE TABLE aldeias (
	cod_aldeia integer,
	nome_aldeia varchar,
	cod_ti integer,
	cod_municipio integer,
	data_cadastro varchar,
	flag_ativo varchar,
	nome_cr varchar,
	nommunic varchar,
	nomuf varchar,
	undadm_codigo varchar,
	coord_lat varchar,
	coord_long varchar
);

--se precisar apagar a tabela para refaze-la
DROP TABLE aldeias;

COPY aldeias
FROM 'C:\aldeias.csv'
DELIMITER ';'
CSV HEADER;

SELECT * FROM aldeias;
SELECT * FROM terras;





-- 1) Quantas aldeias e quantas terras indígenas existem em cada UF (Unidade da Federação)?
CREATE VIEW aldeias_ufs AS
SELECT
	terras.uf_sigla,
	COUNT(distinct terras.terrai_codigo) AS contterras,
	COUNT(distinct aldeias.cod_aldeia) AS contaldeias
FROM terras
FULL JOIN aldeias
ON aldeias.cod_ti = terras.terrai_codigo
GROUP BY terras.uf_sigla
HAVING terras.uf_sigla NOTNULL AND NOT terras.uf_sigla LIKE '%,%'
ORDER BY uf_sigla;

CREATE VIEW aldeias_fronteira AS  
SELECT
	terras.uf_sigla,
	COUNT(distinct terras.terrai_codigo) AS contterras,
	COUNT(distinct aldeias.cod_aldeia) AS contaldeias
	FROM terras
	FULL JOIN aldeias
	ON aldeias.cod_ti = terras.terrai_codigo
	GROUP BY terras.uf_sigla
	HAVING terras.uf_sigla NOTNULL AND terras.uf_sigla LIKE '%,%'
	ORDER BY uf_sigla;

ALTER TABLE terras
ALTER COLUMN terrai_codigo TYPE integer
USING terrai_codigo::integer;

-- 2) Quantas aldeias indígenas existem por cada etnia/povo?
CREATE VIEW numero_aldeias AS
SELECT terras.etnia_nome, COUNT(aldeias.cod_aldeia) AS numero_de_aldeias FROM aldeias
FULL JOIN terras
ON aldeias.cod_ti = terras.terrai_codigo
GROUP BY terras.etnia_nome
HAVING terras.etnia_nome NOTNULL
ORDER BY numero_de_aldeias DESC;