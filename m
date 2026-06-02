Return-Path: <netdev+bounces-293930-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCWmBwQhHmr3hQkAu9opvQ
	(envelope-from <netdev+bounces-293930-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 02:17:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3AD62682B
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 02:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EF08304CA5D
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 00:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0131E285068;
	Tue,  2 Jun 2026 00:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hKY6/KGb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB721FE471
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 00:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780359335; cv=none; b=QhREEsbMG5FPJ369+4jGnGvs2j4PMrH85FYjPGdC/gPZ5ceE7WOlNTRqvV6YqjKoqDz3RQzry/gPR26bZjLJ4CylSvrzRpJG10WZKcsAEwg27VjZbT4wt3hgyIPemVGAzckB3ch9IDyo+yFWl0snzTH6R93FzM2MQLwbqFq5RxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780359335; c=relaxed/simple;
	bh=GZP7wObqvcHcDnE52zv1oLXYc2u0wYsJZ/Q1Qvdde2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JJ1KZ68aNRU9pes5M+QJPR7xPo9RzRqPOqxJLmaI3ThluWGOTU9cG2zuESpSHEyp4WkjK3RyPeDH8ASy+qbDRaU6jfxXYC3T0FbLwn5R7D42o0j6d2BGzDs5Eh1FjqnwpSXXMPSiGggFoqEGxngHJLEFRKECg5+mtb/nFoiSizA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hKY6/KGb; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780359334; x=1811895334;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=GZP7wObqvcHcDnE52zv1oLXYc2u0wYsJZ/Q1Qvdde2g=;
  b=hKY6/KGbVCBwo9WgKKeq9q6gJskt4bUmGA5Z1yaueQz9XY7c38q0Fxfq
   bR4TpLweQsqr5sIa8QRDP3dL8vsTNipI0aDHWnvHSR2T6a+iMiVMC3g0l
   WSzR5XgnwnzjBLoR51shDsA2tCaT5gC4TDikQ6WiNM/7r3BIrkEUO4V1w
   TekuECTZpU8PqxkEFO3QG0Oakt477F7ONuhm/Vw02Ecs/YE83aFv0QvrE
   YwKFdhXunzsQA+c/LBaZD7lsnIul79t+tu6NeF67AlZhInQ8wwU1o+xbV
   Ve/H4MmfRR8c8Mh0h+YOrRa6JBpzMLUmJMAaPJi8dq/WjmCmztOlPNGWS
   Q==;
X-CSE-ConnectionGUID: 50Re1m72Qg+hYtILIWtAtg==
X-CSE-MsgGUID: 59qa52YRRba3uiY4cfkeJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="84755431"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="84755431"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 17:15:31 -0700
X-CSE-ConnectionGUID: 47O+y/BySUuW071iFwTveQ==
X-CSE-MsgGUID: ibmO3pw4S9KI8Y9je1POVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="267598732"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 17:15:31 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 01 Jun 2026 17:14:23 -0700
Subject: [PATCH iwl-next 6/6] ice: refactor ice_sched_cfg_agg to take
 agg_info pointer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-jk-cleanup-vsi-aggregator-nodes-v1-6-36d6ecbe5ede@intel.com>
References: <20260601-jk-cleanup-vsi-aggregator-nodes-v1-0-36d6ecbe5ede@intel.com>
In-Reply-To: <20260601-jk-cleanup-vsi-aggregator-nodes-v1-0-36d6ecbe5ede@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 netdev@vger.kernel.org, Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Mailer: b4 0.16-dev-3fed5
X-Developer-Signature: v=1; a=openpgp-sha256; l=5035;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=GZP7wObqvcHcDnE52zv1oLXYc2u0wYsJZ/Q1Qvdde2g=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhiw5hYX6dr5L562eEnHL9swlxsWGjgsPJXg63Yj49P/fB
 a7/7A/0O0pZGMS4GGTFFFkUHEJWXjeeEKb1xlkOZg4rE8gQBi5OAZiIui4jw54ZUxmT1Zfn/FiW
 4nyOparjN2/ghH6jPctDEiXqQ2ar5DIyPLk+86NtTVKO3lz+ysJl5+KXJgevb1sRXhLxK8E8dmY
 6OwA=
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
	TAGGED_FROM(0.00)[bounces-293930-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 8E3AD62682B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ice_sched_cfg_agg() function is called with an aggregator ID and type.
It performs a lookup of the aggregator info structure by ID. If the lookup
fails, it calls ice_alloc_agg_info to allocate a new aggregator structure
for that ID.

This behavior used to make sense when ice_cfg_agg() was exported and
intended to create a new aggregator node for a specific ID. This is no
longer true, and all three callers of ice_sched_cfg_agg() already have a
valid agg_info structure.

Refactor the function to take the agg_info pointer directly, dropping the
unnecessary lookup and allocation fallback. This simplifies the function,
and keeps its scope targeted at traffic class configuration.

This removes essentially dead code, and prevents the need for adding
additional error cleanup for failures that are impossible.

Suggested-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sched.c | 49 ++++++++++--------------------
 1 file changed, 16 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index c45e9076518d..cb5f6120ad0c 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -2744,41 +2744,28 @@ ice_alloc_agg_info(struct ice_hw *hw, u32 min_id, u32 max_id,
 /**
  * ice_sched_cfg_agg - configure aggregator node
  * @pi: port information structure
- * @agg_id: aggregator ID
- * @agg_type: aggregator type queue, VSI, or aggregator group
+ * @agg_info: pointer to aggregator node to configure
  * @tc_bitmap: bits TC bitmap
  *
- * It registers a unique aggregator node into scheduler services. It
- * allows a user to register with a unique ID to track it's resources.
- * The aggregator type determines if this is a queue group, VSI group
- * or aggregator group. It then creates the aggregator node(s) for requested
- * TC(s) or removes an existing aggregator node including its configuration
- * if indicated via tc_bitmap. Call ice_rm_agg_cfg to release aggregator
- * resources and remove aggregator ID.
- * This function needs to be called with scheduler lock held.
+ * Configure an aggregator node's traffic classes according to the provided
+ * tc_bitmap.
+ *
+ * Context: Must be called with scheduler lock held.
  */
-static int
-ice_sched_cfg_agg(struct ice_port_info *pi, u32 agg_id,
-		  enum ice_agg_type agg_type, unsigned long *tc_bitmap)
+static int ice_sched_cfg_agg(struct ice_port_info *pi,
+			     struct ice_sched_agg_info *agg_info,
+			     unsigned long *tc_bitmap)
 {
-	struct ice_sched_agg_info *agg_info;
-	struct ice_hw *hw = pi->hw;
-	int status = 0;
+	int status;
 	u8 tc;
 
-	agg_info = xa_load(&hw->agg_list, agg_id);
-	if (!agg_info)
-		agg_info = ice_alloc_agg_info(hw, agg_id, agg_id, agg_type);
-	if (IS_ERR(agg_info))
-		return PTR_ERR(agg_info);
-
 	/* Create aggregator node(s) for requested TC(s) */
 	ice_for_each_traffic_class(tc) {
 		if (!ice_is_tc_ena(*tc_bitmap, tc)) {
 			/* Delete aggregator cfg TC if it exists previously */
 			status = ice_rm_agg_cfg_tc(pi, agg_info, tc, false);
 			if (status)
-				break;
+				return status;
 			continue;
 		}
 
@@ -2787,15 +2774,15 @@ ice_sched_cfg_agg(struct ice_port_info *pi, u32 agg_id,
 			continue;
 
 		/* Create new aggregator node for TC */
-		status = ice_sched_add_agg_cfg(pi, agg_id, tc);
+		status = ice_sched_add_agg_cfg(pi, agg_info->agg_id, tc);
 		if (status)
-			break;
+			return status;
 
 		/* Save aggregator node's TC information */
 		set_bit(tc, agg_info->tc_bitmap);
 	}
 
-	return status;
+	return 0;
 }
 
 /**
@@ -3121,8 +3108,7 @@ int ice_cfg_vsi_agg(struct ice_port_info *pi, u16 vsi_handle,
 	}
 
 	/* Configure the aggregator node */
-	status = ice_sched_cfg_agg(pi, agg_info->agg_id, ICE_AGG_TYPE_AGG,
-				   &bitmap);
+	status = ice_sched_cfg_agg(pi, agg_info, &bitmap);
 	if (status)
 		goto out_unlock;
 
@@ -4402,9 +4388,7 @@ void ice_sched_replay_agg(struct ice_hw *hw)
 						    agg_info->replay_tc_bitmap,
 						    replay_bitmap);
 			status = ice_sched_cfg_agg(hw->port_info,
-						   agg_info->agg_id,
-						   ICE_AGG_TYPE_AGG,
-						   replay_bitmap);
+						   agg_info, replay_bitmap);
 			if (status) {
 				dev_info(ice_hw_to_dev(hw),
 					 "Replay agg id[%d] failed\n",
@@ -4471,8 +4455,7 @@ static int ice_sched_replay_vsi_agg(struct ice_hw *hw, u16 vsi_handle)
 	ice_sched_get_ena_tc_bitmap(pi, agg_info->replay_tc_bitmap,
 				    replay_bitmap);
 	/* Replay aggregator node associated to vsi_handle */
-	status = ice_sched_cfg_agg(hw->port_info, agg_info->agg_id,
-				   ICE_AGG_TYPE_AGG, replay_bitmap);
+	status = ice_sched_cfg_agg(hw->port_info, agg_info, replay_bitmap);
 	if (status)
 		return status;
 

-- 
2.54.0.1064.gd145956f57df


