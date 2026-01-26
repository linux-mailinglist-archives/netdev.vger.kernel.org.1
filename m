Return-Path: <netdev+bounces-253612-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKCfH3Hud2kVmgEAu9opvQ
	(envelope-from <netdev+bounces-253612-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 23:45:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4608E059
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 23:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D134303FA92
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 22:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E72A30AD06;
	Mon, 26 Jan 2026 22:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QV3j+H+L"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DA7309DCC
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 22:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769467403; cv=none; b=cNtew+bZnoDbFVz/KVeZZ0SDdMF1R3PSpy9xgxJhWI18ojmYBD5xq97gpgjL/INVXjIi8RXByCYSCIo9lRoFCAsK6CqRh/gtFk80N2enW+w/4kQ/zR4aXKqTPq2E/LZenQ1z46digiR53SPKYNUCEycNHuYEtr1/KIywmnyRjDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769467403; c=relaxed/simple;
	bh=p+tt6EiVVtenGqlt9ajSNf6v4z3ZLfU46JyNvDkwACs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iP92ECs5+87iNa1Lg9e1RrXpX+JPQKY3Krik3mykj8P+5PEAA6+XJF9aC0DU335Cdrnlaxl9S5tAEVXyV7J0+eeaazBgWL8PpRyyU7UMbRNyilt6E2DmKhV9kUyHD45GqpdVnTH7kA4Nd/JhepBG5lm5e9DTj9egV3+12Fuzv28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QV3j+H+L; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769467401; x=1801003401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p+tt6EiVVtenGqlt9ajSNf6v4z3ZLfU46JyNvDkwACs=;
  b=QV3j+H+L7X47Vty8KJFfqrdMoOwGSGWz9OB8t410X2hODEHc1eIXjdLB
   GIAm76/PbjcRi5J/v1opDJY/1pRVXR9DCDggDy1RljVpe0Xl4zlqK13/n
   bJCR6qFaCwUrAA3V05C2q2qxYZwOGbwCjIGoZ1ZirTmecCh8BWI9PEKqD
   ZIMwTlw4YevjqJXbiC0FExaH4ornFzlgYCTl6Kn6VJyVWbbb1mG4vBFMZ
   5jjVDRUWSS/ZvfOP0gaSeOisuIkaWIdTWjZ/RljRWHIU8/dQJuJxzxiOn
   NfyBdAD2GwjmuLLmzIJuhHqlqjYIDDVEs7hRR799VKLYIFqEQ9F5M38sy
   g==;
X-CSE-ConnectionGUID: E2HcnzqpSICq8KPflYBJOQ==
X-CSE-MsgGUID: 8G+b5fJhRfSaoCV4UV4R7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70369387"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="70369387"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 14:43:21 -0800
X-CSE-ConnectionGUID: HM1VNfIJRKeURKvgRkMfYQ==
X-CSE-MsgGUID: C44Vx64XTGa6YhLifUft/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="230754278"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 26 Jan 2026 14:43:20 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 2/7] ice: remove ice_q_stats struct and use struct_group
Date: Mon, 26 Jan 2026 14:43:06 -0800
Message-ID: <20260126224313.3847849-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260126224313.3847849-1-anthony.l.nguyen@intel.com>
References: <20260126224313.3847849-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253612-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E4608E059
X-Rspamd-Action: no action

From: Jacob Keller <jacob.e.keller@intel.com>

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
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c    |  4 ++--
 drivers/net/ethernet/intel/ice/ice_ethtool.c |  4 ++--
 drivers/net/ethernet/intel/ice/ice_lib.c     |  7 ++++---
 drivers/net/ethernet/intel/ice/ice_txrx.h    | 18 ++++++++----------
 4 files changed, 16 insertions(+), 17 deletions(-)

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
index 3565a5d96c6d..91d234f31c02 100644
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
index 6dabac51e1f9..ecf4ba5c79c3 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3440,7 +3440,8 @@ int ice_vsi_cfg_tc(struct ice_vsi *vsi, u8 ena_tc)
  *
  * This function assumes that caller has acquired a u64_stats_sync lock.
  */
-static void ice_update_ring_stats(struct ice_q_stats *stats, u64 pkts, u64 bytes)
+static void ice_update_ring_stats(struct ice_ring_stats *stats,
+				  u64 pkts, u64 bytes)
 {
 	stats->bytes += bytes;
 	stats->pkts += pkts;
@@ -3455,7 +3456,7 @@ static void ice_update_ring_stats(struct ice_q_stats *stats, u64 pkts, u64 bytes
 void ice_update_tx_ring_stats(struct ice_tx_ring *tx_ring, u64 pkts, u64 bytes)
 {
 	u64_stats_update_begin(&tx_ring->ring_stats->syncp);
-	ice_update_ring_stats(&tx_ring->ring_stats->stats, pkts, bytes);
+	ice_update_ring_stats(tx_ring->ring_stats, pkts, bytes);
 	u64_stats_update_end(&tx_ring->ring_stats->syncp);
 }
 
@@ -3468,7 +3469,7 @@ void ice_update_tx_ring_stats(struct ice_tx_ring *tx_ring, u64 pkts, u64 bytes)
 void ice_update_rx_ring_stats(struct ice_rx_ring *rx_ring, u64 pkts, u64 bytes)
 {
 	u64_stats_update_begin(&rx_ring->ring_stats->syncp);
-	ice_update_ring_stats(&rx_ring->ring_stats->stats, pkts, bytes);
+	ice_update_ring_stats(rx_ring->ring_stats, pkts, bytes);
 	u64_stats_update_end(&rx_ring->ring_stats->syncp);
 }
 
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
-- 
2.47.1


