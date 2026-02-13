Return-Path: <netdev+bounces-258650-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGzBBLJYj2lqQQEAu9opvQ
	(envelope-from <netdev+bounces-258650-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 18:00:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60680138722
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 18:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 409933010143
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 16:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD449364054;
	Fri, 13 Feb 2026 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="leqn469t"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695C03624D5
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771001930; cv=none; b=gCruFPcpMZyblTimGEN5UDVrD+6yyKGdGntWn6Idt3CW8w1GYRoJj5L9ODx85+JlSPFUKXTpAysci+GwYQdroxWwlbrjMDaWAbjh6HWOBXs4i2gS+R8LXtHCPf99xwTmkRv1a/Wf/F2HVvqYxAdsdBEkjtFA1npd8m+r6g48ayc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771001930; c=relaxed/simple;
	bh=0UuiXe5ocDED9FX6bVMTYGQVnw0H4k4iNS53hw2DuyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r4hhb+XtSsLCNqIMbnzJxv4whP9N1UXGKd3Xb+8oERgfbvkBGP5jn0dkX41I7yvvt2wYg6CIShZQ//9ilk7Q5afyjFrbf2dPNmCuFdTtV7+Ox8X1rxPxZ/6t9NtYZrPlNQ9r61x/2I1Dd2w2oCDLwdSIGYSsqWBAURky2HllYAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=leqn469t; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id F16C04E40D3D;
	Fri, 13 Feb 2026 16:58:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C76FC606BE;
	Fri, 13 Feb 2026 16:58:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E213110368F17;
	Fri, 13 Feb 2026 17:58:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771001927; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=v7UgD95WyiStMjhsDvEPz2qSedDTSz2QsZrrZYH2CuM=;
	b=leqn469tFdf4PBVhsBueam0cUrQajely7GvJR3L5fWCaKyC4W3p2bSh7oqbAmGWLBj2gor
	Q7ydi2T5O7EF6iRw4WBZui5oD7DPughHDCAIolr2yZy63Ykzoulr63m1D/ZN35XRCryaHr
	NF0W7ecCXNE0K93dV7Non54X9aOiIIfa0vec1DJ8K+ijOmhKWhLWOpPrPuUpWlKvGWlnYF
	fGoJwxdjUyJqTYXq6JpuwHlQamJOYdW2ivaTDaRLBPEKjPvH1frLG2IXTyTB0gDcDT6Gsb
	6nQB/7moz7F4qUGxEctmK1UQ10LkRr+avNjxIBBJZxaN19utn05lBQFTkP98tw==
From: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
To: theo.lebrun@bootlin.com
Cc: andrew+netdev@lunn.ch,
	claudiu.beznea@tuxon.dev,
	davem@davemloft.net,
	edumazet@google.com,
	gregory.clement@bootlin.com,
	kuba@kernel.org,
	lorenzo@kernel.org,
	netdev@vger.kernel.org,
	nicolas.ferre@microchip.com,
	pabeni@redhat.com,
	pvalerio@redhat.com,
	thomas.petazzoni@bootlin.com
Subject: [PATCH 6/6] net: macb: rework macb_tx_complete() processing loop
Date: Fri, 13 Feb 2026 17:57:59 +0100
Message-ID: <20260213165759.225449-6-theo.lebrun@bootlin.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213165759.225449-1-theo.lebrun@bootlin.com>
References: <DG4MBFXG7GGG.3GFLWBUKH087T@bootlin.com>
 <20260213165759.225449-1-theo.lebrun@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258650-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13]
X-Rspamd-Queue-Id: 60680138722
X-Rspamd-Action: no action

The SKB case of macb_tx_complete() must iterate over buffers taking into
account frames might be multi-buffer. Following that, the code for XDP
got integrated into the same loop. But in XDP cases, frames must be
single buffer.

Knowing that, we reverse operations: first we check the buffer type,
then we iterate to consume all frame buffers if it is an SKB buffer.

Side-effects:

 - Statistics tx_packets and tx_bytes are now incremented for
   XDP_TX and XDP_NDO frames as well.

 - Only increment statistics once per macb_tx_complete() call rather
   than once per frame.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 71 +++++++++++-------------
 1 file changed, 33 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 2c7644f2215a..6c33af667405 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1202,11 +1202,10 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 	head = queue->tx_head;
 	for (tail = queue->tx_tail; tail != head && packets < budget; tail++) {
-		void			*data = NULL;
-		struct macb_tx_buff	*tx_buff;
-		struct sk_buff		*skb;
-		struct macb_dma_desc	*desc;
-		u32			ctrl;
+		struct macb_tx_buff *tx_buff;
+		struct macb_dma_desc *desc;
+		struct sk_buff *skb;
+		u32 ctrl;
 
 		desc = macb_tx_desc(queue, tail);
 
@@ -1221,48 +1220,44 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 		if (!(ctrl & MACB_BIT(TX_USED)))
 			break;
 
-		/* Process all buffers of the current transmitted frame */
-		for (;; tail++) {
-			tx_buff = macb_tx_buff(queue, tail);
+		tx_buff = macb_tx_buff(queue, tail);
 
-			if (tx_buff->type != MACB_TYPE_SKB) {
-				data = tx_buff->ptr;
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
-			if (tx_buff->type == MACB_TYPE_SKB && tx_buff->ptr) {
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
-			/* skb is set only for the last buffer of the frame.
-			 * WARNING: at this point skb has been freed by
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
 				  packets, bytes);
 
-- 
2.53.0


