Return-Path: <netdev+bounces-304145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /lLKHgZQRmouQgsAu9opvQ
	(envelope-from <netdev+bounces-304145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 13:48:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D80AF6F6FD4
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 13:48:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="JFSl/F3F";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304145-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304145-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2633330D204D
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 11:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927043655D5;
	Thu,  2 Jul 2026 11:30:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6B342A7B8
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 11:30:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782991849; cv=none; b=awfxZOcVvmZ//7rSNSJGzWlGDuPI+d8/jeZwEXaqMgLAGtVAOgBGfyQ8zSxFN3pSRwUTUEJyU7fnpfsWnmpeG1Zn7LgFvh5LVVsGja1EACqaa/jzcCOWA5HDQwrVxCYNsl4jcNKBamIOZu+IOuMghqNh4Fg97BafS6sTxXWlpXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782991849; c=relaxed/simple;
	bh=cK1MFHk/Cm7aMsNBWPA/KZowX6nQ6QIgVF28AkTWd6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VtAl39dDTGy4nKoEUyq6PWmLMrIbpMoEyDEiR+ziuu1nkQUJaZCTdn42vq09IrAnWdXnoairEALsloY23fuZK9mlkF4sBqxK0p+62V8k6XG6zKsqPmAIaK9j0OjSHeVsqd438dZGgNtLsaDqRjOpjmE0e0lcicrf+w1PCPK1Sbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JFSl/F3F; arc=none smtp.client-ip=198.175.65.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782991848; x=1814527848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cK1MFHk/Cm7aMsNBWPA/KZowX6nQ6QIgVF28AkTWd6w=;
  b=JFSl/F3FhZ6six/akNTD3tGoiUs7yGXhAn/Yl59dM0wsu4vvPuwa9l95
   R4IxUi3Hs67Mqvo7In3o5koUiXA0DbcUSagqM4VhpAbPlk887B2XcFOfz
   pL5c1fw6TDIgJjEBSyzfzv9FcPOMl+JTG+qerYjivsoLsYaZJZKLznF0Q
   0vGkpt9HB0KmhSLQCwJ0PJMQvzsIX7NpYh+06mZag1Gb403AKB4u9VVqC
   c18AUQcnGywvVZU1zgxxJdejSZ+LCcZAP9ajJNrELgHK5fLBcB+mtzLaB
   ANLPBXu97VYegSZKF4dCxPQa9aaT+C8E2wcBxjdREzVyyEFZybbXkT4Rp
   A==;
X-CSE-ConnectionGUID: ZC92AKh1QTiT5s3z2I6Qlw==
X-CSE-MsgGUID: T9j588NgQDmbU46t8lAHRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="83611763"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="83611763"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 04:30:47 -0700
X-CSE-ConnectionGUID: juFCqkrbQ8mk4Fu4L7DTuw==
X-CSE-MsgGUID: 4DgCusuBRiyGiYbHCsBSig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="251788442"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa010.jf.intel.com with ESMTP; 02 Jul 2026 04:30:44 -0700
Received: from gond.igk.intel.com (gond.igk.intel.com [10.123.220.52])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 8619D28762;
	Thu,  2 Jul 2026 12:30:42 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	sandeep.penigalapati@intel.com,
	ananth.s@intel.com,
	alexander.duyck@gmail.com,
	anthony.l.nguyen@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-next v5 10/12] ice: add ACL reset recovery and NTUPLE feature toggle
Date: Thu,  2 Jul 2026 12:30:04 +0200
Message-ID: <20260702103007.97020-11-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260702103007.97020-1-marcin.szycik@linux.intel.com>
References: <20260702103007.97020-1-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,linux.intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[marcin.szycik@linux.intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:sandeep.penigalapati@intel.com,m:ananth.s@intel.com,m:alexander.duyck@gmail.com,m:anthony.l.nguyen@intel.com,m:marcin.szycik@linux.intel.com,m:alexanderduyck@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304145-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcin.szycik@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.intel.com:mid,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D80AF6F6FD4

Extend ACL support to survive PF resets. Add ice_acl_replay_flows() to
rebuild HW flow profiles from preserved SW state, and
ice_acl_replay_fltrs() to reprogram TCAM entries from the SW filter
list. Wire both into ice_rebuild(). On failure, don't fail reset, rather
delete all ACL filters from the SW list.

Reset per-profile HW extraction sequences and range checkers for all
profiles inside ice_acl_create_hw(). This state is separate from the
TCAM entries and survives a PF reset. Explicitly clearing it ensures
that the old configuration is erased.

Add the ICE_FLAG_ACL_ENA PF flag to track ACL status. ACL is always
available, so set it unconditionally in driver initialization. Use the
new flag to track the NTUPLE ethtool feature flag, alongside Flow
Director, as both blocks are used to implement ethtool NTUPLE filters.
Like with Flow Director, disabling the flag deletes all filters, but
enabling it does not reprogram filters.

Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
v5:
* Add this patch
---
 drivers/net/ethernet/intel/ice/ice.h          |  4 +
 drivers/net/ethernet/intel/ice/ice_acl.h      |  5 +-
 drivers/net/ethernet/intel/ice/ice_acl_main.h |  1 +
 drivers/net/ethernet/intel/ice/ice_acl_ctrl.c | 43 +++++-----
 drivers/net/ethernet/intel/ice/ice_acl_main.c | 47 +++++++++++
 .../ethernet/intel/ice/ice_ethtool_ntuple.c   | 79 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_main.c     | 47 +++++++++++
 7 files changed, 201 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index b586645bed00..d4abd948bc9d 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -504,6 +504,7 @@ enum ice_pf_flags {
 	ICE_FLAG_DCB_CAPABLE,
 	ICE_FLAG_DCB_ENA,
 	ICE_FLAG_FD_ENA,
+	ICE_FLAG_ACL_ENA,
 	ICE_FLAG_PTP_SUPPORTED,		/* PTP is supported by NVM */
 	ICE_FLAG_ADV_FEATURES,
 	ICE_FLAG_TC_MQPRIO,		/* support for Multi queue TC */
@@ -1011,10 +1012,12 @@ int ice_init_rdma(struct ice_pf *pf);
 void ice_deinit_rdma(struct ice_pf *pf);
 bool ice_is_wol_supported(struct ice_hw *hw);
 void ice_fdir_del_all_fltrs(struct ice_vsi *vsi);
+void ice_acl_del_all_fltrs(struct ice_vsi *vsi);
 int
 ice_fdir_write_fltr(struct ice_pf *pf, struct ice_ntuple_fltr *input, bool add,
 		    bool is_tun);
 void ice_vsi_manage_fdir(struct ice_vsi *vsi, bool ena);
+void ice_vsi_manage_acl(struct ice_vsi *vsi, bool ena);
 int ice_add_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd);
 int ice_del_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd);
 int ice_get_ethtool_fdir_entry(struct ice_hw *hw, struct ethtool_rxnfc *cmd);
@@ -1032,6 +1035,7 @@ ice_get_fdir_fltr_ids(struct ice_hw *hw, struct ethtool_rxnfc *cmd,
 		      u32 *rule_locs);
 void ice_fdir_rem_adq_chnl(struct ice_hw *hw, u16 vsi_idx);
 void ice_acl_rem_flows(struct ice_hw *hw);
+void ice_acl_replay_flows(struct ice_hw *hw);
 void ice_fdir_release_flows(struct ice_hw *hw);
 void ice_fdir_replay_flows(struct ice_hw *hw);
 void ice_fdir_replay_fltrs(struct ice_pf *pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_acl.h b/drivers/net/ethernet/intel/ice/ice_acl.h
index 0c8163e585d9..65e16ad1c783 100644
--- a/drivers/net/ethernet/intel/ice/ice_acl.h
+++ b/drivers/net/ethernet/intel/ice/ice_acl.h
@@ -6,6 +6,9 @@
 
 #include "ice_common.h"
 
+/* Maximum number of ACL HW profiles */
+#define ICE_ACL_MAX_PROF		128
+
 /* Marks a PF scenario slot as unused in the ACL profile extraction table */
 #define ICE_ACL_INVALID_SCEN		0x3f
 
@@ -124,7 +127,7 @@ struct ice_acl_cntrs {
 };
 
 int ice_acl_create_tbl(struct ice_hw *hw, struct ice_acl_tbl_params *params);
-int ice_acl_destroy_tbl(struct ice_hw *hw);
+void ice_acl_destroy_tbl(struct ice_hw *hw);
 int ice_acl_create_scen(struct ice_hw *hw, u16 match_width, u16 num_entries,
 			u16 *scen_id);
 int ice_aq_alloc_acl_tbl(struct ice_hw *hw, struct ice_acl_alloc_tbl *tbl,
diff --git a/drivers/net/ethernet/intel/ice/ice_acl_main.h b/drivers/net/ethernet/intel/ice/ice_acl_main.h
index 6665af2e7053..54053954b244 100644
--- a/drivers/net/ethernet/intel/ice/ice_acl_main.h
+++ b/drivers/net/ethernet/intel/ice/ice_acl_main.h
@@ -6,4 +6,5 @@
 #include "ice.h"
 #include <linux/ethtool.h>
 int ice_acl_add_rule_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd);
+void ice_acl_replay_fltrs(struct ice_pf *pf);
 #endif /* _ICE_ACL_MAIN_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c b/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
index 32b05df88be3..a76762e3aa46 100644
--- a/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
+++ b/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
@@ -877,9 +877,10 @@ static int ice_acl_destroy_scen(struct ice_hw *hw, u16 scen_id)
  * ice_acl_destroy_tbl - Destroy a previously created LEM table for ACL
  * @hw: pointer to the HW struct
  *
- * Return: 0 on success, negative on error
+ * Continue on AQ errors so SW state is always cleaned up - e.g. after a reset,
+ * where the HW tables might be already gone.
  */
-int ice_acl_destroy_tbl(struct ice_hw *hw)
+void ice_acl_destroy_tbl(struct ice_hw *hw)
 {
 	struct ice_acl_scen *pos_scen, *tmp_scen;
 	struct ice_aqc_acl_generic resp_buf;
@@ -887,7 +888,7 @@ int ice_acl_destroy_tbl(struct ice_hw *hw)
 	int err;
 
 	if (!hw->acl_tbl)
-		return -ENOENT;
+		return;
 
 	/* Mark all the created scenario's TCAM to stop the packet lookup and
 	 * delete them afterward
@@ -898,44 +899,38 @@ int ice_acl_destroy_tbl(struct ice_hw *hw)
 		if (err) {
 			ice_debug(hw, ICE_DBG_ACL, "ice_aq_query_acl_scen() failed. status: %d\n",
 				  err);
-			return err;
-		}
-
-		for (int i = 0; i < ICE_AQC_ACL_SLICES; i++) {
-			buf.tcam_cfg[i].chnk_msk = 0;
-			buf.tcam_cfg[i].start_cmp_set =
-					ICE_AQC_ACL_ALLOC_SCE_START_CMP;
-		}
+		} else {
+			for (int i = 0; i < ICE_AQC_ACL_SLICES; i++) {
+				buf.tcam_cfg[i].chnk_msk = 0;
+				buf.tcam_cfg[i].start_cmp_set =
+						ICE_AQC_ACL_ALLOC_SCE_START_CMP;
+			}
 
-		for (int i = 0; i < ICE_AQC_MAX_ACTION_MEMORIES; i++)
-			buf.act_mem_cfg[i] = 0;
+			for (int i = 0; i < ICE_AQC_MAX_ACTION_MEMORIES; i++)
+				buf.act_mem_cfg[i] = 0;
 
-		err = ice_aq_update_acl_scen(hw, pos_scen->id, &buf, NULL);
-		if (err) {
-			ice_debug(hw, ICE_DBG_ACL, "ice_aq_update_acl_scen() failed. status: %d\n",
-				  err);
-			return err;
+			err = ice_aq_update_acl_scen(hw, pos_scen->id, &buf,
+						     NULL);
+			if (err)
+				ice_debug(hw, ICE_DBG_ACL, "scenario update failed, status: %d\n",
+					  err);
 		}
 
 		err = ice_acl_destroy_scen(hw, pos_scen->id);
 		if (err) {
-			ice_debug(hw, ICE_DBG_ACL, "deletion of scenario failed. status: %d\n",
+			ice_debug(hw, ICE_DBG_ACL, "deletion of scenario failed, status: %d\n",
 				  err);
-			return err;
 		}
 	}
 
 	err = ice_aq_dealloc_acl_tbl(hw, hw->acl_tbl->id, &resp_buf, NULL);
 	if (err) {
-		ice_debug(hw, ICE_DBG_ACL, "AQ de-allocation of ACL failed. status: %d\n",
+		ice_debug(hw, ICE_DBG_ACL, "AQ de-allocation of ACL failed, status: %d\n",
 			  err);
-		return err;
 	}
 
 	kfree(hw->acl_tbl);
 	hw->acl_tbl = NULL;
-
-	return 0;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_acl_main.c b/drivers/net/ethernet/intel/ice/ice_acl_main.c
index 92cabb0b685f..7c566077d55a 100644
--- a/drivers/net/ethernet/intel/ice/ice_acl_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_acl_main.c
@@ -236,6 +236,53 @@ static void ice_acl_set_act_fwd_queue(struct ice_flow_action *action,
 	action->data.acl_act.value = cpu_to_le16(queue_index);
 }
 
+/*
+ * ice_acl_replay_fltrs - replay ACL filters from the SW filter list
+ * @pf: board private structure
+ *
+ * Reprograms ACL TCAM entries after a reset using data preserved in the
+ * SW filter list. Relies on ice_acl_replay_flows() having been called first
+ * to restore the flow profiles.
+ */
+void ice_acl_replay_fltrs(struct ice_pf *pf)
+{
+	struct ice_vsi *vsi = ice_get_main_vsi(pf);
+	struct ice_hw *hw = &pf->hw;
+	struct ice_ntuple_fltr *f_rule;
+
+	if (!vsi)
+		return;
+
+	list_for_each_entry(f_rule, &hw->fdir_list_head, fltr_node) {
+		struct ice_flow_action acts[ICE_ACL_NUM_ACT];
+		struct ice_acl_hw_prof *hw_prof;
+		u64 entry_h = 0;
+		int err;
+
+		if (!f_rule->acl_fltr)
+			continue;
+
+		if (!hw->acl_prof || !hw->acl_prof[f_rule->flow_type])
+			continue;
+
+		hw_prof = hw->acl_prof[f_rule->flow_type];
+
+		memset(&acts, 0, sizeof(acts));
+		if (f_rule->dest_ctl == ICE_FLTR_PRGM_DESC_DEST_DROP_PKT)
+			ice_acl_set_act_drop(&acts[0]);
+		else
+			ice_acl_set_act_fwd_queue(&acts[0], f_rule->q_index);
+
+		err = ice_flow_add_entry(hw, ICE_BLK_ACL, hw_prof->prof_id,
+					 f_rule->fltr_id, vsi->idx,
+					 ICE_FLOW_PRIO_NORMAL, f_rule, acts,
+					 ICE_ACL_NUM_ACT, &entry_h);
+		if (err)
+			dev_warn(ice_pf_to_dev(pf), "Could not reprogram filter %d, status %d\n",
+				 f_rule->fltr_id, err);
+	}
+}
+
 /**
  * ice_acl_add_rule_ethtool - add an ACL rule
  * @vsi: pointer to target VSI
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
index 21a3a6a2f283..be7bfee9e977 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
@@ -514,6 +514,37 @@ void ice_fdir_replay_flows(struct ice_hw *hw)
 	}
 }
 
+/**
+ * ice_acl_replay_flows - replay HW ACL flow profiles
+ * @hw: pointer to HW instance
+ */
+void ice_acl_replay_flows(struct ice_hw *hw)
+{
+	if (!hw->acl_prof)
+		return;
+
+	for (enum ice_fltr_ptype flow = ICE_FLTR_PTYPE_NONF_NONE;
+	     flow < ICE_FLTR_PTYPE_MAX; flow++) {
+		struct ice_flow_prof *hw_prof;
+		struct ice_acl_hw_prof *prof;
+		int err;
+
+		flow &= ~FLOW_EXT;
+		prof = hw->acl_prof[flow];
+		if (!prof || !prof->seg)
+			continue;
+
+		err = ice_flow_add_prof(hw, ICE_BLK_ACL, ICE_FLOW_RX,
+					prof->seg, 1, false, &hw_prof);
+		if (err) {
+			dev_err(ice_hw_to_dev(hw), "Could not replay ACL, flow type %d\n",
+				flow);
+			continue;
+		}
+		prof->prof_id = hw_prof->id;
+	}
+}
+
 /**
  * ice_parse_rx_flow_user_data - deconstruct user-defined data
  * @fsp: pointer to ethtool Rx flow specification
@@ -1800,6 +1831,28 @@ static int ice_del_acl_ethtool(struct ice_hw *hw, struct ice_ntuple_fltr *fltr)
 	return ice_flow_rem_entry(hw, ICE_BLK_ACL, entry);
 }
 
+/**
+ * ice_acl_del_all_fltrs - Delete all ACL filters from the filter list
+ * @vsi: the VSI being changed
+ *
+ * This function needs to be called while holding hw->fdir_fltr_lock
+ */
+void ice_acl_del_all_fltrs(struct ice_vsi *vsi)
+{
+	struct ice_ntuple_fltr *f_rule, *tmp;
+	struct ice_hw *hw = &vsi->back->hw;
+
+	list_for_each_entry_safe(f_rule, tmp, &hw->fdir_list_head, fltr_node) {
+		if (!f_rule->acl_fltr)
+			continue;
+
+		ice_del_acl_ethtool(hw, f_rule);
+		ice_ntuple_update_cntrs(hw, f_rule, false);
+		list_del(&f_rule->fltr_node);
+		kfree(f_rule);
+	}
+}
+
 /**
  * ice_vsi_manage_fdir - turn on/off flow director
  * @vsi: the VSI being changed
@@ -1833,6 +1886,32 @@ void ice_vsi_manage_fdir(struct ice_vsi *vsi, bool ena)
 	mutex_unlock(&hw->fdir_fltr_lock);
 }
 
+/**
+ * ice_vsi_manage_acl - turn on/off ACL
+ * @vsi: the VSI being changed
+ * @ena: boolean value indicating if this is an enable or disable request
+ */
+void ice_vsi_manage_acl(struct ice_vsi *vsi, bool ena)
+{
+	struct ice_pf *pf = vsi->back;
+	struct ice_hw *hw = &pf->hw;
+
+	if (ena) {
+		set_bit(ICE_FLAG_ACL_ENA, pf->flags);
+		return;
+	}
+
+	mutex_lock(&hw->fdir_fltr_lock);
+	if (!test_and_clear_bit(ICE_FLAG_ACL_ENA, pf->flags))
+		goto release_lock;
+
+	ice_acl_del_all_fltrs(vsi);
+	ice_acl_rem_flows(hw);
+
+release_lock:
+	mutex_unlock(&hw->fdir_fltr_lock);
+}
+
 /**
  * ice_fdir_do_rem_flow - delete flow and possibly add perfect flow
  * @pf: PF structure
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 22a7458d0560..5457b0ed78eb 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -18,6 +18,7 @@
 #include "ice_sf_eth.h"
 #include "ice_hwmon.h"
 #include "ice_acl.h"
+#include "ice_acl_main.h"
 /* Including ice_trace.h with CREATE_TRACE_POINTS defined will generate the
  * ice tracepoint functions. This must be done exactly once across the
  * ice driver.
@@ -3936,6 +3937,9 @@ static void ice_set_pf_caps(struct ice_pf *pf)
 				       func_caps->fd_fltr_best_effort);
 	}
 
+	/* ACL is always initially available */
+	set_bit(ICE_FLAG_ACL_ENA, pf->flags);
+
 	clear_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags);
 	if (func_caps->common_cap.ieee_1588)
 		set_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags);
@@ -4359,6 +4363,30 @@ static int ice_acl_create_hw(struct ice_pf *pf)
 	if (err)
 		goto destroy_table;
 
+	/* Reset profile extraction sequences and range checkers for all
+	 * possible HW profile IDs. The TCAM entries are already zeroed by
+	 * ice_acl_init_tbl() inside ice_acl_create_tbl(), but profile
+	 * extraction and range checker state is separate per-profile HW state
+	 * that survives PF reset, therefore must be brought back to default
+	 * state.
+	 */
+	for (u8 prof_id = 0; prof_id < ICE_ACL_MAX_PROF; prof_id++) {
+		struct ice_aqc_acl_prof_generic_frmt xtrct_buf = {};
+		struct ice_aqc_acl_profile_ranges range_buf = {};
+
+		memset(xtrct_buf.pf_scenario_num, ICE_ACL_INVALID_SCEN,
+		       sizeof(xtrct_buf.pf_scenario_num));
+		err = ice_prgm_acl_prof_xtrct(hw, prof_id, &xtrct_buf, NULL);
+		if (err)
+			dev_warn(ice_pf_to_dev(pf), "Failed to reset profile extraction for profile %u\n",
+				 prof_id);
+
+		ice_prog_acl_prof_ranges(hw, prof_id, &range_buf, NULL);
+		if (err)
+			dev_warn(ice_pf_to_dev(pf), "Failed to reset range checkers for profile %u\n",
+				 prof_id);
+	}
+
 	return 0;
 
 destroy_table:
@@ -6588,6 +6616,7 @@ ice_set_features(struct net_device *netdev, netdev_features_t features)
 		bool ena = !!(features & NETIF_F_NTUPLE);
 
 		ice_vsi_manage_fdir(vsi, ena);
+		ice_vsi_manage_acl(vsi, ena);
 		ena ? ice_init_arfs(vsi) : ice_clear_arfs(vsi);
 	}
 
@@ -7873,6 +7902,24 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 		ice_rebuild_arfs(pf);
 	}
 
+	if (test_bit(ICE_FLAG_ACL_ENA, pf->flags)) {
+		/* Clean up the stale HW table SW state left by the reset,
+		 * recreate the HW table and scenario, then replay flow profiles
+		 * from preserved SW state.
+		 */
+		ice_acl_destroy_tbl(hw);
+		if (!ice_acl_create_hw(pf)) {
+			ice_acl_replay_flows(hw);
+			ice_acl_replay_fltrs(pf);
+		} else {
+			dev_err(dev, "Failed to rebuild ACL\n");
+			mutex_lock(&hw->fdir_fltr_lock);
+			if (vsi)
+				ice_acl_del_all_fltrs(vsi);
+			mutex_unlock(&hw->fdir_fltr_lock);
+		}
+	}
+
 	if (vsi && vsi->netdev)
 		netif_device_attach(vsi->netdev);
 
-- 
2.49.0


