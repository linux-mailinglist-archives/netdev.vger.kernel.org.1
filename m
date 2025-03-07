Return-Path: <netdev+bounces-172939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0A4A568E4
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 14:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B41E16D787
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 13:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2F721A955;
	Fri,  7 Mar 2025 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dBcAJNVs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54C1219A91
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 13:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353991; cv=none; b=mWI5PxmdwjNQATu+ZpPZSElPDsOeDxLlpF8y6qdjFHOIH4FfIU3bmf20Dl8FXpZVLf3kY75Ywx0k5Sn6W/5jHFiBZWauZ4rWz1HLliLui1EF2JH7RyPYOHm2JL/TIc3LLAin7kHc/Beng0oJuv63VDRHbtzzWagooBiYzw1zyco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353991; c=relaxed/simple;
	bh=JaBU89FKWRGCTWx9dfd6hRY4eU7nX649tfwEAzq/P4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=umC+8Sh7wv6rmJWTFNYwRgaYEZM3FTUiBGpufVOXffS4oI+wjYUFtfinCnRVzfeaxS/eB+xBNvCk6Gl+9CvkRZAsidVQA8eSrantYym1mPEZIpNQuEz1GvNnqgjeq4kKQ99si1z+NFFJtdnR7XCig73TDuEjxoy/s51+xLxWh0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dBcAJNVs; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741353990; x=1772889990;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JaBU89FKWRGCTWx9dfd6hRY4eU7nX649tfwEAzq/P4c=;
  b=dBcAJNVs3RaoG1BdtoGm+voOtfDZuKLuWACK9yDdvPTCNhfzk1Rpltdx
   Pvfy2hfqbT5/nFxPO0y4z4ovBSBc3l1OsKN1LDvhIKJX4JF9Dah5R+Y7J
   9HuX8mno7itS2jB51Cgf9naTRB+GVda6qAT8V4pept4P2z0ps3VZwmm6b
   RWK2R3+pg8+3WC5tBim0qafVQjS+WPU7dZPm39pNprwpH33/kz6yPsIry
   zzvC2M3ftZwmR+i1lqPWW0Ev9Pf3/9ZfUzcZtj4PZs+Zdc75I9VZxpsek
   rXlS+2NzDuOWUkPsU/Tzo2xobazxrhBH89LH7U0lORooCe8i3xPePaMG3
   A==;
X-CSE-ConnectionGUID: EYHZrY2HQOSof9hzVcOiAw==
X-CSE-MsgGUID: OZ/j5xZvRqyQcZD4cbBI6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53388022"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="53388022"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 05:26:29 -0800
X-CSE-ConnectionGUID: tHeIj6rFTu+CxgaAfIjzlg==
X-CSE-MsgGUID: dUQfI1UjR02M2Bgv2v4JPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="150119509"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by orviesa002.jf.intel.com with ESMTP; 07 Mar 2025 05:26:26 -0800
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Subject: [iwl-next v2] ice: refactor the Tx scheduler feature
Date: Fri,  7 Mar 2025 14:25:56 +0100
Message-ID: <20250307132555.119902-2-martyna.szapar-mudlaw@linux.intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Simplify the code by eliminating an unnecessary wrapper function.
Previously, ice_devlink_tx_sched_layers_get() acted as a thin wrapper
around ice_get_tx_topo_user_sel(), adding no real value but increasing
code complexity. Since both functions were only used once, the wrapper
was redundant and contributed approximately 20 lines of unnecessary
code. Remove ice_get_tx_topo_user_sel() and moves its instructions
directly into ice_devlink_tx_sched_layers_get(), improving readability
and reducing function jumps, without altering functionality.

Also remove unnecessary comment and make usage of str_enabled_disabled() in
ice_init_tx_topology().

Suggested-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
---

v1->v2:
Expanded the commit message with the motivation for the changes, no code modifications.

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
index a03e1819e6d5..a55ec9be7b1d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4550,10 +4550,10 @@ ice_init_tx_topology(struct ice_hw *hw, const struct firmware *firmware)
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
2.47.0


