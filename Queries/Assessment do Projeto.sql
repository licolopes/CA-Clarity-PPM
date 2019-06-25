SELECT
	INV.ID  PROJ_ID
	, INV.CODE PROJ_CODE
	, INV.NAME PROJ_NAME
	, OPRJ.VALE_DITV_SIGLA TITULO_PROJ
	, TO_CHAR(INV.SCHEDULE_START, 'dd/mm/yyyy') DT_INICIO
	, TO_CHAR(INV.SCHEDULE_FINISH,'dd/mm/yyyy') DT_TERMINO
	, ETAPA_VAL.NAME ETAPA_VAL
	, OPRJ.VALE_OBJ_PRINCIPAL OBJ_PRINCIPAL
	, REL_PESQ.VALE_COMENT_3 RESULT_ESPER
	, REL_PESQ.VALE_PROX_ETAPAS PROX_ETAPAS
	, TRL.NAME TRL
  
FROM
	INV_INVESTMENTS INV
	LEFT JOIN ODF_CA_PROJECT OPRJ ON OPRJ.ID = INV.ID
	LEFT JOIN odf_ca_vale_rela_de_pesq REL_PESQ ON REL_PESQ.ODF_PARENT_ID = INV.ID
	LEFT JOIN CMN_LOOKUPS_V TRL ON TRL.LOOKUP_CODE = OPRJ.VALE_TRL
			AND TRL.LOOKUP_TYPE = 'VALE_TRL' 
			AND TRL.LANGUAGE_CODE = 'pt'
	LEFT JOIN CMN_LOOKUPS_V ETAPA_VAL ON ETAPA_VAL.LOOKUP_CODE = OPRJ.DITV_VALORACAO_ETAPA
			AND ETAPA_VAL.LOOKUP_TYPE = 'DITV_VALORACAO_ETAPA' 
			AND ETAPA_VAL.LANGUAGE_CODE = 'pt'

WHERE 
  INV.ID = 5058068