Return-Path: <netdev+bounces-274186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIY7F2VLzWl6bgYAu9opvQ
	(envelope-from <netdev+bounces-274186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 18:44:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EE54037E153
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 18:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 10DC9309C5EA
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 16:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B9D477E58;
	Wed,  1 Apr 2026 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T2eMdf8U"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9849047AF67
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775061581; cv=none; b=cfmswIxGxekI+K0QjwzbFyqeDt5bPgz0sTaND51Cm5OnecLb6eJvIb1FuaGx4iNA77Wlj10k273YMyYEZcMlCGRkbEDWW3ZHY8uycuQqWqNZkaQul5idTfrfYgLMTpgm+tyrTwUT3RwIKZZkg/jwfTUeT/fNp4RkOGS2MAXqrHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775061581; c=relaxed/simple;
	bh=YP6CtUF9AL4yooz8CZtnf8bQL1uJ5a4WtdyvnKsuHT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f4NleSBhkOXI8PbkzNku1PKh3bn3npBM5uRFYXhUo5GHwgNABcKyoOzNkuk9UxatLOoDhAvqQQVscWYRMjiTFgnPHoxTXrDFHfyx7pFOs58RKi7Qp7cDRGEIXaU9DFo2xRYaqK2cV0UbH+si+XExtCBkZTuNRMKpEVt5Sz76Eac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T2eMdf8U; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D87E94E42898;
	Wed,  1 Apr 2026 16:39:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AEF10602BF;
	Wed,  1 Apr 2026 16:39:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4D661104507D9;
	Wed,  1 Apr 2026 18:39:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775061574; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0+PuJJPyolIoWacMBFDdkg6OvWsMTEUZdEigZZJOtyI=;
	b=T2eMdf8UA6kMo1dMR2i8CJydBOl46HuFTA9a7unpQeGbpkL5kswazb0c4ZBE1fBIEAJKjW
	DY9sMrCnEETVtc4YwVLc8JpNa26Ti/l3Um+Aod4nkzF4/Z5DgaHsNZVcJs3YwWKdbRhcPj
	CeigXU7P7cAqXqFEfPRsRFjm7HNdc2bH61WLIGkJEHPbZkjPIwfyPRPU2iDJ9h/17cNV1o
	sMhawq20xvHW37GJISpP1l2ffZRPx7VC5hItQHTO+Z+jwtnjogphTFxdtj+9WYA4MOTQ5e
	fOiLim58Pq6f9unBagr76K+198DGpVuNcfE/GDLK8ClStRGJtMOifVZCc1xQKg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 01 Apr 2026 18:39:08 +0200
Subject: [PATCH net-next 05/11] net: macb: allocate tieoff descriptor once
 across device lifetime
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260401-macb-context-v1-5-9590c5ab7272@bootlin.com>
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
	TAGGED_FROM(0.00)[bounces-274186-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: EE54037E153
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
 drivers/net/ethernet/cadence/macb_main.c | 70 ++++++++++++++++----------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 081f220f6756..d5023fdc0756 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2679,12 +2679,6 @@ static void macb_free_consistent(struct macb *bp)
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
@@ -2782,16 +2776,6 @@ static int macb_alloc_consistent(struct macb *bp)
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
@@ -2799,19 +2783,6 @@ static int macb_alloc_consistent(struct macb *bp)
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
@@ -2839,8 +2810,6 @@ static void gem_init_rings(struct macb *bp)
 
 		gem_init_rx_ring(queue);
 	}
-
-	macb_init_tieoff(bp);
 }
 
 static void macb_init_rings(struct macb *bp)
@@ -2858,8 +2827,6 @@ static void macb_init_rings(struct macb *bp)
 	bp->queues[0].tx_head = 0;
 	bp->queues[0].tx_tail = 0;
 	desc->ctrl |= MACB_BIT(TX_WRAP);
-
-	macb_init_tieoff(bp);
 }
 
 static void macb_reset_hw(struct macb *bp)
@@ -5530,6 +5497,33 @@ static int eyeq5_init(struct platform_device *pdev)
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
 static const struct macb_usrio_config at91_default_usrio = {
 	.mii = MACB_BIT(MII),
 	.rmii = MACB_BIT(RMII),
@@ -5946,10 +5940,14 @@ static int macb_probe(struct platform_device *pdev)
 
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
@@ -5963,6 +5961,9 @@ static int macb_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_out_free_tieoff:
+	macb_free_tieoff(bp);
+
 err_out_unregister_mdio:
 	mdiobus_unregister(bp->mii_bus);
 	mdiobus_free(bp->mii_bus);
@@ -5992,6 +5993,7 @@ static void macb_remove(struct platform_device *pdev)
 	if (netdev) {
 		bp = netdev_priv(netdev);
 		unregister_netdev(netdev);
+		macb_free_tieoff(bp);
 		phy_exit(bp->phy);
 		mdiobus_unregister(bp->mii_bus);
 		mdiobus_free(bp->mii_bus);

-- 
2.53.0


