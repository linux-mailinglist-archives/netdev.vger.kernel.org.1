Return-Path: <netdev+bounces-197049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C47BCAD76C5
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61DA2162818
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7ED6299A8A;
	Thu, 12 Jun 2025 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bDhoMlmX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C6E1D63E4
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742890; cv=none; b=aMFnFOpXOMmda85q63QPhKFPm0N9XPAP5xXfZDFLZkj6vo0RRjIRJdEOTGUOxNpy6JQ7Pz/WWJ1wBvgFXpRsQz3ajsHSSziXOjmIBDchXx1YNiYeI1g4jYoyJMsd9tz6DW7tAMiq2P8HYtbY9InaDoOMXSrLUtoPofnjCaVYGjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742890; c=relaxed/simple;
	bh=qOmqbPKVlkZFoXH6qOYIx76ZCvMhL4wi9LJYTF34Jts=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=KF1ojIaDQbjBmF4u0dXcsgE6eJj6Ce0x1/c+518PNM8EK3pYQoEZxUq9INqjhHwP4C2xc6UAU45aValeP80IjJipwmczSwHvLChy509t6Xz/pkRsGdwQx7djjauQk3xchACNdx33e3svl7X9FLbnwCgb3e8RQzfiVPGFRvq1YtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bDhoMlmX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fwZMOCKfFBVS4iHJPXuDmlM3/1DaYJO0eDoSHbqPtEo=; b=bDhoMlmXYyIkOs26G3MwkhL1SC
	cFTGPHUv+linbYI4GJOTg26WIkzaHxHNzrNaf3lVXIv1J8xkwcQZQQp/dENLnqnYj1epPq/DjSoM1
	NbCTaEKrW6A8R/qare0T8ddvIqepAlSm3VecKPjUcIChlXkyNonzsWU5isyctiEu03990wzyOw1aL
	V+cVjVZ/z2aaLq1bkMzh0b4t6eTwMOMJQv913H3TQ3mC8LRk+3CCAOjGs3ndFd51+RRGmfQ0qdbbm
	qY1TH9dP2LB+ch8frqPfHBP6T/2hT/0umPYAeyHR1IVGAT3DHTw3tpEW+MuwfPpwx/xEmtCYwpZHm
	vm8UD7iA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60382 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uPk3N-00083N-2Q;
	Thu, 12 Jun 2025 16:41:21 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uPk2j-004CF6-Mf; Thu, 12 Jun 2025 16:40:41 +0100
In-Reply-To: <aEr1BhIoC6-UM2XV@shell.armlinux.org.uk>
References: <aEr1BhIoC6-UM2XV@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 1/9] net: stmmac: rk: add get_interfaces()
 implementation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uPk2j-004CF6-Mf@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 12 Jun 2025 16:40:41 +0100

RK platforms support RGMII and/or RMII depending on the SoC. Detect
whether support for a SoC exists by whether the interface specific
set_to functions have been populated, and set the appropriate bits in
phylink's bitmap of interfaces.

This assumes all dwmac interfaces on a SoC have identical support,
but it should be noted that this is not true for RK3528 which only
supports RGMII on GMAC1. However, the existing code structure
permits RGMII to be configured on GMAC0 without complaint, so
preserve this behaviour even though it is incorrect to avoid
functional change.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 700858ff6f7c..8006424ab027 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1864,6 +1864,18 @@ static void rk_gmac_powerdown(struct rk_priv_data *gmac)
 	gmac_clk_enable(gmac, false);
 }
 
+static void rk_get_interfaces(struct stmmac_priv *priv, void *bsp_priv,
+			      unsigned long *interfaces)
+{
+	struct rk_priv_data *rk = bsp_priv;
+
+	if (rk->ops->set_to_rgmii)
+		phy_interface_set_rgmii(interfaces);
+
+	if (rk->ops->set_to_rmii)
+		__set_bit(PHY_INTERFACE_MODE_RMII, interfaces);
+}
+
 static int rk_set_clk_tx_rate(void *bsp_priv_, struct clk *clk_tx_i,
 			      phy_interface_t interface, int speed)
 {
@@ -1919,6 +1931,7 @@ static int rk_gmac_probe(struct platform_device *pdev)
 		plat_dat->tx_fifo_size = 2048;
 	}
 
+	plat_dat->get_interfaces = rk_get_interfaces;
 	plat_dat->set_clk_tx_rate = rk_set_clk_tx_rate;
 
 	plat_dat->bsp_priv = rk_gmac_setup(pdev, plat_dat, data);
-- 
2.30.2


