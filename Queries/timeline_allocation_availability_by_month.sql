SELECT
FUNC_ID,
FUNC_UNIQUE_NAME,
FUNC_NAME,
RES_USERID,
RES_UNIQUE_NAME,
RES_NAME,
SUPER_UNIQUE_NAME,
SUPER_NAME,
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
REC_ALC,
CAP_MES_1,
CAP_MES_2,
CAP_MES_3,
CAP_MES_4,
CAP_MES_5,
CAP_MES_6,
CAP_MES_7,
CAP_MES_8,
CAP_MES_9,
CAP_MES_10,
CAP_MES_11,
CAP_MES_12,
CAP_MES_13,
CAP_TOTAL,
FTOTAL_M1,
FTOTAL_M2,
FTOTAL_M3,
FTOTAL_M4,
FTOTAL_M5,
FTOTAL_M6,
FTOTAL_M7,
FTOTAL_M8,
FTOTAL_M9,
FTOTAL_M10,
FTOTAL_M11,
FTOTAL_M12,
FTOTAL_M13,
FTOTAL
FROM
(
	SELECT
	REC.FUNC_ID,
	REC.FUNC_UNIQUE_NAME,
	REC.FUNC_NAME,
	REC.RES_USERID,
	REC.RES_UNIQUE_NAME,
	REC.RES_NAME,
	REC.SUPER_UNIQUE_NAME,
	REC.SUPER_NAME,
	REC.ALC_MES_1,
	REC.ALC_MES_2,
	REC.ALC_MES_3,
	REC.ALC_MES_4,
	REC.ALC_MES_5,
	REC.ALC_MES_6,
	REC.ALC_MES_7,
	REC.ALC_MES_8,
	REC.ALC_MES_9,
	REC.ALC_MES_10,
	REC.ALC_MES_11,
	REC.ALC_MES_12,
	REC.ALC_MES_13,
	REC.ALC_TOTAL,
	CASE
		WHEN $P{rec_sem_aloc} = 0 AND REC.ALC_TOTAL > 0 THEN 0
		WHEN $P{rec_sem_aloc} = 1 AND REC.ALC_TOTAL >= 0 THEN 1
		END REC_ALC,
	REC.CAP_MES_1,
	REC.CAP_MES_2,
	REC.CAP_MES_3,
	REC.CAP_MES_4,
	REC.CAP_MES_5,
	REC.CAP_MES_6,
	REC.CAP_MES_7,
	REC.CAP_MES_8,
	REC.CAP_MES_9,
	REC.CAP_MES_10,
	REC.CAP_MES_11,
	REC.CAP_MES_12,
	REC.CAP_MES_13,
	REC.CAP_TOTAL,
	NVL(TOTAL.FTOTAL_M1,0) FTOTAL_M1,
	NVL(TOTAL.FTOTAL_M2,0) FTOTAL_M2,
	NVL(TOTAL.FTOTAL_M3,0) FTOTAL_M3,
	NVL(TOTAL.FTOTAL_M4,0) FTOTAL_M4,
	NVL(TOTAL.FTOTAL_M5,0) FTOTAL_M5,
	NVL(TOTAL.FTOTAL_M6,0) FTOTAL_M6,
	NVL(TOTAL.FTOTAL_M7,0) FTOTAL_M7,
	NVL(TOTAL.FTOTAL_M8,0) FTOTAL_M8,
	NVL(TOTAL.FTOTAL_M9,0) FTOTAL_M9,
	NVL(TOTAL.FTOTAL_M10,0) FTOTAL_M10,
	NVL(TOTAL.FTOTAL_M11,0) FTOTAL_M11,
	NVL(TOTAL.FTOTAL_M12,0) FTOTAL_M12,
	NVL(TOTAL.FTOTAL_M13,0) FTOTAL_M13,
	NVL(TOTAL.FTOTAL,0) FTOTAL
	FROM
	(
		SELECT
		ALOCACAO.RES_USERID,
		ALOCACAO.RES_UNIQUE_NAME,
		ALOCACAO.RES_NAME,
		ALOCACAO.ISROLE,
		ALOCACAO.FUNC_ID,
		ALOCACAO.FUNC_UNIQUE_NAME,
		ALOCACAO.FUNC_NAME,
		ALOCACAO.SUPER_UNIQUE_NAME,
		ALOCACAO.SUPER_NAME,
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
		CAPACIDADE.CAP_MES_1,
		CAPACIDADE.CAP_MES_2,
		CAPACIDADE.CAP_MES_3,
		CAPACIDADE.CAP_MES_4,
		CAPACIDADE.CAP_MES_5,
		CAPACIDADE.CAP_MES_6,
		CAPACIDADE.CAP_MES_7,
		CAPACIDADE.CAP_MES_8,
		CAPACIDADE.CAP_MES_9,
		CAPACIDADE.CAP_MES_10,
		CAPACIDADE.CAP_MES_11,
		CAPACIDADE.CAP_MES_12,
		CAPACIDADE.CAP_MES_13,
		CAPACIDADE.CAP_TOTAL
		FROM
		(
			SELECT
				RES_USERID,
				RES_UNIQUE_NAME,
				RES_NAME,
				ISROLE,
				FUNC_ID,
				FUNC_UNIQUE_NAME,
				FUNC_NAME,
				SUPER_UNIQUE_NAME,
				SUPER_NAME,
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
				RES_USERID,
				RES_UNIQUE_NAME,
				RES_NAME,
				ISROLE,
				FUNC_ID,
				FUNC_UNIQUE_NAME,
				FUNC_NAME,
				SUPER_UNIQUE_NAME,
				SUPER_NAME,
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
						RES_USERID,
						RES_UNIQUE_NAME,
						RES_NAME,
						ISROLE,
						FUNC_ID,
						FUNC_UNIQUE_NAME,
						FUNC_NAME,
						SUPER_UNIQUE_NAME,
						SUPER_NAME,
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
							PRES.PRPRIMARYROLEID FUNC_ID,
							FUNC.UNIQUE_NAME FUNC_UNIQUE_NAME,
							FUNC.FIRST_NAME || ' ' || FUNC.LAST_NAME FUNC_NAME,
							SUPER.UNIQUE_NAME SUPER_UNIQUE_NAME,
							SUPER.FIRST_NAME || ' ' || SUPER.LAST_NAME SUPER_NAME,
							TRUNC(S.SLICE_DATE, 'mm') MES,
							NVL(S.SLICE,0) HORAS,
							CASE 
								WHEN OWNER.NAME LIKE 'S - CS' THEN 'CS' 
								WHEN OWNER.NAME LIKE 'S - PARTS' THEN 'SP' 
								WHEN OWNER.NAME LIKE 'EDB - HDA' THEN 'EDB - HDA' 
								WHEN OWNER.NAME LIKE 'HAB - BR - E' THEN 'HAB - E' 
								WHEN OWNER.NAME LIKE 'HAB - BR - DB' THEN 'HAB - DB'		
								WHEN SUBSTR(OWNER.NAME,0,INSTR(OWNER.NAME,' ')-1) = 'TI' THEN 'IT' 
								ELSE SUBSTR(OWNER.NAME,0,INSTR(OWNER.NAME,' ')-1) 
								END OWNER
						FROM   
							PRTEAM TM          	
							INNER JOIN SRM_RESOURCES R ON  TM.PRRESOURCEID = R.ID
							INNER JOIN PRJ_RESOURCES PRES ON PRES.PRID = R.ID
							INNER JOIN SRM_RESOURCES FUNC ON FUNC.ID = PRES.PRPRIMARYROLEID
							LEFT JOIN SRM_RESOURCES SUPER ON SUPER.USER_ID = R.MANAGER_ID							
							INNER JOIN INV_INVESTMENTS INV ON INV.ID = TM.PRPROJECTID  
							INNER JOIN PRJ_BLB_SLICES S ON TM.PRID = S.PRJ_OBJECT_ID
							INNER JOIN PRJ_BLB_SLICEREQUESTS SR ON S.SLICE_REQUEST_ID = SR.ID AND SR.REQUEST_NAME IN ('MONTHLYRESOURCEALLOCCURVE')
							INNER JOIN NBI_DIM_CALENDAR_TIME CAL ON S.SLICE_DATE = CAL.DAY
							INNER JOIN NBI_DIM_CALENDAR_TIME LD ON LD.MONTH_KEY = CAL.MONTH_KEY AND LD.HIERARCHY_LEVEL = 'MONTH'
							INNER JOIN ODF_CA_INV OCINV ON INV.ID = OCINV.ID
							LEFT JOIN CMN_LOOKUPS_V OWNER ON OWNER.LOOKUP_CODE = OCINV.hon_area AND OWNER.LANGUAGE_CODE = 'pt' AND OWNER.LOOKUP_TYPE = 'HON_LKP_AREA'
							LEFT JOIN PRJ_OBS_ASSOCIATIONS OBSA ON OBSA.RECORD_ID = R.ID
							LEFT JOIN PRJ_OBS_UNITS_FLAT OBSF ON OBSA.UNIT_ID = OBSF.UNIT_ID
							LEFT JOIN PRJ_OBS_UNITS OBSU ON OBSU.ID = OBSF.BRANCH_UNIT_ID
							LEFT JOIN PRJ_OBS_OBJECT_TYPES OOT ON OOT.TYPE_ID = OBSU.TYPE_ID AND OOT.TABLE_NAME = 'SRM_RESOURCES'
							LEFT JOIN PFM_INVESTMENTS PFMI ON PFMI.INVESTMENT_ID = INV.ID
						WHERE
							R.IS_ACTIVE = 1						
							AND $X{IN,OBSU.ID,org}
							AND TRUNC(S.SLICE_DATE, 'mm') >= TRUNC($P{data_referencia},'mm')
							AND ($P{portfolio} IS NULL OR PFMI.PORTFOLIO_ID = $P{portfolio})
					)T1
					GROUP BY
						RES_USERID,
						RES_UNIQUE_NAME,
						RES_NAME,
						ISROLE,
						FUNC_ID,
						FUNC_UNIQUE_NAME,
						FUNC_NAME,
						SUPER_UNIQUE_NAME,
						SUPER_NAME,
						MES
				)T2
			)T3		
			GROUP BY
				RES_USERID,
				RES_UNIQUE_NAME,
				RES_NAME,
				ISROLE,
				FUNC_ID,
				FUNC_UNIQUE_NAME,
				FUNC_NAME,
				SUPER_UNIQUE_NAME,
				SUPER_NAME
		)ALOCACAO
		
		LEFT JOIN

		(
			SELECT
				RES_USERID,
				RES_UNIQUE_NAME,
				RES_NAME,
				FUNC_ID,
				FUNC_UNIQUE_NAME,
				FUNC_NAME,
				SUM(MES_1) CAP_MES_1,
				SUM(MES_2) CAP_MES_2,
				SUM(MES_3) CAP_MES_3,
				SUM(MES_4) CAP_MES_4,
				SUM(MES_5) CAP_MES_5,
				SUM(MES_6) CAP_MES_6,
				SUM(MES_7) CAP_MES_7,
				SUM(MES_8) CAP_MES_8,
				SUM(MES_9) CAP_MES_9,
				SUM(MES_10) CAP_MES_10,
				SUM(MES_11) CAP_MES_11,
				SUM(MES_12) CAP_MES_12,
				SUM(MES_13) CAP_MES_13,
				SUM(TOTAL) CAP_TOTAL
			FROM
			(
				SELECT
				RES_USERID,
				RES_UNIQUE_NAME,
				RES_NAME,
				FUNC_ID,
				FUNC_UNIQUE_NAME,
				FUNC_NAME,
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
						RES_USERID,
						RES_UNIQUE_NAME,
						RES_NAME,
						FUNC_ID,
						FUNC_UNIQUE_NAME,
						FUNC_NAME,
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
						SELECT 
							R.USER_ID RES_USERID,
							R.UNIQUE_NAME RES_UNIQUE_NAME,
							R.FIRST_NAME || ' ' || R.LAST_NAME RES_NAME,
							PRES.PRPRIMARYROLEID FUNC_ID,
							FUNC.UNIQUE_NAME FUNC_UNIQUE_NAME,
							FUNC.FIRST_NAME || ' ' || FUNC.LAST_NAME FUNC_NAME,
							TRUNC(S.SLICE_DATE, 'mm') MES,
							NVL(S.SLICE,0) HORAS
						FROM   
							SRM_RESOURCES R
							INNER JOIN PRJ_RESOURCES PRES ON PRES.PRID = R.ID
							INNER JOIN SRM_RESOURCES FUNC ON FUNC.ID = PRES.PRPRIMARYROLEID
							INNER JOIN PRJ_BLB_SLICES S ON R.ID = S.PRJ_OBJECT_ID
							INNER JOIN PRJ_BLB_SLICEREQUESTS SR ON S.SLICE_REQUEST_ID = SR.ID AND SR.REQUEST_NAME IN ('MONTHLYRESOURCEAVAILCURVE')
							INNER JOIN NBI_DIM_CALENDAR_TIME CAL ON S.SLICE_DATE = CAL.DAY
							INNER JOIN NBI_DIM_CALENDAR_TIME LD ON LD.MONTH_KEY = CAL.MONTH_KEY AND LD.HIERARCHY_LEVEL = 'MONTH'
						WHERE
							TRUNC(S.SLICE_DATE, 'mm') >= TRUNC($P{data_referencia},'mm')
					)T1
					GROUP BY
						RES_USERID,
						RES_UNIQUE_NAME,
						RES_NAME,
						FUNC_ID,
						FUNC_UNIQUE_NAME,
						FUNC_NAME,
						MES
				)T2
			)T3
			GROUP BY
				RES_USERID,
				RES_UNIQUE_NAME,
				RES_NAME,
				FUNC_ID,
				FUNC_UNIQUE_NAME,
				FUNC_NAME
		)CAPACIDADE

		ON  ALOCACAO.RES_UNIQUE_NAME = CAPACIDADE.RES_UNIQUE_NAME
	)REC

	LEFT JOIN

	(
		SELECT
			ALOCACAO.RES_USERID,
			ALOCACAO.RES_UNIQUE_NAME,
			ALOCACAO.RES_NAME,
			ALOCACAO.ALC_MES_1 FTOTAL_M1,
			ALOCACAO.ALC_MES_2 FTOTAL_M2,
			ALOCACAO.ALC_MES_3 FTOTAL_M3,
			ALOCACAO.ALC_MES_4 FTOTAL_M4,
			ALOCACAO.ALC_MES_5 FTOTAL_M5,
			ALOCACAO.ALC_MES_6 FTOTAL_M6,
			ALOCACAO.ALC_MES_7 FTOTAL_M7,
			ALOCACAO.ALC_MES_8 FTOTAL_M8,
			ALOCACAO.ALC_MES_9 FTOTAL_M9,
			ALOCACAO.ALC_MES_10 FTOTAL_M10,
			ALOCACAO.ALC_MES_11 FTOTAL_M11,
			ALOCACAO.ALC_MES_12 FTOTAL_M12,
			ALOCACAO.ALC_MES_13 FTOTAL_M13,
			ALOCACAO.ALC_TOTAL FTOTAL
			FROM
			(
				SELECT
					RES_USERID,
					RES_UNIQUE_NAME,
					RES_NAME,
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
								NVL(S.SLICE,0) HORAS,
								CASE 
									WHEN OWNER.NAME LIKE 'S - CS' THEN 'CS' 
									WHEN OWNER.NAME LIKE 'S - PARTS' THEN 'SP' 
									WHEN OWNER.NAME LIKE 'EDB - HDA' THEN 'EDB - HDA' 
									WHEN OWNER.NAME LIKE 'HAB - BR - E' THEN 'HAB - E' 
									WHEN OWNER.NAME LIKE 'HAB - BR - DB' THEN 'HAB - DB'		
									WHEN SUBSTR(OWNER.NAME,0,INSTR(OWNER.NAME,' ')-1) = 'TI' THEN 'IT' 
									ELSE SUBSTR(OWNER.NAME,0,INSTR(OWNER.NAME,' ')-1) 
									END OWNER
							FROM   
								PRTEAM TM          	
								INNER JOIN SRM_RESOURCES R ON  TM.PRRESOURCEID = R.ID
								INNER JOIN PRJ_RESOURCES PRES ON PRES.PRID = R.ID
								INNER JOIN INV_INVESTMENTS INV ON INV.ID = TM.PRPROJECTID  
								INNER JOIN PRJ_BLB_SLICES S ON TM.PRID = S.PRJ_OBJECT_ID
								INNER JOIN PRJ_BLB_SLICEREQUESTS SR ON S.SLICE_REQUEST_ID = SR.ID AND SR.REQUEST_NAME IN ('MONTHLYRESOURCEALLOCCURVE')
								INNER JOIN NBI_DIM_CALENDAR_TIME CAL ON S.SLICE_DATE = CAL.DAY
								INNER JOIN NBI_DIM_CALENDAR_TIME LD ON LD.MONTH_KEY = CAL.MONTH_KEY AND LD.HIERARCHY_LEVEL = 'MONTH'
								INNER JOIN ODF_CA_INV OCINV ON INV.ID = OCINV.ID
								LEFT JOIN CMN_LOOKUPS_V OWNER ON OWNER.LOOKUP_CODE = OCINV.hon_area AND OWNER.LANGUAGE_CODE = 'pt' AND OWNER.LOOKUP_TYPE = 'HON_LKP_AREA'
								LEFT JOIN PFM_INVESTMENTS PFMI ON PFMI.INVESTMENT_ID = INV.ID
							WHERE
								TRUNC(S.SLICE_DATE, 'mm') >= TRUNC($P{data_referencia},'mm')
								AND PRES.PRISROLE = 1
								AND ($P{portfolio} IS NULL OR PFMI.PORTFOLIO_ID = $P{portfolio})
						)T1
						WHERE
							$X{IN,T1.OWNER,owner}
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
					RES_USERID,
					RES_UNIQUE_NAME,
					RES_NAME
			)ALOCACAO
	)TOTAL
	ON REC.FUNC_UNIQUE_NAME = TOTAL.RES_UNIQUE_NAME
)TOTAL2

WHERE
	$X{IN,FUNC_UNIQUE_NAME,func}
	AND $X{IN,SUPER_UNIQUE_NAME,super}
	AND REC_ALC = $P{rec_sem_aloc}