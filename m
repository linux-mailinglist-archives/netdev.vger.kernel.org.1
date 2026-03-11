Return-Path: <netdev+bounces-266581-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPwqIK1DsWlCtAIAu9opvQ
	(envelope-from <netdev+bounces-266581-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:27:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2A626225B
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF7813214349
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BDA363C5F;
	Wed, 11 Mar 2026 09:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0bnLBFz/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0783E36A03F;
	Wed, 11 Mar 2026 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222786; cv=none; b=FgmHfMaqwCWC2dj+YFdI46Z99fkDSDGM0kYTTjmnqgKjBM7l6+8Ee6V7pWhLcPIUKMtaxfZJAQqvzpkZVe9D8+SPj6vwzCe/ozMZuQPCJGxdp0PasdmDz1MYs1RTkGx4m+Ztm2iD8PWGKjPm96yMDpERIEIYqMadFalqRNBo5pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222786; c=relaxed/simple;
	bh=qauPWm0kegPc1QpX3dign6DrReUmmSOhhDeXniOgTNY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=rmKOwIKKqZbpVKdZTnZXWW2hcdS8cfXoY1TyuzuchMY39GrMhrTByjsVm8h5VXixqHEzkPkLWDg5x18PZPCKV2iAmhFloV4DpGtS8yqie9NQI4jx/A38eFuZBx7jLjhXdzh/yDRV6ojFr76K386oQskScu9Ec7Eim8+J7MaPz7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0bnLBFz/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SuiBWL9slWFfLdMK78HlbHZtxacsYxcx6jOQkgQ83JU=; b=0bnLBFz/Nk8gr4e9CsFATeCjgL
	61ovWqyja4T92DhnQalRFx1G9ua2srpEp75Uu9woBqZIUgCwHP1nAJQpqvn1Za9Xad7xk5TTRokXM
	1WyBk+4FntxJN1caECwlH5D2yUFG9GXcrHkt0b2/HIHdyZsxUT0qvo+t6NKWo8UrKkyzGNXlTEO4O
	+y/NitKFgv8ar3Kt+JWVygdq+FvcV+X2wL8SSf9BcRn6m79uWgciLC3ILWc2XQrpFEjWgt5uC5/A6
	sPHr3GNBTBTpG5VSMLw4Lve4+i3q4SErDfo6CJiSEETuoxl9dCJjYFRd6S0QY56UsBLn+NbhmRm+r
	P87ZJxWw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42718 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w0GFK-00000000694-20UR;
	Wed, 11 Mar 2026 09:52:54 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w0GFG-0000000CiTP-1EJi;
	Wed, 11 Mar 2026 09:52:50 +0000
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
Subject: [PATCH net-next 09/15] net: stmmac: add helper to set receive buffer
 size
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w0GFG-0000000CiTP-1EJi@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 11 Mar 2026 09:52:50 +0000
X-Rspamd-Queue-Id: 2D2A626225B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266581-lists,netdev=lfdr.de,kernel];
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
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,rmk-PC.armlinux.org.uk:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

There are three sites that configure the hardware for the receive
buffer size using the same logic to determine the buffer size.
Add a helper so there is only one copy of this code.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 54 ++++++++-----------
 1 file changed, 21 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 787b02c2607a..47b536c15c0e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -393,6 +393,24 @@ static void stmmac_set_queue_rx_tail_ptr(struct stmmac_priv *priv,
 	stmmac_set_rx_tail_ptr(priv, priv->ioaddr, rx_tail_addr, chan);
 }
 
+static void stmmac_set_queue_rx_buf_size(struct stmmac_priv *priv,
+					 struct stmmac_rx_queue *rx_q,
+					 unsigned int chan)
+{
+	u32 buf_size;
+
+	if (rx_q->xsk_pool && rx_q->buf_alloc_num) {
+		buf_size = xsk_pool_get_rx_frame_size(rx_q->xsk_pool);
+		stmmac_set_dma_bfsize(priv, priv->ioaddr,
+				      buf_size,
+				      rx_q->queue_index);
+	} else {
+		stmmac_set_dma_bfsize(priv, priv->ioaddr,
+				      priv->dma_conf.dma_buf_sz,
+				      rx_q->queue_index);
+	}
+}
+
 /**
  * stmmac_rx_dirty - Get RX queue dirty
  * @priv: driver private structure
@@ -2605,23 +2623,13 @@ static void stmmac_dma_operation_mode(struct stmmac_priv *priv)
 	/* configure all channels */
 	for (chan = 0; chan < rx_channels_count; chan++) {
 		struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[chan];
-		u32 buf_size;
 
 		qmode = priv->plat->rx_queues_cfg[chan].mode_to_use;
 
 		stmmac_dma_rx_mode(priv, priv->ioaddr, rxmode, chan,
 				rxfifosz, qmode);
 
-		if (rx_q->xsk_pool && rx_q->buf_alloc_num) {
-			buf_size = xsk_pool_get_rx_frame_size(rx_q->xsk_pool);
-			stmmac_set_dma_bfsize(priv, priv->ioaddr,
-					      buf_size,
-					      chan);
-		} else {
-			stmmac_set_dma_bfsize(priv, priv->ioaddr,
-					      priv->dma_conf.dma_buf_sz,
-					      chan);
-		}
+		stmmac_set_queue_rx_buf_size(priv, rx_q, chan);
 	}
 
 	for (chan = 0; chan < tx_channels_count; chan++) {
@@ -6935,7 +6943,6 @@ void stmmac_enable_rx_queue(struct stmmac_priv *priv, u32 queue)
 	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
 	struct stmmac_channel *ch = &priv->channel[queue];
 	unsigned long flags;
-	u32 buf_size;
 	int ret;
 
 	ret = __alloc_dma_rx_desc_resources(priv, &priv->dma_conf, queue);
@@ -6960,16 +6967,7 @@ void stmmac_enable_rx_queue(struct stmmac_priv *priv, u32 queue)
 	stmmac_set_queue_rx_tail_ptr(priv, rx_q, rx_q->queue_index,
 				     rx_q->buf_alloc_num);
 
-	if (rx_q->xsk_pool && rx_q->buf_alloc_num) {
-		buf_size = xsk_pool_get_rx_frame_size(rx_q->xsk_pool);
-		stmmac_set_dma_bfsize(priv, priv->ioaddr,
-				      buf_size,
-				      rx_q->queue_index);
-	} else {
-		stmmac_set_dma_bfsize(priv, priv->ioaddr,
-				      priv->dma_conf.dma_buf_sz,
-				      rx_q->queue_index);
-	}
+	stmmac_set_queue_rx_buf_size(priv, rx_q, rx_q->queue_index);
 
 	stmmac_start_rx_dma(priv, queue);
 
@@ -7072,7 +7070,6 @@ int stmmac_xdp_open(struct net_device *dev)
 	u8 dma_csr_ch = max(rx_cnt, tx_cnt);
 	struct stmmac_rx_queue *rx_q;
 	struct stmmac_tx_queue *tx_q;
-	u32 buf_size;
 	bool sph_en;
 	u8 chan;
 	int ret;
@@ -7112,16 +7109,7 @@ int stmmac_xdp_open(struct net_device *dev)
 		stmmac_set_queue_rx_tail_ptr(priv, rx_q, chan,
 					     rx_q->buf_alloc_num);
 
-		if (rx_q->xsk_pool && rx_q->buf_alloc_num) {
-			buf_size = xsk_pool_get_rx_frame_size(rx_q->xsk_pool);
-			stmmac_set_dma_bfsize(priv, priv->ioaddr,
-					      buf_size,
-					      rx_q->queue_index);
-		} else {
-			stmmac_set_dma_bfsize(priv, priv->ioaddr,
-					      priv->dma_conf.dma_buf_sz,
-					      rx_q->queue_index);
-		}
+		stmmac_set_queue_rx_buf_size(priv, rx_q, chan);
 
 		stmmac_enable_sph(priv, priv->ioaddr, sph_en, chan);
 	}
-- 
2.47.3


