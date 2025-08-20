Return-Path: <netdev+bounces-215306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 203DAB2E016
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 16:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056F0621109
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 14:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81EF322552;
	Wed, 20 Aug 2025 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gavRSegl"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C396F321F50
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755701755; cv=none; b=Gc6Qudms5rkgOMFbKfA0Rrtw+nCHWA9IHpp1hBsdRtG/EWXw4afYAeOksTP+/MIT76hQhBeJpQp/hnNWqf37L+bmOO9QotV5/FviU6o4Bgi1YCTRjX6F+d+ZAYc044Ot/oXweMlMR8dEf0ECcXkHMob+wgKfT7kNk9dfqFT+/e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755701755; c=relaxed/simple;
	bh=nFdYNmYaVP7xY8B5M9EfwLVyf/HpuiOfR234JcCTn/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PWkWUolJh4wlvgMWKVU0GoATU8BUC4Ir9HEJqJVZxZZGnXgnoUdAuRDqKvQZjxvNNenwelHdLHJpJ0IFm6hMS30DEE9QO3PqTVTOjQ3fd+Q65KMX1g/QEllLqUiAdldhDPAfN+uRIT8qEAuFKwJ6T/3D6Da88t0NBz9qJvR3+cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gavRSegl; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8AADDC6B3AF;
	Wed, 20 Aug 2025 14:55:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 35F2F606A0;
	Wed, 20 Aug 2025 14:55:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 927BB1C22C54F;
	Wed, 20 Aug 2025 16:55:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755701751; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=k8o7htJcB+PWfJpR0G3Ao2g5DXgHwDZ9wOdSNlZxp+A=;
	b=gavRSegln3rIrSUfgArRvy8QCVjiqGfa7CuRo+L79gSBPCVZSN7XhhNs0zn4/XP9EBnaLp
	B3/5n/Wy/Q4bdiwwPv6sHxPUiCjhKgFkHwd7lUr8svCL+y8JOTRYGd22IhK57Dq245lwrg
	B2iU+AaPP1pbucCDG7X3xq3E5p6ogM2L6qzA0hAEbp+ydWQLoBeB05NP5SFddBw+eEn+P1
	+S9QCLINzCsTKfhY7LucEMY1uqDm8YEolvQ8HA9QHI3eSbBAHoDMF8JDM+Rot1cddxbxhp
	63CmbfN0qgnFlEid5W6vxWdCjUomBi1Z6rDPFjZjNbk85FX1dsnyRW0TDVb5vg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 20 Aug 2025 16:55:06 +0200
Subject: [PATCH net v4 2/5] net: macb: remove illusion about TBQPH/RBQPH
 being per-queue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250820-macb-fixes-v4-2-23c399429164@bootlin.com>
References: <20250820-macb-fixes-v4-0-23c399429164@bootlin.com>
In-Reply-To: <20250820-macb-fixes-v4-0-23c399429164@bootlin.com>
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
index ce95fad8cedd7331d4818ba9f73fb6970249e85c..69325665c766927797ca2e1eb1384105bcde3cb5 100644
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
@@ -2542,6 +2538,7 @@ static int macb_alloc_consistent(struct macb *bp)
 {
 	struct macb_queue *queue;
 	unsigned int q;
+	u32 upper;
 	int size;
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
@@ -2549,7 +2546,9 @@ static int macb_alloc_consistent(struct macb *bp)
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
@@ -2563,8 +2562,11 @@ static int macb_alloc_consistent(struct macb *bp)
 
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
@@ -4305,12 +4307,6 @@ static int macb_init(struct platform_device *pdev)
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
@@ -4319,12 +4315,6 @@ static int macb_init(struct platform_device *pdev)
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
@@ -5450,6 +5440,11 @@ static int __maybe_unused macb_suspend(struct device *dev)
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
@@ -5459,10 +5454,6 @@ static int __maybe_unused macb_suspend(struct device *dev)
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
2.50.1


