Return-Path: <netdev+bounces-130113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F32988522
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 14:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB03283B56
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 12:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DF218C34D;
	Fri, 27 Sep 2024 12:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SepOfOv0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4F618C33F
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727440869; cv=none; b=CJYzQBUouQrpqA8Xzox/IcWB4hFzPMzDT0Qnu6XnhVEyeK7M4RHZw4GgB0TTSN44iJcm12c9cIfEa3LY69xA2/9ifLelY7shC3FGgnkopnZs1woT9zdnej0bECAdHDNkQWF53I1IBNI+tOU+Glf6eqfw9JZ62NelfxOKbNa42N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727440869; c=relaxed/simple;
	bh=r1Lr7tvYMwtc8w3SfFcWa0W0NlqvWIvdww5MJWGf+50=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rAFBbTL3SVZ9Ct/WQTxiS/74qfoz0cs1SWTQUTxgMAC2w6p9rQkyP75SMtYo0litp3nYkFAUE+GiCHp7EguxjHuRIYt1dqiPys5fPT1KnW8keSOriwrc04suYEc5XQB6qQNSKoQsitycN+qhcyi7U+ympxVYA2jBKGZJRvnsvkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SepOfOv0; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727440868; x=1758976868;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r1Lr7tvYMwtc8w3SfFcWa0W0NlqvWIvdww5MJWGf+50=;
  b=SepOfOv0cyPiqNI2CRNFwICySLZm250rFx4gz0uTeMRJKHONaRSvSRR4
   IKIRRVcW8cU+6C6lyrWmwSDsObP2Lfwyow9AdiRLPa9n6DfUG2fsBBPWw
   FsrCUbcgd/b3YsPhLQEx7t5AvDZY+s2+tFLfNtfwBxYXPxijDKfSB5PE9
   p9N6VF7FMcqmCJSx7lETXBUhYmtJJf29beL1fV8xUA0lkbgM/9wQ9jy2L
   Le07fGN7wNRprjAawtCZ4SnMF6qixiMuRgIx6kKxxrOpxxLSUZDS2vfWe
   hAzOUqnvymahPvL8BnrcX+WM98FxonrHFdNGHBgDnTWc2ofW+g+ACs1Hn
   Q==;
X-CSE-ConnectionGUID: fsv6rPxSTVCwSckLdCd8mw==
X-CSE-MsgGUID: slYVITCVQQSLTprpWasLLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26385761"
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="26385761"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 05:40:45 -0700
X-CSE-ConnectionGUID: 8eMsemkkSNaHZM7mKKn3hQ==
X-CSE-MsgGUID: yidCo77+QXqMI9eb6wcyJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="76902945"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 27 Sep 2024 05:40:43 -0700
Received: from rozewie.igk.intel.com (rozewie.igk.intel.com [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 3E9EF28195;
	Fri, 27 Sep 2024 13:40:42 +0100 (IST)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	horms@kernel.org,
	anthony.l.nguyen@intel.com,
	marcin.szycik@linux.intel.com,
	michal.swiatkowski@linux.intel.com
Subject: [PATCH iwl-net v2] ice: Flush FDB entries before reset
Date: Fri, 27 Sep 2024 14:38:01 +0200
Message-Id: <20240927123801.14853-1-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Triggering the reset while in switchdev mode causes
errors[1]. Rules are already removed by this time
because switch content is flushed in case of the reset.
This means that rules were deleted from HW but SW
still thinks they exist so when we get
SWITCHDEV_FDB_DEL_TO_DEVICE notification we try to
delete not existing rule.

We can avoid these errors by clearing the rules
early in the reset flow before they are removed from HW.
Switchdev API will get notified that the rule was removed
so we won't get SWITCHDEV_FDB_DEL_TO_DEVICE notification.
Remove unnecessary ice_clear_sw_switch_recipes.

[1]
ice 0000:01:00.0: Failed to delete FDB forward rule, err: -2
ice 0000:01:00.0: Failed to delete FDB guard rule, err: -2

Fixes: 7c945a1a8e5f ("ice: Switchdev FDB events support")
Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
v2: extend commit msg, add NULL pointer check
---
 .../net/ethernet/intel/ice/ice_eswitch_br.c   |  5 +++-
 .../net/ethernet/intel/ice/ice_eswitch_br.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_main.c     | 24 +++----------------
 3 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
index f5aceb32bf4d..cccb7ddf61c9 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
@@ -582,10 +582,13 @@ ice_eswitch_br_switchdev_event(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
-static void ice_eswitch_br_fdb_flush(struct ice_esw_br *bridge)
+void ice_eswitch_br_fdb_flush(struct ice_esw_br *bridge)
 {
 	struct ice_esw_br_fdb_entry *entry, *tmp;
 
+	if (!bridge)
+		return;
+
 	list_for_each_entry_safe(entry, tmp, &bridge->fdb_list, list)
 		ice_eswitch_br_fdb_entry_notify_and_cleanup(bridge, entry);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.h b/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
index c15c7344d7f8..66a2c804338f 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
@@ -117,5 +117,6 @@ void
 ice_eswitch_br_offloads_deinit(struct ice_pf *pf);
 int
 ice_eswitch_br_offloads_init(struct ice_pf *pf);
+void ice_eswitch_br_fdb_flush(struct ice_esw_br *bridge);
 
 #endif /* _ICE_ESWITCH_BR_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c7db88b517da..dcd4c8204753 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -519,25 +519,6 @@ static void ice_pf_dis_all_vsi(struct ice_pf *pf, bool locked)
 		pf->vf_agg_node[node].num_vsis = 0;
 }
 
-/**
- * ice_clear_sw_switch_recipes - clear switch recipes
- * @pf: board private structure
- *
- * Mark switch recipes as not created in sw structures. There are cases where
- * rules (especially advanced rules) need to be restored, either re-read from
- * hardware or added again. For example after the reset. 'recp_created' flag
- * prevents from doing that and need to be cleared upfront.
- */
-static void ice_clear_sw_switch_recipes(struct ice_pf *pf)
-{
-	struct ice_sw_recipe *recp;
-	u8 i;
-
-	recp = pf->hw.switch_info->recp_list;
-	for (i = 0; i < ICE_MAX_NUM_RECIPES; i++)
-		recp[i].recp_created = false;
-}
-
 /**
  * ice_prepare_for_reset - prep for reset
  * @pf: board private structure
@@ -574,8 +555,9 @@ ice_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	mutex_unlock(&pf->vfs.table_lock);
 
 	if (ice_is_eswitch_mode_switchdev(pf)) {
-		if (reset_type != ICE_RESET_PFR)
-			ice_clear_sw_switch_recipes(pf);
+		rtnl_lock();
+		ice_eswitch_br_fdb_flush(pf->eswitch.br_offloads->bridge);
+		rtnl_unlock();
 	}
 
 	/* release ADQ specific HW and SW resources */
-- 
2.39.3


