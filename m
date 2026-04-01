Return-Path: <netdev+bounces-274190-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMzQIZhMzWl6bgYAu9opvQ
	(envelope-from <netdev+bounces-274190-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 18:49:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2CE37E268
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 18:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B885830FCC12
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 16:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D88047DD56;
	Wed,  1 Apr 2026 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LptjTZN5"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C7747D938;
	Wed,  1 Apr 2026 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775061593; cv=none; b=NFHe5VpkAzyPSElve1nr3JsrnIRrkXVfQZ8yG4Sx21DxZ2SY5lquaSYZlFcdkZCJXQUiMQhQ6twwqwl+gUEEcALxleyRPqyTAcVbuFUjQ/sV9a/28eQoGRWjcgksZCLHOXqzKnwvy3XZ6Fyz8vPXg0/Yd7aq2AEUGMtklQRz+7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775061593; c=relaxed/simple;
	bh=lm8NB9tzfRpApXsp+WfP5KXrLK5dcEv8oyupQPzCPIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l9TK8Aj7qxKIAmd4cbdQAPl8/yYNhxkcOWaRawcXXs1bD2RFBLpvMOPVryvlD1l8qanIx1jiTRX8jnea2Lc/6CXGgTr/TsCHzgZGJwOZbdQlBTPgaaFtSCoUhb5AnqnR6PX3y51f5U9XxpGpB9AM4I1pRtXHj+GXWzd1Nt2fseQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LptjTZN5; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 283DC4E42898;
	Wed,  1 Apr 2026 16:39:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F1677602BF;
	Wed,  1 Apr 2026 16:39:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9992A104507FB;
	Wed,  1 Apr 2026 18:39:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775061581; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=X9MoZ1k6DPU6zKTVbA58S1QXZFLGGGZjTlfS0KgPoeE=;
	b=LptjTZN51JMNeQ1ri4qu/QY298Of2Mk/EKt6Y7YVOL9giIPjuI83P7aFv0mb5SsCJdLJaW
	fL9/BMqJaMa74ZNptzG9FC0t9IuAZLyGMQlZtHQLLUvTJEB+TgVxth5j13BuOtWC0CW7n6
	n2CS4raeVPgd70Efq+eccxEL1dmmb+034ubu/2rT6fRViqsNDHbeS9qc7nGTmrl2/QgB0I
	kfAG7tIpz3CqP8au+wCJGtTzV0qKQ8AAgibwfXc2CO7WAhi7FsHmT6D/csMHz5YbvgWyau
	7K12Aaz2PR724fz0R6GlA1eCmzd9QRINJOCcIUZr1zxFwsdEVPQvVn6DshgNRA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 01 Apr 2026 18:39:11 +0200
Subject: [PATCH net-next 08/11] net: macb: make `struct macb` subset
 reachable from macb_context struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260401-macb-context-v1-8-9590c5ab7272@bootlin.com>
References: <20260401-macb-context-v1-0-9590c5ab7272@bootlin.com>
In-Reply-To: <20260401-macb-context-v1-0-9590c5ab7272@bootlin.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Paolo Valerio <pvalerio@redhat.com>, Conor Dooley <conor@kernel.org>, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.15.0
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274190-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.697];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,gnu.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB2CE37E268
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For parallel MACB context to start become a reality, many functions need
to stop operating on bp->ctx (the currently active context) and instead
work on a context they get passed. That context might be
(1) the new one that is getting allocated and initialised, or,
(2) the old one to be freed.

To reduce bug surface area, we will taint those functions to *only* take
a context and no `struct macb *bp`. That way, no bug of using `bp->ctx`
instead of `ctx` will ever occur.

For that, we need to embed a subset of `struct macb` information into
each context so that all helpers can still do their jobs. That subset
must be constant once probe is completed. Do this by taking a pointer
to a subset of macb called `struct macb_info`.

That subset is accessible from context (ctx->info->caps) or
from bp (bp->caps) using `-fms-extensions` option, thanks to
commit c4781dc3d1cf ("Kbuild: enable -fms-extensions").
https://gcc.gnu.org/onlinedocs/gcc/Unnamed-Fields.html

Add the structure and assign ctx->info at alloc,
but nothing uses it yet.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      |  58 ++--
 drivers/net/ethernet/cadence/macb_main.c | 474 ++++++++++++++++---------------
 drivers/net/ethernet/cadence/macb_ptp.c  |   8 +-
 3 files changed, 291 insertions(+), 249 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 8821205e8875..66e3638b84c0 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -840,7 +840,7 @@
  */
 #define macb_or_gem_writel(__bp, __reg, __value) \
 	({ \
-		if (macb_is_gem((__bp))) \
+		if (macb_is_gem((__bp)->caps)) \
 			gem_writel((__bp), __reg, __value); \
 		else \
 			macb_writel((__bp), __reg, __value); \
@@ -849,7 +849,7 @@
 #define macb_or_gem_readl(__bp, __reg) \
 	({ \
 		u32 __v; \
-		if (macb_is_gem((__bp))) \
+		if (macb_is_gem((__bp)->caps)) \
 			__v = gem_readl((__bp), __reg); \
 		else \
 			__v = macb_readl((__bp), __reg); \
@@ -1196,11 +1196,12 @@ static const struct gem_statistic queue_statistics[] = {
 
 struct macb;
 struct macb_queue;
+struct macb_context;
 
 struct macb_or_gem_ops {
-	int	(*mog_alloc_rx_buffers)(struct macb *bp);
-	void	(*mog_free_rx_buffers)(struct macb *bp);
-	void	(*mog_init_rings)(struct macb *bp);
+	int	(*mog_alloc_rx_buffers)(struct macb_context *ctx);
+	void	(*mog_free_rx_buffers)(struct macb_context *ctx);
+	void	(*mog_init_rings)(struct macb_context *ctx);
 	int	(*mog_rx)(struct macb_queue *queue, struct napi_struct *napi,
 			  int budget);
 };
@@ -1290,6 +1291,16 @@ struct ethtool_rx_fs_list {
 	unsigned int count;
 };
 
+struct macb_info {
+	struct platform_device	*pdev;
+	struct net_device	*netdev;
+	struct macb_or_gem_ops	macbgem_ops;
+	unsigned int		num_queues;
+	u32			caps;
+	int			rx_bd_rd_prefetch;
+	int			tx_bd_rd_prefetch;
+};
+
 struct macb_rxq {
 	struct macb_dma_desc	*ring;		/* MACB & GEM */
 	dma_addr_t		ring_dma;	/* MACB & GEM */
@@ -1309,6 +1320,8 @@ struct macb_txq {
 };
 
 struct macb_context {
+	const struct macb_info	*info;
+
 	unsigned int		rx_buffer_size;
 	unsigned int		rx_ring_size;
 	unsigned int		tx_ring_size;
@@ -1324,6 +1337,15 @@ struct macb {
 	u32	(*macb_reg_readl)(struct macb *bp, int offset);
 	void	(*macb_reg_writel)(struct macb *bp, int offset, u32 value);
 
+	/*
+	 * Give direct access (bp->caps) and
+	 * allow taking a pointer to it (&bp->info) for contexts.
+	 */
+	union {
+		struct macb_info;
+		struct macb_info info;
+	};
+
 	/*
 	 * Context stores all its parameters.
 	 * But we must remember them across closure.
@@ -1335,17 +1357,14 @@ struct macb {
 	struct macb_dma_desc	*rx_ring_tieoff;
 	dma_addr_t		rx_ring_tieoff_dma;
 
-	unsigned int		num_queues;
 	struct macb_queue	queues[MACB_MAX_QUEUES];
 
 	spinlock_t		lock;
-	struct platform_device	*pdev;
 	struct clk		*pclk;
 	struct clk		*hclk;
 	struct clk		*tx_clk;
 	struct clk		*rx_clk;
 	struct clk		*tsu_clk;
-	struct net_device	*netdev;
 	/* Protects hw_stats and ethtool_stats */
 	spinlock_t		stats_lock;
 	union {
@@ -1353,15 +1372,12 @@ struct macb {
 		struct gem_stats	gem;
 	}			hw_stats;
 
-	struct macb_or_gem_ops	macbgem_ops;
-
 	struct mii_bus		*mii_bus;
 	struct phylink		*phylink;
 	struct phylink_config	phylink_config;
 	struct phylink_pcs	phylink_usx_pcs;
 	struct phylink_pcs	phylink_sgmii_pcs;
 
-	u32			caps;
 	unsigned int		dma_burst_length;
 
 	phy_interface_t		phy_interface;
@@ -1404,9 +1420,6 @@ struct macb {
 	struct delayed_work	tx_lpi_work;
 	u32			tx_lpi_timer;
 
-	int	rx_bd_rd_prefetch;
-	int	tx_bd_rd_prefetch;
-
 	u32	rx_intr_mask;
 
 	struct macb_pm_data pm_data;
@@ -1458,14 +1471,15 @@ static inline void gem_ptp_do_txstamp(struct macb *bp, struct sk_buff *skb, stru
 static inline void gem_ptp_do_rxstamp(struct macb *bp, struct sk_buff *skb, struct macb_dma_desc *desc) { }
 #endif
 
-static inline bool macb_is_gem(struct macb *bp)
+static inline bool macb_is_gem(u32 caps)
 {
-	return !!(bp->caps & MACB_CAPS_MACB_IS_GEM);
+	return !!(caps & MACB_CAPS_MACB_IS_GEM);
 }
 
-static inline bool gem_has_ptp(struct macb *bp)
+static inline bool gem_has_ptp(u32 caps)
 {
-	return IS_ENABLED(CONFIG_MACB_USE_HWSTAMP) && (bp->caps & MACB_CAPS_GEM_HAS_PTP);
+	return IS_ENABLED(CONFIG_MACB_USE_HWSTAMP) &&
+	       (caps & MACB_CAPS_GEM_HAS_PTP);
 }
 
 /* ENST Helper functions */
@@ -1481,16 +1495,16 @@ static inline u64 enst_max_hw_interval(u32 speed_mbps)
 			    ENST_TIME_GRANULARITY_NS * 1000, (speed_mbps));
 }
 
-static inline bool macb_dma64(struct macb *bp)
+static inline bool macb_dma64(u32 caps)
 {
 	return IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT) &&
-	       bp->caps & MACB_CAPS_DMA_64B;
+	       caps & MACB_CAPS_DMA_64B;
 }
 
-static inline bool macb_dma_ptp(struct macb *bp)
+static inline bool macb_dma_ptp(u32 caps)
 {
 	return IS_ENABLED(CONFIG_MACB_USE_HWSTAMP) &&
-	       bp->caps & MACB_CAPS_DMA_PTP;
+	       caps & MACB_CAPS_DMA_PTP;
 }
 
 /**
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 033c36d8a3d4..47f0d27cd979 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -122,33 +122,36 @@ struct sifive_fu540_macb_mgmt {
  *    word 5: timestamp word 1
  *    word 6: timestamp word 2
  */
-static unsigned int macb_dma_desc_get_size(struct macb *bp)
+static unsigned int macb_dma_desc_get_size(u32 caps)
 {
 	unsigned int desc_size = sizeof(struct macb_dma_desc);
 
-	if (macb_dma64(bp))
+	if (macb_dma64(caps))
 		desc_size += sizeof(struct macb_dma_desc_64);
-	if (macb_dma_ptp(bp))
+	if (macb_dma_ptp(caps))
 		desc_size += sizeof(struct macb_dma_desc_ptp);
 
 	return desc_size;
 }
 
-static unsigned int macb_adj_dma_desc_idx(struct macb *bp, unsigned int desc_idx)
+static unsigned int macb_adj_dma_desc_idx(struct macb_context *ctx,
+					  unsigned int desc_idx)
 {
-	return desc_idx * (1 + macb_dma64(bp) + macb_dma_ptp(bp));
+	return desc_idx * (1 + macb_dma64(ctx->info->caps) +
+			       macb_dma_ptp(ctx->info->caps));
 }
 
-static struct macb_dma_desc_64 *macb_64b_desc(struct macb *bp, struct macb_dma_desc *desc)
+static struct macb_dma_desc_64 *macb_64b_desc(struct macb_dma_desc *desc)
 {
 	return (struct macb_dma_desc_64 *)((void *)desc
 		+ sizeof(struct macb_dma_desc));
 }
 
 /* Ring buffer accessors */
-static unsigned int macb_tx_ring_wrap(struct macb *bp, unsigned int index)
+static unsigned int macb_tx_ring_wrap(struct macb_context *ctx,
+				      unsigned int index)
 {
-	return index & (bp->ctx->tx_ring_size - 1);
+	return index & (ctx->tx_ring_size - 1);
 }
 
 static struct macb_txq *macb_txq(struct macb_queue *queue)
@@ -167,14 +170,13 @@ static struct macb_rxq *macb_rxq(struct macb_queue *queue)
 	return &bp->ctx->rxq[q];
 }
 
-static struct macb_dma_desc *macb_tx_desc(struct macb_queue *queue,
+static struct macb_dma_desc *macb_tx_desc(struct macb_context *ctx,
+					  unsigned int q,
 					  unsigned int index)
 {
-	struct macb_txq *txq = macb_txq(queue);
-
-	index = macb_tx_ring_wrap(queue->bp, index);
-	index = macb_adj_dma_desc_idx(queue->bp, index);
-	return &txq->ring[index];
+	index = macb_tx_ring_wrap(ctx, index);
+	index = macb_adj_dma_desc_idx(ctx, index);
+	return &ctx->txq[q].ring[index];
 }
 
 static struct macb_tx_skb *macb_tx_skb(struct macb_queue *queue,
@@ -182,40 +184,42 @@ static struct macb_tx_skb *macb_tx_skb(struct macb_queue *queue,
 {
 	struct macb_txq *txq = macb_txq(queue);
 
-	return &txq->skb[macb_tx_ring_wrap(queue->bp, index)];
+	return &txq->skb[macb_tx_ring_wrap(queue->bp->ctx, index)];
 }
 
 static dma_addr_t macb_tx_dma(struct macb_queue *queue, unsigned int index)
 {
+	struct macb_context *ctx = queue->bp->ctx;
 	struct macb_txq *txq = macb_txq(queue);
 	dma_addr_t offset;
 
-	offset = macb_tx_ring_wrap(queue->bp, index) *
-			macb_dma_desc_get_size(queue->bp);
+	offset = macb_tx_ring_wrap(ctx, index) *
+			macb_dma_desc_get_size(queue->bp->caps);
 
 	return txq->ring_dma + offset;
 }
 
-static unsigned int macb_rx_ring_wrap(struct macb *bp, unsigned int index)
+static unsigned int macb_rx_ring_wrap(struct macb_context *ctx,
+				      unsigned int index)
 {
-	return index & (bp->ctx->rx_ring_size - 1);
+	return index & (ctx->rx_ring_size - 1);
 }
 
-static struct macb_dma_desc *macb_rx_desc(struct macb_queue *queue, unsigned int index)
+static struct macb_dma_desc *macb_rx_desc(struct macb_context *ctx,
+					  unsigned int q, unsigned int index)
 {
-	struct macb_rxq *rxq = macb_rxq(queue);
-
-	index = macb_rx_ring_wrap(queue->bp, index);
-	index = macb_adj_dma_desc_idx(queue->bp, index);
-	return &rxq->ring[index];
+	index = macb_rx_ring_wrap(ctx, index);
+	index = macb_adj_dma_desc_idx(ctx, index);
+	return &ctx->rxq[q].ring[index];
 }
 
 static void *macb_rx_buffer(struct macb_queue *queue, unsigned int index)
 {
+	struct macb_context *ctx = queue->bp->ctx;
 	struct macb_rxq *rxq = macb_rxq(queue);
 
-	return rxq->buffers + queue->bp->ctx->rx_buffer_size *
-	       macb_rx_ring_wrap(queue->bp, index);
+	return rxq->buffers + ctx->rx_buffer_size *
+	       macb_rx_ring_wrap(ctx, index);
 }
 
 /* I/O accessors */
@@ -278,7 +282,7 @@ static void macb_set_hwaddr(struct macb *bp)
 	top = get_unaligned_le16(bp->netdev->dev_addr + 4);
 	macb_or_gem_writel(bp, SA1T, top);
 
-	if (gem_has_ptp(bp)) {
+	if (gem_has_ptp(bp->caps)) {
 		gem_writel(bp, RXPTPUNI, bottom);
 		gem_writel(bp, TXPTPUNI, bottom);
 	}
@@ -489,7 +493,7 @@ static void macb_init_buffers(struct macb *bp)
 	unsigned int q;
 
 	/* Single register for all queues' high 32 bits. */
-	if (macb_dma64(bp)) {
+	if (macb_dma64(bp->caps)) {
 		rxq = &bp->ctx->rxq[0];
 		txq = &bp->ctx->txq[0];
 		macb_writel(bp, RBQPH, upper_32_bits(rxq->ring_dma));
@@ -772,7 +776,7 @@ static void macb_mac_config(struct phylink_config *config, unsigned int mode,
 	if (bp->caps & MACB_CAPS_MACB_IS_EMAC) {
 		if (state->interface == PHY_INTERFACE_MODE_RMII)
 			ctrl |= MACB_BIT(RM9200_RMII);
-	} else if (macb_is_gem(bp)) {
+	} else if (macb_is_gem(bp->caps)) {
 		ctrl &= ~(GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL));
 		ncr &= ~GEM_BIT(ENABLE_HS_MAC);
 
@@ -824,13 +828,14 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 	unsigned int head, tail, count, ring_size, desc_size;
 	struct macb_tx_skb tx_skb, *skb_curr, *skb_next;
 	struct macb_dma_desc *desc_curr, *desc_next;
+	unsigned int q = queue - queue->bp->queues;
 	unsigned int i, cycles, shift, curr, next;
+	struct macb_context *ctx = queue->bp->ctx;
 	struct macb_txq *txq = macb_txq(queue);
-	struct macb *bp = queue->bp;
 	unsigned char desc[24];
 	unsigned long flags;
 
-	desc_size = macb_dma_desc_get_size(bp);
+	desc_size = macb_dma_desc_get_size(queue->bp->caps);
 
 	if (WARN_ON_ONCE(desc_size > ARRAY_SIZE(desc)))
 		return;
@@ -838,7 +843,7 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 	head = txq->head;
 	tail = txq->tail;
-	ring_size = bp->ctx->tx_ring_size;
+	ring_size = ctx->tx_ring_size;
 	count = CIRC_CNT(head, tail, ring_size);
 
 	if (!(tail % ring_size))
@@ -854,7 +859,7 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 	cycles = gcd(ring_size, shift);
 
 	for (i = 0; i < cycles; i++) {
-		memcpy(&desc, macb_tx_desc(queue, i), desc_size);
+		memcpy(&desc, macb_tx_desc(ctx, q, i), desc_size);
 		memcpy(&tx_skb, macb_tx_skb(queue, i),
 		       sizeof(struct macb_tx_skb));
 
@@ -862,8 +867,8 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 		next = (curr + shift) % ring_size;
 
 		while (next != i) {
-			desc_curr = macb_tx_desc(queue, curr);
-			desc_next = macb_tx_desc(queue, next);
+			desc_curr = macb_tx_desc(ctx, q, curr);
+			desc_next = macb_tx_desc(ctx, q, next);
 
 			memcpy(desc_curr, desc_next, desc_size);
 
@@ -880,7 +885,7 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 			next = (curr + shift) % ring_size;
 		}
 
-		desc_curr = macb_tx_desc(queue, curr);
+		desc_curr = macb_tx_desc(ctx, q, curr);
 		memcpy(desc_curr, &desc, desc_size);
 		if (i == ring_size - 1)
 			desc_curr->ctrl &= ~MACB_BIT(TX_WRAP);
@@ -937,7 +942,7 @@ static void macb_mac_link_up(struct phylink_config *config,
 
 	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC)) {
 		ctrl &= ~MACB_BIT(PAE);
-		if (macb_is_gem(bp)) {
+		if (macb_is_gem(bp->caps)) {
 			ctrl &= ~GEM_BIT(GBE);
 
 			if (speed == SPEED_1000)
@@ -968,7 +973,7 @@ static void macb_mac_link_up(struct phylink_config *config,
 
 	/* Enable Rx and Tx; Enable PTP unicast */
 	ctrl = macb_readl(bp, NCR);
-	if (gem_has_ptp(bp))
+	if (gem_has_ptp(bp->caps))
 		ctrl |= MACB_BIT(PTPUNI);
 
 	macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));
@@ -1078,7 +1083,8 @@ static int macb_mii_probe(struct net_device *netdev)
 		  bp->phylink_config.supported_interfaces);
 
 	/* Determine what modes are supported */
-	if (macb_is_gem(bp) && (bp->caps & MACB_CAPS_GIGABIT_MODE_AVAILABLE)) {
+	if (macb_is_gem(bp->caps) &&
+	    (bp->caps & MACB_CAPS_GIGABIT_MODE_AVAILABLE)) {
 		bp->phylink_config.mac_capabilities |= MAC_1000FD;
 		if (!(bp->caps & MACB_CAPS_NO_GIGABIT_HALF))
 			bp->phylink_config.mac_capabilities |= MAC_1000HD;
@@ -1246,12 +1252,13 @@ static void macb_tx_unmap(struct macb *bp, struct macb_tx_skb *tx_skb, int budge
 	}
 }
 
-static void macb_set_addr(struct macb *bp, struct macb_dma_desc *desc, dma_addr_t addr)
+static void macb_set_addr(struct macb_context *ctx, struct macb_dma_desc *desc,
+			  dma_addr_t addr)
 {
-	if (macb_dma64(bp)) {
+	if (macb_dma64(ctx->info->caps)) {
 		struct macb_dma_desc_64 *desc_64;
 
-		desc_64 = macb_64b_desc(bp, desc);
+		desc_64 = macb_64b_desc(desc);
 		desc_64->addrh = upper_32_bits(addr);
 		/* The low bits of RX address contain the RX_USED bit, clearing
 		 * of which allows packet RX. Make sure the high bits are also
@@ -1263,18 +1270,19 @@ static void macb_set_addr(struct macb *bp, struct macb_dma_desc *desc, dma_addr_
 	desc->addr = lower_32_bits(addr);
 }
 
-static dma_addr_t macb_get_addr(struct macb *bp, struct macb_dma_desc *desc)
+static dma_addr_t macb_get_addr(struct macb_context *ctx,
+				struct macb_dma_desc *desc)
 {
 	dma_addr_t addr = 0;
 
-	if (macb_dma64(bp)) {
+	if (macb_dma64(ctx->info->caps)) {
 		struct macb_dma_desc_64 *desc_64;
 
-		desc_64 = macb_64b_desc(bp, desc);
+		desc_64 = macb_64b_desc(desc);
 		addr = ((u64)(desc_64->addrh) << 32);
 	}
 	addr |= MACB_BF(RX_WADDR, MACB_BFEXT(RX_WADDR, desc->addr));
-	if (macb_dma_ptp(bp))
+	if (macb_dma_ptp(ctx->info->caps))
 		addr &= ~GEM_BIT(DMA_RXVALID);
 	return addr;
 }
@@ -1284,6 +1292,7 @@ static void macb_tx_error_task(struct work_struct *work)
 	struct macb_queue *queue = container_of(work, struct macb_queue,
 						tx_error_task);
 	unsigned int q = queue - queue->bp->queues;
+	struct macb_context *ctx = queue->bp->ctx;
 	struct macb_txq *txq = macb_txq(queue);
 	struct macb *bp = queue->bp;
 	struct macb_tx_skb *tx_skb;
@@ -1326,7 +1335,7 @@ static void macb_tx_error_task(struct work_struct *work)
 	for (tail = txq->tail; tail != txq->head; tail++) {
 		u32	ctrl;
 
-		desc = macb_tx_desc(queue, tail);
+		desc = macb_tx_desc(ctx, q, tail);
 		ctrl = desc->ctrl;
 		tx_skb = macb_tx_skb(queue, tail);
 		skb = tx_skb->skb;
@@ -1345,7 +1354,7 @@ static void macb_tx_error_task(struct work_struct *work)
 			 */
 			if (!(ctrl & MACB_BIT(TX_BUF_EXHAUSTED))) {
 				netdev_vdbg(bp->netdev, "txerr skb %u (data %p) TX complete\n",
-					    macb_tx_ring_wrap(bp, tail),
+					    macb_tx_ring_wrap(ctx, tail),
 					    skb->data);
 				bp->netdev->stats.tx_packets++;
 				queue->stats.tx_packets++;
@@ -1373,8 +1382,8 @@ static void macb_tx_error_task(struct work_struct *work)
 				  packets, bytes);
 
 	/* Set end of TX queue */
-	desc = macb_tx_desc(queue, 0);
-	macb_set_addr(bp, desc, 0);
+	desc = macb_tx_desc(ctx, q, 0);
+	macb_set_addr(ctx, desc, 0);
 	desc->ctrl = MACB_BIT(TX_USED);
 
 	/* Make descriptor updates visible to hardware */
@@ -1436,6 +1445,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	struct macb *bp = queue->bp;
 	struct macb_txq *txq = macb_txq(queue);
 	unsigned int q = queue - bp->queues;
+	struct macb_context *ctx = bp->ctx;
 	unsigned long flags;
 	unsigned int tail;
 	unsigned int head;
@@ -1450,7 +1460,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 		struct macb_dma_desc	*desc;
 		u32			ctrl;
 
-		desc = macb_tx_desc(queue, tail);
+		desc = macb_tx_desc(ctx, q, tail);
 
 		/* Make hw descriptor updates visible to CPU */
 		rmb();
@@ -1475,7 +1485,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 					gem_ptp_do_txstamp(bp, skb, desc);
 
 				netdev_vdbg(bp->netdev, "skb %u (data %p) TX complete\n",
-					    macb_tx_ring_wrap(bp, tail),
+					    macb_tx_ring_wrap(ctx, tail),
 					    skb->data);
 				bp->netdev->stats.tx_packets++;
 				queue->stats.tx_packets++;
@@ -1513,53 +1523,53 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	return packets;
 }
 
-static void gem_rx_refill(struct macb_queue *queue)
+static void gem_rx_refill(struct macb_context *ctx, unsigned int q)
 {
-	struct macb_rxq *rxq = macb_rxq(queue);
-	struct macb *bp = queue->bp;
+	struct device *dev = &ctx->info->pdev->dev;
+	struct macb_rxq *rxq = &ctx->rxq[q];
 	struct macb_dma_desc *desc;
 	struct sk_buff *skb;
 	unsigned int entry;
 	dma_addr_t paddr;
 
 	while (CIRC_SPACE(rxq->prepared_head, rxq->tail,
-			  bp->ctx->rx_ring_size) > 0) {
-		entry = macb_rx_ring_wrap(bp, rxq->prepared_head);
+			  ctx->rx_ring_size) > 0) {
+		entry = macb_rx_ring_wrap(ctx, rxq->prepared_head);
 
 		/* Make hw descriptor updates visible to CPU */
 		rmb();
 
-		desc = macb_rx_desc(queue, entry);
+		desc = macb_rx_desc(ctx, q, entry);
 
 		if (!rxq->skbuff[entry]) {
 			/* allocate sk_buff for this free entry in ring */
-			skb = netdev_alloc_skb(bp->netdev,
-					       bp->ctx->rx_buffer_size);
+			skb = netdev_alloc_skb(ctx->info->netdev,
+					       ctx->rx_buffer_size);
 			if (unlikely(!skb)) {
-				netdev_err(bp->netdev,
+				netdev_err(ctx->info->netdev,
 					   "Unable to allocate sk_buff\n");
 				break;
 			}
 
 			/* now fill corresponding descriptor entry */
-			paddr = dma_map_single(&bp->pdev->dev, skb->data,
-					       bp->ctx->rx_buffer_size,
+			paddr = dma_map_single(dev, skb->data,
+					       ctx->rx_buffer_size,
 					       DMA_FROM_DEVICE);
-			if (dma_mapping_error(&bp->pdev->dev, paddr)) {
+			if (dma_mapping_error(dev, paddr)) {
 				dev_kfree_skb(skb);
 				break;
 			}
 
 			rxq->skbuff[entry] = skb;
 
-			if (entry == bp->ctx->rx_ring_size - 1)
+			if (entry == ctx->rx_ring_size - 1)
 				paddr |= MACB_BIT(RX_WRAP);
 			desc->ctrl = 0;
 			/* Setting addr clears RX_USED and allows reception,
 			 * make sure ctrl is cleared first to avoid a race.
 			 */
 			dma_wmb();
-			macb_set_addr(bp, desc, paddr);
+			macb_set_addr(ctx, desc, paddr);
 
 			/* Properly align Ethernet header.
 			 *
@@ -1572,7 +1582,7 @@ static void gem_rx_refill(struct macb_queue *queue)
 			 * setting the low 2/3 bits.
 			 * It is 3 bits if HW_DMA_CAP_PTP, else 2 bits.
 			 */
-			if (!(bp->caps & MACB_CAPS_RSC))
+			if (!(ctx->info->caps & MACB_CAPS_RSC))
 				skb_reserve(skb, NET_IP_ALIGN);
 		} else {
 			desc->ctrl = 0;
@@ -1585,18 +1595,21 @@ static void gem_rx_refill(struct macb_queue *queue)
 	/* Make descriptor updates visible to hardware */
 	wmb();
 
-	netdev_vdbg(bp->netdev, "rx ring: queue: %p, prepared head %d, tail %d\n",
-		    queue, rxq->prepared_head, rxq->tail);
+	netdev_vdbg(ctx->info->netdev,
+		    "rx ring: queue: %u, prepared head %d, tail %d\n",
+		    q, rxq->prepared_head, rxq->tail);
 }
 
 /* Mark DMA descriptors from begin up to and not including end as unused */
 static void discard_partial_frame(struct macb_queue *queue, unsigned int begin,
 				  unsigned int end)
 {
+	unsigned int q = queue - queue->bp->queues;
+	struct macb_context *ctx = queue->bp->ctx;
 	unsigned int frag;
 
 	for (frag = begin; frag != end; frag++) {
-		struct macb_dma_desc *desc = macb_rx_desc(queue, frag);
+		struct macb_dma_desc *desc = macb_rx_desc(ctx, q, frag);
 
 		desc->addr &= ~MACB_BIT(RX_USED);
 	}
@@ -1613,6 +1626,8 @@ static void discard_partial_frame(struct macb_queue *queue, unsigned int begin,
 static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		  int budget)
 {
+	unsigned int q = queue - queue->bp->queues;
+	struct macb_context *ctx = queue->bp->ctx;
 	struct macb_rxq *rxq = macb_rxq(queue);
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
@@ -1626,14 +1641,14 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		dma_addr_t addr;
 		bool rxused;
 
-		entry = macb_rx_ring_wrap(bp, rxq->tail);
-		desc = macb_rx_desc(queue, entry);
+		entry = macb_rx_ring_wrap(ctx, rxq->tail);
+		desc = macb_rx_desc(ctx, q, entry);
 
 		/* Make hw descriptor updates visible to CPU */
 		rmb();
 
 		rxused = (desc->addr & MACB_BIT(RX_USED)) ? true : false;
-		addr = macb_get_addr(bp, desc);
+		addr = macb_get_addr(ctx, desc);
 
 		if (!rxused)
 			break;
@@ -1697,7 +1712,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		napi_gro_receive(napi, skb);
 	}
 
-	gem_rx_refill(queue);
+	gem_rx_refill(ctx, q);
 
 	return count;
 }
@@ -1705,6 +1720,8 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 static int macb_rx_frame(struct macb_queue *queue, struct napi_struct *napi,
 			 unsigned int first_frag, unsigned int last_frag)
 {
+	unsigned int q = queue - queue->bp->queues;
+	struct macb_context *ctx = queue->bp->ctx;
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
 	unsigned int offset;
@@ -1712,12 +1729,12 @@ static int macb_rx_frame(struct macb_queue *queue, struct napi_struct *napi,
 	unsigned int frag;
 	unsigned int len;
 
-	desc = macb_rx_desc(queue, last_frag);
+	desc = macb_rx_desc(ctx, q, last_frag);
 	len = desc->ctrl & bp->rx_frm_len_mask;
 
 	netdev_vdbg(bp->netdev, "macb_rx_frame frags %u - %u (len %u)\n",
-		    macb_rx_ring_wrap(bp, first_frag),
-		    macb_rx_ring_wrap(bp, last_frag), len);
+		macb_rx_ring_wrap(ctx, first_frag),
+		macb_rx_ring_wrap(ctx, last_frag), len);
 
 	/* The ethernet header starts NET_IP_ALIGN bytes into the
 	 * first buffer. Since the header is 14 bytes, this makes the
@@ -1731,7 +1748,7 @@ static int macb_rx_frame(struct macb_queue *queue, struct napi_struct *napi,
 	if (!skb) {
 		bp->netdev->stats.rx_dropped++;
 		for (frag = first_frag; ; frag++) {
-			desc = macb_rx_desc(queue, frag);
+			desc = macb_rx_desc(ctx, q, frag);
 			desc->addr &= ~MACB_BIT(RX_USED);
 			if (frag == last_frag)
 				break;
@@ -1762,7 +1779,7 @@ static int macb_rx_frame(struct macb_queue *queue, struct napi_struct *napi,
 					       macb_rx_buffer(queue, frag),
 					       frag_len);
 		offset += bp->ctx->rx_buffer_size;
-		desc = macb_rx_desc(queue, frag);
+		desc = macb_rx_desc(ctx, q, frag);
 		desc->addr &= ~MACB_BIT(RX_USED);
 
 		if (frag == last_frag)
@@ -1784,20 +1801,19 @@ static int macb_rx_frame(struct macb_queue *queue, struct napi_struct *napi,
 	return 0;
 }
 
-static inline void macb_init_rx_ring(struct macb_queue *queue)
+static inline void macb_init_rx_ring(struct macb_context *ctx, unsigned int q)
 {
-	struct macb_rxq *rxq = macb_rxq(queue);
+	struct macb_rxq *rxq = &ctx->rxq[q];
 	struct macb_dma_desc *desc = NULL;
-	struct macb *bp = queue->bp;
 	dma_addr_t addr;
 	int i;
 
 	addr = rxq->buffers_dma;
-	for (i = 0; i < bp->ctx->rx_ring_size; i++) {
-		desc = macb_rx_desc(queue, i);
-		macb_set_addr(bp, desc, addr);
+	for (i = 0; i < ctx->rx_ring_size; i++) {
+		desc = macb_rx_desc(ctx, q, i);
+		macb_set_addr(ctx, desc, addr);
 		desc->ctrl = 0;
-		addr += bp->ctx->rx_buffer_size;
+		addr += ctx->rx_buffer_size;
 	}
 	desc->addr |= MACB_BIT(RX_WRAP);
 	rxq->tail = 0;
@@ -1806,6 +1822,8 @@ static inline void macb_init_rx_ring(struct macb_queue *queue)
 static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
 		   int budget)
 {
+	unsigned int q = queue - queue->bp->queues;
+	struct macb_context *ctx = queue->bp->ctx;
 	struct macb_rxq *rxq = macb_rxq(queue);
 	struct macb *bp = queue->bp;
 	bool reset_rx_queue = false;
@@ -1814,7 +1832,7 @@ static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
 	int received = 0;
 
 	for (tail = rxq->tail; budget > 0; tail++) {
-		struct macb_dma_desc *desc = macb_rx_desc(queue, tail);
+		struct macb_dma_desc *desc = macb_rx_desc(ctx, q, tail);
 		u32 ctrl;
 
 		/* Make hw descriptor updates visible to CPU */
@@ -1866,7 +1884,7 @@ static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
 		ctrl = macb_readl(bp, NCR);
 		macb_writel(bp, NCR, ctrl & ~MACB_BIT(RE));
 
-		macb_init_rx_ring(queue);
+		macb_init_rx_ring(ctx, q);
 		queue_writel(queue, RBQP, rxq->ring_dma);
 
 		macb_writel(bp, NCR, ctrl | MACB_BIT(RE));
@@ -1885,13 +1903,14 @@ static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
 
 static bool macb_rx_pending(struct macb_queue *queue)
 {
+	unsigned int q = queue - queue->bp->queues;
+	struct macb_context *ctx = queue->bp->ctx;
 	struct macb_rxq *rxq = macb_rxq(queue);
-	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
 	unsigned int entry;
 
-	entry = macb_rx_ring_wrap(bp, rxq->tail);
-	desc = macb_rx_desc(queue, entry);
+	entry = macb_rx_ring_wrap(ctx, rxq->tail);
+	desc = macb_rx_desc(ctx, q, entry);
 
 	/* Make hw descriptor updates visible to CPU */
 	rmb();
@@ -1939,6 +1958,7 @@ static int macb_rx_poll(struct napi_struct *napi, int budget)
 
 static void macb_tx_restart(struct macb_queue *queue)
 {
+	struct macb_context *ctx = queue->bp->ctx;
 	struct macb_txq *txq = macb_txq(queue);
 	struct macb *bp = queue->bp;
 	unsigned int head_idx, tbqp;
@@ -1949,9 +1969,9 @@ static void macb_tx_restart(struct macb_queue *queue)
 	if (txq->head == txq->tail)
 		goto out_tx_ptr_unlock;
 
-	tbqp = queue_readl(queue, TBQP) / macb_dma_desc_get_size(bp);
-	tbqp = macb_adj_dma_desc_idx(bp, macb_tx_ring_wrap(bp, tbqp));
-	head_idx = macb_adj_dma_desc_idx(bp, macb_tx_ring_wrap(bp, txq->head));
+	tbqp = queue_readl(queue, TBQP) / macb_dma_desc_get_size(ctx->info->caps);
+	tbqp = macb_adj_dma_desc_idx(ctx, macb_tx_ring_wrap(ctx, tbqp));
+	head_idx = macb_adj_dma_desc_idx(ctx, macb_tx_ring_wrap(ctx, txq->head));
 
 	if (tbqp == head_idx)
 		goto out_tx_ptr_unlock;
@@ -1966,6 +1986,8 @@ static void macb_tx_restart(struct macb_queue *queue)
 
 static bool macb_tx_complete_pending(struct macb_queue *queue)
 {
+	unsigned int q = queue - queue->bp->queues;
+	struct macb_context *ctx = queue->bp->ctx;
 	struct macb_txq *txq = macb_txq(queue);
 	bool retval = false;
 	unsigned long flags;
@@ -1975,7 +1997,7 @@ static bool macb_tx_complete_pending(struct macb_queue *queue)
 		/* Make hw descriptor updates visible to CPU */
 		rmb();
 
-		if (macb_tx_desc(queue, txq->tail)->ctrl & MACB_BIT(TX_USED))
+		if (macb_tx_desc(ctx, q, txq->tail)->ctrl & MACB_BIT(TX_USED))
 			retval = true;
 	}
 	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
@@ -2029,6 +2051,7 @@ static void macb_hresp_error_task(struct work_struct *work)
 {
 	struct macb *bp = from_work(bp, work, hresp_err_bh_work);
 	struct net_device *netdev = bp->netdev;
+	struct macb_context *ctx = bp->ctx;
 	struct macb_queue *queue;
 	unsigned int q;
 	u32 ctrl;
@@ -2045,7 +2068,7 @@ static void macb_hresp_error_task(struct work_struct *work)
 	netif_tx_stop_all_queues(netdev);
 	netif_carrier_off(netdev);
 
-	bp->macbgem_ops.mog_init_rings(bp);
+	bp->macbgem_ops.mog_init_rings(ctx);
 
 	/* Initialize TX and RX buffers */
 	macb_init_buffers(bp);
@@ -2218,7 +2241,7 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 		if (status & MACB_BIT(ISR_ROVR)) {
 			/* We missed at least one packet */
 			spin_lock(&bp->stats_lock);
-			if (macb_is_gem(bp))
+			if (macb_is_gem(bp->caps))
 				bp->hw_stats.gem.rx_overruns++;
 			else
 				bp->hw_stats.macb.rx_overruns++;
@@ -2270,6 +2293,8 @@ static unsigned int macb_tx_map(struct macb *bp,
 	unsigned int f, nr_frags = skb_shinfo(skb)->nr_frags;
 	unsigned int len, i, tx_head = txq->head;
 	u32 ctrl, lso_ctrl = 0, seq_ctrl = 0;
+	unsigned int q = queue - bp->queues;
+	struct macb_context *ctx = bp->ctx;
 	unsigned int eof = 1, mss_mfs = 0;
 	struct macb_tx_skb *tx_skb = NULL;
 	struct macb_dma_desc *desc;
@@ -2360,7 +2385,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 	 */
 	i = tx_head;
 	ctrl = MACB_BIT(TX_USED);
-	desc = macb_tx_desc(queue, i);
+	desc = macb_tx_desc(ctx, q, i);
 	desc->ctrl = ctrl;
 
 	if (lso_ctrl) {
@@ -2381,14 +2406,14 @@ static unsigned int macb_tx_map(struct macb *bp,
 	do {
 		i--;
 		tx_skb = macb_tx_skb(queue, i);
-		desc = macb_tx_desc(queue, i);
+		desc = macb_tx_desc(ctx, q, i);
 
 		ctrl = (u32)tx_skb->size;
 		if (eof) {
 			ctrl |= MACB_BIT(TX_LAST);
 			eof = 0;
 		}
-		if (unlikely(macb_tx_ring_wrap(bp, i) ==
+		if (unlikely(macb_tx_ring_wrap(ctx, i) ==
 				bp->ctx->tx_ring_size - 1))
 			ctrl |= MACB_BIT(TX_WRAP);
 
@@ -2407,7 +2432,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 			ctrl |= MACB_BF(MSS_MFS, mss_mfs);
 
 		/* Set TX buffer descriptor */
-		macb_set_addr(bp, desc, tx_skb->mapping);
+		macb_set_addr(ctx, desc, tx_skb->mapping);
 		/* desc->addr must be visible to hardware before clearing
 		 * 'TX_USED' bit in desc->ctrl.
 		 */
@@ -2558,7 +2583,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 		return ret;
 	}
 
-	if (macb_dma_ptp(bp) &&
+	if (macb_dma_ptp(bp->caps) &&
 	    (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
 		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 
@@ -2645,7 +2670,7 @@ static unsigned int macb_rx_buffer_size(struct macb *bp, unsigned int mtu)
 {
 	unsigned int size;
 
-	if (!macb_is_gem(bp)) {
+	if (!macb_is_gem(bp->caps)) {
 		size = MACB_RX_BUFFER_SIZE;
 	} else {
 		size = mtu + ETH_HLEN + ETH_FCS_LEN + NET_IP_ALIGN;
@@ -2663,33 +2688,32 @@ static unsigned int macb_rx_buffer_size(struct macb *bp, unsigned int mtu)
 	return size;
 }
 
-static void gem_free_rx_buffers(struct macb *bp)
+static void gem_free_rx_buffers(struct macb_context *ctx)
 {
+	struct device *dev = &ctx->info->pdev->dev;
 	struct macb_dma_desc *desc;
-	struct macb_queue *queue;
 	struct macb_rxq *rxq;
 	struct sk_buff *skb;
 	dma_addr_t addr;
 	unsigned int q;
 	int i;
 
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		rxq = &bp->ctx->rxq[q];
+	for (q = 0; q < ctx->info->num_queues; ++q) {
+		rxq = &ctx->rxq[q];
 
 		if (!rxq->skbuff)
 			continue;
 
-		for (i = 0; i < bp->ctx->rx_ring_size; i++) {
+		for (i = 0; i < ctx->rx_ring_size; i++) {
 			skb = rxq->skbuff[i];
 
 			if (!skb)
 				continue;
 
-			desc = macb_rx_desc(queue, i);
-			addr = macb_get_addr(bp, desc);
+			desc = macb_rx_desc(ctx, q, i);
+			addr = macb_get_addr(ctx, desc);
 
-			dma_unmap_single(&bp->pdev->dev, addr,
-					 bp->ctx->rx_buffer_size,
+			dma_unmap_single(dev, addr, ctx->rx_buffer_size,
 					 DMA_FROM_DEVICE);
 			dev_kfree_skb_any(skb);
 			skb = NULL;
@@ -2700,52 +2724,52 @@ static void gem_free_rx_buffers(struct macb *bp)
 	}
 }
 
-static void macb_free_rx_buffers(struct macb *bp)
+static void macb_free_rx_buffers(struct macb_context *ctx)
 {
-	struct macb_rxq *rxq = &bp->ctx->rxq[0];
+	struct device *dev = &ctx->info->pdev->dev;
+	struct macb_rxq *rxq = &ctx->rxq[0];
 
 	if (rxq->buffers) {
-		dma_free_coherent(&bp->pdev->dev,
-				  bp->ctx->rx_ring_size *
-					bp->ctx->rx_buffer_size,
+		dma_free_coherent(dev,
+				  ctx->rx_ring_size * ctx->rx_buffer_size,
 				  rxq->buffers, rxq->buffers_dma);
 		rxq->buffers = NULL;
 	}
 }
 
-static unsigned int macb_tx_ring_size_per_queue(struct macb *bp)
+static unsigned int macb_tx_ring_size_per_queue(struct macb_context *ctx)
 {
-	return macb_dma_desc_get_size(bp) * bp->ctx->tx_ring_size +
-		bp->tx_bd_rd_prefetch;
+	return macb_dma_desc_get_size(ctx->info->caps) * ctx->tx_ring_size +
+			ctx->info->tx_bd_rd_prefetch;
 }
 
-static unsigned int macb_rx_ring_size_per_queue(struct macb *bp)
+static unsigned int macb_rx_ring_size_per_queue(struct macb_context *ctx)
 {
-	return macb_dma_desc_get_size(bp) * bp->ctx->rx_ring_size +
-		bp->rx_bd_rd_prefetch;
+	return macb_dma_desc_get_size(ctx->info->caps) * ctx->rx_ring_size +
+			ctx->info->rx_bd_rd_prefetch;
 }
 
-static void macb_free_consistent(struct macb *bp)
+static void macb_free_consistent(struct macb_context *ctx)
 {
-	struct device *dev = &bp->pdev->dev;
+	struct device *dev = &ctx->info->pdev->dev;
 	struct macb_txq *txq;
 	struct macb_rxq *rxq;
 	unsigned int q;
 	size_t size;
 
-	bp->macbgem_ops.mog_free_rx_buffers(bp);
+	ctx->info->macbgem_ops.mog_free_rx_buffers(ctx);
 
-	txq = &bp->ctx->txq[0];
-	size = bp->num_queues * macb_tx_ring_size_per_queue(bp);
+	txq = &ctx->txq[0];
+	size = ctx->info->num_queues * macb_tx_ring_size_per_queue(ctx);
 	dma_free_coherent(dev, size, txq->ring, txq->ring_dma);
 
-	rxq = &bp->ctx->rxq[0];
-	size = bp->num_queues * macb_rx_ring_size_per_queue(bp);
+	rxq = &ctx->rxq[0];
+	size = ctx->info->num_queues * macb_rx_ring_size_per_queue(ctx);
 	dma_free_coherent(dev, size, rxq->ring, rxq->ring_dma);
 
-	for (q = 0; q < bp->num_queues; ++q) {
-		txq = &bp->ctx->txq[q];
-		rxq = &bp->ctx->rxq[q];
+	for (q = 0; q < ctx->info->num_queues; ++q) {
+		txq = &ctx->txq[q];
+		rxq = &ctx->rxq[q];
 
 		kfree(txq->skb);
 		txq->skb = NULL;
@@ -2754,46 +2778,48 @@ static void macb_free_consistent(struct macb *bp)
 	}
 }
 
-static int gem_alloc_rx_buffers(struct macb *bp)
+static int gem_alloc_rx_buffers(struct macb_context *ctx)
 {
 	struct macb_rxq *rxq;
 	unsigned int q;
 	int size;
 
-	for (q = 0; q < bp->num_queues; ++q) {
-		rxq = &bp->ctx->rxq[q];
-		size = bp->ctx->rx_ring_size * sizeof(struct sk_buff *);
+	for (q = 0; q < ctx->info->num_queues; ++q) {
+		rxq = &ctx->rxq[q];
+		size = ctx->rx_ring_size * sizeof(struct sk_buff *);
 		rxq->skbuff = kzalloc(size, GFP_KERNEL);
 		if (!rxq->skbuff)
 			return -ENOMEM;
 		else
-			netdev_dbg(bp->netdev,
+			netdev_dbg(ctx->info->netdev,
 				   "Allocated %d RX struct sk_buff entries at %p\n",
-				   bp->ctx->rx_ring_size, rxq->skbuff);
+				   ctx->rx_ring_size, rxq->skbuff);
 	}
 	return 0;
 }
 
-static int macb_alloc_rx_buffers(struct macb *bp)
+static int macb_alloc_rx_buffers(struct macb_context *ctx)
 {
-	struct macb_rxq *rxq = &bp->ctx->rxq[0];
+	struct device *dev = &ctx->info->pdev->dev;
+	struct macb_rxq *rxq = &ctx->rxq[0];
 	int size;
 
-	size = bp->ctx->rx_ring_size * bp->ctx->rx_buffer_size;
-	rxq->buffers = dma_alloc_coherent(&bp->pdev->dev, size,
+	size = ctx->rx_ring_size * ctx->rx_buffer_size;
+	rxq->buffers = dma_alloc_coherent(dev, size,
 					  &rxq->buffers_dma, GFP_KERNEL);
 	if (!rxq->buffers)
 		return -ENOMEM;
 
-	netdev_dbg(bp->netdev,
+	netdev_dbg(ctx->info->netdev,
 		   "Allocated RX buffers of %d bytes at %08lx (mapped %p)\n",
 		   size, (unsigned long)rxq->buffers_dma, rxq->buffers);
 	return 0;
 }
 
-static int macb_alloc_consistent(struct macb *bp)
+static int macb_alloc_consistent(struct macb_context *ctx)
 {
-	struct device *dev = &bp->pdev->dev;
+	unsigned int num_queues = ctx->info->num_queues;
+	struct device *dev = &ctx->info->pdev->dev;
 	dma_addr_t tx_dma, rx_dma;
 	struct macb_txq *txq;
 	struct macb_rxq *rxq;
@@ -2808,89 +2834,90 @@ static int macb_alloc_consistent(struct macb *bp)
 	 * natural alignment of physical addresses.
 	 */
 
-	size = bp->num_queues * macb_tx_ring_size_per_queue(bp);
+	size = num_queues * macb_tx_ring_size_per_queue(ctx);
 	tx = dma_alloc_coherent(dev, size, &tx_dma, GFP_KERNEL);
 	if (!tx || upper_32_bits(tx_dma) != upper_32_bits(tx_dma + size - 1))
 		goto out_err;
-	netdev_dbg(bp->netdev, "Allocated %zu bytes for %u TX rings at %08lx (mapped %p)\n",
-		   size, bp->num_queues, (unsigned long)tx_dma, tx);
+	netdev_dbg(ctx->info->netdev,
+		   "Allocated %zu bytes for %u TX rings at %08lx (mapped %p)\n",
+		   size, num_queues, (unsigned long)tx_dma, tx);
 
-	size = bp->num_queues * macb_rx_ring_size_per_queue(bp);
+	size = num_queues * macb_rx_ring_size_per_queue(ctx);
 	rx = dma_alloc_coherent(dev, size, &rx_dma, GFP_KERNEL);
 	if (!rx || upper_32_bits(rx_dma) != upper_32_bits(rx_dma + size - 1))
 		goto out_err;
-	netdev_dbg(bp->netdev, "Allocated %zu bytes for %u RX rings at %08lx (mapped %p)\n",
-		   size, bp->num_queues, (unsigned long)rx_dma, rx);
+	netdev_dbg(ctx->info->netdev,
+		   "Allocated %zu bytes for %u RX rings at %08lx (mapped %p)\n",
+		   size, num_queues, (unsigned long)rx_dma, rx);
 
-	for (q = 0; q < bp->num_queues; ++q) {
-		txq = &bp->ctx->txq[q];
-		rxq = &bp->ctx->rxq[q];
+	for (q = 0; q < num_queues; ++q) {
+		txq = &ctx->txq[q];
+		rxq = &ctx->rxq[q];
 
-		txq->ring = tx + macb_tx_ring_size_per_queue(bp) * q;
-		txq->ring_dma = tx_dma + macb_tx_ring_size_per_queue(bp) * q;
+		txq->ring = tx + macb_tx_ring_size_per_queue(ctx) * q;
+		txq->ring_dma = tx_dma + macb_tx_ring_size_per_queue(ctx) * q;
 
-		rxq->ring = rx + macb_rx_ring_size_per_queue(bp) * q;
-		rxq->ring_dma = rx_dma + macb_rx_ring_size_per_queue(bp) * q;
+		rxq->ring = rx + macb_rx_ring_size_per_queue(ctx) * q;
+		rxq->ring_dma = rx_dma + macb_rx_ring_size_per_queue(ctx) * q;
 
-		size = bp->ctx->tx_ring_size * sizeof(struct macb_tx_skb);
+		size = ctx->tx_ring_size * sizeof(struct macb_tx_skb);
 		txq->skb = kmalloc(size, GFP_KERNEL);
 		if (!txq->skb)
 			goto out_err;
 	}
-	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
+	if (ctx->info->macbgem_ops.mog_alloc_rx_buffers(ctx))
 		goto out_err;
 
 	return 0;
 
 out_err:
-	macb_free_consistent(bp);
+	macb_free_consistent(ctx);
 	return -ENOMEM;
 }
 
-static void gem_init_rx_ring(struct macb_queue *queue)
+static void gem_init_rx_ring(struct macb_context *ctx, unsigned int q)
 {
-	struct macb_rxq *rxq = macb_rxq(queue);
+	struct macb_rxq *rxq = &ctx->rxq[q];
 
 	rxq->tail = 0;
 	rxq->prepared_head = 0;
 
-	gem_rx_refill(queue);
+	gem_rx_refill(ctx, q);
 }
 
-static void gem_init_rings(struct macb *bp)
+static void gem_init_rings(struct macb_context *ctx)
 {
-	struct macb_queue *queue;
 	struct macb_dma_desc *desc = NULL;
 	struct macb_txq *txq;
 	unsigned int q;
 	int i;
 
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		txq = &bp->ctx->txq[q];
-		for (i = 0; i < bp->ctx->tx_ring_size; i++) {
-			desc = macb_tx_desc(queue, i);
-			macb_set_addr(bp, desc, 0);
+	for (q = 0; q < ctx->info->num_queues; ++q) {
+		txq = &ctx->txq[q];
+		for (i = 0; i < ctx->tx_ring_size; i++) {
+			desc = macb_tx_desc(ctx, q, i);
+			macb_set_addr(ctx, desc, 0);
 			desc->ctrl = MACB_BIT(TX_USED);
 		}
 		desc->ctrl |= MACB_BIT(TX_WRAP);
 		txq->head = 0;
 		txq->tail = 0;
 
-		gem_init_rx_ring(queue);
+		gem_init_rx_ring(ctx, q);
 	}
 }
 
-static void macb_init_rings(struct macb *bp)
+static void macb_init_rings(struct macb_context *ctx)
 {
-	struct macb_txq *txq = &bp->ctx->txq[0];
+	struct macb_txq *txq = &ctx->txq[0];
 	struct macb_dma_desc *desc = NULL;
 	int i;
 
-	macb_init_rx_ring(&bp->queues[0]);
+	macb_init_rx_ring(ctx, 0);
 
-	for (i = 0; i < bp->ctx->tx_ring_size; i++) {
-		desc = macb_tx_desc(&bp->queues[0], i);
-		macb_set_addr(bp, desc, 0);
+	for (i = 0; i < ctx->tx_ring_size; i++) {
+		desc = macb_tx_desc(ctx, 0, i);
+		macb_set_addr(ctx, desc, 0);
 		desc->ctrl = MACB_BIT(TX_USED);
 	}
 	txq->head = 0;
@@ -2960,7 +2987,7 @@ static u32 macb_mdc_clk_div(struct macb *bp)
 	u32 config;
 	unsigned long pclk_hz;
 
-	if (macb_is_gem(bp))
+	if (macb_is_gem(bp->caps))
 		return gem_mdc_clk_div(bp);
 
 	pclk_hz = clk_get_rate(bp->pclk);
@@ -2982,7 +3009,7 @@ static u32 macb_mdc_clk_div(struct macb *bp)
  */
 static u32 macb_dbw(struct macb *bp)
 {
-	if (!macb_is_gem(bp))
+	if (!macb_is_gem(bp->caps))
 		return 0;
 
 	switch (GEM_BFEXT(DBWDEF, gem_readl(bp, DCFG1))) {
@@ -3011,7 +3038,7 @@ static void macb_configure_dma(struct macb *bp)
 	u32 dmacfg;
 
 	buffer_size = bp->ctx->rx_buffer_size / RX_BUFFER_MULTIPLE;
-	if (macb_is_gem(bp)) {
+	if (macb_is_gem(bp->caps)) {
 		dmacfg = gem_readl(bp, DMACFG) & ~GEM_BF(RXBS, -1L);
 		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 			if (q)
@@ -3035,9 +3062,9 @@ static void macb_configure_dma(struct macb *bp)
 			dmacfg &= ~GEM_BIT(TXCOEN);
 
 		dmacfg &= ~GEM_BIT(ADDR64);
-		if (macb_dma64(bp))
+		if (macb_dma64(bp->caps))
 			dmacfg |= GEM_BIT(ADDR64);
-		if (macb_dma_ptp(bp))
+		if (macb_dma_ptp(bp->caps))
 			dmacfg |= GEM_BIT(RXEXT) | GEM_BIT(TXEXT);
 		netdev_dbg(bp->netdev, "Cadence configure DMA with 0x%08x\n",
 			   dmacfg);
@@ -3065,7 +3092,7 @@ static void macb_init_hw(struct macb *bp)
 		config |= MACB_BIT(BIG);	/* Receive oversized frames */
 	if (bp->netdev->flags & IFF_PROMISC)
 		config |= MACB_BIT(CAF);	/* Copy All Frames */
-	else if (macb_is_gem(bp) && bp->netdev->features & NETIF_F_RXCSUM)
+	else if (macb_is_gem(bp->caps) && bp->netdev->features & NETIF_F_RXCSUM)
 		config |= GEM_BIT(RXCOEN);
 	if (!(bp->netdev->flags & IFF_BROADCAST))
 		config |= MACB_BIT(NBC);	/* No BroadCast */
@@ -3173,14 +3200,14 @@ static void macb_set_rx_mode(struct net_device *netdev)
 		cfg |= MACB_BIT(CAF);
 
 		/* Disable RX checksum offload */
-		if (macb_is_gem(bp))
+		if (macb_is_gem(bp->caps))
 			cfg &= ~GEM_BIT(RXCOEN);
 	} else {
 		/* Disable promiscuous mode */
 		cfg &= ~MACB_BIT(CAF);
 
 		/* Enable RX checksum offload only if requested */
-		if (macb_is_gem(bp) && netdev->features & NETIF_F_RXCSUM)
+		if (macb_is_gem(bp->caps) && netdev->features & NETIF_F_RXCSUM)
 			cfg |= GEM_BIT(RXCOEN);
 	}
 
@@ -3222,19 +3249,21 @@ static int macb_open(struct net_device *netdev)
 		goto pm_exit;
 	}
 
+	bp->ctx->info = &bp->info;
+
 	/* RX buffers initialization */
 	bp->ctx->rx_buffer_size = macb_rx_buffer_size(bp, netdev->mtu);
 	bp->ctx->rx_ring_size = bp->configured_rx_ring_size;
 	bp->ctx->tx_ring_size = bp->configured_tx_ring_size;
 
-	err = macb_alloc_consistent(bp);
+	err = macb_alloc_consistent(bp->ctx);
 	if (err) {
 		netdev_err(netdev, "Unable to allocate DMA memory (error %d)\n",
 			   err);
 		goto free_ctx;
 	}
 
-	bp->macbgem_ops.mog_init_rings(bp);
+	bp->macbgem_ops.mog_init_rings(bp->ctx);
 	macb_init_buffers(bp);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
@@ -3272,7 +3301,7 @@ static int macb_open(struct net_device *netdev)
 		napi_disable(&queue->napi_rx);
 		napi_disable(&queue->napi_tx);
 	}
-	macb_free_consistent(bp);
+	macb_free_consistent(bp->ctx);
 free_ctx:
 	kfree(bp->ctx);
 	bp->ctx = NULL;
@@ -3308,7 +3337,7 @@ static int macb_close(struct net_device *netdev)
 	netif_carrier_off(netdev);
 	spin_unlock_irqrestore(&bp->lock, flags);
 
-	macb_free_consistent(bp);
+	macb_free_consistent(bp->ctx);
 	kfree(bp->ctx);
 	bp->ctx = NULL;
 
@@ -3461,7 +3490,7 @@ static void macb_get_stats(struct net_device *netdev,
 	struct macb_stats *hwstat = &bp->hw_stats.macb;
 
 	netdev_stats_to_stats64(nstat, &bp->netdev->stats);
-	if (macb_is_gem(bp)) {
+	if (macb_is_gem(bp->caps)) {
 		gem_get_stats(bp, nstat);
 		return;
 	}
@@ -3684,8 +3713,8 @@ static void macb_get_regs(struct net_device *netdev, struct ethtool_regs *regs,
 	regs->version = (macb_readl(bp, MID) & ((1 << MACB_REV_SIZE) - 1))
 			| MACB_GREGS_VERSION;
 
-	tail = macb_tx_ring_wrap(bp, txq->tail);
-	head = macb_tx_ring_wrap(bp, txq->head);
+	tail = macb_tx_ring_wrap(bp->ctx, txq->tail);
+	head = macb_tx_ring_wrap(bp->ctx, txq->head);
 
 	regs_buff[0]  = macb_readl(bp, NCR);
 	regs_buff[1]  = macb_or_gem_readl(bp, NCFGR);
@@ -3703,7 +3732,7 @@ static void macb_get_regs(struct net_device *netdev, struct ethtool_regs *regs,
 
 	if (!(bp->caps & MACB_CAPS_USRIO_DISABLED))
 		regs_buff[12] = macb_or_gem_readl(bp, USRIO);
-	if (macb_is_gem(bp))
+	if (macb_is_gem(bp->caps))
 		regs_buff[13] = gem_readl(bp, DMACFG);
 }
 
@@ -3835,7 +3864,7 @@ static int gem_get_ts_info(struct net_device *netdev,
 {
 	struct macb *bp = netdev_priv(netdev);
 
-	if (!macb_dma_ptp(bp)) {
+	if (!macb_dma_ptp(bp->caps)) {
 		ethtool_op_get_ts_info(netdev, info);
 		return 0;
 	}
@@ -3936,7 +3965,7 @@ static void gem_prog_cmp_regs(struct macb *bp, struct ethtool_rx_flow_spec *fs)
 	bool cmp_b = false;
 	bool cmp_c = false;
 
-	if (!macb_is_gem(bp))
+	if (!macb_is_gem(bp->caps))
 		return;
 
 	tp4sp_v = &(fs->h_u.tcp_ip4_spec);
@@ -4297,7 +4326,7 @@ static inline void macb_set_txcsum_feature(struct macb *bp,
 {
 	u32 val;
 
-	if (!macb_is_gem(bp))
+	if (!macb_is_gem(bp->caps))
 		return;
 
 	val = gem_readl(bp, DMACFG);
@@ -4315,7 +4344,7 @@ static inline void macb_set_rxcsum_feature(struct macb *bp,
 	struct net_device *netdev = bp->netdev;
 	u32 val;
 
-	if (!macb_is_gem(bp))
+	if (!macb_is_gem(bp->caps))
 		return;
 
 	val = gem_readl(bp, NCFGR);
@@ -4330,7 +4359,7 @@ static inline void macb_set_rxcsum_feature(struct macb *bp,
 static inline void macb_set_rxflow_feature(struct macb *bp,
 					   netdev_features_t features)
 {
-	if (!macb_is_gem(bp))
+	if (!macb_is_gem(bp->caps))
 		return;
 
 	gem_enable_flow_filters(bp, !!(features & NETIF_F_NTUPLE));
@@ -4649,7 +4678,7 @@ static void macb_configure_caps(struct macb *bp,
 			bp->caps |= MACB_CAPS_FIFO_MODE;
 		if (GEM_BFEXT(PBUF_RSC, gem_readl(bp, DCFG6)))
 			bp->caps |= MACB_CAPS_RSC;
-		if (gem_has_ptp(bp)) {
+		if (gem_has_ptp(bp->caps)) {
 			if (!GEM_BFEXT(TSU, gem_readl(bp, DCFG5)))
 				dev_err(&bp->pdev->dev,
 					"GEM doesn't support hardware ptp.\n");
@@ -4861,7 +4890,7 @@ static int macb_init_dflt(struct platform_device *pdev)
 	netdev->netdev_ops = &macb_netdev_ops;
 
 	/* setup appropriated routines according to adapter type */
-	if (macb_is_gem(bp)) {
+	if (macb_is_gem(bp->caps)) {
 		bp->macbgem_ops.mog_alloc_rx_buffers = gem_alloc_rx_buffers;
 		bp->macbgem_ops.mog_free_rx_buffers = gem_free_rx_buffers;
 		bp->macbgem_ops.mog_init_rings = gem_init_rings;
@@ -4890,7 +4919,7 @@ static int macb_init_dflt(struct platform_device *pdev)
 		netdev->hw_features |= MACB_NETIF_LSO;
 
 	/* Checksum offload is only available on gem with packet buffer */
-	if (macb_is_gem(bp) && !(bp->caps & MACB_CAPS_FIFO_MODE))
+	if (macb_is_gem(bp->caps) && !(bp->caps & MACB_CAPS_FIFO_MODE))
 		netdev->hw_features |= NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
 	if (bp->caps & MACB_CAPS_SG_DISABLED)
 		netdev->hw_features &= ~NETIF_F_SG;
@@ -5009,7 +5038,7 @@ static int at91ether_alloc_coherent(struct macb *bp)
 
 	rxq->ring = dma_alloc_coherent(&bp->pdev->dev,
 				       (AT91ETHER_MAX_RX_DESCR *
-					macb_dma_desc_get_size(bp)),
+				       macb_dma_desc_get_size(bp->caps)),
 				       &rxq->ring_dma, GFP_KERNEL);
 	if (!rxq->ring)
 		return -ENOMEM;
@@ -5022,7 +5051,7 @@ static int at91ether_alloc_coherent(struct macb *bp)
 	if (!rxq->buffers) {
 		dma_free_coherent(&bp->pdev->dev,
 				  AT91ETHER_MAX_RX_DESCR *
-				  macb_dma_desc_get_size(bp),
+				  macb_dma_desc_get_size(bp->caps),
 				  rxq->ring, rxq->ring_dma);
 		rxq->ring = NULL;
 		return -ENOMEM;
@@ -5038,7 +5067,7 @@ static void at91ether_free_coherent(struct macb *bp)
 	if (rxq->ring) {
 		dma_free_coherent(&bp->pdev->dev,
 				  AT91ETHER_MAX_RX_DESCR *
-				  macb_dma_desc_get_size(bp),
+				  macb_dma_desc_get_size(bp->caps),
 				  rxq->ring, rxq->ring_dma);
 		rxq->ring = NULL;
 	}
@@ -5055,7 +5084,6 @@ static void at91ether_free_coherent(struct macb *bp)
 /* Initialize and start the Receiver and Transmit subsystems */
 static int at91ether_start(struct macb *bp)
 {
-	struct macb_queue *queue = &bp->queues[0];
 	struct macb_rxq *rxq = &bp->ctx->rxq[0];
 	struct macb_dma_desc *desc;
 	dma_addr_t addr;
@@ -5068,8 +5096,8 @@ static int at91ether_start(struct macb *bp)
 
 	addr = rxq->buffers_dma;
 	for (i = 0; i < AT91ETHER_MAX_RX_DESCR; i++) {
-		desc = macb_rx_desc(queue, i);
-		macb_set_addr(bp, desc, addr);
+		desc = macb_rx_desc(bp->ctx, 0, i);
+		macb_set_addr(bp->ctx, desc, addr);
 		desc->ctrl = 0;
 		addr += AT91ETHER_MAX_RBUFF_SZ;
 	}
@@ -5218,14 +5246,13 @@ static netdev_tx_t at91ether_start_xmit(struct sk_buff *skb,
 static void at91ether_rx(struct net_device *netdev)
 {
 	struct macb *bp = netdev_priv(netdev);
-	struct macb_queue *queue = &bp->queues[0];
 	struct macb_rxq *rxq = &bp->ctx->rxq[0];
 	struct macb_dma_desc *desc;
 	unsigned char *p_recv;
 	struct sk_buff *skb;
 	unsigned int pktlen;
 
-	desc = macb_rx_desc(queue, rxq->tail);
+	desc = macb_rx_desc(bp->ctx, 0, rxq->tail);
 	while (desc->addr & MACB_BIT(RX_USED)) {
 		p_recv = rxq->buffers + rxq->tail * AT91ETHER_MAX_RBUFF_SZ;
 		pktlen = MACB_BF(RX_FRMLEN, desc->ctrl);
@@ -5254,7 +5281,7 @@ static void at91ether_rx(struct net_device *netdev)
 		else
 			rxq->tail++;
 
-		desc = macb_rx_desc(queue, rxq->tail);
+		desc = macb_rx_desc(bp->ctx, 0, rxq->tail);
 	}
 }
 
@@ -5584,7 +5611,7 @@ static int macb_alloc_tieoff(struct macb *bp)
 		return 0;
 
 	bp->rx_ring_tieoff = dma_alloc_coherent(&bp->pdev->dev,
-						macb_dma_desc_get_size(bp),
+						macb_dma_desc_get_size(bp->caps),
 						&bp->rx_ring_tieoff_dma,
 						GFP_KERNEL);
 	if (!bp->rx_ring_tieoff)
@@ -5598,7 +5625,7 @@ static void macb_free_tieoff(struct macb *bp)
 	if (!bp->rx_ring_tieoff)
 		return;
 
-	dma_free_coherent(&bp->pdev->dev, macb_dma_desc_get_size(bp),
+	dma_free_coherent(&bp->pdev->dev, macb_dma_desc_get_size(bp->caps),
 			  bp->rx_ring_tieoff,
 			  bp->rx_ring_tieoff_dma);
 	bp->rx_ring_tieoff = NULL;
@@ -5986,12 +6013,12 @@ static int macb_probe(struct platform_device *pdev)
 		val = GEM_BFEXT(RXBD_RDBUFF, gem_readl(bp, DCFG10));
 		if (val)
 			bp->rx_bd_rd_prefetch = (2 << (val - 1)) *
-						macb_dma_desc_get_size(bp);
+						macb_dma_desc_get_size(bp->caps);
 
 		val = GEM_BFEXT(TXBD_RDBUFF, gem_readl(bp, DCFG10));
 		if (val)
 			bp->tx_bd_rd_prefetch = (2 << (val - 1)) *
-						macb_dma_desc_get_size(bp);
+						macb_dma_desc_get_size(bp->caps);
 	}
 
 	bp->rx_intr_mask = MACB_RX_INT_FLAGS;
@@ -6036,7 +6063,7 @@ static int macb_probe(struct platform_device *pdev)
 	INIT_DELAYED_WORK(&bp->tx_lpi_work, macb_tx_lpi_work_fn);
 
 	netdev_info(netdev, "Cadence %s rev 0x%08x at 0x%08lx irq %d (%pM)\n",
-		    macb_is_gem(bp) ? "GEM" : "MACB", macb_readl(bp, MID),
+		    macb_is_gem(bp->caps) ? "GEM" : "MACB", macb_readl(bp, MID),
 		    netdev->base_addr, netdev->irq, netdev->dev_addr);
 
 	pm_runtime_put_autosuspend(&bp->pdev->dev);
@@ -6171,7 +6198,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 		 * Enable WoL IRQ on queue 0
 		 */
 		devm_free_irq(dev, bp->queues[0].irq, bp->queues);
-		if (macb_is_gem(bp)) {
+		if (macb_is_gem(bp->caps)) {
 			err = devm_request_irq(dev, bp->queues[0].irq, gem_wol_interrupt,
 					       IRQF_SHARED, netdev->name, bp->queues);
 			if (err) {
@@ -6236,6 +6263,7 @@ static int __maybe_unused macb_resume(struct device *dev)
 {
 	struct net_device *netdev = dev_get_drvdata(dev);
 	struct macb *bp = netdev_priv(netdev);
+	struct macb_context *ctx = bp->ctx;
 	struct macb_queue *queue;
 	unsigned long flags;
 	unsigned int q;
@@ -6253,7 +6281,7 @@ static int __maybe_unused macb_resume(struct device *dev)
 	if (bp->wol & MACB_WOL_ENABLED) {
 		spin_lock_irqsave(&bp->lock, flags);
 		/* Disable WoL */
-		if (macb_is_gem(bp)) {
+		if (macb_is_gem(bp->caps)) {
 			queue_writel(bp->queues, IDR, GEM_BIT(WOL));
 			gem_writel(bp, WOL, 0);
 		} else {
@@ -6293,10 +6321,10 @@ static int __maybe_unused macb_resume(struct device *dev)
 	for (q = 0, queue = bp->queues; q < bp->num_queues;
 	     ++q, ++queue) {
 		if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC)) {
-			if (macb_is_gem(bp))
-				gem_init_rx_ring(queue);
+			if (macb_is_gem(bp->caps))
+				gem_init_rx_ring(ctx, q);
 			else
-				macb_init_rx_ring(queue);
+				macb_init_rx_ring(ctx, q);
 		}
 
 		napi_enable(&queue->napi_rx);
diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index e5195d7dac1d..2070508fd2e0 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -28,10 +28,10 @@
 static struct macb_dma_desc_ptp *macb_ptp_desc(struct macb *bp,
 					       struct macb_dma_desc *desc)
 {
-	if (!macb_dma_ptp(bp))
+	if (!macb_dma_ptp(bp->caps))
 		return NULL;
 
-	if (macb_dma64(bp))
+	if (macb_dma64(bp->caps))
 		return (struct macb_dma_desc_ptp *)
 				((u8 *)desc + sizeof(struct macb_dma_desc)
 				+ sizeof(struct macb_dma_desc_64));
@@ -384,7 +384,7 @@ int gem_get_hwtst(struct net_device *netdev,
 	struct macb *bp = netdev_priv(netdev);
 
 	*tstamp_config = bp->tstamp_config;
-	if (!macb_dma_ptp(bp))
+	if (!macb_dma_ptp(bp->caps))
 		return -EOPNOTSUPP;
 
 	return 0;
@@ -411,7 +411,7 @@ int gem_set_hwtst(struct net_device *netdev,
 	struct macb *bp = netdev_priv(netdev);
 	u32 regval;
 
-	if (!macb_dma_ptp(bp))
+	if (!macb_dma_ptp(bp->caps))
 		return -EOPNOTSUPP;
 
 	switch (tstamp_config->tx_type) {

-- 
2.53.0


