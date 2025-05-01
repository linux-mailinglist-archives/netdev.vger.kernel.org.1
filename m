Return-Path: <netdev+bounces-187319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F7FAA6672
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 00:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36F21BC6C65
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 22:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB927262D1D;
	Thu,  1 May 2025 22:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="az+nCIfx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA25A2528F7
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 22:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140075; cv=none; b=USxABCWwRjme7E7FhgN07qc7kvtINGgeO8WxC51I2dn/UicEv3biMPBbKT4p3f0dgrKudtNIDIbMefoDjw8uSE6pwxHKKc0z6kK0Ejakk/JM+gS+F75wrLNjvvsugoZQENwXrvRxPiF5dfoV28ekKPG46MzdwGuDxkBhurDPz0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140075; c=relaxed/simple;
	bh=jkS+DDheFbpSHA0HbN+u1Re/rNfcV2cf0+ng81UCAgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RBCFmEHBlYO3G4fwuHHiBmbAaE2Uf9gMAcoScbvAnb5QUge2l9baaVEGGbz6dfLoIzRSTr2dIIUlLIHnKtl7G3qLT67z7RCAF3Dp9L5sQ89PTO6LDJrNHvgJIdugnki7zmZi/fD74h7yBJc9TsxLiBfDAmNy0qWU2NsaTTTAb/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=az+nCIfx; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746140074; x=1777676074;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=jkS+DDheFbpSHA0HbN+u1Re/rNfcV2cf0+ng81UCAgg=;
  b=az+nCIfxxz5PnaMYWxkV6uR4f5l1ylmq9mi8pXRkv4Ul5zS/ufX+rf33
   Y6BbKSYfFgEPMq6tXX1ooIYGoRvBrPxeyTBig8nhzBXegzMKoh2L4Gcys
   3T+PysADUS5ZAZmbh2mNbfu6c5Y+hTwG8D2/O0ZVtp1UU5Tshl+Ss0CoA
   lHTknqi6ZjnGf5MuXP2CoeR5Z9u7lTHV6Vqy4YEHJTORYv8kfxP1OGjiy
   O9rOUAKfGvv/6K7aO90E9UDt8GRfmEO8KgHrAavG63Wjj9AEdrMvufzeI
   dJuP60vuoK0/GhtuM1En8NVSCYYvMS3VRr8hUZYjRjEaO2j+2jz62buau
   g==;
X-CSE-ConnectionGUID: TiXFRaqdR06/ueb52c+xng==
X-CSE-MsgGUID: YI6ZK8raT7ugCEANlm++tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="58811710"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="58811710"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 15:54:32 -0700
X-CSE-ConnectionGUID: I1MRVyORSFCRw7GoPaZ+VA==
X-CSE-MsgGUID: fZ6ZPu7fQ9OoFY+J+c+fZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="138514278"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 15:54:31 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 01 May 2025 15:54:14 -0700
Subject: [PATCH v4 03/15] ice: fix E825-C TSPLL register definitions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250501-kk-tspll-improvements-alignment-v4-3-24c83d0ce7a8@intel.com>
References: <20250501-kk-tspll-improvements-alignment-v4-0-24c83d0ce7a8@intel.com>
In-Reply-To: <20250501-kk-tspll-improvements-alignment-v4-0-24c83d0ce7a8@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Karol Kolacinski <karol.kolacinski@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Milena Olech <milena.olech@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>
X-Mailer: b4 0.14.2

The E825-C hardware has a slightly different register layout for register
19 of the Clock Generation Unit and TSPLL. The fbdiv_intgr value can be 10
bits wide.

Additionally, most of the fields that were in register 24 are made
available in register 23 instead. The programming logic already has a
corrected definition for register 23, but it incorrectly still used the
8-bit definition of fbdiv_intgr. This results in truncating some of the
values of fbdiv_intgr, including the value used for the 156.25MHz signal.

The driver only used register 24 to obtain the enable status, which we
should read from register 23. This results in an incorrect output for the
log messages, but does not change any functionality besides
disabled-by-default dynamic debug messages.

Fix the register definitions, and adjust the code to properly reflect the
enable/disable status in the log messages.

Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.h | 17 ++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_tspll.c  | 17 +++++++----------
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index af88e274e989a03b3e2f793186a2b662c226bf83..86b34fb02d41b01640ee8b913ff2fc82fde85b68 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -74,7 +74,7 @@ union ice_cgu_r16 {
 };
 
 #define ICE_CGU_R19 0x4c
-union ice_cgu_r19 {
+union ice_cgu_r19_e82x {
 	struct {
 		u32 fbdiv_intgr : 8;
 		u32 fdpll_ulck_thr : 5;
@@ -89,6 +89,21 @@ union ice_cgu_r19 {
 	u32 val;
 };
 
+union ice_cgu_r19_e825 {
+	struct {
+		u32 tspll_fbdiv_intgr : 10;
+		u32 fdpll_ulck_thr : 5;
+		u32 misc15 : 1;
+		u32 tspll_ndivratio : 4;
+		u32 tspll_iref_ndivratio : 3;
+		u32 misc19 : 1;
+		u32 japll_ndivratio : 4;
+		u32 japll_postdiv_pdivratio : 3;
+		u32 misc27 : 1;
+	};
+	u32 val;
+};
+
 #define ICE_CGU_R22 0x58
 union ice_cgu_r22 {
 	struct {
diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index 2fe619214a1a15d8d1d7bd5ac350c6ab58b75e81..74a9fc35fb1a6bc1011fe8142566a14673e867d9 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -230,7 +230,7 @@ static int ice_tspll_cfg_e82x(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 			      enum ice_clk_src clk_src)
 {
 	union tspll_ro_bwm_lf bwm_lf;
-	union ice_cgu_r19 dw19;
+	union ice_cgu_r19_e82x dw19;
 	union ice_cgu_r22 dw22;
 	union ice_cgu_r24 dw24;
 	union ice_cgu_r9 dw9;
@@ -398,9 +398,9 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 			       enum ice_clk_src clk_src)
 {
 	union tspll_ro_lock_e825c ro_lock;
+	union ice_cgu_r19_e825 dw19;
 	union ice_cgu_r16 dw16;
 	union ice_cgu_r23 dw23;
-	union ice_cgu_r19 dw19;
 	union ice_cgu_r22 dw22;
 	union ice_cgu_r24 dw24;
 	union ice_cgu_r9 dw9;
@@ -428,10 +428,6 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 	if (err)
 		return err;
 
-	err = ice_read_cgu_reg(hw, ICE_CGU_R24, &dw24.val);
-	if (err)
-		return err;
-
 	err = ice_read_cgu_reg(hw, ICE_CGU_R16, &dw16.val);
 	if (err)
 		return err;
@@ -446,7 +442,7 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 
 	/* Log the current clock configuration */
 	ice_debug(hw, ICE_DBG_PTP, "Current TSPLL configuration -- %s, clk_src %s, clk_freq %s, PLL %s\n",
-		  str_enabled_disabled(dw24.ts_pll_enable),
+		  str_enabled_disabled(dw23.ts_pll_enable),
 		  ice_tspll_clk_src_str(dw23.time_ref_sel),
 		  ice_tspll_clk_freq_str(dw9.time_ref_freq_sel),
 		  ro_lock.plllock_true_lock_cri ? "locked" : "unlocked");
@@ -486,8 +482,8 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 	if (err)
 		return err;
 
-	dw19.fbdiv_intgr = e825c_tspll_params[clk_freq].fbdiv_intgr;
-	dw19.ndivratio = e825c_tspll_params[clk_freq].ndivratio;
+	dw19.tspll_fbdiv_intgr = e825c_tspll_params[clk_freq].fbdiv_intgr;
+	dw19.tspll_ndivratio = e825c_tspll_params[clk_freq].ndivratio;
 
 	err = ice_write_cgu_reg(hw, ICE_CGU_R19, dw19.val);
 	if (err)
@@ -518,6 +514,7 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 	if (err)
 		return err;
 
+	dw24.val = 0;
 	dw24.fbdiv_frac = e825c_tspll_params[clk_freq].fbdiv_frac;
 
 	err = ice_write_cgu_reg(hw, ICE_CGU_R24, dw24.val);
@@ -545,7 +542,7 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 
 	/* Log the current clock configuration */
 	ice_debug(hw, ICE_DBG_PTP, "New TSPLL configuration -- %s, clk_src %s, clk_freq %s, PLL %s\n",
-		  str_enabled_disabled(dw24.ts_pll_enable),
+		  str_enabled_disabled(dw23.ts_pll_enable),
 		  ice_tspll_clk_src_str(dw23.time_ref_sel),
 		  ice_tspll_clk_freq_str(dw9.time_ref_freq_sel),
 		  ro_lock.plllock_true_lock_cri ? "locked" : "unlocked");

-- 
2.48.1.397.gec9d649cc640


