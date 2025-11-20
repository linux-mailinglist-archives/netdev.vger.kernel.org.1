Return-Path: <netdev+bounces-240546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D021C762F2
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 21:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id D15FA29D79
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 20:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00A73559DE;
	Thu, 20 Nov 2025 20:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="To+ttwhI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C2C34AAF4
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 20:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763670087; cv=none; b=mDo0a1TUKbFlz/NjqGuKL8bTU8akNE5B1QF8DyzAZ0Fh17SWIG27RcL+KLkut4f19qAxJu6tQ7bnc75dFuchJS4i0D9Abm9/Xt06zYFlYAhgmbKg8nLp1rARxUczzCpWo8YwO30RlGNgp/lc3mDZgIJGB41Jwc2npjQy380BRX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763670087; c=relaxed/simple;
	bh=O3KWgybwVh8Y84Yxm3x8fvp9QN2cADLNfPn1ytY99nE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ikPNIAbfYbHB3zzON2YgoV9Zl5affCFRNdNozNqy3zunppA8QKW9rmgBjAux8nIbRVNhf54UljMkqwJLbkE6mpNS87EplsGF0PEles5BnqsekOz/r7FJyAeUWXoPoqRgNJ2fpAJOCVILw3EgH4QwUJ9PGF9YoKY0NKUqTBNxsm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=To+ttwhI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763670086; x=1795206086;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=O3KWgybwVh8Y84Yxm3x8fvp9QN2cADLNfPn1ytY99nE=;
  b=To+ttwhIYP0PFIhdf5aPJLDvIDMBwI5EnzMHItaLby/NBvUUJQ1ZqVmu
   +ocI8nDzxqNmanWohT69k8XHW8PpWfquk3qvOxZB6/7m59DAiznsP/qi6
   2IYlaQwIobcJobBdOSDc2hX5cZ2kL1xphuR4QX7V916eMd18UMLKC7/gH
   S+NPVB2UxYGjHB8htWqqngiKhE2Q1okqHTqzvgnWq9evN2VXCwMjDTGvM
   C+QDzws6WxCoVfgY0KkM06frG+J5DoSYGGqfg8JhtN8Nh2QsK8jqpRSJ+
   ukoqhlqmWZxyhBU/aBpXjZ/6x9FCLUGDS+YGTF4V4Nvf8gSpAnFNbiO8l
   w==;
X-CSE-ConnectionGUID: c9C420EoRs20zYdz3YWGhQ==
X-CSE-MsgGUID: VU1XS02YQZSguAdxTeZWXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="65688949"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="65688949"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 12:21:17 -0800
X-CSE-ConnectionGUID: 8C2tEk8hS06v/F1VOhsoog==
X-CSE-MsgGUID: tJ+/mqV6QraCquhZDQo3TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="222419707"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.90]) ([10.166.28.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 12:21:12 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 20 Nov 2025 12:20:45 -0800
Subject: [PATCH iwl-next v4 5/6] ice: shorten ring stat names and add
 accessors
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-jk-refactor-queue-stats-v4-5-6e8b0cea75cc@intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10424;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=O3KWgybwVh8Y84Yxm3x8fvp9QN2cADLNfPn1ytY99nE=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhkz5ClOTGOkHQeVBk7UZZXknvBd5eO6V5o5t+UXCXJ/Pn
 HD+lmDeUcrCIMbFICumyKLgELLyuvGEMK03znIwc1iZQIYwcHEKwEQ+7Gb4ydi7TV0wflOSb+bf
 vU8MNOdszj9Y8f5jybxfp99N3Hu+ZCvDX5kbk/zEetRWRG99+y1DeEsYZ83L6yb3tHUZwnxcQn6
 /4AYA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

The ice Tx/Rx hotpath has a few statistics counters for tracking unexpected
events. These values are stored as u64 but are not accumulated using the
u64_stats API. This could result in load/tear stores on some architectures.
Even some 64-bit architectures could have issues since the fields are not
read or written using ACCESS_ONCE or READ_ONCE.

A following change is going to refactor the stats accumulator code to use
the u64_stats API for all of these stats, and to use u64_stats_read and
u64_stats_inc properly to prevent load/store tears on all architectures.

Using u64_stats_inc and the syncp pointer is slightly verbose and would be
duplicated in a number of places in the Tx and Rx hot path. Add accessor
macros for the cases where only a single stat value is touched at once. To
keep lines short, also shorten the stats names and convert ice_txq_stats
and ice_rxq_stats to struct_group.

This will ease the transition to properly using the u64_stats API in the
following change.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.h     | 55 +++++++++++++++++++--------
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  2 +-
 drivers/net/ethernet/intel/ice/ice_main.c     | 16 ++++----
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 16 ++++----
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  4 +-
 6 files changed, 60 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index d5ad76b25f16..e7e4991c0934 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -129,19 +129,6 @@ struct ice_tx_offload_params {
 	u8 header_len;
 };
 
-struct ice_txq_stats {
-	u64 restart_q;
-	u64 tx_busy;
-	u64 tx_linearize;
-	int prev_pkt; /* negative if no pending Tx descriptors */
-};
-
-struct ice_rxq_stats {
-	u64 non_eop_descs;
-	u64 alloc_page_failed;
-	u64 alloc_buf_failed;
-};
-
 struct ice_ring_stats {
 	struct rcu_head rcu;	/* to avoid race on free */
 	struct u64_stats_sync syncp;
@@ -149,12 +136,50 @@ struct ice_ring_stats {
 		u64 pkts;
 		u64 bytes;
 		union {
-			struct ice_txq_stats tx_stats;
-			struct ice_rxq_stats rx_stats;
+			struct_group(tx,
+				u64 tx_restart_q;
+				u64 tx_busy;
+				u64 tx_linearize;
+				/* negative if no pending Tx descriptors */
+				int prev_pkt;
+			);
+			struct_group(rx,
+				u64 rx_non_eop_descs;
+				u64 rx_page_failed;
+				u64 rx_buf_failed;
+			);
 		};
 	);
 };
 
+/**
+ * ice_stats_read - Read a single ring stat value
+ * @stats: pointer to ring_stats structure for a queue
+ * @member: the ice_ring_stats member to read
+ *
+ * Shorthand for reading a single 64-bit stat value from struct
+ * ice_ring_stats.
+ *
+ * Return: the value of the requested stat.
+ */
+#define ice_stats_read(stats, member) ({				\
+	struct ice_ring_stats *__stats = (stats);			\
+	__stats->member;						\
+})
+
+/**
+ * ice_stats_inc - Increment a single ring stat value
+ * @stats: pointer to the ring_stats structure for a queue
+ * @member: the ice_ring_stats member to increment
+ *
+ * Shorthand for incrementing a single 64-bit stat value in struct
+ * ice_ring_stats.
+ */
+#define ice_stats_inc(stats, member) do {				\
+	struct ice_ring_stats *__stats = (stats);			\
+	__stats->member++;						\
+} while (0)
+
 enum ice_ring_state_t {
 	ICE_TX_XPS_INIT_DONE,
 	ICE_TX_NBITS,
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
index 6a3f10f7a53f..f17990b68b62 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
@@ -38,7 +38,7 @@ ice_is_non_eop(const struct ice_rx_ring *rx_ring,
 	if (likely(ice_test_staterr(rx_desc->wb.status_error0, ICE_RXD_EOF)))
 		return false;
 
-	rx_ring->ring_stats->rx_stats.non_eop_descs++;
+	ice_stats_inc(rx_ring->ring_stats, rx_non_eop_descs);
 
 	return true;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 4133d297dda2..740596e5d384 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -159,8 +159,8 @@ static void ice_check_for_hang_subtask(struct ice_pf *pf)
 			 * prev_pkt would be negative if there was no
 			 * pending work.
 			 */
-			packets = ring_stats->stats.pkts & INT_MAX;
-			if (ring_stats->tx_stats.prev_pkt == packets) {
+			packets = ice_stats_read(ring_stats, pkts) & INT_MAX;
+			if (ring_stats->tx.prev_pkt == packets) {
 				/* Trigger sw interrupt to revive the queue */
 				ice_trigger_sw_intr(hw, tx_ring->q_vector);
 				continue;
@@ -170,7 +170,7 @@ static void ice_check_for_hang_subtask(struct ice_pf *pf)
 			 * to ice_get_tx_pending()
 			 */
 			smp_rmb();
-			ring_stats->tx_stats.prev_pkt =
+			ring_stats->tx.prev_pkt =
 			    ice_get_tx_pending(tx_ring) ? packets : -1;
 		}
 	}
@@ -6854,9 +6854,9 @@ ice_update_vsi_tx_ring_stats(struct ice_vsi *vsi,
 		ice_fetch_u64_stats_per_ring(ring->ring_stats, &pkts, &bytes);
 		vsi_stats->tx_packets += pkts;
 		vsi_stats->tx_bytes += bytes;
-		vsi->tx_restart += ring->ring_stats->tx_stats.restart_q;
-		vsi->tx_busy += ring->ring_stats->tx_stats.tx_busy;
-		vsi->tx_linearize += ring->ring_stats->tx_stats.tx_linearize;
+		vsi->tx_restart += ring->ring_stats->tx_restart_q;
+		vsi->tx_busy += ring->ring_stats->tx_busy;
+		vsi->tx_linearize += ring->ring_stats->tx_linearize;
 	}
 }
 
@@ -6898,8 +6898,8 @@ static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
 		ice_fetch_u64_stats_per_ring(ring_stats, &pkts, &bytes);
 		vsi_stats->rx_packets += pkts;
 		vsi_stats->rx_bytes += bytes;
-		vsi->rx_buf_failed += ring_stats->rx_stats.alloc_buf_failed;
-		vsi->rx_page_failed += ring_stats->rx_stats.alloc_page_failed;
+		vsi->rx_buf_failed += ring_stats->rx_buf_failed;
+		vsi->rx_page_failed += ring_stats->rx_page_failed;
 	}
 
 	/* update XDP Tx rings counters */
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index f4196347b23a..eea83b26b094 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -379,7 +379,7 @@ static bool ice_clean_tx_irq(struct ice_tx_ring *tx_ring, int napi_budget)
 		if (netif_tx_queue_stopped(txring_txq(tx_ring)) &&
 		    !test_bit(ICE_VSI_DOWN, vsi->state)) {
 			netif_tx_wake_queue(txring_txq(tx_ring));
-			++tx_ring->ring_stats->tx_stats.restart_q;
+			ice_stats_inc(tx_ring->ring_stats, tx_restart_q);
 		}
 	}
 
@@ -499,7 +499,7 @@ int ice_setup_tx_ring(struct ice_tx_ring *tx_ring)
 
 	tx_ring->next_to_use = 0;
 	tx_ring->next_to_clean = 0;
-	tx_ring->ring_stats->tx_stats.prev_pkt = -1;
+	tx_ring->ring_stats->tx.prev_pkt = -1;
 	return 0;
 
 err:
@@ -849,7 +849,7 @@ bool ice_alloc_rx_bufs(struct ice_rx_ring *rx_ring, unsigned int cleaned_count)
 
 		addr = libeth_rx_alloc(&fq, ntu);
 		if (addr == DMA_MAPPING_ERROR) {
-			rx_ring->ring_stats->rx_stats.alloc_page_failed++;
+			ice_stats_inc(rx_ring->ring_stats, rx_page_failed);
 			break;
 		}
 
@@ -863,7 +863,7 @@ bool ice_alloc_rx_bufs(struct ice_rx_ring *rx_ring, unsigned int cleaned_count)
 
 		addr = libeth_rx_alloc(&hdr_fq, ntu);
 		if (addr == DMA_MAPPING_ERROR) {
-			rx_ring->ring_stats->rx_stats.alloc_page_failed++;
+			ice_stats_inc(rx_ring->ring_stats, rx_page_failed);
 
 			libeth_rx_recycle_slow(fq.fqes[ntu].netmem);
 			break;
@@ -1045,7 +1045,7 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		/* exit if we failed to retrieve a buffer */
 		if (!skb) {
 			libeth_xdp_return_buff_slow(xdp);
-			rx_ring->ring_stats->rx_stats.alloc_buf_failed++;
+			ice_stats_inc(rx_ring->ring_stats, rx_buf_failed);
 			continue;
 		}
 
@@ -1363,7 +1363,7 @@ static int __ice_maybe_stop_tx(struct ice_tx_ring *tx_ring, unsigned int size)
 
 	/* A reprieve! - use start_queue because it doesn't call schedule */
 	netif_tx_start_queue(txring_txq(tx_ring));
-	++tx_ring->ring_stats->tx_stats.restart_q;
+	ice_stats_inc(tx_ring->ring_stats, tx_restart_q);
 	return 0;
 }
 
@@ -2165,7 +2165,7 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
 		if (__skb_linearize(skb))
 			goto out_drop;
 		count = ice_txd_use_count(skb->len);
-		tx_ring->ring_stats->tx_stats.tx_linearize++;
+		ice_stats_inc(tx_ring->ring_stats, tx_linearize);
 	}
 
 	/* need: 1 descriptor per page * PAGE_SIZE/ICE_MAX_DATA_PER_TXD,
@@ -2176,7 +2176,7 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
 	 */
 	if (ice_maybe_stop_tx(tx_ring, count + ICE_DESCS_PER_CACHE_LINE +
 			      ICE_DESCS_FOR_CTX_DESC)) {
-		tx_ring->ring_stats->tx_stats.tx_busy++;
+		ice_stats_inc(tx_ring->ring_stats, tx_busy);
 		return NETDEV_TX_BUSY;
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index 956da38d63b0..e68f3e5d35b4 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -480,7 +480,7 @@ int __ice_xmit_xdp_ring(struct xdp_buff *xdp, struct ice_tx_ring *xdp_ring,
 	return ICE_XDP_CONSUMED;
 
 busy:
-	xdp_ring->ring_stats->tx_stats.tx_busy++;
+	ice_stats_inc(xdp_ring->ring_stats, tx_busy);
 
 	return ICE_XDP_CONSUMED;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 989ff1fd9110..953e68ed0f9a 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -497,7 +497,7 @@ static int ice_xmit_xdp_tx_zc(struct xdp_buff *xdp,
 	return ICE_XDP_TX;
 
 busy:
-	xdp_ring->ring_stats->tx_stats.tx_busy++;
+	ice_stats_inc(xdp_ring->ring_stats, tx_busy);
 
 	return ICE_XDP_CONSUMED;
 }
@@ -659,7 +659,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
 			xsk_buff_free(first);
 			first = NULL;
 
-			rx_ring->ring_stats->rx_stats.alloc_buf_failed++;
+			ice_stats_inc(rx_ring->ring_stats, rx_buf_failed);
 			continue;
 		}
 

-- 
2.51.0.rc1.197.g6d975e95c9d7


