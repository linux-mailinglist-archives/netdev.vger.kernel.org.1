Return-Path: <netdev+bounces-116803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C9F94BC3F
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DFEA1F21258
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6497018C911;
	Thu,  8 Aug 2024 11:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m6gT3NqQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6840C18C347;
	Thu,  8 Aug 2024 11:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723116292; cv=none; b=qqXfjXrMXraEC+jjBAeNQ4MskBpqQDYnVeh12y6VYKCFdSWXaVM7sIW/piUxY8HjKinpIQ5aTrqUEVuAkqGlWGr9+GbfbqNKNQUvS5yBwj9nxZaOQwahrjYJoNBGaOaDfxF+Nqd9P1gIQr0m87ieIP+C3N/Gfk9RxdYThRXDJ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723116292; c=relaxed/simple;
	bh=ApWPWIRVl2oIsyFjG5glWYXDz0u5DrPryJFiIIVnv2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MGJwke3N1vrVQF4X7qgsSFkOWCRwjlyoUBfxH1OuugUjpUpuPFF67Sbq/Afd51TFEDV8n3JnCkFVo+dH2oQNJqPDeBtT6CB9Tm+h4n4OApVNBvUZGST2S9tnIfWcWxmwx1CjkzlGMpOoRXXnaTE/jcx9HrjIcUvKPgJHVl3j3hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m6gT3NqQ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723116291; x=1754652291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ApWPWIRVl2oIsyFjG5glWYXDz0u5DrPryJFiIIVnv2o=;
  b=m6gT3NqQxVnm46SgN2hjKBWlNS+2mMET9tHSAFpmV/eKWsGTRsbg4h8p
   ttK2lUlZc6tqcbgLfJMYILNAF5cpE0R5pKIj0MH9b82hwG1YyGAKVcpzj
   0z8Zx6VqqsrP1tJBLj4tiy9/DRUAmvs0C0dRACC4oBW8ikMrPqBwHjViY
   zpaHCeMJDaZEeITeUsk/VvlhDR+37XxGroEB5lVc+0L9Q9E5LvkC4R5IY
   liDNSF/BvBjzYLURtTv2WPB3hPEIRltzIoDfiKObxACpXgvLpkoMQPW+s
   lH5JZobhKpFzEP9XNb+voNWm98VKkc1MlGrivbCrzJAgVxwXcrXA9UKbD
   Q==;
X-CSE-ConnectionGUID: l/LgPqkZTVe2VOxLg5J4wQ==
X-CSE-MsgGUID: IEOT9iN2S5GMwkL3psvtfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="38741871"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="38741871"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 04:24:50 -0700
X-CSE-ConnectionGUID: d/VmH1cuRFuZi5QPxWl9mA==
X-CSE-MsgGUID: siorjTixTtOr3IqGPbWoJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="61574922"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmviesa005.fm.intel.com with ESMTP; 08 Aug 2024 04:24:46 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v1 2/2] ice: add callbacks for Embedded SYNC enablement on dpll pins
Date: Thu,  8 Aug 2024 13:20:13 +0200
Message-Id: <20240808112013.166621-3-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240808112013.166621-1-arkadiusz.kubalewski@intel.com>
References: <20240808112013.166621-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the user to get and set configuration of Embedded SYNC feature
on the ice driver dpll pins.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 241 +++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_dpll.h |   1 +
 2 files changed, 239 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index e92be6f130a3..0664bbe98769 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -394,8 +394,8 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
 
 	switch (pin_type) {
 	case ICE_DPLL_PIN_TYPE_INPUT:
-		ret = ice_aq_get_input_pin_cfg(&pf->hw, pin->idx, NULL, NULL,
-					       NULL, &pin->flags[0],
+		ret = ice_aq_get_input_pin_cfg(&pf->hw, pin->idx, &pin->status,
+					       NULL, NULL, &pin->flags[0],
 					       &pin->freq, &pin->phase_adjust);
 		if (ret)
 			goto err;
@@ -430,7 +430,7 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
 			goto err;
 
 		parent &= ICE_AQC_GET_CGU_OUT_CFG_DPLL_SRC_SEL;
-		if (ICE_AQC_SET_CGU_OUT_CFG_OUT_EN & pin->flags[0]) {
+		if (ICE_AQC_GET_CGU_OUT_CFG_OUT_EN & pin->flags[0]) {
 			pin->state[pf->dplls.eec.dpll_idx] =
 				parent == pf->dplls.eec.dpll_idx ?
 				DPLL_PIN_STATE_CONNECTED :
@@ -1098,6 +1098,237 @@ ice_dpll_phase_offset_get(const struct dpll_pin *pin, void *pin_priv,
 	return 0;
 }
 
+/**
+ * ice_dpll_output_e_sync_set - callback for setting embedded sync
+ * @pin: pointer to a pin
+ * @pin_priv: private data pointer passed on pin registration
+ * @dpll: registered dpll pointer
+ * @dpll_priv: private data pointer passed on dpll registration
+ * @e_sync_freq: requested embedded sync frequency
+ * @extack: error reporting
+ *
+ * Dpll subsystem callback. Handler for setting embedded sync frequency value
+ * on output pin.
+ *
+ * Context: Acquires pf->dplls.lock
+ * Return:
+ * * 0 - success
+ * * negative - error
+ */
+static int
+ice_dpll_output_e_sync_set(const struct dpll_pin *pin, void *pin_priv,
+			   const struct dpll_device *dpll, void *dpll_priv,
+			   u64 e_sync_freq, struct netlink_ext_ack *extack)
+{
+	struct ice_dpll_pin *p = pin_priv;
+	struct ice_dpll *d = dpll_priv;
+	struct ice_pf *pf = d->pf;
+	u8 flags = 0;
+	int ret;
+
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+	mutex_lock(&pf->dplls.lock);
+	if (p->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_OUT_EN)
+		flags = ICE_AQC_SET_CGU_OUT_CFG_OUT_EN;
+	if (e_sync_freq == DPLL_PIN_FREQUENCY_1_HZ) {
+		if (p->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_ESYNC_EN) {
+			ret = 0;
+		} else {
+			flags |= ICE_AQC_SET_CGU_OUT_CFG_ESYNC_EN;
+			ret = ice_aq_set_output_pin_cfg(&pf->hw, p->idx, flags,
+							0, 0, 0);
+		}
+	} else {
+		if (!(p->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_ESYNC_EN)) {
+			ret = 0;
+		} else {
+			flags &= ~ICE_AQC_SET_CGU_OUT_CFG_ESYNC_EN;
+			ret = ice_aq_set_output_pin_cfg(&pf->hw, p->idx, flags,
+							0, 0, 0);
+		}
+	}
+	mutex_unlock(&pf->dplls.lock);
+	if (ret)
+		NL_SET_ERR_MSG_FMT(extack,
+				   "err:%d %s failed to set e-sync freq\n",
+				   ret,
+				   ice_aq_str(pf->hw.adminq.sq_last_status));
+	return ret;
+}
+
+/**
+ * ice_dpll_output_e_sync_get - callback for getting embedded sync config
+ * @pin: pointer to a pin
+ * @pin_priv: private data pointer passed on pin registration
+ * @dpll: registered dpll pointer
+ * @dpll_priv: private data pointer passed on dpll registration
+ * @e_sync_freq: on success holds embedded sync frequency of a pin
+ * @e_sync_range: on success holds embedded sync frequency range for a pin
+ * @pulse: on success holds embedded sync pulse type
+ * @extack: error reporting
+ *
+ * Dpll subsystem callback. Handler for getting embedded sync frequency value
+ * and capabilities on output pin.
+ *
+ * Context: Acquires pf->dplls.lock
+ * Return:
+ * * 0 - success
+ * * negative - error
+ */
+static int
+ice_dpll_output_e_sync_get(const struct dpll_pin *pin, void *pin_priv,
+			   const struct dpll_device *dpll, void *dpll_priv,
+			   u64 *e_sync_freq,
+			   struct dpll_pin_frequency *e_sync_range,
+			   enum dpll_pin_e_sync_pulse *pulse,
+			   struct netlink_ext_ack *extack)
+{
+	struct ice_dpll_pin *p = pin_priv;
+	struct ice_dpll *d = dpll_priv;
+	struct ice_pf *pf = d->pf;
+
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+	mutex_lock(&pf->dplls.lock);
+	if (!(p->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_ESYNC_ABILITY)) {
+		mutex_unlock(&pf->dplls.lock);
+		return -EOPNOTSUPP;
+	}
+	*pulse = DPLL_PIN_E_SYNC_PULSE_NONE;
+	e_sync_range->min = 0;
+	if (p->freq == DPLL_PIN_FREQUENCY_10_MHZ) {
+		e_sync_range->max = DPLL_PIN_FREQUENCY_1_HZ;
+		if (p->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_ESYNC_EN) {
+			*e_sync_freq = DPLL_PIN_FREQUENCY_1_HZ;
+			*pulse = DPLL_PIN_E_SYNC_PULSE_25_75;
+		} else {
+			*e_sync_freq = 0;
+		}
+	} else {
+		e_sync_range->max = 0;
+		*e_sync_freq = 0;
+	}
+	mutex_unlock(&pf->dplls.lock);
+	return 0;
+}
+
+/**
+ * ice_dpll_input_e_sync_set - callback for setting embedded sync
+ * @pin: pointer to a pin
+ * @pin_priv: private data pointer passed on pin registration
+ * @dpll: registered dpll pointer
+ * @dpll_priv: private data pointer passed on dpll registration
+ * @e_sync_freq: requested embedded sync frequency
+ * @extack: error reporting
+ *
+ * Dpll subsystem callback. Handler for setting embedded sync frequency value
+ * on input pin.
+ *
+ * Context: Acquires pf->dplls.lock
+ * Return:
+ * * 0 - success
+ * * negative - error
+ */
+static int
+ice_dpll_input_e_sync_set(const struct dpll_pin *pin, void *pin_priv,
+			  const struct dpll_device *dpll, void *dpll_priv,
+			  u64 e_sync_freq, struct netlink_ext_ack *extack)
+{
+	struct ice_dpll_pin *p = pin_priv;
+	struct ice_dpll *d = dpll_priv;
+	struct ice_pf *pf = d->pf;
+	u8 flags_en = 0;
+	int ret;
+
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+	mutex_lock(&pf->dplls.lock);
+	if (p->flags[0] & ICE_AQC_GET_CGU_IN_CFG_FLG2_INPUT_EN)
+		flags_en = ICE_AQC_SET_CGU_IN_CFG_FLG2_INPUT_EN;
+	if (e_sync_freq == DPLL_PIN_FREQUENCY_1_HZ) {
+		if (p->flags[0] & ICE_AQC_GET_CGU_IN_CFG_FLG2_ESYNC_EN) {
+			ret = 0;
+		} else {
+			flags_en |= ICE_AQC_SET_CGU_IN_CFG_FLG2_ESYNC_EN;
+			ret = ice_aq_set_input_pin_cfg(&pf->hw, p->idx, 0,
+						       flags_en, 0, 0);
+		}
+	} else {
+		if (!(p->flags[0] & ICE_AQC_GET_CGU_IN_CFG_FLG2_ESYNC_EN)) {
+			ret = 0;
+		} else {
+			flags_en &= ~ICE_AQC_SET_CGU_IN_CFG_FLG2_ESYNC_EN;
+			ret = ice_aq_set_input_pin_cfg(&pf->hw, p->idx, 0,
+						       flags_en, 0, 0);
+		}
+	}
+	mutex_unlock(&pf->dplls.lock);
+	if (ret)
+		NL_SET_ERR_MSG_FMT(extack,
+				   "err:%d %s failed to set e-sync freq\n",
+				   ret,
+				   ice_aq_str(pf->hw.adminq.sq_last_status));
+
+	return ret;
+}
+
+/**
+ * ice_dpll_input_e_sync_get - callback for getting embedded sync config
+ * @pin: pointer to a pin
+ * @pin_priv: private data pointer passed on pin registration
+ * @dpll: registered dpll pointer
+ * @dpll_priv: private data pointer passed on dpll registration
+ * @e_sync_freq: on success holds embedded sync frequency of a pin
+ * @e_sync_range: on success holds embedded sync frequency range for a pin
+ * @pulse: on success holds embedded sync pulse type
+ * @extack: error reporting
+ *
+ * Dpll subsystem callback. Handler for getting embedded sync frequency value
+ * and capabilities on input pin.
+ *
+ * Context: Acquires pf->dplls.lock
+ * Return:
+ * * 0 - success
+ * * negative - error
+ */
+static int
+ice_dpll_input_e_sync_get(const struct dpll_pin *pin, void *pin_priv,
+			  const struct dpll_device *dpll, void *dpll_priv,
+			  u64 *e_sync_freq,
+			  struct dpll_pin_frequency *e_sync_range,
+			  enum dpll_pin_e_sync_pulse *pulse,
+			  struct netlink_ext_ack *extack)
+{
+	struct ice_dpll_pin *p = pin_priv;
+	struct ice_dpll *d = dpll_priv;
+	struct ice_pf *pf = d->pf;
+
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+	mutex_lock(&pf->dplls.lock);
+	if (!(p->status & ICE_AQC_GET_CGU_IN_CFG_STATUS_ESYNC_CAP)) {
+		mutex_unlock(&pf->dplls.lock);
+		return -EOPNOTSUPP;
+	}
+	*pulse = DPLL_PIN_E_SYNC_PULSE_NONE;
+	e_sync_range->min = 0;
+	if (p->freq == DPLL_PIN_FREQUENCY_10_MHZ) {
+		e_sync_range->max = DPLL_PIN_FREQUENCY_1_HZ;
+		if (p->flags[0] & ICE_AQC_GET_CGU_IN_CFG_FLG2_ESYNC_EN) {
+			*e_sync_freq = DPLL_PIN_FREQUENCY_1_HZ;
+			*pulse = DPLL_PIN_E_SYNC_PULSE_25_75;
+		} else {
+			*e_sync_freq = 0;
+		}
+	} else {
+		e_sync_range->max = 0;
+		*e_sync_freq = 0;
+	}
+	mutex_unlock(&pf->dplls.lock);
+	return 0;
+}
+
 /**
  * ice_dpll_rclk_state_on_pin_set - set a state on rclk pin
  * @pin: pointer to a pin
@@ -1222,6 +1453,8 @@ static const struct dpll_pin_ops ice_dpll_input_ops = {
 	.phase_adjust_get = ice_dpll_pin_phase_adjust_get,
 	.phase_adjust_set = ice_dpll_input_phase_adjust_set,
 	.phase_offset_get = ice_dpll_phase_offset_get,
+	.e_sync_set = ice_dpll_input_e_sync_set,
+	.e_sync_get = ice_dpll_input_e_sync_get,
 };
 
 static const struct dpll_pin_ops ice_dpll_output_ops = {
@@ -1232,6 +1465,8 @@ static const struct dpll_pin_ops ice_dpll_output_ops = {
 	.direction_get = ice_dpll_output_direction,
 	.phase_adjust_get = ice_dpll_pin_phase_adjust_get,
 	.phase_adjust_set = ice_dpll_output_phase_adjust_set,
+	.e_sync_set = ice_dpll_output_e_sync_set,
+	.e_sync_get = ice_dpll_output_e_sync_get,
 };
 
 static const struct dpll_device_ops ice_dpll_ops = {
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
index 93172e93995b..c320f1bf7d6d 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -31,6 +31,7 @@ struct ice_dpll_pin {
 	struct dpll_pin_properties prop;
 	u32 freq;
 	s32 phase_adjust;
+	u8 status;
 };
 
 /** ice_dpll - store info required for DPLL control
-- 
2.38.1


