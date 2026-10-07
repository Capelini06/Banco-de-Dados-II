-- ============================================================
-- BANCO DE DADOS II
-- DESAFIO FINAL DO SEMESTRE
-- EMPRESA: SPORTZonE
-- ============================================================

DROP DATABasE IF EXISTS sportzone;

CREATE DATABasE sportzone;


USE sportzone;


-- ============================================================
-- TABELA: CLIENTES
-- ============================================================

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    cidade VARCHAR(80) NOT NULL,
    estado CHAR(2) NOT NULL,
    renda DECIMAL(10,2),
    data_cadastro DATE NOT NULL
);


-- ============================================================
-- TABELA: VENDEDORES
-- ============================================================

CREATE TABLE vendedores (
    id_vendedor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    cidade VARCHAR(80) NOT NULL,
    data_admissao DATE NOT NULL
);


-- ============================================================
-- TABELA: PRODUTOS
-- ============================================================

CREATE TABLE produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    categoria VARCHAR(60) NOT NULL,
    marca VARCHAR(60) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL,
    ativo BOOLEAN NOT NULL DEFAULT TRUE,

    CHECK (preco >= 0),
    CHECK (estoque >= 0)
);


-- ============================================================
-- TABELA: VENDas
-- ============================================================

CREATE TABLE vendas (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_vendedor INT NOT NULL,
    data_venda DATE NOT NULL,
    forma_pagamento VARCHAR(30) NOT NULL,

    ConSTRAINT fk_vendas_clientes
        FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente),

    ConSTRAINT fk_vendas_vendedores
        FOREIGN KEY (id_vendedor)
        REFERENCES vendedores(id_vendedor)
);


-- ============================================================
-- TABELA: ITENS_VENDA
-- ============================================================

CREATE TABLE itens_venda (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_venda INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,

    ConSTRAINT fk_itens_vendas
        FOREIGN KEY (id_venda)
        REFERENCES vendas(id_venda),

    ConSTRAINT fk_itens_produtos
        FOREIGN KEY (id_produto)
        REFERENCES produtos(id_produto),

    CHECK (quantidade > 0),
    CHECK (preco_unitario >= 0)
);


-- ============================================================
-- INSERTS: CLIENTES
-- ============================================================

INSERT INTO clientes
(nome, cpf, cidade, estado, renda, data_cadastro)
VALUES
('Lucas Almeida',       '111.111.111-01', 'Curitiba',          'PR', 8500.00,  '2026-01-10'),
('Mariana Costa',       '111.111.111-02', 'Curitiba',          'PR', 6200.00,  '2026-01-15'),
('Rafael Martins',      '111.111.111-03', 'São José dos Pinhais','PR', 4800.00,'2026-01-20'),
('Fernanda Oliveira',   '111.111.111-04', 'Colombo',           'PR', 7300.00,  '2026-02-03'),
('Bruno Souza',         '111.111.111-05', 'Curitiba',          'PR', 3900.00,  '2026-02-12'),
('Camila Rodrigues',    '111.111.111-06', 'Pinhais',           'PR', 9100.00,  '2026-02-18'),
('Gustavo Pereira',     '111.111.111-07', 'Araucária',         'PR', 5200.00,  '2026-03-01'),
('Juliana Santos',      '111.111.111-08', 'Curitiba',          'PR', 6800.00,  '2026-03-08'),
('Felipe Lima',         '111.111.111-09', 'Campo Largo',       'PR', 4400.00,  '2026-03-15'),
('Amanda Ribeiro',      '111.111.111-10', 'Curitiba',          'PR', 12500.00, '2026-03-22'),
('Diego Ferreira',      '111.111.111-11', 'Pinhais',           'PR', 5800.00,  '2026-04-02'),
('Patrícia Gomes',      '111.111.111-12', 'Colombo',           'PR', 7600.00,  '2026-04-11'),
('André Moreira',       '111.111.111-13', 'Curitiba',          'PR', 3300.00,  '2026-04-18'),
('Larissa Alves',       '111.111.111-14', 'Araucária',         'PR', 8700.00,  '2026-05-01'),
('Rodrigo Barbosa',     '111.111.111-15', 'Curitiba',          'PR', 10200.00, '2026-05-09'),
('Beatriz Cardoso',     '111.111.111-16', 'Pinhais',           'PR', 4600.00,  '2026-05-20'),
('Eduardo Nunes',       '111.111.111-17', 'Curitiba',          'PR', 5500.00,  '2026-06-01'),
('Natália Rocha',       '111.111.111-18', 'Campo Largo',       'PR', 6900.00,  '2026-06-10'),
('Henrique Freitas',    '111.111.111-19', 'Colombo',           'PR', 4100.00,  '2026-06-18'),
('Isabela Teixeira',    '111.111.111-20', 'Curitiba',          'PR', 9800.00,  '2026-06-25');


-- ============================================================
-- INSERTS: VENDEDORES
-- ============================================================

INSERT INTO vendedores
(nome, email, cidade, data_admissao)
VALUES
('Carlos Mendes',   'carlos@sportzone.com.br',   'Curitiba', '2024-02-01'),
('Ana Paula Silva', 'ana@sportzone.com.br',      'Curitiba', '2024-05-10'),
('João Ribeiro',    'joao@sportzone.com.br',     'Pinhais',  '2025-01-15'),
('Renata Lopes',    'renata@sportzone.com.br',   'Curitiba', '2025-03-12'),
('Marcelo Torres',  'marcelo@sportzone.com.br',  'Colombo',  '2025-07-20'),
('Bianca Martins',  'bianca@sportzone.com.br',   'Curitiba', '2025-10-05'),
('Paulo Henrique',  'paulo@sportzone.com.br',    'Pinhais',  '2026-01-08'),
('Sabrina Costa',   'sabrina@sportzone.com.br',  'Curitiba', '2026-07-01');


-- Observação:
-- Sabrina Costa propositalmente não possuirá vendas.


-- ============================================================
-- INSERTS: PRODUTOS
-- ============================================================

INSERT INTO produtos
(nome, categoria, marca, preco, estoque, ativo)
VALUES
('Tênis Running Pro',           'Calçados',    'RunFast',   499.90, 18, TRUE),
('Tênis Urban Flex',            'Calçados',    'RunFast',   359.90, 25, TRUE),
('Tênis Trail Adventure',       'Calçados',    'MountainX', 549.90, 12, TRUE),

('Camiseta Dry Fit Masculina',  'Vestuário',   'SportMax',   89.90, 45, TRUE),
('Camiseta Dry Fit Feminina',   'Vestuário',   'SportMax',   89.90, 38, TRUE),
('Shorts Performance',          'Vestuário',   'SportMax',  119.90, 30, TRUE),
('Legging Training',            'Vestuário',   'FitLife',   159.90, 28, TRUE),
('Jaqueta Corta-Vento',         'Vestuário',   'MountainX', 299.90, 14, TRUE),

('Mochila Esportiva 30L',       'Acessórios',  'Adventure', 219.90, 20, TRUE),
('Garrafa Térmica 1L',          'Acessórios',  'HydroFit',  129.90, 40, TRUE),
('Luvas de Academia',           'Acessórios',  'FitLife',    79.90, 35, TRUE),
('Boné Sport Performance',      'Acessórios',  'SportMax',   69.90, 32, TRUE),

('Halter 10kg',                 'Musculação',  'StrongFit', 179.90, 15, TRUE),
('Kit Halteres 20kg',           'Musculação',  'StrongFit', 499.90, 10, TRUE),
('Banco de Musculação',         'Musculação',  'StrongFit', 899.90, 6, TRUE),

('Bola de Futebol Pro',         'Esportes',    'Arena',     149.90, 22, TRUE),
('Bola de Basquete Street',     'Esportes',    'Arena',     169.90, 16, TRUE),
('Raquete de Tênis Carbon',     'Esportes',    'Winner',    649.90, 8, TRUE),

('Corda de Pular Speed',        'Fitness',     'FitLife',    59.90, 50, TRUE),
('Colchonete Premium',          'Fitness',     'FitLife',   139.90, 26, TRUE),

('Step Aeróbico Profissional',  'Fitness',     'FitLife',   259.90, 10, TRUE),
('Kettlebell 16kg',             'Musculação',  'StrongFit', 229.90, 12, TRUE);


-- Observação:
-- Produtos 21 e 22 propositalmente nunca serão vendidos.


-- ============================================================
-- INSERTS: VENDas
-- ============================================================

INSERT INTO vendas
(id_cliente, id_vendedor, data_venda, forma_pagamento)
VALUES
(1,  1, '2026-01-15', 'Cartão de Crédito'),
(2,  2, '2026-01-20', 'PIX'),
(3,  3, '2026-02-03', 'Cartão de Débito'),
(1,  1, '2026-02-10', 'PIX'),
(4,  4, '2026-02-17', 'Cartão de Crédito'),

(5,  2, '2026-03-02', 'PIX'),
(6,  1, '2026-03-06', 'Cartão de Crédito'),
(2,  3, '2026-03-12', 'Cartão de Crédito'),
(7,  5, '2026-03-18', 'PIX'),
(8,  4, '2026-03-25', 'Cartão de Débito'),

(10, 1, '2026-04-02', 'Cartão de Crédito'),
(3,  3, '2026-04-07', 'PIX'),
(11, 6, '2026-04-13', 'Cartão de Crédito'),
(12, 2, '2026-04-21', 'PIX'),
(1,  1, '2026-04-29', 'Cartão de Crédito'),

(14, 5, '2026-05-05', 'Cartão de Débito'),
(15, 1, '2026-05-10', 'Cartão de Crédito'),
(6,  4, '2026-05-15', 'PIX'),
(8,  2, '2026-05-22', 'Cartão de Crédito'),
(10, 3, '2026-05-30', 'PIX'),

(2,  2, '2026-06-04', 'Cartão de Crédito'),
(11, 6, '2026-06-09', 'PIX'),
(14, 5, '2026-06-14', 'Cartão de Crédito'),
(17, 7, '2026-06-19', 'PIX'),
(1,  1, '2026-06-26', 'Cartão de Crédito'),

(15, 4, '2026-07-03', 'Cartão de Crédito'),
(3,  3, '2026-07-08', 'PIX'),
(10, 1, '2026-07-14', 'Cartão de Crédito'),
(18, 7, '2026-07-21', 'PIX'),
(6,  6, '2026-07-29', 'Cartão de Crédito'),

(8,  2, '2026-08-02', 'PIX'),
(14, 5, '2026-08-08', 'Cartão de Crédito'),
(2,  3, '2026-08-15', 'Cartão de Débito'),
(15, 4, '2026-08-22', 'PIX'),
(10, 1, '2026-08-29', 'Cartão de Crédito'),

(1,  1, '2026-09-02', 'PIX'),
(17, 7, '2026-09-04', 'Cartão de Crédito'),
(6,  6, '2026-09-06', 'Cartão de Crédito'),
(14, 5, '2026-09-07', 'PIX'),
(10, 1, '2026-09-08', 'Cartão de Crédito');


-- Clientes propositalmente sem nenhuma compra:
-- 9  - Felipe Lima
-- 13 - André Moreira
-- 16 - Beatriz Cardoso
-- 19 - Henrique Freitas
-- 20 - Isabela Teixeira


-- ============================================================
-- INSERTS: ITENS_VENDA
-- ============================================================

INSERT INTO itens_venda
(id_venda, id_produto, quantidade, preco_unitario)
VALUES

-- VENDA 01
(1, 1, 1, 469.90),
(1, 4, 2, 84.90),
(1, 10, 1, 119.90),

-- VENDA 02
(2, 2, 1, 349.90),
(2, 5, 2, 89.90),

-- VENDA 03
(3, 16, 1, 139.90),
(3, 12, 1, 69.90),
(3, 19, 1, 59.90),

-- VENDA 04
(4, 13, 2, 169.90),
(4, 11, 1, 79.90),

-- VENDA 05
(5, 7, 1, 149.90),
(5, 5, 2, 84.90),
(5, 10, 1, 129.90),

-- VENDA 06
(6, 4, 3, 79.90),
(6, 6, 1, 109.90),

-- VENDA 07
(7, 14, 1, 479.90),
(7, 20, 2, 129.90),

-- VENDA 08
(8, 1, 1, 499.90),
(8, 9, 1, 209.90),

-- VENDA 09
(9, 3, 1, 529.90),
(9, 8, 1, 289.90),

-- VENDA 10
(10, 5, 2, 89.90),
(10, 7, 1, 159.90),

-- VENDA 11
(11, 15, 1, 849.90),
(11, 14, 1, 489.90),
(11, 11, 2, 74.90),

-- VENDA 12
(12, 16, 2, 144.90),
(12, 4, 1, 89.90),

-- VENDA 13
(13, 2, 1, 359.90),
(13, 10, 2, 124.90),

-- VENDA 14
(14, 17, 1, 159.90),
(14, 12, 2, 64.90),

-- VENDA 15
(15, 18, 1, 619.90),
(15, 3, 1, 519.90),

-- VENDA 16
(16, 6, 2, 119.90),
(16, 7, 1, 149.90),
(16, 19, 2, 54.90),

-- VENDA 17
(17, 1, 2, 479.90),
(17, 10, 1, 129.90),

-- VENDA 18
(18, 4, 2, 84.90),
(18, 5, 2, 84.90),
(18, 20, 1, 139.90),

-- VENDA 19
(19, 9, 1, 219.90),
(19, 12, 1, 69.90),

-- VENDA 20
(20, 13, 1, 179.90),
(20, 14, 1, 499.90),

-- VENDA 21
(21, 2, 1, 349.90),
(21, 6, 2, 114.90),

-- VENDA 22
(22, 11, 2, 79.90),
(22, 20, 1, 134.90),

-- VENDA 23
(23, 3, 1, 549.90),
(23, 8, 1, 299.90),

-- VENDA 24
(24, 16, 2, 149.90),
(24, 4, 2, 89.90),

-- VENDA 25
(25, 1, 1, 489.90),
(25, 18, 1, 629.90),

-- VENDA 26
(26, 15, 1, 899.90),
(26, 13, 2, 174.90),

-- VENDA 27
(27, 17, 1, 169.90),
(27, 12, 2, 69.90),

-- VENDA 28
(28, 14, 2, 489.90),
(28, 10, 2, 129.90),

-- VENDA 29
(29, 19, 3, 59.90),
(29, 20, 2, 139.90),

-- VENDA 30
(30, 7, 2, 154.90),
(30, 5, 1, 89.90),
(30, 11, 1, 79.90),

-- VENDA 31
(31, 4, 2, 89.90),
(31, 6, 1, 119.90),
(31, 10, 1, 129.90),

-- VENDA 32
(32, 3, 1, 539.90),
(32, 9, 1, 219.90),

-- VENDA 33
(33, 16, 2, 144.90),
(33, 17, 1, 164.90),

-- VENDA 34
(34, 1, 1, 499.90),
(34, 8, 1, 299.90),
(34, 12, 1, 69.90),

-- VENDA 35
(35, 15, 1, 879.90),
(35, 14, 1, 499.90),
(35, 20, 1, 139.90),

-- VENDA 36
(36, 18, 1, 649.90),
(36, 11, 2, 79.90),

-- VENDA 37
(37, 2, 1, 359.90),
(37, 10, 2, 129.90),

-- VENDA 38
(38, 7, 2, 159.90),
(38, 4, 2, 89.90),

-- VENDA 39
(39, 3, 1, 549.90),
(39, 9, 1, 219.90),
(39, 19, 2, 59.90),

-- VENDA 40
(40, 15, 1, 899.90),
(40, 1, 1, 499.90),
(40, 10, 1, 129.90);

-- Parte 1 – Análise de Clientes
WITH total_gasto as (
    select
        id_venda,
        coalesce(SUM(quantidade * preco_unitario), 0) as total_gasto
    from itens_venda
    group by id_venda
)
select
    c.id_cliente
    ,c.nome
    ,c.cidade
    ,c.renda
    ,count(distinct v.id_venda) as qta_compras_realizadas
    ,coalesce(SUM(iv.quantidade), 0) as qta_produtos_adquiridos
    ,coalesce(SUM(tg.total_gasto), 0) as total_gasto
    ,coalesce(ROUND(SUM(tg.total_gasto) / nullif(count(distinct v.id_venda), 0), 2), 0) as ticket_medio
    ,MAX(v.data_venda) as ultima_compra
from clientes c
left join vendas v
    on c.id_cliente = v.id_cliente
left join itens_venda iv
    on v.id_venda = iv.id_venda
left join total_gasto tg
    on tg.id_venda = v.id_venda
group by c.id_cliente, c.nome, c.cidade, c.renda
order by total_gasto desc;


-- Parte 2 – Análise de Produtos
WITH faturamento as (
    select
        id_venda,
        coalesce(SUM(quantidade * preco_unitario), 0) as faturamento
    from itens_venda
    group by id_venda
) select
	p.id_produto
	,p.nome
	,p.preco
	,p.estoque
	,count(iv.id_produto) as qta_total_vendido
	,coalesce(sum(f.faturamento), 0) as faturamento
	,count(v.id_cliente) as qta_vendas_por_clientes
from produtos p
left join itens_venda iv
	on iv.id_produto = p.id_Produto
left join vendas v
	on v.id_venda = iv.id_venda
left join faturamento f
	on f.id_venda = v.id_venda
group by p.id_produto, p.nome
order by qta_total_vendido desc;


-- Parte 3 – Análise de Vendedores
WITH faturamento as (
    select
        id_venda,
        coalesce(SUM(quantidade * preco_unitario), 0) as faturamento
    from itens_venda
    group by id_venda
)select
	ve.id_vendedor
	,ve.nome
	,count(v.id_vendedor) as qta_vendas_realizadas
	,count(iv.id_produto) as qta_produtos_vendidos
	,coalesce(sum(f.faturamento), 0) as faturamento_total
	,coalesce(ROUND(SUM(f.faturamento) / nullif(count(distinct v.id_venda), 0), 2), 0) as ticket_medio
from vendedores ve
left join vendas v
	on v.id_vendedor = ve.id_vendedor
left join itens_venda iv
	on iv.id_venda = v.id_venda
left join faturamento f
	on f.id_venda = v.id_venda
group by ve.id_vendedor, ve.nome
order by faturamento_total desc;



-- Parte 4 – KPIs Gerenciais Obrigatórios
-- Qual cliente mais gastou na SportZone?
WITH total_gasto as (
    select
        id_venda,
        coalesce(SUM(quantidade * preco_unitario), 0) as total_gasto
    from itens_venda
    group by id_venda
) select
    c.id_cliente
    ,c.nome
    ,c.cidade
    ,coalesce(SUM(tg.total_gasto), 0) as total_gasto
from clientes c
left join vendas v
    on c.id_cliente = v.id_cliente
left join total_gasto tg
    on tg.id_venda = v.id_venda
group by c.id_cliente, c.nome, c.cidade, c.renda
order by total_gasto desc
limit 1;


-- Qual cliente realizou a maior quantidade de compras?
select
    c.id_cliente
    ,c.nome
    ,c.cidade
    ,count(distinct v.id_venda) as qta_compras_realizadas
from clientes c
left join vendas v
    on c.id_cliente = v.id_cliente
group by c.id_cliente, c.nome, c.cidade, c.renda
order by qta_compras_realizadas desc
limit 1;


-- Qual produto teve a maior quantidade de unidades vendidas?
select
	p.id_produto
	,p.nome
	,count(iv.id_produto) as qta_total_vendido
from produtos p
left join itens_venda iv
	on iv.id_produto = p.id_Produto
group by p.id_produto, p.nome
order by qta_total_vendido desc
limit 1;


-- Qual produto gerou o maior faturamento?
WITH faturamento as (
    select
        id_venda,
        coalesce(SUM(quantidade * preco_unitario), 0) as faturamento
    from itens_venda
    group by id_venda
) select
	p.id_produto
	,p.nome
	,coalesce(sum(f.faturamento), 0) as faturamento
from produtos p
left join itens_venda iv
	on iv.id_produto = p.id_Produto
left join vendas v
	on v.id_venda = iv.id_venda
left join faturamento f
	on f.id_venda = v.id_venda
group by p.id_produto, p.nome
order by faturamento desc
limit 1;


-- Quais produtos nunca foram vendidos?
select 
	p.id_produto
	,p.nome
from produtos p
left join itens_venda iv
	on iv.id_produto = p.id_produto
where iv.id_produto is null;


-- Qual vendedor realizou a maior quantidade de vendas?
select
	ve.id_vendedor
    ,ve.nome
    ,count(v.id_vendedor) as qta_vendida
    from vendedores ve 
    left join vendas v
		on v.id_vendedor = ve.id_vendedor
    group by ve.id_vendedor, ve.nome
    order by qta_vendida desc
    limit 1;


-- Qual vendedor gerou o maior faturamento?
WITH faturamento as (
    select
        id_venda,
        coalesce(SUM(quantidade * preco_unitario), 0) as faturamento
    from itens_venda
    group by id_venda
)select
	ve.id_vendedor
	,ve.nome
	,coalesce(sum(f.faturamento), 0) as faturamento_total
from vendedores ve
left join vendas v
	on v.id_vendedor = ve.id_vendedor
left join faturamento f
	on f.id_venda = v.id_venda
group by ve.id_vendedor, ve.nome
order by faturamento_total desc
limit 1;


-- Quantos clientes nunca realizaram uma compra?
select 
    count(distinct c.id_cliente) as qta_compras
from clientes c
left join vendas v
	on v.id_cliente = c.id_cliente
where v.id_cliente is null;


-- Qual foi o faturamento total da empresa?
SELECT
    COALESCE(SUM(quantidade * preco_unitario), 0) AS faturamento_total
FROM itens_venda;


-- Qual é o ticket médio geral das vendas?
WITH faturamento as (
    select
        id_venda,
        coalesce(SUM(quantidade * preco_unitario), 0) as faturamento
    from itens_venda
    group by id_venda
)select
	coalesce(ROUND(SUM(f.faturamento) / nullif(count(distinct v.id_venda), 0), 2), 0) as ticket_medio
from vendas v
left join faturamento f
	on f.id_venda = v.id_venda;
