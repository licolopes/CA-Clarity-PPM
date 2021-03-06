SELECT DISTINCT
	   INV.ID INV_ID 
	 , INV.CODE INV_CODE
	 , INV.NAME INV_NAME
	 , CATEG_PROD.NAME CATEGORIA
	 , PORTARIA.NAME PORTARIA
	 , TIPO_PROJ.NAME TIPO_PROJ
	 , UNID_NEG.NAME UNID_NEG
	 , STATUS.NAME STATUS
	 , ETAPA.NAME ETAPA    
	 , PTSK.PRNAME TAREFA
	 , PTSK.PREXTERNALID ID_TAREFA
	 , CONVERT(VARCHAR(10),PTSK.PRSTART ,120) INICIO_TAREFA
	 , CONVERT(VARCHAR(10),PTSK.PRFINISH ,120) TERMINO_TAREFA
	 , CONVERT(VARCHAR(10),BASELINE.START_DATE ,120) INICIO_BASELINE
	 , CONVERT(VARCHAR(10),BASELINE.FINISH_DATE ,120) TERMINO_BASELINE
	 , PTSK.PRPCTCOMPLETE PORC_CONCLUIDO
	 , STATUS_TAREFA.NAME STATUS_TAREFA
 
FROM 
	NIKU.INV_INVESTMENTS INV
	JOIN NIKU.ODF_CA_INV OINV ON OINV.id = INV.ID
	JOIN NIKU.ODF_CA_PROJECT ODFPROJ ON ODFPROJ.id = INV.ID       
	JOIN NIKU.INV_PROJECTS IPRJ ON INV.ID = IPRJ.PRID   
	JOIN NIKU.ODF_MULTI_VALUED_LOOKUPS MUL ON INV.ID = MUL.PK_ID AND MUL.OBJECT = 'project' AND MUL.ATTRIBUTE = 'hm_unid_ne'
	JOIN NIKU.CMN_LOOKUPS_V UNID_NEG ON UNID_NEG.LOOKUP_CODE = MUL.VALUE AND UNID_NEG.LOOKUP_TYPE = 'HM_LKP_UNID_NEG'AND UNID_NEG.LANGUAGE_CODE = 'pt'
	JOIN NIKU.CMN_LOOKUPS_V CATEG_PROD ON CATEG_PROD.LOOKUP_CODE = OINV.hm_categ_prod AND CATEG_PROD.LOOKUP_TYPE = 'HM_CATEG_PROD' AND CATEG_PROD.LANGUAGE_CODE = 'pt'
	LEFT JOIN NIKU.CMN_LOOKUPS_V ETAPA ON ETAPA.LOOKUP_CODE = OINV.hm_etap_proj AND ETAPA.LOOKUP_TYPE = 'HM_LKP_ETAP_PROJ' AND ETAPA.LANGUAGE_CODE = 'pt'
	JOIN NIKU.CMN_LOOKUPS_V STATUS ON STATUS.LOOKUP_CODE = OINV.hm_status_proj AND STATUS.LOOKUP_TYPE = 'HM_STATUS' AND STATUS.LANGUAGE_CODE = 'pt'
	JOIN NIKU.CMN_LOOKUPS_V TIPO_PROJ ON TIPO_PROJ.LOOKUP_CODE = OINV.hm_tipo_projeto AND TIPO_PROJ.LOOKUP_TYPE = 'HM_LKP_TIPO_PROJ' AND TIPO_PROJ.LANGUAGE_CODE = 'pt'
	LEFT JOIN NIKU.CMN_LOOKUPS_V PORTARIA ON PORTARIA.ID = OINV.portaria_344 AND PORTARIA.LOOKUP_TYPE = 'PAC_RPT_YESNO' AND PORTARIA.LANGUAGE_CODE = 'pt'
	LEFT JOIN NIKU.PRTASK PTSK ON PTSK.PRPROJECTID = INV.ID
	JOIN niku.PRJ_BASELINE_DETAILS BASELINE ON BASELINE.OBJECT_ID = PTSK.PRID
	LEFT JOIN NIKU.CMN_LOOKUPS_V STATUS_TAREFA ON STATUS_TAREFA.LOOKUP_ENUM = PTSK.PRSTATUS AND STATUS_TAREFA.LOOKUP_TYPE = 'prTaskStatus' AND STATUS_TAREFA.LANGUAGE_CODE = 'pt'
	
WHERE 
	INV.IS_ACTIVE = 1  
	AND ODFPROJ.PARTITION_CODE = 'hm_inovaprod'
	AND PTSK.PRISKEY = 0
	AND PTSK.PRISTASK = 1
	AND BASELINE.IS_CURRENT = 1 

ORDER BY
	  INV.CODE ASC
	, PTSK.PREXTERNALID ASC
	