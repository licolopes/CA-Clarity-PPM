SELECT
  DIR_SOLICITANTE
  , COUNT(INV_ID) QTD

FROM
(

	SELECT DISTINCT
		INV.ID INV_ID
		, INV.CODE INV_CODE
		, INV.NAME INV_NAME
		, CATEGORIA.NAME CATEGORIA
		, CASE
			WHEN RAIA.NAME = 'ERP' THEN 'ERP'
			WHEN RAIA.NAME = 'Projetos de Curta Duração (Fast Track)' THEN 'Fast Track'
			WHEN RAIA.NAME = 'Projetos de Desenvolvimento de Novas Soluções de Negócios' THEN 'DNSN'
			WHEN RAIA.NAME = 'Projetos de Manutenção e Sustentação do Negócio' THEN 'MSN'
			WHEN RAIA.NAME = 'Segurança' THEN 'Segurança'
			WHEN RAIA.NAME = 'Sem CAPEX Compartilhado' THEN 'Sem CAPEX Compartilhado'
			WHEN RAIA.NAME = 'Soluções e Serviços BackOffice' THEN 'BKO'
			WHEN RAIA.NAME = 'Ferramentas Administrativas' THEN 'BKO'      
			END RAIA
		, CASE
			WHEN DIR_SOLICITANTE.NAME = 'Diretoria AF&Pessoas' THEN 'Dir. AF&Pessoas'
			WHEN DIR_SOLICITANTE.NAME = 'Diretoria de Negócios e Soluções' THEN 'Dir. de Neg. e Soluções'
			WHEN DIR_SOLICITANTE.NAME = 'Diretoria de Operações' THEN 'Dir. de Operações'
			WHEN DIR_SOLICITANTE.NAME = 'Diretoria de Relacionamento' THEN 'Dir. de Relacionamento'
			WHEN DIR_SOLICITANTE.NAME = 'Diretoria de Tec. da Informação' THEN 'Dir. de Tec. da Informação'
			WHEN DIR_SOLICITANTE.NAME = 'Diretoria Geral' THEN 'Dir. Geral'        
			END DIR_SOLICITANTE
		, CLIENTE.NAME CLIENTE
		, AREA_GEST.NAME AREA_GEST
		, STATUS_DEM.NAME STATUS_DEM

	FROM
		INV_INVESTMENTS INV
		LEFT JOIN ODF_CA_IDEA OIDEA ON OIDEA.ID = INV.ID
		LEFT JOIN ODF_CA_INV OINV ON OINV.ID = INV.ID
		LEFT JOIN CMN_LOOKUPS_V CATEGORIA ON CATEGORIA.LOOKUP_CODE = OIDEA.OBJ_REQUEST_TYPE AND CATEGORIA.LOOKUP_TYPE = 'OBJ_IDEA_PROJECT_TYPE' AND CATEGORIA.LANGUAGE_CODE = 'pt'
		LEFT JOIN CMN_LOOKUPS_V RAIA ON RAIA.LOOKUP_CODE = OIDEA.TB_TP_PJT_PRIOZ_CORP AND RAIA.LOOKUP_TYPE = 'TB_PC_TP_PROJETO' AND RAIA.LANGUAGE_CODE = 'pt'
		LEFT JOIN CMN_LOOKUPS_V DIR_SOLICITANTE ON DIR_SOLICITANTE.LOOKUP_CODE = OINV.TB_INV_DIR_SOLIC AND DIR_SOLICITANTE.LOOKUP_TYPE = 'TB_LISTA_DIRETORIAS' AND DIR_SOLICITANTE.LANGUAGE_CODE = 'pt'
		LEFT JOIN CMN_LOOKUPS_V CLIENTE ON CLIENTE.LOOKUP_CODE = OINV.TB_CLIENTE_EXTERNO AND CLIENTE.LOOKUP_TYPE = 'TB_LISTA_CLIENTES' AND CLIENTE.LANGUAGE_CODE = 'pt'
		LEFT JOIN CMN_LOOKUPS_V AREA_GEST ON AREA_GEST.LOOKUP_CODE = OIDEA.TB_AREA_APROVADORA AND AREA_GEST.LOOKUP_TYPE = 'TB_AREA_APROVADORA' AND AREA_GEST.LANGUAGE_CODE = 'pt'
		LEFT JOIN CMN_LOOKUPS_V STATUS_DEM ON STATUS_DEM.LOOKUP_CODE = OIDEA.TB_STAT_DEMANDA AND STATUS_DEM.LOOKUP_TYPE = 'TB_STATUS_DEMANDA' AND STATUS_DEM.LANGUAGE_CODE = 'pt'

	WHERE
		INV.ODF_OBJECT_CODE = 'idea'
		AND INV.IS_ACTIVE = 1
	
) AMTS

WHERE
	DIR_SOLICITANTE IS NOT NULL
	AND $X{IN,RAIA,raia} 
	AND $X{IN,CLIENTE,clientes}
	AND $X{IN,CATEGORIA,categ_demanda}

GROUP BY
	DIR_SOLICITANTE

ORDER BY
	DIR_SOLICITANTE ASC