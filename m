Return-Path: <netdev+bounces-274184-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGkmOxpLzWl6bgYAu9opvQ
	(envelope-from <netdev+bounces-274184-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 18:43:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D074137E10B
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 18:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB6E0306DD6F
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 16:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE2B47A0A9;
	Wed,  1 Apr 2026 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zLlB3BlQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A452F310651
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775061575; cv=none; b=kSEkCcLokrsX5YfukZwUrl0ZnkYqTrs6p3wbbBenI5XoQofLxKyUqIDMh0INgn/FpKK3u//IHUw1eK/KZ1IKeZQkRgGxALx+AZNnWMjGnwoz+wmnAa+ZF7/oWa1KAqrMisGAEAfNbNMNs+AMiNVz73LhhHei76lXLmeMfCONqqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775061575; c=relaxed/simple;
	bh=2Li85y3O0B5xRflVjiPQmdDthz1Sij/s+po81PL0O5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bbMJBfpsXkFaM1Fs5ePff/80tI+zXBIO7aNkUms++/ayc52/2P0rC3OvsykYlmi75tCxivTaBDGtSWnHzrx8D+mXeG+jboW+YDWYqVoDE2FmYn0Fv06qreb5nn4uMHFLqWr3YdyZ6xX3m2EYndFaADjE2ry8Y0E9dOrlOXAHAlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zLlB3BlQ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3B2DD1A30B4;
	Wed,  1 Apr 2026 16:39:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 11656602BF;
	Wed,  1 Apr 2026 16:39:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 94F7510450306;
	Wed,  1 Apr 2026 18:39:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775061569; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DWtIq6jd1F1PaNYVYR5QTVPdsPIiGubpvbe0+JPvC9s=;
	b=zLlB3BlQyXf0HvaA39mmXsTSYrpAbohWHoKNcgIHs/WQY9I8t1pcHN7rJve5bTQj44YoCc
	kcuTvlG2XKfElBvPFaB9o7sDtBvSQROixp6HFz8kO0POj8kZmX2m+bBNlJ0CkYpG8f14xn
	EYd6cj3QMz12TIRtOl07ia0X77M0jUMjbGvVUz0PWA4hjjSUl3zqB5zwUUh9dJM7C6YP/1
	YnbPM+JzbjOSTcrpHIz1qCJBlcrkUiiO9FbVEV8t9m7yT6R8ThA6Low2zy2mqv5SOgRkw5
	Oea+L/PcETGAyUtlkR4JIbhfJzh8eIrtx1qhKK4VR6OeaP8PphL5ASsxF9JCqA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 01 Apr 2026 18:39:06 +0200
Subject: [PATCH net-next 03/11] net: macb: unify queue index variable
 naming convention and types
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260401-macb-context-v1-3-9590c5ab7272@bootlin.com>
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
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274184-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D074137E10B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Variables are named q or queue_index. Types are int, unsigned int, u32
and u16. Use `unsigned int q` everywhere.

Skip over taprio functions. They use `u8 queue_id` which fits with the
`struct macb_queue_enst_config` field. Using `queue_id` everywhere
would be too verbose.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 05ccb6f186f7..087401163771 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -873,7 +873,7 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 static void gem_shuffle_tx_rings(struct macb *bp)
 {
 	struct macb_queue *queue;
-	int q;
+	unsigned int q;
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; q++, queue++)
 		gem_shuffle_tx_one_ring(queue);
@@ -1254,7 +1254,7 @@ static void macb_tx_error_task(struct work_struct *work)
 						      tx_error_task);
 	bool			halt_timeout = false;
 	struct macb		*bp = queue->bp;
-	u32			queue_index;
+	unsigned int		q;
 	u32			packets = 0;
 	u32			bytes = 0;
 	struct macb_tx_skb	*tx_skb;
@@ -1263,9 +1263,9 @@ static void macb_tx_error_task(struct work_struct *work)
 	unsigned int		tail;
 	unsigned long		flags;
 
-	queue_index = queue - bp->queues;
+	q = queue - bp->queues;
 	netdev_vdbg(bp->netdev, "macb_tx_error_task: q = %u, t = %u, h = %u\n",
-		    queue_index, queue->tx_tail, queue->tx_head);
+		    q, queue->tx_tail, queue->tx_head);
 
 	/* Prevent the queue NAPI TX poll from running, as it calls
 	 * macb_tx_complete(), which in turn may call netif_wake_subqueue().
@@ -1338,7 +1338,7 @@ static void macb_tx_error_task(struct work_struct *work)
 		macb_tx_unmap(bp, tx_skb, 0);
 	}
 
-	netdev_tx_completed_queue(netdev_get_tx_queue(bp->netdev, queue_index),
+	netdev_tx_completed_queue(netdev_get_tx_queue(bp->netdev, q),
 				  packets, bytes);
 
 	/* Set end of TX queue */
@@ -1403,7 +1403,7 @@ static bool ptp_one_step_sync(struct sk_buff *skb)
 static int macb_tx_complete(struct macb_queue *queue, int budget)
 {
 	struct macb *bp = queue->bp;
-	u16 queue_index = queue - bp->queues;
+	unsigned int q = queue - bp->queues;
 	unsigned long flags;
 	unsigned int tail;
 	unsigned int head;
@@ -1465,14 +1465,14 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 		}
 	}
 
-	netdev_tx_completed_queue(netdev_get_tx_queue(bp->netdev, queue_index),
+	netdev_tx_completed_queue(netdev_get_tx_queue(bp->netdev, q),
 				  packets, bytes);
 
 	queue->tx_tail = tail;
-	if (__netif_subqueue_stopped(bp->netdev, queue_index) &&
+	if (__netif_subqueue_stopped(bp->netdev, q) &&
 	    CIRC_CNT(queue->tx_head, queue->tx_tail,
 		     bp->tx_ring_size) <= MACB_TX_WAKEUP_THRESH(bp))
-		netif_wake_subqueue(bp->netdev, queue_index);
+		netif_wake_subqueue(bp->netdev, q);
 	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 
 	if (packets)
@@ -2496,10 +2496,10 @@ static int macb_pad_and_fcs(struct sk_buff **skb, struct net_device *netdev)
 static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 				   struct net_device *netdev)
 {
-	u16 queue_index = skb_get_queue_mapping(skb);
 	struct macb *bp = netdev_priv(netdev);
-	struct macb_queue *queue = &bp->queues[queue_index];
+	unsigned int q = skb_get_queue_mapping(skb);
 	unsigned int desc_cnt, nr_frags, frag_size, f;
+	struct macb_queue *queue = &bp->queues[q];
 	unsigned int hdrlen;
 	unsigned long flags;
 	bool is_lso;
@@ -2539,7 +2539,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 #if defined(DEBUG) && defined(VERBOSE_DEBUG)
 	netdev_vdbg(bp->netdev,
 		    "start_xmit: queue %hu len %u head %p data %p tail %p end %p\n",
-		    queue_index, skb->len, skb->head, skb->data,
+		    q, skb->len, skb->head, skb->data,
 		    skb_tail_pointer(skb), skb_end_pointer(skb));
 	print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_OFFSET, 16, 1,
 		       skb->data, 16, true);
@@ -2565,7 +2565,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 	/* This is a hard error, log it. */
 	if (CIRC_SPACE(queue->tx_head, queue->tx_tail,
 		       bp->tx_ring_size) < desc_cnt) {
-		netif_stop_subqueue(netdev, queue_index);
+		netif_stop_subqueue(netdev, q);
 		netdev_dbg(netdev, "tx_head = %u, tx_tail = %u\n",
 			   queue->tx_head, queue->tx_tail);
 		ret = NETDEV_TX_BUSY;
@@ -2581,7 +2581,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 	/* Make newly initialized descriptor visible to hardware */
 	wmb();
 	skb_tx_timestamp(skb);
-	netdev_tx_sent_queue(netdev_get_tx_queue(bp->netdev, queue_index),
+	netdev_tx_sent_queue(netdev_get_tx_queue(bp->netdev, q),
 			     skb->len);
 
 	spin_lock(&bp->lock);
@@ -2590,7 +2590,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 	spin_unlock(&bp->lock);
 
 	if (CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx_ring_size) < 1)
-		netif_stop_subqueue(netdev, queue_index);
+		netif_stop_subqueue(netdev, q);
 
 unlock:
 	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);

-- 
2.53.0


