Return-Path: <netdev+bounces-240480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D02C755CD
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 99E8F2B480
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 16:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CAE36E553;
	Thu, 20 Nov 2025 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JANfrB1N"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748C936CDFE;
	Thu, 20 Nov 2025 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656107; cv=none; b=e8JxLtggNdxoj9IcjXNridytKNpVi1ygGSettkVwLK8rvCq4nP8cnH1FrEX7XqFlju105d1HbJYQdXf2XKQETUVZn6F7MXEQYBZeLtb4muTNOuHJ3jkgcI2fUWz+ratDqeBCUAziFK+64mDdXA2Gkbfdelc0uIrxgk/TN9ZQqFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656107; c=relaxed/simple;
	bh=o05JNdB6D1vyiu/R+lX09CjA8bn5afRbx6R7I34pziA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogbGzm1vzwhMV8FZYQCqpEFEsK4KW+BA2k/0nsEfJ+ISvyFQYftZo7wmJh92gGxo5c95jThPD7+vdM2+rVvaL8gLTmGYPEcD7E+blxBSExObZKG9icY6WJ81vsiwzQR98CFjkbaHPNXk1D1Py9HicaCDz734SUWCCqEWpVfcZYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JANfrB1N; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763656105; x=1795192105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o05JNdB6D1vyiu/R+lX09CjA8bn5afRbx6R7I34pziA=;
  b=JANfrB1NNMPFrpc9psg6om9igVJDpLPZe0SUJF1/KYiLP93byWTRw45H
   MUYqQP2ZKEpJdCaCOl60IPazGiZHFSiavy5OSSupjlBTxrJxEYx60kHWI
   uKHtr926waUhjCVUCSRedHEYYuJqKB28SI15MIWX9FlE7JjNbQRWwFqgo
   raHjPQ4zR7HPX8mr+UCktIwICtdoZpMUiSx3e8TxcYRTjpkbM8aqryhO9
   MkbkgydF/epS5qSVOeD16oXTptFpXnl9If2aY3tnIWPN/zy7eqalt+3va
   xPlksZn8K7tx0LJwYc3lux6mqaXhX+tUuzDTf/htjxfTBtEDdEfmMUMw4
   Q==;
X-CSE-ConnectionGUID: sZ+zW2I7RIabCl5NQiPrxQ==
X-CSE-MsgGUID: vwW+PWDfSIinuD1dBCXtvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="69599299"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="69599299"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 08:28:24 -0800
X-CSE-ConnectionGUID: cFh5Fch8RdyJNL8o3Q64BQ==
X-CSE-MsgGUID: jPuNL+t7QCOBlBJxb7w92Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="191531292"
Received: from hpe-dl385gen10.igk.intel.com ([10.91.240.117])
  by orviesa008.jf.intel.com with ESMTP; 20 Nov 2025 08:28:23 -0800
From: Jakub Slepecki <jakub.slepecki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	jakub.slepecki@intel.com
Subject: [PATCH iwl-next 4/8] ice: allow overriding lan_en, lb_en in switch
Date: Thu, 20 Nov 2025 17:28:09 +0100
Message-ID: <20251120162813.37942-5-jakub.slepecki@intel.com>
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

Currently, lan_en and lb_en are determined based on switching mode,
destination MAC, and the lookup type, action type and flags of the rule
in question.  This gives little to no options for the user (such as
ice_fltr.c) to enforce rules to behave in a specific way.

Such functionality is needed to work with pairs of rules, for example,
when handling MAC forward to LAN together with MAC,VLAN forward to
loopback rules pair.  This case could not be easily deduced in a context
of a single filter without adding a specialized flag.

Instead of adding a specialized flag to mark special scenario rules,
we add a slightly more generic flag to the lan_en and lb_en themselves
for the ice_fltr.c to request specific destination flags later on, for
example, to override value:

    struct ice_fltr_info fi;
    fi.lb_en = ICE_FLTR_INFO_LB_LAN_FORCE_ENABLED;
    fi.lan_en = ICE_FLTR_INFO_LB_LAN_FORCE_DISABLED;

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Jakub Slepecki <jakub.slepecki@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 21 +++++++++++++--------
 drivers/net/ethernet/intel/ice/ice_switch.h |  7 +++++++
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 04e5d653efce..7b63588948fd 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -2538,8 +2538,9 @@ int ice_get_initial_sw_cfg(struct ice_hw *hw)
  */
 static void ice_fill_sw_info(struct ice_hw *hw, struct ice_fltr_info *fi)
 {
-	fi->lb_en = false;
-	fi->lan_en = false;
+	bool lan_en = false;
+	bool lb_en = false;
+
 	if ((fi->flag & ICE_FLTR_TX) &&
 	    (fi->fltr_act == ICE_FWD_TO_VSI ||
 	     fi->fltr_act == ICE_FWD_TO_VSI_LIST ||
@@ -2549,7 +2550,7 @@ static void ice_fill_sw_info(struct ice_hw *hw, struct ice_fltr_info *fi)
 		 * packets to the internal switch that will be dropped.
 		 */
 		if (fi->lkup_type != ICE_SW_LKUP_VLAN)
-			fi->lb_en = true;
+			lb_en = true;
 
 		/* Set lan_en to TRUE if
 		 * 1. The switch is a VEB AND
@@ -2578,14 +2579,18 @@ static void ice_fill_sw_info(struct ice_hw *hw, struct ice_fltr_info *fi)
 			     !is_unicast_ether_addr(fi->l_data.mac.mac_addr)) ||
 			    (fi->lkup_type == ICE_SW_LKUP_MAC_VLAN &&
 			     !is_unicast_ether_addr(fi->l_data.mac.mac_addr)))
-				fi->lan_en = true;
+				lan_en = true;
 		} else {
-			fi->lan_en = true;
+			lan_en = true;
 		}
 	}
 
 	if (fi->flag & ICE_FLTR_TX_ONLY)
-		fi->lan_en = false;
+		lan_en = false;
+	if (!(fi->lb_en & ICE_FLTR_INFO_LB_LAN_FORCE_MASK))
+		fi->lb_en = lb_en;
+	if (!(fi->lan_en & ICE_FLTR_INFO_LB_LAN_FORCE_MASK))
+		fi->lan_en = lan_en;
 }
 
 /**
@@ -2669,9 +2674,9 @@ ice_fill_sw_rule(struct ice_hw *hw, struct ice_fltr_info *f_info,
 		return;
 	}
 
-	if (f_info->lb_en)
+	if (f_info->lb_en & ICE_FLTR_INFO_LB_LAN_VALUE_MASK)
 		act |= ICE_SINGLE_ACT_LB_ENABLE;
-	if (f_info->lan_en)
+	if (f_info->lan_en & ICE_FLTR_INFO_LB_LAN_VALUE_MASK)
 		act |= ICE_SINGLE_ACT_LAN_ENABLE;
 
 	switch (f_info->lkup_type) {
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.h b/drivers/net/ethernet/intel/ice/ice_switch.h
index 671d7a5f359f..a7dc4bfec3a0 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.h
+++ b/drivers/net/ethernet/intel/ice/ice_switch.h
@@ -72,6 +72,13 @@ enum ice_src_id {
 	ICE_SRC_ID_LPORT,
 };
 
+#define ICE_FLTR_INFO_LB_LAN_VALUE_MASK BIT(0)
+#define ICE_FLTR_INFO_LB_LAN_FORCE_MASK BIT(1)
+#define ICE_FLTR_INFO_LB_LAN_FORCE_ENABLED	\
+	(ICE_FLTR_INFO_LB_LAN_VALUE_MASK |	\
+	 ICE_FLTR_INFO_LB_LAN_FORCE_MASK)
+#define ICE_FLTR_INFO_LB_LAN_FORCE_DISABLED ICE_FLTR_INFO_LB_LAN_FORCE_MASK
+
 struct ice_fltr_info {
 	/* Look up information: how to look up packet */
 	enum ice_sw_lkup_type lkup_type;
-- 
2.43.0


