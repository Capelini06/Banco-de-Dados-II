
CREATE DATABASE IF NOT EXISTS db_techmarket;
USE db_techmarket;

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(100),
    cidade VARCHAR(60),
    estado CHAR(2)
);

CREATE TABLE vendedores (
    id_vendedor INT PRIMARY KEY,
    nome VARCHAR(100),
    equipe VARCHAR(50)
);

CREATE TABLE produtos (
    id_produto INT PRIMARY KEY,
    descricao VARCHAR(100),
    categoria VARCHAR(50),
    preco DECIMAL(10,2)
);

CREATE TABLE pedidos (
    id_pedido INT PRIMARY KEY,
    id_cliente INT,
    id_vendedor INT,
    data_pedido DATE,
    status_pedido VARCHAR(20),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor)
);

CREATE TABLE itens_pedido (
    id_item INT PRIMARY KEY,
    id_pedido INT,
    id_produto INT,
    quantidade INT,
    preco_unitario DECIMAL(10,2),
    desconto_percentual DECIMAL(5,2),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

INSERT INTO clientes VALUES
(1,'Ana Souza','Curitiba','PR'),
(2,'Bruno Lima','Londrina','PR'),
(3,'Carla Mendes','Sao Paulo','SP'),
(4,'Daniel Rocha','Curitiba','PR'),
(5,'Eduarda Alves','Joinville','SC'),
(6,'Felipe Costa','Campinas','SP'),
(7,'Gabriela Martins','Maringa','PR'),
(8,'Henrique Dias','Florianopolis','SC');

INSERT INTO vendedores VALUES
(1,'Marcos Silva','Sul'),
(2,'Patricia Gomes','Sul'),
(3,'Ricardo Oliveira','Sudeste'),
(4,'Juliana Ferreira','Sudeste');

INSERT INTO produtos VALUES
(1,'Notebook Pro', 'Computadores',4500.00),
(2,'Mouse Gamer','Perifericos',180.00),
(3,'Teclado Mecanico','Perifericos',350.00),
(4,'Monitor 27','Monitores',1400.00),
(5,'Headset Pro','Audio',420.00),
(6,'Webcam HD','Acessorios',260.00),
(7,'SSD 1TB','Armazenamento',550.00),
(8,'Hub USB-C','Acessorios',150.00);

INSERT INTO pedidos VALUES
(101,1,1,'2026-09-01','Faturado'),
(102,2,1,'2026-09-02','Faturado'),
(103,3,3,'2026-09-03','Faturado'),
(104,4,2,'2026-09-05','Cancelado'),
(105,5,2,'2026-09-06','Faturado'),
(106,6,3,'2026-09-08','Faturado'),
(107,1,1,'2026-09-10','Faturado'),
(108,7,2,'2026-09-12','Pendente'),
(109,2,2,'2026-09-15','Faturado'),
(110,3,3,'2026-09-17','Faturado'),
(111,5,1,'2026-09-19','Faturado'),
(112,6,3,'2026-09-22','Faturado');

INSERT INTO itens_pedido VALUES
(1,101,1,1,4500,10),
(2,101,2,2,180,0),
(3,102,3,2,350,5),
(4,102,5,1,420,0),
(5,103,4,2,1400,10),
(6,103,6,1,260,0),
(7,104,1,1,4500,0),
(8,105,7,2,550,5),
(9,105,8,3,150,0),
(10,106,1,2,4500,5),
(11,106,3,1,350,0),
(12,107,4,1,1400,0),
(13,107,5,2,420,10),
(14,108,2,4,180,0),
(15,109,6,3,260,0),
(16,109,8,2,150,5),
(17,110,7,1,550,0),
(18,110,2,3,180,10),
(19,111,3,2,350,0),
(20,112,1,1,4500,15);

-- missao 01
-- o pedido, o cliente responsável pela compra, o vendedor envolvido, o produto comercializado, sua categoria, a data da operação e os valores financeiros.
-- criação da view
DROP VIEW vw_vendas_detalhadas;
CREATE VIEW vw_vendas_detalhadas AS
	SELECT
		p.id_pedido
        ,c.estado
        ,c.cidade
		,c.nome AS cliente
		,ve.nome AS vendedor
		,pr.descricao AS produto
		,pr.categoria
        ,p.status_pedido
		,p.data_pedido
		,ip.quantidade
		,ip.preco_unitario
		,ip.desconto_percentual
		,(ip.preco_unitario * ip.quantidade) AS valor_bruto
		,round(sum((ip.preco_unitario * ip.quantidade) * (1 - ip.desconto_percentual / 100))  ,2) AS valor_liquido
	FROM pedidos p
    JOIN clientes c
    ON c.id_cliente = p.id_cliente
    JOIN vendedores ve
    ON ve.id_vendedor = p.id_vendedor
    JOIN itens_pedido ip
    ON ip.id_pedido = p.id_pedido
    JOIN produtos pr
    ON pr.id_produto = ip.id_produto
    where p.status_pedido = "Faturado";

-- Apresentar todas as vendas, organizando os registros do maior para o menor valor efetivamente faturado.
SELECT *
FROM vw_vendas_detalhadas
ORDER BY valor_liquido DESC;

-- Identificar os cinco itens de venda com maior valor faturado, exibindo o cliente e o produto correspondente.
SELECT
	cliente
    ,produto
    ,valor_liquido
FROM vw_vendas_detalhadas
ORDER BY valor_liquido DESC
LIMIT 5;

-- Apresentar as vendas realizadas para clientes do Paraná, organizadas por data da operação.
SELECT
	 estado
	,cidade
    ,COUNT(id_pedido) AS quantidade_compras
    ,data_pedido
FROM vw_vendas_detalhadas
WHERE estado = "PR"
GROUP BY estado, cidade, data_pedido
ORDER BY data_pedido ASC;
	
-- missão 02
-- criação da view
--  contendo a identificação de cada vendedor, sua equipe, a quantidade de pedidos faturados, a quantidade total de unidades vendidas e o faturamento efetivo acumulado.
DROP VIEW vw_desempenho_vendedores;
CREATE VIEW  vw_desempenho_vendedores AS
	SELECT
		 ve.id_vendedor
        ,ve.nome AS vendedor
        ,ve.equipe
        ,COUNT(DISTINCT p.id_pedido) AS quantidade_pedidos
        ,sum(ip.quantidade) AS quantidade_total_vendida
        ,round(sum((ip.preco_unitario * ip.quantidade) * (1 - ip.desconto_percentual / 100))  ,2) AS valor_liquido
	FROM vendedores ve
    JOIN pedidos p 
    ON p.id_vendedor = ve.id_vendedor
    JOIN itens_pedido ip
    ON ip.id_pedido = p.id_pedido
    where p.status_pedido = "Faturado"
	GROUP BY id_vendedor, ve.nome, ve.equipe;
    
select * 
from vw_desempenho_vendedores;

-- Um ranking dos vendedores com maior faturamento, apresentando também seu ticket médio por pedido
select
	 vendedor
    ,valor_liquido
    ,round((valor_liquido/quantidade_pedidos), 2) as ticket_medio
    from vw_desempenho_vendedores
    order by valor_liquido desc;
    
-- Um relatório gerencial com o faturamento total e a quantidade de pedidos por equipe comercial, ordenado pelo maior faturamento.
select
	 equipe
	,
    ,valor_liquido
    ,round((valor_liquido/quantidade_pedidos), 2) as ticket_medio
    from vw_desempenho_vendedores
    order by valor_liquido desc;