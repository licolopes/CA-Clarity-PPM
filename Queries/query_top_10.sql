SELECT
ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) LINHA
,*
FROM
(

SELECT TOP 10
 "Descrição do Projetos"
, ISNULL("Aprov REP",0) "Aprov REP"
, ISNULL("Aprov REP Capex",0) "Aprov REP Capex"
, ISNULL("Aprov REP Opex",0) "Aprov REP Opex"
--, ISNULL("Aprov Recursos Internos",0) "Aprov Recursos Internos"
, ISNULL("Anos Ant Capex",0) "Anos Ant Capex" 
, ISNULL("Anos Ant Opex",0) "Anos Ant Opex"
--, ISNULL("Anos Ant Recursos Internos",0) "Anos Ant Recursos Internos"
, ISNULL("Ano atual Gasto Capex",0) "Ano atual Gasto Capex"
, ISNULL("Ano atual Gasto Opex",0) "Ano atual Gasto Opex"
--, ISNULL("Anos atual Recursos Internos",0) "Anos atual Recursos Internos"
, ISNULL("Ano atual Prev Capex",0) "Ano atual Prev Capex"
, ISNULL("Ano Atual Prev Opex",0) "Ano Atual Prev Opex"
--, ISNULL("Ano Atual Prev Recursos Internos",0) "Ano Atual Prev Recursos Internos"
, ISNULL("Anos Post Prev Capex",0) "Anos Post Prev Capex"
, ISNULL("Anos Post Prev Opex",0) "Anos Post Prev Opex"
--, ISNULL("Anos Post Prev Recursos Internos",0) "Anos Post Prev Recursos Internos"
, ISNULL("Realizado Capex",0) "Realizado Capex"
, ISNULL("Realizado Opex",0) "Realizado Opex"
--, ISNULL("Realizado Recursos Internos",0) "Realizado Recursos Internos"
, ISNULL(("Realizado Capex" + "Realizado Opex"),0) "Realizado Total"

FROM
(
	SELECT
		
		INVI.NAME "Descrição do Projetos"
		, FFIN.PLANNED_CST_TOTAL "Aprov REP"
		, FFIN.PLANNED_CST_CAPITAL_TOTAL "Aprov REP Capex"
		, FFIN.PLANNED_CST_OPERATING_TOTAL "Aprov REP Opex"
		, 	(
				SELECT
					SUM(ISNULL(ROUND((DATEDIFF(DAY,FP_COST.START_DATE,FP_COST.FINISH_DATE)*FP_COST.SLICE),0),0))
				FROM
					NIKU.FIN_PLANS FIN_PLAN
					LEFT JOIN NIKU.FIN_COST_PLAN_DETAILS FPD on FIN_PLAN.ID = FPD.PLAN_ID
					LEFT JOIN NIKU.ODF_CA_COSTPLAN OCA_COST on FIN_PLAN.ID = OCA_COST.ID
					LEFT JOIN NIKU.ODF_SSL_CST_DTL_COST FP_COST ON FPD.ID = FP_COST.PRJ_OBJECT_ID
					LEFT JOIN NIKU.CMN_LOOKUPS_V LOV1 ON LOV1.ID = FPD.LOV1_ID  AND LOV1.LANGUAGE_CODE = 'pt' AND LOV1.LOOKUP_TYPE = 'PRTIMEENTRY_USER_LOV1'
					LEFT JOIN NIKU.PAC_FOS_RESOURCE_CLASS RES_CLASS ON RES_CLASS.ID = FPD.RESOURCE_CLASS_ID
				WHERE
					FIN_PLAN.OBJECT_ID = INVI.ID
					AND FIN_PLAN.IS_PLAN_OF_RECORD = 1
					AND hm_tipo_plano_custo = 'planejado'
					AND RES_CLASS.RESOURCE_CLASS = 'RECINT'				
			) "Aprov Recursos Internos"
		, 	(
				SELECT
					SUM(ISNULL(ROUND((DATEDIFF(DAY,FP_COST.START_DATE,FP_COST.FINISH_DATE)*FP_COST.SLICE),0),0))
				FROM
					NIKU.FIN_PLANS FIN_PLAN
					LEFT JOIN NIKU.FIN_COST_PLAN_DETAILS FPD on FIN_PLAN.ID = FPD.PLAN_ID
					LEFT JOIN NIKU.ODF_CA_COSTPLAN OCA_COST on FIN_PLAN.ID = OCA_COST.ID
					LEFT JOIN NIKU.ODF_SSL_CST_DTL_COST FP_COST ON FPD.ID = FP_COST.PRJ_OBJECT_ID
					LEFT JOIN NIKU.CMN_LOOKUPS_V COST_TYPE ON COST_TYPE.ID = FPD.COST_TYPE_ID  AND COST_TYPE.LANGUAGE_CODE = 'pt' AND COST_TYPE.LOOKUP_TYPE = 'LOOKUP_FIN_COSTTYPECODE'
				WHERE
					FIN_PLAN.OBJECT_ID = INVI.ID
					AND FIN_PLAN.IS_PLAN_OF_RECORD = 1
					AND hm_tipo_plano_custo = 'planejado'
					AND COST_TYPE.NAME = 'CAPEX'
					AND DATEPART(YEAR,FP_COST.START_DATE) = DATEPART(YEAR,GETDATE()) - 1			
			) "Anos Ant Capex"
		, 	(
				SELECT
					SUM(ISNULL(ROUND((DATEDIFF(DAY,FP_COST.START_DATE,FP_COST.FINISH_DATE)*FP_COST.SLICE),0),0))
				FROM
					NIKU.FIN_PLANS FIN_PLAN
					LEFT JOIN NIKU.FIN_COST_PLAN_DETAILS FPD on FIN_PLAN.ID = FPD.PLAN_ID
					LEFT JOIN NIKU.ODF_CA_COSTPLAN OCA_COST on FIN_PLAN.ID = OCA_COST.ID
					LEFT JOIN NIKU.ODF_SSL_CST_DTL_COST FP_COST ON FPD.ID = FP_COST.PRJ_OBJECT_ID
					LEFT JOIN NIKU.CMN_LOOKUPS_V COST_TYPE ON COST_TYPE.ID = FPD.COST_TYPE_ID  AND COST_TYPE.LANGUAGE_CODE = 'pt' AND COST_TYPE.LOOKUP_TYPE = 'LOOKUP_FIN_COSTTYPECODE'
				WHERE
					FIN_PLAN.OBJECT_ID = INVI.ID
					AND FIN_PLAN.IS_PLAN_OF_RECORD = 1
					AND hm_tipo_plano_custo = 'planejado'
					AND COST_TYPE.NAME = 'OPEX'
					AND DATEPART(YEAR,FP_COST.START_DATE) = DATEPART(YEAR,GETDATE()) - 1			
			) "Anos Ant Opex"
		, 	(
				SELECT
					SUM(ISNULL(ROUND((DATEDIFF(DAY,FP_COST.START_DATE,FP_COST.FINISH_DATE)*FP_COST.SLICE),0),0))
				FROM
					NIKU.FIN_PLANS FIN_PLAN
					LEFT JOIN NIKU.FIN_COST_PLAN_DETAILS FPD on FIN_PLAN.ID = FPD.PLAN_ID
					LEFT JOIN NIKU.ODF_CA_COSTPLAN OCA_COST on FIN_PLAN.ID = OCA_COST.ID
					LEFT JOIN NIKU.ODF_SSL_CST_DTL_COST FP_COST ON FPD.ID = FP_COST.PRJ_OBJECT_ID
					LEFT JOIN NIKU.CMN_LOOKUPS_V LOV1 ON LOV1.ID = FPD.LOV1_ID  AND LOV1.LANGUAGE_CODE = 'pt' AND LOV1.LOOKUP_TYPE = 'PRTIMEENTRY_USER_LOV1'
					LEFT JOIN NIKU.PAC_FOS_RESOURCE_CLASS RES_CLASS ON RES_CLASS.ID = FPD.RESOURCE_CLASS_ID
				WHERE
					FIN_PLAN.OBJECT_ID = INVI.ID
					AND FIN_PLAN.IS_PLAN_OF_RECORD = 1
					AND hm_tipo_plano_custo = 'planejado'
					AND RES_CLASS.RESOURCE_CLASS = 'RECINT'
					AND DATEPART(YEAR,FP_COST.START_DATE) = DATEPART(YEAR,GETDATE()) - 1		
			) "Anos Ant Recursos Internos"
		,	(
				SELECT 
					ISNULL(SUM(PV.TOTALCOST),0)
				FROM 
					NIKU.PPA_WIP PW 
					LEFT JOIN NIKU.PPA_WIP_VALUES PV ON PW.TRANSNO = PV.TRANSNO AND PV.CURRENCY_TYPE = 'HOME'
				WHERE
					PW.INVESTMENT_ID = INVI.ID
					AND PW.COST_TYPE = 'CAPITAL'
					AND DATEPART(YEAR,PW.ENTRYDATE) = DATEPART(YEAR,GETDATE())
			) "Ano atual Gasto Capex"
		,	(
				SELECT 
					ISNULL(SUM(PV.TOTALCOST),0)
				FROM 
					NIKU.PPA_WIP PW 
					LEFT JOIN NIKU.PPA_WIP_VALUES PV ON PW.TRANSNO = PV.TRANSNO AND PV.CURRENCY_TYPE = 'HOME'
				WHERE
					PW.INVESTMENT_ID = INVI.ID
					AND PW.COST_TYPE = 'OPERATING'
					AND DATEPART(YEAR,PW.ENTRYDATE) = DATEPART(YEAR,GETDATE())
			) "Ano atual Gasto Opex"
		,	(
				SELECT	
					ISNULL(SUM(PV.TOTALCOST),0)
				FROM 
					NIKU.PPA_WIP PW 
					LEFT JOIN NIKU.PPA_WIP_VALUES PV ON PW.TRANSNO = PV.TRANSNO AND PV.CURRENCY_TYPE = 'HOME'
				WHERE
					PW.INVESTMENT_ID = INVI.ID
					AND PW.RESOURCE_CLASS = 'RECINT'
					AND DATEPART(YEAR,PW.ENTRYDATE) = DATEPART(YEAR,GETDATE())		
			) "Anos atual Recursos Internos"
		, 	(
				SELECT
					SUM(ISNULL(ROUND((DATEDIFF(DAY,FP_COST.START_DATE,FP_COST.FINISH_DATE)*FP_COST.SLICE),0),0))
				FROM
					NIKU.FIN_PLANS FIN_PLAN
					LEFT JOIN NIKU.FIN_COST_PLAN_DETAILS FPD on FIN_PLAN.ID = FPD.PLAN_ID
					LEFT JOIN NIKU.ODF_CA_COSTPLAN OCA_COST on FIN_PLAN.ID = OCA_COST.ID
					LEFT JOIN NIKU.ODF_SSL_CST_DTL_COST FP_COST ON FPD.ID = FP_COST.PRJ_OBJECT_ID
					LEFT JOIN NIKU.CMN_LOOKUPS_V COST_TYPE ON COST_TYPE.ID = FPD.COST_TYPE_ID  AND COST_TYPE.LANGUAGE_CODE = 'pt' AND COST_TYPE.LOOKUP_TYPE = 'LOOKUP_FIN_COSTTYPECODE'
				WHERE
					FIN_PLAN.OBJECT_ID = INVI.ID
					AND FIN_PLAN.IS_PLAN_OF_RECORD = 1
					AND hm_tipo_plano_custo = 'planejado'
					AND COST_TYPE.NAME = 'CAPEX'
					AND DATEPART(YEAR,FP_COST.START_DATE) = DATEPART(YEAR,GETDATE())		
			) "Ano atual Prev Capex"
		, 	(
				SELECT
					SUM(ISNULL(ROUND((DATEDIFF(DAY,FP_COST.START_DATE,FP_COST.FINISH_DATE)*FP_COST.SLICE),0),0))
				FROM
					NIKU.FIN_PLANS FIN_PLAN
					LEFT JOIN NIKU.FIN_COST_PLAN_DETAILS FPD on FIN_PLAN.ID = FPD.PLAN_ID
					LEFT JOIN NIKU.ODF_CA_COSTPLAN OCA_COST on FIN_PLAN.ID = OCA_COST.ID
					LEFT JOIN NIKU.ODF_SSL_CST_DTL_COST FP_COST ON FPD.ID = FP_COST.PRJ_OBJECT_ID
					LEFT JOIN NIKU.CMN_LOOKUPS_V COST_TYPE ON COST_TYPE.ID = FPD.COST_TYPE_ID  AND COST_TYPE.LANGUAGE_CODE = 'pt' AND COST_TYPE.LOOKUP_TYPE = 'LOOKUP_FIN_COSTTYPECODE'
				WHERE
					FIN_PLAN.OBJECT_ID = INVI.ID
					AND FIN_PLAN.IS_PLAN_OF_RECORD = 1
					AND hm_tipo_plano_custo = 'planejado'
					AND COST_TYPE.NAME = 'OPEX'
					AND DATEPART(YEAR,FP_COST.START_DATE) = DATEPART(YEAR,GETDATE())		
			) "Ano Atual Prev Opex"
		, 	(
				SELECT
					SUM(ISNULL(ROUND((DATEDIFF(DAY,FP_COST.START_DATE,FP_COST.FINISH_DATE)*FP_COST.SLICE),0),0))
				FROM
					NIKU.FIN_PLANS FIN_PLAN
					LEFT JOIN NIKU.FIN_COST_PLAN_DETAILS FPD on FIN_PLAN.ID = FPD.PLAN_ID
					LEFT JOIN NIKU.ODF_CA_COSTPLAN OCA_COST on FIN_PLAN.ID = OCA_COST.ID
					LEFT JOIN NIKU.ODF_SSL_CST_DTL_COST FP_COST ON FPD.ID = FP_COST.PRJ_OBJECT_ID
					LEFT JOIN NIKU.CMN_LOOKUPS_V LOV1 ON LOV1.ID = FPD.LOV1_ID  AND LOV1.LANGUAGE_CODE = 'pt' AND LOV1.LOOKUP_TYPE = 'PRTIMEENTRY_USER_LOV1'
					LEFT JOIN NIKU.PAC_FOS_RESOURCE_CLASS RES_CLASS ON RES_CLASS.ID = FPD.RESOURCE_CLASS_ID
				WHERE
					FIN_PLAN.OBJECT_ID = INVI.ID
					AND FIN_PLAN.IS_PLAN_OF_RECORD = 1
					AND hm_tipo_plano_custo = 'planejado'
					AND RES_CLASS.RESOURCE_CLASS = 'RECINT'
					AND DATEPART(YEAR,FP_COST.START_DATE) = DATEPART(YEAR,GETDATE())	
			) "Ano Atual Prev Recursos Internos"
		, 	(
				SELECT
					SUM(ISNULL(ROUND((DATEDIFF(DAY,FP_COST.START_DATE,FP_COST.FINISH_DATE)*FP_COST.SLICE),0),0))
				FROM
					NIKU.FIN_PLANS FIN_PLAN
					LEFT JOIN NIKU.FIN_COST_PLAN_DETAILS FPD on FIN_PLAN.ID = FPD.PLAN_ID
					LEFT JOIN NIKU.ODF_CA_COSTPLAN OCA_COST on FIN_PLAN.ID = OCA_COST.ID
					LEFT JOIN NIKU.ODF_SSL_CST_DTL_COST FP_COST ON FPD.ID = FP_COST.PRJ_OBJECT_ID
					LEFT JOIN NIKU.CMN_LOOKUPS_V COST_TYPE ON COST_TYPE.ID = FPD.COST_TYPE_ID  AND COST_TYPE.LANGUAGE_CODE = 'pt' AND COST_TYPE.LOOKUP_TYPE = 'LOOKUP_FIN_COSTTYPECODE'
				WHERE
					FIN_PLAN.OBJECT_ID = INVI.ID
					AND FIN_PLAN.IS_PLAN_OF_RECORD = 1
					AND hm_tipo_plano_custo = 'planejado'
					AND COST_TYPE.NAME = 'CAPEX'
					AND DATEPART(YEAR,FP_COST.START_DATE) = DATEPART(YEAR,GETDATE()) + 1	
			) "Anos Post Prev Capex"
		, 	(
				SELECT
					SUM(ISNULL(ROUND((DATEDIFF(DAY,FP_COST.START_DATE,FP_COST.FINISH_DATE)*FP_COST.SLICE),0),0))
				FROM
					NIKU.FIN_PLANS FIN_PLAN
					LEFT JOIN NIKU.FIN_COST_PLAN_DETAILS FPD on FIN_PLAN.ID = FPD.PLAN_ID
					LEFT JOIN NIKU.ODF_CA_COSTPLAN OCA_COST on FIN_PLAN.ID = OCA_COST.ID
					LEFT JOIN NIKU.ODF_SSL_CST_DTL_COST FP_COST ON FPD.ID = FP_COST.PRJ_OBJECT_ID
					LEFT JOIN NIKU.CMN_LOOKUPS_V COST_TYPE ON COST_TYPE.ID = FPD.COST_TYPE_ID  AND COST_TYPE.LANGUAGE_CODE = 'pt' AND COST_TYPE.LOOKUP_TYPE = 'LOOKUP_FIN_COSTTYPECODE'
				WHERE
					FIN_PLAN.OBJECT_ID = INVI.ID
					AND FIN_PLAN.IS_PLAN_OF_RECORD = 1
					AND hm_tipo_plano_custo = 'planejado'
					AND COST_TYPE.NAME = 'OPEX'
					AND DATEPART(YEAR,FP_COST.START_DATE) = DATEPART(YEAR,GETDATE()) + 1		
			) "Anos Post Prev Opex"
		, 	(
				SELECT
					SUM(ISNULL(ROUND((DATEDIFF(DAY,FP_COST.START_DATE,FP_COST.FINISH_DATE)*FP_COST.SLICE),0),0))
				FROM
					NIKU.FIN_PLANS FIN_PLAN
					LEFT JOIN NIKU.FIN_COST_PLAN_DETAILS FPD on FIN_PLAN.ID = FPD.PLAN_ID
					LEFT JOIN NIKU.ODF_CA_COSTPLAN OCA_COST on FIN_PLAN.ID = OCA_COST.ID
					LEFT JOIN NIKU.ODF_SSL_CST_DTL_COST FP_COST ON FPD.ID = FP_COST.PRJ_OBJECT_ID
					LEFT JOIN NIKU.CMN_LOOKUPS_V LOV1 ON LOV1.ID = FPD.LOV1_ID  AND LOV1.LANGUAGE_CODE = 'pt' AND LOV1.LOOKUP_TYPE = 'PRTIMEENTRY_USER_LOV1'
					LEFT JOIN NIKU.PAC_FOS_RESOURCE_CLASS RES_CLASS ON RES_CLASS.ID = FPD.RESOURCE_CLASS_ID
				WHERE
					FIN_PLAN.OBJECT_ID = INVI.ID
					AND FIN_PLAN.IS_PLAN_OF_RECORD = 1
					AND hm_tipo_plano_custo = 'planejado'
					AND RES_CLASS.RESOURCE_CLASS = 'RECINT'
					AND DATEPART(YEAR,FP_COST.START_DATE) = DATEPART(YEAR,GETDATE()) + 1
			) "Anos Post Prev Recursos Internos"
		,	(
				SELECT 
					ISNULL(SUM(PV.TOTALCOST),0)
				FROM 
					NIKU.PPA_WIP PW 
					LEFT JOIN NIKU.PPA_WIP_VALUES PV ON PW.TRANSNO = PV.TRANSNO AND PV.CURRENCY_TYPE = 'HOME'
				WHERE
					PW.INVESTMENT_ID = INVI.ID
					AND PW.COST_TYPE = 'CAPITAL'
			) "Realizado Capex"
		,	(
				SELECT 
					ISNULL(SUM(PV.TOTALCOST),0)
				FROM 
					NIKU.PPA_WIP PW 
					LEFT JOIN NIKU.PPA_WIP_VALUES PV ON PW.TRANSNO = PV.TRANSNO AND PV.CURRENCY_TYPE = 'HOME'
				WHERE
					PW.INVESTMENT_ID = INVI.ID
					AND PW.COST_TYPE = 'OPERATING'
			) "Realizado Opex"
		,	(
				SELECT	
					ISNULL(SUM(PV.TOTALCOST),0)
				FROM 
					NIKU.PPA_WIP PW 
					LEFT JOIN NIKU.PPA_WIP_VALUES PV ON PW.TRANSNO = PV.TRANSNO AND PV.CURRENCY_TYPE = 'HOME'
				WHERE
					PW.INVESTMENT_ID = INVI.ID
					AND PW.RESOURCE_CLASS = 'RECINT'
			) "Realizado Recursos Internos"

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
		LEFT JOIN NIKU.CMN_LOOKUPS_V STATUS ON STATUS.LOOKUP_CODE = OCINV.HM_SITUACAO_AGRUP AND STATUS.LANGUAGE_CODE = 'pt' AND STATUS.LOOKUP_TYPE = 'HM_LKP_SITUACAO_AGRUP'
		LEFT JOIN NIKU.CMN_LOOKUPS_V TIPO_CUSTO ON TIPO_CUSTO.LOOKUP_CODE = PMPRJ.COST_TYPE  AND TIPO_CUSTO.LANGUAGE_CODE = 'pt' AND TIPO_CUSTO.LOOKUP_TYPE = 'LOOKUP_FIN_COSTTYPECODE'
	WHERE
		INVI.IS_ACTIVE = 1
		AND INVI.ODF_OBJECT_CODE = 'project'
)TOP10

ORDER BY
	"Aprov REP" DESC
) ORDEM