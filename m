Return-Path: <netdev+bounces-242997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C41C97ECE
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 15:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3D356344A49
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 14:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4E131D75D;
	Mon,  1 Dec 2025 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PL9UgYn9"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C6F31BCBC
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764600745; cv=none; b=SczdtZXR802ckJJHiJsAwGQqzAWv4c5OloRSdMjHd9t/tQMLdXiVUyQ/Lgv+V3ASNIBZVwxGxs1lFtcIvpJV6U95uBeuGOum+fbnXpPuNEv9TmLs7LAxyTkAyQfQppP4ZblSrH3rcTxWhcTO27QRoQl3N1gvZbJySxFaEBRmRE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764600745; c=relaxed/simple;
	bh=8jKEYxlt5KDLOSq+plH4L6cbYbUtNlETBrDaYM3bgeE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=fANpC7DkP2aAKfcODGmCQF9xX2aJZIJ36yR9zjdNZrJijU+HOAfunI1Aze4fgfkCsSol9U/BIQt0igHRWSyI5rnbzLOMgt7mbNxT4z6vGGi5wET9ycv63DWXXJXTmcrx4tZmHYt2BRi9QK273JxmNut+UFp+rm15/V/wAyOqyWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PL9UgYn9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fWbyBP63uvCTssWzZZ2tOggk/sZ4stCJWuHR4DBcl2M=; b=PL9UgYn9Y1fpsv/YH5p1RcJPlB
	0vP1B7PV892h7IIHSdksFtTL67trIJ5hum3N462aYcfm5WBMx/QEGfhiVgv7dYIVHCseLazkr0yTW
	v5SqDL5/uWhsmY9uK/NzLfG1X7VNdAvwg1qaJ3o4qb4sf3J3I4IsaIJdSAQKdrqcs+xcpzvfPSFIZ
	pf/p0/SkB/W56Z/T6CRXXi51SXS08M0tCu9SGNCMKiaJ0fQxMbBDsNlSppNeGLfkNQjUNKioFyUQ2
	fWsBFyvcBJKtEDdtTUdRWJtjRb7CyRH19U4+VMTqTnNWVNV1OyUO8gD1cTIvvReNSAgxvNNhIbNaH
	Q22uelKw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:49796 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vQ5Fl-000000000hr-1b36;
	Mon, 01 Dec 2025 14:51:49 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vQ5Fg-0000000GNwZ-0aYc;
	Mon, 01 Dec 2025 14:51:44 +0000
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
Subject: [PATCH RFC net-next 12/15] net: stmmac: rk: introduce flags
 indicating support for RGMII/RMII
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vQ5Fg-0000000GNwZ-0aYc@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 01 Dec 2025 14:51:44 +0000

Introduce two boolean flags into struct rk_priv_data indicating
whether RGMII and/or RMII is supported for this instance. Use these
to configure the supported_interfaces mask for phylink, validate the
interface mode. Initialise these from equivalent flags in the
rk_gmac_ops or depending on the presence of the ops->set_to_rgmii and
ops->set_to_mii methods. Finally, make ops->set_to_* optional.

This will allow us to get rid of empty set_to_rmii() methods.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 35 +++++++++++++------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 4c80a73bbf74..fbc0e50519f6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -48,6 +48,8 @@ struct rk_gmac_ops {
 	u16 mac_speed_mask;
 
 	bool speed_reg_php_grf;
+	bool supports_rgmii;
+	bool supports_rmii;
 	bool php_grf_required;
 	bool regs_valid;
 	u32 regs[];
@@ -81,6 +83,8 @@ struct rk_priv_data {
 	bool clk_enabled;
 	bool clock_input;
 	bool integrated_phy;
+	bool supports_rgmii;
+	bool supports_rmii;
 
 	struct clk_bulk_data *clks;
 	int num_clks;
@@ -1387,6 +1391,9 @@ static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
 	bsp_priv->rmii_clk_sel_mask = ops->rmii_clk_sel_mask;
 	bsp_priv->mac_speed_mask = ops->mac_speed_mask;
 
+	bsp_priv->supports_rgmii = ops->supports_rgmii || !!ops->set_to_rgmii;
+	bsp_priv->supports_rmii = ops->supports_rmii || !!ops->set_to_rmii;
+
 	if (ops->init) {
 		ret = ops->init(bsp_priv);
 		if (ret) {
@@ -1405,11 +1412,11 @@ static int rk_gmac_check_ops(struct rk_priv_data *bsp_priv)
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
-		if (!bsp_priv->ops->set_to_rgmii)
+		if (!bsp_priv->supports_rgmii)
 			return -EINVAL;
 		break;
 	case PHY_INTERFACE_MODE_RMII:
-		if (!bsp_priv->ops->set_to_rmii)
+		if (!bsp_priv->supports_rmii)
 			return -EINVAL;
 		break;
 	default:
@@ -1455,24 +1462,32 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
 	switch (bsp_priv->phy_iface) {
 	case PHY_INTERFACE_MODE_RGMII:
 		dev_info(dev, "init for RGMII\n");
-		bsp_priv->ops->set_to_rgmii(bsp_priv, bsp_priv->tx_delay,
-					    bsp_priv->rx_delay);
+		if (bsp_priv->ops->set_to_rgmii)
+			bsp_priv->ops->set_to_rgmii(bsp_priv,
+						    bsp_priv->tx_delay,
+						    bsp_priv->rx_delay);
 		break;
 	case PHY_INTERFACE_MODE_RGMII_ID:
 		dev_info(dev, "init for RGMII_ID\n");
-		bsp_priv->ops->set_to_rgmii(bsp_priv, 0, 0);
+		if (bsp_priv->ops->set_to_rgmii)
+			bsp_priv->ops->set_to_rgmii(bsp_priv, 0, 0);
 		break;
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 		dev_info(dev, "init for RGMII_RXID\n");
-		bsp_priv->ops->set_to_rgmii(bsp_priv, bsp_priv->tx_delay, 0);
+		if (bsp_priv->ops->set_to_rgmii)
+			bsp_priv->ops->set_to_rgmii(bsp_priv,
+						    bsp_priv->tx_delay, 0);
 		break;
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		dev_info(dev, "init for RGMII_TXID\n");
-		bsp_priv->ops->set_to_rgmii(bsp_priv, 0, bsp_priv->rx_delay);
+		if (bsp_priv->ops->set_to_rgmii)
+			bsp_priv->ops->set_to_rgmii(bsp_priv,
+						    0, bsp_priv->rx_delay);
 		break;
 	case PHY_INTERFACE_MODE_RMII:
 		dev_info(dev, "init for RMII\n");
-		bsp_priv->ops->set_to_rmii(bsp_priv);
+		if (bsp_priv->ops->set_to_rmii)
+			bsp_priv->ops->set_to_rmii(bsp_priv);
 		break;
 	default:
 		dev_err(dev, "NO interface defined!\n");
@@ -1508,10 +1523,10 @@ static void rk_get_interfaces(struct stmmac_priv *priv, void *bsp_priv,
 {
 	struct rk_priv_data *rk = bsp_priv;
 
-	if (rk->ops->set_to_rgmii)
+	if (rk->supports_rgmii)
 		phy_interface_set_rgmii(interfaces);
 
-	if (rk->ops->set_to_rmii)
+	if (rk->supports_rmii)
 		__set_bit(PHY_INTERFACE_MODE_RMII, interfaces);
 }
 
-- 
2.47.3


