Return-Path: <netdev+bounces-242995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C7BC97EC2
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 15:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59E194E188B
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 14:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E124D31BCA9;
	Mon,  1 Dec 2025 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ffqi2pQj"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025E0319860
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764600743; cv=none; b=PG17/ECxg4GM1VXL3jqoHecoYFK477UOamlS5Z9Wx5YhdRW3+Wa13nKNaH/AxTdzl5V9Zf2PcP9yrWr883bneASJEN0PA+jOOlgTWYU89/oMPp302mdXdRdmdizt8t9qcGkO6fHh0Qh9gJ/8Mv9Np2PocHrzRRtO+IcWvlpjwUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764600743; c=relaxed/simple;
	bh=8Odq+0FdnYObqcjnAmO+Osm06sw21cxvGJf07kzbIq0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=DjxN5BhByW8LME/h6y7Do+mXXRyAaFm00D38QQVFsCCmTiQQMeu92oca1dBuK/uAOOvshyjFCxkSeRHnomLsAkLq4rtSxIys30aNTTXSwk7MShb15FaiYOrSuNVP1X1mV7WtxNZrL0Bp3bOlheXT6lEuMBw3Yd/xkPvFanlVwXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ffqi2pQj; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eFOskbUwm0fPWhzGP4f7FXT0H9qDoZ8nRAhr5ePVCIY=; b=ffqi2pQj6r1TeInhkYYP5R8gdg
	KK/hAw6UziM6aCDGs9RIKd6hmw+YAOiRzcBPe2bhZQlMec3uMP+FTc/Ja2ZBcWxZVwWshDrX3Ebz8
	yOqW8sXSM5RP9z57zlVEbLMiy/AvYaKdPEqCEPxcD8RxxVoq15TK6lgOdrVdbSayGwCayH82tIFR4
	F8ykDTiW1pHhdP0caaOyAmTvcG3DbYGL51ict1xF8aWORp5WZlIA9azwPrtpyeq2LGoAuzpyif5rO
	rGpK1POfrCuNcVj3JkXA+xgfZDHDcq1Qh7phDOxA2dqGF76xyZscaRBYH2Cq47ijQ4OGO6ZvN4qq3
	bd4wf4MA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:49784 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vQ5Fi-000000000hn-0Bxs;
	Mon, 01 Dec 2025 14:51:46 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vQ5Fa-0000000GNwT-48iR;
	Mon, 01 Dec 2025 14:51:39 +0000
In-Reply-To: <aS2rFBlz1jdwXaS8@shell.armlinux.org.uk>
References: <aS2rFBlz1jdwXaS8@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RFC net-next 11/15] net: stmmac: rk: convert px30
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vQ5Fa-0000000GNwT-48iR@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 01 Dec 2025 14:51:38 +0000

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 38 ++-----------------
 1 file changed, 4 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index c26bd22658c6..4c80a73bbf74 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -237,49 +237,19 @@ static void rk_gmac_integrated_fephy_powerdown(struct rk_priv_data *priv,
 
 #define PX30_GRF_GMAC_CON1		0x0904
 
-/* PX30_GRF_GMAC_CON1 */
-#define PX30_GMAC_SPEED_10M		GRF_CLR_BIT(2)
-#define PX30_GMAC_SPEED_100M		GRF_BIT(2)
-
 static void px30_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 }
 
-static int px30_set_speed(struct rk_priv_data *bsp_priv,
-			  phy_interface_t interface, int speed)
-{
-	struct clk *clk_mac_speed = bsp_priv->clks[RK_CLK_MAC_SPEED].clk;
-	struct device *dev = bsp_priv->dev;
-	unsigned int con1;
-	long rate;
-
-	if (!clk_mac_speed) {
-		dev_err(dev, "%s: Missing clk_mac_speed clock\n", __func__);
-		return -EINVAL;
-	}
-
-	if (speed == 10) {
-		con1 = PX30_GMAC_SPEED_10M;
-		rate = 2500000;
-	} else if (speed == 100) {
-		con1 = PX30_GMAC_SPEED_100M;
-		rate = 25000000;
-	} else {
-		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
-		return -EINVAL;
-	}
-
-	regmap_write(bsp_priv->grf, PX30_GRF_GMAC_CON1, con1);
-
-	return clk_set_rate(clk_mac_speed, rate);
-}
-
 static const struct rk_gmac_ops px30_ops = {
 	.set_to_rmii = px30_set_to_rmii,
-	.set_speed = px30_set_speed,
+	.set_speed = rk_set_clk_mac_speed,
 
 	.phy_intf_sel_grf_reg = PX30_GRF_GMAC_CON1,
 	.phy_intf_sel_mask = GENMASK_U16(6, 4),
+
+	.speed_grf_reg = PX30_GRF_GMAC_CON1,
+	.mac_speed_mask = BIT_U16(2),
 };
 
 #define RK3128_GRF_MAC_CON0	0x0168
-- 
2.47.3


