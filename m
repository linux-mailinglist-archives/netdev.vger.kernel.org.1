Return-Path: <netdev+bounces-277543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJlrHkJW2WlGoggAu9opvQ
	(envelope-from <netdev+bounces-277543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:57:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A97253DC371
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 41EB2304ECDD
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 19:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8AE3A6EF4;
	Fri, 10 Apr 2026 19:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ydQXnl7D"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A8E37F8D3
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 19:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850764; cv=none; b=qhJj4CWMCiCQDbQzCm/3XCaGJGlBE5fIc1JDSpgzIZdSVZ1y4nYFvAaJSKw6okQVFCMim/3e11PQqSwZNwypTN2aMGKA+OAcC/lLatpZpk87iUgROMHCSPgKf9uWgWVFYT8Rgw49w5WMmz+6z4eiCHi0s4J0O43CV+l2VwfdpJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850764; c=relaxed/simple;
	bh=ylFosOyISRkCLcpLILfXR1jqq9ZJDl5D3Rd67XbsIZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PeWzTIu06Atyv21/CfJnvQ9DerRoVW1qV22JeQAKes2jyrTmKEOXEby96kQXfRTzf1wKfojW/CoiXykU/ENWQ2WXgcRYI7M/PyKkRuz6PACrGuKXAJV/ZbzOTrB/DOWR1EwtcMr7pFsGBehW9SZxPwe/sRDH60ku5csme/8J/5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ydQXnl7D; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9D7FF4E4294C;
	Fri, 10 Apr 2026 19:52:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 73708603F0;
	Fri, 10 Apr 2026 19:52:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B2A6610450088;
	Fri, 10 Apr 2026 21:52:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775850760; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lvkMSS621GEt/FKfEI0QkYcsjQ+tlBiP5wmcPdsLGHE=;
	b=ydQXnl7DlcIUY4Zej6P4WopdUL83zZvP8IIsLJNa9mf3BKSdrcbu61xMIdYGBbbMP4C1g9
	GaUWV4OwwR64gJ/RlT1Rnnjm3AOlNsnCHgmGGlG8uSi5FH/wjEdiuGZFL7sHKdGUl0rTpE
	e9blU3auiCN09fz7LzJC7HOPx+V/yXUwSWAUGPAjoFuQ4naraFFZ6p393Fg7ZHWKKgQFiw
	Aopajuh5UWcM0jclega8tfAndMfWV4EvRff0Q2VJ4lZhW39P4Vo+FWKnDUCDnbCjtIA7UU
	zlmGtsss5pytqyCe9H/IMiP+nqlU5qDsa8HlI4Hpe3co8qalDJmwFg70M2/lDg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 10 Apr 2026 21:52:01 +0200
Subject: [PATCH net-next v2 13/14] net: macb: use context swapping in
 .set_ringparam()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-macb-context-v2-13-af39f71d40b6@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277543-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid]
X-Rspamd-Queue-Id: A97253DC371
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ethtool_ops.set_ringparam() is implemented using the primitive close /
update ring size / reopen sequence. Under memory pressure this does not
fly: we free our buffers at close and cannot reallocate new ones at
open. Also, it triggers a slow PHY reinit.

Instead, exploit the new context mechanism and improve our sequence to:
 - allocate a new context (including buffers) first
 - if it fails, early return without any impact to the interface
 - stop interface
 - update global state (bp, netdev, etc)
 - pass buffer pointers to the hardware
 - start interface
 - free old context.

The HW disable sequence is inspired by macb_reset_hw() but avoids
(1) setting NCR bit CLRSTAT and (2) clearing register PBUFRXCUT.

The HW re-enable sequence is inspired by macb_mac_link_up(), skipping
over register writes which would be redundant (because values have not
changed).

The generic context swapping parts are isolated into helper functions
macb_context_swap_start|end(), reusable by other operations (change_mtu,
set_channels, etc).

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 102 ++++++++++++++++++++++++++++---
 1 file changed, 95 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 81beb67b206a..340ae7d881c6 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3081,6 +3081,89 @@ static void macb_configure_dma(struct macb *bp)
 	}
 }
 
+static void macb_context_swap_start(struct macb *bp)
+{
+	struct macb_queue *queue;
+	unsigned long flags;
+	unsigned int q;
+	u32 ctrl;
+
+	/* Disable software Tx, disable HW Tx/Rx and disable NAPI. */
+
+	netif_tx_disable(bp->netdev);
+
+	spin_lock_irqsave(&bp->lock, flags);
+
+	ctrl = macb_readl(bp, NCR);
+	macb_writel(bp, NCR, ctrl & ~(MACB_BIT(RE) | MACB_BIT(TE)));
+
+	macb_writel(bp, TSR, -1);
+	macb_writel(bp, RSR, -1);
+
+	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+		queue_writel(queue, IDR, -1);
+		queue_readl(queue, ISR);
+		if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
+			queue_writel(queue, ISR, -1);
+	}
+
+	spin_unlock_irqrestore(&bp->lock, flags);
+
+	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+		napi_disable(&queue->napi_rx);
+		napi_disable(&queue->napi_tx);
+		netdev_tx_reset_queue(netdev_get_tx_queue(bp->netdev, q));
+		cancel_work_sync(&queue->tx_error_task);
+	}
+
+	cancel_work_sync(&bp->hresp_err_bh_work);
+	cancel_delayed_work_sync(&bp->tx_lpi_work);
+}
+
+static void macb_context_swap_end(struct macb *bp,
+				  struct macb_context *new_ctx)
+{
+	struct macb_context *old_ctx;
+	struct macb_queue *queue;
+	unsigned int q;
+	u32 ctrl;
+
+	/* Swap contexts & give buffer pointers to HW. */
+
+	old_ctx = bp->ctx;
+	bp->ctx = new_ctx;
+	macb_init_buffers(bp);
+
+	/* Start NAPI, HW Tx/Rx and software Tx. */
+
+	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+		napi_enable(&queue->napi_rx);
+		napi_enable(&queue->napi_tx);
+	}
+
+	macb_configure_dma(bp);
+
+	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC)) {
+		for (q = 0, queue = bp->queues; q < bp->num_queues;
+		     ++q, ++queue) {
+			queue_writel(queue, IER,
+				     bp->rx_intr_mask |
+				     MACB_TX_INT_FLAGS |
+				     MACB_BIT(HRESP));
+		}
+	}
+
+	ctrl = macb_readl(bp, NCR);
+	macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));
+
+	netif_tx_start_all_queues(bp->netdev);
+
+	/* Free old context. */
+
+	macb_free_consistent(old_ctx);
+	kfree(old_ctx);
+}
+
 static void macb_init_hw(struct macb *bp)
 {
 	u32 config;
@@ -3804,9 +3887,10 @@ static int macb_set_ringparam(struct net_device *netdev,
 			      struct kernel_ethtool_ringparam *kernel_ring,
 			      struct netlink_ext_ack *extack)
 {
+	unsigned int new_rx_size, new_tx_size;
 	struct macb *bp = netdev_priv(netdev);
-	u32 new_rx_size, new_tx_size;
-	unsigned int reset = 0;
+	bool running = netif_running(netdev);
+	struct macb_context *new_ctx;
 
 	if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
 		return -EINVAL;
@@ -3825,16 +3909,20 @@ static int macb_set_ringparam(struct net_device *netdev,
 		return 0;
 	}
 
-	if (netif_running(bp->netdev)) {
-		reset = 1;
-		macb_close(bp->netdev);
+	if (running) {
+		new_ctx = macb_context_alloc(bp, netdev->mtu,
+					     new_rx_size, new_tx_size);
+		if (IS_ERR(new_ctx))
+			return PTR_ERR(new_ctx);
+
+		macb_context_swap_start(bp);
 	}
 
 	bp->configured_rx_ring_size = new_rx_size;
 	bp->configured_tx_ring_size = new_tx_size;
 
-	if (reset)
-		macb_open(bp->netdev);
+	if (running)
+		macb_context_swap_end(bp, new_ctx);
 
 	return 0;
 }

-- 
2.53.0


