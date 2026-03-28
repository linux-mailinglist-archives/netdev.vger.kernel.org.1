Return-Path: <netdev+bounces-272839-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SL2eKaFfyGmjlAUAu9opvQ
	(envelope-from <netdev+bounces-272839-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 00:09:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42226350379
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 00:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDD7B30528B1
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 23:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905C3373C1E;
	Sat, 28 Mar 2026 23:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="OTAvrCC2"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AAD372ED8;
	Sat, 28 Mar 2026 23:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774739184; cv=none; b=XLnRqw0pLu1Oa3e8MIJEXoC7WQaIWKlGMIOPlSTtj5k2r2trUbHKGvXYvDrmQ548JZJ1Bhk1PM/tBy7MsjLdKgQxLAxC1KWaWpaX2tHuVtAt5+/zS19sY+qVdyAV9cLtJ/K75yRF2emKaDn0eAHPNefOJh4zzaN8EVdXXVa4y9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774739184; c=relaxed/simple;
	bh=Syp+gnDOJk0dwT48w2LlL89AamjrF0yvpW5wtvggP9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofe56LjcyLIGCsAkI+1Jol5jB5k+k4MHyW6ianmtVz0x2KaF6K9pwcR15FKyZuClUTIE6F8aO85AunM5nyAMMgimHyFlQErOGPJvmJgQKDla1FMLeusZoVT5xMEjsKP5NaPIoBSJDRmDL5GK499BL/ov0Xbs+km1ML0bbeuCGl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=OTAvrCC2; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 02B43A5877;
	Sun, 29 Mar 2026 00:06:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1774739180; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=W9QDTMEnHfn6FVVTYhylTdR46J7wyAG/vu+CFK0xvjk=;
	b=OTAvrCC2Q09BNTKS8Nq0j7z/TNX8jHR7D9TWEjXED3LlHrl4BK9C523bWeNS34E85yFcIJ
	TpBYrUci/G2ErSWpuPfaaRRdU84z/0EeIPz9NkVo466Wb8d8JhqW+3zzbhNK9umMB0vr8x
	wruojRCG3qjABy6dRwZskF0eeoOcFWI95s2GlIjT+mtabWMVkpVqlff+G75Z+VzcmPRcGk
	AbFifiraFE9BUTPZaOmQCh/3XX0opx/sy5mFL3xC5dR9elLVu5qoE/YRrNnIXEq/3jweF4
	TVYQr9SI66sLiEUH7U0jhKEQkt5bwPOqCwVwQ1DdWCGrdGPI+OaHeasadfMNvw==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Justin Chen <justin.chen@broadcom.com>,
	Simon Horman <horms@kernel.org>,
	Nicolai Buchwitz <nb@tipi-net.de>,
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
Subject: [PATCH net-next v5 4/6] net: bcmgenet: add XDP_TX support
Date: Sun, 29 Mar 2026 00:05:07 +0100
Message-ID: <20260328230513.415790-5-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260328230513.415790-1-nb@tipi-net.de>
References: <20260328230513.415790-1-nb@tipi-net.de>
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
	TAGGED_FROM(0.00)[bounces-272839-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,tipi-net.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42226350379
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
BPF execution) and zeroing it. For foreign frames redirected from other
devices, the TSB is written into the xdp_frame headroom.

The page_pool DMA direction is changed from DMA_FROM_DEVICE to
DMA_BIDIRECTIONAL to allow TX reuse of the existing DMA mapping.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 224 ++++++++++++++++--
 .../net/ethernet/broadcom/genet/bcmgenet.h    |   3 +
 2 files changed, 205 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index b45ba2c2857e..687c3b12d44f 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -48,8 +48,10 @@
 
 #define GENET_Q0_RX_BD_CNT	\
 	(TOTAL_DESC - priv->hw_params->rx_queues * priv->hw_params->rx_bds_per_q)
+#define GENET_Q16_TX_BD_CNT	32
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
@@ -1925,10 +1935,16 @@ static unsigned int __bcmgenet_tx_reclaim(struct net_device *dev,
 	unsigned int pkts_compl = 0;
 	unsigned int txbds_ready;
 	unsigned int c_index;
+	struct enet_cb *tx_cb;
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
@@ -1941,8 +1957,15 @@ static unsigned int __bcmgenet_tx_reclaim(struct net_device *dev,
 
 	/* Reclaim transmitted buffers */
 	while (txbds_processed < txbds_ready) {
-		skb = bcmgenet_free_tx_cb(&priv->pdev->dev,
-					  &priv->tx_cbs[ring->clean_ptr]);
+		tx_cb = &priv->tx_cbs[ring->clean_ptr];
+		if (tx_cb->xdpf) {
+			pkts_compl++;
+			bytes_compl += tx_cb->xdp_dma_map
+				? tx_cb->xdpf->len
+				: tx_cb->xdpf->len -
+				  sizeof(struct status_64);
+		}
+		skb = bcmgenet_free_tx_cb(&priv->pdev->dev, tx_cb);
 		if (skb) {
 			pkts_compl++;
 			bytes_compl += GENET_CB(skb)->bytes_sent;
@@ -1964,8 +1987,11 @@ static unsigned int __bcmgenet_tx_reclaim(struct net_device *dev,
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
@@ -2042,6 +2068,9 @@ static void bcmgenet_tx_reclaim_all(struct net_device *dev)
 	do {
 		bcmgenet_tx_reclaim(dev, &priv->tx_rings[i++], true);
 	} while (i <= priv->hw_params->tx_queues && netif_is_multiqueue(dev));
+
+	/* Also reclaim XDP TX ring */
+	bcmgenet_tx_reclaim(dev, &priv->xdp_tx_ring, true);
 }
 
 /* Reallocate the SKB to put enough headroom in front of it and insert
@@ -2299,11 +2328,96 @@ static struct sk_buff *bcmgenet_xdp_build_skb(struct bcmgenet_rx_ring *ring,
 	return skb;
 }
 
+static bool bcmgenet_xdp_xmit_frame(struct bcmgenet_priv *priv,
+				     struct xdp_frame *xdpf, bool dma_map)
+{
+	struct bcmgenet_tx_ring *ring = &priv->xdp_tx_ring;
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
 static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
 				     struct bpf_prog *prog,
 				     struct xdp_buff *xdp,
 				     struct page *rx_page)
 {
+	struct bcmgenet_priv *priv = ring->priv;
+	struct xdp_frame *xdpf;
 	unsigned int act;
 
 	act = bpf_prog_run_xdp(prog, xdp);
@@ -2311,14 +2425,42 @@ static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
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
+		if (xdp->data - xdp->data_hard_start <
+		    sizeof(struct status_64)) {
+			page_pool_put_full_page(ring->page_pool, rx_page,
+						true);
+			return XDP_DROP;
+		}
+		xdp->data -= sizeof(struct status_64);
+		xdp->data_meta -= sizeof(struct status_64);
+		memset(xdp->data, 0, sizeof(struct status_64));
+
+		xdpf = xdp_convert_buff_to_frame(xdp);
+		if (unlikely(!xdpf)) {
+			page_pool_put_full_page(ring->page_pool, rx_page,
+						true);
+			return XDP_DROP;
+		}
+		if (unlikely(!bcmgenet_xdp_xmit_frame(priv, xdpf, false))) {
+			xdp_return_frame_rx_napi(xdpf);
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
@@ -2556,9 +2698,15 @@ static int bcmgenet_rx_poll(struct napi_struct *napi, int budget)
 {
 	struct bcmgenet_rx_ring *ring = container_of(napi,
 			struct bcmgenet_rx_ring, napi);
+	struct bcmgenet_priv *priv = ring->priv;
 	struct dim_sample dim_sample = {};
 	unsigned int work_done;
 
+	/* Reclaim completed XDP TX frames (ring 16 has no interrupt) */
+	if (priv->xdp_prog)
+		bcmgenet_tx_reclaim(priv->dev,
+				    &priv->xdp_tx_ring, false);
+
 	work_done = bcmgenet_desc_rx(ring, budget);
 
 	if (work_done < budget && napi_complete_done(napi, work_done))
@@ -2789,10 +2937,11 @@ static void bcmgenet_init_rx_coalesce(struct bcmgenet_rx_ring *ring)
 
 /* Initialize a Tx ring along with corresponding hardware registers */
 static void bcmgenet_init_tx_ring(struct bcmgenet_priv *priv,
+				  struct bcmgenet_tx_ring *ring,
 				  unsigned int index, unsigned int size,
-				  unsigned int start_ptr, unsigned int end_ptr)
+				  unsigned int start_ptr,
+				  unsigned int end_ptr)
 {
-	struct bcmgenet_tx_ring *ring = &priv->tx_rings[index];
 	u32 words_per_bd = WORDS_PER_BD(priv);
 	u32 flow_period_val = 0;
 
@@ -2833,8 +2982,11 @@ static void bcmgenet_init_tx_ring(struct bcmgenet_priv *priv,
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
@@ -2846,7 +2998,7 @@ static int bcmgenet_rx_ring_create_pool(struct bcmgenet_priv *priv,
 		.pool_size = ring->size,
 		.nid = NUMA_NO_NODE,
 		.dev = &priv->pdev->dev,
-		.dma_dir = DMA_FROM_DEVICE,
+		.dma_dir = DMA_BIDIRECTIONAL,
 		.offset = GENET_XDP_HEADROOM,
 		.max_len = RX_BUF_LENGTH,
 	};
@@ -2980,6 +3132,7 @@ static int bcmgenet_tdma_disable(struct bcmgenet_priv *priv)
 
 	reg = bcmgenet_tdma_readl(priv, DMA_CTRL);
 	mask = (1 << (priv->hw_params->tx_queues + 1)) - 1;
+	mask |= BIT(DESC_INDEX);
 	mask = (mask << DMA_RING_BUF_EN_SHIFT) | DMA_EN;
 	reg &= ~mask;
 	bcmgenet_tdma_writel(priv, reg, DMA_CTRL);
@@ -3025,14 +3178,18 @@ static int bcmgenet_rdma_disable(struct bcmgenet_priv *priv)
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
+ * - Tx queue 16 uses tx_cbs[224..255]
  */
 static void bcmgenet_init_tx_queues(struct net_device *dev)
 {
@@ -3045,7 +3202,8 @@ static void bcmgenet_init_tx_queues(struct net_device *dev)
 
 	/* Initialize Tx priority queues */
 	for (i = 0; i <= priv->hw_params->tx_queues; i++) {
-		bcmgenet_init_tx_ring(priv, i, end - start, start, end);
+		bcmgenet_init_tx_ring(priv, &priv->tx_rings[i],
+				      i, end - start, start, end);
 		start = end;
 		end += priv->hw_params->tx_bds_per_q;
 		dma_priority[DMA_PRIO_REG_INDEX(i)] |=
@@ -3053,13 +3211,19 @@ static void bcmgenet_init_tx_queues(struct net_device *dev)
 			<< DMA_PRIO_REG_SHIFT(i);
 	}
 
+	/* Initialize ring 16 (descriptor ring) for XDP TX */
+	bcmgenet_init_tx_ring(priv, &priv->xdp_tx_ring,
+			      DESC_INDEX, GENET_Q16_TX_BD_CNT,
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
@@ -3773,6 +3937,21 @@ static void bcmgenet_get_stats64(struct net_device *dev,
 		stats->tx_dropped += tx_dropped;
 	}
 
+	/* Include XDP TX ring (DESC_INDEX) stats */
+	tx_stats = &priv->xdp_tx_ring.stats64;
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
@@ -4278,6 +4457,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
 		u64_stats_init(&priv->rx_rings[i].stats64.syncp);
 	for (i = 0; i <= priv->hw_params->tx_queues; i++)
 		u64_stats_init(&priv->tx_rings[i].stats64.syncp);
+	u64_stats_init(&priv->xdp_tx_ring.stats64.syncp);
 
 	/* libphy will determine the link state */
 	netif_carrier_off(dev);
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 1459473ac1b0..8966d32efe2f 100644
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
@@ -611,6 +613,7 @@ struct bcmgenet_priv {
 	unsigned int num_tx_bds;
 
 	struct bcmgenet_tx_ring tx_rings[GENET_MAX_MQ_CNT + 1];
+	struct bcmgenet_tx_ring xdp_tx_ring;
 
 	/* receive variables */
 	void __iomem *rx_bds;
-- 
2.51.0


