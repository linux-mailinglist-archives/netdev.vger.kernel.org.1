Return-Path: <netdev+bounces-267516-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PWRIloqtGkQiQAAu9opvQ
	(envelope-from <netdev+bounces-267516-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:16:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E298285BF2
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D54F306A53C
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2920D3A4536;
	Fri, 13 Mar 2026 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QnrnYBbT"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5058239659B
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773414961; cv=none; b=AHlxx0aC4WfGuutWy44p9bdXS9Noug6sFYEDTLseJ4iyzGI9521HvbjNemaOx7Qam8Gv1xdijlletwip777NKTfEhq4+m2jHSx6CqivamHSzqjHbOGPUaX8XN2aNIu0WwrqFzCcyaf0Cy6DrlrLZJ9JRVU4ilRXCdIqzegEoOUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773414961; c=relaxed/simple;
	bh=Ng7XlfAeDOAMvcaVXtqNNzzvkne2lmdAwzTtJpBBUzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BWL5v9Hd8yEqn05Ip7n3wvludaDcVr/SZsFs84oYg8ASl6xDJGgyiatsqcuyDrXzPGa3Hk31Sbo3ZGT5Pqt+TL904FOiWJMzsFeLHHbOQasm2Z5xWC0OR1ONtuiAN0UO5f3ls6NLwwC1n29s6rxl482WHgBh/xtQdgSHF78VawU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QnrnYBbT; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E028D1A2E18;
	Fri, 13 Mar 2026 15:15:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B5D2660027;
	Fri, 13 Mar 2026 15:15:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4F06A10369F35;
	Fri, 13 Mar 2026 16:15:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773414956; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nrlCHCvVqMO3vaJQNZaTZnfQ1l/PaJiputp+qZzl5z0=;
	b=QnrnYBbTXOOq8lhsPlqwVYVb9blNjLPeni3LUztA7lHA9JilWeqwIE61sGJGK0Nz7H5FH+
	dKAJ6gfLNyw6+CGiO9qo1DJLTX77HS33QjMa4GCYQEzDp3y6jzu44wCFzDhZz6GC6UDYPr
	WEpeza6NgXaOEKola5UAtcOg0TPIiASbjdbH/fXuv0QEYQrumOZjKcE/tuSV0oIPiEs6uy
	OJhlLFLEzAdGK62hQlkSKs1nZrbvvn/W1zgBJlRN6o/cfIFrsE1npPS680Tzi2yoZk5kGs
	ZxddpNSVLrebp8kby0wiK8YNPv3t97NCStrvvhEUAdkqV72L7fVFut95KmgECw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 13 Mar 2026 16:15:52 +0100
Subject: [PATCH net-next v3 1/2] net: macb: implement
 ethtool_ops.get|set_channels()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260313-macb-set-channels-v3-1-c66b7781ddb8@bootlin.com>
References: <20260313-macb-set-channels-v3-0-c66b7781ddb8@bootlin.com>
In-Reply-To: <20260313-macb-set-channels-v3-0-c66b7781ddb8@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267516-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E298285BF2
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
 drivers/net/ethernet/cadence/macb_main.c | 103 ++++++++++++++++++++++++++-----
 2 files changed, 88 insertions(+), 16 deletions(-)

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
index 5e27e0e87a55..562d16beffb4 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -468,9 +468,26 @@ static void macb_init_buffers(struct macb *bp)
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
 
@@ -4114,8 +4131,8 @@ static int gem_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
 
 	switch (cmd->cmd) {
 	case ETHTOOL_SRXCLSRLINS:
-		if ((cmd->fs.location >= bp->max_tuples)
-				|| (cmd->fs.ring_cookie >= bp->num_queues)) {
+		if (cmd->fs.location >= bp->max_tuples ||
+		    cmd->fs.ring_cookie >= bp->max_num_queues) {
 			ret = -EINVAL;
 			break;
 		}
@@ -4133,6 +4150,54 @@ static int gem_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
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
+	if (count == old_count)
+		return 0;
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
@@ -4148,6 +4213,8 @@ static const struct ethtool_ops macb_ethtool_ops = {
 	.set_link_ksettings     = macb_set_link_ksettings,
 	.get_ringparam		= macb_get_ringparam,
 	.set_ringparam		= macb_set_ringparam,
+	.get_channels		= macb_get_channels,
+	.set_channels		= macb_set_channels,
 };
 
 static int macb_get_eee(struct net_device *dev, struct ethtool_keee *eee)
@@ -4182,12 +4249,14 @@ static const struct ethtool_ops gem_ethtool_ops = {
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
@@ -4328,9 +4397,9 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
 	size_t i;
 	int err;
 
-	if (conf->num_entries > bp->num_queues) {
+	if (conf->num_entries > bp->max_num_queues) {
 		netdev_err(ndev, "Too many TAPRIO entries: %zu > %d queues\n",
-			   conf->num_entries, bp->num_queues);
+			   conf->num_entries, bp->max_num_queues);
 		return -EINVAL;
 	}
 
@@ -4378,9 +4447,9 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
 
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
@@ -4440,7 +4509,7 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
 	/* All validations passed - proceed with hardware configuration */
 	scoped_guard(spinlock_irqsave, &bp->lock) {
 		/* Disable ENST queues if running before configuring */
-		queue_mask = BIT_U32(bp->num_queues) - 1;
+		queue_mask = BIT_U32(bp->max_num_queues) - 1;
 		gem_writel(bp, ENST_CONTROL,
 			   queue_mask << GEM_ENST_DISABLE_QUEUE_OFFSET);
 
@@ -4475,7 +4544,7 @@ static void macb_taprio_destroy(struct net_device *ndev)
 	unsigned int q;
 
 	netdev_reset_tc(ndev);
-	queue_mask = BIT_U32(bp->num_queues) - 1;
+	queue_mask = BIT_U32(bp->max_num_queues) - 1;
 
 	scoped_guard(spinlock_irqsave, &bp->lock) {
 		/* Single disable command for all queues */
@@ -4483,7 +4552,8 @@ static void macb_taprio_destroy(struct net_device *ndev)
 			   queue_mask << GEM_ENST_DISABLE_QUEUE_OFFSET);
 
 		/* Clear all queue ENST registers in batch */
-		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+		for (q = 0, queue = bp->queues; q < bp->max_num_queues;
+		     ++q, ++queue) {
 			queue_writel(queue, ENST_START_TIME, 0);
 			queue_writel(queue, ENST_ON_TIME, 0);
 			queue_writel(queue, ENST_OFF_TIME, 0);
@@ -5719,6 +5789,7 @@ static int macb_probe(struct platform_device *pdev)
 		bp->macb_reg_writel = hw_writel;
 	}
 	bp->num_queues = num_queues;
+	bp->max_num_queues = num_queues;
 	bp->dma_burst_length = macb_config->dma_burst_length;
 	bp->pclk = pclk;
 	bp->hclk = hclk;

-- 
2.53.0


