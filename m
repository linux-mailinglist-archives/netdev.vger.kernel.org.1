Return-Path: <netdev+bounces-267970-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFIiFgYqt2kLNQEAu9opvQ
	(envelope-from <netdev+bounces-267970-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 22:52:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3482292B95
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 22:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0DF93083034
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 21:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E5F37D131;
	Sun, 15 Mar 2026 21:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="fWmBMz+I"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB0137AA6F;
	Sun, 15 Mar 2026 21:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773611409; cv=none; b=Eqy+0U/ORJGh4BTgDMFiMbvQRdrQ6/7TAhxZZCj4g0MVNet3DSGxNLuUv49adP7J/5PD6AhTeqbQVd0NV8kUh5baVfMMntTCEk2xMNWmDdLPtbzk8ThTuxEoVNLzmR8beBwp9L4/2abjKgqxNqU/o/djHB1ka2zWYPr7K0Weqt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773611409; c=relaxed/simple;
	bh=1SaRQsAs6AsmEauiwUfVsXSX4Z++Q74EMJhzZndsZnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQMNJ3CjHiAkS62XyeOiujNJFFyBE4HBqbVBupv+GQh2WRjw0dpmCfz2/4Lqk/CQ51DVNZV9ZQQu3wiJW5tzSdVfzNf6zlDPaJA1FTo63Sgoza+7YVInjfZQcDFqgmuRgYIc3t1QJe1M4En+50aSrf4wFGu/rHyiH2tJOVdHer4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=fWmBMz+I; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F21ADA56FC;
	Sun, 15 Mar 2026 22:49:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1773611398; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=yKakVXrvFu5zd8knKYT6mpq6EoG49IT8UCNhqgyfI2Y=;
	b=fWmBMz+IMt+0AlWYXPBFfHTimgFy4/31h6a8CV0gVTchnidpipX87sndhslNJLpGztq1z0
	hToSTF38SkxJNM6b1tfTQW+NHWVlu0uf0i0I5/OOk5DzTNgvZ6pN59WLSnYDksY9S+jXh3
	lkUfNSsQycHwGbI83o1ZutZ9rkjRzN8os+RM1kBv6pqWebq6azwcfWy7kDCRCg4ccecZdN
	vP6iprkJ2sF/O8EdcUS0lw7lgcvUcfdACzB5FWO+cPmHb7sR3ld+bRl1/kd5898vRSI66C
	qDWoj7/zA4Kc4qBnUpxR5fhF3GrNGSpyA5p9IZk3LnjanEgoIIsdCSWHEHGS6Q==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	=?UTF-8?q?Markus=20Bl=C3=B6chl?= <mbloch@rooftopnetworks.de>,
	Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v2 1/6] net: bcmgenet: convert RX path to page_pool
Date: Sun, 15 Mar 2026 22:49:09 +0100
Message-ID: <20260315214914.1555777-2-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260315214914.1555777-1-nb@tipi-net.de>
References: <20260315214914.1555777-1-nb@tipi-net.de>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[tipi-net.de];
	TAGGED_FROM(0.00)[bounces-267970-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,broadcom.com];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,gmail.com,rooftopnetworks.de,arndb.de,vger.kernel.org,tipi-net.de];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid]
X-Rspamd-Queue-Id: D3482292B95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace the per-packet __netdev_alloc_skb() + dma_map_single() in the
RX path with page_pool, which provides efficient page recycling and
DMA mapping management. This is a prerequisite for XDP support (which
requires stable page-backed buffers rather than SKB linear data).

Key changes:
- Create a page_pool per RX ring (PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV)
- bcmgenet_rx_refill() allocates pages via page_pool_alloc_pages()
- bcmgenet_desc_rx() builds SKBs from pages via napi_build_skb() with
  skb_mark_for_recycle() for automatic page_pool return
- Buffer layout reserves XDP_PACKET_HEADROOM (256 bytes) before the HW
  RSB (64 bytes) + alignment pad (2 bytes) for future XDP headroom

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/Kconfig         |   1 +
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 213 +++++++++++-------
 .../net/ethernet/broadcom/genet/bcmgenet.h    |   4 +
 3 files changed, 141 insertions(+), 77 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet/broadcom/Kconfig
index cd7dddeb91dd..e3b9a5272406 100644
--- a/drivers/net/ethernet/broadcom/Kconfig
+++ b/drivers/net/ethernet/broadcom/Kconfig
@@ -78,6 +78,7 @@ config BCMGENET
 	select BCM7XXX_PHY
 	select MDIO_BCM_UNIMAC
 	select DIMLIB
+	select PAGE_POOL
 	select BROADCOM_PHY if ARCH_BCM2835
 	help
 	  This driver supports the built-in Ethernet MACs found in the
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 482a31e7b72b..7410034d9bdc 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -52,6 +52,14 @@
 #define RX_BUF_LENGTH		2048
 #define SKB_ALIGNMENT		32
 
+/* Page pool RX buffer layout:
+ * XDP_PACKET_HEADROOM | RSB(64) + pad(2) | frame data | skb_shared_info
+ * The HW writes the 64B RSB + 2B alignment padding before the frame.
+ */
+#define GENET_XDP_HEADROOM	XDP_PACKET_HEADROOM
+#define GENET_RSB_PAD		(sizeof(struct status_64) + 2)
+#define GENET_RX_HEADROOM	(GENET_XDP_HEADROOM + GENET_RSB_PAD)
+
 /* Tx/Rx DMA register offset, skip 256 descriptors */
 #define WORDS_PER_BD(p)		(p->hw_params->words_per_bd)
 #define DMA_DESC_SIZE		(WORDS_PER_BD(priv) * sizeof(u32))
@@ -1895,21 +1903,13 @@ static struct sk_buff *bcmgenet_free_tx_cb(struct device *dev,
 }
 
 /* Simple helper to free a receive control block's resources */
-static struct sk_buff *bcmgenet_free_rx_cb(struct device *dev,
-					   struct enet_cb *cb)
+static void bcmgenet_free_rx_cb(struct enet_cb *cb,
+				struct page_pool *pool)
 {
-	struct sk_buff *skb;
-
-	skb = cb->skb;
-	cb->skb = NULL;
-
-	if (dma_unmap_addr(cb, dma_addr)) {
-		dma_unmap_single(dev, dma_unmap_addr(cb, dma_addr),
-				 dma_unmap_len(cb, dma_len), DMA_FROM_DEVICE);
-		dma_unmap_addr_set(cb, dma_addr, 0);
+	if (cb->rx_page) {
+		page_pool_put_full_page(pool, cb->rx_page, false);
+		cb->rx_page = NULL;
 	}
-
-	return skb;
 }
 
 /* Unlocked version of the reclaim routine */
@@ -2248,46 +2248,30 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 	goto out;
 }
 
-static struct sk_buff *bcmgenet_rx_refill(struct bcmgenet_priv *priv,
-					  struct enet_cb *cb)
+static int bcmgenet_rx_refill(struct bcmgenet_rx_ring *ring,
+			      struct enet_cb *cb)
 {
-	struct device *kdev = &priv->pdev->dev;
-	struct sk_buff *skb;
-	struct sk_buff *rx_skb;
+	struct bcmgenet_priv *priv = ring->priv;
 	dma_addr_t mapping;
+	struct page *page;
 
-	/* Allocate a new Rx skb */
-	skb = __netdev_alloc_skb(priv->dev, priv->rx_buf_len + SKB_ALIGNMENT,
-				 GFP_ATOMIC | __GFP_NOWARN);
-	if (!skb) {
+	page = page_pool_alloc_pages(ring->page_pool,
+				     GFP_ATOMIC | __GFP_NOWARN);
+	if (!page) {
 		priv->mib.alloc_rx_buff_failed++;
 		netif_err(priv, rx_err, priv->dev,
-			  "%s: Rx skb allocation failed\n", __func__);
-		return NULL;
-	}
-
-	/* DMA-map the new Rx skb */
-	mapping = dma_map_single(kdev, skb->data, priv->rx_buf_len,
-				 DMA_FROM_DEVICE);
-	if (dma_mapping_error(kdev, mapping)) {
-		priv->mib.rx_dma_failed++;
-		dev_kfree_skb_any(skb);
-		netif_err(priv, rx_err, priv->dev,
-			  "%s: Rx skb DMA mapping failed\n", __func__);
-		return NULL;
+			  "%s: Rx page allocation failed\n", __func__);
+		return -ENOMEM;
 	}
 
-	/* Grab the current Rx skb from the ring and DMA-unmap it */
-	rx_skb = bcmgenet_free_rx_cb(kdev, cb);
+	/* page_pool handles DMA mapping via PP_FLAG_DMA_MAP */
+	mapping = page_pool_get_dma_addr(page) + GENET_XDP_HEADROOM;
 
-	/* Put the new Rx skb on the ring */
-	cb->skb = skb;
-	dma_unmap_addr_set(cb, dma_addr, mapping);
-	dma_unmap_len_set(cb, dma_len, priv->rx_buf_len);
+	cb->rx_page = page;
+	cb->rx_page_offset = GENET_XDP_HEADROOM;
 	dmadesc_set_addr(priv, cb->bd_addr, mapping);
 
-	/* Return the current Rx skb to caller */
-	return rx_skb;
+	return 0;
 }
 
 /* bcmgenet_desc_rx - descriptor based rx process.
@@ -2339,25 +2323,28 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 	while ((rxpktprocessed < rxpkttoprocess) &&
 	       (rxpktprocessed < budget)) {
 		struct status_64 *status;
+		struct page *rx_page;
+		unsigned int rx_off;
 		__be16 rx_csum;
+		void *hard_start;
 
 		cb = &priv->rx_cbs[ring->read_ptr];
-		skb = bcmgenet_rx_refill(priv, cb);
 
-		if (unlikely(!skb)) {
+		/* Save the received page before refilling */
+		rx_page = cb->rx_page;
+		rx_off = cb->rx_page_offset;
+
+		if (bcmgenet_rx_refill(ring, cb)) {
 			BCMGENET_STATS64_INC(stats, dropped);
 			goto next;
 		}
 
-		status = (struct status_64 *)skb->data;
+		page_pool_dma_sync_for_cpu(ring->page_pool, rx_page, 0,
+					   RX_BUF_LENGTH);
+
+		hard_start = page_address(rx_page) + rx_off;
+		status = (struct status_64 *)hard_start;
 		dma_length_status = status->length_status;
-		if (dev->features & NETIF_F_RXCSUM) {
-			rx_csum = (__force __be16)(status->rx_csum & 0xffff);
-			if (rx_csum) {
-				skb->csum = (__force __wsum)ntohs(rx_csum);
-				skb->ip_summed = CHECKSUM_COMPLETE;
-			}
-		}
 
 		/* DMA flags and length are still valid no matter how
 		 * we got the Receive Status Vector (64B RSB or register)
@@ -2373,7 +2360,8 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 		if (unlikely(len > RX_BUF_LENGTH)) {
 			netif_err(priv, rx_status, dev, "oversized packet\n");
 			BCMGENET_STATS64_INC(stats, length_errors);
-			dev_kfree_skb_any(skb);
+			page_pool_put_full_page(ring->page_pool, rx_page,
+						true);
 			goto next;
 		}
 
@@ -2381,7 +2369,8 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 			netif_err(priv, rx_status, dev,
 				  "dropping fragmented packet!\n");
 			BCMGENET_STATS64_INC(stats, fragmented_errors);
-			dev_kfree_skb_any(skb);
+			page_pool_put_full_page(ring->page_pool, rx_page,
+						true);
 			goto next;
 		}
 
@@ -2409,24 +2398,48 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 						DMA_RX_RXER)) == DMA_RX_RXER)
 				u64_stats_inc(&stats->errors);
 			u64_stats_update_end(&stats->syncp);
-			dev_kfree_skb_any(skb);
+			page_pool_put_full_page(ring->page_pool, rx_page,
+						true);
 			goto next;
 		} /* error packet */
 
-		skb_put(skb, len);
+		/* Build SKB from the page - data starts at hard_start,
+		 * frame begins after RSB(64) + pad(2) = 66 bytes.
+		 */
+		skb = napi_build_skb(hard_start, PAGE_SIZE - GENET_XDP_HEADROOM);
+		if (unlikely(!skb)) {
+			BCMGENET_STATS64_INC(stats, dropped);
+			page_pool_put_full_page(ring->page_pool, rx_page,
+						true);
+			goto next;
+		}
+
+		skb_mark_for_recycle(skb);
 
-		/* remove RSB and hardware 2bytes added for IP alignment */
-		skb_pull(skb, 66);
-		len -= 66;
+		/* Reserve the RSB + pad, then set the data length */
+		skb_reserve(skb, GENET_RSB_PAD);
+		__skb_put(skb, len - GENET_RSB_PAD);
 
 		if (priv->crc_fwd_en) {
-			skb_trim(skb, len - ETH_FCS_LEN);
+			skb_trim(skb, skb->len - ETH_FCS_LEN);
 			len -= ETH_FCS_LEN;
 		}
 
+		/* Set up checksum offload */
+		if (dev->features & NETIF_F_RXCSUM) {
+			rx_csum = (__force __be16)(status->rx_csum & 0xffff);
+			if (rx_csum) {
+				skb->csum = (__force __wsum)ntohs(rx_csum);
+				skb->ip_summed = CHECKSUM_COMPLETE;
+			}
+		}
+
+		len = skb->len;
 		bytes_processed += len;
 
-		/*Finish setting up the received SKB and send it to the kernel*/
+		/* Finish setting up the received SKB and send it to the
+		 * kernel.
+		 */
 		skb->protocol = eth_type_trans(skb, priv->dev);
 
 		u64_stats_update_begin(&stats->syncp);
@@ -2495,12 +2508,11 @@ static void bcmgenet_dim_work(struct work_struct *work)
 	dim->state = DIM_START_MEASURE;
 }
 
-/* Assign skb to RX DMA descriptor. */
+/* Assign page_pool pages to RX DMA descriptors. */
 static int bcmgenet_alloc_rx_buffers(struct bcmgenet_priv *priv,
 				     struct bcmgenet_rx_ring *ring)
 {
 	struct enet_cb *cb;
-	struct sk_buff *skb;
 	int i;
 
 	netif_dbg(priv, hw, priv->dev, "%s\n", __func__);
@@ -2508,10 +2520,7 @@ static int bcmgenet_alloc_rx_buffers(struct bcmgenet_priv *priv,
 	/* loop here for each buffer needing assign */
 	for (i = 0; i < ring->size; i++) {
 		cb = ring->cbs + i;
-		skb = bcmgenet_rx_refill(priv, cb);
-		if (skb)
-			dev_consume_skb_any(skb);
-		if (!cb->skb)
+		if (bcmgenet_rx_refill(ring, cb))
 			return -ENOMEM;
 	}
 
@@ -2520,16 +2529,18 @@ static int bcmgenet_alloc_rx_buffers(struct bcmgenet_priv *priv,
 
 static void bcmgenet_free_rx_buffers(struct bcmgenet_priv *priv)
 {
-	struct sk_buff *skb;
+	struct bcmgenet_rx_ring *ring;
 	struct enet_cb *cb;
-	int i;
+	int q, i;
 
-	for (i = 0; i < priv->num_rx_bds; i++) {
-		cb = &priv->rx_cbs[i];
-
-		skb = bcmgenet_free_rx_cb(&priv->pdev->dev, cb);
-		if (skb)
-			dev_consume_skb_any(skb);
+	for (q = 0; q <= priv->hw_params->rx_queues; q++) {
+		ring = &priv->rx_rings[q];
+		if (!ring->page_pool)
+			continue;
+		for (i = 0; i < ring->size; i++) {
+			cb = ring->cbs + i;
+			bcmgenet_free_rx_cb(cb, ring->page_pool);
+		}
 	}
 }
 
@@ -2747,6 +2758,31 @@ static void bcmgenet_init_tx_ring(struct bcmgenet_priv *priv,
 	netif_napi_add_tx(priv->dev, &ring->napi, bcmgenet_tx_poll);
 }
 
+static int bcmgenet_rx_ring_create_pool(struct bcmgenet_priv *priv,
+					struct bcmgenet_rx_ring *ring)
+{
+	struct page_pool_params pp_params = {
+		.order = 0,
+		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.pool_size = ring->size,
+		.nid = NUMA_NO_NODE,
+		.dev = &priv->pdev->dev,
+		.dma_dir = DMA_FROM_DEVICE,
+		.offset = GENET_XDP_HEADROOM,
+		.max_len = RX_BUF_LENGTH,
+	};
+
+	ring->page_pool = page_pool_create(&pp_params);
+	if (IS_ERR(ring->page_pool)) {
+		int err = PTR_ERR(ring->page_pool);
+
+		ring->page_pool = NULL;
+		return err;
+	}
+
+	return 0;
+}
+
 /* Initialize a RDMA ring */
 static int bcmgenet_init_rx_ring(struct bcmgenet_priv *priv,
 				 unsigned int index, unsigned int size,
@@ -2765,10 +2801,17 @@ static int bcmgenet_init_rx_ring(struct bcmgenet_priv *priv,
 	ring->cb_ptr = start_ptr;
 	ring->end_ptr = end_ptr - 1;
 
-	ret = bcmgenet_alloc_rx_buffers(priv, ring);
+	ret = bcmgenet_rx_ring_create_pool(priv, ring);
 	if (ret)
 		return ret;
 
+	ret = bcmgenet_alloc_rx_buffers(priv, ring);
+	if (ret) {
+		page_pool_destroy(ring->page_pool);
+		ring->page_pool = NULL;
+		return ret;
+	}
+
 	bcmgenet_init_dim(ring, bcmgenet_dim_work);
 	bcmgenet_init_rx_coalesce(ring);
 
@@ -2961,6 +3004,20 @@ static void bcmgenet_fini_rx_napi(struct bcmgenet_priv *priv)
 	}
 }
 
+static void bcmgenet_destroy_rx_page_pools(struct bcmgenet_priv *priv)
+{
+	struct bcmgenet_rx_ring *ring;
+	unsigned int i;
+
+	for (i = 0; i <= priv->hw_params->rx_queues; ++i) {
+		ring = &priv->rx_rings[i];
+		if (ring->page_pool) {
+			page_pool_destroy(ring->page_pool);
+			ring->page_pool = NULL;
+		}
+	}
+}
+
 /* Initialize Rx queues
  *
  * Queues 0-15 are priority queues. Hardware Filtering Block (HFB) can be
@@ -3032,6 +3089,7 @@ static void bcmgenet_fini_dma(struct bcmgenet_priv *priv)
 	}
 
 	bcmgenet_free_rx_buffers(priv);
+	bcmgenet_destroy_rx_page_pools(priv);
 	kfree(priv->rx_cbs);
 	kfree(priv->tx_cbs);
 }
@@ -3108,6 +3166,7 @@ static int bcmgenet_init_dma(struct bcmgenet_priv *priv, bool flush_rx)
 	if (ret) {
 		netdev_err(priv->dev, "failed to initialize Rx queues\n");
 		bcmgenet_free_rx_buffers(priv);
+		bcmgenet_destroy_rx_page_pools(priv);
 		kfree(priv->rx_cbs);
 		kfree(priv->tx_cbs);
 		return ret;
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 9e4110c7fdf6..11a0ec563a89 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -15,6 +15,7 @@
 #include <linux/phy.h>
 #include <linux/dim.h>
 #include <linux/ethtool.h>
+#include <net/page_pool/helpers.h>
 
 #include "../unimac.h"
 
@@ -469,6 +470,8 @@ struct bcmgenet_rx_stats64 {
 
 struct enet_cb {
 	struct sk_buff      *skb;
+	struct page         *rx_page;
+	unsigned int        rx_page_offset;
 	void __iomem *bd_addr;
 	DEFINE_DMA_UNMAP_ADDR(dma_addr);
 	DEFINE_DMA_UNMAP_LEN(dma_len);
@@ -575,6 +578,7 @@ struct bcmgenet_rx_ring {
 	struct bcmgenet_net_dim dim;
 	u32		rx_max_coalesced_frames;
 	u32		rx_coalesce_usecs;
+	struct page_pool *page_pool;
 	struct bcmgenet_priv *priv;
 };
 
-- 
2.51.0


