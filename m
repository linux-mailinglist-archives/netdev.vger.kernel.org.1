Return-Path: <netdev+bounces-253611-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INHtAm/ud2kVmgEAu9opvQ
	(envelope-from <netdev+bounces-253611-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 23:45:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 810C48E052
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 23:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2ED8C303E2DD
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 22:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089FA30ACF2;
	Mon, 26 Jan 2026 22:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jBXfe+FD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084C92FF16F
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 22:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769467402; cv=none; b=i7q2Mi2ogxS38VAveULuGPfqZyMZRDPqmYwHt7iAazNDY6RW4PNq3tHzuko5VpN9MkJVuHHlYyioJL53MgVEuWc/XH2BqCKxZtHPr9DMa6WM0Tu/R6mNHG+hHqPaZOIml4z/9k60qD9lYI0owQFmgQ52PFL0faesVidJYCw4izI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769467402; c=relaxed/simple;
	bh=c3/barYtcy5NZ92JigXNGx8kOAOtydkAk7u4aY6Nf5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAkJW2laZ80zSlOekyfN7Ql+wwlUphO28jqqbEo4erENnZmGpRMyc/qzj/GfZxiaapscpSd3BWC1uAhNiNSVCNkASxMoUtqssOEnXa4H8fbQPbUFe0B0/MXFMjryZ0HkjcOYEEOVqk4lZWRpcm9XL9KL2sfUvsYdGokb5FHb6t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jBXfe+FD; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769467401; x=1801003401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c3/barYtcy5NZ92JigXNGx8kOAOtydkAk7u4aY6Nf5A=;
  b=jBXfe+FDgxWRQ7mhS7e7OIRUrv39SPwa2MriIvB0GeIpZ/Bk5QWul0jC
   +p/hbq+jy9XeQ0LyNuvavArH0Uqp0xhtjSRPhgeyRtfmoCfDu7fbucDU4
   pit21HLJTZXeyrzqUbTduSxXfsLozMGeOvWbuRFYisxrDNffaMmFqtFih
   RiJyHUKDl+VdDaBLseiTUoNo2Vdcq/W8q1W8NXToXQ1szQYzuMfZ/1EQx
   +UjTWpReMv8jdthdJsiooUbFrDanIGIaqAAbQBzZJne1407GwUK282KFt
   gOgR1gMxCg1Vrd+8kQ9iigjhLKpXQgNtErmIFrmt73lX8aoxLHGMkL6R/
   w==;
X-CSE-ConnectionGUID: nXcvNANATg60DKDafUHMPw==
X-CSE-MsgGUID: UcjNk6LSSNaYNjswofLXYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70369383"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="70369383"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 14:43:20 -0800
X-CSE-ConnectionGUID: EzYuATIFRFKJw8acMuM9Jw==
X-CSE-MsgGUID: 4HCVOoQQR6ac+zP77Ee85g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="230754275"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 26 Jan 2026 14:43:19 -0800
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
Subject: [PATCH net-next 1/7] ice: pass pointer to ice_fetch_u64_stats_per_ring
Date: Mon, 26 Jan 2026 14:43:05 -0800
Message-ID: <20260126224313.3847849-2-anthony.l.nguyen@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253611-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 810C48E052
X-Rspamd-Action: no action

From: Jacob Keller <jacob.e.keller@intel.com>

The ice_fetch_u64_stats_per_ring function takes a pointer to the syncp from
the ring stats to synchronize reading of the packet stats. It also takes a
*copy* of the ice_q_stats fields instead of a pointer to the stats. This
completely defeats the point of using the u64_stats API. We pass the stats
by value, so they are static at the point of reading within the
u64_stats_fetch_retry loop.

Simplify the function to take a pointer to the ice_ring_stats instead of
two separate parameters. Additionally, since we never call this outside of
ice_main.c, make it a static function.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      |  3 ---
 drivers/net/ethernet/intel/ice/ice_main.c | 24 +++++++++--------------
 2 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 00f75d87c73f..def7efa15447 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -957,9 +957,6 @@ u16 ice_get_avail_rxq_count(struct ice_pf *pf);
 int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx, bool locked);
 void ice_update_vsi_stats(struct ice_vsi *vsi);
 void ice_update_pf_stats(struct ice_pf *pf);
-void
-ice_fetch_u64_stats_per_ring(struct u64_stats_sync *syncp,
-			     struct ice_q_stats stats, u64 *pkts, u64 *bytes);
 int ice_up(struct ice_vsi *vsi);
 int ice_down(struct ice_vsi *vsi);
 int ice_down_up(struct ice_vsi *vsi);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index de488185cd4a..6dc22e811ae5 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6824,25 +6824,23 @@ int ice_up(struct ice_vsi *vsi)
 
 /**
  * ice_fetch_u64_stats_per_ring - get packets and bytes stats per ring
- * @syncp: pointer to u64_stats_sync
- * @stats: stats that pkts and bytes count will be taken from
+ * @stats: pointer to ring stats structure
  * @pkts: packets stats counter
  * @bytes: bytes stats counter
  *
  * This function fetches stats from the ring considering the atomic operations
  * that needs to be performed to read u64 values in 32 bit machine.
  */
-void
-ice_fetch_u64_stats_per_ring(struct u64_stats_sync *syncp,
-			     struct ice_q_stats stats, u64 *pkts, u64 *bytes)
+static void ice_fetch_u64_stats_per_ring(struct ice_ring_stats *stats,
+					 u64 *pkts, u64 *bytes)
 {
 	unsigned int start;
 
 	do {
-		start = u64_stats_fetch_begin(syncp);
-		*pkts = stats.pkts;
-		*bytes = stats.bytes;
-	} while (u64_stats_fetch_retry(syncp, start));
+		start = u64_stats_fetch_begin(&stats->syncp);
+		*pkts = stats->stats.pkts;
+		*bytes = stats->stats.bytes;
+	} while (u64_stats_fetch_retry(&stats->syncp, start));
 }
 
 /**
@@ -6866,9 +6864,7 @@ ice_update_vsi_tx_ring_stats(struct ice_vsi *vsi,
 		ring = READ_ONCE(rings[i]);
 		if (!ring || !ring->ring_stats)
 			continue;
-		ice_fetch_u64_stats_per_ring(&ring->ring_stats->syncp,
-					     ring->ring_stats->stats, &pkts,
-					     &bytes);
+		ice_fetch_u64_stats_per_ring(ring->ring_stats, &pkts, &bytes);
 		vsi_stats->tx_packets += pkts;
 		vsi_stats->tx_bytes += bytes;
 		vsi->tx_restart += ring->ring_stats->tx_stats.restart_q;
@@ -6912,9 +6908,7 @@ static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
 		struct ice_ring_stats *ring_stats;
 
 		ring_stats = ring->ring_stats;
-		ice_fetch_u64_stats_per_ring(&ring_stats->syncp,
-					     ring_stats->stats, &pkts,
-					     &bytes);
+		ice_fetch_u64_stats_per_ring(ring_stats, &pkts, &bytes);
 		vsi_stats->rx_packets += pkts;
 		vsi_stats->rx_bytes += bytes;
 		vsi->rx_buf_failed += ring_stats->rx_stats.alloc_buf_failed;
-- 
2.47.1


