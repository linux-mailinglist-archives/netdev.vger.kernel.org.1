Return-Path: <netdev+bounces-230323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DAFBE69BC
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 08:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26E68628130
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 06:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D1D31691F;
	Fri, 17 Oct 2025 06:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eUMsbCtM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D9D313264;
	Fri, 17 Oct 2025 06:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681467; cv=none; b=IbFClcJ6qBty6jbozszpaKiSQt9+KPOI4DDrh1dmiZCkyW7Jv5YdPxzIaYlRnaUjhGtv9kPMWuMueUaFjSmiICbuVC1ZvFV0bpKxNl9/HQ8XizyiHQZlDpDYGuAgKMvfad3E/JtEXCpE0DxXmaasY9Up39QpXd9DwSEWmM/cqos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681467; c=relaxed/simple;
	bh=EByV0rlDQQ5GTHMdo29/ehYDkAdFjEUzVHrBbDR5m1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oVH/ny1Bf8ew6i7jVBUlylscArn6QTNtvURhwbo0JLRNFBu3ZhBce/kAk1fVqa9aiuRpwRNcei+VOi/Ko+vZC7ehZxh4ODQDxAwu5x4Xtevoz9pxHnMH0EY4TPwPi8diMlIYjcPYrBKgpDs9yLTSmA2Axa/6uPw4wR7yHC8Fspw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eUMsbCtM; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760681464; x=1792217464;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=EByV0rlDQQ5GTHMdo29/ehYDkAdFjEUzVHrBbDR5m1I=;
  b=eUMsbCtM3lrkRx6wFCNPxTWxPtZz6elJPVkFx98JCzA7JBCWYoUqG/Xx
   OXbjO6cOL32/tgvBqc/ViLj/60cytAHL5Ps9WGd9KV44l14aEOwkXl2mm
   QlA0VOzpIFiVpZnqsF+HVBQX0PkRHUv8InVT/7HH94qB+D7Rc7H+3T4cW
   y6v/hd0UmRzfEQwHiLU6fhzEZdqBBhF/gxseslFVPUUkLA1IbOlLCPUns
   Sa41txAPFBWw7M7QZtMlepY9baioYbLo7ZvjK9DSIH9+lRz/MSBlgNbEx
   aF8+C5ma+UjfSfx0DsKC24Vn+UGNEH4ochTM5Sn16GTyezXW2Q3d8qTSU
   Q==;
X-CSE-ConnectionGUID: dRthExJVT02LonB5anQRoQ==
X-CSE-MsgGUID: nS0ZHHlZSsSC8lDuLJRcwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="50454007"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="50454007"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 23:10:55 -0700
X-CSE-ConnectionGUID: 2lUWPx8ESh6bKkaAjzOAPg==
X-CSE-MsgGUID: 8edqMDiiSwCvrkaLJ6/Gog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="183059511"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 23:10:55 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 16 Oct 2025 23:08:40 -0700
Subject: [PATCH net-next v2 11/14] ice: implement transmit hardware
 timestamp statistics
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-jk-iwl-next-2025-10-15-v2-11-ff3a390d9fc6@intel.com>
References: <20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com>
In-Reply-To: <20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Hariprasad Kelam <hkelam@marvell.com>, Rinitha S <sx.rinitha@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 jbrandeburg@cloudflare.com
X-Mailer: b4 0.15-dev-f4b34
X-Developer-Signature: v=1; a=openpgp-sha256; l=2098;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=bvUUvDDVRsZPpEK4dY3zvEOu4zTfN+FjY/cZyXNo1EM=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhoyPd1/unfLnNs+CP3trP3Ft2W1ht13v3Nbfe2Yx5tT8M
 77cPPN2TEcpC4MYF4OsmCKLgkPIyuvGE8K03jjLwcxhZQIZwsDFKQAT8XrDyLD4cNBc5RnhvmLp
 2msDZ8nw7FrHpzJVKJ/JrmF6u0d1qgTDL+aboc+2rZPdLO4z+Y5dqe+jib9O7Vpyy9X5zj9PHwW
 FqWwA
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
Tested-by: Rinitha S <sx.rinitha@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index d1ec7e6f12bf..75492a720c68 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -4736,6 +4736,23 @@ static void ice_get_rmon_stats(struct net_device *netdev,
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
 
@@ -4822,6 +4839,7 @@ static const struct ethtool_ops ice_ethtool_ops = {
 	.get_eth_mac_stats	= ice_get_eth_mac_stats,
 	.get_pause_stats	= ice_get_pause_stats,
 	.get_rmon_stats		= ice_get_rmon_stats,
+	.get_ts_stats		= ice_get_ts_stats,
 	.get_drvinfo		= ice_get_drvinfo,
 	.get_regs_len		= ice_get_regs_len,
 	.get_regs		= ice_get_regs,

-- 
2.51.0.rc1.197.g6d975e95c9d7


