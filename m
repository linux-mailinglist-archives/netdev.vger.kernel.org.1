Return-Path: <netdev+bounces-162409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6F7A26C7E
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 08:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABBCC18873E2
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 07:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B50204C1F;
	Tue,  4 Feb 2025 07:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N9FAZ8on"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B1C204C1D
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 07:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738653186; cv=none; b=uchXm4PYtZtbmAdYYpu9d5NVUNpj1duhCxPGCH1eljAWGZcN02BXRVxGb2ntWgaDd+x/fQWg+6oUmZUH2B9Hb2mNkqO8UR543wFgUoVZdM/RmNB0L+1pAWSEwpRDJ7KUXxoadLl0ieNhLJ27u9qbM3XgJdSSWX9f/LrDxIPGG/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738653186; c=relaxed/simple;
	bh=QfFPqspbaf7ExJBkf27J8R5NIKhkrUJF1PxNFpOI15o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b4NaSljq+HS8Wby3UH7pPxQuX9zipxSfBnrFj1LJFJrUBT0JcLyJZUfbRDmL4P5sHC3W5J1XxSdJXaC97/amtV5uRaEVxH5rHwEkIZLNexHv/BNKpd+YIYk9/zfcwdmaA/xuf/TIXtKcAjxA/0L6+xvbDz5nOuw/ZIDfhOIKRbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N9FAZ8on; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738653185; x=1770189185;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QfFPqspbaf7ExJBkf27J8R5NIKhkrUJF1PxNFpOI15o=;
  b=N9FAZ8onwCA6DZWfmuUauXf9dQjiAEM9IM/0qFMJKFtshktrZWoSMONY
   LkNGWLeHtwRdBkcXMv5554LtiJEWh+Cz1v6ECalWghbExPX596CeM8lGS
   6o+d9DT5wicqhU529b1X7eD/VG8Y2MJoqS2W9+8PGP1eHidj97wc3ZAKU
   OUjt5hRSpyzad1HqHIivVo1j7F/8xXsZvOoFxYlja3D/wkEAX3lgIPlsn
   uYUrB8gp09WSQp4iVbvx12hrASSnCAYckL4vEgAYOxKtras/KkKpMVIEv
   Z9XLO2uzlBgNwZOx6os4x983u6CeZf1X93OcdlqYboJmCDlxAcU9sQF2P
   A==;
X-CSE-ConnectionGUID: P20BCcgaQfOg4gQltURjuA==
X-CSE-MsgGUID: uQBcQ9A+Qm++YrsU8CogwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="43089169"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="43089169"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 23:13:04 -0800
X-CSE-ConnectionGUID: yz4bl+uSRUG5EnW0awHZLQ==
X-CSE-MsgGUID: nzNvQnPtRRm1JI70EINpKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="141361157"
Received: from pkwapuli-mobl1.ger.corp.intel.com (HELO vbox-pkwap.ger.corp.intel.com) ([10.245.87.141])
  by fmviesa001.fm.intel.com with ESMTP; 03 Feb 2025 23:13:02 -0800
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	richardcochran@gmail.com,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next] ixgbe: add PTP support for E610 device
Date: Tue,  4 Feb 2025 08:12:59 +0100
Message-ID: <20250204071259.15510-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add PTP support for E610 adapter. The E610 is based on X550 and adds
firmware managed link, enhanced security capabilities and support for
updated server manageability. It does not introduce any new PTP features
compared to X550.

Reviewed-by: Milena Olech <milena.olech@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c     | 13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index da91c58..f03925c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3185,6 +3185,7 @@ static int ixgbe_get_ts_info(struct net_device *dev,
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
 	case ixgbe_mac_x550em_a:
+	case ixgbe_mac_e610:
 		info->rx_filters |= BIT(HWTSTAMP_FILTER_ALL);
 		break;
 	case ixgbe_mac_X540:
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
index 9339edb..eef25e1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
@@ -140,6 +140,7 @@
  * proper mult and shift to convert the cycles into nanoseconds of time.
  */
 #define IXGBE_X550_BASE_PERIOD 0xC80000000ULL
+#define IXGBE_E610_BASE_PERIOD 0x333333333ULL
 #define INCVALUE_MASK	0x7FFFFFFF
 #define ISGN		0x80000000
 
@@ -415,6 +416,7 @@ static void ixgbe_ptp_convert_to_hwtstamp(struct ixgbe_adapter *adapter,
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
 	case ixgbe_mac_x550em_a:
+	case ixgbe_mac_e610:
 		/* Upper 32 bits represent billions of cycles, lower 32 bits
 		 * represent cycles. However, we use timespec64_to_ns for the
 		 * correct math even though the units haven't been corrected
@@ -492,11 +494,13 @@ static int ixgbe_ptp_adjfine_X550(struct ptp_clock_info *ptp, long scaled_ppm)
 	struct ixgbe_adapter *adapter =
 			container_of(ptp, struct ixgbe_adapter, ptp_caps);
 	struct ixgbe_hw *hw = &adapter->hw;
+	u64 rate, base;
 	bool neg_adj;
-	u64 rate;
 	u32 inca;
 
-	neg_adj = diff_by_scaled_ppm(IXGBE_X550_BASE_PERIOD, scaled_ppm, &rate);
+	base = hw->mac.type == ixgbe_mac_e610 ? IXGBE_E610_BASE_PERIOD :
+						IXGBE_X550_BASE_PERIOD;
+	neg_adj = diff_by_scaled_ppm(base, scaled_ppm, &rate);
 
 	/* warn if rate is too large */
 	if (rate >= INCVALUE_MASK)
@@ -559,6 +563,7 @@ static int ixgbe_ptp_gettimex(struct ptp_clock_info *ptp,
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
 	case ixgbe_mac_x550em_a:
+	case ixgbe_mac_e610:
 		/* Upper 32 bits represent billions of cycles, lower 32 bits
 		 * represent cycles. However, we use timespec64_to_ns for the
 		 * correct math even though the units haven't been corrected
@@ -1067,6 +1072,7 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
 	case ixgbe_mac_x550em_a:
+	case ixgbe_mac_e610:
 		/* enable timestamping all packets only if at least some
 		 * packets were requested. Otherwise, play nice and disable
 		 * timestamping
@@ -1233,6 +1239,7 @@ void ixgbe_ptp_start_cyclecounter(struct ixgbe_adapter *adapter)
 		fallthrough;
 	case ixgbe_mac_x550em_a:
 	case ixgbe_mac_X550:
+	case ixgbe_mac_e610:
 		cc.read = ixgbe_ptp_read_X550;
 		break;
 	case ixgbe_mac_X540:
@@ -1280,6 +1287,7 @@ static void ixgbe_ptp_init_systime(struct ixgbe_adapter *adapter)
 	case ixgbe_mac_X550EM_x:
 	case ixgbe_mac_x550em_a:
 	case ixgbe_mac_X550:
+	case ixgbe_mac_e610:
 		tsauxc = IXGBE_READ_REG(hw, IXGBE_TSAUXC);
 
 		/* Reset SYSTIME registers to 0 */
@@ -1407,6 +1415,7 @@ static long ixgbe_ptp_create_clock(struct ixgbe_adapter *adapter)
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
 	case ixgbe_mac_x550em_a:
+	case ixgbe_mac_e610:
 		snprintf(adapter->ptp_caps.name, 16, "%s", netdev->name);
 		adapter->ptp_caps.owner = THIS_MODULE;
 		adapter->ptp_caps.max_adj = 30000000;
-- 
2.43.0


