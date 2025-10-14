Return-Path: <netdev+bounces-229305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5032FBDA5EF
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 17:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491DC1925C5F
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C35A3054D3;
	Tue, 14 Oct 2025 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FOpV4hhQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AE5304963
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455565; cv=none; b=AznuQKp/NvoDLUyG3qZuy0xC9DuAefrgQ4RGiPcC2zKb6m7Be0NOL8dgmVrY7hoGJN7eFt2ejVyP/WUARdA4EsKhFEaHHgQOf93BhWQu3yRUJDT1Ocn4L39PJCT7hKpfhxCaP7K0nuc/Ezy3CKK1eV0iYbnde27W4DXnNCYP6Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455565; c=relaxed/simple;
	bh=92e/0H7vLbswdPeWDdzTlQk4ifp2T00n8ZPVF4Bqkvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UYjFalmzV7ojuheN+nwBjeRhJzjVDlGKXbJzrqPVt9M6jDTdsbyTpZlEFjbj5OUA+9FSbylSscblF9KrDb2cvg2aTMxYjI5cPokiIh7KzpIHx5ki+hWuoKC7OZbHyYtp8OjYTNs09Dgy3yXn4ht9qggrFCe7y4LrfKHjYhIsSv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FOpV4hhQ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6B104C09F95;
	Tue, 14 Oct 2025 15:25:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 75B75606EC;
	Tue, 14 Oct 2025 15:26:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E3037102F22B1;
	Tue, 14 Oct 2025 17:25:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760455559; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jaSOvhbWIl9I6598VXUOOMnqnEToCtsJCRhNQilmR1k=;
	b=FOpV4hhQL1t1xsz0iIKzX8i6Dm3KaPPEhuFQyOl1BUuRZWZNNCizR7tHgjh6gza8DJZdsM
	Qv7B2fxNVuDzFEyakPETSsd2tPnKyz1snQZRtT5lI6XY4jBhNJUWazosDaNkmg+3Jlq2QT
	voLi0JiZsWbYjXHZ0cOGQAETpFJQZMsaAiBiZv+bwC5DZ8fC1ptRYOlRWFX+Q8lQZbjK1+
	I9MJYhwreVVIajjrnGjLFXm9IHWkr/Cup0A4Khc7GVI+im/jwSXBhq8EFkpy0jlRJpH+tY
	75lj2c/RmTdkt5FMrkjMGUUtWPzo9SID3pptT6Xt2TsDRSsanEFY0E6OC1OE4Q==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 14 Oct 2025 17:25:11 +0200
Subject: [PATCH net-next 10/15] net: macb: remove bp->queue_mask
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-macb-cleanup-v1-10-31cd266e22cd@bootlin.com>
References: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
In-Reply-To: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

The low 16 bits of GEM_DCFG6 tell us which queues are enabled in HW. In
theory, there could be holes in the bitfield. In practice, the macb
driver would fail if there were holes as most loops iterate upon
bp->num_queues. Only macb_init() iterated correctly.

 - Drop bp->queue_mask field.
 - Error out at probe if a hole is in the queue mask.
 - Rely upon bp->num_queues for iteration.
 - As we drop the queue_mask probe local variable, fix RCT.
 - Compute queue_mask on the fly for TAPRIO using bp->num_queues.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      |  1 -
 drivers/net/ethernet/cadence/macb_main.c | 69 +++++++++++++++++---------------
 2 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index f696b2ddc412bffdbdee5dd32c59b338130907f3..5b7d4cdb204d8362bfa81dcc58965edbbf4dd1f8 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1290,7 +1290,6 @@ struct macb {
 	unsigned int		tx_ring_size;
 
 	unsigned int		num_queues;
-	unsigned int		queue_mask;
 	struct macb_queue	queues[MACB_MAX_QUEUES];
 
 	spinlock_t		lock;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 9db419b94d0b47c19cdafb707b1e500124b682c8..98e28d51a6e12c24ef27c939363eb43c0aec1951 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4066,6 +4066,8 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
 	struct macb *bp = netdev_priv(ndev);
 	struct ethtool_link_ksettings kset;
 	struct macb_queue *queue;
+	u32 queue_mask;
+	u8 queue_id;
 	size_t i;
 	int err;
 
@@ -4117,8 +4119,9 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
 			goto cleanup;
 		}
 
-		/* gate_mask must not select queues outside the valid queue_mask */
-		if (entry->gate_mask & ~bp->queue_mask) {
+		/* gate_mask must not select queues outside the valid queues */
+		queue_id = order_base_2(entry->gate_mask);
+		if (queue_id >= bp->num_queues) {
 			netdev_err(ndev, "Entry %zu: gate_mask 0x%x exceeds queue range (max_queues=%d)\n",
 				   i, entry->gate_mask, bp->num_queues);
 			err = -EINVAL;
@@ -4152,7 +4155,7 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
 			goto cleanup;
 		}
 
-		enst_queue[i].queue_id = order_base_2(entry->gate_mask);
+		enst_queue[i].queue_id = queue_id;
 		enst_queue[i].start_time_mask =
 			(start_time_sec << GEM_START_TIME_SEC_OFFSET) |
 			start_time_nsec;
@@ -4180,8 +4183,9 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
 	/* All validations passed - proceed with hardware configuration */
 	scoped_guard(spinlock_irqsave, &bp->lock) {
 		/* Disable ENST queues if running before configuring */
+		queue_mask = BIT_U32(bp->num_queues) - 1;
 		gem_writel(bp, ENST_CONTROL,
-			   bp->queue_mask << GEM_ENST_DISABLE_QUEUE_OFFSET);
+			   queue_mask << GEM_ENST_DISABLE_QUEUE_OFFSET);
 
 		for (i = 0; i < conf->num_entries; i++) {
 			queue = &bp->queues[enst_queue[i].queue_id];
@@ -4210,15 +4214,16 @@ static void macb_taprio_destroy(struct net_device *ndev)
 {
 	struct macb *bp = netdev_priv(ndev);
 	struct macb_queue *queue;
-	u32 enst_disable_mask;
+	u32 queue_mask;
 	unsigned int q;
 
 	netdev_reset_tc(ndev);
-	enst_disable_mask = bp->queue_mask << GEM_ENST_DISABLE_QUEUE_OFFSET;
+	queue_mask = BIT_U32(bp->num_queues) - 1;
 
 	scoped_guard(spinlock_irqsave, &bp->lock) {
 		/* Single disable command for all queues */
-		gem_writel(bp, ENST_CONTROL, enst_disable_mask);
+		gem_writel(bp, ENST_CONTROL,
+			   queue_mask << GEM_ENST_DISABLE_QUEUE_OFFSET);
 
 		/* Clear all queue ENST registers in batch */
 		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
@@ -4341,26 +4346,25 @@ static void macb_configure_caps(struct macb *bp,
 	dev_dbg(&bp->pdev->dev, "Cadence caps 0x%08x\n", bp->caps);
 }
 
-static void macb_probe_queues(void __iomem *mem,
-			      bool native_io,
-			      unsigned int *queue_mask,
-			      unsigned int *num_queues)
+static int macb_probe_queues(struct device *dev, void __iomem *mem, bool native_io)
 {
-	*queue_mask = 0x1;
-	*num_queues = 1;
+	/* BIT(0) is never set but queue 0 always exists. */
+	unsigned int queue_mask = 0x1;
 
-	/* is it macb or gem ?
-	 *
-	 * We need to read directly from the hardware here because
-	 * we are early in the probe process and don't have the
-	 * MACB_CAPS_MACB_IS_GEM flag positioned
-	 */
-	if (!hw_is_gem(mem, native_io))
-		return;
+	/* Use hw_is_gem() as MACB_CAPS_MACB_IS_GEM is not yet positioned. */
+	if (hw_is_gem(mem, native_io)) {
+		if (native_io)
+			queue_mask |= __raw_readl(mem + GEM_DCFG6) & 0xFF;
+		else
+			queue_mask |= readl_relaxed(mem + GEM_DCFG6) & 0xFF;
 
-	/* bit 0 is never set but queue 0 always exists */
-	*queue_mask |= readl_relaxed(mem + GEM_DCFG6) & 0xff;
-	*num_queues = hweight32(*queue_mask);
+		if (fls(queue_mask) != ffz(queue_mask)) {
+			dev_err(dev, "queue mask %#x has a hole\n", queue_mask);
+			return -EINVAL;
+		}
+	}
+
+	return hweight32(queue_mask);
 }
 
 static void macb_clks_disable(struct clk *pclk, struct clk *hclk, struct clk *tx_clk,
@@ -4478,10 +4482,7 @@ static int macb_init(struct platform_device *pdev)
 	 * register mapping but we don't want to test the queue index then
 	 * compute the corresponding register offset at run time.
 	 */
-	for (hw_q = 0, q = 0; hw_q < MACB_MAX_QUEUES; ++hw_q) {
-		if (!(bp->queue_mask & (1 << hw_q)))
-			continue;
-
+	for (hw_q = 0, q = 0; hw_q < bp->num_queues; ++hw_q) {
 		queue = &bp->queues[q];
 		queue->bp = bp;
 		spin_lock_init(&queue->tx_ptr_lock);
@@ -5385,14 +5386,14 @@ static int macb_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct clk *pclk, *hclk = NULL, *tx_clk = NULL, *rx_clk = NULL;
 	struct clk *tsu_clk = NULL;
-	unsigned int queue_mask, num_queues;
-	bool native_io;
 	phy_interface_t interface;
 	struct net_device *dev;
 	struct resource *regs;
 	u32 wtrmrk_rst_val;
 	void __iomem *mem;
 	struct macb *bp;
+	int num_queues;
+	bool native_io;
 	int err, val;
 
 	mem = devm_platform_get_and_ioremap_resource(pdev, 0, &regs);
@@ -5418,7 +5419,12 @@ static int macb_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	native_io = hw_is_native_io(mem);
 
-	macb_probe_queues(mem, native_io, &queue_mask, &num_queues);
+	num_queues = macb_probe_queues(&pdev->dev, mem, native_io);
+	if (num_queues < 0) {
+		err = num_queues;
+		goto err_disable_clocks;
+	}
+
 	dev = alloc_etherdev_mq(sizeof(*bp), num_queues);
 	if (!dev) {
 		err = -ENOMEM;
@@ -5442,7 +5448,6 @@ static int macb_probe(struct platform_device *pdev)
 		bp->macb_reg_writel = hw_writel;
 	}
 	bp->num_queues = num_queues;
-	bp->queue_mask = queue_mask;
 	bp->dma_burst_length = macb_config->dma_burst_length;
 	bp->pclk = pclk;
 	bp->hclk = hclk;

-- 
2.51.0


