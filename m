Return-Path: <netdev+bounces-269152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHkCJA3wumkfdQIAu9opvQ
	(envelope-from <netdev+bounces-269152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 19:33:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A282C158E
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 19:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F1D132013DC
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 18:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264CE3D333D;
	Wed, 18 Mar 2026 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UFKrgh4/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D10F3CE4A3
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 18:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773858413; cv=none; b=TBfo90ztp2jGZy4a/Jc8VGHM1CMQNULPj2ErKO5SVbm1Dov3n/I5NIMFXpyuBgdl9P8Zv2JlQk7asEdn+KlLQmCG7SpkuDICwnp0ScvgLmeId/QusGBL88dUaaN9VqTQjxHkyngmmyCp3FQTTBnMpkoxIFTWIkaicp/SiG/zPDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773858413; c=relaxed/simple;
	bh=t/ZLiFEx4OCGyooC2tpdu3HxovcaNCR7f8jYfgt4u7I=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=pGggYXtOhb3felODA4MHdaave1gVEx8jJEWP4gJELKxXgvP6wDdCMVq7mAL93eAffkDkn+OjMWxV4TXC0gZC+PdXlaemJ1BFBNBGDldDoC31ZP4owx83ngUYAZJmdNROZlrkR5M1IQqtyEz/USdlHz1y6cXtmrepSZePqd1614U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=UFKrgh4/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fvhhv7MIWMegmnz4QXxXkxWDldAObm8AahQjpmMTPy8=; b=UFKrgh4/dGkHv3DqRzbF2Q09ao
	OErSkJwUIa8beFUyVkpbmjC3r+aHHBQKi3fFeAi73kk7BaxRGSH3uhEKIxDbTgVcrLcZshqGS+pi4
	im5rb99PB4rX6D2P5i9PHQOwDJNs3F85B11k6SKSdY1zCD2LTsjMCIEUOQuGxGKB6oCczGkXI6w4p
	eNugQtcRNbUFGvr4Rr8czBppP7UH99EC3U/wETPufwtXVPWJu6B3c2VyBsEiyGzTfYtgbsEE/4Z2V
	9OlT/8y9EFXe9LJOwcOAgUqgV6aG2SIZ3Y3mgFRwdh2rpTxxmfs+3zw1IWMbp1z1CgTLm9vxB+Ib1
	xz8zAogQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44962 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w2vbQ-000000003pW-3uXk;
	Wed, 18 Mar 2026 18:26:44 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w2vbQ-0000000DbWc-0ty5;
	Wed, 18 Mar 2026 18:26:44 +0000
In-Reply-To: <abruRQpjLyMkoUEP@shell.armlinux.org.uk>
References: <abruRQpjLyMkoUEP@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 3/5] net: stmmac: simplify DMA descriptor
 allocation/init/freeing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w2vbQ-0000000DbWc-0ty5@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 18 Mar 2026 18:26:44 +0000
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269152-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.565];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 00A282C158E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rather than having separate branches to handle the different types of
descriptors, use the helper functions to calculate the total size of
the DMA descriptors.

Use this to allocate or free the descriptor array, and use a local
variable to hold the address of the descriptor array, so we only need
one dma_alloc_coherent() or dma_free_coherent() call in these paths.

Also do the same for the receive ring initialisation. The transmit
ring can't be converted as there is a case where stmmac_mode_init()
is not called.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 57 +++++++++----------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 567499e74917..8a84fdd4577d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1885,6 +1885,7 @@ static int __init_dma_rx_desc_rings(struct stmmac_priv *priv,
 				    u32 queue, gfp_t flags)
 {
 	struct stmmac_rx_queue *rx_q = &dma_conf->rx_queue[queue];
+	void *des;
 	int ret;
 
 	netif_dbg(priv, probe, priv->dev,
@@ -1928,13 +1929,12 @@ static int __init_dma_rx_desc_rings(struct stmmac_priv *priv,
 	/* Setup the chained descriptor addresses */
 	if (priv->descriptor_mode == STMMAC_CHAIN_MODE) {
 		if (priv->extend_desc)
-			stmmac_mode_init(priv, rx_q->dma_erx,
-					 rx_q->dma_rx_phy,
-					 dma_conf->dma_rx_size, 1);
+			des = rx_q->dma_erx;
 		else
-			stmmac_mode_init(priv, rx_q->dma_rx,
-					 rx_q->dma_rx_phy,
-					 dma_conf->dma_rx_size, 0);
+			des = rx_q->dma_rx;
+
+		stmmac_mode_init(priv, des, rx_q->dma_rx_phy,
+				 dma_conf->dma_rx_size, priv->extend_desc);
 	}
 
 	return 0;
@@ -2148,6 +2148,8 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
 					 u32 queue)
 {
 	struct stmmac_rx_queue *rx_q = &dma_conf->rx_queue[queue];
+	size_t size;
+	void *addr;
 
 	/* Release the DMA RX socket buffers */
 	if (rx_q->xsk_pool)
@@ -2159,14 +2161,14 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
 	rx_q->xsk_pool = NULL;
 
 	/* Free DMA regions of consistent memory previously allocated */
-	if (!priv->extend_desc)
-		dma_free_coherent(priv->device, dma_conf->dma_rx_size *
-				  sizeof(struct dma_desc),
-				  rx_q->dma_rx, rx_q->dma_rx_phy);
+	if (priv->extend_desc)
+		addr = rx_q->dma_erx;
 	else
-		dma_free_coherent(priv->device, dma_conf->dma_rx_size *
-				  sizeof(struct dma_extended_desc),
-				  rx_q->dma_erx, rx_q->dma_rx_phy);
+		addr = rx_q->dma_rx;
+
+	size = stmmac_get_rx_desc_size(priv) * dma_conf->dma_rx_size;
+
+	dma_free_coherent(priv->device, size, addr, rx_q->dma_rx_phy);
 
 	if (xdp_rxq_info_is_reg(&rx_q->xdp_rxq))
 		xdp_rxq_info_unreg(&rx_q->xdp_rxq);
@@ -2251,6 +2253,8 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
 	struct page_pool_params pp_params = { 0 };
 	unsigned int dma_buf_sz_pad, num_pages;
 	unsigned int napi_id;
+	size_t size;
+	void *addr;
 	int ret;
 
 	dma_buf_sz_pad = stmmac_rx_offset(priv) + dma_conf->dma_buf_sz +
@@ -2286,24 +2290,17 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
 	if (!rx_q->buf_pool)
 		return -ENOMEM;
 
-	if (priv->extend_desc) {
-		rx_q->dma_erx = dma_alloc_coherent(priv->device,
-						   dma_conf->dma_rx_size *
-						   sizeof(struct dma_extended_desc),
-						   &rx_q->dma_rx_phy,
-						   GFP_KERNEL);
-		if (!rx_q->dma_erx)
-			return -ENOMEM;
+	size = stmmac_get_rx_desc_size(priv) * dma_conf->dma_rx_size;
 
-	} else {
-		rx_q->dma_rx = dma_alloc_coherent(priv->device,
-						  dma_conf->dma_rx_size *
-						  sizeof(struct dma_desc),
-						  &rx_q->dma_rx_phy,
-						  GFP_KERNEL);
-		if (!rx_q->dma_rx)
-			return -ENOMEM;
-	}
+	addr = dma_alloc_coherent(priv->device, size, &rx_q->dma_rx_phy,
+				  GFP_KERNEL);
+	if (!addr)
+		return -ENOMEM;
+
+	if (priv->extend_desc)
+		rx_q->dma_erx = addr;
+	else
+		rx_q->dma_rx = addr;
 
 	if (stmmac_xdp_is_enabled(priv) &&
 	    test_bit(queue, priv->af_xdp_zc_qps))
-- 
2.47.3


