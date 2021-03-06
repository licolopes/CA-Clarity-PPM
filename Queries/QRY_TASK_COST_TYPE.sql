SELECT DISTINCT
	@SELECT:DIM:USER_DEF:IMPLIED:KEYTASK:TSK.PRID:ID_TAREFA@
	, @SELECT:DIM_PROP:USER_DEF:IMPLIED:KEYTASK:TSK.PRNAME:NOME_TAREFA@
	, @SELECT:DIM_PROP:USER_DEF:IMPLIED:KEYTASK:INV.CODE:INV_CODE@
	, @SELECT:DIM_PROP:USER_DEF:IMPLIED:KEYTASK:INV.NAME:INV_NAME@
	
FROM
    INV_INVESTMENTS INV 
    INNER JOIN PRTASK TSK ON TSK.PRPROJECTID = INV.ID
	
WHERE  @FILTER@
	AND TSK.COST_TYPE IS NOT NULL
	AND INV.IS_ACTIVE = 1

ORDER BY
  INV_CODE ASC
  , ID_TAREFA ASC