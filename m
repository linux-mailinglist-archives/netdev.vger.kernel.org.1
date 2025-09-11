Return-Path: <netdev+bounces-222317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E89B53D79
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 23:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 615F07B889A
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 21:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659FF2DECA1;
	Thu, 11 Sep 2025 21:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lvCiJ4rf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DEF2DE6F1
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 21:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757624744; cv=none; b=htG77htXMGz5K95/tmRxrotlir0FF/C9ALziVIGuFnm/ezf+j9RRSBbLsO4Zf6yx0jX4GS5gms9GE+sdVl26W9QnQuqWVG3apEMafGtARc9bPDmsH91VTEjCdp9rRGLc1vTj/qf8prMoIA3ExTbQ4CS09NzchF3plwFYDmMmh9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757624744; c=relaxed/simple;
	bh=VVKuKyb/YLzxN0c44QNI7HV1VTI5lpWG7rqWf3hqoEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ioeoj13Xa59zS2vRzvKHRGPVlNkPWUEZpaqKlkjdJt+PZM+64OSGMULs1nkCv7a6zgEcoCoV9MQugkFczQjm1hCxfFX1RPfn9qdNpAdGnSJ+ukrltKarGFLTpdTjVslWoleLGwt5muzdVhvP8q0oUpgq2DShkojJZqcfItMDMaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lvCiJ4rf; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757624743; x=1789160743;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VVKuKyb/YLzxN0c44QNI7HV1VTI5lpWG7rqWf3hqoEQ=;
  b=lvCiJ4rfdPaCOxMUjRgEZL4B4SAPO/vXLgxnMG05TTgfY0i3Jknw1W8h
   elhxyqYfCAzQ8fYeI1qu5+kkjZ/KeMcMNADGZXhH7WQQCKhFz0ZH+uM7i
   uWCMrdkcXWkTTvIlvodq82UGEpGLgQo2RihuUdZngb5FcHxdXreTQRnjb
   6QAINYUT9NczEsmPS20d2vzXQNsS79QuNLXNX3XMyBH/PvpHQOzb3Zqa9
   9myOfydyHMQDlR0rRY8K0nhgvLiTDi8FClXft+xJHIiTODR0k3FM3LcsP
   th95ih8G3pIMbrTD1fvzMP/ZvTWnB4UM1GuGUQ9ZDpPj3huFc+DS/gyCu
   A==;
X-CSE-ConnectionGUID: MVzujwE9QG2DkJzJfRBjTA==
X-CSE-MsgGUID: 6CbIl6lgSbqxUZKCVbdjOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="82558896"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="82558896"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 14:05:40 -0700
X-CSE-ConnectionGUID: SxVUdIvtQjalOkcmDmGAxQ==
X-CSE-MsgGUID: 9033Fs9ASvSW88UQ2LxGLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="174583360"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 11 Sep 2025 14:05:39 -0700
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
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 06/15] ice: allow calling custom send function in fwlog
Date: Thu, 11 Sep 2025 14:05:05 -0700
Message-ID: <20250911210525.345110-7-anthony.l.nguyen@intel.com>
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

Fwlog code needs to communicate with FW. In ice it is done through admin
queue command. Allow indirect calling the send function to move the
specific admin queue send function from fwlog core code.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c  | 23 ++++++-
 drivers/net/ethernet/intel/ice/ice_debugfs.c |  6 +-
 drivers/net/ethernet/intel/ice/ice_fwlog.c   | 67 ++++++++++----------
 drivers/net/ethernet/intel/ice/ice_fwlog.h   | 14 ++--
 4 files changed, 65 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index c3f99b2e2087..53d713d19da2 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -984,6 +984,26 @@ static int ice_wait_for_fw(struct ice_hw *hw, u32 timeout)
 	return -ETIMEDOUT;
 }
 
+static int __fwlog_send_cmd(void *priv, struct libie_aq_desc *desc, void *buf,
+			    u16 size)
+{
+	struct ice_hw *hw = priv;
+
+	return ice_aq_send_cmd(hw, desc, buf, size, NULL);
+}
+
+static int __fwlog_init(struct ice_hw *hw)
+{
+	struct ice_pf *pf = hw->back;
+	struct ice_fwlog_api api = {
+		.pdev = pf->pdev,
+		.send_cmd = __fwlog_send_cmd,
+		.priv = hw,
+	};
+
+	return ice_fwlog_init(hw, &hw->fwlog, &api);
+}
+
 /**
  * ice_init_hw - main hardware initialization routine
  * @hw: pointer to the hardware structure
@@ -992,7 +1012,6 @@ int ice_init_hw(struct ice_hw *hw)
 {
 	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree) = NULL;
 	void *mac_buf __free(kfree) = NULL;
-	struct ice_pf *pf = hw->back;
 	u16 mac_buf_len;
 	int status;
 
@@ -1013,7 +1032,7 @@ int ice_init_hw(struct ice_hw *hw)
 	if (status)
 		goto err_unroll_cqinit;
 
-	status = ice_fwlog_init(hw, &hw->fwlog, pf->pdev);
+	status = __fwlog_init(hw);
 	if (status)
 		ice_debug(hw, ICE_DBG_FW_LOG, "Error initializing FW logging: %d\n",
 			  status);
diff --git a/drivers/net/ethernet/intel/ice/ice_debugfs.c b/drivers/net/ethernet/intel/ice/ice_debugfs.c
index 1e036bc128c5..9235ae099e17 100644
--- a/drivers/net/ethernet/intel/ice/ice_debugfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_debugfs.c
@@ -350,14 +350,14 @@ ice_debugfs_enable_write(struct file *filp, const char __user *buf,
 	else
 		hw->fwlog.cfg.options &= ~ICE_FWLOG_OPTION_ARQ_ENA;
 
-	ret = ice_fwlog_set(hw, &hw->fwlog.cfg);
+	ret = ice_fwlog_set(&hw->fwlog, &hw->fwlog.cfg);
 	if (ret)
 		goto enable_write_error;
 
 	if (enable)
-		ret = ice_fwlog_register(hw, &hw->fwlog);
+		ret = ice_fwlog_register(&hw->fwlog);
 	else
-		ret = ice_fwlog_unregister(hw, &hw->fwlog);
+		ret = ice_fwlog_unregister(&hw->fwlog);
 
 	if (ret)
 		goto enable_write_error;
diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.c b/drivers/net/ethernet/intel/ice/ice_fwlog.c
index b1c1359d5ab5..172905187a3e 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.c
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.c
@@ -137,10 +137,10 @@ static bool ice_fwlog_supported(struct ice_fwlog *fwlog)
 
 /**
  * ice_aq_fwlog_get - Get the current firmware logging configuration (0xFF32)
- * @hw: pointer to the HW structure
+ * @fwlog: pointer to the fwlog structure
  * @cfg: firmware logging configuration to populate
  */
-static int ice_aq_fwlog_get(struct ice_hw *hw, struct ice_fwlog_cfg *cfg)
+static int ice_aq_fwlog_get(struct ice_fwlog *fwlog, struct ice_fwlog_cfg *cfg)
 {
 	struct ice_aqc_fw_log_cfg_resp *fw_modules;
 	struct ice_aqc_fw_log *cmd;
@@ -161,17 +161,17 @@ static int ice_aq_fwlog_get(struct ice_hw *hw, struct ice_fwlog_cfg *cfg)
 
 	cmd->cmd_flags = ICE_AQC_FW_LOG_AQ_QUERY;
 
-	status = ice_aq_send_cmd(hw, &desc, buf, ICE_AQ_MAX_BUF_LEN, NULL);
+	status = fwlog->send_cmd(fwlog->priv, &desc, buf, ICE_AQ_MAX_BUF_LEN);
 	if (status) {
-		dev_dbg(&hw->fwlog.pdev->dev, "Failed to get FW log configuration\n");
+		dev_dbg(&fwlog->pdev->dev, "Failed to get FW log configuration\n");
 		goto status_out;
 	}
 
 	module_id_cnt = le16_to_cpu(cmd->ops.cfg.mdl_cnt);
 	if (module_id_cnt < ICE_AQC_FW_LOG_ID_MAX) {
-		dev_dbg(&hw->fwlog.pdev->dev, "FW returned less than the expected number of FW log module IDs\n");
+		dev_dbg(&fwlog->pdev->dev, "FW returned less than the expected number of FW log module IDs\n");
 	} else if (module_id_cnt > ICE_AQC_FW_LOG_ID_MAX) {
-		dev_dbg(&hw->fwlog.pdev->dev, "FW returned more than expected number of FW log module IDs, setting module_id_cnt to software expected max %u\n",
+		dev_dbg(&fwlog->pdev->dev, "FW returned more than expected number of FW log module IDs, setting module_id_cnt to software expected max %u\n",
 			ICE_AQC_FW_LOG_ID_MAX);
 		module_id_cnt = ICE_AQC_FW_LOG_ID_MAX;
 	}
@@ -201,7 +201,6 @@ static int ice_aq_fwlog_get(struct ice_hw *hw, struct ice_fwlog_cfg *cfg)
 
 /**
  * ice_fwlog_set_supported - Set if FW logging is supported by FW
- * @hw: pointer to the HW struct
  * @fwlog: pointer to the fwlog structure
  *
  * If FW returns success to the ice_aq_fwlog_get call then it supports FW
@@ -210,7 +209,7 @@ static int ice_aq_fwlog_get(struct ice_hw *hw, struct ice_fwlog_cfg *cfg)
  * This function is only meant to be called during driver init to determine if
  * the FW support FW logging.
  */
-static void ice_fwlog_set_supported(struct ice_hw *hw, struct ice_fwlog *fwlog)
+static void ice_fwlog_set_supported(struct ice_fwlog *fwlog)
 {
 	struct ice_fwlog_cfg *cfg;
 	int status;
@@ -221,7 +220,7 @@ static void ice_fwlog_set_supported(struct ice_hw *hw, struct ice_fwlog *fwlog)
 	if (!cfg)
 		return;
 
-	status = ice_aq_fwlog_get(hw, cfg);
+	status = ice_aq_fwlog_get(fwlog, cfg);
 	if (status)
 		dev_dbg(&fwlog->pdev->dev, "ice_aq_fwlog_get failed, FW logging is not supported on this version of FW, status %d\n",
 			status);
@@ -235,26 +234,26 @@ static void ice_fwlog_set_supported(struct ice_hw *hw, struct ice_fwlog *fwlog)
  * ice_fwlog_init - Initialize FW logging configuration
  * @hw: pointer to the HW structure
  * @fwlog: pointer to the fwlog structure
- * @pdev: pointer to the pci dev used in dev_warn()
+ * @api: api structure to init fwlog
  *
  * This function should be called on driver initialization during
  * ice_init_hw().
  */
 int ice_fwlog_init(struct ice_hw *hw, struct ice_fwlog *fwlog,
-		   struct pci_dev *pdev)
+		   struct ice_fwlog_api *api)
 {
 	/* only support fw log commands on PF 0 */
 	if (hw->bus.func)
 		return -EINVAL;
 
-	ice_fwlog_set_supported(hw, fwlog);
-	fwlog->pdev = pdev;
+	fwlog->api = *api;
+	ice_fwlog_set_supported(fwlog);
 
 	if (ice_fwlog_supported(fwlog)) {
 		int status;
 
 		/* read the current config from the FW and store it */
-		status = ice_aq_fwlog_get(hw, &fwlog->cfg);
+		status = ice_aq_fwlog_get(fwlog, &fwlog->cfg);
 		if (status)
 			return status;
 
@@ -307,7 +306,7 @@ void ice_fwlog_deinit(struct ice_hw *hw, struct ice_fwlog *fwlog)
 	 * for the next driver load
 	 */
 	fwlog->cfg.options &= ~ICE_FWLOG_OPTION_ARQ_ENA;
-	status = ice_fwlog_set(hw, &fwlog->cfg);
+	status = ice_fwlog_set(fwlog, &fwlog->cfg);
 	if (status)
 		dev_warn(&fwlog->pdev->dev, "Unable to turn off FW logging, status: %d\n",
 			 status);
@@ -316,7 +315,7 @@ void ice_fwlog_deinit(struct ice_hw *hw, struct ice_fwlog *fwlog)
 
 	pf->ice_debugfs_pf_fwlog_modules = NULL;
 
-	status = ice_fwlog_unregister(hw, fwlog);
+	status = ice_fwlog_unregister(fwlog);
 	if (status)
 		dev_warn(&fwlog->pdev->dev, "Unable to unregister FW logging, status: %d\n",
 			 status);
@@ -329,15 +328,16 @@ void ice_fwlog_deinit(struct ice_hw *hw, struct ice_fwlog *fwlog)
 
 /**
  * ice_aq_fwlog_set - Set FW logging configuration AQ command (0xFF30)
- * @hw: pointer to the HW structure
+ * @fwlog: pointer to the fwlog structure
  * @entries: entries to configure
  * @num_entries: number of @entries
  * @options: options from ice_fwlog_cfg->options structure
  * @log_resolution: logging resolution
  */
 static int
-ice_aq_fwlog_set(struct ice_hw *hw, struct ice_fwlog_module_entry *entries,
-		 u16 num_entries, u16 options, u16 log_resolution)
+ice_aq_fwlog_set(struct ice_fwlog *fwlog,
+		 struct ice_fwlog_module_entry *entries, u16 num_entries,
+		 u16 options, u16 log_resolution)
 {
 	struct ice_aqc_fw_log_cfg_resp *fw_modules;
 	struct ice_aqc_fw_log *cmd;
@@ -369,9 +369,8 @@ ice_aq_fwlog_set(struct ice_hw *hw, struct ice_fwlog_module_entry *entries,
 	if (options & ICE_FWLOG_OPTION_UART_ENA)
 		cmd->cmd_flags |= ICE_AQC_FW_LOG_CONF_UART_EN;
 
-	status = ice_aq_send_cmd(hw, &desc, fw_modules,
-				 sizeof(*fw_modules) * num_entries,
-				 NULL);
+	status = fwlog->send_cmd(fwlog->priv, &desc, fw_modules,
+				 sizeof(*fw_modules) * num_entries);
 
 	kfree(fw_modules);
 
@@ -380,7 +379,7 @@ ice_aq_fwlog_set(struct ice_hw *hw, struct ice_fwlog_module_entry *entries,
 
 /**
  * ice_fwlog_set - Set the firmware logging settings
- * @hw: pointer to the HW structure
+ * @fwlog: pointer to the fwlog structure
  * @cfg: config used to set firmware logging
  *
  * This function should be called whenever the driver needs to set the firmware
@@ -391,22 +390,22 @@ ice_aq_fwlog_set(struct ice_hw *hw, struct ice_fwlog_module_entry *entries,
  * ice_fwlog_register. Note, that ice_fwlog_register does not need to be called
  * for init.
  */
-int ice_fwlog_set(struct ice_hw *hw, struct ice_fwlog_cfg *cfg)
+int ice_fwlog_set(struct ice_fwlog *fwlog, struct ice_fwlog_cfg *cfg)
 {
-	if (!ice_fwlog_supported(&hw->fwlog))
+	if (!ice_fwlog_supported(fwlog))
 		return -EOPNOTSUPP;
 
-	return ice_aq_fwlog_set(hw, cfg->module_entries,
+	return ice_aq_fwlog_set(fwlog, cfg->module_entries,
 				ICE_AQC_FW_LOG_ID_MAX, cfg->options,
 				cfg->log_resolution);
 }
 
 /**
  * ice_aq_fwlog_register - Register PF for firmware logging events (0xFF31)
- * @hw: pointer to the HW structure
+ * @fwlog: pointer to the fwlog structure
  * @reg: true to register and false to unregister
  */
-static int ice_aq_fwlog_register(struct ice_hw *hw, bool reg)
+static int ice_aq_fwlog_register(struct ice_fwlog *fwlog, bool reg)
 {
 	struct ice_aqc_fw_log *cmd;
 	struct libie_aq_desc desc;
@@ -417,25 +416,24 @@ static int ice_aq_fwlog_register(struct ice_hw *hw, bool reg)
 	if (reg)
 		cmd->cmd_flags = ICE_AQC_FW_LOG_AQ_REGISTER;
 
-	return ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
+	return fwlog->send_cmd(fwlog->priv, &desc, NULL, 0);
 }
 
 /**
  * ice_fwlog_register - Register the PF for firmware logging
- * @hw: pointer to the HW structure
  * @fwlog: pointer to the fwlog structure
  *
  * After this call the PF will start to receive firmware logging based on the
  * configuration set in ice_fwlog_set.
  */
-int ice_fwlog_register(struct ice_hw *hw, struct ice_fwlog *fwlog)
+int ice_fwlog_register(struct ice_fwlog *fwlog)
 {
 	int status;
 
 	if (!ice_fwlog_supported(fwlog))
 		return -EOPNOTSUPP;
 
-	status = ice_aq_fwlog_register(hw, true);
+	status = ice_aq_fwlog_register(fwlog, true);
 	if (status)
 		dev_dbg(&fwlog->pdev->dev, "Failed to register for firmware logging events over ARQ\n");
 	else
@@ -446,17 +444,16 @@ int ice_fwlog_register(struct ice_hw *hw, struct ice_fwlog *fwlog)
 
 /**
  * ice_fwlog_unregister - Unregister the PF from firmware logging
- * @hw: pointer to the HW structure
  * @fwlog: pointer to the fwlog structure
  */
-int ice_fwlog_unregister(struct ice_hw *hw, struct ice_fwlog *fwlog)
+int ice_fwlog_unregister(struct ice_fwlog *fwlog)
 {
 	int status;
 
 	if (!ice_fwlog_supported(fwlog))
 		return -EOPNOTSUPP;
 
-	status = ice_aq_fwlog_register(hw, false);
+	status = ice_aq_fwlog_register(fwlog, false);
 	if (status)
 		dev_dbg(&fwlog->pdev->dev, "Failed to unregister from firmware logging events over ARQ\n");
 	else
diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.h b/drivers/net/ethernet/intel/ice/ice_fwlog.h
index 9c56ca6cbef0..fe4b2ce6813f 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.h
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.h
@@ -68,17 +68,21 @@ struct ice_fwlog {
 	struct ice_fwlog_cfg cfg;
 	bool supported; /* does hardware support FW logging? */
 	struct ice_fwlog_ring ring;
-	struct pci_dev *pdev;
+	struct_group_tagged(ice_fwlog_api, api,
+		struct pci_dev *pdev;
+		int (*send_cmd)(void *, struct libie_aq_desc *, void *, u16);
+		void *priv;
+	);
 };
 
 bool ice_fwlog_ring_empty(struct ice_fwlog_ring *rings);
 void ice_fwlog_ring_increment(u16 *item, u16 size);
 int ice_fwlog_init(struct ice_hw *hw, struct ice_fwlog *fwlog,
-		   struct pci_dev *pdev);
+		   struct ice_fwlog_api *api);
 void ice_fwlog_deinit(struct ice_hw *hw, struct ice_fwlog *fwlog);
-int ice_fwlog_set(struct ice_hw *hw, struct ice_fwlog_cfg *cfg);
-int ice_fwlog_register(struct ice_hw *hw, struct ice_fwlog *fwlog);
-int ice_fwlog_unregister(struct ice_hw *hw, struct ice_fwlog *fwlog);
+int ice_fwlog_set(struct ice_fwlog *fwlog, struct ice_fwlog_cfg *cfg);
+int ice_fwlog_register(struct ice_fwlog *fwlog);
+int ice_fwlog_unregister(struct ice_fwlog *fwlog);
 void ice_fwlog_realloc_rings(struct ice_fwlog *fwlog, int index);
 void ice_get_fwlog_data(struct ice_fwlog *fwlog, u8 *buf, u16 len);
 #endif /* _ICE_FWLOG_H_ */
-- 
2.47.1


