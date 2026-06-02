Return-Path: <netdev+bounces-293925-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFp3JawgHmrmhQkAu9opvQ
	(envelope-from <netdev+bounces-293925-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 02:15:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 381506267E8
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 02:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87F4530262D7
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 00:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DD929D260;
	Tue,  2 Jun 2026 00:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g3OJJuf3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651E218DB2A
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 00:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780359332; cv=none; b=E9cbyLE7SiYIq6avU4Dq1OwTwjnnfF4cIL5DdgsMVRRoAlq82PhmMJByniMcjPneEyghsOkgsXMmMtoTQQic5kAbo1nNI4C4lE+JORGYyA8zMvGPuP9fCB8mae6PNLsE9EbA6Q9Ist9pMi5Ku8ojI8AFUTlqG/Bde5aB6I0LQBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780359332; c=relaxed/simple;
	bh=ksqg8j/fyMk5YEmjp5KGUMgaL2Fi4R1uhiVDs5nvGyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XPK4G+2ToV48V8Ay5KwDhgJS1KMaXGNGLdsPPx6npu/4XysPShnKcoTR78dEdDSCY9/fjUkTs27wy+NdyJpKdXifMmxdl3gjyFD++0KcZsIZDZfzc538OyCeKOuTFphgdCieNvBYhEK+du6k9KJc9u1sYCNZkflenffB0oU9Xbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g3OJJuf3; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780359331; x=1811895331;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ksqg8j/fyMk5YEmjp5KGUMgaL2Fi4R1uhiVDs5nvGyY=;
  b=g3OJJuf3qAdFqC3ueh170lXncwWqPSW1VMxVeKPpX5taGwRu3SzDHxQL
   i2sHZdbbqWkPcuVEht1IFh5D75FNf7e8sDdRenQaTrraT3Egpk0pXEi49
   yl7AWuUVLpiFXlTaTymmPW3xYFYbG/8gwP/VA2Es0TBP/WYJ7bevP1z1f
   qacKPrpkPgqQKOhnHB4fqmJz/eHnEUdlp+I0weDxYTLZm8QjZtX0PKEvR
   r2Xad1xO7Y8PO5yUlVBvqVz8EJB/Dx1+UUj6RHbA/bB5942SaUGryzZdb
   9sGyS+Xhf5QRZw04J5iLjKMGexVjxhm0a1qq/XRJFdnH5Tgy4uCH9+jzW
   Q==;
X-CSE-ConnectionGUID: 0n56QN4jS++0ZsV6QziYjw==
X-CSE-MsgGUID: 7b/3zbtkT16oV+zBZC0r0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="84755419"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="84755419"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 17:15:30 -0700
X-CSE-ConnectionGUID: n89E4oksTuSef5ElVwZ/UA==
X-CSE-MsgGUID: 1lYpfoQ5Q3OA5dn1i+Se5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="267598716"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 17:15:30 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 01 Jun 2026 17:14:18 -0700
Subject: [PATCH iwl-next 1/6] ice: convert hw->agg_list from linked list to
 xarray
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-jk-cleanup-vsi-aggregator-nodes-v1-1-36d6ecbe5ede@intel.com>
References: <20260601-jk-cleanup-vsi-aggregator-nodes-v1-0-36d6ecbe5ede@intel.com>
In-Reply-To: <20260601-jk-cleanup-vsi-aggregator-nodes-v1-0-36d6ecbe5ede@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 netdev@vger.kernel.org, Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Mailer: b4 0.16-dev-3fed5
X-Developer-Signature: v=1; a=openpgp-sha256; l=9228;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=ksqg8j/fyMk5YEmjp5KGUMgaL2Fi4R1uhiVDs5nvGyY=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhiw5hQUu9a8vMst9Kc7fZdq/0WrXsVPJGtt2GB7ufGHBk
 752nvuXjlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACZyqY7hr1xbyn7FhXHVvMfc
 D0Wf63lUKHU2qbX0ZtiRado1F97oBzH8r/TlE9+XIXRnX1e8SlK0iNX08PlJhSsE37vv+ujL1/i
 XGwA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293925-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 381506267E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The scheduler code saves information about the aggregator nodes in a linked
list in the hw->agg_list structure. This choice of data structure is not
ideal. Indeed, several places in the code iterate the list searching to see
if a given ID is present.

Convert the linked list into an xarray. Where possible, simplify aggregator
info lookup to use xa_load instead of iterating over all the entries.

Switching to xarray data structure better matches the existing usage
pattern. In addition, it prepares the code to allow removal of the
ice_agg_node wrapping structure used by ice_vsi, which will be completed in
following changes.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sched.h  |  1 -
 drivers/net/ethernet/intel/ice/ice_type.h   |  2 +-
 drivers/net/ethernet/intel/ice/ice_common.c |  4 +-
 drivers/net/ethernet/intel/ice/ice_sched.c  | 58 ++++++++++++-----------------
 4 files changed, 27 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.h b/drivers/net/ethernet/intel/ice/ice_sched.h
index 7b668083be07..f2a619fcab8b 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.h
+++ b/drivers/net/ethernet/intel/ice/ice_sched.h
@@ -67,7 +67,6 @@ struct ice_sched_agg_vsi_info {
 
 struct ice_sched_agg_info {
 	struct list_head agg_vsi_list;
-	struct list_head list_entry;
 	DECLARE_BITMAP(tc_bitmap, ICE_MAX_TRAFFIC_CLASS);
 	u32 agg_id;
 	enum ice_agg_type agg_type;
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index b39be74b1d55..ab297b66ee16 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -948,7 +948,7 @@ struct ice_hw {
 	u8 max_cgds;
 	u8 sw_entry_point_layer;
 	u16 max_children[ICE_AQC_TOPO_MAX_LEVEL_NUM];
-	struct list_head agg_list;	/* lists all aggregator */
+	struct xarray agg_list; /* array of aggregator nodes */
 
 	struct ice_vsi_ctx *vsi_ctx[ICE_MAX_VSI];
 	u8 evb_veb;		/* true for VEB, false for VEPA */
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 3c36f8a28a64..f6fa0a50e08f 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1052,6 +1052,7 @@ int ice_init_hw(struct ice_hw *hw)
 	hw->evb_veb = true;
 
 	xa_init_flags(&hw->port_info->sched_node_ids, XA_FLAGS_ALLOC);
+	xa_init_flags(&hw->agg_list, XA_FLAGS_ALLOC);
 
 	/* Query the allocated resources for Tx scheduler */
 	status = ice_sched_query_res_alloc(hw);
@@ -1091,7 +1092,6 @@ int ice_init_hw(struct ice_hw *hw)
 		status = -EIO;
 		goto err_unroll_sched;
 	}
-	INIT_LIST_HEAD(&hw->agg_list);
 	/* Initialize max burst size */
 	if (!hw->max_burst_size)
 		ice_cfg_rl_burst_size(hw, ICE_SCHED_DFLT_BURST_SIZE);
@@ -1147,6 +1147,7 @@ int ice_init_hw(struct ice_hw *hw)
 	ice_sched_cleanup_all(hw);
 err_unroll_xarray:
 	xa_destroy(&hw->port_info->sched_node_ids);
+	xa_destroy(&hw->agg_list);
 err_unroll_alloc:
 	devm_kfree(ice_hw_to_dev(hw), hw->port_info);
 err_unroll_cqinit:
@@ -1189,6 +1190,7 @@ void ice_deinit_hw(struct ice_hw *hw)
 	ice_clear_all_vsi_ctx(hw);
 
 	xa_destroy(&hw->port_info->sched_node_ids);
+	xa_destroy(&hw->agg_list);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index 8b005e4603eb..a74f840cba23 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -813,9 +813,9 @@ static void ice_sched_clear_rl_prof(struct ice_port_info *pi)
 void ice_sched_clear_agg(struct ice_hw *hw)
 {
 	struct ice_sched_agg_info *agg_info;
-	struct ice_sched_agg_info *atmp;
+	unsigned long index;
 
-	list_for_each_entry_safe(agg_info, atmp, &hw->agg_list, list_entry) {
+	xa_for_each(&hw->agg_list, index, agg_info) {
 		struct ice_sched_agg_vsi_info *agg_vsi_info;
 		struct ice_sched_agg_vsi_info *vtmp;
 
@@ -824,7 +824,7 @@ void ice_sched_clear_agg(struct ice_hw *hw)
 			list_del(&agg_vsi_info->list_entry);
 			devm_kfree(ice_hw_to_dev(hw), agg_vsi_info);
 		}
-		list_del(&agg_info->list_entry);
+		xa_erase(&hw->agg_list, index);
 		devm_kfree(ice_hw_to_dev(hw), agg_info);
 	}
 }
@@ -2060,10 +2060,9 @@ ice_sched_cfg_vsi(struct ice_port_info *pi, u16 vsi_handle, u8 tc, u16 maxqs,
 static void ice_sched_rm_agg_vsi_info(struct ice_port_info *pi, u16 vsi_handle)
 {
 	struct ice_sched_agg_info *agg_info;
-	struct ice_sched_agg_info *atmp;
+	unsigned long index;
 
-	list_for_each_entry_safe(agg_info, atmp, &pi->hw->agg_list,
-				 list_entry) {
+	xa_for_each(&pi->hw->agg_list, index, agg_info) {
 		struct ice_sched_agg_vsi_info *agg_vsi_info;
 		struct ice_sched_agg_vsi_info *vtmp;
 
@@ -2226,26 +2225,6 @@ int ice_rm_vsi_rdma_cfg(struct ice_port_info *pi, u16 vsi_handle)
 	return ice_sched_rm_vsi_cfg(pi, vsi_handle, ICE_SCHED_NODE_OWNER_RDMA);
 }
 
-/**
- * ice_get_agg_info - get the aggregator ID
- * @hw: pointer to the hardware structure
- * @agg_id: aggregator ID
- *
- * This function validates aggregator ID. The function returns info if
- * aggregator ID is present in list otherwise it returns null.
- */
-static struct ice_sched_agg_info *
-ice_get_agg_info(struct ice_hw *hw, u32 agg_id)
-{
-	struct ice_sched_agg_info *agg_info;
-
-	list_for_each_entry(agg_info, &hw->agg_list, list_entry)
-		if (agg_info->agg_id == agg_id)
-			return agg_info;
-
-	return NULL;
-}
-
 /**
  * ice_sched_get_free_vsi_parent - Find a free parent node in aggregator subtree
  * @hw: pointer to the HW struct
@@ -2619,7 +2598,7 @@ ice_save_agg_tc_bitmap(struct ice_port_info *pi, u32 agg_id,
 {
 	struct ice_sched_agg_info *agg_info;
 
-	agg_info = ice_get_agg_info(pi->hw, agg_id);
+	agg_info = xa_load(&pi->hw->agg_list, agg_id);
 	if (!agg_info)
 		return -EINVAL;
 	bitmap_copy(agg_info->replay_tc_bitmap, tc_bitmap,
@@ -2735,7 +2714,7 @@ ice_sched_cfg_agg(struct ice_port_info *pi, u32 agg_id,
 	int status = 0;
 	u8 tc;
 
-	agg_info = ice_get_agg_info(hw, agg_id);
+	agg_info = xa_load(&hw->agg_list, agg_id);
 	if (!agg_info) {
 		/* Create new entry for new aggregator ID */
 		agg_info = devm_kzalloc(ice_hw_to_dev(hw), sizeof(*agg_info),
@@ -2750,8 +2729,13 @@ ice_sched_cfg_agg(struct ice_port_info *pi, u32 agg_id,
 		/* Initialize the aggregator VSI list head */
 		INIT_LIST_HEAD(&agg_info->agg_vsi_list);
 
-		/* Add new entry in aggregator list */
-		list_add(&agg_info->list_entry, &hw->agg_list);
+		/* Add new entry in aggregator array */
+		status = xa_insert(&hw->agg_list, agg_id, agg_info,
+				   GFP_KERNEL);
+		if (status) {
+			devm_kfree(ice_hw_to_dev(hw), agg_info);
+			return status;
+		}
 	}
 	/* Create aggregator node(s) for requested TC(s) */
 	ice_for_each_traffic_class(tc) {
@@ -2836,8 +2820,9 @@ static struct ice_sched_agg_info *
 ice_get_vsi_agg_info(struct ice_hw *hw, u16 vsi_handle)
 {
 	struct ice_sched_agg_info *agg_info;
+	unsigned long index;
 
-	list_for_each_entry(agg_info, &hw->agg_list, list_entry) {
+	xa_for_each(&hw->agg_list, index, agg_info) {
 		struct ice_sched_agg_vsi_info *agg_vsi_info;
 
 		agg_vsi_info = ice_get_agg_vsi_info(agg_info, vsi_handle);
@@ -2864,7 +2849,7 @@ ice_save_agg_vsi_tc_bitmap(struct ice_port_info *pi, u32 agg_id, u16 vsi_handle,
 	struct ice_sched_agg_vsi_info *agg_vsi_info;
 	struct ice_sched_agg_info *agg_info;
 
-	agg_info = ice_get_agg_info(pi->hw, agg_id);
+	agg_info = xa_load(&pi->hw->agg_list, agg_id);
 	if (!agg_info)
 		return -EINVAL;
 	/* check if entry already exist */
@@ -2899,7 +2884,7 @@ ice_sched_assoc_vsi_to_agg(struct ice_port_info *pi, u32 agg_id,
 
 	if (!ice_is_vsi_valid(pi->hw, vsi_handle))
 		return -EINVAL;
-	agg_info = ice_get_agg_info(hw, agg_id);
+	agg_info = xa_load(&hw->agg_list, agg_id);
 	if (!agg_info)
 		return -EINVAL;
 	/* If the VSI is already part of another aggregator then update
@@ -4313,9 +4298,10 @@ void ice_sched_replay_agg(struct ice_hw *hw)
 {
 	struct ice_port_info *pi = hw->port_info;
 	struct ice_sched_agg_info *agg_info;
+	unsigned long index;
 
 	mutex_lock(&pi->sched_lock);
-	list_for_each_entry(agg_info, &hw->agg_list, list_entry)
+	xa_for_each(&hw->agg_list, index, agg_info) {
 		/* replay aggregator (re-create aggregator node) */
 		if (!bitmap_equal(agg_info->tc_bitmap, agg_info->replay_tc_bitmap,
 				  ICE_MAX_TRAFFIC_CLASS)) {
@@ -4338,6 +4324,7 @@ void ice_sched_replay_agg(struct ice_hw *hw)
 				continue;
 			}
 		}
+	}
 	mutex_unlock(&pi->sched_lock);
 }
 
@@ -4352,9 +4339,10 @@ void ice_sched_replay_agg_vsi_preinit(struct ice_hw *hw)
 {
 	struct ice_port_info *pi = hw->port_info;
 	struct ice_sched_agg_info *agg_info;
+	unsigned long index;
 
 	mutex_lock(&pi->sched_lock);
-	list_for_each_entry(agg_info, &hw->agg_list, list_entry) {
+	xa_for_each(&hw->agg_list, index, agg_info) {
 		struct ice_sched_agg_vsi_info *agg_vsi_info;
 
 		agg_info->tc_bitmap[0] = 0;

-- 
2.54.0.1064.gd145956f57df


