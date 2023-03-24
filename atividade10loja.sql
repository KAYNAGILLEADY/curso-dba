CREATE OR REPLACE TRIGGER novaVenda
AFTER INSERT ON vendas
FOR EACH ROW
EXECUTE PROCEDURE registrarVenda('1', 5);

CREATE OR REPLACE FUNCTION registrarVenda ()
RETURNS TRIGGER AS $$

DECLARE
	qtd_estoque int;

BEGIN
	SELECT qtde_estoque
	FROM produtos
	WHERE id_produto = TG_ARGV[0]
	INTO qtd_estoque;

	IF (TG_ARGV[1]::int > qtd_estoque) THEN
		RAISE NOTICE 'Quantidade indisponível no momento!!';
	ELSE 
		INSERT INTO produtos_vendas VALUES
		(NEW.id_venda, TG_ARGV[0], TG_ARGV[1]::int);
		
		select baixaEstoque(TG_ARGV[1]::int, TG_ARGV[0]);
	END IF;
	
RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION baixaEstoque (qtde_comprada int, produto varchar)
RETURNS VOID AS $$

BEGIN
	
	UPDATE produtos SET qtde_estoque = qtde_estoque - qtde_comprada
	WHERE id_produto = produto;

END;
$$ LANGUAGE plpgsql;

select * from produtos

ALTER TABLE produtos
ALTER COLUMN qtde_estoque TYPE INTEGER USING qtde_estoque::integer

ALTER TABLE produtos_vendas
ALTER COLUMN qtde_adquirida TYPE INTEGER USING qtde_adquirida::integer

select * from funcionarios

INSERT INTO vendas VALUES
('1', '21/03/2023', 'pix', '001', '001');