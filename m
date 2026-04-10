Return-Path: <netdev+bounces-277535-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIAzLbJV2WlGoggAu9opvQ
	(envelope-from <netdev+bounces-277535-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:55:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A05B3DC291
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BCE13076AF3
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 19:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEC338643E;
	Fri, 10 Apr 2026 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X4MMGk/B"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9943859D4;
	Fri, 10 Apr 2026 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850741; cv=none; b=GDQBGC4yUoTbDlib437A70ByHkROxpprgHVJsbiP8AyIBmmgERpqWNTPxpmAeYljZpT7hIxQoSoXL6xZ4T8fWekkVSPaHIV/5mdsM6810yDd5YvvWZqkf4U30+3sJpQ2m+BmED4hS1HlnvQlIyyPSES2IEL2TytqpnDm6uF4KBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850741; c=relaxed/simple;
	bh=nArcLjBvm+EtWq6UlgfsPNnoA4LMEsIUQuWl7d2UcPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IK8tFYePo749aioECuEs0qQn1VQlvpA5AhgnqmRWWoLLUWbFKBvvvKeENbYJNKewDp75monHTuatOpHsJQLl24sD8LYvNZajqFiBTy8/EiCUhdUhvWyhaTv802V3DnAappdbpXqDXKUxaxS/LfzFA7Lpe0RVlmRMvEdutmgCEo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=X4MMGk/B; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B8BFAC5C1A6;
	Fri, 10 Apr 2026 19:52:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 70ECB603F0;
	Fri, 10 Apr 2026 19:52:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1049110450088;
	Fri, 10 Apr 2026 21:52:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775850737; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WCOBchWkfQmjz27k3+PQMok4Uks1c3OB/eBq9DknrAo=;
	b=X4MMGk/B12+P9XpADHCFbaaMb0eJuxFePeosJ4rrlbDx+oNWKAoHBk96im69lmopZZo4t9
	4oQN5pIPUueLb46dx4ZVxyPf6WgZEJv/MfrX8qXC1f1YQghgMHMxojjSYOpji28vH8udAu
	bkgggoIMVFIAuiZuwQwG2s05N7gAsJCumHSlACSosRlvrHfOZ5c2POC+IvZ4053dIilsSm
	Xxo/EPaoG/uqhZ36BH6WA/8CSpPS9VvxxANPRas6Pyu5e0VjFUGpC5h7KdNs7c9QQmQrtj
	gx/Q6yF+3MTJ62z/lbyB41AOXCEqogdoqTVcTIgNANiRFW3B+TJ1atFr8BcZLg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 10 Apr 2026 21:51:53 +0200
Subject: [PATCH net-next v2 05/14] net: macb: allocate tieoff descriptor
 once across device lifetime
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-macb-context-v2-5-af39f71d40b6@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277535-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid]
X-Rspamd-Queue-Id: 2A05B3DC291
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The tieoff descriptor is a RX DMA descriptor ring of size one. It gets
configured onto queues for Wake-on-LAN during system-wide suspend when
hardware does not support disabling individual queues
(MACB_CAPS_QUEUE_DISABLE).

MACB/GEM driver allocates it alongside the main RX ring
inside macb_alloc_consistent() at open. Free is done by
macb_free_consistent() at close.

Change to allocate once at probe and free on probe failure or device
removal. This makes the tieoff descriptor lifetime much longer,
avoiding repeating coherent buffer allocation on each open/close cycle.

Main benefit: we dissociate its lifetime from the main ring's lifetime.
That way there is less work to be doing on resources (re)alloc. This
currently happens on close/open, but will soon also happen on context
swap operations (set_ringparam, change_mtu, set_channels, etc).

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 75 +++++++++++++++++---------------
 1 file changed, 41 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index c5d8e8f835ba..ec030801ed68 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2653,12 +2653,6 @@ static void macb_free_consistent(struct macb *bp)
 	unsigned int q;
 	size_t size;
 
-	if (bp->rx_ring_tieoff) {
-		dma_free_coherent(dev, macb_dma_desc_get_size(bp),
-				  bp->rx_ring_tieoff, bp->rx_ring_tieoff_dma);
-		bp->rx_ring_tieoff = NULL;
-	}
-
 	bp->macbgem_ops.mog_free_rx_buffers(bp);
 
 	size = bp->num_queues * macb_tx_ring_size_per_queue(bp);
@@ -2756,16 +2750,6 @@ static int macb_alloc_consistent(struct macb *bp)
 	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
 		goto out_err;
 
-	/* Required for tie off descriptor for PM cases */
-	if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE)) {
-		bp->rx_ring_tieoff = dma_alloc_coherent(&bp->pdev->dev,
-							macb_dma_desc_get_size(bp),
-							&bp->rx_ring_tieoff_dma,
-							GFP_KERNEL);
-		if (!bp->rx_ring_tieoff)
-			goto out_err;
-	}
-
 	return 0;
 
 out_err:
@@ -2773,19 +2757,6 @@ static int macb_alloc_consistent(struct macb *bp)
 	return -ENOMEM;
 }
 
-static void macb_init_tieoff(struct macb *bp)
-{
-	struct macb_dma_desc *desc = bp->rx_ring_tieoff;
-
-	if (bp->caps & MACB_CAPS_QUEUE_DISABLE)
-		return;
-	/* Setup a wrapping descriptor with no free slots
-	 * (WRAP and USED) to tie off/disable unused RX queues.
-	 */
-	macb_set_addr(bp, desc, MACB_BIT(RX_WRAP) | MACB_BIT(RX_USED));
-	desc->ctrl = 0;
-}
-
 static void gem_init_rx_ring(struct macb_queue *queue)
 {
 	queue->rx_tail = 0;
@@ -2813,8 +2784,6 @@ static void gem_init_rings(struct macb *bp)
 
 		gem_init_rx_ring(queue);
 	}
-
-	macb_init_tieoff(bp);
 }
 
 static void macb_init_rings(struct macb *bp)
@@ -2832,8 +2801,6 @@ static void macb_init_rings(struct macb *bp)
 	bp->queues[0].tx_head = 0;
 	bp->queues[0].tx_tail = 0;
 	desc->ctrl |= MACB_BIT(TX_WRAP);
-
-	macb_init_tieoff(bp);
 }
 
 static void macb_reset_hw(struct macb *bp)
@@ -5510,6 +5477,38 @@ static int eyeq5_init(struct platform_device *pdev)
 	return ret;
 }
 
+static int macb_alloc_tieoff(struct macb *bp)
+{
+	/* Tieoff is a workaround in case HW cannot disable queues, for PM. */
+	if (bp->caps & MACB_CAPS_QUEUE_DISABLE)
+		return 0;
+
+	bp->rx_ring_tieoff = dma_alloc_coherent(&bp->pdev->dev,
+						macb_dma_desc_get_size(bp),
+						&bp->rx_ring_tieoff_dma,
+						GFP_KERNEL);
+	if (!bp->rx_ring_tieoff)
+		return -ENOMEM;
+
+	macb_set_addr(bp, bp->rx_ring_tieoff,
+		      MACB_BIT(RX_WRAP) | MACB_BIT(RX_USED));
+
+	bp->rx_ring_tieoff->ctrl = 0;
+
+	return 0;
+}
+
+static void macb_free_tieoff(struct macb *bp)
+{
+	if (!bp->rx_ring_tieoff)
+		return;
+
+	dma_free_coherent(&bp->pdev->dev, macb_dma_desc_get_size(bp),
+			  bp->rx_ring_tieoff,
+			  bp->rx_ring_tieoff_dma);
+	bp->rx_ring_tieoff = NULL;
+}
+
 static const struct macb_usrio_config mpfs_usrio = {
 	.tsu_source = 0,
 };
@@ -5919,10 +5918,14 @@ static int macb_probe(struct platform_device *pdev)
 
 	netif_carrier_off(netdev);
 
+	err = macb_alloc_tieoff(bp);
+	if (err)
+		goto err_out_unregister_mdio;
+
 	err = register_netdev(netdev);
 	if (err) {
 		dev_err(&pdev->dev, "Cannot register net device, aborting.\n");
-		goto err_out_unregister_mdio;
+		goto err_out_free_tieoff;
 	}
 
 	INIT_WORK(&bp->hresp_err_bh_work, macb_hresp_error_task);
@@ -5936,6 +5939,9 @@ static int macb_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_out_free_tieoff:
+	macb_free_tieoff(bp);
+
 err_out_unregister_mdio:
 	mdiobus_unregister(bp->mii_bus);
 	mdiobus_free(bp->mii_bus);
@@ -5965,6 +5971,7 @@ static void macb_remove(struct platform_device *pdev)
 	if (netdev) {
 		bp = netdev_priv(netdev);
 		unregister_netdev(netdev);
+		macb_free_tieoff(bp);
 		phy_exit(bp->phy);
 		mdiobus_unregister(bp->mii_bus);
 		mdiobus_free(bp->mii_bus);

-- 
2.53.0


