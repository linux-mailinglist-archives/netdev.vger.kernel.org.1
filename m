Return-Path: <netdev+bounces-235327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DF4C2EB39
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 02:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AAD83BA578
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 01:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2B5221FB4;
	Tue,  4 Nov 2025 01:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J9YcxTsh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53B621CC56
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 01:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762218446; cv=none; b=XUU7+xbtF3laZD4PnOyrte1qilh7F6mrC7u2vRSTUoLjLAmmrU4WdWKMmVmqcTfpyvAyvuyTN19D6xXTNVl0RfmbZWT0WZCmYvpM0qyEkpuZ6zUnoMbXK5gIP9NITPPvOgo0ja4W9cS/3xCH22lJSl+IqwUK+L7An5SckAQNztE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762218446; c=relaxed/simple;
	bh=sE8Oq9tY1dUzCVDqM7QC2zprMi2tuNz63igFw+gBju8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g4aJ9+qXyqcopEPwVzUTw1MBuFViqmEIj+RPfBNS+Xg0H0VIkxo8Azl0eZVo3lpGSfv9x6fWYEBri/0HGHRc9rfX0CzEXEADo0IDVsiUCfhOrrTLx8jmJD5SYXg8NlTrGHqqntuKbiyTE2XYlHoCZobQVma6JzIs2iys+pA8E1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J9YcxTsh; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762218445; x=1793754445;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=sE8Oq9tY1dUzCVDqM7QC2zprMi2tuNz63igFw+gBju8=;
  b=J9YcxTshRnAT9Hz4HUb4TanDIUlSKkep4OprAxKHUZN0eqyXoFg2v4sD
   /x562wDyrYk2SH+65mfkQ7oCoTboguIBaiE0GWkOYVbdxXYIfG50Mx6W8
   i2y6A2N0HFL3LOgT8JyF0N1aReB9X9l8y05gI1UwJhZsXgBIS73wWJNQG
   WdfwUvAo5p+R6OT87TLYvvjdgxTOq07sBWCNGjdopDDWBz14HDbj3I2vf
   AhXbmAAi42K1CuHOD3QU9R8i+nQoI1XxKVnI1tfZEDtgYo03aQ4PjbL+e
   DEBkHNp845ba8IE8OAkkmN93Jx0yuRiS6I9nzCNPFhKAl8inCTRm8LaA8
   Q==;
X-CSE-ConnectionGUID: wa+QZbXwSTysH4y/LlQrjA==
X-CSE-MsgGUID: c+YVt+QJRDO6as/t41fnXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="75656564"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="75656564"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 17:07:18 -0800
X-CSE-ConnectionGUID: /u6ZniPoTNGGw7W2DubAaw==
X-CSE-MsgGUID: zT+VPdM6TMyXT5+oym0X2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="217828772"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.90]) ([10.166.28.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 17:07:16 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 03 Nov 2025 17:06:52 -0800
Subject: [PATCH iwl-next 7/9] ice: use u64_stats API to access pkts/bytes
 in dim sample
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-jk-refactor-queue-stats-v1-7-164d2ed859b6@intel.com>
References: <20251103-jk-refactor-queue-stats-v1-0-164d2ed859b6@intel.com>
In-Reply-To: <20251103-jk-refactor-queue-stats-v1-0-164d2ed859b6@intel.com>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.15-dev-f4b34
X-Developer-Signature: v=1; a=openpgp-sha256; l=6368;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=sE8Oq9tY1dUzCVDqM7QC2zprMi2tuNz63igFw+gBju8=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhkzOwENbtPNjbTJ6Xqit6DvhYahXxMsqkrMqf2LW6sK0G
 71Trlt0lLIwiHExyIopsig4hKy8bjwhTOuNsxzMHFYmkCEMXJwCMJE/eYwMO49dNAh+ZJmnrOgs
 enH79DcH1/5fpFC9eFnhnYtdjT2b4hgZnkzZMX3G+QbV2FfffiXxbfaVmx2X6SO67LtAllCXReU
 sLgA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

The __ice_update_sample and __ice_get_ethtool_stats functions directly
accesses the pkts and bytes counters from the ring stats. A following
change is going to update the fields to be u64_stats_t type, and will need
to be accessed appropriately. This will ensure that the accesses do not
cause load/store tearing.

Add helper functions similar to the ones used for updating the stats
values, and use them. This ensures use of the syncp pointer on 32-bit
architectures. Once the fields are updated to u64_stats_t, it will then
properly avoid tears on all architectures.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.h     |  6 +++++
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 26 +++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_lib.c     | 36 ++++++++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_txrx.c    | 29 +++++++++++-----------
 4 files changed, 75 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 2cb1eb98b9da..49454d98dcfe 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -92,6 +92,12 @@ void ice_update_tx_ring_stats(struct ice_tx_ring *ring, u64 pkts, u64 bytes);
 
 void ice_update_rx_ring_stats(struct ice_rx_ring *ring, u64 pkts, u64 bytes);
 
+void ice_fetch_tx_ring_stats(const struct ice_tx_ring *ring,
+			     u64 *pkts, u64 *bytes);
+
+void ice_fetch_rx_ring_stats(const struct ice_rx_ring *ring,
+			     u64 *pkts, u64 *bytes);
+
 void ice_write_intrl(struct ice_q_vector *q_vector, u8 intrl);
 void ice_write_itr(struct ice_ring_container *rc, u16 itr);
 void ice_set_q_vector_intrl(struct ice_q_vector *q_vector);
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 0bc6f31a2b06..6c93e0e91ef5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1942,25 +1942,35 @@ __ice_get_ethtool_stats(struct net_device *netdev,
 	rcu_read_lock();
 
 	ice_for_each_alloc_txq(vsi, j) {
+		u64 pkts, bytes;
+
 		tx_ring = READ_ONCE(vsi->tx_rings[j]);
-		if (tx_ring && tx_ring->ring_stats) {
-			data[i++] = tx_ring->ring_stats->stats.pkts;
-			data[i++] = tx_ring->ring_stats->stats.bytes;
-		} else {
+		if (!tx_ring || !tx_ring->ring_stats) {
 			data[i++] = 0;
 			data[i++] = 0;
+			continue;
 		}
+
+		ice_fetch_tx_ring_stats(tx_ring, &pkts, &bytes);
+
+		data[i++] = pkts;
+		data[i++] = bytes;
 	}
 
 	ice_for_each_alloc_rxq(vsi, j) {
+		u64 pkts, bytes;
+
 		rx_ring = READ_ONCE(vsi->rx_rings[j]);
-		if (rx_ring && rx_ring->ring_stats) {
-			data[i++] = rx_ring->ring_stats->stats.pkts;
-			data[i++] = rx_ring->ring_stats->stats.bytes;
-		} else {
+		if (!rx_ring || !rx_ring->ring_stats) {
 			data[i++] = 0;
 			data[i++] = 0;
+			continue;
 		}
+
+		ice_fetch_rx_ring_stats(rx_ring, &pkts, &bytes);
+
+		data[i++] = pkts;
+		data[i++] = bytes;
 	}
 
 	rcu_read_unlock();
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index c6dd297582c1..1c8b6129835d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3470,6 +3470,42 @@ void ice_update_rx_ring_stats(struct ice_rx_ring *rx_ring, u64 pkts, u64 bytes)
 	u64_stats_update_end(&rx_ring->ring_stats->syncp);
 }
 
+/**
+ * ice_fetch_tx_ring_stats - Fetch Tx ring packet and byte counters
+ * @ring: ring to update
+ * @pkts: number of processed packets
+ * @bytes: number of processed bytes
+ */
+void ice_fetch_tx_ring_stats(const struct ice_tx_ring *ring,
+			     u64 *pkts, u64 *bytes)
+{
+	unsigned int start;
+
+	do  {
+		start = u64_stats_fetch_begin(&ring->ring_stats->syncp);
+		*pkts = ring->ring_stats->pkts;
+		*bytes = ring->ring_stats->bytes;
+	} while (u64_stats_fetch_retry(&ring->ring_stats->syncp, start));
+}
+
+/**
+ * ice_fetch_rx_ring_stats - Fetch Rx ring packet and byte counters
+ * @ring: ring to read
+ * @pkts: number of processed packets
+ * @bytes: number of processed bytes
+ */
+void ice_fetch_rx_ring_stats(const struct ice_rx_ring *ring,
+			     u64 *pkts, u64 *bytes)
+{
+	unsigned int start;
+
+	do  {
+		start = u64_stats_fetch_begin(&ring->ring_stats->syncp);
+		*pkts = ring->ring_stats->pkts;
+		*bytes = ring->ring_stats->bytes;
+	} while (u64_stats_fetch_retry(&ring->ring_stats->syncp, start));
+}
+
 /**
  * ice_is_dflt_vsi_in_use - check if the default forwarding VSI is being used
  * @pi: port info of the switch with default VSI
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 30073ed9ca99..f0f5133c389f 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1087,35 +1087,36 @@ static void __ice_update_sample(struct ice_q_vector *q_vector,
 				struct dim_sample *sample,
 				bool is_tx)
 {
-	u64 packets = 0, bytes = 0;
+	u64 total_packets = 0, total_bytes = 0, pkts, bytes;
 
 	if (is_tx) {
 		struct ice_tx_ring *tx_ring;
 
 		ice_for_each_tx_ring(tx_ring, *rc) {
-			struct ice_ring_stats *ring_stats;
-
-			ring_stats = tx_ring->ring_stats;
-			if (!ring_stats)
+			if (!tx_ring->ring_stats)
 				continue;
-			packets += ring_stats->stats.pkts;
-			bytes += ring_stats->stats.bytes;
+
+			ice_fetch_tx_ring_stats(tx_ring, &pkts, &bytes);
+
+			total_packets += pkts;
+			total_bytes += bytes;
 		}
 	} else {
 		struct ice_rx_ring *rx_ring;
 
 		ice_for_each_rx_ring(rx_ring, *rc) {
-			struct ice_ring_stats *ring_stats;
-
-			ring_stats = rx_ring->ring_stats;
-			if (!ring_stats)
+			if (!rx_ring->ring_stats)
 				continue;
-			packets += ring_stats->stats.pkts;
-			bytes += ring_stats->stats.bytes;
+
+			ice_fetch_rx_ring_stats(rx_ring, &pkts, &bytes);
+
+			total_packets += pkts;
+			total_bytes += bytes;
 		}
 	}
 
-	dim_update_sample(q_vector->total_events, packets, bytes, sample);
+	dim_update_sample(q_vector->total_events,
+			  total_packets, total_bytes, sample);
 	sample->comp_ctr = 0;
 
 	/* if dim settings get stale, like when not updated for 1

-- 
2.51.0.rc1.197.g6d975e95c9d7


