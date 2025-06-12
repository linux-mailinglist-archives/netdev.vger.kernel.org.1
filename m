Return-Path: <netdev+bounces-197051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA93AD76C8
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78366164659
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4566C21FF44;
	Thu, 12 Jun 2025 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NRqc1d0y"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B671D63E4
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742902; cv=none; b=BNp1S6q2XtZecgGeY2IIueqVC9sZRF22NgrA0A8rthD4nSEWEJKVnF2V5Imu1CNc6ybzH6A89DwJXUwTQvc6pBr6N8kRV8llV3Z2DZQyPEiF+GIs77E6nJuOui5rrY7fFhFCvvOlMXWJphl0A9Jxtza6aH3nEtJGZ9B7OyvyPTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742902; c=relaxed/simple;
	bh=zLOfc7ADLMocHKvd0F5hYEgE3aXxTENsX905vjZSAis=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=jGNMktHE2/8C5tptbzred1aT5Frg8AQ4A3ueMwM90tQTt9PvHDDNiYdOXnQPK3tM9T3TFWQK/X5O28HF1MCZu48s95IyvfOZcpwW74coAL65n8gM17uZ3QgHGdGfw/oW6rMhuExraGfST+ghbK2u7tYz9KkifvQo7c0Gl/oSAXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NRqc1d0y; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/FNcAziOrhOzllfFVnAeQaoJkj2U9zuddP9Mm5ujyIs=; b=NRqc1d0yVw+TitEVJKzF+qNlH1
	ihbXVCjwc6vueiy1SMoHLdhoFrJNIZIYmzqJNgtXdsFZZcKBxoDf6IMkiKk38BCDqbaVeEl/jzc93
	i4RYprpCyMp2g8aYmhEGwfuoSFkwv3RiRjIW/jpTH+6Hwmu9E2uMyxzn8Y1tUnPcWa1wa/epSPEbp
	bRMj+VVXiLBk5VWP6n3yxaMKH1rtSSImLZn7c8ExOpMXyBJnpGS1szPabRVg/WGpVdbfNDwwdlIx+
	MbUnN9R/3oHgyt/FVJf2MjpiSRM9vBsvpwrf9Y9gwbV4Y0wV6SenF7U+QfTf+mpbMYUXyufbI5Dwm
	pF1ABUtQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38862 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uPk3Y-00083q-06;
	Thu, 12 Jun 2025 16:41:32 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uPk2t-004CFN-Td; Thu, 12 Jun 2025 16:40:51 +0100
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
Subject: [PATCH net-next 3/9] net: stmmac: rk: add struct for programming
 register based speeds
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uPk2t-004CFN-Td@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 12 Jun 2025 16:40:51 +0100

There is a common pattern in the driver where many SoCs need to write a
single register with a value dependent on the interface mode and speed.
Rather than having a lot of repeated code, add some common functions
and a struct to contain the values to be written to a register to
select the RGMII and RMII speeds.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 432 +++++++++---------
 1 file changed, 204 insertions(+), 228 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 7a1a9f54748d..7b5e989bb77f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -24,6 +24,15 @@
 #include "stmmac_platform.h"
 
 struct rk_priv_data;
+
+struct rk_reg_speed_data {
+	unsigned int rgmii_10;
+	unsigned int rgmii_100;
+	unsigned int rgmii_1000;
+	unsigned int rmii_10;
+	unsigned int rmii_100;
+};
+
 struct rk_gmac_ops {
 	void (*set_to_rgmii)(struct rk_priv_data *bsp_priv,
 			     int tx_delay, int rx_delay);
@@ -83,6 +92,67 @@ struct rk_priv_data {
 	struct regmap *php_grf;
 };
 
+static int rk_set_reg_speed(struct rk_priv_data *bsp_priv,
+			    const struct rk_reg_speed_data *rsd,
+			    unsigned int reg, phy_interface_t interface,
+			    int speed)
+{
+	unsigned int val;
+
+	if (phy_interface_mode_is_rgmii(interface)) {
+		if (speed == SPEED_10) {
+			val = rsd->rgmii_10;
+		} else if (speed == SPEED_100) {
+			val = rsd->rgmii_100;
+		} else if (speed == SPEED_1000) {
+			val = rsd->rgmii_1000;
+		} else {
+			/* Phylink will not allow inappropriate speeds for
+			 * interface modes, so this should never happen.
+			 */
+			return -EINVAL;
+		}
+	} else if (interface == PHY_INTERFACE_MODE_RMII) {
+		if (speed == SPEED_10) {
+			val = rsd->rmii_10;
+		} else if (speed == SPEED_100) {
+			val = rsd->rmii_100;
+		} else {
+			/* Phylink will not allow inappropriate speeds for
+			 * interface modes, so this should never happen.
+			 */
+			return -EINVAL;
+		}
+	} else {
+		/* This should never happen, as .get_interfaces() limits
+		 * the interface modes that are supported to RGMII and/or
+		 * RMII.
+		 */
+		return -EINVAL;
+	}
+
+	regmap_write(bsp_priv->grf, reg, val);
+
+	return 0;
+
+}
+
+static int rk_set_reg_speed_rgmii(struct rk_priv_data *bsp_priv,
+				  const struct rk_reg_speed_data *rsd,
+				  unsigned int reg, int speed)
+{
+	return rk_set_reg_speed(bsp_priv, rsd, reg, PHY_INTERFACE_MODE_RGMII,
+				speed);
+}
+
+static int rk_set_reg_speed_rmii(struct rk_priv_data *bsp_priv,
+				 const struct rk_reg_speed_data *rsd,
+				 unsigned int reg, int speed)
+{
+	return rk_set_reg_speed(bsp_priv, rsd, reg, PHY_INTERFACE_MODE_RMII,
+				speed);
+}
+
 #define HIWORD_UPDATE(val, mask, shift) \
 		((val) << (shift) | (mask) << ((shift) + 16))
 
@@ -261,40 +331,30 @@ static void rk3128_set_to_rmii(struct rk_priv_data *bsp_priv)
 		     RK3128_GMAC_PHY_INTF_SEL_RMII | RK3128_GMAC_RMII_MODE);
 }
 
+static const struct rk_reg_speed_data rk3128_reg_speed_data = {
+	.rgmii_10 = RK3128_GMAC_CLK_2_5M,
+	.rgmii_100 = RK3128_GMAC_CLK_25M,
+	.rgmii_1000 = RK3128_GMAC_CLK_125M,
+	.rmii_10 = RK3128_GMAC_RMII_CLK_2_5M | RK3128_GMAC_SPEED_10M,
+	.rmii_100 = RK3128_GMAC_RMII_CLK_25M | RK3128_GMAC_SPEED_100M,
+};
+
 static void rk3128_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
-	unsigned int con1;
 
-	if (speed == 10) {
-		con1 = RK3128_GMAC_CLK_2_5M;
-	} else if (speed == 100) {
-		con1 = RK3128_GMAC_CLK_25M;
-	} else if (speed == 1000) {
-		con1 = RK3128_GMAC_CLK_125M;
-	} else {
+	if (rk_set_reg_speed_rgmii(bsp_priv, &rk3128_reg_speed_data,
+				   RK3128_GRF_MAC_CON1, speed))
 		dev_err(dev, "unknown speed value for RGMII! speed=%d", speed);
-		return;
-	}
-
-	regmap_write(bsp_priv->grf, RK3128_GRF_MAC_CON1, con1);
 }
 
 static void rk3128_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
-	unsigned int con1;
 
-	if (speed == 10) {
-		con1 = RK3128_GMAC_RMII_CLK_2_5M | RK3128_GMAC_SPEED_10M;
-	} else if (speed == 100) {
-		con1 = RK3128_GMAC_RMII_CLK_25M | RK3128_GMAC_SPEED_100M;
-	} else {
+	if (rk_set_reg_speed_rmii(bsp_priv, &rk3128_reg_speed_data,
+				  RK3128_GRF_MAC_CON1, speed))
 		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
-		return;
-	}
-
-	regmap_write(bsp_priv->grf, RK3128_GRF_MAC_CON1, con1);
 }
 
 static const struct rk_gmac_ops rk3128_ops = {
@@ -360,40 +420,30 @@ static void rk3228_set_to_rmii(struct rk_priv_data *bsp_priv)
 	regmap_write(bsp_priv->grf, RK3228_GRF_MAC_CON1, GRF_BIT(11));
 }
 
+static const struct rk_reg_speed_data rk3228_reg_speed_data = {
+	.rgmii_10 = RK3228_GMAC_CLK_2_5M,
+	.rgmii_100 = RK3228_GMAC_CLK_25M,
+	.rgmii_1000 = RK3228_GMAC_CLK_125M,
+	.rmii_10 = RK3228_GMAC_RMII_CLK_2_5M | RK3228_GMAC_SPEED_10M,
+	.rmii_100 = RK3228_GMAC_RMII_CLK_25M | RK3228_GMAC_SPEED_100M,
+};
+
 static void rk3228_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
-	unsigned int con1;
 
-	if (speed == 10) {
-		con1 = RK3228_GMAC_CLK_2_5M;
-	} else if (speed == 100) {
-		con1 = RK3228_GMAC_CLK_25M;
-	} else if (speed == 1000) {
-		con1 = RK3228_GMAC_CLK_125M;
-	} else {
+	if (rk_set_reg_speed_rgmii(bsp_priv, &rk3228_reg_speed_data,
+				   RK3228_GRF_MAC_CON1, speed))
 		dev_err(dev, "unknown speed value for RGMII! speed=%d", speed);
-		return;
-	}
-
-	regmap_write(bsp_priv->grf, RK3228_GRF_MAC_CON1, con1);
 }
 
 static void rk3228_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
-	unsigned int con1;
 
-	if (speed == 10) {
-		con1 = RK3228_GMAC_RMII_CLK_2_5M | RK3228_GMAC_SPEED_10M;
-	} else if (speed == 100) {
-		con1 = RK3228_GMAC_RMII_CLK_25M | RK3228_GMAC_SPEED_100M;
-	} else {
+	if (rk_set_reg_speed_rmii(bsp_priv, &rk3228_reg_speed_data,
+				  RK3228_GRF_MAC_CON1, speed))
 		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
-		return;
-	}
-
-	regmap_write(bsp_priv->grf, RK3228_GRF_MAC_CON1, con1);
 }
 
 static void rk3228_integrated_phy_powerup(struct rk_priv_data *priv)
@@ -459,40 +509,30 @@ static void rk3288_set_to_rmii(struct rk_priv_data *bsp_priv)
 		     RK3288_GMAC_PHY_INTF_SEL_RMII | RK3288_GMAC_RMII_MODE);
 }
 
+static const struct rk_reg_speed_data rk3288_reg_speed_data = {
+	.rgmii_10 = RK3288_GMAC_CLK_2_5M,
+	.rgmii_100 = RK3288_GMAC_CLK_25M,
+	.rgmii_1000 = RK3288_GMAC_CLK_125M,
+	.rmii_10 = RK3288_GMAC_RMII_CLK_2_5M | RK3288_GMAC_SPEED_10M,
+	.rmii_100 = RK3288_GMAC_RMII_CLK_25M | RK3288_GMAC_SPEED_100M,
+};
+
 static void rk3288_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
-	unsigned int con1;
 
-	if (speed == 10) {
-		con1 = RK3288_GMAC_CLK_2_5M;
-	} else if (speed == 100) {
-		con1 = RK3288_GMAC_CLK_25M;
-	} else if (speed == 1000) {
-		con1 = RK3288_GMAC_CLK_125M;
-	} else {
+	if (rk_set_reg_speed_rgmii(bsp_priv, &rk3288_reg_speed_data,
+				   RK3288_GRF_SOC_CON1, speed))
 		dev_err(dev, "unknown speed value for RGMII! speed=%d", speed);
-		return;
-	}
-
-	regmap_write(bsp_priv->grf, RK3288_GRF_SOC_CON1, con1);
 }
 
 static void rk3288_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
-	unsigned int con1;
 
-	if (speed == 10) {
-		con1 = RK3288_GMAC_RMII_CLK_2_5M | RK3288_GMAC_SPEED_10M;
-	} else if (speed == 100) {
-		con1 = RK3288_GMAC_RMII_CLK_25M | RK3288_GMAC_SPEED_100M;
-	} else {
+	if (rk_set_reg_speed_rmii(bsp_priv, &rk3288_reg_speed_data,
+				  RK3288_GRF_SOC_CON1, speed))
 		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
-		return;
-	}
-
-	regmap_write(bsp_priv->grf, RK3288_GRF_SOC_CON1, con1);
 }
 
 static const struct rk_gmac_ops rk3288_ops = {
@@ -518,21 +558,18 @@ static void rk3308_set_to_rmii(struct rk_priv_data *bsp_priv)
 		     RK3308_GMAC_PHY_INTF_SEL_RMII);
 }
 
+static const struct rk_reg_speed_data rk3308_reg_speed_data = {
+	.rmii_10 = RK3308_GMAC_SPEED_10M,
+	.rmii_100 = RK3308_GMAC_SPEED_100M,
+};
+
 static void rk3308_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
-	unsigned int con0;
 
-	if (speed == 10) {
-		con0 = RK3308_GMAC_SPEED_10M;
-	} else if (speed == 100) {
-		con0 = RK3308_GMAC_SPEED_100M;
-	} else {
+	if (rk_set_reg_speed_rmii(bsp_priv, &rk3308_reg_speed_data,
+				  RK3308_GRF_MAC_CON0, speed))
 		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
-		return;
-	}
-
-	regmap_write(bsp_priv->grf, RK3308_GRF_MAC_CON0, con0);
 }
 
 static const struct rk_gmac_ops rk3308_ops = {
@@ -599,43 +636,33 @@ static void rk3328_set_to_rmii(struct rk_priv_data *bsp_priv)
 		     RK3328_GMAC_RMII_MODE);
 }
 
+static const struct rk_reg_speed_data rk3328_reg_speed_data = {
+	.rgmii_10 = RK3328_GMAC_CLK_2_5M,
+	.rgmii_100 = RK3328_GMAC_CLK_25M,
+	.rgmii_1000 = RK3328_GMAC_CLK_125M,
+	.rmii_10 = RK3328_GMAC_RMII_CLK_2_5M | RK3328_GMAC_SPEED_10M,
+	.rmii_100 = RK3328_GMAC_RMII_CLK_25M | RK3328_GMAC_SPEED_100M,
+};
+
 static void rk3328_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
-	unsigned int con1;
 
-	if (speed == 10) {
-		con1 = RK3328_GMAC_CLK_2_5M;
-	} else if (speed == 100) {
-		con1 = RK3328_GMAC_CLK_25M;
-	} else if (speed == 1000) {
-		con1 = RK3328_GMAC_CLK_125M;
-	} else {
+	if (rk_set_reg_speed_rgmii(bsp_priv, &rk3328_reg_speed_data,
+				   RK3328_GRF_MAC_CON1, speed))
 		dev_err(dev, "unknown speed value for RGMII! speed=%d", speed);
-		return;
-	}
-
-	regmap_write(bsp_priv->grf, RK3328_GRF_MAC_CON1, con1);
 }
 
 static void rk3328_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
-	unsigned int reg, con;
+	unsigned int reg;
 
 	reg = bsp_priv->integrated_phy ? RK3328_GRF_MAC_CON2 :
 		  RK3328_GRF_MAC_CON1;
 
-	if (speed == 10) {
-		con = RK3328_GMAC_RMII_CLK_2_5M | RK3328_GMAC_SPEED_10M;
-	} else if (speed == 100) {
-		con = RK3328_GMAC_RMII_CLK_25M | RK3328_GMAC_SPEED_100M;
-	} else {
+	if (rk_set_reg_speed_rmii(bsp_priv, &rk3328_reg_speed_data, reg, speed))
 		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
-		return;
-	}
-
-	regmap_write(bsp_priv->grf, reg, con);
 }
 
 static void rk3328_integrated_phy_powerup(struct rk_priv_data *priv)
@@ -701,40 +728,30 @@ static void rk3366_set_to_rmii(struct rk_priv_data *bsp_priv)
 		     RK3366_GMAC_PHY_INTF_SEL_RMII | RK3366_GMAC_RMII_MODE);
 }
 
+static const struct rk_reg_speed_data rk3366_reg_speed_data = {
+	.rgmii_10 = RK3366_GMAC_CLK_2_5M,
+	.rgmii_100 = RK3366_GMAC_CLK_25M,
+	.rgmii_1000 = RK3366_GMAC_CLK_125M,
+	.rmii_10 = RK3366_GMAC_RMII_CLK_2_5M | RK3366_GMAC_SPEED_10M,
+	.rmii_100 = RK3366_GMAC_RMII_CLK_25M | RK3366_GMAC_SPEED_100M,
+};
+
 static void rk3366_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
-	unsigned int con6;
 
-	if (speed == 10) {
-		con6 = RK3366_GMAC_CLK_2_5M;
-	} else if (speed == 100) {
-		con6 = RK3366_GMAC_CLK_25M;
-	} else if (speed == 1000) {
-		con6 = RK3366_GMAC_CLK_125M;
-	} else {
+	if (rk_set_reg_speed_rgmii(bsp_priv, &rk3366_reg_speed_data,
+				   RK3366_GRF_SOC_CON6, speed))
 		dev_err(dev, "unknown speed value for RGMII! speed=%d", speed);
-		return;
-	}
-
-	regmap_write(bsp_priv->grf, RK3366_GRF_SOC_CON6, con6);
 }
 
 static void rk3366_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
-	unsigned int con6;
 
-	if (speed == 10) {
-		con6 = RK3366_GMAC_RMII_CLK_2_5M | RK3366_GMAC_SPEED_10M;
-	} else if (speed == 100) {
-		con6 = RK3366_GMAC_RMII_CLK_25M | RK3366_GMAC_SPEED_100M;
-	} else {
+	if (rk_set_reg_speed_rmii(bsp_priv, &rk3366_reg_speed_data,
+				  RK3366_GRF_SOC_CON6, speed))
 		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
-		return;
-	}
-
-	regmap_write(bsp_priv->grf, RK3366_GRF_SOC_CON6, con6);
 }
 
 static const struct rk_gmac_ops rk3366_ops = {
@@ -790,40 +807,30 @@ static void rk3368_set_to_rmii(struct rk_priv_data *bsp_priv)
 		     RK3368_GMAC_PHY_INTF_SEL_RMII | RK3368_GMAC_RMII_MODE);
 }
 
+static const struct rk_reg_speed_data rk3368_reg_speed_data = {
+	.rgmii_10 = RK3368_GMAC_CLK_2_5M,
+	.rgmii_100 = RK3368_GMAC_CLK_25M,
+	.rgmii_1000 = RK3368_GMAC_CLK_125M,
+	.rmii_10 = RK3368_GMAC_RMII_CLK_2_5M | RK3368_GMAC_SPEED_10M,
+	.rmii_100 = RK3368_GMAC_RMII_CLK_25M | RK3368_GMAC_SPEED_100M,
+};
+
 static void rk3368_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
-	unsigned int con15;
 
-	if (speed == 10) {
-		con15 = RK3368_GMAC_CLK_2_5M;
-	} else if (speed == 100) {
-		con15 = RK3368_GMAC_CLK_25M;
-	} else if (speed == 1000) {
-		con15 = RK3368_GMAC_CLK_125M;
-	} else {
+	if (rk_set_reg_speed_rgmii(bsp_priv, &rk3368_reg_speed_data,
+				   RK3368_GRF_SOC_CON15, speed))
 		dev_err(dev, "unknown speed value for RGMII! speed=%d", speed);
-		return;
-	}
-
-	regmap_write(bsp_priv->grf, RK3368_GRF_SOC_CON15, con15);
 }
 
 static void rk3368_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
-	unsigned int con15;
 
-	if (speed == 10) {
-		con15 = RK3368_GMAC_RMII_CLK_2_5M | RK3368_GMAC_SPEED_10M;
-	} else if (speed == 100) {
-		con15 = RK3368_GMAC_RMII_CLK_25M | RK3368_GMAC_SPEED_100M;
-	} else {
+	if (rk_set_reg_speed_rmii(bsp_priv, &rk3368_reg_speed_data,
+				  RK3368_GRF_SOC_CON15, speed))
 		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
-		return;
-	}
-
-	regmap_write(bsp_priv->grf, RK3368_GRF_SOC_CON15, con15);
 }
 
 static const struct rk_gmac_ops rk3368_ops = {
@@ -879,40 +886,30 @@ static void rk3399_set_to_rmii(struct rk_priv_data *bsp_priv)
 		     RK3399_GMAC_PHY_INTF_SEL_RMII | RK3399_GMAC_RMII_MODE);
 }
 
+static const struct rk_reg_speed_data rk3399_reg_speed_data = {
+	.rgmii_10 = RK3399_GMAC_CLK_2_5M,
+	.rgmii_100 = RK3399_GMAC_CLK_25M,
+	.rgmii_1000 = RK3399_GMAC_CLK_125M,
+	.rmii_10 = RK3399_GMAC_RMII_CLK_2_5M | RK3399_GMAC_SPEED_10M,
+	.rmii_100 = RK3399_GMAC_RMII_CLK_25M | RK3399_GMAC_SPEED_100M,
+};
+
 static void rk3399_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
-	unsigned int con5;
 
-	if (speed == 10) {
-		con5 = RK3399_GMAC_CLK_2_5M;
-	} else if (speed == 100) {
-		con5 = RK3399_GMAC_CLK_25M;
-	} else if (speed == 1000) {
-		con5 = RK3399_GMAC_CLK_125M;
-	} else {
+	if (rk_set_reg_speed_rgmii(bsp_priv, &rk3399_reg_speed_data,
+				   RK3399_GRF_SOC_CON5, speed))
 		dev_err(dev, "unknown speed value for RGMII! speed=%d", speed);
-		return;
-	}
-
-	regmap_write(bsp_priv->grf, RK3399_GRF_SOC_CON5, con5);
 }
 
 static void rk3399_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
-	unsigned int con5;
 
-	if (speed == 10) {
-		con5 = RK3399_GMAC_RMII_CLK_2_5M | RK3399_GMAC_SPEED_10M;
-	} else if (speed == 100) {
-		con5 = RK3399_GMAC_RMII_CLK_25M | RK3399_GMAC_SPEED_100M;
-	} else {
+	if (rk_set_reg_speed_rmii(bsp_priv, &rk3399_reg_speed_data,
+				  RK3399_GRF_SOC_CON5, speed))
 		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
-		return;
-	}
-
-	regmap_write(bsp_priv->grf, RK3399_GRF_SOC_CON5, con5);
 }
 
 static const struct rk_gmac_ops rk3399_ops = {
@@ -982,45 +979,44 @@ static void rk3528_set_to_rmii(struct rk_priv_data *bsp_priv)
 			     RK3528_GMAC0_CLK_RMII_DIV2);
 }
 
+static const struct rk_reg_speed_data rk3528_gmac0_reg_speed_data = {
+	.rmii_10 = RK3528_GMAC0_CLK_RMII_DIV20,
+	.rmii_100 = RK3528_GMAC0_CLK_RMII_DIV2,
+};
+
+static const struct rk_reg_speed_data rk3528_gmac1_reg_speed_data = {
+	.rgmii_10 = RK3528_GMAC1_CLK_RGMII_DIV50,
+	.rgmii_100 = RK3528_GMAC1_CLK_RGMII_DIV5,
+	.rgmii_1000 = RK3528_GMAC1_CLK_RGMII_DIV1,
+	.rmii_10 = RK3528_GMAC1_CLK_RMII_DIV20,
+	.rmii_100 = RK3528_GMAC1_CLK_RMII_DIV2,
+};
+
 static void rk3528_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
-	unsigned int con5;
 
-	if (speed == 10) {
-		con5 = RK3528_GMAC1_CLK_RGMII_DIV50;
-	} else if (speed == 100) {
-		con5 = RK3528_GMAC1_CLK_RGMII_DIV5;
-	} else if (speed == 1000) {
-		con5 = RK3528_GMAC1_CLK_RGMII_DIV1;
-	} else {
+	if (rk_set_reg_speed_rgmii(bsp_priv, &rk3528_gmac1_reg_speed_data,
+				   RK3528_VPU_GRF_GMAC_CON5, speed))
 		dev_err(dev, "unknown speed value for RGMII! speed=%d", speed);
-		return;
-	}
-
-	regmap_write(bsp_priv->grf, RK3528_VPU_GRF_GMAC_CON5, con5);
 }
 
 static void rk3528_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
-	unsigned int reg, val;
+	const struct rk_reg_speed_data *rsd;
+	unsigned int reg;
 
-	if (speed == 10) {
-		val = bsp_priv->id == 1 ? RK3528_GMAC1_CLK_RMII_DIV20 :
-					  RK3528_GMAC0_CLK_RMII_DIV20;
-	} else if (speed == 100) {
-		val = bsp_priv->id == 1 ? RK3528_GMAC1_CLK_RMII_DIV2 :
-					  RK3528_GMAC0_CLK_RMII_DIV2;
+	if (bsp_priv->id == 1) {
+		rsd = &rk3528_gmac1_reg_speed_data;
+		reg = RK3528_VPU_GRF_GMAC_CON5;
 	} else {
-		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
-		return;
+		rsd = &rk3528_gmac0_reg_speed_data;
+		reg = RK3528_VO_GRF_GMAC_CON;
 	}
 
-	reg = bsp_priv->id == 1 ? RK3528_VPU_GRF_GMAC_CON5 :
-				  RK3528_VO_GRF_GMAC_CON;
-
-	regmap_write(bsp_priv->grf, reg, val);
+	if (rk_set_reg_speed_rmii(bsp_priv, rsd, reg, speed))
+		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
 }
 
 static void rk3528_set_clock_selection(struct rk_priv_data *bsp_priv,
@@ -1224,42 +1220,25 @@ static void rk3576_set_to_rmii(struct rk_priv_data *bsp_priv)
 	regmap_write(bsp_priv->grf, offset_con, RK3576_GMAC_RMII_MODE);
 }
 
+static const struct rk_reg_speed_data rk3578_reg_speed_data = {
+	.rgmii_10 = RK3576_GMAC_CLK_RGMII_DIV50,
+	.rgmii_100 = RK3576_GMAC_CLK_RGMII_DIV5,
+	.rgmii_1000 = RK3576_GMAC_CLK_RGMII_DIV1,
+	.rmii_10 = RK3576_GMAC_CLK_RMII_DIV20,
+	.rmii_100 = RK3576_GMAC_CLK_RMII_DIV2,
+};
+
 static void rk3576_set_gmac_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
-	unsigned int val = 0, offset_con;
-
-	switch (speed) {
-	case 10:
-		if (bsp_priv->phy_iface == PHY_INTERFACE_MODE_RMII)
-			val = RK3576_GMAC_CLK_RMII_DIV20;
-		else
-			val = RK3576_GMAC_CLK_RGMII_DIV50;
-		break;
-	case 100:
-		if (bsp_priv->phy_iface == PHY_INTERFACE_MODE_RMII)
-			val = RK3576_GMAC_CLK_RMII_DIV2;
-		else
-			val = RK3576_GMAC_CLK_RGMII_DIV5;
-		break;
-	case 1000:
-		if (bsp_priv->phy_iface != PHY_INTERFACE_MODE_RMII)
-			val = RK3576_GMAC_CLK_RGMII_DIV1;
-		else
-			goto err;
-		break;
-	default:
-		goto err;
-	}
+	unsigned int offset_con;
 
 	offset_con = bsp_priv->id == 1 ? RK3576_GRF_GMAC_CON1 :
 					 RK3576_GRF_GMAC_CON0;
 
-	regmap_write(bsp_priv->grf, offset_con, val);
-
-	return;
-err:
-	dev_err(dev, "unknown speed value for GMAC speed=%d", speed);
+	if (rk_set_reg_speed(bsp_priv, &rk3578_reg_speed_data, offset_con,
+			     bsp_priv->phy_iface, speed))
+		dev_err(dev, "unknown speed value for GMAC speed=%d", speed);
 }
 
 static void rk3576_set_clock_selection(struct rk_priv_data *bsp_priv, bool input,
@@ -1446,21 +1425,18 @@ static void rv1108_set_to_rmii(struct rk_priv_data *bsp_priv)
 		     RV1108_GMAC_PHY_INTF_SEL_RMII);
 }
 
+static const struct rk_reg_speed_data rv1108_reg_speed_data = {
+	.rmii_10 = RV1108_GMAC_RMII_CLK_2_5M | RV1108_GMAC_SPEED_10M,
+	.rmii_100 = RV1108_GMAC_RMII_CLK_25M | RV1108_GMAC_SPEED_100M,
+};
+
 static void rv1108_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
-	unsigned int con0;
 
-	if (speed == 10) {
-		con0 = RV1108_GMAC_RMII_CLK_2_5M | RV1108_GMAC_SPEED_10M;
-	} else if (speed == 100) {
-		con0 = RV1108_GMAC_RMII_CLK_25M | RV1108_GMAC_SPEED_100M;
-	} else {
+	if (rk_set_reg_speed_rmii(bsp_priv, &rv1108_reg_speed_data,
+				  RV1108_GRF_GMAC_CON0, speed))
 		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
-		return;
-	}
-
-	regmap_write(bsp_priv->grf, RV1108_GRF_GMAC_CON0, con0);
 }
 
 static const struct rk_gmac_ops rv1108_ops = {
-- 
2.30.2


