Return-Path: <netdev+bounces-131968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CBA9900D4
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 12:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D7B1F24603
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A278E14D6E1;
	Fri,  4 Oct 2024 10:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Yrx5Azps"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D6813BAC3
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 10:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728037301; cv=none; b=kcf7jcpbSzMMgXPpII8FzTh7wpz8xGgO8cu1vlnCkmjSEA18f7Yv6yd1TXmewjWcGPChAp3dgFO+kFX/SNriTcwcRhI0fPXAXh4kLU/kZULhWN78Wr4SZjl+lxnTFB+45hzg7UBFUKzn8AeH/09aJZyX4fZiK7ZqDoX20K4Emdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728037301; c=relaxed/simple;
	bh=SdLLaPI29FQqZgh16eV5MPp7rRDii9jEdFwoxo0bXT4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=OcAZs7XbgCT1JPHLxWmgtTSRlDyUT2lmz4db6h4pX1otFX2uXB5x4K8aVm3zaLiOSOdKhrUHFTXwiol6UUSQ3QgyRRl/5FAyaaI/yxAvfkAReozAnoc7viMar2Zgfh4cgMEOdtHda5V6IXLvww81C268TcVrMqPjzkG3rHjV0kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Yrx5Azps; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ExI/ACmTdGnu2wl58XdTM2XBdiCewL3COzv5HbxtnQA=; b=Yrx5AzpsWcjlUubu8HwU5aGCne
	+StxVSkFAmKoQk85lm8UJcxY16jmd4APFJMAFG3xOpHrZ/EpSuh3uB8+uYfqdmEN0e3e2O5WTuLAS
	azTudeOfC+mnIaw+sgTuB0OgQuvpqR5M0buf2l1Mw/iQjWfj9/a1Q3gCJwtPKr8KIqfF3zLm1UhM/
	353Z+j3Ddcj0ExdzfJryCOpZjjxGjR/2YHI/rWjejw6qX4ufyN5WCH1Rnbi21+ecXY7XL9+ewjCCR
	+yNG1nGZkWOqhal1MVB2OedeohD37qLgB8fjRAq+ozzmuQ7imxu/XA3vr9zb7/nNqSovKQz7CQt6l
	TPDi0RTg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:45024 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1swfR7-0001iC-06;
	Fri, 04 Oct 2024 11:21:24 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1swfR4-006Dfm-AY; Fri, 04 Oct 2024 11:21:22 +0100
In-Reply-To: <Zv_BTd8UF7XbJF_e@shell.armlinux.org.uk>
References: <Zv_BTd8UF7XbJF_e@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 09/13] net: pcs: xpcs: add _modify() accessors
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1swfR4-006Dfm-AY@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 04 Oct 2024 11:21:22 +0100

The xpcs driver does a lot of read-modify-write operations on
registers, which leads to long-winded code to read the register, check
whether the read was successful, modify the value in some way, and then
write it back.

We have a mdiodev _modify() accessor that encapsulates this, and does
the register modification under the MDIO bus lock ensuring that the
modification is atomic with respect to other bus operations. Convert
the xpcs driver to use this accessor.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs-nxp.c |  24 ++---
 drivers/net/pcs/pcs-xpcs-wx.c  |  56 +++++------
 drivers/net/pcs/pcs-xpcs.c     | 165 +++++++++++++++------------------
 drivers/net/pcs/pcs-xpcs.h     |   1 +
 4 files changed, 104 insertions(+), 142 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs-nxp.c b/drivers/net/pcs/pcs-xpcs-nxp.c
index d16fc58cd48d..e8efe94cf4ec 100644
--- a/drivers/net/pcs/pcs-xpcs-nxp.c
+++ b/drivers/net/pcs/pcs-xpcs-nxp.c
@@ -152,26 +152,18 @@ static int nxp_sja1110_pma_config(struct dw_xpcs *xpcs,
 	/* Enable TX and RX PLLs and circuits.
 	 * Release reset of PMA to enable data flow to/from PCS.
 	 */
-	ret = xpcs_read(xpcs, MDIO_MMD_VEND2, SJA1110_POWERDOWN_ENABLE);
-	if (ret < 0)
-		return ret;
-
-	val = ret & ~(SJA1110_TXPLL_PD | SJA1110_TXPD | SJA1110_RXCH_PD |
-		      SJA1110_RXBIAS_PD | SJA1110_RESET_SER_EN |
-		      SJA1110_RESET_SER | SJA1110_RESET_DES);
-	val |= SJA1110_RXPKDETEN | SJA1110_RCVEN;
-
-	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, SJA1110_POWERDOWN_ENABLE, val);
+	ret = xpcs_modify(xpcs, MDIO_MMD_VEND2, SJA1110_POWERDOWN_ENABLE,
+			  SJA1110_TXPLL_PD | SJA1110_TXPD | SJA1110_RXCH_PD |
+			  SJA1110_RXBIAS_PD | SJA1110_RESET_SER_EN |
+			  SJA1110_RESET_SER | SJA1110_RESET_DES |
+			  SJA1110_RXPKDETEN | SJA1110_RCVEN,
+			  SJA1110_RXPKDETEN | SJA1110_RCVEN);
 	if (ret < 0)
 		return ret;
 
 	/* Program continuous-time linear equalizer (CTLE) settings. */
-	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, SJA1110_RX_CDR_CTLE,
-			 rx_cdr_ctle);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return xpcs_write(xpcs, MDIO_MMD_VEND2, SJA1110_RX_CDR_CTLE,
+			  rx_cdr_ctle);
 }
 
 int nxp_sja1110_sgmii_pma_config(struct dw_xpcs *xpcs)
diff --git a/drivers/net/pcs/pcs-xpcs-wx.c b/drivers/net/pcs/pcs-xpcs-wx.c
index 5f5cd3596cb8..fc52f7aa5f59 100644
--- a/drivers/net/pcs/pcs-xpcs-wx.c
+++ b/drivers/net/pcs/pcs-xpcs-wx.c
@@ -46,25 +46,23 @@
 #define TXGBE_VCO_CAL_LD0		0x72
 #define TXGBE_VCO_CAL_REF0		0x76
 
-static int txgbe_read_pma(struct dw_xpcs *xpcs, int reg)
+static int txgbe_write_pma(struct dw_xpcs *xpcs, int reg, u16 val)
 {
-	return xpcs_read(xpcs, MDIO_MMD_PMAPMD, TXGBE_PMA_MMD + reg);
+	return xpcs_write(xpcs, MDIO_MMD_PMAPMD, TXGBE_PMA_MMD + reg, val);
 }
 
-static int txgbe_write_pma(struct dw_xpcs *xpcs, int reg, u16 val)
+static int txgbe_modify_pma(struct dw_xpcs *xpcs, int reg, u16 mask, u16 set)
 {
-	return xpcs_write(xpcs, MDIO_MMD_PMAPMD, TXGBE_PMA_MMD + reg, val);
+	return xpcs_modify(xpcs, MDIO_MMD_PMAPMD, TXGBE_PMA_MMD + reg, mask,
+			   set);
 }
 
 static void txgbe_pma_config_10gbaser(struct dw_xpcs *xpcs)
 {
-	int val;
-
 	txgbe_write_pma(xpcs, TXGBE_MPLLA_CTL0, 0x21);
 	txgbe_write_pma(xpcs, TXGBE_MPLLA_CTL3, 0);
-	val = txgbe_read_pma(xpcs, TXGBE_TX_GENCTL1);
-	val = u16_replace_bits(val, 0x5, TXGBE_TX_GENCTL1_VBOOST_LVL);
-	txgbe_write_pma(xpcs, TXGBE_TX_GENCTL1, val);
+	txgbe_modify_pma(xpcs, TXGBE_TX_GENCTL1, TXGBE_TX_GENCTL1_VBOOST_LVL,
+			 FIELD_PREP(TXGBE_TX_GENCTL1_VBOOST_LVL, 0x5));
 	txgbe_write_pma(xpcs, TXGBE_MISC_CTL0, TXGBE_MISC_CTL0_PLL |
 			TXGBE_MISC_CTL0_CR_PARA_SEL | TXGBE_MISC_CTL0_RX_VREF(0xF));
 	txgbe_write_pma(xpcs, TXGBE_VCO_CAL_LD0, 0x549);
@@ -78,38 +76,29 @@ static void txgbe_pma_config_10gbaser(struct dw_xpcs *xpcs)
 
 	txgbe_write_pma(xpcs, TXGBE_RX_EQ_CTL0, TXGBE_RX_EQ_CTL0_CTLE_POLE(2) |
 			TXGBE_RX_EQ_CTL0_CTLE_BOOST(5));
-	val = txgbe_read_pma(xpcs, TXGBE_RX_EQ_ATTN_CTL);
-	val &= ~TXGBE_RX_EQ_ATTN_LVL0;
-	txgbe_write_pma(xpcs, TXGBE_RX_EQ_ATTN_CTL, val);
+	txgbe_modify_pma(xpcs, TXGBE_RX_EQ_ATTN_CTL, TXGBE_RX_EQ_ATTN_LVL0, 0);
 	txgbe_write_pma(xpcs, TXGBE_DFE_TAP_CTL0, 0xBE);
-	val = txgbe_read_pma(xpcs, TXGBE_AFE_DFE_ENABLE);
-	val &= ~(TXGBE_DFE_EN_0 | TXGBE_AFE_EN_0);
-	txgbe_write_pma(xpcs, TXGBE_AFE_DFE_ENABLE, val);
-	val = txgbe_read_pma(xpcs, TXGBE_RX_EQ_CTL4);
-	val &= ~TXGBE_RX_EQ_CTL4_CONT_ADAPT0;
-	txgbe_write_pma(xpcs, TXGBE_RX_EQ_CTL4, val);
+	txgbe_modify_pma(xpcs, TXGBE_AFE_DFE_ENABLE,
+			 TXGBE_DFE_EN_0 | TXGBE_AFE_EN_0, 0);
+	txgbe_modify_pma(xpcs, TXGBE_RX_EQ_CTL4, TXGBE_RX_EQ_CTL4_CONT_ADAPT0,
+			 0);
 }
 
 static void txgbe_pma_config_1g(struct dw_xpcs *xpcs)
 {
-	int val;
-
-	val = txgbe_read_pma(xpcs, TXGBE_TX_GENCTL1);
-	val = u16_replace_bits(val, 0x5, TXGBE_TX_GENCTL1_VBOOST_LVL);
-	val &= ~TXGBE_TX_GENCTL1_VBOOST_EN0;
-	txgbe_write_pma(xpcs, TXGBE_TX_GENCTL1, val);
+	txgbe_modify_pma(xpcs, TXGBE_TX_GENCTL1,
+			 TXGBE_TX_GENCTL1_VBOOST_LVL |
+			 TXGBE_TX_GENCTL1_VBOOST_EN0,
+			 FIELD_PREP(TXGBE_TX_GENCTL1_VBOOST_LVL, 0x5));
 	txgbe_write_pma(xpcs, TXGBE_MISC_CTL0, TXGBE_MISC_CTL0_PLL |
 			TXGBE_MISC_CTL0_CR_PARA_SEL | TXGBE_MISC_CTL0_RX_VREF(0xF));
 
 	txgbe_write_pma(xpcs, TXGBE_RX_EQ_CTL0, TXGBE_RX_EQ_CTL0_VGA1_GAIN(7) |
 			TXGBE_RX_EQ_CTL0_VGA2_GAIN(7) | TXGBE_RX_EQ_CTL0_CTLE_BOOST(6));
-	val = txgbe_read_pma(xpcs, TXGBE_RX_EQ_ATTN_CTL);
-	val &= ~TXGBE_RX_EQ_ATTN_LVL0;
-	txgbe_write_pma(xpcs, TXGBE_RX_EQ_ATTN_CTL, val);
+	txgbe_modify_pma(xpcs, TXGBE_RX_EQ_ATTN_CTL, TXGBE_RX_EQ_ATTN_LVL0, 0);
 	txgbe_write_pma(xpcs, TXGBE_DFE_TAP_CTL0, 0);
-	val = txgbe_read_pma(xpcs, TXGBE_RX_GEN_CTL3);
-	val = u16_replace_bits(val, 0x4, TXGBE_RX_GEN_CTL3_LOS_TRSHLD0);
-	txgbe_write_pma(xpcs, TXGBE_RX_GEN_CTL3, val);
+	txgbe_modify_pma(xpcs, TXGBE_RX_GEN_CTL3, TXGBE_RX_GEN_CTL3_LOS_TRSHLD0,
+			 FIELD_PREP(TXGBE_RX_GEN_CTL3_LOS_TRSHLD0, 0x4));
 
 	txgbe_write_pma(xpcs, TXGBE_MPLLA_CTL0, 0x20);
 	txgbe_write_pma(xpcs, TXGBE_MPLLA_CTL3, 0x46);
@@ -172,7 +161,7 @@ static bool txgbe_xpcs_mode_quirk(struct dw_xpcs *xpcs)
 
 int txgbe_xpcs_switch_mode(struct dw_xpcs *xpcs, phy_interface_t interface)
 {
-	int val, ret;
+	int ret;
 
 	switch (interface) {
 	case PHY_INTERFACE_MODE_10GBASER:
@@ -194,9 +183,8 @@ int txgbe_xpcs_switch_mode(struct dw_xpcs *xpcs, phy_interface_t interface)
 
 	if (interface == PHY_INTERFACE_MODE_10GBASER) {
 		xpcs_write(xpcs, MDIO_MMD_PCS, MDIO_CTRL2, MDIO_PCS_CTRL2_10GBR);
-		val = xpcs_read(xpcs, MDIO_MMD_PMAPMD, MDIO_CTRL1);
-		val |= MDIO_CTRL1_SPEED10G;
-		xpcs_write(xpcs, MDIO_MMD_PMAPMD, MDIO_CTRL1, val);
+		xpcs_modify(xpcs, MDIO_MMD_PMAPMD, MDIO_CTRL1,
+			    MDIO_CTRL1_SPEED10G, MDIO_CTRL1_SPEED10G);
 		txgbe_pma_config_10gbaser(xpcs);
 	} else {
 		xpcs_write(xpcs, MDIO_MMD_PCS, MDIO_CTRL2, MDIO_PCS_CTRL2_10GBX);
diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index f55bc180c624..5ac8262ac264 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -175,6 +175,11 @@ int xpcs_write(struct dw_xpcs *xpcs, int dev, u32 reg, u16 val)
 	return mdiodev_c45_write(xpcs->mdiodev, dev, reg, val);
 }
 
+int xpcs_modify(struct dw_xpcs *xpcs, int dev, u32 reg, u16 mask, u16 set)
+{
+	return mdiodev_c45_modify(xpcs->mdiodev, dev, reg, mask, set);
+}
+
 static int xpcs_modify_changed(struct dw_xpcs *xpcs, int dev, u32 reg,
 			       u16 mask, u16 set)
 {
@@ -192,6 +197,12 @@ static int xpcs_write_vendor(struct dw_xpcs *xpcs, int dev, int reg,
 	return xpcs_write(xpcs, dev, DW_VENDOR | reg, val);
 }
 
+static int xpcs_modify_vendor(struct dw_xpcs *xpcs, int dev, int reg, u16 mask,
+			      u16 set)
+{
+	return xpcs_modify(xpcs, dev, DW_VENDOR | reg, mask, set);
+}
+
 int xpcs_read_vpcs(struct dw_xpcs *xpcs, int reg)
 {
 	return xpcs_read_vendor(xpcs, MDIO_MMD_PCS, reg);
@@ -202,6 +213,11 @@ int xpcs_write_vpcs(struct dw_xpcs *xpcs, int reg, u16 val)
 	return xpcs_write_vendor(xpcs, MDIO_MMD_PCS, reg, val);
 }
 
+static int xpcs_modify_vpcs(struct dw_xpcs *xpcs, int reg, u16 mask, u16 val)
+{
+	return xpcs_modify_vendor(xpcs, MDIO_MMD_PCS, reg, mask, val);
+}
+
 static int xpcs_poll_reset(struct dw_xpcs *xpcs, int dev)
 {
 	/* Poll until the reset bit clears (50ms per retry == 0.6 sec) */
@@ -326,30 +342,17 @@ static void xpcs_config_usxgmii(struct dw_xpcs *xpcs, int speed)
 		return;
 	}
 
-	ret = xpcs_read_vpcs(xpcs, MDIO_CTRL1);
+	ret = xpcs_modify_vpcs(xpcs, MDIO_CTRL1, DW_USXGMII_EN, DW_USXGMII_EN);
 	if (ret < 0)
 		goto out;
 
-	ret = xpcs_write_vpcs(xpcs, MDIO_CTRL1, ret | DW_USXGMII_EN);
+	ret = xpcs_modify(xpcs, MDIO_MMD_VEND2, MDIO_CTRL1, DW_USXGMII_SS_MASK,
+			  speed_sel | DW_USXGMII_FULL);
 	if (ret < 0)
 		goto out;
 
-	ret = xpcs_read(xpcs, MDIO_MMD_VEND2, MDIO_CTRL1);
-	if (ret < 0)
-		goto out;
-
-	ret &= ~DW_USXGMII_SS_MASK;
-	ret |= speed_sel | DW_USXGMII_FULL;
-
-	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MDIO_CTRL1, ret);
-	if (ret < 0)
-		goto out;
-
-	ret = xpcs_read_vpcs(xpcs, MDIO_CTRL1);
-	if (ret < 0)
-		goto out;
-
-	ret = xpcs_write_vpcs(xpcs, MDIO_CTRL1, ret | DW_USXGMII_RST);
+	ret = xpcs_modify_vpcs(xpcs, MDIO_CTRL1, DW_USXGMII_RST,
+			       DW_USXGMII_RST);
 	if (ret < 0)
 		goto out;
 
@@ -413,13 +416,9 @@ static int xpcs_config_aneg_c73(struct dw_xpcs *xpcs,
 	if (ret < 0)
 		return ret;
 
-	ret = xpcs_read(xpcs, MDIO_MMD_AN, MDIO_CTRL1);
-	if (ret < 0)
-		return ret;
-
-	ret |= MDIO_AN_CTRL1_ENABLE | MDIO_AN_CTRL1_RESTART;
-
-	return xpcs_write(xpcs, MDIO_MMD_AN, MDIO_CTRL1, ret);
+	return xpcs_modify(xpcs, MDIO_MMD_AN, MDIO_CTRL1,
+			   MDIO_AN_CTRL1_ENABLE | MDIO_AN_CTRL1_RESTART,
+			   MDIO_AN_CTRL1_ENABLE | MDIO_AN_CTRL1_RESTART);
 }
 
 static int xpcs_aneg_done_c73(struct dw_xpcs *xpcs,
@@ -581,40 +580,31 @@ EXPORT_SYMBOL_GPL(xpcs_get_interfaces);
 
 int xpcs_config_eee(struct dw_xpcs *xpcs, int mult_fact_100ns, int enable)
 {
+	u16 mask, val;
 	int ret;
 
-	ret = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_EEE_MCTRL0);
-	if (ret < 0)
-		return ret;
+	mask = DW_VR_MII_EEE_LTX_EN | DW_VR_MII_EEE_LRX_EN |
+	       DW_VR_MII_EEE_TX_QUIET_EN | DW_VR_MII_EEE_RX_QUIET_EN |
+	       DW_VR_MII_EEE_TX_EN_CTRL | DW_VR_MII_EEE_RX_EN_CTRL |
+	       DW_VR_MII_EEE_MULT_FACT_100NS;
 
-	if (enable) {
-	/* Enable EEE */
-		ret = DW_VR_MII_EEE_LTX_EN | DW_VR_MII_EEE_LRX_EN |
+	if (enable)
+		val = DW_VR_MII_EEE_LTX_EN | DW_VR_MII_EEE_LRX_EN |
 		      DW_VR_MII_EEE_TX_QUIET_EN | DW_VR_MII_EEE_RX_QUIET_EN |
 		      DW_VR_MII_EEE_TX_EN_CTRL | DW_VR_MII_EEE_RX_EN_CTRL |
 		      FIELD_PREP(DW_VR_MII_EEE_MULT_FACT_100NS,
 				 mult_fact_100ns);
-	} else {
-		ret &= ~(DW_VR_MII_EEE_LTX_EN | DW_VR_MII_EEE_LRX_EN |
-		       DW_VR_MII_EEE_TX_QUIET_EN | DW_VR_MII_EEE_RX_QUIET_EN |
-		       DW_VR_MII_EEE_TX_EN_CTRL | DW_VR_MII_EEE_RX_EN_CTRL |
-		       DW_VR_MII_EEE_MULT_FACT_100NS);
-	}
-
-	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_EEE_MCTRL0, ret);
-	if (ret < 0)
-		return ret;
+	else
+		val = 0;
 
-	ret = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_EEE_MCTRL1);
+	ret = xpcs_modify(xpcs, MDIO_MMD_VEND2, DW_VR_MII_EEE_MCTRL0, mask,
+			  val);
 	if (ret < 0)
 		return ret;
 
-	if (enable)
-		ret |= DW_VR_MII_EEE_TRN_LPI;
-	else
-		ret &= ~DW_VR_MII_EEE_TRN_LPI;
-
-	return xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_EEE_MCTRL1, ret);
+	return xpcs_modify(xpcs, MDIO_MMD_VEND2, DW_VR_MII_EEE_MCTRL1,
+			   DW_VR_MII_EEE_TRN_LPI,
+			   enable ? DW_VR_MII_EEE_TRN_LPI : 0);
 }
 EXPORT_SYMBOL_GPL(xpcs_config_eee);
 
@@ -646,6 +636,7 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 				      unsigned int neg_mode)
 {
 	int ret, mdio_ctrl, tx_conf;
+	u16 mask, val;
 
 	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID)
 		xpcs_write_vpcs(xpcs, DW_VR_XS_PCS_DIG_CTRL1, DW_CL37_BP | DW_EN_VSMMD1);
@@ -677,38 +668,35 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 			return ret;
 	}
 
-	ret = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_CTRL);
-	if (ret < 0)
-		return ret;
+	mask = DW_VR_MII_PCS_MODE_MASK | DW_VR_MII_TX_CONFIG_MASK;
+	val = FIELD_PREP(DW_VR_MII_PCS_MODE_MASK,
+			 DW_VR_MII_PCS_MODE_C37_SGMII);
 
-	ret &= ~(DW_VR_MII_PCS_MODE_MASK | DW_VR_MII_TX_CONFIG_MASK);
-	ret |= FIELD_PREP(DW_VR_MII_PCS_MODE_MASK,
-			  DW_VR_MII_PCS_MODE_C37_SGMII);
 	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
-		ret |= DW_VR_MII_AN_CTRL_8BIT;
+		mask |= DW_VR_MII_AN_CTRL_8BIT;
+		val |= DW_VR_MII_AN_CTRL_8BIT;
 		/* Hardware requires it to be PHY side SGMII */
 		tx_conf = DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII;
 	} else {
 		tx_conf = DW_VR_MII_TX_CONFIG_MAC_SIDE_SGMII;
 	}
-	ret |= FIELD_PREP(DW_VR_MII_TX_CONFIG_MASK, tx_conf);
-	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_CTRL, ret);
-	if (ret < 0)
-		return ret;
 
-	ret = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_DIG_CTRL1);
+	val |= FIELD_PREP(DW_VR_MII_TX_CONFIG_MASK, tx_conf);
+
+	ret = xpcs_modify(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_CTRL, mask, val);
 	if (ret < 0)
 		return ret;
 
+	mask = DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW;
 	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
-		ret |= DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW;
-	else
-		ret &= ~DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW;
+		val = DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW;
 
-	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID)
-		ret |= DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL;
+	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
+		mask |= DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL;
+		val |= DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL;
+	}
 
-	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_DIG_CTRL1, ret);
+	ret = xpcs_modify(xpcs, MDIO_MMD_VEND2, DW_VR_MII_DIG_CTRL1, mask, val);
 	if (ret < 0)
 		return ret;
 
@@ -726,6 +714,7 @@ static int xpcs_config_aneg_c37_1000basex(struct dw_xpcs *xpcs,
 	phy_interface_t interface = PHY_INTERFACE_MODE_1000BASEX;
 	int ret, mdio_ctrl, adv;
 	bool changed = 0;
+	u16 mask, val;
 
 	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID)
 		xpcs_write_vpcs(xpcs, DW_VR_XS_PCS_DIG_CTRL1, DW_CL37_BP | DW_EN_VSMMD1);
@@ -746,14 +735,16 @@ static int xpcs_config_aneg_c37_1000basex(struct dw_xpcs *xpcs,
 			return ret;
 	}
 
-	ret = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_CTRL);
-	if (ret < 0)
-		return ret;
+	mask = DW_VR_MII_PCS_MODE_MASK;
+	val = FIELD_PREP(DW_VR_MII_PCS_MODE_MASK,
+			 DW_VR_MII_PCS_MODE_C37_1000BASEX);
+
+	if (!xpcs->pcs.poll) {
+		mask |= DW_VR_MII_AN_INTR_EN;
+		val |= DW_VR_MII_AN_INTR_EN;
+	}
 
-	ret &= ~DW_VR_MII_PCS_MODE_MASK;
-	if (!xpcs->pcs.poll)
-		ret |= DW_VR_MII_AN_INTR_EN;
-	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_CTRL, ret);
+	ret = xpcs_modify(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_CTRL, mask, val);
 	if (ret < 0)
 		return ret;
 
@@ -790,22 +781,16 @@ static int xpcs_config_2500basex(struct dw_xpcs *xpcs)
 {
 	int ret;
 
-	ret = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_DIG_CTRL1);
-	if (ret < 0)
-		return ret;
-	ret |= DW_VR_MII_DIG_CTRL1_2G5_EN;
-	ret &= ~DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW;
-	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_DIG_CTRL1, ret);
+	ret = xpcs_modify(xpcs, MDIO_MMD_VEND2, DW_VR_MII_DIG_CTRL1,
+			  DW_VR_MII_DIG_CTRL1_2G5_EN |
+			  DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW,
+			  DW_VR_MII_DIG_CTRL1_2G5_EN);
 	if (ret < 0)
 		return ret;
 
-	ret = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_CTRL);
-	if (ret < 0)
-		return ret;
-	ret &= ~AN_CL37_EN;
-	ret |= SGMII_SPEED_SS6;
-	ret &= ~SGMII_SPEED_SS13;
-	return xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_CTRL, ret);
+	return xpcs_modify(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_CTRL,
+			   AN_CL37_EN | SGMII_SPEED_SS6 | SGMII_SPEED_SS13,
+			   SGMII_SPEED_SS6);
 }
 
 static int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
@@ -1179,13 +1164,9 @@ static void xpcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
 static void xpcs_an_restart(struct phylink_pcs *pcs)
 {
 	struct dw_xpcs *xpcs = phylink_pcs_to_xpcs(pcs);
-	int ret;
 
-	ret = xpcs_read(xpcs, MDIO_MMD_VEND2, MDIO_CTRL1);
-	if (ret >= 0) {
-		ret |= BMCR_ANRESTART;
-		xpcs_write(xpcs, MDIO_MMD_VEND2, MDIO_CTRL1, ret);
-	}
+	xpcs_modify(xpcs, MDIO_MMD_VEND2, MDIO_CTRL1, BMCR_ANRESTART,
+		    BMCR_ANRESTART);
 }
 
 static int xpcs_read_ids(struct dw_xpcs *xpcs)
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index 8902485730a2..b80b956ec286 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -139,6 +139,7 @@ struct dw_xpcs {
 
 int xpcs_read(struct dw_xpcs *xpcs, int dev, u32 reg);
 int xpcs_write(struct dw_xpcs *xpcs, int dev, u32 reg, u16 val);
+int xpcs_modify(struct dw_xpcs *xpcs, int dev, u32 reg, u16 mask, u16 set);
 int xpcs_read_vpcs(struct dw_xpcs *xpcs, int reg);
 int xpcs_write_vpcs(struct dw_xpcs *xpcs, int reg, u16 val);
 int nxp_sja1105_sgmii_pma_config(struct dw_xpcs *xpcs);
-- 
2.30.2


