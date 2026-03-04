Return-Path: <netdev+bounces-263993-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAuQKTt5qGnpugAAu9opvQ
	(envelope-from <netdev+bounces-263993-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:26:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 225DA2064A0
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DDFF3053CE8
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 18:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EB73D7D96;
	Wed,  4 Mar 2026 18:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xYj+FOig"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32233CD8AA
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 18:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648641; cv=none; b=cj2KemHPsHLjvByGzQZrXJSDq0r0rSDgU//DlSViGvOvuVAGssKBrCViP36pkBw0fXPUaHSAoXfo/z9XnIeS88tzTqa7aJeKBmHgSjRkF+YqwxYV70vtxMILGnzkTHcvgdChqasLNlOpm5KoXx8odT4my9Xb8bMZYbhnSKcct2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648641; c=relaxed/simple;
	bh=gExp/m0uv0I2CpCXmMKevKdtVBq/K6XyZ9iXZ8ojeYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kX5V1FjBMlq//Q+Pr+/xJH5+kajfbYNWC4IkKrHFlKCpYXG5H7t1Ggzv7eTAmbmmMFuMCjFVMPhh2X6/ceZ1yw8CpXRWplDBCfpcrLmENom34381m2sFWQANRY2MGLHKfEean+LGtkUqMOono2K59hSrITXXgP6AQ1d1X910jdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xYj+FOig; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id AA7C54E42544;
	Wed,  4 Mar 2026 18:23:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 788015FF5C;
	Wed,  4 Mar 2026 18:23:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CB476103694F8;
	Wed,  4 Mar 2026 19:23:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772648637; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dzl/qreKh68sppWaNDnY8qNK5Kh//0XfSDDQisblgGk=;
	b=xYj+FOigGbPONNXz/Vyy9F0IOlMRie/Vb9p8u3BKuobRRDcyImEvUHtrnBoXEkBiJTou8g
	fKIai177jJ9uOXnxbkdd5FQVgQI/2zCoGy6zcR47FLilNGTCtV0OmXCeJ7E/qpz+gvEyN1
	sP3juI9IUHT+TbU0vjj+6qyIuK3Kydwha+QvXXmAwEw0M6VtmqhzALeu1PGS9g+utnt4jV
	bHC0DmV0gDnA6U2E9lijBCaETWvg00fuOUiwLXXApuHi+BAVrra3bg5nMvjydtm3LLpn/p
	gbxl5PiQJe++4Jgd7htOqpn/nNh3BqggfLit+ik2ofvvWHGRU9myYw9orD01XQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 04 Mar 2026 19:23:46 +0100
Subject: [PATCH net-next 3/8] net: macb: account for stats in Tx XDP
 codepaths
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260304-macb-xsk-v1-3-3d036076abf5@bootlin.com>
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
X-Rspamd-Queue-Id: 225DA2064A0
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
	TAGGED_FROM(0.00)[bounces-263993-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

macb_tx_complete() processing loop assumes a packet is composed of
multiple frames and composes around this idea. However, this is only
true in the SKB case ie `tx_buff->type == MACB_TYPE_SKB`.

Rework macb_tx_complete() to bring the tx_buff->type switch statement
outside and the frame iteration loop now lives only inside the SKB
case.

Fix Tx XDP stats that were not accounted for, in the XDP_TX|NDO cases.
Only increment statistics once per macb_tx_complete() call rather than
once per frame.

The `bytes` and `packets` stack variables now gets incremented for
completed XDP XMIT/TX packets. This implies the DQL subsystem through
netdev_tx_completed_queue() now gets notified of those packets
completing. We must therefore also report those bytes as sent, using
netdev_tx_sent_queue(), in macb_xdp_submit_frame() called by:
 - Rx XDP programs returning action XDP_TX and,
 - the .ndo_xdp_xmit() callback.

Incrementing `packets` also implies XDP packets are accounted for in our
NAPI budget calculation.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 71 +++++++++++++++-----------------
 1 file changed, 33 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 1aa90499343a..c1677f1d8f23 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1212,7 +1212,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 {
 	struct macb *bp = queue->bp;
 	unsigned long flags;
-	int skb_packets = 0;
+	int xsk_frames = 0;
 	unsigned int tail;
 	unsigned int head;
 	u16 queue_index;
@@ -1227,7 +1227,6 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 		struct macb_tx_buff *tx_buff;
 		struct macb_dma_desc *desc;
 		struct sk_buff *skb;
-		void *data = NULL;
 		u32 ctrl;
 
 		desc = macb_tx_desc(queue, tail);
@@ -1243,52 +1242,46 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 		if (!(ctrl & MACB_BIT(TX_USED)))
 			break;
 
-		/* Process all buffers of the current transmitted frame */
-		for (;; tail++) {
-			tx_buff = macb_tx_buff(queue, tail);
+		tx_buff = macb_tx_buff(queue, tail);
 
-			if (tx_buff->type != MACB_TYPE_SKB) {
-				data = tx_buff->ptr;
-				packets++;
-				goto unmap;
+		switch (tx_buff->type) {
+		case MACB_TYPE_SKB:
+			/* Process all buffers of the current transmitted frame */
+			while (!tx_buff->ptr) {
+				macb_tx_unmap(bp, tx_buff, budget);
+				tail++;
+				tx_buff = macb_tx_buff(queue, tail);
 			}
 
-			/* First, update TX stats if needed */
-			if (tx_buff->ptr) {
-				data = tx_buff->ptr;
-				skb = tx_buff->ptr;
+			skb = tx_buff->ptr;
 
-				if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
-				    !ptp_one_step_sync(skb))
-					gem_ptp_do_txstamp(bp, skb, desc);
+			if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
+			    !ptp_one_step_sync(skb))
+				gem_ptp_do_txstamp(bp, skb, desc);
 
-				netdev_vdbg(bp->dev, "skb %u (data %p) TX complete\n",
-					    macb_tx_ring_wrap(bp, tail),
-					    skb->data);
-				bp->dev->stats.tx_packets++;
-				queue->stats.tx_packets++;
-				bp->dev->stats.tx_bytes += skb->len;
-				queue->stats.tx_bytes += skb->len;
-				skb_packets++;
-				packets++;
-				bytes += skb->len;
-			}
+			netdev_vdbg(bp->dev, "skb %u (data %p) TX complete\n",
+				    macb_tx_ring_wrap(bp, tail),
+				    skb->data);
+			bytes += skb->len;
+			break;
 
-unmap:
-			/* Now we can safely release resources */
-			macb_tx_unmap(bp, tx_buff, budget);
-
-			/* data is set only for the last buffer of the frame.
-			 * WARNING: at this point the buffer has been freed by
-			 * macb_tx_unmap().
-			 */
-			if (data)
-				break;
+		case MACB_TYPE_XDP_TX:
+		case MACB_TYPE_XDP_NDO:
+			bytes += tx_buff->size;
+			break;
 		}
+
+		packets++;
+		macb_tx_unmap(bp, tx_buff, budget);
 	}
 
+	bp->dev->stats.tx_packets += packets;
+	queue->stats.tx_packets += packets;
+	bp->dev->stats.tx_bytes += bytes;
+	queue->stats.tx_bytes += bytes;
+
 	netdev_tx_completed_queue(netdev_get_tx_queue(bp->dev, queue_index),
-				  skb_packets, bytes);
+				  packets, bytes);
 
 	queue->tx_tail = tail;
 	if (__netif_subqueue_stopped(bp->dev, queue_index) &&
@@ -1529,6 +1522,8 @@ static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xdpf,
 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
 	spin_unlock(&bp->lock);
 
+	netdev_tx_sent_queue(netdev_get_tx_queue(bp->dev, queue_index), xdpf->len);
+
 	if (CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx_ring_size) < 1)
 		netif_stop_subqueue(dev, queue_index);
 

-- 
2.53.0


