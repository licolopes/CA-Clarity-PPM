SELECT 'TOP' CLASS
	,CASE 
		WHEN idl.DAYS_LATE_PCT < 1
			THEN 'GREEN'
		WHEN idl.DAYS_LATE_PCT < 11
			THEN 'YELLOW'
		WHEN idl.DAYS_LATE_PCT >= 11
			THEN 'RED'
		ELSE 'GRAY'
		END STATUS
	,COUNT(INVI.ID) QTD
FROM INV_INVESTMENTS INVI
JOIN ODF_CA_INV OCINV ON INVI.ID = OCINV.ID
JOIN INV_PROJECTS INVP ON INVI.ID = INVP.PRID
JOIN cop_inv_days_late_v idl ON idl.investment_id = INVI.id
WHERE INVI.IS_ACTIVE = 1
	AND INVP.IS_TEMPLATE = 0
	AND INVI.ID IN (
		SELECT TOP.ID TOP_ID
		FROM (
			SELECT INVITOP.ID ID
				,(
					NVL((san_pri_mkt_size_mat * 2), 0) + NVL(san_pri_mkt_cagr_5y, 0) + NVL(san_pri_mkt_pst_mat, 0) + NVL(san_pri_gen_mkt_mat, 0) + NVL((san_pri_gen_mol_mat * 2), 0) + NVL(san_pri_comp_scen, 0) + NVL(san_pri_presc_frag, 0) + NVL((san_pri_unmet_med * 2), 0) + NVL((san_pri_strg_relev * 3), 0) + NVL(san_pri_prd_adv_vlue, 0) + NVL(san_pri_lvrg_core_co, 0) + NVL((san_pri_valid_mkt_re * 2), 0) + NVL(san_pri_prc_access, 0) + NVL((san_pri_clin_efficac * 2), 0) + NVL((san_pri_clin_quality * 2), 0) + NVL(san_pri_clin_safety, 0) + NVL((san_pri_kol_rx_cons * 2), 0) + NVL(san_pri_liter_qualit, 0) + NVL(san_pri_reg_feasi_do, 0) + NVL(san_pri_prd_dev_doc, 0) + NVL(san_pri_prd_dev_api, 0) + NVL(san_pri_manuf_equip, 0) + NVL(san_pri_prd_mat_ava, 0) + NVL(san_pri_src_raw_pkg, 0) + NVL((san_pri_est_lch_time * 2), 0) + NVL((san_pri_net_sales * 2
							), 0) + NVL(san_pri_gross_margin, 0) + NVL(san_pri_payback, 0) + NVL(san_pri_boi_y3, 0) + NVL((san_pri_npv_5y * 2), 0) + NVL(san_pri_inv_for_dev, 0)
					) SCORE
			FROM INV_INVESTMENTS INVITOP
			JOIN INV_PROJECTS INVPTOP ON INVITOP.ID = INVPTOP.PRID
			JOIN ODF_CA_INV OCINVTOP ON INVITOP.ID = OCINVTOP.ID
			WHERE INVITOP.IS_ACTIVE = 1
				AND INVPTOP.IS_TEMPLATE = 0
			ORDER BY SCORE DESC
			) TOP
		WHERE ROWNUM <= 3
		)
GROUP BY CASE 
		WHEN idl.DAYS_LATE_PCT < 1
			THEN 'GREEN'
		WHEN idl.DAYS_LATE_PCT < 11
			THEN 'YELLOW'
		WHEN idl.DAYS_LATE_PCT >= 11
			THEN 'RED'
		ELSE 'GRAY'
		END

UNION

SELECT 'OTHER' CLASS
	,CASE 
		WHEN idl.DAYS_LATE_PCT < 1
			THEN 'GREEN'
		WHEN idl.DAYS_LATE_PCT < 11
			THEN 'YELLOW'
		WHEN idl.DAYS_LATE_PCT >= 11
			THEN 'RED'
		ELSE 'GRAY'
		END
	,COUNT(INVI.ID) QTD
FROM INV_INVESTMENTS INVI
JOIN ODF_CA_INV OCINV ON INVI.ID = OCINV.ID
JOIN INV_PROJECTS INVP ON INVI.ID = INVP.PRID
JOIN cop_inv_days_late_v idl ON idl.investment_id = INVI.id
WHERE INVI.IS_ACTIVE = 1
	AND INVP.IS_TEMPLATE = 0
	AND INVI.ID NOT IN (
		SELECT TOP.ID TOP_ID
		FROM (
			SELECT INVITOP.ID ID
				,(
					NVL((san_pri_mkt_size_mat * 2), 0) + NVL(san_pri_mkt_cagr_5y, 0) + NVL(san_pri_mkt_pst_mat, 0) + NVL(san_pri_gen_mkt_mat, 0) + NVL((san_pri_gen_mol_mat * 2), 0) + NVL(san_pri_comp_scen, 0) + NVL(san_pri_presc_frag, 0) + NVL((san_pri_unmet_med * 2), 0) + NVL((san_pri_strg_relev * 3), 0) + NVL(san_pri_prd_adv_vlue, 0) + NVL(san_pri_lvrg_core_co, 0) + NVL((san_pri_valid_mkt_re * 2), 0) + NVL(san_pri_prc_access, 0) + NVL((san_pri_clin_efficac * 2), 0) + NVL((san_pri_clin_quality * 2), 0) + NVL(san_pri_clin_safety, 0) + NVL((san_pri_kol_rx_cons * 2), 0) + NVL(san_pri_liter_qualit, 0) + NVL(san_pri_reg_feasi_do, 0) + NVL(san_pri_prd_dev_doc, 0) + NVL(san_pri_prd_dev_api, 0) + NVL(san_pri_manuf_equip, 0) + NVL(san_pri_prd_mat_ava, 0) + NVL(san_pri_src_raw_pkg, 0) + NVL((san_pri_est_lch_time * 2), 0) + NVL((san_pri_net_sales * 2
							), 0) + NVL(san_pri_gross_margin, 0) + NVL(san_pri_payback, 0) + NVL(san_pri_boi_y3, 0) + NVL((san_pri_npv_5y * 2), 0) + NVL(san_pri_inv_for_dev, 0)
					) SCORE
			FROM INV_INVESTMENTS INVITOP
			JOIN INV_PROJECTS INVPTOP ON INVITOP.ID = INVPTOP.PRID
			JOIN ODF_CA_INV OCINVTOP ON INVITOP.ID = OCINVTOP.ID
			WHERE INVITOP.IS_ACTIVE = 1
				AND INVPTOP.IS_TEMPLATE = 0
			ORDER BY SCORE DESC
			) TOP
		WHERE ROWNUM <= 3
		)
GROUP BY CASE 
		WHEN idl.DAYS_LATE_PCT < 1
			THEN 'GREEN'
		WHEN idl.DAYS_LATE_PCT < 11
			THEN 'YELLOW'
		WHEN idl.DAYS_LATE_PCT >= 11
			THEN 'RED'
		ELSE 'GRAY'
		END

UNION

SELECT 'TOTAL' CLASS
	,CASE 
		WHEN idl.DAYS_LATE_PCT < 1
			THEN 'GREEN'
		WHEN idl.DAYS_LATE_PCT < 11
			THEN 'YELLOW'
		WHEN idl.DAYS_LATE_PCT >= 11
			THEN 'RED'
		ELSE 'GRAY'
		END
	,COUNT(INVI.ID) QTD
FROM INV_INVESTMENTS INVI
JOIN ODF_CA_INV OCINV ON INVI.ID = OCINV.ID
JOIN INV_PROJECTS INVP ON INVI.ID = INVP.PRID
JOIN cop_inv_days_late_v idl ON idl.investment_id = INVI.id
WHERE INVI.IS_ACTIVE = 1
	AND INVP.IS_TEMPLATE = 0
GROUP BY CASE 
		WHEN idl.DAYS_LATE_PCT < 1
			THEN 'GREEN'
		WHEN idl.DAYS_LATE_PCT < 11
			THEN 'YELLOW'
		WHEN idl.DAYS_LATE_PCT >= 11
			THEN 'RED'
		ELSE 'GRAY'
		END