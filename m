Return-Path: <netdev+bounces-303744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jeGEMCw7RWrV8woAu9opvQ
	(envelope-from <netdev+bounces-303744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:07:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B39ED6EF7FA
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:07:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=iFhoTTiD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303744-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303744-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8FAF6303C6BC
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 16:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470284A2E17;
	Wed,  1 Jul 2026 15:59:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22EE4921B2;
	Wed,  1 Jul 2026 15:59:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921589; cv=none; b=Ickh3DRPC7TZZgW/o9bSzqH+/xEna6LJ3laY/iZSfjZCUHf0TFbO+a/Guv1HfdPcrytzvpRKgQAniW5Zae9Qp33BeESdC+nGOGjdhBV8AeVI1WS9NOXc+u0Csb1V3ZwdIqmfG+WYHbzBUXJr5av1XllOcTsKwNNmqLgMn/Bj170=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921589; c=relaxed/simple;
	bh=/tosRwyljAFm0dVI7ttz96XN6e4tMrMz/YEez7DL39g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Agle6SfiImYEIWhmHGBfY7xajx5W49+jmuUQaTFuu5Dnq+EdzDmBzpf64OzL9FFEPjgpE7UeIsMYRiuqR+tb+ZO4rgccYGCzjQkUO7ZcQX7SpgGI8tpR9hsDpYX7NYRvA+MpNUvXev8P+Vyu/Kzg0Q5Ad9ExjdKz1B/i+9ySJ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iFhoTTiD; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 809B14E40BF7;
	Wed,  1 Jul 2026 15:59:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 51E7F60288;
	Wed,  1 Jul 2026 15:59:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AABEA104C967F;
	Wed,  1 Jul 2026 17:59:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782921584; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZK0SBCPOmMsy53Y1bHnVws/BlPpbIuDko15goBEzumc=;
	b=iFhoTTiDGZpWvZSvLJhFYyya3vH8DVp5HkgWiR1R5yzqtlGvnVG840vjStA4tlpW/vXj1g
	aW5Iou0Z+hqkskVee+rq41pkytdmq/NlNfny4TgwC6S2tgHKEvDCacXXlo3r/ViRu9fTbX
	HAANqq0m11unbGh0vmh/7Vjk0odfpmBsrGhmDIFxFGwvzjSdul9tP8Pe7ZVcdr+usgKQeK
	tympAGRmHxtdiR3rytdyLx+93kWDxIhdhZ47rp0nALnWwaLKi5Fy8Udpy7K39eImxoH08c
	7s+kYY/MAw/LBqM1drCH1tNoY9LZPCoMw/WtBlq0/h+wPpTt0Iy6mR/z5Q5RLw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 01 Jul 2026 17:59:15 +0200
Subject: [PATCH net-next v3 12/15] net: macb: introduce
 macb_context_alloc() helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260701-macb-context-v3-12-00268d5b1502@bootlin.com>
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
	TAGGED_FROM(0.00)[bounces-303744-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: B39ED6EF7FA

Move the context allocation sequence from inline macb_open() to its own
helper function called macb_context_alloc(). All ops doing context
swapping (set_ringparam, change_mtu, etc) will use this helper.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 56 +++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 8163df4719b2..7245c345c78f 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2849,6 +2849,36 @@ static int macb_alloc(struct macb_context *ctx)
 	return -ENOMEM;
 }
 
+static struct macb_context *macb_context_alloc(struct macb *bp,
+					       unsigned int mtu,
+					       unsigned int rx_ring_size,
+					       unsigned int tx_ring_size)
+{
+	struct macb_context *ctx;
+	int err;
+
+	ctx = kzalloc_obj(*ctx);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	ctx->info = &bp->info;
+	ctx->rx_buffer_size = macb_rx_buffer_size(bp, mtu);
+	ctx->rx_ring_size = rx_ring_size;
+	ctx->tx_ring_size = tx_ring_size;
+
+	err = macb_alloc(ctx);
+	if (err) {
+		netdev_err(bp->netdev,
+			   "Unable to allocate DMA memory (error %d)\n", err);
+		kfree(ctx);
+		return ERR_PTR(err);
+	}
+
+	bp->macbgem_ops.mog_init_rings(ctx);
+
+	return ctx;
+}
+
 static void gem_init_rx_ring(struct macb_context *ctx, unsigned int q)
 {
 	struct macb_rxq *rxq = &ctx->rxq[q];
@@ -3216,27 +3246,15 @@ static int macb_open(struct net_device *netdev)
 	if (err < 0)
 		return err;
 
-	bp->ctx = kzalloc_obj(*bp->ctx);
-	if (!bp->ctx) {
-		err = -ENOMEM;
+	bp->ctx = macb_context_alloc(bp, netdev->mtu,
+				     bp->configured_rx_ring_size,
+				     bp->configured_tx_ring_size);
+	if (IS_ERR(bp->ctx)) {
+		err = PTR_ERR(bp->ctx);
+		bp->ctx = NULL;
 		goto pm_exit;
 	}
 
-	bp->ctx->info = &bp->info;
-
-	/* RX buffers initialization */
-	bp->ctx->rx_buffer_size = macb_rx_buffer_size(bp, netdev->mtu);
-	bp->ctx->rx_ring_size = bp->configured_rx_ring_size;
-	bp->ctx->tx_ring_size = bp->configured_tx_ring_size;
-
-	err = macb_alloc(bp->ctx);
-	if (err) {
-		netdev_err(netdev, "Unable to allocate DMA memory (error %d)\n",
-			   err);
-		goto free_ctx;
-	}
-
-	bp->macbgem_ops.mog_init_rings(bp->ctx);
 	macb_init_buffers(bp);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
@@ -3275,7 +3293,6 @@ static int macb_open(struct net_device *netdev)
 		napi_disable(&queue->napi_tx);
 	}
 	macb_free(bp->ctx);
-free_ctx:
 	kfree(bp->ctx);
 	bp->ctx = NULL;
 pm_exit:
@@ -5158,6 +5175,7 @@ static int at91ether_open(struct net_device *netdev)
 		ret = -ENOMEM;
 		goto pm_exit;
 	}
+	bp->ctx->info = &bp->info;
 
 	/* Clear internal statistics */
 	ctl = macb_readl(bp, NCR);

-- 
2.55.0


