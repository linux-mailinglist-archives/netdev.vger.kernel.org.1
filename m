Return-Path: <netdev+bounces-168546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A777CA3F484
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 13:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58ECB189023C
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 12:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB62A205501;
	Fri, 21 Feb 2025 12:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fNxihGuH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B96920B1E6
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740141315; cv=none; b=f4p0f9R2lZCbPGLKOcKT+gt/UfX64Ujg0sC6t9OJy2R+VDB6vMSeUFCLUSteDzlpODjoP70nAc896Nbis5LlSfXzn4pSFMlNmU3wTl7YkQvYeLSyl5kQtSN3ZQHyHmeWKWTilNobSndK7u5s7SWtv6JomlHGDB6zvdVmbIhe3gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740141315; c=relaxed/simple;
	bh=TiaQgtk1QATCxx+9hdlTJjC2880xKswnHFkscu5zqVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=emUsHp8mcaI2PtjZABKhABtc42iytpNrKeQkJinAVTXWGeXOE1oce+Re9Udfi21fQCQsJYyvx18aQAhXrutqDUPWA0BpDF2d0wXEB49a3QesjmgJm7HlC1CAXP5WymVwq0t38WN3WYl2wfIwi6lreH4ccmcgFHkbvnUT3JM8K7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fNxihGuH; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740141313; x=1771677313;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TiaQgtk1QATCxx+9hdlTJjC2880xKswnHFkscu5zqVg=;
  b=fNxihGuH7snT8DjlDjZbIQyy/cTgJ5XWZPZlnlUMByQ0gbL0IBgHCibE
   0Fj41+HBLkCo9oEbl2Mi1IBFrbP8yYwwPHpTECYdAE9xCrrndnDE9onxn
   rOrDvnBfehXRj/9ZCDfI8r26JHm34tdq4p1Xx1Ss+XKbFn+TaxvKN0Wu2
   6W+UIoGvFYZNfcrj04Xx8eztIPF1v6x98OnCXzW8v0rqygD4N4X3LsRpS
   F6P/vRuiTAQPKIZx0HUVqSOkoJ2atKh8x9Sel6aiKW6vSTmNThO+KufEe
   R9gJfcwODlwFjlYz8nhoYfRj/R4UcAe25L9guccPBN/6/nVU/UIPWOXqP
   w==;
X-CSE-ConnectionGUID: RVxjGpZYRrChec3IYNc7vA==
X-CSE-MsgGUID: VvziAD2xRkO4HNhFqAVLBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="66321407"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="66321407"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 04:35:13 -0800
X-CSE-ConnectionGUID: NYSzAKXUSFaCYrnqYLdzAg==
X-CSE-MsgGUID: H13S5++xT8i0W/Qef9y1Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115862597"
Received: from gklab-003-001.igk.intel.com ([10.211.3.1])
  by orviesa007.jf.intel.com with ESMTP; 21 Feb 2025 04:35:09 -0800
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH iwl-next v1 3/3] ice: enable timesync operation on 2xNAC E825 devices
Date: Fri, 21 Feb 2025 13:31:23 +0100
Message-Id: <20250221123123.2833395-4-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250221123123.2833395-1-grzegorz.nitka@intel.com>
References: <20250221123123.2833395-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

According to the E825C specification, SBQ address for ports on a single
complex is device 2 for PHY 0 and device 13 for PHY1.
For accessing ports on a dual complex E825C (so called 2xNAC mode),
the driver should use destination device 2 (referred as phy_0) for
the current complex PHY and device 13 (referred as phy_0_peer) for
peer complex PHY.

Differentiate SBQ destination device by checking if current PF port
number is on the same PHY as target port number.

Adjust 'ice_get_lane_number' function to provide unique port number for
ports from PHY1 in 'dual' mode config (by adding fixed offset for PHY1
ports). Cache this value in ice_hw struct.

Introduce ice_get_primary_hw wrapper to get access to timesync register
not available from second NAC.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Co-developed-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h        | 60 ++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_common.c |  6 ++-
 drivers/net/ethernet/intel/ice/ice_ptp.c    | 49 ++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 39 +++++++++++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  5 --
 drivers/net/ethernet/intel/ice/ice_type.h   |  1 +
 6 files changed, 134 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 53b990e2e850..d80ab48402f1 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -193,8 +193,6 @@
 
 #define ice_pf_to_dev(pf) (&((pf)->pdev->dev))
 
-#define ice_pf_src_tmr_owned(pf) ((pf)->hw.func_caps.ts_func_info.src_tmr_owned)
-
 enum ice_feature {
 	ICE_F_DSCP,
 	ICE_F_PHY_RCLK,
@@ -1049,4 +1047,62 @@ static inline void ice_clear_rdma_cap(struct ice_pf *pf)
 }
 
 extern const struct xdp_metadata_ops ice_xdp_md_ops;
+
+/**
+ * ice_is_dual - Check if given config is multi-NAC
+ * @hw: pointer to HW structure
+ *
+ * Return: true if the device is running in mutli-NAC (Network
+ * Acceleration Complex) configuration variant, false otherwise
+ * (always false for non-E825 devices).
+ */
+static inline bool ice_is_dual(struct ice_hw *hw)
+{
+	return hw->mac_type == ICE_MAC_GENERIC_3K_E825 &&
+	       (hw->dev_caps.nac_topo.mode & ICE_NAC_TOPO_DUAL_M);
+}
+
+/**
+ * ice_is_primary - Check if given device belongs to the primary complex
+ * @hw: pointer to HW structure
+ *
+ * Check if given PF/HW is running on primary complex in multi-NAC
+ * configuration.
+ *
+ * Return: true if the device is dual, false otherwise (always true
+ * for non-E825 devices).
+ */
+static inline bool ice_is_primary(struct ice_hw *hw)
+{
+	return hw->mac_type != ICE_MAC_GENERIC_3K_E825 ||
+	       !ice_is_dual(hw) ||
+	       (hw->dev_caps.nac_topo.mode & ICE_NAC_TOPO_PRIMARY_M);
+}
+
+/**
+ * ice_pf_src_tmr_owned - Check if a primary timer is owned by PF
+ * @hw: pointer to HW structure
+ *
+ * Return: true if PF owns primary timer, false otherwise.
+ */
+static inline bool ice_pf_src_tmr_owned(struct ice_pf *pf)
+{
+	return pf->hw.func_caps.ts_func_info.src_tmr_owned &&
+	       ice_is_primary(&pf->hw);
+}
+
+/**
+ * ice_get_primary_hw - Get pointer to primary ice_hw structure
+ * @pf: pointer to PF structure
+ *
+ * Return: A pointer to ice_hw structure with access to timesync
+ * register space.
+ */
+static inline struct ice_hw *ice_get_primary_hw(struct ice_pf *pf)
+{
+	if (!pf->adapter->ctrl_pf)
+		return &pf->hw;
+	else
+		return &pf->adapter->ctrl_pf->hw;
+}
 #endif /* _ICE_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index ed7ef8608cbb..4ff4c99d0872 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1135,6 +1135,8 @@ int ice_init_hw(struct ice_hw *hw)
 		}
 	}
 
+	hw->lane_num = ice_get_phy_lane_number(hw);
+
 	return 0;
 err_unroll_fltr_mgmt_struct:
 	ice_cleanup_fltr_mgmt_struct(hw);
@@ -4081,10 +4083,12 @@ int ice_get_phy_lane_number(struct ice_hw *hw)
 			continue;
 
 		if (hw->pf_id == lport) {
+			if (hw->mac_type == ICE_MAC_GENERIC_3K_E825 &&
+			    ice_is_dual(hw) && !ice_is_primary(hw))
+				lane += ICE_PORTS_PER_QUAD;
 			kfree(options);
 			return lane;
 		}
-
 		lport++;
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index a7aa6d5fb775..81012024c14f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -208,6 +208,9 @@ u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
 	u32 hi, lo, lo2;
 	u8 tmr_idx;
 
+	if (!ice_is_primary(hw))
+		hw = ice_get_primary_hw(pf);
+
 	tmr_idx = ice_get_ptp_src_clock_index(hw);
 	guard(spinlock)(&pf->adapter->ptp_gltsyn_time_lock);
 	/* Read the system timestamp pre PHC read */
@@ -2807,6 +2810,32 @@ static void ice_ptp_periodic_work(struct kthread_work *work)
 				   msecs_to_jiffies(err ? 10 : 500));
 }
 
+/**
+ * ice_ptp_prepare_rebuild_sec - Prepare second NAC for PTP reset or rebuild
+ * @pf: Board private structure
+ * @rebuild: rebuild if true, prepare if false
+ * @reset_type: the reset type being performed
+ */
+static void ice_ptp_prepare_rebuild_sec(struct ice_pf *pf, bool rebuild,
+					enum ice_reset_req reset_type)
+{
+	struct list_head *entry;
+
+	list_for_each(entry, &pf->adapter->ports.ports) {
+		struct ice_ptp_port *port = list_entry(entry,
+						       struct ice_ptp_port,
+						       list_node);
+		struct ice_pf *peer_pf = ptp_port_to_pf(port);
+
+		if (!ice_is_primary(&peer_pf->hw)) {
+			if (rebuild)
+				ice_ptp_rebuild(peer_pf, reset_type);
+			else
+				ice_ptp_prepare_for_reset(peer_pf, reset_type);
+		}
+	}
+}
+
 /**
  * ice_ptp_prepare_for_reset - Prepare PTP for reset
  * @pf: Board private structure
@@ -2815,6 +2844,7 @@ static void ice_ptp_periodic_work(struct kthread_work *work)
 void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 {
 	struct ice_ptp *ptp = &pf->ptp;
+	struct ice_hw *hw = &pf->hw;
 	u8 src_tmr;
 
 	if (ptp->state != ICE_PTP_READY)
@@ -2830,6 +2860,9 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	if (reset_type == ICE_RESET_PFR)
 		return;
 
+	if (ice_pf_src_tmr_owned(pf) && hw->mac_type == ICE_MAC_GENERIC_3K_E825)
+		ice_ptp_prepare_rebuild_sec(pf, false, reset_type);
+
 	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
 
 	/* Disable periodic outputs */
@@ -2951,13 +2984,6 @@ void ice_ptp_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 	dev_err(ice_pf_to_dev(pf), "PTP reset failed %d\n", err);
 }
 
-static bool ice_is_primary(struct ice_hw *hw)
-{
-	return hw->mac_type == ICE_MAC_GENERIC_3K_E825 && ice_is_dual(hw) ?
-		       !!(hw->dev_caps.nac_topo.mode & ICE_NAC_TOPO_PRIMARY_M) :
-		       true;
-}
-
 static int ice_ptp_setup_adapter(struct ice_pf *pf)
 {
 	if (!ice_pf_src_tmr_owned(pf) || !ice_is_primary(&pf->hw))
@@ -3177,17 +3203,16 @@ void ice_ptp_init(struct ice_pf *pf)
 {
 	struct ice_ptp *ptp = &pf->ptp;
 	struct ice_hw *hw = &pf->hw;
-	int lane_num, err;
+	int err;
 
 	ptp->state = ICE_PTP_INITIALIZING;
 
-	lane_num = ice_get_phy_lane_number(hw);
-	if (lane_num < 0) {
-		err = lane_num;
+	if (hw->lane_num < 0) {
+		err = hw->lane_num;
 		goto err_exit;
 	}
+	ptp->port.port_num = hw->lane_num;
 
-	ptp->port.port_num = (u8)lane_num;
 	ice_ptp_init_hw(hw);
 
 	ice_ptp_init_tx_interrupt_mode(pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index eb1893dd8979..ccac84eb34c9 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -874,8 +874,12 @@ static u32 ice_ptp_tmr_cmd_to_port_reg(struct ice_hw *hw,
  */
 void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 {
+	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
 	u32 cmd_val = ice_ptp_tmr_cmd_to_src_reg(hw, cmd);
 
+	if (!ice_is_primary(hw))
+		hw = ice_get_primary_hw(pf);
+
 	wr32(hw, GLTSYN_CMD, cmd_val);
 }
 
@@ -891,6 +895,9 @@ static void ice_ptp_exec_tmr_cmd(struct ice_hw *hw)
 {
 	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
 
+	if (!ice_is_primary(hw))
+		hw = ice_get_primary_hw(pf);
+
 	guard(spinlock)(&pf->adapter->ptp_gltsyn_time_lock);
 	wr32(hw, GLTSYN_CMD_SYNC, SYNC_EXEC_CMD);
 	ice_flush(hw);
@@ -922,10 +929,18 @@ static void ice_ptp_cfg_sync_delay(const struct ice_hw *hw, u32 delay)
 static enum ice_sbq_dev_id ice_ptp_get_dest_dev_e825(struct ice_hw *hw,
 						     u8 port)
 {
-	/* On a single complex E825, PHY 0 is always destination device phy_0
+	u8 curr_phy, tgt_phy;
+
+	tgt_phy = port >= hw->ptp.ports_per_phy;
+	curr_phy = hw->lane_num >= hw->ptp.ports_per_phy;
+	/* In the driver, lanes 4..7 are in fact 0..3 on a second PHY.
+	 * On a single complex E825C, PHY 0 is always destination device phy_0
 	 * and PHY 1 is phy_0_peer.
+	 * On dual complex E825C, device phy_0 points to PHY on a current
+	 * complex and phy_0_peer to PHY on a different complex.
 	 */
-	if (port >= hw->ptp.ports_per_phy)
+	if ((!ice_is_dual(hw) && tgt_phy == 1) ||
+	    (ice_is_dual(hw) && tgt_phy != curr_phy))
 		return ice_sbq_dev_phy_0_peer;
 	else
 		return ice_sbq_dev_phy_0;
@@ -2417,6 +2432,7 @@ int ice_phy_cfg_intr_eth56g(struct ice_hw *hw, u8 port, bool ena, u8 threshold)
 static int ice_read_phy_and_phc_time_eth56g(struct ice_hw *hw, u8 port,
 					    u64 *phy_time, u64 *phc_time)
 {
+	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
 	u64 tx_time, rx_time;
 	u32 zo, lo;
 	u8 tmr_idx;
@@ -2436,8 +2452,13 @@ static int ice_read_phy_and_phc_time_eth56g(struct ice_hw *hw, u8 port,
 	ice_ptp_exec_tmr_cmd(hw);
 
 	/* Read the captured PHC time from the shadow time registers */
-	zo = rd32(hw, GLTSYN_SHTIME_0(tmr_idx));
-	lo = rd32(hw, GLTSYN_SHTIME_L(tmr_idx));
+	if (ice_is_primary(hw)) {
+		zo = rd32(hw, GLTSYN_SHTIME_0(tmr_idx));
+		lo = rd32(hw, GLTSYN_SHTIME_L(tmr_idx));
+	} else {
+		zo = rd32(ice_get_primary_hw(pf), GLTSYN_SHTIME_0(tmr_idx));
+		lo = rd32(ice_get_primary_hw(pf), GLTSYN_SHTIME_L(tmr_idx));
+	}
 	*phc_time = (u64)lo << 32 | zo;
 
 	/* Read the captured PHY time from the PHY shadow registers */
@@ -2574,6 +2595,7 @@ int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port, bool soft_reset)
  */
 int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 {
+	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
 	u32 lo, hi;
 	u64 incval;
 	u8 tmr_idx;
@@ -2599,8 +2621,13 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 	if (err)
 		return err;
 
-	lo = rd32(hw, GLTSYN_INCVAL_L(tmr_idx));
-	hi = rd32(hw, GLTSYN_INCVAL_H(tmr_idx));
+	if (ice_is_primary(hw)) {
+		lo = rd32(hw, GLTSYN_INCVAL_L(tmr_idx));
+		hi = rd32(hw, GLTSYN_INCVAL_H(tmr_idx));
+	} else {
+		lo = rd32(ice_get_primary_hw(pf), GLTSYN_INCVAL_L(tmr_idx));
+		hi = rd32(ice_get_primary_hw(pf), GLTSYN_INCVAL_H(tmr_idx));
+	}
 	incval = (u64)hi << 32 | lo;
 
 	err = ice_write_40b_ptp_reg_eth56g(hw, port, PHY_REG_TIMETUS_L, incval);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index e5925ccc2613..83f20fa7ace7 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -444,11 +444,6 @@ static inline u64 ice_get_base_incval(struct ice_hw *hw)
 	}
 }
 
-static inline bool ice_is_dual(struct ice_hw *hw)
-{
-	return !!(hw->dev_caps.nac_topo.mode & ICE_NAC_TOPO_DUAL_M);
-}
-
 #define PFTSYN_SEM_BYTES	4
 
 #define ICE_PTP_CLOCK_INDEX_0	0x00
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 0aab21113cc4..04123dfd20d2 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -970,6 +970,7 @@ struct ice_hw {
 	u8 intrl_gran;
 
 	struct ice_ptp_hw ptp;
+	u8 lane_num;
 
 	/* Active package version (currently active) */
 	struct ice_pkg_ver active_pkg_ver;
-- 
2.39.3


