Return-Path: <netdev+bounces-267370-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uA/VDQ7gs2ktcQAAu9opvQ
	(envelope-from <netdev+bounces-267370-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:59:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3EC281057
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4BB4325636B
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C0C3876CC;
	Fri, 13 Mar 2026 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UZxaPicK"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E07346760;
	Fri, 13 Mar 2026 09:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773395490; cv=none; b=iTobAzztKJJcsN/S9F8BiGi10mip32PNmGGDjy94hV3HssTzy7rSPtAJ6fVYW+3NNaIJ8XpwfEvrZGSI3lrdqSVbzhLzUH5t/WOlu5tu4jY+x8h+SW9kI8hgQxGWD9gouAQjW1vokKGWtw0bB9A00k1Gkl0RHXNt+ytZjWt6D4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773395490; c=relaxed/simple;
	bh=hD3sAe18nPWW8oxFsuxTzsfxHAjUYL2Cp4S10XNcD5s=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=NS9yjAun4XNLSZCg7L20dduYn6832mp8osYQuRK/2q49MReUGRP7qfv5h8aYEgXOovZAgV90zTWbmn6rRE0w2hJSw6ufAj0JXK/DDM2HMvyyqb5YYOk1ZyAT54QB83WysS7U0ITBLmC8PllI7nrJ+ZJ32u31D2xTAApGkQwqvxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=UZxaPicK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ImtxcwWXXJt6qxVXIbd5mh51lvJgGcYRDTbE+CXfQNQ=; b=UZxaPicK56GyZaL9/SlNYEQUYa
	JyEl5xWo47ir1fl7bemP4j1ynf4JovAH/l2+4KMhIaqN2IieTB4wepwVlKcPZKNzmYppb/nXe83qA
	4THTWL7TfiEe9maQmx6wFzltMXz+mnQa/foTwHShp4SR3mIOtu6yT0OmY+2No5pGsKAVJm3EA/rhe
	FIKky5iue6cV7G9hce8Z8QUriyNFDOyYL40p3tZThyst7lKSAOTLa4vJnlugxtzTwePCoSZGQjWwt
	Z9/fTOKnYBvZ7ovMd+6rUgTg9wO65xe3ehanaH9U3qiP/o38M+fay9Z1enLyXdg8e/g25JfSqqq+M
	V2hgK2ZA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33798 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w0zAy-000000000dT-2bfI;
	Fri, 13 Mar 2026 09:51:24 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w0zAx-0000000D4FM-0yS9;
	Fri, 13 Mar 2026 09:51:23 +0000
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
Subject: [PATCH net-next v3 05/15] net: stmmac: add helper to get size of a
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
Message-Id: <E1w0zAx-0000000D4FM-0yS9@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 13 Mar 2026 09:51:23 +0000
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267370-lists,netdev=lfdr.de,kernel];
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
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rmk-PC.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: CD3EC281057
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add and use a helper to get the size of the hardware receive
descriptor.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 24 +++++++++----------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a3dfd3501604..dca62e7b259a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -362,6 +362,14 @@ static inline u32 stmmac_tx_avail(struct stmmac_priv *priv, u32 queue)
 			  priv->dma_conf.dma_tx_size);
 }
 
+static size_t stmmac_get_rx_desc_size(struct stmmac_priv *priv)
+{
+	if (priv->extend_desc)
+		return sizeof(struct dma_extended_desc);
+	else
+		return sizeof(struct dma_desc);
+}
+
 static struct dma_desc *stmmac_get_rx_desc(struct stmmac_priv *priv,
 					   struct stmmac_rx_queue *rx_q,
 					   unsigned int index)
@@ -1432,10 +1440,7 @@ static void stmmac_display_rx_rings(struct stmmac_priv *priv,
 		pr_info("\tRX Queue %u rings\n", queue);
 
 		head_rx = stmmac_get_rx_desc(priv, rx_q, 0);
-		if (priv->extend_desc)
-			desc_size = sizeof(struct dma_extended_desc);
-		else
-			desc_size = sizeof(struct dma_desc);
+		desc_size = stmmac_get_rx_desc_size(priv);
 
 		/* Display RX ring */
 		stmmac_display_ring(priv, head_rx, dma_conf->dma_rx_size, true,
@@ -5412,11 +5417,7 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		void *rx_head = stmmac_get_rx_desc(priv, rx_q, 0);
 
 		netdev_dbg(priv->dev, "%s: descriptor ring:\n", __func__);
-		if (priv->extend_desc) {
-			desc_size = sizeof(struct dma_extended_desc);
-		} else {
-			desc_size = sizeof(struct dma_desc);
-		}
+		desc_size = stmmac_get_rx_desc_size(priv);
 
 		stmmac_display_ring(priv, rx_head, priv->dma_conf.dma_rx_size, true,
 				    rx_q->dma_rx_phy, desc_size);
@@ -5604,10 +5605,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		void *rx_head = stmmac_get_rx_desc(priv, rx_q, 0);
 
 		netdev_dbg(priv->dev, "%s: descriptor ring:\n", __func__);
-		if (priv->extend_desc)
-			desc_size = sizeof(struct dma_extended_desc);
-		else
-			desc_size = sizeof(struct dma_desc);
+		desc_size = stmmac_get_rx_desc_size(priv);
 
 		stmmac_display_ring(priv, rx_head, priv->dma_conf.dma_rx_size, true,
 				    rx_q->dma_rx_phy, desc_size);
-- 
2.47.3


