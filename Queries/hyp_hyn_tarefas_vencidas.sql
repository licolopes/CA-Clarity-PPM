SELECT   @SELECT:DIM:USER_DEF:IMPLIED:LISTA_PROJ:DISTINCT UNIQUE_ID:UNIQUE_ID@
		,@SELECT:DIM_PROP:USER_DEF:IMPLIED:LISTA_PROJ:INV_ID:INV_ID@
		,@SELECT:DIM_PROP:USER_DEF:IMPLIED:LISTA_PROJ:INV_CODE:INV_CODE@
		,@SELECT:DIM_PROP:USER_DEF:IMPLIED:LISTA_PROJ:INV_NAME:INV_NAME@
		,@SELECT:DIM_PROP:USER_DEF:IMPLIED:LISTA_PROJ:CATEGORIA:CATEGORIA@
		,@SELECT:DIM_PROP:USER_DEF:IMPLIED:LISTA_PROJ:PORTARIA:PORTARIA@
		,@SELECT:DIM_PROP:USER_DEF:IMPLIED:LISTA_PROJ:TIPO_PROJ:TIPO_PROJ@
		,@SELECT:DIM_PROP:USER_DEF:IMPLIED:LISTA_PROJ:UNIDADE_NEGOCIO:UNIDADE_NEGOCIO@
		,@SELECT:DIM_PROP:USER_DEF:IMPLIED:LISTA_PROJ:STATUS:STATUS@
		,@SELECT:DIM_PROP:USER_DEF:IMPLIED:LISTA_PROJ:ETAPA:ETAPA@
		,@SELECT:DIM_PROP:USER_DEF:IMPLIED:LISTA_PROJ:TAREFA:TAREFA@

FROM   (  
SELECT DISTINCT
   CONVERT(varchar(6),GETDATE(),12) + REPLACE(CONVERT(varchar(8),GETDATE(),108),':','') + CONVERT(VARCHAR(6),ROW_NUMBER() OVER (ORDER BY INV.ID)) UNIQUE_ID
 , INV.ID INV_ID 
 , INV.CODE INV_CODE
 , INV.NAME INV_NAME
 , CATEG_PROD.LOOKUP_CODE ID_CATEG_PROD  
 , CATEG_PROD.NAME CATEGORIA
 , PORTARIA.NAME PORTARIA
 , TIPO_PROJ.LOOKUP_CODE ID_TIPO_PROJ
 , TIPO_PROJ.NAME TIPO_PROJ
 , UNID_NEG.LOOKUP_CODE ID_UNIDADE_NEGOCIO
 , substring( ( SELECT ', '+UN2.NAME AS [text()]                      
   FROM niku.INV_INVESTMENTS INV2                      
   JOIN niku.ODF_MULTI_VALUED_LOOKUPS MLKP2 ON MLKP2.PK_ID = INV2.ID AND MLKP2.OBJECT = 'project' AND MLKP2.ATTRIBUTE = 'hm_unid_ne'                      
   JOIN niku.CMN_LOOKUPS_V UN2 ON MLKP2.VALUE = UN2.LOOKUP_CODE AND UN2.LANGUAGE_CODE = 'pt' AND UN2.LOOKUP_TYPE = 'HM_LKP_UNID_NEG'                      
   WHERE INV2.CODE = INV.CODE FOR XML PATH ('') ),3,1000) [UNIDADE_NEGOCIO]
 , STATUS.LOOKUP_CODE ID_STATUS
 , STATUS.NAME STATUS
 , ETAPA.LOOKUP_CODE ID_ETAPA
 , ETAPA.NAME ETAPA    
 , C.MONTH_KEY MES
 , PTSK.PRNAME TAREFA
 
FROM NIKU.INV_INVESTMENTS INV
JOIN NIKU.ODF_CA_INV OINV ON OINV.id = INV.ID
JOIN NIKU.ODF_CA_PROJECT ODFPROJ ON ODFPROJ.id = INV.ID       
JOIN NIKU.INV_PROJECTS IPRJ ON INV.ID = IPRJ.PRID   
JOIN NIKU.ODF_MULTI_VALUED_LOOKUPS MUL ON INV.ID = MUL.PK_ID AND MUL.OBJECT = 'project' AND MUL.ATTRIBUTE = 'hm_unid_ne'
JOIN NIKU.CMN_LOOKUPS_V UNID_NEG ON UNID_NEG.LOOKUP_CODE = MUL.VALUE AND UNID_NEG.LOOKUP_TYPE = 'HM_LKP_UNID_NEG'AND UNID_NEG.LANGUAGE_CODE = 'pt'
JOIN NIKU.CMN_LOOKUPS_V CATEG_PROD ON CATEG_PROD.LOOKUP_CODE = OINV.hm_categ_prod AND CATEG_PROD.LOOKUP_TYPE = 'HM_CATEG_PROD' AND CATEG_PROD.LANGUAGE_CODE = 'pt'
LEFT JOIN NIKU.CMN_LOOKUPS_V ETAPA ON ETAPA.LOOKUP_CODE = OINV.hm_etap_proj AND ETAPA.LOOKUP_TYPE = 'HM_LKP_ETAP_PROJ' AND ETAPA.LANGUAGE_CODE = 'pt'
JOIN NIKU.CMN_LOOKUPS_V STATUS ON STATUS.LOOKUP_CODE = OINV.hm_status_proj AND STATUS.LOOKUP_TYPE = 'HM_STATUS' AND STATUS.LANGUAGE_CODE = 'pt'
JOIN NIKU.CMN_LOOKUPS_V TIPO_PROJ ON TIPO_PROJ.LOOKUP_CODE = OINV.hm_tipo_projeto AND TIPO_PROJ.LOOKUP_TYPE = 'HM_LKP_TIPO_PROJ' AND TIPO_PROJ.LANGUAGE_CODE = 'pt'
JOIN NIKU.CMN_LOOKUPS_V PORTARIA ON PORTARIA.ID = OINV.portaria_344 AND PORTARIA.LOOKUP_TYPE = 'PAC_RPT_YESNO' AND PORTARIA.LANGUAGE_CODE = 'pt'
LEFT OUTER JOIN NIKU.NBI_DIM_CALENDAR_TIME C ON INV.CREATED_DATE BETWEEN C.PERIOD_START_DATE AND C.PERIOD_END_DATE
LEFT JOIN NIKU.PRTASK PTSK ON PTSK.PRPROJECTID = INV.ID

WHERE INV.IS_ACTIVE = 1  
AND IPRJ.IS_PROGRAM = 0
AND C.MONTH_KEY != ''
AND ODFPROJ.PARTITION_CODE = 'hm_inovaprod'
AND PTSK.PRISKEY = 1
AND PTSK.PRISTASK = 0) AMTS

WHERE @WHERE:PARAM:USER_DEF:STRING:INV_NAME:INV_NAME@   
AND @WHERE:PARAM:USER_DEF:STRING:ID_UNIDADE_NEGOCIO:UNIDADE_NEGOCIO@
AND @WHERE:PARAM:USER_DEF:STRING:ID_CATEG_PROD:CATEGORIA@
AND @WHERE:PARAM:USER_DEF:STRING:ID_STATUS:STATUS@  
AND @WHERE:PARAM:USER_DEF:STRING:ID_TIPO_PROJ:TIPO_PROJ@  
AND @WHERE:PARAM:USER_DEF:STRING:MES:MES@  
AND @WHERE:PARAM:USER_DEF:STRING:ISNULL(ID_ETAPA,''):ETAPA@  
AND @WHERE:PARAM:USER_DEF:STRING:TAREFA:TAREFA@  

AND(
	(ID_UNIDADE_NEGOCIO = @WHERE:PARAM:XML:STRING:/data/unid_neg/@value@ OR @WHERE:PARAM:XML:STRING:/data/unid_neg/@value@ IS NULL) 
	AND (ID_TIPO_PROJ = @WHERE:PARAM:XML:STRING:/data/tipo_proj/@value@ OR @WHERE:PARAM:XML:STRING:/data/tipo_proj/@value@ IS NULL)
	AND (ID_ETAPA = @WHERE:PARAM:XML:STRING:/data/etapa_proj/@value@ OR @WHERE:PARAM:XML:STRING:/data/etapa_proj/@value@ IS NULL)
	AND (MES = @WHERE:PARAM:XML:STRING:/data/mes_unid_neg/@value@ OR @WHERE:PARAM:XML:STRING:/data/mes_unid_neg/@value@ IS NULL)
	AND (TAREFA = @WHERE:PARAM:XML:STRING:/data/task/@value@ OR @WHERE:PARAM:XML:STRING:/data/task/@value@ IS NULL)
)

AND @FILTER@