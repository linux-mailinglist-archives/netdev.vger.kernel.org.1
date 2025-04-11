Return-Path: <netdev+bounces-181776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D73F2A8677F
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C0E37B1690
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBCE293B55;
	Fri, 11 Apr 2025 20:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EMfVai9/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D14B28FFE2
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 20:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404253; cv=none; b=l+JcYZ6h0sR+A5nLQ1k83jFiY1MjgOfjXqhNlYRDhTa7BUTSE8jCFwC55WhC8MsHMd9n3J8vRgGkEfkM71MZLY4eSmUDNa7v/66kxgZq5vIuy+kb9HlRplJyHFUW2lyOXFxC/H89Gjp97RasJn97XX1G4QvwaMS2mSmNk7KfIFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404253; c=relaxed/simple;
	bh=rciRK/cct95zL8D8vMhj7zbDuwBLml6Td8ojzVGmRR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZSQ8ToF+PHTzw9J5sTLuQJpH59FNJq4WVTrlfPM75MaxzimJ2Yz1bp+WR75ctyQHMfW7UiMcVXlWf5dKBNMhUXMXdjQFiZwHJwMlvjrBexiMgqa9JJpYyEINT8UKgKJ/KqqYWn2tq0vCIGi71XYfBt2g7CBYqWHo4NkSQgnAYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EMfVai9/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744404251; x=1775940251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rciRK/cct95zL8D8vMhj7zbDuwBLml6Td8ojzVGmRR4=;
  b=EMfVai9/WONveI43tLn3QG07WKeVXJHIzWe8xtpH5Hiwcf9Q5AAnQaRQ
   R4CmOdSwo0pGjiAQpUNXM1/Kbu+CmZwOlIwegHcHKeARk1Z1mqggRbiG9
   4dFlfEY/7l1omPwpt5CYu+Q82DpWyzZffySShDM1t0L9n1amTJfpKhxgb
   hHlgIMKB9ThDRMkfznzHhpY+lUlfYohoK6xypGql0JSlIBVvzifitNB41
   pzWm5RuxFWaAAIiGUpDteKhJp2c+5CGmdprCwe3lXmKI3pzRXOWUmZgkj
   3lwQu49u2YAZKVMi+ApW+7NKuUloTDNiaZIgqOvYZZEOyYjNA+GBINWQs
   w==;
X-CSE-ConnectionGUID: LsPKiS7BSOuzNSnq6+4ScA==
X-CSE-MsgGUID: OmkkTQsoQKCFje+wrwpC7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="45103875"
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="45103875"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 13:44:07 -0700
X-CSE-ConnectionGUID: VDwqaIiNQ6ebIIHhXc5Lig==
X-CSE-MsgGUID: ifz7ELQ1QuWLPtNg1yPOFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="129241811"
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
Subject: [PATCH net-next 06/15] ice: enable LLDP TX for VFs through tc
Date: Fri, 11 Apr 2025 13:43:47 -0700
Message-ID: <20250411204401.3271306-7-anthony.l.nguyen@intel.com>
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

Only a single VSI can be in charge of sending LLDP frames, sometimes it is
beneficial to assign this function to a VF, that is possible to do with tc
capabilities in the switchdev mode. It requires first blocking the PF from
sending the LLDP frames with a following command:

tc filter add dev <ifname> egress protocol lldp flower skip_sw action drop

Then it becomes possible to configure a forward rule from a VF port
representor to uplink instead.

tc filter add dev <vf_ifname> ingress protocol lldp flower skip_sw
action mirred egress redirect dev <ifname>

How LLDP exclusivity was done previously is LLDP traffic was blocked for a
whole port by a single rule and PF was bypassing that. Now at least in the
switchdev mode, every separate VSI has to have its own drop rule. Another
complication is the fact that tc does not respect when the driver refuses
to delete a rule, so returning an error results in a HW rule still present
with no way to reference it through tc. This is addressed by allowing the
PF rule to be deleted at any time, but making the VF forward rule "dormant"
in such case, this means it is deleted from HW but stays in tc and driver's
bookkeeping to be restored when drop rule is added back to the PF.

Implement tc configuration handling which enables the user to transmit LLDP
packets from VF instead of PF.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c |   2 +
 drivers/net/ethernet/intel/ice/ice_repr.c    |   7 +
 drivers/net/ethernet/intel/ice/ice_tc_lib.c  | 160 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_tc_lib.h  |   2 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h  |   4 +
 5 files changed, 175 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 206a7d839aef..6aae03771746 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -29,6 +29,7 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
 			return -ENODEV;
 
 	ice_remove_vsi_fltr(&pf->hw, uplink_vsi->idx);
+	ice_vsi_cfg_sw_lldp(uplink_vsi, true, false);
 
 	netif_addr_lock_bh(netdev);
 	__dev_uc_unsync(netdev, NULL);
@@ -282,6 +283,7 @@ static void ice_eswitch_release_env(struct ice_pf *pf)
 	ice_fltr_add_mac_and_broadcast(uplink_vsi,
 				       uplink_vsi->port_info->mac.perm_addr,
 				       ICE_FWD_TO_VSI);
+	ice_vsi_cfg_sw_lldp(uplink_vsi, true, true);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index f81bf60f8365..cb08746556a6 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -337,6 +337,7 @@ void ice_repr_destroy(struct ice_repr *repr)
 static void ice_repr_rem_vf(struct ice_repr *repr)
 {
 	ice_eswitch_decfg_vsi(repr->src_vsi, repr->parent_mac);
+	ice_pass_vf_tx_lldp(repr->src_vsi, true);
 	unregister_netdev(repr->netdev);
 	ice_devlink_destroy_vf_port(repr->vf);
 	ice_virtchnl_set_dflt_ops(repr->vf);
@@ -418,6 +419,10 @@ static int ice_repr_add_vf(struct ice_repr *repr)
 	if (err)
 		goto err_netdev;
 
+	err = ice_drop_vf_tx_lldp(repr->src_vsi, true);
+	if (err)
+		goto err_drop_lldp;
+
 	err = ice_eswitch_cfg_vsi(repr->src_vsi, repr->parent_mac);
 	if (err)
 		goto err_cfg_vsi;
@@ -430,6 +435,8 @@ static int ice_repr_add_vf(struct ice_repr *repr)
 	return 0;
 
 err_cfg_vsi:
+	ice_pass_vf_tx_lldp(repr->src_vsi, true);
+err_drop_lldp:
 	unregister_netdev(repr->netdev);
 err_netdev:
 	ice_devlink_destroy_vf_port(vf);
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index 229cd29ff92a..49b87071b7dc 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -762,6 +762,154 @@ static int ice_eswitch_tc_parse_action(struct net_device *filter_dev,
 	return 0;
 }
 
+static bool ice_is_fltr_lldp(struct ice_tc_flower_fltr *fltr)
+{
+	return fltr->outer_headers.l2_key.n_proto == htons(ETH_P_LLDP);
+}
+
+static bool ice_is_fltr_pf_tx_lldp(struct ice_tc_flower_fltr *fltr)
+{
+	struct ice_vsi *vsi = fltr->src_vsi, *uplink;
+
+	if (!ice_is_switchdev_running(vsi->back))
+		return false;
+
+	uplink = vsi->back->eswitch.uplink_vsi;
+	return vsi == uplink && fltr->action.fltr_act == ICE_DROP_PACKET &&
+	       ice_is_fltr_lldp(fltr) &&
+	       fltr->direction == ICE_ESWITCH_FLTR_EGRESS &&
+	       fltr->flags == ICE_TC_FLWR_FIELD_ETH_TYPE_ID;
+}
+
+static bool ice_is_fltr_vf_tx_lldp(struct ice_tc_flower_fltr *fltr)
+{
+	struct ice_vsi *vsi = fltr->src_vsi, *uplink;
+
+	uplink = vsi->back->eswitch.uplink_vsi;
+	return fltr->src_vsi->type == ICE_VSI_VF && ice_is_fltr_lldp(fltr) &&
+	       fltr->direction == ICE_ESWITCH_FLTR_EGRESS &&
+	       fltr->dest_vsi == uplink;
+}
+
+static struct ice_tc_flower_fltr *
+ice_find_pf_tx_lldp_fltr(struct ice_pf *pf)
+{
+	struct ice_tc_flower_fltr *fltr;
+
+	hlist_for_each_entry(fltr, &pf->tc_flower_fltr_list, tc_flower_node)
+		if (ice_is_fltr_pf_tx_lldp(fltr))
+			return fltr;
+
+	return NULL;
+}
+
+static bool ice_any_vf_lldp_tx_ena(struct ice_pf *pf)
+{
+	struct ice_vf *vf;
+	unsigned int bkt;
+
+	ice_for_each_vf(pf, bkt, vf)
+		if (vf->lldp_tx_ena)
+			return true;
+
+	return false;
+}
+
+int ice_pass_vf_tx_lldp(struct ice_vsi *vsi, bool deinit)
+{
+	struct ice_rule_query_data remove_entry = {
+		.rid = vsi->vf->lldp_recipe_id,
+		.rule_id = vsi->vf->lldp_rule_id,
+		.vsi_handle = vsi->idx,
+	};
+	struct ice_pf *pf = vsi->back;
+	int err;
+
+	if (vsi->vf->lldp_tx_ena)
+		return 0;
+
+	if (!deinit && !ice_find_pf_tx_lldp_fltr(vsi->back))
+		return -EINVAL;
+
+	if (!deinit && ice_any_vf_lldp_tx_ena(pf))
+		return -EINVAL;
+
+	err = ice_rem_adv_rule_by_id(&pf->hw, &remove_entry);
+	if (!err)
+		vsi->vf->lldp_tx_ena = true;
+
+	return err;
+}
+
+int ice_drop_vf_tx_lldp(struct ice_vsi *vsi, bool init)
+{
+	struct ice_rule_query_data rule_added;
+	struct ice_adv_rule_info rinfo = {
+		.priority = 7,
+		.src_vsi = vsi->idx,
+		.sw_act = {
+			.src = vsi->idx,
+			.flag = ICE_FLTR_TX,
+			.fltr_act = ICE_DROP_PACKET,
+			.vsi_handle = vsi->idx,
+		},
+		.flags_info.act_valid = true,
+	};
+	struct ice_adv_lkup_elem list[3];
+	struct ice_pf *pf = vsi->back;
+	int err;
+
+	if (!init && !vsi->vf->lldp_tx_ena)
+		return 0;
+
+	memset(list, 0, sizeof(list));
+	ice_rule_add_direction_metadata(&list[0]);
+	ice_rule_add_src_vsi_metadata(&list[1]);
+	list[2].type = ICE_ETYPE_OL;
+	list[2].h_u.ethertype.ethtype_id = htons(ETH_P_LLDP);
+	list[2].m_u.ethertype.ethtype_id = htons(0xFFFF);
+
+	err = ice_add_adv_rule(&pf->hw, list, ARRAY_SIZE(list), &rinfo,
+			       &rule_added);
+	if (err) {
+		dev_err(&pf->pdev->dev,
+			"Failed to add an LLDP rule to VSI 0x%X: %d\n",
+			vsi->idx, err);
+	} else {
+		vsi->vf->lldp_recipe_id = rule_added.rid;
+		vsi->vf->lldp_rule_id = rule_added.rule_id;
+		vsi->vf->lldp_tx_ena = false;
+	}
+
+	return err;
+}
+
+static void ice_handle_add_pf_lldp_drop_rule(struct ice_vsi *vsi)
+{
+	struct ice_tc_flower_fltr *fltr;
+	struct ice_pf *pf = vsi->back;
+
+	hlist_for_each_entry(fltr, &pf->tc_flower_fltr_list, tc_flower_node) {
+		if (!ice_is_fltr_vf_tx_lldp(fltr))
+			continue;
+		ice_pass_vf_tx_lldp(fltr->src_vsi, true);
+		break;
+	}
+}
+
+static void ice_handle_del_pf_lldp_drop_rule(struct ice_pf *pf)
+{
+	int i;
+
+	/* Make the VF LLDP fwd to uplink rule dormant */
+	ice_for_each_vsi(pf, i) {
+		struct ice_vsi *vf_vsi = pf->vsi[i];
+
+		if (vf_vsi && vf_vsi->type == ICE_VSI_VF)
+			ice_drop_vf_tx_lldp(vf_vsi, false);
+	}
+}
+
 static int
 ice_eswitch_add_tc_fltr(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr)
 {
@@ -779,6 +927,9 @@ ice_eswitch_add_tc_fltr(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr)
 		return -EOPNOTSUPP;
 	}
 
+	if (ice_is_fltr_vf_tx_lldp(fltr))
+		return ice_pass_vf_tx_lldp(vsi, false);
+
 	lkups_cnt = ice_tc_count_lkups(flags, fltr);
 	list = kcalloc(lkups_cnt, sizeof(*list), GFP_ATOMIC);
 	if (!list)
@@ -850,6 +1001,9 @@ ice_eswitch_add_tc_fltr(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr)
 		goto exit;
 	}
 
+	if (ice_is_fltr_pf_tx_lldp(fltr))
+		ice_handle_add_pf_lldp_drop_rule(vsi);
+
 	/* store the output params, which are needed later for removing
 	 * advanced switch filter
 	 */
@@ -1969,6 +2123,12 @@ static int ice_del_tc_fltr(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr)
 	struct ice_pf *pf = vsi->back;
 	int err;
 
+	if (ice_is_fltr_pf_tx_lldp(fltr))
+		ice_handle_del_pf_lldp_drop_rule(pf);
+
+	if (ice_is_fltr_vf_tx_lldp(fltr))
+		return ice_drop_vf_tx_lldp(vsi, false);
+
 	rule_rem.rid = fltr->rid;
 	rule_rem.rule_id = fltr->rule_id;
 	rule_rem.vsi_handle = fltr->dest_vsi_handle;
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.h b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
index df9f90f793b9..8a3ab2f22af9 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
@@ -217,6 +217,8 @@ int ice_del_cls_flower(struct ice_vsi *vsi,
 		       struct flow_cls_offload *cls_flower);
 void ice_replay_tc_fltrs(struct ice_pf *pf);
 bool ice_is_tunnel_supported(struct net_device *dev);
+int ice_drop_vf_tx_lldp(struct ice_vsi *vsi, bool init);
+int ice_pass_vf_tx_lldp(struct ice_vsi *vsi, bool deinit);
 
 static inline bool ice_is_forward_action(enum ice_sw_fwd_act_type fltr_act)
 {
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index f4c9ca1f51ce..482f4285fd35 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -124,6 +124,7 @@ struct ice_vf {
 	u8 spoofchk:1;
 	u8 link_forced:1;
 	u8 link_up:1;			/* only valid if VF link is forced */
+	u8 lldp_tx_ena:1;
 
 	u32 ptp_caps;
 
@@ -150,6 +151,9 @@ struct ice_vf {
 	/* devlink port data */
 	struct devlink_port devlink_port;
 
+	u16 lldp_recipe_id;
+	u16 lldp_rule_id;
+
 	u16 num_msix;			/* num of MSI-X configured on this VF */
 	struct ice_vf_qs_bw qs_bw[ICE_MAX_RSS_QS_PER_VF];
 };
-- 
2.47.1


