Return-Path: <netdev+bounces-263995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLcdB0N8qGmHuwAAu9opvQ
	(envelope-from <netdev+bounces-263995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:38:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B7F2067B1
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 079E331F8F9A
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 18:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36303DBD67;
	Wed,  4 Mar 2026 18:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="K0g/+RgJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E8A3DA5DC;
	Wed,  4 Mar 2026 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648645; cv=none; b=KBoT+GlNSisvXuwsUj0VMfs9yvsQaefBn0EYVzQQqJtZDB6rap8OOaIMTVNotZrWn2//158ASifFNpZSOVUvczAJZqE1kDunOBzpkzMDYVYCf4Lau4LTvKBtWK59y8ezf7aLg08kqj039r27WkFPO6SN4reAORTUeMJ80KrJ3JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648645; c=relaxed/simple;
	bh=lQQjYjZNPUbQ7rcixRKkV5WLW2kgdqScBVux9Qg7dOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YMUu0yAVWe9npOqvxwMlxvMNVGicNpa4dLwXvWOhRfurOKaod5FFMj+ayjTpWD3Yv+LhtT2EQbJ9zxRJr3IoLQANXpnj2e8AUl5Wz4bp9v7DM4GHZkosz2BnwlYV+/9rVPR2BwVBH+NuxQPw2WOQJQIs81hAzerJ+o1Hq7oCwr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=K0g/+RgJ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 949A41A2CB5;
	Wed,  4 Mar 2026 18:24:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 697095FF5C;
	Wed,  4 Mar 2026 18:24:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A9007103695EE;
	Wed,  4 Mar 2026 19:23:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772648641; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JtnE5Dd9ijOOlqqPU5d8+YUT29h7RsvROog7pXP+pnI=;
	b=K0g/+RgJ1llz1pIWEUZ1pnnkBvnbJtYaiRJaIaUSr+FpcuHTW5EUK27nrZk6QaDR+WTKZe
	fIP8vq/tNu26z/feB9y0IRfZbqX0z+0ECOU4y8F136n4UPB4r1skP490r1Un8Y4ixu63T6
	vGj9E7gLSQ+0DDRASx8wN3tMy8FRCFmuPNS1KgivTmXfcaXAABRiF3sACy++s1oHnYptvS
	+w9aVhLiKHOLzjHZTac1KZWzu9i2o+6RoIuMRO4kUpaQwHhPkH+3droRPw0WXykS0nfaXg
	meoxskiPDFsgCqFoI/tld+tFEfKdjD9kd0sc1zgcLj7PtulE9JBWDY4e65w5zg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 04 Mar 2026 19:23:48 +0100
Subject: [PATCH net-next 5/8] net: macb: move macb_xdp_submit_frame() body
 to helper function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260304-macb-xsk-v1-5-3d036076abf5@bootlin.com>
References: <20260304-macb-xsk-v1-0-3d036076abf5@bootlin.com>
In-Reply-To: <20260304-macb-xsk-v1-0-3d036076abf5@bootlin.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 72B7F2067B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263995-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid]
X-Rspamd-Action: no action

Part of macb_xdp_submit_frame() is specific to the handling of an XDP
buffer (pick a queue for emission, DMA map or sync, report emitted
bytes), part is chitchat with hardware to update DMA descriptor and
start transmit.

Move the hardware specific code out of macb_xdp_submit_frame() into a
macb_xdp_submit_buff() helper function. The goal is to make code
reusable to support XSK buffers.

The macb_xdp_submit_frame() body is modified slightly: we bring the
dma_map_single() call outside of the queue->tx_ptr_lock critical
section, to minimise its span.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 143 +++++++++++++++++--------------
 1 file changed, 78 insertions(+), 65 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ed94f9f0894b..65c2ec2a843c 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1208,6 +1208,52 @@ static bool ptp_one_step_sync(struct sk_buff *skb)
 	return false;
 }
 
+static void macb_xdp_submit_buff(struct macb *bp, unsigned int queue_index,
+				 struct macb_tx_buff buff)
+{
+	struct macb_queue *queue = &bp->queues[queue_index];
+	struct net_device *netdev = bp->dev;
+	struct macb_tx_buff *tx_buff;
+	struct macb_dma_desc *desc;
+	unsigned int next_head;
+	u32 ctrl;
+
+	next_head = queue->tx_head + 1;
+
+	ctrl = MACB_BIT(TX_USED);
+	desc = macb_tx_desc(queue, next_head);
+	desc->ctrl = ctrl;
+
+	desc = macb_tx_desc(queue, queue->tx_head);
+	tx_buff = macb_tx_buff(queue, queue->tx_head);
+	*tx_buff = buff;
+
+	ctrl = (u32)buff.size;
+	ctrl |= MACB_BIT(TX_LAST);
+
+	if (unlikely(macb_tx_ring_wrap(bp, queue->tx_head) == (bp->tx_ring_size - 1)))
+		ctrl |= MACB_BIT(TX_WRAP);
+
+	/* Set TX buffer descriptor */
+	macb_set_addr(bp, desc, buff.mapping);
+	/* desc->addr must be visible to hardware before clearing
+	 * 'TX_USED' bit in desc->ctrl.
+	 */
+	wmb();
+	desc->ctrl = ctrl;
+	queue->tx_head = next_head;
+
+	/* Make newly initialized descriptor visible to hardware */
+	wmb();
+
+	spin_lock(&bp->lock);
+	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
+	spin_unlock(&bp->lock);
+
+	if (CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx_ring_size) < 1)
+		netif_stop_subqueue(netdev, queue_index);
+}
+
 static int macb_tx_complete(struct macb_queue *queue, int budget)
 {
 	struct macb *bp = queue->bp;
@@ -1430,44 +1476,25 @@ static void discard_partial_frame(struct macb_queue *queue, unsigned int begin,
 }
 
 static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xdpf,
-				 struct net_device *dev, bool dma_map,
+				 struct net_device *netdev, bool dma_map,
 				 dma_addr_t addr)
 {
+	struct device *dev = &bp->pdev->dev;
 	enum macb_tx_buff_type buff_type;
-	struct macb_tx_buff *tx_buff;
 	int cpu = smp_processor_id();
-	struct macb_dma_desc *desc;
 	struct macb_queue *queue;
-	unsigned int next_head;
 	unsigned long flags;
 	dma_addr_t mapping;
 	u16 queue_index;
 	int err = 0;
-	u32 ctrl;
-
-	queue_index = cpu % bp->num_queues;
-	queue = &bp->queues[queue_index];
-	buff_type = dma_map ? MACB_TYPE_XDP_NDO : MACB_TYPE_XDP_TX;
-
-	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
-
-	/* This is a hard error, log it. */
-	if (CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx_ring_size) < 1) {
-		netif_stop_subqueue(dev, queue_index);
-		netdev_dbg(bp->dev, "tx_head = %u, tx_tail = %u\n",
-			   queue->tx_head, queue->tx_tail);
-		err = -ENOMEM;
-		goto unlock;
-	}
 
 	if (dma_map) {
-		mapping = dma_map_single(&bp->pdev->dev,
-					 xdpf->data,
-					 xdpf->len, DMA_TO_DEVICE);
-		if (unlikely(dma_mapping_error(&bp->pdev->dev, mapping))) {
-			err = -ENOMEM;
-			goto unlock;
-		}
+		mapping = dma_map_single(dev, xdpf->data, xdpf->len, DMA_TO_DEVICE);
+		err = dma_mapping_error(&bp->pdev->dev, mapping);
+		if (unlikely(err))
+			return err;
+
+		buff_type = MACB_TYPE_XDP_NDO;
 	} else {
 		/* progs can adjust the head. Sync and set the adjusted one.
 		 * This also implicitly takes into account ip alignment,
@@ -1476,52 +1503,38 @@ static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xdpf,
 		mapping = addr + xdpf->headroom + sizeof(*xdpf);
 		dma_sync_single_for_device(&bp->pdev->dev, mapping,
 					   xdpf->len, DMA_BIDIRECTIONAL);
+
+		buff_type = MACB_TYPE_XDP_TX;
 	}
 
-	next_head = queue->tx_head + 1;
+	queue_index = cpu % bp->num_queues;
+	queue = &bp->queues[queue_index];
 
-	ctrl = MACB_BIT(TX_USED);
-	desc = macb_tx_desc(queue, next_head);
-	desc->ctrl = ctrl;
+	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 
-	desc = macb_tx_desc(queue, queue->tx_head);
-	tx_buff = macb_tx_buff(queue, queue->tx_head);
-	tx_buff->ptr = xdpf;
-	tx_buff->type = buff_type;
-	tx_buff->mapping = dma_map ? mapping : 0;
-	tx_buff->size = xdpf->len;
-	tx_buff->mapped_as_page = false;
+	if (CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx_ring_size) < 1) {
+		/* This is a hard error, log it. */
+		netif_stop_subqueue(netdev, queue_index);
+		netdev_dbg(netdev, "tx_head = %u, tx_tail = %u\n",
+			   queue->tx_head, queue->tx_tail);
+		err = -ENOMEM;
+	} else {
+		macb_xdp_submit_buff(bp, queue_index, (struct macb_tx_buff){
+			.ptr = xdpf,
+			.mapping = dma_map ? mapping : 0,
+			.size = xdpf->len,
+			.mapped_as_page = false,
+			.type = buff_type,
+		});
 
-	ctrl = (u32)tx_buff->size;
-	ctrl |= MACB_BIT(TX_LAST);
+		netdev_tx_sent_queue(netdev_get_tx_queue(bp->dev, queue_index), xdpf->len);
+	}
 
-	if (unlikely(macb_tx_ring_wrap(bp, queue->tx_head) == (bp->tx_ring_size - 1)))
-		ctrl |= MACB_BIT(TX_WRAP);
-
-	/* Set TX buffer descriptor */
-	macb_set_addr(bp, desc, mapping);
-	/* desc->addr must be visible to hardware before clearing
-	 * 'TX_USED' bit in desc->ctrl.
-	 */
-	wmb();
-	desc->ctrl = ctrl;
-	queue->tx_head = next_head;
-
-	/* Make newly initialized descriptor visible to hardware */
-	wmb();
-
-	spin_lock(&bp->lock);
-	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
-	spin_unlock(&bp->lock);
-
-	netdev_tx_sent_queue(netdev_get_tx_queue(bp->dev, queue_index), xdpf->len);
-
-	if (CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx_ring_size) < 1)
-		netif_stop_subqueue(dev, queue_index);
-
-unlock:
 	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 
+	if (err && dma_map)
+		dma_unmap_single(dev, mapping, xdpf->len, DMA_TO_DEVICE);
+
 	return err;
 }
 

-- 
2.53.0


