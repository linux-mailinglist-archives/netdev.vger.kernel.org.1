Return-Path: <netdev+bounces-197055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CEBAD76CF
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFA51188A43D
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9023529ACF0;
	Thu, 12 Jun 2025 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GrvY1SOC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEA829B229
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742920; cv=none; b=KYM4b4bNwRu7jzLYTBhzFaMtwmMfyU+WWi6/CGSVI+hfLpMgXfM/yzA2FJRYw2NM0GRMve0X0iekm9gjznTjdepXP4lTIMURSYkXWqdeYCpwovmhDiiiFrqwKLUWrcitwXOyQc6ANH+yoNaYcq9h/PHoBJrf1pm6N/DXSQAeAc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742920; c=relaxed/simple;
	bh=0BhcuS0FHaiQmqehFPyZ4nvwTn81GHBqlESv0VV9mRg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=pOmPB/XmGUkgE5QKm37JbTG2P1jRtht0dJ4PF35n18g4jZPo2zj99PhcWmixTd2BLDUgt8JEIN/pNiZmEvA6KT1GFZkX4CsIsF9YmeCG8MLy/OZ7CsPX96zLm7+c+J0idBxAgeQssWlKah9Rahk5J5xndu5Z01a9R6gEYcax3Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=GrvY1SOC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U8OnpIVRMDsCvWvEU627B7xFOFqUm/Prfg2szCnr5fc=; b=GrvY1SOCPxPv97W26JYreUrBFT
	GnkuxBm7nYyHeUfamWkF81FFBqf6p2jGGsjkbk7zbJgaFcplaCsNn7z9Z8IdCG9gQ6AUABI65UUER
	oMCowzW5X0+H4rcfduxN+0ijLU+8bkB9AY0KdRNWowMsOeAbV97zhHBQeGN5PM5lUlMZIqYdOhhwE
	YnUQz48g2qTMgeX6V5hRFIM+WpXMPFWVYpTJmxSKDWqt0cPbb2I7wOyKgn52wolYjbXwYJJgFQRbC
	hDq9M9wOm6Ke9xtrmDNafvMwQ2SJZ5MjK4UZHLNnowMEEIzRAZ8GWM3HsxYSo1Ga5sjMwSek9h54E
	CzC5CaVA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42644 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uPk3s-00084s-1R;
	Thu, 12 Jun 2025 16:41:52 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uPk3E-004CFl-BZ; Thu, 12 Jun 2025 16:41:12 +0100
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
Subject: [PATCH net-next 7/9] net: stmmac: rk: simplify px30_set_rmii_speed()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uPk3E-004CFl-BZ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 12 Jun 2025 16:41:12 +0100

px30_set_rmii_speed() doesn't need to be as verbose as it is - it
merely needs the values for the register and clock rate which depend
on the speed, and then call the appropriate functions. Rewrite the
function to make it so.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 29 +++++++++----------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 8ad6b3b0e282..72f2b80bf3bb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -250,6 +250,8 @@ static void px30_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct clk *clk_mac_speed = bsp_priv->clks[RK_CLK_MAC_SPEED].clk;
 	struct device *dev = &bsp_priv->pdev->dev;
+	unsigned int con1;
+	long rate;
 	int ret;
 
 	if (!clk_mac_speed) {
@@ -258,25 +260,22 @@ static void px30_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 	}
 
 	if (speed == 10) {
-		regmap_write(bsp_priv->grf, PX30_GRF_GMAC_CON1,
-			     PX30_GMAC_SPEED_10M);
-
-		ret = clk_set_rate(clk_mac_speed, 2500000);
-		if (ret)
-			dev_err(dev, "%s: set clk_mac_speed rate 2500000 failed: %d\n",
-				__func__, ret);
+		con1 = PX30_GMAC_SPEED_10M;
+		rate = 2500000;
 	} else if (speed == 100) {
-		regmap_write(bsp_priv->grf, PX30_GRF_GMAC_CON1,
-			     PX30_GMAC_SPEED_100M);
-
-		ret = clk_set_rate(clk_mac_speed, 25000000);
-		if (ret)
-			dev_err(dev, "%s: set clk_mac_speed rate 25000000 failed: %d\n",
-				__func__, ret);
-
+		con1 = PX30_GMAC_SPEED_100M;
+		rate = 25000000;
 	} else {
 		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
+		return;
 	}
+
+	regmap_write(bsp_priv->grf, PX30_GRF_GMAC_CON1, con1);
+
+	ret = clk_set_rate(clk_mac_speed, rate);
+	if (ret)
+		dev_err(dev, "%s: set clk_mac_speed rate %ld failed: %d\n",
+			__func__, rate, ret);
 }
 
 static const struct rk_gmac_ops px30_ops = {
-- 
2.30.2


