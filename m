Return-Path: <netdev+bounces-164890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15575A2F88C
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0546E3A183B
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529E8257453;
	Mon, 10 Feb 2025 19:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VXI/c/Qk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5134A2566D6
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 19:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739215445; cv=none; b=QvFEhrJV1ZDunIMLnk0z8LeOLMQR2J8Cgciz0FpKSwdqcUIJnxCNPq+qu/O8kVp+ReqTu7BRPkMMcLzunypbKHMFPiEOxHH00obced2FyDXEY6BsajyiDaWPu6vK9DJFs6bgI96veL/F6Z8+d8U3dDVrQIvq2exzbyg0z8o7Uvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739215445; c=relaxed/simple;
	bh=bvEKMpHjXaSJ0Xov9aIn4h6MBlLNB8ZOnO1UoYuK0js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMRCf2JcL9a5Wq09GNeOa8XFLzADm6a1bvVqgEToiTwKeS6VdtBTwqCytH1WwwJEbRtxbiBud+IzrXlCilXnLk4zfWX9CiqFKscwbTtdpFQsUzZkyPWGJe5LBs9G7KZXXssO5cPDWTLnygVtA2oQoUSuUcY7kaA/v+qS3pSUOvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VXI/c/Qk; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739215443; x=1770751443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bvEKMpHjXaSJ0Xov9aIn4h6MBlLNB8ZOnO1UoYuK0js=;
  b=VXI/c/QktTwvx5vXeqrDEHxJAQ2z00wGR3PnvlkHIFQZ5WJCZmS77F1n
   OjgT0xrDayjEMyR3tUGgTxGtNPsehcubfdEPjo/P0R15LUnma0oifpXqD
   jEHQyJbJX2+cKg2/KIwkTFOrNOclvPgcp11g3sQQQmJEp7sH4v9LPjE9J
   NMUO/PjQ4LQ/XG16mFezKNxxqoVbh5LxQW5DWoDh2VquQQ5hn6SaNpA1+
   6GyFC3Xmywh+mc9o0IArJ6NKQKnGQh1gM6WFsOr5ygISKqqk33aEXUpa+
   XtSWs72yvM2rX7VjDJnyzJ8clbA2SbpDLUHa5mgcVKpEr8d9N4MYY/Z62
   Q==;
X-CSE-ConnectionGUID: 854po/p6RWSmlaTmNbQTDw==
X-CSE-MsgGUID: kwEEiHTMSderj7S+ywYwWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39929221"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="39929221"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 11:24:01 -0800
X-CSE-ConnectionGUID: S02RsMkJRf6nI/r3ee5BJA==
X-CSE-MsgGUID: CE2hzCeNRC2GsHmF7tzNkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112733866"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 10 Feb 2025 11:24:01 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	grzegorz.nitka@intel.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org
Subject: [PATCH net-next 03/10] ice: Use FIELD_PREP for timestamp values
Date: Mon, 10 Feb 2025 11:23:41 -0800
Message-ID: <20250210192352.3799673-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210192352.3799673-1-anthony.l.nguyen@intel.com>
References: <20250210192352.3799673-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Instead of using shifts and casts, use FIELD_PREP after reading 40b
timestamp values.

Rename a couple defines for better clarity and consistency.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 11 ++++++-----
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  9 +++++----
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 8475d422f1ec..a2a666e6df86 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -1576,9 +1576,8 @@ static int ice_read_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx,
 	 * lower 8 bits in the low register, and the upper 32 bits in the high
 	 * register.
 	 */
-	*tstamp = FIELD_PREP(TS_PHY_HIGH_M, hi) |
-		  FIELD_PREP(TS_PHY_LOW_M, lo);
-
+	*tstamp = FIELD_PREP(PHY_40B_HIGH_M, hi) |
+		  FIELD_PREP(PHY_40B_LOW_M, lo);
 	return 0;
 }
 
@@ -3213,7 +3212,8 @@ ice_read_phy_tstamp_e82x(struct ice_hw *hw, u8 quad, u8 idx, u64 *tstamp)
 	 * lower 8 bits in the low register, and the upper 32 bits in the high
 	 * register.
 	 */
-	*tstamp = FIELD_PREP(TS_PHY_HIGH_M, hi) | FIELD_PREP(TS_PHY_LOW_M, lo);
+	*tstamp = FIELD_PREP(PHY_40B_HIGH_M, hi) |
+		  FIELD_PREP(PHY_40B_LOW_M, lo);
 
 	return 0;
 }
@@ -4979,7 +4979,8 @@ ice_read_phy_tstamp_e810(struct ice_hw *hw, u8 lport, u8 idx, u64 *tstamp)
 	/* For E810 devices, the timestamp is reported with the lower 32 bits
 	 * in the low register, and the upper 8 bits in the high register.
 	 */
-	*tstamp = ((u64)hi) << TS_HIGH_S | ((u64)lo & TS_LOW_M);
+	*tstamp = FIELD_PREP(PHY_EXT_40B_HIGH_M, hi) |
+		  FIELD_PREP(PHY_EXT_40B_LOW_M, lo);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 6b4679407558..4381ef4a6c77 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -652,15 +652,16 @@ static inline bool ice_is_dual(struct ice_hw *hw)
 /* Source timer incval macros */
 #define INCVAL_HIGH_M			0xFF
 
-/* Timestamp block macros */
+/* PHY 40b registers macros */
+#define PHY_EXT_40B_LOW_M		GENMASK(31, 0)
+#define PHY_EXT_40B_HIGH_M		GENMASK_ULL(39, 32)
+#define PHY_40B_LOW_M			GENMASK(7, 0)
+#define PHY_40B_HIGH_M			GENMASK_ULL(39, 8)
 #define TS_VALID			BIT(0)
 #define TS_LOW_M			0xFFFFFFFF
 #define TS_HIGH_M			0xFF
 #define TS_HIGH_S			32
 
-#define TS_PHY_LOW_M			GENMASK(7, 0)
-#define TS_PHY_HIGH_M			GENMASK_ULL(39, 8)
-
 #define BYTES_PER_IDX_ADDR_L_U		8
 #define BYTES_PER_IDX_ADDR_L		4
 
-- 
2.47.1


