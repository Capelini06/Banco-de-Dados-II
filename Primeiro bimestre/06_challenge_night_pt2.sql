DROP TABLE IF EXISTS itens_venda;
DROP TABLE IF EXISTS vendas;
DROP TABLE IF EXISTS produtos;
DROP TABLE IF EXISTS vendedores;
DROP TABLE IF EXISTS clientes;

CREATE TABLE clientes (
    id_cliente      INTEGER       PRIMARY KEY,
    nome_cliente    VARCHAR(100)  NOT NULL,
    cidade          VARCHAR(80)   NOT NULL,
    estado          CHAR(2)       NOT NULL
);

CREATE TABLE vendedores (
    id_vendedor     INTEGER       PRIMARY KEY,
    nome_vendedor   VARCHAR(100)  NOT NULL,
    setor           VARCHAR(50)   NOT NULL
);

CREATE TABLE produtos (
    id_produto      INTEGER        PRIMARY KEY,
    nome_produto    VARCHAR(120)   NOT NULL,
    categoria       VARCHAR(60)    NOT NULL,
    marca           VARCHAR(60)    NOT NULL,
    preco            DECIMAL(10,2) NOT NULL
);

CREATE TABLE vendas (
    id_venda          INTEGER        PRIMARY KEY,
    data_venda        DATE           NOT NULL,
    id_cliente        INTEGER        NOT NULL,
    id_vendedor       INTEGER        NOT NULL,
    forma_pagamento   VARCHAR(40)    NOT NULL,
    status            VARCHAR(20)    NOT NULL,
    valor_total       DECIMAL(10,2)  NOT NULL,
    CONSTRAINT fk_vendas_clientes
        FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    CONSTRAINT fk_vendas_vendedores
        FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor)
);

CREATE TABLE itens_venda (
    id_item          INTEGER        PRIMARY KEY,
    id_venda         INTEGER        NOT NULL,
    id_produto       INTEGER        NOT NULL,
    quantidade       INTEGER        NOT NULL,
    valor_unitario   DECIMAL(10,2)  NOT NULL,
    desconto         DECIMAL(5,2)   NOT NULL DEFAULT 0,
    CONSTRAINT fk_itens_venda
        FOREIGN KEY (id_venda) REFERENCES vendas(id_venda),
    CONSTRAINT fk_itens_produtos
        FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

INSERT INTO clientes (id_cliente, nome_cliente, cidade, estado) VALUES
    (1, 'Ana Souza', 'Curitiba', 'PR'),
    (2, 'Bruno Lima', 'São José dos Pinhais', 'PR'),
    (3, 'Carla Mendes', 'Curitiba', 'PR'),
    (4, 'Diego Martins', 'Colombo', 'PR'),
    (5, 'Eduarda Alves', 'Pinhais', 'PR'),
    (6, 'Felipe Rocha', 'Curitiba', 'PR'),
    (7, 'Gabriela Costa', 'Araucária', 'PR'),
    (8, 'Henrique Silva', 'Curitiba', 'PR'),
    (9, 'Isabela Nunes', 'Campo Largo', 'PR'),
    (10, 'João Ribeiro', 'Curitiba', 'PR'),
    (11, 'Karen Oliveira', 'Piraquara', 'PR'),
    (12, 'Lucas Ferreira', 'Curitiba', 'PR'),
    (13, 'Mariana Gomes', 'Almirante Tamandaré', 'PR'),
    (14, 'Nicolas Santos', 'Curitiba', 'PR'),
    (15, 'Olívia Barros', 'Fazenda Rio Grande', 'PR'),
    (16, 'Paulo Moreira', 'Curitiba', 'PR'),
    (17, 'Queila Teixeira', 'Quatro Barras', 'PR'),
    (18, 'Rafael Cardoso', 'Curitiba', 'PR'),
    (19, 'Sabrina Correia', 'Campina Grande do Sul', 'PR'),
    (20, 'Thiago Lopes', 'Curitiba', 'PR'),
    (21, 'Úrsula Freitas', 'Mandirituba', 'PR'),
    (22, 'Vinícius Melo', 'Curitiba', 'PR'),
    (23, 'William Araújo', 'Rio Branco do Sul', 'PR'),
    (24, 'Yasmin Duarte', 'Curitiba', 'PR'),
    (25, 'Alice Pires', 'Joinville', 'SC'),
    (26, 'Bernardo Castro', 'Florianópolis', 'SC'),
    (27, 'Cecília Farias', 'Blumenau', 'SC'),
    (28, 'Daniela Reis', 'Itajaí', 'SC'),
    (29, 'Enzo Carvalho', 'São Paulo', 'SP'),
    (30, 'Fernanda Vieira', 'Campinas', 'SP'),
    (31, 'Gustavo Moraes', 'Sorocaba', 'SP'),
    (32, 'Helena Campos', 'Santos', 'SP'),
    (33, 'Igor Monteiro', 'Rio de Janeiro', 'RJ'),
    (34, 'Juliana Peixoto', 'Niterói', 'RJ'),
    (35, 'Kaique Batista', 'Belo Horizonte', 'MG'),
    (36, 'Larissa Cunha', 'Londrina', 'PR'),
    (37, 'Marcelo Prado', 'Maringá', 'PR'),
    (38, 'Natália Assis', 'Cascavel', 'PR'),
    (39, 'Otávio Rezende', 'Ponta Grossa', 'PR'),
    (40, 'Priscila Leal', 'Guarapuava', 'PR'),
    (41, 'Renato Diniz', 'Paranaguá', 'PR'),
    (42, 'Simone Amaral', 'Curitiba', 'PR'),
    (43, 'Tadeu Coelho', 'Curitiba', 'PR'),
    (44, 'Valéria Neves', 'Curitiba', 'PR'),
    (45, 'Wesley Ramos', 'Curitiba', 'PR'),
    (46, 'Adriana Luz', 'Curitiba', 'PR'),
    (47, 'Caio Borges', 'Curitiba', 'PR'),
    (48, 'Débora Matos', 'Curitiba', 'PR'),
    (49, 'Emanuel Pinto', 'Curitiba', 'PR'),
    (50, 'Flávia Xavier', 'Curitiba', 'PR');

INSERT INTO vendedores (id_vendedor, nome_vendedor, setor) VALUES
    (1, 'Amanda Freire', 'Loja Física'),
    (2, 'Breno Paiva', 'E-commerce'),
    (3, 'Camila Sales', 'Corporativo'),
    (4, 'Douglas Reis', 'Televendas'),
    (5, 'Elaine Braga', 'Marketplace'),
    (6, 'Fábio Moura', 'Loja Física'),
    (7, 'Giovana Teles', 'E-commerce'),
    (8, 'Hugo Andrade', 'Corporativo'),
    (9, 'Ingrid Leite', 'Televendas'),
    (10, 'Jorge Cunha', 'Marketplace'),
    (11, 'Kátia Prado', 'Loja Física'),
    (12, 'Leandro Vaz', 'E-commerce'),
    (13, 'Mônica Dias', 'Corporativo'),
    (14, 'Natan Pacheco', 'Televendas'),
    (15, 'Patrícia Alves', 'Marketplace'),
    (16, 'Ricardo Falcão', 'Loja Física'),
    (17, 'Sara Brito', 'E-commerce'),
    (18, 'Tomás Queiroz', 'Corporativo'),
    (19, 'Vanessa Lins', 'Televendas'),
    (20, 'Yuri Bastos', 'Marketplace'),
    (21, 'Aline Rocha', 'Loja Física'),
    (22, 'Bruno Medeiros', 'E-commerce'),
    (23, 'Cláudia Fontes', 'Corporativo'),
    (24, 'Davi Correia', 'Televendas'),
    (25, 'Ester Maia', 'Marketplace'),
    (26, 'Fernando Lima', 'Loja Física'),
    (27, 'Graziella Moraes', 'E-commerce'),
    (28, 'Heitor Nunes', 'Corporativo'),
    (29, 'Iara Martins', 'Televendas'),
    (30, 'Jonas Cardoso', 'Marketplace'),
    (31, 'Kelly Ribeiro', 'Loja Física'),
    (32, 'Luan Pereira', 'E-commerce'),
    (33, 'Márcia Carvalho', 'Corporativo'),
    (34, 'Noel Souza', 'Televendas'),
    (35, 'Pamela Castro', 'Marketplace'),
    (36, 'Raul Mendes', 'Loja Física'),
    (37, 'Silvia Lopes', 'E-commerce'),
    (38, 'Túlio Barros', 'Corporativo'),
    (39, 'Vitória Gomes', 'Televendas'),
    (40, 'Wallace Freitas', 'Marketplace'),
    (41, 'Ágata Moreira', 'Loja Física'),
    (42, 'César Silva', 'E-commerce'),
    (43, 'Denise Oliveira', 'Corporativo'),
    (44, 'Edson Santos', 'Televendas'),
    (45, 'Francine Costa', 'Marketplace'),
    (46, 'Gilberto Melo', 'Loja Física'),
    (47, 'Heloísa Reis', 'E-commerce'),
    (48, 'Ítalo Vieira', 'Corporativo'),
    (49, 'Jéssica Pires', 'Televendas'),
    (50, 'Kevin Araújo', 'Marketplace');

INSERT INTO produtos (id_produto, nome_produto, categoria, marca, preco) VALUES
    (1, 'Notebook Pro 14', 'Informática', 'TechPlus', 4599.90),
    (2, 'Mouse Sem Fio', 'Informática', 'ClickMax', 89.90),
    (3, 'Teclado Mecânico', 'Informática', 'KeyMaster', 329.90),
    (4, 'Monitor 24 Polegadas', 'Informática', 'Vision', 899.90),
    (5, 'SSD 1 TB', 'Informática', 'FastDrive', 449.90),
    (6, 'Webcam Full HD', 'Informática', 'Vision', 219.90),
    (7, 'Headset Gamer', 'Informática', 'SoundPlay', 289.90),
    (8, 'Roteador Wi-Fi 6', 'Informática', 'Connect', 399.90),
    (9, 'Impressora Multifuncional', 'Informática', 'PrintNow', 799.90),
    (10, 'Hub USB-C', 'Informática', 'Connect', 179.90),
    (11, 'Smartphone X1', 'Telefonia', 'MobileX', 1999.90),
    (12, 'Smartphone X2 Pro', 'Telefonia', 'MobileX', 3299.90),
    (13, 'Carregador Turbo', 'Telefonia', 'Volt', 119.90),
    (14, 'Capa Antichoque', 'Telefonia', 'SafeCase', 69.90),
    (15, 'Fone Bluetooth', 'Telefonia', 'SoundPlay', 199.90),
    (16, 'Smartwatch Fit', 'Wearables', 'Move', 599.90),
    (17, 'Pulseira Inteligente', 'Wearables', 'Move', 249.90),
    (18, 'TV 50 Polegadas 4K', 'TV e Vídeo', 'Vision', 2699.90),
    (19, 'Soundbar 2.1', 'Áudio', 'SoundPlay', 999.90),
    (20, 'Caixa de Som Bluetooth', 'Áudio', 'BeatBox', 349.90),
    (21, 'Air Fryer 5L', 'Eletrodomésticos', 'CasaFácil', 549.90),
    (22, 'Liquidificador 1200W', 'Eletrodomésticos', 'CasaFácil', 229.90),
    (23, 'Cafeteira Elétrica', 'Eletrodomésticos', 'BelaCasa', 189.90),
    (24, 'Micro-ondas 32L', 'Eletrodomésticos', 'BelaCasa', 799.90),
    (25, 'Aspirador Vertical', 'Eletrodomésticos', 'CleanHome', 499.90),
    (26, 'Ventilador de Coluna', 'Climatização', 'FreshAir', 299.90),
    (27, 'Climatizador Portátil', 'Climatização', 'FreshAir', 699.90),
    (28, 'Ar-condicionado 12000 BTU', 'Climatização', 'FreshAir', 2399.90),
    (29, 'Panela Elétrica', 'Eletrodomésticos', 'CasaFácil', 319.90),
    (30, 'Grill Elétrico', 'Eletrodomésticos', 'CasaFácil', 249.90),
    (31, 'Lava-louças 10 Serviços', 'Eletrodomésticos', 'CleanHome', 2999.90),
    (32, 'Máquina de Lavar 12kg', 'Eletrodomésticos', 'CleanHome', 2299.90),
    (33, 'Geladeira Duplex 400L', 'Eletrodomésticos', 'BelaCasa', 3499.90),
    (34, 'Forno Elétrico 50L', 'Eletrodomésticos', 'BelaCasa', 899.90),
    (35, 'Cooktop de Indução', 'Eletrodomésticos', 'CasaFácil', 1399.90),
    (36, 'Ferro a Vapor', 'Eletroportáteis', 'CasaFácil', 159.90),
    (37, 'Secador de Cabelo', 'Cuidados Pessoais', 'BeautyPro', 199.90),
    (38, 'Chapinha Cerâmica', 'Cuidados Pessoais', 'BeautyPro', 169.90),
    (39, 'Barbeador Elétrico', 'Cuidados Pessoais', 'BeautyPro', 249.90),
    (40, 'Escova Secadora', 'Cuidados Pessoais', 'BeautyPro', 229.90),
    (41, 'Câmera de Segurança', 'Segurança', 'SafeHome', 399.90),
    (42, 'Fechadura Digital', 'Segurança', 'SafeHome', 699.90),
    (43, 'Campainha Inteligente', 'Segurança', 'SafeHome', 449.90),
    (44, 'Lâmpada Inteligente', 'Casa Inteligente', 'SmartCasa', 79.90),
    (45, 'Tomada Inteligente', 'Casa Inteligente', 'SmartCasa', 99.90),
    (46, 'Robô Aspirador', 'Casa Inteligente', 'SmartCasa', 1499.90),
    (47, 'Projetor Portátil', 'TV e Vídeo', 'Vision', 1899.90),
    (48, 'Controle Universal', 'TV e Vídeo', 'Connect', 129.90),
    (49, 'Suporte Articulado TV', 'TV e Vídeo', 'SafeMount', 199.90),
    (50, 'Filtro de Linha', 'Acessórios', 'Volt', 89.90);

INSERT INTO vendas (
    id_venda,
    data_venda,
    id_cliente,
    id_vendedor,
    forma_pagamento,
    status,
    valor_total
) VALUES
    (1, '2026-01-09', 7, 3, 'Pix', 'Concluída', 317.45),
    (2, '2026-01-13', 14, 6, 'Cartão de Crédito', 'Concluída', 454.90),
    (3, '2026-01-17', 21, 9, 'Boleto', 'Concluída', 592.35),
    (4, '2026-01-21', 28, 12, 'Dinheiro', 'Pendente', 729.80),
    (5, '2026-01-25', 35, 15, 'Cartão de Débito', 'Cancelada', 867.25),
    (6, '2026-01-29', 7, 18, 'Pix', 'Concluída', 1004.70),
    (7, '2026-02-02', 14, 1, 'Cartão de Crédito', 'Concluída', 1142.15),
    (8, '2026-02-06', 21, 4, 'Boleto', 'Concluída', 1279.60),
    (9, '2026-02-10', 28, 7, 'Dinheiro', 'Pendente', 1417.05),
    (10, '2026-02-14', 35, 10, 'Cartão de Débito', 'Cancelada', 1554.50),
    (11, '2026-02-18', 7, 13, 'Pix', 'Concluída', 1691.95),
    (12, '2026-02-22', 14, 16, 'Cartão de Crédito', 'Concluída', 1829.40),
    (13, '2026-02-26', 21, 19, 'Boleto', 'Concluída', 1966.85),
    (14, '2026-03-02', 28, 2, 'Dinheiro', 'Pendente', 2104.30),
    (15, '2026-03-06', 35, 5, 'Cartão de Débito', 'Cancelada', 2241.75),
    (16, '2026-03-10', 7, 8, 'Pix', 'Concluída', 2379.20),
    (17, '2026-03-14', 14, 11, 'Cartão de Crédito', 'Concluída', 2516.65),
    (18, '2026-03-18', 21, 14, 'Boleto', 'Concluída', 2654.10),
    (19, '2026-03-22', 28, 17, 'Dinheiro', 'Pendente', 2791.55),
    (20, '2026-03-26', 35, 20, 'Cartão de Débito', 'Cancelada', 2929.00),
    (21, '2026-03-30', 7, 3, 'Pix', 'Concluída', 3066.45),
    (22, '2026-04-03', 14, 6, 'Cartão de Crédito', 'Concluída', 3203.90),
    (23, '2026-04-07', 21, 9, 'Boleto', 'Concluída', 3341.35),
    (24, '2026-04-11', 28, 12, 'Dinheiro', 'Pendente', 3478.80),
    (25, '2026-04-15', 35, 15, 'Cartão de Débito', 'Cancelada', 3616.25),
    (26, '2026-04-19', 7, 18, 'Pix', 'Concluída', 3753.70),
    (27, '2026-04-23', 14, 1, 'Cartão de Crédito', 'Concluída', 3891.15),
    (28, '2026-04-27', 21, 4, 'Boleto', 'Concluída', 4028.60),
    (29, '2026-05-01', 28, 7, 'Dinheiro', 'Pendente', 4166.05),
    (30, '2026-05-05', 35, 10, 'Cartão de Débito', 'Cancelada', 4303.50),
    (31, '2026-05-09', 7, 13, 'Pix', 'Concluída', 4440.95),
    (32, '2026-05-13', 14, 16, 'Cartão de Crédito', 'Concluída', 4578.40),
    (33, '2026-05-17', 21, 19, 'Boleto', 'Concluída', 4715.85),
    (34, '2026-05-21', 28, 2, 'Dinheiro', 'Pendente', 4853.30),
    (35, '2026-05-25', 35, 5, 'Cartão de Débito', 'Cancelada', 190.75),
    (36, '2026-05-29', 7, 8, 'Pix', 'Concluída', 328.20),
    (37, '2026-06-02', 14, 11, 'Cartão de Crédito', 'Concluída', 465.65),
    (38, '2026-06-06', 21, 14, 'Boleto', 'Concluída', 603.10),
    (39, '2026-06-10', 28, 17, 'Dinheiro', 'Pendente', 740.55),
    (40, '2026-06-14', 35, 20, 'Cartão de Débito', 'Cancelada', 878.00),
    (41, '2026-06-18', 7, 3, 'Pix', 'Concluída', 1015.45),
    (42, '2026-06-22', 14, 6, 'Cartão de Crédito', 'Concluída', 1152.90),
    (43, '2026-06-26', 21, 9, 'Boleto', 'Concluída', 1290.35),
    (44, '2026-06-30', 28, 12, 'Dinheiro', 'Pendente', 1427.80),
    (45, '2026-01-05', 35, 15, 'Cartão de Débito', 'Cancelada', 1565.25),
    (46, '2026-01-09', 7, 18, 'Pix', 'Concluída', 1702.70),
    (47, '2026-01-13', 14, 1, 'Cartão de Crédito', 'Concluída', 1840.15),
    (48, '2026-01-17', 21, 4, 'Boleto', 'Concluída', 1977.60),
    (49, '2026-01-21', 28, 7, 'Dinheiro', 'Pendente', 2115.05),
    (50, '2026-01-25', 35, 10, 'Cartão de Débito', 'Cancelada', 2252.50);

INSERT INTO itens_venda (
    id_item,
    id_venda,
    id_produto,
    quantidade,
    valor_unitario,
    desconto
) VALUES
    (1, 1, 9, 2, 759.90, 5.00),
    (2, 2, 18, 3, 2429.91, 10.00),
    (3, 3, 27, 4, 734.89, 15.00),
    (4, 4, 36, 1, 159.90, 20.00),
    (5, 5, 5, 2, 427.40, 0.00),
    (6, 6, 14, 3, 62.91, 5.00),
    (7, 7, 23, 4, 199.40, 10.00),
    (8, 8, 32, 1, 2299.90, 15.00),
    (9, 9, 1, 2, 4369.90, 20.00),
    (10, 10, 10, 3, 161.91, 0.00),
    (11, 11, 19, 4, 1049.89, 5.00),
    (12, 12, 28, 1, 2399.90, 10.00),
    (13, 13, 37, 2, 189.91, 15.00),
    (14, 14, 6, 3, 197.91, 20.00),
    (15, 15, 15, 4, 209.90, 0.00),
    (16, 16, 24, 1, 799.90, 5.00),
    (17, 17, 33, 2, 3324.90, 10.00),
    (18, 18, 2, 3, 80.91, 15.00),
    (19, 19, 11, 4, 2099.89, 20.00),
    (20, 20, 20, 1, 349.90, 0.00),
    (21, 21, 29, 2, 303.90, 5.00),
    (22, 22, 38, 3, 152.91, 10.00),
    (23, 23, 7, 4, 304.39, 15.00),
    (24, 24, 16, 1, 599.90, 20.00),
    (25, 25, 25, 2, 474.90, 0.00),
    (26, 26, 34, 3, 809.91, 5.00),
    (27, 27, 3, 4, 346.39, 10.00),
    (28, 28, 12, 1, 3299.90, 15.00),
    (29, 29, 21, 2, 522.40, 20.00),
    (30, 30, 30, 3, 224.91, 0.00),
    (31, 31, 39, 4, 262.40, 5.00),
    (32, 32, 8, 1, 399.90, 10.00),
    (33, 33, 17, 2, 237.41, 15.00),
    (34, 34, 26, 3, 269.91, 20.00),
    (35, 35, 35, 4, 1469.90, 0.00),
    (36, 36, 4, 1, 899.90, 5.00),
    (37, 37, 13, 2, 113.91, 10.00),
    (38, 38, 22, 3, 206.91, 15.00),
    (39, 39, 31, 4, 3149.90, 20.00),
    (40, 40, 40, 1, 229.90, 0.00),
    (41, 41, 9, 2, 759.90, 5.00),
    (42, 42, 18, 3, 2429.91, 10.00),
    (43, 43, 27, 4, 734.89, 15.00),
    (44, 44, 36, 1, 159.90, 20.00),
    (45, 45, 5, 2, 427.40, 0.00),
    (46, 46, 14, 3, 62.91, 5.00),
    (47, 47, 23, 4, 199.40, 10.00),
    (48, 48, 32, 1, 2299.90, 15.00),
    (49, 49, 1, 2, 4369.90, 20.00),
    (50, 50, 10, 3, 161.91, 0.00);

CREATE INDEX idx_vendas_cliente
    ON vendas (id_cliente);

CREATE INDEX idx_vendas_vendedor
    ON vendas (id_vendedor);

CREATE INDEX idx_itens_venda_venda
    ON itens_venda (id_venda);

CREATE INDEX idx_itens_venda_produto
    ON itens_venda (id_produto);

-- ------------------------------------------------------------
SELECT
    c.nome_cliente,
    c.cidade,
    COUNT(v.id_venda) AS quantidade_compras,
    COALESCE(SUM(v.valor_total), 0) AS valor_total_comprado
FROM clientes AS c
LEFT JOIN vendas AS v
    ON c.id_cliente = v.id_cliente
GROUP BY c.id_cliente, c.nome_cliente, c.cidade
ORDER BY valor_total_comprado DESC;

-- ------------------------------------------------------------
SELECT
    p.nome_produto,
    p.categoria,
    COALESCE(SUM(iv.quantidade), 0) AS quantidade_vendida,
    COALESCE(SUM(iv.quantidade * iv.valor_unitario), 0) AS faturamento
FROM produtos AS p
LEFT JOIN itens_venda AS iv
    ON p.id_produto = iv.id_produto
GROUP BY p.id_produto, p.nome_produto, p.categoria
ORDER BY faturamento DESC;

-- ------------------------------------------------------------
SELECT
    vd.nome_vendedor,
    vd.setor,
    COUNT(v.id_venda) AS quantidade_vendas,
    COALESCE(SUM(v.valor_total), 0) AS faturamento
FROM vendedores AS vd
LEFT JOIN vendas AS v
    ON vd.id_vendedor = v.id_vendedor
GROUP BY vd.id_vendedor, vd.nome_vendedor, vd.setor
ORDER BY faturamento DESC;

-- ------------------------------------------------------------
WITH clientes_compradores AS (
    SELECT DISTINCT c.id_cliente
    FROM clientes AS c
    INNER JOIN vendas AS v
        ON c.id_cliente = v.id_cliente
)
SELECT
    c.id_cliente,
    c.nome_cliente,
    c.cidade
FROM clientes AS c
LEFT JOIN clientes_compradores AS cc
    ON c.id_cliente = cc.id_cliente
WHERE cc.id_cliente IS NULL;

-- ------------------------------------------------------------
WITH produtos_vendidos AS (
    SELECT DISTINCT p.id_produto
    FROM produtos AS p
    INNER JOIN itens_venda AS iv
        ON p.id_produto = iv.id_produto
)
SELECT
    p.id_produto,
    p.nome_produto,
    p.categoria
FROM produtos AS p
LEFT JOIN produtos_vendidos AS pv
    ON p.id_produto = pv.id_produto
WHERE pv.id_produto IS NULL;

-- ------------------------------------------------------------
WITH faturamento_vendedores AS (
    SELECT
        vd.id_vendedor,
        vd.nome_vendedor,
        COALESCE(SUM(v.valor_total), 0) AS faturamento_total
    FROM vendedores AS vd
    LEFT JOIN vendas AS v
        ON vd.id_vendedor = v.id_vendedor
    GROUP BY vd.id_vendedor, vd.nome_vendedor
)
SELECT
    nome_vendedor,
    faturamento_total,
    CASE
        WHEN faturamento_total = 0 THEN 'Sem vendas'
        WHEN faturamento_total >= 20000 THEN 'Excelente'
        WHEN faturamento_total >= 10000 THEN 'Bom'
        ELSE 'Regular'
    END AS classificacao
FROM faturamento_vendedores
ORDER BY faturamento_total DESC;

-- ------------------------------------------------------------
WITH faturamento_produtos AS (
    SELECT
        p.id_produto,
        p.nome_produto,
        COALESCE(SUM(iv.quantidade * iv.valor_unitario), 0) AS faturamento_produto
    FROM produtos AS p
    LEFT JOIN itens_venda AS iv
        ON p.id_produto = iv.id_produto
    GROUP BY p.id_produto, p.nome_produto
),
media_geral AS (
    SELECT AVG(faturamento_produto) AS media_faturamento
    FROM faturamento_produtos
)
SELECT
    fp.nome_produto,
    fp.faturamento_produto,
    mg.media_faturamento
FROM faturamento_produtos AS fp
CROSS JOIN media_geral AS mg
WHERE fp.faturamento_produto > mg.media_faturamento
ORDER BY fp.faturamento_produto DESC;

-- ------------------------------------------------------------
WITH produtos_status AS (
    SELECT
        p.id_produto,
        p.categoria,
        COALESCE(SUM(iv.quantidade * iv.valor_unitario), 0) AS faturamento_produto,
        CASE WHEN COUNT(iv.id_item) > 0 THEN 1 ELSE 0 END AS foi_vendido
    FROM produtos AS p
    LEFT JOIN itens_venda AS iv
        ON p.id_produto = iv.id_produto
    GROUP BY p.id_produto, p.categoria
)
SELECT
    categoria,
    COUNT(*) AS quantidade_produtos,
    SUM(foi_vendido) AS produtos_vendidos,
    SUM(1 - foi_vendido) AS produtos_nunca_vendidos,
    SUM(faturamento_produto) AS faturamento
FROM produtos_status
GROUP BY categoria
ORDER BY faturamento DESC;

-- ------------------------------------------------------------
WITH compras_cliente AS (
    SELECT
        c.id_cliente,
        c.nome_cliente,
        COUNT(v.id_venda) AS quantidade_compras,
        COALESCE(SUM(v.valor_total), 0) AS valor_total,
        COALESCE(AVG(v.valor_total), 0) AS ticket_medio
    FROM clientes AS c
    LEFT JOIN vendas AS v
        ON c.id_cliente = v.id_cliente
    GROUP BY c.id_cliente, c.nome_cliente
)
SELECT
    nome_cliente,
    quantidade_compras,
    valor_total,
    ticket_medio,
    CASE
        WHEN quantidade_compras = 0 THEN 'Sem compras'
        WHEN valor_total >= 5000 THEN 'Cliente VIP'
        WHEN valor_total >= 1000 THEN 'Cliente Regular'
        ELSE 'Cliente Ocasional'
    END AS classificacao
FROM compras_cliente
ORDER BY valor_total DESC;

-- ------------------------------------------------------------
WITH vendas_produto AS (
    SELECT
        p.id_produto,
        p.nome_produto,
        COALESCE(SUM(iv.quantidade), 0) AS quantidade_vendida,
        COALESCE(SUM(iv.quantidade * iv.valor_unitario), 0) AS valor_vendido
    FROM produtos AS p
    LEFT JOIN itens_venda AS iv
        ON p.id_produto = iv.id_produto
    GROUP BY p.id_produto, p.nome_produto
),
total_vendas AS (
    SELECT SUM(valor_vendido) AS faturamento_total
    FROM vendas_produto
)
SELECT
    vp.nome_produto,
    vp.quantidade_vendida,
    vp.valor_vendido,
    ROUND(vp.valor_vendido / NULLIF(tv.faturamento_total, 0) * 100, 2) AS percentual_participacao
FROM vendas_produto AS vp
CROSS JOIN total_vendas AS tv
ORDER BY vp.valor_vendido DESC;

-- ------------------------------------------------------------
WITH produtos_vendidos AS (
    SELECT DISTINCT p.id_produto
    FROM produtos AS p
    INNER JOIN itens_venda AS iv
        ON p.id_produto = iv.id_produto
)
SELECT
    p.id_produto,
    p.nome_produto,
    CASE
        WHEN pv.id_produto IS NOT NULL THEN 'Vendido'
        ELSE 'Nunca vendido'
    END AS situacao
FROM produtos AS p
LEFT JOIN produtos_vendidos AS pv
    ON p.id_produto = pv.id_produto
ORDER BY situacao, p.nome_produto;

-- ------------------------------------------------------------
SELECT
    COALESCE(t.nome_cliente, a.nome_cliente) AS nome_cliente,
    COALESCE(t.email, a.email) AS email,
    CASE
        WHEN t.email IS NOT NULL AND a.email IS NOT NULL THEN 'Presente em ambas as bases'
        WHEN t.email IS NOT NULL AND a.email IS NULL THEN 'Somente TechVendas'
        WHEN t.email IS NULL AND a.email IS NOT NULL THEN 'Somente empresa adquirida'
    END AS situacao
FROM clientes_techvendas AS t
LEFT JOIN clientes_empresa_adquirida AS a
    ON t.email = a.email

UNION

SELECT
    COALESCE(t.nome_cliente, a.nome_cliente) AS nome_cliente,
    COALESCE(t.email, a.email) AS email,
    CASE
        WHEN t.email IS NOT NULL AND a.email IS NOT NULL THEN 'Presente em ambas as bases'
        WHEN t.email IS NOT NULL AND a.email IS NULL THEN 'Somente TechVendas'
        WHEN t.email IS NULL AND a.email IS NOT NULL THEN 'Somente empresa adquirida'
    END AS situacao
FROM clientes_techvendas AS t
RIGHT JOIN clientes_empresa_adquirida AS a
    ON t.email = a.email

ORDER BY situacao, nome_cliente;

-- ------------------------------------------------------------
WITH comparativo AS (
    SELECT
        COALESCE(t.email, a.email) AS email,
        CASE
            WHEN t.email IS NOT NULL AND a.email IS NOT NULL THEN 'Presente nas duas bases'
            WHEN t.email IS NOT NULL AND a.email IS NULL THEN 'Somente na base antiga'
            WHEN t.email IS NULL AND a.email IS NOT NULL THEN 'Somente na base nova'
        END AS situacao
    FROM clientes_techvendas AS t
    LEFT JOIN clientes_empresa_adquirida AS a
        ON t.email = a.email

    UNION

    SELECT
        COALESCE(t.email, a.email) AS email,
        CASE
            WHEN t.email IS NOT NULL AND a.email IS NOT NULL THEN 'Presente nas duas bases'
            WHEN t.email IS NOT NULL AND a.email IS NULL THEN 'Somente na base antiga'
            WHEN t.email IS NULL AND a.email IS NOT NULL THEN 'Somente na base nova'
        END AS situacao
    FROM clientes_techvendas AS t
    RIGHT JOIN clientes_empresa_adquirida AS a
        ON t.email = a.email
)
SELECT
    situacao,
    COUNT(*) AS quantidade_clientes
FROM comparativo
GROUP BY situacao
ORDER BY situacao;

-- ------------------------------------------------------------
WITH resumo_vendedor AS (
    SELECT
        vd.id_vendedor,
        vd.nome_vendedor,
        COUNT(DISTINCT v.id_cliente) AS quantidade_clientes,
        COUNT(v.id_venda) AS quantidade_vendas,
        COALESCE(AVG(v.valor_total), 0) AS ticket_medio
    FROM vendedores AS vd
    LEFT JOIN vendas AS v
        ON vd.id_vendedor = v.id_vendedor
    GROUP BY vd.id_vendedor, vd.nome_vendedor
),
faturamento_cliente_vendedor AS (
    SELECT
        v.id_vendedor,
        c.nome_cliente,
        SUM(v.valor_total) AS faturamento_cliente,
        ROW_NUMBER() OVER (
            PARTITION BY v.id_vendedor
            ORDER BY SUM(v.valor_total) DESC
        ) AS ranking
    FROM vendas AS v
    INNER JOIN clientes AS c
        ON v.id_cliente = c.id_cliente
    GROUP BY v.id_vendedor, c.nome_cliente
),
melhor_cliente AS (
    SELECT id_vendedor, nome_cliente AS melhor_cliente
    FROM faturamento_cliente_vendedor
    WHERE ranking = 1
),
faturamento_categoria_vendedor AS (
    SELECT
        v.id_vendedor,
        p.categoria,
        SUM(iv.quantidade * iv.valor_unitario) AS faturamento_categoria,
        ROW_NUMBER() OVER (
            PARTITION BY v.id_vendedor
            ORDER BY SUM(iv.quantidade * iv.valor_unitario) DESC
        ) AS ranking
    FROM vendas AS v
    INNER JOIN itens_venda AS iv
        ON v.id_venda = iv.id_venda
    INNER JOIN produtos AS p
        ON iv.id_produto = p.id_produto
    GROUP BY v.id_vendedor, p.categoria
),
melhor_categoria AS (
    SELECT id_vendedor, categoria AS melhor_categoria
    FROM faturamento_categoria_vendedor
    WHERE ranking = 1
),
faturamento_produto_vendedor AS (
    SELECT
        v.id_vendedor,
        p.nome_produto,
        SUM(iv.quantidade * iv.valor_unitario) AS faturamento_produto,
        ROW_NUMBER() OVER (
            PARTITION BY v.id_vendedor
            ORDER BY SUM(iv.quantidade * iv.valor_unitario) DESC
        ) AS ranking
    FROM vendas AS v
    INNER JOIN itens_venda AS iv
        ON v.id_venda = iv.id_venda
    INNER JOIN produtos AS p
        ON iv.id_produto = p.id_produto
    GROUP BY v.id_vendedor, p.nome_produto
),
melhor_produto AS (
    SELECT id_vendedor, nome_produto AS melhor_produto
    FROM faturamento_produto_vendedor
    WHERE ranking = 1
)
SELECT
    rv.nome_vendedor,
    rv.quantidade_clientes,
    rv.quantidade_vendas,
    rv.ticket_medio,
    mc.melhor_cliente,
    mcat.melhor_categoria,
    mp.melhor_produto
FROM resumo_vendedor AS rv
LEFT JOIN melhor_cliente AS mc
    ON rv.id_vendedor = mc.id_vendedor
LEFT JOIN melhor_categoria AS mcat
    ON rv.id_vendedor = mcat.id_vendedor
LEFT JOIN melhor_produto AS mp
    ON rv.id_vendedor = mp.id_vendedor
ORDER BY rv.quantidade_vendas DESC;

-- ------------------------------------------------------------
WITH clientes_compradores AS (
    SELECT DISTINCT v.id_cliente
    FROM vendas AS v
),
auditoria_clientes AS (
    SELECT
        c.id_cliente,
        CASE WHEN cc.id_cliente IS NOT NULL THEN 1 ELSE 0 END AS esta_ativo
    FROM clientes AS c
    LEFT JOIN clientes_compradores AS cc
        ON c.id_cliente = cc.id_cliente

    UNION

    SELECT
        c.id_cliente,
        CASE WHEN cc.id_cliente IS NOT NULL THEN 1 ELSE 0 END AS esta_ativo
    FROM clientes AS c
    RIGHT JOIN clientes_compradores AS cc
        ON c.id_cliente = cc.id_cliente
),
resumo_clientes AS (
    SELECT
        COUNT(*) AS clientes_cadastrados,
        SUM(esta_ativo) AS clientes_ativos,
        SUM(1 - esta_ativo) AS clientes_sem_compras
    FROM auditoria_clientes
),
produtos_vendidos AS (
    SELECT DISTINCT iv.id_produto
    FROM itens_venda AS iv
),
auditoria_produtos AS (
    SELECT
        p.id_produto,
        CASE WHEN pv.id_produto IS NOT NULL THEN 1 ELSE 0 END AS foi_vendido
    FROM produtos_vendidos AS pv
    RIGHT JOIN produtos AS p
        ON pv.id_produto = p.id_produto
),
resumo_produtos AS (
    SELECT
        COUNT(*) AS produtos_cadastrados,
        SUM(foi_vendido) AS produtos_vendidos,
        SUM(1 - foi_vendido) AS produtos_sem_vendas
    FROM auditoria_produtos
),
vendedores_com_vendas AS (
    SELECT vd.id_vendedor
    FROM vendedores AS vd
    LEFT JOIN vendas AS v
        ON vd.id_vendedor = v.id_vendedor
    GROUP BY vd.id_vendedor
    HAVING COUNT(v.id_venda) > 0
),
resumo_vendedores AS (
    SELECT
        COUNT(*) AS vendedores_cadastrados,
        (SELECT COUNT(*) FROM vendedores_com_vendas) AS vendedores_ativos,
        COUNT(*) - (SELECT COUNT(*) FROM vendedores_com_vendas) AS vendedores_sem_vendas
    FROM vendedores
)
SELECT
    rc.clientes_cadastrados,
    COALESCE(rc.clientes_ativos, 0) AS clientes_ativos,
    COALESCE(rc.clientes_sem_compras, 0) AS clientes_sem_compras,
    rp.produtos_cadastrados,
    COALESCE(rp.produtos_vendidos, 0) AS produtos_vendidos,
    COALESCE(rp.produtos_sem_vendas, 0) AS produtos_sem_vendas,
    rv.vendedores_cadastrados,
    COALESCE(rv.vendedores_ativos, 0) AS vendedores_ativos,
    COALESCE(rv.vendedores_sem_vendas, 0) AS vendedores_sem_vendas
FROM resumo_clientes AS rc
CROSS JOIN resumo_produtos AS rp
CROSS JOIN resumo_vendedores AS rv;
