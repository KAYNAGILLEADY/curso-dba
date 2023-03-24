-- 1) Total de produtos
-- por categoria
CREATE VIEW qtde_produtos AS
SELECT categoria, COUNT(*) AS qtde_produtos
FROM produtos
GROUP BY categoria;

-- 2) Produtos mais vendidos
-- (maior p/ menor)
CREATE VIEW produtos_mais_vendidos AS
SELECT produtos.descricao, fk_produto, SUM(qtde_adquirida) AS total
FROM produtos_vendas
LEFT JOIN produtos
ON id_produto = fk_produto
GROUP BY fk_produto, produtos.descricao
ORDER BY total DESC;


-- 3) Vendas por funcionário
CREATE VIEW vendas_por_funcionario AS
SELECT 
	nome_funcionario,
	fk_funcionario, 
	COUNT(*) AS qtde_vendida
FROM vendas
LEFT JOIN funcionarios
ON id_funcionario = fk_funcionario
GROUP BY fk_funcionario, nome_funcionario
ORDER BY qtde_vendida DESC;

-- Criar permissões de acesso (roles)
-- funcionario (funções)
-- gerente (views)

CREATE ROLE funcionario WITH
LOGIN ENCRYPTED PASSWORD 'funcionario123';

CREATE ROLE gerente WITH
LOGIN ENCRYPTED PASSWORD 'gerente123';

GRANT EXECUTE ON 
	ALL FUNCTIONS
IN SCHEMA public
TO funcionario;

GRANT select, insert, update, delete ON
	ALL TABLES
IN SCHEMA public
TO funcionario;

GRANT select ON
	produtos_mais_vendidos,
	qtde_produtos,
	vendas_por_funcionario
TO gerente;

-- Remover a permissão de edição
-- (UPDATE e DELETE) das tabelas
-- VENDAS e PRODUTOS_VENDAS

REVOKE UPDATE, DELETE ON vendas FROM funcionario;
REVOKE UPDATE, DELETE ON produtos_vendas FROM funcionario;

REVOKE UPDATE, DELETE ON vendas FROM gerente;
REVOKE UPDATE, DELETE ON produtos_vendas FROM gerente;