Return-Path: <netdev+bounces-240481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACE0C755D3
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id C88C12BA3E
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 16:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7409136E57C;
	Thu, 20 Nov 2025 16:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="facUANTf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919E836CE0F;
	Thu, 20 Nov 2025 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656109; cv=none; b=ek+2PA3t+PXEUPngM1EcLPBv505NqsWembQt1F9TjuDyMzbUw8NrKMDFUk4UyTzlAeG1lCKezvWIqXo1bHqA/tfkJ9QC9rHifjaRaRrP0LaOxBfDg4M5wD+GaPbBD72OvnHNtw/JEPPjIMrL04u1q1IDkeO4StlpThsWg/bdBxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656109; c=relaxed/simple;
	bh=blYugHy6Y+vpD16wimuhQ7vAEzDULMbvdxJyg0IihBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpH1dUN/54RvYjUHWDG2XjKiY137v3R1one/jUjK4VWRtqZjJhIogfhL1TkuKNPj2qXZcT2DVUTwqp8SQu2d2U6JzqkVlu4vNnXzXaF3MzvBVoRFXPWItTMO2uCa91LE8Z+5hyhmZ83zh3kS4abLbW269jWFiAyMcPp1WEccRAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=facUANTf; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763656107; x=1795192107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=blYugHy6Y+vpD16wimuhQ7vAEzDULMbvdxJyg0IihBY=;
  b=facUANTf8Yhz+fZdycTNphGtfA/8gOdL/4frnsDnOGgTzrn/Yrf/LPGk
   E8XLF6nSfmBIVUf4kambiXe1x/QyxJTHuCbq3ASQz0ayyX+p8I5EAQJ4Y
   FvCfWgFWriI7bHrliDpCI9Vp6vna2LkqekVPqNl3HcI+zjHbB20U1RyGS
   +PHhzOY7LDQq1Cwclg/vayWJ99gMF4hMTZqq83Q3ESAClbS40yEKFtlIv
   hR/OffFTIZChse849kltIKnMuDwKQsxWLRGuGE8upmlB0goEs8mcyi7wd
   obsCXzAwxmHn1tws1z0rKLvag4PKbPFXGtieTxqPoHQKX3sSBvetk3Xnt
   g==;
X-CSE-ConnectionGUID: xOtBfCUXRmu2zyDpKDvYkQ==
X-CSE-MsgGUID: Tf6DeQE7RVi6KcwEe5wL+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="69599305"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="69599305"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 08:28:27 -0800
X-CSE-ConnectionGUID: EIRml9c9TsWL+ufx+DrWSQ==
X-CSE-MsgGUID: lPeWA4ULR9ynRkwTKb6bPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="191531295"
Received: from hpe-dl385gen10.igk.intel.com ([10.91.240.117])
  by orviesa008.jf.intel.com with ESMTP; 20 Nov 2025 08:28:25 -0800
From: Jakub Slepecki <jakub.slepecki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	jakub.slepecki@intel.com
Subject: [PATCH iwl-next 5/8] ice: update mac,vlan rules when toggling between VEB and VEPA
Date: Thu, 20 Nov 2025 17:28:10 +0100
Message-ID: <20251120162813.37942-6-jakub.slepecki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120162813.37942-1-jakub.slepecki@intel.com>
References: <20251120162813.37942-1-jakub.slepecki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

When changing into VEPA mode MAC rules are modified to forward all traffic
to the wire instead of allowing some packets to go into the loopback.
MAC,VLAN rules may and will also be used to forward loopback traffic
in VEB, so when we switch to VEPA, we want them to behave similarly to
MAC-only rules.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Jakub Slepecki <jakub.slepecki@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c   | 38 ++++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_switch.c |  8 +++--
 drivers/net/ethernet/intel/ice/ice_switch.h |  3 +-
 3 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 0b6175ade40d..661af039bf4f 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -8115,8 +8115,8 @@ ice_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
 	struct ice_pf *pf = ice_netdev_to_pf(dev);
 	struct nlattr *attr, *br_spec;
 	struct ice_hw *hw = &pf->hw;
+	int rem, v, rb_err, err = 0;
 	struct ice_sw *pf_sw;
-	int rem, v, err = 0;
 
 	pf_sw = pf->first_sw;
 	/* find the attribute in the netlink message */
@@ -8126,6 +8126,7 @@ ice_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
 
 	nla_for_each_nested_type(attr, IFLA_BRIDGE_MODE, br_spec, rem) {
 		__u16 mode = nla_get_u16(attr);
+		u8 old_evb_veb = hw->evb_veb;
 
 		if (mode != BRIDGE_MODE_VEPA && mode != BRIDGE_MODE_VEB)
 			return -EINVAL;
@@ -8147,17 +8148,38 @@ ice_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
 		/* Update the unicast switch filter rules for the corresponding
 		 * switch of the netdev
 		 */
-		err = ice_update_sw_rule_bridge_mode(hw);
+		err = ice_update_sw_rule_bridge_mode(hw, ICE_SW_LKUP_MAC);
 		if (err) {
-			netdev_err(dev, "switch rule update failed, mode = %d err %d aq_err %s\n",
-				   mode, err,
+			/* evb_veb is expected to be already reverted in error
+			 * path because of the potential rollback.
+			 */
+			hw->evb_veb = old_evb_veb;
+			goto err_without_rollback;
+		}
+		err = ice_update_sw_rule_bridge_mode(hw, ICE_SW_LKUP_MAC_VLAN);
+		if (err) {
+			/* ice_update_sw_rule_bridge_mode looks this up, so we
+			 * must revert it before attempting a rollback.
+			 */
+			hw->evb_veb = old_evb_veb;
+			goto err_rollback_mac;
+		}
+		pf_sw->bridge_mode = mode;
+		continue;
+
+err_rollback_mac:
+		rb_err = ice_update_sw_rule_bridge_mode(hw, ICE_SW_LKUP_MAC);
+		if (rb_err) {
+			netdev_err(dev, "switch rule update failed, mode = %d err %d; rollback failed, err %d aq_err %s\n",
+				   mode, err, rb_err,
 				   libie_aq_str(hw->adminq.sq_last_status));
-			/* revert hw->evb_veb */
-			hw->evb_veb = (pf_sw->bridge_mode == BRIDGE_MODE_VEB);
-			return err;
+			return rb_err;
 		}
 
-		pf_sw->bridge_mode = mode;
+err_without_rollback:
+		netdev_err(dev, "switch rule update failed, mode = %d err %d aq_err %s\n",
+			   mode, err, libie_aq_str(hw->adminq.sq_last_status));
+		return err;
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 7b63588948fd..b1445dfb1b64 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -3065,10 +3065,12 @@ ice_update_pkt_fwd_rule(struct ice_hw *hw, struct ice_fltr_info *f_info)
 /**
  * ice_update_sw_rule_bridge_mode
  * @hw: pointer to the HW struct
+ * @lkup: recipe/lookup type to update
  *
  * Updates unicast switch filter rules based on VEB/VEPA mode
  */
-int ice_update_sw_rule_bridge_mode(struct ice_hw *hw)
+int ice_update_sw_rule_bridge_mode(struct ice_hw *hw,
+				   enum ice_sw_lkup_type lkup)
 {
 	struct ice_switch_info *sw = hw->switch_info;
 	struct ice_fltr_mgmt_list_entry *fm_entry;
@@ -3076,8 +3078,8 @@ int ice_update_sw_rule_bridge_mode(struct ice_hw *hw)
 	struct mutex *rule_lock; /* Lock to protect filter rule list */
 	int status = 0;
 
-	rule_lock = &sw->recp_list[ICE_SW_LKUP_MAC].filt_rule_lock;
-	rule_head = &sw->recp_list[ICE_SW_LKUP_MAC].filt_rules;
+	rule_lock = &sw->recp_list[lkup].filt_rule_lock;
+	rule_head = &sw->recp_list[lkup].filt_rules;
 
 	mutex_lock(rule_lock);
 	list_for_each_entry(fm_entry, rule_head, list_entry) {
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.h b/drivers/net/ethernet/intel/ice/ice_switch.h
index a7dc4bfec3a0..60527475959b 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.h
+++ b/drivers/net/ethernet/intel/ice/ice_switch.h
@@ -360,7 +360,8 @@ int
 ice_add_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 		 u16 lkups_cnt, struct ice_adv_rule_info *rinfo,
 		 struct ice_rule_query_data *added_entry);
-int ice_update_sw_rule_bridge_mode(struct ice_hw *hw);
+int ice_update_sw_rule_bridge_mode(struct ice_hw *hw,
+				   enum ice_sw_lkup_type lkup);
 int ice_add_vlan(struct ice_hw *hw, struct list_head *m_list);
 int ice_remove_vlan(struct ice_hw *hw, struct list_head *v_list);
 int ice_add_mac(struct ice_hw *hw, struct list_head *m_lst);
-- 
2.43.0


