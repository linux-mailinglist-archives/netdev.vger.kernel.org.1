Return-Path: <netdev+bounces-187170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC1CAA5835
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 00:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96D3A1C20910
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 22:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7719227E8C;
	Wed, 30 Apr 2025 22:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4L14XbL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EDB226CFB
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 22:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746053505; cv=none; b=BGgUYno1MD5mxQoR7H01Y+JjRmkHkwnTeHTPGh4MJg9BZNGknkm3rzPDmnA8KbSSsCGIxXqvTUIeuZiNViQFVWt2SowsGSolGyl4l0ivJeL1jV9L4/ZaM1Z5991OjywrlQGFW5Pz8Ev7EWN+ZsKngMdaWFKNpNWil0zdsfVo40M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746053505; c=relaxed/simple;
	bh=/LYCBKxEPTRQfve9WiCaRvxZaeq7au3XhX5h2W7RrjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ep7rN1BMvNzB2Z76rwe2vs0wTQalhnsRWOTuadQZ5+T6G+lPTX2NPEMSWXmJlnm3hBt2EDF1EgGOPoRtGJ0VUiHX3zvfzDWlcWaCA3p4kA8gChkWi0g0lN7lCYAnosjNCFOfaRv7tluzl/RpY/qT3OgUCtd6gn44bHnQXzFW+hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4L14XbL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746053504; x=1777589504;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=/LYCBKxEPTRQfve9WiCaRvxZaeq7au3XhX5h2W7RrjA=;
  b=H4L14XbLQ7rNEsMOPai+4JKJMEzv5SFO+pNcy1ykozDQKyBNhzdlkpsL
   wmyNjxPQMEgSYjs6veESHqbsQUnXSMxwVjOP726bfvWjl/O3YLCdhlOvh
   z0XPsvTtWJ8oT7D3jmZ+kDQu2zicBB04M5b2oezg6GnQwfggnWQ1XFzpp
   7F9j7U6DXSA39vSfQDtsTJm8C2fYr/Bz+nD3Yw/FCMXI4sMfm1UjXBlUO
   hJcQdA1+BmK8QxNRKVPJiUlTgdo8CqKnJ3F5LrCTlxfJuzcA50QvpsieS
   ylxHX8TsmcWwPAaKhGzXfqCKpqazncHlm/Yffmtd++ZiCt2SNs8Ikz1wB
   A==;
X-CSE-ConnectionGUID: ZyiGPLYzQi2I/rorTvnivA==
X-CSE-MsgGUID: 69gBYDJpT82E3dWBX+lx4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="73120890"
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="73120890"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 15:51:40 -0700
X-CSE-ConnectionGUID: R+N2AkOzTLeNtKJajYN3jQ==
X-CSE-MsgGUID: F6RbQt0TSyi4sPdN02RE6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="134145074"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 15:51:40 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 30 Apr 2025 15:51:34 -0700
Subject: [PATCH v3 03/15] ice: fix E825-C TSPLL register definitions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-kk-tspll-improvements-alignment-v3-3-ab8472e86204@intel.com>
References: <20250430-kk-tspll-improvements-alignment-v3-0-ab8472e86204@intel.com>
In-Reply-To: <20250430-kk-tspll-improvements-alignment-v3-0-ab8472e86204@intel.com>
To: Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 netdev <netdev@vger.kernel.org>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Milena Olech <milena.olech@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Karol Kolacinski <karol.kolacinski@intel.com>
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
index fee5b373af8cf8f5e9c17fd1c65b9e2f1bb4cfa4..0ed9b5e2a0afb1d3a0e697a027e3cb125e4db443 100644
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
index 3f6287e48192b33c7e108c584587b2e8cf57182f..c27f5cabfb1fe0f018b73c3c6b56d77f24db9165 100644
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
-		  dw24.ts_pll_enable ? "enabled" : "disabled",
+		  dw23.ts_pll_enable ? "enabled" : "disabled",
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
-		  dw24.ts_pll_enable ? "enabled" : "disabled",
+		  dw23.ts_pll_enable ? "enabled" : "disabled",
 		  ice_tspll_clk_src_str(dw23.time_ref_sel),
 		  ice_tspll_clk_freq_str(dw9.time_ref_freq_sel),
 		  ro_lock.plllock_true_lock_cri ? "locked" : "unlocked");

-- 
2.48.1.397.gec9d649cc640


