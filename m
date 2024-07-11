Return-Path: <netdev+bounces-110915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 766C892EE94
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 20:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38E51F25351
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 18:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77F916EB57;
	Thu, 11 Jul 2024 18:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hugR45uv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F1F16E875
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 18:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721612; cv=none; b=AhEx+H4nH8QuJD8fwFeayXo3TMxMG7DGzp5AuDQwcFq+ByBKf4ROWDkAjtbuzjyYyLki0LM9yzs0xHC2N76+UetOqGkNxGrhciFqn/oVQNCSNab26ShozZeNOeDNg5PmQHxFDJeixibkfcRa83DNZYkc4f/S3p9aGKUntvNXSJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721612; c=relaxed/simple;
	bh=089UMu7QvZxAxoaPmebl1Qdp69qYm8xRfIzhiP0uWyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tdAakzEg2J7PIbuKARFpqDM7YWRFhehDh63V48UiG8lG0hFUVmd8MIi3MUWQ/YwrERJY5TF5sNz8letKFuGTZGSGUxj7bcUgqXvIVO/gEauR996nN/rnX9eTJfzWMVJyASUfFnkeDHtl3n1PxPO1meDDAs6FiF3IFiNm3DFf0r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hugR45uv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720721610; x=1752257610;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=089UMu7QvZxAxoaPmebl1Qdp69qYm8xRfIzhiP0uWyY=;
  b=hugR45uvDg/ZWiV5BXaKXe1A93bdtHxikGGwceV3duGI3SHpvFfJPr0k
   y461ikGfiUIyZWDgAw6MfOruUuVyVO0Naj/zPENGblOPvK2eUbLGktEDc
   41CUP8huqy2voe5+gwjQqN5qViTY4Hm7ae0fjLeiaqjbhhSd3IsM6BILp
   7oCL8Nw10ww8ydSFNWocmgOe9U255ft9cu+S4ZTLiXMondk6KbnBmvlxo
   SwtVaNfmM6Y1u+Kz6V85JQ/TM92tvMehrycWTTKSyhBn7DwJZPVgwt1Rl
   HyqRJl0Br9mQdicRbEvU8wGCGVvrVHcnwgHE49zB4hamaRcsSF919Lx2z
   A==;
X-CSE-ConnectionGUID: y9NrZhVxTPyHuwNx1yuHWg==
X-CSE-MsgGUID: 82DK6l6jRRCZW8eOORqVZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="28720967"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="28720967"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 11:13:28 -0700
X-CSE-ConnectionGUID: 4HKAueYpRQWO2jH+fbZoyA==
X-CSE-MsgGUID: 17JzO2XZRO64KoxjLHYvfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="48390913"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 11 Jul 2024 11:13:28 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 6/7] ice: Remove unused members from switch API
Date: Thu, 11 Jul 2024 11:13:09 -0700
Message-ID: <20240711181312.2019606-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240711181312.2019606-1-anthony.l.nguyen@intel.com>
References: <20240711181312.2019606-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcin Szycik <marcin.szycik@linux.intel.com>

Remove several members of struct ice_sw_recipe and struct
ice_prot_lkup_ext. Remove struct ice_recp_grp_entry and struct
ice_pref_recipe_group, since they are now unused as well.

All of the deleted members were only written to and never read, so it's
pointless to keep them.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c   |  7 ---
 .../ethernet/intel/ice/ice_protocol_type.h    | 17 -------
 drivers/net/ethernet/intel/ice/ice_switch.c   | 51 ++++---------------
 drivers/net/ethernet/intel/ice/ice_switch.h   | 16 ------
 4 files changed, 10 insertions(+), 81 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 17f6626fec7e..e77261704ee4 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -961,14 +961,7 @@ static void ice_cleanup_fltr_mgmt_struct(struct ice_hw *hw)
 	}
 	recps = sw->recp_list;
 	for (i = 0; i < ICE_MAX_NUM_RECIPES; i++) {
-		struct ice_recp_grp_entry *rg_entry, *tmprg_entry;
-
 		recps[i].root_rid = i;
-		list_for_each_entry_safe(rg_entry, tmprg_entry,
-					 &recps[i].rg_list, l_entry) {
-			list_del(&rg_entry->l_entry);
-			devm_kfree(ice_hw_to_dev(hw), rg_entry);
-		}
 
 		if (recps[i].adv_rule) {
 			struct ice_adv_fltr_mgmt_list_entry *tmp_entry;
diff --git a/drivers/net/ethernet/intel/ice/ice_protocol_type.h b/drivers/net/ethernet/intel/ice/ice_protocol_type.h
index 47e405bf1382..7c09ea0f03ba 100644
--- a/drivers/net/ethernet/intel/ice/ice_protocol_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_protocol_type.h
@@ -455,7 +455,6 @@ struct ice_prot_ext_tbl_entry {
 
 /* Extractions to be looked up for a given recipe */
 struct ice_prot_lkup_ext {
-	u16 prot_type;
 	u8 n_val_words;
 	/* create a buffer to hold max words per recipe */
 	u16 field_mask[ICE_MAX_CHAIN_WORDS];
@@ -463,20 +462,4 @@ struct ice_prot_lkup_ext {
 	struct ice_fv_word fv_words[ICE_MAX_CHAIN_WORDS];
 };
 
-struct ice_pref_recipe_group {
-	u8 n_val_pairs;		/* Number of valid pairs */
-	struct ice_fv_word pairs[ICE_NUM_WORDS_RECIPE];
-	u16 mask[ICE_NUM_WORDS_RECIPE];
-};
-
-struct ice_recp_grp_entry {
-	struct list_head l_entry;
-
-#define ICE_INVAL_CHAIN_IND 0xFF
-	u16 rid;
-	u8 chain_idx;
-	u16 fv_idx[ICE_NUM_WORDS_RECIPE];
-	u16 fv_mask[ICE_NUM_WORDS_RECIPE];
-	struct ice_pref_recipe_group r_group;
-};
 #endif /* _ICE_PROTOCOL_TYPE_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 5a092dcea172..27828cdfe085 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -1471,7 +1471,6 @@ int ice_init_def_sw_recp(struct ice_hw *hw)
 		recps[i].root_rid = i;
 		INIT_LIST_HEAD(&recps[i].filt_rules);
 		INIT_LIST_HEAD(&recps[i].filt_replay_rules);
-		INIT_LIST_HEAD(&recps[i].rg_list);
 		mutex_init(&recps[i].filt_rule_lock);
 	}
 
@@ -2339,18 +2338,10 @@ ice_get_recp_frm_fw(struct ice_hw *hw, struct ice_sw_recipe *recps, u8 rid,
 
 	for (sub_recps = 0; sub_recps < num_recps; sub_recps++) {
 		struct ice_aqc_recipe_data_elem root_bufs = tmp[sub_recps];
-		struct ice_recp_grp_entry *rg_entry;
 		u8 i, prof, idx, prot = 0;
 		bool is_root;
 		u16 off = 0;
 
-		rg_entry = devm_kzalloc(ice_hw_to_dev(hw), sizeof(*rg_entry),
-					GFP_KERNEL);
-		if (!rg_entry) {
-			status = -ENOMEM;
-			goto err_unroll;
-		}
-
 		idx = root_bufs.recipe_indx;
 		is_root = root_bufs.content.rid & ICE_AQ_RECIPE_ID_IS_ROOT;
 
@@ -2364,10 +2355,7 @@ ice_get_recp_frm_fw(struct ice_hw *hw, struct ice_sw_recipe *recps, u8 rid,
 				      ICE_MAX_NUM_PROFILES);
 		for (i = 0; i < ICE_NUM_WORDS_RECIPE; i++) {
 			u8 lkup_indx = root_bufs.content.lkup_indx[i];
-
-			rg_entry->fv_idx[i] = lkup_indx;
-			rg_entry->fv_mask[i] =
-				le16_to_cpu(root_bufs.content.mask[i]);
+			u16 lkup_mask = le16_to_cpu(root_bufs.content.mask[i]);
 
 			/* If the recipe is a chained recipe then all its
 			 * child recipe's result will have a result index.
@@ -2378,26 +2366,21 @@ ice_get_recp_frm_fw(struct ice_hw *hw, struct ice_sw_recipe *recps, u8 rid,
 			 * has ICE_AQ_RECIPE_LKUP_IGNORE or 0 since it isn't a
 			 * valid offset value.
 			 */
-			if (test_bit(rg_entry->fv_idx[i], hw->switch_info->prof_res_bm[prof]) ||
-			    rg_entry->fv_idx[i] & ICE_AQ_RECIPE_LKUP_IGNORE ||
-			    rg_entry->fv_idx[i] == 0)
+			if (!lkup_indx ||
+			    (lkup_indx & ICE_AQ_RECIPE_LKUP_IGNORE) ||
+			    test_bit(lkup_indx,
+				     hw->switch_info->prof_res_bm[prof]))
 				continue;
 
-			ice_find_prot_off(hw, ICE_BLK_SW, prof,
-					  rg_entry->fv_idx[i], &prot, &off);
+			ice_find_prot_off(hw, ICE_BLK_SW, prof, lkup_indx,
+					  &prot, &off);
 			lkup_exts->fv_words[fv_word_idx].prot_id = prot;
 			lkup_exts->fv_words[fv_word_idx].off = off;
-			lkup_exts->field_mask[fv_word_idx] =
-				rg_entry->fv_mask[i];
+			lkup_exts->field_mask[fv_word_idx] = lkup_mask;
 			fv_word_idx++;
 		}
-		/* populate rg_list with the data from the child entry of this
-		 * recipe
-		 */
-		list_add(&rg_entry->l_entry, &recps[rid].rg_list);
 
 		/* Propagate some data to the recipe database */
-		recps[idx].is_root = !!is_root;
 		recps[idx].priority = root_bufs.content.act_ctrl_fwd_priority;
 		recps[idx].need_pass_l2 = root_bufs.content.act_ctrl &
 					  ICE_AQ_RECIPE_ACT_NEED_PASS_L2;
@@ -2405,11 +2388,8 @@ ice_get_recp_frm_fw(struct ice_hw *hw, struct ice_sw_recipe *recps, u8 rid,
 					   ICE_AQ_RECIPE_ACT_ALLOW_PASS_L2;
 		bitmap_zero(recps[idx].res_idxs, ICE_MAX_FV_WORDS);
 		if (root_bufs.content.result_indx & ICE_AQ_RECIPE_RESULT_EN) {
-			recps[idx].chain_idx = root_bufs.content.result_indx &
-				~ICE_AQ_RECIPE_RESULT_EN;
-			set_bit(recps[idx].chain_idx, recps[idx].res_idxs);
-		} else {
-			recps[idx].chain_idx = ICE_INVAL_CHAIN_IND;
+			set_bit(root_bufs.content.result_indx &
+				~ICE_AQ_RECIPE_RESULT_EN, recps[idx].res_idxs);
 		}
 
 		if (!is_root) {
@@ -2429,8 +2409,6 @@ ice_get_recp_frm_fw(struct ice_hw *hw, struct ice_sw_recipe *recps, u8 rid,
 
 	/* Complete initialization of the root recipe entry */
 	lkup_exts->n_val_words = fv_word_idx;
-	recps[rid].big_recp = (num_recps > 1);
-	recps[rid].n_grp_count = (u8)num_recps;
 
 	/* Copy result indexes */
 	bitmap_copy(recps[rid].res_idxs, result_bm, ICE_MAX_FV_WORDS);
@@ -5157,7 +5135,6 @@ ice_add_sw_recipe(struct ice_hw *hw, struct ice_sw_recipe *rm,
 		return status;
 
 	recipe = &hw->switch_info->recp_list[rid];
-	recipe->is_root = true;
 	root = &buf[recp_cnt - 1];
 	fill_recipe_template(root, rid, rm);
 
@@ -5317,9 +5294,7 @@ ice_add_adv_recipe(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 	DECLARE_BITMAP(fv_bitmap, ICE_MAX_NUM_PROFILES);
 	DECLARE_BITMAP(profiles, ICE_MAX_NUM_PROFILES);
 	struct ice_prot_lkup_ext *lkup_exts;
-	struct ice_recp_grp_entry *r_entry;
 	struct ice_sw_fv_list_entry *fvit;
-	struct ice_recp_grp_entry *r_tmp;
 	struct ice_sw_fv_list_entry *tmp;
 	struct ice_sw_recipe *rm;
 	int status = 0;
@@ -5361,7 +5336,6 @@ ice_add_adv_recipe(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 	 * headers being programmed.
 	 */
 	INIT_LIST_HEAD(&rm->fv_list);
-	INIT_LIST_HEAD(&rm->rg_list);
 
 	/* Get bitmap of field vectors (profiles) that are compatible with the
 	 * rule request; only these will be searched in the subsequent call to
@@ -5465,11 +5439,6 @@ ice_add_adv_recipe(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 	}
 
 err_unroll:
-	list_for_each_entry_safe(r_entry, r_tmp, &rm->rg_list, l_entry) {
-		list_del(&r_entry->l_entry);
-		devm_kfree(ice_hw_to_dev(hw), r_entry);
-	}
-
 	list_for_each_entry_safe(fvit, tmp, &rm->fv_list, list_entry) {
 		list_del(&fvit->list_entry);
 		devm_kfree(ice_hw_to_dev(hw), fvit);
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.h b/drivers/net/ethernet/intel/ice/ice_switch.h
index 4bf170b505ae..671d7a5f359f 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.h
+++ b/drivers/net/ethernet/intel/ice/ice_switch.h
@@ -216,7 +216,6 @@ struct ice_sw_recipe {
 	/* For a chained recipe the root recipe is what should be used for
 	 * programming rules
 	 */
-	u8 is_root;
 	u8 root_rid;
 	u8 recp_created;
 
@@ -230,19 +229,6 @@ struct ice_sw_recipe {
 	u8 fv_idx[ICE_MAX_CHAIN_WORDS];
 	u16 fv_mask[ICE_MAX_CHAIN_WORDS];
 
-	/* if this recipe is a collection of other recipe */
-	u8 big_recp;
-
-	/* if this recipe is part of another bigger recipe then chain index
-	 * corresponding to this recipe
-	 */
-	u8 chain_idx;
-
-	/* if this recipe is a collection of other recipe then count of other
-	 * recipes and recipe IDs of those recipes
-	 */
-	u8 n_grp_count;
-
 	/* Bit map specifying the IDs associated with this group of recipe */
 	DECLARE_BITMAP(r_bitmap, ICE_MAX_NUM_RECIPES);
 
@@ -274,8 +260,6 @@ struct ice_sw_recipe {
 	u8 need_pass_l2:1;
 	u8 allow_pass_l2:1;
 
-	struct list_head rg_list;
-
 	/* This struct saves the fv_words for a given lookup */
 	struct ice_prot_lkup_ext lkup_exts;
 };
-- 
2.41.0


