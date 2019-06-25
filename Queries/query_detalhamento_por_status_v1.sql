DECLARE @PARAM VARCHAR
SET @PARAM = 'sim'

SELECT
"Status"
, SUM("Quantidade") "Quantidade"
, SUM("Aprovado REP") "Aprovado REP"
, SUM("Aprovado REP Capex") "Aprovado REP Capex"
, SUM("Aprovado REP Opex") "Aprovado REP Opex"
, SUM("Anos Anteriores Realizado Capex") "Anos Anteriores Realizado Capex"
, SUM("Anos Anteriores Realizado Opex") "Anos Anteriores Realizado Opex"
, SUM("Ano atual Realizado Capex") "Ano atual Realizado Capex" 
, SUM("Ano atual Realizado Opex") "Ano atual Realizado Opex"
, SUM("Ano atual Planejado Capex") "Ano atual Planejado Capex"
, SUM("Ano Atual Planejado Opex") "Ano Atual Planejado Opex"
, SUM("Anos Posteriores Planejado de Capex") "Anos Posteriores Planejado de Capex"
, SUM("Anos Posteriores Planejado de Opex") "Anos Posteriores Planejado de Opex"
, SUM("Total Realizado de Capex") "Total Realizado de Capex"
, SUM("Total Realizado de Opex") "Total Realizado de Opex"
, SUM("Total Realizado") "Total Realizado" 
FROM
(
	SELECT
	"Status"
	, "Quantidade"
	, "Aprovado REP"
	, "Aprovado REP Capex"
	, "Aprovado REP Opex"
	, "Anos Anteriores Realizado Capex" 
	, "Anos Anteriores Realizado Opex"
	, "Ano atual Realizado Capex"
	, "Ano atual Realizado Opex"
	, "Ano atual Planejado Capex"
	, "Ano Atual Planejado Opex"
	, "Anos Posteriores Planejado de Capex"
	, "Anos Posteriores Planejado de Opex"
	, "Total Realizado de Capex"
	, "Total Realizado de Opex"
	, "Total Realizado" 
	, CASE
		WHEN DATEPART(YEAR,"Data") = DATEPART(YEAR,(SELECT MAX(hm_data_corte) FROM NIKU.ODF_CA_HM_DATA_RELATORIO WHERE hm_aprovado = 1)) - 1 THEN 'ano_anterior'
		WHEN DATEPART(YEAR,"Data") = DATEPART(YEAR,(SELECT MAX(hm_data_corte) FROM NIKU.ODF_CA_HM_DATA_RELATORIO WHERE hm_aprovado = 1)) THEN 'ano_atual'
		WHEN DATEPART(YEAR,"Data") = DATEPART(YEAR,(SELECT MAX(hm_data_corte) FROM NIKU.ODF_CA_HM_DATA_RELATORIO WHERE hm_aprovado = 1)) + 1 THEN 'ano_posterior'
		ELSE 'Não Informado'
		END "Data de Referência - Status"
	FROM
	(
		SELECT
		"Status"
		, CASE
			WHEN "Status" = 'A entregar' THEN "Data Go Live"
			WHEN "Status" = 'Entregue' THEN "Data Go Live"
			WHEN "Status" = 'Cancelado' THEN "Data Cancelamento/Suspensão"
			WHEN "Status" = 'On Hold' THEN "Data Cancelamento/Suspensão"
			END "Data"
		, COUNT("Status") "Quantidade"
		, ISNULL(SUM("Aprov REP"),0) "Aprovado REP"
		, ISNULL(SUM("Aprov REP Capex"),0) "Aprovado REP Capex"
		, ISNULL(SUM("Aprov REP Opex"),0) "Aprovado REP Opex"
		, ISNULL(SUM("Anos Ant Capex" ),0) "Anos Anteriores Realizado Capex" 
		, ISNULL(SUM("Anos Ant Opex"),0) "Anos Anteriores Realizado Opex"
		, ISNULL(SUM("Ano atual Gasto Capex"),0) "Ano atual Realizado Capex"
		, ISNULL(SUM("Ano atual Gasto Opex"),0) "Ano atual Realizado Opex"
		, ISNULL(SUM("Ano atual Prev Capex"),0) "Ano atual Planejado Capex"
		, ISNULL(SUM("Ano Atual Prev Opex"),0) "Ano Atual Planejado Opex"
		, ISNULL(SUM("Anos Post Prev Capex"),0) "Anos Posteriores Planejado de Capex"
		, ISNULL(SUM("Anos Post Prev Opex"),0) "Anos Posteriores Planejado de Opex"
		, ISNULL(SUM("Realizado Capex"),0) "Total Realizado de Capex"
		, ISNULL(SUM("Realizado Opex"),0) "Total Realizado de Opex"
		, ISNULL(SUM("Realizado Capex" + "Realizado Opex"),0) "Total Realizado"


		FROM
		(
			SELECT
				INVI.NAME "Descrição do Projetos"
				, INVI.CODE "Código do Projeto"
				, INVI.ID "ÍD do Projeto"
				, TIPO_PROJ.NAME "Tipo do projeto"
				, DIR_EXEC.NAME "Diretoria Executiva"
				, TIPO_COMITE.NAME "Tipo - Comitê Executivo"
				, OCPRJ.data_cancelamento "Data Cancelamento/Suspensão"
				, CASE 
					WHEN OCPRJ.data_go_live IS NOT NULL THEN OCPRJ.data_go_live
					WHEN OCPRJ.data_go_live IS NULL THEN OCPRJ.hm_data_go_live_orig
					WHEN OCPRJ.data_go_live IS NULL AND OCPRJ.hm_data_go_live_orig IS NULL THEN NULL
					ELSE NULL
					END "Data Go Live"				
				, CASE 
					WHEN STATUS.NAME = 'Desenho' THEN 'A entregar'
					WHEN STATUS.NAME = 'Desenvolvimento' THEN 'A entregar'
					WHEN STATUS.NAME = 'Planejamento' THEN 'A entregar'
					WHEN STATUS.NAME = 'Preparação Final' THEN 'A entregar'
					WHEN STATUS.NAME = 'Testes' THEN 'A entregar'
					WHEN STATUS.NAME = 'Cancelada' THEN 'Cancelado'
					WHEN STATUS.NAME = 'Cancelamento Solicitado' THEN 'Cancelado'
					WHEN STATUS.NAME = 'Aguardando Aprovação' THEN 'Em análise'
					WHEN STATUS.NAME = 'Aprovada' THEN 'Em análise'
					WHEN STATUS.NAME = 'Convertida em Projeto' THEN 'Em análise'
					WHEN STATUS.NAME = 'Em Análise' THEN 'Em análise'
					WHEN STATUS.NAME = 'Em Análise da Viab. Técnica' THEN 'Em análise'
					WHEN STATUS.NAME = 'Em Análise Para Aprovação' THEN 'Em análise'
					WHEN STATUS.NAME = 'Não Existe' THEN 'Em análise'
					WHEN STATUS.NAME = 'Planejando Solução' THEN 'Em análise'
					WHEN STATUS.NAME = 'Priorizada' THEN 'Em análise'
					WHEN STATUS.NAME = 'Solicitada' THEN 'Em análise'
					WHEN STATUS.NAME = 'Validando Planejamento' THEN 'Em análise'
					WHEN STATUS.NAME = 'Encerrado' THEN 'Entregue'
					WHEN STATUS.NAME = 'Encerramento' THEN 'Entregue'
					WHEN STATUS.NAME = 'SPGL' THEN 'Entregue'
					WHEN STATUS.NAME = 'On Hold' THEN 'On Hold'
					WHEN STATUS.NAME = 'Suspensão Solicitada' THEN 'On Hold'				
					END STATUS				
				, CASE
					WHEN CUSTO_DEMANDA.NAME = 'Maior que 250K' THEN '>= 250K'
					WHEN CUSTO_DEMANDA.NAME = 'Maior que 500K' THEN '>= 250K'
					WHEN CUSTO_DEMANDA.NAME = 'Entre 150K e 500K' THEN '>= 250K'
					ELSE '< 250K'
					END "> 250K ?"
				, ISNULL(FFIN.PLANNED_CST_TOTAL,0) "Aprov REP"
				, ISNULL(FFIN.PLANNED_CST_CAPITAL_TOTAL,0) "Aprov REP Capex"
				, ISNULL(FFIN.PLANNED_CST_OPERATING_TOTAL,0) "Aprov REP Opex"
				, 	(
						SELECT 
							ISNULL(SUM(PV.TOTALCOST),0)
						FROM 
							NIKU.PPA_WIP PW 
							LEFT JOIN NIKU.PPA_WIP_VALUES PV ON PW.TRANSNO = PV.TRANSNO AND PV.CURRENCY_TYPE = 'HOME'
							LEFT JOIN NIKU.PAC_MNT_PROJECTS PMPRJ ON PMPRJ.ID = PW.INVESTMENT_ID
						WHERE
							PW.INVESTMENT_ID = INVI.ID
							AND PMPRJ.COST_TYPE = 'CAPITAL'
							AND DATEPART(YEAR,PW.ENTRYDATE) = DATEPART(YEAR,(SELECT MAX(hm_data_corte) FROM NIKU.ODF_CA_HM_DATA_RELATORIO WHERE hm_aprovado = 1)) - 1			
					) "Anos Ant Capex"
				, 	(
						SELECT 
							ISNULL(SUM(PV.TOTALCOST),0)
						FROM 
							NIKU.PPA_WIP PW 
							LEFT JOIN NIKU.PPA_WIP_VALUES PV ON PW.TRANSNO = PV.TRANSNO AND PV.CURRENCY_TYPE = 'HOME'
							LEFT JOIN NIKU.PAC_MNT_PROJECTS PMPRJ ON PMPRJ.ID = PW.INVESTMENT_ID
						WHERE
							PW.INVESTMENT_ID = INVI.ID
							AND PMPRJ.COST_TYPE = 'OPERATING'
							AND (
									(@PARAM = 'sim' AND PW.RESOURCE_CLASS = 'RECINT') 
									OR (@PARAM = 'nao' AND PW.RESOURCE_CLASS != 'RECINT')
									OR (@PARAM = 'tudo')
								)
							AND DATEPART(YEAR,PW.ENTRYDATE) = DATEPART(YEAR,(SELECT MAX(hm_data_corte) FROM NIKU.ODF_CA_HM_DATA_RELATORIO WHERE hm_aprovado = 1)) - 1			
					) "Anos Ant Opex"
				,	(
						SELECT 
							ISNULL(SUM(PV.TOTALCOST),0)
						FROM 
							NIKU.PPA_WIP PW 
							LEFT JOIN NIKU.PPA_WIP_VALUES PV ON PW.TRANSNO = PV.TRANSNO AND PV.CURRENCY_TYPE = 'HOME'
							LEFT JOIN NIKU.PAC_MNT_PROJECTS PMPRJ ON PMPRJ.ID = PW.INVESTMENT_ID
						WHERE
							PW.INVESTMENT_ID = INVI.ID
							AND PMPRJ.COST_TYPE = 'CAPITAL'
							AND DATEPART(YEAR,PW.ENTRYDATE) = DATEPART(YEAR,(SELECT MAX(hm_data_corte) FROM NIKU.ODF_CA_HM_DATA_RELATORIO WHERE hm_aprovado = 1))
					) "Ano atual Gasto Capex"
				,	(
						SELECT 
							ISNULL(SUM(PV.TOTALCOST),0)
						FROM 
							NIKU.PPA_WIP PW 
							LEFT JOIN NIKU.PPA_WIP_VALUES PV ON PW.TRANSNO = PV.TRANSNO AND PV.CURRENCY_TYPE = 'HOME'
							LEFT JOIN NIKU.PAC_MNT_PROJECTS PMPRJ ON PMPRJ.ID = PW.INVESTMENT_ID
						WHERE
							PW.INVESTMENT_ID = INVI.ID
							AND PMPRJ.COST_TYPE = 'OPERATING'
							AND (
									(@PARAM = 'sim' AND PW.RESOURCE_CLASS = 'RECINT') 
									OR (@PARAM = 'nao' AND PW.RESOURCE_CLASS != 'RECINT')
									OR (@PARAM = 'tudo')
								)
							AND DATEPART(YEAR,PW.ENTRYDATE) = DATEPART(YEAR,(SELECT MAX(hm_data_corte) FROM NIKU.ODF_CA_HM_DATA_RELATORIO WHERE hm_aprovado = 1))
					) "Ano atual Gasto Opex"
				, 	(
						SELECT
							SUM(ISNULL(ROUND((DATEDIFF(DAY,FP_COST.START_DATE,FP_COST.FINISH_DATE)*FP_COST.SLICE),0),0))
						FROM
							NIKU.FIN_PLANS FIN_PLAN
							LEFT JOIN NIKU.FIN_COST_PLAN_DETAILS FPD on FIN_PLAN.ID = FPD.PLAN_ID
							LEFT JOIN NIKU.ODF_CA_COSTPLAN OCA_COST on FIN_PLAN.ID = OCA_COST.ID
							LEFT JOIN NIKU.ODF_SSL_CST_DTL_COST FP_COST ON FPD.ID = FP_COST.PRJ_OBJECT_ID
							LEFT JOIN NIKU.PAC_FOS_RESOURCE_CLASS RES_CLASS ON RES_CLASS.ID = FPD.RESOURCE_CLASS_ID
							LEFT JOIN NIKU.PAC_MNT_PROJECTS PMPRJ ON PMPRJ.ID = INVI.ID
						WHERE
							FIN_PLAN.OBJECT_ID = INVI.ID
							AND FIN_PLAN.IS_PLAN_OF_RECORD = 1
							AND hm_tipo_plano_custo = 'planejado'
							AND PMPRJ.COST_TYPE = 'CAPITAL'						
							AND DATEPART(YEAR,FP_COST.START_DATE) = DATEPART(YEAR,(SELECT MAX(hm_data_corte) FROM NIKU.ODF_CA_HM_DATA_RELATORIO WHERE hm_aprovado = 1))		
					) "Ano atual Prev Capex"
				, 	(
						SELECT
							SUM(ISNULL(ROUND((DATEDIFF(DAY,FP_COST.START_DATE,FP_COST.FINISH_DATE)*FP_COST.SLICE),0),0))
						FROM
							NIKU.FIN_PLANS FIN_PLAN
							LEFT JOIN NIKU.FIN_COST_PLAN_DETAILS FPD on FIN_PLAN.ID = FPD.PLAN_ID
							LEFT JOIN NIKU.ODF_CA_COSTPLAN OCA_COST on FIN_PLAN.ID = OCA_COST.ID
							LEFT JOIN NIKU.ODF_SSL_CST_DTL_COST FP_COST ON FPD.ID = FP_COST.PRJ_OBJECT_ID
							LEFT JOIN NIKU.PAC_FOS_RESOURCE_CLASS RES_CLASS ON RES_CLASS.ID = FPD.RESOURCE_CLASS_ID
							LEFT JOIN NIKU.PAC_MNT_PROJECTS PMPRJ ON PMPRJ.ID = INVI.ID
						WHERE
							FIN_PLAN.OBJECT_ID = INVI.ID
							AND FIN_PLAN.IS_PLAN_OF_RECORD = 1
							AND hm_tipo_plano_custo = 'planejado'
							AND PMPRJ.COST_TYPE = 'OPERATING'
							AND (
									(@PARAM = 'sim' AND RES_CLASS.RESOURCE_CLASS = 'RECINT') 
									OR (@PARAM = 'nao' AND RES_CLASS.RESOURCE_CLASS != 'RECINT')
									OR (@PARAM = 'tudo')
								)
							AND DATEPART(YEAR,FP_COST.START_DATE) = DATEPART(YEAR,(SELECT MAX(hm_data_corte) FROM NIKU.ODF_CA_HM_DATA_RELATORIO WHERE hm_aprovado = 1))		
					) "Ano Atual Prev Opex"
				, 	(
						SELECT
							SUM(ISNULL(ROUND((DATEDIFF(DAY,FP_COST.START_DATE,FP_COST.FINISH_DATE)*FP_COST.SLICE),0),0))
						FROM
							NIKU.FIN_PLANS FIN_PLAN
							LEFT JOIN NIKU.FIN_COST_PLAN_DETAILS FPD on FIN_PLAN.ID = FPD.PLAN_ID
							LEFT JOIN NIKU.ODF_CA_COSTPLAN OCA_COST on FIN_PLAN.ID = OCA_COST.ID
							LEFT JOIN NIKU.ODF_SSL_CST_DTL_COST FP_COST ON FPD.ID = FP_COST.PRJ_OBJECT_ID
							LEFT JOIN NIKU.PAC_FOS_RESOURCE_CLASS RES_CLASS ON RES_CLASS.ID = FPD.RESOURCE_CLASS_ID
							LEFT JOIN NIKU.PAC_MNT_PROJECTS PMPRJ ON PMPRJ.ID = INVI.ID
						WHERE
							FIN_PLAN.OBJECT_ID = INVI.ID
							AND FIN_PLAN.IS_PLAN_OF_RECORD = 1
							AND hm_tipo_plano_custo = 'planejado'
							AND PMPRJ.COST_TYPE = 'CAPITAL'
							AND DATEPART(YEAR,FP_COST.START_DATE) = DATEPART(YEAR,(SELECT MAX(hm_data_corte) FROM NIKU.ODF_CA_HM_DATA_RELATORIO WHERE hm_aprovado = 1)) + 1	
					) "Anos Post Prev Capex"
				, 	(
						SELECT
							SUM(ISNULL(ROUND((DATEDIFF(DAY,FP_COST.START_DATE,FP_COST.FINISH_DATE)*FP_COST.SLICE),0),0))
						FROM
							NIKU.FIN_PLANS FIN_PLAN
							LEFT JOIN NIKU.FIN_COST_PLAN_DETAILS FPD on FIN_PLAN.ID = FPD.PLAN_ID
							LEFT JOIN NIKU.ODF_CA_COSTPLAN OCA_COST on FIN_PLAN.ID = OCA_COST.ID
							LEFT JOIN NIKU.ODF_SSL_CST_DTL_COST FP_COST ON FPD.ID = FP_COST.PRJ_OBJECT_ID
							LEFT JOIN NIKU.PAC_FOS_RESOURCE_CLASS RES_CLASS ON RES_CLASS.ID = FPD.RESOURCE_CLASS_ID
							LEFT JOIN NIKU.PAC_MNT_PROJECTS PMPRJ ON PMPRJ.ID = INVI.ID
						WHERE
							FIN_PLAN.OBJECT_ID = INVI.ID
							AND FIN_PLAN.IS_PLAN_OF_RECORD = 1
							AND hm_tipo_plano_custo = 'planejado'
							AND PMPRJ.COST_TYPE = 'OPERATING'
							AND (
									(@PARAM = 'sim' AND RES_CLASS.RESOURCE_CLASS = 'RECINT') 
									OR (@PARAM = 'nao' AND RES_CLASS.RESOURCE_CLASS != 'RECINT')
									OR (@PARAM = 'tudo')
								)
							AND DATEPART(YEAR,FP_COST.START_DATE) = DATEPART(YEAR,(SELECT MAX(hm_data_corte) FROM NIKU.ODF_CA_HM_DATA_RELATORIO WHERE hm_aprovado = 1)) + 1		
					) "Anos Post Prev Opex"
				,	(
						SELECT 
							ISNULL(SUM(PV.TOTALCOST),0)
						FROM 
							NIKU.PPA_WIP PW 
							LEFT JOIN NIKU.PPA_WIP_VALUES PV ON PW.TRANSNO = PV.TRANSNO AND PV.CURRENCY_TYPE = 'HOME'
							LEFT JOIN NIKU.PAC_MNT_PROJECTS PMPRJ ON PMPRJ.ID = PW.INVESTMENT_ID
						WHERE
							PW.INVESTMENT_ID = INVI.ID
							AND PMPRJ.COST_TYPE = 'CAPITAL'
					) "Realizado Capex"
				,	(
						SELECT 
							ISNULL(SUM(PV.TOTALCOST),0)
						FROM 
							NIKU.PPA_WIP PW 
							LEFT JOIN NIKU.PPA_WIP_VALUES PV ON PW.TRANSNO = PV.TRANSNO AND PV.CURRENCY_TYPE = 'HOME'
							LEFT JOIN NIKU.PAC_MNT_PROJECTS PMPRJ ON PMPRJ.ID = PW.INVESTMENT_ID
						WHERE
							PW.INVESTMENT_ID = INVI.ID
							AND (
									(@PARAM = 'sim' AND PW.RESOURCE_CLASS = 'RECINT') 
									OR (@PARAM = 'nao' AND PW.RESOURCE_CLASS != 'RECINT')
									OR (@PARAM = 'tudo')
								)
							AND PMPRJ.COST_TYPE = 'OPERATING'
					) "Realizado Opex"				

			FROM
				NIKU.INV_INVESTMENTS INVI
				LEFT JOIN NIKU.ODF_CA_INV OCINV ON INVI.ID = OCINV.ID
				LEFT JOIN NIKU.ODF_CA_INV IDEA_OCINV ON INVI.IDEA_ID = IDEA_OCINV.ID
				LEFT JOIN NIKU.ODF_CA_PROJECT OCPRJ ON INVI.ID = OCPRJ.ID
				LEFT JOIN NIKU.PAC_MNT_PROJECTS PMPRJ ON INVI.ID = PMPRJ.ID
				LEFT JOIN NIKU.FIN_FINANCIALS FFIN ON INVI.ID = FFIN.ID
				LEFT JOIN NIKU.FIN_FINANCIALS IDEA_FFIN ON IDEA_FFIN.ID = INVI.IDEA_ID
				LEFT JOIN NIKU.FIN_PLANS FIN_PLAN ON FIN_PLAN.OBJECT_ID = INVI.ID AND FIN_PLAN.IS_PLAN_OF_RECORD = 1
				LEFT JOIN NIKU.BIZ_COM_PERIODS BIZ ON BIZ.ID = FIN_PLAN.END_PERIOD_ID
				LEFT JOIN NIKU.CMN_SEC_USERS USR ON USR.ID = INVI.MANAGER_ID
				LEFT JOIN NIKU.ODF_CA_HM_ORDEM_SAP OSAP ON OSAP.ODF_PARENT_ID = INVI.ID
				LEFT JOIN NIKU.CMN_LOOKUPS_V DIR_EXEC ON DIR_EXEC.LOOKUP_CODE = OCINV.HM_NOME_DIRETORIA AND DIR_EXEC.LANGUAGE_CODE = 'pt' AND DIR_EXEC.LOOKUP_TYPE = 'HM_LKP_NOME_DIRETORIA' 
				LEFT JOIN NIKU.CMN_LOOKUPS_V DIVISAO ON DIVISAO.LOOKUP_CODE = OCINV.HM_DIVISAO AND DIVISAO.LANGUAGE_CODE = 'pt' AND DIVISAO.LOOKUP_TYPE = 'HM_LKP_DIVISAO'
				LEFT JOIN NIKU.CMN_LOOKUPS_V HIERARQUIA_PRI ON HIERARQUIA_PRI.LOOKUP_CODE = INVI.GOAL_CODE AND HIERARQUIA_PRI.LANGUAGE_CODE = 'pt' AND HIERARQUIA_PRI.LOOKUP_TYPE = 'INVESTMENT_GOAL_TYPE'
				LEFT JOIN NIKU.CMN_LOOKUPS_V AREA_TI ON AREA_TI.LOOKUP_CODE = OCINV.HM_AREA_TI AND AREA_TI.LANGUAGE_CODE = 'pt' AND AREA_TI.LOOKUP_TYPE = 'AREAS_TI'
				LEFT JOIN NIKU.CMN_LOOKUPS_V CLASSIFICACAO ON CLASSIFICACAO.LOOKUP_CODE = OCPRJ.OBJ_REQUEST_TYPE AND CLASSIFICACAO.LANGUAGE_CODE = 'pt' AND CLASSIFICACAO.LOOKUP_TYPE = 'OBJ_IDEA_PROJECT_TYPE'
				LEFT JOIN NIKU.CMN_LOOKUPS_V CUSTO_DEMANDA ON CUSTO_DEMANDA.LOOKUP_CODE = OCPRJ.CUSTO_DEMANDA AND CUSTO_DEMANDA.LANGUAGE_CODE = 'pt' AND CUSTO_DEMANDA.LOOKUP_TYPE = 'CUSTO_DEMANDA'
				LEFT JOIN NIKU.CMN_LOOKUPS_V STATUS ON STATUS.LOOKUP_CODE = OCINV.HM_SITUACAO AND STATUS.LANGUAGE_CODE = 'pt' AND STATUS.LOOKUP_TYPE = 'HM_SITUACAO'
				LEFT JOIN NIKU.CMN_LOOKUPS_V TIPO_CUSTO ON TIPO_CUSTO.LOOKUP_CODE = PMPRJ.COST_TYPE  AND TIPO_CUSTO.LANGUAGE_CODE = 'pt' AND TIPO_CUSTO.LOOKUP_TYPE = 'LOOKUP_FIN_COSTTYPECODE'
				LEFT JOIN NIKU.CMN_LOOKUPS_V TIPO_PROJ ON TIPO_PROJ.LOOKUP_CODE = OCPRJ.obj_request_type AND TIPO_PROJ.LANGUAGE_CODE = 'pt' AND TIPO_PROJ.LOOKUP_TYPE = 'OBJ_IDEA_PROJECT_TYPE'
				LEFT JOIN NIKU.CMN_LOOKUPS_V TIPO_COMITE ON TIPO_COMITE.LOOKUP_CODE = OCPRJ.hm_tipo_com_exec_ti AND TIPO_COMITE.LANGUAGE_CODE = 'pt' AND TIPO_COMITE.LOOKUP_TYPE = 'HM_LKP_COMITE_EXEC_tI'
				
			WHERE
				INVI.IS_ACTIVE = 1
				AND INVI.ODF_OBJECT_CODE = 'project'
				--AND INVI.ID = 5286001
				
		)DETAIL_PROJ
		
		--WHERE
			--$X{IN,"Diretoria Executiva",data_ref_status}
			--AND $X{IN,"Tipo - Comitê Executivo",tipo_com_exec}
			--AND $X{IN,"> 250K ?",data_ref_status}
			
		GROUP BY
			"ÍD do Projeto"
			, "Descrição do Projetos"
			, "Data Cancelamento/Suspensão"
			, "Data Go Live"
			, "Status"		
	) AMTS
	
)FINAL

WHERE
	"Status" IS NOT NULL
	--AND $X{IN,"Data de Referência - Status",data_ref_status}
	--AND $X{IN,"Status",data_ref_status}
	
GROUP BY
	"Status"
	
ORDER BY
	"Aprovado REP" DESC