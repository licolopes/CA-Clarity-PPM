SELECT DISTINCT TOP 1000 
    inv.CODE as 'ID da Demanda',
    inv.NAME as 'Nome da Demanda',
    meta.NAME as 'Hierarquia de Priorização',
    inv.CREATED_DATE as 'Data de Criação',
    ca_idea.beneficios as 'Benefícios Esperados',
    categoria.NAME as 'Categoria',
    CONVERT(VARCHAR(MAX),ca_idea.situacao_mot_solicit) as 'Contexto Atual',
    CONVERT(VARCHAR(MAX),ca_idea.situacao_adequada) as 'Descrição',
    ca_idea.hm_evid_chamado as 'Evidência do Chamado',
    ca_idea.nr_maximo_2 as 'Nr. Chamado',
    tipo.NAME as 'Tipo da Demanda',
    tipo2.NAME as 'Tipo - Comitê Executivo',
    area_sol.NAME as 'Área Solicitante',
    area_ti.NAME as 'Área TI',
    CONVERT(VARCHAR(MAX),ca_inv.hm_breve_resum) as 'Breve Resumo',
    ca_inv.hm_capex as 'CAPEX',
    curva_abc.NAME as 'Curva ABC',
    ca_inv.hm_cust_ext as 'Custos Externos',
    ca_inv.hm_cust_int as 'Custos Internos',
    ca_inv.hm_csto_tot as 'Custo Total',
    ca_inv.hm_data_solicitacao as 'Data de Solicitação',
    ca_inv.hm_dt_limite_implant as 'Data limite para Implantação',
    dem_prior.NAME as 'Demanda Priorizada',
    dir.FIRST_NAME + ' ' + dir.LAST_NAME as 'Diretor(a) Área Solcitante',
    dirExec.FIRST_NAME + ' ' + dirExec.LAST_NAME as 'Diretor(a) Executivo(a) Área Solicitante',
    diret.NAME AS 'Diretoria Executiva',
    divisao.NAME as 'Divisão',
    fase.NAME as 'Fase',
    gerDemanda.FIRST_NAME + ' ' + gerDemanda.LAST_NAME as 'Gerente da Demanda',
    gerExecProp.FIRST_NAME + ' ' + gerExecProp.LAST_NAME as 'Gerente Executivo Proponente',
    ca_inv.hm_graduacao_risco as 'Graduação do Risco',
    ca_inv.hm_id_plan_custo as 'ID Planilha Custo',
    ln.FIRST_NAME + ' ' + ln.LAST_NAME as 'Líder do Negócio',
    CONVERT(VARCHAR(MAX),ca_inv.hm_objetivos) as 'Objetivos',
    ca_inv.hm_ordem_pri_negocio as 'Ordem de Prioridade do Negócio',
    part_release.NAME as 'Participa do Release?',
    ca_inv.hm_payback as 'Payback (Meses)',
    ca_inv.hm_prz_esti_exec as 'Prazo Estimado de Execução',
    situacao.NAME as 'Situação',
    solic.FIRST_NAME + ' ' + solic.LAST_NAME as 'Solicitante',
    com_exec.NAME as 'Tipo - Comitê Executivo',
    ca_inv.hm_tir as 'TIR (%)',
    valor_dem.NAME as 'Valor da Demanda',
    ca_inv.hm_vpl as 'VPL',
    ca_inv.hm_opex as 'OPEX',
    CRIADOR.FIRST_NAME + ' ' + CRIADOR.LAST_NAME as 'Criado por'
    

  FROM [niku].[niku].[INV_INVESTMENTS] as inv
  INNER JOIN [niku].[niku].[ODF_CA_INV] as ca_inv on inv.ID = ca_inv.ID
  INNER JOIN [niku].[niku].[ODF_CA_IDEA] as ca_idea on inv.ID = ca_idea.id
  LEFT JOIN [niku].[niku].SRM_RESOURCES as dir on ca_inv.hm_diretoria = dir.ID AND dir.IS_ACTIVE=1
  LEFT JOIN [niku].[niku].cmn_sec_user_groups dirc2 ON dir.user_id=dirc2.user_id  
  LEFT JOIN [niku].[niku].cmn_sec_groups dirc3 ON dirc3.id=dirc2.group_id AND dirc3.group_code='hm_grp_diretoria' AND dir.PERSON_TYPE != 0    
  LEFT JOIN [niku].[niku].SRM_RESOURCES as dirExec on ca_inv.hm_dir_executiva = dirExec.ID AND dirExec.IS_ACTIVE=1
  LEFT JOIN [niku].[niku].cmn_sec_user_groups dirExecc2 ON dirExec.user_id=dirExecc2.user_id  
  LEFT JOIN [niku].[niku].cmn_sec_groups dirExecc3 ON dirExecc3.id=dirExecc2.group_id  AND dirExecc3.group_code='hm_grp_diretoria_executiva' AND dirExec.PERSON_TYPE != 0                             
  LEFT JOIN [niku].[niku].SRM_RESOURCES as gerDemanda on ca_inv.hm_gerente_demanda = gerDemanda.ID AND gerDemanda.IS_ACTIVE=1
  LEFT JOIN [niku].[niku].cmn_sec_user_groups gerDemandac2 ON gerDemanda.user_id=gerDemandac2.user_id  
  LEFT JOIN [niku].[niku].cmn_sec_groups gerDemandac3 ON gerDemandac3.id=gerDemandac2.group_id AND gerDemandac3.group_code='gerente_demanda' AND gerDemanda.PERSON_TYPE != 0                             
  LEFT JOIN [niku].[niku].SRM_RESOURCES as gerExecProp on ca_inv.hm_ger_exec_prop = gerExecProp.ID AND gerExecProp.IS_ACTIVE=1
  LEFT JOIN [niku].[niku].cmn_sec_user_groups gerExecPropc2 ON gerExecProp.user_id=gerExecPropc2.user_id  
  LEFT JOIN [niku].[niku].cmn_sec_groups gerExecPropc3 ON gerExecPropc3.id=gerExecPropc2.group_id AND gerExecPropc3.group_code='ger_executivos' AND gerExecProp.PERSON_TYPE != 0  
  LEFT JOIN [niku].[niku].SRM_RESOURCES as ln on ca_inv.hm_lider_negocio = ln.ID
  LEFT JOIN [niku].[niku].cmn_sec_user_groups lnc2 ON ln.user_id = lnc2.user_id  
  LEFT JOIN [niku].[niku].cmn_sec_groups lnc3 ON lnc2.group_id = lnc3.id AND lnc3.group_code='hm_grupo_lider_negocio' AND ln.PERSON_TYPE != 0    
  LEFT JOIN [niku].[niku].SRM_RESOURCES as solic on ca_inv.hm_solicitante = solic.ID
  LEFT JOIN [niku].[niku].CMN_LOOKUPS_V as meta on meta.LOOKUP_CODE = INV.GOAL_CODE AND meta.LANGUAGE_CODE = 'pt' and meta.LOOKUP_TYPE = 'INVESTMENT_GOAL_TYPE'
  LEFT JOIN [niku].[niku].CMN_LOOKUPS_V as categoria on categoria.LOOKUP_CODE = ca_idea.obj_request_category and categoria.LANGUAGE_CODE = 'pt' and categoria.LOOKUP_TYPE = 'OBJ_IDEA_PROJECT_CATEGORY'
  LEFT JOIN [niku].[niku].CMN_LOOKUPS_V as tipo on tipo.LOOKUP_CODE = ca_idea.obj_request_type AND tipo.LANGUAGE_CODE = 'pt' and tipo.LOOKUP_TYPE = 'OBJ_IDEA_PROJECT_TYPE'
  LEFT JOIN [niku].[niku].CMN_LOOKUPS_V as tipo2 on tipo2.LOOKUP_CODE = ca_idea.tipo_demanda AND tipo2.LANGUAGE_CODE = 'pt' and tipo2.LOOKUP_TYPE = 'TIPO_DEMANDA'
  LEFT JOIN [niku].[niku].CMN_LOOKUPS_V as area_sol on area_sol.LOOKUP_CODE = ca_inv.hm_area_solicitante AND area_sol.LANGUAGE_CODE = 'pt' and area_sol.LOOKUP_TYPE = 'AREAS'
  LEFT JOIN [niku].[niku].CMN_LOOKUPS_V as area_ti on area_ti.LOOKUP_CODE = ca_inv.hm_area_ti AND area_ti.LANGUAGE_CODE = 'pt' and area_ti.LOOKUP_TYPE = 'AREAS_TI'
  LEFT JOIN [niku].[niku].CMN_LOOKUPS_V as curva_abc on curva_abc.LOOKUP_CODE = ca_inv.hm_curva_abc AND curva_abc.LANGUAGE_CODE = 'pt' and curva_abc.LOOKUP_TYPE = 'HM_LKP_CURVA_ABC'
  LEFT JOIN [niku].[niku].CMN_LOOKUPS_V as dem_prior on dem_prior.id = ca_inv.hm_demanda_prio AND dem_prior.LANGUAGE_CODE = 'pt' and dem_prior.LOOKUP_TYPE = 'PAC_RPT_YESNO'
  LEFT JOIN [niku].[niku].CMN_LOOKUPS_V as divisao on divisao.LOOKUP_CODE = ca_inv.hm_divisao AND divisao.LANGUAGE_CODE = 'pt' and divisao.LOOKUP_TYPE = 'HM_LKP_DIVISAO'
  LEFT JOIN [niku].[niku].CMN_LOOKUPS_V as fase on fase.LOOKUP_CODE = ca_inv.hm_fase AND fase.LANGUAGE_CODE = 'pt' and fase.LOOKUP_TYPE = 'HM_FASE'
  LEFT JOIN [niku].[niku].CMN_LOOKUPS_V as part_release on part_release.id = ca_inv.hm_part_release AND part_release.LANGUAGE_CODE = 'pt' and part_release.LOOKUP_TYPE = 'PAC_RPT_YESNO'
  LEFT JOIN [niku].[niku].CMN_LOOKUPS_V as situacao on situacao.LOOKUP_CODE = ca_inv.hm_situacao AND situacao.LANGUAGE_CODE = 'pt' and situacao.LOOKUP_TYPE = 'HM_SITUACAO'
  LEFT JOIN [niku].[niku].CMN_LOOKUPS_V as valor_dem on valor_dem.LOOKUP_CODE = ca_inv.hm_valor_demand AND valor_dem.LANGUAGE_CODE = 'pt' and valor_dem.LOOKUP_TYPE = 'HM_LKP_VALOR_DEMANDA'
  LEFT JOIN [niku].[niku].CMN_LOOKUPS_V as com_exec on com_exec.LOOKUP_CODE = ca_inv.hm_tipo_comite_exec AND com_exec.LANGUAGE_CODE = 'pt' and com_exec.LOOKUP_TYPE = 'HM_TIPO_COMITE_EXECUTIVO'
  LEFT JOIN [niku].[niku].CMN_LOOKUPS_V as diret on diret.LOOKUP_CODE = ca_inv.hm_nome_diretoria AND diret.LANGUAGE_CODE = 'pt' and diret.LOOKUP_TYPE = 'HM_LKP_NOME_DIRETORIA'
  LEFT JOIN [niku].[niku].SRM_RESOURCES CRIADOR ON CRIADOR.USER_ID = inv.CREATED_BY
  
  Where inv.CODE = '[@IDdemanda]'
  
  