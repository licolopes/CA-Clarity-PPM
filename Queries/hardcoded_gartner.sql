SELECT
*
FROM
(

---------------------- Informações Realizado Ano Anterior ----------------------

SELECT
	'Realizado 2015' CATEGORIA
	, 'Operação' SERIES
	, 56810000 VALOR

UNION ALL

SELECT
	'Realizado 2015' CATEGORIA
	, 'Projetos Novos Negocios' SERIES
	, 10340000 VALOR

UNION ALL

SELECT
	'Realizado 2015' CATEGORIA
	, 'Disponivel Novas Demandas Projetos /Operação' SERIES
	, NULL VALOR

UNION ALL

SELECT
	'Realizado 2015' CATEGORIA
	, 'Projetos de TI' SERIES
	, 9610000 VALOR
UNION ALL

SELECT
	'Realizado 2015' CATEGORIA
	, 'Projetos de Inovação e Melhorias' SERIES
	, 22240000 VALOR

UNION ALL

SELECT
	'Realizado 2015' CATEGORIA
	, 'Orçado Disponível de Folha para Novas Demandas de Projetos' SERIES
	, NULL VALOR

---------------------- Informações Realizado Ano/Mês Atual ----------------------
UNION ALL

SELECT
	'Realizado 2016_08' CATEGORIA
	, 'Operação' SERIES
	, 38030000 VALOR

UNION ALL

SELECT
	'Realizado 2016_08' CATEGORIA
	, 'Projetos Novos Negocios' SERIES
	, 15260000 VALOR

UNION ALL

SELECT
	'Realizado 2016_08' CATEGORIA
	, 'Disponivel Novas Demandas Projetos /Operação' SERIES
	, NULL VALOR

UNION ALL

SELECT
	'Realizado 2016_08' CATEGORIA
	, 'Projetos de TI' SERIES
	, 6110000 VALOR
UNION ALL

SELECT
	'Realizado 2016_08' CATEGORIA
	, 'Projetos de Inovação e Melhorias' SERIES
	, 10400000 VALOR

UNION ALL

SELECT
	'Realizado 2016_08' CATEGORIA
	, 'Orçado Disponível de Folha para Novas Demandas de Projetos' SERIES
	, NULL VALOR

---------------------- Informações Orçado Ano Atual ----------------------
UNION ALL

SELECT
	'Orçado 2016' CATEGORIA
	, 'Operação' SERIES
	, 62510000 VALOR

UNION ALL

SELECT
	'Orçado 2016' CATEGORIA
	, 'Projetos Novos Negocios' SERIES
	, 25610000 VALOR

UNION ALL

SELECT
	'Orçado 2016' CATEGORIA
	, 'Disponivel Novas Demandas Projetos /Operação' SERIES
	, -11720000 VALOR

UNION ALL

SELECT
	'Orçado 2016' CATEGORIA
	, 'Projetos de TI' SERIES
	, 8010000 VALOR
UNION ALL

SELECT
	'Orçado 2016' CATEGORIA
	, 'Projetos de Inovação e Melhorias' SERIES
	, 15770000 VALOR

UNION ALL

SELECT
	'Orçado 2016' CATEGORIA
	, 'Orçado Disponível de Folha para Novas Demandas de Projetos' SERIES
	, 4160000 VALOR
) AMTS