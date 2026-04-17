Return-Path: <netdev+bounces-279192-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COc1NWOF4WkiuQAAu9opvQ
	(envelope-from <netdev+bounces-279192-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 02:57:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7D5415E3A
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 02:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B770309BAD3
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 00:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55ADF21FF2A;
	Fri, 17 Apr 2026 00:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PQgq2bq8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137022441B8
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 00:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776387276; cv=none; b=RRKgFEHLbpyCu61C+F0EH8VW5fknTywnVkLXnJBuoMUb5WD2gHGHmEQN+fZ1G0HBbuRKP+qgmKAT5qNm282NjCsX4ZmIwBqTSo9sByW0mWZjPo+zCKaD8paMPJThiAWVoL1zpPM0EXLIjX8EtLz8t+3LkZBt4MJvu5Fs5wA5GaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776387276; c=relaxed/simple;
	bh=q0HbPMMSBTiBHuqvlfNv9u5Kf9ionqZwij8Lf7yX/5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m3UUbL1o3HdY0VgAKuEPeYDGv2xeMR3fC/EnXt5Asgao1Jq3UYMyO4M/TJbKsNHHMV4muiTn+nCiGD2z6PIWWlXK9Biyo3D7H/m2ru6u+wa838Uh7lrZs1ZZmlAtkbSHmiNV37VVqgBJhb5z66tpREAQ7+dHxacsFuV8C5N3jK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PQgq2bq8; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776387274; x=1807923274;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=q0HbPMMSBTiBHuqvlfNv9u5Kf9ionqZwij8Lf7yX/5o=;
  b=PQgq2bq8LZR5+2Q0hIqvGCVcYhVuUOsY4/hqgfj9kio2cm3WbotmZBDg
   EKBZXOT3vGK5Jduekf8J6f5/hCqIoc2utSWk2D93/QfjRbLZzBx1TkvDT
   D4u2QBBYsZiudI3JPhh6Y/D0yD7E81ycZQ91onTmyH/AVrh26HP2X8Wjk
   rTzrpY3iXJAj6eCT4IPVPjhacphh0ouml52SlLeptKyzH5UvSDyQ15icQ
   4vZfaYh/l5okEj5HNJJG0XI8ofewXw4mFEfTLMX5nYDz3tyEF6gHl7jIs
   BClBcIvq6Ew/gFvgl+WyDAoeqGsO83j3KXtcGa9R9o+d+0SwvX1m2mdXM
   A==;
X-CSE-ConnectionGUID: jmPdRecWTD+odUB0zO3ZPg==
X-CSE-MsgGUID: vqCuaPYCQnGINkltxm2U3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="81000556"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="81000556"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 17:54:31 -0700
X-CSE-ConnectionGUID: /gBBbfbsR+WnoaWBjSxM+w==
X-CSE-MsgGUID: e0NZ6PZLTR6knhPFklUTJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226539875"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 17:54:29 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 16 Apr 2026 17:53:31 -0700
Subject: [PATCH net v2 07/12] ice: fix race condition in TX timestamp ring
 cleanup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-iwl-net-submission-2026-04-14-v2-7-686c33c9828d@intel.com>
References: <20260416-iwl-net-submission-2026-04-14-v2-0-686c33c9828d@intel.com>
In-Reply-To: <20260416-iwl-net-submission-2026-04-14-v2-0-686c33c9828d@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Keita Morisaki <kmta1236@gmail.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Rinitha S <sx.rinitha@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=7991;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=2AmUenNZR1q/tmuWehoTiw4WxtZoeYDMcGuRBBGGgSg=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsyHLYd852gJxN/W0zed/9K6Wsrp2DqtHpNLf/4IznbTY
 o6xeujWUcrCIMbFICumyKLgELLyuvGEMK03znIwc1iZQIYwcHEKwESiGhgZVlVP6urVfPmXa3v/
 0ycSIVvez/LYeyUyx7Vsr83tOQqrfBj+Z5bM/sMwrbB8rcYG1d+VxyuqVl2+XJrK/XfP6XzuNKt
 STgA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-279192-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E7D5415E3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Keita Morisaki <kmta1236@gmail.com>

Fix a race condition between ice_free_tx_tstamp_ring() and ice_tx_map()
that can cause a NULL pointer dereference.

ice_free_tx_tstamp_ring currently clears the ICE_TX_FLAGS_TXTIME flag
after NULLing the tstamp_ring. This could allow a concurrent ice_tx_map
call on another CPU to dereference the tstamp_ring, which could lead to
a NULL pointer dereference.

  CPU A:ice_free_tx_tstamp_ring() | CPU B:ice_tx_map()
  --------------------------------|---------------------------------
  tx_ring->tstamp_ring = NULL     |
                                  | ice_is_txtime_cfg() -> true
                                  | tstamp_ring = tx_ring->tstamp_ring
                                  | tstamp_ring->count  // NULL deref!
  flags &= ~ICE_TX_FLAGS_TXTIME   |

Fix by:
1. Reordering ice_free_tx_tstamp_ring() to clear the flag before
   NULLing the pointer, with smp_wmb() to ensure proper ordering.
2. Adding smp_rmb() in ice_tx_map() after the flag check to order the
   flag read before the pointer read, using READ_ONCE() for the
   pointer, and adding a NULL check as a safety net.
3. Converting tx_ring->flags from u8 to DECLARE_BITMAP() and using
   atomic bitops (set_bit(), clear_bit(), test_bit()) for all flag
   operations throughout the driver:
   - ICE_TX_RING_FLAGS_XDP
   - ICE_TX_RING_FLAGS_VLAN_L2TAG1
   - ICE_TX_RING_FLAGS_VLAN_L2TAG2
   - ICE_TX_RING_FLAGS_TXTIME

Fixes: ccde82e909467 ("ice: add E830 Earliest TxTime First Offload support")
Signed-off-by: Keita Morisaki <kmta1236@gmail.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |  4 ++--
 drivers/net/ethernet/intel/ice/ice_txrx.h    | 16 ++++++++++------
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c     |  4 ++--
 drivers/net/ethernet/intel/ice/ice_txrx.c    | 23 ++++++++++++++++-------
 5 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index eb3a48330cc1..725b130dd3a2 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -753,7 +753,7 @@ static inline bool ice_is_xdp_ena_vsi(struct ice_vsi *vsi)
 
 static inline void ice_set_ring_xdp(struct ice_tx_ring *ring)
 {
-	ring->flags |= ICE_TX_FLAGS_RING_XDP;
+	set_bit(ICE_TX_RING_FLAGS_XDP, ring->flags);
 }
 
 /**
@@ -778,7 +778,7 @@ static inline bool ice_is_txtime_ena(const struct ice_tx_ring *ring)
  */
 static inline bool ice_is_txtime_cfg(const struct ice_tx_ring *ring)
 {
-	return !!(ring->flags & ICE_TX_FLAGS_TXTIME);
+	return test_bit(ICE_TX_RING_FLAGS_TXTIME, ring->flags);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index b6547e1b7c42..5e517f219379 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -212,6 +212,14 @@ enum ice_rx_dtype {
 	ICE_RX_DTYPE_SPLIT_ALWAYS	= 2,
 };
 
+enum ice_tx_ring_flags {
+	ICE_TX_RING_FLAGS_XDP,
+	ICE_TX_RING_FLAGS_VLAN_L2TAG1,
+	ICE_TX_RING_FLAGS_VLAN_L2TAG2,
+	ICE_TX_RING_FLAGS_TXTIME,
+	ICE_TX_RING_FLAGS_NBITS,
+};
+
 struct ice_pkt_ctx {
 	u64 cached_phctime;
 	__be16 vlan_proto;
@@ -352,11 +360,7 @@ struct ice_tx_ring {
 	u16 count;			/* Number of descriptors */
 	u16 q_index;			/* Queue number of ring */
 
-	u8 flags;
-#define ICE_TX_FLAGS_RING_XDP		BIT(0)
-#define ICE_TX_FLAGS_RING_VLAN_L2TAG1	BIT(1)
-#define ICE_TX_FLAGS_RING_VLAN_L2TAG2	BIT(2)
-#define ICE_TX_FLAGS_TXTIME		BIT(3)
+	DECLARE_BITMAP(flags, ICE_TX_RING_FLAGS_NBITS);
 
 	struct xsk_buff_pool *xsk_pool;
 
@@ -398,7 +402,7 @@ static inline bool ice_ring_ch_enabled(struct ice_tx_ring *ring)
 
 static inline bool ice_ring_is_xdp(struct ice_tx_ring *ring)
 {
-	return !!(ring->flags & ICE_TX_FLAGS_RING_XDP);
+	return test_bit(ICE_TX_RING_FLAGS_XDP, ring->flags);
 }
 
 enum ice_container_type {
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index bd77f1c001ee..16aa25535152 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -943,7 +943,7 @@ ice_tx_prepare_vlan_flags_dcb(struct ice_tx_ring *tx_ring,
 		/* if this is not already set it means a VLAN 0 + priority needs
 		 * to be offloaded
 		 */
-		if (tx_ring->flags & ICE_TX_FLAGS_RING_VLAN_L2TAG2)
+		if (test_bit(ICE_TX_RING_FLAGS_VLAN_L2TAG2, tx_ring->flags))
 			first->tx_flags |= ICE_TX_FLAGS_HW_OUTER_SINGLE_VLAN;
 		else
 			first->tx_flags |= ICE_TX_FLAGS_HW_VLAN;
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 689c6025ea82..837b71b7b2b7 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1412,9 +1412,9 @@ static int ice_vsi_alloc_rings(struct ice_vsi *vsi)
 		ring->count = vsi->num_tx_desc;
 		ring->txq_teid = ICE_INVAL_TEID;
 		if (dvm_ena)
-			ring->flags |= ICE_TX_FLAGS_RING_VLAN_L2TAG2;
+			set_bit(ICE_TX_RING_FLAGS_VLAN_L2TAG2, ring->flags);
 		else
-			ring->flags |= ICE_TX_FLAGS_RING_VLAN_L2TAG1;
+			set_bit(ICE_TX_RING_FLAGS_VLAN_L2TAG1, ring->flags);
 		WRITE_ONCE(vsi->tx_rings[i], ring);
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 7be9c062949b..4ca1a0602307 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -190,9 +190,10 @@ void ice_free_tstamp_ring(struct ice_tx_ring *tx_ring)
 void ice_free_tx_tstamp_ring(struct ice_tx_ring *tx_ring)
 {
 	ice_free_tstamp_ring(tx_ring);
+	clear_bit(ICE_TX_RING_FLAGS_TXTIME, tx_ring->flags);
+	smp_wmb();	/* order flag clear before pointer NULL */
 	kfree_rcu(tx_ring->tstamp_ring, rcu);
-	tx_ring->tstamp_ring = NULL;
-	tx_ring->flags &= ~ICE_TX_FLAGS_TXTIME;
+	WRITE_ONCE(tx_ring->tstamp_ring, NULL);
 }
 
 /**
@@ -405,7 +406,7 @@ static int ice_alloc_tstamp_ring(struct ice_tx_ring *tx_ring)
 	tx_ring->tstamp_ring = tstamp_ring;
 	tstamp_ring->desc = NULL;
 	tstamp_ring->count = ice_calc_ts_ring_count(tx_ring);
-	tx_ring->flags |= ICE_TX_FLAGS_TXTIME;
+	set_bit(ICE_TX_RING_FLAGS_TXTIME, tx_ring->flags);
 	return 0;
 }
 
@@ -1521,13 +1522,20 @@ ice_tx_map(struct ice_tx_ring *tx_ring, struct ice_tx_buf *first,
 		return;
 
 	if (ice_is_txtime_cfg(tx_ring)) {
-		struct ice_tstamp_ring *tstamp_ring = tx_ring->tstamp_ring;
-		u32 tstamp_count = tstamp_ring->count;
-		u32 j = tstamp_ring->next_to_use;
+		struct ice_tstamp_ring *tstamp_ring;
+		u32 tstamp_count, j;
 		struct ice_ts_desc *ts_desc;
 		struct timespec64 ts;
 		u32 tstamp;
 
+		smp_rmb();	/* order flag read before pointer read */
+		tstamp_ring = READ_ONCE(tx_ring->tstamp_ring);
+		if (unlikely(!tstamp_ring))
+			goto ring_kick;
+
+		tstamp_count = tstamp_ring->count;
+		j = tstamp_ring->next_to_use;
+
 		ts = ktime_to_timespec64(first->skb->tstamp);
 		tstamp = ts.tv_nsec >> ICE_TXTIME_CTX_RESOLUTION_128NS;
 
@@ -1555,6 +1563,7 @@ ice_tx_map(struct ice_tx_ring *tx_ring, struct ice_tx_buf *first,
 		tstamp_ring->next_to_use = j;
 		writel_relaxed(j, tstamp_ring->tail);
 	} else {
+ring_kick:
 		writel_relaxed(i, tx_ring->tail);
 	}
 	return;
@@ -1814,7 +1823,7 @@ ice_tx_prepare_vlan_flags(struct ice_tx_ring *tx_ring, struct ice_tx_buf *first)
 	 */
 	if (skb_vlan_tag_present(skb)) {
 		first->vid = skb_vlan_tag_get(skb);
-		if (tx_ring->flags & ICE_TX_FLAGS_RING_VLAN_L2TAG2)
+		if (test_bit(ICE_TX_RING_FLAGS_VLAN_L2TAG2, tx_ring->flags))
 			first->tx_flags |= ICE_TX_FLAGS_HW_OUTER_SINGLE_VLAN;
 		else
 			first->tx_flags |= ICE_TX_FLAGS_HW_VLAN;

-- 
2.54.0.rc2.531.gaf818d63126a


