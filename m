Return-Path: <netdev+bounces-223696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F2DB5A138
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9F7F7B2430
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 19:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B78D304BA9;
	Tue, 16 Sep 2025 19:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OULuBNnk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6772DCC08;
	Tue, 16 Sep 2025 19:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758050218; cv=none; b=dHmrzOjHtmP4jlFcDUBaWWcGdEFiDDpz6HpTfcQ1FJHOMTgjJNJohRPETB01+TNeJOgWsNVWWGKA0oCq5w395pF+mfagdkHP4HL5bcJsA25DUnWI1o2VS5VkUWZXWKl8QddMkfnJNCUtFsqmClGX7Oet1WbDcCTjnTHizUgsRGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758050218; c=relaxed/simple;
	bh=9YzEHPC3kMFw3ZqY8wpSZT2CZ0Ko0RK1ZiOYgDcqnaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PWuLmycAU2rwnwAK4buZMcjNCSRsBPLVTXCPqw4L42JRb09YzmRpMuuU06eM/521HcxDTjxrvb5EfehHFQIsq+QmTmXMXVZslueXvjnFU37jJ8q0afgLInLYjmA4dsOEikpBG4SuxkP6rcDdbYXPDDNzMTd2Va0qMYQiChOPwuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OULuBNnk; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758050217; x=1789586217;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=9YzEHPC3kMFw3ZqY8wpSZT2CZ0Ko0RK1ZiOYgDcqnaY=;
  b=OULuBNnkd4zDZqGngiz1VvYqiLajKtdsJtCtc0Z8en4xsc25hru2P8fk
   kyMYty+TnkZY4aI8hIyFg5Kg26G6vvg1n/BgUMP1gkBdX883ZlragvSHP
   AdkrHzTdAACDZEvofpNlJsxofBfP0DW5Iwa60i9IyoMn+MZEwh2DKeLng
   LExVaE89LjYoCsEKDNX879dodOUsnweK0N+AR1SPVCr1DS7MkwyiHdhan
   r0u0bQoI4XvPXv3KVWhExSUGYdJV5z7ekz6on/Uvmxqj2TsBiV+lg6uvi
   JeImzxCk5njWyc0xweIPZ2UWtFC9vTUgDvbpERge40W6Q8y785zTj+Gt8
   Q==;
X-CSE-ConnectionGUID: 6Jt6EUuHSpWybAtUHVbdbg==
X-CSE-MsgGUID: RW4BlJgTT6e9bLIQLjDHBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60037596"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="60037596"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 12:16:55 -0700
X-CSE-ConnectionGUID: q6LBvRBbQ5KRtxJ/2R9pwQ==
X-CSE-MsgGUID: JgyBbiYDTT+bJKO8cKh56g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174961767"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 12:16:54 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 16 Sep 2025 12:14:57 -0700
Subject: [PATCH iwl-next v4 4/5] ice: implement transmit hardware timestamp
 statistics
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-resend-jbrandeb-ice-standard-stats-v4-4-ec198614c738@intel.com>
References: <20250916-resend-jbrandeb-ice-standard-stats-v4-0-ec198614c738@intel.com>
In-Reply-To: <20250916-resend-jbrandeb-ice-standard-stats-v4-0-ec198614c738@intel.com>
To: Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Jakub Kicinski <kuba@kernel.org>, Hariprasad Kelam <hkelam@marvell.com>, 
 Simon Horman <horms@kernel.org>, 
 Marcin Szycik <marcin.szycik@linux.intel.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, netdev@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org, corbet@lwn.net, 
 Jacob Keller <jacob.e.keller@intel.com>
Cc: jbrandeburg@cloudflare.com
X-Mailer: b4 0.15-dev-cbe0e
X-Developer-Signature: v=1; a=openpgp-sha256; l=1987;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=fVsMI2sxazmf90Rmjei3DDI63a9Lm7CC2bI4YMCczTA=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhoyT25fUB66/Wip4ckvfosXTmRT1btUkb7XtFFy7YaLRU
 bZL1udPdZSyMIhxMciKKbIoOISsvG48IUzrjbMczBxWJpAhDFycAjCRJSqMDP9XRfjcczDcxvdy
 WbzTrSPZ0e5/j3seKApv2eIRUlKtLcrIsO3g6uO53jlNS84I6V9c48GVJSeZnsQx1WTKy09fFq6
 7yAwA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The kernel now has common statistics for transmit timestamps, so
implement them in the ice driver.

use via
ethtool -I -T eth0

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 3d99c4a1e287..f8bb2d55b28c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -4730,6 +4730,23 @@ static void ice_get_rmon_stats(struct net_device *netdev,
 	*ranges = ice_rmon_ranges;
 }
 
+/* ice_get_ts_stats - provide timestamping stats
+ * @netdev: the netdevice pointer from ethtool
+ * @ts_stats: the ethtool data structure to fill in
+ */
+static void ice_get_ts_stats(struct net_device *netdev,
+			     struct ethtool_ts_stats *ts_stats)
+{
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
+	struct ice_ptp *ptp = &pf->ptp;
+
+	ts_stats->pkts = ptp->tx_hwtstamp_good;
+	ts_stats->err = ptp->tx_hwtstamp_skipped +
+			ptp->tx_hwtstamp_flushed +
+			ptp->tx_hwtstamp_discarded;
+	ts_stats->lost = ptp->tx_hwtstamp_timeouts;
+}
+
 #define ICE_ETHTOOL_PFR (ETH_RESET_IRQ | ETH_RESET_DMA | \
 	ETH_RESET_FILTER | ETH_RESET_OFFLOAD)
 
@@ -4816,6 +4833,7 @@ static const struct ethtool_ops ice_ethtool_ops = {
 	.get_eth_mac_stats	= ice_get_eth_mac_stats,
 	.get_pause_stats	= ice_get_pause_stats,
 	.get_rmon_stats		= ice_get_rmon_stats,
+	.get_ts_stats		= ice_get_ts_stats,
 	.get_drvinfo		= ice_get_drvinfo,
 	.get_regs_len		= ice_get_regs_len,
 	.get_regs		= ice_get_regs,

-- 
2.51.0.rc1.197.g6d975e95c9d7


