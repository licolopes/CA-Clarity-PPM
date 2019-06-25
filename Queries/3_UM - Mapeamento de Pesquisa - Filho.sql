SELECT 
	@SELECT:MAP.LOOKUP_CODE:LOOKUP_CODE@,
	@SELECT:MAP.LOOKUP_NAME:LOOKUP_NAME@,
	@SELECT:MAP.LOOKUP_SORT:LOOKUP_SORT@
FROM 	(	
		SELECT DISTINCT	l.lookup_code lookup_code, l.name lookup_name, l.sort_order lookup_sort
		FROM   cmn_lookups_v l
		WHERE  l.lookup_type = 'LKP_UM_CATEG_RISCO' 
			AND l.language_code = @WHERE:PARAM:LANGUAGE@ 
			AND l.is_active = 1
			AND (
					@WHERE:PARAM:USER_DEF:STRING:MAPPING_TYPE_CONSTRAIN@ IS NULL OR
					@WHERE:PARAM:USER_DEF:STRING:MAPPING_TYPE_CONSTRAIN@ = 'um_tp_categ_risco'
				)
		) MAP
WHERE  @FILTER@