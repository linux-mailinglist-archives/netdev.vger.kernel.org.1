Return-Path: <netdev+bounces-267714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKDfAqsvtWkXxQAAu9opvQ
	(envelope-from <netdev+bounces-267714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:51:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6947528C89C
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82EC9303CE81
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 09:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B6C34E75B;
	Sat, 14 Mar 2026 09:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lmC06WNi"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497DD346765;
	Sat, 14 Mar 2026 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773481769; cv=none; b=hz4ekWM8lHS9PttJIOFYPPT+ZPojWtlHZNM2PCpdCrIAnNt4EpJaUG+XPIauyiHBg3IEh75ZD9x0Ijp1BybSB6m3TOznvx4cQGeHx2muIE9Oocn93YeQaPJXjy4PIi+pi68aA71zUEe9CQ18DHM95uH/PjihoRGSobArPULF4TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773481769; c=relaxed/simple;
	bh=wlHzuUH0gUssp1UjidQbhAVH/CdfFqbsFbfXxNH8yRQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=a5lMcI5lNhe6yrs5R/VmFTAAyKLU0Ookq60mTBQuPi4qUYpm8lMw5MOCu6KF5LfErEXEd/RqCWIXf+G+RRZ2XZ3jjA+Jy8PomF5iXOA1DZcGuMAELDe9sZ38Vu9UXOdozNMnNs+O8myW5LcPwKR9u3jepK8RaZuPOg/t+4J4uvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=lmC06WNi; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jy7ZZYhO/l6AOCV4Dt/j5MRaTr5NmlKcOirpso5gcsI=; b=lmC06WNieLreXGlEIHWpCaVOUh
	i6MIhwbunHss7ff3R7azS4CcFGl4FeoVTYa1Pm4bSjU6txY7q3MCpt9WnEJeXg0niU2MM6ZyE/j1u
	uOWWWzx1QDzUm1e+HznZcd2kA/p93Rr8QD0BiESBqDQdwIPyKdEQX2TdxevjhOwGRt1+H4Rk91CQy
	HQVw3YScq5pTl5ur2Wf2GhPolkpZytbVlWvqf3FlLqcMQCAyv3+S0XNFcLbm6d3YZk2+Qg+oHewhZ
	2fEjzb5OHRAx2jn1i8m9i0EcnBt1/L4bK67l1x8Ie8fC6dd8jikYZZI0uX55WbXkPCYA8BUUrjTQe
	ohE5Aqsg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54580 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w1LWz-0000000023d-1VDf;
	Sat, 14 Mar 2026 09:43:37 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w1LWy-0000000DGT8-2Hoc;
	Sat, 14 Mar 2026 09:43:36 +0000
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
Subject: [PATCH net-next v4 15/15] net: stmmac: use queue rather than
 ->queue_index
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w1LWy-0000000DGT8-2Hoc@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sat, 14 Mar 2026 09:43:36 +0000
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267714-lists,netdev=lfdr.de,kernel];
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
	NEURAL_HAM(-0.00)[-0.976];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email,rmk-PC.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 6947528C89C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We use a lot of ->queue_index where we already have the queue / channel
index (which are actually the same index), which has been used to get
the queue struct. Since queue and queue_index are identical in
priv->(tx|rx)_queue[queue]->queue_index there is no point using the
queue_index where we already have queue.

Use queue rather than queue_index.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 25 ++++++++-----------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 55b79e9e637f..8393cbd0875e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -440,7 +440,7 @@ static void stmmac_set_queue_rx_buf_size(struct stmmac_priv *priv,
 	else
 		buf_size = priv->dma_conf.dma_buf_sz;
 
-	stmmac_set_dma_bfsize(priv, priv->ioaddr, buf_size, rx_q->queue_index);
+	stmmac_set_dma_bfsize(priv, priv->ioaddr, buf_size, chan);
 }
 
 /**
@@ -1902,7 +1902,7 @@ static int __init_dma_rx_desc_rings(struct stmmac_priv *priv,
 						   NULL));
 		netdev_info(priv->dev,
 			    "Register MEM_TYPE_XSK_BUFF_POOL RxQ-%d\n",
-			    rx_q->queue_index);
+			    queue);
 		xsk_pool_set_rxq_info(rx_q->xsk_pool, &rx_q->xdp_rxq);
 	} else {
 		WARN_ON(xdp_rxq_info_reg_mem_model(&rx_q->xdp_rxq,
@@ -1910,7 +1910,7 @@ static int __init_dma_rx_desc_rings(struct stmmac_priv *priv,
 						   rx_q->page_pool));
 		netdev_info(priv->dev,
 			    "Register MEM_TYPE_PAGE_POOL RxQ-%d\n",
-			    rx_q->queue_index);
+			    queue);
 	}
 
 	if (rx_q->xsk_pool) {
@@ -2310,9 +2310,7 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
 	else
 		napi_id = ch->rx_napi.napi_id;
 
-	ret = xdp_rxq_info_reg(&rx_q->xdp_rxq, priv->dev,
-			       rx_q->queue_index,
-			       napi_id);
+	ret = xdp_rxq_info_reg(&rx_q->xdp_rxq, priv->dev, queue, napi_id);
 	if (ret) {
 		netdev_err(priv->dev, "Failed to register xdp rxq info\n");
 		return -EINVAL;
@@ -3340,7 +3338,7 @@ static void stmmac_tx_timer_arm(struct stmmac_priv *priv, u32 queue)
 	if (!tx_coal_timer)
 		return;
 
-	ch = &priv->channel[tx_q->queue_index];
+	ch = &priv->channel[queue];
 	napi = tx_q->xsk_pool ? &ch->rxtx_napi : &ch->tx_napi;
 
 	/* Arm timer only if napi is not already scheduled.
@@ -6918,12 +6916,11 @@ void stmmac_enable_rx_queue(struct stmmac_priv *priv, u32 queue)
 	stmmac_clear_rx_descriptors(priv, &priv->dma_conf, queue);
 
 	stmmac_init_rx_chan(priv, priv->ioaddr, priv->plat->dma_cfg,
-			    rx_q->dma_rx_phy, rx_q->queue_index);
+			    rx_q->dma_rx_phy, queue);
 
-	stmmac_set_queue_rx_tail_ptr(priv, rx_q, rx_q->queue_index,
-				     rx_q->buf_alloc_num);
+	stmmac_set_queue_rx_tail_ptr(priv, rx_q, queue, rx_q->buf_alloc_num);
 
-	stmmac_set_queue_rx_buf_size(priv, rx_q, rx_q->queue_index);
+	stmmac_set_queue_rx_buf_size(priv, rx_q, queue);
 
 	stmmac_start_rx_dma(priv, queue);
 
@@ -6969,12 +6966,12 @@ void stmmac_enable_tx_queue(struct stmmac_priv *priv, u32 queue)
 	stmmac_clear_tx_descriptors(priv, &priv->dma_conf, queue);
 
 	stmmac_init_tx_chan(priv, priv->ioaddr, priv->plat->dma_cfg,
-			    tx_q->dma_tx_phy, tx_q->queue_index);
+			    tx_q->dma_tx_phy, queue);
 
 	if (tx_q->tbs & STMMAC_TBS_AVAIL)
-		stmmac_enable_tbs(priv, priv->ioaddr, 1, tx_q->queue_index);
+		stmmac_enable_tbs(priv, priv->ioaddr, 1, queue);
 
-	stmmac_set_queue_tx_tail_ptr(priv, tx_q, tx_q->queue_index, 0);
+	stmmac_set_queue_tx_tail_ptr(priv, tx_q, queue, 0);
 
 	stmmac_start_tx_dma(priv, queue);
 
-- 
2.47.3


