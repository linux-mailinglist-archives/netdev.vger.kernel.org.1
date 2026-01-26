Return-Path: <netdev+bounces-253615-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDjdDqfud2kVmgEAu9opvQ
	(envelope-from <netdev+bounces-253615-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 23:45:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 926108E068
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 23:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0364E30474DE
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 22:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3283301022;
	Mon, 26 Jan 2026 22:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WvvGlY/S"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD0C30AD05
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 22:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769467407; cv=none; b=YsMHUd0oEXyNW+xeXmJl41tikcmKShKtGjxFBttEGD23ikKusuNfZKf/oexe9GxbcHqU5pf03FQUEIB3DEOHJ5emSS+52T/50/n9Qx5B+sizOkDdarbn2b5y3eWcSotn4V2IW30on11yIP9+wIc8niO+5j8fItcvgkxwrYnyI/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769467407; c=relaxed/simple;
	bh=5XmCDibG+EJeSdun8tJ6fGJhsWyNIhdZOS/+FUipQ4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hzgKXTBM6egCpgOIoyT6OVZddEmasmI7FyH0Hp23MMK57K6QeNxLYxbBA0bvsZjeON78hX6UAIKf9KkHufL+viPKmq45NONMmS5w6ApCTrW9dl4FE6e//jBVs/18MdMMzDMpI2JT40mHAcz3fXARO7IcGPB4ZJPuYRFlanVIlGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WvvGlY/S; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769467403; x=1801003403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5XmCDibG+EJeSdun8tJ6fGJhsWyNIhdZOS/+FUipQ4E=;
  b=WvvGlY/SniqckGta7XOQqZrHVdqwtzVzzw7xXDNJ0XuDKng9CxVOUZQ5
   4lEBb0JTvM+xRZSXnexxeFhitjfWNW3VXgzopBZ5ZCL7mjP3Z0Pl3jniR
   yesTDcu74/PhBGPw7TkjS/Bd/QZR8jI+3bvptGPbL11mv5fIMbFGgsACg
   dxseYCLQqx5oN9hXuadupCPKrt1Nuyet3adiyaSMPDQypcg8FYhAfamBg
   FsC02MMRSOJbLk7lbF7SAnrkA1cXd2KxIEsIhu08bsLKNQfszsfjVDMwS
   6JXN1MthdIRrV3IzoI6KAK16j07kaPu9pj/6XBBgLU6sY7k+MltKhHLiH
   w==;
X-CSE-ConnectionGUID: O9b5izGTTnmv4yrj1NiNjg==
X-CSE-MsgGUID: DXDAHpvWTgKFNkno6qGJbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70369400"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="70369400"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 14:43:23 -0800
X-CSE-ConnectionGUID: NcKCrlOaTfS8MkE9oV4MdQ==
X-CSE-MsgGUID: EU/NlugjThGHVMUq3K94Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="230754294"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 26 Jan 2026 14:43:22 -0800
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
Subject: [PATCH net-next 5/7] ice: convert all ring stats to u64_stats_t
Date: Mon, 26 Jan 2026 14:43:09 -0800
Message-ID: <20260126224313.3847849-6-anthony.l.nguyen@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253615-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 926108E068
X-Rspamd-Action: no action

From: Jacob Keller <jacob.e.keller@intel.com>

After several cleanups, the ice driver is now finally ready to convert all
Tx and Rx ring stats to the u64_stats_t and proper use of the u64 stats
APIs.

The final remaining part to cleanup is the VSI stats accumulation logic in
ice_update_vsi_ring_stats().

Refactor the function and its helpers so that all stat values (and not
just pkts and bytes) use the u64_stats APIs. The
ice_fetch_u64_(tx|rx)_stats functions read the stat values using
u64_stats_read and then copy them into local ice_vsi_(tx|rx)_stats
structures. This does require making a new struct with the stat fields as
u64.

The ice_update_vsi_(tx|rx)_ring_stats functions call the fetch functions
per ring and accumulate the result into one copy of the struct. This
accumulated total is then used to update the relevant VSI fields.

Since these are relatively small, the contents are all stored on the stack
rather than allocating and freeing memory.

Once the accumulator side is updated, the helper ice_stats_read and
ice_stats_inc and other related helper functions all easily translate to
use of u64_stats_read and u64_stats_inc. This completes the refactor and
ensures that all stats accesses now make proper use of the API.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c  |  29 +---
 drivers/net/ethernet/intel/ice/ice_main.c | 180 +++++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_txrx.h |  28 ++--
 3 files changed, 147 insertions(+), 90 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index c0f77d962c30..17d92ba65128 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3432,21 +3432,6 @@ int ice_vsi_cfg_tc(struct ice_vsi *vsi, u8 ena_tc)
 	return ret;
 }
 
-/**
- * ice_update_ring_stats - Update ring statistics
- * @stats: stats to be updated
- * @pkts: number of processed packets
- * @bytes: number of processed bytes
- *
- * This function assumes that caller has acquired a u64_stats_sync lock.
- */
-static void ice_update_ring_stats(struct ice_ring_stats *stats,
-				  u64 pkts, u64 bytes)
-{
-	stats->bytes += bytes;
-	stats->pkts += pkts;
-}
-
 /**
  * ice_update_tx_ring_stats - Update Tx ring specific counters
  * @tx_ring: ring to update
@@ -3456,7 +3441,8 @@ static void ice_update_ring_stats(struct ice_ring_stats *stats,
 void ice_update_tx_ring_stats(struct ice_tx_ring *tx_ring, u64 pkts, u64 bytes)
 {
 	u64_stats_update_begin(&tx_ring->ring_stats->syncp);
-	ice_update_ring_stats(tx_ring->ring_stats, pkts, bytes);
+	u64_stats_add(&tx_ring->ring_stats->pkts, pkts);
+	u64_stats_add(&tx_ring->ring_stats->bytes, bytes);
 	u64_stats_update_end(&tx_ring->ring_stats->syncp);
 }
 
@@ -3469,7 +3455,8 @@ void ice_update_tx_ring_stats(struct ice_tx_ring *tx_ring, u64 pkts, u64 bytes)
 void ice_update_rx_ring_stats(struct ice_rx_ring *rx_ring, u64 pkts, u64 bytes)
 {
 	u64_stats_update_begin(&rx_ring->ring_stats->syncp);
-	ice_update_ring_stats(rx_ring->ring_stats, pkts, bytes);
+	u64_stats_add(&rx_ring->ring_stats->pkts, pkts);
+	u64_stats_add(&rx_ring->ring_stats->bytes, bytes);
 	u64_stats_update_end(&rx_ring->ring_stats->syncp);
 }
 
@@ -3486,8 +3473,8 @@ void ice_fetch_tx_ring_stats(const struct ice_tx_ring *ring,
 
 	do  {
 		start = u64_stats_fetch_begin(&ring->ring_stats->syncp);
-		*pkts = ring->ring_stats->pkts;
-		*bytes = ring->ring_stats->bytes;
+		*pkts = u64_stats_read(&ring->ring_stats->pkts);
+		*bytes = u64_stats_read(&ring->ring_stats->bytes);
 	} while (u64_stats_fetch_retry(&ring->ring_stats->syncp, start));
 }
 
@@ -3504,8 +3491,8 @@ void ice_fetch_rx_ring_stats(const struct ice_rx_ring *ring,
 
 	do  {
 		start = u64_stats_fetch_begin(&ring->ring_stats->syncp);
-		*pkts = ring->ring_stats->pkts;
-		*bytes = ring->ring_stats->bytes;
+		*pkts = u64_stats_read(&ring->ring_stats->pkts);
+		*bytes = u64_stats_read(&ring->ring_stats->bytes);
 	} while (u64_stats_fetch_retry(&ring->ring_stats->syncp, start));
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index ced6ad86c8b2..79d97a902470 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6822,54 +6822,132 @@ int ice_up(struct ice_vsi *vsi)
 	return err;
 }
 
+struct ice_vsi_tx_stats {
+	u64 pkts;
+	u64 bytes;
+	u64 tx_restart_q;
+	u64 tx_busy;
+	u64 tx_linearize;
+};
+
+struct ice_vsi_rx_stats {
+	u64 pkts;
+	u64 bytes;
+	u64 rx_non_eop_descs;
+	u64 rx_page_failed;
+	u64 rx_buf_failed;
+};
+
+/**
+ * ice_fetch_u64_tx_stats - get Tx stats from a ring
+ * @ring: the Tx ring to copy stats from
+ * @copy: temporary storage for the ring statistics
+ *
+ * Fetch the u64 stats from the ring using u64_stats_fetch. This ensures each
+ * stat value is self-consistent, though not necessarily consistent w.r.t
+ * other stats.
+ */
+static void ice_fetch_u64_tx_stats(struct ice_tx_ring *ring,
+				   struct ice_vsi_tx_stats *copy)
+{
+	struct ice_ring_stats *stats = ring->ring_stats;
+	unsigned int start;
+
+	do {
+		start = u64_stats_fetch_begin(&stats->syncp);
+		copy->pkts = u64_stats_read(&stats->pkts);
+		copy->bytes = u64_stats_read(&stats->bytes);
+		copy->tx_restart_q = u64_stats_read(&stats->tx_restart_q);
+		copy->tx_busy = u64_stats_read(&stats->tx_busy);
+		copy->tx_linearize = u64_stats_read(&stats->tx_linearize);
+	} while (u64_stats_fetch_retry(&stats->syncp, start));
+}
+
 /**
- * ice_fetch_u64_stats_per_ring - get packets and bytes stats per ring
- * @stats: pointer to ring stats structure
- * @pkts: packets stats counter
- * @bytes: bytes stats counter
+ * ice_fetch_u64_rx_stats - get Rx stats from a ring
+ * @ring: the Rx ring to copy stats from
+ * @copy: temporary storage for the ring statistics
  *
- * This function fetches stats from the ring considering the atomic operations
- * that needs to be performed to read u64 values in 32 bit machine.
+ * Fetch the u64 stats from the ring using u64_stats_fetch. This ensures each
+ * stat value is self-consistent, though not necessarily consistent w.r.t
+ * other stats.
  */
-static void ice_fetch_u64_stats_per_ring(struct ice_ring_stats *stats,
-					 u64 *pkts, u64 *bytes)
+static void ice_fetch_u64_rx_stats(struct ice_rx_ring *ring,
+				   struct ice_vsi_rx_stats *copy)
 {
+	struct ice_ring_stats *stats = ring->ring_stats;
 	unsigned int start;
 
 	do {
 		start = u64_stats_fetch_begin(&stats->syncp);
-		*pkts = stats->stats.pkts;
-		*bytes = stats->stats.bytes;
+		copy->pkts = u64_stats_read(&stats->pkts);
+		copy->bytes = u64_stats_read(&stats->bytes);
+		copy->rx_non_eop_descs =
+			u64_stats_read(&stats->rx_non_eop_descs);
+		copy->rx_page_failed = u64_stats_read(&stats->rx_page_failed);
+		copy->rx_buf_failed = u64_stats_read(&stats->rx_buf_failed);
 	} while (u64_stats_fetch_retry(&stats->syncp, start));
 }
 
 /**
  * ice_update_vsi_tx_ring_stats - Update VSI Tx ring stats counters
  * @vsi: the VSI to be updated
- * @vsi_stats: the stats struct to be updated
+ * @vsi_stats: accumulated stats for this VSI
  * @rings: rings to work on
  * @count: number of rings
  */
-static void
-ice_update_vsi_tx_ring_stats(struct ice_vsi *vsi,
-			     struct rtnl_link_stats64 *vsi_stats,
-			     struct ice_tx_ring **rings, u16 count)
+static void ice_update_vsi_tx_ring_stats(struct ice_vsi *vsi,
+					 struct ice_vsi_tx_stats *vsi_stats,
+					 struct ice_tx_ring **rings, u16 count)
 {
+	struct ice_vsi_tx_stats copy = {};
 	u16 i;
 
 	for (i = 0; i < count; i++) {
 		struct ice_tx_ring *ring;
-		u64 pkts = 0, bytes = 0;
 
 		ring = READ_ONCE(rings[i]);
 		if (!ring || !ring->ring_stats)
 			continue;
-		ice_fetch_u64_stats_per_ring(ring->ring_stats, &pkts, &bytes);
-		vsi_stats->tx_packets += pkts;
-		vsi_stats->tx_bytes += bytes;
-		vsi->tx_restart += ring->ring_stats->tx_restart_q;
-		vsi->tx_busy += ring->ring_stats->tx_busy;
-		vsi->tx_linearize += ring->ring_stats->tx_linearize;
+
+		ice_fetch_u64_tx_stats(ring, &copy);
+
+		vsi_stats->pkts += copy.pkts;
+		vsi_stats->bytes += copy.bytes;
+		vsi_stats->tx_restart_q += copy.tx_restart_q;
+		vsi_stats->tx_busy += copy.tx_busy;
+		vsi_stats->tx_linearize += copy.tx_linearize;
+	}
+}
+
+/**
+ * ice_update_vsi_rx_ring_stats - Update VSI Rx ring stats counters
+ * @vsi: the VSI to be updated
+ * @vsi_stats: accumulated stats for this VSI
+ * @rings: rings to work on
+ * @count: number of rings
+ */
+static void ice_update_vsi_rx_ring_stats(struct ice_vsi *vsi,
+					 struct ice_vsi_rx_stats *vsi_stats,
+					 struct ice_rx_ring **rings, u16 count)
+{
+	struct ice_vsi_rx_stats copy = {};
+	u16 i;
+
+	for (i = 0; i < count; i++) {
+		struct ice_rx_ring *ring;
+
+		ring = READ_ONCE(rings[i]);
+		if (!ring || !ring->ring_stats)
+			continue;
+
+		ice_fetch_u64_rx_stats(ring, &copy);
+
+		vsi_stats->pkts += copy.pkts;
+		vsi_stats->bytes += copy.bytes;
+		vsi_stats->rx_non_eop_descs += copy.rx_non_eop_descs;
+		vsi_stats->rx_page_failed += copy.rx_page_failed;
+		vsi_stats->rx_buf_failed += copy.rx_buf_failed;
 	}
 }
 
@@ -6880,48 +6958,34 @@ ice_update_vsi_tx_ring_stats(struct ice_vsi *vsi,
 static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
 {
 	struct rtnl_link_stats64 *net_stats, *stats_prev;
-	struct rtnl_link_stats64 *vsi_stats;
+	struct ice_vsi_tx_stats tx_stats = {};
+	struct ice_vsi_rx_stats rx_stats = {};
 	struct ice_pf *pf = vsi->back;
-	u64 pkts, bytes;
-	int i;
-
-	vsi_stats = kzalloc(sizeof(*vsi_stats), GFP_ATOMIC);
-	if (!vsi_stats)
-		return;
-
-	/* reset non-netdev (extended) stats */
-	vsi->tx_restart = 0;
-	vsi->tx_busy = 0;
-	vsi->tx_linearize = 0;
-	vsi->rx_buf_failed = 0;
-	vsi->rx_page_failed = 0;
 
 	rcu_read_lock();
 
 	/* update Tx rings counters */
-	ice_update_vsi_tx_ring_stats(vsi, vsi_stats, vsi->tx_rings,
+	ice_update_vsi_tx_ring_stats(vsi, &tx_stats, vsi->tx_rings,
 				     vsi->num_txq);
 
 	/* update Rx rings counters */
-	ice_for_each_rxq(vsi, i) {
-		struct ice_rx_ring *ring = READ_ONCE(vsi->rx_rings[i]);
-		struct ice_ring_stats *ring_stats;
-
-		ring_stats = ring->ring_stats;
-		ice_fetch_u64_stats_per_ring(ring_stats, &pkts, &bytes);
-		vsi_stats->rx_packets += pkts;
-		vsi_stats->rx_bytes += bytes;
-		vsi->rx_buf_failed += ring_stats->rx_buf_failed;
-		vsi->rx_page_failed += ring_stats->rx_page_failed;
-	}
+	ice_update_vsi_rx_ring_stats(vsi, &rx_stats, vsi->rx_rings,
+				     vsi->num_rxq);
 
 	/* update XDP Tx rings counters */
 	if (ice_is_xdp_ena_vsi(vsi))
-		ice_update_vsi_tx_ring_stats(vsi, vsi_stats, vsi->xdp_rings,
+		ice_update_vsi_tx_ring_stats(vsi, &tx_stats, vsi->xdp_rings,
 					     vsi->num_xdp_txq);
 
 	rcu_read_unlock();
 
+	/* Save non-netdev (extended) stats */
+	vsi->tx_restart = tx_stats.tx_restart_q;
+	vsi->tx_busy = tx_stats.tx_busy;
+	vsi->tx_linearize = tx_stats.tx_linearize;
+	vsi->rx_buf_failed = rx_stats.rx_buf_failed;
+	vsi->rx_page_failed = rx_stats.rx_page_failed;
+
 	net_stats = &vsi->net_stats;
 	stats_prev = &vsi->net_stats_prev;
 
@@ -6931,18 +6995,16 @@ static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
 	 * let's skip this round.
 	 */
 	if (likely(pf->stat_prev_loaded)) {
-		net_stats->tx_packets += vsi_stats->tx_packets - stats_prev->tx_packets;
-		net_stats->tx_bytes += vsi_stats->tx_bytes - stats_prev->tx_bytes;
-		net_stats->rx_packets += vsi_stats->rx_packets - stats_prev->rx_packets;
-		net_stats->rx_bytes += vsi_stats->rx_bytes - stats_prev->rx_bytes;
+		net_stats->tx_packets += tx_stats.pkts - stats_prev->tx_packets;
+		net_stats->tx_bytes += tx_stats.bytes - stats_prev->tx_bytes;
+		net_stats->rx_packets += rx_stats.pkts - stats_prev->rx_packets;
+		net_stats->rx_bytes += rx_stats.bytes - stats_prev->rx_bytes;
 	}
 
-	stats_prev->tx_packets = vsi_stats->tx_packets;
-	stats_prev->tx_bytes = vsi_stats->tx_bytes;
-	stats_prev->rx_packets = vsi_stats->rx_packets;
-	stats_prev->rx_bytes = vsi_stats->rx_bytes;
-
-	kfree(vsi_stats);
+	stats_prev->tx_packets = tx_stats.pkts;
+	stats_prev->tx_bytes = tx_stats.bytes;
+	stats_prev->rx_packets = rx_stats.pkts;
+	stats_prev->rx_bytes = rx_stats.bytes;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index e7e4991c0934..c51b1e60f717 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -133,20 +133,20 @@ struct ice_ring_stats {
 	struct rcu_head rcu;	/* to avoid race on free */
 	struct u64_stats_sync syncp;
 	struct_group(stats,
-		u64 pkts;
-		u64 bytes;
+		u64_stats_t pkts;
+		u64_stats_t bytes;
 		union {
 			struct_group(tx,
-				u64 tx_restart_q;
-				u64 tx_busy;
-				u64 tx_linearize;
+				u64_stats_t tx_restart_q;
+				u64_stats_t tx_busy;
+				u64_stats_t tx_linearize;
 				/* negative if no pending Tx descriptors */
 				int prev_pkt;
 			);
 			struct_group(rx,
-				u64 rx_non_eop_descs;
-				u64 rx_page_failed;
-				u64 rx_buf_failed;
+				u64_stats_t rx_non_eop_descs;
+				u64_stats_t rx_page_failed;
+				u64_stats_t rx_buf_failed;
 			);
 		};
 	);
@@ -164,7 +164,13 @@ struct ice_ring_stats {
  */
 #define ice_stats_read(stats, member) ({				\
 	struct ice_ring_stats *__stats = (stats);			\
-	__stats->member;						\
+	unsigned int start;						\
+	u64 val;							\
+	do {								\
+		start = u64_stats_fetch_begin(&__stats->syncp);		\
+		val = u64_stats_read(&__stats->member);			\
+	} while (u64_stats_fetch_retry(&__stats->syncp, start));	\
+	val;								\
 })
 
 /**
@@ -177,7 +183,9 @@ struct ice_ring_stats {
  */
 #define ice_stats_inc(stats, member) do {				\
 	struct ice_ring_stats *__stats = (stats);			\
-	__stats->member++;						\
+	u64_stats_update_begin(&__stats->syncp);			\
+	u64_stats_inc(&__stats->member);				\
+	u64_stats_update_end(&__stats->syncp);				\
 } while (0)
 
 enum ice_ring_state_t {
-- 
2.47.1


