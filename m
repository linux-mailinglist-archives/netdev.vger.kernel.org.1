Return-Path: <netdev+bounces-235050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE89C2B8A2
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 12:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E813BBF05
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 11:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62A63043C7;
	Mon,  3 Nov 2025 11:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eDlTZlto"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9303054F8
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170672; cv=none; b=DhB4BraDnoJCoGhqthptihyLu4HCfFzG/40hg/yTXsFhFMIrxZA9z6Nl7sOiLlkyRG4bGujXaS+GD7HgD6gQJ0NnRIDjamijOh6GEBzKLoJThgQo3va5w4dv32/G0C2llsG/t7HZqfINeuNWAHBirkpPV1lkB0QGdNRTqXh5/kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170672; c=relaxed/simple;
	bh=Vibd5ps+PSRFnQF3jIOYvV/vKKoP4zJIccCzF29G8rg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=tRjUTgrnNoLkUqrdJ1XRDMCbNjGwC9/10lKDFTn5D9Jsuy0LNcToWIgEAGBAP+d6l3ACPrGVHmLuerD2yhoW8KPMUCBLnYZzDyAkMdPs2TXY0dHojNZav7acoi3tZHHVcbd5VhrGHx6axkyqeXOSqCQ+QF5cCQSKNIqOeERZLp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eDlTZlto; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+x67xrOfs+NtjduqtRJxZD8HBELV2D7qvud2IndiqU4=; b=eDlTZltoetN3Hk1dXyigbldu0u
	gLYRDBWpaj8VhWcsanGsGMOEUnFEmvC66Nj4x1QtyF9BH1Qc/u73b7jubrIw5ZWPWmoKzk3GSGmtL
	xJ9VYkHMSdMM42Dt1mcLxJSlD11vWe+IaORHyBYfRrUznWsbnT5Hyy7U7dB07Z7+qFT+pT95V8b0G
	XWTfellsJlbbkChSQwSejkGFdESfUc9XW1T0/bSPpZgSgo6LMOMRm7sDvUaOFtMzQNbTnJWGkGbZz
	FjQGf64JAQ9Xj87x8/+0Fzjt3KRvSmN7HSRkQXrWz0SxaznipsaFpnMXTXOx7CdEYBEMhIlYm9jnl
	sc2ueNDQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35376 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vFt5G-000000000iL-006H;
	Mon, 03 Nov 2025 11:50:50 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vFt5C-0000000ChpR-2kAB;
	Mon, 03 Nov 2025 11:50:46 +0000
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
Subject: [PATCH net-next 11/11] net: stmmac: imx: use ->set_phy_intf_sel()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vFt5C-0000000ChpR-2kAB@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 03 Nov 2025 11:50:46 +0000

Rather than placing the phy_intf_sel() setup in the ->init() method,
move it to the new ->set_phy_intf_sel() method.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-imx.c   | 38 +++++--------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index ae1b73e1bcb2..db288fbd5a4d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -134,36 +134,19 @@ static int imx_dwmac_clks_config(void *priv, bool enabled)
 	return ret;
 }
 
-static int imx_dwmac_init(struct platform_device *pdev, void *priv)
+static int imx_set_phy_intf_sel(void *bsp_priv, u8 phy_intf_sel)
 {
-	struct imx_priv_data *dwmac = priv;
-	phy_interface_t interface;
-	int phy_intf_sel, ret;
-
-	if (dwmac->ops->set_intf_mode) {
-		interface = dwmac->plat_dat->phy_interface;
-
-		phy_intf_sel = stmmac_get_phy_intf_sel(interface);
-		if (phy_intf_sel != PHY_INTF_SEL_GMII_MII &&
-		    phy_intf_sel != PHY_INTF_SEL_RGMII &&
-		    phy_intf_sel != PHY_INTF_SEL_RMII) {
-			dev_dbg(dwmac->dev,
-				"imx dwmac doesn't support %s interface\n",
-				phy_modes(interface));
-			return phy_intf_sel < 0 ? phy_intf_sel : -EINVAL;
-		}
+	struct imx_priv_data *dwmac = bsp_priv;
 
-		ret = dwmac->ops->set_intf_mode(dwmac, phy_intf_sel);
-		if (ret)
-			return ret;
-	}
+	if (!dwmac->ops->set_intf_mode)
+		return 0;
 
-	return 0;
-}
+	if (phy_intf_sel != PHY_INTF_SEL_GMII_MII &&
+	    phy_intf_sel != PHY_INTF_SEL_RGMII &&
+	    phy_intf_sel != PHY_INTF_SEL_RMII)
+		return -EINVAL;
 
-static void imx_dwmac_exit(struct platform_device *pdev, void *priv)
-{
-	/* nothing to do now */
+	return dwmac->ops->set_intf_mode(dwmac, phy_intf_sel);
 }
 
 static int imx_dwmac_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
@@ -342,8 +325,7 @@ static int imx_dwmac_probe(struct platform_device *pdev)
 		plat_dat->tx_queues_cfg[i].tbs_en = 1;
 
 	plat_dat->host_dma_width = dwmac->ops->addr_width;
-	plat_dat->init = imx_dwmac_init;
-	plat_dat->exit = imx_dwmac_exit;
+	plat_dat->set_phy_intf_sel = imx_set_phy_intf_sel;
 	plat_dat->clks_config = imx_dwmac_clks_config;
 	plat_dat->bsp_priv = dwmac;
 	dwmac->plat_dat = plat_dat;
-- 
2.47.3


