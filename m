Return-Path: <netdev+bounces-266585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ac4CUY+sWmtswIAu9opvQ
	(envelope-from <netdev+bounces-266585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:04:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A36D261B50
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E93A3149697
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86243603DA;
	Wed, 11 Mar 2026 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UisvdeZ3"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DB73B38A1;
	Wed, 11 Mar 2026 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222805; cv=none; b=QjF7OMxZghMtNsRPR8ioY74fUK73pyP9yue/WhSBkUHY2A2ZuU/1CKYOZLKZ6HDWPfqaIN2B5WBIIVJMeEHq2zMdZptX1OYozgX2DApXSvHoawd2B9ffn+dKC3C12wTI68Vn0/0z+O9mohCgXfpWLlWGGhgRfFifCP0/wAxWogo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222805; c=relaxed/simple;
	bh=qqUc6IGecAKIHqxhBHUK67Qb9DpkM7wobrznfxJh7Lk=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Nfa296QiphlEaW8+21HLy8DZpTb4AEu2wjjSjNd27fZOFAeYdSisSIRqbYDh1lUhcdfTRKOTgoEsJiPIzCNlgWuzEkfVcX2tTFZGmN8SJloWi/IvHH/bsQFMjP/MVtDT30oAhuBUVZSZTpCifVeKRjoNkFcOnX7kCQkJY8M4Nc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=UisvdeZ3; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Vwljc2bReMp+ReRMVI0DIpKEZxv2RLRL09hipjwo8dA=; b=UisvdeZ3sIRa/cQr4FIvJ6x+fe
	Vkc33eMxBmw2nIHMH3s6ZoKZ4hkdUlNxGCYE6rXaXCZ6rYvywXxF9VO2eWsITNSd5JQkUd4Eo4/mP
	CMetRg0OX+J7/e269TzibJu7CTC84pcdR+z9XaA1GvKkTS/WAgcEEJ8gj4mJze+Qdgc6gFmhKFyCn
	gY+6ieOdbxD6VSk4lGi+JriIojryii3pBLLtAFzpqPMXJwy9/x/WMigvsoemTWWGpMUOsJ3+GY7l1
	9FYLD28zNrG4rkMCPpogtyM+q+HT30UJuDlmIlmegTvcEn/fW66IjQ9cdi4lE7u6/QgdTme+ZGVwv
	lCppcNPA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37986 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w0GFf-000000006AR-0IVd;
	Wed, 11 Mar 2026 09:53:15 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w0GFa-0000000CiTn-3BDH;
	Wed, 11 Mar 2026 09:53:10 +0000
In-Reply-To: <abE7LWj04-JNxgS2@shell.armlinux.org.uk>
References: <abE7LWj04-JNxgS2@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 13/15] net: stmmac: add helper to set transmit tail
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
Message-Id: <E1w0GFa-0000000CiTn-3BDH@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 11 Mar 2026 09:53:10 +0000
X-Rspamd-Queue-Id: 1A36D261B50
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266585-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,rmk-PC.armlinux.org.uk:mid,armlinux.org.uk:email]
X-Rspamd-Action: no action

Setting the queue transmit tail pointer follows a common pattern:
calculate the DMA address, and then call stmmac_set_tx_tail_ptr().
The only difference between all the call sites is the index used.

Factor this out into a static function.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 30 ++++++++++---------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index da1726b887f3..4521469c5e1d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -385,6 +385,18 @@ static struct dma_desc *stmmac_get_tx_desc(struct stmmac_priv *priv,
 		return &tx_q->dma_tx[index];
 }
 
+static void stmmac_set_queue_tx_tail_ptr(struct stmmac_priv *priv,
+					 struct stmmac_tx_queue *tx_q,
+					 unsigned int chan, unsigned int index)
+{
+	int desc_size;
+
+	desc_size = stmmac_get_tx_desc_size(priv, tx_q);
+
+	tx_q->tx_tail_addr = tx_q->dma_tx_phy + index * desc_size;
+	stmmac_set_tx_tail_ptr(priv, priv->ioaddr, tx_q->tx_tail_addr, chan);
+}
+
 static size_t stmmac_get_rx_desc_size(struct stmmac_priv *priv)
 {
 	if (priv->extend_desc)
@@ -3311,9 +3323,7 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
 		stmmac_init_tx_chan(priv, priv->ioaddr, priv->plat->dma_cfg,
 				    tx_q->dma_tx_phy, chan);
 
-		tx_q->tx_tail_addr = tx_q->dma_tx_phy;
-		stmmac_set_tx_tail_ptr(priv, priv->ioaddr,
-				       tx_q->tx_tail_addr, chan);
+		stmmac_set_queue_tx_tail_ptr(priv, tx_q, chan, 0);
 	}
 
 	return ret;
@@ -4326,9 +4336,6 @@ static void stmmac_tso_allocator(struct stmmac_priv *priv, dma_addr_t des,
 static void stmmac_flush_tx_descriptors(struct stmmac_priv *priv, int queue)
 {
 	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
-	int desc_size;
-
-	desc_size = stmmac_get_tx_desc_size(priv, tx_q);
 
 	/* The own bit must be the latest setting done when prepare the
 	 * descriptor and then barrier is needed to make sure that
@@ -4336,8 +4343,7 @@ static void stmmac_flush_tx_descriptors(struct stmmac_priv *priv, int queue)
 	 */
 	wmb();
 
-	tx_q->tx_tail_addr = tx_q->dma_tx_phy + (tx_q->cur_tx * desc_size);
-	stmmac_set_tx_tail_ptr(priv, priv->ioaddr, tx_q->tx_tail_addr, queue);
+	stmmac_set_queue_tx_tail_ptr(priv, tx_q, queue, tx_q->cur_tx);
 }
 
 /**
@@ -6967,9 +6973,7 @@ void stmmac_enable_tx_queue(struct stmmac_priv *priv, u32 queue)
 	if (tx_q->tbs & STMMAC_TBS_AVAIL)
 		stmmac_enable_tbs(priv, priv->ioaddr, 1, tx_q->queue_index);
 
-	tx_q->tx_tail_addr = tx_q->dma_tx_phy;
-	stmmac_set_tx_tail_ptr(priv, priv->ioaddr,
-			       tx_q->tx_tail_addr, tx_q->queue_index);
+	stmmac_set_queue_tx_tail_ptr(priv, tx_q, tx_q->queue_index, 0);
 
 	stmmac_start_tx_dma(priv, queue);
 
@@ -7070,9 +7074,7 @@ int stmmac_xdp_open(struct net_device *dev)
 		stmmac_init_tx_chan(priv, priv->ioaddr, priv->plat->dma_cfg,
 				    tx_q->dma_tx_phy, chan);
 
-		tx_q->tx_tail_addr = tx_q->dma_tx_phy;
-		stmmac_set_tx_tail_ptr(priv, priv->ioaddr,
-				       tx_q->tx_tail_addr, chan);
+		stmmac_set_queue_tx_tail_ptr(priv, tx_q, chan, 0);
 
 		hrtimer_setup(&tx_q->txtimer, stmmac_tx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	}
-- 
2.47.3


