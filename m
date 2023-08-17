Return-Path: <netdev+bounces-28611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E9E77FFE5
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 23:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034501C20EF5
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34F91B7FB;
	Thu, 17 Aug 2023 21:29:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50181B7FA
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 21:29:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E7AE55
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692307776; x=1723843776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ekw8LJZ1jk7ooY1WN2ZYBpmuxMcfMwwdWDinqDWTVBM=;
  b=ZDfCcqpsjzne69GEnSXYkuvdouaI+yTZwBe2vwRZAVe0PRBOJJca63OK
   fQbmg8CyG5qGz6GoR87wukLore67SgthcVVVdvLY82+BllBlTkZ6d4Ovb
   vVG8CWXs6YWxQNYW3TTB5KlsyRAhmSuNqybrPwo5l8H4mcDskOWIGs2bM
   LTBvjaQhgdZ8q07CjjSyRJdW5mMjD92Fw4sCVTgvQT8SRKkADQH2PNWhK
   n+NFoDljXwJd1w80ykyYOaUvjrCFiRfamaKhqLnf2mwrnLz35sFrvTdES
   oa670Hr8GaqaFhT7+hrtLninXUNSiQQm1INF13yP1h+gvlP0JvbQbaPE9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="363095036"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="363095036"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 14:29:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="824813692"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="824813692"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Aug 2023 14:29:34 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jan Sokolowski <jan.sokolowski@intel.com>,
	anthony.l.nguyen@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH net-next v2 01/15] ice: remove unused methods
Date: Thu, 17 Aug 2023 14:22:25 -0700
Message-Id: <20230817212239.2601543-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230817212239.2601543-1-anthony.l.nguyen@intel.com>
References: <20230817212239.2601543-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jan Sokolowski <jan.sokolowski@intel.com>

Following methods were found to no longer be in use:
ice_is_pca9575_present
ice_mac_fltr_exist
ice_napi_del

Remove them.

Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c    | 15 -------
 drivers/net/ethernet/intel/ice/ice_lib.h    |  2 -
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 19 --------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  1 -
 drivers/net/ethernet/intel/ice/ice_switch.c | 48 ---------------------
 drivers/net/ethernet/intel/ice/ice_switch.h |  1 -
 6 files changed, 86 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 927518fcad51..54aa01d2a474 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2943,21 +2943,6 @@ void ice_vsi_dis_irq(struct ice_vsi *vsi)
 		synchronize_irq(vsi->q_vectors[i]->irq.virq);
 }
 
-/**
- * ice_napi_del - Remove NAPI handler for the VSI
- * @vsi: VSI for which NAPI handler is to be removed
- */
-void ice_napi_del(struct ice_vsi *vsi)
-{
-	int v_idx;
-
-	if (!vsi->netdev)
-		return;
-
-	ice_for_each_q_vector(vsi, v_idx)
-		netif_napi_del(&vsi->q_vectors[v_idx]->napi);
-}
-
 /**
  * ice_vsi_release - Delete a VSI and free its resources
  * @vsi: the VSI being removed
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index dd53fe968ad8..cb6599cb8be6 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -93,8 +93,6 @@ void ice_vsi_cfg_netdev_tc(struct ice_vsi *vsi, u8 ena_tc);
 struct ice_vsi *
 ice_vsi_setup(struct ice_pf *pf, struct ice_vsi_cfg_params *params);
 
-void ice_napi_del(struct ice_vsi *vsi);
-
 int ice_vsi_release(struct ice_vsi *vsi);
 
 void ice_vsi_close(struct ice_vsi *vsi);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index a38614d21ea8..a0da1bb55ba1 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -3308,25 +3308,6 @@ int ice_read_pca9575_reg_e810t(struct ice_hw *hw, u8 offset, u8 *data)
 	return ice_aq_read_i2c(hw, link_topo, 0, addr, 1, data, NULL);
 }
 
-/**
- * ice_is_pca9575_present
- * @hw: pointer to the hw struct
- *
- * Check if the SW IO expander is present in the netlist
- */
-bool ice_is_pca9575_present(struct ice_hw *hw)
-{
-	u16 handle = 0;
-	int status;
-
-	if (!ice_is_e810t(hw))
-		return false;
-
-	status = ice_get_pca9575_handle(hw, &handle);
-
-	return !status && handle;
-}
-
 /**
  * ice_ptp_reset_ts_memory - Reset timestamp memory for all blocks
  * @hw: pointer to the HW struct
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 1969425f0084..07cd023b0efd 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -199,7 +199,6 @@ int ice_ptp_init_phy_e810(struct ice_hw *hw);
 int ice_read_sma_ctrl_e810t(struct ice_hw *hw, u8 *data);
 int ice_write_sma_ctrl_e810t(struct ice_hw *hw, u8 data);
 int ice_read_pca9575_reg_e810t(struct ice_hw *hw, u8 offset, u8 *data);
-bool ice_is_pca9575_present(struct ice_hw *hw);
 
 #define PFTSYN_SEM_BYTES	4
 
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index a7afb612fe32..24c3f481848b 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -3408,54 +3408,6 @@ ice_remove_rule_internal(struct ice_hw *hw, u8 recp_id,
 	return status;
 }
 
-/**
- * ice_mac_fltr_exist - does this MAC filter exist for given VSI
- * @hw: pointer to the hardware structure
- * @mac: MAC address to be checked (for MAC filter)
- * @vsi_handle: check MAC filter for this VSI
- */
-bool ice_mac_fltr_exist(struct ice_hw *hw, u8 *mac, u16 vsi_handle)
-{
-	struct ice_fltr_mgmt_list_entry *entry;
-	struct list_head *rule_head;
-	struct ice_switch_info *sw;
-	struct mutex *rule_lock; /* Lock to protect filter rule list */
-	u16 hw_vsi_id;
-
-	if (!ice_is_vsi_valid(hw, vsi_handle))
-		return false;
-
-	hw_vsi_id = ice_get_hw_vsi_num(hw, vsi_handle);
-	sw = hw->switch_info;
-	rule_head = &sw->recp_list[ICE_SW_LKUP_MAC].filt_rules;
-	if (!rule_head)
-		return false;
-
-	rule_lock = &sw->recp_list[ICE_SW_LKUP_MAC].filt_rule_lock;
-	mutex_lock(rule_lock);
-	list_for_each_entry(entry, rule_head, list_entry) {
-		struct ice_fltr_info *f_info = &entry->fltr_info;
-		u8 *mac_addr = &f_info->l_data.mac.mac_addr[0];
-
-		if (is_zero_ether_addr(mac_addr))
-			continue;
-
-		if (f_info->flag != ICE_FLTR_TX ||
-		    f_info->src_id != ICE_SRC_ID_VSI ||
-		    f_info->lkup_type != ICE_SW_LKUP_MAC ||
-		    f_info->fltr_act != ICE_FWD_TO_VSI ||
-		    hw_vsi_id != f_info->fwd_id.hw_vsi_id)
-			continue;
-
-		if (ether_addr_equal(mac, mac_addr)) {
-			mutex_unlock(rule_lock);
-			return true;
-		}
-	}
-	mutex_unlock(rule_lock);
-	return false;
-}
-
 /**
  * ice_vlan_fltr_exist - does this VLAN filter exist for given VSI
  * @hw: pointer to the hardware structure
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.h b/drivers/net/ethernet/intel/ice/ice_switch.h
index 0bd4320e39df..db7e501b7e0a 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.h
+++ b/drivers/net/ethernet/intel/ice/ice_switch.h
@@ -371,7 +371,6 @@ int ice_add_vlan(struct ice_hw *hw, struct list_head *m_list);
 int ice_remove_vlan(struct ice_hw *hw, struct list_head *v_list);
 int ice_add_mac(struct ice_hw *hw, struct list_head *m_lst);
 int ice_remove_mac(struct ice_hw *hw, struct list_head *m_lst);
-bool ice_mac_fltr_exist(struct ice_hw *hw, u8 *mac, u16 vsi_handle);
 bool ice_vlan_fltr_exist(struct ice_hw *hw, u16 vlan_id, u16 vsi_handle);
 int ice_add_eth_mac(struct ice_hw *hw, struct list_head *em_list);
 int ice_remove_eth_mac(struct ice_hw *hw, struct list_head *em_list);
-- 
2.38.1


