SELECT 
	@SELECT:MAP.LOOKUP_CODE:LOOKUP_CODE@,
	@SELECT:MAP.LOOKUP_NAME:LOOKUP_NAME@,
	@SELECT:MAP.LOOKUP_SORT:LOOKUP_SORT@
FROM  (
		
		SELECT
				lookup_code, lookup_name, lookup_sort
				FROM
				(
					SELECT 
						'rcf_flexibility' lookup_code
						,'Externo' lookup_name
						, 1 lookup_sort
					FROM DUAL

					UNION
					
					SELECT  
						'rcf_supportability' lookup_code
						,'Gerenciamento de Projeto' lookup_name
						, 2 lookup_sort
					FROM DUAL
						   
					UNION
					
					SELECT  
						'rcf_org_culture' lookup_code
						,'Organizacional' lookup_name
						, 3 lookup_sort
					FROM DUAL
						   
					UNION
					
					SELECT  
						'rcf_technical' lookup_code
						,'Técnico' lookup_name
						, 4 lookup_sort
					FROM DUAL
				)AMTS
			WHERE
			(
				@WHERE:PARAM:USER_DEF:STRING:MAPPING_TYPE_CONSTRAIN@ IS NULL OR
				@WHERE:PARAM:USER_DEF:STRING:MAPPING_TYPE_CONSTRAIN@ = 'um_tp_categ_risco'
			)
		) MAP
WHERE  @FILTER@