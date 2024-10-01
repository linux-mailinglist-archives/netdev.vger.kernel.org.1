Return-Path: <netdev+bounces-131028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3713298C69B
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E78FB21464
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AB31CEAAB;
	Tue,  1 Oct 2024 20:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ilSqOlGX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5791C7B83
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 20:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727813836; cv=none; b=hTrCcvULe/Ko1UDVj//d487D/8fpc7WZ67Ovr3Gsn41QJ3zt85hWA56881PMqLVPtsY3/ozFFme81TnbgiFq98pEASwuYjXK8I/DynwVZmccPbV21DFcatHYmx0TGZesG+ngoBiFa8QDdOhMRuToFfED0HvOOEvBAI2Fxx7q2l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727813836; c=relaxed/simple;
	bh=YyyjFlkhjHZBqfV5SsySRlJ73wiNH5BikHICgaQB/gI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n/M2MIT37FWtB2R6Me1dAIpaoVkED+uE0U2VazNfn7Hv2giMZODNJILrYhY+tF+AENBp4ya/8bZR0OGLChrxczl4JnXN2HhDpZGzBl3X1Qq8IIvRQffPQbOA/HOR9kDV9MxYRNXLmK86Fu6CQqylil6iKy+4zXxpoT6ZrPefYcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ilSqOlGX; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727813834; x=1759349834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YyyjFlkhjHZBqfV5SsySRlJ73wiNH5BikHICgaQB/gI=;
  b=ilSqOlGXfIka9WdiZ2cjWi5PAYB1OpAM6v6iYCjBy6LVmFo7GnFeeeb1
   F3qGofqpDdMK9HbI171Dr/YlIcwma1Z7qk6aEW0FB2l8rFenEs6AXHKuC
   h4Uylm8DjXRptmCqsBPMqbDxRK3cYep4CUHdl6Df7huXK/EOeIkPt+ZaL
   5fD/PR7RC220vAkBnvCXnbAcY3Cbz8LxrpSv7VZ7Yhd7dd/iED18ij3KI
   1G/rGn7hGZ4l80uZM+jllRpms8wMVQYFBthniikRzKALv06PIxhsEuI0R
   DSNLUWxhPPS+12hd/HxG8imACQl/sR4K5EZZCtxejRLhaTRVjkMH9+ybG
   g==;
X-CSE-ConnectionGUID: PRlzyzgyRWeUJ25imfhkJw==
X-CSE-MsgGUID: AQZb4lHHTVOFmZREhgN7VA==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="27063052"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="27063052"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 13:17:13 -0700
X-CSE-ConnectionGUID: MOoOiAYBTmmhyTeSMh7GSA==
X-CSE-MsgGUID: dyilq+FUTAO8MDWt8wONTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="73761841"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 01 Oct 2024 13:17:13 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 01/12] ice: Implement ice_ptp_pin_desc
Date: Tue,  1 Oct 2024 13:16:48 -0700
Message-ID: <20241001201702.3252954-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241001201702.3252954-1-anthony.l.nguyen@intel.com>
References: <20241001201702.3252954-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Add a new internal structure describing PTP pins.
Use the new structure for all non-E810T products.

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 256 +++++++++++++++--------
 drivers/net/ethernet/intel/ice/ice_ptp.h |  65 ++++--
 2 files changed, 214 insertions(+), 107 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index ef2e858f49bb..34ce1a160f73 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -5,6 +5,30 @@
 #include "ice_lib.h"
 #include "ice_trace.h"
 
+static const char ice_pin_names[][64] = {
+	"SDP0",
+	"SDP1",
+	"SDP2",
+	"SDP3",
+	"TIME_SYNC",
+	"1PPS"
+};
+
+static const struct ice_ptp_pin_desc ice_pin_desc_e82x[] = {
+	/* name,        gpio */
+	{  TIME_SYNC, {  4, -1 }},
+	{  ONE_PPS,   { -1,  5 }},
+};
+
+static const struct ice_ptp_pin_desc ice_pin_desc_e810[] = {
+	/* name,      gpio */
+	{  SDP0,    {  0, 0 }},
+	{  SDP1,    {  1, 1 }},
+	{  SDP2,    {  2, 2 }},
+	{  SDP3,    {  3, 3 }},
+	{  ONE_PPS, { -1, 5 }},
+};
+
 #define E810_OUT_PROP_DELAY_NS 1
 
 static const struct ptp_pin_desc ice_pin_desc_e810t[] = {
@@ -16,6 +40,29 @@ static const struct ptp_pin_desc ice_pin_desc_e810t[] = {
 	{ "U.FL2", UFL2, PTP_PF_NONE, 2, { 0, } },
 };
 
+/**
+ * ice_ptp_find_pin_idx - Find pin index in ptp_pin_desc
+ * @pf: Board private structure
+ * @func: Pin function
+ * @chan: GPIO channel
+ *
+ * Return: positive pin number when pin is present, -1 otherwise
+ */
+static int ice_ptp_find_pin_idx(struct ice_pf *pf, enum ptp_pin_function func,
+				unsigned int chan)
+{
+	const struct ptp_clock_info *info = &pf->ptp.info;
+	int i;
+
+	for (i = 0; i < info->n_pins; i++) {
+		if (info->pin_config[i].func == func &&
+		    info->pin_config[i].chan == chan)
+			return i;
+	}
+
+	return -1;
+}
+
 /**
  * ice_get_sma_config_e810t
  * @hw: pointer to the hw struct
@@ -1900,14 +1947,14 @@ static void ice_ptp_enable_all_clkout(struct ice_pf *pf)
 }
 
 /**
- * ice_ptp_gpio_enable_e810 - Enable/disable ancillary features of PHC
+ * ice_ptp_gpio_enable_e810t - Enable/disable ancillary features of PHC
  * @info: the driver's PTP info structure
  * @rq: The requested feature to change
  * @on: Enable/disable flag
  */
 static int
-ice_ptp_gpio_enable_e810(struct ptp_clock_info *info,
-			 struct ptp_clock_request *rq, int on)
+ice_ptp_gpio_enable_e810t(struct ptp_clock_info *info,
+			  struct ptp_clock_request *rq, int on)
 {
 	struct ice_pf *pf = ptp_info_to_pf(info);
 	bool sma_pres = false;
@@ -1930,22 +1977,18 @@ ice_ptp_gpio_enable_e810(struct ptp_clock_info *info,
 				clk_cfg.gpio_pin = GPIO_22;
 			else
 				return -1;
-		} else if (ice_is_e810t(&pf->hw)) {
+		} else {
 			if (chan == 0)
 				clk_cfg.gpio_pin = GPIO_20;
 			else
 				clk_cfg.gpio_pin = GPIO_22;
-		} else if (chan == PPS_CLK_GEN_CHAN) {
-			clk_cfg.gpio_pin = PPS_PIN_INDEX;
-		} else {
-			clk_cfg.gpio_pin = chan;
 		}
 
 		clk_cfg.flags = rq->perout.flags;
-		clk_cfg.period = ((rq->perout.period.sec * NSEC_PER_SEC) +
-				   rq->perout.period.nsec);
-		clk_cfg.start_time = ((rq->perout.start.sec * NSEC_PER_SEC) +
-				       rq->perout.start.nsec);
+		clk_cfg.period = rq->perout.period.sec * NSEC_PER_SEC +
+				 rq->perout.period.nsec;
+		clk_cfg.start_time = rq->perout.start.sec * NSEC_PER_SEC +
+				     rq->perout.start.nsec;
 		clk_cfg.ena = !!on;
 
 		return ice_ptp_cfg_clkout(pf, chan, &clk_cfg, true);
@@ -1960,13 +2003,11 @@ ice_ptp_gpio_enable_e810(struct ptp_clock_info *info,
 				gpio_pin = GPIO_21;
 			else
 				gpio_pin = GPIO_23;
-		} else if (ice_is_e810t(&pf->hw)) {
+		} else {
 			if (chan == 0)
 				gpio_pin = GPIO_21;
 			else
 				gpio_pin = GPIO_23;
-		} else {
-			gpio_pin = chan;
 		}
 
 		extts_cfg.flags = rq->extts.flags;
@@ -1981,34 +2022,89 @@ ice_ptp_gpio_enable_e810(struct ptp_clock_info *info,
 }
 
 /**
- * ice_ptp_gpio_enable_e823 - Enable/disable ancillary features of PHC
+ * ice_verify_pin - verify if pin supports requested pin function
  * @info: the driver's PTP info structure
+ * @pin: Pin index
+ * @func: Assigned function
+ * @chan: Assigned channel
+ *
+ * Return: 0 on success, -EOPNOTSUPP when function is not supported.
+ */
+static int ice_verify_pin(struct ptp_clock_info *info, unsigned int pin,
+			  enum ptp_pin_function func, unsigned int chan)
+{
+	struct ice_pf *pf = ptp_info_to_pf(info);
+	const struct ice_ptp_pin_desc *pin_desc;
+
+	pin_desc = &pf->ptp.ice_pin_desc[pin];
+
+	/* Is assigned function allowed? */
+	switch (func) {
+	case PTP_PF_EXTTS:
+		if (pin_desc->gpio[0] < 0)
+			return -EOPNOTSUPP;
+		break;
+	case PTP_PF_PEROUT:
+		if (pin_desc->gpio[1] < 0)
+			return -EOPNOTSUPP;
+		break;
+	case PTP_PF_NONE:
+		break;
+	case PTP_PF_PHYSYNC:
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+/**
+ * ice_ptp_gpio_enable - Enable/disable ancillary features of PHC
+ * @info: The driver's PTP info structure
  * @rq: The requested feature to change
  * @on: Enable/disable flag
+ *
+ * Return: 0 on success, -EOPNOTSUPP when request type is not supported
  */
-static int ice_ptp_gpio_enable_e823(struct ptp_clock_info *info,
-				    struct ptp_clock_request *rq, int on)
+static int ice_ptp_gpio_enable(struct ptp_clock_info *info,
+			       struct ptp_clock_request *rq, int on)
 {
 	struct ice_pf *pf = ptp_info_to_pf(info);
 
 	switch (rq->type) {
-	case PTP_CLK_REQ_PPS:
+	case PTP_CLK_REQ_PEROUT:
 	{
-		struct ice_perout_channel clk_cfg = {};
+		struct ice_perout_channel clk_cfg;
+		int pin_desc_idx;
+
+		pin_desc_idx = ice_ptp_find_pin_idx(pf, PTP_PF_PEROUT,
+						    rq->perout.index);
+		if (pin_desc_idx < 0)
+			return -EIO;
+
 
 		clk_cfg.flags = rq->perout.flags;
-		clk_cfg.gpio_pin = PPS_PIN_INDEX;
-		clk_cfg.period = NSEC_PER_SEC;
+		clk_cfg.gpio_pin = pf->ptp.ice_pin_desc[pin_desc_idx].gpio[1];
+		clk_cfg.period = rq->perout.period.sec * NSEC_PER_SEC +
+				 rq->perout.period.nsec;
+		clk_cfg.start_time = rq->perout.start.sec * NSEC_PER_SEC +
+				     rq->perout.start.nsec;
 		clk_cfg.ena = !!on;
 
-		return ice_ptp_cfg_clkout(pf, PPS_CLK_GEN_CHAN, &clk_cfg, true);
+		return ice_ptp_cfg_clkout(pf, rq->perout.index, &clk_cfg, true);
 	}
 	case PTP_CLK_REQ_EXTTS:
 	{
 		struct ice_extts_channel extts_cfg = {};
+		int pin_desc_idx;
+
+		pin_desc_idx = ice_ptp_find_pin_idx(pf, PTP_PF_EXTTS,
+						    rq->extts.index);
+		if (pin_desc_idx < 0)
+			return -EIO;
 
 		extts_cfg.flags = rq->extts.flags;
-		extts_cfg.gpio_pin = TIME_SYNC_PIN_INDEX;
+		extts_cfg.gpio_pin = pf->ptp.ice_pin_desc[pin_desc_idx].gpio[0];
 		extts_cfg.ena = !!on;
 
 		return ice_ptp_cfg_extts(pf, rq->extts.index, &extts_cfg, true);
@@ -2404,6 +2500,26 @@ u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
 	return ts_ns;
 }
 
+/**
+ * ice_ptp_setup_pin_cfg - setup PTP pin_config structure
+ * @pf: Board private structure
+ */
+static void ice_ptp_setup_pin_cfg(struct ice_pf *pf)
+{
+	for (unsigned int i = 0; i < pf->ptp.info.n_pins; i++) {
+		const struct ice_ptp_pin_desc *desc = &pf->ptp.ice_pin_desc[i];
+		struct ptp_pin_desc *pin = &pf->ptp.pin_desc[i];
+		const char *name = NULL;
+
+		name = ice_pin_names[desc->name_idx];
+		strscpy(pin->name, name, sizeof(pin->name));
+
+		pin->index = i;
+	}
+
+	pf->ptp.info.pin_config = pf->ptp.pin_desc;
+}
+
 /**
  * ice_ptp_disable_sma_pins_e810t - Disable E810-T SMA pins
  * @pf: pointer to the PF structure
@@ -2457,61 +2573,41 @@ ice_ptp_setup_sma_pins_e810t(struct ice_pf *pf, struct ptp_clock_info *info)
 }
 
 /**
- * ice_ptp_setup_pins_e810 - Setup PTP pins in sysfs
+ * ice_ptp_setup_pins_e810t - Setup PTP pins in sysfs
  * @pf: pointer to the PF instance
- * @info: PTP clock capabilities
  */
-static void
-ice_ptp_setup_pins_e810(struct ice_pf *pf, struct ptp_clock_info *info)
-{
-	if (ice_is_feature_supported(pf, ICE_F_SMA_CTRL)) {
-		info->n_ext_ts = N_EXT_TS_E810;
-		info->n_per_out = N_PER_OUT_E810T;
-		info->n_pins = NUM_PTP_PINS_E810T;
-		info->verify = ice_verify_pin_e810t;
-
-		/* Complete setup of the SMA pins */
-		ice_ptp_setup_sma_pins_e810t(pf, info);
-	} else if (ice_is_e810t(&pf->hw)) {
-		info->n_ext_ts = N_EXT_TS_NO_SMA_E810T;
-		info->n_per_out = N_PER_OUT_NO_SMA_E810T;
-	} else {
-		info->n_per_out = N_PER_OUT_E810;
-		info->n_ext_ts = N_EXT_TS_E810;
-	}
-}
-
-/**
- * ice_ptp_setup_pins_e823 - Setup PTP pins in sysfs
- * @pf: pointer to the PF instance
- * @info: PTP clock capabilities
- */
-static void
-ice_ptp_setup_pins_e823(struct ice_pf *pf, struct ptp_clock_info *info)
+static void ice_ptp_setup_pins_e810t(struct ice_pf *pf)
 {
-	info->pps = 1;
-	info->n_per_out = 0;
-	info->n_ext_ts = 1;
+	pf->ptp.info.enable = ice_ptp_gpio_enable_e810t;
+	pf->ptp.info.n_pins = NUM_PTP_PINS_E810T;
+	pf->ptp.info.verify = ice_verify_pin_e810t;
+
+	/* Complete setup of the SMA pins */
+	ice_ptp_setup_sma_pins_e810t(pf, &pf->ptp.info);
 }
 
 /**
- * ice_ptp_set_funcs_e82x - Set specialized functions for E82x support
+ * ice_ptp_set_funcs_e82x - Set specialized functions for E82X support
  * @pf: Board private structure
- * @info: PTP info to fill
  *
- * Assign functions to the PTP capabiltiies structure for E82x devices.
+ * Assign functions to the PTP capabilities structure for E82X devices.
  * Functions which operate across all device families should be set directly
- * in ice_ptp_set_caps. Only add functions here which are distinct for E82x
+ * in ice_ptp_set_caps. Only add functions here which are distinct for E82X
  * devices.
  */
-static void
-ice_ptp_set_funcs_e82x(struct ice_pf *pf, struct ptp_clock_info *info)
+static void ice_ptp_set_funcs_e82x(struct ice_pf *pf)
 {
 #ifdef CONFIG_ICE_HWTS
 	if (boot_cpu_has(X86_FEATURE_ART) &&
 	    boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ))
-		info->getcrosststamp = ice_ptp_getcrosststamp_e82x;
+		pf->ptp.info.getcrosststamp = ice_ptp_getcrosststamp_e82x;
+
 #endif /* CONFIG_ICE_HWTS */
+	pf->ptp.info.enable = ice_ptp_gpio_enable;
+	pf->ptp.info.verify = ice_verify_pin;
+	pf->ptp.ice_pin_desc = ice_pin_desc_e82x;
+	pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e82x);
+	ice_ptp_setup_pin_cfg(pf);
 }
 
 /**
@@ -2527,27 +2623,15 @@ ice_ptp_set_funcs_e82x(struct ice_pf *pf, struct ptp_clock_info *info)
 static void
 ice_ptp_set_funcs_e810(struct ice_pf *pf, struct ptp_clock_info *info)
 {
-	info->enable = ice_ptp_gpio_enable_e810;
-	ice_ptp_setup_pins_e810(pf, info);
-}
-
-/**
- * ice_ptp_set_funcs_e823 - Set specialized functions for E823 support
- * @pf: Board private structure
- * @info: PTP info to fill
- *
- * Assign functions to the PTP capabiltiies structure for E823 devices.
- * Functions which operate across all device families should be set directly
- * in ice_ptp_set_caps. Only add functions here which are distinct for e823
- * devices.
- */
-static void
-ice_ptp_set_funcs_e823(struct ice_pf *pf, struct ptp_clock_info *info)
-{
-	ice_ptp_set_funcs_e82x(pf, info);
+	if (ice_is_e810t(&pf->hw) &&
+	    ice_is_feature_supported(pf, ICE_F_SMA_CTRL)) {
+		ice_ptp_setup_pins_e810t(pf);
+		return;
+	}
 
-	info->enable = ice_ptp_gpio_enable_e823;
-	ice_ptp_setup_pins_e823(pf, info);
+	pf->ptp.ice_pin_desc = ice_pin_desc_e810;
+	pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e810);
+	ice_ptp_setup_pin_cfg(pf);
 }
 
 /**
@@ -2567,13 +2651,13 @@ static void ice_ptp_set_caps(struct ice_pf *pf)
 	info->adjfine = ice_ptp_adjfine;
 	info->gettimex64 = ice_ptp_gettimex64;
 	info->settime64 = ice_ptp_settime64;
+	info->n_per_out = GLTSYN_TGT_H_IDX_MAX;
+	info->n_ext_ts = GLTSYN_EVNT_H_IDX_MAX;
 
 	if (ice_is_e810(&pf->hw))
 		ice_ptp_set_funcs_e810(pf, info);
-	else if (ice_is_e823(&pf->hw))
-		ice_ptp_set_funcs_e823(pf, info);
 	else
-		ice_ptp_set_funcs_e82x(pf, info);
+		ice_ptp_set_funcs_e82x(pf);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 2db2257a0fb2..eccd52108010 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -221,6 +221,46 @@ enum ice_ptp_state {
 	ICE_PTP_ERROR,
 };
 
+enum ice_ptp_pin {
+	SDP0 = 0,
+	SDP1,
+	SDP2,
+	SDP3,
+	TIME_SYNC,
+	ONE_PPS
+};
+
+/* Per-channel register definitions */
+#define GLTSYN_AUX_OUT(_chan, _idx)	(GLTSYN_AUX_OUT_0(_idx) + ((_chan) * 8))
+#define GLTSYN_AUX_IN(_chan, _idx)	(GLTSYN_AUX_IN_0(_idx) + ((_chan) * 8))
+#define GLTSYN_CLKO(_chan, _idx)	(GLTSYN_CLKO_0(_idx) + ((_chan) * 8))
+#define GLTSYN_TGT_L(_chan, _idx)	(GLTSYN_TGT_L_0(_idx) + ((_chan) * 16))
+#define GLTSYN_TGT_H(_chan, _idx)	(GLTSYN_TGT_H_0(_idx) + ((_chan) * 16))
+#define GLTSYN_EVNT_L(_chan, _idx)	(GLTSYN_EVNT_L_0(_idx) + ((_chan) * 16))
+#define GLTSYN_EVNT_H(_chan, _idx)	(GLTSYN_EVNT_H_0(_idx) + ((_chan) * 16))
+#define GLTSYN_EVNT_H_IDX_MAX		3
+
+/* Pin definitions for PTP */
+#define PPS_CLK_GEN_CHAN		3
+#define PPS_PIN_INDEX			5
+#define ICE_N_PINS_MAX			6
+#define ICE_PIN_DESC_ARR_LEN(_arr)	(sizeof(_arr) / \
+					 sizeof(struct ice_ptp_pin_desc))
+
+/**
+ * struct ice_ptp_pin_desc - hardware pin description data
+ * @name_idx: index of the name of pin in ice_pin_names
+ * @gpio: the associated GPIO input and output pins
+ *
+ * Structure describing a PTP-capable GPIO pin that extends ptp_pin_desc array
+ * for the device. Device families have separate sets of available pins with
+ * varying restrictions.
+ */
+struct ice_ptp_pin_desc {
+	int name_idx;
+	int gpio[2];
+};
+
 /**
  * struct ice_ptp - data used for integrating with CONFIG_PTP_1588_CLOCK
  * @state: current state of PTP state machine
@@ -232,6 +272,8 @@ enum ice_ptp_state {
  * @cached_phc_jiffies: jiffies when cached_phc_time was last updated
  * @ext_ts_chan: the external timestamp channel in use
  * @ext_ts_irq: the external timestamp IRQ in use
+ * @pin_desc: structure defining pins
+ * @ice_pin_desc: internal structure describing pin relations
  * @kworker: kwork thread for handling periodic work
  * @perout_channels: periodic output data
  * @extts_channels: channels for external timestamps
@@ -257,6 +299,8 @@ struct ice_ptp {
 	u8 ext_ts_chan;
 	u8 ext_ts_irq;
 	struct kthread_worker *kworker;
+	struct ptp_pin_desc pin_desc[ICE_N_PINS_MAX];
+	const struct ice_ptp_pin_desc *ice_pin_desc;
 	struct ice_perout_channel perout_channels[GLTSYN_TGT_H_IDX_MAX];
 	struct ice_extts_channel extts_channels[GLTSYN_TGT_H_IDX_MAX];
 	struct ptp_clock_info info;
@@ -289,27 +333,6 @@ struct ice_ptp {
 #define FIFO_EMPTY			BIT(2)
 #define FIFO_OK				0xFF
 #define ICE_PTP_FIFO_NUM_CHECKS		5
-/* Per-channel register definitions */
-#define GLTSYN_AUX_OUT(_chan, _idx)	(GLTSYN_AUX_OUT_0(_idx) + ((_chan) * 8))
-#define GLTSYN_AUX_IN(_chan, _idx)	(GLTSYN_AUX_IN_0(_idx) + ((_chan) * 8))
-#define GLTSYN_CLKO(_chan, _idx)	(GLTSYN_CLKO_0(_idx) + ((_chan) * 8))
-#define GLTSYN_TGT_L(_chan, _idx)	(GLTSYN_TGT_L_0(_idx) + ((_chan) * 16))
-#define GLTSYN_TGT_H(_chan, _idx)	(GLTSYN_TGT_H_0(_idx) + ((_chan) * 16))
-#define GLTSYN_EVNT_L(_chan, _idx)	(GLTSYN_EVNT_L_0(_idx) + ((_chan) * 16))
-#define GLTSYN_EVNT_H(_chan, _idx)	(GLTSYN_EVNT_H_0(_idx) + ((_chan) * 16))
-#define GLTSYN_EVNT_H_IDX_MAX		3
-
-/* Pin definitions for PTP PPS out */
-#define PPS_CLK_GEN_CHAN		3
-#define PPS_CLK_SRC_CHAN		2
-#define PPS_PIN_INDEX			5
-#define TIME_SYNC_PIN_INDEX		4
-#define N_EXT_TS_E810			3
-#define N_PER_OUT_E810			4
-#define N_PER_OUT_E810T			3
-#define N_PER_OUT_NO_SMA_E810T		2
-#define N_EXT_TS_NO_SMA_E810T		2
-#define ETH_GLTSYN_ENA(_i)		(0x03000348 + ((_i) * 4))
 
 #if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
 int ice_ptp_clock_index(struct ice_pf *pf);
-- 
2.42.0


