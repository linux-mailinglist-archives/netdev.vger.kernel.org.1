Return-Path: <netdev+bounces-274188-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NTqOOdMzWl6bgYAu9opvQ
	(envelope-from <netdev+bounces-274188-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 18:50:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DA537E2D0
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 18:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDCD130E3B87
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 16:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F94E47D92B;
	Wed,  1 Apr 2026 16:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nDJV8j3U"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31BC47B43B;
	Wed,  1 Apr 2026 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775061586; cv=none; b=YH8lqAMFSTZnaSB5KldWIs2gNbWykCzvkeS+QDkDXwvTpYoVy2WI23YH9QYrHcurXiTWXK2Klb2Me+PIAgRDyT50PRQSbIvax5HI8ttw+iX4D4CnydGQnZFixtf4UzYfPTUFnWt9/i9PdtatYFWg/3ijcGNxsQ4G18W35UeUjOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775061586; c=relaxed/simple;
	bh=VZE5GsWeH6j/DKbvO7v/+eNrx0GQslaOreKOzBQf7UQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=otmQC/5kxCbkjHlS/WdvyvuomuxU94xOwZxqgF8vhfXrbrmipzzDJNajcsON2Vz7BlszD4e3kxXTD62lUwhR9nF6p+Qdk3g4NtboUWCwd1C9GZGni5qWy/zUk060Z+1/2gFYJrxroq1tqX3RM57l+btBXT3a4X9z4GUR6dsT7qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nDJV8j3U; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 440DF1A30BD;
	Wed,  1 Apr 2026 16:39:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1A8B7602BF;
	Wed,  1 Apr 2026 16:39:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C9DB0104509D8;
	Wed,  1 Apr 2026 18:39:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775061576; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Vt7UXQgblo7Y2fcJY1k7i3Bd5s0n3yDKMkNNDR8/6Kk=;
	b=nDJV8j3UPMYCvdDKjt1kfXnu2acOvTXHg2B0eED27aggqzA4PshXro/+hADM/hZyjqQvWD
	AhKgB6vK8kbDptGK6WzWOhy5Jav3xcvuLWrf/CtSdLlGmlC8nt4H+Y59yUdPRKZ+yvhpNE
	BTCh5tBI+dljenyjmpe1IFaqpb4xihGCHpsZSHbK4CW51j155ZuTlYpKkMvhwNZfVe6EDx
	brZlBX06biNJKOx5T67rLF4eyjuS2CTAY1DC2m9aVoR1xx0AQwmZJdGb9zyXrahSetbVVU
	bR4uDD2AjgZbcaZ0t0FWo/srTWXz/JDTfGgvMIMNGutNjBABVnqsXbCauprjeA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 01 Apr 2026 18:39:09 +0200
Subject: [PATCH net-next 06/11] net: macb: introduce macb_context struct
 for buffer management
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260401-macb-context-v1-6-9590c5ab7272@bootlin.com>
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
	TAGGED_FROM(0.00)[bounces-274188-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.987];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 37DA537E2D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Whenever an operation requires buffer realloc, we close the interface,
update parameters and reopen. To improve reliability under memory
pressure, we should rather alloc new buffers, reconfigure HW and free
old buffers. This requires MACB to support having multiple "contexts"
in parallel.

Introduce this concept by adding the macb_context struct, which owns all
queue buffers and the parameters associated. We do not yet support
multiple contexts in parallel, because all functions access bp->ctx
(the currently active context) directly.

Steps:

 - Introduce `struct macb_context` and its children `struct macb_rxq`
   and `struct macb_txq`. Context fields are stolen from `struct macb`
   and rxq/txq fields are from `struct macb_queue`.

   Making it two separate structs per queue simplifies accesses: we grab
   a txq/rxq local variable and access fields like txq->head instead of
   queue->tx_head. It also anecdotally improves data locality.

 - macb_init_dflt() does not set bp->ctx->{rx,tx}_ring_size to default
   values as ctx is not allocated yet. Instead, introduce
   bp->configured_{rx,tx}_ring_size which get updated on user requests.

 - macb_open() starts by allocating bp->ctx. It gets freed in the
   open error codepath or by macb_close().

 - Guided by compile errors, update all codepaths. Most diff is changing
   `queue->tx_*` to `txq->*` and `queue->rx_*` to `rxq->*`, with a new
   local variable. Also rx_buffer_size / rx_ring_size / tx_ring_size
   move from bp to bp->ctx.

   Introduce two helpers macb_tx|rx() functions to convert macb_queue
   pointers.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      |  49 ++--
 drivers/net/ethernet/cadence/macb_main.c | 442 ++++++++++++++++++-------------
 2 files changed, 296 insertions(+), 195 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index d6dd1d356e12..8821205e8875 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1272,21 +1272,10 @@ struct macb_queue {
 
 	/* Lock to protect tx_head and tx_tail */
 	spinlock_t		tx_ptr_lock;
-	unsigned int		tx_head, tx_tail;
-	struct macb_dma_desc	*tx_ring;
-	struct macb_tx_skb	*tx_skb;
-	dma_addr_t		tx_ring_dma;
 	struct work_struct	tx_error_task;
 	bool			txubr_pending;
 	struct napi_struct	napi_tx;
 
-	dma_addr_t		rx_ring_dma;
-	dma_addr_t		rx_buffers_dma;
-	unsigned int		rx_tail;
-	unsigned int		rx_prepared_head;
-	struct macb_dma_desc	*rx_ring;
-	struct sk_buff		**rx_skbuff;
-	void			*rx_buffers;
 	struct napi_struct	napi_rx;
 	struct queue_stats stats;
 };
@@ -1301,6 +1290,32 @@ struct ethtool_rx_fs_list {
 	unsigned int count;
 };
 
+struct macb_rxq {
+	struct macb_dma_desc	*ring;		/* MACB & GEM */
+	dma_addr_t		ring_dma;	/* MACB & GEM */
+	unsigned int		tail;		/* MACB & GEM */
+	unsigned int		prepared_head;	/* GEM */
+	struct sk_buff		**skbuff;	/* GEM */
+	dma_addr_t		buffers_dma;	/* MACB */
+	void			*buffers;	/* MACB */
+};
+
+struct macb_txq {
+	unsigned int		head;
+	unsigned int		tail;
+	struct macb_dma_desc	*ring;
+	dma_addr_t		ring_dma;
+	struct macb_tx_skb	*skb;
+};
+
+struct macb_context {
+	unsigned int		rx_buffer_size;
+	unsigned int		rx_ring_size;
+	unsigned int		tx_ring_size;
+	struct macb_rxq		rxq[MACB_MAX_QUEUES];
+	struct macb_txq		txq[MACB_MAX_QUEUES];
+};
+
 struct macb {
 	void __iomem		*regs;
 	bool			native_io;
@@ -1309,12 +1324,16 @@ struct macb {
 	u32	(*macb_reg_readl)(struct macb *bp, int offset);
 	void	(*macb_reg_writel)(struct macb *bp, int offset, u32 value);
 
+	/*
+	 * Context stores all its parameters.
+	 * But we must remember them across closure.
+	 */
+	unsigned int		configured_rx_ring_size;
+	unsigned int		configured_tx_ring_size;
+	struct macb_context	*ctx;
+
 	struct macb_dma_desc	*rx_ring_tieoff;
 	dma_addr_t		rx_ring_tieoff_dma;
-	size_t			rx_buffer_size;
-
-	unsigned int		rx_ring_size;
-	unsigned int		tx_ring_size;
 
 	unsigned int		num_queues;
 	struct macb_queue	queues[MACB_MAX_QUEUES];
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index d5023fdc0756..0f63d9b89c11 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -61,7 +61,7 @@ struct sifive_fu540_macb_mgmt {
 #define MAX_TX_RING_SIZE	4096
 
 /* level of occupied TX descriptors under which we wake up TX process */
-#define MACB_TX_WAKEUP_THRESH(bp)	(3 * (bp)->tx_ring_size / 4)
+#define MACB_TX_WAKEUP_THRESH(bp)	(3 * (bp)->ctx->tx_ring_size / 4)
 
 #define MACB_RX_INT_FLAGS	(MACB_BIT(RCOMP) | MACB_BIT(ISR_ROVR))
 #define MACB_TX_ERR_FLAGS	(MACB_BIT(ISR_TUND)			\
@@ -148,48 +148,73 @@ static struct macb_dma_desc_64 *macb_64b_desc(struct macb *bp, struct macb_dma_d
 /* Ring buffer accessors */
 static unsigned int macb_tx_ring_wrap(struct macb *bp, unsigned int index)
 {
-	return index & (bp->tx_ring_size - 1);
+	return index & (bp->ctx->tx_ring_size - 1);
+}
+
+static struct macb_txq *macb_txq(struct macb_queue *queue)
+{
+	struct macb *bp = queue->bp;
+	unsigned int q = queue - bp->queues;
+
+	return &bp->ctx->txq[q];
+}
+
+static struct macb_rxq *macb_rxq(struct macb_queue *queue)
+{
+	struct macb *bp = queue->bp;
+	unsigned int q = queue - bp->queues;
+
+	return &bp->ctx->rxq[q];
 }
 
 static struct macb_dma_desc *macb_tx_desc(struct macb_queue *queue,
 					  unsigned int index)
 {
+	struct macb_txq *txq = macb_txq(queue);
+
 	index = macb_tx_ring_wrap(queue->bp, index);
 	index = macb_adj_dma_desc_idx(queue->bp, index);
-	return &queue->tx_ring[index];
+	return &txq->ring[index];
 }
 
 static struct macb_tx_skb *macb_tx_skb(struct macb_queue *queue,
 				       unsigned int index)
 {
-	return &queue->tx_skb[macb_tx_ring_wrap(queue->bp, index)];
+	struct macb_txq *txq = macb_txq(queue);
+
+	return &txq->skb[macb_tx_ring_wrap(queue->bp, index)];
 }
 
 static dma_addr_t macb_tx_dma(struct macb_queue *queue, unsigned int index)
 {
+	struct macb_txq *txq = macb_txq(queue);
 	dma_addr_t offset;
 
 	offset = macb_tx_ring_wrap(queue->bp, index) *
 			macb_dma_desc_get_size(queue->bp);
 
-	return queue->tx_ring_dma + offset;
+	return txq->ring_dma + offset;
 }
 
 static unsigned int macb_rx_ring_wrap(struct macb *bp, unsigned int index)
 {
-	return index & (bp->rx_ring_size - 1);
+	return index & (bp->ctx->rx_ring_size - 1);
 }
 
 static struct macb_dma_desc *macb_rx_desc(struct macb_queue *queue, unsigned int index)
 {
+	struct macb_rxq *rxq = macb_rxq(queue);
+
 	index = macb_rx_ring_wrap(queue->bp, index);
 	index = macb_adj_dma_desc_idx(queue->bp, index);
-	return &queue->rx_ring[index];
+	return &rxq->ring[index];
 }
 
 static void *macb_rx_buffer(struct macb_queue *queue, unsigned int index)
 {
-	return queue->rx_buffers + queue->bp->rx_buffer_size *
+	struct macb_rxq *rxq = macb_rxq(queue);
+
+	return rxq->buffers + queue->bp->ctx->rx_buffer_size *
 	       macb_rx_ring_wrap(queue->bp, index);
 }
 
@@ -459,19 +484,23 @@ static int macb_mdio_write_c45(struct mii_bus *bus, int mii_id,
 static void macb_init_buffers(struct macb *bp)
 {
 	struct macb_queue *queue;
+	struct macb_rxq *rxq;
+	struct macb_txq *txq;
 	unsigned int q;
 
 	/* Single register for all queues' high 32 bits. */
 	if (macb_dma64(bp)) {
-		macb_writel(bp, RBQPH,
-			    upper_32_bits(bp->queues[0].rx_ring_dma));
-		macb_writel(bp, TBQPH,
-			    upper_32_bits(bp->queues[0].tx_ring_dma));
+		rxq = &bp->ctx->rxq[0];
+		txq = &bp->ctx->txq[0];
+		macb_writel(bp, RBQPH, upper_32_bits(rxq->ring_dma));
+		macb_writel(bp, TBQPH, upper_32_bits(txq->ring_dma));
 	}
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		queue_writel(queue, RBQP, lower_32_bits(queue->rx_ring_dma));
-		queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
+		rxq = &bp->ctx->rxq[q];
+		txq = &bp->ctx->txq[q];
+		queue_writel(queue, RBQP, lower_32_bits(rxq->ring_dma));
+		queue_writel(queue, TBQP, lower_32_bits(txq->ring_dma));
 	}
 }
 
@@ -644,11 +673,12 @@ static bool macb_tx_lpi_set(struct macb *bp, bool enable)
 
 static bool macb_tx_all_queues_idle(struct macb *bp)
 {
-	struct macb_queue *queue;
+	struct macb_txq *txq;
 	unsigned int q;
 
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		if (READ_ONCE(queue->tx_head) != READ_ONCE(queue->tx_tail))
+	for (q = 0; q < bp->num_queues; ++q) {
+		txq = &bp->ctx->txq[q];
+		if (READ_ONCE(txq->head) != READ_ONCE(txq->tail))
 			return false;
 	}
 	return true;
@@ -795,6 +825,7 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 	struct macb_tx_skb tx_skb, *skb_curr, *skb_next;
 	struct macb_dma_desc *desc_curr, *desc_next;
 	unsigned int i, cycles, shift, curr, next;
+	struct macb_txq *txq = macb_txq(queue);
 	struct macb *bp = queue->bp;
 	unsigned char desc[24];
 	unsigned long flags;
@@ -805,17 +836,17 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 		return;
 
 	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
-	head = queue->tx_head;
-	tail = queue->tx_tail;
-	ring_size = bp->tx_ring_size;
+	head = txq->head;
+	tail = txq->tail;
+	ring_size = bp->ctx->tx_ring_size;
 	count = CIRC_CNT(head, tail, ring_size);
 
 	if (!(tail % ring_size))
 		goto unlock;
 
 	if (!count) {
-		queue->tx_head = 0;
-		queue->tx_tail = 0;
+		txq->head = 0;
+		txq->tail = 0;
 		goto unlock;
 	}
 
@@ -859,8 +890,8 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 		       sizeof(struct macb_tx_skb));
 	}
 
-	queue->tx_head = count;
-	queue->tx_tail = 0;
+	txq->head = count;
+	txq->tail = 0;
 
 	/* Make descriptor updates visible to hardware */
 	wmb();
@@ -1253,6 +1284,7 @@ static void macb_tx_error_task(struct work_struct *work)
 	struct macb_queue *queue = container_of(work, struct macb_queue,
 						tx_error_task);
 	unsigned int q = queue - queue->bp->queues;
+	struct macb_txq *txq = macb_txq(queue);
 	struct macb *bp = queue->bp;
 	struct macb_tx_skb *tx_skb;
 	struct macb_dma_desc *desc;
@@ -1264,7 +1296,7 @@ static void macb_tx_error_task(struct work_struct *work)
 	u32 bytes = 0;
 
 	netdev_vdbg(bp->netdev, "macb_tx_error_task: q = %u, t = %u, h = %u\n",
-		    q, queue->tx_tail, queue->tx_head);
+		    q, txq->tail, txq->head);
 
 	/* Prevent the queue NAPI TX poll from running, as it calls
 	 * macb_tx_complete(), which in turn may call netif_wake_subqueue().
@@ -1291,7 +1323,7 @@ static void macb_tx_error_task(struct work_struct *work)
 	/* Treat frames in TX queue including the ones that caused the error.
 	 * Free transmit buffers in upper layer.
 	 */
-	for (tail = queue->tx_tail; tail != queue->tx_head; tail++) {
+	for (tail = txq->tail; tail != txq->head; tail++) {
 		u32	ctrl;
 
 		desc = macb_tx_desc(queue, tail);
@@ -1349,10 +1381,10 @@ static void macb_tx_error_task(struct work_struct *work)
 	wmb();
 
 	/* Reinitialize the TX desc queue */
-	queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
+	queue_writel(queue, TBQP, lower_32_bits(txq->ring_dma));
 	/* Make TX ring reflect state of hardware */
-	queue->tx_head = 0;
-	queue->tx_tail = 0;
+	txq->head = 0;
+	txq->tail = 0;
 
 	/* Housework before enabling TX IRQ */
 	macb_writel(bp, TSR, macb_readl(bp, TSR));
@@ -1402,6 +1434,7 @@ static bool ptp_one_step_sync(struct sk_buff *skb)
 static int macb_tx_complete(struct macb_queue *queue, int budget)
 {
 	struct macb *bp = queue->bp;
+	struct macb_txq *txq = macb_txq(queue);
 	unsigned int q = queue - bp->queues;
 	unsigned long flags;
 	unsigned int tail;
@@ -1410,8 +1443,8 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	u32 bytes = 0;
 
 	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
-	head = queue->tx_head;
-	for (tail = queue->tx_tail; tail != head && packets < budget; tail++) {
+	head = txq->head;
+	for (tail = txq->tail; tail != head && packets < budget; tail++) {
 		struct macb_tx_skb	*tx_skb;
 		struct sk_buff		*skb;
 		struct macb_dma_desc	*desc;
@@ -1467,10 +1500,10 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	netdev_tx_completed_queue(netdev_get_tx_queue(bp->netdev, q),
 				  packets, bytes);
 
-	queue->tx_tail = tail;
+	txq->tail = tail;
 	if (__netif_subqueue_stopped(bp->netdev, q) &&
-	    CIRC_CNT(queue->tx_head, queue->tx_tail,
-		     bp->tx_ring_size) <= MACB_TX_WAKEUP_THRESH(bp))
+	    CIRC_CNT(txq->head, txq->tail,
+		     bp->ctx->tx_ring_size) <= MACB_TX_WAKEUP_THRESH(bp))
 		netif_wake_subqueue(bp->netdev, q);
 	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 
@@ -1482,24 +1515,26 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 
 static void gem_rx_refill(struct macb_queue *queue)
 {
+	struct macb_rxq *rxq = macb_rxq(queue);
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
 	struct sk_buff *skb;
 	unsigned int entry;
 	dma_addr_t paddr;
 
-	while (CIRC_SPACE(queue->rx_prepared_head, queue->rx_tail,
-			bp->rx_ring_size) > 0) {
-		entry = macb_rx_ring_wrap(bp, queue->rx_prepared_head);
+	while (CIRC_SPACE(rxq->prepared_head, rxq->tail,
+			  bp->ctx->rx_ring_size) > 0) {
+		entry = macb_rx_ring_wrap(bp, rxq->prepared_head);
 
 		/* Make hw descriptor updates visible to CPU */
 		rmb();
 
 		desc = macb_rx_desc(queue, entry);
 
-		if (!queue->rx_skbuff[entry]) {
+		if (!rxq->skbuff[entry]) {
 			/* allocate sk_buff for this free entry in ring */
-			skb = netdev_alloc_skb(bp->netdev, bp->rx_buffer_size);
+			skb = netdev_alloc_skb(bp->netdev,
+					       bp->ctx->rx_buffer_size);
 			if (unlikely(!skb)) {
 				netdev_err(bp->netdev,
 					   "Unable to allocate sk_buff\n");
@@ -1508,16 +1543,16 @@ static void gem_rx_refill(struct macb_queue *queue)
 
 			/* now fill corresponding descriptor entry */
 			paddr = dma_map_single(&bp->pdev->dev, skb->data,
-					       bp->rx_buffer_size,
+					       bp->ctx->rx_buffer_size,
 					       DMA_FROM_DEVICE);
 			if (dma_mapping_error(&bp->pdev->dev, paddr)) {
 				dev_kfree_skb(skb);
 				break;
 			}
 
-			queue->rx_skbuff[entry] = skb;
+			rxq->skbuff[entry] = skb;
 
-			if (entry == bp->rx_ring_size - 1)
+			if (entry == bp->ctx->rx_ring_size - 1)
 				paddr |= MACB_BIT(RX_WRAP);
 			desc->ctrl = 0;
 			/* Setting addr clears RX_USED and allows reception,
@@ -1544,14 +1579,14 @@ static void gem_rx_refill(struct macb_queue *queue)
 			dma_wmb();
 			desc->addr &= ~MACB_BIT(RX_USED);
 		}
-		queue->rx_prepared_head++;
+		rxq->prepared_head++;
 	}
 
 	/* Make descriptor updates visible to hardware */
 	wmb();
 
 	netdev_vdbg(bp->netdev, "rx ring: queue: %p, prepared head %d, tail %d\n",
-		    queue, queue->rx_prepared_head, queue->rx_tail);
+		    queue, rxq->prepared_head, rxq->tail);
 }
 
 /* Mark DMA descriptors from begin up to and not including end as unused */
@@ -1578,6 +1613,7 @@ static void discard_partial_frame(struct macb_queue *queue, unsigned int begin,
 static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		  int budget)
 {
+	struct macb_rxq *rxq = macb_rxq(queue);
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
 	struct sk_buff *skb;
@@ -1590,7 +1626,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		dma_addr_t addr;
 		bool rxused;
 
-		entry = macb_rx_ring_wrap(bp, queue->rx_tail);
+		entry = macb_rx_ring_wrap(bp, rxq->tail);
 		desc = macb_rx_desc(queue, entry);
 
 		/* Make hw descriptor updates visible to CPU */
@@ -1607,7 +1643,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 
 		ctrl = desc->ctrl;
 
-		queue->rx_tail++;
+		rxq->tail++;
 		count++;
 
 		if (!(ctrl & MACB_BIT(RX_SOF) && ctrl & MACB_BIT(RX_EOF))) {
@@ -1617,7 +1653,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			queue->stats.rx_dropped++;
 			break;
 		}
-		skb = queue->rx_skbuff[entry];
+		skb = rxq->skbuff[entry];
 		if (unlikely(!skb)) {
 			netdev_err(bp->netdev,
 				   "inconsistent Rx descriptor chain\n");
@@ -1626,14 +1662,14 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			break;
 		}
 		/* now everything is ready for receiving packet */
-		queue->rx_skbuff[entry] = NULL;
+		rxq->skbuff[entry] = NULL;
 		len = ctrl & bp->rx_frm_len_mask;
 
 		netdev_vdbg(bp->netdev, "gem_rx %u (len %u)\n", entry, len);
 
 		skb_put(skb, len);
 		dma_unmap_single(&bp->pdev->dev, addr,
-				 bp->rx_buffer_size, DMA_FROM_DEVICE);
+				 bp->ctx->rx_buffer_size, DMA_FROM_DEVICE);
 
 		skb->protocol = eth_type_trans(skb, bp->netdev);
 		skb_checksum_none_assert(skb);
@@ -1713,7 +1749,7 @@ static int macb_rx_frame(struct macb_queue *queue, struct napi_struct *napi,
 	skb_put(skb, len);
 
 	for (frag = first_frag; ; frag++) {
-		unsigned int frag_len = bp->rx_buffer_size;
+		unsigned int frag_len = bp->ctx->rx_buffer_size;
 
 		if (offset + frag_len > len) {
 			if (unlikely(frag != last_frag)) {
@@ -1725,7 +1761,7 @@ static int macb_rx_frame(struct macb_queue *queue, struct napi_struct *napi,
 		skb_copy_to_linear_data_offset(skb, offset,
 					       macb_rx_buffer(queue, frag),
 					       frag_len);
-		offset += bp->rx_buffer_size;
+		offset += bp->ctx->rx_buffer_size;
 		desc = macb_rx_desc(queue, frag);
 		desc->addr &= ~MACB_BIT(RX_USED);
 
@@ -1750,32 +1786,34 @@ static int macb_rx_frame(struct macb_queue *queue, struct napi_struct *napi,
 
 static inline void macb_init_rx_ring(struct macb_queue *queue)
 {
+	struct macb_rxq *rxq = macb_rxq(queue);
 	struct macb_dma_desc *desc = NULL;
 	struct macb *bp = queue->bp;
 	dma_addr_t addr;
 	int i;
 
-	addr = queue->rx_buffers_dma;
-	for (i = 0; i < bp->rx_ring_size; i++) {
+	addr = rxq->buffers_dma;
+	for (i = 0; i < bp->ctx->rx_ring_size; i++) {
 		desc = macb_rx_desc(queue, i);
 		macb_set_addr(bp, desc, addr);
 		desc->ctrl = 0;
-		addr += bp->rx_buffer_size;
+		addr += bp->ctx->rx_buffer_size;
 	}
 	desc->addr |= MACB_BIT(RX_WRAP);
-	queue->rx_tail = 0;
+	rxq->tail = 0;
 }
 
 static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
 		   int budget)
 {
+	struct macb_rxq *rxq = macb_rxq(queue);
 	struct macb *bp = queue->bp;
 	bool reset_rx_queue = false;
 	int first_frag = -1;
 	unsigned int tail;
 	int received = 0;
 
-	for (tail = queue->rx_tail; budget > 0; tail++) {
+	for (tail = rxq->tail; budget > 0; tail++) {
 		struct macb_dma_desc *desc = macb_rx_desc(queue, tail);
 		u32 ctrl;
 
@@ -1829,7 +1867,7 @@ static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
 		macb_writel(bp, NCR, ctrl & ~MACB_BIT(RE));
 
 		macb_init_rx_ring(queue);
-		queue_writel(queue, RBQP, queue->rx_ring_dma);
+		queue_writel(queue, RBQP, rxq->ring_dma);
 
 		macb_writel(bp, NCR, ctrl | MACB_BIT(RE));
 
@@ -1838,20 +1876,21 @@ static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
 	}
 
 	if (first_frag != -1)
-		queue->rx_tail = first_frag;
+		rxq->tail = first_frag;
 	else
-		queue->rx_tail = tail;
+		rxq->tail = tail;
 
 	return received;
 }
 
 static bool macb_rx_pending(struct macb_queue *queue)
 {
+	struct macb_rxq *rxq = macb_rxq(queue);
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
 	unsigned int entry;
 
-	entry = macb_rx_ring_wrap(bp, queue->rx_tail);
+	entry = macb_rx_ring_wrap(bp, rxq->tail);
 	desc = macb_rx_desc(queue, entry);
 
 	/* Make hw descriptor updates visible to CPU */
@@ -1900,18 +1939,19 @@ static int macb_rx_poll(struct napi_struct *napi, int budget)
 
 static void macb_tx_restart(struct macb_queue *queue)
 {
+	struct macb_txq *txq = macb_txq(queue);
 	struct macb *bp = queue->bp;
 	unsigned int head_idx, tbqp;
 	unsigned long flags;
 
 	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 
-	if (queue->tx_head == queue->tx_tail)
+	if (txq->head == txq->tail)
 		goto out_tx_ptr_unlock;
 
 	tbqp = queue_readl(queue, TBQP) / macb_dma_desc_get_size(bp);
 	tbqp = macb_adj_dma_desc_idx(bp, macb_tx_ring_wrap(bp, tbqp));
-	head_idx = macb_adj_dma_desc_idx(bp, macb_tx_ring_wrap(bp, queue->tx_head));
+	head_idx = macb_adj_dma_desc_idx(bp, macb_tx_ring_wrap(bp, txq->head));
 
 	if (tbqp == head_idx)
 		goto out_tx_ptr_unlock;
@@ -1926,15 +1966,16 @@ static void macb_tx_restart(struct macb_queue *queue)
 
 static bool macb_tx_complete_pending(struct macb_queue *queue)
 {
+	struct macb_txq *txq = macb_txq(queue);
 	bool retval = false;
 	unsigned long flags;
 
 	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
-	if (queue->tx_head != queue->tx_tail) {
+	if (txq->head != txq->tail) {
 		/* Make hw descriptor updates visible to CPU */
 		rmb();
 
-		if (macb_tx_desc(queue, queue->tx_tail)->ctrl & MACB_BIT(TX_USED))
+		if (macb_tx_desc(queue, txq->tail)->ctrl & MACB_BIT(TX_USED))
 			retval = true;
 	}
 	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
@@ -2225,8 +2266,9 @@ static unsigned int macb_tx_map(struct macb *bp,
 				struct sk_buff *skb,
 				unsigned int hdrlen)
 {
+	struct macb_txq *txq = macb_txq(queue);
 	unsigned int f, nr_frags = skb_shinfo(skb)->nr_frags;
-	unsigned int len, i, tx_head = queue->tx_head;
+	unsigned int len, i, tx_head = txq->head;
 	u32 ctrl, lso_ctrl = 0, seq_ctrl = 0;
 	unsigned int eof = 1, mss_mfs = 0;
 	struct macb_tx_skb *tx_skb = NULL;
@@ -2346,11 +2388,12 @@ static unsigned int macb_tx_map(struct macb *bp,
 			ctrl |= MACB_BIT(TX_LAST);
 			eof = 0;
 		}
-		if (unlikely(macb_tx_ring_wrap(bp, i) == bp->tx_ring_size - 1))
+		if (unlikely(macb_tx_ring_wrap(bp, i) ==
+				bp->ctx->tx_ring_size - 1))
 			ctrl |= MACB_BIT(TX_WRAP);
 
 		/* First descriptor is header descriptor */
-		if (i == queue->tx_head) {
+		if (i == txq->head) {
 			ctrl |= MACB_BF(TX_LSO, lso_ctrl);
 			ctrl |= MACB_BF(TX_TCP_SEQ_SRC, seq_ctrl);
 			if ((bp->netdev->features & NETIF_F_HW_CSUM) &&
@@ -2370,16 +2413,16 @@ static unsigned int macb_tx_map(struct macb *bp,
 		 */
 		wmb();
 		desc->ctrl = ctrl;
-	} while (i != queue->tx_head);
+	} while (i != txq->head);
 
-	queue->tx_head = tx_head;
+	txq->head = tx_head;
 
 	return 0;
 
 dma_error:
 	netdev_err(bp->netdev, "TX DMA map failed\n");
 
-	for (i = queue->tx_head; i != tx_head; i++) {
+	for (i = txq->head; i != tx_head; i++) {
 		tx_skb = macb_tx_skb(queue, i);
 
 		macb_tx_unmap(bp, tx_skb, 0);
@@ -2499,6 +2542,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 	unsigned int q = skb_get_queue_mapping(skb);
 	unsigned int desc_cnt, nr_frags, frag_size, f;
 	struct macb_queue *queue = &bp->queues[q];
+	struct macb_txq *txq = macb_txq(queue);
 	netdev_tx_t ret = NETDEV_TX_OK;
 	unsigned int hdrlen;
 	unsigned long flags;
@@ -2562,11 +2606,11 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 
 	/* This is a hard error, log it. */
-	if (CIRC_SPACE(queue->tx_head, queue->tx_tail,
-		       bp->tx_ring_size) < desc_cnt) {
+	if (CIRC_SPACE(txq->head, txq->tail,
+		       bp->ctx->tx_ring_size) < desc_cnt) {
 		netif_stop_subqueue(netdev, q);
 		netdev_dbg(netdev, "tx_head = %u, tx_tail = %u\n",
-			   queue->tx_head, queue->tx_tail);
+			   txq->head, txq->tail);
 		ret = NETDEV_TX_BUSY;
 		goto unlock;
 	}
@@ -2588,7 +2632,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
 	spin_unlock(&bp->lock);
 
-	if (CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx_ring_size) < 1)
+	if (CIRC_SPACE(txq->head, txq->tail, bp->ctx->tx_ring_size) < 1)
 		netif_stop_subqueue(netdev, q);
 
 unlock:
@@ -2600,38 +2644,42 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 static void macb_init_rx_buffer_size(struct macb *bp, size_t size)
 {
 	if (!macb_is_gem(bp)) {
-		bp->rx_buffer_size = MACB_RX_BUFFER_SIZE;
+		bp->ctx->rx_buffer_size = MACB_RX_BUFFER_SIZE;
 	} else {
-		bp->rx_buffer_size = MIN(size, RX_BUFFER_MAX);
+		bp->ctx->rx_buffer_size = MIN(size, RX_BUFFER_MAX);
 
-		if (bp->rx_buffer_size % RX_BUFFER_MULTIPLE) {
+		if (bp->ctx->rx_buffer_size % RX_BUFFER_MULTIPLE) {
 			netdev_dbg(bp->netdev,
 				   "RX buffer must be multiple of %d bytes, expanding\n",
 				   RX_BUFFER_MULTIPLE);
-			bp->rx_buffer_size =
-				roundup(bp->rx_buffer_size, RX_BUFFER_MULTIPLE);
+			bp->ctx->rx_buffer_size =
+				roundup(bp->ctx->rx_buffer_size,
+					RX_BUFFER_MULTIPLE);
 		}
 	}
 
-	netdev_dbg(bp->netdev, "mtu [%u] rx_buffer_size [%zu]\n",
-		   bp->netdev->mtu, bp->rx_buffer_size);
+	netdev_dbg(bp->netdev, "mtu [%u] rx_buffer_size [%u]\n",
+		   bp->netdev->mtu, bp->ctx->rx_buffer_size);
 }
 
 static void gem_free_rx_buffers(struct macb *bp)
 {
-	struct sk_buff		*skb;
-	struct macb_dma_desc	*desc;
+	struct macb_dma_desc *desc;
 	struct macb_queue *queue;
-	dma_addr_t		addr;
+	struct macb_rxq *rxq;
+	struct sk_buff *skb;
+	dma_addr_t addr;
 	unsigned int q;
 	int i;
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		if (!queue->rx_skbuff)
+		rxq = &bp->ctx->rxq[q];
+
+		if (!rxq->skbuff)
 			continue;
 
-		for (i = 0; i < bp->rx_ring_size; i++) {
-			skb = queue->rx_skbuff[i];
+		for (i = 0; i < bp->ctx->rx_ring_size; i++) {
+			skb = rxq->skbuff[i];
 
 			if (!skb)
 				continue;
@@ -2639,95 +2687,106 @@ static void gem_free_rx_buffers(struct macb *bp)
 			desc = macb_rx_desc(queue, i);
 			addr = macb_get_addr(bp, desc);
 
-			dma_unmap_single(&bp->pdev->dev, addr, bp->rx_buffer_size,
-					DMA_FROM_DEVICE);
+			dma_unmap_single(&bp->pdev->dev, addr,
+					 bp->ctx->rx_buffer_size,
+					 DMA_FROM_DEVICE);
 			dev_kfree_skb_any(skb);
 			skb = NULL;
 		}
 
-		kfree(queue->rx_skbuff);
-		queue->rx_skbuff = NULL;
+		kfree(rxq->skbuff);
+		rxq->skbuff = NULL;
 	}
 }
 
 static void macb_free_rx_buffers(struct macb *bp)
 {
-	struct macb_queue *queue = &bp->queues[0];
+	struct macb_rxq *rxq = &bp->ctx->rxq[0];
 
-	if (queue->rx_buffers) {
+	if (rxq->buffers) {
 		dma_free_coherent(&bp->pdev->dev,
-				  bp->rx_ring_size * bp->rx_buffer_size,
-				  queue->rx_buffers, queue->rx_buffers_dma);
-		queue->rx_buffers = NULL;
+				  bp->ctx->rx_ring_size *
+					bp->ctx->rx_buffer_size,
+				  rxq->buffers, rxq->buffers_dma);
+		rxq->buffers = NULL;
 	}
 }
 
 static unsigned int macb_tx_ring_size_per_queue(struct macb *bp)
 {
-	return macb_dma_desc_get_size(bp) * bp->tx_ring_size + bp->tx_bd_rd_prefetch;
+	return macb_dma_desc_get_size(bp) * bp->ctx->tx_ring_size +
+		bp->tx_bd_rd_prefetch;
 }
 
 static unsigned int macb_rx_ring_size_per_queue(struct macb *bp)
 {
-	return macb_dma_desc_get_size(bp) * bp->rx_ring_size + bp->rx_bd_rd_prefetch;
+	return macb_dma_desc_get_size(bp) * bp->ctx->rx_ring_size +
+		bp->rx_bd_rd_prefetch;
 }
 
 static void macb_free_consistent(struct macb *bp)
 {
 	struct device *dev = &bp->pdev->dev;
-	struct macb_queue *queue;
+	struct macb_txq *txq;
+	struct macb_rxq *rxq;
 	unsigned int q;
 	size_t size;
 
 	bp->macbgem_ops.mog_free_rx_buffers(bp);
 
+	txq = &bp->ctx->txq[0];
 	size = bp->num_queues * macb_tx_ring_size_per_queue(bp);
-	dma_free_coherent(dev, size, bp->queues[0].tx_ring, bp->queues[0].tx_ring_dma);
+	dma_free_coherent(dev, size, txq->ring, txq->ring_dma);
 
+	rxq = &bp->ctx->rxq[0];
 	size = bp->num_queues * macb_rx_ring_size_per_queue(bp);
-	dma_free_coherent(dev, size, bp->queues[0].rx_ring, bp->queues[0].rx_ring_dma);
+	dma_free_coherent(dev, size, rxq->ring, rxq->ring_dma);
 
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		kfree(queue->tx_skb);
-		queue->tx_skb = NULL;
-		queue->tx_ring = NULL;
-		queue->rx_ring = NULL;
+	for (q = 0; q < bp->num_queues; ++q) {
+		txq = &bp->ctx->txq[q];
+		rxq = &bp->ctx->rxq[q];
+
+		kfree(txq->skb);
+		txq->skb = NULL;
+		txq->ring = NULL;
+		rxq->ring = NULL;
 	}
 }
 
 static int gem_alloc_rx_buffers(struct macb *bp)
 {
-	struct macb_queue *queue;
+	struct macb_rxq *rxq;
 	unsigned int q;
 	int size;
 
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		size = bp->rx_ring_size * sizeof(struct sk_buff *);
-		queue->rx_skbuff = kzalloc(size, GFP_KERNEL);
-		if (!queue->rx_skbuff)
+	for (q = 0; q < bp->num_queues; ++q) {
+		rxq = &bp->ctx->rxq[q];
+		size = bp->ctx->rx_ring_size * sizeof(struct sk_buff *);
+		rxq->skbuff = kzalloc(size, GFP_KERNEL);
+		if (!rxq->skbuff)
 			return -ENOMEM;
 		else
 			netdev_dbg(bp->netdev,
 				   "Allocated %d RX struct sk_buff entries at %p\n",
-				   bp->rx_ring_size, queue->rx_skbuff);
+				   bp->ctx->rx_ring_size, rxq->skbuff);
 	}
 	return 0;
 }
 
 static int macb_alloc_rx_buffers(struct macb *bp)
 {
-	struct macb_queue *queue = &bp->queues[0];
+	struct macb_rxq *rxq = &bp->ctx->rxq[0];
 	int size;
 
-	size = bp->rx_ring_size * bp->rx_buffer_size;
-	queue->rx_buffers = dma_alloc_coherent(&bp->pdev->dev, size,
-					    &queue->rx_buffers_dma, GFP_KERNEL);
-	if (!queue->rx_buffers)
+	size = bp->ctx->rx_ring_size * bp->ctx->rx_buffer_size;
+	rxq->buffers = dma_alloc_coherent(&bp->pdev->dev, size,
+					  &rxq->buffers_dma, GFP_KERNEL);
+	if (!rxq->buffers)
 		return -ENOMEM;
 
 	netdev_dbg(bp->netdev,
 		   "Allocated RX buffers of %d bytes at %08lx (mapped %p)\n",
-		   size, (unsigned long)queue->rx_buffers_dma, queue->rx_buffers);
+		   size, (unsigned long)rxq->buffers_dma, rxq->buffers);
 	return 0;
 }
 
@@ -2735,7 +2794,8 @@ static int macb_alloc_consistent(struct macb *bp)
 {
 	struct device *dev = &bp->pdev->dev;
 	dma_addr_t tx_dma, rx_dma;
-	struct macb_queue *queue;
+	struct macb_txq *txq;
+	struct macb_rxq *rxq;
 	unsigned int q;
 	void *tx, *rx;
 	size_t size;
@@ -2761,16 +2821,19 @@ static int macb_alloc_consistent(struct macb *bp)
 	netdev_dbg(bp->netdev, "Allocated %zu bytes for %u RX rings at %08lx (mapped %p)\n",
 		   size, bp->num_queues, (unsigned long)rx_dma, rx);
 
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		queue->tx_ring = tx + macb_tx_ring_size_per_queue(bp) * q;
-		queue->tx_ring_dma = tx_dma + macb_tx_ring_size_per_queue(bp) * q;
+	for (q = 0; q < bp->num_queues; ++q) {
+		txq = &bp->ctx->txq[q];
+		rxq = &bp->ctx->rxq[q];
 
-		queue->rx_ring = rx + macb_rx_ring_size_per_queue(bp) * q;
-		queue->rx_ring_dma = rx_dma + macb_rx_ring_size_per_queue(bp) * q;
+		txq->ring = tx + macb_tx_ring_size_per_queue(bp) * q;
+		txq->ring_dma = tx_dma + macb_tx_ring_size_per_queue(bp) * q;
 
-		size = bp->tx_ring_size * sizeof(struct macb_tx_skb);
-		queue->tx_skb = kmalloc(size, GFP_KERNEL);
-		if (!queue->tx_skb)
+		rxq->ring = rx + macb_rx_ring_size_per_queue(bp) * q;
+		rxq->ring_dma = rx_dma + macb_rx_ring_size_per_queue(bp) * q;
+
+		size = bp->ctx->tx_ring_size * sizeof(struct macb_tx_skb);
+		txq->skb = kmalloc(size, GFP_KERNEL);
+		if (!txq->skb)
 			goto out_err;
 	}
 	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
@@ -2785,8 +2848,10 @@ static int macb_alloc_consistent(struct macb *bp)
 
 static void gem_init_rx_ring(struct macb_queue *queue)
 {
-	queue->rx_tail = 0;
-	queue->rx_prepared_head = 0;
+	struct macb_rxq *rxq = macb_rxq(queue);
+
+	rxq->tail = 0;
+	rxq->prepared_head = 0;
 
 	gem_rx_refill(queue);
 }
@@ -2795,18 +2860,20 @@ static void gem_init_rings(struct macb *bp)
 {
 	struct macb_queue *queue;
 	struct macb_dma_desc *desc = NULL;
+	struct macb_txq *txq;
 	unsigned int q;
 	int i;
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		for (i = 0; i < bp->tx_ring_size; i++) {
+		txq = &bp->ctx->txq[q];
+		for (i = 0; i < bp->ctx->tx_ring_size; i++) {
 			desc = macb_tx_desc(queue, i);
 			macb_set_addr(bp, desc, 0);
 			desc->ctrl = MACB_BIT(TX_USED);
 		}
 		desc->ctrl |= MACB_BIT(TX_WRAP);
-		queue->tx_head = 0;
-		queue->tx_tail = 0;
+		txq->head = 0;
+		txq->tail = 0;
 
 		gem_init_rx_ring(queue);
 	}
@@ -2814,18 +2881,19 @@ static void gem_init_rings(struct macb *bp)
 
 static void macb_init_rings(struct macb *bp)
 {
-	int i;
+	struct macb_txq *txq = &bp->ctx->txq[0];
 	struct macb_dma_desc *desc = NULL;
+	int i;
 
 	macb_init_rx_ring(&bp->queues[0]);
 
-	for (i = 0; i < bp->tx_ring_size; i++) {
+	for (i = 0; i < bp->ctx->tx_ring_size; i++) {
 		desc = macb_tx_desc(&bp->queues[0], i);
 		macb_set_addr(bp, desc, 0);
 		desc->ctrl = MACB_BIT(TX_USED);
 	}
-	bp->queues[0].tx_head = 0;
-	bp->queues[0].tx_tail = 0;
+	txq->head = 0;
+	txq->tail = 0;
 	desc->ctrl |= MACB_BIT(TX_WRAP);
 }
 
@@ -2941,7 +3009,7 @@ static void macb_configure_dma(struct macb *bp)
 	unsigned int q;
 	u32 dmacfg;
 
-	buffer_size = bp->rx_buffer_size / RX_BUFFER_MULTIPLE;
+	buffer_size = bp->ctx->rx_buffer_size / RX_BUFFER_MULTIPLE;
 	if (macb_is_gem(bp)) {
 		dmacfg = gem_readl(bp, DMACFG) & ~GEM_BF(RXBS, -1L);
 		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
@@ -3148,14 +3216,22 @@ static int macb_open(struct net_device *netdev)
 	if (err < 0)
 		return err;
 
+	bp->ctx = kzalloc_obj(*bp->ctx);
+	if (!bp->ctx) {
+		err = -ENOMEM;
+		goto pm_exit;
+	}
+
 	/* RX buffers initialization */
 	macb_init_rx_buffer_size(bp, bufsz);
+	bp->ctx->rx_ring_size = bp->configured_rx_ring_size;
+	bp->ctx->tx_ring_size = bp->configured_tx_ring_size;
 
 	err = macb_alloc_consistent(bp);
 	if (err) {
 		netdev_err(netdev, "Unable to allocate DMA memory (error %d)\n",
 			   err);
-		goto pm_exit;
+		goto free_ctx;
 	}
 
 	bp->macbgem_ops.mog_init_rings(bp);
@@ -3197,6 +3273,9 @@ static int macb_open(struct net_device *netdev)
 		napi_disable(&queue->napi_tx);
 	}
 	macb_free_consistent(bp);
+free_ctx:
+	kfree(bp->ctx);
+	bp->ctx = NULL;
 pm_exit:
 	pm_runtime_put_sync(&bp->pdev->dev);
 	return err;
@@ -3230,6 +3309,8 @@ static int macb_close(struct net_device *netdev)
 	spin_unlock_irqrestore(&bp->lock, flags);
 
 	macb_free_consistent(bp);
+	kfree(bp->ctx);
+	bp->ctx = NULL;
 
 	if (bp->ptp_info)
 		bp->ptp_info->ptp_remove(netdev);
@@ -3596,14 +3677,15 @@ static void macb_get_regs(struct net_device *netdev, struct ethtool_regs *regs,
 			  void *p)
 {
 	struct macb *bp = netdev_priv(netdev);
+	struct macb_txq *txq = &bp->ctx->txq[0];
 	unsigned int tail, head;
 	u32 *regs_buff = p;
 
 	regs->version = (macb_readl(bp, MID) & ((1 << MACB_REV_SIZE) - 1))
 			| MACB_GREGS_VERSION;
 
-	tail = macb_tx_ring_wrap(bp, bp->queues[0].tx_tail);
-	head = macb_tx_ring_wrap(bp, bp->queues[0].tx_head);
+	tail = macb_tx_ring_wrap(bp, txq->tail);
+	head = macb_tx_ring_wrap(bp, txq->head);
 
 	regs_buff[0]  = macb_readl(bp, NCR);
 	regs_buff[1]  = macb_or_gem_readl(bp, NCFGR);
@@ -3682,8 +3764,8 @@ static void macb_get_ringparam(struct net_device *netdev,
 	ring->rx_max_pending = MAX_RX_RING_SIZE;
 	ring->tx_max_pending = MAX_TX_RING_SIZE;
 
-	ring->rx_pending = bp->rx_ring_size;
-	ring->tx_pending = bp->tx_ring_size;
+	ring->rx_pending = bp->ctx->rx_ring_size;
+	ring->tx_pending = bp->ctx->tx_ring_size;
 }
 
 static int macb_set_ringparam(struct net_device *netdev,
@@ -3706,8 +3788,8 @@ static int macb_set_ringparam(struct net_device *netdev,
 			      MIN_TX_RING_SIZE, MAX_TX_RING_SIZE);
 	new_tx_size = roundup_pow_of_two(new_tx_size);
 
-	if ((new_tx_size == bp->tx_ring_size) &&
-	    (new_rx_size == bp->rx_ring_size)) {
+	if (new_tx_size == bp->configured_tx_ring_size &&
+	    new_rx_size == bp->configured_rx_ring_size) {
 		/* nothing to do */
 		return 0;
 	}
@@ -3717,8 +3799,8 @@ static int macb_set_ringparam(struct net_device *netdev,
 		macb_close(bp->netdev);
 	}
 
-	bp->rx_ring_size = new_rx_size;
-	bp->tx_ring_size = new_tx_size;
+	bp->configured_rx_ring_size = new_rx_size;
+	bp->configured_tx_ring_size = new_tx_size;
 
 	if (reset)
 		macb_open(bp->netdev);
@@ -4725,9 +4807,6 @@ static int macb_init_dflt(struct platform_device *pdev)
 	int err;
 	u32 val, reg;
 
-	bp->tx_ring_size = DEFAULT_TX_RING_SIZE;
-	bp->rx_ring_size = DEFAULT_RX_RING_SIZE;
-
 	/* set the queue register mapping once for all: queue0 has a special
 	 * register mapping but we don't want to test the queue index then
 	 * compute the corresponding register offset at run time.
@@ -4926,26 +5005,26 @@ static struct sifive_fu540_macb_mgmt *mgmt;
 
 static int at91ether_alloc_coherent(struct macb *bp)
 {
-	struct macb_queue *queue = &bp->queues[0];
+	struct macb_rxq *rxq = &bp->ctx->rxq[0];
 
-	queue->rx_ring = dma_alloc_coherent(&bp->pdev->dev,
-					    (AT91ETHER_MAX_RX_DESCR *
-					     macb_dma_desc_get_size(bp)),
-					    &queue->rx_ring_dma, GFP_KERNEL);
-	if (!queue->rx_ring)
+	rxq->ring = dma_alloc_coherent(&bp->pdev->dev,
+				       (AT91ETHER_MAX_RX_DESCR *
+					macb_dma_desc_get_size(bp)),
+				       &rxq->ring_dma, GFP_KERNEL);
+	if (!rxq->ring)
 		return -ENOMEM;
 
-	queue->rx_buffers = dma_alloc_coherent(&bp->pdev->dev,
-					       AT91ETHER_MAX_RX_DESCR *
-					       AT91ETHER_MAX_RBUFF_SZ,
-					       &queue->rx_buffers_dma,
-					       GFP_KERNEL);
-	if (!queue->rx_buffers) {
+	rxq->buffers = dma_alloc_coherent(&bp->pdev->dev,
+					  AT91ETHER_MAX_RX_DESCR *
+					  AT91ETHER_MAX_RBUFF_SZ,
+					  &rxq->buffers_dma,
+					  GFP_KERNEL);
+	if (!rxq->buffers) {
 		dma_free_coherent(&bp->pdev->dev,
 				  AT91ETHER_MAX_RX_DESCR *
 				  macb_dma_desc_get_size(bp),
-				  queue->rx_ring, queue->rx_ring_dma);
-		queue->rx_ring = NULL;
+				  rxq->ring, rxq->ring_dma);
+		rxq->ring = NULL;
 		return -ENOMEM;
 	}
 
@@ -4954,22 +5033,22 @@ static int at91ether_alloc_coherent(struct macb *bp)
 
 static void at91ether_free_coherent(struct macb *bp)
 {
-	struct macb_queue *queue = &bp->queues[0];
+	struct macb_rxq *rxq = &bp->ctx->rxq[0];
 
-	if (queue->rx_ring) {
+	if (rxq->ring) {
 		dma_free_coherent(&bp->pdev->dev,
 				  AT91ETHER_MAX_RX_DESCR *
 				  macb_dma_desc_get_size(bp),
-				  queue->rx_ring, queue->rx_ring_dma);
-		queue->rx_ring = NULL;
+				  rxq->ring, rxq->ring_dma);
+		rxq->ring = NULL;
 	}
 
-	if (queue->rx_buffers) {
+	if (rxq->buffers) {
 		dma_free_coherent(&bp->pdev->dev,
 				  AT91ETHER_MAX_RX_DESCR *
 				  AT91ETHER_MAX_RBUFF_SZ,
-				  queue->rx_buffers, queue->rx_buffers_dma);
-		queue->rx_buffers = NULL;
+				  rxq->buffers, rxq->buffers_dma);
+		rxq->buffers = NULL;
 	}
 }
 
@@ -4977,6 +5056,7 @@ static void at91ether_free_coherent(struct macb *bp)
 static int at91ether_start(struct macb *bp)
 {
 	struct macb_queue *queue = &bp->queues[0];
+	struct macb_rxq *rxq = &bp->ctx->rxq[0];
 	struct macb_dma_desc *desc;
 	dma_addr_t addr;
 	u32 ctl;
@@ -4986,7 +5066,7 @@ static int at91ether_start(struct macb *bp)
 	if (ret)
 		return ret;
 
-	addr = queue->rx_buffers_dma;
+	addr = rxq->buffers_dma;
 	for (i = 0; i < AT91ETHER_MAX_RX_DESCR; i++) {
 		desc = macb_rx_desc(queue, i);
 		macb_set_addr(bp, desc, addr);
@@ -4998,10 +5078,10 @@ static int at91ether_start(struct macb *bp)
 	desc->addr |= MACB_BIT(RX_WRAP);
 
 	/* Reset buffer index */
-	queue->rx_tail = 0;
+	rxq->tail = 0;
 
 	/* Program address of descriptor list in Rx Buffer Queue register */
-	macb_writel(bp, RBQP, queue->rx_ring_dma);
+	macb_writel(bp, RBQP, rxq->ring_dma);
 
 	/* Enable Receive and Transmit */
 	ctl = macb_readl(bp, NCR);
@@ -5139,15 +5219,15 @@ static void at91ether_rx(struct net_device *netdev)
 {
 	struct macb *bp = netdev_priv(netdev);
 	struct macb_queue *queue = &bp->queues[0];
+	struct macb_rxq *rxq = &bp->ctx->rxq[0];
 	struct macb_dma_desc *desc;
 	unsigned char *p_recv;
 	struct sk_buff *skb;
 	unsigned int pktlen;
 
-	desc = macb_rx_desc(queue, queue->rx_tail);
+	desc = macb_rx_desc(queue, rxq->tail);
 	while (desc->addr & MACB_BIT(RX_USED)) {
-		p_recv = queue->rx_buffers +
-			 queue->rx_tail * AT91ETHER_MAX_RBUFF_SZ;
+		p_recv = rxq->buffers + rxq->tail * AT91ETHER_MAX_RBUFF_SZ;
 		pktlen = MACB_BF(RX_FRMLEN, desc->ctrl);
 		skb = netdev_alloc_skb(netdev, pktlen + 2);
 		if (skb) {
@@ -5169,12 +5249,12 @@ static void at91ether_rx(struct net_device *netdev)
 		desc->addr &= ~MACB_BIT(RX_USED);
 
 		/* wrap after last buffer */
-		if (queue->rx_tail == AT91ETHER_MAX_RX_DESCR - 1)
-			queue->rx_tail = 0;
+		if (rxq->tail == AT91ETHER_MAX_RX_DESCR - 1)
+			rxq->tail = 0;
 		else
-			queue->rx_tail++;
+			rxq->tail++;
 
-		desc = macb_rx_desc(queue, queue->rx_tail);
+		desc = macb_rx_desc(queue, rxq->tail);
 	}
 }
 
@@ -5829,6 +5909,8 @@ static int macb_probe(struct platform_device *pdev)
 	bp->rx_clk = rx_clk;
 	bp->tsu_clk = tsu_clk;
 	bp->jumbo_max_len = macb_config->jumbo_max_len;
+	bp->configured_rx_ring_size = DEFAULT_RX_RING_SIZE;
+	bp->configured_tx_ring_size = DEFAULT_TX_RING_SIZE;
 
 	if (!hw_is_gem(bp->regs, bp->native_io))
 		bp->max_tx_length = MACB_MAX_TX_LEN;

-- 
2.53.0


