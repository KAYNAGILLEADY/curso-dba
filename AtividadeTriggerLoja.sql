-- 1) CRIAR AS TABELAS
CREATE TABLE produtos (
	cod_produto VARCHAR PRIMARY KEY,
	descricao VARCHAR NOT NULL,
	qtde_disponivel INTEGER DEFAULT 0
);

CREATE TABLE itens_vendas (
	cod_venda VARCHAR PRIMARY KEY,
	fk_produto VARCHAR REFERENCES produtos(cod_produto),
	qtde_vendida INTEGER NOT NULL
);

-- 2) POPULAR A TABELA PRODUTOS
INSERT INTO produtos(qtde_disponivel, descricao, cod_produto) VALUES
	(10, 'Coca-cola', 'XPTO'),
	(8, 'Guaraná Antártica', 'ABCD'),
	(2, 'Fanta Uva', 'WXYZ');

-- 3) CRIAR UMA FUNÇÃO
CREATE OR REPLACE FUNCTION baixa_estoque()     
RETURNS trigger AS $trigger$
DECLARE    
	qtde_em_estoque INTEGER := 0;
BEGIN    
	--Captura o valor no Result Set da consulta e atribui a uma variável.
	SELECT qtde_disponivel 
	FROM produtos
	WHERE cod_produto = NEW.fk_produto
	INTO qtde_em_estoque; -- INTO serve justamente inserir o valor da consulta na variável.
	
	IF NEW.qtde_vendida <= qtde_em_estoque THEN
		UPDATE produtos
		SET qtde_disponivel = qtde_disponivel - NEW.qtde_vendida
		WHERE cod_produto = NEW.fk_produto;
	ELSE RAISE EXCEPTION 'Quantidade indisponível no estoque';
	END IF;
	
-- OU --

/*
	IF NEW.qtde_vendida > qtde_em_estoque THEN
	RAISE EXCEPTION 'Quantidade indisponível no estoque';
	
	ELSE
		UPDATE produtos
		SET qtde_disponivel = qtde_disponivel - NEW.qtde_vendida
		WHERE cod_produto = NEW.fk_produto;
	END IF;
*/
RETURN NEW;
END;
$trigger$ LANGUAGE plpgsql;

-- 4) CRIAR UMA TRIGGER QUE CHAME A FUNÇÃO
CREATE OR REPLACE TRIGGER log_compra
BEFORE INSERT ON itens_vendas
FOR EACH ROW
EXECUTE PROCEDURE baixa_estoque();

-- 5) POPULAR A TABELA ITENS_VENDAS E VER A MÁGICA ACONTECER
INSERT INTO itens_vendas VALUES
	('1005', 'ABCD', 1),
	('1001', 'WXYZ', 3);