Return-Path: <netdev+bounces-173612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6337A5A015
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 18:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B543A7D9B
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 17:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4445C2356AA;
	Mon, 10 Mar 2025 17:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DEEbijma"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435D2233D99
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628714; cv=none; b=meUPNRP80wdLWvURS6k0UNjA4ajjeZzxCzFIggjNC6kXjPKiPv1UZ2ID7KUSXxwtZaPe5dCQJEcqlFJqzvUVyGsxJfUa3f938ysKwCHpllptGC57WWYKRs2QXuUjRDf7q7Coc8b9P5LMTs5ZEq8t616AtAYVeVd2X3HkTK2X+a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628714; c=relaxed/simple;
	bh=L/+W0J1dfdqEu5GoFe8jiLmS1whnnfKjwrYC+E3AwsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9w0aL+IlE4f8NpEkhu/YlIZZH1xgV/Yo3NeFbJzql4HbgaY+E9sxTF45IoPNHiekuqw5LYaOsqnEyU3Z3kyY74CkHjQjP8zlLKulvsomL4bxlaLgwNDXcowqQjNqCZdsHc7CEEtsDAxlAJmBqIOQdjiOXyQsQH6VJIbVyt6LB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DEEbijma; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741628711; x=1773164711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L/+W0J1dfdqEu5GoFe8jiLmS1whnnfKjwrYC+E3AwsU=;
  b=DEEbijmaN+m+uw78WY27OVP3PZL5nfk+HaCcVVc3wRdkOTDV+bsQ7hBm
   lQhQRi+tygqrAzkEpZEA2fYH21lk7ivgafbspTDsr5yqRursgzn8+I7nP
   EnB5msO40oKsJ5N+snY/FULh/as2FKMb/4T3CoCtKrMsPR2xGpi2Ykxvc
   0jZaSzhcs4elEUDQaZexsuj6S5De4OBx703Y35No7UgfZmePxbitt+zrM
   g4GfZZQU99BNJkd6eOVufZxX7jzgxXbj5VAqYZHznenar9hZBja3k2BLt
   gEF1PpVj12w0RfC/ZNpni57DFaN9N2C9jaIv8De1fI4cyRfP2bTfKR4rA
   Q==;
X-CSE-ConnectionGUID: lSkotbqTQH+r9pczgCeLSA==
X-CSE-MsgGUID: QYwdoE6PQwavFalHQSTZGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="46549012"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="46549012"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 10:45:07 -0700
X-CSE-ConnectionGUID: zfnkH/iwS6SyBTTWXKuyYQ==
X-CSE-MsgGUID: GlF7DJbOTtiXXMF9Y8ws5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="120950830"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 10 Mar 2025 10:45:06 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Milena Olech <milena.olech@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Bharath R <bharath.r@intel.com>
Subject: [PATCH net-next 5/6] ixgbe: add PTP support for E610 device
Date: Mon, 10 Mar 2025 10:44:58 -0700
Message-ID: <20250310174502.3708121-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310174502.3708121-1-anthony.l.nguyen@intel.com>
References: <20250310174502.3708121-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Add PTP support for E610 adapter. The E610 is based on X550 and adds
firmware managed link, enhanced security capabilities and support for
updated server manageability. It does not introduce any new PTP features
compared to X550.

Reviewed-by: Milena Olech <milena.olech@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Tested-by: Bharath R <bharath.r@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c     | 13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index da91c582d439..f03925c1f521 100644
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
index 9339edbd9082..eef25e11d938 100644
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
2.47.1


