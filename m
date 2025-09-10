Return-Path: <netdev+bounces-221770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B7EB51D4D
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 18:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E92F48600B
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 16:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2183277A9;
	Wed, 10 Sep 2025 16:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ni7JKBdx"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EA326D4CA
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 16:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520999; cv=none; b=TeJKtr33QMRSMYgqivW2lfdL2/5u7YvZtte+x4U0lZnd5kzMcJltMTFvVovdn2OK02wlpbrrMWGtrGAr633xR5Mqsrj3Ji59z1HW1v0LG6nY4qGUT1WXPcl1+F6jqRsepDzJtZYI3T/IxEDy0ZlrLuCb7UtHUS/idotWDJ26Zoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520999; c=relaxed/simple;
	bh=Hw3S4Yh1b9uVhqXs5nOnRXPDZIBl16sL7jFuN1px3s8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ALUwXg3Gkgzze8Cufb14Mcpoh0m5ww5OjDz12MXDciOtZ5PIYyCMSNyh4ekWCj1Pe726kT0G3ujw9u92e1JClDRwsRwoALr3i2mXOehVRZT6HVl2uPg7HXnCN/8e0o664BVFDWw5caBhV8QsOniXwurtCJ+kX2B+kHEemP2jqzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ni7JKBdx; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8F7F41A0D55;
	Wed, 10 Sep 2025 16:16:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7F3C6606D4;
	Wed, 10 Sep 2025 16:16:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7A0C7102F2870;
	Wed, 10 Sep 2025 18:16:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757520992; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=XWwRlk2s1La7LFWvZ8yGGl3dun8e0qyYKsEMxtd/N1E=;
	b=ni7JKBdxxxk0nw3HOcz4yns3Ts9nX8kD95XiteM8uxLEhvyqxJwFUvlZC8WCvzQoaWHYBQ
	cU+MA3Tde0nfLvAUr98QUUzwfF0RaerDOiCdjbGoTJC1vE1aKdByiS9QgLaG4Y0uL0yzJ5
	nSIDz0q0T8r6UXHU5k7E1ph5hyJ5pDY2zqQgYfuzx2IE1GnU1KmFrDZgPBTzhGe5BSSJO8
	b0mTEdSydPWFTChWUr5g5yUKkL7qGuTKNAOEMlk+tgoR7D/E/Phn1G/lk6yaQtCccGEJFu
	D8J+NaDL2zrF9ba49OrvQGBJlSWY6CuHUX0IZ5g7PEKE9CsUc8IL83ZKui5Rew==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 10 Sep 2025 18:15:31 +0200
Subject: [PATCH net v5 2/5] net: macb: remove illusion about TBQPH/RBQPH
 being per-queue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250910-macb-fixes-v5-2-f413a3601ce4@bootlin.com>
References: <20250910-macb-fixes-v5-0-f413a3601ce4@bootlin.com>
In-Reply-To: <20250910-macb-fixes-v5-0-f413a3601ce4@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Harini Katakam <harini.katakam@xilinx.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Sean Anderson <sean.anderson@linux.dev>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

The MACB driver acts as if TBQPH/RBQPH are configurable on a per queue
basis; this is a lie. A single register configures the upper 32 bits of
each DMA descriptor buffers for all queues.

Concrete actions:

 - Drop GEM_TBQPH/GEM_RBQPH macros which have a queue index argument.
   Only use MACB_TBQPH/MACB_RBQPH constants.

 - Drop struct macb_queue->TBQPH/RBQPH fields.

 - In macb_init_buffers(): do a single write to TBQPH and RBQPH for all
   queues instead of a write per queue.

 - In macb_tx_error_task(): drop the write to TBQPH.

 - In macb_alloc_consistent(): if allocations give different upper
   32-bits, fail. Previously, it would have lead to silent memory
   corruption as queues would have used the upper 32 bits of the alloc
   from queue 0 and their own low 32 bits.

 - In macb_suspend(): if we use the tie off descriptor for suspend, do
   the write once for all queues instead of once per queue.

Fixes: fff8019a08b6 ("net: macb: Add 64 bit addressing support for GEM")
Fixes: ae1f2a56d273 ("net: macb: Added support for many RX queues")
Reviewed-by: Sean Anderson <sean.anderson@linux.dev>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      |  4 ---
 drivers/net/ethernet/cadence/macb_main.c | 57 ++++++++++++++------------------
 2 files changed, 24 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index c9a5c8beb2fa8166195d1d83f187d2d0c62668a8..a7e845fee4b3a2e3d14abb49abdbaf3e8e6ea02b 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -213,10 +213,8 @@
 
 #define GEM_ISR(hw_q)		(0x0400 + ((hw_q) << 2))
 #define GEM_TBQP(hw_q)		(0x0440 + ((hw_q) << 2))
-#define GEM_TBQPH(hw_q)		(0x04C8)
 #define GEM_RBQP(hw_q)		(0x0480 + ((hw_q) << 2))
 #define GEM_RBQS(hw_q)		(0x04A0 + ((hw_q) << 2))
-#define GEM_RBQPH(hw_q)		(0x04D4)
 #define GEM_IER(hw_q)		(0x0600 + ((hw_q) << 2))
 #define GEM_IDR(hw_q)		(0x0620 + ((hw_q) << 2))
 #define GEM_IMR(hw_q)		(0x0640 + ((hw_q) << 2))
@@ -1214,10 +1212,8 @@ struct macb_queue {
 	unsigned int		IDR;
 	unsigned int		IMR;
 	unsigned int		TBQP;
-	unsigned int		TBQPH;
 	unsigned int		RBQS;
 	unsigned int		RBQP;
-	unsigned int		RBQPH;
 
 	/* Lock to protect tx_head and tx_tail */
 	spinlock_t		tx_ptr_lock;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index c769b7dbd3baf5cafe64008e18dff939623528d4..3e634049dadf14d371eac68448f80b111f228dfd 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -495,19 +495,19 @@ static void macb_init_buffers(struct macb *bp)
 	struct macb_queue *queue;
 	unsigned int q;
 
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+	/* Single register for all queues' high 32 bits. */
+	if (bp->hw_dma_cap & HW_DMA_CAP_64B) {
+		macb_writel(bp, RBQPH,
+			    upper_32_bits(bp->queues[0].rx_ring_dma));
+		macb_writel(bp, TBQPH,
+			    upper_32_bits(bp->queues[0].tx_ring_dma));
+	}
+#endif
+
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 		queue_writel(queue, RBQP, lower_32_bits(queue->rx_ring_dma));
-#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-		if (bp->hw_dma_cap & HW_DMA_CAP_64B)
-			queue_writel(queue, RBQPH,
-				     upper_32_bits(queue->rx_ring_dma));
-#endif
 		queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
-#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-		if (bp->hw_dma_cap & HW_DMA_CAP_64B)
-			queue_writel(queue, TBQPH,
-				     upper_32_bits(queue->tx_ring_dma));
-#endif
 	}
 }
 
@@ -1166,10 +1166,6 @@ static void macb_tx_error_task(struct work_struct *work)
 
 	/* Reinitialize the TX desc queue */
 	queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
-#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-	if (bp->hw_dma_cap & HW_DMA_CAP_64B)
-		queue_writel(queue, TBQPH, upper_32_bits(queue->tx_ring_dma));
-#endif
 	/* Make TX ring reflect state of hardware */
 	queue->tx_head = 0;
 	queue->tx_tail = 0;
@@ -2546,6 +2542,7 @@ static int macb_alloc_consistent(struct macb *bp)
 {
 	struct macb_queue *queue;
 	unsigned int q;
+	u32 upper;
 	int size;
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
@@ -2553,7 +2550,9 @@ static int macb_alloc_consistent(struct macb *bp)
 		queue->tx_ring = dma_alloc_coherent(&bp->pdev->dev, size,
 						    &queue->tx_ring_dma,
 						    GFP_KERNEL);
-		if (!queue->tx_ring)
+		upper = upper_32_bits(queue->tx_ring_dma);
+		if (!queue->tx_ring ||
+		    upper != upper_32_bits(bp->queues[0].tx_ring_dma))
 			goto out_err;
 		netdev_dbg(bp->dev,
 			   "Allocated TX ring for queue %u of %d bytes at %08lx (mapped %p)\n",
@@ -2567,8 +2566,11 @@ static int macb_alloc_consistent(struct macb *bp)
 
 		size = RX_RING_BYTES(bp) + bp->rx_bd_rd_prefetch;
 		queue->rx_ring = dma_alloc_coherent(&bp->pdev->dev, size,
-						 &queue->rx_ring_dma, GFP_KERNEL);
-		if (!queue->rx_ring)
+						    &queue->rx_ring_dma,
+						    GFP_KERNEL);
+		upper = upper_32_bits(queue->rx_ring_dma);
+		if (!queue->rx_ring ||
+		    upper != upper_32_bits(bp->queues[0].rx_ring_dma))
 			goto out_err;
 		netdev_dbg(bp->dev,
 			   "Allocated RX ring of %d bytes at %08lx (mapped %p)\n",
@@ -4309,12 +4311,6 @@ static int macb_init(struct platform_device *pdev)
 			queue->TBQP = GEM_TBQP(hw_q - 1);
 			queue->RBQP = GEM_RBQP(hw_q - 1);
 			queue->RBQS = GEM_RBQS(hw_q - 1);
-#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-			if (bp->hw_dma_cap & HW_DMA_CAP_64B) {
-				queue->TBQPH = GEM_TBQPH(hw_q - 1);
-				queue->RBQPH = GEM_RBQPH(hw_q - 1);
-			}
-#endif
 		} else {
 			/* queue0 uses legacy registers */
 			queue->ISR  = MACB_ISR;
@@ -4323,12 +4319,6 @@ static int macb_init(struct platform_device *pdev)
 			queue->IMR  = MACB_IMR;
 			queue->TBQP = MACB_TBQP;
 			queue->RBQP = MACB_RBQP;
-#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-			if (bp->hw_dma_cap & HW_DMA_CAP_64B) {
-				queue->TBQPH = MACB_TBQPH;
-				queue->RBQPH = MACB_RBQPH;
-			}
-#endif
 		}
 
 		/* get irq: here we use the linux queue index, not the hardware
@@ -5452,6 +5442,11 @@ static int __maybe_unused macb_suspend(struct device *dev)
 		 */
 		tmp = macb_readl(bp, NCR);
 		macb_writel(bp, NCR, tmp & ~(MACB_BIT(TE) | MACB_BIT(RE)));
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+		if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE))
+			macb_writel(bp, RBQPH,
+				    upper_32_bits(bp->rx_ring_tieoff_dma));
+#endif
 		for (q = 0, queue = bp->queues; q < bp->num_queues;
 		     ++q, ++queue) {
 			/* Disable RX queues */
@@ -5461,10 +5456,6 @@ static int __maybe_unused macb_suspend(struct device *dev)
 				/* Tie off RX queues */
 				queue_writel(queue, RBQP,
 					     lower_32_bits(bp->rx_ring_tieoff_dma));
-#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-				queue_writel(queue, RBQPH,
-					     upper_32_bits(bp->rx_ring_tieoff_dma));
-#endif
 			}
 			/* Disable all interrupts */
 			queue_writel(queue, IDR, -1);

-- 
2.51.0


