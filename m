Return-Path: <netdev+bounces-272828-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLveFylKyGlVjgUAu9opvQ
	(envelope-from <netdev+bounces-272828-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 22:37:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC933500B1
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 22:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C3E3301DCCA
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 21:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3EF341ADF;
	Sat, 28 Mar 2026 21:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="N8ybQIPR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE797371D0F
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 21:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774733844; cv=none; b=p1KG5diZYHXspI4h/J6oVqKiaeJG7VSmHcnesumgA7GWSuqz6tQQmym6MVE70rVyf62UUzC3SthfdnMedqJ6zHopRcrRwX8YvvXYoLjkdQUKx6p1Vd7nfKIaK7BQggoQ1IEJOLgsKcwola2YZlVVpWSvNZgUC1oVaYb8ptB2l64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774733844; c=relaxed/simple;
	bh=csyPmKCcs0SENs+UgM81qgrqbA4i9Kz7T834OM4Gf2g=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=PA3depfoYMR5uA5/ftCVmD2wXOAKXDnjNzTV82tV/+os3+6lZ0x6DC0MWeJsL+jpgkyHCqmKuXA4/sc6RSnQj2kdXRQbf0aHcxzmLKHTUwQbXxZwmfmrxbLCUINv7nLovLBSMIlnolRt4z9uoVCaZIdOTjbu9TrltjUFK3hG9I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=N8ybQIPR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=e+VhMvWWWb7bM8h9ezDsK92nJiBl8kA77NkPPrUcrAQ=; b=N8ybQIPRJ0V+m7B1JqpTX99Iss
	rbuf3liaMJ3DM9FggJJfs/56afmb+ZJpOBEsnGvldXouWLqe4My5fh5s756lajIQ5PRACvqigw8Go
	bp5lyowMYyyepIVHwAf625WbAgGxtNQZeSOZj5fcWH0P87D4XZJgsNm5pG2Hj7IwoIlieWfL+I8fp
	9XLRzB9QWi7I6yw0RKJm7U6h2GVy+Yq+/4F05AazoANJuBOaXkkW4ob5oPSodd7luQ3joHRUPlCzH
	Hn6Cmm7jmdYQvz9ETRQlIvGGhhqM+2xKCy8/bKO3ia6TGZwnYMXOl3NNM1RFfUh51zNs/VY1ML0f6
	kOvdXDcA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43636 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w6bLF-000000007TH-3zwj;
	Sat, 28 Mar 2026 21:37:14 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w6bLE-0000000ELuF-2Lpi;
	Sat, 28 Mar 2026 21:37:12 +0000
In-Reply-To: <achJ1dfeT6Q8rBuX@shell.armlinux.org.uk>
References: <achJ1dfeT6Q8rBuX@shell.armlinux.org.uk>
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
	Ong Boon Leong <boon.leong.ong@intel.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 07/10] net: stmmac: split out gso features setup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w6bLE-0000000ELuF-2Lpi@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sat, 28 Mar 2026 21:37:12 +0000
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272828-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,rmk-PC.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BBC933500B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move the GSO features setup into a separate function, co-loated with
other GSO/TSO support.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 21 ++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 8991da2f96a9..4442358e8280 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4381,6 +4381,19 @@ static void stmmac_set_gso_types(struct stmmac_priv *priv, bool tso)
 	}
 }
 
+static void stmmac_set_gso_features(struct net_device *ndev)
+{
+	struct stmmac_priv *priv = netdev_priv(ndev);
+
+	if ((priv->plat->flags & STMMAC_FLAG_TSO_EN) && (priv->dma_cap.tsoen)) {
+		ndev->hw_features |= NETIF_F_TSO | NETIF_F_TSO6;
+		if (priv->plat->core_type == DWMAC_CORE_GMAC4)
+			ndev->hw_features |= NETIF_F_GSO_UDP_L4;
+		stmmac_set_gso_types(priv, true);
+		dev_info(priv->device, "TSO feature enabled\n");
+	}
+}
+
 /**
  *  stmmac_tso_xmit - Tx entry point of the driver for oversized frames (TSO)
  *  @skb : the socket buffer
@@ -7865,13 +7878,7 @@ static int __stmmac_dvr_probe(struct device *device,
 		ndev->hw_features |= NETIF_F_HW_TC;
 	}
 
-	if ((priv->plat->flags & STMMAC_FLAG_TSO_EN) && (priv->dma_cap.tsoen)) {
-		ndev->hw_features |= NETIF_F_TSO | NETIF_F_TSO6;
-		if (priv->plat->core_type == DWMAC_CORE_GMAC4)
-			ndev->hw_features |= NETIF_F_GSO_UDP_L4;
-		stmmac_set_gso_types(priv, true);
-		dev_info(priv->device, "TSO feature enabled\n");
-	}
+	stmmac_set_gso_features(ndev);
 
 	if (priv->dma_cap.sphen &&
 	    !(priv->plat->flags & STMMAC_FLAG_SPH_DISABLE)) {
-- 
2.47.3


