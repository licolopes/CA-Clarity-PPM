SELECT
	hm_recurso RECURSO
	, RES.FIRST_NAME + ' ' + RES.LAST_NAME FULL_NAME
	, hm_dia DATA
	, ISNULL(hm_hora_inicio,'00:00') HORA_INICIO
	, ISNULL(hm_hora_fim,'00:00') HORA_FIM
	, hm_horas_ausentes HORAS_AUSENTES
	, ISNULL(DATEDIFF(MINUTE, hm_hora_inicio, hm_hora_fim),0) MINUTOS
	, ISNULL(CONVERT(varchar(5), DATEADD(minute, DATEDIFF(minute, hm_hora_inicio, hm_hora_fim), 0), 114),'00:00') SALDO_HORAS
	
FROM
	NIKU.ODF_CA_HM_REGISTRO_PONTO REG
	LEFT JOIN NIKU.SRM_RESOURCES RES ON RES.ID = REG.hm_recurso

WHERE
	REG.hm_recurso = 5003032	
	
ORDER BY
	hm_recurso ASC
	, hm_dia ASC
	, hm_hora_inicio ASC