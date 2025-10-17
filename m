Return-Path: <netdev+bounces-230372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB90FBE73E2
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 10:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88701581647
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 08:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B81825F984;
	Fri, 17 Oct 2025 08:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fcKUrDXI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D16429E0F8
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 08:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760690670; cv=none; b=fzrytveQseMe3Ios0UC3lBUxTfNhUJuO+ohXV2MI9UinXUhsXcUGgRN7C+zelAGWpzkreHVdoB/7wtvxcaKCxduY4gGSPGFtKt8ybOQbplPDMnvIODFxCcTLd6YFf9r1cdx2Z/D3jeN0ewuYEkJgxOyrVUuHyU25zQJNIffP7qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760690670; c=relaxed/simple;
	bh=kAQyU+o9QeNSim6ryxGcCJ6H49R7ppKizEttgq8uj6A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a0L42vJIhcSf1aN1xwk4LuJba6irNbvzZahan8Rx/6A4wmHd25m0AFPnWq5Nquf41UikTSdTBJyOm+vkBHbnKSQNq5Myk2w2NAduq7BLBvZH4wHz9nwbxw9rnEmldEwLVVqy15rtFexQ5FhnDCEnI4GgBJb80zz0tST1KwuNHGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fcKUrDXI; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760690668; x=1792226668;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kAQyU+o9QeNSim6ryxGcCJ6H49R7ppKizEttgq8uj6A=;
  b=fcKUrDXIhmsJOaiXupuFxPY2Cn2G/ctrOTL0Qev+ucCjrpPTGncEkS0T
   GgXrZ7GRp1iC20CM41pfeePWNF5bGX3lV3o2c/+9InS46YkrkZ2sVN2aj
   uJMiTcHzVnmUlWnzJPw1G85n7Qyjs4OTJLIsT4cNGz//8gbKDXoE9lYVN
   VgAylSjvByZA2JBJX8hjB5Xb7puar0RM6JHiYhNTE4AsKMpQRS/tNKfAZ
   4QrMnHgKa/csZdXe9rLneT1urTXluwvW5uOGjB1OoGBFO/XfpCWnnba62
   XHeWi5XlN6/cb+bO7wdFH0LUeaLuzIXZbWJUTNhdIj6im0vKux5NF6yE+
   g==;
X-CSE-ConnectionGUID: Ey6BiQurTK64aqNT2ibATA==
X-CSE-MsgGUID: N86156j6S0yjUo1QBzvQiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="88367589"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="88367589"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 01:44:28 -0700
X-CSE-ConnectionGUID: 405iXWIUTgCJikW5one9Ag==
X-CSE-MsgGUID: 1Ohrd9QFTYSi4tH+y5wTKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="181876789"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa010.jf.intel.com with ESMTP; 17 Oct 2025 01:44:26 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v2 iwl-next] ice: unify PHY FW loading status handler for E800 devices
Date: Fri, 17 Oct 2025 10:42:28 +0200
Message-Id: <20251017084228.4140603-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unify handling of PHY firmware load delays across all E800 family
devices. There is an existing mechanism to poll GL_MNG_FWSM_FW_LOADING_M
bit of GL_MNG_FWSM register in order to verify whether PHY FW loading
completed or not. Previously, this logic was limited to E827 variants
only.

Also, inform a user of possible delay in initialization process, by
dumping informational message in dmesg log ("Link initialization is
blocked by PHY FW initialization. Link initialization will continue
after PHY FW initialization completes.").

Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
v1->v2:
 - rebased
 - pasted dmesg message into the commit message
---
 drivers/net/ethernet/intel/ice/ice_common.c | 81 ++++++---------------
 1 file changed, 24 insertions(+), 57 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 8e56354332ad..d05d371a9944 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -203,42 +203,6 @@ bool ice_is_generic_mac(struct ice_hw *hw)
 		hw->mac_type == ICE_MAC_GENERIC_3K_E825);
 }
 
-/**
- * ice_is_pf_c827 - check if pf contains c827 phy
- * @hw: pointer to the hw struct
- *
- * Return: true if the device has c827 phy.
- */
-static bool ice_is_pf_c827(struct ice_hw *hw)
-{
-	struct ice_aqc_get_link_topo cmd = {};
-	u8 node_part_number;
-	u16 node_handle;
-	int status;
-
-	if (hw->mac_type != ICE_MAC_E810)
-		return false;
-
-	if (hw->device_id != ICE_DEV_ID_E810C_QSFP)
-		return true;
-
-	cmd.addr.topo_params.node_type_ctx =
-		FIELD_PREP(ICE_AQC_LINK_TOPO_NODE_TYPE_M, ICE_AQC_LINK_TOPO_NODE_TYPE_PHY) |
-		FIELD_PREP(ICE_AQC_LINK_TOPO_NODE_CTX_M, ICE_AQC_LINK_TOPO_NODE_CTX_PORT);
-	cmd.addr.topo_params.index = 0;
-
-	status = ice_aq_get_netlist_node(hw, &cmd, &node_part_number,
-					 &node_handle);
-
-	if (status || node_part_number != ICE_AQC_GET_LINK_TOPO_NODE_NR_C827)
-		return false;
-
-	if (node_handle == E810C_QSFP_C827_0_HANDLE || node_handle == E810C_QSFP_C827_1_HANDLE)
-		return true;
-
-	return false;
-}
-
 /**
  * ice_clear_pf_cfg - Clear PF configuration
  * @hw: pointer to the hardware structure
@@ -958,30 +922,35 @@ static void ice_get_itr_intrl_gran(struct ice_hw *hw)
 }
 
 /**
- * ice_wait_for_fw - wait for full FW readiness
+ * ice_wait_fw_load - wait for PHY firmware loading to complete
  * @hw: pointer to the hardware structure
  * @timeout: milliseconds that can elapse before timing out
  *
- * Return: 0 on success, -ETIMEDOUT on timeout.
+ * On some cards, FW can load longer than usual,
+ * and could still not be ready before link is turned on.
+ * In these cases, we should wait until all's loaded.
+ *
+ * Return:
+ * * 0 on success (FW load is completed)
+ * * negative - on timeout
  */
-static int ice_wait_for_fw(struct ice_hw *hw, u32 timeout)
+static int ice_wait_fw_load(struct ice_hw *hw, u32 timeout)
 {
-	int fw_loading;
-	u32 elapsed = 0;
+	int fw_loading_reg;
 
-	while (elapsed <= timeout) {
-		fw_loading = rd32(hw, GL_MNG_FWSM) & GL_MNG_FWSM_FW_LOADING_M;
+	if (!timeout)
+		return 0;
 
-		/* firmware was not yet loaded, we have to wait more */
-		if (fw_loading) {
-			elapsed += 100;
-			msleep(100);
-			continue;
-		}
+	fw_loading_reg = rd32(hw, GL_MNG_FWSM) & GL_MNG_FWSM_FW_LOADING_M;
+	/* notify the user only once if PHY FW is still loading */
+	if (fw_loading_reg)
+		dev_info(ice_hw_to_dev(hw), "Link initialization is blocked by PHY FW initialization. Link initialization will continue after PHY FW initialization completes.\n");
+	else
 		return 0;
-	}
 
-	return -ETIMEDOUT;
+	return rd32_poll_timeout(hw, GL_MNG_FWSM, fw_loading_reg,
+				 !(fw_loading_reg & GL_MNG_FWSM_FW_LOADING_M),
+				 10000, timeout * 1000);
 }
 
 static int __fwlog_send_cmd(void *priv, struct libie_aq_desc *desc, void *buf,
@@ -1171,12 +1140,10 @@ int ice_init_hw(struct ice_hw *hw)
 	 * due to necessity of loading FW from an external source.
 	 * This can take even half a minute.
 	 */
-	if (ice_is_pf_c827(hw)) {
-		status = ice_wait_for_fw(hw, 30000);
-		if (status) {
-			dev_err(ice_hw_to_dev(hw), "ice_wait_for_fw timed out");
-			goto err_unroll_fltr_mgmt_struct;
-		}
+	status = ice_wait_fw_load(hw, 30000);
+	if (status) {
+		dev_err(ice_hw_to_dev(hw), "ice_wait_fw_load timed out");
+		goto err_unroll_fltr_mgmt_struct;
 	}
 
 	hw->lane_num = ice_get_phy_lane_number(hw);

base-commit: f642fdeedf5c09bacf13ccb213615daba617b5b4
-- 
2.39.3


