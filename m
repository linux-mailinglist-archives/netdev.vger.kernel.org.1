Return-Path: <netdev+bounces-235049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22856C2B89C
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 12:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25D8A3BB870
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 11:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF45730146E;
	Mon,  3 Nov 2025 11:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VLRDRUvc"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7094E3054F8
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170668; cv=none; b=F7hqN7cSyrGnibia9oPCy8XRbMZae2ENxJa0kjOcK9PFcLVl7q88lDI/fxDVgTFUJHVfJnr7HrkCLpIysn0P9ES4SeJPR+T6VzVTy//itqBhLDFVjCj7Z0HsnlNGp+O0lXIo8XW2NdsqwDANg2Y0CIv9MLfaa+iG+WfTUOVOKa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170668; c=relaxed/simple;
	bh=lxXAR4f4KcshnXGKSd9sGaiIE73eRyFWMlM7QOPvktY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=gBsJnyLPXNszGlC5hYAiRhGDGQtctDkxIvnJZUlCrVUCeuPNHxm2HDbPcp7HH0ASxz1U/KO6HTfUx7u+IZQAyqXQOewZw3ND1WvcmrxkrX0wyyg3+rq7LtKQTeJbQICsQKGHvbehkz/nsruAzVidJGxD4QwTddsg1cUZ1NCq08c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VLRDRUvc; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kly4N6abxp7aiePb6wwRYSJBZH1/+QjzYw61vq0g2YY=; b=VLRDRUvcQXaTw2J9kkhL41exjg
	l03aK4H5uo2r3lFc7UW+qkMbskoYLmUNx1vTeQXFsWaGs/dVVrYQMk6ahorUvjrArrwmmMrW259rT
	d3gYqe06cb7qItzqXKILT6Mt5XgrHxlNNDsoghKsHOBnQRZsL6WTkefxMg6+rwYqZUKRz7iMHwEua
	FrXmdJ1esBBO2TXfhbNL31mcEW2ySLoGgSM3cn6UgIz8E31IZbecuu7xWNkYUdtqoNrTsmbHoi3Hd
	PIVdJnkHQ9YKxgv78dtENXBUJYvGAHwn/M9EaCCt1LFsMRmGOUQp6ye+LHFVBOPu3mwoHX3gSD3A8
	0yD2ZqVQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50026 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vFt56-000000000ho-2CKc;
	Mon, 03 Nov 2025 11:50:40 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vFt52-0000000ChpG-1bsd;
	Mon, 03 Nov 2025 11:50:36 +0000
In-Reply-To: <aQiWzyrXU_2hGJ4j@shell.armlinux.org.uk>
References: <aQiWzyrXU_2hGJ4j@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	s32@nxp.com,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH net-next 09/11] net: stmmac: imx: simplify set_intf_mode()
 implementations
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vFt52-0000000ChpG-1bsd@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 03 Nov 2025 11:50:36 +0000

Simplify the set_intf_mode() implementations, testing the phy_intf_sel
value rather than the PHY interface mode.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-imx.c   | 67 ++++++-------------
 1 file changed, 19 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index dc28486a7af0..d69be9de4468 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -67,29 +67,15 @@ static int imx8mp_set_intf_mode(struct plat_stmmacenet_data *plat_dat,
 				u8 phy_intf_sel)
 {
 	struct imx_priv_data *dwmac = plat_dat->bsp_priv;
-	int val;
-
-	switch (plat_dat->phy_interface) {
-	case PHY_INTERFACE_MODE_MII:
-		val = 0;
-		break;
-	case PHY_INTERFACE_MODE_RMII:
-		val = dwmac->rmii_refclk_ext ? 0 : GPR_ENET_QOS_CLK_TX_CLK_SEL;
-		break;
-	case PHY_INTERFACE_MODE_RGMII:
-	case PHY_INTERFACE_MODE_RGMII_ID:
-	case PHY_INTERFACE_MODE_RGMII_RXID:
-	case PHY_INTERFACE_MODE_RGMII_TXID:
-		val = GPR_ENET_QOS_RGMII_EN;
-		break;
-	default:
-		pr_debug("imx dwmac doesn't support %s interface\n",
-			 phy_modes(plat_dat->phy_interface));
-		return -EINVAL;
-	}
+	unsigned int val;
 
-	val |= FIELD_PREP(GPR_ENET_QOS_INTF_SEL_MASK, phy_intf_sel) |
-	       GPR_ENET_QOS_CLK_GEN_EN;
+	val = FIELD_PREP(GPR_ENET_QOS_INTF_SEL_MASK, phy_intf_sel) |
+	      GPR_ENET_QOS_CLK_GEN_EN;
+
+	if (phy_intf_sel == PHY_INTF_SEL_RMII && !dwmac->rmii_refclk_ext)
+		val |= GPR_ENET_QOS_CLK_TX_CLK_SEL;
+	else if (phy_intf_sel == PHY_INTF_SEL_RGMII)
+		val |= GPR_ENET_QOS_RGMII_EN;
 
 	return regmap_update_bits(dwmac->intf_regmap, dwmac->intf_reg_off,
 				  GPR_ENET_QOS_INTF_MODE_MASK, val);
@@ -99,39 +85,24 @@ static int
 imx8dxl_set_intf_mode(struct plat_stmmacenet_data *plat_dat,
 		      u8 phy_intf_sel)
 {
-	int ret = 0;
-
 	/* TBD: depends on imx8dxl scu interfaces to be upstreamed */
-	return ret;
+	return 0;
 }
 
 static int imx93_set_intf_mode(struct plat_stmmacenet_data *plat_dat,
 			       u8 phy_intf_sel)
 {
 	struct imx_priv_data *dwmac = plat_dat->bsp_priv;
-	int val, ret;
-
-	switch (plat_dat->phy_interface) {
-	case PHY_INTERFACE_MODE_RMII:
-		if (dwmac->rmii_refclk_ext) {
-			ret = regmap_clear_bits(dwmac->intf_regmap,
-						dwmac->intf_reg_off +
-						MX93_GPR_CLK_SEL_OFFSET,
-						MX93_GPR_ENET_QOS_CLK_SEL_MASK);
-			if (ret)
-				return ret;
-		}
-		break;
-	case PHY_INTERFACE_MODE_MII:
-	case PHY_INTERFACE_MODE_RGMII:
-	case PHY_INTERFACE_MODE_RGMII_ID:
-	case PHY_INTERFACE_MODE_RGMII_RXID:
-	case PHY_INTERFACE_MODE_RGMII_TXID:
-		break;
-	default:
-		dev_dbg(dwmac->dev, "imx dwmac doesn't support %s interface\n",
-			phy_modes(plat_dat->phy_interface));
-		return -EINVAL;
+	unsigned int val;
+	int ret;
+
+	if (phy_intf_sel == PHY_INTF_SEL_RMII && dwmac->rmii_refclk_ext) {
+		ret = regmap_clear_bits(dwmac->intf_regmap,
+					dwmac->intf_reg_off +
+					MX93_GPR_CLK_SEL_OFFSET,
+					MX93_GPR_ENET_QOS_CLK_SEL_MASK);
+		if (ret)
+			return ret;
 	}
 
 	val = FIELD_PREP(MX93_GPR_ENET_QOS_INTF_SEL_MASK, phy_intf_sel) |
-- 
2.47.3


