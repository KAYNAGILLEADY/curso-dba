CREATE TABLE PRODUTOS (
	id_produto varchar PRIMARY KEY,
	descricao varchar,
	valor_unitario varchar,
	categoria varchar,
	qtde_estoque varchar
);

CREATE TABLE FUNCIONARIOS (
	id_funcionario varchar PRIMARY KEY,
	cpf_funcionario varchar,
	nome_funcionario varchar,
	cargo varchar,
	departamento varchar,
	salario varchar
);

CREATE TABLE CLIENTES (
	id_cliente varchar PRIMARY KEY,
	cpf_cliente varchar,
	nome_cliente varchar
);

CREATE TABLE VENDAS (
	id_venda varchar PRIMARY KEY,
	dataehora varchar,
	valor_total varchar,
	forma_pgto varchar,
	fk_cliente varchar REFERENCES CLIENTES(id_cliente),
	fk_funcionario varchar REFERENCES FUNCIONARIOS(id_funcionario)
);

CREATE TABLE PRODUTOS_VENDAS (
	fk_venda varchar REFERENCES VENDAS(id_venda),
	fk_produto varchar REFERENCES PRODUTOS(id_produto),
	qtde_adquirida varchar
);


CREATE TABLE PRODUTOS_AUDITORIA (
	id_log varchar PRIMARY KEY,
	operacao varchar,
	dataehora varchar,
	id_funcionario varchar
);

CREATE TABLE VENDAS_AUDITORIA (
	id_log varchar PRIMARY KEY,
	operacao varchar,
	dataehora varchar,
	id_funcionario varchar
);

CREATE TABLE FUNCIONARIOS_AUDITORIA (
	id_log varchar PRIMARY KEY,
	operacao varchar,
	dataehora varchar,
	id_funcionario varchar
);

CREATE TABLE CLIENTES_AUDITORIA (
	id_log varchar PRIMARY KEY,
	operacao varchar,
	dataehora varchar,
	id_funcionario varchar
);

CREATE TABLE PRODUTOS_VENDAS_AUDITORIA (
	id_log varchar PRIMARY KEY,
	operacao varchar,
	dataehora varchar,
	id_funcionario varchar
);


INSERT INTO PRODUTOS VALUES
	('1', 'churrasqueira de controle remoto', '2500,00', 'eletrônicos', '5'),
	('2', 'notebook acer nitro 5', '4500,00', 'eletrônicos', '15'),
	('3', 'geladeira eletrolux', '1500,00', 'eletrônicos', '20'),
	('4', 'televisão 4k samsung', '4000,00', 'eletrônicos', '10'),
	('5', 'mouse daten', '25,00', 'eletrônicos', '16'),
	('6', 'teclado game redragon', '100,00', 'eletrônicos', '7'),
	('7', 'teclado n3 microsoft', '75,00', 'eletrônicos', '37'),
	('8', 'carteira de couro', '50,00', 'utilitários', '3'),
	('9', 'celular nokia tijolão', '5,00', 'eletrônicos', '18'),
	('10', 'iPhone 6s 64 GB', '2000,00', 'eletrônicos', '4'),
	('11', 'xiaomi poco x5', '2000,00', 'eletrônicos', '6'),
	('12', 'notebook positivo 1tb celeron 4gb ram ddr3', '1500,00', 'eletrônicos', '30'),
	('13', 'caneta bic preta', '1,00', 'material escolar', '20'),
	('14', 'caneta bic azul', '1,00', 'material escolar', '10'),
	('15', 'caneta bic vermelha', '1,00', 'material escolar', '35'),
	('16', 'projetor 4k ', '800,00', 'eletrônicos', '14'),
	('17', 'vara de pescar inquebrável III', '148,00', 'pesca', '75'),
	('18', 'carregador turbo', '26,00', 'eletrônicos', '24'),
	('19', 'fritadeira de controle remoto', '1568,00', 'eletrônicos', '3'),
	('20', 'cabo sata', '72,00', 'eletrônicos', '21');

	("21", "mochila 5 bolsos", "172,66", "material escolar", "7") VALUES
	('22', 'Galaxy A03 Core', '799,00', 'eletrônicos', '9'),
	('23', 'tênis 12 mola', '200,00', 'utilitários', '12'),
	('24', 'óculos escuro', '79,99', 'utilitários', '30'),
	('25', 'boné de aba reta', '50,98', 'utilitários', '25'),
	('26', 'monitor daten 8k', '2295,56', 'eletrônicos', '6'),
	('27', 'aspirador de pó eletrolux', '3000,00', 'para casa', '18'),
	
	
	
INSERT INTO clientes (id_cliente, cpf_cliente, nome_cliente) VALUES
    ('001', '123.456.789-10', 'João Silva'),
    ('002', '987.654.321-00', 'Maria Souza'),
    ('003', '456.789.123-11', 'Pedro Andrade'),
    ('004', '222.333.444-55', 'Juliana Santos'),
    ('005', '111.222.333-44', 'Fernando Oliveira'),
    ('006', '555.666.777-88', 'Isabela Rocha'),
    ('007', '666.777.888-99', 'Ricardo Pereira'),
    ('008', '999.888.777.66', 'Amanda Costa'),
    ('009', '777.888.999-10', 'Lucas Souza'),
    ('010', '222.555.888-33', 'Carla Gonçalves');

INSERT INTO funcionarios (id_funcionario, cpf_funcionario, nome_funcionario, cargo, departamento, salario) VALUES
    ('001', '123.456.789-10', 'João Silva', 'Analista de Sistemas', 'TI', '5000.00'),
    ('002', '987.654.321-00', 'Maria Souza', 'Gerente de Vendas', 'Comercial', '8000.00'),
    ('003', '456.789.123-11', 'Pedro Andrade', 'Assistente Administrativo', 'Administração', '3000.00'),
    ('004', '222.333.444-55', 'Juliana Santos', 'Analista de Marketing', 'Marketing', '5500.00');
	
