Return-Path: <netdev+bounces-268679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAoDOyJ/uWmxHAIAu9opvQ
	(envelope-from <netdev+bounces-268679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 17:19:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D51B92ADCF9
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 17:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22DD1303427B
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A666930E851;
	Tue, 17 Mar 2026 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PsFlOdj6"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3949930E0E4
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764365; cv=none; b=iQmFXgoBKe9q1Ve4ZLxdm8N4QTuIpRtIj+e5YyNemItM1Q3G8gWmmZwXeA9h3l80ec9g4HiJnSOOWA3kbWh0bQ+uAg/5vaSiFRfJ3uZ5e6IXENrGhWSg80PS7PJVl9vD/aJw0kihaDtjdR5+MUXilR/q7mIwDIC+2jsTLg/AsS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764365; c=relaxed/simple;
	bh=qigh43BKzsUOD2/4BjJhk4bZi9wLxWHIk6EvGfzEw64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HtprHc5edzCA6AsGouCBu+nc58AMx8E6TjLaGNnNe0fs3eQ1arsD2xoZDaMNtu13as+3sARUQvuh3E/w8+cYpyEaxHVi5p5Pt5whkwAvw7ccKvFidjL7HPPN6kE0BdyoPL/P5eKYjQ7HB2YRknp36IbceIvcHJ8UUF2UZ5ZL334=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PsFlOdj6; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B77694E426D5;
	Tue, 17 Mar 2026 16:19:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8DD0B5FC9A;
	Tue, 17 Mar 2026 16:19:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 581A610450641;
	Tue, 17 Mar 2026 17:19:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773764360; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3e/0x+YhiV49h77QgHappcAYuSifhjt41F7k45+WPSs=;
	b=PsFlOdj6sccnnhPPUrfRF+xPZWlJ0dKEYOH6Xo8d+Q/MpjG8EpvhoBWdp/km8uDW7HJss9
	QVcirU9OhdIc4QE3vYJfjGuxEkcSkR051FizfwSV3qtYWYGANJKX/VQu/lgimcDIAXFtTx
	evshHMTRBA6l0eFBN1Ugc9rIsd6HuTT2D4RhU6TGKyBAVEuw6269JJH8mEmIo9fiFduDiQ
	flsg6JZL0GoEjTPcjmATSj2DxzsnB86TGn4dExiHBJNAVyfEgBAK32l2YINZLC+xC0Z9ik
	kJVoVyoeu5eFcP2oOYlNOoEEmK8k4KCkDIXg116BzO0IvOk/LVRHjoZNkQuMKA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 17 Mar 2026 17:19:08 +0100
Subject: [PATCH net-next v4 1/2] net: macb: implement
 ethtool_ops.get|set_channels()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-macb-set-channels-v4-1-1bd4f4ffcfca@bootlin.com>
References: <20260317-macb-set-channels-v4-0-1bd4f4ffcfca@bootlin.com>
In-Reply-To: <20260317-macb-set-channels-v4-0-1bd4f4ffcfca@bootlin.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Paolo Valerio <pvalerio@redhat.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.15-dev
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
	TAGGED_FROM(0.00)[bounces-268679-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D51B92ADCF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

bp->num_queues is the total number of queues and is constant from probe.
Introduce bp->max_num_queues which takes the current role of
bp->num_queues and allow `0 < bp->num_queues <= bp->max_num_queues`.
MACB/GEM does not know about rx/tx specific queues; it only has
combined queues.

.set_channels() is reserved to devices with MACB_CAPS_QUEUE_DISABLE.
The tieoff workaround would not work as packets would still be routed
into queues with a tieoff descriptor.

Implement .set_channels() operation by refusing if netif_running().
The reason to implement .set_channels() is memory savings, we cannot
preallocate and swap at runtime.

Nit: fix an alignment issue inside gem_ethtool_ops which does not
deserve its own patch.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      |   1 +
 drivers/net/ethernet/cadence/macb_main.c | 100 ++++++++++++++++++++++++++-----
 2 files changed, 85 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index c69828b27dae..b08afe340996 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1309,6 +1309,7 @@ struct macb {
 	unsigned int		tx_ring_size;
 
 	unsigned int		num_queues;
+	unsigned int		max_num_queues;
 	struct macb_queue	queues[MACB_MAX_QUEUES];
 
 	spinlock_t		lock;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index abd328428c94..dd066f481200 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -469,9 +469,26 @@ static void macb_init_buffers(struct macb *bp)
 			    upper_32_bits(bp->queues[0].tx_ring_dma));
 	}
 
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		queue_writel(queue, RBQP, lower_32_bits(queue->rx_ring_dma));
-		queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
+	for (q = 0, queue = bp->queues; q < bp->max_num_queues; ++q, ++queue) {
+		if (q < bp->num_queues) {
+			queue_writel(queue, RBQP,
+				     lower_32_bits(queue->rx_ring_dma));
+			queue_writel(queue, TBQP,
+				     lower_32_bits(queue->tx_ring_dma));
+		} else {
+			/*
+			 * macb_set_channels(), which is the only way of writing
+			 * to bp->num_queues, is only allowed if
+			 * MACB_CAPS_QUEUE_DISABLE.
+			 */
+			queue_writel(queue, RBQP, MACB_BIT(QUEUE_DISABLE));
+
+			/* Disable all interrupts */
+			queue_writel(queue, IDR, -1);
+			queue_readl(queue, ISR);
+			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
+				queue_writel(queue, ISR, -1);
+		}
 	}
 }
 
@@ -4121,8 +4138,8 @@ static int gem_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
 
 	switch (cmd->cmd) {
 	case ETHTOOL_SRXCLSRLINS:
-		if ((cmd->fs.location >= bp->max_tuples)
-				|| (cmd->fs.ring_cookie >= bp->num_queues)) {
+		if (cmd->fs.location >= bp->max_tuples ||
+		    cmd->fs.ring_cookie >= bp->max_num_queues) {
 			ret = -EINVAL;
 			break;
 		}
@@ -4140,6 +4157,51 @@ static int gem_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
 	return ret;
 }
 
+static void macb_get_channels(struct net_device *netdev,
+			      struct ethtool_channels *ch)
+{
+	struct macb *bp = netdev_priv(netdev);
+
+	ch->max_combined = bp->max_num_queues;
+	ch->combined_count = bp->num_queues;
+}
+
+static int macb_set_channels(struct net_device *netdev,
+			     struct ethtool_channels *ch)
+{
+	struct macb *bp = netdev_priv(netdev);
+	unsigned int old_count = bp->num_queues;
+	unsigned int count = ch->combined_count;
+	int ret;
+
+	/*
+	 * MACB_CAPS_QUEUE_DISABLE means that the field QUEUE_DISABLE/BIT0 in
+	 * the per-queue RBQP register disables queue Rx. If we don't have that
+	 * capability we can have multiple queues but we must always run with
+	 * all enabled.
+	 */
+	if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE))
+		return -EOPNOTSUPP;
+
+	/*
+	 * An ideal .set_channels() implementation uses upfront allocated
+	 * resources and swaps them in, bringing reliability under memory
+	 * pressure. However, here we implement it for memory savings in
+	 * setups with less than max number of queues active.
+	 *
+	 * Signal it by refusing .set_channels() once interface is opened.
+	 */
+	if (netif_running(bp->dev))
+		return -EBUSY;
+
+	ret = netif_set_real_num_queues(bp->dev, count, count);
+	if (ret)
+		return ret;
+
+	bp->num_queues = count;
+	return 0;
+}
+
 static const struct ethtool_ops macb_ethtool_ops = {
 	.get_regs_len		= macb_get_regs_len,
 	.get_regs		= macb_get_regs,
@@ -4155,6 +4217,8 @@ static const struct ethtool_ops macb_ethtool_ops = {
 	.set_link_ksettings     = macb_set_link_ksettings,
 	.get_ringparam		= macb_get_ringparam,
 	.set_ringparam		= macb_set_ringparam,
+	.get_channels		= macb_get_channels,
+	.set_channels		= macb_set_channels,
 };
 
 static int macb_get_eee(struct net_device *dev, struct ethtool_keee *eee)
@@ -4189,12 +4253,14 @@ static const struct ethtool_ops gem_ethtool_ops = {
 	.set_link_ksettings     = macb_set_link_ksettings,
 	.get_ringparam		= macb_get_ringparam,
 	.set_ringparam		= macb_set_ringparam,
-	.get_rxnfc			= gem_get_rxnfc,
-	.set_rxnfc			= gem_set_rxnfc,
-	.get_rx_ring_count		= gem_get_rx_ring_count,
-	.nway_reset			= phy_ethtool_nway_reset,
+	.get_rxnfc		= gem_get_rxnfc,
+	.set_rxnfc		= gem_set_rxnfc,
+	.get_rx_ring_count	= gem_get_rx_ring_count,
+	.nway_reset		= phy_ethtool_nway_reset,
 	.get_eee		= macb_get_eee,
 	.set_eee		= macb_set_eee,
+	.get_channels		= macb_get_channels,
+	.set_channels		= macb_set_channels,
 };
 
 static int macb_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
@@ -4335,9 +4401,9 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
 	size_t i;
 	int err;
 
-	if (conf->num_entries > bp->num_queues) {
+	if (conf->num_entries > bp->max_num_queues) {
 		netdev_err(ndev, "Too many TAPRIO entries: %zu > %d queues\n",
-			   conf->num_entries, bp->num_queues);
+			   conf->num_entries, bp->max_num_queues);
 		return -EINVAL;
 	}
 
@@ -4385,9 +4451,9 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
 
 		/* gate_mask must not select queues outside the valid queues */
 		queue_id = order_base_2(entry->gate_mask);
-		if (queue_id >= bp->num_queues) {
+		if (queue_id >= bp->max_num_queues) {
 			netdev_err(ndev, "Entry %zu: gate_mask 0x%x exceeds queue range (max_queues=%d)\n",
-				   i, entry->gate_mask, bp->num_queues);
+				   i, entry->gate_mask, bp->max_num_queues);
 			err = -EINVAL;
 			goto cleanup;
 		}
@@ -4447,7 +4513,7 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
 	/* All validations passed - proceed with hardware configuration */
 	scoped_guard(spinlock_irqsave, &bp->lock) {
 		/* Disable ENST queues if running before configuring */
-		queue_mask = BIT_U32(bp->num_queues) - 1;
+		queue_mask = BIT_U32(bp->max_num_queues) - 1;
 		gem_writel(bp, ENST_CONTROL,
 			   queue_mask << GEM_ENST_DISABLE_QUEUE_OFFSET);
 
@@ -4482,7 +4548,7 @@ static void macb_taprio_destroy(struct net_device *ndev)
 	unsigned int q;
 
 	netdev_reset_tc(ndev);
-	queue_mask = BIT_U32(bp->num_queues) - 1;
+	queue_mask = BIT_U32(bp->max_num_queues) - 1;
 
 	scoped_guard(spinlock_irqsave, &bp->lock) {
 		/* Single disable command for all queues */
@@ -4490,7 +4556,8 @@ static void macb_taprio_destroy(struct net_device *ndev)
 			   queue_mask << GEM_ENST_DISABLE_QUEUE_OFFSET);
 
 		/* Clear all queue ENST registers in batch */
-		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+		for (q = 0, queue = bp->queues; q < bp->max_num_queues;
+		     ++q, ++queue) {
 			queue_writel(queue, ENST_START_TIME, 0);
 			queue_writel(queue, ENST_ON_TIME, 0);
 			queue_writel(queue, ENST_OFF_TIME, 0);
@@ -5735,6 +5802,7 @@ static int macb_probe(struct platform_device *pdev)
 		bp->macb_reg_writel = hw_writel;
 	}
 	bp->num_queues = num_queues;
+	bp->max_num_queues = num_queues;
 	bp->dma_burst_length = macb_config->dma_burst_length;
 	bp->pclk = pclk;
 	bp->hclk = hclk;

-- 
2.53.0


