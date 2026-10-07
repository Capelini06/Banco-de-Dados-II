CREATE DATABASE sql_quest;

USE sql_quest;

CREATE TABLE jogadores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    classe VARCHAR(50) NOT NULL,
    nivel INT NOT NULL,
    moedas INT NOT NULL DEFAULT 0,
    pontos INT NOT NULL,
    guilda VARCHAR(50),
    bonus INT,
    status_jogador VARCHAR(30) NOT NULL,
    classificacao VARCHAR(30)
);

INSERT INTO jogadores
(nome, classe, nivel, moedas, pontos, guilda, bonus, status_jogador)
VALUES
('Arthas', 'Guerreiro', 18, 950, 7200, 'Dragões', 500, 'ATIVO'),

('Luna', 'Maga', 22, 1500, 9800, 'Fênix', NULL, 'ATIVO'),

('Thorim', 'Guerreiro', 15, 450, 5100, 'Dragões', 300, 'ATIVO'),

('Nyx', 'Assassina', 26, 2100, 12500, 'Sombras', NULL, 'ATIVO'),

('Eldrin', 'Mago', 12, 300, 3900, 'Fênix', 200, 'ATIVO'),

('Kael', 'Arqueiro', 20, 1100, 8300, 'Dragões', NULL, 'ATIVO'),

('Morgana', 'Maga', 30, 3200, 16000, 'Sombras', 1000, 'ATIVO'),

('Ragnar', 'Guerreiro', 8, 150, 1800, 'Dragões', NULL, 'INATIVO'),

('Lyra', 'Arqueira', 17, 700, 6500, 'Fênix', 400, 'ATIVO'),

('Draven', 'Assassino', 25, 1800, 11200, 'Sombras', 700, 'ATIVO'),

('Orion', 'Mago', 6, 80, 900, NULL, NULL, 'INATIVO'),

('Freya', 'Guerreira', 21, 1300, 8900, 'Dragões', 600, 'ATIVO');

-- O PRIMEIRO PROBLEMA: A CLASSIFICAÇÃO DOS AVENTUREIROS
update jogadores 
set classificacao = case
	when pontos >= 12000 then 'LENDÁRIO'
    when pontos >= 8000 then 'ELITE'
    when pontos >= 5000 then 'VETERANO'
    else 'APRENDIZ'
end;

select *
from jogadores;    

-- O SEGUNDO PROBLEMA: OS BÔNUS DESAPARECIDOS
select *
from jogadores
where bonus is null;

update jogadores
set bonus = coalesce(bonus, 0);    

-- O TERCEIRO PROBLEMA: A RECOMPENSA DOS JOGADORES ACIMA DA MÉDIA
select *
from jogadores
where pontos > (
	select avg(pontos)
    from jogadores
    ); 

UPDATE jogadores
SET moedas = moedas + 250
WHERE pontos > (
    SELECT media
    FROM (
        SELECT AVG(pontos) AS media
        FROM jogadores
    ) AS resultado
);

-- A QUARTA ETAPA: A GUERRA DAS GUILDAS
SELECT 
    guilda,
    ROUND(AVG(pontos), 2) AS media_pontos
FROM jogadores
WHERE guilda IS NOT NULL
GROUP BY guilda
HAVING AVG(pontos) > 7000;

update jogadores
set moedas = moedas + 300
where guilda in (
    select guilda
    from (
        select guilda
        from jogadores
        where guilda is not null
        group by guilda
        having avg(pontos) > 7000
    ) as vencedoras
);

-- A QUINTA ETAPA: O CONSELHO DOS CAMPEÕES
select *
from jogadores
order by pontos desc
limit 3;

update jogadores
set nivel = nivel + 1
order by pontos desc
limit 3;

-- A SEXTA ETAPA: O TREINAMENTO EMERGENCIAL
select *
from jogadores
where status_jogador = 'ATIVO' and nivel < 18;

update jogadores
set nivel = nivel + 2
where status_jogador = 'ATIVO' and nivel < 18;

-- A SÉTIMA ETAPA: OS ESPIÕES DE NULLMASTER
select *
from jogadores
where status_jogador = 'INATIVO' and pontos < 2000;

delete from jogadores
where status_jogador = 'INATIVO' and pontos < 2000;

-- A AUDITORIA FINAL DO REINO
select id, nome, nivel, moedas, pontos, guilda, bonus, status_jogador, classificacao
from jogadores
order by pontos desc;