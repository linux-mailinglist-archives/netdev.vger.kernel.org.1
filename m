Return-Path: <netdev+bounces-187179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C65AA5841
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 00:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E079050366E
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 22:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AF822ACD3;
	Wed, 30 Apr 2025 22:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SJspWBgY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18EA22A4F1
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 22:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746053512; cv=none; b=gHyMq/m3P9/WZf2c0kKldXwVpFYQe34vToIS1tnJwciyjTT9izJLMhsIelcMBZLiXh8nX8YZVN5n87cuM7Ft1bdpph1zMmcg6NZVvJz2T5+/PVxcRhnTCoUbuyccaPUf+KKW5OlTE584Jr+0LYXldZpEwRuoOjsXeX/SvahqQio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746053512; c=relaxed/simple;
	bh=P+iNkEdwlUrja5URJ/amj6hrk1flV7wnzjKbGtD+5qU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R4uOdmarITStHMd6mL/gnzrbJV21MR4oJA87IIZhq9wM2S97YRmDIVTstNCJ3gmziHaRlTJtzbgAyr7FpaW0yJChdiQS5Z/ZbW4Ki3NJSPr61uuuJOuvpD95blEZB8BSFNypP8CbUbB0YU8JKSeuR385Dajr8DEvh8yNJ+pnKdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SJspWBgY; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746053510; x=1777589510;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=P+iNkEdwlUrja5URJ/amj6hrk1flV7wnzjKbGtD+5qU=;
  b=SJspWBgYN7vBo4hXKEXHW8Z0qvtLJJPwxtgf9LypfJcze8T6ps8PIMBY
   qEr773lkzsF4KkilGO/PhGZWmxjcS7kSM1e6tp1eM10gmfFKYUePBNtHl
   ijbNcwoq5b4en9Kqs7FR0CoyzbJMzsUbTLllM8mm5SvOd6FyN1DVa/tak
   MKII8i2jZqisPGccWjPelJH1PqpgyRxp5k+QYW6nJql06xAilTDP2ZggO
   tAh/7ryJWVOyFtQ9PmC8XthD9YByMcvKoh1Z0xgPpofx81g5vl5dx7AOd
   Fm2+WgeGbTTHTvCBvrO9I06MJXXoCGeebHWs6jjwuagxBn5ZJUPJAXf4g
   g==;
X-CSE-ConnectionGUID: V1m/KJIST2SN0fO+8T+K3w==
X-CSE-MsgGUID: Y7EHEWBbTzi/zwUu345Z+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="73120909"
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="73120909"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 15:51:41 -0700
X-CSE-ConnectionGUID: FRkmzg5VSVKuCkcaVcXP6Q==
X-CSE-MsgGUID: YQgNbADmQaCYu7uVLixymw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="134145100"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 15:51:40 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 30 Apr 2025 15:51:42 -0700
Subject: [PATCH v3 11/15] ice: add multiple TSPLL helpers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-kk-tspll-improvements-alignment-v3-11-ab8472e86204@intel.com>
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

From: Karol Kolacinski <karol.kolacinski@intel.com>

Add helpers for checking TSPLL params, disabling sticky bits,
configuring TSPLL and getting default clock frequency to simplify
the code flows.

Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tspll.c | 156 ++++++++++++++++++++---------
 1 file changed, 108 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index ae8aee1c7d40ebe452725196b87d22dc3484892a..0792d60438cad479934bac0ffd3454c8b193079a 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -71,6 +71,58 @@ static const char *ice_tspll_clk_freq_str(enum ice_tspll_freq clk_freq)
 	}
 }
 
+/**
+ * ice_tspll_default_freq - Return default frequency for a MAC type
+ * @mac_type: MAC type
+ *
+ * Return: default TSPLL frequency for a correct MAC type, -ERANGE otherwise.
+ */
+static enum ice_tspll_freq ice_tspll_default_freq(enum ice_mac_type mac_type)
+{
+	switch (mac_type) {
+	case ICE_MAC_GENERIC:
+		return ICE_TSPLL_FREQ_25_000;
+	case ICE_MAC_GENERIC_3K_E825:
+		return ICE_TSPLL_FREQ_156_250;
+	default:
+		return -ERANGE;
+	}
+}
+
+/**
+ * ice_tspll_check_params - Check if TSPLL params are correct
+ * @hw: Pointer to the HW struct
+ * @clk_freq: Clock frequency to program
+ * @clk_src: Clock source to select (TIME_REF or TCXO)
+ *
+ * Return: true if TSPLL params are correct, false otherwise.
+ */
+static bool ice_tspll_check_params(struct ice_hw *hw,
+				   enum ice_tspll_freq clk_freq,
+				   enum ice_clk_src clk_src)
+{
+	if (clk_freq >= NUM_ICE_TSPLL_FREQ) {
+		dev_warn(ice_hw_to_dev(hw), "Invalid TSPLL frequency %u\n",
+			 clk_freq);
+		return false;
+	}
+
+	if (clk_src >= NUM_ICE_CLK_SRC) {
+		dev_warn(ice_hw_to_dev(hw), "Invalid clock source %u\n",
+			 clk_src);
+		return false;
+	}
+
+	if ((hw->mac_type == ICE_MAC_GENERIC_3K_E825 ||
+	     clk_src == ICE_CLK_SRC_TCXO) &&
+	    clk_freq != ice_tspll_default_freq(hw->mac_type)) {
+		dev_warn(ice_hw_to_dev(hw), "Unsupported frequency for this clock source\n");
+		return false;
+	}
+
+	return true;
+}
+
 /**
  * ice_tspll_clk_src_str - Convert time_ref_src to string
  * @clk_src: Clock source
@@ -129,24 +181,6 @@ static int ice_tspll_cfg_e82x(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 {
 	u32 val, r9, r24;
 
-	if (clk_freq >= NUM_ICE_TSPLL_FREQ) {
-		dev_warn(ice_hw_to_dev(hw), "Invalid TIME_REF frequency %u\n",
-			 clk_freq);
-		return -EINVAL;
-	}
-
-	if (clk_src >= NUM_ICE_CLK_SRC) {
-		dev_warn(ice_hw_to_dev(hw), "Invalid clock source %u\n",
-			 clk_src);
-		return -EINVAL;
-	}
-
-	if (clk_src == ICE_CLK_SRC_TCXO && clk_freq != ICE_TSPLL_FREQ_25_000) {
-		dev_warn(ice_hw_to_dev(hw),
-			 "TCXO only supports 25 MHz frequency\n");
-		return -EINVAL;
-	}
-
 	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R9, &r9);
 	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R24, &r24);
 	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_RO_BWM_LF, &val);
@@ -258,23 +292,6 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 {
 	u32 val, r9, r23;
 
-	if (clk_freq >= NUM_ICE_TSPLL_FREQ) {
-		dev_warn(ice_hw_to_dev(hw), "Invalid TIME_REF frequency %u\n",
-			 clk_freq);
-		return -EINVAL;
-	}
-
-	if (clk_src >= NUM_ICE_CLK_SRC) {
-		dev_warn(ice_hw_to_dev(hw), "Invalid clock source %u\n",
-			 clk_src);
-		return -EINVAL;
-	}
-
-	if (clk_freq != ICE_TSPLL_FREQ_156_250) {
-		dev_warn(ice_hw_to_dev(hw), "Adapter only supports 156.25 MHz frequency\n");
-		return -EINVAL;
-	}
-
 	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R9, &r9);
 	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R23, &r23);
 	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_RO_LOCK, &val);
@@ -400,6 +417,52 @@ int ice_tspll_cfg_pps_out_e825c(struct ice_hw *hw, bool enable)
 	return ice_write_cgu_reg(hw, ICE_CGU_R9, val);
 }
 
+/**
+ * ice_tspll_cfg - Configure the Clock Generation Unit TSPLL
+ * @hw: Pointer to the HW struct
+ * @clk_freq: Clock frequency to program
+ * @clk_src: Clock source to select (TIME_REF, or TCXO)
+ *
+ * Configure the Clock Generation Unit with the desired clock frequency and
+ * time reference, enabling the TSPLL which drives the PTP hardware clock.
+ *
+ * Return: 0 on success, -ERANGE on unsupported MAC type, other negative error
+ *         codes when failed to configure CGU.
+ */
+static int ice_tspll_cfg(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
+			 enum ice_clk_src clk_src)
+{
+	switch (hw->mac_type) {
+	case ICE_MAC_GENERIC:
+		return ice_tspll_cfg_e82x(hw, clk_freq, clk_src);
+	case ICE_MAC_GENERIC_3K_E825:
+		return ice_tspll_cfg_e825c(hw, clk_freq, clk_src);
+	default:
+		return -ERANGE;
+	}
+}
+
+/**
+ * ice_tspll_dis_sticky_bits - disable TSPLL sticky bits
+ * @hw: Pointer to the HW struct
+ *
+ * Configure the Clock Generation Unit TSPLL sticky bits so they don't latch on
+ * losing TSPLL lock, but always show current state.
+ *
+ * Return: 0 on success, -ERANGE on unsupported MAC type.
+ */
+static int ice_tspll_dis_sticky_bits(struct ice_hw *hw)
+{
+	switch (hw->mac_type) {
+	case ICE_MAC_GENERIC:
+		return ice_tspll_dis_sticky_bits_e82x(hw);
+	case ICE_MAC_GENERIC_3K_E825:
+		return ice_tspll_dis_sticky_bits_e825c(hw);
+	default:
+		return -ERANGE;
+	}
+}
+
 /**
  * ice_tspll_init - Initialize TSPLL with settings from firmware
  * @hw: Pointer to the HW structure
@@ -411,25 +474,22 @@ int ice_tspll_cfg_pps_out_e825c(struct ice_hw *hw, bool enable)
 int ice_tspll_init(struct ice_hw *hw)
 {
 	struct ice_ts_func_info *ts_info = &hw->func_caps.ts_func_info;
+	enum ice_tspll_freq tspll_freq;
+	enum ice_clk_src clk_src;
 	int err;
 
-	/* Disable sticky lock detection so lock err reported is accurate. */
-	if (hw->mac_type == ICE_MAC_GENERIC_3K_E825)
-		err = ice_tspll_dis_sticky_bits_e825c(hw);
-	else
-		err = ice_tspll_dis_sticky_bits_e82x(hw);
+	tspll_freq = (enum ice_tspll_freq)ts_info->time_ref;
+	clk_src = (enum ice_clk_src)ts_info->clk_src;
+	if (!ice_tspll_check_params(hw, tspll_freq, clk_src))
+		return -EINVAL;
+
+	/* Disable sticky lock detection so lock status reported is accurate */
+	err = ice_tspll_dis_sticky_bits(hw);
 	if (err)
 		return err;
 
 	/* Configure the TSPLL using the parameters from the function
 	 * capabilities.
 	 */
-	if (hw->mac_type == ICE_MAC_GENERIC_3K_E825)
-		err = ice_tspll_cfg_e825c(hw, ts_info->time_ref,
-					  (enum ice_clk_src)ts_info->clk_src);
-	else
-		err = ice_tspll_cfg_e82x(hw, ts_info->time_ref,
-					 (enum ice_clk_src)ts_info->clk_src);
-
-	return err;
+	return ice_tspll_cfg(hw, tspll_freq, clk_src);
 }

-- 
2.48.1.397.gec9d649cc640


