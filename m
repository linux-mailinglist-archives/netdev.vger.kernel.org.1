Return-Path: <netdev+bounces-251447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EC659D3C5DD
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E66585A92A0
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5479B410D31;
	Tue, 20 Jan 2026 10:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iNdSpgAi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3993410D07;
	Tue, 20 Jan 2026 10:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768905293; cv=none; b=hXIjOuASiqb08Zeyz2e5CAulO/9OTVW9/3lIO0L8bOB1nbBXxvmvBI60pHP3vZIgUlQ/HGzl58KzfPO2yH34GxfUSkMS8bhe2WfKf4hOFSZz3Ydy2h5b7gQEOWO/BINq7ZCWmOhk7ChNgOGfu9fNbsg5KxvqsEWFTq2KyaRhBrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768905293; c=relaxed/simple;
	bh=iC3XdbETtmivl7MiNG080jOCyV8qw/2J329iqKv9uzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nM2emJbyuABxov+wc7DmL0w78vXhsNwyDwsECgLCnnCEzjtr5Z8tOnBi6CVymDVf4g3u49qBSx0FzhdkDNOOLgE6gULvmj8ShBPb0Za0ar4bWAD9Lh8mUVuSXmITzmcwEkXbFVRYdP2+bWbiOIdLEVswkJI17w6IbQ9fSBAr8OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iNdSpgAi; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768905291; x=1800441291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iC3XdbETtmivl7MiNG080jOCyV8qw/2J329iqKv9uzM=;
  b=iNdSpgAi/sqn5rIcrW5PUkrN0VK6FUT4ymjyDxSVU3rJ8KsGK9JrURKr
   AOj+BMxuyVimwOcBCbd1RkKV/geDBS8VIauSN7Z+2nm/tUSpFyCuSG/of
   80aQkqfHvOkUfS10FMlPaNcCBlFC+DnUTXLTiqJxu7nNkWL4CNW0JXCjC
   JllZ6xhWbFUWdQev5n2e4vAgLT/o844dUbl4DDzOaCIrHUSaYmX21YxuJ
   BpdDi2ni95p9oYfgpnjH4p1V4m6zR/02CqyaLEGCcIMuCX34yMTEJoWxb
   dNlqz2rz6z9lXyOdXQHt0p3IskkzJ++LGEQq47CE7iZ4E7G7831A3ZsBU
   A==;
X-CSE-ConnectionGUID: soH+Eci3RLaWgBE4ArP2Vg==
X-CSE-MsgGUID: eXxREXPlQmq3puwiNU8lUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="70161748"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="70161748"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 02:34:50 -0800
X-CSE-ConnectionGUID: ipVBg8rASC6sTNAfBhD0LA==
X-CSE-MsgGUID: lNdC1XsPSC+zrigQGNbj/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="210935856"
Received: from hpe-dl385gen10.igk.intel.com ([10.91.240.117])
  by fmviesa004.fm.intel.com with ESMTP; 20 Jan 2026 02:34:49 -0800
From: Jakub Slepecki <jakub.slepecki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	jakub.slepecki@intel.com,
	aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v3 4/8] ice: allow overriding lan_en, lb_en in switch
Date: Tue, 20 Jan 2026 11:34:35 +0100
Message-ID: <20260120103440.892326-5-jakub.slepecki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120103440.892326-1-jakub.slepecki@intel.com>
References: <20260120103440.892326-1-jakub.slepecki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

Currently, lan_en and lb_en are determined based on switching mode,
destination MAC, and the lookup type, action type and flags of the rule
in question.  This gives little to no options for the user (such as
ice_fltr.c) to enforce rules to behave in a specific way.

Such functionality is needed to work with pairs of rules, for example,
when handling MAC forward to LAN together with MAC,VLAN forward to
loopback rules pair.  This case could not be easily deduced in a context
of a single filter without adding some guessing logic or a specialized
flag.

Add a slightly more generic flag to the lan_en and lb_en themselves
for the ice_fltr.c to request specific destination flags later on,
for example, to override both values:

    struct ice_fltr_info fi;
    fi.lb_en = ICE_FLTR_INFO_LB_LAN_FORCE_ENABLED;
    fi.lan_en = ICE_FLTR_INFO_LB_LAN_FORCE_DISABLED;

Signed-off-by: Jakub Slepecki <jakub.slepecki@intel.com>
---
I considered a resend or bumping the old thread, because we did not finish
the discussion last time with Aleksandr, but I feel like this version
addresses most if not all of the points that were made.  One exception is
that I did not split the fields, but that was only one of the solutions.
Nonetheless, this should be overall a good starting point for a
discussion.

Changes in v3:
  - LB_LAN masks and values no longer rely on boolean promotion.
  - ice_fill_sw_info() deals with u8 the entire time instead of building
    building lb_en and lan_en values at the end from booleans.

Changes in v2:
  - Use FIELD_GET et al. when handling fi.lb_en and fi.lan_en.
  - Rename /LB_LAN/s/_MASK/_M/ because one of uses would need to break
    line
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 25 +++++++++++++--------
 drivers/net/ethernet/intel/ice/ice_switch.h | 19 +++++++++++++---
 2 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 04e5d653efce..3caccd798220 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -2534,12 +2534,14 @@ int ice_get_initial_sw_cfg(struct ice_hw *hw)
  *
  * This helper function populates the lb_en and lan_en elements of the provided
  * ice_fltr_info struct using the switch's type and characteristics of the
- * switch rule being configured.
+ * switch rule being configured.  Elements are updated only if their FORCE bit
+ * is not set.
  */
 static void ice_fill_sw_info(struct ice_hw *hw, struct ice_fltr_info *fi)
 {
-	fi->lb_en = false;
-	fi->lan_en = false;
+	u8 lan_en = fi->lan_en;
+	u8 lb_en = fi->lb_en;
+
 	if ((fi->flag & ICE_FLTR_TX) &&
 	    (fi->fltr_act == ICE_FWD_TO_VSI ||
 	     fi->fltr_act == ICE_FWD_TO_VSI_LIST ||
@@ -2549,7 +2551,7 @@ static void ice_fill_sw_info(struct ice_hw *hw, struct ice_fltr_info *fi)
 		 * packets to the internal switch that will be dropped.
 		 */
 		if (fi->lkup_type != ICE_SW_LKUP_VLAN)
-			fi->lb_en = true;
+			FIELD_MODIFY(ICE_FLTR_INFO_LB_LAN_VALUE_M, &lb_en, 1);
 
 		/* Set lan_en to TRUE if
 		 * 1. The switch is a VEB AND
@@ -2578,14 +2580,19 @@ static void ice_fill_sw_info(struct ice_hw *hw, struct ice_fltr_info *fi)
 			     !is_unicast_ether_addr(fi->l_data.mac.mac_addr)) ||
 			    (fi->lkup_type == ICE_SW_LKUP_MAC_VLAN &&
 			     !is_unicast_ether_addr(fi->l_data.mac.mac_addr)))
-				fi->lan_en = true;
+				FIELD_MODIFY(ICE_FLTR_INFO_LB_LAN_VALUE_M,
+					     &lan_en, 1);
 		} else {
-			fi->lan_en = true;
+			FIELD_MODIFY(ICE_FLTR_INFO_LB_LAN_VALUE_M, &lan_en, 1);
 		}
 	}
 
 	if (fi->flag & ICE_FLTR_TX_ONLY)
-		fi->lan_en = false;
+		FIELD_MODIFY(ICE_FLTR_INFO_LB_LAN_VALUE_M, &lan_en, 0);
+	if (!FIELD_GET(ICE_FLTR_INFO_LB_LAN_FORCE_M, lb_en))
+		fi->lb_en = lb_en;
+	if (!FIELD_GET(ICE_FLTR_INFO_LB_LAN_FORCE_M, lan_en))
+		fi->lan_en = lan_en;
 }
 
 /**
@@ -2669,9 +2676,9 @@ ice_fill_sw_rule(struct ice_hw *hw, struct ice_fltr_info *f_info,
 		return;
 	}
 
-	if (f_info->lb_en)
+	if (FIELD_GET(ICE_FLTR_INFO_LB_LAN_VALUE_M, f_info->lb_en))
 		act |= ICE_SINGLE_ACT_LB_ENABLE;
-	if (f_info->lan_en)
+	if (FIELD_GET(ICE_FLTR_INFO_LB_LAN_VALUE_M, f_info->lan_en))
 		act |= ICE_SINGLE_ACT_LAN_ENABLE;
 
 	switch (f_info->lkup_type) {
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.h b/drivers/net/ethernet/intel/ice/ice_switch.h
index 671d7a5f359f..137eae878ab1 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.h
+++ b/drivers/net/ethernet/intel/ice/ice_switch.h
@@ -72,6 +72,14 @@ enum ice_src_id {
 	ICE_SRC_ID_LPORT,
 };
 
+#define ICE_FLTR_INFO_LB_LAN_VALUE_M BIT(0)
+#define ICE_FLTR_INFO_LB_LAN_FORCE_M BIT(1)
+#define ICE_FLTR_INFO_LB_LAN_FORCE_ENABLED			 \
+	(FIELD_PREP_CONST(ICE_FLTR_INFO_LB_LAN_VALUE_M, 1) |  \
+	 FIELD_PREP_CONST(ICE_FLTR_INFO_LB_LAN_FORCE_M, 1))
+#define ICE_FLTR_INFO_LB_LAN_FORCE_DISABLED			 \
+	(FIELD_PREP_CONST(ICE_FLTR_INFO_LB_LAN_FORCE_M, 1))
+
 struct ice_fltr_info {
 	/* Look up information: how to look up packet */
 	enum ice_sw_lkup_type lkup_type;
@@ -131,9 +139,14 @@ struct ice_fltr_info {
 	 */
 	u8 qgrp_size;
 
-	/* Rule creations populate these indicators basing on the switch type */
-	u8 lb_en;	/* Indicate if packet can be looped back */
-	u8 lan_en;	/* Indicate if packet can be forwarded to the uplink */
+	/* Following members have two bits: VALUE and FORCE.  Rule creation will
+	 * populate VALUE bit of these members based on switch type, but only if
+	 * their FORCE bit is not set.
+	 *
+	 * See ICE_FLTR_INFO_LB_LAN_VALUE_M and ICE_FLTR_INFO_LB_LAN_FORCE_M.
+	 */
+	u8 lb_en;	/* VALUE bit: packet can be looped back */
+	u8 lan_en;	/* VALUE bit: packet can be forwarded to the uplink */
 };
 
 struct ice_update_recipe_lkup_idx_params {
-- 
2.43.0


