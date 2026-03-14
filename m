Return-Path: <netdev+bounces-267703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHJuO5wttWkXxQAAu9opvQ
	(envelope-from <netdev+bounces-267703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:42:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 919F028C751
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 043D2301220E
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 09:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A85347BD7;
	Sat, 14 Mar 2026 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DpCwnpTu"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EA4318B85;
	Sat, 14 Mar 2026 09:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773481370; cv=none; b=A4R9WfNElUL2stLm3Vbg8JveYQSukRfln3git4wi+n6u+4vVHhISFSROynjIvzYz8YbXaZM8fPEYRo/gtsTpGLll1a+V9dublmCN53DiWoTwiI9vaQUl3O/zD6Tw90db2mUGZ5OoIagcUbp9PovsPsnmWVOrrpTMuHEJGz3JZdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773481370; c=relaxed/simple;
	bh=+WVosI6iUk+esIVtNGtBxUDX1RSKOqIH5i/f7lsmpHY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=CwUF16bOF8rhoqiHpHo2E1kBRHd9glLAi8j19/sOZyz8tB0e+WsJEemNvPTpPHK38JEjvANYpqn4C0EUfUYBhZ3OOqy25oXJwyLBN/lsihQXnwqL2yq6i89v4SS8SUlnSa3AHWjo6RW5/qZb5nbfk1g3U2jboeyICG3JinNQ5Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DpCwnpTu; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sjmjh9LqgSfqY7476rGy7BOUo6MdY+yHA2slM9LQGLY=; b=DpCwnpTuPAvMZIJIjm8NRgFS0q
	j0QnfFaLNfKw02brsuCvBf4Q//jpZ2nQMkdowhgkNedJ2+gCZFUIHUyw3dTs5iEX6gp5JEecRFmKz
	ulrgOk4VvBDRQ5pCcgJYj+ImwBYF9FU2z++ukNANENd0r3POPuco/5bfd59ZTwKH3+q228T13AmfB
	o65HfR8iWn+IdwgfFfbYosw9PnTE8Rn82mUCp+tSlF1mdLolS5JzUoA8Jdf4u9WLNEzNkGAhQUi9M
	jdNs0bHEf55Z9bMBOd7L6d9ZcDmtO0+NUNhkc56egb/h8lp4TxJp31G8SPW2wCUQN8C7Ntq1oNP3E
	10FD7tTQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42924 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w1LW5-0000000020U-2u7E;
	Sat, 14 Mar 2026 09:42:42 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w1LW4-0000000DGS3-1J49;
	Sat, 14 Mar 2026 09:42:40 +0000
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
Subject: [PATCH net-next v4 04/15] net: stmmac: add helper to get hardware
 receive descriptor
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w1LW4-0000000DGS3-1J49@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sat, 14 Mar 2026 09:42:40 +0000
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267703-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,rmk-PC.armlinux.org.uk:mid,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 919F028C751
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Provide a helper to get a hardware receive descriptor that takes
account of whether extended format is being used, but returning the
base struct dma_desc pointer. This avoids multiple instances where
this is open coded.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 76 +++++++------------
 1 file changed, 26 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 765b168df50d..a3dfd3501604 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -362,6 +362,16 @@ static inline u32 stmmac_tx_avail(struct stmmac_priv *priv, u32 queue)
 			  priv->dma_conf.dma_tx_size);
 }
 
+static struct dma_desc *stmmac_get_rx_desc(struct stmmac_priv *priv,
+					   struct stmmac_rx_queue *rx_q,
+					   unsigned int index)
+{
+	if (priv->extend_desc)
+		return &rx_q->dma_erx[index].basic;
+	else
+		return &rx_q->dma_rx[index];
+}
+
 /**
  * stmmac_rx_dirty - Get RX queue dirty
  * @priv: driver private structure
@@ -1421,13 +1431,11 @@ static void stmmac_display_rx_rings(struct stmmac_priv *priv,
 
 		pr_info("\tRX Queue %u rings\n", queue);
 
-		if (priv->extend_desc) {
-			head_rx = (void *)rx_q->dma_erx;
+		head_rx = stmmac_get_rx_desc(priv, rx_q, 0);
+		if (priv->extend_desc)
 			desc_size = sizeof(struct dma_extended_desc);
-		} else {
-			head_rx = (void *)rx_q->dma_rx;
+		else
 			desc_size = sizeof(struct dma_desc);
-		}
 
 		/* Display RX ring */
 		stmmac_display_ring(priv, head_rx, dma_conf->dma_rx_size, true,
@@ -1519,10 +1527,7 @@ static void stmmac_clear_rx_descriptors(struct stmmac_priv *priv,
 
 	/* Clear the RX descriptors */
 	for (i = 0; i < dma_conf->dma_rx_size; i++) {
-		if (priv->extend_desc)
-			desc = &rx_q->dma_erx[i].basic;
-		else
-			desc = &rx_q->dma_rx[i];
+		desc = stmmac_get_rx_desc(priv, rx_q, i);
 
 		stmmac_init_rx_desc(priv, desc, priv->use_riwt, priv->mode,
 				    (i == dma_conf->dma_rx_size - 1),
@@ -1731,10 +1736,7 @@ static int stmmac_alloc_rx_buffers(struct stmmac_priv *priv,
 		struct dma_desc *p;
 		int ret;
 
-		if (priv->extend_desc)
-			p = &((rx_q->dma_erx + i)->basic);
-		else
-			p = rx_q->dma_rx + i;
+		p = stmmac_get_rx_desc(priv, rx_q, i);
 
 		ret = stmmac_init_rx_buffers(priv, dma_conf, p, i, flags,
 					     queue);
@@ -1789,10 +1791,7 @@ static int stmmac_alloc_rx_buffers_zc(struct stmmac_priv *priv,
 		dma_addr_t dma_addr;
 		struct dma_desc *p;
 
-		if (priv->extend_desc)
-			p = (struct dma_desc *)(rx_q->dma_erx + i);
-		else
-			p = rx_q->dma_rx + i;
+		p = stmmac_get_rx_desc(priv, rx_q, i);
 
 		buf = &rx_q->buf_pool[i];
 
@@ -4954,10 +4953,7 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
 		struct dma_desc *p;
 		bool use_rx_wd;
 
-		if (priv->extend_desc)
-			p = (struct dma_desc *)(rx_q->dma_erx + entry);
-		else
-			p = rx_q->dma_rx + entry;
+		p = stmmac_get_rx_desc(priv, rx_q, entry);
 
 		if (!buf->page) {
 			buf->page = page_pool_alloc_pages(rx_q->page_pool, gfp);
@@ -5355,10 +5351,7 @@ static bool stmmac_rx_refill_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 			}
 		}
 
-		if (priv->extend_desc)
-			rx_desc = (struct dma_desc *)(rx_q->dma_erx + entry);
-		else
-			rx_desc = rx_q->dma_rx + entry;
+		rx_desc = stmmac_get_rx_desc(priv, rx_q, entry);
 
 		dma_addr = xsk_buff_xdp_get_dma(buf->xdp);
 		stmmac_set_desc_addr(priv, rx_desc, dma_addr);
@@ -5416,14 +5409,12 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 	int status = 0;
 
 	if (netif_msg_rx_status(priv)) {
-		void *rx_head;
+		void *rx_head = stmmac_get_rx_desc(priv, rx_q, 0);
 
 		netdev_dbg(priv->dev, "%s: descriptor ring:\n", __func__);
 		if (priv->extend_desc) {
-			rx_head = (void *)rx_q->dma_erx;
 			desc_size = sizeof(struct dma_extended_desc);
 		} else {
-			rx_head = (void *)rx_q->dma_rx;
 			desc_size = sizeof(struct dma_desc);
 		}
 
@@ -5461,10 +5452,7 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 			dirty = 0;
 		}
 
-		if (priv->extend_desc)
-			p = (struct dma_desc *)(rx_q->dma_erx + entry);
-		else
-			p = rx_q->dma_rx + entry;
+		p = stmmac_get_rx_desc(priv, rx_q, entry);
 
 		/* read the status of the incoming frame */
 		status = stmmac_rx_status(priv, &priv->xstats, p);
@@ -5477,10 +5465,7 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 						priv->dma_conf.dma_rx_size);
 		next_entry = rx_q->cur_rx;
 
-		if (priv->extend_desc)
-			np = (struct dma_desc *)(rx_q->dma_erx + next_entry);
-		else
-			np = rx_q->dma_rx + next_entry;
+		np = stmmac_get_rx_desc(priv, rx_q, next_entry);
 
 		prefetch(np);
 
@@ -5616,16 +5601,13 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 	limit = min(priv->dma_conf.dma_rx_size - 1, (unsigned int)limit);
 
 	if (netif_msg_rx_status(priv)) {
-		void *rx_head;
+		void *rx_head = stmmac_get_rx_desc(priv, rx_q, 0);
 
 		netdev_dbg(priv->dev, "%s: descriptor ring:\n", __func__);
-		if (priv->extend_desc) {
-			rx_head = (void *)rx_q->dma_erx;
+		if (priv->extend_desc)
 			desc_size = sizeof(struct dma_extended_desc);
-		} else {
-			rx_head = (void *)rx_q->dma_rx;
+		else
 			desc_size = sizeof(struct dma_desc);
-		}
 
 		stmmac_display_ring(priv, rx_head, priv->dma_conf.dma_rx_size, true,
 				    rx_q->dma_rx_phy, desc_size);
@@ -5658,10 +5640,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		entry = next_entry;
 		buf = &rx_q->buf_pool[entry];
 
-		if (priv->extend_desc)
-			p = (struct dma_desc *)(rx_q->dma_erx + entry);
-		else
-			p = rx_q->dma_rx + entry;
+		p = stmmac_get_rx_desc(priv, rx_q, entry);
 
 		/* read the status of the incoming frame */
 		status = stmmac_rx_status(priv, &priv->xstats, p);
@@ -5673,10 +5652,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 						priv->dma_conf.dma_rx_size);
 		next_entry = rx_q->cur_rx;
 
-		if (priv->extend_desc)
-			np = (struct dma_desc *)(rx_q->dma_erx + next_entry);
-		else
-			np = rx_q->dma_rx + next_entry;
+		np = stmmac_get_rx_desc(priv, rx_q, next_entry);
 
 		prefetch(np);
 
-- 
2.47.3


