Return-Path: <netdev+bounces-169847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0544FA45F89
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 13:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3FE188428C
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 12:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A4D21506A;
	Wed, 26 Feb 2025 12:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RHzSKtFN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6CF212B23
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 12:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740573698; cv=none; b=D7ARhihKejAkSoXPyzQAiC+/EsqZ9qGpk0ICqk+4otAVZpixeao6EEYdwK9ig2vFfPUPWjbr3ARs1oZDBJfHZqICzc2RPLEuGEbv+Gc9tmkZsm0Ba8MxDRN9H0Sc/0Vqj1LAvrw6XY/d47wAHA2g9RWLcf9lEaYb/0qPLPy7Oqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740573698; c=relaxed/simple;
	bh=2Wtl/99KUY6VSqZjgNxx680yUju/s18Trdq/SjzInIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HPfkqRKZUsaz9Dy9YhBYZx9fwRqzekYKZSUPLPvP/H087EhcJrtPwGIAyM7Ay1af/N/d/R5zrMuDSRIu0Bg932GOD4fPmFfnfvCd7ZW1W6e0+1Egi6C8PLd4j3dJb74ABWSjN/aDOKCIswO0M5D1ZMlcS9mCUcvejB0lImopcuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RHzSKtFN; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740573696; x=1772109696;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2Wtl/99KUY6VSqZjgNxx680yUju/s18Trdq/SjzInIA=;
  b=RHzSKtFNM1HHADfhkJreFZRL4fDOffOhBs22jNU4DdTTbzo1aDi6UHEz
   NokJuF6cs8v3e6VmmaXDCdhg3z2L+6vpxZz4uBJURo3wswscTEk4MUhj8
   YfUcYqyQ+y4445migzJnlEzsz0+DeKwrBggcIJNc4ZOBuJ+sKA0PESc2R
   K0AzuRfZfRTLvEbxmErnhOBMwLKGGp4N42hwQBhJ5EPWWJ1radA3WRy2U
   lcWsYsdHeTw6R0nCCO0GBaJ3jQWP66Nq4q+rp4K0DPmGmAr9weKuQKHgZ
   OXHI/PyHLq3cXa2eH/G2lMs2WKmTAx7WV7pRqVV2vgCtvZEy9ets1+P+D
   Q==;
X-CSE-ConnectionGUID: k3isdd0tRlCioHbZf+jMqQ==
X-CSE-MsgGUID: wZr/cYVOQrSzMk2O+tTXKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41259257"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="41259257"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 04:41:35 -0800
X-CSE-ConnectionGUID: OzUplYlUT0S491KkA4jXBA==
X-CSE-MsgGUID: f72xxEfzQOapx08Ge0Mwdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="116882902"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa008.fm.intel.com with ESMTP; 26 Feb 2025 04:41:33 -0800
Received: from ilmater.igk.intel.com (ilmater.igk.intel.com [10.123.220.50])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 19ECE12419;
	Wed, 26 Feb 2025 12:41:32 +0000 (GMT)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v1] ice: refactor the Tx scheduler feature
Date: Wed, 26 Feb 2025 12:33:56 +0100
Message-ID: <20250226113409.446325-1-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Embed ice_get_tx_topo_user_sel() inside the only caller:
ice_devlink_tx_sched_layers_get().
Instead of jump from the wrapper to the function that does "get" operation
it does "get" itself.

Remove unnecessary comment and make usage of str_enabled_disabled()
in ice_init_tx_topology().

Suggested-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 .../net/ethernet/intel/ice/devlink/devlink.c  | 56 +++++++------------
 drivers/net/ethernet/intel/ice/ice_ddp.c      |  2 -
 drivers/net/ethernet/intel/ice/ice_main.c     |  8 +--
 3 files changed, 23 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index fcb199efbea5..2355e21d115c 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -529,41 +529,6 @@ ice_devlink_reload_empr_finish(struct ice_pf *pf,
 	return 0;
 }
 
-/**
- * ice_get_tx_topo_user_sel - Read user's choice from flash
- * @pf: pointer to pf structure
- * @layers: value read from flash will be saved here
- *
- * Reads user's preference for Tx Scheduler Topology Tree from PFA TLV.
- *
- * Return: zero when read was successful, negative values otherwise.
- */
-static int ice_get_tx_topo_user_sel(struct ice_pf *pf, uint8_t *layers)
-{
-	struct ice_aqc_nvm_tx_topo_user_sel usr_sel = {};
-	struct ice_hw *hw = &pf->hw;
-	int err;
-
-	err = ice_acquire_nvm(hw, ICE_RES_READ);
-	if (err)
-		return err;
-
-	err = ice_aq_read_nvm(hw, ICE_AQC_NVM_TX_TOPO_MOD_ID, 0,
-			      sizeof(usr_sel), &usr_sel, true, true, NULL);
-	if (err)
-		goto exit_release_res;
-
-	if (usr_sel.data & ICE_AQC_NVM_TX_TOPO_USER_SEL)
-		*layers = ICE_SCHED_5_LAYERS;
-	else
-		*layers = ICE_SCHED_9_LAYERS;
-
-exit_release_res:
-	ice_release_nvm(hw);
-
-	return err;
-}
-
 /**
  * ice_update_tx_topo_user_sel - Save user's preference in flash
  * @pf: pointer to pf structure
@@ -610,19 +575,36 @@ static int ice_update_tx_topo_user_sel(struct ice_pf *pf, int layers)
  * @id: the parameter ID to set
  * @ctx: context to store the parameter value
  *
+ * Reads user's preference for Tx Scheduler Topology Tree from PFA TLV.
+ *
  * Return: zero on success and negative value on failure.
  */
 static int ice_devlink_tx_sched_layers_get(struct devlink *devlink, u32 id,
 					   struct devlink_param_gset_ctx *ctx)
 {
+	struct ice_aqc_nvm_tx_topo_user_sel usr_sel = {};
 	struct ice_pf *pf = devlink_priv(devlink);
+	struct ice_hw *hw = &pf->hw;
 	int err;
 
-	err = ice_get_tx_topo_user_sel(pf, &ctx->val.vu8);
+	err = ice_acquire_nvm(hw, ICE_RES_READ);
 	if (err)
 		return err;
 
-	return 0;
+	err = ice_aq_read_nvm(hw, ICE_AQC_NVM_TX_TOPO_MOD_ID, 0,
+			      sizeof(usr_sel), &usr_sel, true, true, NULL);
+	if (err)
+		goto exit_release_res;
+
+	if (usr_sel.data & ICE_AQC_NVM_TX_TOPO_USER_SEL)
+		ctx->val.vu8 = ICE_SCHED_5_LAYERS;
+	else
+		ctx->val.vu8 = ICE_SCHED_9_LAYERS;
+
+exit_release_res:
+	ice_release_nvm(hw);
+
+	return err;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index 69d5b1a28491..a2f738eaf02e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -2324,8 +2324,6 @@ enum ice_ddp_state ice_copy_and_init_pkg(struct ice_hw *hw, const u8 *buf,
  * @flags: pointer to descriptor flags
  * @set: 0-get, 1-set topology
  *
- * The function will get or set Tx topology
- *
  * Return: zero when set was successful, negative values otherwise.
  */
 static int
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index b084839eb811..9d9cad81b336 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4544,10 +4544,10 @@ ice_init_tx_topology(struct ice_hw *hw, const struct firmware *firmware)
 	dev = ice_pf_to_dev(pf);
 	err = ice_cfg_tx_topo(hw, firmware->data, firmware->size);
 	if (!err) {
-		if (hw->num_tx_sched_layers > num_tx_sched_layers)
-			dev_info(dev, "Tx scheduling layers switching feature disabled\n");
-		else
-			dev_info(dev, "Tx scheduling layers switching feature enabled\n");
+		dev_info(dev, "Tx scheduling layers switching feature %s\n",
+			 str_enabled_disabled(hw->num_tx_sched_layers <=
+					      num_tx_sched_layers));
+
 		/* if there was a change in topology ice_cfg_tx_topo triggered
 		 * a CORER and we need to re-init hw
 		 */
-- 
2.48.1


