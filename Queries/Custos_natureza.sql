SELECT CASE VALORES.COST_TYPE 
         WHEN 'CAPITAL' THEN 'CAPEX' 
         ELSE 'OPEX' 
		 
       END                                               NATUREZA 
       , Sum(VALORES.ORCADO)                             ORCADO 
       , Sum(VALORES.REALIZADO)                          REALIZADO 
       , Sum(VALORES.REALIZADO) / Sum(VALORES.ORCADO)    PCT_REALIZADO 
       , Sum(VALORES.COMPROMETIDO)                       COMPROMETIDO 
       , Sum(VALORES.COMPROMETIDO) / Sum(VALORES.ORCADO) PCT_COMPROMETIDO 
       , Sum(VALORES.PROJETADO)                          PROJETADO 
       , Sum(VALORES.PROJETADO) / Sum(VALORES.ORCADO)    PCT_PROJETADO 
	   
FROM   (SELECT INV_ID 
               , COST_TYPE 
               , RESOURCE_CLASS 
               , TRANSCLASS 
               , Sum(ORCADO)       ORCADO 
               , Sum(REALIZADO)    REALIZADO 
               , Sum(COMPROMETIDO) COMPROMETIDO 
               , Sum(PROJETADO)    PROJETADO 
			   
        FROM   (SELECT FIN_PLAN.OBJECT_ID               INV_ID 
                       , TIPO_CUSTO.LOOKUP_CODE         COST_TYPE 
                       , RES_CLASS.RESOURCE_CLASS 
                       , TRANSCLASS.DESCRIPTION         TRANSCLASS 
                       , Sum(ISNULL(FPD.TOTAL_COST, 0)) ORCADO 
                       , 0                              REALIZADO 
                       , 0                              COMPROMETIDO 
                       , 0                              PROJETADO 
                FROM   NIKU.FIN_PLANS FIN_PLAN 
                       JOIN NIKU.FIN_COST_PLAN_DETAILS FPD 
                         ON FIN_PLAN.ID = FPD.PLAN_ID 
                       JOIN NIKU.ODF_CA_COSTPLAN OCA_COST 
                         ON FIN_PLAN.ID = OCA_COST.ID 
                       JOIN NIKU.CMN_LOOKUPS_V TIPO_CUSTO 
                         ON TIPO_CUSTO.ID = FPD.COST_TYPE_ID 
                            AND TIPO_CUSTO.LANGUAGE_CODE = 'pt' 
                            AND TIPO_CUSTO.LOOKUP_TYPE = 
                                'LOOKUP_FIN_COSTTYPECODE' 
                       JOIN NIKU.PAC_FOS_RESOURCE_CLASS RES_CLASS 
                         ON RES_CLASS.ID = FPD.RESOURCE_CLASS_ID 
                       JOIN NIKU.TRANSCLASS TRANSCLASS 
                         ON TRANSCLASS.ID = FPD.TRANSACTION_CLASS_ID 
                WHERE  FIN_PLAN.PLAN_TYPE_CODE = 'BUDGET' 
                   AND OCA_COST.HM_TIPO_PLANO_CUSTO = 'planejado' 
                   AND FIN_PLAN.IS_PLAN_OF_RECORD = 1 
                GROUP  BY FIN_PLAN.OBJECT_ID 
                          , TIPO_CUSTO.LOOKUP_CODE 
                          , RES_CLASS.RESOURCE_CLASS 
                          , TRANSCLASS.DESCRIPTION 
                UNION 
				
                SELECT FIN_PLAN.OBJECT_ID 
                       , TIPO_CUSTO.LOOKUP_CODE         TIPO_CUSTO 
                       , RES_CLASS.RESOURCE_CLASS 
                       , TRANSCLASS.DESCRIPTION 
                       , 0                              ORCADO 
                       , 0                              REALIZADO 
                       , Sum(ISNULL(FPD.TOTAL_COST, 0)) COMPROMETIDO 
                       , 0                              PROJETADO 
                FROM   NIKU.FIN_PLANS FIN_PLAN 
                       JOIN NIKU.FIN_COST_PLAN_DETAILS FPD 
                         ON FIN_PLAN.ID = FPD.PLAN_ID 
                       JOIN NIKU.ODF_CA_COSTPLAN OCA_COST 
                         ON FIN_PLAN.ID = OCA_COST.ID 
                       JOIN NIKU.CMN_LOOKUPS_V TIPO_CUSTO 
                         ON TIPO_CUSTO.ID = FPD.COST_TYPE_ID 
                            AND TIPO_CUSTO.LANGUAGE_CODE = 'pt' 
                            AND TIPO_CUSTO.LOOKUP_TYPE = 
                                'LOOKUP_FIN_COSTTYPECODE' 
                       JOIN NIKU.PAC_FOS_RESOURCE_CLASS RES_CLASS 
                         ON RES_CLASS.ID = FPD.RESOURCE_CLASS_ID 
                       JOIN NIKU.TRANSCLASS TRANSCLASS 
                         ON TRANSCLASS.ID = FPD.TRANSACTION_CLASS_ID 
                WHERE  FIN_PLAN.PLAN_TYPE_CODE = 'FORECAST' 
                   AND OCA_COST.HM_TIPO_PLANO_CUSTO = 'comprometido' 
                   AND FIN_PLAN.IS_PLAN_OF_RECORD = 1 
                GROUP  BY FIN_PLAN.OBJECT_ID 
                          , TIPO_CUSTO.LOOKUP_CODE 
                          , RES_CLASS.RESOURCE_CLASS 
                          , TRANSCLASS.DESCRIPTION 
                UNION 
				
                SELECT FIN_PLAN.OBJECT_ID 
                       , TIPO_CUSTO.LOOKUP_CODE         TIPO_CUSTO 
                       , RES_CLASS.RESOURCE_CLASS 
                       , TRANSCLASS.DESCRIPTION 
                       , 0                              ORCADO 
                       , 0                              REALIZADO 
                       , 0                              COMPROMETIDO 
                       , Sum(ISNULL(FPD.TOTAL_COST, 0)) PROJETADO 
					   
                FROM   NIKU.FIN_PLANS FIN_PLAN 
                       JOIN NIKU.FIN_COST_PLAN_DETAILS FPD 
                         ON FIN_PLAN.ID = FPD.PLAN_ID 
                       JOIN NIKU.ODF_CA_COSTPLAN OCA_COST 
                         ON FIN_PLAN.ID = OCA_COST.ID 
                       JOIN NIKU.CMN_LOOKUPS_V TIPO_CUSTO 
                         ON TIPO_CUSTO.ID = FPD.COST_TYPE_ID 
                            AND TIPO_CUSTO.LANGUAGE_CODE = 'pt' 
                            AND TIPO_CUSTO.LOOKUP_TYPE = 
                                'LOOKUP_FIN_COSTTYPECODE' 
                       JOIN NIKU.PAC_FOS_RESOURCE_CLASS RES_CLASS 
                         ON RES_CLASS.ID = FPD.RESOURCE_CLASS_ID 
                       JOIN NIKU.TRANSCLASS TRANSCLASS 
                         ON TRANSCLASS.ID = FPD.TRANSACTION_CLASS_ID 
                WHERE  FIN_PLAN.PLAN_TYPE_CODE = 'FORECAST' 
                   AND OCA_COST.HM_TIPO_PLANO_CUSTO = 'projetado' 
                   AND FIN_PLAN.IS_PLAN_OF_RECORD = 1 
                GROUP  BY FIN_PLAN.OBJECT_ID 
                          , TIPO_CUSTO.LOOKUP_CODE 
                          , RES_CLASS.RESOURCE_CLASS 
                          , TRANSCLASS.DESCRIPTION 
                UNION 
                SELECT PW.INVESTMENT_ID 
                       , PW.COST_TYPE 
                       , PW.RESOURCE_CLASS 
                       , TRANSCLASS.DESCRIPTION 
                       , 0 ORCADO 
                       , Sum(ISNULL(PV.TOTALCOST, 0)) 
                       , 0 COMPROMETIDO 
                       , 0 PROJETADO 
                FROM   NIKU.PPA_WIP PW 
                       JOIN NIKU.PPA_WIP_VALUES PV 
                         ON PW.TRANSNO = PV.TRANSNO 
                            AND PV.CURRENCY_TYPE = 'HOME' 
                       JOIN NIKU.TRANSCLASS TRANSCLASS 
                         ON TRANSCLASS.TRANSCLASS = PW.TRANSCLASS 
                            AND PW.STATUS = 0 
                GROUP  BY PW.INVESTMENT_ID 
                          , PW.COST_TYPE 
                          , PW.RESOURCE_CLASS 
                          , TRANSCLASS.DESCRIPTION)VAL 
        GROUP  BY INV_ID 
                  , COST_TYPE 
                  , RESOURCE_CLASS 
                  , TRANSCLASS) VALORES 
				  
       JOIN NIKU.INV_INVESTMENTS INVI 
         ON INVI.ID = VALORES.INV_ID 
       JOIN NIKU.ODF_CA_INV OCINV 
         ON INVI.ID = OCINV.ID 
       JOIN NIKU.PAC_MNT_PROJECTS PMPRJ 
         ON PMPRJ.ID = INVI.ID 
		 
WHERE  INVI.ODF_OBJECT_CODE = 'project' 
   AND OCINV.HM_DIR_EXECUTIVA = OCINV.HM_DIR_EXECUTIVA 
   AND OCINV.HM_AREA_TI = OCINV.HM_AREA_TI 
   AND PMPRJ.COST_TYPE = PMPRJ.COST_TYPE 
   AND INVI.CODE = INVI.CODE 
   AND OCINV.HM_SITUACAO = OCINV.HM_SITUACAO 
   AND OCINV.HM_CUST_EXT = OCINV.HM_CUST_EXT 
   AND VALORES.RESOURCE_CLASS = VALORES.RESOURCE_CLASS 
GROUP  BY VALORES.COST_TYPE 