Return-Path: <netdev+bounces-197052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D34AD76C9
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9532218888C6
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7777429AAEF;
	Thu, 12 Jun 2025 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GdOcwzr1"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF63D1D63E4
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742906; cv=none; b=J61m2QxIHepVeglKLfY5eslm48+Q3VxI7jqTecSP1NslekvxYb93unG3PCzc6iB145/VcjFctl58esffRgwWQVDDeh81Jz/ygpXB5kZojqeGYLqpbBwLz8mvf1DPlIn3CZhTl2QAEQ39V3aKIt5G4zA8zY6lmka7qPtrnTPA+D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742906; c=relaxed/simple;
	bh=QuETsY35D8k8X5ImJccG7DRoXWlk7CXKtJRv7kdFOXA=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=DD+LiFnTnBCyg0SUTkv69cLlScqO9rCmQ2w6zbvIBCr2p6bPtOLaMKkSd3TxVWt3Hevn1rdlOumTQRjDe+Upr2liZvxMib5pDluEs29hFKaK+5I4iZ5pH66ws9GNp/qB6OkYHYFvCLI91EPAtZy1O2sQBYc/w0whTt4OvCQ5y2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=GdOcwzr1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=64CpcFM6H4Vg52rc57aO+fncDZ9t6GSrZTLajMibm0A=; b=GdOcwzr1kJJxKsUOvBySQ2rKLK
	3jOiO26DYmylhL3sbABgwpnvvuxsqzd+zT/lhEr1ftyIaSx0HUA16mMV1ek2b1olV3RomKEF/6LfU
	xZv3fIAdSPLjVLJY73nnx4L+RAydUbE9X7UITyN6FCVf4OpWEsnrU1NRPaY3et3dAAQh03fmQKJHe
	wfRlt6hqi3/aGDhKXI9ThEDO6Yext49HvEJDh43CvFNO13+GlTlgbqR4qD4GemX4Y5SH933nnrDwT
	plg61K4WUgFU9rrvqxbRg2Q2jB+hpe+P6Nm6ONvBSxlKDqEhkTxfHo/zxYAD13D9xL6vikBYNbvly
	8KXBzgtw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38864 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uPk3d-000846-18;
	Thu, 12 Jun 2025 16:41:37 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uPk2z-004CFT-0e; Thu, 12 Jun 2025 16:40:57 +0100
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
Subject: [PATCH net-next 4/9] net: stmmac: rk: combine rv1126 set_*_speed()
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
Message-Id: <E1uPk2z-004CFT-0e@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 12 Jun 2025 16:40:57 +0100

Just like rk3568, there is no need to have separate RGMII and RMII
methods to set clk_mac_speed() as rgmii_clock() can be used to return
the clock rate for both RGMII and RMII interface modes. Combine these
two methods.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 33 +++----------------
 1 file changed, 4 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 7b5e989bb77f..c7b64f0a2931 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1496,7 +1496,7 @@ static void rv1126_set_to_rmii(struct rk_priv_data *bsp_priv)
 		     RV1126_GMAC_PHY_INTF_SEL_RMII);
 }
 
-static void rv1126_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
+static void rv1126_set_clk_mac_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct clk *clk_mac_speed = bsp_priv->clks[RK_CLK_MAC_SPEED].clk;
 	struct device *dev = &bsp_priv->pdev->dev;
@@ -1505,32 +1505,7 @@ static void rv1126_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 
 	rate = rgmii_clock(speed);
 	if (rate < 0) {
-		dev_err(dev, "unknown speed value for RGMII speed=%d", speed);
-		return;
-	}
-
-	ret = clk_set_rate(clk_mac_speed, rate);
-	if (ret)
-		dev_err(dev, "%s: set clk_mac_speed rate %ld failed %d\n",
-			__func__, rate, ret);
-}
-
-static void rv1126_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
-{
-	struct clk *clk_mac_speed = bsp_priv->clks[RK_CLK_MAC_SPEED].clk;
-	struct device *dev = &bsp_priv->pdev->dev;
-	unsigned long rate;
-	int ret;
-
-	switch (speed) {
-	case 10:
-		rate = 2500000;
-		break;
-	case 100:
-		rate = 25000000;
-		break;
-	default:
-		dev_err(dev, "unknown speed value for RGMII speed=%d", speed);
+		dev_err(dev, "unknown speed value for GMAC speed=%d", speed);
 		return;
 	}
 
@@ -1543,8 +1518,8 @@ static void rv1126_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 static const struct rk_gmac_ops rv1126_ops = {
 	.set_to_rgmii = rv1126_set_to_rgmii,
 	.set_to_rmii = rv1126_set_to_rmii,
-	.set_rgmii_speed = rv1126_set_rgmii_speed,
-	.set_rmii_speed = rv1126_set_rmii_speed,
+	.set_rgmii_speed = rv1126_set_clk_mac_speed,
+	.set_rmii_speed = rv1126_set_clk_mac_speed,
 };
 
 static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
-- 
2.30.2


