Return-Path: <netdev+bounces-187329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D6DAA668A
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 00:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A5537B5F61
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 22:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A552626D4E3;
	Thu,  1 May 2025 22:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZmWOTRe7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63F526A1C1
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 22:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140082; cv=none; b=e+CclmwgD/y9Zytj5VkO5CsnXxVyjCIKf+MfaegC+wQFBdo3bsWDKO6xONze8IxLnc3cMaRcE/MxDiGE8z8GR998I/rH0JPpqERejt4TzSh1Kauxc7ro9QQgA2Kwo4454rNuTmJJQH7eJJgh7S3CGp4cof5qAtK2Q79D8AZ9r8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140082; c=relaxed/simple;
	bh=Ui1x/Cg53BF1Ey3vUkgERO9Hq0bcGMAFrRPbLHEC5+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R7ZE+Psy3AfoxxboQz6FlCDpxW4+T49844vZMcn7QayDrA4W9dDmBUX4MTLip2pwE7fCwe/1IWm5/iH8HpMYQdQjNE4cupNLLH8DraZaJTfsZxVxMm3V9lMBwm6A4aW4AVEqMpjkiq9TfilYgWDHZlOCvuhZiT83PMiJGuZcc+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZmWOTRe7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746140081; x=1777676081;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Ui1x/Cg53BF1Ey3vUkgERO9Hq0bcGMAFrRPbLHEC5+w=;
  b=ZmWOTRe7i18t8UmGvsvMxYotrupKRWAlNG4BnTLQ35hrFlnpqVPd28g0
   Q26n9gkYlxUY8vYGUX3J7EoqzpYp1tSswzWdg7SdAMOvvlXKs+VOqPXZU
   qZlQRdc1Kpw7TNouQd4CYbYwkGR2UVmALujjKoKhHqE4XruZmNST1cx6Z
   la9LIZnvpWur5X6MGdo2klalzZkXmlAGInygUvf6guAHz9R1fpdD/uemv
   kbXqRr9Nx+9pbJ71hzJ8LJHBVi3Cui19bbrXhEaCdApzxpFuVbze7Vjgb
   rbWrVu4NXk7u+iCz/zYUUGZ7dkMe260gEr+d36gs881LIcTj1o5rphUiy
   w==;
X-CSE-ConnectionGUID: v7WPyDO5QN630GM0Kq9NrQ==
X-CSE-MsgGUID: S3HFS7JVRUi3kRaGH8nAzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="58811742"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="58811742"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 15:54:37 -0700
X-CSE-ConnectionGUID: px+aE/8ZSBGpGSuCEqlRqg==
X-CSE-MsgGUID: IIM7kdlZQZ6AWXDfxAs/mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="138514308"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 15:54:35 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 01 May 2025 15:54:22 -0700
Subject: [PATCH v4 11/15] ice: add multiple TSPLL helpers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250501-kk-tspll-improvements-alignment-v4-11-24c83d0ce7a8@intel.com>
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
index 54f7b8a18a2f48b1866d2fe6e505d32b6717965c..66ad5ee63f3084d1d54c2445f56d7f61d6be344b 100644
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


