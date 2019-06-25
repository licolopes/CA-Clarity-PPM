SELECT
RES_USERID,
RES_UNIQUE_NAME,
RES_NAME,
INV_TYPE,
INV_ID,
INV_CODE,
INV_NAME,
OWNER,
PC,
ALC_MES_1,
ALC_MES_2,
ALC_MES_3,
ALC_MES_4,
ALC_MES_5,
ALC_MES_6,
ALC_MES_7,
ALC_MES_8,
ALC_MES_9,
ALC_MES_10,
ALC_MES_11,
ALC_MES_12,
ALC_MES_13,
ALC_TOTAL,
TSK_MES_1,
TSK_MES_2,
TSK_MES_3,
TSK_MES_4,
TSK_MES_5,
TSK_MES_6,
TSK_MES_7,
TSK_MES_8,
TSK_MES_9,
TSK_MES_10,
TSK_MES_11,
TSK_MES_12,
TSK_MES_13
FROM
(

	SELECT
	ALOCACAO.RES_USERID,
	ALOCACAO.RES_UNIQUE_NAME,
	ALOCACAO.RES_NAME,
	ALOCACAO.INV_TYPE,
	ALOCACAO.INV_ID,
	ALOCACAO.INV_CODE,
	ALOCACAO.INV_NAME,
	CASE 
		WHEN OWNER.NAME LIKE 'S - CS' THEN 'CS' 
		WHEN OWNER.NAME LIKE 'S - PARTS' THEN 'SP' 
		WHEN OWNER.NAME LIKE 'EDB - HDA' THEN 'EDB - HDA' 
		WHEN OWNER.NAME LIKE 'HAB - BR - E' THEN 'HAB - E' 
		WHEN OWNER.NAME LIKE 'HAB - BR - DB' THEN 'HAB - DB'		
		WHEN SUBSTR(OWNER.NAME,0,INSTR(OWNER.NAME,' ')-1) = 'TI' THEN 'IT' 
		ELSE SUBSTR(OWNER.NAME,0,INSTR(OWNER.NAME,' ')-1) 
		END OWNER,
	ALOCACAO.ALC_MES_1,
	ALOCACAO.ALC_MES_2,
	ALOCACAO.ALC_MES_3,
	ALOCACAO.ALC_MES_4,
	ALOCACAO.ALC_MES_5,
	ALOCACAO.ALC_MES_6,
	ALOCACAO.ALC_MES_7,
	ALOCACAO.ALC_MES_8,
	ALOCACAO.ALC_MES_9,
	ALOCACAO.ALC_MES_10,
	ALOCACAO.ALC_MES_11,
	ALOCACAO.ALC_MES_12,
	ALOCACAO.ALC_MES_13,
	ALOCACAO.ALC_TOTAL,
	PRJ.PC,
	PRJ.TSK_MES_1,
	PRJ.TSK_MES_2,
	PRJ.TSK_MES_3,
	PRJ.TSK_MES_4,
	PRJ.TSK_MES_5,
	PRJ.TSK_MES_6,
	PRJ.TSK_MES_7,
	PRJ.TSK_MES_8,
	PRJ.TSK_MES_9,
	PRJ.TSK_MES_10,
	PRJ.TSK_MES_11,
	PRJ.TSK_MES_12,
	PRJ.TSK_MES_13
	FROM
	(
		SELECT
			INV_TYPE,
			INV_ID,
			INV_CODE,
			INV_NAME,
			RES_USERID,
			RES_UNIQUE_NAME,
			RES_NAME,
			ISROLE,
			SUM(MES_1) ALC_MES_1,
			SUM(MES_2) ALC_MES_2,
			SUM(MES_3) ALC_MES_3,
			SUM(MES_4) ALC_MES_4,
			SUM(MES_5) ALC_MES_5,
			SUM(MES_6) ALC_MES_6,
			SUM(MES_7) ALC_MES_7,
			SUM(MES_8) ALC_MES_8,
			SUM(MES_9) ALC_MES_9,
			SUM(MES_10) ALC_MES_10,
			SUM(MES_11) ALC_MES_11,
			SUM(MES_12) ALC_MES_12,
			SUM(MES_13) ALC_MES_13,
			SUM(TOTAL) ALC_TOTAL
		FROM
		(
			SELECT
			INV_TYPE,
			INV_ID,
			INV_CODE,
			INV_NAME,
			RES_USERID,
			RES_UNIQUE_NAME,
			RES_NAME,
			ISROLE,
			MES_1,
			MES_2,
			MES_3,
			MES_4,
			MES_5,
			MES_6,
			MES_7,
			MES_8,
			MES_9,
			MES_10,
			MES_11,
			MES_12,
			MES_13,
			(MES_1 + MES_2 + MES_3 + MES_4 + MES_5 + MES_6 + MES_7 + MES_8 + MES_9 + MES_10 + MES_11 + MES_12 + MES_13) TOTAL
			FROM
			(
				SELECT
					INV_TYPE,
					INV_ID,
					INV_CODE,
					INV_NAME,
					RES_USERID,
					RES_UNIQUE_NAME,
					RES_NAME,
					ISROLE,
					CASE WHEN MES = TRUNC($P{data_referencia},'mm') THEN SUM(HORAS) ELSE 0 END MES_1,
					CASE WHEN MES = ADD_MONTHS(TRUNC($P{data_referencia},'mm'),1) THEN SUM(HORAS) ELSE 0 END MES_2,
					CASE WHEN MES = ADD_MONTHS(TRUNC($P{data_referencia},'mm'),2) THEN SUM(HORAS) ELSE 0 END MES_3,
					CASE WHEN MES = ADD_MONTHS(TRUNC($P{data_referencia},'mm'),3) THEN SUM(HORAS) ELSE 0 END MES_4,
					CASE WHEN MES = ADD_MONTHS(TRUNC($P{data_referencia},'mm'),4) THEN SUM(HORAS) ELSE 0 END MES_5,
					CASE WHEN MES = ADD_MONTHS(TRUNC($P{data_referencia},'mm'),5) THEN SUM(HORAS) ELSE 0 END MES_6,
					CASE WHEN MES = ADD_MONTHS(TRUNC($P{data_referencia},'mm'),6) THEN SUM(HORAS) ELSE 0 END MES_7,
					CASE WHEN MES = ADD_MONTHS(TRUNC($P{data_referencia},'mm'),7) THEN SUM(HORAS) ELSE 0 END MES_8,
					CASE WHEN MES = ADD_MONTHS(TRUNC($P{data_referencia},'mm'),8) THEN SUM(HORAS) ELSE 0 END MES_9,
					CASE WHEN MES = ADD_MONTHS(TRUNC($P{data_referencia},'mm'),9) THEN SUM(HORAS) ELSE 0 END MES_10,
					CASE WHEN MES = ADD_MONTHS(TRUNC($P{data_referencia},'mm'),10) THEN SUM(HORAS) ELSE 0 END MES_11,
					CASE WHEN MES = ADD_MONTHS(TRUNC($P{data_referencia},'mm'),11) THEN SUM(HORAS) ELSE 0 END MES_12,
					CASE WHEN MES = ADD_MONTHS(TRUNC($P{data_referencia},'mm'),12) THEN SUM(HORAS) ELSE 0 END MES_13
				FROM
				(
					SELECT DISTINCT
						INV.ODF_OBJECT_CODE INV_TYPE,
						INV.ID INV_ID,
						INV.CODE INV_CODE,
						INV.NAME INV_NAME,
						R.USER_ID RES_USERID,
						R.UNIQUE_NAME RES_UNIQUE_NAME,
						R.FIRST_NAME || ' ' || R.LAST_NAME RES_NAME,
						PRES.PRISROLE ISROLE,
						TRUNC(S.SLICE_DATE, 'mm') MES,
						NVL(S.SLICE,0) HORAS
					FROM   
						PRTEAM TM          	
						INNER JOIN SRM_RESOURCES R ON  TM.PRRESOURCEID = R.ID
						INNER JOIN PRJ_RESOURCES PRES ON PRES.PRID = R.ID
						INNER JOIN INV_INVESTMENTS INV ON INV.ID = TM.PRPROJECTID  
						INNER JOIN INV_PROJECTS INVP ON INVP.PRID = INV.ID
						INNER JOIN PRJ_BLB_SLICES S ON TM.PRID = S.PRJ_OBJECT_ID
						INNER JOIN PRJ_BLB_SLICEREQUESTS SR ON S.SLICE_REQUEST_ID = SR.ID AND SR.REQUEST_NAME IN ('MONTHLYRESOURCEALLOCCURVE')
						INNER JOIN NBI_DIM_CALENDAR_TIME CAL ON S.SLICE_DATE = CAL.DAY
						INNER JOIN NBI_DIM_CALENDAR_TIME LD ON LD.MONTH_KEY = CAL.MONTH_KEY AND LD.HIERARCHY_LEVEL = 'MONTH'
						INNER JOIN PRJ_OBS_ASSOCIATIONS OBSA ON OBSA.RECORD_ID = INV.ID
						INNER JOIN PRJ_OBS_UNITS_FLAT OBSF ON OBSA.UNIT_ID = OBSF.UNIT_ID
						INNER JOIN PRJ_OBS_UNITS OBSU ON OBSU.ID = OBSF.BRANCH_UNIT_ID AND OBSU.TYPE_ID = 5000003
						INNER JOIN PRJ_OBS_OBJECT_TYPES OOT ON OOT.TYPE_ID = OBSU.TYPE_ID AND OOT.TABLE_NAME = 'SRM_PROJECTS'
						LEFT JOIN PFM_INVESTMENTS PFMI ON PFMI.INVESTMENT_ID = INV.ID
					WHERE
						TRUNC(S.SLICE_DATE, 'mm') >= TRUNC($P{data_referencia},'mm')
						AND $X{IN,OBSU.ID,org}
						AND PRES.PRISROLE = 1
						AND INV.IS_ACTIVE = 1
						AND INVP.IS_TEMPLATE = 0
						AND ($P{portfolio} IS NULL OR PFMI.PORTFOLIO_ID = $P{portfolio})
				)T1
				GROUP BY
					INV_TYPE,
					INV_ID,
					INV_CODE,
					INV_NAME,
					RES_USERID,
					RES_UNIQUE_NAME,
					RES_NAME,
					ISROLE,
					MES
			)T2
		)T3		
		GROUP BY		
			INV_TYPE,
			INV_ID,
			INV_CODE,
			INV_NAME,
			RES_USERID,
			RES_UNIQUE_NAME,
			RES_NAME,
			ISROLE
	)ALOCACAO
		
	LEFT JOIN

	(
		SELECT
			INV_ID,
			PC,
			LISTAGG(MES_1,'/') WITHIN GROUP (ORDER BY DATA_TAREFA) TSK_MES_1,
			LISTAGG(MES_2,'/') WITHIN GROUP (ORDER BY DATA_TAREFA) TSK_MES_2,
			LISTAGG(MES_3,'/') WITHIN GROUP (ORDER BY DATA_TAREFA) TSK_MES_3,
			LISTAGG(MES_4,'/') WITHIN GROUP (ORDER BY DATA_TAREFA) TSK_MES_4,
			LISTAGG(MES_5,'/') WITHIN GROUP (ORDER BY DATA_TAREFA) TSK_MES_5,
			LISTAGG(MES_6,'/') WITHIN GROUP (ORDER BY DATA_TAREFA) TSK_MES_6,
			LISTAGG(MES_7,'/') WITHIN GROUP (ORDER BY DATA_TAREFA) TSK_MES_7,
			LISTAGG(MES_8,'/') WITHIN GROUP (ORDER BY DATA_TAREFA) TSK_MES_8,
			LISTAGG(MES_9,'/') WITHIN GROUP (ORDER BY DATA_TAREFA) TSK_MES_9,
			LISTAGG(MES_10,'/') WITHIN GROUP (ORDER BY DATA_TAREFA) TSK_MES_10,
			LISTAGG(MES_11,'/') WITHIN GROUP (ORDER BY DATA_TAREFA) TSK_MES_11,
			LISTAGG(MES_12,'/') WITHIN GROUP (ORDER BY DATA_TAREFA) TSK_MES_12,
			LISTAGG(MES_13,'/') WITHIN GROUP (ORDER BY DATA_TAREFA) TSK_MES_13
		FROM
		(
			SELECT DISTINCT
				INV_ID,
				PC,
				CASE WHEN TRUNC(MES,'mm') = TRUNC($P{data_referencia},'mm') THEN TSK ELSE '' END MES_1,
				CASE WHEN TRUNC(MES,'mm') = ADD_MONTHS(TRUNC($P{data_referencia},'mm'),1) THEN TSK ELSE '' END MES_2,
				CASE WHEN TRUNC(MES,'mm') = ADD_MONTHS(TRUNC($P{data_referencia},'mm'),2) THEN TSK ELSE '' END MES_3,
				CASE WHEN TRUNC(MES,'mm') = ADD_MONTHS(TRUNC($P{data_referencia},'mm'),3) THEN TSK ELSE '' END MES_4,
				CASE WHEN TRUNC(MES,'mm') = ADD_MONTHS(TRUNC($P{data_referencia},'mm'),4) THEN TSK ELSE '' END MES_5,
				CASE WHEN TRUNC(MES,'mm') = ADD_MONTHS(TRUNC($P{data_referencia},'mm'),5) THEN TSK ELSE '' END MES_6,
				CASE WHEN TRUNC(MES,'mm') = ADD_MONTHS(TRUNC($P{data_referencia},'mm'),6) THEN TSK ELSE '' END MES_7,
				CASE WHEN TRUNC(MES,'mm') = ADD_MONTHS(TRUNC($P{data_referencia},'mm'),7) THEN TSK ELSE '' END MES_8,
				CASE WHEN TRUNC(MES,'mm') = ADD_MONTHS(TRUNC($P{data_referencia},'mm'),8) THEN TSK ELSE '' END MES_9,
				CASE WHEN TRUNC(MES,'mm') = ADD_MONTHS(TRUNC($P{data_referencia},'mm'),9) THEN TSK ELSE '' END MES_10,
				CASE WHEN TRUNC(MES,'mm') = ADD_MONTHS(TRUNC($P{data_referencia},'mm'),10) THEN TSK ELSE '' END MES_11,
				CASE WHEN TRUNC(MES,'mm') = ADD_MONTHS(TRUNC($P{data_referencia},'mm'),11) THEN TSK ELSE '' END MES_12,
				CASE WHEN TRUNC(MES,'mm') = ADD_MONTHS(TRUNC($P{data_referencia},'mm'),12) THEN TSK ELSE '' END MES_13,
				DATA_TAREFA
			FROM
			(
				SELECT DISTINCT 
					INVI.NAME THEME
					, INVI.ID INV_ID
					, OCINV.HON_AREA OWNER
					, SUBSTR(TSK,1,2) TSK
					, PERIODS.START_DATE MES
					, MES_INI DATA_TAREFA
					, PC
					, PC_ORDER
				FROM
				(
					SELECT DISTINCT
						INVI.ID INV_ID,
						SUBSTR(TSK.PRNAME,1,2) TSK,
						MIN(BASE_DETAILS.START_DATE) MES_INI,
						MAX(BASE_DETAILS.FINISH_DATE) MES_FIM,
						'PLAN' PC,
						20 PC_ORDER
					FROM 
						INV_INVESTMENTS INVI
						LEFT JOIN INV_PROJECTS INVP ON INVP.PRID = INVI.ID
						LEFT JOIN PRTASK TSK ON INVI.ID = TSK.PRPROJECTID  AND SUBSTR(TSK.PRNAME,1,2) IN ('U0','U1','J0','J1','J2','J3','J4','J5','P0')
						LEFT JOIN PRJ_BASELINES BASELINE ON BASELINE.PROJECT_ID = TSK.PRPROJECTID AND BASELINE.IS_CURRENT = 1 
						LEFT JOIN PRJ_BASELINE_DETAILS BASE_DETAILS ON BASE_DETAILS.OBJECT_ID = TSK.PRID AND BASE_DETAILS.IS_CURRENT = 1 AND BASE_DETAILS.BASELINE_ID = BASELINE.ID	
						LEFT JOIN PFM_INVESTMENTS PFMI ON PFMI.INVESTMENT_ID = INVI.ID
					WHERE
						INVI.IS_ACTIVE = 1
						AND INVP.IS_TEMPLATE = 0
						AND $P{show_plan} = 1
						AND ($P{portfolio} IS NULL OR PFMI.PORTFOLIO_ID = $P{portfolio})
					GROUP BY
						INVI.ID,
						SUBSTR(TSK.PRNAME,1,2)
				)TASKS
				JOIN INV_INVESTMENTS INVI ON INVI.ID = TASKS.INV_ID
				JOIN ODF_CA_INV OCINV ON INVI.ID = OCINV.ID
				LEFT JOIN BIZ_COM_PERIODS PERIODS ON ((TRUNC(TASKS.MES_INI,'MONTH') <= PERIODS.START_DATE AND TRUNC(TASKS.MES_FIM,'MONTH') >= PERIODS.START_DATE)) AND PERIODS.PERIOD_TYPE = 'MONTHLY'
			)	
		)
		GROUP BY
			INV_ID,
			PC
	)PRJ
	ON ALOCACAO.INV_ID = PRJ.INV_ID
	LEFT JOIN ODF_CA_INV OCINV ON ALOCACAO.INV_ID = OCINV.ID
	LEFT JOIN CMN_LOOKUPS_V OWNER ON OWNER.LOOKUP_CODE = OCINV.hon_area AND OWNER.LANGUAGE_CODE = 'pt' AND OWNER.LOOKUP_TYPE = 'HON_LKP_AREA'
)FINAL
WHERE
	RES_UNIQUE_NAME = $P{func_id}
	AND $X{IN,OWNER,owner}