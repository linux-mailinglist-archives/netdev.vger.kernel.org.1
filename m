Return-Path: <netdev+bounces-269425-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBhLB83ku2njpQIAu9opvQ
	(envelope-from <netdev+bounces-269425-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:58:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BD32CABE6
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3BF0314C8D8
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 11:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BD23CD8D9;
	Thu, 19 Mar 2026 11:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="fJeHY+2B"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B871F3C9EE8;
	Thu, 19 Mar 2026 11:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921300; cv=none; b=H//BbhzVDLdKmgWsN4OnML1qRE1uGzdPD3QTFBLpJtZAu12VXnCG3OklUvpENDBX8h9z8lzvfdEo+ABu9oDPiUTimPaHIxILEnhr3EBqp3K0IntWK8YIU7L+oJWXPOygmPcOq2KwNYDUMkYIFTK8BtYIPbvQ711uH0jwuVmSVDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921300; c=relaxed/simple;
	bh=q5iRWM26r0htqgbgcEh36cqYhYDLXxu6cGzEnPYdkR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVRU0yP45ujcUvEMn0zZ/T4BWgFM7lFbk9jhHfYQ7JLoa1GEg2q1D/jWxdHEp34JtDIIMh2jYW/09DIDfIXbXa9rvEp8mm5MRAjP02Hz1hJJ3lG1bet8EFmdAlC+Jew0gSIS39i/ddUy5o5qLdl91EefzcuAH9soEtqHyKH0Z+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=fJeHY+2B; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 27840A57F6;
	Thu, 19 Mar 2026 12:54:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1773921291; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=TBPo8fFRhHPr3sY1sd1czx8Aihd2SH8DueSu2Jwci4E=;
	b=fJeHY+2B6MR817YWReBGwyvJDxKGk2VXTyWfzfsVTKgEs4hqNwMwy6AIONPAm5QmkCRp5y
	VLwm9ytKVluPqY1l/KQf2NIh7WRIykPrTXq6Mp1RWECUZVsJqnIy8RsB7okSVj4/e59IE7
	hbtQ2kBowRuC08BLEu9676mK/zJZxcdRulHCuJSsoMvsBRRO7fctllwCuhzshcfLivgWXE
	+46Oo1VDgyCmvS9dchAs3UC169jQRTOD9g1WS6EYRnccdPbXQurondeSoxdnPkRAQopO62
	4xoCRuRug06x8t6DzYM32Mx/7mxwkxVGYlVmudvmkwej/0UV1y+SEsP0VW6QPA==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Nicolai Buchwitz <nb@tipi-net.de>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v3 4/6] net: bcmgenet: add XDP_TX support
Date: Thu, 19 Mar 2026 12:53:57 +0100
Message-ID: <20260319115402.353509-5-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319115402.353509-1-nb@tipi-net.de>
References: <20260319115402.353509-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269425-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[tipi-net.de,gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,fomichev.me,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.975];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid]
X-Rspamd-Queue-Id: B0BD32CABE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement XDP_TX using ring 16 (DESC_INDEX), the hardware default
descriptor ring, dedicated to XDP TX for isolation from SKB TX queues.

Ring 16 gets 32 BDs carved from ring 0's allocation. TX completion is
piggybacked on RX NAPI poll since ring 16's INTRL2_1 bit collides with
RX ring 0, similar to how bnxt, ice, and other XDP drivers handle TX
completion within the RX poll path.

The GENET MAC has TBUF_64B_EN set globally, requiring every TX buffer
to start with a 64-byte struct status_64 (TSB). For local XDP_TX, the
TSB is prepended by backing xdp->data into the RSB area (unused after
BPF execution) and zeroing it. For foreign frames (ndo_xdp_xmit), the
TSB is written into the xdp_frame headroom.

The page_pool DMA direction is changed from DMA_FROM_DEVICE to
DMA_BIDIRECTIONAL to allow TX reuse of the existing DMA mapping.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 195 ++++++++++++++++--
 .../net/ethernet/broadcom/genet/bcmgenet.h    |   4 +-
 2 files changed, 181 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index e8f90d6b16a2..54df1694f1cd 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -48,8 +48,10 @@
 
 #define GENET_Q0_RX_BD_CNT	\
 	(TOTAL_DESC - priv->hw_params->rx_queues * priv->hw_params->rx_bds_per_q)
+#define GENET_Q16_TX_BD_CNT	64
 #define GENET_Q0_TX_BD_CNT	\
-	(TOTAL_DESC - priv->hw_params->tx_queues * priv->hw_params->tx_bds_per_q)
+	(TOTAL_DESC - priv->hw_params->tx_queues * priv->hw_params->tx_bds_per_q \
+	 - GENET_Q16_TX_BD_CNT)
 
 #define RX_BUF_LENGTH		2048
 #define SKB_ALIGNMENT		32
@@ -1893,6 +1895,14 @@ static struct sk_buff *bcmgenet_free_tx_cb(struct device *dev,
 		if (cb == GENET_CB(skb)->last_cb)
 			return skb;
 
+	} else if (cb->xdpf) {
+		if (cb->xdp_dma_map)
+			dma_unmap_single(dev, dma_unmap_addr(cb, dma_addr),
+					 dma_unmap_len(cb, dma_len),
+					 DMA_TO_DEVICE);
+		dma_unmap_addr_set(cb, dma_addr, 0);
+		xdp_return_frame(cb->xdpf);
+		cb->xdpf = NULL;
 	} else if (dma_unmap_addr(cb, dma_addr)) {
 		dma_unmap_page(dev,
 			       dma_unmap_addr(cb, dma_addr),
@@ -1927,8 +1937,13 @@ static unsigned int __bcmgenet_tx_reclaim(struct net_device *dev,
 	unsigned int c_index;
 	struct sk_buff *skb;
 
-	/* Clear status before servicing to reduce spurious interrupts */
-	bcmgenet_intrl2_1_writel(priv, (1 << ring->index), INTRL2_CPU_CLEAR);
+	/* Clear status before servicing to reduce spurious interrupts.
+	 * Ring DESC_INDEX (XDP TX) has no interrupt; skip the clear to
+	 * avoid clobbering RX ring 0's bit at the same position.
+	 */
+	if (ring->index != DESC_INDEX)
+		bcmgenet_intrl2_1_writel(priv, BIT(ring->index),
+					 INTRL2_CPU_CLEAR);
 
 	/* Compute how many buffers are transmitted since last xmit call */
 	c_index = bcmgenet_tdma_ring_readl(priv, ring->index, TDMA_CONS_INDEX)
@@ -1964,8 +1979,11 @@ static unsigned int __bcmgenet_tx_reclaim(struct net_device *dev,
 	u64_stats_add(&stats->bytes, bytes_compl);
 	u64_stats_update_end(&stats->syncp);
 
-	netdev_tx_completed_queue(netdev_get_tx_queue(dev, ring->index),
-				  pkts_compl, bytes_compl);
+	/* Ring DESC_INDEX (XDP TX) has no netdev TX queue; skip BQL */
+	if (ring->index != DESC_INDEX)
+		netdev_tx_completed_queue(netdev_get_tx_queue(dev,
+							      ring->index),
+					  pkts_compl, bytes_compl);
 
 	return txbds_processed;
 }
@@ -2042,6 +2060,9 @@ static void bcmgenet_tx_reclaim_all(struct net_device *dev)
 	do {
 		bcmgenet_tx_reclaim(dev, &priv->tx_rings[i++], true);
 	} while (i <= priv->hw_params->tx_queues && netif_is_multiqueue(dev));
+
+	/* Also reclaim XDP TX ring */
+	bcmgenet_tx_reclaim(dev, &priv->tx_rings[DESC_INDEX], true);
 }
 
 /* Reallocate the SKB to put enough headroom in front of it and insert
@@ -2299,10 +2320,96 @@ static struct sk_buff *bcmgenet_xdp_build_skb(struct bcmgenet_rx_ring *ring,
 	return skb;
 }
 
+static bool
+bcmgenet_xdp_xmit_frame(struct bcmgenet_priv *priv,
+			struct xdp_frame *xdpf, bool dma_map)
+{
+	struct bcmgenet_tx_ring *ring = &priv->tx_rings[DESC_INDEX];
+	struct device *kdev = &priv->pdev->dev;
+	struct enet_cb *tx_cb_ptr;
+	dma_addr_t mapping;
+	unsigned int dma_len;
+	u32 len_stat;
+
+	spin_lock(&ring->lock);
+
+	if (ring->free_bds < 1) {
+		spin_unlock(&ring->lock);
+		return false;
+	}
+
+	tx_cb_ptr = bcmgenet_get_txcb(priv, ring);
+
+	if (dma_map) {
+		void *tsb_start;
+
+		/* The GENET MAC has TBUF_64B_EN set globally, so hardware
+		 * expects a 64-byte TSB prefix on every TX buffer.  For
+		 * redirected frames (ndo_xdp_xmit) we prepend a zeroed TSB
+		 * using the frame's headroom.
+		 */
+		if (unlikely(xdpf->headroom < sizeof(struct status_64))) {
+			bcmgenet_put_txcb(priv, ring);
+			spin_unlock(&ring->lock);
+			return false;
+		}
+
+		tsb_start = xdpf->data - sizeof(struct status_64);
+		memset(tsb_start, 0, sizeof(struct status_64));
+
+		dma_len = xdpf->len + sizeof(struct status_64);
+		mapping = dma_map_single(kdev, tsb_start, dma_len,
+					 DMA_TO_DEVICE);
+		if (dma_mapping_error(kdev, mapping)) {
+			tx_cb_ptr->skb = NULL;
+			tx_cb_ptr->xdpf = NULL;
+			bcmgenet_put_txcb(priv, ring);
+			spin_unlock(&ring->lock);
+			return false;
+		}
+	} else {
+		struct page *page = virt_to_page(xdpf->data);
+
+		/* For local XDP_TX the caller already prepended the TSB
+		 * into xdpf->data/len, so dma_len == xdpf->len.
+		 */
+		dma_len = xdpf->len;
+		mapping = page_pool_get_dma_addr(page) +
+			  sizeof(*xdpf) + xdpf->headroom;
+		dma_sync_single_for_device(kdev, mapping, dma_len,
+					   DMA_BIDIRECTIONAL);
+	}
+
+	dma_unmap_addr_set(tx_cb_ptr, dma_addr, mapping);
+	dma_unmap_len_set(tx_cb_ptr, dma_len, dma_len);
+	tx_cb_ptr->skb = NULL;
+	tx_cb_ptr->xdpf = xdpf;
+	tx_cb_ptr->xdp_dma_map = dma_map;
+
+	len_stat = (dma_len << DMA_BUFLENGTH_SHIFT) |
+		   (priv->hw_params->qtag_mask << DMA_TX_QTAG_SHIFT) |
+		   DMA_TX_APPEND_CRC | DMA_SOP | DMA_EOP;
+
+	dmadesc_set(priv, tx_cb_ptr->bd_addr, mapping, len_stat);
+
+	ring->free_bds--;
+	ring->prod_index++;
+	ring->prod_index &= DMA_P_INDEX_MASK;
+
+	bcmgenet_tdma_ring_writel(priv, ring->index, ring->prod_index,
+				  TDMA_PROD_INDEX);
+
+	spin_unlock(&ring->lock);
+
+	return true;
+}
+
 static unsigned int
 bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring, struct bpf_prog *prog,
 		 struct xdp_buff *xdp, struct page *rx_page)
 {
+	struct bcmgenet_priv *priv = ring->priv;
+	struct xdp_frame *xdpf;
 	unsigned int act;
 
 	act = bpf_prog_run_xdp(prog, xdp);
@@ -2310,14 +2417,33 @@ bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring, struct bpf_prog *prog,
 	switch (act) {
 	case XDP_PASS:
 		return XDP_PASS;
+	case XDP_TX:
+		/* Prepend a zeroed TSB (Transmit Status Block).  The GENET
+		 * MAC has TBUF_64B_EN set globally, so hardware expects every
+		 * TX buffer to begin with a 64-byte struct status_64.  Back
+		 * up xdp->data into the RSB area (which is no longer needed
+		 * after the BPF program ran) and zero it.
+		 */
+		xdp->data -= sizeof(struct status_64);
+		xdp->data_meta -= sizeof(struct status_64);
+		memset(xdp->data, 0, sizeof(struct status_64));
+
+		xdpf = xdp_convert_buff_to_frame(xdp);
+		if (unlikely(!xdpf) ||
+		    unlikely(!bcmgenet_xdp_xmit_frame(priv, xdpf, false))) {
+			page_pool_put_full_page(ring->page_pool, rx_page,
+						true);
+			return XDP_DROP;
+		}
+		return XDP_TX;
 	case XDP_DROP:
 		page_pool_put_full_page(ring->page_pool, rx_page, true);
 		return XDP_DROP;
 	default:
-		bpf_warn_invalid_xdp_action(ring->priv->dev, prog, act);
+		bpf_warn_invalid_xdp_action(priv->dev, prog, act);
 		fallthrough;
 	case XDP_ABORTED:
-		trace_xdp_exception(ring->priv->dev, prog, act);
+		trace_xdp_exception(priv->dev, prog, act);
 		page_pool_put_full_page(ring->page_pool, rx_page, true);
 		return XDP_ABORTED;
 	}
@@ -2555,9 +2681,15 @@ static int bcmgenet_rx_poll(struct napi_struct *napi, int budget)
 {
 	struct bcmgenet_rx_ring *ring = container_of(napi,
 			struct bcmgenet_rx_ring, napi);
+	struct bcmgenet_priv *priv = ring->priv;
 	struct dim_sample dim_sample = {};
 	unsigned int work_done;
 
+	/* Reclaim completed XDP TX frames (ring 16 has no interrupt) */
+	if (priv->xdp_prog)
+		bcmgenet_tx_reclaim(priv->dev,
+				    &priv->tx_rings[DESC_INDEX], false);
+
 	work_done = bcmgenet_desc_rx(ring, budget);
 
 	if (work_done < budget && napi_complete_done(napi, work_done))
@@ -2832,8 +2964,11 @@ static void bcmgenet_init_tx_ring(struct bcmgenet_priv *priv,
 	bcmgenet_tdma_ring_writel(priv, index, end_ptr * words_per_bd - 1,
 				  DMA_END_ADDR);
 
-	/* Initialize Tx NAPI */
-	netif_napi_add_tx(priv->dev, &ring->napi, bcmgenet_tx_poll);
+	/* Initialize Tx NAPI for priority queues only; ring DESC_INDEX
+	 * (XDP TX) has its completions handled inline in RX NAPI.
+	 */
+	if (index != DESC_INDEX)
+		netif_napi_add_tx(priv->dev, &ring->napi, bcmgenet_tx_poll);
 }
 
 static int bcmgenet_rx_ring_create_pool(struct bcmgenet_priv *priv,
@@ -2845,7 +2980,7 @@ static int bcmgenet_rx_ring_create_pool(struct bcmgenet_priv *priv,
 		.pool_size = ring->size,
 		.nid = NUMA_NO_NODE,
 		.dev = &priv->pdev->dev,
-		.dma_dir = DMA_FROM_DEVICE,
+		.dma_dir = DMA_BIDIRECTIONAL,
 		.offset = GENET_XDP_HEADROOM,
 		.max_len = RX_BUF_LENGTH,
 	};
@@ -2977,6 +3112,7 @@ static int bcmgenet_tdma_disable(struct bcmgenet_priv *priv)
 
 	reg = bcmgenet_tdma_readl(priv, DMA_CTRL);
 	mask = (1 << (priv->hw_params->tx_queues + 1)) - 1;
+	mask |= BIT(DESC_INDEX);
 	mask = (mask << DMA_RING_BUF_EN_SHIFT) | DMA_EN;
 	reg &= ~mask;
 	bcmgenet_tdma_writel(priv, reg, DMA_CTRL);
@@ -3022,14 +3158,18 @@ static int bcmgenet_rdma_disable(struct bcmgenet_priv *priv)
  * with queue 1 being the highest priority queue.
  *
  * Queue 0 is the default Tx queue with
- * GENET_Q0_TX_BD_CNT = 256 - 4 * 32 = 128 descriptors.
+ * GENET_Q0_TX_BD_CNT = 256 - 4 * 32 - 32 = 96 descriptors.
+ *
+ * Ring 16 (DESC_INDEX) is used for XDP TX with
+ * GENET_Q16_TX_BD_CNT = 32 descriptors.
  *
  * The transmit control block pool is then partitioned as follows:
- * - Tx queue 0 uses tx_cbs[0..127]
- * - Tx queue 1 uses tx_cbs[128..159]
- * - Tx queue 2 uses tx_cbs[160..191]
- * - Tx queue 3 uses tx_cbs[192..223]
- * - Tx queue 4 uses tx_cbs[224..255]
+ * - Tx queue 0 uses tx_cbs[0..95]
+ * - Tx queue 1 uses tx_cbs[96..127]
+ * - Tx queue 2 uses tx_cbs[128..159]
+ * - Tx queue 3 uses tx_cbs[160..191]
+ * - Tx queue 4 uses tx_cbs[192..223]
+ * - Tx ring 16 uses tx_cbs[224..255]
  */
 static void bcmgenet_init_tx_queues(struct net_device *dev)
 {
@@ -3050,13 +3190,18 @@ static void bcmgenet_init_tx_queues(struct net_device *dev)
 			<< DMA_PRIO_REG_SHIFT(i);
 	}
 
+	/* Initialize ring 16 (descriptor ring) for XDP TX */
+	bcmgenet_init_tx_ring(priv, DESC_INDEX, GENET_Q16_TX_BD_CNT,
+			      TOTAL_DESC - GENET_Q16_TX_BD_CNT, TOTAL_DESC);
+
 	/* Set Tx queue priorities */
 	bcmgenet_tdma_writel(priv, dma_priority[0], DMA_PRIORITY_0);
 	bcmgenet_tdma_writel(priv, dma_priority[1], DMA_PRIORITY_1);
 	bcmgenet_tdma_writel(priv, dma_priority[2], DMA_PRIORITY_2);
 
-	/* Configure Tx queues as descriptor rings */
+	/* Configure Tx queues as descriptor rings, including ring 16 */
 	ring_mask = (1 << (priv->hw_params->tx_queues + 1)) - 1;
+	ring_mask |= BIT(DESC_INDEX);
 	bcmgenet_tdma_writel(priv, ring_mask, DMA_RING_CFG);
 
 	/* Enable Tx rings */
@@ -3770,6 +3915,21 @@ static void bcmgenet_get_stats64(struct net_device *dev,
 		stats->tx_dropped += tx_dropped;
 	}
 
+	/* Include XDP TX ring (DESC_INDEX) stats */
+	tx_stats = &priv->tx_rings[DESC_INDEX].stats64;
+	do {
+		start = u64_stats_fetch_begin(&tx_stats->syncp);
+		tx_bytes = u64_stats_read(&tx_stats->bytes);
+		tx_packets = u64_stats_read(&tx_stats->packets);
+		tx_errors = u64_stats_read(&tx_stats->errors);
+		tx_dropped = u64_stats_read(&tx_stats->dropped);
+	} while (u64_stats_fetch_retry(&tx_stats->syncp, start));
+
+	stats->tx_bytes += tx_bytes;
+	stats->tx_packets += tx_packets;
+	stats->tx_errors += tx_errors;
+	stats->tx_dropped += tx_dropped;
+
 	for (q = 0; q <= priv->hw_params->rx_queues; q++) {
 		rx_stats = &priv->rx_rings[q].stats64;
 		do {
@@ -4273,6 +4433,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
 		u64_stats_init(&priv->rx_rings[i].stats64.syncp);
 	for (i = 0; i <= priv->hw_params->tx_queues; i++)
 		u64_stats_init(&priv->tx_rings[i].stats64.syncp);
+	u64_stats_init(&priv->tx_rings[DESC_INDEX].stats64.syncp);
 
 	/* libphy will determine the link state */
 	netif_carrier_off(dev);
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 1459473ac1b0..fce598c29a96 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -472,6 +472,8 @@ struct bcmgenet_rx_stats64 {
 
 struct enet_cb {
 	struct sk_buff      *skb;
+	struct xdp_frame    *xdpf;
+	bool                xdp_dma_map;
 	struct page         *rx_page;
 	unsigned int        rx_page_offset;
 	void __iomem *bd_addr;
@@ -610,7 +612,7 @@ struct bcmgenet_priv {
 	struct enet_cb *tx_cbs;
 	unsigned int num_tx_bds;
 
-	struct bcmgenet_tx_ring tx_rings[GENET_MAX_MQ_CNT + 1];
+	struct bcmgenet_tx_ring tx_rings[DESC_INDEX + 1];
 
 	/* receive variables */
 	void __iomem *rx_bds;
-- 
2.51.0


