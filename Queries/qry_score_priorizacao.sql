SELECT
INV_CODE
, INV_NAME
, SCORE	
, CASE
	WHEN SCORE <= 22.40 THEN 'baixo'
	WHEN SCORE > 22.40 AND SCORE <= 43.60 THEN 'medio'
	WHEN SCORE > 43.60 AND SCORE <= 64.80 THEN 'alto'
	WHEN SCORE > 64.80 THEN 'critico'
	END GRAU_RISCO_ID
FROM
(

	SELECT
	INV_CODE
	, INV_NAME
	, CASE
		WHEN POSICAO_FAT = 0
			THEN (IMPACTO_REG + MELHORIA_PROD + DESAB_PROD + FAT_C_MC)
		WHEN POSICAO_FAT > 0
			THEN POSICAO_FAT + IMPACTO_REG + MELHORIA_PROD + DESAB_PROD + FAT_C_MC
		END SCORE
	 
	FROM
	(
		SELECT DISTINCT
			INV.CODE INV_CODE
			, INV.NAME INV_NAME
			, ISNULL((IMPACTO_REG.PESO * IMPACTO_REG.VALOR),0) IMPACTO_REG
			, ISNULL((MELHORIA_PROD.PESO * MELHORIA_PROD.VALOR),0) MELHORIA_PROD
			, ISNULL((DESAB_PROD.PESO * DESAB_PROD.VALOR),0) DESAB_PROD
			, ISNULL((FAT_C_MC.PESO * FAT_C_MC.VALOR),0) FAT_C_MC
			, ISNULL( (1 / OPRJ.pr_pos_real),0) POSICAO_FAT
			
		FROM
			NIKU.INV_INVESTMENTS INV
			INNER JOIN NIKU.ODF_CA_PROJECT OPRJ ON OPRJ.ID = INV.ID
			LEFT JOIN NIKU.ODF_CA_PR_MAP_PESQ IMPACTO_REG ON IMPACTO_REG.NOME_PESQ = OPRJ.pr_imp_reg
			LEFT JOIN NIKU.ODF_CA_PR_MAP_PESQ MELHORIA_PROD ON MELHORIA_PROD.NOME_PESQ = OPRJ.pr_melhoria_prod 
			LEFT JOIN NIKU.ODF_CA_PR_MAP_PESQ DESAB_PROD ON DESAB_PROD.NOME_PESQ = OPRJ.pr_desab_prod 
			LEFT JOIN NIKU.ODF_CA_PR_MAP_PESQ FAT_C_MC ON FAT_C_MC.NOME_PESQ = OPRJ.pr_fat_mc 

		WHERE
			OPRJ.PARTITION_CODE = 'hm_pos_registro'
			AND INV.ID = '5287003'
		
	)SCORE
)AMTS