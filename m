Return-Path: <netdev+bounces-264492-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ia2LpG7qWnNDQEAu9opvQ
	(envelope-from <netdev+bounces-264492-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 18:21:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FAA216122
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 18:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2048B3013B76
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 17:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FAE3E3DA0;
	Thu,  5 Mar 2026 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kslav3oo"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D208A3E3D85
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772731226; cv=none; b=IN3CEY9JlF4jGXBxriRLic/r3tiI/jeAJubOPcs3/+2F1zTTax8jGlL7mnPaEr/bjcFck1FFAt18jRwvsbvnqGor62fnTkdBFIsBO/SwarfV1rq5EG9kP2UlavzPUZF7Z2XIb3WFRN/Lsi99ULq7XRl4kbt+KEOarr93FHJYCVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772731226; c=relaxed/simple;
	bh=8BSr8Z+djW2ArgZXzFGXq3rMIr8hH0DMZUCahE+APdI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gFbmZWVIstAqjm/xSX4V9KhggcttUqe3U46EKY5St1czDwFFu0u5GzSrm5lATIchgiV96FXyGjMXwLNhd3WM3CVAVuQL31x9n7/pKFGRy7OwYMb692HdIGskcC6pMtSjikcY6uRARWF9wCgTsCvgsWFownW9D2avq65FrZljHJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kslav3oo; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 92A231A2CEF;
	Thu,  5 Mar 2026 17:20:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 66C5A5FF89;
	Thu,  5 Mar 2026 17:20:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 725EA1036990A;
	Thu,  5 Mar 2026 18:20:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772731222; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=riyRiC18Lx2YQbioxa9EAVOQZDST3MG0mMeUtporR+Y=;
	b=kslav3ooqxTLXMtXJO8JO97KDMPyw01QaFm/ad2z3YjnZ5FessVcjs0CUGHM5xMvu6xYPF
	H3FOJ6zDK/Gld+86ygeVeOFrkM0aeeiJ1h6oHLTaBoPwD4Xfa4dxorP5hkPkQVe9qrCNRY
	yLMXTohAoYIBFFunns6UEnYXjvF6Uqg2D+n9BBCj8cDgwtD2CgCOPOrV8awn4fDZ0lXzGY
	m3vejkV5y8inVwH+Q2L8bpwaNC59lNp+iuwWYznCYU1c5pjIheCyAqyUzP9ZM4aL3eQy4H
	7qWpSte9ESLHVr3Pj1RQLQ2hutzIbLaSaUMqLkhFCWO29xYu3SeTNOz/Ir301Q==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Thu, 05 Mar 2026 18:20:14 +0100
Subject: [PATCH net-next 1/2] net: macb: implement
 ethtool_ops.get|set_channels()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260305-macb-set-channels-v1-1-28e3a96a3dc3@bootlin.com>
References: <20260305-macb-set-channels-v1-0-28e3a96a3dc3@bootlin.com>
In-Reply-To: <20260305-macb-set-channels-v1-0-28e3a96a3dc3@bootlin.com>
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
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 58FAA216122
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264492-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid]
X-Rspamd-Action: no action

bp->num_queues is the total number of queues and is constant from probe.
Introduce bp->max_num_queues which takes the current role of
bp->num_queues and allow `0 < bp->num_queues <= bp->max_num_queues`.
MACB/GEM does not know about rx/tx specific queues; it only has
combined queues.

Implement .set_channels() operation by wrapping ourselves in
macb_close() and macb_open() calls if interface is running. This
triggers reinit of buffers, which also includes the code that
enables/disables only the queues below bp->num_queues, in
macb_init_buffers().

If reopen fails, then we do one last attempt and reset num_queues to
the previous value and try reopen. We still error out because the
.set_channels() operation failed.

.set_channels() is reserved to devices with MACB_CAPS_QUEUE_DISABLE.
The tieoff workaround would not work as packets would still be routed
into queues with a tieoff descriptor.

Nit: fix an alignment issue inside gem_ethtool_ops which does not
deserve its own patch.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      |   1 +
 drivers/net/ethernet/cadence/macb_main.c | 100 ++++++++++++++++++++++++++-----
 2 files changed, 85 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 87414a2ddf6e..30fa65e2bdf2 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1294,6 +1294,7 @@ struct macb {
 	unsigned int		tx_ring_size;
 
 	unsigned int		num_queues;
+	unsigned int		max_num_queues;
 	struct macb_queue	queues[MACB_MAX_QUEUES];
 
 	spinlock_t		lock;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 17f0ad3d7a09..bac83a2b4c4d 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -466,9 +466,24 @@ static void macb_init_buffers(struct macb *bp)
 			    upper_32_bits(bp->queues[0].tx_ring_dma));
 	}
 
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		queue_writel(queue, RBQP, lower_32_bits(queue->rx_ring_dma));
-		queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
+	for (q = 0, queue = bp->queues; q < bp->max_num_queues; ++q, ++queue) {
+		if (q < bp->num_queues) {
+			queue_writel(queue, RBQP, lower_32_bits(queue->rx_ring_dma));
+			queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
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
 
@@ -3900,8 +3915,8 @@ static int gem_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
 
 	switch (cmd->cmd) {
 	case ETHTOOL_SRXCLSRLINS:
-		if ((cmd->fs.location >= bp->max_tuples)
-				|| (cmd->fs.ring_cookie >= bp->num_queues)) {
+		if (cmd->fs.location >= bp->max_tuples ||
+		    cmd->fs.ring_cookie >= bp->max_num_queues) {
 			ret = -EINVAL;
 			break;
 		}
@@ -3919,6 +3934,54 @@ static int gem_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
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
+	bool running = netif_running(bp->dev);
+	int ret = 0;
+
+	if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE))
+		return -EOPNOTSUPP;
+
+	if (!count || ch->rx_count || ch->tx_count)
+		return -EINVAL;
+
+	if (count > bp->max_num_queues)
+		return -EINVAL;
+
+	if (count == old_count)
+		return 0;
+
+	if (running)
+		macb_close(bp->dev);
+
+	bp->num_queues = count;
+	netif_set_real_num_queues(bp->dev, count, count);
+
+	if (running) {
+		ret = macb_open(bp->dev);
+		if (ret) {
+			bp->num_queues = old_count;
+			netif_set_real_num_queues(bp->dev, old_count, old_count);
+			macb_open(bp->dev);
+		}
+	}
+
+	return ret;
+}
+
 static const struct ethtool_ops macb_ethtool_ops = {
 	.get_regs_len		= macb_get_regs_len,
 	.get_regs		= macb_get_regs,
@@ -3934,6 +3997,8 @@ static const struct ethtool_ops macb_ethtool_ops = {
 	.set_link_ksettings     = macb_set_link_ksettings,
 	.get_ringparam		= macb_get_ringparam,
 	.set_ringparam		= macb_set_ringparam,
+	.get_channels		= macb_get_channels,
+	.set_channels		= macb_set_channels,
 };
 
 static const struct ethtool_ops gem_ethtool_ops = {
@@ -3954,10 +4019,12 @@ static const struct ethtool_ops gem_ethtool_ops = {
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
+	.get_channels		= macb_get_channels,
+	.set_channels		= macb_set_channels,
 };
 
 static int macb_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
@@ -4098,9 +4165,9 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
 	size_t i;
 	int err;
 
-	if (conf->num_entries > bp->num_queues) {
+	if (conf->num_entries > bp->max_num_queues) {
 		netdev_err(ndev, "Too many TAPRIO entries: %zu > %d queues\n",
-			   conf->num_entries, bp->num_queues);
+			   conf->num_entries, bp->max_num_queues);
 		return -EINVAL;
 	}
 
@@ -4148,9 +4215,9 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
 
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
@@ -4210,7 +4277,7 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
 	/* All validations passed - proceed with hardware configuration */
 	scoped_guard(spinlock_irqsave, &bp->lock) {
 		/* Disable ENST queues if running before configuring */
-		queue_mask = BIT_U32(bp->num_queues) - 1;
+		queue_mask = BIT_U32(bp->max_num_queues) - 1;
 		gem_writel(bp, ENST_CONTROL,
 			   queue_mask << GEM_ENST_DISABLE_QUEUE_OFFSET);
 
@@ -4245,7 +4312,7 @@ static void macb_taprio_destroy(struct net_device *ndev)
 	unsigned int q;
 
 	netdev_reset_tc(ndev);
-	queue_mask = BIT_U32(bp->num_queues) - 1;
+	queue_mask = BIT_U32(bp->max_num_queues) - 1;
 
 	scoped_guard(spinlock_irqsave, &bp->lock) {
 		/* Single disable command for all queues */
@@ -4253,7 +4320,7 @@ static void macb_taprio_destroy(struct net_device *ndev)
 			   queue_mask << GEM_ENST_DISABLE_QUEUE_OFFSET);
 
 		/* Clear all queue ENST registers in batch */
-		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+		for (q = 0, queue = bp->queues; q < bp->max_num_queues; ++q, ++queue) {
 			queue_writel(queue, ENST_START_TIME, 0);
 			queue_writel(queue, ENST_ON_TIME, 0);
 			queue_writel(queue, ENST_OFF_TIME, 0);
@@ -5512,6 +5579,7 @@ static int macb_probe(struct platform_device *pdev)
 		bp->macb_reg_writel = hw_writel;
 	}
 	bp->num_queues = num_queues;
+	bp->max_num_queues = num_queues;
 	bp->dma_burst_length = macb_config->dma_burst_length;
 	bp->pclk = pclk;
 	bp->hclk = hclk;

-- 
2.53.0


