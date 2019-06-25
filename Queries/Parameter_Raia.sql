SELECT

	RAIA

FROM(

	SELECT DISTINCT

		CASE
			WHEN RAIA.NAME = 'ERP' THEN 'ERP'
			WHEN RAIA.NAME = 'Projetos de Curta Duração (Fast Track)' THEN 'Fast Track'
			WHEN RAIA.NAME = 'Projetos de Desenvolvimento de Novas Soluções de Negócios' THEN 'DNSN'
			WHEN RAIA.NAME = 'Projetos de Manutenção e Sustentação do Negócio' THEN 'MSN'
			WHEN RAIA.NAME = 'Segurança' THEN 'Segurança'
			WHEN RAIA.NAME = 'Sem CAPEX Compartilhado' THEN 'Sem CAPEX Compartilhado'
			WHEN RAIA.NAME = 'Soluções e Serviços BackOffice' THEN 'BKO'
			WHEN RAIA.NAME = 'Ferramentas Administrativas' THEN 'BKO'      
		END RAIA

	FROM
		INV_INVESTMENTS INV
		LEFT JOIN ODF_CA_IDEA OIDEA ON OIDEA.ID = INV.ID
		LEFT JOIN CMN_LOOKUPS_V RAIA ON RAIA.LOOKUP_CODE = OIDEA.TB_TP_PJT_PRIOZ_CORP AND RAIA.LOOKUP_TYPE = 'TB_PC_TP_PROJETO' AND RAIA.LANGUAGE_CODE = 'pt'
) AMTS

WHERE 
	RAIA IS NOT NULL

ORDER BY
	RAIA ASC