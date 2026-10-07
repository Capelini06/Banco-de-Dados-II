create database safra;
use safra;

SELECT * FROM safra.garantia_safra;
-- exercicio 1
-- 1.1: Base filtrada por ano
select
	ano_referencia
	,mes_referencia
	,id_municipio
	,sigla_uf
	,nis_favorecido
	,nome_favorecido
	,valor_parcela
	,rn
from garantia_safra
where ano_referencia >= '2020';

-- 1.2: Qta de parcelas e total movimentado
select
	ano_referencia
    ,sigla_uf
    ,count(nis_favorecido) as qta_parcelas
    ,sum(valor_parcela) as valor_total
from garantia_safra
group by ano_referencia, sigla_uf;


-- 1.3: contagem de beneficiarios distintos e municipios atendidos
select
	ano_referencia
    ,sigla_uf
    ,count(distinct id_municipio) as municipios_atendidos
    ,count(distinct nis_favorecido) as beneficiarios_atendidos
from garantia_safra
group by ano_referencia, sigla_uf;

    
-- 1.4: ticket medio e maior valor de parcela    
select 
	ano_referencia
    ,sigla_uf
    ,round(sum(valor_parcela) / count(nis_favorecido), 2) as  ticket_medio
    ,max(valor_parcela) as maior_parcela
from garantia_safra
group by ano_referencia, sigla_uf;
    
-- 1.5: classificação
select
	ano_referencia
    ,sigla_uf
    ,count( case when valor_parcela >=800 then 'ALTA' end) as qta_alta
    ,count( case when valor_parcela >=500 and valor_parcela < 800 then 'MEDIA' end) as qta_media
    ,count( case when valor_parcela < 500 then 'BAIXA' end) as qta_baixa
    from garantia_safra
    group by ano_referencia, sigla_uf;

-- 1.6 relatorio final
with base_filtrada as (
    select
        ano_referencia,
        mes_referencia,
        id_municipio,
        sigla_uf,
        nis_favorecido,
        nome_favorecido,
        valor_parcela,
        rn
    from garantia_safra
    where ano_referencia >= 2020
),
info_financeiro as (
    select
        ano_referencia,
        sigla_uf,
        count(nis_favorecido) as qta_parcelas,
        sum(valor_parcela) as valor_total
    from garantia_safra
    group by ano_referencia, sigla_uf
),
base_contagem as (
    select
        ano_referencia,
        sigla_uf,
        count(distinct id_municipio) as municipios_atendidos,
        count(distinct nis_favorecido) as beneficiarios_unicos
    from garantia_safra
    group by ano_referencia, sigla_uf
),
base_ticket_medio as (
    select
        ano_referencia,
        sigla_uf,
        round(sum(valor_parcela) / count(nis_favorecido), 2) as ticket_medio,
        max(valor_parcela) as maior_parcela
    from garantia_safra
    group by ano_referencia, sigla_uf
),
base_classificacao as (
    select
        ano_referencia,
        sigla_uf,
        count(case when valor_parcela > 800 then 1 end) as qta_alta,
        count(case
            when valor_parcela >= 500
             and valor_parcela <= 800
            then 1
        end) as qta_media,
        count(case when valor_parcela < 500 then 1 end) as qta_baixa
    from garantia_safra
    group by ano_referencia, sigla_uf
)
select
    bf.sigla_uf,
    bf.ano_referencia,
    ifi.qta_parcelas,
    ifi.valor_total,
    bc.municipios_atendidos,
    bc.beneficiarios_unicos,
    btm.ticket_medio,
    btm.maior_parcela,
    bcl.qta_alta,
    bcl.qta_media,
    bcl.qta_baixa,
    case
        when btm.ticket_medio >= 800 then 'alta'
        when btm.ticket_medio >= 500 and btm.ticket_medio < 800 then 'media'
        when btm.ticket_medio < 500 then 'baixa'
    end as classificacao_ticket
from (
    select distinct
        ano_referencia,
        sigla_uf
    from base_filtrada
) as bf
left join info_financeiro ifi
    on ifi.ano_referencia = bf.ano_referencia
    and ifi.sigla_uf = bf.sigla_uf
left join base_contagem bc
    on bc.ano_referencia = bf.ano_referencia
    and bc.sigla_uf = bf.sigla_uf
left join base_ticket_medio btm
    on btm.ano_referencia = bf.ano_referencia
    and btm.sigla_uf = bf.sigla_uf
left join base_classificacao bcl
    on bcl.ano_referencia = bf.ano_referencia
    and bcl.sigla_uf = bf.sigla_uf
order by bf.ano_referencia asc, ifi.valor_total desc;


-- ---------------------------------------------------------
-- exercicio 2
-- 2.1 base 2020
select
	ano_referencia
	,mes_referencia
	,id_municipio
	,sigla_uf
	,nis_favorecido
	,nome_favorecido
	,valor_parcela
	,rn
from garantia_safra
where ano_referencia = '2020';

-- 2.2 valor total e parcelas
select
	ano_referencia
    ,sigla_uf
    ,count(nis_favorecido) as qta_parcelas
    ,sum(valor_parcela) as valor_total
from garantia_safra
where ano_referencia = '2020'
group by sigla_uf;

-- 2.3  benficiarios distintos
select
	sigla_uf
    ,count(distinct nis_favorecido) as beneficiarios_atendidos
from garantia_safra
where ano_referencia = '2020'
group by ano_referencia, sigla_uf;

-- 2.4 municipios diferentes
select
	sigla_uf
    ,count(distinct id_municipio) as municipios_atendidos
from garantia_safra
where ano_referencia = '2020'
group by ano_referencia, sigla_uf;

-- 2.5 valor total no brasil em 2020
select
	ano_referencia
    ,sum(valor_parcela) as valor_total_brasil
from garantia_safra
where ano_referencia = '2020';

-- 2.6 classificação uf
with valor_total_uf as (
	select
		ano_referencia
		,sigla_uf
		,count(nis_favorecido) as qta_parcelas
		,sum(valor_parcela) as valor_total
	from garantia_safra
	where ano_referencia = '2020'
	group by sigla_uf
)
select
	vtuf.ano_referencia
    ,vtuf.sigla_uf
	,case
		when vtuf.valor_total >= 20000 then 'alto'
		when vtuf.valor_total >= 10000 and vtuf.valor_total < 20000 then 'media'
		when vtuf.valor_total < 10000 then 'baixa'
	end as classificacao_valor_total
from garantia_safra as gs
join valor_total_uf vtuf
	on gs.ano_referencia = vtuf.ano_referencia
group by vtuf.ano_referencia ,vtuf.sigla_uf
order by classificacao_valor_total;

-- 2.7 top 5 UF que mais ganharam
	select
		ano_referencia
		,sigla_uf
		,sum(valor_parcela) as valor_total
	from garantia_safra
	where ano_referencia = '2020'
	group by sigla_uf
    order by valor_total desc
    limit 5;
    
-- 2.8
with base_filtrada as (
    select
        ano_referencia,
        mes_referencia,
        id_municipio,
        sigla_uf,
        nis_favorecido,
        nome_favorecido,
        valor_parcela,
        rn
    from garantia_safra
    where ano_referencia = '2020'
),
info_financeiro as (
    select
        ano_referencia,
        sigla_uf,
        count(nis_favorecido) as qta_parcelas,
        sum(valor_parcela) as valor_total
    from garantia_safra
    where ano_referencia = '2020'
    group by ano_referencia, sigla_uf
),
beneficiarios_distintos as (
    select
        ano_referencia,
        sigla_uf,
        count(distinct nis_favorecido) as beneficiarios_atendidos
    from garantia_safra
    where ano_referencia = '2020'
    group by ano_referencia, sigla_uf
),
municipios_distintos as (
    select
        ano_referencia,
        sigla_uf,
        count(distinct id_municipio) as municipios_atendidos
    from garantia_safra
    where ano_referencia = '2020'
    group by ano_referencia, sigla_uf
),
total_brasil as (
    select
        ano_referencia,
        sum(valor_parcela) as valor_total_brasil
    from garantia_safra
    where ano_referencia = '2020'
    group by ano_referencia
),
classificacao_uf as (
    select
        ano_referencia,
        sigla_uf,
        case
            when sum(valor_parcela) >= 20000 then 'alto'
            when sum(valor_parcela) >= 10000 then 'media'
            else 'baixa'
        end as classificacao_valor_total
    from garantia_safra
    where ano_referencia = '2020'
    group by ano_referencia, sigla_uf
),
top_5 as (
    select
        ano_referencia,
        sigla_uf,
        sum(valor_parcela) as valor_total,
        dense_rank() over (
            order by sum(valor_parcela) desc
        ) as ranking
    from garantia_safra
    where ano_referencia = '2020'
    group by ano_referencia, sigla_uf
)
select
    bf.sigla_uf,
    ifi.valor_total,
    ifi.qta_parcelas,
    bd.beneficiarios_atendidos,
    md.municipios_atendidos,
    round(
        ifi.valor_total / tb.valor_total_brasil * 100,
        2
    ) as participacao_pct,

    c.classificacao_valor_total as faixa,
    case
        when top.ranking = 1 then 'LIDER_BR'
        when top.ranking <= 5 then 'TOP_5'
        else null
    end as classificacao
from (
    select distinct
        ano_referencia,
        sigla_uf
    from base_filtrada
) as bf
left join info_financeiro ifi
    on ifi.ano_referencia = bf.ano_referencia
    and ifi.sigla_uf = bf.sigla_uf
left join beneficiarios_distintos bd
    on bd.ano_referencia = bf.ano_referencia
    and bd.sigla_uf = bf.sigla_uf
left join municipios_distintos md
    on md.ano_referencia = bf.ano_referencia
    and md.sigla_uf = bf.sigla_uf
left join total_brasil tb
    on tb.ano_referencia = bf.ano_referencia
left join classificacao_uf c
    on c.ano_referencia = bf.ano_referencia
    and c.sigla_uf = bf.sigla_uf
left join top_5 top
    on top.ano_referencia = bf.ano_referencia
    and top.sigla_uf = bf.sigla_uf
order by participacao_pct desc
limit 5;



-- 3.1
select
	ano_referencia
	,mes_referencia
	,id_municipio
	,sigla_uf
	,nis_favorecido
	,nome_favorecido
	,valor_parcela
	,rn
from garantia_safra
where ano_referencia >= '2020';
-- 3.2
select
    sigla_uf,
    id_municipio,
    ano_referencia,
    nome_favorecido,
    sum(valor_parcela) as valor_total,
    round(avg(valor_parcela), 2) as media_por_parcela
from garantia_safra
group by sigla_uf,id_municipio,ano_referencia,nome_favorecido;

-- 3-3
select
	sigla_uf
    ,id_municipio
    ,ano_referencia
    ,sum(valor_parcela) as valor_total
from garantia_safra
group by sigla_uf,id_municipio,ano_referencia
order by ano_referencia;

-- 3-4
with valor_total_favorecido as (
    select
        sigla_uf,
        id_municipio,
        ano_referencia,
        nome_favorecido,
        sum(valor_parcela) as valor_total
    from garantia_safra
    group by
        sigla_uf,
        id_municipio,
        ano_referencia,
        nome_favorecido
)
select
    id_municipio,
    ano_referencia,
    max(valor_total) as maior_valor_total
from valor_total_favorecido
group by
    id_municipio,
    ano_referencia;


-- 3-5
select
	nome_favorecido
    ,case
            when sum(valor_parcela) >= 800 then 'alto'
            when sum(valor_parcela) >= 500 and sum(valor_parcela) <800 then 'media'
            else 'baixa'
        end as classificacao_valor_total
from garantia_safra
group by nome_favorecido;






with base_filtrada as (
    select
        ano_referencia,
        mes_referencia,
        id_municipio,
        sigla_uf,
        nis_favorecido,
        nome_favorecido,
        valor_parcela,
        rn
    from garantia_safra
    where ano_referencia >= '2020'
),
segundo as (
    select
        sigla_uf,
        id_municipio,
        ano_referencia,
        nome_favorecido,
        sum(valor_parcela) as valor_total,
        round(avg(valor_parcela), 2) as media_por_parcela,
        count(*) as qtd_parcelas
    from garantia_safra
    where ano_referencia >= '2020'
    group by
        sigla_uf,
        id_municipio,
        ano_referencia,
        nome_favorecido
),
terceiro as (
    select
        sigla_uf,
        id_municipio,
        ano_referencia,
        sum(valor_parcela) as total_municipio
    from garantia_safra
    where ano_referencia >= '2020'
    group by
        sigla_uf,
        id_municipio,
        ano_referencia
),
quarto as (
    select
        id_municipio,
        ano_referencia,
        max(valor_total) as maior_valor_individual
    from segundo
    group by
        id_municipio,
        ano_referencia
),
quinto as (
    select
        nome_favorecido,
        case
            when sum(valor_parcela) >= 800 then 'alto'
            when sum(valor_parcela) >= 500 then 'media'
            else 'baixa'
        end as classificacao_valor_total
    from garantia_safra
    group by nome_favorecido
)
select
    s.sigla_uf,
    s.id_municipio,
    s.ano_referencia,
    s.nome_favorecido,
    s.valor_total,
    s.media_por_parcela,
    s.qtd_parcelas,
    t.total_municipio,
    q.maior_valor_individual,
    case
        when s.valor_total >= 800 then 'alto'
        when s.valor_total >= 500 then 'media'
        else 'baixa'
    end as faixa_valor,
    case
        when s.valor_total = q.maior_valor_individual
            then 'DESTAQUE_MUNICIPAL'
        else 'OUTROS'
    end as grupo_destaque
from segundo s
left join terceiro t
    on t.sigla_uf = s.sigla_uf
    and t.id_municipio = s.id_municipio
    and t.ano_referencia = s.ano_referencia
left join quarto q
    on q.id_municipio = s.id_municipio
    and q.ano_referencia = s.ano_referencia
order by
    s.ano_referencia,
    s.sigla_uf,
    s.id_municipio,
    s.valor_total desc;
