SELECT DISTINCT
	ROBJ.OBJECT_TYPE_CODE COD_OBJETO
	, CASE ROBJ.OBJECT_TYPE_CODE WHEN 'change' THEN INV_CHANGE.ID WHEN 'cop_prj_statusrpt' THEN INV_SRPT.ID ELSE INV.ID END ID_INVESTIMENTO
	, CASE ROBJ.OBJECT_TYPE_CODE WHEN 'change' THEN INV_CHANGE.CODE WHEN 'cop_prj_statusrpt' THEN INV_SRPT.CODE ELSE INV.CODE END COD_INVESTIMENTO
	, CASE ROBJ.OBJECT_TYPE_CODE WHEN 'change' THEN INV_CHANGE.NAME WHEN 'cop_prj_statusrpt' THEN INV_SRPT.NAME ELSE INV.NAME END NOME_INVESTIMENTO
	, DPRO.NAME PROCESSO
	, CAI.ID ID_IA
	, CAI.SUBJECT DESC_IA
	, RASS.ID ID_ASSIGNEE, RES.UNIQUE_NAME RESP_ID
	, RES.FIRST_NAME + ' ' + RES.LAST_NAME RESP_NOME
	, USR.USER_NAME COD_USER, LKP.NAME
	, CONVERT(VARCHAR(19),CAI.DUE_DATE,126) VENCIMENTO
	, CAI.OWNER_ID 
FROM 
	niku.CAL_ACTION_ITEMS CAI
	JOIN niku.BPM_RUN_STEP_ACTION_RESULTS SAR ON SAR.AI_ID = CAI.ID
	JOIN niku.BPM_RUN_ASSIGNEES RASS ON RASS.PK_ID = SAR.ID
	JOIN niku.SRM_RESOURCES RES ON RES.USER_ID = RASS.USER_ID
	JOIN niku.CMN_SEC_USERS USR ON RES.USER_ID = USR.ID
	JOIN niku.BPM_RUN_STEPS RSTP on SAR.STEP_INSTANCE_ID = RSTP.ID
	JOIN niku.BPM_DEF_STEP_ACTIONS DACT ON DACT.ID = SAR.STEP_ACTION_ID
	JOIN niku.BPM_DEF_STEP_AI_ACTIONS DACTA ON DACT.ID = DACTA.STEP_ACTION_ID
	JOIN niku.CMN_LOOKUPS_V LKP ON DACTA.STATUS_TYPE_CODE = LKP.LOOKUP_TYPE AND LKP.LOOKUP_CODE = DACTA.STATUS_CODE AND LKP.LANGUAGE_CODE = 'pt'
	JOIN niku.BPM_RUN_PROCESSES RPRO ON RSTP.PROCESS_INSTANCE_ID = RPRO.ID
	JOIN niku.BPM_DEF_PROCESS_VERSIONS DPROV ON DPROV.ID = RPRO.PROCESS_VERSION_ID
	LEFT JOIN niku.CMN_CAPTIONS_NLS DPRO ON DPRO.LANGUAGE_CODE = 'pt' AND DPRO.TABLE_NAME = 'BPM_DEF_PROCESSES' AND DPRO.PK_ID = DPROV.PROCESS_ID
	JOIN niku.BPM_RUN_OBJECTS ROBJ ON ROBJ.PK_ID = RPRO.ID AND ROBJ.TABLE_NAME = 'BPM_RUN_PROCESSES' AND ROBJ.TYPE_CODE = 'BPM_POT_PRIMARY'
	LEFT JOIN niku.INV_INVESTMENTS INV ON ROBJ.OBJECT_ID = INV.ID AND ROBJ.OBJECT_TYPE_CODE = INV.ODF_OBJECT_CODE
	LEFT JOIN niku.RIM_RISKS_AND_ISSUES RRAI ON ROBJ.OBJECT_ID = RRAI.ID AND ROBJ.OBJECT_TYPE_CODE = 'change'
	LEFT JOIN niku.INV_INVESTMENTS INV_CHANGE ON RRAI.PK_ID = INV_CHANGE.ID
	LEFT JOIN niku.ODF_CA_COP_PRJ_STATUSRPT SRPT ON SRPT.id = ROBJ.OBJECT_ID AND ROBJ.OBJECT_TYPE_CODE = 'cop_prj_statusrpt'
	LEFT JOIN niku.INV_INVESTMENTS INV_SRPT ON SRPT.ODF_PARENT_ID = INV_SRPT.ID
WHERE
	RASS.AI_STATUS_CODE = 'CAL_OPEN'
	AND RSTP.STATUS_CODE = 'BPM_SIS_READY_TO_EVAL_POSTCON'
	AND RPRO.STATUS_CODE = 'BPM_PIS_RUNNING'