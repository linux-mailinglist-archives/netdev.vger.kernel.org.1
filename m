Return-Path: <netdev+bounces-267367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCnCHsHfs2ktcQAAu9opvQ
	(envelope-from <netdev+bounces-267367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:58:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E98BC281004
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99AE131979EC
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84488388E75;
	Fri, 13 Mar 2026 09:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="F4tSZiwj"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6E1363094;
	Fri, 13 Mar 2026 09:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773395473; cv=none; b=dG6MgmVkdVXaWTMAqAt22R083xoP4IYmEaxqyUgA4UqW0uzJ86WTCklHVY/DvyWN+smbwI/YDQ8omzvkrpyhO7vXnwhi1F+FLjpy5ENIKQnAopze4BDgmp9qPynzwAX3euJeJQBy8lpjXTW4Przejbj+/ore5fZFQ5kOdPgB4rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773395473; c=relaxed/simple;
	bh=vmV76oO1JZB7prEq9gqCaaciuyEFx0XqgGYVquXhzRk=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=o0L4AIWsl2FaK9Lt7SjDWKa7Dt7G6wgyuCrWKtfvEJKblHvI3zIyLsxr46XtVzFtWQ89RXvOx3+a44hRHF3JxvFX+EHmS0Cnc0/GQ+9u/NvDVAAb1nqjysDGbt8+uyMLYkMabEQpiv5cgzpk14Z4ZnkcrPe1wEN4Sdmc9AB4DM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=F4tSZiwj; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6iS/RgX6lu0f4umfKZBwVXa6SDtuz9v9yqZMmkoNc/c=; b=F4tSZiwjPMcIbmHppfxD/7ckmg
	lP7Yp7ox40dYBGJNbthabfFUOK+SYiZRvenCrznrY+kc99ajEOZ3NJmcZGkCYOkqZ3k5awsjWLfMy
	zfEuI3LLUc4jHZU8oCnSHQHHKex1BxcA4nmzJArU65be3aUBggmEvII5t4OFQfzNZuroQufNWgyEL
	VAnf3ebc6JD8v3ujSazJO0EtkQXPAU57v0tZ06fWw1t6D2cWvfEC294MwREyrtbURxKdnzUds2AtC
	/KHCbGaNpf7wzkuIMuJqYJujp/HH+JxLCHqXBUp/atj/JlCV6kLoLeBNG0NE51twUYn1CSARWAzhG
	ne+ny3TA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35558 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w0zAi-000000000cY-32a6;
	Fri, 13 Mar 2026 09:51:08 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w0zAh-0000000D4F4-3gzQ;
	Fri, 13 Mar 2026 09:51:07 +0000
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
Subject: [PATCH net-next v3 02/15] net: stmmac: helpers for filling
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
Message-Id: <E1w0zAh-0000000D4F4-3gzQ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 13 Mar 2026 09:51:07 +0000
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267367-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rmk-PC.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: E98BC281004
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


