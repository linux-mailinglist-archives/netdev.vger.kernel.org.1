Return-Path: <netdev+bounces-213868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 506A3B272C7
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 01:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D333E7B0C31
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 23:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C70A288525;
	Thu, 14 Aug 2025 23:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UN+x7ki6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923692882A8
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 23:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212950; cv=none; b=eeJU84GvU6Suu8kgfZdlcFbYSkiZY/NCQJbzg8+SaL58jha7qzLxNy+V5mx7n6bKpYcZNLgveZ/KWpQ6vAlhsEEr6JDpkQFAyLoebVaP9xPYrt3rdEB4Lk8Y7d/TBeGSzoF8OC5oilbUW9Epd/ZJoJHc5TivJWEGdrOiLFRewcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212950; c=relaxed/simple;
	bh=M4Q8UvbOFiM1m8LQJGkBNmBQScV8Ya4y2H2CPu1SKNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dbe7czylsXpOjIAclVX5qJrloFVEuA2lmQ0a0kiqjK5tBUhxgHnfl0DiftfI6B3eP1eWpONt5R4xtyDAjFeBHsR9NmbEkhEXdavluAilmd5lyYbequSytyqTHD6Ln4j9h/0+40YkV8xWJW3ea7J9Bf4t0I1Mnl9HfN7+D1yedUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UN+x7ki6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755212948; x=1786748948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M4Q8UvbOFiM1m8LQJGkBNmBQScV8Ya4y2H2CPu1SKNk=;
  b=UN+x7ki6nPTpCKsu/uTIOupg2unFkxIasjCqKPZs7PVKNAFNhNZRN1jk
   uLzEjGoWOQsuONlKyFxzvSXxSgX4zT/wUkExhz5jBD17CEMy450Ey7Ygx
   SptOVhh100Q57rK58xWscHoS6xUxI8ImHxgusbhaYLGeFgaOfr7PaP2Ay
   5JV7d/vtrukIzr2sTOv4oQ1sBzPMUbNyqpP+0aF0nwNKJxeWfqc2I4MYf
   hdhhjpkoSipTearQl+jLWWxWv31Q6c8wEgP+J0qfXDEW7i9IUUDbZOvsy
   Z3NATyR8SiC7dikRcnaBmQV30VbTaSsQAeYHn3xZlqkweuRg2bmaCs6RK
   Q==;
X-CSE-ConnectionGUID: 9uYYbJK2RxG2st+ULjjrbw==
X-CSE-MsgGUID: MzvEsPBHRJaL7htZxGVqSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="45117979"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="45117979"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 16:09:04 -0700
X-CSE-ConnectionGUID: AA3haOiMRFO9Ptq/1glK/A==
X-CSE-MsgGUID: MTmwsSdNTtiuDu9/twxa4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="166848135"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 14 Aug 2025 16:09:04 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Dave Ertman <david.m.ertman@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 4/7] ice: move LAG function in code to prepare for Active-Active
Date: Thu, 14 Aug 2025 16:08:51 -0700
Message-ID: <20250814230855.128068-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250814230855.128068-1-anthony.l.nguyen@intel.com>
References: <20250814230855.128068-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Ertman <david.m.ertman@intel.com>

In the SRIOV LAG Active-Active, the functions ice_lag_cfg_pf_fltr's
and ice_lag_config_eswitch's content are moved to earlier locations
in the source file.  Also, ice_lag_cfg_pf_fltr is renamed, and its
flow is changed.

To reduce the delta in the larger patch, move the original functions
to their new location so that only functional changes are needed in
the larger patch.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 147 ++++++++++++-----------
 1 file changed, 74 insertions(+), 73 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 48efd8d27296..1f76536e6176 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -100,6 +100,28 @@ static bool netif_is_same_ice(struct ice_pf *pf, struct net_device *netdev)
 	return true;
 }
 
+/**
+ * ice_lag_config_eswitch - configure eswitch to work with LAG
+ * @lag: lag info struct
+ * @netdev: active network interface device struct
+ *
+ * Updates all port representors in eswitch to use @netdev for Tx.
+ *
+ * Configures the netdev to keep dst metadata (also used in representor Tx).
+ * This is required for an uplink without switchdev mode configured.
+ */
+static void ice_lag_config_eswitch(struct ice_lag *lag,
+				   struct net_device *netdev)
+{
+	struct ice_repr *repr;
+	unsigned long id;
+
+	xa_for_each(&lag->pf->eswitch.reprs, id, repr)
+		repr->dst->u.port_info.lower_dev = netdev;
+
+	netif_keep_dst(netdev);
+}
+
 /**
  * ice_netdev_to_lag - return pointer to associated lag struct from netdev
  * @netdev: pointer to net_device struct to query
@@ -354,6 +376,58 @@ ice_lag_cfg_pf_fltrs(struct ice_lag *lag, void *ptr)
 	}
 }
 
+/**
+ * ice_lag_cfg_cp_fltr - configure filter for control packets
+ * @lag: local interface's lag struct
+ * @add: add or remove rule
+ */
+static void
+ice_lag_cfg_cp_fltr(struct ice_lag *lag, bool add)
+{
+	struct ice_sw_rule_lkup_rx_tx *s_rule = NULL;
+	struct ice_vsi *vsi;
+	u16 buf_len, opc;
+
+	vsi = lag->pf->vsi[0];
+
+	buf_len = ICE_SW_RULE_RX_TX_HDR_SIZE(s_rule, ICE_TRAIN_PKT_LEN);
+	s_rule = kzalloc(buf_len, GFP_KERNEL);
+	if (!s_rule) {
+		netdev_warn(lag->netdev, "-ENOMEM error configuring CP filter\n");
+		return;
+	}
+
+	if (add) {
+		s_rule->hdr.type = cpu_to_le16(ICE_AQC_SW_RULES_T_LKUP_RX);
+		s_rule->recipe_id = cpu_to_le16(ICE_LAG_SRIOV_CP_RECIPE);
+		s_rule->src = cpu_to_le16(vsi->port_info->lport);
+		s_rule->act = cpu_to_le32(ICE_FWD_TO_VSI |
+					  ICE_SINGLE_ACT_LAN_ENABLE |
+					  ICE_SINGLE_ACT_VALID_BIT |
+					  FIELD_PREP(ICE_SINGLE_ACT_VSI_ID_M,
+						     vsi->vsi_num));
+		s_rule->hdr_len = cpu_to_le16(ICE_TRAIN_PKT_LEN);
+		memcpy(s_rule->hdr_data, lacp_train_pkt, ICE_TRAIN_PKT_LEN);
+		opc = ice_aqc_opc_add_sw_rules;
+	} else {
+		opc = ice_aqc_opc_remove_sw_rules;
+		s_rule->index = cpu_to_le16(lag->cp_rule_idx);
+	}
+	if (ice_aq_sw_rules(&lag->pf->hw, s_rule, buf_len, 1, opc, NULL)) {
+		netdev_warn(lag->netdev, "Error %s CP rule for fail-over\n",
+			    add ? "ADDING" : "REMOVING");
+		goto err_cp_free;
+	}
+
+	if (add)
+		lag->cp_rule_idx = le16_to_cpu(s_rule->index);
+	else
+		lag->cp_rule_idx = 0;
+
+err_cp_free:
+	kfree(s_rule);
+}
+
 /**
  * ice_display_lag_info - print LAG info
  * @lag: LAG info struct
@@ -768,57 +842,6 @@ void ice_lag_move_vf_nodes_cfg(struct ice_lag *lag, u8 src_prt, u8 dst_prt)
 	ice_lag_destroy_netdev_list(lag, &ndlist);
 }
 
-/**
- * ice_lag_cfg_cp_fltr - configure filter for control packets
- * @lag: local interface's lag struct
- * @add: add or remove rule
- */
-static void
-ice_lag_cfg_cp_fltr(struct ice_lag *lag, bool add)
-{
-	struct ice_sw_rule_lkup_rx_tx *s_rule = NULL;
-	struct ice_vsi *vsi;
-	u16 buf_len, opc;
-
-	vsi = lag->pf->vsi[0];
-
-	buf_len = ICE_SW_RULE_RX_TX_HDR_SIZE(s_rule, ICE_TRAIN_PKT_LEN);
-	s_rule = kzalloc(buf_len, GFP_KERNEL);
-	if (!s_rule) {
-		netdev_warn(lag->netdev, "-ENOMEM error configuring CP filter\n");
-		return;
-	}
-
-	if (add) {
-		s_rule->hdr.type = cpu_to_le16(ICE_AQC_SW_RULES_T_LKUP_RX);
-		s_rule->recipe_id = cpu_to_le16(ICE_LAG_SRIOV_CP_RECIPE);
-		s_rule->src = cpu_to_le16(vsi->port_info->lport);
-		s_rule->act = cpu_to_le32(ICE_FWD_TO_VSI |
-					  ICE_SINGLE_ACT_LAN_ENABLE |
-					  ICE_SINGLE_ACT_VALID_BIT |
-					  FIELD_PREP(ICE_SINGLE_ACT_VSI_ID_M, vsi->vsi_num));
-		s_rule->hdr_len = cpu_to_le16(ICE_TRAIN_PKT_LEN);
-		memcpy(s_rule->hdr_data, lacp_train_pkt, ICE_TRAIN_PKT_LEN);
-		opc = ice_aqc_opc_add_sw_rules;
-	} else {
-		opc = ice_aqc_opc_remove_sw_rules;
-		s_rule->index = cpu_to_le16(lag->cp_rule_idx);
-	}
-	if (ice_aq_sw_rules(&lag->pf->hw, s_rule, buf_len, 1, opc, NULL)) {
-		netdev_warn(lag->netdev, "Error %s CP rule for fail-over\n",
-			    add ? "ADDING" : "REMOVING");
-		goto cp_free;
-	}
-
-	if (add)
-		lag->cp_rule_idx = le16_to_cpu(s_rule->index);
-	else
-		lag->cp_rule_idx = 0;
-
-cp_free:
-	kfree(s_rule);
-}
-
 /**
  * ice_lag_prepare_vf_reset - helper to adjust vf lag for reset
  * @lag: lag struct for interface that owns VF
@@ -1038,28 +1061,6 @@ static void ice_lag_link(struct ice_lag *lag)
 	netdev_info(lag->netdev, "Shared SR-IOV resources in bond are active\n");
 }
 
-/**
- * ice_lag_config_eswitch - configure eswitch to work with LAG
- * @lag: lag info struct
- * @netdev: active network interface device struct
- *
- * Updates all port representors in eswitch to use @netdev for Tx.
- *
- * Configures the netdev to keep dst metadata (also used in representor Tx).
- * This is required for an uplink without switchdev mode configured.
- */
-static void ice_lag_config_eswitch(struct ice_lag *lag,
-				   struct net_device *netdev)
-{
-	struct ice_repr *repr;
-	unsigned long id;
-
-	xa_for_each(&lag->pf->eswitch.reprs, id, repr)
-		repr->dst->u.port_info.lower_dev = netdev;
-
-	netif_keep_dst(netdev);
-}
-
 /**
  * ice_lag_unlink - handle unlink event
  * @lag: LAG info struct
-- 
2.47.1


