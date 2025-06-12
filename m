Return-Path: <netdev+bounces-197057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68237AD76EE
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F0F3B5171
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3174B29B771;
	Thu, 12 Jun 2025 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sHIPscLD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F56029B229
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742931; cv=none; b=bKJTnN1YZwqvCInJ41IvmVRfoRmPm5edjzqQsgRRV0zPnnDSLxyAjibUF3RYPg9xRuCkmRue7mYyfhHdY4k7veq5GTN7CpshJH019RYLwMmjdehdmhii1/60Uy6KVvMwwd5kFJKA8eKlMsYs5MkPwAR7uXQzxGrn71tk963Krmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742931; c=relaxed/simple;
	bh=Ulav5/5Iy4XDs9ZWDSvI4lCKxv6U9G+15D6HzVEjLUk=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Ecxp1SiI2cKozfWPWVIndVhSRgzKreJfY53WKbwlUTzPgyLWOLjophsYLlQmMSlz9tVcQnpDbethIhDIBeEFfNeiNwrUL9OA+Q5/bnXQUSG+Q32N+kishN4zwPEb6fqqrmsfTpCxpqYh+EvOp4EgyAx7pdssg7kX47SpllpfSu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sHIPscLD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cZnvOnHtbSmTRkDQY5OMcUHswqrZh6xf9n5dNyGk7Nw=; b=sHIPscLDJe2PxlFKqqldN0N61g
	9eMwdItQ/K45eKRVOY9dFpQYtJYYO6gHd6+qgOD4kbdXK0fxqMRvX9kt0bQiIE2cuSKLJaBxaDchy
	YauesJ/+zfnj+mr6OuJ4fJ7kk9cZOcEKDJyxveXbeQ2Rxvau7NNTYQBoRlcTdgNd3f335LmmNCBXp
	YtB0ImDWdzH87emHvyHdeCati/P/swpV0q3xhbe5OpnFbpfxLmrMu2LPLB7lnFjLsCKGzD4bLAvw9
	vSS1RHTq3OQ2CX8wQ92N3s7OICM48tcD3GSoZaVjWZ/WG65b3h4qjLMnbkbCJ3KJDgwZWyWv9SlCh
	6P2jOglg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44308 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uPk42-00085O-2N;
	Thu, 12 Jun 2025 16:42:02 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uPk3O-004CFx-Ir; Thu, 12 Jun 2025 16:41:22 +0100
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
Subject: [PATCH net-next 9/9] net: stmmac: rk: remove obsolete .set_*_speed()
 methods
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uPk3O-004CFx-Ir@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 12 Jun 2025 16:41:22 +0100

Now that no SoC implements the .set_*_speed() methods, we can get rid
of these methods and the now unused code in rk_set_clk_tx_rate().
Arrange for the function to return an error when the .set_speed()
method is not implemented.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 21 +------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 7cdb09037da0..18ae12df4a85 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -37,8 +37,6 @@ struct rk_gmac_ops {
 	void (*set_to_rgmii)(struct rk_priv_data *bsp_priv,
 			     int tx_delay, int rx_delay);
 	void (*set_to_rmii)(struct rk_priv_data *bsp_priv);
-	void (*set_rgmii_speed)(struct rk_priv_data *bsp_priv, int speed);
-	void (*set_rmii_speed)(struct rk_priv_data *bsp_priv, int speed);
 	int (*set_speed)(struct rk_priv_data *bsp_priv,
 			 phy_interface_t interface, int speed);
 	void (*set_clock_selection)(struct rk_priv_data *bsp_priv, bool input,
@@ -1707,29 +1705,12 @@ static int rk_set_clk_tx_rate(void *bsp_priv_, struct clk *clk_tx_i,
 			      phy_interface_t interface, int speed)
 {
 	struct rk_priv_data *bsp_priv = bsp_priv_;
-	struct device *dev = &bsp_priv->pdev->dev;
 
 	if (bsp_priv->ops->set_speed)
 		return bsp_priv->ops->set_speed(bsp_priv, bsp_priv->phy_iface,
 						speed);
 
-	switch (bsp_priv->phy_iface) {
-	case PHY_INTERFACE_MODE_RGMII:
-	case PHY_INTERFACE_MODE_RGMII_ID:
-	case PHY_INTERFACE_MODE_RGMII_RXID:
-	case PHY_INTERFACE_MODE_RGMII_TXID:
-		if (bsp_priv->ops->set_rgmii_speed)
-			bsp_priv->ops->set_rgmii_speed(bsp_priv, speed);
-		break;
-	case PHY_INTERFACE_MODE_RMII:
-		if (bsp_priv->ops->set_rmii_speed)
-			bsp_priv->ops->set_rmii_speed(bsp_priv, speed);
-		break;
-	default:
-		dev_err(dev, "unsupported interface %d", bsp_priv->phy_iface);
-	}
-
-	return 0;
+	return -EINVAL;
 }
 
 static int rk_gmac_probe(struct platform_device *pdev)
-- 
2.30.2


