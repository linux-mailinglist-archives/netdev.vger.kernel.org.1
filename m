Return-Path: <netdev+bounces-240543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 297A4C762E9
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 21:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB0A135BFE5
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 20:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984F033B6FF;
	Thu, 20 Nov 2025 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/hEsLYS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012E13101DB
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763670081; cv=none; b=josTrPDKVKvsvsQwbvhy5t4yxlETUoo2Y5WVA/AzIn68hSqHtnNszPaRtqaNfb9YHUSEq3NtReR9oA3W3E53qGWkUWyA4ku7my4UEG+EhKVYbrXnFLAWWxI/If4yUSm43oQVsp5JCCkA8R7oIwum1toCFhcbNoUx20YD/p0nU1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763670081; c=relaxed/simple;
	bh=DfYxaVDADmFTAmicAnjEt8LtB3MiHxWc16GEl1QPrZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LQuILRup6JmmSLSYXj9UtQ8QcVkLU2vEx9xiiIMi8otLwrIycoJh4zOfIMj2rnGaYClt+180gtoRLanSmkvjWgU3l5YeHQb8C8TBKyb24qwLxAqqcq1LNH+JYweBJlzx0Ga9mAkmlLKCkVhJcIvmHtHwy4rApVjZuVtOdSNXsJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l/hEsLYS; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763670080; x=1795206080;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=DfYxaVDADmFTAmicAnjEt8LtB3MiHxWc16GEl1QPrZs=;
  b=l/hEsLYS7ilWhXzGPTkMvUInDENXonmJEpiKWg4nAFh/+FuwDtCzgzPw
   7JRipCQqJSEWESK96oNSaxKv6eyQoYJmrFlw2zYwVrKE0UjTry4oDhiw2
   wuaPNJijrVPVBNafviRR3Mj9OdyVEbDz6eEU0BIVrDVWtlUKc9UZc+stA
   r3U5jXQNFJRrK7k2sxvKGPhk/W4Iwoj+Kw6ynBs+GAxb5+zuDilmFXJyd
   8av7L2u5aYHk99jXv+fF0ce0oNMkJzXoXa+vJLnZcBW1aKKUGchXR1GY5
   5zG58gn2ZimR32NxqkvR+HSOV2d3u5rD9YaiHaWv3ayd4PDigIdM6ziTN
   w==;
X-CSE-ConnectionGUID: t7F34KGfTP6PEcrKDiz/bQ==
X-CSE-MsgGUID: YaPWid51Q1OcnYY4vpyg1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="65688939"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="65688939"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 12:21:16 -0800
X-CSE-ConnectionGUID: apEEvgd7RTq9rhGLDJFWsw==
X-CSE-MsgGUID: y4UqaO2BTdS2C101lTAt4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="222419699"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.90]) ([10.166.28.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 12:21:12 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 20 Nov 2025 12:20:43 -0800
Subject: [PATCH iwl-next v4 3/6] ice: remove ice_q_stats struct and use
 struct_group
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-jk-refactor-queue-stats-v4-3-6e8b0cea75cc@intel.com>
References: <20251120-jk-refactor-queue-stats-v4-0-6e8b0cea75cc@intel.com>
In-Reply-To: <20251120-jk-refactor-queue-stats-v4-0-6e8b0cea75cc@intel.com>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Simon Horman <horms@kernel.org>, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Mailer: b4 0.15-dev-f4b34
X-Developer-Signature: v=1; a=openpgp-sha256; l=5248;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=DfYxaVDADmFTAmicAnjEt8LtB3MiHxWc16GEl1QPrZs=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhkz5CtOJ1y662H4/5P7q1qMZBvPO3/kV93H6zcbrMqG3H
 Us/7VE41lHKwiDGxSArpsii4BCy8rrxhDCtN85yMHNYmUCGMHBxCsBExOYx/E9cplwz7azmWoeq
 U8fa10e0BHUsfPSyLuTO5QsW6/RY0+Yx/OFx+6j3+0nZSd0PKwRkplaKlLPfma33X+bakvMsE08
 s38QPAA==
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

The ice_qp_reset_stats function resets the stats for all rings on a VSI. It
currently behaves differently for Tx and Rx rings. For Rx rings, it only
clears the rx_stats which do not include the pkt and byte counts. For Tx
rings and XDP rings, it clears only the pkt and byte counts.

We could add extra memset calls to cover both the stats and relevant
tx/rx stats fields. Instead, lets convert stats into a struct_group which
contains both the pkts and bytes fields as well as the Tx or Rx stats, and
remove the ice_q_stats structure entirely.

The only remaining user of ice_q_stats is the ice_q_stats_len function in
ice_ethtool.c, which just counts the number of fields. Replace this with a
simple multiplication by 2. I find this to be simpler to reason about than
relying on knowing the layout of the ice_q_stats structure.

Now that the stats field of the ice_ring_stats covers all of the statistic
values, the ice_qp_reset_stats function will properly zero out all of the
fields.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.h    | 18 ++++++++----------
 drivers/net/ethernet/intel/ice/ice_base.c    |  4 ++--
 drivers/net/ethernet/intel/ice/ice_ethtool.c |  4 ++--
 drivers/net/ethernet/intel/ice/ice_lib.c     |  7 ++++---
 4 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index e440c55d9e9f..d5ad76b25f16 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -129,11 +129,6 @@ struct ice_tx_offload_params {
 	u8 header_len;
 };
 
-struct ice_q_stats {
-	u64 pkts;
-	u64 bytes;
-};
-
 struct ice_txq_stats {
 	u64 restart_q;
 	u64 tx_busy;
@@ -149,12 +144,15 @@ struct ice_rxq_stats {
 
 struct ice_ring_stats {
 	struct rcu_head rcu;	/* to avoid race on free */
-	struct ice_q_stats stats;
 	struct u64_stats_sync syncp;
-	union {
-		struct ice_txq_stats tx_stats;
-		struct ice_rxq_stats rx_stats;
-	};
+	struct_group(stats,
+		u64 pkts;
+		u64 bytes;
+		union {
+			struct ice_txq_stats tx_stats;
+			struct ice_rxq_stats rx_stats;
+		};
+	);
 };
 
 enum ice_ring_state_t {
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index eadb1e3d12b3..afbff8aa9ceb 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -1414,8 +1414,8 @@ static void ice_qp_reset_stats(struct ice_vsi *vsi, u16 q_idx)
 	if (!vsi_stat)
 		return;
 
-	memset(&vsi_stat->rx_ring_stats[q_idx]->rx_stats, 0,
-	       sizeof(vsi_stat->rx_ring_stats[q_idx]->rx_stats));
+	memset(&vsi_stat->rx_ring_stats[q_idx]->stats, 0,
+	       sizeof(vsi_stat->rx_ring_stats[q_idx]->stats));
 	memset(&vsi_stat->tx_ring_stats[q_idx]->stats, 0,
 	       sizeof(vsi_stat->tx_ring_stats[q_idx]->stats));
 	if (vsi->xdp_rings)
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index a1d9abee97e5..0bc6f31a2b06 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -33,8 +33,8 @@ static int ice_q_stats_len(struct net_device *netdev)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 
-	return ((np->vsi->alloc_txq + np->vsi->alloc_rxq) *
-		(sizeof(struct ice_q_stats) / sizeof(u64)));
+	/* One packets and one bytes count per queue */
+	return ((np->vsi->alloc_txq + np->vsi->alloc_rxq) * 2);
 }
 
 #define ICE_PF_STATS_LEN	ARRAY_SIZE(ice_gstrings_pf_stats)
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 116a4f4ef91d..85bc18600c17 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3441,7 +3441,8 @@ int ice_vsi_cfg_tc(struct ice_vsi *vsi, u8 ena_tc)
  *
  * This function assumes that caller has acquired a u64_stats_sync lock.
  */
-static void ice_update_ring_stats(struct ice_q_stats *stats, u64 pkts, u64 bytes)
+static void ice_update_ring_stats(struct ice_ring_stats *stats,
+				  u64 pkts, u64 bytes)
 {
 	stats->bytes += bytes;
 	stats->pkts += pkts;
@@ -3456,7 +3457,7 @@ static void ice_update_ring_stats(struct ice_q_stats *stats, u64 pkts, u64 bytes
 void ice_update_tx_ring_stats(struct ice_tx_ring *tx_ring, u64 pkts, u64 bytes)
 {
 	u64_stats_update_begin(&tx_ring->ring_stats->syncp);
-	ice_update_ring_stats(&tx_ring->ring_stats->stats, pkts, bytes);
+	ice_update_ring_stats(tx_ring->ring_stats, pkts, bytes);
 	u64_stats_update_end(&tx_ring->ring_stats->syncp);
 }
 
@@ -3469,7 +3470,7 @@ void ice_update_tx_ring_stats(struct ice_tx_ring *tx_ring, u64 pkts, u64 bytes)
 void ice_update_rx_ring_stats(struct ice_rx_ring *rx_ring, u64 pkts, u64 bytes)
 {
 	u64_stats_update_begin(&rx_ring->ring_stats->syncp);
-	ice_update_ring_stats(&rx_ring->ring_stats->stats, pkts, bytes);
+	ice_update_ring_stats(rx_ring->ring_stats, pkts, bytes);
 	u64_stats_update_end(&rx_ring->ring_stats->syncp);
 }
 

-- 
2.51.0.rc1.197.g6d975e95c9d7


