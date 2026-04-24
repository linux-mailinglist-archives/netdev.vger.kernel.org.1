Return-Path: <netdev+bounces-280973-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFBtIGJA62nZKAAAu9opvQ
	(envelope-from <netdev+bounces-280973-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 12:05:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D11FE45CB92
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 12:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55EF23060AD0
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 10:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539EE3624CC;
	Fri, 24 Apr 2026 10:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hNIS1fBb"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67116362133;
	Fri, 24 Apr 2026 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777024881; cv=none; b=dgH72pNz7uCe7uwIvDGvX4ldrbqxRbl+1mQs7pEedS4Bm+3PFTVpTUnHkwAV6ivkMTjCnTR6FLxsoprDs/KbraDvahALRUh72Y0qgsyClcSL58quh7xuuj2yUkAxrRtp4Jq9lj2mFQ7epftmYy7KQa5TTtpXBBkvnE4GzG4e/d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777024881; c=relaxed/simple;
	bh=Yy2WannBX4lvU7zWsEb5b+r7/XwUG2n+24zBsfypLiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kPsCMX7SmvTNQDpPUwi9XJoXitsVoRxMQXU8ypSoESIDPc76NgUKib1urmDQXIAooupSH99fujmGdpKmAgpGovr53a8fYC7Vv3FIzytHLKWjiB3T4CoftmQm3rhxKrH1HDaW/qsRMdbAKQgQuXjzuWlTKm/MPPRsxQYFZSwCPjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hNIS1fBb; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 428B9C5EF25;
	Fri, 24 Apr 2026 10:01:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7E950604EB;
	Fri, 24 Apr 2026 10:01:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 70DD31072077B;
	Fri, 24 Apr 2026 12:01:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777024874; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=Zj0vqNHZ44r/6iCMJXkPmXsULWpgIxSih4Gcje05/Qo=;
	b=hNIS1fBbL2jmpGnQpvm8pSLTr6wUeBb7FYn8g/hM9ONaWwZgtLnl8tgi6qQeCYtGrpY6D2
	d3vUaAkJhOEo2xrNWcU0FbCgqCkTpg+hkLqjUiqEQAITtdKNhJqIouY6tvkrsk/Vm7Vu9A
	xM73KELBCLRWzOVD3XNrqumcmmLxBRU44MdnVbsEvUm+cB0O18j9AYqoaraVlV2Pd0Zq9X
	iLindmxk1IbAUiSWKTSYL5AuBmFLWiOhCIPjlwVyLVS1JVIsfr29Sed+uwnOL3smieQD2w
	kgvOgF6TNN5jsPwblGZYa52vwkoj+QTNcGhQGKgV9jmruhpZdsCBaUSz/OKaCQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 24 Apr 2026 12:01:01 +0200
Subject: [PATCH net] net: macb: drop in-flight Tx SKBs on close
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260424-macb-drop-tx-v1-1-b3ecb787d84d@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMzQqDMBAGX0W+swtx+yP6KtKDJmu7hUZJ0iKI7
 96oxxmYWRElqES0xYogP406+QxVWcC+ev8UUpcZbPhurnyhT28HcmGaKS00NlZqrtk4c0NO5iC
 jLseug5eExynjd3iLTfsI2/YH5Ttx6XUAAAA=
X-Change-ID: 20260423-macb-drop-tx-f9ce72720d05
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Haavard Skinnemoen <hskinnemoen@atmel.com>, Jeff Garzik <jeff@garzik.org>
Cc: Paolo Valerio <pvalerio@redhat.com>, Conor Dooley <conor@kernel.org>, 
 Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: D11FE45CB92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280973-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The MACB driver has since forever leaked the outgoing SKBs that have not
yet been marked as completed. They live in queue->tx_skb which gets
freed without remorse nor checking.

macb_free_consistent() gets called in a few codepaths, but only
close will trigger the added expressions. In macb_open() and
macb_alloc_consistent() failure cases, tx_skb just got allocated
and is empty.

Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index a12aa21244e8..3ffd60b852f8 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2649,6 +2649,7 @@ static unsigned int macb_rx_ring_size_per_queue(struct macb *bp)
 static void macb_free_consistent(struct macb *bp)
 {
 	struct device *dev = &bp->pdev->dev;
+	unsigned int dropped, tail;
 	struct macb_queue *queue;
 	unsigned int q;
 	size_t size;
@@ -2668,6 +2669,14 @@ static void macb_free_consistent(struct macb *bp)
 	dma_free_coherent(dev, size, bp->queues[0].rx_ring, bp->queues[0].rx_ring_dma);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+		dropped = CIRC_CNT(queue->tx_head, queue->tx_tail,
+				   bp->tx_ring_size);
+		queue->stats.tx_dropped += dropped;
+		bp->dev->stats.tx_dropped += dropped;
+
+		for (tail = queue->tx_tail; tail != queue->tx_head; tail++)
+			macb_tx_unmap(bp, macb_tx_skb(queue, tail), 0);
+
 		kfree(queue->tx_skb);
 		queue->tx_skb = NULL;
 		queue->tx_ring = NULL;

---
base-commit: 41517b5a932a35c6f59a997ab3b7fa7746c273bd
change-id: 20260423-macb-drop-tx-f9ce72720d05

Best regards,
--  
Théo Lebrun <theo.lebrun@bootlin.com>


