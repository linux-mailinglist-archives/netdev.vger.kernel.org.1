Return-Path: <netdev+bounces-238472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A037C59680
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 19:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7574B4FBC30
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 17:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63A621323C;
	Thu, 13 Nov 2025 17:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Qjt3WF/E"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5327C2877FA
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 17:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763056014; cv=none; b=Ohm0m2MXxiu7gxhYFU8bL5ePbAn9dVmG3SbtLSdB4rniNTMHIRGftbv3Ka3YZ4Jw71Nba/OUFPZ2Qr0B+jQI5bCG1dN68ds05Pl7avdu94oJ76ugURSm3V9SmN5StaNmiD9LyLTa4J32VrmRvElwROeBVdYNzi386VA5eaei8GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763056014; c=relaxed/simple;
	bh=v4268DXMIx811Pw3H14PANpGx15g7XKLRYrHAID9R4o=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ks3UMxgSMGnZIZiscxsnZKk/ZKCmUXFqA1JeZidW7aNy6mSfJOvPjmYRUzLn565dMB/HejhP5rFylvwfux6xzAdS9tdgbW2FWwYLVfczdD+uLiy1+xa+/9WP9Z0VcD96chPtteBPk3rY2Eyr98fHMZmVzxd/0uNQXj2HkwNKk2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Qjt3WF/E; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NO6IIoEQNRWpFvMuTQ6qp1i2naIx7VdqjocOSF9i4p8=; b=Qjt3WF/EKcvgZrqTNW5FHAFcmy
	zhthRxx0x2k9Gs97jsK+tmQRe7Ai1XDrcZc3WKITYjLh9j5QSdoZd7Uj26sXHDuR1wvjm0Kme3/v1
	+07O+0LpUTPfqOsAT9jzgg1i4CZffs26fWOJHxO8096EV2PVJvBHHgTCG3i816dHdNb7/KFjpZSwm
	pxFW+yY6jf6w5AacTl96QQC0dtSYsB7qMJlyIs24XY72yrZv4orI5ym43OE/B9/e58L3QBk8w1kdK
	Ubkh6yd/BmsFBTllIlAYEgyWB8fA/jRem8p3t4ySrxNmDrN1WC8mBGbXRvngNnnaMw2hb5zDXGR8m
	9HLpb99g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57060 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vJbP7-000000005no-13m2;
	Thu, 13 Nov 2025 17:46:41 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vJbP6-0000000EBqP-1cmm;
	Thu, 13 Nov 2025 17:46:40 +0000
In-Reply-To: <aRYZaKTIvfYoV3wE@shell.armlinux.org.uk>
References: <aRYZaKTIvfYoV3wE@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 2/4] net: stmmac: rk: convert all bitfields to
 GRF_FIELD*()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vJbP6-0000000EBqP-1cmm@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 13 Nov 2025 17:46:40 +0000

Convert all bitfields to GRF_FIELD() or GRF_FIELD_CONST(), which makes
the bitfield values more readable, and also allows the aarch64 compiler
to produce better code.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 136 ++++++++----------
 1 file changed, 57 insertions(+), 79 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 794a7ed71451..4257cc1f66e9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -151,6 +151,8 @@ static int rk_set_clk_mac_speed(struct rk_priv_data *bsp_priv,
 
 #define GRF_FIELD(hi, lo, val)		\
 	FIELD_PREP_WM16(GENMASK_U16(hi, lo), val)
+#define GRF_FIELD_CONST(hi, lo, val)	\
+	FIELD_PREP_WM16_CONST(GENMASK_U16(hi, lo), val)
 
 #define GRF_BIT(nr)			(BIT(nr) | BIT(nr+16))
 #define GRF_CLR_BIT(nr)			(BIT(nr+16))
@@ -167,7 +169,7 @@ static int rk_set_clk_mac_speed(struct rk_priv_data *bsp_priv,
 #define RK_MACPHY_ENABLE		GRF_BIT(0)
 #define RK_MACPHY_DISABLE		GRF_CLR_BIT(0)
 #define RK_MACPHY_CFG_CLK_50M		GRF_BIT(14)
-#define RK_GMAC2PHY_RMII_MODE		(GRF_BIT(6) | GRF_CLR_BIT(7))
+#define RK_GMAC2PHY_RMII_MODE		GRF_FIELD(7, 6, 1)
 #define RK_GRF_CON2_MACPHY_ID		GRF_FIELD(15, 0, 0x1234)
 #define RK_GRF_CON3_MACPHY_ID		GRF_FIELD(5, 0, 0x35)
 
@@ -203,7 +205,7 @@ static void rk_gmac_integrated_ephy_powerdown(struct rk_priv_data *priv)
 #define RK_FEPHY_SHUTDOWN		GRF_BIT(1)
 #define RK_FEPHY_POWERUP		GRF_CLR_BIT(1)
 #define RK_FEPHY_INTERNAL_RMII_SEL	GRF_BIT(6)
-#define RK_FEPHY_24M_CLK_SEL		(GRF_BIT(8) | GRF_BIT(9))
+#define RK_FEPHY_24M_CLK_SEL		GRF_FIELD(9, 8, 3)
 #define RK_FEPHY_PHY_ID			GRF_BIT(11)
 
 static void rk_gmac_integrated_fephy_powerup(struct rk_priv_data *priv,
@@ -232,8 +234,7 @@ static void rk_gmac_integrated_fephy_powerdown(struct rk_priv_data *priv,
 #define PX30_GRF_GMAC_CON1		0x0904
 
 /* PX30_GRF_GMAC_CON1 */
-#define PX30_GMAC_PHY_INTF_SEL_RMII	(GRF_CLR_BIT(4) | GRF_CLR_BIT(5) | \
-					 GRF_BIT(6))
+#define PX30_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(6, 4, 4)
 #define PX30_GMAC_SPEED_10M		GRF_CLR_BIT(2)
 #define PX30_GMAC_SPEED_100M		GRF_BIT(2)
 
@@ -289,19 +290,17 @@ static const struct rk_gmac_ops px30_ops = {
 #define RK3128_GMAC_CLK_TX_DL_CFG(val) GRF_FIELD(6, 0, val)
 
 /* RK3128_GRF_MAC_CON1 */
-#define RK3128_GMAC_PHY_INTF_SEL_RGMII	\
-		(GRF_BIT(6) | GRF_CLR_BIT(7) | GRF_CLR_BIT(8))
-#define RK3128_GMAC_PHY_INTF_SEL_RMII	\
-		(GRF_CLR_BIT(6) | GRF_CLR_BIT(7) | GRF_BIT(8))
+#define RK3128_GMAC_PHY_INTF_SEL_RGMII GRF_FIELD(8, 6, 1)
+#define RK3128_GMAC_PHY_INTF_SEL_RMII  GRF_FIELD(8, 6, 4)
 #define RK3128_GMAC_FLOW_CTRL          GRF_BIT(9)
 #define RK3128_GMAC_FLOW_CTRL_CLR      GRF_CLR_BIT(9)
 #define RK3128_GMAC_SPEED_10M          GRF_CLR_BIT(10)
 #define RK3128_GMAC_SPEED_100M         GRF_BIT(10)
 #define RK3128_GMAC_RMII_CLK_25M       GRF_BIT(11)
 #define RK3128_GMAC_RMII_CLK_2_5M      GRF_CLR_BIT(11)
-#define RK3128_GMAC_CLK_125M           (GRF_CLR_BIT(12) | GRF_CLR_BIT(13))
-#define RK3128_GMAC_CLK_25M            (GRF_BIT(12) | GRF_BIT(13))
-#define RK3128_GMAC_CLK_2_5M           (GRF_CLR_BIT(12) | GRF_BIT(13))
+#define RK3128_GMAC_CLK_125M           GRF_FIELD_CONST(13, 12, 0)
+#define RK3128_GMAC_CLK_25M            GRF_FIELD_CONST(13, 12, 3)
+#define RK3128_GMAC_CLK_2_5M           GRF_FIELD_CONST(13, 12, 2)
 #define RK3128_GMAC_RMII_MODE          GRF_BIT(14)
 #define RK3128_GMAC_RMII_MODE_CLR      GRF_CLR_BIT(14)
 
@@ -354,19 +353,17 @@ static const struct rk_gmac_ops rk3128_ops = {
 #define RK3228_GMAC_CLK_TX_DL_CFG(val)	GRF_FIELD(6, 0, val)
 
 /* RK3228_GRF_MAC_CON1 */
-#define RK3228_GMAC_PHY_INTF_SEL_RGMII	\
-		(GRF_BIT(4) | GRF_CLR_BIT(5) | GRF_CLR_BIT(6))
-#define RK3228_GMAC_PHY_INTF_SEL_RMII	\
-		(GRF_CLR_BIT(4) | GRF_CLR_BIT(5) | GRF_BIT(6))
+#define RK3228_GMAC_PHY_INTF_SEL_RGMII	GRF_FIELD(6, 4, 1)
+#define RK3228_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(6, 4, 4)
 #define RK3228_GMAC_FLOW_CTRL		GRF_BIT(3)
 #define RK3228_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
 #define RK3228_GMAC_SPEED_10M		GRF_CLR_BIT(2)
 #define RK3228_GMAC_SPEED_100M		GRF_BIT(2)
 #define RK3228_GMAC_RMII_CLK_25M	GRF_BIT(7)
 #define RK3228_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(7)
-#define RK3228_GMAC_CLK_125M		(GRF_CLR_BIT(8) | GRF_CLR_BIT(9))
-#define RK3228_GMAC_CLK_25M		(GRF_BIT(8) | GRF_BIT(9))
-#define RK3228_GMAC_CLK_2_5M		(GRF_CLR_BIT(8) | GRF_BIT(9))
+#define RK3228_GMAC_CLK_125M		GRF_FIELD_CONST(9, 8, 0)
+#define RK3228_GMAC_CLK_25M		GRF_FIELD_CONST(9, 8, 3)
+#define RK3228_GMAC_CLK_2_5M		GRF_FIELD_CONST(9, 8, 2)
 #define RK3228_GMAC_RMII_MODE		GRF_BIT(10)
 #define RK3228_GMAC_RMII_MODE_CLR	GRF_CLR_BIT(10)
 #define RK3228_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(0)
@@ -435,19 +432,17 @@ static const struct rk_gmac_ops rk3228_ops = {
 #define RK3288_GRF_SOC_CON3	0x0250
 
 /*RK3288_GRF_SOC_CON1*/
-#define RK3288_GMAC_PHY_INTF_SEL_RGMII	(GRF_BIT(6) | GRF_CLR_BIT(7) | \
-					 GRF_CLR_BIT(8))
-#define RK3288_GMAC_PHY_INTF_SEL_RMII	(GRF_CLR_BIT(6) | GRF_CLR_BIT(7) | \
-					 GRF_BIT(8))
+#define RK3288_GMAC_PHY_INTF_SEL_RGMII	GRF_FIELD(8, 6, 1)
+#define RK3288_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(8, 6, 4)
 #define RK3288_GMAC_FLOW_CTRL		GRF_BIT(9)
 #define RK3288_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(9)
 #define RK3288_GMAC_SPEED_10M		GRF_CLR_BIT(10)
 #define RK3288_GMAC_SPEED_100M		GRF_BIT(10)
 #define RK3288_GMAC_RMII_CLK_25M	GRF_BIT(11)
 #define RK3288_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(11)
-#define RK3288_GMAC_CLK_125M		(GRF_CLR_BIT(12) | GRF_CLR_BIT(13))
-#define RK3288_GMAC_CLK_25M		(GRF_BIT(12) | GRF_BIT(13))
-#define RK3288_GMAC_CLK_2_5M		(GRF_CLR_BIT(12) | GRF_BIT(13))
+#define RK3288_GMAC_CLK_125M		GRF_FIELD_CONST(13, 12, 0)
+#define RK3288_GMAC_CLK_25M		GRF_FIELD_CONST(13, 12, 3)
+#define RK3288_GMAC_CLK_2_5M		GRF_FIELD_CONST(13, 12, 2)
 #define RK3288_GMAC_RMII_MODE		GRF_BIT(14)
 #define RK3288_GMAC_RMII_MODE_CLR	GRF_CLR_BIT(14)
 
@@ -501,8 +496,7 @@ static const struct rk_gmac_ops rk3288_ops = {
 #define RK3308_GRF_MAC_CON0		0x04a0
 
 /* RK3308_GRF_MAC_CON0 */
-#define RK3308_GMAC_PHY_INTF_SEL_RMII	(GRF_CLR_BIT(2) | GRF_CLR_BIT(3) | \
-					GRF_BIT(4))
+#define RK3308_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(4, 2, 4)
 #define RK3308_GMAC_FLOW_CTRL		GRF_BIT(3)
 #define RK3308_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
 #define RK3308_GMAC_SPEED_10M		GRF_CLR_BIT(0)
@@ -541,19 +535,17 @@ static const struct rk_gmac_ops rk3308_ops = {
 #define RK3328_GMAC_CLK_TX_DL_CFG(val)	GRF_FIELD(6, 0, val)
 
 /* RK3328_GRF_MAC_CON1 */
-#define RK3328_GMAC_PHY_INTF_SEL_RGMII	\
-		(GRF_BIT(4) | GRF_CLR_BIT(5) | GRF_CLR_BIT(6))
-#define RK3328_GMAC_PHY_INTF_SEL_RMII	\
-		(GRF_CLR_BIT(4) | GRF_CLR_BIT(5) | GRF_BIT(6))
+#define RK3328_GMAC_PHY_INTF_SEL_RGMII	GRF_FIELD(6, 4, 1)
+#define RK3328_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(6, 4, 4)
 #define RK3328_GMAC_FLOW_CTRL		GRF_BIT(3)
 #define RK3328_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
 #define RK3328_GMAC_SPEED_10M		GRF_CLR_BIT(2)
 #define RK3328_GMAC_SPEED_100M		GRF_BIT(2)
 #define RK3328_GMAC_RMII_CLK_25M	GRF_BIT(7)
 #define RK3328_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(7)
-#define RK3328_GMAC_CLK_125M		(GRF_CLR_BIT(11) | GRF_CLR_BIT(12))
-#define RK3328_GMAC_CLK_25M		(GRF_BIT(11) | GRF_BIT(12))
-#define RK3328_GMAC_CLK_2_5M		(GRF_CLR_BIT(11) | GRF_BIT(12))
+#define RK3328_GMAC_CLK_125M		GRF_FIELD_CONST(12, 11, 0)
+#define RK3328_GMAC_CLK_25M		GRF_FIELD_CONST(12, 11, 3)
+#define RK3328_GMAC_CLK_2_5M		GRF_FIELD_CONST(12, 11, 2)
 #define RK3328_GMAC_RMII_MODE		GRF_BIT(9)
 #define RK3328_GMAC_RMII_MODE_CLR	GRF_CLR_BIT(9)
 #define RK3328_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(0)
@@ -630,19 +622,17 @@ static const struct rk_gmac_ops rk3328_ops = {
 #define RK3366_GRF_SOC_CON7	0x041c
 
 /* RK3366_GRF_SOC_CON6 */
-#define RK3366_GMAC_PHY_INTF_SEL_RGMII	(GRF_BIT(9) | GRF_CLR_BIT(10) | \
-					 GRF_CLR_BIT(11))
-#define RK3366_GMAC_PHY_INTF_SEL_RMII	(GRF_CLR_BIT(9) | GRF_CLR_BIT(10) | \
-					 GRF_BIT(11))
+#define RK3366_GMAC_PHY_INTF_SEL_RGMII	GRF_FIELD(11, 9, 1)
+#define RK3366_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(11, 9, 4)
 #define RK3366_GMAC_FLOW_CTRL		GRF_BIT(8)
 #define RK3366_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(8)
 #define RK3366_GMAC_SPEED_10M		GRF_CLR_BIT(7)
 #define RK3366_GMAC_SPEED_100M		GRF_BIT(7)
 #define RK3366_GMAC_RMII_CLK_25M	GRF_BIT(3)
 #define RK3366_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
-#define RK3366_GMAC_CLK_125M		(GRF_CLR_BIT(4) | GRF_CLR_BIT(5))
-#define RK3366_GMAC_CLK_25M		(GRF_BIT(4) | GRF_BIT(5))
-#define RK3366_GMAC_CLK_2_5M		(GRF_CLR_BIT(4) | GRF_BIT(5))
+#define RK3366_GMAC_CLK_125M		GRF_FIELD_CONST(5, 4, 0)
+#define RK3366_GMAC_CLK_25M		GRF_FIELD_CONST(5, 4, 3)
+#define RK3366_GMAC_CLK_2_5M		GRF_FIELD_CONST(5, 4, 2)
 #define RK3366_GMAC_RMII_MODE		GRF_BIT(6)
 #define RK3366_GMAC_RMII_MODE_CLR	GRF_CLR_BIT(6)
 
@@ -697,19 +687,17 @@ static const struct rk_gmac_ops rk3366_ops = {
 #define RK3368_GRF_SOC_CON16	0x0440
 
 /* RK3368_GRF_SOC_CON15 */
-#define RK3368_GMAC_PHY_INTF_SEL_RGMII	(GRF_BIT(9) | GRF_CLR_BIT(10) | \
-					 GRF_CLR_BIT(11))
-#define RK3368_GMAC_PHY_INTF_SEL_RMII	(GRF_CLR_BIT(9) | GRF_CLR_BIT(10) | \
-					 GRF_BIT(11))
+#define RK3368_GMAC_PHY_INTF_SEL_RGMII	GRF_FIELD(11, 9, 1)
+#define RK3368_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(11, 9, 4)
 #define RK3368_GMAC_FLOW_CTRL		GRF_BIT(8)
 #define RK3368_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(8)
 #define RK3368_GMAC_SPEED_10M		GRF_CLR_BIT(7)
 #define RK3368_GMAC_SPEED_100M		GRF_BIT(7)
 #define RK3368_GMAC_RMII_CLK_25M	GRF_BIT(3)
 #define RK3368_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
-#define RK3368_GMAC_CLK_125M		(GRF_CLR_BIT(4) | GRF_CLR_BIT(5))
-#define RK3368_GMAC_CLK_25M		(GRF_BIT(4) | GRF_BIT(5))
-#define RK3368_GMAC_CLK_2_5M		(GRF_CLR_BIT(4) | GRF_BIT(5))
+#define RK3368_GMAC_CLK_125M		GRF_FIELD_CONST(5, 4, 0)
+#define RK3368_GMAC_CLK_25M		GRF_FIELD_CONST(5, 4, 3)
+#define RK3368_GMAC_CLK_2_5M		GRF_FIELD_CONST(5, 4, 2)
 #define RK3368_GMAC_RMII_MODE		GRF_BIT(6)
 #define RK3368_GMAC_RMII_MODE_CLR	GRF_CLR_BIT(6)
 
@@ -764,19 +752,17 @@ static const struct rk_gmac_ops rk3368_ops = {
 #define RK3399_GRF_SOC_CON6	0xc218
 
 /* RK3399_GRF_SOC_CON5 */
-#define RK3399_GMAC_PHY_INTF_SEL_RGMII	(GRF_BIT(9) | GRF_CLR_BIT(10) | \
-					 GRF_CLR_BIT(11))
-#define RK3399_GMAC_PHY_INTF_SEL_RMII	(GRF_CLR_BIT(9) | GRF_CLR_BIT(10) | \
-					 GRF_BIT(11))
+#define RK3399_GMAC_PHY_INTF_SEL_RGMII	GRF_FIELD(11, 9, 1)
+#define RK3399_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(11, 9, 4)
 #define RK3399_GMAC_FLOW_CTRL		GRF_BIT(8)
 #define RK3399_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(8)
 #define RK3399_GMAC_SPEED_10M		GRF_CLR_BIT(7)
 #define RK3399_GMAC_SPEED_100M		GRF_BIT(7)
 #define RK3399_GMAC_RMII_CLK_25M	GRF_BIT(3)
 #define RK3399_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
-#define RK3399_GMAC_CLK_125M		(GRF_CLR_BIT(4) | GRF_CLR_BIT(5))
-#define RK3399_GMAC_CLK_25M		(GRF_BIT(4) | GRF_BIT(5))
-#define RK3399_GMAC_CLK_2_5M		(GRF_CLR_BIT(4) | GRF_BIT(5))
+#define RK3399_GMAC_CLK_125M		GRF_FIELD_CONST(5, 4, 0)
+#define RK3399_GMAC_CLK_25M		GRF_FIELD_CONST(5, 4, 3)
+#define RK3399_GMAC_CLK_2_5M		GRF_FIELD_CONST(5, 4, 2)
 #define RK3399_GMAC_RMII_MODE		GRF_BIT(6)
 #define RK3399_GMAC_RMII_MODE_CLR	GRF_CLR_BIT(6)
 
@@ -916,9 +902,9 @@ static const struct rk_gmac_ops rk3506_ops = {
 #define RK3528_GMAC1_CLK_RMII_DIV2	GRF_BIT(10)
 #define RK3528_GMAC1_CLK_RMII_DIV20	GRF_CLR_BIT(10)
 
-#define RK3528_GMAC1_CLK_RGMII_DIV1	(GRF_CLR_BIT(11) | GRF_CLR_BIT(10))
-#define RK3528_GMAC1_CLK_RGMII_DIV5	(GRF_BIT(11) | GRF_BIT(10))
-#define RK3528_GMAC1_CLK_RGMII_DIV50	(GRF_BIT(11) | GRF_CLR_BIT(10))
+#define RK3528_GMAC1_CLK_RGMII_DIV1	GRF_FIELD_CONST(11, 10, 0)
+#define RK3528_GMAC1_CLK_RGMII_DIV5	GRF_FIELD_CONST(11, 10, 3)
+#define RK3528_GMAC1_CLK_RGMII_DIV50	GRF_FIELD_CONST(11, 10, 2)
 
 #define RK3528_GMAC0_CLK_RMII_GATE	GRF_BIT(2)
 #define RK3528_GMAC0_CLK_RMII_NOGATE	GRF_CLR_BIT(2)
@@ -1029,10 +1015,8 @@ static const struct rk_gmac_ops rk3528_ops = {
 #define RK3568_GRF_GMAC1_CON1		0x038c
 
 /* RK3568_GRF_GMAC0_CON1 && RK3568_GRF_GMAC1_CON1 */
-#define RK3568_GMAC_PHY_INTF_SEL_RGMII	\
-		(GRF_BIT(4) | GRF_CLR_BIT(5) | GRF_CLR_BIT(6))
-#define RK3568_GMAC_PHY_INTF_SEL_RMII	\
-		(GRF_CLR_BIT(4) | GRF_CLR_BIT(5) | GRF_BIT(6))
+#define RK3568_GMAC_PHY_INTF_SEL_RGMII	GRF_FIELD(6, 4, 1)
+#define RK3568_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(6, 4, 4)
 #define RK3568_GMAC_FLOW_CTRL			GRF_BIT(3)
 #define RK3568_GMAC_FLOW_CTRL_CLR		GRF_CLR_BIT(3)
 #define RK3568_GMAC_RXCLK_DLY_ENABLE		GRF_BIT(1)
@@ -1112,12 +1096,9 @@ static const struct rk_gmac_ops rk3568_ops = {
 #define RK3576_GMAC_CLK_RMII_DIV2		GRF_BIT(5)
 #define RK3576_GMAC_CLK_RMII_DIV20		GRF_CLR_BIT(5)
 
-#define RK3576_GMAC_CLK_RGMII_DIV1		\
-			(GRF_CLR_BIT(6) | GRF_CLR_BIT(5))
-#define RK3576_GMAC_CLK_RGMII_DIV5		\
-			(GRF_BIT(6) | GRF_BIT(5))
-#define RK3576_GMAC_CLK_RGMII_DIV50		\
-			(GRF_BIT(6) | GRF_CLR_BIT(5))
+#define RK3576_GMAC_CLK_RGMII_DIV1		GRF_FIELD_CONST(6, 5, 0)
+#define RK3576_GMAC_CLK_RGMII_DIV5		GRF_FIELD_CONST(6, 5, 3)
+#define RK3576_GMAC_CLK_RGMII_DIV50		GRF_FIELD_CONST(6, 5, 2)
 
 #define RK3576_GMAC_CLK_RMII_GATE		GRF_BIT(4)
 #define RK3576_GMAC_CLK_RMII_NOGATE		GRF_CLR_BIT(4)
@@ -1228,9 +1209,9 @@ static const struct rk_gmac_ops rk3576_ops = {
 #define RK3588_GRF_CLK_CON1			0X0070
 
 #define RK3588_GMAC_PHY_INTF_SEL_RGMII(id)	\
-	(GRF_BIT(3 + (id) * 6) | GRF_CLR_BIT(4 + (id) * 6) | GRF_CLR_BIT(5 + (id) * 6))
+	(GRF_FIELD(5, 3, 1) << ((id) * 6))
 #define RK3588_GMAC_PHY_INTF_SEL_RMII(id)	\
-	(GRF_CLR_BIT(3 + (id) * 6) | GRF_CLR_BIT(4 + (id) * 6) | GRF_BIT(5 + (id) * 6))
+	(GRF_FIELD(5, 3, 4) << ((id) * 6))
 
 #define RK3588_GMAC_CLK_RMII_MODE(id)		GRF_BIT(5 * (id))
 #define RK3588_GMAC_CLK_RGMII_MODE(id)		GRF_CLR_BIT(5 * (id))
@@ -1242,11 +1223,11 @@ static const struct rk_gmac_ops rk3576_ops = {
 #define RK3588_GMA_CLK_RMII_DIV20(id)		GRF_CLR_BIT(5 * (id) + 2)
 
 #define RK3588_GMAC_CLK_RGMII_DIV1(id)		\
-			(GRF_CLR_BIT(5 * (id) + 2) | GRF_CLR_BIT(5 * (id) + 3))
+	(GRF_FIELD_CONST(3, 2, 0) << ((id) * 5))
 #define RK3588_GMAC_CLK_RGMII_DIV5(id)		\
-			(GRF_BIT(5 * (id) + 2) | GRF_BIT(5 * (id) + 3))
+	(GRF_FIELD_CONST(3, 2, 3) << ((id) * 5))
 #define RK3588_GMAC_CLK_RGMII_DIV50(id)		\
-			(GRF_CLR_BIT(5 * (id) + 2) | GRF_BIT(5 * (id) + 3))
+	(GRF_FIELD_CONST(3, 2, 2) << ((id) * 5))
 
 #define RK3588_GMAC_CLK_RMII_GATE(id)		GRF_BIT(5 * (id) + 1)
 #define RK3588_GMAC_CLK_RMII_NOGATE(id)		GRF_CLR_BIT(5 * (id) + 1)
@@ -1347,8 +1328,7 @@ static const struct rk_gmac_ops rk3588_ops = {
 #define RV1108_GRF_GMAC_CON0		0X0900
 
 /* RV1108_GRF_GMAC_CON0 */
-#define RV1108_GMAC_PHY_INTF_SEL_RMII	(GRF_CLR_BIT(4) | GRF_CLR_BIT(5) | \
-					GRF_BIT(6))
+#define RV1108_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(6, 4, 4)
 #define RV1108_GMAC_FLOW_CTRL		GRF_BIT(3)
 #define RV1108_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
 #define RV1108_GMAC_SPEED_10M		GRF_CLR_BIT(2)
@@ -1384,10 +1364,8 @@ static const struct rk_gmac_ops rv1108_ops = {
 #define RV1126_GRF_GMAC_CON2		0X0078
 
 /* RV1126_GRF_GMAC_CON0 */
-#define RV1126_GMAC_PHY_INTF_SEL_RGMII	\
-		(GRF_BIT(4) | GRF_CLR_BIT(5) | GRF_CLR_BIT(6))
-#define RV1126_GMAC_PHY_INTF_SEL_RMII	\
-		(GRF_CLR_BIT(4) | GRF_CLR_BIT(5) | GRF_BIT(6))
+#define RV1126_GMAC_PHY_INTF_SEL_RGMII	GRF_FIELD(6, 4, 1)
+#define RV1126_GMAC_PHY_INTF_SEL_RMII	GRF_FIELD(6, 4, 4)
 #define RV1126_GMAC_FLOW_CTRL			GRF_BIT(7)
 #define RV1126_GMAC_FLOW_CTRL_CLR		GRF_CLR_BIT(7)
 #define RV1126_GMAC_M0_RXCLK_DLY_ENABLE		GRF_BIT(1)
-- 
2.47.3


