Return-Path: <netdev+bounces-195876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B28A6AD28BC
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 23:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D520189209D
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 21:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAF82253A5;
	Mon,  9 Jun 2025 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ep/fSW45"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9622248A8
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 21:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749504429; cv=none; b=uRBu0g/BmpT6doVluPfcIStbmhEVzLn1djrMcoCshig6QcnKUFEoxwbkrjv2cVww9rpQGGTUk/qiWt36u8D7XjVWzoNzy7bJkmd78RhrjkljVSQV4yFXH9zl9+78HyD2gRGF7WzqSt5VcWW3Al0FgzU0xAg5xMywdP4CPcTjKhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749504429; c=relaxed/simple;
	bh=oTWiBhgfWglQRAv7FgHyH/7xAzBfTtFABjvFNimlUzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYwrfAQN97ylQpdV62xeTEAwmkLqbXsGrY9cbpOZALMGegSMdy9GIfnyYD693jZGdCElIi9NCH+uriatlNOtDMRI9YO1wdfffdy2/L9GC+lczURB/QIUKypboESByA7zKCcSTOJu5NyptgfMkQUZJrlvG6amiZim2ZgAoIAtDV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ep/fSW45; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749504427; x=1781040427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oTWiBhgfWglQRAv7FgHyH/7xAzBfTtFABjvFNimlUzY=;
  b=Ep/fSW45oh3eHWyzBFPoc5x6PpBEY7155W/UvzDiOFhIE0BxvdDNNsxq
   DkfZiSG2zFEYKwaoWW0CTSzcUG0FoU0r2g9hdvfv0M3Dy5kxUJ9VzYDs7
   2mYgJI5HyoR3fdyAmIKz4Zm5m6nAMjHTN057YkY2NhAVxdCdtdwR9nbrA
   /zzfaqphHKP0DjUgHzCOTy2ibPyEDuPUTvZXCR2rgU97j6pfnucx2sflF
   Hc6GgB+RETZIaBE9sgQW5u2P8R1Q60jSioJ0cGXfBc0m8tJNk5tAuit9W
   JGR6oeZ2KBmd2sMa4JAjeIx9g0pdiGwa6TW8UV9f9tAeoY6O3hYB/FfE4
   Q==;
X-CSE-ConnectionGUID: sWsQZsTtRlySij50pFO9aw==
X-CSE-MsgGUID: SwFkl5+YRL2eHblh1CFEow==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="61864212"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="61864212"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 14:27:04 -0700
X-CSE-ConnectionGUID: WF2TEeV/Q1mWMRIV5B+DbQ==
X-CSE-MsgGUID: kF0ID6aoSla4sOkJMmnauw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="150469047"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 09 Jun 2025 14:27:04 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Milena Olech <milena.olech@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 07/11] ice: change SMA pins to SDP in PTP API
Date: Mon,  9 Jun 2025 14:26:46 -0700
Message-ID: <20250609212652.1138933-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250609212652.1138933-1-anthony.l.nguyen@intel.com>
References: <20250609212652.1138933-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

This change aligns E810 PTP pin control to all other products.

Currently, SMA/U.FL port expanders are controlled together with SDP pins
connected to 1588 clock. To align this, separate this control by
exposing only SDP20..23 pins in PTP API on adapters with DPLL.

Clear error for all E810 on absent NVM pin section or other errors to
allow proper initialization on SMA E810 with NVM section.

Use ARRAY_SIZE for pin array instead of internal definition.

Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 254 ++++-------------------
 drivers/net/ethernet/intel/ice/ice_ptp.h |   3 -
 2 files changed, 39 insertions(+), 218 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index b79a148ed0f2..b948a6d9226c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -40,21 +40,19 @@ static const struct ice_ptp_pin_desc ice_pin_desc_e810[] = {
 	{  ONE_PPS,   { -1,  5 }, { 0, 1 }},
 };
 
-static const char ice_pin_names_nvm[][64] = {
-	"GNSS",
-	"SMA1",
-	"U.FL1",
-	"SMA2",
-	"U.FL2",
+static const char ice_pin_names_dpll[][64] = {
+	"SDP20",
+	"SDP21",
+	"SDP22",
+	"SDP23",
 };
 
-static const struct ice_ptp_pin_desc ice_pin_desc_e810_sma[] = {
+static const struct ice_ptp_pin_desc ice_pin_desc_dpll[] = {
 	/* name,   gpio,       delay */
-	{  GNSS, {  1, -1 }, { 0, 0 }},
-	{  SMA1, {  1,  0 }, { 0, 1 }},
-	{  UFL1, { -1,  0 }, { 0, 1 }},
-	{  SMA2, {  3,  2 }, { 0, 1 }},
-	{  UFL2, {  3, -1 }, { 0, 0 }},
+	{  SDP0, { -1,  0 }, { 0, 1 }},
+	{  SDP1, {  1, -1 }, { 0, 0 }},
+	{  SDP2, { -1,  2 }, { 0, 1 }},
+	{  SDP3, {  3, -1 }, { 0, 0 }},
 };
 
 static struct ice_pf *ice_get_ctrl_pf(struct ice_pf *pf)
@@ -92,101 +90,6 @@ static int ice_ptp_find_pin_idx(struct ice_pf *pf, enum ptp_pin_function func,
 	return -1;
 }
 
-/**
- * ice_ptp_update_sma_data - update SMA pins data according to pins setup
- * @pf: Board private structure
- * @sma_pins: parsed SMA pins status
- * @data: SMA data to update
- */
-static void ice_ptp_update_sma_data(struct ice_pf *pf, unsigned int sma_pins[],
-				    u8 *data)
-{
-	const char *state1, *state2;
-
-	/* Set the right state based on the desired configuration.
-	 * When bit is set, functionality is disabled.
-	 */
-	*data &= ~ICE_ALL_SMA_MASK;
-	if (!sma_pins[UFL1 - 1]) {
-		if (sma_pins[SMA1 - 1] == PTP_PF_EXTTS) {
-			state1 = "SMA1 Rx, U.FL1 disabled";
-			*data |= ICE_SMA1_TX_EN;
-		} else if (sma_pins[SMA1 - 1] == PTP_PF_PEROUT) {
-			state1 = "SMA1 Tx U.FL1 disabled";
-			*data |= ICE_SMA1_DIR_EN;
-		} else {
-			state1 = "SMA1 disabled, U.FL1 disabled";
-			*data |= ICE_SMA1_MASK;
-		}
-	} else {
-		/* U.FL1 Tx will always enable SMA1 Rx */
-		state1 = "SMA1 Rx, U.FL1 Tx";
-	}
-
-	if (!sma_pins[UFL2 - 1]) {
-		if (sma_pins[SMA2 - 1] == PTP_PF_EXTTS) {
-			state2 = "SMA2 Rx, U.FL2 disabled";
-			*data |= ICE_SMA2_TX_EN | ICE_SMA2_UFL2_RX_DIS;
-		} else if (sma_pins[SMA2 - 1] == PTP_PF_PEROUT) {
-			state2 = "SMA2 Tx, U.FL2 disabled";
-			*data |= ICE_SMA2_DIR_EN | ICE_SMA2_UFL2_RX_DIS;
-		} else {
-			state2 = "SMA2 disabled, U.FL2 disabled";
-			*data |= ICE_SMA2_MASK;
-		}
-	} else {
-		if (!sma_pins[SMA2 - 1]) {
-			state2 = "SMA2 disabled, U.FL2 Rx";
-			*data |= ICE_SMA2_DIR_EN | ICE_SMA2_TX_EN;
-		} else {
-			state2 = "SMA2 Tx, U.FL2 Rx";
-			*data |= ICE_SMA2_DIR_EN;
-		}
-	}
-
-	dev_dbg(ice_pf_to_dev(pf), "%s, %s\n", state1, state2);
-}
-
-/**
- * ice_ptp_set_sma_cfg - set the configuration of the SMA control logic
- * @pf: Board private structure
- *
- * Return: 0 on success, negative error code otherwise
- */
-static int ice_ptp_set_sma_cfg(struct ice_pf *pf)
-{
-	const struct ice_ptp_pin_desc *ice_pins = pf->ptp.ice_pin_desc;
-	struct ptp_pin_desc *pins = pf->ptp.pin_desc;
-	unsigned int sma_pins[ICE_SMA_PINS_NUM] = {};
-	int err;
-	u8 data;
-
-	/* Read initial pin state value */
-	err = ice_read_sma_ctrl(&pf->hw, &data);
-	if (err)
-		return err;
-
-	/* Get SMA/U.FL pins states */
-	for (int i = 0; i < pf->ptp.info.n_pins; i++)
-		if (pins[i].func) {
-			int name_idx = ice_pins[i].name_idx;
-
-			switch (name_idx) {
-			case SMA1:
-			case UFL1:
-			case SMA2:
-			case UFL2:
-				sma_pins[name_idx - 1] = pins[i].func;
-				break;
-			default:
-				continue;
-			}
-		}
-
-	ice_ptp_update_sma_data(pf, sma_pins, &data);
-	return ice_write_sma_ctrl(&pf->hw, data);
-}
-
 /**
  * ice_ptp_cfg_tx_interrupt - Configure Tx timestamp interrupt for the device
  * @pf: Board private structure
@@ -1878,63 +1781,6 @@ static void ice_ptp_enable_all_perout(struct ice_pf *pf)
 					   true);
 }
 
-/**
- * ice_ptp_disable_shared_pin - Disable enabled pin that shares GPIO
- * @pf: Board private structure
- * @pin: Pin index
- * @func: Assigned function
- *
- * Return: 0 on success, negative error code otherwise
- */
-static int ice_ptp_disable_shared_pin(struct ice_pf *pf, unsigned int pin,
-				      enum ptp_pin_function func)
-{
-	unsigned int gpio_pin;
-
-	switch (func) {
-	case PTP_PF_PEROUT:
-		gpio_pin = pf->ptp.ice_pin_desc[pin].gpio[1];
-		break;
-	case PTP_PF_EXTTS:
-		gpio_pin = pf->ptp.ice_pin_desc[pin].gpio[0];
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	for (unsigned int i = 0; i < pf->ptp.info.n_pins; i++) {
-		struct ptp_pin_desc *pin_desc = &pf->ptp.pin_desc[i];
-		unsigned int chan = pin_desc->chan;
-
-		/* Skip pin idx from the request */
-		if (i == pin)
-			continue;
-
-		if (pin_desc->func == PTP_PF_PEROUT &&
-		    pf->ptp.ice_pin_desc[i].gpio[1] == gpio_pin) {
-			pf->ptp.perout_rqs[chan].period.sec = 0;
-			pf->ptp.perout_rqs[chan].period.nsec = 0;
-			pin_desc->func = PTP_PF_NONE;
-			pin_desc->chan = 0;
-			dev_dbg(ice_pf_to_dev(pf), "Disabling pin %u with shared output GPIO pin %u\n",
-				i, gpio_pin);
-			return ice_ptp_cfg_perout(pf, &pf->ptp.perout_rqs[chan],
-						  false);
-		} else if (pf->ptp.pin_desc->func == PTP_PF_EXTTS &&
-			   pf->ptp.ice_pin_desc[i].gpio[0] == gpio_pin) {
-			pf->ptp.extts_rqs[chan].flags &= ~PTP_ENABLE_FEATURE;
-			pin_desc->func = PTP_PF_NONE;
-			pin_desc->chan = 0;
-			dev_dbg(ice_pf_to_dev(pf), "Disabling pin %u with shared input GPIO pin %u\n",
-				i, gpio_pin);
-			return ice_ptp_cfg_extts(pf, &pf->ptp.extts_rqs[chan],
-						 false);
-		}
-	}
-
-	return 0;
-}
-
 /**
  * ice_verify_pin - verify if pin supports requested pin function
  * @info: the driver's PTP info structure
@@ -1969,14 +1815,6 @@ static int ice_verify_pin(struct ptp_clock_info *info, unsigned int pin,
 		return -EOPNOTSUPP;
 	}
 
-	/* On adapters with SMA_CTRL disable other pins that share same GPIO */
-	if (ice_is_feature_supported(pf, ICE_F_SMA_CTRL)) {
-		ice_ptp_disable_shared_pin(pf, pin, func);
-		pf->ptp.pin_desc[pin].func = func;
-		pf->ptp.pin_desc[pin].chan = chan;
-		return ice_ptp_set_sma_cfg(pf);
-	}
-
 	return 0;
 }
 
@@ -2499,14 +2337,14 @@ static void ice_ptp_setup_pin_cfg(struct ice_pf *pf)
 	for (unsigned int i = 0; i < pf->ptp.info.n_pins; i++) {
 		const struct ice_ptp_pin_desc *desc = &pf->ptp.ice_pin_desc[i];
 		struct ptp_pin_desc *pin = &pf->ptp.pin_desc[i];
-		const char *name = NULL;
+		const char *name;
 
 		if (!ice_is_feature_supported(pf, ICE_F_SMA_CTRL))
 			name = ice_pin_names[desc->name_idx];
-		else if (desc->name_idx != GPIO_NA)
-			name = ice_pin_names_nvm[desc->name_idx];
-		if (name)
-			strscpy(pin->name, name, sizeof(pin->name));
+		else
+			name = ice_pin_names_dpll[desc->name_idx];
+
+		strscpy(pin->name, name, sizeof(pin->name));
 
 		pin->index = i;
 	}
@@ -2518,8 +2356,8 @@ static void ice_ptp_setup_pin_cfg(struct ice_pf *pf)
  * ice_ptp_disable_pins - Disable PTP pins
  * @pf: pointer to the PF structure
  *
- * Disable the OS access to the SMA pins. Called to clear out the OS
- * indications of pin support when we fail to setup the SMA control register.
+ * Disable the OS access to the pins. Called to clear out the OS
+ * indications of pin support when we fail to setup pin array.
  */
 static void ice_ptp_disable_pins(struct ice_pf *pf)
 {
@@ -2560,40 +2398,30 @@ static int ice_ptp_parse_sdp_entries(struct ice_pf *pf, __le16 *entries,
 	for (i = 0; i < num_entries; i++) {
 		u16 entry = le16_to_cpu(entries[i]);
 		DECLARE_BITMAP(bitmap, GPIO_NA);
-		unsigned int bitmap_idx;
+		unsigned int idx;
 		bool dir;
 		u16 gpio;
 
 		*bitmap = FIELD_GET(ICE_AQC_NVM_SDP_AC_PIN_M, entry);
+
+		/* Check if entry's pin bitmap is valid. */
+		if (bitmap_empty(bitmap, GPIO_NA))
+			continue;
+
 		dir = !!FIELD_GET(ICE_AQC_NVM_SDP_AC_DIR_M, entry);
 		gpio = FIELD_GET(ICE_AQC_NVM_SDP_AC_SDP_NUM_M, entry);
-		for_each_set_bit(bitmap_idx, bitmap, GPIO_NA + 1) {
-			unsigned int idx;
-
-			/* Check if entry's pin bit is valid */
-			if (bitmap_idx >= NUM_PTP_PINS_NVM &&
-			    bitmap_idx != GPIO_NA)
-				continue;
 
-			/* Check if pin already exists */
-			for (idx = 0; idx < ICE_N_PINS_MAX; idx++)
-				if (pins[idx].name_idx == bitmap_idx)
-					break;
-
-			if (idx == ICE_N_PINS_MAX) {
-				/* Pin not found, setup its entry and name */
-				idx = n_pins++;
-				pins[idx].name_idx = bitmap_idx;
-				if (bitmap_idx == GPIO_NA)
-					strscpy(pf->ptp.pin_desc[idx].name,
-						ice_pin_names[gpio],
-						sizeof(pf->ptp.pin_desc[idx]
-							       .name));
-			}
+		for (idx = 0; idx < ICE_N_PINS_MAX; idx++) {
+			if (pins[idx].name_idx == gpio)
+				break;
+		}
 
-			/* Setup in/out GPIO number */
-			pins[idx].gpio[dir] = gpio;
+		if (idx == ICE_N_PINS_MAX) {
+			/* Pin not found, setup its entry and name */
+			idx = n_pins++;
+			pins[idx].name_idx = gpio;
 		}
+		pins[idx].gpio[dir] = gpio;
 	}
 
 	for (i = 0; i < n_pins; i++) {
@@ -2621,10 +2449,10 @@ static void ice_ptp_set_funcs_e82x(struct ice_pf *pf)
 
 	if (pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825) {
 		pf->ptp.ice_pin_desc = ice_pin_desc_e825c;
-		pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e825c);
+		pf->ptp.info.n_pins = ARRAY_SIZE(ice_pin_desc_e825c);
 	} else {
 		pf->ptp.ice_pin_desc = ice_pin_desc_e82x;
-		pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e82x);
+		pf->ptp.info.n_pins = ARRAY_SIZE(ice_pin_desc_e82x);
 	}
 	ice_ptp_setup_pin_cfg(pf);
 }
@@ -2650,15 +2478,13 @@ static void ice_ptp_set_funcs_e810(struct ice_pf *pf)
 	if (err) {
 		/* SDP section does not exist in NVM or is corrupted */
 		if (ice_is_feature_supported(pf, ICE_F_SMA_CTRL)) {
-			ptp->ice_pin_desc = ice_pin_desc_e810_sma;
-			ptp->info.n_pins =
-				ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e810_sma);
+			ptp->ice_pin_desc = ice_pin_desc_dpll;
+			ptp->info.n_pins = ARRAY_SIZE(ice_pin_desc_dpll);
 		} else {
 			pf->ptp.ice_pin_desc = ice_pin_desc_e810;
-			pf->ptp.info.n_pins =
-				ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e810);
-			err = 0;
+			pf->ptp.info.n_pins = ARRAY_SIZE(ice_pin_desc_e810);
 		}
+		err = 0;
 	} else {
 		desc = devm_kcalloc(ice_pf_to_dev(pf), ICE_N_PINS_MAX,
 				    sizeof(struct ice_ptp_pin_desc),
@@ -2676,8 +2502,6 @@ static void ice_ptp_set_funcs_e810(struct ice_pf *pf)
 	ptp->info.pin_config = ptp->pin_desc;
 	ice_ptp_setup_pin_cfg(pf);
 
-	if (ice_is_feature_supported(pf, ICE_F_SMA_CTRL))
-		err = ice_ptp_set_sma_cfg(pf);
 err:
 	if (err) {
 		devm_kfree(ice_pf_to_dev(pf), desc);
@@ -2703,7 +2527,7 @@ static void ice_ptp_set_funcs_e830(struct ice_pf *pf)
 #endif /* CONFIG_ICE_HWTS */
 	/* Rest of the config is the same as base E810 */
 	pf->ptp.ice_pin_desc = ice_pin_desc_e810;
-	pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e810);
+	pf->ptp.info.n_pins = ARRAY_SIZE(ice_pin_desc_e810);
 	ice_ptp_setup_pin_cfg(pf);
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 3b769a0cad00..c8dac5a5bcd9 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -202,9 +202,6 @@ enum ice_ptp_pin_nvm {
 
 /* Pin definitions for PTP */
 #define ICE_N_PINS_MAX			6
-#define ICE_SMA_PINS_NUM		4
-#define ICE_PIN_DESC_ARR_LEN(_arr)	(sizeof(_arr) / \
-					 sizeof(struct ice_ptp_pin_desc))
 
 /**
  * struct ice_ptp_pin_desc - hardware pin description data
-- 
2.47.1


