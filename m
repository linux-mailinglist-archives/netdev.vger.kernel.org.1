Return-Path: <netdev+bounces-303736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 09omB5U5RWpr8woAu9opvQ
	(envelope-from <netdev+bounces-303736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:00:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A82E06EF71D
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:00:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=lSeyP49v;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303736-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303736-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 38C88305C07A
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 15:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE824963A6;
	Wed,  1 Jul 2026 15:59:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCC74921BC;
	Wed,  1 Jul 2026 15:59:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921568; cv=none; b=jlTyEotMZ8ja8ZlJNFVRKS2CZRw6i7PgE0UpoBrBQ4GaB1NgPnYFgSpUTqHE3yJmW1obrpIzvQt5iKFwqPxTfSe/x2TcZb2eb8E3m37CWBmF2xj4C0TncPKyD1iQj80h9Npu0vbmgcaxeolodqDdW7gvv/i0/PEEZ6Vbkm2Yga4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921568; c=relaxed/simple;
	bh=U3mfovUrqYVXlBxnJXMTg0G3KY1y/ExbXMXi+omXq14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q82YjMa/8DmNmYB+uQwsH8rtWUu2njivjn38OKqOCTTnyjanYsGXIwU4SGame0PrKNNVxaXQWNA79WM6IljZqcgUo7z5JMZ0oa1lOSfxFndLRjlTGaQfbdod0t7Yr/T5Cne9A4mLt24vV5qJWYWcFlFU3YVP+//HiZlDsjNVSkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lSeyP49v; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B0A904E40BD1;
	Wed,  1 Jul 2026 15:59:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 842E760288;
	Wed,  1 Jul 2026 15:59:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4CC62104C9682;
	Wed,  1 Jul 2026 17:59:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782921564; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ujgmya6r58Oj2aH35bctynGlkrh9YKUWIfZDMRe623A=;
	b=lSeyP49vxUWVAjlR67PbFhhHJDEbVO5k7bJL+xNwOMKAfk7NPt7viA4A7MJkODrOnvGENx
	1Cq6545ZIcmznrb6TtWa6V7eAhUsoirkRSx8SrP2Ss+UTce6wC62A9NS3ab7690kjXERPH
	6RADgeq1NID/JhzFt07rgg628IZtKeVWCWw7Ares+YocyxT/wZ/sYnEfBRY8+j/sofpoZb
	QmE7O9f2EfGpa7Vh+GfPmf07+Aqg6f89VMmyuz5CyfnQqI80P88bi/XMY4nYxGAl4itG0U
	HBa66aUnMNyKgqNsaSGSXo6VlB160Ds8CpYizV3u7RpJR4tuCAE3nIGIL4Rbwg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 01 Jul 2026 17:59:08 +0200
Subject: [PATCH net-next v3 05/15] net: macb: enforce reverse christmas
 tree (RCT) convention
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260701-macb-context-v3-5-00268d5b1502@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303736-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,bootlin.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A82E06EF71D

Enforce the reverse christmas tree convention in those functions:

   macb_tx_error_task()
   gem_rx_refill()
   gem_rx()
   macb_rx_frame()
   macb_init_rx_ring()
   macb_rx()
   macb_rx_pending()
   macb_start_xmit()

The goal is to minimise unrelated diff in future patches.

In macb_tx_error_task(), we fold the assignment into the declaration
statement.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 61 ++++++++++++++++----------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 3b75797381b6..8b52122bc134 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1254,20 +1254,19 @@ static dma_addr_t macb_get_addr(struct macb *bp, struct macb_dma_desc *desc)
 
 static void macb_tx_error_task(struct work_struct *work)
 {
-	struct macb_queue	*queue = container_of(work, struct macb_queue,
-						      tx_error_task);
-	bool			halt_timeout = false;
-	struct macb		*bp = queue->bp;
-	unsigned int		q;
-	u32			packets = 0;
-	u32			bytes = 0;
-	struct macb_tx_skb	*tx_skb;
-	struct macb_dma_desc	*desc;
-	struct sk_buff		*skb;
-	unsigned int		tail;
-	unsigned long		flags;
+	struct macb_queue *queue = container_of(work, struct macb_queue,
+						tx_error_task);
+	unsigned int q = queue - queue->bp->queues;
+	struct macb *bp = queue->bp;
+	struct macb_tx_skb *tx_skb;
+	struct macb_dma_desc *desc;
+	bool halt_timeout = false;
+	struct sk_buff *skb;
+	unsigned long flags;
+	unsigned int tail;
+	u32 packets = 0;
+	u32 bytes = 0;
 
-	q = queue - bp->queues;
 	netdev_vdbg(bp->netdev, "macb_tx_error_task: q = %u, t = %u, h = %u\n",
 		    q, queue->tx_tail, queue->tx_head);
 
@@ -1487,11 +1486,11 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 
 static void gem_rx_refill(struct macb_queue *queue)
 {
-	unsigned int		entry;
-	struct sk_buff		*skb;
-	dma_addr_t		paddr;
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
+	struct sk_buff *skb;
+	unsigned int entry;
+	dma_addr_t paddr;
 
 	while (CIRC_SPACE(queue->rx_prepared_head, queue->rx_tail,
 			bp->rx_ring_size) > 0) {
@@ -1584,11 +1583,11 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		  int budget)
 {
 	struct macb *bp = queue->bp;
-	unsigned int		len;
-	unsigned int		entry;
-	struct sk_buff		*skb;
-	struct macb_dma_desc	*desc;
-	int			count = 0;
+	struct macb_dma_desc *desc;
+	struct sk_buff *skb;
+	unsigned int entry;
+	unsigned int len;
+	int count = 0;
 
 	while (count < budget) {
 		u32 ctrl;
@@ -1674,12 +1673,12 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 static int macb_rx_frame(struct macb_queue *queue, struct napi_struct *napi,
 			 unsigned int first_frag, unsigned int last_frag)
 {
-	unsigned int len;
-	unsigned int frag;
+	struct macb *bp = queue->bp;
+	struct macb_dma_desc *desc;
 	unsigned int offset;
 	struct sk_buff *skb;
-	struct macb_dma_desc *desc;
-	struct macb *bp = queue->bp;
+	unsigned int frag;
+	unsigned int len;
 
 	desc = macb_rx_desc(queue, last_frag);
 	len = desc->ctrl & bp->rx_frm_len_mask;
@@ -1755,9 +1754,9 @@ static int macb_rx_frame(struct macb_queue *queue, struct napi_struct *napi,
 
 static inline void macb_init_rx_ring(struct macb_queue *queue)
 {
+	struct macb_dma_desc *desc = NULL;
 	struct macb *bp = queue->bp;
 	dma_addr_t addr;
-	struct macb_dma_desc *desc = NULL;
 	int i;
 
 	addr = queue->rx_buffers_dma;
@@ -1776,9 +1775,9 @@ static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
 {
 	struct macb *bp = queue->bp;
 	bool reset_rx_queue = false;
-	int received = 0;
-	unsigned int tail;
 	int first_frag = -1;
+	unsigned int tail;
+	int received = 0;
 
 	for (tail = queue->rx_tail; budget > 0; tail++) {
 		struct macb_dma_desc *desc = macb_rx_desc(queue, tail);
@@ -1853,8 +1852,8 @@ static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
 static bool macb_rx_pending(struct macb_queue *queue)
 {
 	struct macb *bp = queue->bp;
-	unsigned int		entry;
-	struct macb_dma_desc	*desc;
+	struct macb_dma_desc *desc;
+	unsigned int entry;
 
 	entry = macb_rx_ring_wrap(bp, queue->rx_tail);
 	desc = macb_rx_desc(queue, entry);
@@ -2474,10 +2473,10 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 	unsigned int q = skb_get_queue_mapping(skb);
 	unsigned int desc_cnt, nr_frags, frag_size, f;
 	struct macb_queue *queue = &bp->queues[q];
+	netdev_tx_t ret = NETDEV_TX_OK;
 	unsigned int hdrlen;
 	unsigned long flags;
 	bool is_lso;
-	netdev_tx_t ret = NETDEV_TX_OK;
 
 	if (macb_clear_csum(skb)) {
 		dev_kfree_skb_any(skb);

-- 
2.55.0


