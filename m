Return-Path: <netdev+bounces-277538-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJQ+JBBW2WlGoggAu9opvQ
	(envelope-from <netdev+bounces-277538-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:57:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1207F3DC333
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 512AA308DBAB
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 19:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E833921EC;
	Fri, 10 Apr 2026 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pFExZTEf"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089343909A5
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 19:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850749; cv=none; b=F4Z19KcoIWam1dP1CDNnLxV08y0SjIM9I1U9YegAbEtjf+joV8io33k0nm4IggnAgVxt6EPn/UUw0kq6s3jhBfimUZpY+pit01XJpuFQLYaTSoCNXMLZH5YtiOtj3MiPMSd67LicVegRVktQCaA5cHWrpLeKCipFdUDBCVmv4C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850749; c=relaxed/simple;
	bh=sGFd+s9AVxJZ5Sytm2ICoAojXWg2zvbvrneGJGUsSLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BsmKzOuW+9BZdDg2w6mqkZLRAHQrtb7CA8QyQgpPDkNQEvAsmv25KUFg0yH20Kqcs7CPk8FSKR9orCYIubStomHA+qmvVLOm20wvn3dWWuagdplGJr8ERXx19vy9+zUgwCaMtXLCS1SHwSYJfsDyL+Sr+DBuG7r2PkEBrosSk7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pFExZTEf; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 16120C5C1A6;
	Fri, 10 Apr 2026 19:53:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C2881603F0;
	Fri, 10 Apr 2026 19:52:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 250B91045008E;
	Fri, 10 Apr 2026 21:52:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775850745; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=56hojmgUkhRsgQnnsEAB4Jx7odiblMoDke1mfiVM2Bo=;
	b=pFExZTEfCKyKV1aTZDHY7n1n8aoqahRSAGLDMafCZ0rXBHhJeQ3OoggYVjANoyk4FYHE8b
	ipf5Oozwkwsl+pfuTsxrfChDxR+NFpCSL1DmkDnezFg41rLm/MCh0x1j8BX1OGOfYkQMF2
	9W3nOdmx24uxT5B9k3qWM01EjMPVBhxDiYyA8fs1jrBCFRzlNzPOcNpmWAnvyFat8qjxnL
	4zaMptMpQwIK8nP8YGzDVamrGElwdxAW9I4SkQJsFmYMTcgQc4En9vTa8PkWT+ENZQFJsW
	78di6BNloZc+yLYJJYd5I6Gxz/F1ngzee3syufZ4bj3kF3yEzfpihSI52Ti5/Q==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 10 Apr 2026 21:51:56 +0200
Subject: [PATCH net-next v2 08/14] net: macb: make `struct macb` subset
 reachable from macb_context struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-macb-context-v2-8-af39f71d40b6@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277538-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gnu.org:url,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid]
X-Rspamd-Queue-Id: 1207F3DC333
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For parallel MACB context to start become a reality, many functions need
to stop operating on bp->ctx (the currently active context) and instead
work on a context they get passed. That context might be
(1) the new one that is getting allocated and initialised, or,
(2) the old one to be freed.

To reduce bug surface area, we will taint those functions to *only* take
a context and no `struct macb *bp`. That way, no bug of using `bp->ctx`
instead of `ctx` will ever occur.

For that, we need to embed a subset of `struct macb` information into
each context so that all helpers can still do their jobs. That subset
must be constant once probe is completed. Do this by taking a pointer
to a subset of macb called `struct macb_info`.

That subset is accessible from context (ctx->info->caps) or
from bp (bp->caps) using `-fms-extensions` option, thanks to
commit c4781dc3d1cf ("Kbuild: enable -fms-extensions").
https://gcc.gnu.org/onlinedocs/gcc/Unnamed-Fields.html

Add the structure and assign ctx->info at alloc,
but nothing uses it yet.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      | 30 +++++++++++++++++++++---------
 drivers/net/ethernet/cadence/macb_main.c |  2 ++
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 452b2c8f8641..5ce1b1045e6a 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1290,6 +1290,16 @@ struct ethtool_rx_fs_list {
 	unsigned int count;
 };
 
+struct macb_info {
+	struct platform_device	*pdev;
+	struct net_device	*netdev;
+	struct macb_or_gem_ops	macbgem_ops;
+	unsigned int		num_queues;
+	u32			caps;
+	int			rx_bd_rd_prefetch;
+	int			tx_bd_rd_prefetch;
+};
+
 struct macb_rxq {
 	struct macb_dma_desc	*ring;		/* MACB & GEM */
 	dma_addr_t		ring_dma;	/* MACB & GEM */
@@ -1309,6 +1319,8 @@ struct macb_txq {
 };
 
 struct macb_context {
+	const struct macb_info	*info;
+
 	unsigned int		rx_buffer_size;
 	unsigned int		rx_ring_size;
 	unsigned int		tx_ring_size;
@@ -1324,6 +1336,15 @@ struct macb {
 	u32	(*macb_reg_readl)(struct macb *bp, int offset);
 	void	(*macb_reg_writel)(struct macb *bp, int offset, u32 value);
 
+	/*
+	 * Give direct access (bp->caps) and
+	 * allow taking a pointer to it (&bp->info) for contexts.
+	 */
+	union {
+		struct macb_info;
+		struct macb_info info;
+	};
+
 	/*
 	 * Context stores all its parameters.
 	 * But we must remember them across closure.
@@ -1335,17 +1356,14 @@ struct macb {
 	struct macb_dma_desc	*rx_ring_tieoff;
 	dma_addr_t		rx_ring_tieoff_dma;
 
-	unsigned int		num_queues;
 	struct macb_queue	queues[MACB_MAX_QUEUES];
 
 	spinlock_t		lock;
-	struct platform_device	*pdev;
 	struct clk		*pclk;
 	struct clk		*hclk;
 	struct clk		*tx_clk;
 	struct clk		*rx_clk;
 	struct clk		*tsu_clk;
-	struct net_device	*netdev;
 	/* Protects hw_stats and ethtool_stats */
 	spinlock_t		stats_lock;
 	union {
@@ -1353,15 +1371,12 @@ struct macb {
 		struct gem_stats	gem;
 	}			hw_stats;
 
-	struct macb_or_gem_ops	macbgem_ops;
-
 	struct mii_bus		*mii_bus;
 	struct phylink		*phylink;
 	struct phylink_config	phylink_config;
 	struct phylink_pcs	phylink_usx_pcs;
 	struct phylink_pcs	phylink_sgmii_pcs;
 
-	u32			caps;
 	unsigned int		dma_burst_length;
 
 	phy_interface_t		phy_interface;
@@ -1404,9 +1419,6 @@ struct macb {
 	struct delayed_work	tx_lpi_work;
 	u32			tx_lpi_timer;
 
-	int	rx_bd_rd_prefetch;
-	int	tx_bd_rd_prefetch;
-
 	u32	rx_intr_mask;
 
 	struct macb_pm_data pm_data;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 2eddc7892073..9e35c25b7a56 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3195,6 +3195,8 @@ static int macb_open(struct net_device *netdev)
 		goto pm_exit;
 	}
 
+	bp->ctx->info = &bp->info;
+
 	/* RX buffers initialization */
 	bp->ctx->rx_buffer_size = macb_rx_buffer_size(bp, netdev->mtu);
 	bp->ctx->rx_ring_size = bp->configured_rx_ring_size;

-- 
2.53.0


