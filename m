Return-Path: <netdev+bounces-222311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B85DB53D71
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 23:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF6847AA738
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 21:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478F126FA54;
	Thu, 11 Sep 2025 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FL+jwE0q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ACC1DA55
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 21:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757624739; cv=none; b=tyoeTB/Hwc2Mux1sOhZ2VYQqUfBwo5TcupD8qOK2sIA3t6p87XEX2GAUCX188NGNooKDdwD323GG+XiCoxXRw+MnpE5nRo4tADkRXRH/6xa3ba0PxJuCyyel2B4TEQw9WVck6nTAHO5Jf7HyTJl8L/t65kkVytfT3PGrcvZmuoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757624739; c=relaxed/simple;
	bh=PU7vShzjuJMlHV4S2BxbLN/wuncRF2KfsNIyttCU5WI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MimjFoAfjvR37cMChmsSs77cI54zxylllMT1pDRnxwY7dE1j/T2C4rQMUEOqWO0oXzTCCt+g6aLuGiBIfSpSDnJjW/joBYyGmhUgGj6IuANOe7zHbDuxKSfggOiNTgJR3kXHtLrmZmLY6y8N2uyMtTaxAS/U+tqE+hlTLyHrta0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FL+jwE0q; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757624738; x=1789160738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PU7vShzjuJMlHV4S2BxbLN/wuncRF2KfsNIyttCU5WI=;
  b=FL+jwE0qntLyCyxXqW7AKLccQwJx+CTeah/kX3EDZeYl9Of/gsvL36uZ
   6oTB5faycOFJjHWnK4TFwexlqU2ceBLxhbDuo0SK6UoQBXDLC+k1oeh+Y
   +xUSMpJBLVlLFL2PFVSnnehRCQ7NF/kpfYbYYV75Q4wc+WPxIabNC8OCP
   g3z9MlUSAQXReZ9CMg/OA8H5QEqMOfnW5JEq5oCOyI/LKZsqKW0QA2GlT
   CshYlzDDo1yIxIV1bAYaKfKqNUJY4PTL+7XHhZ7TU0y3ThQxptHGjUTnd
   E2V0EmK+/sS2VmyKIzJTtB7K10+JGFwA1pfhJ+y+k/90aFhsj9zbwMCc8
   Q==;
X-CSE-ConnectionGUID: NPV2WKuLTie2me7KNA3IGg==
X-CSE-MsgGUID: oJdobUTDS2+Q1IoPVCKo/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="82558843"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="82558843"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 14:05:36 -0700
X-CSE-ConnectionGUID: So/uAjGOQdCOnBP84vXU5g==
X-CSE-MsgGUID: xYQIBT9EQCe8eYP71WfbZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="174583329"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 11 Sep 2025 14:05:35 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	horms@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next 01/15] ice: make fwlog functions static
Date: Thu, 11 Sep 2025 14:05:00 -0700
Message-ID: <20250911210525.345110-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250911210525.345110-1-anthony.l.nguyen@intel.com>
References: <20250911210525.345110-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

ice_fwlog_supported(), ice_fwlog_get() and ice_fwlog_supported() aren't
called outside the ice_fwlog.c file. Make it static and move in the file
to allow clean build.

Drop ice_fwlog_get(). It is called only from ice_fwlog_init() function
where the fwlog support is already checked. There is no need to check it
again, call ice_aq_fwlog_get() instead.

Drop no longer valid comment from ice_fwlog_get_supported().

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_fwlog.c | 232 ++++++++++-----------
 drivers/net/ethernet/intel/ice/ice_fwlog.h |   5 +-
 2 files changed, 109 insertions(+), 128 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.c b/drivers/net/ethernet/intel/ice/ice_fwlog.c
index a31bb026ad34..e48856206648 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.c
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.c
@@ -123,6 +123,113 @@ void ice_fwlog_realloc_rings(struct ice_hw *hw, int index)
 	hw->fwlog_ring.tail = 0;
 }
 
+/**
+ * ice_fwlog_supported - Cached for whether FW supports FW logging or not
+ * @hw: pointer to the HW structure
+ *
+ * This will always return false if called before ice_init_hw(), so it must be
+ * called after ice_init_hw().
+ */
+static bool ice_fwlog_supported(struct ice_hw *hw)
+{
+	return hw->fwlog_supported;
+}
+
+/**
+ * ice_aq_fwlog_get - Get the current firmware logging configuration (0xFF32)
+ * @hw: pointer to the HW structure
+ * @cfg: firmware logging configuration to populate
+ */
+static int ice_aq_fwlog_get(struct ice_hw *hw, struct ice_fwlog_cfg *cfg)
+{
+	struct ice_aqc_fw_log_cfg_resp *fw_modules;
+	struct ice_aqc_fw_log *cmd;
+	struct libie_aq_desc desc;
+	u16 module_id_cnt;
+	int status;
+	void *buf;
+	int i;
+
+	memset(cfg, 0, sizeof(*cfg));
+
+	buf = kzalloc(ICE_AQ_MAX_BUF_LEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_fw_logs_query);
+	cmd = libie_aq_raw(&desc);
+
+	cmd->cmd_flags = ICE_AQC_FW_LOG_AQ_QUERY;
+
+	status = ice_aq_send_cmd(hw, &desc, buf, ICE_AQ_MAX_BUF_LEN, NULL);
+	if (status) {
+		ice_debug(hw, ICE_DBG_FW_LOG, "Failed to get FW log configuration\n");
+		goto status_out;
+	}
+
+	module_id_cnt = le16_to_cpu(cmd->ops.cfg.mdl_cnt);
+	if (module_id_cnt < ICE_AQC_FW_LOG_ID_MAX) {
+		ice_debug(hw, ICE_DBG_FW_LOG, "FW returned less than the expected number of FW log module IDs\n");
+	} else if (module_id_cnt > ICE_AQC_FW_LOG_ID_MAX) {
+		ice_debug(hw, ICE_DBG_FW_LOG, "FW returned more than expected number of FW log module IDs, setting module_id_cnt to software expected max %u\n",
+			  ICE_AQC_FW_LOG_ID_MAX);
+		module_id_cnt = ICE_AQC_FW_LOG_ID_MAX;
+	}
+
+	cfg->log_resolution = le16_to_cpu(cmd->ops.cfg.log_resolution);
+	if (cmd->cmd_flags & ICE_AQC_FW_LOG_CONF_AQ_EN)
+		cfg->options |= ICE_FWLOG_OPTION_ARQ_ENA;
+	if (cmd->cmd_flags & ICE_AQC_FW_LOG_CONF_UART_EN)
+		cfg->options |= ICE_FWLOG_OPTION_UART_ENA;
+	if (cmd->cmd_flags & ICE_AQC_FW_LOG_QUERY_REGISTERED)
+		cfg->options |= ICE_FWLOG_OPTION_IS_REGISTERED;
+
+	fw_modules = (struct ice_aqc_fw_log_cfg_resp *)buf;
+
+	for (i = 0; i < module_id_cnt; i++) {
+		struct ice_aqc_fw_log_cfg_resp *fw_module = &fw_modules[i];
+
+		cfg->module_entries[i].module_id =
+			le16_to_cpu(fw_module->module_identifier);
+		cfg->module_entries[i].log_level = fw_module->log_level;
+	}
+
+status_out:
+	kfree(buf);
+	return status;
+}
+
+/**
+ * ice_fwlog_set_supported - Set if FW logging is supported by FW
+ * @hw: pointer to the HW struct
+ *
+ * If FW returns success to the ice_aq_fwlog_get call then it supports FW
+ * logging, else it doesn't. Set the fwlog_supported flag accordingly.
+ *
+ * This function is only meant to be called during driver init to determine if
+ * the FW support FW logging.
+ */
+static void ice_fwlog_set_supported(struct ice_hw *hw)
+{
+	struct ice_fwlog_cfg *cfg;
+	int status;
+
+	hw->fwlog_supported = false;
+
+	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
+	if (!cfg)
+		return;
+
+	status = ice_aq_fwlog_get(hw, cfg);
+	if (status)
+		ice_debug(hw, ICE_DBG_FW_LOG, "ice_aq_fwlog_get failed, FW logging is not supported on this version of FW, status %d\n",
+			  status);
+	else
+		hw->fwlog_supported = true;
+
+	kfree(cfg);
+}
+
 /**
  * ice_fwlog_init - Initialize FW logging configuration
  * @hw: pointer to the HW structure
@@ -142,7 +249,7 @@ int ice_fwlog_init(struct ice_hw *hw)
 		int status;
 
 		/* read the current config from the FW and store it */
-		status = ice_fwlog_get(hw, &hw->fwlog_cfg);
+		status = ice_aq_fwlog_get(hw, &hw->fwlog_cfg);
 		if (status)
 			return status;
 
@@ -214,18 +321,6 @@ void ice_fwlog_deinit(struct ice_hw *hw)
 	}
 }
 
-/**
- * ice_fwlog_supported - Cached for whether FW supports FW logging or not
- * @hw: pointer to the HW structure
- *
- * This will always return false if called before ice_init_hw(), so it must be
- * called after ice_init_hw().
- */
-bool ice_fwlog_supported(struct ice_hw *hw)
-{
-	return hw->fwlog_supported;
-}
-
 /**
  * ice_aq_fwlog_set - Set FW logging configuration AQ command (0xFF30)
  * @hw: pointer to the HW structure
@@ -300,83 +395,6 @@ int ice_fwlog_set(struct ice_hw *hw, struct ice_fwlog_cfg *cfg)
 				cfg->log_resolution);
 }
 
-/**
- * ice_aq_fwlog_get - Get the current firmware logging configuration (0xFF32)
- * @hw: pointer to the HW structure
- * @cfg: firmware logging configuration to populate
- */
-static int ice_aq_fwlog_get(struct ice_hw *hw, struct ice_fwlog_cfg *cfg)
-{
-	struct ice_aqc_fw_log_cfg_resp *fw_modules;
-	struct ice_aqc_fw_log *cmd;
-	struct libie_aq_desc desc;
-	u16 module_id_cnt;
-	int status;
-	void *buf;
-	int i;
-
-	memset(cfg, 0, sizeof(*cfg));
-
-	buf = kzalloc(ICE_AQ_MAX_BUF_LEN, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_fw_logs_query);
-	cmd = libie_aq_raw(&desc);
-
-	cmd->cmd_flags = ICE_AQC_FW_LOG_AQ_QUERY;
-
-	status = ice_aq_send_cmd(hw, &desc, buf, ICE_AQ_MAX_BUF_LEN, NULL);
-	if (status) {
-		ice_debug(hw, ICE_DBG_FW_LOG, "Failed to get FW log configuration\n");
-		goto status_out;
-	}
-
-	module_id_cnt = le16_to_cpu(cmd->ops.cfg.mdl_cnt);
-	if (module_id_cnt < ICE_AQC_FW_LOG_ID_MAX) {
-		ice_debug(hw, ICE_DBG_FW_LOG, "FW returned less than the expected number of FW log module IDs\n");
-	} else if (module_id_cnt > ICE_AQC_FW_LOG_ID_MAX) {
-		ice_debug(hw, ICE_DBG_FW_LOG, "FW returned more than expected number of FW log module IDs, setting module_id_cnt to software expected max %u\n",
-			  ICE_AQC_FW_LOG_ID_MAX);
-		module_id_cnt = ICE_AQC_FW_LOG_ID_MAX;
-	}
-
-	cfg->log_resolution = le16_to_cpu(cmd->ops.cfg.log_resolution);
-	if (cmd->cmd_flags & ICE_AQC_FW_LOG_CONF_AQ_EN)
-		cfg->options |= ICE_FWLOG_OPTION_ARQ_ENA;
-	if (cmd->cmd_flags & ICE_AQC_FW_LOG_CONF_UART_EN)
-		cfg->options |= ICE_FWLOG_OPTION_UART_ENA;
-	if (cmd->cmd_flags & ICE_AQC_FW_LOG_QUERY_REGISTERED)
-		cfg->options |= ICE_FWLOG_OPTION_IS_REGISTERED;
-
-	fw_modules = (struct ice_aqc_fw_log_cfg_resp *)buf;
-
-	for (i = 0; i < module_id_cnt; i++) {
-		struct ice_aqc_fw_log_cfg_resp *fw_module = &fw_modules[i];
-
-		cfg->module_entries[i].module_id =
-			le16_to_cpu(fw_module->module_identifier);
-		cfg->module_entries[i].log_level = fw_module->log_level;
-	}
-
-status_out:
-	kfree(buf);
-	return status;
-}
-
-/**
- * ice_fwlog_get - Get the firmware logging settings
- * @hw: pointer to the HW structure
- * @cfg: config to populate based on current firmware logging settings
- */
-int ice_fwlog_get(struct ice_hw *hw, struct ice_fwlog_cfg *cfg)
-{
-	if (!ice_fwlog_supported(hw))
-		return -EOPNOTSUPP;
-
-	return ice_aq_fwlog_get(hw, cfg);
-}
-
 /**
  * ice_aq_fwlog_register - Register PF for firmware logging events (0xFF31)
  * @hw: pointer to the HW structure
@@ -438,37 +456,3 @@ int ice_fwlog_unregister(struct ice_hw *hw)
 
 	return status;
 }
-
-/**
- * ice_fwlog_set_supported - Set if FW logging is supported by FW
- * @hw: pointer to the HW struct
- *
- * If FW returns success to the ice_aq_fwlog_get call then it supports FW
- * logging, else it doesn't. Set the fwlog_supported flag accordingly.
- *
- * This function is only meant to be called during driver init to determine if
- * the FW support FW logging.
- */
-void ice_fwlog_set_supported(struct ice_hw *hw)
-{
-	struct ice_fwlog_cfg *cfg;
-	int status;
-
-	hw->fwlog_supported = false;
-
-	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
-	if (!cfg)
-		return;
-
-	/* don't call ice_fwlog_get() because that would check to see if FW
-	 * logging is supported which is what the driver is determining now
-	 */
-	status = ice_aq_fwlog_get(hw, cfg);
-	if (status)
-		ice_debug(hw, ICE_DBG_FW_LOG, "ice_aq_fwlog_get failed, FW logging is not supported on this version of FW, status %d\n",
-			  status);
-	else
-		hw->fwlog_supported = true;
-
-	kfree(cfg);
-}
diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.h b/drivers/net/ethernet/intel/ice/ice_fwlog.h
index 287e71fa4b86..7d95d11b6ef9 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.h
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.h
@@ -38,7 +38,7 @@ struct ice_fwlog_cfg {
 	 * logging on initialization
 	 */
 #define ICE_FWLOG_OPTION_REGISTER_ON_INIT	BIT(2)
-	/* set in the ice_fwlog_get() response if the PF is registered for FW
+	/* set in the ice_aq_fwlog_get() response if the PF is registered for FW
 	 * logging events over ARQ
 	 */
 #define ICE_FWLOG_OPTION_IS_REGISTERED		BIT(3)
@@ -67,12 +67,9 @@ struct ice_fwlog_ring {
 bool ice_fwlog_ring_full(struct ice_fwlog_ring *rings);
 bool ice_fwlog_ring_empty(struct ice_fwlog_ring *rings);
 void ice_fwlog_ring_increment(u16 *item, u16 size);
-void ice_fwlog_set_supported(struct ice_hw *hw);
-bool ice_fwlog_supported(struct ice_hw *hw);
 int ice_fwlog_init(struct ice_hw *hw);
 void ice_fwlog_deinit(struct ice_hw *hw);
 int ice_fwlog_set(struct ice_hw *hw, struct ice_fwlog_cfg *cfg);
-int ice_fwlog_get(struct ice_hw *hw, struct ice_fwlog_cfg *cfg);
 int ice_fwlog_register(struct ice_hw *hw);
 int ice_fwlog_unregister(struct ice_hw *hw);
 void ice_fwlog_realloc_rings(struct ice_hw *hw, int index);
-- 
2.47.1


