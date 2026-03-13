Return-Path: <netdev+bounces-267371-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yH0TGpbes2macQAAu9opvQ
	(envelope-from <netdev+bounces-267371-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:53:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81452280E39
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B8EB30462D6
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C485C387370;
	Fri, 13 Mar 2026 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="j+k3xlp2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A2138838A;
	Fri, 13 Mar 2026 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773395495; cv=none; b=t23HMwelxjJQkXVOMGDGKS8EfOTb1vaE/+jbGGCVoL5fl2EDJu14n/9JnpL2PhDsJDgYwUx+d6wDsFheOCIOBmmqmq+YZia2uVJNGDpptI4vlKv84lsKjmsOV/nq2UjfeC5/0/QyDiLitH1hDtizRLCYGpSNiOeNG8+yYMqSHTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773395495; c=relaxed/simple;
	bh=ZyEhh1KUApYFr6InHcH8dDUaTsgPWZb7a/3dyKeVt6Q=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ekeHlB1h3SW8Ag59U/LcqFK4Ywh9uMSTfGELmQhpgyk4Kbn7xKtrVRPOnoTphwodgwRbHfkpCnRYb1WR/c+lqVdOanNnw2lg0mE4ikimowflxPMtnQ4jKBpzX3leTPFbVqO/Qm6P1GV/kKbexZzFyyVTgL1HrSGCVJtQPCYrv58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=j+k3xlp2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=31gW1Ez9RW21ry4PNLhw5rfo5103IhHkPkxFZmjfbYk=; b=j+k3xlp2Jd8EBWl3mwLFraGduz
	ChW4PRRo53cgNclreqakuupPTe50SRVo/7mTWmNIhaAi9ikGexU4/4jozV92QuJCiW28zFT6ruEc7
	VFb9gCc7TLsL1pz90upnkSiY6sRPGgovC8PXFXFHic6mgsKW2YlUSUesq2hY0lgAP35SfbyxwGqSL
	LR9KDNw+0r9kEGV21yHeKdXmVCreRyTrUYez2n3+j+4WfwMBG7zhG2+dAO6VwulYIMLYDxnyucLBU
	PY0RAy5DTQeyiSKlXlJDOK5ja0i/8rb9eP7cmjkG+fOAhPT5C1ZXRqEd0U+b7sKIJlOQblxWLHjYm
	5Qr0OL0w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37478 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w0zB3-000000000du-2IwL;
	Fri, 13 Mar 2026 09:51:29 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w0zB2-0000000D4FS-1VOh;
	Fri, 13 Mar 2026 09:51:28 +0000
In-Reply-To: <abPdzyXJHqt5v3bi@shell.armlinux.org.uk>
References: <abPdzyXJHqt5v3bi@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v3 06/15] net: stmmac: add helper to set receive tail
 pointer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w0zB2-0000000D4FS-1VOh@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 13 Mar 2026 09:51:28 +0000
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267371-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rmk-PC.armlinux.org.uk:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 81452280E39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Setting the queue receive tail pointer follows a common pattern:
calculate the DMA address, and then call stmmac_set_rx_tail_ptr().
The only difference between all the call sites is the index used.

Factor this out into a static function, and add a comment about why
it only uses the normal descriptor size.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 40 +++++++++----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index dca62e7b259a..8823f8f5b053 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -380,6 +380,18 @@ static struct dma_desc *stmmac_get_rx_desc(struct stmmac_priv *priv,
 		return &rx_q->dma_rx[index];
 }
 
+static void stmmac_set_queue_rx_tail_ptr(struct stmmac_priv *priv,
+					 struct stmmac_rx_queue *rx_q,
+					 unsigned int chan, unsigned int index)
+{
+	/* This only needs to deal with normal descriptors as enhanced
+	 * descriptiors are only supported with dwmac1000 (<v4.0) which
+	 * does not implement .set_rx_tail_ptr
+	 */
+	rx_q->rx_tail_addr = rx_q->dma_rx_phy + index * sizeof(struct dma_desc);
+	stmmac_set_rx_tail_ptr(priv, priv->ioaddr, rx_q->rx_tail_addr, chan);
+}
+
 /**
  * stmmac_rx_dirty - Get RX queue dirty
  * @priv: driver private structure
@@ -3302,11 +3314,8 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
 		stmmac_init_rx_chan(priv, priv->ioaddr, priv->plat->dma_cfg,
 				    rx_q->dma_rx_phy, chan);
 
-		rx_q->rx_tail_addr = rx_q->dma_rx_phy +
-				     (rx_q->buf_alloc_num *
-				      sizeof(struct dma_desc));
-		stmmac_set_rx_tail_ptr(priv, priv->ioaddr,
-				       rx_q->rx_tail_addr, chan);
+		stmmac_set_queue_rx_tail_ptr(priv, rx_q, chan,
+					     rx_q->buf_alloc_num);
 	}
 
 	/* DMA TX Channel Configuration */
@@ -4999,9 +5008,7 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
 		entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_rx_size);
 	}
 	rx_q->dirty_rx = entry;
-	rx_q->rx_tail_addr = rx_q->dma_rx_phy +
-			    (rx_q->dirty_rx * sizeof(struct dma_desc));
-	stmmac_set_rx_tail_ptr(priv, priv->ioaddr, rx_q->rx_tail_addr, queue);
+	stmmac_set_queue_rx_tail_ptr(priv, rx_q, queue, rx_q->dirty_rx);
 	/* Wake up Rx DMA from the suspend state if required */
 	stmmac_enable_dma_reception(priv, priv->ioaddr, queue);
 }
@@ -5381,9 +5388,7 @@ static bool stmmac_rx_refill_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 
 	if (rx_desc) {
 		rx_q->dirty_rx = entry;
-		rx_q->rx_tail_addr = rx_q->dma_rx_phy +
-				     (rx_q->dirty_rx * sizeof(struct dma_desc));
-		stmmac_set_rx_tail_ptr(priv, priv->ioaddr, rx_q->rx_tail_addr, queue);
+		stmmac_set_queue_rx_tail_ptr(priv, rx_q, queue, rx_q->dirty_rx);
 	}
 
 	return ret;
@@ -6951,10 +6956,8 @@ void stmmac_enable_rx_queue(struct stmmac_priv *priv, u32 queue)
 	stmmac_init_rx_chan(priv, priv->ioaddr, priv->plat->dma_cfg,
 			    rx_q->dma_rx_phy, rx_q->queue_index);
 
-	rx_q->rx_tail_addr = rx_q->dma_rx_phy + (rx_q->buf_alloc_num *
-			     sizeof(struct dma_desc));
-	stmmac_set_rx_tail_ptr(priv, priv->ioaddr,
-			       rx_q->rx_tail_addr, rx_q->queue_index);
+	stmmac_set_queue_rx_tail_ptr(priv, rx_q, rx_q->queue_index,
+				     rx_q->buf_alloc_num);
 
 	if (rx_q->xsk_pool && rx_q->buf_alloc_num) {
 		buf_size = xsk_pool_get_rx_frame_size(rx_q->xsk_pool);
@@ -7105,11 +7108,8 @@ int stmmac_xdp_open(struct net_device *dev)
 		stmmac_init_rx_chan(priv, priv->ioaddr, priv->plat->dma_cfg,
 				    rx_q->dma_rx_phy, chan);
 
-		rx_q->rx_tail_addr = rx_q->dma_rx_phy +
-				     (rx_q->buf_alloc_num *
-				      sizeof(struct dma_desc));
-		stmmac_set_rx_tail_ptr(priv, priv->ioaddr,
-				       rx_q->rx_tail_addr, chan);
+		stmmac_set_queue_rx_tail_ptr(priv, rx_q, chan,
+					     rx_q->buf_alloc_num);
 
 		if (rx_q->xsk_pool && rx_q->buf_alloc_num) {
 			buf_size = xsk_pool_get_rx_frame_size(rx_q->xsk_pool);
-- 
2.47.3


