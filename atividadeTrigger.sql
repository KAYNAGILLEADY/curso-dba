/*
	DIA: 22/02/2023
	ALUNO: "Kaynã Gilleady"
	DESCRICAO: "criação de triggers explorando o conceito de manipulação das tabelas e backup"
*/


--------------------------------------------------------------------------------------------------
-- Crie uma função que retorne uma trigger para dar baixa no estoque do sistema
-- de uma loja quando uma venda acontecer. Os esquemas/modelos do Banco de Dados são os seguintes:
--------------------------------------------------------------------------------------------------


/*
	
Produto
	cod_produto: varchar
	descricao: varchar
	qtde_disponivel: integer

ItensVenda
	cod_venda: varchar
	fk_produto: varchar
	qtde_produto: integer	
*/

CREATE TABLE produtos (
	cod_produto varchar PRIMARY KEY,
	descricao varchar,
	qtde_disponivel int
)

CREATE TABLE ItensVenda (
	cod_venda varchar PRIMARY KEY,
	fk_produto varchar,
	qtde_vendida int,
	FOREIGN KEY (fk_produto) 
		REFERENCES produto(cod_produto)
);

INSERT INTO produtos
VALUES 
	('001', 'coca-cola 2L', 5),
	('002', 'sabonete', 10),
	('003', 'mouse', 8),
	('004', 'monitor 144hz', 2);
