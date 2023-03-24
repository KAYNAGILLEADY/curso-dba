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

CREATE FUNCTION baixa_estoque()     
RETURNS INTEGER   
LANGUAGE plpgsql  
AS $$    
DECLARE    
	qtde_a_vender INTEGER = 0;
BEGIN    
	SELECT qtde_disponivel 
	FROM produto 
	WHERE cod_produto = NEW.fk_produto
	INTO qtde_a_vender;
RETURN 1  
END;   
$$  

-- 4) CRIAR UMA TRIGGER QUE CHAME A FUNÇÃO

-- 5) POPULAR A TABELA ITENS_VENDAS E VER A MÁGICA ACONTECER
INSERT INTO itens_vendas VALUES 
	('1001', 'WXYZ', 3);