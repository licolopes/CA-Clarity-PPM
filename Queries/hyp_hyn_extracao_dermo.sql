SELECT DISTINCT 
   INV.CODE COD_PROJ
 , CONVERT(VARCHAR(10),INV.CREATED_DATE ,120) DATA_ABERTURA
 , GER_PROJ.FIRST_NAME + ' ' + GER_PROJ.LAST_NAME GER_PROJETO
 , INV.NAME NOME_PROJ
 , CATEG_PROD.NAME CATEGORIA
 , PORTARIA.NAME PORTARIA
 , TIPO_PROJ.NAME TIPO_PROJ
 , UNID_NEG.NAME UNID_NEG
 , STATUS.NAME STATUS
 , ETAPA.NAME ETAPA
 , LINHA.NAME LINHA_PRODUTO
  , CONVERT(VARCHAR(MAX),substring( ( SELECT ', '+UN2.NAME AS [text()]                      
   FROM niku.INV_INVESTMENTS INV2                      
   JOIN niku.ODF_MULTI_VALUED_LOOKUPS MLKP2 ON MLKP2.PK_ID = INV2.ID AND MLKP2.OBJECT = 'project' AND MLKP2.ATTRIBUTE = 'hm_area_aplicacao'                      
   JOIN niku.CMN_LOOKUPS_V UN2 ON MLKP2.VALUE = UN2.LOOKUP_CODE AND UN2.LANGUAGE_CODE = 'pt' AND UN2.LOOKUP_TYPE = 'HM_LKP_AREA_APLICA'                      
   WHERE INV2.CODE = INV.CODE FOR XML PATH ('') ),3,1000)) [AREA_APLICACAO]
   , CONVERT(VARCHAR(MAX),OINV.hm_pub_alvo) PUBLICO_ALVO
   , CONVERT(VARCHAR(MAX),OINV.hm_rac_projeto) RACIONAL_PROJETO
   , OINV.hm_ativos_rec ATIVOS_RECOMENDADOS
   , OINV.hm_ativos_n_rec ATIVOS_NAO_RECOMENDADOS
   , TEXTURA.NAME TEXTURA
   , FRAG_AROMA.NAME FRAGANCIA_AROMA
   , OINV.hm_outros_text TEXTURA_OUTROS
   , CONVERT(VARCHAR(MAX),OINV.hm_com_obs) ATIVOS_COMENTARIOS
   , OINV.hm_exc_rec EXCIPIENTES_RECOMENDADOS
   , OINV.hm_exc_n_rec EXCIPIENTES_NAO_RECOMENDADOS
   , CARAC_SENSO.NAME CARACTERISTICA_SENSORIAL
   , OINV.hm_outros_caract_sen OUTROS_CARACTERISTICA_SENSORIAL
   , COR.NAME EXCIPIENTES_COR
   , OINV.hm_outros_cor OUTROS_COR
   , CORPO_MATERIAL.NAME CORPO_MATERIAL
   , OINV.hm_outros_corpo_mat OUTROS_CORPO_MATERIAL
   , CORPO_ASPECTO.NAME CORPO_ASPECTO
   , OINV.hm_corpo_outros CORPO_ASPECTO_OUTROS
   , OINV.hm_cor_corpo COR_CORPO
   , CART_MATERIAL.NAME CARTUCHO_MATERIAL
   , OINV.hm_outros_cart_mat CARTUCHO_MATERUAL_OUTROS
   , CART_ASPECTO.NAME CARTUCHO_ASPECTO
   , OINV.hm_cartucho_outros CARTUCHO_ASPECTO_OUTROS
   , OINV.hm_qtd_cor_imp QUANTIDADE_CORES_IMPRESSAO
   , CONVERT(VARCHAR(MAX),OINV.hm_amos_grat_mkt) AMOSTRA_GRATIS
   , TAMPA_TIPO.NAME TAMPA_TIPO
   , OINV.hm_outros_tampa_tipo TAMPA_TIPO_OUTROS
   , TAMPA_ASPECTO.NAME TAMPA_ASPECTO
   , OINV.hm_tampa_outros TAMPA_ASPECTO_OUTROS
   , OINV.hm_cor_tampa TAMPA_COR
   , MKT_FCST_CUST.hm_apr APRESENTACAO
   , CONVERT(FLOAT,MKT_FCST_CUST.hm_un_1no) FORECAST_UNID_ANO_1
   , CONVERT(FLOAT,MKT_FCST_CUST.hm_un_2ano) FORECAST_UNID_ANO_2
   , CONVERT(FLOAT,MKT_FCST_CUST.hm_un_3ano) FORECAST_UNID_ANO_3
   , CONVERT(FLOAT,MKT_FCST_CUST.hm_un_4ano) FORECAST_UNID_ANO_4
   , CONVERT(FLOAT,MKT_FCST_CUST.hm_un_5ano) FORECAST_UNID_ANO_5
   , CONVERT(FLOAT,MKT_FCST_CUST.hm_1ano) FORECAST_VALOR_ANO_1
   , CONVERT(FLOAT,MKT_FCST_CUST.hm_2ano) FORECAST_VALOR_ANO_2
   , CONVERT(FLOAT,MKT_FCST_CUST.hm_3ano) FORECAST_VALOR_ANO_3
   , CONVERT(FLOAT,MKT_FCST_CUST.hm_4ano) FORECAST_VALOR_ANO_4
   , CONVERT(FLOAT,MKT_FCST_CUST.hm_5ano) FORECAST_VALOR_ANO_5
   , CONVERT(FLOAT,MKT_FCST_CUST.hm_mat_emb) TARGET_MATERIAL_EMBALAGEM
   , CONVERT(FLOAT,MKT_FCST_CUST.hm_mat_pr) TARGET_MATERIA_PRIMA
   , CONVERT(FLOAT,MKT_FCST_CUST.hm_prod) TARGET_PRODUCAO
   , MKT_FCST_CUST.hm_desc_pratic DESCONTO_PRATICADO
   , MKT_FCST_CUST.hm_pf PF
   , CONVERT(VARCHAR(MAX),OINV.hm_est_seg_inst) SEGURANCA_INSTITUTO
   , CONVERT(FLOAT,OINV.hm_pub_inf + OINV.hm_gest + OINV.hm_pel_sen + OINV.hm_pub_esp + OINV.hm_avl_oft + OINV.hm_sens_de + OINV.hm_fot_der + OINV.hm_com_pat + OINV.hm_com_uso + OINV.hm_acne_us + OINV.hm_tol_ocu + OINV.hm_qst_seg + OINV.hm_sen_des + OINV.hm_out_ace + OINV.hm_otr_est) SEGURANCA_ORCAMENTO
   , CONVERT(FLOAT,OINV.est_seg_ad) SEGURANCA_GASTOS_ADICIONAIS
   , CONVERT(VARCHAR(MAX),OINV.hm_est_efic_inst) EFICACIA_INSTITUTO
   , CONVERT(FLOAT,OINV.hm_scren + OINV.hm_fotoest + OINV.hm_fps_vit + OINV.hm_fps_pro + OINV.hm_fps_sec + OINV.hm_fps_res + OINV.hm_uva_ppd + OINV.hm_uva_coc + OINV.hm_luz_vis + OINV.hm_inf_ver + OINV.hm_corn_tpo + OINV.hm_tewl + OINV.hm_ph_tpo + OINV.hm_seb_tpo + OINV.hm_cut_tpo + OINV.hm_outros) EFICACIA_ORCAMENTO
   , CONVERT(FLOAT,OINV.est_efi_ad) EFICACIA_GASTOS_ADICIONAIS
   , CONVERT(VARCHAR(MAX),OINV.hm_est_invitro_inst) INVITRO_INSTITUTO
   , CONVERT(FLOAT,OINV.est_inv_orc) INVITRO_ORCAMENTO
   , CONVERT(FLOAT,OINV.est_inv_ad) INVITRO_GASTOS_ADICIONAIS
   , CONVERT(FLOAT,ISNULL(OINV.est_inv_orc,0) + ISNULL(OINV.est_efi_ad,0) + ISNULL(OINV.est_seg_ad,0) 
							+ ISNULL(OINV.est_inv_ad,0) + ISNULL(OINV.hm_pub_inf,0) + ISNULL(OINV.hm_gest,0) + ISNULL(OINV.hm_pel_sen,0) 
							+ ISNULL(OINV.hm_pub_esp,0) + ISNULL(OINV.hm_avl_oft,0) + ISNULL(OINV.hm_sens_de,0) + ISNULL(OINV.hm_fot_der,0) 
							+ ISNULL(OINV.hm_com_pat,0) + ISNULL(OINV.hm_com_uso,0) + ISNULL(OINV.hm_acne_us,0) + ISNULL(OINV.hm_tol_ocu,0) 
							+ ISNULL(OINV.hm_qst_seg,0) + ISNULL(OINV.hm_sen_des,0) + ISNULL(OINV.hm_out_ace,0) + ISNULL(OINV.hm_otr_est,0) 
							+ ISNULL(OINV.hm_scren,0) + ISNULL(OINV.hm_fotoest,0) + ISNULL(OINV.hm_fps_vit,0) + ISNULL(OINV.hm_fps_pro,0) 
							+ ISNULL(OINV.hm_fps_sec,0) + ISNULL(OINV.hm_fps_res,0) + ISNULL(OINV.hm_uva_ppd,0) + ISNULL(OINV.hm_uva_coc,0) 
							+ ISNULL(OINV.hm_luz_vis,0) + ISNULL(OINV.hm_inf_ver,0) + ISNULL(OINV.hm_corn_tpo,0) + ISNULL(OINV.hm_tewl,0) 
							+ ISNULL(OINV.hm_ph_tpo,0) + ISNULL(OINV.hm_seb_tpo,0) + ISNULL(OINV.hm_cut_tpo,0) + ISNULL(OINV.hm_outros,0)) GASTO_TOTAL_AREA
   , TIPO_PETICAO_ANVISA.NAME TIPO_PETICAO_ANVISA
   , CLASSIFICACAO.NAME CLASSIFICACAO
   , CONVERT(FLOAT,OINV.hm_tax_not) TAXA_NOTIFICACAO
   , CONVERT(FLOAT,OINV.hm_tax_reg) TAXA_REGISTRO
   , CATEG_PROD.NAME CATEGORIA
   , CONVERT(FLOAT,OINV.hm_tst_bca) TESTE_BANCADA_PROTOTIPO
   , CONVERT(FLOAT,OINV.hm_lote_p) LOTE_PILOTO
   , CONVERT(FLOAT,OINV.hm_est_com) ESTABILIDADE_COMPATIBILIDADE
   , CONVERT(FLOAT,OINV.hm_prod_c) COMPRA_PRODUTOS_CONCORRENTES
   , CONVERT(FLOAT,OINV.hm_ret_pro) RETIRADA_PRODUTOS_LINHA
   , CONVERT(FLOAT,OINV.hm_outros_v) OUTROS_VALORES
   , CONVERT(FLOAT,ISNULL(hm_tst_bca,0) + ISNULL(OINV.hm_lote_p,0) + ISNULL(OINV.hm_est_com,0) + ISNULL(OINV.hm_prod_c,0) 
										+ ISNULL(OINV.hm_ret_pro,0) + ISNULL(OINV.hm_outros_v,0)) GASTOS_PROJETO_PD
   , CONVERT(VARCHAR(MAX),OINV.hm_com_ger_des_dermo) COMENTARIOS_DESENV_PRODUTO
   , OINV.hm_cod_model CODIGO_MODELO
   , OINV.hm_fornecedor_sc FORNECEDOR
   , OINV.hm_estrutura ESTRUTURA
   , OINV.hm_capacidade CAPACIDADE
   , OINV.hm_maq_env MAQUINA_ENVASE
   , OINV.hm_molde_ex MOLDE_EXCLUSIVO
   , OINV.hm_comp_em COMPATIBILIDADE
   , CONVERT(VARCHAR(MAX),OINV.hm_obs_desenv_emb) OBSERVACOES_DESENV_EMBALAGEM
   
   --INFORMAÇÕES DE LANÇAMENTO
 , INV.NAME NOME_PROJ
 , OINV.hm_marca_prod MARCA
 , CONVERT(FLOAT,MKT_LANC.hm_mes1 + MKT_LANC.hm_mes2 + MKT_LANC.hm_mes3 + MKT_LANC.hm_mes4 + MKT_LANC.hm_mes5 + MKT_LANC.hm_mes6 +
   MKT_LANC.hm_mes7 + MKT_LANC.hm_mes8 + MKT_LANC.hm_mes9 + MKT_LANC.hm_mes10 + MKT_LANC.hm_mes11 + MKT_LANC.hm_mes12) FORECAST_UNID_ANO_1
 , CONVERT(FLOAT,MKT_LANC.hm_ano2) FORECAST_UNID_ANO_2
 , CONVERT(FLOAT,MKT_LANC.hm_ano3) FORECAST_UNID_ANO_3
 , CONVERT(FLOAT,MKT_LANC.hm_ano4) FORECAST_UNID_ANO_4
 , CONVERT(FLOAT,MKT_LANC.hm_ano5) FORECAST_UNID_ANO_5
 , CONVERT(FLOAT,MKT_LANC.hm_pco_fab) PRECO_FAB
 , CONVERT(FLOAT,MKT_LANC.hm_desc) DESCONTO
 
 --INFORMAÇÕES DE CANCELAMENTO
 , CANCEL_PROJ.NAME CANCELAR_PROJETO
 , CONVERT(VARCHAR(10),ODFPROJ.data_cancelamento ,120) DATA_CANCEL
 , CONVERT(VARCHAR(MAX),OINV.hm_motiv_cancel) MOTIVO_CANCEL 

FROM NIKU.INV_INVESTMENTS INV
	INNER JOIN NIKU.ODF_CA_INV OINV ON OINV.ID = INV.ID
	INNER JOIN NIKU.ODF_CA_PROJECT ODFPROJ ON ODFPROJ.ID = INV.ID       
	INNER JOIN NIKU.INV_PROJECTS IPRJ ON INV.ID = IPRJ.PRID   
	LEFT JOIN NIKU.ODF_MULTI_VALUED_LOOKUPS MUL ON INV.ID = MUL.PK_ID AND MUL.OBJECT = 'PROJECT' AND MUL.ATTRIBUTE = 'HM_UNID_NE'
	LEFT JOIN NIKU.CMN_LOOKUPS_V CATEG_PROD ON CATEG_PROD.LOOKUP_CODE = OINV.HM_CATEG_PROD AND CATEG_PROD.LOOKUP_TYPE = 'HM_CATEG_PROD' AND CATEG_PROD.LANGUAGE_CODE = 'PT'
	LEFT JOIN NIKU.CMN_LOOKUPS_V UNID_NEG ON UNID_NEG.LOOKUP_CODE = MUL.VALUE AND UNID_NEG.LOOKUP_TYPE = 'HM_LKP_UNID_NEG'AND UNID_NEG.LANGUAGE_CODE = 'pt'
	LEFT JOIN NIKU.CMN_LOOKUPS_V ETAPA ON ETAPA.LOOKUP_CODE = OINV.HM_ETAP_PROJ AND ETAPA.LOOKUP_TYPE = 'HM_LKP_ETAP_PROJ' AND ETAPA.LANGUAGE_CODE = 'PT'
	LEFT JOIN NIKU.CMN_LOOKUPS_V STATUS ON STATUS.LOOKUP_CODE = OINV.HM_STATUS_PROJ AND STATUS.LOOKUP_TYPE = 'HM_STATUS' AND STATUS.LANGUAGE_CODE = 'PT'
	LEFT JOIN NIKU.CMN_LOOKUPS_V TIPO_PROJ ON TIPO_PROJ.LOOKUP_CODE = OINV.HM_TIPO_PROJETO AND TIPO_PROJ.LOOKUP_TYPE = 'HM_LKP_TIPO_PROJ' AND TIPO_PROJ.LANGUAGE_CODE = 'PT'
	LEFT JOIN NIKU.CMN_LOOKUPS_V PORTARIA ON PORTARIA.ID = OINV.PORTARIA_344 AND PORTARIA.LOOKUP_TYPE = 'PAC_RPT_YESNO' AND PORTARIA.LANGUAGE_CODE = 'PT'
	LEFT JOIN NIKU.SRM_RESOURCES GER_PROJ ON GER_PROJ.USER_ID = INV.MANAGER_ID
	LEFT JOIN NIKU.CMN_LOOKUPS_V LINHA ON LINHA.LOOKUP_CODE = OINV.hm_linha_skin AND LINHA.LANGUAGE_CODE = 'pt' AND LINHA.LOOKUP_TYPE = 'HM_LKP_LINHA_SKIN'
	LEFT JOIN NIKU.CMN_LOOKUPS_V TEXTURA ON TEXTURA.LOOKUP_CODE = OINV.hm_textura AND TEXTURA.LANGUAGE_CODE = 'pt' AND TEXTURA.LOOKUP_TYPE = 'HM_LKP_TEXTURA'
	LEFT JOIN NIKU.CMN_LOOKUPS_V FRAG_AROMA ON FRAG_AROMA.LOOKUP_CODE = OINV.hm_frag_aroma AND FRAG_AROMA.LANGUAGE_CODE = 'pt' AND FRAG_AROMA.LOOKUP_TYPE = 'HM_LKP_FRAG_AROMA'
	LEFT JOIN NIKU.CMN_LOOKUPS_V CARAC_SENSO ON CARAC_SENSO.LOOKUP_CODE = OINV.hm_carac_sens AND CARAC_SENSO.LANGUAGE_CODE = 'pt' AND CARAC_SENSO.LOOKUP_TYPE = 'HM_LKP_CARAC_SENS'
	LEFT JOIN NIKU.CMN_LOOKUPS_V COR ON COR.LOOKUP_CODE = OINV.hm_cor AND COR.LANGUAGE_CODE = 'pt' AND COR.LOOKUP_TYPE = 'HM_LKP_COR'
	LEFT JOIN NIKU.CMN_LOOKUPS_V CORPO_MATERIAL ON CORPO_MATERIAL.LOOKUP_CODE = OINV.hm_corpo_mat AND CORPO_MATERIAL.LANGUAGE_CODE = 'pt' AND CORPO_MATERIAL.LOOKUP_TYPE = 'HM_LKP_CORPO_MAT'
	LEFT JOIN NIKU.CMN_LOOKUPS_V CORPO_ASPECTO ON CORPO_ASPECTO.LOOKUP_CODE = OINV.hm_corpo_asp AND CORPO_ASPECTO.LANGUAGE_CODE = 'pt' AND CORPO_ASPECTO.LOOKUP_TYPE = 'HM_LKP_CORPO_ASP'
	LEFT JOIN NIKU.CMN_LOOKUPS_V CART_MATERIAL ON CART_MATERIAL.LOOKUP_CODE = OINV.hm_cart_mat AND CART_MATERIAL.LANGUAGE_CODE = 'pt' AND CART_MATERIAL.LOOKUP_TYPE = 'HM_LKP_CART_MAT'
	LEFT JOIN NIKU.CMN_LOOKUPS_V CART_ASPECTO ON CART_ASPECTO.LOOKUP_CODE = OINV.hm_cart_asp AND CART_ASPECTO.LANGUAGE_CODE = 'pt' AND CART_ASPECTO.LOOKUP_TYPE = 'HM_LKP_CART_ASP'
	LEFT JOIN NIKU.CMN_LOOKUPS_V TAMPA_TIPO ON TAMPA_TIPO.LOOKUP_CODE = OINV.hm_tampa_tipo AND TAMPA_TIPO.LANGUAGE_CODE = 'pt' AND TAMPA_TIPO.LOOKUP_TYPE = 'HM_LKP_TAMP_TIPO'
	LEFT JOIN NIKU.CMN_LOOKUPS_V TAMPA_ASPECTO ON TAMPA_ASPECTO.LOOKUP_CODE = OINV.hm_tampa_asp AND TAMPA_ASPECTO.LANGUAGE_CODE = 'pt' AND TAMPA_ASPECTO.LOOKUP_TYPE = 'HM_LKP_TAMP_ASP'
	LEFT JOIN NIKU.ODF_CA_HM_SUBOBJ_MKT_CT MKT_FCST_CUST ON MKT_FCST_CUST.ODF_PARENT_ID = INV.ID
	LEFT JOIN NIKU.CMN_LOOKUPS_V TIPO_PETICAO_ANVISA ON TIPO_PETICAO_ANVISA.LOOKUP_CODE = OINV.hm_tipo_pet_anvisa AND TIPO_PETICAO_ANVISA.LANGUAGE_CODE = 'pt' AND TIPO_PETICAO_ANVISA.LOOKUP_TYPE = 'HM_LKP_TIPO_PET_ANVISA'
	LEFT JOIN NIKU.CMN_LOOKUPS_V CLASSIFICACAO ON CLASSIFICACAO.LOOKUP_CODE = OINV.hm_clas AND CLASSIFICACAO.LANGUAGE_CODE = 'pt' AND CLASSIFICACAO.LOOKUP_TYPE = 'HM_LKP_CLAS'
	FULL OUTER JOIN NIKU.ODF_CA_hm_subobj_apr_lan MKT_LANC ON MKT_LANC.ODF_PARENT_ID = INV.ID AND MKT_FCST_CUST.hm_apr = MKT_LANC.hm_apr_marca
	LEFT JOIN NIKU.CMN_LOOKUPS_V CANCEL_PROJ ON CANCEL_PROJ.ID = OINV.hm_cancel_project AND CANCEL_PROJ.LOOKUP_TYPE = 'PAC_RPT_YESNO' AND CANCEL_PROJ.LANGUAGE_CODE = 'pt'

WHERE 
	ODFPROJ.PARTITION_CODE = 'hm_inovaprod'
	AND OINV.HM_CATEG_PROD IN ('dermo','alimento_funcional','cosmetico','nutraceutico')
	
ORDER BY 
	INV.CODE ASC