Return-Path: <netdev+bounces-229746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E46BE07B6
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 21:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34AF03BA34F
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 19:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF6E3128D3;
	Wed, 15 Oct 2025 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OWax6P7y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A6A311C39;
	Wed, 15 Oct 2025 19:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556810; cv=none; b=r6Y7gP1G5loMCFAiu3ftt5ZdnKnLY88qdHpB1qfK50a2tFRQV16x160M8tQdeNIG+lVgjU+ZDWUQz5IdsskWXmFuNRuhVmxXb5P7KJTbJThuJbP62nIdJDO3l7eAazVC1klsqlya5ol/otncTrt2EEJ7H1zaalArftFxASlOvN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556810; c=relaxed/simple;
	bh=EByV0rlDQQ5GTHMdo29/ehYDkAdFjEUzVHrBbDR5m1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W/yH4JsvT/9nOKFZNM7mYIYWyzAzsN/fKHC9ie2ZdyJjNDd8shoclKZAL7nQQt+yhXjMUmQQbVWisoUqno1TcK6Flqrb1E6epD1hBz8ghwH07B9AW4ZoTihbhKnoIKHACV/Mwe0HyCGUEElvGiAUXTEQAQGi9p9bsIvKAg05GeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OWax6P7y; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760556808; x=1792092808;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=EByV0rlDQQ5GTHMdo29/ehYDkAdFjEUzVHrBbDR5m1I=;
  b=OWax6P7yfkxIgZP8xaDJOayo1mUORHS5YPCzHlkl1AIRVifRvc+JDO70
   DiVt36sdPQSgh/JJZx3miR7uVizMDgPq2aCa8Sf6Y4+1oq54LlWkH0/lg
   yTdTTSfG7n0n+oPyocGaqtgbxOiolcLu+BdZrmkj6eNq6S60eTHW/lYUo
   n2neAsjOsNlizY7QE0Z2mFJXzjWFxSHp6Z0OthrvNGWnKZi/d8KajB1cg
   VzUqoKsgNyhFRIMBOJkQD4zOFQOuvi2CrmFNrLVYsTzVAg0ololXsrz/z
   WRpmENwcAPtPahDFI1aRex47uKBXN+sw+05PGyf+eet5/1KuBv9iCLrTY
   g==;
X-CSE-ConnectionGUID: 5f08ktCrQ8mMbSf9DM2XZg==
X-CSE-MsgGUID: cN+vc0I4S46HTtH0J8raog==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="74083561"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="74083561"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:33:15 -0700
X-CSE-ConnectionGUID: eBvaKLfQSmOFjk+u3fptjA==
X-CSE-MsgGUID: nEK20vn3TDCYyFsF1yErPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="182044904"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:33:15 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 15 Oct 2025 12:32:07 -0700
Subject: [PATCH net-next 11/14] ice: implement transmit hardware timestamp
 statistics
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-jk-iwl-next-2025-10-15-v1-11-79c70b9ddab8@intel.com>
References: <20251015-jk-iwl-next-2025-10-15-v1-0-79c70b9ddab8@intel.com>
In-Reply-To: <20251015-jk-iwl-next-2025-10-15-v1-0-79c70b9ddab8@intel.com>
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
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=2098;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=bvUUvDDVRsZPpEK4dY3zvEOu4zTfN+FjY/cZyXNo1EM=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhoz333547TsiULK/mTeEQcg+sWh+e77KWTGzHO9p07+7X
 Atu3vW0o5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgInsXs/IsCJN9kAiT8B0EbME
 18aHP+f/q2gSLf7W98K6LEGiaPLKKQz/6zeEXJ/I9CPl4+1cjUxrmw7BpdlehpN92xQj72zpD1v
 LCgA=
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


