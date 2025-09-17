Return-Path: <netdev+bounces-224076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6B3B80764
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81BF18969E7
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736F132E726;
	Wed, 17 Sep 2025 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MKAuvQDt"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3058032E724
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121975; cv=none; b=E4BmW5j/KIYMlrlF6BrGRCUFrAwbe0x75je5dqVzJgFw1KQXBqCNC3MK8ljmj+FCeKzxwzRmLe4fvUYThRdk8D1P1bp5FAf95ICuDRLJZ2od67kJBTMrnHL6KZyuoHz9AUJE2SwXU0KvfzlO3sHPRdZbdemFgprATWsQID71s1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121975; c=relaxed/simple;
	bh=5O5bDgWLzFkQR68V4BrPdupJxphnTv/SOD7b9fnCtyo=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=a1/29wL5tQQchDLEAmoBQs2MLAkuar5/yABOrYzfh0d9TESjeVCj3qqmeDkKXKacBo+gtsch7+07QPW25pF/WaiWR6WrOtFOjjecM/vjZFWIJL/jnkKJAjEDy5TEP79El7jdNnS2mPG0xNXyBXp/nexnVT7VSuh8/y1IN3CfmZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MKAuvQDt; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yHSQ+RaFu0KBQqFTLVbeHlZC6n9bOFTaTq8CjHGDQOw=; b=MKAuvQDtEtgNfMzhwzjV8r8xgP
	MA40JSEfx2W+1qrr8SwP2ukornVJjksr1bNjlM2u8GrzNvFS2gnmrInqIPa3CIVQlBwasWSruJhtw
	lF4RPM2ySN1xcB7urXSizeXm73q3+OIPrPaNIqji8HTilKukU4QQGGUkJ7F/2LPK6a12KSY7okHOK
	iSwU6pzn1CjUQihhwZLDyjzHurthSlqDajFfhnzp2OGzbeKYZ0/eMOYs5xLXEXIE4TIgR6CNso4eC
	gHQGuc+bX2AyjCm3lTupCItG1qU2yIzRMSz8Ldqy8gKzsfXRcvgMwFnp+Drl+m1dn/Kh1t4O6DufU
	OpOF9rNQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58692 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uytpT-000000004kx-365Q;
	Wed, 17 Sep 2025 16:12:19 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uytpQ-00000006H2L-2Jzb;
	Wed, 17 Sep 2025 16:12:16 +0100
In-Reply-To: <aMrPpc8oRxqGtVPJ@shell.armlinux.org.uk>
References: <aMrPpc8oRxqGtVPJ@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chen-Yu Tsai <wens@csie.org>,
	"David S. Miller" <davem@davemloft.net>,
	Drew Fustini <fustini@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Fu Wei <wefu@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Samuel Holland <samuel@sholland.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH net-next 04/10] net: stmmac: ingenic: convert to use
 phy_interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uytpQ-00000006H2L-2Jzb@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 17 Sep 2025 16:12:16 +0100

dwmac-ingenic uses only MII, RMII, GMII or RGMII interface modes, none
of which require any kind of conversion between the MAC and external
world. Thus, mac_interface and phy_interface will be the same.

Convert dwmac-ingenic to use phy_interface when determining the
interface mode that the dwmac core should be configured to at reset,
rather than mac_interface.

Also convert the error prints to use phy_modes() and terminate with a
newline so that we get a human readable string rather than a number for
the interface mode.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac-ingenic.c   | 25 +++++++++++--------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
index 15abe214131f..c1670f6bae14 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
@@ -90,7 +90,7 @@ static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 	struct ingenic_mac *mac = plat_dat->bsp_priv;
 	unsigned int val;
 
-	switch (plat_dat->mac_interface) {
+	switch (plat_dat->phy_interface) {
 	case PHY_INTERFACE_MODE_MII:
 		val = FIELD_PREP(MACPHYC_TXCLK_SEL_MASK, MACPHYC_TXCLK_SEL_INPUT) |
 			  FIELD_PREP(MACPHYC_PHY_INFT_MASK, MACPHYC_PHY_INFT_MII);
@@ -119,7 +119,8 @@ static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 		break;
 
 	default:
-		dev_err(mac->dev, "Unsupported interface %d", plat_dat->mac_interface);
+		dev_err(mac->dev, "Unsupported interface %s\n",
+			phy_modes(plat_dat->phy_interface));
 		return -EINVAL;
 	}
 
@@ -131,13 +132,14 @@ static int x1000_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 {
 	struct ingenic_mac *mac = plat_dat->bsp_priv;
 
-	switch (plat_dat->mac_interface) {
+	switch (plat_dat->phy_interface) {
 	case PHY_INTERFACE_MODE_RMII:
 		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RMII\n");
 		break;
 
 	default:
-		dev_err(mac->dev, "Unsupported interface %d", plat_dat->mac_interface);
+		dev_err(mac->dev, "Unsupported interface %s\n",
+			phy_modes(plat_dat->phy_interface));
 		return -EINVAL;
 	}
 
@@ -150,14 +152,15 @@ static int x1600_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 	struct ingenic_mac *mac = plat_dat->bsp_priv;
 	unsigned int val;
 
-	switch (plat_dat->mac_interface) {
+	switch (plat_dat->phy_interface) {
 	case PHY_INTERFACE_MODE_RMII:
 		val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, MACPHYC_PHY_INFT_RMII);
 		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RMII\n");
 		break;
 
 	default:
-		dev_err(mac->dev, "Unsupported interface %d", plat_dat->mac_interface);
+		dev_err(mac->dev, "Unsupported interface %s\n",
+			phy_modes(plat_dat->phy_interface));
 		return -EINVAL;
 	}
 
@@ -170,7 +173,7 @@ static int x1830_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 	struct ingenic_mac *mac = plat_dat->bsp_priv;
 	unsigned int val;
 
-	switch (plat_dat->mac_interface) {
+	switch (plat_dat->phy_interface) {
 	case PHY_INTERFACE_MODE_RMII:
 		val = FIELD_PREP(MACPHYC_MODE_SEL_MASK, MACPHYC_MODE_SEL_RMII) |
 			  FIELD_PREP(MACPHYC_PHY_INFT_MASK, MACPHYC_PHY_INFT_RMII);
@@ -178,7 +181,8 @@ static int x1830_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 		break;
 
 	default:
-		dev_err(mac->dev, "Unsupported interface %d", plat_dat->mac_interface);
+		dev_err(mac->dev, "Unsupported interface %s\n",
+			phy_modes(plat_dat->phy_interface));
 		return -EINVAL;
 	}
 
@@ -191,7 +195,7 @@ static int x2000_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 	struct ingenic_mac *mac = plat_dat->bsp_priv;
 	unsigned int val;
 
-	switch (plat_dat->mac_interface) {
+	switch (plat_dat->phy_interface) {
 	case PHY_INTERFACE_MODE_RMII:
 		val = FIELD_PREP(MACPHYC_TX_SEL_MASK, MACPHYC_TX_SEL_ORIGIN) |
 			  FIELD_PREP(MACPHYC_RX_SEL_MASK, MACPHYC_RX_SEL_ORIGIN) |
@@ -221,7 +225,8 @@ static int x2000_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 		break;
 
 	default:
-		dev_err(mac->dev, "Unsupported interface %d", plat_dat->mac_interface);
+		dev_err(mac->dev, "Unsupported interface %s\n",
+			phy_modes(plat_dat->phy_interface));
 		return -EINVAL;
 	}
 
-- 
2.47.3


