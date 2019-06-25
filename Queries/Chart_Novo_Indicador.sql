SELECT
	INV.ID  PROJ_ID
	, INV.CODE PROJ_CODE
	, INV.NAME PROJ_NAME
	, OPRJ.DITV_NOME_NV_INDICAD NV_IND_NOME
	, OPRJ.DITV_UNID_NV_INDICAD NV_IND_UNID
	, OPRJ.DITV_PS_NV_IND NV_IND_PESSIMISTA
	, OPRJ.DITV_MD_NV_IND NV_IND_MODERADO
	, OPRJ.DITV_OT_NV_IND NV_IND_OTIMISTA
	, OPRJ.DITV_BREAKEVEN BREAKEVEN

FROM
	INV_INVESTMENTS INV
	LEFT JOIN ODF_CA_PROJECT OPRJ ON OPRJ.ID = INV.ID

WHERE 
	INV.ID = 5058068
