Return-Path: <netdev+bounces-267701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GkyKo8ttWkXxQAAu9opvQ
	(envelope-from <netdev+bounces-267701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:42:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DF128C73A
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2836A301220E
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 09:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227F833D503;
	Sat, 14 Mar 2026 09:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gXmuQJPf"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79281318B85;
	Sat, 14 Mar 2026 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773481357; cv=none; b=mTwzXpkXHvCLwP7hmW/LyrPAX10yGbfaOsK3MezYoubpEEIm+Z41Xnn6LJI53THCs6odeoz1kK2G5xjJKOWu69l/hXISsKqfkc0xI+OyDkNb5TkeYxYNAJsbIeyt3JzduvufzvEPMqo7+/uL0naQ0HCgmJ9Z4TV2E1RdxgeAnx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773481357; c=relaxed/simple;
	bh=vmV76oO1JZB7prEq9gqCaaciuyEFx0XqgGYVquXhzRk=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=bwI7IpbKhGm99x2KQWpOySXAuKpy8mBkW4L8fQ273LKel2lHu/nSe83oH5zGtrSzBs1rk0JrJWSyWo9ffQ/Ao1R7kJwuGGVUceitHtoxlvU4ssfHT6F8agzmhFkZknTaXQbD5jXph/9xnLhq7G3/ohFcf8WGFRiLB3H+kUPFl50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gXmuQJPf; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6iS/RgX6lu0f4umfKZBwVXa6SDtuz9v9yqZMmkoNc/c=; b=gXmuQJPf4NRzbEAzste9JKT4rd
	y15jYlSaqUIRw9S0xTDzp6+mJDC02qagvvFFdE1+wRagyfv23za8lRq9zLvmN817/QP0YRAV4fd1h
	r5aBa1idN9kpNtMKGOE+a8Tj0VwuBwM/aDUixHUp40YrpkXasNfWoDLQ5UGOnoR4cf+wQfrP70tli
	DN9hIPiVjbbe3ME1zL8olY5g0HtyIB/ZtrFWJewWqe9NaNPtBFbjGVtf83H8FZr42pRZFoNu01nL9
	N5Mkbbk96ECqJTUMgtfMF3kKM2jJoCmJWydrOG+ZFaO8IJ3joACwPeOsJNyxgfBNG5jA0Ovm0ibm9
	JzMT+X7Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34364 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w1LVu-000000001zy-3vCL;
	Sat, 14 Mar 2026 09:42:30 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w1LVu-0000000DGRr-0Ni3;
	Sat, 14 Mar 2026 09:42:30 +0000
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
Subject: [PATCH net-next v4 02/15] net: stmmac: helpers for filling
 tx_q->tx_skbuff_dma
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w1LVu-0000000DGRr-0Ni3@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sat, 14 Mar 2026 09:42:30 +0000
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267701-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.975];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,rmk-PC.armlinux.org.uk:mid,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 44DF128C73A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add helpers to fill in the transmit queue metadata to ensure that all
entries are initialised when preparing to transmit. This avoids clean
up code running into surprises.

For example, stmmac_clean_desc3() (which calls clean_desc3() in
chain_mode.c or ring_mode.c) looks at the .last_segment, and in the
latter case, .is_jumbo members.

AI believes that there is a missing .buf_type assignment in
stmmac_tso_xmit(), but this is a mis-analysis. AI believes that
stmmac_tso_allocator() which would increment tx_q->cur_tx will be
called within the loop when nfrags is zero, but it's failing to
realise that none of the code within the for() loop will be
executed. In any case, at the point where the loop exits,
tx_q->tx_skbuff_dma[tx_q->cur_tx].buf_type has been correctly set
via the call to stmmac_set_tx_skb_dma_entry() - either the one
before the loop, or the one at the end of the loop block.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 96 +++++++++++--------
 1 file changed, 54 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 11150bddd872..0dcf4a31e314 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1925,6 +1925,34 @@ static int init_dma_rx_desc_rings(struct net_device *dev,
 	return ret;
 }
 
+static void stmmac_set_tx_dma_entry(struct stmmac_tx_queue *tx_q,
+				    unsigned int entry,
+				    enum stmmac_txbuf_type type,
+				    dma_addr_t addr, size_t len,
+				    bool map_as_page)
+{
+	tx_q->tx_skbuff_dma[entry].buf = addr;
+	tx_q->tx_skbuff_dma[entry].len = len;
+	tx_q->tx_skbuff_dma[entry].buf_type = type;
+	tx_q->tx_skbuff_dma[entry].map_as_page = map_as_page;
+	tx_q->tx_skbuff_dma[entry].last_segment = false;
+	tx_q->tx_skbuff_dma[entry].is_jumbo = false;
+}
+
+static void stmmac_set_tx_skb_dma_entry(struct stmmac_tx_queue *tx_q,
+					unsigned int entry, dma_addr_t addr,
+					size_t len, bool map_as_page)
+{
+	stmmac_set_tx_dma_entry(tx_q, entry, STMMAC_TXBUF_T_SKB, addr, len,
+				map_as_page);
+}
+
+static void stmmac_set_tx_dma_last_segment(struct stmmac_tx_queue *tx_q,
+					   unsigned int entry)
+{
+	tx_q->tx_skbuff_dma[entry].last_segment = true;
+}
+
 /**
  * __init_dma_tx_desc_rings - init the TX descriptor ring (per queue)
  * @priv: driver private structure
@@ -1970,11 +1998,8 @@ static int __init_dma_tx_desc_rings(struct stmmac_priv *priv,
 			p = tx_q->dma_tx + i;
 
 		stmmac_clear_desc(priv, p);
+		stmmac_set_tx_skb_dma_entry(tx_q, i, 0, 0, false);
 
-		tx_q->tx_skbuff_dma[i].buf = 0;
-		tx_q->tx_skbuff_dma[i].map_as_page = false;
-		tx_q->tx_skbuff_dma[i].len = 0;
-		tx_q->tx_skbuff_dma[i].last_segment = false;
 		tx_q->tx_skbuff[i] = NULL;
 	}
 
@@ -2695,19 +2720,15 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		meta = xsk_buff_get_metadata(pool, xdp_desc.addr);
 		xsk_buff_raw_dma_sync_for_device(pool, dma_addr, xdp_desc.len);
 
-		tx_q->tx_skbuff_dma[entry].buf_type = STMMAC_TXBUF_T_XSK_TX;
-
 		/* To return XDP buffer to XSK pool, we simple call
 		 * xsk_tx_completed(), so we don't need to fill up
 		 * 'buf' and 'xdpf'.
 		 */
-		tx_q->tx_skbuff_dma[entry].buf = 0;
-		tx_q->xdpf[entry] = NULL;
+		stmmac_set_tx_dma_entry(tx_q, entry, STMMAC_TXBUF_T_XSK_TX,
+					0, xdp_desc.len, false);
+		stmmac_set_tx_dma_last_segment(tx_q, entry);
 
-		tx_q->tx_skbuff_dma[entry].map_as_page = false;
-		tx_q->tx_skbuff_dma[entry].len = xdp_desc.len;
-		tx_q->tx_skbuff_dma[entry].last_segment = true;
-		tx_q->tx_skbuff_dma[entry].is_jumbo = false;
+		tx_q->xdpf[entry] = NULL;
 
 		stmmac_set_desc_addr(priv, tx_desc, dma_addr);
 
@@ -2882,6 +2903,9 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
 			tx_q->tx_skbuff_dma[entry].map_as_page = false;
 		}
 
+		/* This looks at tx_q->tx_skbuff_dma[tx_q->dirty_tx].is_jumbo
+		 * and tx_q->tx_skbuff_dma[tx_q->dirty_tx].last_segment
+		 */
 		stmmac_clean_desc3(priv, tx_q, p);
 
 		tx_q->tx_skbuff_dma[entry].last_segment = false;
@@ -4471,10 +4495,8 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	 * this DMA buffer right after the DMA engine completely finishes the
 	 * full buffer transmission.
 	 */
-	tx_q->tx_skbuff_dma[tx_q->cur_tx].buf = des;
-	tx_q->tx_skbuff_dma[tx_q->cur_tx].len = skb_headlen(skb);
-	tx_q->tx_skbuff_dma[tx_q->cur_tx].map_as_page = false;
-	tx_q->tx_skbuff_dma[tx_q->cur_tx].buf_type = STMMAC_TXBUF_T_SKB;
+	stmmac_set_tx_skb_dma_entry(tx_q, tx_q->cur_tx, des, skb_headlen(skb),
+				    false);
 
 	/* Prepare fragments */
 	for (i = 0; i < nfrags; i++) {
@@ -4489,17 +4511,14 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 		stmmac_tso_allocator(priv, des, skb_frag_size(frag),
 				     (i == nfrags - 1), queue);
 
-		tx_q->tx_skbuff_dma[tx_q->cur_tx].buf = des;
-		tx_q->tx_skbuff_dma[tx_q->cur_tx].len = skb_frag_size(frag);
-		tx_q->tx_skbuff_dma[tx_q->cur_tx].map_as_page = true;
-		tx_q->tx_skbuff_dma[tx_q->cur_tx].buf_type = STMMAC_TXBUF_T_SKB;
+		stmmac_set_tx_skb_dma_entry(tx_q, tx_q->cur_tx, des,
+					    skb_frag_size(frag), true);
 	}
 
-	tx_q->tx_skbuff_dma[tx_q->cur_tx].last_segment = true;
+	stmmac_set_tx_dma_last_segment(tx_q, tx_q->cur_tx);
 
 	/* Only the last descriptor gets to point to the skb. */
 	tx_q->tx_skbuff[tx_q->cur_tx] = skb;
-	tx_q->tx_skbuff_dma[tx_q->cur_tx].buf_type = STMMAC_TXBUF_T_SKB;
 
 	/* Manage tx mitigation */
 	tx_packets = CIRC_CNT(tx_q->cur_tx + 1, first_tx,
@@ -4758,23 +4777,18 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (dma_mapping_error(priv->device, des))
 			goto dma_map_err; /* should reuse desc w/o issues */
 
-		tx_q->tx_skbuff_dma[entry].buf = des;
-
+		stmmac_set_tx_skb_dma_entry(tx_q, entry, des, len, true);
 		stmmac_set_desc_addr(priv, desc, des);
 
-		tx_q->tx_skbuff_dma[entry].map_as_page = true;
-		tx_q->tx_skbuff_dma[entry].len = len;
-		tx_q->tx_skbuff_dma[entry].last_segment = last_segment;
-		tx_q->tx_skbuff_dma[entry].buf_type = STMMAC_TXBUF_T_SKB;
-
 		/* Prepare the descriptor and set the own bit too */
 		stmmac_prepare_tx_desc(priv, desc, 0, len, csum_insertion,
 				priv->mode, 1, last_segment, skb->len);
 	}
 
+	stmmac_set_tx_dma_last_segment(tx_q, entry);
+
 	/* Only the last descriptor gets to point to the skb. */
 	tx_q->tx_skbuff[entry] = skb;
-	tx_q->tx_skbuff_dma[entry].buf_type = STMMAC_TXBUF_T_SKB;
 
 	/* According to the coalesce parameter the IC bit for the latest
 	 * segment is reset and the timer re-started to clean the tx status.
@@ -4853,14 +4867,13 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (dma_mapping_error(priv->device, des))
 			goto dma_map_err;
 
-		tx_q->tx_skbuff_dma[first_entry].buf = des;
-		tx_q->tx_skbuff_dma[first_entry].buf_type = STMMAC_TXBUF_T_SKB;
-		tx_q->tx_skbuff_dma[first_entry].map_as_page = false;
+		stmmac_set_tx_skb_dma_entry(tx_q, first_entry, des, nopaged_len,
+					    false);
 
 		stmmac_set_desc_addr(priv, first, des);
 
-		tx_q->tx_skbuff_dma[first_entry].len = nopaged_len;
-		tx_q->tx_skbuff_dma[first_entry].last_segment = last_segment;
+		if (last_segment)
+			stmmac_set_tx_dma_last_segment(tx_q, first_entry);
 
 		if (unlikely((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
 			     priv->hwts_tx_en)) {
@@ -5062,6 +5075,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
 	bool csum = !priv->plat->tx_queues_cfg[queue].coe_unsupported;
 	unsigned int entry = tx_q->cur_tx;
+	enum stmmac_txbuf_type buf_type;
 	struct dma_desc *tx_desc;
 	dma_addr_t dma_addr;
 	bool set_ic;
@@ -5089,7 +5103,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 		if (dma_mapping_error(priv->device, dma_addr))
 			return STMMAC_XDP_CONSUMED;
 
-		tx_q->tx_skbuff_dma[entry].buf_type = STMMAC_TXBUF_T_XDP_NDO;
+		buf_type = STMMAC_TXBUF_T_XDP_NDO;
 	} else {
 		struct page *page = virt_to_page(xdpf->data);
 
@@ -5098,14 +5112,12 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 		dma_sync_single_for_device(priv->device, dma_addr,
 					   xdpf->len, DMA_BIDIRECTIONAL);
 
-		tx_q->tx_skbuff_dma[entry].buf_type = STMMAC_TXBUF_T_XDP_TX;
+		buf_type = STMMAC_TXBUF_T_XDP_TX;
 	}
 
-	tx_q->tx_skbuff_dma[entry].buf = dma_addr;
-	tx_q->tx_skbuff_dma[entry].map_as_page = false;
-	tx_q->tx_skbuff_dma[entry].len = xdpf->len;
-	tx_q->tx_skbuff_dma[entry].last_segment = true;
-	tx_q->tx_skbuff_dma[entry].is_jumbo = false;
+	stmmac_set_tx_dma_entry(tx_q, entry, buf_type, dma_addr, xdpf->len,
+				false);
+	stmmac_set_tx_dma_last_segment(tx_q, entry);
 
 	tx_q->xdpf[entry] = xdpf;
 
-- 
2.47.3


