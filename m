Return-Path: <netdev+bounces-303743-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k/VtABU7RWrR8woAu9opvQ
	(envelope-from <netdev+bounces-303743-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:06:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D416EF7F7
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:06:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=XGbopPKC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303743-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303743-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6FEFF3039515
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 16:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894BA495510;
	Wed,  1 Jul 2026 15:59:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77BB4A2E12
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 15:59:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921588; cv=none; b=hcH/JoO+VTEizx8EVIqLp4qbqOvxr7fe+gjfhn8oKnN1qi8L0qu9ugwHw8AbCgyDTDAZTN02lqZQHA3AVqHJLd+X633kNmJt8bT7F33UqXBCJdr+i8GSM+Ld3oU247wlHevJbPuq/C4YwgchJxT7/Jw+W/w6BWb8Y5NI4zZwmZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921588; c=relaxed/simple;
	bh=sA4ZraL9NLbB4gQrhws1xpBKH7dKKQoQ08UXcJxSzMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cth34emMh6oVWPemU7f9eQPjFaPIi94KWH+2VrxGTkIDo4eQjDXTwgxs2361vvFJxHwE3tXIwnwocu0TjWMYwdMpAZw5B2wVSN2r9H2BpB81RHsCEVjW5nhyhUvdNT9klez+ShbkBpUvr5v56FrGzGzOOPivx7qEPp+qDwxK+no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XGbopPKC; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1E3474E40BF5;
	Wed,  1 Jul 2026 15:59:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C2F8460300;
	Wed,  1 Jul 2026 15:59:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C5D55104C968D;
	Wed,  1 Jul 2026 17:59:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782921581; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=r31sonVFa/mUjmpGl1m7S8GHfAOssJmeeRXTzxqfNp4=;
	b=XGbopPKC5fSQGdcaS2DwlsX2DviujM87t0mV3x1dtPnZZrz1KZyoSLDatOW+5eMkCNyv6V
	coxeRmuYID2aKWmnSJWjxqmci07W/5V5dF16QCNjfezFq6Gscdf/T1rbVWPXG4jD+h/uTn
	wYXQKOi/VRqhDWmfDTcqIAvm+9aDDdA03phv1a2pt3FFKMZsMFbwW0YAb8KbX1KRRsDPaW
	28NgesBYByvoPFOakgMn/KW747rEp/3CruAzoCN2xRj9UhT0l6kd2vW/Vt6euefYCgeTzV
	udf0FcAuk/94cVSitkOr+6DSEqdA4NrvGXmOuGLXWT6MZ5hVQMkXAzju0nyQRw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 01 Jul 2026 17:59:14 +0200
Subject: [PATCH net-next v3 11/15] net: macb: change function signatures to
 take contexts
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260701-macb-context-v3-11-00268d5b1502@bootlin.com>
References: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
In-Reply-To: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Paolo Valerio <pvalerio@redhat.com>, Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303743-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:theo.lebrun@bootlin.com,m:conor.dooley@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:pvalerio@redhat.com,m:nb@tipi-net.de,m:vladimir.kondratiev@mobileye.com,m:gregory.clement@bootlin.com,m:benoit.monin@bootlin.com,m:tawfik.bayouk@mobileye.com,m:thomas.petazzoni@bootlin.com,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,bootlin.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9D416EF7F7

For parallel MACB context to start become a reality, many functions need
to stop operating on bp->ctx (the currently active context) and instead
work on a context they get passed. That context might be
(1) the new one that is getting allocated and initialised, or,
(2) the old one to be freed.

To reduce bug surface area, taint those functions to *only* take a
context `struct macb_context *ctx` and no `struct macb *bp`. That way,
no bug of using `bp->ctx` instead of `ctx` will ever occur.

We also convert functions that take a `struct macb_queue *queue` to
instead take `struct macb_context *ctx, unsigned int q`, with q
indexing ctx->txq[] and ctx->rxq[].

Full list:

   macb_adj_dma_desc_idx()
   macb_tx_ring_wrap()
   macb_tx_desc()
   macb_rx_ring_wrap()
   macb_rx_desc()
   macb_get_addr()
   gem_rx_refill()
   macb_init_rx_ring()
   gem_free_rx_buffers()
   macb_free_rx_buffers()
   macb_tx_ring_size_per_queue()
   macb_rx_ring_size_per_queue()
   macb_free()
   gem_alloc_rx_buffers()
   macb_alloc_rx_buffers()
   macb_alloc()
   gem_init_rx_ring()
   gem_init_rings()
   macb_init_rings()

Note about gem_rx_refill(): it ends with a netdev_vdbg() that prints the
queue pointer. Change to print the queue index because we do not have
access to the queue anymore.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      |   7 +-
 drivers/net/ethernet/cadence/macb_main.c | 371 ++++++++++++++++---------------
 2 files changed, 201 insertions(+), 177 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 165763117a8c..db0d0270c88c 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
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
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index e35f4542613b..8163df4719b2 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -138,9 +138,11 @@ static unsigned int macb_dma_desc_get_size(const struct macb_info *info)
 	return desc_size;
 }
 
-static unsigned int macb_adj_dma_desc_idx(struct macb *bp, unsigned int desc_idx)
+static unsigned int macb_adj_dma_desc_idx(struct macb_context *ctx,
+					  unsigned int desc_idx)
 {
-	return desc_idx * (1 + macb_dma64(&bp->info) + macb_dma_ptp(&bp->info));
+	return desc_idx * (1 + macb_dma64(ctx->info) +
+			       macb_dma_ptp(ctx->info));
 }
 
 static struct macb_dma_desc_64 *macb_64b_desc(struct macb_dma_desc *desc)
@@ -150,9 +152,10 @@ static struct macb_dma_desc_64 *macb_64b_desc(struct macb_dma_desc *desc)
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
@@ -171,14 +174,13 @@ static struct macb_rxq *macb_rxq(struct macb_queue *queue)
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
@@ -186,40 +188,42 @@ static struct macb_tx_skb *macb_tx_skb(struct macb_queue *queue,
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
+	offset = macb_tx_ring_wrap(ctx, index) *
 			macb_dma_desc_get_size(&queue->bp->info);
 
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
@@ -828,13 +832,14 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
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
 
-	desc_size = macb_dma_desc_get_size(&bp->info);
+	desc_size = macb_dma_desc_get_size(&queue->bp->info);
 
 	if (WARN_ON_ONCE(desc_size > ARRAY_SIZE(desc)))
 		return;
@@ -842,7 +847,7 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 	head = txq->head;
 	tail = txq->tail;
-	ring_size = bp->ctx->tx_ring_size;
+	ring_size = ctx->tx_ring_size;
 	count = CIRC_CNT(head, tail, ring_size);
 
 	if (!(tail % ring_size))
@@ -858,7 +863,7 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 	cycles = gcd(ring_size, shift);
 
 	for (i = 0; i < cycles; i++) {
-		memcpy(&desc, macb_tx_desc(queue, i), desc_size);
+		memcpy(&desc, macb_tx_desc(ctx, q, i), desc_size);
 		memcpy(&tx_skb, macb_tx_skb(queue, i),
 		       sizeof(struct macb_tx_skb));
 
@@ -866,8 +871,8 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 		next = (curr + shift) % ring_size;
 
 		while (next != i) {
-			desc_curr = macb_tx_desc(queue, curr);
-			desc_next = macb_tx_desc(queue, next);
+			desc_curr = macb_tx_desc(ctx, q, curr);
+			desc_next = macb_tx_desc(ctx, q, next);
 
 			memcpy(desc_curr, desc_next, desc_size);
 
@@ -884,7 +889,7 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 			next = (curr + shift) % ring_size;
 		}
 
-		desc_curr = macb_tx_desc(queue, curr);
+		desc_curr = macb_tx_desc(ctx, q, curr);
 		memcpy(desc_curr, &desc, desc_size);
 		if (i == ring_size - 1)
 			desc_curr->ctrl &= ~MACB_BIT(TX_WRAP);
@@ -1269,19 +1274,19 @@ static void macb_set_addr(const struct macb_info *info,
 	desc->addr = lower_32_bits(addr);
 }
 
-static dma_addr_t macb_get_addr(const struct macb_info *info,
+static dma_addr_t macb_get_addr(struct macb_context *ctx,
 				struct macb_dma_desc *desc)
 {
 	dma_addr_t addr = 0;
 
-	if (macb_dma64(info)) {
+	if (macb_dma64(ctx->info)) {
 		struct macb_dma_desc_64 *desc_64;
 
 		desc_64 = macb_64b_desc(desc);
 		addr = ((u64)(desc_64->addrh) << 32);
 	}
 	addr |= MACB_BF(RX_WADDR, MACB_BFEXT(RX_WADDR, desc->addr));
-	if (macb_dma_ptp(info))
+	if (macb_dma_ptp(ctx->info))
 		addr &= ~GEM_BIT(DMA_RXVALID);
 	return addr;
 }
@@ -1291,6 +1296,7 @@ static void macb_tx_error_task(struct work_struct *work)
 	struct macb_queue *queue = container_of(work, struct macb_queue,
 						tx_error_task);
 	unsigned int q = queue - queue->bp->queues;
+	struct macb_context *ctx = queue->bp->ctx;
 	struct macb_txq *txq = macb_txq(queue);
 	struct macb *bp = queue->bp;
 	struct macb_tx_skb *tx_skb;
@@ -1333,7 +1339,7 @@ static void macb_tx_error_task(struct work_struct *work)
 	for (tail = txq->tail; tail != txq->head; tail++) {
 		u32	ctrl;
 
-		desc = macb_tx_desc(queue, tail);
+		desc = macb_tx_desc(ctx, q, tail);
 		ctrl = desc->ctrl;
 		tx_skb = macb_tx_skb(queue, tail);
 		skb = tx_skb->skb;
@@ -1352,7 +1358,7 @@ static void macb_tx_error_task(struct work_struct *work)
 			 */
 			if (!(ctrl & MACB_BIT(TX_BUF_EXHAUSTED))) {
 				netdev_vdbg(bp->netdev, "txerr skb %u (data %p) TX complete\n",
-					    macb_tx_ring_wrap(bp, tail),
+					    macb_tx_ring_wrap(ctx, tail),
 					    skb->data);
 				bp->netdev->stats.tx_packets++;
 				queue->stats.tx_packets++;
@@ -1380,7 +1386,7 @@ static void macb_tx_error_task(struct work_struct *work)
 				  packets, bytes);
 
 	/* Set end of TX queue */
-	desc = macb_tx_desc(queue, 0);
+	desc = macb_tx_desc(ctx, q, 0);
 	macb_set_addr(&bp->info, desc, 0);
 	desc->ctrl = MACB_BIT(TX_USED);
 
@@ -1443,6 +1449,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	struct macb *bp = queue->bp;
 	struct macb_txq *txq = macb_txq(queue);
 	unsigned int q = queue - bp->queues;
+	struct macb_context *ctx = bp->ctx;
 	unsigned long flags;
 	unsigned int tail;
 	unsigned int head;
@@ -1457,7 +1464,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 		struct macb_dma_desc	*desc;
 		u32			ctrl;
 
-		desc = macb_tx_desc(queue, tail);
+		desc = macb_tx_desc(ctx, q, tail);
 
 		/* Make hw descriptor updates visible to CPU */
 		rmb();
@@ -1482,7 +1489,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 					gem_ptp_do_txstamp(bp, skb, desc);
 
 				netdev_vdbg(bp->netdev, "skb %u (data %p) TX complete\n",
-					    macb_tx_ring_wrap(bp, tail),
+					    macb_tx_ring_wrap(ctx, tail),
 					    skb->data);
 				bp->netdev->stats.tx_packets++;
 				queue->stats.tx_packets++;
@@ -1520,53 +1527,53 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
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
-			macb_set_addr(&bp->info, desc, paddr);
+			macb_set_addr(ctx->info, desc, paddr);
 
 			/* Properly align Ethernet header.
 			 *
@@ -1579,7 +1586,7 @@ static void gem_rx_refill(struct macb_queue *queue)
 			 * setting the low 2/3 bits.
 			 * It is 3 bits if HW_DMA_CAP_PTP, else 2 bits.
 			 */
-			if (!(bp->caps & MACB_CAPS_RSC))
+			if (!(ctx->info->caps & MACB_CAPS_RSC))
 				skb_reserve(skb, NET_IP_ALIGN);
 		} else {
 			desc->ctrl = 0;
@@ -1592,18 +1599,21 @@ static void gem_rx_refill(struct macb_queue *queue)
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
@@ -1620,6 +1630,8 @@ static void discard_partial_frame(struct macb_queue *queue, unsigned int begin,
 static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		  int budget)
 {
+	unsigned int q = queue - queue->bp->queues;
+	struct macb_context *ctx = queue->bp->ctx;
 	struct macb_rxq *rxq = macb_rxq(queue);
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
@@ -1633,14 +1645,14 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		dma_addr_t addr;
 		bool rxused;
 
-		entry = macb_rx_ring_wrap(bp, rxq->tail);
-		desc = macb_rx_desc(queue, entry);
+		entry = macb_rx_ring_wrap(ctx, rxq->tail);
+		desc = macb_rx_desc(ctx, q, entry);
 
 		/* Make hw descriptor updates visible to CPU */
 		rmb();
 
 		rxused = (desc->addr & MACB_BIT(RX_USED)) ? true : false;
-		addr = macb_get_addr(&bp->info, desc);
+		addr = macb_get_addr(ctx, desc);
 
 		if (!rxused)
 			break;
@@ -1704,7 +1716,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		napi_gro_receive(napi, skb);
 	}
 
-	gem_rx_refill(queue);
+	gem_rx_refill(ctx, q);
 
 	return count;
 }
@@ -1712,6 +1724,8 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 static int macb_rx_frame(struct macb_queue *queue, struct napi_struct *napi,
 			 unsigned int first_frag, unsigned int last_frag)
 {
+	unsigned int q = queue - queue->bp->queues;
+	struct macb_context *ctx = queue->bp->ctx;
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
 	unsigned int offset;
@@ -1719,12 +1733,12 @@ static int macb_rx_frame(struct macb_queue *queue, struct napi_struct *napi,
 	unsigned int frag;
 	unsigned int len;
 
-	desc = macb_rx_desc(queue, last_frag);
+	desc = macb_rx_desc(ctx, q, last_frag);
 	len = desc->ctrl & bp->rx_frm_len_mask;
 
 	netdev_vdbg(bp->netdev, "macb_rx_frame frags %u - %u (len %u)\n",
-		    macb_rx_ring_wrap(bp, first_frag),
-		    macb_rx_ring_wrap(bp, last_frag), len);
+		    macb_rx_ring_wrap(ctx, first_frag),
+		    macb_rx_ring_wrap(ctx, last_frag), len);
 
 	/* The ethernet header starts NET_IP_ALIGN bytes into the
 	 * first buffer. Since the header is 14 bytes, this makes the
@@ -1738,7 +1752,7 @@ static int macb_rx_frame(struct macb_queue *queue, struct napi_struct *napi,
 	if (!skb) {
 		bp->netdev->stats.rx_dropped++;
 		for (frag = first_frag; ; frag++) {
-			desc = macb_rx_desc(queue, frag);
+			desc = macb_rx_desc(ctx, q, frag);
 			desc->addr &= ~MACB_BIT(RX_USED);
 			if (frag == last_frag)
 				break;
@@ -1769,7 +1783,7 @@ static int macb_rx_frame(struct macb_queue *queue, struct napi_struct *napi,
 					       macb_rx_buffer(queue, frag),
 					       frag_len);
 		offset += bp->ctx->rx_buffer_size;
-		desc = macb_rx_desc(queue, frag);
+		desc = macb_rx_desc(ctx, q, frag);
 		desc->addr &= ~MACB_BIT(RX_USED);
 
 		if (frag == last_frag)
@@ -1791,20 +1805,19 @@ static int macb_rx_frame(struct macb_queue *queue, struct napi_struct *napi,
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
-		macb_set_addr(&bp->info, desc, addr);
+	for (i = 0; i < ctx->rx_ring_size; i++) {
+		desc = macb_rx_desc(ctx, q, i);
+		macb_set_addr(ctx->info, desc, addr);
 		desc->ctrl = 0;
-		addr += bp->ctx->rx_buffer_size;
+		addr += ctx->rx_buffer_size;
 	}
 	desc->addr |= MACB_BIT(RX_WRAP);
 	rxq->tail = 0;
@@ -1813,6 +1826,8 @@ static inline void macb_init_rx_ring(struct macb_queue *queue)
 static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
 		   int budget)
 {
+	unsigned int q = queue - queue->bp->queues;
+	struct macb_context *ctx = queue->bp->ctx;
 	struct macb_rxq *rxq = macb_rxq(queue);
 	struct macb *bp = queue->bp;
 	bool reset_rx_queue = false;
@@ -1821,7 +1836,7 @@ static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
 	int received = 0;
 
 	for (tail = rxq->tail; budget > 0; tail++) {
-		struct macb_dma_desc *desc = macb_rx_desc(queue, tail);
+		struct macb_dma_desc *desc = macb_rx_desc(ctx, q, tail);
 		u32 ctrl;
 
 		/* Make hw descriptor updates visible to CPU */
@@ -1873,7 +1888,7 @@ static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
 		ctrl = macb_readl(bp, NCR);
 		macb_writel(bp, NCR, ctrl & ~MACB_BIT(RE));
 
-		macb_init_rx_ring(queue);
+		macb_init_rx_ring(ctx, q);
 		queue_writel(queue, RBQP, rxq->ring_dma);
 
 		macb_writel(bp, NCR, ctrl | MACB_BIT(RE));
@@ -1892,13 +1907,14 @@ static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
 
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
@@ -1945,6 +1961,7 @@ static int macb_rx_poll(struct napi_struct *napi, int budget)
 
 static void macb_tx_restart(struct macb_queue *queue)
 {
+	struct macb_context *ctx = queue->bp->ctx;
 	struct macb_txq *txq = macb_txq(queue);
 	struct macb *bp = queue->bp;
 	unsigned int head_idx, tbqp;
@@ -1955,9 +1972,9 @@ static void macb_tx_restart(struct macb_queue *queue)
 	if (txq->head == txq->tail)
 		goto out_tx_ptr_unlock;
 
-	tbqp = queue_readl(queue, TBQP) / macb_dma_desc_get_size(&bp->info);
-	tbqp = macb_adj_dma_desc_idx(bp, macb_tx_ring_wrap(bp, tbqp));
-	head_idx = macb_adj_dma_desc_idx(bp, macb_tx_ring_wrap(bp, txq->head));
+	tbqp = queue_readl(queue, TBQP) / macb_dma_desc_get_size(ctx->info);
+	tbqp = macb_adj_dma_desc_idx(ctx, macb_tx_ring_wrap(ctx, tbqp));
+	head_idx = macb_adj_dma_desc_idx(ctx, macb_tx_ring_wrap(ctx, txq->head));
 
 	if (tbqp == head_idx)
 		goto out_tx_ptr_unlock;
@@ -1972,6 +1989,8 @@ static void macb_tx_restart(struct macb_queue *queue)
 
 static bool macb_tx_complete_pending(struct macb_queue *queue)
 {
+	unsigned int q = queue - queue->bp->queues;
+	struct macb_context *ctx = queue->bp->ctx;
 	struct macb_txq *txq = macb_txq(queue);
 	bool retval = false;
 	unsigned long flags;
@@ -1981,7 +2000,7 @@ static bool macb_tx_complete_pending(struct macb_queue *queue)
 		/* Make hw descriptor updates visible to CPU */
 		rmb();
 
-		if (macb_tx_desc(queue, txq->tail)->ctrl & MACB_BIT(TX_USED))
+		if (macb_tx_desc(ctx, q, txq->tail)->ctrl & MACB_BIT(TX_USED))
 			retval = true;
 	}
 	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
@@ -2034,6 +2053,7 @@ static void macb_hresp_error_task(struct work_struct *work)
 {
 	struct macb *bp = from_work(bp, work, hresp_err_bh_work);
 	struct net_device *netdev = bp->netdev;
+	struct macb_context *ctx = bp->ctx;
 	struct macb_queue *queue;
 	unsigned int q;
 	u32 ctrl;
@@ -2050,7 +2070,7 @@ static void macb_hresp_error_task(struct work_struct *work)
 	netif_tx_stop_all_queues(netdev);
 	netif_carrier_off(netdev);
 
-	bp->macbgem_ops.mog_init_rings(bp);
+	bp->macbgem_ops.mog_init_rings(ctx);
 
 	/* Initialize TX and RX buffers */
 	macb_init_buffers(bp);
@@ -2247,6 +2267,8 @@ static unsigned int macb_tx_map(struct macb *bp,
 	unsigned int f, nr_frags = skb_shinfo(skb)->nr_frags;
 	unsigned int len, i, tx_head = txq->head;
 	u32 ctrl, lso_ctrl = 0, seq_ctrl = 0;
+	unsigned int q = queue - bp->queues;
+	struct macb_context *ctx = bp->ctx;
 	unsigned int eof = 1, mss_mfs = 0;
 	struct macb_tx_skb *tx_skb = NULL;
 	struct macb_dma_desc *desc;
@@ -2337,7 +2359,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 	 */
 	i = tx_head;
 	ctrl = MACB_BIT(TX_USED);
-	desc = macb_tx_desc(queue, i);
+	desc = macb_tx_desc(ctx, q, i);
 	desc->ctrl = ctrl;
 
 	if (lso_ctrl) {
@@ -2358,14 +2380,14 @@ static unsigned int macb_tx_map(struct macb *bp,
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
 
@@ -2640,33 +2662,32 @@ static unsigned int macb_rx_buffer_size(struct macb *bp, unsigned int mtu)
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
-			addr = macb_get_addr(&bp->info, desc);
+			desc = macb_rx_desc(ctx, q, i);
+			addr = macb_get_addr(ctx, desc);
 
-			dma_unmap_single(&bp->pdev->dev, addr,
-					 bp->ctx->rx_buffer_size,
+			dma_unmap_single(dev, addr, ctx->rx_buffer_size,
 					 DMA_FROM_DEVICE);
 			dev_kfree_skb_any(skb);
 			skb = NULL;
@@ -2677,52 +2698,52 @@ static void gem_free_rx_buffers(struct macb *bp)
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
-	return macb_dma_desc_get_size(&bp->info) * bp->ctx->tx_ring_size +
-		bp->tx_bd_rd_prefetch;
+	return macb_dma_desc_get_size(ctx->info) * ctx->tx_ring_size +
+			ctx->info->tx_bd_rd_prefetch;
 }
 
-static unsigned int macb_rx_ring_size_per_queue(struct macb *bp)
+static unsigned int macb_rx_ring_size_per_queue(struct macb_context *ctx)
 {
-	return macb_dma_desc_get_size(&bp->info) * bp->ctx->rx_ring_size +
-		bp->rx_bd_rd_prefetch;
+	return macb_dma_desc_get_size(ctx->info) * ctx->rx_ring_size +
+			ctx->info->rx_bd_rd_prefetch;
 }
 
-static void macb_free(struct macb *bp)
+static void macb_free(struct macb_context *ctx)
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
@@ -2731,46 +2752,48 @@ static void macb_free(struct macb *bp)
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
 
-static int macb_alloc(struct macb *bp)
+static int macb_alloc(struct macb_context *ctx)
 {
-	struct device *dev = &bp->pdev->dev;
+	unsigned int num_queues = ctx->info->num_queues;
+	struct device *dev = &ctx->info->pdev->dev;
 	dma_addr_t tx_dma, rx_dma;
 	struct macb_txq *txq;
 	struct macb_rxq *rxq;
@@ -2785,89 +2808,90 @@ static int macb_alloc(struct macb *bp)
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
-	macb_free(bp);
+	macb_free(ctx);
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
-			macb_set_addr(&bp->info, desc, 0);
+	for (q = 0; q < ctx->info->num_queues; ++q) {
+		txq = &ctx->txq[q];
+		for (i = 0; i < ctx->tx_ring_size; i++) {
+			desc = macb_tx_desc(ctx, q, i);
+			macb_set_addr(ctx->info, desc, 0);
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
-		macb_set_addr(&bp->info, desc, 0);
+	for (i = 0; i < ctx->tx_ring_size; i++) {
+		desc = macb_tx_desc(ctx, 0, i);
+		macb_set_addr(ctx->info, desc, 0);
 		desc->ctrl = MACB_BIT(TX_USED);
 	}
 	txq->head = 0;
@@ -3205,14 +3229,14 @@ static int macb_open(struct net_device *netdev)
 	bp->ctx->rx_ring_size = bp->configured_rx_ring_size;
 	bp->ctx->tx_ring_size = bp->configured_tx_ring_size;
 
-	err = macb_alloc(bp);
+	err = macb_alloc(bp->ctx);
 	if (err) {
 		netdev_err(netdev, "Unable to allocate DMA memory (error %d)\n",
 			   err);
 		goto free_ctx;
 	}
 
-	bp->macbgem_ops.mog_init_rings(bp);
+	bp->macbgem_ops.mog_init_rings(bp->ctx);
 	macb_init_buffers(bp);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
@@ -3250,7 +3274,7 @@ static int macb_open(struct net_device *netdev)
 		napi_disable(&queue->napi_rx);
 		napi_disable(&queue->napi_tx);
 	}
-	macb_free(bp);
+	macb_free(bp->ctx);
 free_ctx:
 	kfree(bp->ctx);
 	bp->ctx = NULL;
@@ -3286,7 +3310,7 @@ static int macb_close(struct net_device *netdev)
 	netif_carrier_off(netdev);
 	spin_unlock_irqrestore(&bp->lock, flags);
 
-	macb_free(bp);
+	macb_free(bp->ctx);
 	kfree(bp->ctx);
 	bp->ctx = NULL;
 
@@ -3665,8 +3689,8 @@ static void macb_get_regs(struct net_device *netdev, struct ethtool_regs *regs,
 
 	if (bp->ctx) {
 		txq = &bp->ctx->txq[0];
-		tail = macb_tx_ring_wrap(bp, txq->tail);
-		head = macb_tx_ring_wrap(bp, txq->head);
+		tail = macb_tx_ring_wrap(bp->ctx, txq->tail);
+		head = macb_tx_ring_wrap(bp->ctx, txq->head);
 		tx_dma_tail = macb_tx_dma(&bp->queues[0], tail);
 		tx_dma_head = macb_tx_dma(&bp->queues[0], head);
 	}
@@ -5008,7 +5032,7 @@ static int at91ether_alloc_coherent(struct macb *bp)
 
 	rxq->ring = dma_alloc_coherent(&bp->pdev->dev,
 				       (AT91ETHER_MAX_RX_DESCR *
-					macb_dma_desc_get_size(&bp->info)),
+				       macb_dma_desc_get_size(&bp->info)),
 				       &rxq->ring_dma, GFP_KERNEL);
 	if (!rxq->ring)
 		return -ENOMEM;
@@ -5054,7 +5078,6 @@ static void at91ether_free_coherent(struct macb *bp)
 /* Initialize and start the Receiver and Transmit subsystems */
 static int at91ether_start(struct macb *bp)
 {
-	struct macb_queue *queue = &bp->queues[0];
 	struct macb_rxq *rxq = &bp->ctx->rxq[0];
 	struct macb_dma_desc *desc;
 	dma_addr_t addr;
@@ -5067,7 +5090,7 @@ static int at91ether_start(struct macb *bp)
 
 	addr = rxq->buffers_dma;
 	for (i = 0; i < AT91ETHER_MAX_RX_DESCR; i++) {
-		desc = macb_rx_desc(queue, i);
+		desc = macb_rx_desc(bp->ctx, 0, i);
 		macb_set_addr(&bp->info, desc, addr);
 		desc->ctrl = 0;
 		addr += AT91ETHER_MAX_RBUFF_SZ;
@@ -5229,14 +5252,13 @@ static netdev_tx_t at91ether_start_xmit(struct sk_buff *skb,
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
@@ -5265,7 +5287,7 @@ static void at91ether_rx(struct net_device *netdev)
 		else
 			rxq->tail++;
 
-		desc = macb_rx_desc(queue, rxq->tail);
+		desc = macb_rx_desc(bp->ctx, 0, rxq->tail);
 	}
 }
 
@@ -6220,6 +6242,7 @@ static int __maybe_unused macb_resume(struct device *dev)
 {
 	struct net_device *netdev = dev_get_drvdata(dev);
 	struct macb *bp = netdev_priv(netdev);
+	struct macb_context *ctx = bp->ctx;
 	struct macb_queue *queue;
 	unsigned long flags;
 	unsigned int q;
@@ -6265,9 +6288,9 @@ static int __maybe_unused macb_resume(struct device *dev)
 	     ++q, ++queue) {
 		if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC)) {
 			if (macb_is_gem(&bp->info))
-				gem_init_rx_ring(queue);
+				gem_init_rx_ring(ctx, q);
 			else
-				macb_init_rx_ring(queue);
+				macb_init_rx_ring(ctx, q);
 		}
 
 		napi_enable(&queue->napi_rx);

-- 
2.55.0


