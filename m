Return-Path: <netdev+bounces-277541-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCa2FYNV2WlgoggAu9opvQ
	(envelope-from <netdev+bounces-277541-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:54:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1886D3DC25B
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4917F302C5DB
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 19:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6552F39B482;
	Fri, 10 Apr 2026 19:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="c1egKd0v"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA376383C9F
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 19:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850758; cv=none; b=PYIg/c7L/21MwkSXRfDVWtvJmny81myljOt3ANN+BITtSmGqrMWdAvPXLX87ACHHUHWJodFd/03YbDo7wkcr9r0r8edJdjvYJNylaToU+Jel+0ShUlHzSMAxCGnZdjCl4P1+eEu/DgqCkgYTB91Eaaj3hPGuupwuBbq8g6Asa00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850758; c=relaxed/simple;
	bh=uuTimKHP0xvMst2PsIZf+716JlvPj89fz4d+Y3lAoEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gDPsl9KIl+SbkzmWPlU41mzKgHIkSxntsFlCdRDjLutpJ1ses9iXR44GRwGY3CC0XNgsI6c5pu2uKMyJUK6hXO45k7nOitTPNr/GqS8u8H+VO9Ei9OG3qjUBQKsttRgZ/ECZNcSS5bmw/Lu9N/j2CQAsAEU152HYNTO1SH56pCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c1egKd0v; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 116B3C5C1A6;
	Fri, 10 Apr 2026 19:53:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BCBE1603F0;
	Fri, 10 Apr 2026 19:52:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 495BA10450087;
	Fri, 10 Apr 2026 21:52:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775850754; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pG9M87ui02WcWQKMcXg4vfwoAG6iNXXP7VjdHseBNO0=;
	b=c1egKd0vbKbyCAwrMCb1n5I0dd4dqTkzKuTNhB0ITcUC+NZRP3TXL93e8NZWFSRsUnbJS0
	UMyYxmnf1n/EUnUjjl+pD3wjAqTMijV2BWiBXeksRSNFSucloByYO0IsfZXVZfIfviacbM
	ypTcxLMJaL938X39nrItxhv/wn8YRy4zJyApdPjsRPZaAA+rEFKYdxOElRRG57m7Hz7ybm
	Y3Afqgz+pTnckiGugqEOFuI2g6e8qgBxmOjihE6wulvvc4p7ERjtC9eN2TjdoUL7d46fq4
	q/iE1FrDF6Fq9IkuUDMfGAjs1x9APs87LHY3CTIyTMY9iTNYelLFLuWRwH776A==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 10 Apr 2026 21:51:59 +0200
Subject: [PATCH net-next v2 11/14] net: macb: introduce
 macb_context_alloc() helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-macb-context-v2-11-af39f71d40b6@bootlin.com>
References: <20260410-macb-context-v2-0-af39f71d40b6@bootlin.com>
In-Reply-To: <20260410-macb-context-v2-0-af39f71d40b6@bootlin.com>
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
X-Mailer: b4 0.15.1
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
	TAGGED_FROM(0.00)[bounces-277541-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1886D3DC25B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move the context allocation sequence from inline macb_open() to its own
helper function called macb_context_alloc(). All ops doing context
swapping (set_ringparam, change_mtu, etc) will use this helper.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 55 +++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 71d60d8d1993..ba7463a857dd 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2848,6 +2848,36 @@ static int macb_alloc_consistent(struct macb_context *ctx)
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
+	err = macb_alloc_consistent(ctx);
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
@@ -3215,27 +3245,15 @@ static int macb_open(struct net_device *netdev)
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
-	err = macb_alloc_consistent(bp->ctx);
-	if (err) {
-		netdev_err(netdev, "Unable to allocate DMA memory (error %d)\n",
-			   err);
-		goto free_ctx;
-	}
-
-	bp->macbgem_ops.mog_init_rings(bp->ctx);
 	macb_init_buffers(bp);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
@@ -3274,7 +3292,6 @@ static int macb_open(struct net_device *netdev)
 		napi_disable(&queue->napi_tx);
 	}
 	macb_free_consistent(bp->ctx);
-free_ctx:
 	kfree(bp->ctx);
 	bp->ctx = NULL;
 pm_exit:

-- 
2.53.0


