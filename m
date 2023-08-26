Return-Path: <netdev+bounces-30864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4487895B8
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 12:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E88D1C20D42
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 10:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788A08834;
	Sat, 26 Aug 2023 10:03:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9762102
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 10:03:19 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065BC9D
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 03:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mH9fmWh29/vmpowLc2/1ix0vEBt12GIu8GqTHuO66+Q=; b=WEpZdoAQSWIC81TJerF787UzJ1
	gJLWa4l1HvU9mpRnvXea/e64df/lXevKrHcAHbeVQ37D36sbPn6UHiRBD6XKS0ZAx/rxVmbnRATGM
	fv89vWs0zRPK1iDt9/Xoh6zXUFQCWRzIhJ5WEApcS0FSTMFwMRF7aN2J5YBDj6IJis/Q2MVAoODG+
	MVJxzcGdolayeTAaWE3dxsLp6kZ7C/3pEmnyq7SblH+ZfxUXfrFSaP4OXT/TmU3yxR2rY55sPMgFh
	Z0mScnmG4xWkXEXnr/3lFRGI0QRex47+ZvbTrVoY/blbjM1AgrjDLmXWnuJdZKCbPFrCTyrB+vEkI
	nsO3XvxA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47342 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qZq82-00067I-2s;
	Sat, 26 Aug 2023 11:02:50 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qZq83-005tts-6K; Sat, 26 Aug 2023 11:02:51 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	 Jose Abreu <joabreu@synopsys.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Feiyang Chen <chenfeiyang@loongson.cn>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Samin Guo <samin.guo@starfivetech.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-sunxi@lists.linux.dev,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next] net: stmmac: clarify difference between "interface"
 and "phy_interface"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qZq83-005tts-6K@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sat, 26 Aug 2023 11:02:51 +0100
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Clarify the difference between "interface" and "phy_interface" in
struct plat_stmmacenet_data, both by adding a comment, and also
renaming "interface" to be "mac_interface". The difference between
these are:

 MAC ----- optional PCS ----- SerDes ----- optional PHY ----- Media
       ^                               ^
 mac_interface                   phy_interface

Note that phylink currently only deals with phy_interface.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---

One last patch before Sunday - I would like to get this merged as it
touches multiple stmmac platforms before any further are added.

This patch merely renames the "plat_dat->interface" to "->mac_interface"
but doesn't change which any code uses.

All code which uses plat->interface (now plat->mac_interface) are
determining the interface from the MAC side not the PHY side. These
need a code review against the docs to check whether that is correct.
Essentially, every .c file touched by this needs a code review. This
code review should not affect whether this patch is merged.

 .../net/ethernet/stmicro/stmmac/dwmac-imx.c   | 14 ++++++-------
 .../ethernet/stmicro/stmmac/dwmac-ingenic.c   | 20 +++++++++----------
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  |  2 +-
 .../ethernet/stmicro/stmmac/dwmac-lpc18xx.c   |  4 ++--
 .../ethernet/stmicro/stmmac/dwmac-mediatek.c  |  2 +-
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |  2 +-
 .../ethernet/stmicro/stmmac/dwmac-starfive.c  |  4 ++--
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c |  8 ++++----
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  6 +++---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  6 ++++--
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  6 +++---
 include/linux/stmmac.h                        | 15 +++++++++++++-
 12 files changed, 52 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 535856fffaea..df34e34cc14f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -70,7 +70,7 @@ static int imx8mp_set_intf_mode(struct plat_stmmacenet_data *plat_dat)
 	struct imx_priv_data *dwmac = plat_dat->bsp_priv;
 	int val;
 
-	switch (plat_dat->interface) {
+	switch (plat_dat->mac_interface) {
 	case PHY_INTERFACE_MODE_MII:
 		val = GPR_ENET_QOS_INTF_SEL_MII;
 		break;
@@ -87,7 +87,7 @@ static int imx8mp_set_intf_mode(struct plat_stmmacenet_data *plat_dat)
 		break;
 	default:
 		pr_debug("imx dwmac doesn't support %d interface\n",
-			 plat_dat->interface);
+			 plat_dat->mac_interface);
 		return -EINVAL;
 	}
 
@@ -110,7 +110,7 @@ static int imx93_set_intf_mode(struct plat_stmmacenet_data *plat_dat)
 	struct imx_priv_data *dwmac = plat_dat->bsp_priv;
 	int val;
 
-	switch (plat_dat->interface) {
+	switch (plat_dat->mac_interface) {
 	case PHY_INTERFACE_MODE_MII:
 		val = MX93_GPR_ENET_QOS_INTF_SEL_MII;
 		break;
@@ -125,7 +125,7 @@ static int imx93_set_intf_mode(struct plat_stmmacenet_data *plat_dat)
 		break;
 	default:
 		dev_dbg(dwmac->dev, "imx dwmac doesn't support %d interface\n",
-			 plat_dat->interface);
+			 plat_dat->mac_interface);
 		return -EINVAL;
 	}
 
@@ -192,8 +192,8 @@ static void imx_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int mod
 	plat_dat = dwmac->plat_dat;
 
 	if (dwmac->ops->mac_rgmii_txclk_auto_adj ||
-	    (plat_dat->interface == PHY_INTERFACE_MODE_RMII) ||
-	    (plat_dat->interface == PHY_INTERFACE_MODE_MII))
+	    (plat_dat->mac_interface == PHY_INTERFACE_MODE_RMII) ||
+	    (plat_dat->mac_interface == PHY_INTERFACE_MODE_MII))
 		return;
 
 	switch (speed) {
@@ -260,7 +260,7 @@ static int imx_dwmac_mx93_reset(void *priv, void __iomem *ioaddr)
 	value |= DMA_BUS_MODE_SFT_RESET;
 	writel(value, ioaddr + DMA_BUS_MODE);
 
-	if (plat_dat->interface == PHY_INTERFACE_MODE_RMII) {
+	if (plat_dat->mac_interface == PHY_INTERFACE_MODE_RMII) {
 		usleep_range(100, 200);
 		writel(RMII_RESET_SPEED, ioaddr + MAC_CTRL_REG);
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
index e22ef0d6bc73..0a20c3d24722 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
@@ -89,7 +89,7 @@ static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 	struct ingenic_mac *mac = plat_dat->bsp_priv;
 	unsigned int val;
 
-	switch (plat_dat->interface) {
+	switch (plat_dat->mac_interface) {
 	case PHY_INTERFACE_MODE_MII:
 		val = FIELD_PREP(MACPHYC_TXCLK_SEL_MASK, MACPHYC_TXCLK_SEL_INPUT) |
 			  FIELD_PREP(MACPHYC_PHY_INFT_MASK, MACPHYC_PHY_INFT_MII);
@@ -118,7 +118,7 @@ static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 		break;
 
 	default:
-		dev_err(mac->dev, "Unsupported interface %d", plat_dat->interface);
+		dev_err(mac->dev, "Unsupported interface %d", plat_dat->mac_interface);
 		return -EINVAL;
 	}
 
@@ -130,13 +130,13 @@ static int x1000_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 {
 	struct ingenic_mac *mac = plat_dat->bsp_priv;
 
-	switch (plat_dat->interface) {
+	switch (plat_dat->mac_interface) {
 	case PHY_INTERFACE_MODE_RMII:
 		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RMII\n");
 		break;
 
 	default:
-		dev_err(mac->dev, "Unsupported interface %d", plat_dat->interface);
+		dev_err(mac->dev, "Unsupported interface %d", plat_dat->mac_interface);
 		return -EINVAL;
 	}
 
@@ -149,14 +149,14 @@ static int x1600_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 	struct ingenic_mac *mac = plat_dat->bsp_priv;
 	unsigned int val;
 
-	switch (plat_dat->interface) {
+	switch (plat_dat->mac_interface) {
 	case PHY_INTERFACE_MODE_RMII:
 		val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, MACPHYC_PHY_INFT_RMII);
 		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RMII\n");
 		break;
 
 	default:
-		dev_err(mac->dev, "Unsupported interface %d", plat_dat->interface);
+		dev_err(mac->dev, "Unsupported interface %d", plat_dat->mac_interface);
 		return -EINVAL;
 	}
 
@@ -169,7 +169,7 @@ static int x1830_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 	struct ingenic_mac *mac = plat_dat->bsp_priv;
 	unsigned int val;
 
-	switch (plat_dat->interface) {
+	switch (plat_dat->mac_interface) {
 	case PHY_INTERFACE_MODE_RMII:
 		val = FIELD_PREP(MACPHYC_MODE_SEL_MASK, MACPHYC_MODE_SEL_RMII) |
 			  FIELD_PREP(MACPHYC_PHY_INFT_MASK, MACPHYC_PHY_INFT_RMII);
@@ -177,7 +177,7 @@ static int x1830_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 		break;
 
 	default:
-		dev_err(mac->dev, "Unsupported interface %d", plat_dat->interface);
+		dev_err(mac->dev, "Unsupported interface %d", plat_dat->mac_interface);
 		return -EINVAL;
 	}
 
@@ -190,7 +190,7 @@ static int x2000_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 	struct ingenic_mac *mac = plat_dat->bsp_priv;
 	unsigned int val;
 
-	switch (plat_dat->interface) {
+	switch (plat_dat->mac_interface) {
 	case PHY_INTERFACE_MODE_RMII:
 		val = FIELD_PREP(MACPHYC_TX_SEL_MASK, MACPHYC_TX_SEL_ORIGIN) |
 			  FIELD_PREP(MACPHYC_RX_SEL_MASK, MACPHYC_RX_SEL_ORIGIN) |
@@ -220,7 +220,7 @@ static int x2000_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 		break;
 
 	default:
-		dev_err(mac->dev, "Unsupported interface %d", plat_dat->interface);
+		dev_err(mac->dev, "Unsupported interface %d", plat_dat->mac_interface);
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index a25c187d3185..2cd6fce5c993 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -117,7 +117,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	}
 
 	plat->phy_interface = phy_mode;
-	plat->interface = PHY_INTERFACE_MODE_GMII;
+	plat->mac_interface = PHY_INTERFACE_MODE_GMII;
 
 	pci_set_master(pdev);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
index 18e84ba693a6..d0aa674ce705 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
@@ -50,9 +50,9 @@ static int lpc18xx_dwmac_probe(struct platform_device *pdev)
 		goto err_remove_config_dt;
 	}
 
-	if (plat_dat->interface == PHY_INTERFACE_MODE_MII) {
+	if (plat_dat->mac_interface == PHY_INTERFACE_MODE_MII) {
 		ethmode = LPC18XX_CREG_CREG6_ETHMODE_MII;
-	} else if (plat_dat->interface == PHY_INTERFACE_MODE_RMII) {
+	} else if (plat_dat->mac_interface == PHY_INTERFACE_MODE_RMII) {
 		ethmode = LPC18XX_CREG_CREG6_ETHMODE_RMII;
 	} else {
 		dev_err(&pdev->dev, "Only MII and RMII mode supported\n");
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
index 7580077383c0..cd796ec04132 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
@@ -587,7 +587,7 @@ static int mediatek_dwmac_common_data(struct platform_device *pdev,
 {
 	int i;
 
-	plat->interface = priv_plat->phy_mode;
+	plat->mac_interface = priv_plat->phy_mode;
 	if (priv_plat->mac_wol)
 		plat->flags |= STMMAC_FLAG_USE_PHY_WOL;
 	else
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 7db176e8691f..9bf102bbc6a0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -236,7 +236,7 @@ static int socfpga_get_plat_phymode(struct socfpga_dwmac *dwmac)
 	struct net_device *ndev = dev_get_drvdata(dwmac->dev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
 
-	return priv->plat->interface;
+	return priv->plat->mac_interface;
 }
 
 static void socfpga_sgmii_config(struct socfpga_dwmac *dwmac, bool enable)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
index 892612564694..9289bb87c3e3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
@@ -60,7 +60,7 @@ static int starfive_dwmac_set_mode(struct plat_stmmacenet_data *plat_dat)
 	unsigned int mode;
 	int err;
 
-	switch (plat_dat->interface) {
+	switch (plat_dat->mac_interface) {
 	case PHY_INTERFACE_MODE_RMII:
 		mode = STARFIVE_DWMAC_PHY_INFT_RMII;
 		break;
@@ -72,7 +72,7 @@ static int starfive_dwmac_set_mode(struct plat_stmmacenet_data *plat_dat)
 
 	default:
 		dev_err(dwmac->dev, "unsupported interface %d\n",
-			plat_dat->interface);
+			plat_dat->mac_interface);
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index 3a09085819dc..26ea8c687881 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -171,7 +171,7 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 
 	clk_rate = clk_get_rate(dwmac->clk_eth_ck);
 	dwmac->enable_eth_ck = false;
-	switch (plat_dat->interface) {
+	switch (plat_dat->mac_interface) {
 	case PHY_INTERFACE_MODE_MII:
 		if (clk_rate == ETH_CK_F_25M && dwmac->ext_phyclk)
 			dwmac->enable_eth_ck = true;
@@ -210,7 +210,7 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 		break;
 	default:
 		pr_debug("SYSCFG init :  Do not manage %d interface\n",
-			 plat_dat->interface);
+			 plat_dat->mac_interface);
 		/* Do not manage others interfaces */
 		return -EINVAL;
 	}
@@ -230,7 +230,7 @@ static int stm32mcu_set_mode(struct plat_stmmacenet_data *plat_dat)
 	u32 reg = dwmac->mode_reg;
 	int val;
 
-	switch (plat_dat->interface) {
+	switch (plat_dat->mac_interface) {
 	case PHY_INTERFACE_MODE_MII:
 		val = SYSCFG_MCU_ETH_SEL_MII;
 		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_MII\n");
@@ -241,7 +241,7 @@ static int stm32mcu_set_mode(struct plat_stmmacenet_data *plat_dat)
 		break;
 	default:
 		pr_debug("SYSCFG init :  Do not manage %d interface\n",
-			 plat_dat->interface);
+			 plat_dat->mac_interface);
 		/* Do not manage others interfaces */
 		return -EINVAL;
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index c23420863a8d..01e77368eef1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -1016,7 +1016,7 @@ static int sun8i_dwmac_set_syscon(struct device *dev,
 	if (gmac->variant->support_rmii)
 		reg &= ~SYSCON_RMII_EN;
 
-	switch (plat->interface) {
+	switch (plat->mac_interface) {
 	case PHY_INTERFACE_MODE_MII:
 		/* default */
 		break;
@@ -1031,7 +1031,7 @@ static int sun8i_dwmac_set_syscon(struct device *dev,
 		break;
 	default:
 		dev_err(dev, "Unsupported interface mode: %s",
-			phy_modes(plat->interface));
+			phy_modes(plat->mac_interface));
 		return -EINVAL;
 	}
 
@@ -1231,7 +1231,7 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
 	/* platform data specifying hardware features and callbacks.
 	 * hardware features were copied from Allwinner drivers.
 	 */
-	plat_dat->interface = interface;
+	plat_dat->mac_interface = interface;
 	plat_dat->rx_coe = STMMAC_RX_COE_TYPE2;
 	plat_dat->tx_coe = 1;
 	plat_dat->flags |= STMMAC_FLAG_HAS_SUN8I;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e52ae165c968..c92bab6e2341 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1119,7 +1119,7 @@ static const struct phylink_mac_ops stmmac_phylink_mac_ops = {
  */
 static void stmmac_check_pcs_mode(struct stmmac_priv *priv)
 {
-	int interface = priv->plat->interface;
+	int interface = priv->plat->mac_interface;
 
 	if (priv->dma_cap.pcs) {
 		if ((interface == PHY_INTERFACE_MODE_RGMII) ||
@@ -1214,7 +1214,9 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 		priv->phylink_config.ovr_an_inband =
 			mdio_bus_data->xpcs_an_inband;
 
-	/* Set the platform/firmware specified interface mode */
+	/* Set the platform/firmware specified interface mode. Note, phylink
+	 * deals with the PHY interface mode, not the MAC interface mode.
+	 */
 	__set_bit(mode, priv->phylink_config.supported_interfaces);
 
 	/* If we have an xpcs, it defines which PHY interfaces are supported. */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index ff330423ee66..35f4b1484029 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -419,9 +419,9 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 		return ERR_PTR(phy_mode);
 
 	plat->phy_interface = phy_mode;
-	plat->interface = stmmac_of_get_mac_mode(np);
-	if (plat->interface < 0)
-		plat->interface = plat->phy_interface;
+	plat->mac_interface = stmmac_of_get_mac_mode(np);
+	if (plat->mac_interface < 0)
+		plat->mac_interface = plat->phy_interface;
 
 	/* Some wrapper drivers still rely on phy_node. Let's save it while
 	 * they are not converted to phylink. */
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index b2ccd827bb80..ce89cc3e4913 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -223,7 +223,20 @@ struct dwmac4_addrs {
 struct plat_stmmacenet_data {
 	int bus_id;
 	int phy_addr;
-	int interface;
+	/* MAC ----- optional PCS ----- SerDes ----- optional PHY ----- Media
+	 *       ^                               ^
+	 * mac_interface                   phy_interface
+	 *
+	 * mac_interface is the MAC-side interface, which may be the same
+	 * as phy_interface if there is no intervening PCS. If there is a
+	 * PCS, then mac_interface describes the interface mode between the
+	 * MAC and PCS, and phy_interface describes the interface mode
+	 * between the PCS and PHY.
+	 */
+	phy_interface_t mac_interface;
+	/* phy_interface is the PHY-side interface - the interface used by
+	 * an attached PHY.
+	 */
 	phy_interface_t phy_interface;
 	struct stmmac_mdio_bus_data *mdio_bus_data;
 	struct device_node *phy_node;
-- 
2.30.2


