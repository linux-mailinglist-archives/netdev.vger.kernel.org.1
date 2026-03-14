Return-Path: <netdev+bounces-267712-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNeANIMvtWkXxQAAu9opvQ
	(envelope-from <netdev+bounces-267712-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:50:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A46A28C87F
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 205903027132
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 09:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FD434DB41;
	Sat, 14 Mar 2026 09:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gIkRa28X"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7F6343D91;
	Sat, 14 Mar 2026 09:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773481743; cv=none; b=nCC6TQseuW/XJUCtj0a2IGD5Q/l6U0PC+pdnT0bgCIs6dfpaV2pFHex6Gj5xtI5xa/0C5hfHOWJe+Im1ATJ9oPBsaJld8iCvFjvSe83dItygPEeENlssDdbR/EeeZxR1PnxkQN/C7s1o7jGIAxRxKX2DgeTSMBgjqi6a4N8+WhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773481743; c=relaxed/simple;
	bh=ZvJ2Gz0QjLwmMMuvqsd6TZZpOao32nY99IbDVrnCHMA=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ZXSIj4ZBYdGQhrbQhzK5HLK9apkGgpj5XdM7cnoP5kWZYirETXir6L8vQhPlN1q9Nr6REZZFKW4+IBLrISNJRklqd70loDe2Ptf5Ewj3Ou1ClKFENVePQ16B0UvVYLDs8gaO9xLjBwjiWepC4oWAq/DM5pbXKFfMQ10F3s2D+7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gIkRa28X; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QSDqBN/DmAWeozPDEC8b1qloPDPE+0ZqAmxNNyAd8yY=; b=gIkRa28X5jTjJWMQG5mgoIQJ34
	UZ0vgK3wkj+J3kdnVJZLfz6BwhDVQ49HaX3ojcyw+ggv0PBinDS/6+hx6rEnIg5/1x6aRDzERVbBc
	xblYXEmctkbWht/Q1o3IaHanD40PLh5JXOGDBQQ0Inh+lZSaFbsyl6qgZj8d8DlMBnyyKF1ieLewM
	gtF70wnwZLH9UVBFKZf6qD/ptIz8yNALp72qaGVXA2xFp5w9nkgJeFy+LLNUfZfA7LSlOj1472qMe
	75V+daQiDIRw/9I8gMeMa+NtxY0DBpJ78TcLxrKOIbmasuGpISo+DZm1AxacKAvekdvasKcgOHqTq
	FsRkauBw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:40722 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w1LWm-00000000231-1oUa;
	Sat, 14 Mar 2026 09:43:24 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w1LWj-0000000DGSp-0lhO;
	Sat, 14 Mar 2026 09:43:21 +0000
In-Reply-To: <abUtGH9KB03PH5Ne@shell.armlinux.org.uk>
References: <abUtGH9KB03PH5Ne@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH net-next v4 12/15] net: stmmac: add helper to get size of a
 transmit descriptor
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w1LWj-0000000DGSp-0lhO@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sat, 14 Mar 2026 09:43:21 +0000
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267712-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.975];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email,rmk-PC.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 3A46A28C87F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add and use a helper to get the size of the hardware transmit
descriptor.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 40 +++++++------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 76e4dcf8f697..da1726b887f3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -362,6 +362,17 @@ static inline u32 stmmac_tx_avail(struct stmmac_priv *priv, u32 queue)
 			  priv->dma_conf.dma_tx_size);
 }
 
+static size_t stmmac_get_tx_desc_size(struct stmmac_priv *priv,
+				      struct stmmac_tx_queue *tx_q)
+{
+	if (priv->extend_desc)
+		return sizeof(struct dma_extended_desc);
+	else if (tx_q->tbs & STMMAC_TBS_AVAIL)
+		return sizeof(struct dma_edesc);
+	else
+		return sizeof(struct dma_desc);
+}
+
 static struct dma_desc *stmmac_get_tx_desc(struct stmmac_priv *priv,
 					   struct stmmac_tx_queue *tx_q,
 					   unsigned int index)
@@ -1501,14 +1512,8 @@ static void stmmac_display_tx_rings(struct stmmac_priv *priv,
 
 		pr_info("\tTX Queue %d rings\n", queue);
 
-		if (priv->extend_desc)
-			desc_size = sizeof(struct dma_extended_desc);
-		else if (tx_q->tbs & STMMAC_TBS_AVAIL)
-			desc_size = sizeof(struct dma_edesc);
-		else
-			desc_size = sizeof(struct dma_desc);
-
 		head_tx = stmmac_get_tx_desc(priv, tx_q, 0);
+		desc_size = stmmac_get_tx_desc_size(priv, tx_q);
 
 		stmmac_display_ring(priv, head_tx, dma_conf->dma_tx_size, false,
 				    tx_q->dma_tx_phy, desc_size);
@@ -2186,17 +2191,14 @@ static void __free_dma_tx_desc_resources(struct stmmac_priv *priv,
 	dma_free_tx_skbufs(priv, dma_conf, queue);
 
 	if (priv->extend_desc) {
-		size = sizeof(struct dma_extended_desc);
 		addr = tx_q->dma_etx;
 	} else if (tx_q->tbs & STMMAC_TBS_AVAIL) {
-		size = sizeof(struct dma_edesc);
 		addr = tx_q->dma_entx;
 	} else {
-		size = sizeof(struct dma_desc);
 		addr = tx_q->dma_tx;
 	}
 
-	size *= dma_conf->dma_tx_size;
+	size = stmmac_get_tx_desc_size(priv, tx_q) * dma_conf->dma_tx_size;
 
 	dma_free_coherent(priv->device, size, addr, tx_q->dma_tx_phy);
 
@@ -2358,14 +2360,7 @@ static int __alloc_dma_tx_desc_resources(struct stmmac_priv *priv,
 	if (!tx_q->tx_skbuff)
 		return -ENOMEM;
 
-	if (priv->extend_desc)
-		size = sizeof(struct dma_extended_desc);
-	else if (tx_q->tbs & STMMAC_TBS_AVAIL)
-		size = sizeof(struct dma_edesc);
-	else
-		size = sizeof(struct dma_desc);
-
-	size *= dma_conf->dma_tx_size;
+	size = stmmac_get_tx_desc_size(priv, tx_q) * dma_conf->dma_tx_size;
 
 	addr = dma_alloc_coherent(priv->device, size,
 				  &tx_q->dma_tx_phy, GFP_KERNEL);
@@ -4333,12 +4328,7 @@ static void stmmac_flush_tx_descriptors(struct stmmac_priv *priv, int queue)
 	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
 	int desc_size;
 
-	if (likely(priv->extend_desc))
-		desc_size = sizeof(struct dma_extended_desc);
-	else if (tx_q->tbs & STMMAC_TBS_AVAIL)
-		desc_size = sizeof(struct dma_edesc);
-	else
-		desc_size = sizeof(struct dma_desc);
+	desc_size = stmmac_get_tx_desc_size(priv, tx_q);
 
 	/* The own bit must be the latest setting done when prepare the
 	 * descriptor and then barrier is needed to make sure that
-- 
2.47.3


