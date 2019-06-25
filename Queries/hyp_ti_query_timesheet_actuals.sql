SELECT
	INV.ID INV_ID,
	INV.CODE INV_CODE,
	INV.NAME INV_NAME,
	TASK.PRNAME TASK_NAME,
	PBS.SLICE_DATE DATES,
	RES.PRNAME RESOURCE_NAME,
	RES.PRUSERNAME USERNAME,
	RES.PRID RESOURCE_ID,
	CC.PRNAME CHARGECODE,
	TS.PRSTATUS TS_STATUS_ID,
	CASE WHEN TS.PRSTATUS = 4 THEN 'POSTED' END TS_STATUS,
	SUM(PBS.SLICE) ACTUALS
FROM 
	NIKU.INV_INVESTMENTS INV 
	LEFT JOIN NIKU.PRTASK TASK ON INV.ID = TASK.PRPROJECTID
	LEFT JOIN NIKU.PRASSIGNMENT ASSIGN ON TASK.PRID = ASSIGN.PRTASKID
	LEFT JOIN NIKU.PRTIMEENTRY TE ON TE.PRASSIGNMENTID = ASSIGN.PRID
	LEFT JOIN NIKU.PRJ_BLB_SLICES PBS ON TE.PRID = PBS.PRJ_OBJECT_ID
	LEFT JOIN NIKU.PRJ_BLB_SLICEREQUESTS PBSR ON PBSR.ID = PBS.SLICE_REQUEST_ID
	LEFT JOIN NIKU.PRTIMESHEET TS ON TE.PRTIMESHEETID = TS.PRID
	LEFT JOIN NIKU.PRRESOURCE RES ON TS.PRRESOURCEID = RES.PRID
	LEFT JOIN NIKU.PRCHARGECODE CC ON TE.PRCHARGECODEID = CC.PRID
WHERE
	INV.ODF_OBJECT_CODE = 'PROJECT'
	AND PBSR.REQUEST_NAME = 'DAILYRESOURCETIMECURVE'
	AND TS.PRSTATUS = 4
GROUP BY
	INV.ID,
	INV.CODE,
	INV.NAME,
	TASK.PRNAME,
	PBS.SLICE_DATE,
	RES.PRNAME,
	RES.PRUSERNAME,
	RES.PRID,
	CC.PRNAME,
	TS.PRSTATUS
ORDER BY
	INV.ID ASC,
	RES.PRUSERNAME ASC