Return-Path: <netdev+bounces-199180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B68CAADF4ED
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 19:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA1C4A34DB
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 17:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704DA307ACE;
	Wed, 18 Jun 2025 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="he7sLvRf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3886D307AC8
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268576; cv=none; b=R4xeFC88/PHZZsEl2WkKcbQ4wpJx6Lrgo/XlghhpAYjP+ZiGgneM30RN/+eg3VdhnxjK2w/TmEaVc79KOi5+2JuuJ8DFbahiBIWyxf9A6B9nNT1Oxw03RftQbsR+2O2HdahXt2qoiKKVtPF/0k9w9/PSIU67g+FsZegHqSnj+dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268576; c=relaxed/simple;
	bh=mSRmEn9cGad6rqzsOcvJp3ZzHkOEJeu37AWa3Bm0QbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1krbtWDmADS94hBwwzL3277BUGpVjwXCmg62VqMa5Q0ukydMSAAd6SAiFw74YYAlo3GUudKyV1kes33CNQrCOaDvJw4eJ634ofzepltWFRyVMKBXyMn98QGfgPJZ+ghFGaaJ29NheKDvcgC6kH12fFu3TqvRgrRTEGQVWZyyE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=he7sLvRf; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750268574; x=1781804574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mSRmEn9cGad6rqzsOcvJp3ZzHkOEJeu37AWa3Bm0QbA=;
  b=he7sLvRf/KeAf3pvRmkaLJJdz0rdahqRk491g2CNKYvo1fRDe3SCD9BR
   UradR+x01LpgIl2A+4ObYm5gE9531VbnatSDBloAwDng8IA0LfruPPigv
   yuBiCJDgsn3cZ4cTT2DOzZOEAbIvzqJiS0cBzGikOnGMGl747LJULBcuU
   fwDLq6KysS6w16bQuBwuu/dMmugEv0kkvcVoqUXGLFtE2GiJh6zwdOQ/N
   PDSjz4Ps+L15kRM8SHEMEWb1FfIyj8V0KMoWg/TUUruPXYr2reEVN6YRv
   0wAFXdkLf8FPBQ+HY0a/lyeTgPAhoOMlLoBtRjOSFLk/Tb5al7J/FICQy
   Q==;
X-CSE-ConnectionGUID: nyjjKmf2RPSc8D5OUNCxLQ==
X-CSE-MsgGUID: jJnOVWw3QXi2KjgpZR/9Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="56183737"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="56183737"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 10:42:50 -0700
X-CSE-ConnectionGUID: xfaeEVibTAqAFjdZ8J8RMw==
X-CSE-MsgGUID: qWfLQ8DRQbWhpWE1SZZFAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="149695965"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 18 Jun 2025 10:42:50 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	Milena Olech <milena.olech@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 10/15] ice: use bitfields instead of unions for CGU regs
Date: Wed, 18 Jun 2025 10:42:22 -0700
Message-ID: <20250618174231.3100231-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250618174231.3100231-1-anthony.l.nguyen@intel.com>
References: <20250618174231.3100231-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Switch from unions with bitfield structs to definitions with bitfield
masks. This is necessary, because some registers have different
field definitions or even use a different register for the same fields
based on HW type.

Remove unused register fields.

Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.h | 212 +++--------------
 drivers/net/ethernet/intel/ice/ice_tspll.c  | 238 ++++++++++----------
 2 files changed, 155 insertions(+), 295 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index ac8f1d90246f..6d117e0250f3 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -39,194 +39,46 @@
 #define FEC_RECEIVER_ID_PCS0 (0x33 << FEC_RECV_ID_SHIFT)
 #define FEC_RECEIVER_ID_PCS1 (0x34 << FEC_RECV_ID_SHIFT)
 
-#define ICE_CGU_R9 0x24
-union ice_cgu_r9 {
-	struct {
-		u32 time_ref_freq_sel : 3;
-		u32 clk_eref1_en : 1;
-		u32 clk_eref0_en : 1;
-		u32 time_ref_en : 1;
-		u32 time_sync_en : 1;
-		u32 one_pps_out_en : 1;
-		u32 clk_ref_synce_en : 1;
-		u32 clk_synce1_en : 1;
-		u32 clk_synce0_en : 1;
-		u32 net_clk_ref1_en : 1;
-		u32 net_clk_ref0_en : 1;
-		u32 clk_synce1_amp : 2;
-		u32 misc6 : 1;
-		u32 clk_synce0_amp : 2;
-		u32 one_pps_out_amp : 2;
-		u32 misc24 : 12;
-	};
-	u32 val;
-};
+#define ICE_CGU_R9			0x24
+#define ICE_CGU_R9_TIME_REF_FREQ_SEL	GENMASK(2, 0)
+#define ICE_CGU_R9_CLK_EREF0_EN		BIT(4)
+#define ICE_CGU_R9_TIME_REF_EN		BIT(5)
+#define ICE_CGU_R9_TIME_SYNC_EN		BIT(6)
+#define ICE_CGU_R9_ONE_PPS_OUT_EN	BIT(7)
+#define ICE_CGU_R9_ONE_PPS_OUT_AMP	GENMASK(19, 18)
 
-#define ICE_CGU_R16 0x40
-union ice_cgu_r16 {
-	struct {
-		u32 synce_remndr : 6;
-		u32 synce_phlmt_en : 1;
-		u32 misc13 : 17;
-		u32 ck_refclkfreq : 8;
-	};
-	u32 val;
-};
+#define ICE_CGU_R16			0x40
+#define ICE_CGU_R16_TSPLL_CK_REFCLKFREQ	GENMASK(31, 24)
 
-#define ICE_CGU_R19 0x4c
-union ice_cgu_r19_e82x {
-	struct {
-		u32 fbdiv_intgr : 8;
-		u32 fdpll_ulck_thr : 5;
-		u32 misc15 : 3;
-		u32 ndivratio : 4;
-		u32 tspll_iref_ndivratio : 3;
-		u32 misc19 : 1;
-		u32 japll_ndivratio : 4;
-		u32 japll_iref_ndivratio : 3;
-		u32 misc27 : 1;
-	};
-	u32 val;
-};
+#define ICE_CGU_R19			0x4C
+#define ICE_CGU_R19_TSPLL_FBDIV_INTGR_E82X	GENMASK(7, 0)
+#define ICE_CGU_R19_TSPLL_FBDIV_INTGR_E825	GENMASK(9, 0)
+#define ICE_CGU_R19_TSPLL_NDIVRATIO	GENMASK(19, 16)
 
-union ice_cgu_r19_e825 {
-	struct {
-		u32 tspll_fbdiv_intgr : 10;
-		u32 fdpll_ulck_thr : 5;
-		u32 misc15 : 1;
-		u32 tspll_ndivratio : 4;
-		u32 tspll_iref_ndivratio : 3;
-		u32 misc19 : 1;
-		u32 japll_ndivratio : 4;
-		u32 japll_postdiv_pdivratio : 3;
-		u32 misc27 : 1;
-	};
-	u32 val;
-};
+#define ICE_CGU_R22			0x58
+#define ICE_CGU_R22_TIME1588CLK_DIV	GENMASK(23, 20)
+#define ICE_CGU_R22_TIME1588CLK_DIV2	BIT(30)
 
-#define ICE_CGU_R22 0x58
-union ice_cgu_r22 {
-	struct {
-		u32 fdpll_frac_div_out_nc : 2;
-		u32 fdpll_lock_int_for : 1;
-		u32 synce_hdov_int_for : 1;
-		u32 synce_lock_int_for : 1;
-		u32 fdpll_phlead_slip_nc : 1;
-		u32 fdpll_acc1_ovfl_nc : 1;
-		u32 fdpll_acc2_ovfl_nc : 1;
-		u32 synce_status_nc : 6;
-		u32 fdpll_acc1f_ovfl : 1;
-		u32 misc18 : 1;
-		u32 fdpllclk_div : 4;
-		u32 time1588clk_div : 4;
-		u32 synceclk_div : 4;
-		u32 synceclk_sel_div2 : 1;
-		u32 fdpllclk_sel_div2 : 1;
-		u32 time1588clk_sel_div2 : 1;
-		u32 misc3 : 1;
-	};
-	u32 val;
-};
+#define ICE_CGU_R23			0x5C
+#define ICE_CGU_R24			0x60
+#define ICE_CGU_R24_FBDIV_FRAC		GENMASK(21, 0)
+#define ICE_CGU_R23_R24_TSPLL_ENABLE	BIT(24)
+#define ICE_CGU_R23_R24_REF1588_CK_DIV	GENMASK(30, 27)
+#define ICE_CGU_R23_R24_TIME_REF_SEL	BIT(31)
 
-#define ICE_CGU_R23 0x5C
-union ice_cgu_r23 {
-	struct {
-		u32 cgupll_fbdiv_intgr : 10;
-		u32 ux56pll_fbdiv_intgr : 10;
-		u32 misc20 : 4;
-		u32 ts_pll_enable : 1;
-		u32 time_sync_tspll_align_sel : 1;
-		u32 ext_synce_sel : 1;
-		u32 ref1588_ck_div : 4;
-		u32 time_ref_sel : 1;
+#define ICE_CGU_BW_TDC			0x31C
+#define ICE_CGU_BW_TDC_PLLLOCK_SEL	GENMASK(30, 29)
 
-	};
-	u32 val;
-};
+#define ICE_CGU_RO_LOCK			0x3F0
+#define ICE_CGU_RO_LOCK_TRUE_LOCK	BIT(12)
+#define ICE_CGU_RO_LOCK_UNLOCK		BIT(13)
 
-#define ICE_CGU_R24 0x60
-union ice_cgu_r24 {
-	struct {
-		u32 fbdiv_frac : 22;
-		u32 misc20 : 2;
-		u32 ts_pll_enable : 1;
-		u32 time_sync_tspll_align_sel : 1;
-		u32 ext_synce_sel : 1;
-		u32 ref1588_ck_div : 4;
-		u32 time_ref_sel : 1;
-	};
-	u32 val;
-};
+#define ICE_CGU_CNTR_BIST		0x344
+#define ICE_CGU_CNTR_BIST_PLLLOCK_SEL_0	BIT(15)
+#define ICE_CGU_CNTR_BIST_PLLLOCK_SEL_1	BIT(16)
 
-#define TSPLL_CNTR_BIST_SETTINGS 0x344
-union tspll_cntr_bist_settings {
-	struct {
-		u32 i_irefgen_settling_time_cntr_7_0 : 8;
-		u32 i_irefgen_settling_time_ro_standby_1_0 : 2;
-		u32 reserved195 : 5;
-		u32 i_plllock_sel_0 : 1;
-		u32 i_plllock_sel_1 : 1;
-		u32 i_plllock_cnt_6_0 : 7;
-		u32 i_plllock_cnt_10_7 : 4;
-		u32 reserved200 : 4;
-	};
-	u32 val;
-};
-
-#define TSPLL_RO_BWM_LF 0x370
-union tspll_ro_bwm_lf {
-	struct {
-		u32 bw_freqov_high_cri_7_0 : 8;
-		u32 bw_freqov_high_cri_9_8 : 2;
-		u32 biascaldone_cri : 1;
-		u32 plllock_gain_tran_cri : 1;
-		u32 plllock_true_lock_cri : 1;
-		u32 pllunlock_flag_cri : 1;
-		u32 afcerr_cri : 1;
-		u32 afcdone_cri : 1;
-		u32 feedfwrdgain_cal_cri_7_0 : 8;
-		u32 m2fbdivmod_cri_7_0 : 8;
-	};
-	u32 val;
-};
-
-#define TSPLL_RO_LOCK_E825C 0x3f0
-union tspll_ro_lock_e825c {
-	struct {
-		u32 bw_freqov_high_cri_7_0 : 8;
-		u32 bw_freqov_high_cri_9_8 : 2;
-		u32 reserved455 : 1;
-		u32 plllock_gain_tran_cri : 1;
-		u32 plllock_true_lock_cri : 1;
-		u32 pllunlock_flag_cri : 1;
-		u32 afcerr_cri : 1;
-		u32 afcdone_cri : 1;
-		u32 feedfwrdgain_cal_cri_7_0 : 8;
-		u32 reserved462 : 8;
-	};
-	u32 val;
-};
-
-#define TSPLL_BW_TDC_E825C 0x31c
-union tspll_bw_tdc_e825c {
-	struct {
-		u32 i_tdc_offset_lock_1_0 : 2;
-		u32 i_bbthresh1_2_0 : 3;
-		u32 i_bbthresh2_2_0 : 3;
-		u32 i_tdcsel_1_0 : 2;
-		u32 i_tdcovccorr_en_h : 1;
-		u32 i_divretimeren : 1;
-		u32 i_bw_ampmeas_window : 1;
-		u32 i_bw_lowerbound_2_0 : 3;
-		u32 i_bw_upperbound_2_0 : 3;
-		u32 i_bw_mode_1_0 : 2;
-		u32 i_ft_mode_sel_2_0 : 3;
-		u32 i_bwphase_4_0 : 5;
-		u32 i_plllock_sel_1_0 : 2;
-		u32 i_afc_divratio : 1;
-	};
-	u32 val;
-};
+#define ICE_CGU_RO_BWM_LF		0x370
+#define ICE_CGU_RO_BWM_LF_TRUE_LOCK	BIT(12)
 
 int ice_init_hw(struct ice_hw *hw);
 void ice_deinit_hw(struct ice_hw *hw);
diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index 743847258693..54f7b8a18a2f 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -127,11 +127,7 @@ static void ice_tspll_log_cfg(struct ice_hw *hw, bool enable, u8 clk_src,
 static int ice_tspll_cfg_e82x(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 			      enum ice_clk_src clk_src)
 {
-	union tspll_ro_bwm_lf bwm_lf;
-	union ice_cgu_r19_e82x dw19;
-	union ice_cgu_r22 dw22;
-	union ice_cgu_r24 dw24;
-	union ice_cgu_r9 dw9;
+	u32 val, r9, r24;
 
 	if (clk_freq >= NUM_ICE_TSPLL_FREQ) {
 		dev_warn(ice_hw_to_dev(hw), "Invalid TIME_REF frequency %u\n",
@@ -151,61 +147,74 @@ static int ice_tspll_cfg_e82x(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 		return -EINVAL;
 	}
 
-	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R9, &dw9.val);
-	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R24, &dw24.val);
-	ICE_READ_CGU_REG_OR_DIE(hw, TSPLL_RO_BWM_LF, &bwm_lf.val);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R9, &r9);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R24, &r24);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_RO_BWM_LF, &val);
 
-	ice_tspll_log_cfg(hw, dw24.ts_pll_enable, dw24.time_ref_sel,
-			  dw9.time_ref_freq_sel, bwm_lf.plllock_true_lock_cri,
+	ice_tspll_log_cfg(hw, !!FIELD_GET(ICE_CGU_R23_R24_TSPLL_ENABLE, r24),
+			  FIELD_GET(ICE_CGU_R23_R24_TIME_REF_SEL, r24),
+			  FIELD_GET(ICE_CGU_R9_TIME_REF_FREQ_SEL, r9),
+			  !!FIELD_GET(ICE_CGU_RO_BWM_LF_TRUE_LOCK, val),
 			  false);
 
 	/* Disable the PLL before changing the clock source or frequency */
-	if (dw24.ts_pll_enable) {
-		dw24.ts_pll_enable = 0;
-		ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R24, dw24.val);
+	if (FIELD_GET(ICE_CGU_R23_R24_TSPLL_ENABLE, r24)) {
+		r24 &= ~ICE_CGU_R23_R24_TSPLL_ENABLE;
+		ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R24, r24);
 	}
 
 	/* Set the frequency */
-	dw9.time_ref_freq_sel = clk_freq;
-	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R9, dw9.val);
+	r9 &= ~ICE_CGU_R9_TIME_REF_FREQ_SEL;
+	r9 |= FIELD_PREP(ICE_CGU_R9_TIME_REF_FREQ_SEL, clk_freq);
+	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R9, r9);
 
 	/* Configure the TSPLL feedback divisor */
-	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R19, &dw19.val);
-	dw19.fbdiv_intgr = e82x_tspll_params[clk_freq].feedback_div;
-	dw19.ndivratio = 1;
-	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R19, dw19.val);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R19, &val);
+	val &= ~(ICE_CGU_R19_TSPLL_FBDIV_INTGR_E82X | ICE_CGU_R19_TSPLL_NDIVRATIO);
+	val |= FIELD_PREP(ICE_CGU_R19_TSPLL_FBDIV_INTGR_E82X,
+			  e82x_tspll_params[clk_freq].feedback_div);
+	val |= FIELD_PREP(ICE_CGU_R19_TSPLL_NDIVRATIO, 1);
+	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R19, val);
 
 	/* Configure the TSPLL post divisor */
-	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R22, &dw22.val);
-	dw22.time1588clk_div = e82x_tspll_params[clk_freq].post_pll_div;
-	dw22.time1588clk_sel_div2 = 0;
-	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R22, dw22.val);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R22, &val);
+	val &= ~(ICE_CGU_R22_TIME1588CLK_DIV |
+		 ICE_CGU_R22_TIME1588CLK_DIV2);
+	val |= FIELD_PREP(ICE_CGU_R22_TIME1588CLK_DIV,
+			  e82x_tspll_params[clk_freq].post_pll_div);
+	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R22, val);
 
 	/* Configure the TSPLL pre divisor and clock source */
-	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R24, &dw24.val);
-	dw24.ref1588_ck_div = e82x_tspll_params[clk_freq].refclk_pre_div;
-	dw24.fbdiv_frac = e82x_tspll_params[clk_freq].frac_n_div;
-	dw24.time_ref_sel = clk_src;
-	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R24, dw24.val);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R24, &r24);
+	r24 &= ~(ICE_CGU_R23_R24_REF1588_CK_DIV | ICE_CGU_R24_FBDIV_FRAC |
+		 ICE_CGU_R23_R24_TIME_REF_SEL);
+	r24 |= FIELD_PREP(ICE_CGU_R23_R24_REF1588_CK_DIV,
+			  e82x_tspll_params[clk_freq].refclk_pre_div);
+	r24 |= FIELD_PREP(ICE_CGU_R24_FBDIV_FRAC,
+			  e82x_tspll_params[clk_freq].frac_n_div);
+	r24 |= FIELD_PREP(ICE_CGU_R23_R24_TIME_REF_SEL, clk_src);
+	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R24, r24);
 
 	/* Finally, enable the PLL */
-	dw24.ts_pll_enable = 1;
-	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R24, dw24.val);
+	r24 |= ICE_CGU_R23_R24_TSPLL_ENABLE;
+	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R24, r24);
 
 	/* Wait to verify if the PLL locks */
 	usleep_range(1000, 5000);
 
-	ICE_READ_CGU_REG_OR_DIE(hw, TSPLL_RO_BWM_LF, &bwm_lf.val);
-	if (!bwm_lf.plllock_true_lock_cri) {
-		dev_warn(ice_hw_to_dev(hw), "TSPLL failed to lock\n");
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_RO_BWM_LF, &val);
+	if (!(val & ICE_CGU_RO_BWM_LF_TRUE_LOCK)) {
+		dev_warn(ice_hw_to_dev(hw), "CGU PLL failed to lock\n");
 		return -EBUSY;
 	}
 
-	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R9, &dw9.val);
-	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R24, &dw24.val);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R9, &r9);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R24, &r24);
 
-	ice_tspll_log_cfg(hw, dw24.ts_pll_enable, dw24.time_ref_sel,
-			  dw9.time_ref_freq_sel, true, false);
+	ice_tspll_log_cfg(hw, !!FIELD_GET(ICE_CGU_R23_R24_TSPLL_ENABLE, r24),
+			  FIELD_GET(ICE_CGU_R23_R24_TIME_REF_SEL, r24),
+			  FIELD_GET(ICE_CGU_R9_TIME_REF_FREQ_SEL, r9),
+			  true, true);
 
 	return 0;
 }
@@ -221,14 +230,12 @@ static int ice_tspll_cfg_e82x(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
  */
 static int ice_tspll_dis_sticky_bits_e82x(struct ice_hw *hw)
 {
-	union tspll_cntr_bist_settings cntr_bist;
+	u32 val;
 
-	ICE_READ_CGU_REG_OR_DIE(hw, TSPLL_CNTR_BIST_SETTINGS, &cntr_bist.val);
-	/* Disable sticky lock detection so lock err reported is accurate */
-	cntr_bist.i_plllock_sel_0 = 0;
-	cntr_bist.i_plllock_sel_1 = 0;
-
-	return ice_write_cgu_reg(hw, TSPLL_CNTR_BIST_SETTINGS, cntr_bist.val);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_CNTR_BIST, &val);
+	val &= ~(ICE_CGU_CNTR_BIST_PLLLOCK_SEL_0 |
+		 ICE_CGU_CNTR_BIST_PLLLOCK_SEL_1);
+	return ice_write_cgu_reg(hw, ICE_CGU_CNTR_BIST, val);
 }
 
 /**
@@ -249,12 +256,7 @@ static int ice_tspll_dis_sticky_bits_e82x(struct ice_hw *hw)
 static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 			       enum ice_clk_src clk_src)
 {
-	union tspll_ro_lock_e825c ro_lock;
-	union ice_cgu_r19_e825 dw19;
-	union ice_cgu_r16 dw16;
-	union ice_cgu_r23 dw23;
-	union ice_cgu_r22 dw22;
-	union ice_cgu_r9 dw9;
+	u32 val, r9, r23;
 
 	if (clk_freq >= NUM_ICE_TSPLL_FREQ) {
 		dev_warn(ice_hw_to_dev(hw), "Invalid TIME_REF frequency %u\n",
@@ -273,84 +275,91 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 		return -EINVAL;
 	}
 
-	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R9, &dw9.val);
-	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R16, &dw16.val);
-	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R23, &dw23.val);
-	ICE_READ_CGU_REG_OR_DIE(hw, TSPLL_RO_LOCK_E825C, &ro_lock.val);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R9, &r9);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R23, &r23);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_RO_LOCK, &val);
 
-	ice_tspll_log_cfg(hw, dw23.ts_pll_enable, dw23.time_ref_sel,
-			  dw9.time_ref_freq_sel,
-			  ro_lock.plllock_true_lock_cri, false);
+	ice_tspll_log_cfg(hw, !!FIELD_GET(ICE_CGU_R23_R24_TSPLL_ENABLE, r23),
+			  FIELD_GET(ICE_CGU_R23_R24_TIME_REF_SEL, r23),
+			  FIELD_GET(ICE_CGU_R9_TIME_REF_FREQ_SEL, r9),
+			  !!FIELD_GET(ICE_CGU_RO_LOCK_TRUE_LOCK, val),
+			  false);
 
 	/* Disable the PLL before changing the clock source or frequency */
-	if (dw23.ts_pll_enable) {
-		dw23.ts_pll_enable = 0;
-		ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R23, dw23.val);
+	if (FIELD_GET(ICE_CGU_R23_R24_TSPLL_ENABLE, r23)) {
+		r23 &= ~ICE_CGU_R23_R24_TSPLL_ENABLE;
+		ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R23, r23);
 	}
 
-	if (dw9.time_sync_en) {
-		dw9.time_sync_en = 0;
-		ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R9, dw9.val);
+	if (FIELD_GET(ICE_CGU_R9_TIME_SYNC_EN, r9)) {
+		r9 &= ~ICE_CGU_R9_TIME_SYNC_EN;
+		ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R9, r9);
 	}
 
-	/* Set the frequency */
-	dw9.time_ref_freq_sel = clk_freq;
-
-	/* Enable the correct receiver */
-	if (clk_src == ICE_CLK_SRC_TCXO) {
-		dw9.time_ref_en = 0;
-		dw9.clk_eref0_en = 1;
-	} else {
-		dw9.time_ref_en = 1;
-		dw9.clk_eref0_en = 0;
-	}
-	dw9.time_sync_en = 1;
-	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R9, dw9.val);
+	/* Set the frequency and enable the correct receiver */
+	r9 &= ~(ICE_CGU_R9_TIME_REF_FREQ_SEL | ICE_CGU_R9_CLK_EREF0_EN |
+		ICE_CGU_R9_TIME_REF_EN);
+	r9 |= FIELD_PREP(ICE_CGU_R9_TIME_REF_FREQ_SEL, clk_freq);
+	if (clk_src == ICE_CLK_SRC_TCXO)
+		r9 |= ICE_CGU_R9_CLK_EREF0_EN;
+	else
+		r9 |= ICE_CGU_R9_TIME_REF_EN;
+	r9 |= ICE_CGU_R9_TIME_SYNC_EN;
+	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R9, r9);
 
 	/* Choose the referenced frequency */
-	dw16.ck_refclkfreq = ICE_TSPLL_CK_REFCLKFREQ_E825;
-	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R16, dw16.val);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R16, &val);
+	val &= ~ICE_CGU_R16_TSPLL_CK_REFCLKFREQ;
+	val |= FIELD_PREP(ICE_CGU_R16_TSPLL_CK_REFCLKFREQ,
+			  ICE_TSPLL_CK_REFCLKFREQ_E825);
+	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R16, val);
 
 	/* Configure the TSPLL feedback divisor */
-	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R19, &dw19.val);
-	dw19.tspll_fbdiv_intgr = ICE_TSPLL_FBDIV_INTGR_E825;
-	dw19.tspll_ndivratio = ICE_TSPLL_NDIVRATIO_E825;
-	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R19, dw19.val);
-
-	/* Configure the TSPLL post divisor */
-	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R22, &dw22.val);
-	/* These two are constant for E825C */
-	dw22.time1588clk_div = 5;
-	dw22.time1588clk_sel_div2 = 0;
-	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R22, dw22.val);
-
-	/* Configure the TSPLL pre divisor and clock source */
-	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R23, &dw23.val);
-	dw23.ref1588_ck_div = 0;
-	dw23.time_ref_sel = clk_src;
-	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R23, dw23.val);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R19, &val);
+	val &= ~(ICE_CGU_R19_TSPLL_FBDIV_INTGR_E825 |
+		 ICE_CGU_R19_TSPLL_NDIVRATIO);
+	val |= FIELD_PREP(ICE_CGU_R19_TSPLL_FBDIV_INTGR_E825,
+			  ICE_TSPLL_FBDIV_INTGR_E825);
+	val |= FIELD_PREP(ICE_CGU_R19_TSPLL_NDIVRATIO,
+			  ICE_TSPLL_NDIVRATIO_E825);
+	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R19, val);
+
+	/* Configure the TSPLL post divisor, these two are constant */
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R22, &val);
+	val &= ~(ICE_CGU_R22_TIME1588CLK_DIV |
+		 ICE_CGU_R22_TIME1588CLK_DIV2);
+	val |= FIELD_PREP(ICE_CGU_R22_TIME1588CLK_DIV, 5);
+	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R22, val);
+
+	/* Configure the TSPLL pre divisor (constant) and clock source */
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R23, &r23);
+	r23 &= ~(ICE_CGU_R23_R24_REF1588_CK_DIV | ICE_CGU_R23_R24_TIME_REF_SEL);
+	r23 |= FIELD_PREP(ICE_CGU_R23_R24_TIME_REF_SEL, clk_src);
+	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R23, r23);
 
 	/* Clear the R24 register. */
 	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R24, 0);
 
 	/* Finally, enable the PLL */
-	dw23.ts_pll_enable = 1;
-	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R23, dw23.val);
+	r23 |= ICE_CGU_R23_R24_TSPLL_ENABLE;
+	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R23, r23);
 
 	/* Wait to verify if the PLL locks */
 	usleep_range(1000, 5000);
 
-	ICE_READ_CGU_REG_OR_DIE(hw, TSPLL_RO_LOCK_E825C, &ro_lock.val);
-	if (!ro_lock.plllock_true_lock_cri) {
-		dev_warn(ice_hw_to_dev(hw), "TSPLL failed to lock\n");
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_RO_LOCK, &val);
+	if (!(val & ICE_CGU_RO_LOCK_TRUE_LOCK)) {
+		dev_warn(ice_hw_to_dev(hw), "CGU PLL failed to lock\n");
 		return -EBUSY;
 	}
 
-	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R9, &dw9.val);
-	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R23, &dw23.val);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R9, &r9);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R23, &r23);
 
-	ice_tspll_log_cfg(hw, dw23.ts_pll_enable, dw23.time_ref_sel,
-			  dw9.time_ref_freq_sel, true, true);
+	ice_tspll_log_cfg(hw, !!FIELD_GET(ICE_CGU_R23_R24_TSPLL_ENABLE, r23),
+			  FIELD_GET(ICE_CGU_R23_R24_TIME_REF_SEL, r23),
+			  FIELD_GET(ICE_CGU_R9_TIME_REF_FREQ_SEL, r9),
+			  true, true);
 
 	return 0;
 }
@@ -366,15 +375,13 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
  */
 static int ice_tspll_dis_sticky_bits_e825c(struct ice_hw *hw)
 {
-	union tspll_bw_tdc_e825c bw_tdc;
+	u32 val;
 
-	ICE_READ_CGU_REG_OR_DIE(hw, TSPLL_BW_TDC_E825C, &bw_tdc.val);
-	bw_tdc.i_plllock_sel_1_0 = 0;
-	return ice_write_cgu_reg(hw, TSPLL_BW_TDC_E825C, bw_tdc.val);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_BW_TDC, &val);
+	val &= ~ICE_CGU_BW_TDC_PLLLOCK_SEL;
+	return ice_write_cgu_reg(hw, ICE_CGU_BW_TDC, val);
 }
 
-#define ICE_ONE_PPS_OUT_AMP_MAX 3
-
 /**
  * ice_tspll_cfg_pps_out_e825c - Enable/disable 1PPS output and set amplitude
  * @hw: pointer to the HW struct
@@ -384,12 +391,13 @@ static int ice_tspll_dis_sticky_bits_e825c(struct ice_hw *hw)
  */
 int ice_tspll_cfg_pps_out_e825c(struct ice_hw *hw, bool enable)
 {
-	union ice_cgu_r9 r9;
+	u32 val;
 
-	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R9, &r9.val);
-	r9.one_pps_out_en = enable;
-	r9.one_pps_out_amp = enable * ICE_ONE_PPS_OUT_AMP_MAX;
-	return ice_write_cgu_reg(hw, ICE_CGU_R9, r9.val);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R9, &val);
+	val &= ~(ICE_CGU_R9_ONE_PPS_OUT_EN | ICE_CGU_R9_ONE_PPS_OUT_AMP);
+	val |= FIELD_PREP(ICE_CGU_R9_ONE_PPS_OUT_EN, enable) |
+	       ICE_CGU_R9_ONE_PPS_OUT_AMP;
+	return ice_write_cgu_reg(hw, ICE_CGU_R9, val);
 }
 
 /**
-- 
2.47.1


