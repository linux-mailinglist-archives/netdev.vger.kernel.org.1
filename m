Return-Path: <netdev+bounces-265576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PuXMb/drmm/JQIAu9opvQ
	(envelope-from <netdev+bounces-265576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 15:48:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2AE23AD87
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 15:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F74930BEF1A
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 14:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B5D3D412B;
	Mon,  9 Mar 2026 14:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XcrZG738";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="McZESMKi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD633D4108
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067466; cv=none; b=NYpRFQd9LDJXzxR3JsXTVFNGZYyMkhA0vj7NslDi0DqZfpAAhDcPblwpZbHTv+cuUAxUt1L9kIzR5buUbglku89UZ07KF37gOSptyvEa+4X9aK6RdBCe8wwZYVR/SNDFmybWg7+ylWCa4ugBL3/lSC5fX7jamhsxPAMqScmaCUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067466; c=relaxed/simple;
	bh=sJjQM/+MEVJ4M+dNWTo4KZ60arQJwDhR9SDOoORuT2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGE42KXy5PupjpUXX3xSo8qCBOuHu90/BV0AKba39Zf2dDqM7c0YzwaRpgjsJMuSzUEhjezNe7Z7FKbpyW0lFmSKcaPXb4QvBlUgeDGxHX9wLKYBv+DGkKujLofQVyPMv5CaeLFWHikJ4gtPy9Kmm1c0Q9MJae9ujhZgnla80ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XcrZG738; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=McZESMKi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773067461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fvqbM9yloI59JQFfPay6wzoqrjS0TtshAWzgmk7mxjI=;
	b=XcrZG738qpAyL+stN9JHxyKtB+r9kq8aXRRXc3WQ6zixSwsYY5qvT0+PnimotayUMTX2ct
	3OcQS6C6vug6YxOE0+qq7gli9cEzV3cOmBBggV0tDpWjouJcu4pVJuWTdGlRk9217jq+7P
	MXPNj0muiZqp5FWLeF1WwqkfZxWAL8Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-BtflsFkzPWa72UbFIMgCoQ-1; Mon, 09 Mar 2026 10:44:19 -0400
X-MC-Unique: BtflsFkzPWa72UbFIMgCoQ-1
X-Mimecast-MFC-AGG-ID: BtflsFkzPWa72UbFIMgCoQ_1773067459
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4853b00f9f5so4322275e9.2
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 07:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773067458; x=1773672258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvqbM9yloI59JQFfPay6wzoqrjS0TtshAWzgmk7mxjI=;
        b=McZESMKijjsIIgzYb6YHRUW4MoNb1bnJ6O7NUEEdHjkr/FLXzAdi7rcX+XsWj0Bpio
         DWbqpKTKipzAw6g6/s09f2Uve6sk83B3BQUTWzOw/pD6VL0g2H3Qsq1mbhIfpT9xFleM
         pfBuuWUEJEuXC5vgpGu0le+d4w9/FIBuNt7w6vWC8csI52y9HdO2jf1SCW6qhmxGHjzM
         zlvk5p72aYz2ujzHPbibOSgWjJclKbwP3IMyi6EKydW4gkCYGyDZSWe81oKpJ0VtwYMU
         dZoPs0rrL/4brC4yKyurrtZDrfLqeUt8p1FgIBx1hkek5H4F2f1F6pgpbMtgT1ojLwmy
         X1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773067458; x=1773672258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fvqbM9yloI59JQFfPay6wzoqrjS0TtshAWzgmk7mxjI=;
        b=CDZ/5Z9Di3+x+m3tftW179rah8tCtgQ48JWgSyxAZhHxnR27p5pT5Hw8pLFgFkn5XF
         ALP7ytqnn8lPVmAkTmZQIdN7EbWdYXVbQs9d9QXOp3aK+efTUNyTXevPlqhXsPPHu+NU
         R6kg9/EoAhq84jXCZpmKdjSKgcLp9279mXxts3lVEYImML8jA1XwxwjffDBIdxGjCDRY
         law++Ru8gT4zydQ3lxG4PtOdXqm8bGh8a3cxVPQGUWvAnrUV1PvJGNVT9CYpANJ146Ui
         6mmjFFVK9LicLTudoyqYZEmutcDRFTXPx5c7vtLjnVIgTeS1G11AMkhLsofpVrR5JG8Q
         GWqQ==
X-Gm-Message-State: AOJu0YyRsGLy7+YmCPn1DEoeRQCwwQ6joYFmq1+tZ2ckQRPJbY3hz05O
	9zhJXSndCda1Bhrg6AUZD/spUOhUnZkpwRT4MGb7nOD2QNOMAmYUw+QNjz3TYDgPPU8oeVg82r3
	AotGOUbz5zENJZXZnXelamQC0eB2fDiFcnQzCW2YAp+Xfy+cCNm+boPEjaVceuj3Haw5ZxinLBR
	NC5uBOBbPYSFfGNiDvd/F66l4JB1aH/aMY35tTWGoTyg==
X-Gm-Gg: ATEYQzycetQsEvLxFTGZ2nJngyN4popeKKptvRLACwPCs3A+qlRvOgTYOmb+vat28UX
	cjB0eHVpfRT7Iwy484K3zAjO7hmGMxpQUUC3ta1Qe0FXrVzzM36d/zjJaZd82r4jzUMu18PM6ZY
	y1KDrbWClT07shxclVfiWYndrDGxU58H6wph8APa9+2G8kJ0rKtgZ+scplGO+w5zIDDM46NkMEz
	Ms9qRro3iPsgtOuED7ROCk+Je00GUQWNS/A9+LLJ/WR0Hyv3xWrU1eqMyUrwoiGcyK0BnWBtkiu
	XM76RhR7XZ8TX3ov61Kd2M6cTZDjj+3LE4U3pQrrYIqWlEUDNlT6fH9+SMa/Zc1u/f02AxWoAE0
	OjtwfrteHI5leIDPPmc+QVweyNVPAHK4Pfz1+ESlGH3VapN1TXKPPp+Hy6gs=
X-Received: by 2002:a05:600d:6443:10b0:485:3bc7:a21c with SMTP id 5b1f17b1804b1-4853bc7b45dmr39675115e9.24.1773067457886;
        Mon, 09 Mar 2026 07:44:17 -0700 (PDT)
X-Received: by 2002:a05:600d:6443:10b0:485:3bc7:a21c with SMTP id 5b1f17b1804b1-4853bc7b45dmr39674595e9.24.1773067457385;
        Mon, 09 Mar 2026 07:44:17 -0700 (PDT)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485246fd127sm133722465e9.6.2026.03.09.07.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:44:14 -0700 (PDT)
From: Paolo Valerio <pvalerio@redhat.com>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net-next v4 6/8] net: macb: generalize tx buffer handling
Date: Mon,  9 Mar 2026 15:43:51 +0100
Message-ID: <20260309144353.1213770-7-pvalerio@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309144353.1213770-1-pvalerio@redhat.com>
References: <20260309144353.1213770-1-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5C2AE23AD87
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265576-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Rename struct macb_tx_buff member skb to ptr and introduce
macb_tx_buff_type to identify the buffer type macb_tx_buff
represents.

Currently the buffer can only be MACB_TYPE_SKB, so the sk_buff
case is handled unconditionally in the tx path.
The remaining type handling will be handled by subsequent patches.

This is the last preparatory step for XDP xmit support.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/macb.h      | 25 ++++++++-----
 drivers/net/ethernet/cadence/macb_main.c | 45 ++++++++++++++----------
 2 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 1cc626088174..d8c581394b98 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -965,19 +965,28 @@ struct macb_dma_desc_ptp {
 /* Scaled PPM fraction */
 #define PPM_FRACTION	16
 
-/* struct macb_tx_buff - data about an skb which is being transmitted
- * @skb: skb currently being transmitted, only set for the last buffer
- *       of the frame
- * @mapping: DMA address of the skb's fragment buffer
+enum macb_tx_buff_type {
+	MACB_TYPE_SKB,
+	MACB_TYPE_XDP_TX,
+	MACB_TYPE_XDP_NDO,
+};
+
+/* struct macb_tx_buff - data about an skb or xdp frame which is being
+ * transmitted.
+ * @ptr: pointer to skb or xdp frame being transmitted, only set
+ *        for the last buffer for sk_buff
+ * @mapping: DMA address of the skb's fragment or xdp buffer
  * @size: size of the DMA mapped buffer
  * @mapped_as_page: true when buffer was mapped with skb_frag_dma_map(),
  *                  false when buffer was mapped with dma_map_single()
+ * @type: type of buffer (MACB_TYPE_SKB, MACB_TYPE_XDP_TX, MACB_TYPE_XDP_NDO)
  */
 struct macb_tx_buff {
-	struct sk_buff		*skb;
-	dma_addr_t		mapping;
-	size_t			size;
-	bool			mapped_as_page;
+	void				*ptr;
+	dma_addr_t			mapping;
+	size_t				size;
+	bool				mapped_as_page;
+	enum macb_tx_buff_type		type;
 };
 
 /* Hardware-collected statistics. Used when updating the network
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index b0f2ba338b22..13e4a3438439 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1098,7 +1098,8 @@ static int macb_halt_tx(struct macb *bp)
 					bp, TSR);
 }
 
-static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff, int budget)
+static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff,
+			  int budget)
 {
 	if (tx_buff->mapping) {
 		if (tx_buff->mapped_as_page)
@@ -1110,9 +1111,9 @@ static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff, int bud
 		tx_buff->mapping = 0;
 	}
 
-	if (tx_buff->skb) {
-		napi_consume_skb(tx_buff->skb, budget);
-		tx_buff->skb = NULL;
+	if (tx_buff->ptr) {
+		napi_consume_skb(tx_buff->ptr, budget);
+		tx_buff->ptr = NULL;
 	}
 }
 
@@ -1199,7 +1200,7 @@ static void macb_tx_error_task(struct work_struct *work)
 		desc = macb_tx_desc(queue, tail);
 		ctrl = desc->ctrl;
 		tx_buff = macb_tx_buff(queue, tail);
-		skb = tx_buff->skb;
+		skb = tx_buff->ptr;
 
 		if (ctrl & MACB_BIT(TX_USED)) {
 			/* skb is set for the last buffer of the frame */
@@ -1207,7 +1208,7 @@ static void macb_tx_error_task(struct work_struct *work)
 				macb_tx_unmap(bp, tx_buff, 0);
 				tail++;
 				tx_buff = macb_tx_buff(queue, tail);
-				skb = tx_buff->skb;
+				skb = tx_buff->ptr;
 			}
 
 			/* ctrl still refers to the first buffer descriptor
@@ -1304,20 +1305,22 @@ static bool ptp_one_step_sync(struct sk_buff *skb)
 static int macb_tx_complete(struct macb_queue *queue, int budget)
 {
 	struct macb *bp = queue->bp;
-	u16 queue_index = queue - bp->queues;
 	unsigned long flags;
 	unsigned int tail;
 	unsigned int head;
+	u16 queue_index;
 	int packets = 0;
 	u32 bytes = 0;
 
+	queue_index  = queue - bp->queues;
+
 	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 	head = queue->tx_head;
 	for (tail = queue->tx_tail; tail != head && packets < budget; tail++) {
-		struct macb_tx_buff	*tx_buff;
-		struct sk_buff		*skb;
-		struct macb_dma_desc	*desc;
-		u32			ctrl;
+		struct macb_tx_buff *tx_buff;
+		struct macb_dma_desc *desc;
+		struct sk_buff *skb;
+		u32 ctrl;
 
 		desc = macb_tx_desc(queue, tail);
 
@@ -1335,7 +1338,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 		/* Process all buffers of the current transmitted frame */
 		for (;; tail++) {
 			tx_buff = macb_tx_buff(queue, tail);
-			skb = tx_buff->skb;
+			skb = tx_buff->ptr;
 
 			/* First, update TX stats if needed */
 			if (skb) {
@@ -2266,7 +2269,8 @@ static unsigned int macb_tx_map(struct macb *bp,
 			goto dma_error;
 
 		/* Save info to properly release resources */
-		tx_buff->skb = NULL;
+		tx_buff->ptr = NULL;
+		tx_buff->type = MACB_TYPE_SKB;
 		tx_buff->mapping = mapping;
 		tx_buff->size = size;
 		tx_buff->mapped_as_page = false;
@@ -2294,7 +2298,8 @@ static unsigned int macb_tx_map(struct macb *bp,
 				goto dma_error;
 
 			/* Save info to properly release resources */
-			tx_buff->skb = NULL;
+			tx_buff->ptr = NULL;
+			tx_buff->type = MACB_TYPE_SKB;
 			tx_buff->mapping = mapping;
 			tx_buff->size = size;
 			tx_buff->mapped_as_page = true;
@@ -2312,7 +2317,8 @@ static unsigned int macb_tx_map(struct macb *bp,
 	}
 
 	/* This is the last buffer of the frame: save socket buffer */
-	tx_buff->skb = skb;
+	tx_buff->ptr = skb;
+	tx_buff->type = MACB_TYPE_SKB;
 
 	/* Update TX ring: update buffer descriptors in reverse order
 	 * to avoid race condition
@@ -5154,8 +5160,9 @@ static netdev_tx_t at91ether_start_xmit(struct sk_buff *skb,
 		netif_stop_queue(dev);
 
 		/* Store packet information (to free when Tx completed) */
-		lp->rm9200_txq[desc].skb = skb;
+		lp->rm9200_txq[desc].ptr = skb;
 		lp->rm9200_txq[desc].size = skb->len;
+		lp->rm9200_txq[desc].type = MACB_TYPE_SKB;
 		lp->rm9200_txq[desc].mapping = dma_map_single(&lp->pdev->dev, skb->data,
 							      skb->len, DMA_TO_DEVICE);
 		if (dma_mapping_error(&lp->pdev->dev, lp->rm9200_txq[desc].mapping)) {
@@ -5247,9 +5254,9 @@ static irqreturn_t at91ether_interrupt(int irq, void *dev_id)
 			dev->stats.tx_errors++;
 
 		desc = 0;
-		if (lp->rm9200_txq[desc].skb) {
-			dev_consume_skb_irq(lp->rm9200_txq[desc].skb);
-			lp->rm9200_txq[desc].skb = NULL;
+		if (lp->rm9200_txq[desc].ptr) {
+			dev_consume_skb_irq(lp->rm9200_txq[desc].ptr);
+			lp->rm9200_txq[desc].ptr = NULL;
 			dma_unmap_single(&lp->pdev->dev, lp->rm9200_txq[desc].mapping,
 					 lp->rm9200_txq[desc].size, DMA_TO_DEVICE);
 			dev->stats.tx_packets++;
-- 
2.53.0


