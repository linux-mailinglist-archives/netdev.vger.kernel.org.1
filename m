Return-Path: <netdev+bounces-149811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D369E7916
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 20:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175871883457
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 19:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1B121CFE3;
	Fri,  6 Dec 2024 19:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JDbT8qGb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968BF21B8F4
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513753; cv=none; b=R9RncZhK9V5RLl8aCWRKTaHxIk/5YNGkWu+HpABtFXuTVgwRuCJf2lJg800pYCXcJs9n/yW0FTMfJ37bLyzddGef3i8X7ViF61AgpvUdIgciktya3A9H+arKK3MvHOoP6lUPYz112bLz95Oyi6fe7fMQvjIPW9VLDa3rwkFR/CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513753; c=relaxed/simple;
	bh=zSCtf+quTd5fqw4D7EK3AedwCjvHcB3Fg9rIFen5XtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sepaaJUXKeS8STn19fzl0nmGAGqP3ehmfUm6XCkn0KvZo7yw6KzbeuZDSnccchM8Og7AAEhf++kSoOjqThqpYxgA5QCjPPT3IJhopL/Tbelw1mwpDArMJo9rnholtgScATvms57QrzUC/L5TisZP+jNC0vurHgIsWMDLALpFfvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JDbT8qGb; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733513751; x=1765049751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zSCtf+quTd5fqw4D7EK3AedwCjvHcB3Fg9rIFen5XtU=;
  b=JDbT8qGbiHMmX15gdNlRnDKV5pH5Gu1yIpViXsg63a2OPO4t1nIJ7Otr
   WlBHwTXo+IvpU9wL97AZehrWXAqtombd9p+AJR4AzbMevAoy+CNLLp0pH
   +xASPFBJcD7+but5ljWZcFkn/2Z1K8gHUPhcajrxD6BTZzsCqtYXiqnuQ
   cVC1523eIu6Bsd/NDaYcui8zIeHSWTlCe1rEs4Z6T0JDnR+UkdZ8Xou6g
   R6mqAi6Zm5eSnwtewPzwGHgQZNg8o5Vfn9bfGeva4eAcy6f0UY7ZFbf03
   bn7PzSPid+kP6olXcHLUCTNAqhGtRUkz82e2Q0flpehiRxl9t+eLVz6H9
   A==;
X-CSE-ConnectionGUID: 05B57iXmRIWJTjIRJNibhA==
X-CSE-MsgGUID: nLjMj2fGRkm8RzJ95f3odg==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="33226583"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="33226583"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 11:35:46 -0800
X-CSE-ConnectionGUID: 6H/h9vE6QdaS5YckWmpb2g==
X-CSE-MsgGUID: XPAwS7F0SD+rkY9kAWvj8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="94301409"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 06 Dec 2024 11:35:47 -0800
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
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	Arkadiusz Kubalewski <Arkadiusz.kubalewski@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 4/4] ice: Add correct PHY lane assignment
Date: Fri,  6 Dec 2024 11:35:41 -0800
Message-ID: <20241206193542.4121545-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241206193542.4121545-1-anthony.l.nguyen@intel.com>
References: <20241206193542.4121545-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Driver always naively assumes, that for PTP purposes, PHY lane to
configure is corresponding to PF ID.

This is not true for some port configurations, e.g.:
- 2x50G per quad, where lanes used are 0 and 2 on each quad, but PF IDs
  are 0 and 1
- 100G per quad on 2 quads, where lanes used are 0 and 4, but PF IDs are
  0 and 1

Use correct PHY lane assignment by getting and parsing port options.
This is read from the NVM by the FW and provided to the driver with
the indication of active port split.

Remove ice_is_muxed_topo(), which is no longer needed.

Fixes: 4409ea1726cb ("ice: Adjust PTP init for 2x50G E825C devices")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Arkadiusz Kubalewski <Arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_common.c   | 45 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_common.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  6 +--
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 23 ++++------
 drivers/net/ethernet/intel/ice/ice_ptp.h      |  4 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 26 +----------
 drivers/net/ethernet/intel/ice/ice_type.h     |  1 -
 8 files changed, 62 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 1489a8ceec51..4d27cf309646 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1665,6 +1665,7 @@ struct ice_aqc_get_port_options_elem {
 #define ICE_AQC_PORT_OPT_MAX_LANE_25G	5
 #define ICE_AQC_PORT_OPT_MAX_LANE_50G	6
 #define ICE_AQC_PORT_OPT_MAX_LANE_100G	7
+#define ICE_AQC_PORT_OPT_MAX_LANE_200G	8
 
 	u8 global_scid[2];
 	u8 phy_scid[2];
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 496d86cbd13f..ab25ccd7e8ec 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -4095,6 +4095,51 @@ ice_aq_set_port_option(struct ice_hw *hw, u8 lport, u8 lport_valid,
 	return ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
 }
 
+/**
+ * ice_get_phy_lane_number - Get PHY lane number for current adapter
+ * @hw: pointer to the hw struct
+ *
+ * Return: PHY lane number on success, negative error code otherwise.
+ */
+int ice_get_phy_lane_number(struct ice_hw *hw)
+{
+	struct ice_aqc_get_port_options_elem *options __free(kfree);
+	unsigned int lport = 0;
+	unsigned int lane;
+	int err;
+
+	options = kcalloc(ICE_AQC_PORT_OPT_MAX, sizeof(*options), GFP_KERNEL);
+	if (!options)
+		return -ENOMEM;
+
+	for (lane = 0; lane < ICE_MAX_PORT_PER_PCI_DEV; lane++) {
+		u8 options_count = ICE_AQC_PORT_OPT_MAX;
+		u8 speed, active_idx, pending_idx;
+		bool active_valid, pending_valid;
+
+		err = ice_aq_get_port_options(hw, options, &options_count, lane,
+					      true, &active_idx, &active_valid,
+					      &pending_idx, &pending_valid);
+		if (err)
+			return err;
+
+		if (!active_valid)
+			continue;
+
+		speed = options[active_idx].max_lane_speed;
+		/* If we don't get speed for this lane, it's unoccupied */
+		if (speed > ICE_AQC_PORT_OPT_MAX_LANE_200G)
+			continue;
+
+		if (hw->pf_id == lport)
+			return lane;
+		lport++;
+	}
+
+	/* PHY lane not found */
+	return -ENXIO;
+}
+
 /**
  * ice_aq_sff_eeprom
  * @hw: pointer to the HW struct
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 27208a60cece..fe6f88cfd948 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -193,6 +193,7 @@ ice_aq_get_port_options(struct ice_hw *hw,
 int
 ice_aq_set_port_option(struct ice_hw *hw, u8 lport, u8 lport_valid,
 		       u8 new_option);
+int ice_get_phy_lane_number(struct ice_hw *hw);
 int
 ice_aq_sff_eeprom(struct ice_hw *hw, u16 lport, u8 bus_addr,
 		  u16 mem_addr, u8 page, u8 set_page, u8 *data, u8 length,
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 0ab35607e5d5..89fa3d53d317 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1144,7 +1144,7 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
 	if (link_up == old_link && link_speed == old_link_speed)
 		return 0;
 
-	ice_ptp_link_change(pf, pf->hw.pf_id, link_up);
+	ice_ptp_link_change(pf, link_up);
 
 	if (ice_is_dcb_active(pf)) {
 		if (test_bit(ICE_FLAG_DCB_ENA, pf->flags))
@@ -6790,7 +6790,7 @@ static int ice_up_complete(struct ice_vsi *vsi)
 		ice_print_link_msg(vsi, true);
 		netif_tx_start_all_queues(vsi->netdev);
 		netif_carrier_on(vsi->netdev);
-		ice_ptp_link_change(pf, pf->hw.pf_id, true);
+		ice_ptp_link_change(pf, true);
 	}
 
 	/* Perform an initial read of the statistics registers now to
@@ -7260,7 +7260,7 @@ int ice_down(struct ice_vsi *vsi)
 
 	if (vsi->netdev) {
 		vlan_err = ice_vsi_del_vlan_zero(vsi);
-		ice_ptp_link_change(vsi->back, vsi->back->hw.pf_id, false);
+		ice_ptp_link_change(vsi->back, false);
 		netif_carrier_off(vsi->netdev);
 		netif_tx_disable(vsi->netdev);
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index a999fface272..efd770dfec44 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1388,10 +1388,9 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 /**
  * ice_ptp_link_change - Reconfigure PTP after link status change
  * @pf: Board private structure
- * @port: Port for which the PHY start is set
  * @linkup: Link is up or down
  */
-void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup)
+void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 {
 	struct ice_ptp_port *ptp_port;
 	struct ice_hw *hw = &pf->hw;
@@ -1399,14 +1398,7 @@ void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup)
 	if (pf->ptp.state != ICE_PTP_READY)
 		return;
 
-	if (WARN_ON_ONCE(port >= hw->ptp.num_lports))
-		return;
-
 	ptp_port = &pf->ptp.port;
-	if (ice_is_e825c(hw) && hw->ptp.is_2x50g_muxed_topo)
-		port *= 2;
-	if (WARN_ON_ONCE(ptp_port->port_num != port))
-		return;
 
 	/* Update cached link status for this port immediately */
 	ptp_port->link_up = linkup;
@@ -3164,10 +3156,17 @@ void ice_ptp_init(struct ice_pf *pf)
 {
 	struct ice_ptp *ptp = &pf->ptp;
 	struct ice_hw *hw = &pf->hw;
-	int err;
+	int lane_num, err;
 
 	ptp->state = ICE_PTP_INITIALIZING;
 
+	lane_num = ice_get_phy_lane_number(hw);
+	if (lane_num < 0) {
+		err = lane_num;
+		goto err_exit;
+	}
+
+	ptp->port.port_num = (u8)lane_num;
 	ice_ptp_init_hw(hw);
 
 	ice_ptp_init_tx_interrupt_mode(pf);
@@ -3188,10 +3187,6 @@ void ice_ptp_init(struct ice_pf *pf)
 	if (err)
 		goto err_exit;
 
-	ptp->port.port_num = hw->pf_id;
-	if (ice_is_e825c(hw) && hw->ptp.is_2x50g_muxed_topo)
-		ptp->port.port_num = hw->pf_id * 2;
-
 	err = ice_ptp_init_port(pf, &ptp->port);
 	if (err)
 		goto err_exit;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 824e73b677a4..c490d98fd9c6 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -310,7 +310,7 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf,
 			       enum ice_reset_req reset_type);
 void ice_ptp_init(struct ice_pf *pf);
 void ice_ptp_release(struct ice_pf *pf);
-void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup);
+void ice_ptp_link_change(struct ice_pf *pf, bool linkup);
 #else /* IS_ENABLED(CONFIG_PTP_1588_CLOCK) */
 static inline int ice_ptp_set_ts_config(struct ice_pf *pf, struct ifreq *ifr)
 {
@@ -358,7 +358,7 @@ static inline void ice_ptp_prepare_for_reset(struct ice_pf *pf,
 }
 static inline void ice_ptp_init(struct ice_pf *pf) { }
 static inline void ice_ptp_release(struct ice_pf *pf) { }
-static inline void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup)
+static inline void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 {
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index e606f1049742..23fd830a364d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2722,26 +2722,6 @@ static int ice_get_phy_tx_tstamp_ready_eth56g(struct ice_hw *hw, u8 port,
 	return 0;
 }
 
-/**
- * ice_is_muxed_topo - detect breakout 2x50G topology for E825C
- * @hw: pointer to the HW struct
- *
- * Return: true if it's 2x50 breakout topology, false otherwise
- */
-static bool ice_is_muxed_topo(struct ice_hw *hw)
-{
-	u8 link_topo;
-	bool mux;
-	u32 val;
-
-	val = rd32(hw, GLGEN_SWITCH_MODE_CONFIG);
-	mux = FIELD_GET(GLGEN_SWITCH_MODE_CONFIG_25X4_QUAD_M, val);
-	val = rd32(hw, GLGEN_MAC_LINK_TOPO);
-	link_topo = FIELD_GET(GLGEN_MAC_LINK_TOPO_LINK_TOPO_M, val);
-
-	return (mux && link_topo == ICE_LINK_TOPO_UP_TO_2_LINKS);
-}
-
 /**
  * ice_ptp_init_phy_e825 - initialize PHY parameters
  * @hw: pointer to the HW struct
@@ -2764,12 +2744,8 @@ static void ice_ptp_init_phy_e825(struct ice_hw *hw)
 
 	ice_sb_access_ena_eth56g(hw, true);
 	err = ice_read_phy_eth56g(hw, hw->pf_id, PHY_REG_REVISION, &phy_rev);
-	if (err || phy_rev != PHY_REVISION_ETH56G) {
+	if (err || phy_rev != PHY_REVISION_ETH56G)
 		ptp->phy_model = ICE_PHY_UNSUP;
-		return;
-	}
-
-	ptp->is_2x50g_muxed_topo = ice_is_muxed_topo(hw);
 }
 
 /* E822 family functions
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index a61026970be5..4a9ef722635f 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -880,7 +880,6 @@ struct ice_ptp_hw {
 	union ice_phy_params phy;
 	u8 num_lports;
 	u8 ports_per_phy;
-	bool is_2x50g_muxed_topo;
 };
 
 /* Port hardware description */
-- 
2.42.0


