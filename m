Return-Path: <netdev+bounces-181773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9161AA86778
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD684C3C8C
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F65A28F937;
	Fri, 11 Apr 2025 20:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZkT5v9+H"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F80284B29
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404250; cv=none; b=ndRoGAkk3aKp/M2NSKm7MaDZ0ZHWtx3SATfzMgIcXYbYaOtBIv65PiazeaVFL7sqjJJtfKG7TbXWFT25n6HGzhgp3Y/H5aIGbWG9H68YkQ6pgq2z/OG4o8X/yv6m5TxHWgBSiirCMS+q2b/Y/wYeksAgzXNxtP1gR04sGeNKkyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404250; c=relaxed/simple;
	bh=cwqMNYrWMTywxJZvVuIVBXSFwl2fCdZz9eRlaAZSjAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PAxqu16wvRsgv/92QMN8LN2wGOyN4arctTA/QVJ//zkD8chocmN2tU9jO5lY7z8kdgJo5YT/jIJLz7cEGyE2QfxRUEPb+5m9XndWnj8emCUCgoykttE22uyTTVJGH0BJ1mTKRRbIXcQTONXzCpxSivZs26L/cwW1YY5peQj8BEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZkT5v9+H; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744404249; x=1775940249;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cwqMNYrWMTywxJZvVuIVBXSFwl2fCdZz9eRlaAZSjAI=;
  b=ZkT5v9+HaxRRcObIr6i7BBxT5dEqFxAwdzORo/CmmvIkkNwjGMV862dr
   QVwtOXlTMT7WXN+aIXHFPGBDLvb3N7Bjs5rdwzAcGYf0SCSFXML7DbQfv
   s7cZ42BPW93+MC88VGiOTjchU3di8x3hzusN4srevCtBez2OloPoEEAA0
   2qfPppmRbwgJrQKcjwxNwTmA1+/sUbDCxvEZbSqFHB6x6keTZOsjfM16A
   Cj2zg1dFijsyCD9XPvSg+H2bDXYNyt2M6EDI8pTHEAqNFSzAHeRjxtcbZ
   1KjNaCFHImmP9PO9qW2oTby7PID3+tVieAcRgfo2priaD2ZpEyNBpgMMc
   w==;
X-CSE-ConnectionGUID: qgwWvHU4T3ao51sJa0ez2w==
X-CSE-MsgGUID: de61hlNeTCe5MhCCeThjQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="45103850"
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="45103850"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 13:44:06 -0700
X-CSE-ConnectionGUID: 2iHUTRetTEiGKZR7tiNoqg==
X-CSE-MsgGUID: idrZxMSYSly8Y4CI6k8Hww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="129241798"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 11 Apr 2025 13:44:06 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	anthony.l.nguyen@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 02/15] ice: do not add LLDP-specific filter if not necessary
Date: Fri, 11 Apr 2025 13:43:43 -0700
Message-ID: <20250411204401.3271306-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411204401.3271306-1-anthony.l.nguyen@intel.com>
References: <20250411204401.3271306-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Larysa Zaremba <larysa.zaremba@intel.com>

Commit 34295a3696fb ("ice: implement new LLDP filter command")
introduced the ability to use LLDP-specific filter that directs all
LLDP traffic to a single VSI. However, current goal is for all trusted VFs
to be able to see LLDP neighbors, which is impossible to do with the
special filter.

Make using the generic filter the default choice and fall back to special
one only if a generic filter cannot be added. That way setups with "NVMs
where an already existent LLDP filter is blocking the creation of a filter
to allow LLDP packets" will still be able to configure software Rx LLDP on
PF only, while all other setups would be able to forward them to VFs too.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h        |  1 +
 drivers/net/ethernet/intel/ice/ice_common.c | 14 +++++++++----
 drivers/net/ethernet/intel/ice/ice_common.h |  3 +--
 drivers/net/ethernet/intel/ice/ice_lib.c    | 23 ++++++++++++++-------
 4 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index fd083647c14a..2694951a0b1d 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -515,6 +515,7 @@ enum ice_pf_flags {
 	ICE_FLAG_MTU_CHANGED,
 	ICE_FLAG_GNSS,			/* GNSS successfully initialized */
 	ICE_FLAG_DPLL,			/* SyncE/PTP dplls initialized */
+	ICE_FLAG_LLDP_AQ_FLTR,
 	ICE_PF_FLAGS_NBITS		/* must be last */
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 59df31c2c83f..e725b785d093 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -6011,15 +6011,21 @@ bool ice_fw_supports_lldp_fltr_ctrl(struct ice_hw *hw)
 /**
  * ice_lldp_fltr_add_remove - add or remove a LLDP Rx switch filter
  * @hw: pointer to HW struct
- * @vsi_num: absolute HW index for VSI
+ * @vsi: VSI to add the filter to
  * @add: boolean for if adding or removing a filter
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the operation cannot be performed
+ *	   with this HW or VSI, otherwise an error corresponding to
+ *	   the AQ transaction result.
  */
-int
-ice_lldp_fltr_add_remove(struct ice_hw *hw, u16 vsi_num, bool add)
+int ice_lldp_fltr_add_remove(struct ice_hw *hw, struct ice_vsi *vsi, bool add)
 {
 	struct ice_aqc_lldp_filter_ctrl *cmd;
 	struct ice_aq_desc desc;
 
+	if (vsi->type != ICE_VSI_PF || !ice_fw_supports_lldp_fltr_ctrl(hw))
+		return -EOPNOTSUPP;
+
 	cmd = &desc.params.lldp_filter_ctrl;
 
 	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_lldp_filter_ctrl);
@@ -6029,7 +6035,7 @@ ice_lldp_fltr_add_remove(struct ice_hw *hw, u16 vsi_num, bool add)
 	else
 		cmd->cmd_flags = ICE_AQC_LLDP_FILTER_ACTION_DELETE;
 
-	cmd->vsi_num = cpu_to_le16(vsi_num);
+	cmd->vsi_num = cpu_to_le16(vsi->vsi_num);
 
 	return ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 9b00aa0ddf10..64c530b39191 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -290,8 +290,7 @@ int
 ice_aq_set_lldp_mib(struct ice_hw *hw, u8 mib_type, void *buf, u16 buf_size,
 		    struct ice_sq_cd *cd);
 bool ice_fw_supports_lldp_fltr_ctrl(struct ice_hw *hw);
-int
-ice_lldp_fltr_add_remove(struct ice_hw *hw, u16 vsi_num, bool add);
+int ice_lldp_fltr_add_remove(struct ice_hw *hw, struct ice_vsi *vsi, bool add);
 int ice_lldp_execute_pending_mib(struct ice_hw *hw);
 int
 ice_aq_read_i2c(struct ice_hw *hw, struct ice_aqc_link_topo_addr topo_addr,
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 0bcf9d127ac9..542b76b5707a 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2085,19 +2085,28 @@ void ice_cfg_sw_lldp(struct ice_vsi *vsi, bool tx, bool create)
 		status = eth_fltr(vsi, ETH_P_LLDP, ICE_FLTR_TX,
 				  ICE_DROP_PACKET);
 	} else {
-		if (ice_fw_supports_lldp_fltr_ctrl(&pf->hw)) {
-			status = ice_lldp_fltr_add_remove(&pf->hw, vsi->vsi_num,
-							  create);
-		} else {
+		if (!test_bit(ICE_FLAG_LLDP_AQ_FLTR, pf->flags)) {
 			status = eth_fltr(vsi, ETH_P_LLDP, ICE_FLTR_RX,
 					  ICE_FWD_TO_VSI);
+			if (!status || !create)
+				goto report;
+
+			dev_info(dev,
+				 "Failed to add generic LLDP Rx filter on VSI %i error: %d, falling back to specialized AQ control\n",
+				 vsi->vsi_num, status);
 		}
+
+		status = ice_lldp_fltr_add_remove(&pf->hw, vsi, create);
+		if (!status)
+			set_bit(ICE_FLAG_LLDP_AQ_FLTR, pf->flags);
+
 	}
 
+report:
 	if (status)
-		dev_dbg(dev, "Fail %s %s LLDP rule on VSI %i error: %d\n",
-			create ? "adding" : "removing", tx ? "TX" : "RX",
-			vsi->vsi_num, status);
+		dev_warn(dev, "Failed to %s %s LLDP rule on VSI %i error: %d\n",
+			 create ? "add" : "remove", tx ? "Tx" : "Rx",
+			 vsi->vsi_num, status);
 }
 
 /**
-- 
2.47.1


