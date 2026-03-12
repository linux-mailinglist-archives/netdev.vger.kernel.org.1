Return-Path: <netdev+bounces-267000-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGAlArCRsml5NgAAu9opvQ
	(envelope-from <netdev+bounces-267000-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:13:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBE32702A7
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EB2B30B0A19
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1043C0637;
	Thu, 12 Mar 2026 10:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pMi/MFax"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFDD3C3424;
	Thu, 12 Mar 2026 10:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773310207; cv=none; b=sjH95v8P7D94IChCcxg+kweS1Z0L05SIcvbA5XmpOv8enYjxRUa+lECtkRvw6rSE3T5yufy4h5x96RDcKwH1KMYeqcx81tAGQK/GWYT17RCJ/TALBJMvxQZFm5F4oBndcMQYeqJgknE69zg881fCMCeL9J1li4FbZPv6TZ3uaNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773310207; c=relaxed/simple;
	bh=k6q39lOW+xQu0Nyag4YuAMe/hF4JRDUICrJG7xUXC7c=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=KBuJmmBQdTAZSnBu/pFTfoH1o9n8+S+3LNDzvRhmq3+6mWS81XoA3C/f9wdb3p4E/6m8TkouDwI8phPCoRhSmNNeR4TkB+99IrSqkBZXAJtG5m7XTsF10LF3z7hMTqSbB+gZRSHViY8Fc5lR+b1Y6DJrqg09xiGMD1ZE3hCZdQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pMi/MFax; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vD9XV3c23C+2JgGGszHzOnaUIWcl3DV5rrl6x+Bs1b8=; b=pMi/MFaxfKzfHX7aJIdpDsOd4N
	ACF0r4ilzIdLHkDT3cQxga2TPDKyQcCLshgb+9fvGrYALB+GIcqFixWUrLolzYFi2wfI5qsu4QpYM
	IHyVmhmbk+h/7kFV7KtN+XA0CzSZX/5ihCMYA4eGxolb8SIMNyXRT1n8c5XIeKV+aROfMtb+yKM7a
	Cvos3DlXzSFVSa4kFMuXiI04xf5Fe+s3qXKaENNhK/5aoR2IG0NC7f2jSwg54dpE2ldH6SK/5WFcL
	jSLlj6Ylb+zvjjwcV78YCh9jiZ6cnXYr5MM1Xil+JKh2fyhw7lqjCYw6ML3b7JNZRIVoKF3Su89hz
	fPIpuQyA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:45888 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w0czF-000000007aJ-3WbS;
	Thu, 12 Mar 2026 10:09:49 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w0czA-0000000CzGq-04op;
	Thu, 12 Mar 2026 10:09:44 +0000
In-Reply-To: <abKQWloxp9_4OuJh@shell.armlinux.org.uk>
References: <abKQWloxp9_4OuJh@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v2 11/15] net: stmmac: add helper to get hardware
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
Message-Id: <E1w0czA-0000000CzGq-04op@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 12 Mar 2026 10:09:44 +0000
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267000-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.973];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,rmk-PC.armlinux.org.uk:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AFBE32702A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Provide a helper to get the hardware transmit descriptor that takes
account of whether extended format and TBS are being used, returning
the base struct dma_desc pointer. This avoids multiple instances where
these tests are open coded.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 87 ++++++-------------
 1 file changed, 25 insertions(+), 62 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 032ef9fba8b4..76e4dcf8f697 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -362,6 +362,18 @@ static inline u32 stmmac_tx_avail(struct stmmac_priv *priv, u32 queue)
 			  priv->dma_conf.dma_tx_size);
 }
 
+static struct dma_desc *stmmac_get_tx_desc(struct stmmac_priv *priv,
+					   struct stmmac_tx_queue *tx_q,
+					   unsigned int index)
+{
+	if (priv->extend_desc)
+		return &tx_q->dma_etx[index].basic;
+	else if (tx_q->tbs & STMMAC_TBS_AVAIL)
+		return &tx_q->dma_entx[index].basic;
+	else
+		return &tx_q->dma_tx[index];
+}
+
 static size_t stmmac_get_rx_desc_size(struct stmmac_priv *priv)
 {
 	if (priv->extend_desc)
@@ -1489,16 +1501,14 @@ static void stmmac_display_tx_rings(struct stmmac_priv *priv,
 
 		pr_info("\tTX Queue %d rings\n", queue);
 
-		if (priv->extend_desc) {
-			head_tx = (void *)tx_q->dma_etx;
+		if (priv->extend_desc)
 			desc_size = sizeof(struct dma_extended_desc);
-		} else if (tx_q->tbs & STMMAC_TBS_AVAIL) {
-			head_tx = (void *)tx_q->dma_entx;
+		else if (tx_q->tbs & STMMAC_TBS_AVAIL)
 			desc_size = sizeof(struct dma_edesc);
-		} else {
-			head_tx = (void *)tx_q->dma_tx;
+		else
 			desc_size = sizeof(struct dma_desc);
-		}
+
+		head_tx = stmmac_get_tx_desc(priv, tx_q, 0);
 
 		stmmac_display_ring(priv, head_tx, dma_conf->dma_tx_size, false,
 				    tx_q->dma_tx_phy, desc_size);
@@ -1587,13 +1597,7 @@ static void stmmac_clear_tx_descriptors(struct stmmac_priv *priv,
 		int last = (i == (dma_conf->dma_tx_size - 1));
 		struct dma_desc *p;
 
-		if (priv->extend_desc)
-			p = &tx_q->dma_etx[i].basic;
-		else if (tx_q->tbs & STMMAC_TBS_AVAIL)
-			p = &tx_q->dma_entx[i].basic;
-		else
-			p = &tx_q->dma_tx[i];
-
+		p = stmmac_get_tx_desc(priv, tx_q, i);
 		stmmac_init_tx_desc(priv, p, priv->mode, last);
 	}
 }
@@ -2021,13 +2025,7 @@ static int __init_dma_tx_desc_rings(struct stmmac_priv *priv,
 	for (i = 0; i < dma_conf->dma_tx_size; i++) {
 		struct dma_desc *p;
 
-		if (priv->extend_desc)
-			p = &((tx_q->dma_etx + i)->basic);
-		else if (tx_q->tbs & STMMAC_TBS_AVAIL)
-			p = &((tx_q->dma_entx + i)->basic);
-		else
-			p = tx_q->dma_tx + i;
-
+		p = stmmac_get_tx_desc(priv, tx_q, i);
 		stmmac_clear_desc(priv, p);
 		stmmac_set_tx_skb_dma_entry(tx_q, i, 0, 0, false);
 
@@ -2730,13 +2728,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 			continue;
 		}
 
-		if (likely(priv->extend_desc))
-			tx_desc = (struct dma_desc *)(tx_q->dma_etx + entry);
-		else if (tx_q->tbs & STMMAC_TBS_AVAIL)
-			tx_desc = &tx_q->dma_entx[entry].basic;
-		else
-			tx_desc = tx_q->dma_tx + entry;
-
+		tx_desc = stmmac_get_tx_desc(priv, tx_q, entry);
 		dma_addr = xsk_buff_raw_get_dma(pool, xdp_desc.addr);
 		meta = xsk_buff_get_metadata(pool, xdp_desc.addr);
 		xsk_buff_raw_dma_sync_for_device(pool, dma_addr, xdp_desc.len);
@@ -2863,13 +2855,7 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
 			skb = NULL;
 		}
 
-		if (priv->extend_desc)
-			p = (struct dma_desc *)(tx_q->dma_etx + entry);
-		else if (tx_q->tbs & STMMAC_TBS_AVAIL)
-			p = &tx_q->dma_entx[entry].basic;
-		else
-			p = tx_q->dma_tx + entry;
-
+		p = stmmac_get_tx_desc(priv, tx_q, entry);
 		status = stmmac_tx_status(priv,	&priv->xstats, p, priv->ioaddr);
 		/* Check if the descriptor is owned by the DMA */
 		if (unlikely(status & tx_dma_own))
@@ -4752,13 +4738,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		csum_insertion = !csum_insertion;
 	}
 
-	if (likely(priv->extend_desc))
-		desc = (struct dma_desc *)(tx_q->dma_etx + entry);
-	else if (tx_q->tbs & STMMAC_TBS_AVAIL)
-		desc = &tx_q->dma_entx[entry].basic;
-	else
-		desc = tx_q->dma_tx + entry;
-
+	desc = stmmac_get_tx_desc(priv, tx_q, entry);
 	first = desc;
 
 	if (has_vlan)
@@ -4783,12 +4763,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
 		WARN_ON(tx_q->tx_skbuff[entry]);
 
-		if (likely(priv->extend_desc))
-			desc = (struct dma_desc *)(tx_q->dma_etx + entry);
-		else if (tx_q->tbs & STMMAC_TBS_AVAIL)
-			desc = &tx_q->dma_entx[entry].basic;
-		else
-			desc = tx_q->dma_tx + entry;
+		desc = stmmac_get_tx_desc(priv, tx_q, entry);
 
 		des = skb_frag_dma_map(priv->device, frag, 0, len,
 				       DMA_TO_DEVICE);
@@ -4829,13 +4804,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		set_ic = false;
 
 	if (set_ic) {
-		if (likely(priv->extend_desc))
-			desc = &tx_q->dma_etx[entry].basic;
-		else if (tx_q->tbs & STMMAC_TBS_AVAIL)
-			desc = &tx_q->dma_entx[entry].basic;
-		else
-			desc = &tx_q->dma_tx[entry];
-
+		desc = stmmac_get_tx_desc(priv, tx_q, entry);
 		tx_q->tx_count_frames = 0;
 		stmmac_set_tx_ic(priv, desc);
 	}
@@ -5103,13 +5072,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 		return STMMAC_XDP_CONSUMED;
 	}
 
-	if (likely(priv->extend_desc))
-		tx_desc = (struct dma_desc *)(tx_q->dma_etx + entry);
-	else if (tx_q->tbs & STMMAC_TBS_AVAIL)
-		tx_desc = &tx_q->dma_entx[entry].basic;
-	else
-		tx_desc = tx_q->dma_tx + entry;
-
+	tx_desc = stmmac_get_tx_desc(priv, tx_q, entry);
 	if (dma_map) {
 		dma_addr = dma_map_single(priv->device, xdpf->data,
 					  xdpf->len, DMA_TO_DEVICE);
-- 
2.47.3


