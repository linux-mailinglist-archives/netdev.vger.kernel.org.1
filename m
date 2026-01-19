Return-Path: <netdev+bounces-251175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AD54CD3B006
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 17:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 047E930019C5
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117A2296BD1;
	Mon, 19 Jan 2026 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HY4anZBl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AFB28466D;
	Mon, 19 Jan 2026 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768838940; cv=none; b=snqZ5n0uNlqU5EgzaRsWBru3CTId1x7o8J0u1m7aWHfWLNo9cM/Vxx8idcnLFtpgTqU4+x4XteLATj5G3LDMOICXwIqiLv1pKdXjaAUEwgbUmkA6c2aBkTNN/eTpBM5tUHZJsHbERC1NYLo1XizGYNUDavL2wdfDzMPElSL3HIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768838940; c=relaxed/simple;
	bh=jKLAKNw8LAPiSTNiGlwq3IsykxvTXEyH7GUXFvNYuWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NGOhRzEbJsc+gWxYn/hloG2TksDHw3pP77I5OjKgQuR8lLToltwM1J6l8gpG+ixpbEpeHl1uuxw9dQdCM+wJ1mrdXtf1ZgUSJqfTByw8lWX0uy4sJmKrpO0Q15e7tN8A3UxW7MgzqEYQi1YVtDEPb4zW9ZnbzNXlY9NRDGsPrJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HY4anZBl; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768838939; x=1800374939;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jKLAKNw8LAPiSTNiGlwq3IsykxvTXEyH7GUXFvNYuWQ=;
  b=HY4anZBlKuwCR0zWuEkb+ufzlCF6RVAK6ag60iQ8YVuhDn7M5UOYwnhJ
   8WxwI7A5SRCKDQvFXq3YiZ0WQvwdaVcFXQ6VSCowF/3igFa1xCIdNMJhs
   hDZZ8wm7FMI/1ylVD3y0paMEjk9w5a2Sbf+VviA8AmBd2hsQyCguHcb/E
   SFgUFpxFoF5jcG3OYJbwHKHxbG5I18DwVx88kgOF0tEzAgG+/TmoPo+Nf
   tUwe1HTkrtrIkJGrBgDJVVNvE0J1rbWkKldiCBHBNipnq8haBCs7ahMS0
   JpYG8qb3Au+NBZCnutYIL6t7iqxH8QHFg/4LHA+tw2naussOBIz4rNe7X
   w==;
X-CSE-ConnectionGUID: sSm9a24RRZqp1Qtzu66BDg==
X-CSE-MsgGUID: zCiVwQGMQW+eMOijb5V3Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="70024621"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="70024621"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 08:08:58 -0800
X-CSE-ConnectionGUID: m03z9xo5TwuyW1visJY+Rg==
X-CSE-MsgGUID: TuCpV0m8TISHPxIMvjc67Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="205804943"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa006.fm.intel.com with ESMTP; 19 Jan 2026 08:08:54 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next] ice: reshuffle and group Rx and Tx queue fields by cachelines
Date: Mon, 19 Jan 2026 17:08:43 +0100
Message-ID: <20260119160843.3854173-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Place the fields in ice_{rx,tx}_ring used in the same pieces of
hotpath code closer to each other and use
__cacheline_group_{begin,end}_aligned() to isolate the read mostly,
read-write, and cold groups into separate cachelines similarly
to idpf.

Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
Applies cleanly to today's next-queue.

Testing hints:

No functional changes in this patch, there's no way it could break
anything. If you want, you can test basic XDP actions (PASS, DROP)
and compare the performance before and after the patch.
---
 drivers/net/ethernet/intel/ice/ice_txrx.h     | 122 ++++++++++--------
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   1 -
 drivers/net/ethernet/intel/ice/ice_txrx.c     |   1 -
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |   3 -
 4 files changed, 70 insertions(+), 57 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index e3c682723107..557b5e656bb0 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -267,34 +267,49 @@ struct ice_tstamp_ring {
 } ____cacheline_internodealigned_in_smp;
 
 struct ice_rx_ring {
-	/* CL1 - 1st cacheline starts here */
+	__cacheline_group_begin_aligned(read_mostly);
 	void *desc;			/* Descriptor ring memory */
 	struct page_pool *pp;
 	struct net_device *netdev;	/* netdev ring maps to */
-	struct ice_vsi *vsi;		/* Backreference to associated VSI */
 	struct ice_q_vector *q_vector;	/* Backreference to associated vector */
 	u8 __iomem *tail;
-	u16 q_index;			/* Queue number of ring */
-
-	u16 count;			/* Number of descriptors */
-	u16 reg_idx;			/* HW register index of the ring */
-	u16 next_to_alloc;
 
 	union {
 		struct libeth_fqe *rx_fqes;
 		struct xdp_buff **xdp_buf;
 	};
 
-	/* CL2 - 2nd cacheline starts here */
-	struct libeth_fqe *hdr_fqes;
+	u16 count;			/* Number of descriptors */
+	u8 ptp_rx;
+
+	u8 flags;
+#define ICE_RX_FLAGS_CRC_STRIP_DIS	BIT(2)
+#define ICE_RX_FLAGS_MULTIDEV		BIT(3)
+#define ICE_RX_FLAGS_RING_GCS		BIT(4)
+
+	u32 truesize;
+
 	struct page_pool *hdr_pp;
+	struct libeth_fqe *hdr_fqes;
+
+	struct bpf_prog *xdp_prog;
+	struct ice_tx_ring *xdp_ring;
+	struct xsk_buff_pool *xsk_pool;
+
+	/* stats structs */
+	struct ice_ring_stats *ring_stats;
+	struct ice_rx_ring *next;	/* pointer to next ring in q_vector */
 
+	u32 hdr_truesize;
+
+	struct xdp_rxq_info xdp_rxq;
+	__cacheline_group_end_aligned(read_mostly);
+
+	__cacheline_group_begin_aligned(read_write);
 	union {
 		struct libeth_xdp_buff_stash xdp;
 		struct libeth_xdp_buff *xsk;
 	};
-
-	/* CL3 - 3rd cacheline starts here */
 	union {
 		struct ice_pkt_ctx pkt_ctx;
 		struct {
@@ -302,75 +317,78 @@ struct ice_rx_ring {
 			__be16 vlan_proto;
 		};
 	};
-	struct bpf_prog *xdp_prog;
 
 	/* used in interrupt processing */
 	u16 next_to_use;
 	u16 next_to_clean;
+	__cacheline_group_end_aligned(read_write);
 
-	u32 hdr_truesize;
-	u32 truesize;
-
-	/* stats structs */
-	struct ice_ring_stats *ring_stats;
-
+	__cacheline_group_begin_aligned(cold);
 	struct rcu_head rcu;		/* to avoid race on free */
-	/* CL4 - 4th cacheline starts here */
+	struct ice_vsi *vsi;		/* Backreference to associated VSI */
 	struct ice_channel *ch;
-	struct ice_tx_ring *xdp_ring;
-	struct ice_rx_ring *next;	/* pointer to next ring in q_vector */
-	struct xsk_buff_pool *xsk_pool;
-	u16 rx_hdr_len;
-	u16 rx_buf_len;
+
 	dma_addr_t dma;			/* physical address of ring */
+	u16 q_index;			/* Queue number of ring */
+	u16 reg_idx;			/* HW register index of the ring */
 	u8 dcb_tc;			/* Traffic class of ring */
-	u8 ptp_rx;
-#define ICE_RX_FLAGS_CRC_STRIP_DIS	BIT(2)
-#define ICE_RX_FLAGS_MULTIDEV		BIT(3)
-#define ICE_RX_FLAGS_RING_GCS		BIT(4)
-	u8 flags;
-	/* CL5 - 5th cacheline starts here */
-	struct xdp_rxq_info xdp_rxq;
+
+	u16 rx_hdr_len;
+	u16 rx_buf_len;
+	__cacheline_group_end_aligned(cold);
 } ____cacheline_internodealigned_in_smp;
 
 struct ice_tx_ring {
-	/* CL1 - 1st cacheline starts here */
-	struct ice_tx_ring *next;	/* pointer to next ring in q_vector */
+	__cacheline_group_begin_aligned(read_mostly);
 	void *desc;			/* Descriptor ring memory */
 	struct device *dev;		/* Used for DMA mapping */
 	u8 __iomem *tail;
 	struct ice_tx_buf *tx_buf;
+
 	struct ice_q_vector *q_vector;	/* Backreference to associated vector */
 	struct net_device *netdev;	/* netdev ring maps to */
 	struct ice_vsi *vsi;		/* Backreference to associated VSI */
-	/* CL2 - 2nd cacheline starts here */
-	dma_addr_t dma;			/* physical address of ring */
-	struct xsk_buff_pool *xsk_pool;
-	u16 next_to_use;
-	u16 next_to_clean;
-	u16 q_handle;			/* Queue handle per TC */
-	u16 reg_idx;			/* HW register index of the ring */
+
 	u16 count;			/* Number of descriptors */
 	u16 q_index;			/* Queue number of ring */
-	u16 xdp_tx_active;
+
+	u8 flags;
+#define ICE_TX_FLAGS_RING_XDP		BIT(0)
+#define ICE_TX_FLAGS_RING_VLAN_L2TAG1	BIT(1)
+#define ICE_TX_FLAGS_RING_VLAN_L2TAG2	BIT(2)
+#define ICE_TX_FLAGS_TXTIME		BIT(3)
+
+	struct xsk_buff_pool *xsk_pool;
+
 	/* stats structs */
 	struct ice_ring_stats *ring_stats;
-	/* CL3 - 3rd cacheline starts here */
+	struct ice_tx_ring *next;	/* pointer to next ring in q_vector */
+
+	struct ice_tstamp_ring *tstamp_ring;
+	struct ice_ptp_tx *tx_tstamps;
+	__cacheline_group_end_aligned(read_mostly);
+
+	__cacheline_group_begin_aligned(read_write);
+	u16 next_to_use;
+	u16 next_to_clean;
+
+	u16 xdp_tx_active;
+	spinlock_t tx_lock;
+	__cacheline_group_end_aligned(read_write);
+
+	__cacheline_group_begin_aligned(cold);
 	struct rcu_head rcu;		/* to avoid race on free */
 	DECLARE_BITMAP(xps_state, ICE_TX_NBITS);	/* XPS Config State */
 	struct ice_channel *ch;
-	struct ice_ptp_tx *tx_tstamps;
-	spinlock_t tx_lock;
-	u32 txq_teid;			/* Added Tx queue TEID */
-	/* CL4 - 4th cacheline starts here */
-	struct ice_tstamp_ring *tstamp_ring;
-#define ICE_TX_FLAGS_RING_XDP		BIT(0)
-#define ICE_TX_FLAGS_RING_VLAN_L2TAG1	BIT(1)
-#define ICE_TX_FLAGS_RING_VLAN_L2TAG2	BIT(2)
-#define ICE_TX_FLAGS_TXTIME		BIT(3)
-	u8 flags;
+
+	dma_addr_t dma;			/* physical address of ring */
+	u16 q_handle;			/* Queue handle per TC */
+	u16 reg_idx;			/* HW register index of the ring */
 	u8 dcb_tc;			/* Traffic class of ring */
+
 	u16 quanta_prof_id;
+	u32 txq_teid;			/* Added Tx queue TEID */
+	__cacheline_group_end_aligned(cold);
 } ____cacheline_internodealigned_in_smp;
 
 static inline bool ice_ring_ch_enabled(struct ice_tx_ring *ring)
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 8d8569d06119..4f79dc73a8ad 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3388,7 +3388,6 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 				 */
 				rx_rings[i].next_to_use = 0;
 				rx_rings[i].next_to_clean = 0;
-				rx_rings[i].next_to_alloc = 0;
 				*vsi->rx_rings[i] = rx_rings[i];
 			}
 			kfree(rx_rings);
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index e8e1acbd5a7d..40d7252caee0 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -582,7 +582,6 @@ void ice_zero_rx_ring(struct ice_rx_ring *rx_ring)
 		     PAGE_SIZE);
 	memset(rx_ring->desc, 0, size);
 
-	rx_ring->next_to_alloc = 0;
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index f7006ce5104a..66d211aa0833 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -20,9 +20,6 @@ void ice_release_rx_desc(struct ice_rx_ring *rx_ring, u16 val)
 
 	rx_ring->next_to_use = val;
 
-	/* update next to alloc since we have filled the ring */
-	rx_ring->next_to_alloc = val;
-
 	/* QRX_TAIL will be updated with any tail value, but hardware ignores
 	 * the lower 3 bits. This makes it so we only bump tail on meaningful
 	 * boundaries. Also, this allows us to bump tail on intervals of 8 up to
-- 
2.52.0


