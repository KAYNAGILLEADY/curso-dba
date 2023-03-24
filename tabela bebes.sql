/*
	ALUNO: 'Kaynã Gilleady',
	DIA: '23/01/2022',
	DESCRICAO: ' Atividade Avaliativa 4 '
*/

#1 - Baixe o conjunto de dados (dataset) disponível no Google Classroom.

#2 - Crie uma tabela no database “bebes” que represente este dataset.
CREATE TABLE dataset (
	id varchar,
	idademae varchar,
	estadocivilmae varchar,
	catprenatal varchar,
	qtdsemanas varchar,
	tipoparto varchar(,
	peso varchar,
	malformacao varchar,
	sexo varchar,
	apgar1 varchar,
	apgar5 varchar,
	obito varchar
);

COPY dataset
FROM 'C:\Users\Public\Downloads\dataset.csv'
DELIMITER ','
CSV HEADER;

#3 - Elimine a coluna “sexo”, que representa o sexo do bebê.
ALTER TABLE dataset
DROP COLUMN sexo;


#4 - Mostre a quantidade de registros existentes nesta tabela.
SELECT COUNT(*) FROM dataset; 
#Resultado: 11389 registros


#5 - Mostre os registros cujo campo “malformação” é igual a 1.
SELECT * FROM dataset
WHERE malformacao LIKE 'sim';


#6 - Selecione somente os registros dos casos em que o bebê foi a óbito.
SELECT * FROM dataset
WHERE obito = '1';



#7 - Conte quantos bebês nasceram de parto normal e quantos bebês nasceram de parto cesáreo.
SELECT COUNT(*) FROM dataset #Resultado: 4006
WHERE tipoparto = 'vaginal'; 

SELECT COUNT(*) FROM dataset #Resultado: 7378
WHERE tipoparto = 'cesareo';



#8 - Verifique, dentre os bebês que vieram a óbito, quantos bebês nasceram com menos
#	 de 36 semanas de gestação. Eles representam qual percentual do total de bebês que
#	 vieram a óbito?

SELECT obito, (COUNT(obito)*100 /( SELECT COUNT(qtdsemanas) FROM dataset)) AS porcentagem
FROM dataset
WHERE obito = '1' AND qtdsemanas < '36'
GROUP BY obito;
/* Resultado: É de 15% */





#9 - Calcule a média de semanas de uma gestação.
SELECT AVG(qtdsemanas) AS mediasemanagestacao FROM dataset;
#Resultado: A média é 36.9526113052046941




#10 - Calcule quantos bebês vieram a óbito filhos de mães solteiras e filhos de mães
#	  casadas. De acordo com este resultado, você diria que o estado civil da mãe influencia
#	  na probabilidade de sobrevivência da criança?
SELECT COUNT(*) FROM dataset 
WHERE obito = '1' AND estadocivilmae LIKE 'solteira';
#Resultado: 1159
 
SELECT COUNT(*) FROM dataset
WHERE obito = '1' AND estadocivilmae LIKE 'casada';
#Resultado: 808

/* 
	Influencia sim visto que a morte de mais de mais de 300 pessoas é sim uma grande perca.

	Esse trecho de código mostra a diferença entre as duas quantidades
	passadas na questão acima.
*/
SELECT (
	COUNT(*) -( SELECT COUNT(*) FROM dataset WHERE obito = '1' AND estadocivilmae LIKE 'casada')
) AS diferenca
FROM dataset
WHERE obito = '1' AND estadocivilmae LIKE 'solteira';
#Resultado: 351