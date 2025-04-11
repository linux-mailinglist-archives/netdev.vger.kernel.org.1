Return-Path: <netdev+bounces-181774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB8BA8677B
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72FDA4C1C9D
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4088228FFDB;
	Fri, 11 Apr 2025 20:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q8N7qAjg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9397D28CF6D
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404251; cv=none; b=HnyY/oM3TN8oMXkjXm/fLZ57WN8qLg8j2w68G1b6t3uOmjPdvkSsdk68+NHGJbT0gwVNzZzCXNhcdo0xR7KKlWc22MfNdxIB3X5unw25CKXFundviZKbdik1qaQpoQq2TYBAaf1q/JQOJW0BXQSXRoxKU3FshvAvGscV0mnLcp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404251; c=relaxed/simple;
	bh=yOoFoy+LrkrsyqaKEBGranhpyueLaZoSCbldLrnpZ6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KF4/0/TPjRWfbOsppM1X9oXvUHs0j9bT3VYgah7HLge6Hc+//rKU0JkiuDLekSUgaz3tEiSMKWGeeHiFm6K7n4c9CgLSJnyvumURT95MJXWpcA7GVzVzamo6G2URbwDsmmaJrdhlsXv/tkTRawtFURu1RFPLVGesN43ZN42uJ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q8N7qAjg; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744404249; x=1775940249;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yOoFoy+LrkrsyqaKEBGranhpyueLaZoSCbldLrnpZ6Q=;
  b=Q8N7qAjgOmMggFWBg3jRlOmkOKNBtBdQUyvkjZQ2mXSCeqGa6IRjj6u+
   6zQ59ZEe2aGj5omXchYIpmBs7OtKmUVl5wx6ojJCs5ekVJ2ueyGYDyXJC
   Wd9HVfEBg1wof/gNveGflcydB7gkwGgLbCN/n6E3eMPmNvxYx8jwbFImE
   2F132taSuujmn7WOLhmDjOieOIF7V5wLXx1oT9e1RQgcU3zdZVFqCgr9Z
   twVtnz4Mvs7stuER0OoA1ic6y3d8ycdXircRFSV92dxoUeAs7G1Uzm755
   it9hsbrOw6m0JoScMPOHgfGVb9oTchqBuzqCIwvpTrhLquiRwkVdBki2W
   w==;
X-CSE-ConnectionGUID: uzQoFPrjQt2VtFpPob09nA==
X-CSE-MsgGUID: WmrLiZkuSyu7aP7+SMGlng==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="45103863"
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="45103863"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 13:44:06 -0700
X-CSE-ConnectionGUID: UVAacgjyTpOWw88XAOT7IQ==
X-CSE-MsgGUID: 77rMa1ffQcyzJZo5Z5x52w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="129241804"
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
Subject: [PATCH net-next 04/15] ice: remove headers argument from ice_tc_count_lkups
Date: Fri, 11 Apr 2025 13:43:45 -0700
Message-ID: <20250411204401.3271306-5-anthony.l.nguyen@intel.com>
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

Remove the headers argument from the ice_tc_count_lkups() function, because
it is not used anywhere.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index ea39b999a0d0..d8d28d74222a 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -12,14 +12,11 @@
 /**
  * ice_tc_count_lkups - determine lookup count for switch filter
  * @flags: TC-flower flags
- * @headers: Pointer to TC flower filter header structure
  * @fltr: Pointer to outer TC filter structure
  *
- * Determine lookup count based on TC flower input for switch filter.
+ * Return: lookup count based on TC flower input for a switch filter.
  */
-static int
-ice_tc_count_lkups(u32 flags, struct ice_tc_flower_lyr_2_4_hdrs *headers,
-		   struct ice_tc_flower_fltr *fltr)
+static int ice_tc_count_lkups(u32 flags, struct ice_tc_flower_fltr *fltr)
 {
 	int lkups_cnt = 1; /* 0th lookup is metadata */
 
@@ -770,7 +767,6 @@ static int ice_eswitch_tc_parse_action(struct net_device *filter_dev,
 static int
 ice_eswitch_add_tc_fltr(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr)
 {
-	struct ice_tc_flower_lyr_2_4_hdrs *headers = &fltr->outer_headers;
 	struct ice_adv_rule_info rule_info = { 0 };
 	struct ice_rule_query_data rule_added;
 	struct ice_hw *hw = &vsi->back->hw;
@@ -785,7 +781,7 @@ ice_eswitch_add_tc_fltr(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr)
 		return -EOPNOTSUPP;
 	}
 
-	lkups_cnt = ice_tc_count_lkups(flags, headers, fltr);
+	lkups_cnt = ice_tc_count_lkups(flags, fltr);
 	list = kcalloc(lkups_cnt, sizeof(*list), GFP_ATOMIC);
 	if (!list)
 		return -ENOMEM;
@@ -985,7 +981,6 @@ static int
 ice_add_tc_flower_adv_fltr(struct ice_vsi *vsi,
 			   struct ice_tc_flower_fltr *tc_fltr)
 {
-	struct ice_tc_flower_lyr_2_4_hdrs *headers = &tc_fltr->outer_headers;
 	struct ice_adv_rule_info rule_info = {0};
 	struct ice_rule_query_data rule_added;
 	struct ice_adv_lkup_elem *list;
@@ -1021,7 +1016,7 @@ ice_add_tc_flower_adv_fltr(struct ice_vsi *vsi,
 			return PTR_ERR(dest_vsi);
 	}
 
-	lkups_cnt = ice_tc_count_lkups(flags, headers, tc_fltr);
+	lkups_cnt = ice_tc_count_lkups(flags, tc_fltr);
 	list = kcalloc(lkups_cnt, sizeof(*list), GFP_ATOMIC);
 	if (!list)
 		return -ENOMEM;
-- 
2.47.1


