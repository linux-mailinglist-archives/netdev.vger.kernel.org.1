Return-Path: <netdev+bounces-264004-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +P0OHg97qGmHuwAAu9opvQ
	(envelope-from <netdev+bounces-264004-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:33:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E487720668B
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7604306907C
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 18:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A333E3DAD;
	Wed,  4 Mar 2026 18:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CH56vEt7"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFE73E3D8D
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648702; cv=none; b=iLgxt9OnbOTBVfCZN2ySllXGjoS8iYeOrj9fflT/4DA0r3Y0taKGmh9wTN9/sAQ+hjDeKWLh7pihLPA446u8TaQAquRc2K0vq2+Df0e6tjcQMWx7p215r6JlEPj2rb2y/ABN/fd9mKpPPAsBhHsJXvqsCk4XAi8cFh7ounC8Ez0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648702; c=relaxed/simple;
	bh=vibvuKxVooPBJkXJkyFwoq08DAa9glaCCQBQpNxwfCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GJn9TRUfyJvKwwBCJIcpb72CjqyBG7StR/ZJgXAoLNL3TmbFfbIrNzJttk+YIb7R/48cVTYIi5qtOvnmMTfr+ROKdvpB08pRbd1+uHyThd1CjulaRUI07dnWeiMTlr9yaq2G9fyxpriZ0FUR1thtGqHwHBv67bxAkSGuGjGHHYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CH56vEt7; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7CE9B1A2C8D;
	Wed,  4 Mar 2026 18:24:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 533FA5FF5C;
	Wed,  4 Mar 2026 18:24:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A89561036960A;
	Wed,  4 Mar 2026 19:24:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772648698; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=s+cOyZ8u3T068fgeZVGs8jhtYZwKXq49c7tRInBCtPo=;
	b=CH56vEt7PpVL01KzdTpGssEy+FyW9dM1gqNqhUzRH9mM26f4fLsMwvUhzvzEW+TKeq+nVZ
	kdfRjfyj2q9nf2they9fVzl8dqNOGF5jkCz+HaxKLFzIalBifmgSbLooyow3m4Fbdcz5B1
	ASLPyhqAFIvybKh9OwIZ+xoeWxHAsj/I4rhRuC0JSyX9KMK4cy30QNe9goQxwtZYWH/L6H
	VKuSfMOBWaXHjcCtWB1y2K3Abvm1GeDIwhh0SoHQf4kFtDglXainz5fYE225PhrNAuGjcC
	Ju0+LISdEDrnrnKdoJTTe3LIZcWMwonM6IPVB1k/n/iOcXtWbaKm/RyJPX/mYg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 04 Mar 2026 19:24:31 +0100
Subject: [PATCH net-next 8/8] net: macb: add Tx zero-copy AF_XDP support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260304-macb-xsk-v1-8-ba2ebe2bdaa3@bootlin.com>
References: <20260304-macb-xsk-v1-0-ba2ebe2bdaa3@bootlin.com>
In-Reply-To: <20260304-macb-xsk-v1-0-ba2ebe2bdaa3@bootlin.com>
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
X-Rspamd-Queue-Id: E487720668B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264004-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid]
X-Rspamd-Action: no action

Add a new buffer type (to `enum macb_tx_buff_type`). Near the end of
macb_tx_complete(), we go and read the XSK buffers using
xsk_tx_peek_release_desc_batch() and append those buffers to our Tx
ring.

Additionally, in macb_tx_complete(), we signal to the XSK subsystem
number of bytes completed and conditionally mark the need_wakeup
flag.

Lastly, we update XSK wakeup by writing the TCOMP bit in the per-queue
IMR register, to ensure NAPI scheduling will take place.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      |  1 +
 drivers/net/ethernet/cadence/macb_main.c | 91 +++++++++++++++++++++++++++++---
 2 files changed, 86 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index a9e6f0289ecb..5700a285c08a 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -963,6 +963,7 @@ enum macb_tx_buff_type {
 	MACB_TYPE_SKB,
 	MACB_TYPE_XDP_TX,
 	MACB_TYPE_XDP_NDO,
+	MACB_TYPE_XSK,
 };
 
 /* struct macb_tx_buff - data about an skb or xdp frame which is being
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ea1b0b8c4fab..fee1ebadcf20 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -986,21 +986,30 @@ static int macb_halt_tx(struct macb *bp)
 
 static void macb_tx_release_buff(void *buff, enum macb_tx_buff_type type, int budget)
 {
-	if (type == MACB_TYPE_SKB) {
+	switch (type) {
+	case MACB_TYPE_SKB:
 		napi_consume_skb(buff, budget);
-	} else if (type == MACB_TYPE_XDP_TX) {
-		if (!budget)
-			xdp_return_frame(buff);
-		else
+		break;
+	case MACB_TYPE_XDP_TX:
+		if (budget)
 			xdp_return_frame_rx_napi(buff);
-	} else {
+		else
+			xdp_return_frame(buff);
+		break;
+	case MACB_TYPE_XDP_NDO:
 		xdp_return_frame(buff);
+		break;
+	case MACB_TYPE_XSK:
+		break;
 	}
 }
 
 static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff,
 			  int budget)
 {
+	if (tx_buff->type == MACB_TYPE_XSK)
+		return;
+
 	if (tx_buff->mapping) {
 		if (tx_buff->mapped_as_page)
 			dma_unmap_page(&bp->pdev->dev, tx_buff->mapping,
@@ -1255,6 +1264,57 @@ static void macb_xdp_submit_buff(struct macb *bp, unsigned int queue_index,
 		netif_stop_subqueue(netdev, queue_index);
 }
 
+static void macb_xdp_xmit_zc(struct macb *bp, unsigned int queue_index, int budget)
+{
+	struct macb_queue *queue = &bp->queues[queue_index];
+	struct xsk_buff_pool *xsk = queue->xsk_pool;
+	dma_addr_t mapping;
+	u32 slot_available;
+	size_t bytes = 0;
+	u32 batch;
+
+	guard(spinlock_irqsave)(&queue->tx_ptr_lock);
+
+	/* This is a hard error, log it. */
+	slot_available = CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx_ring_size);
+	if (slot_available < 1) {
+		netif_stop_subqueue(bp->dev, queue_index);
+		netdev_dbg(bp->dev, "tx_head = %u, tx_tail = %u\n",
+			   queue->tx_head, queue->tx_tail);
+		return;
+	}
+
+	batch = min_t(u32, slot_available, budget);
+	batch = xsk_tx_peek_release_desc_batch(xsk, batch);
+	if (!batch)
+		return;
+
+	for (u32 i = 0; i < batch; i++) {
+		struct xdp_desc *desc = &xsk->tx_descs[i];
+
+		mapping = xsk_buff_raw_get_dma(xsk, desc->addr);
+		xsk_buff_raw_dma_sync_for_device(xsk, mapping, desc->len);
+
+		macb_xdp_submit_buff(bp, queue_index, (struct macb_tx_buff){
+			.ptr = NULL,
+			.mapping = mapping,
+			.size = desc->len,
+			.mapped_as_page = false,
+			.type = MACB_TYPE_XSK,
+		});
+
+		bytes += desc->len;
+	}
+
+	/* Make newly initialized descriptor visible to hardware */
+	wmb();
+	spin_lock(&bp->lock);
+	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
+	spin_unlock(&bp->lock);
+
+	netdev_tx_sent_queue(netdev_get_tx_queue(bp->dev, queue_index), bytes);
+}
+
 static int macb_tx_complete(struct macb_queue *queue, int budget)
 {
 	struct macb *bp = queue->bp;
@@ -1316,6 +1376,11 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 		case MACB_TYPE_XDP_NDO:
 			bytes += tx_buff->size;
 			break;
+
+		case MACB_TYPE_XSK:
+			bytes += tx_buff->size;
+			xsk_frames++;
+			break;
 		}
 
 		packets++;
@@ -1337,6 +1402,16 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 		netif_wake_subqueue(bp->dev, queue_index);
 	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 
+	if (queue->xsk_pool) {
+		if (xsk_frames)
+			xsk_tx_completed(queue->xsk_pool, xsk_frames);
+
+		if (xsk_uses_need_wakeup(queue->xsk_pool))
+			xsk_set_tx_need_wakeup(queue->xsk_pool);
+
+		macb_xdp_xmit_zc(bp, queue_index, budget);
+	}
+
 	return packets;
 }
 
@@ -1616,6 +1691,10 @@ static int gem_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
 	    !napi_if_scheduled_mark_missed(&queue->napi_rx))
 		irqs |= MACB_BIT(RCOMP);
 
+	if ((flags & XDP_WAKEUP_TX) &&
+	    !napi_if_scheduled_mark_missed(&queue->napi_tx))
+		irqs |= MACB_BIT(TCOMP);
+
 	if (irqs)
 		queue_writel(queue, IMR, irqs);
 

-- 
2.53.0


