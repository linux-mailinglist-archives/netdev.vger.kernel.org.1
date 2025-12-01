Return-Path: <netdev+bounces-242993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFD8C97EB0
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 15:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2501A4E1840
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 14:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9D231A7E1;
	Mon,  1 Dec 2025 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NZXQr10n"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100BF31BCBC
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764600717; cv=none; b=mnkmGPNibs9pLmAGY4mYoQn8zGDlHIjrkLz+fA+ZszCZ6Mjrd8mHLKIFU5veg+oA9WlILW8Xu9Ybat2g57bnZOLwGSj36Z+34yhlfju+E6MS8SXkaWTLDC2uNi/CnkMKSBot2G7PjLtReO5wwc1Y1ldPz586AJ7xmF5Eg++bFbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764600717; c=relaxed/simple;
	bh=+W04f0Qz5uxrWlVanpYmGGggeYczk6JcQcLRpnJ3a0M=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=b2SNPy9iEMg7wd4UBgfkgPwrxsSb2CjEgIl6802atESAqOZSAR/civL/iyIXgIM4IXEvv23ZI6JU1QmZLYsnf8U84ETf+9NRiMjxrFd38/vnajBknM3bVafg3CIcB2+1GoYOx5Ww3sFcvZ5EAXh8EM8d8uGAY2WSn1FThicPuMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NZXQr10n; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FhmmRjdDtmJV4C3ijnr66bOrJiMhqUMCllvcugFiWUI=; b=NZXQr10nz+dQKEjozvgOIkf112
	zp3l0Mi7j2gLDpfGmvV3sqDbmW0qiXtp+bVJtzsFkrHZSeEC/+g6vcW+lJq2KP1E0TINCENTPrJ2f
	EA/k4fYb6A/3I1Q0RozB84NM7l+EUtc/EMZY4UlJIkzIpuF1cCXtcHrVzY1XV6MHx8BAMPDFVQ0oD
	W1zqy5E0wfBiSGkqBlmAbrwbX3fJqVgklD6vkXuAAgaUwagxpkQUC3MqCfHzCuZ4eiUi1IPiQA3Ot
	sSoxuU3mgOwbxewMnmI64VgdAYR2fxESGeGRa391p5A8mFuNvEZn9I0N2sIzJe3wdSOKkkHv3Ctfp
	ku13Rd6w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50474 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vQ5FN-000000000gz-1Z3d;
	Mon, 01 Dec 2025 14:51:25 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vQ5FL-0000000GNwB-2ckX;
	Mon, 01 Dec 2025 14:51:23 +0000
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
Subject: [PATCH RFC net-next 08/15] net: stmmac: rk: use rk_encode_wm16() for
 RMII speed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vQ5FL-0000000GNwB-2ckX@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 01 Dec 2025 14:51:23 +0000

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 71 +++++++++----------
 1 file changed, 33 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index d11a58d7f24b..5f586782d595 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -49,6 +49,7 @@ struct rk_gmac_ops {
 
 	u16 speed_grf_reg;
 	u16 gmii_clk_sel_mask;
+	u16 mac_speed_mask;
 
 	bool speed_reg_php_grf;
 	bool php_grf_required;
@@ -103,6 +104,7 @@ struct rk_priv_data {
 
 	u16 speed_grf_reg;
 	u16 gmii_clk_sel_mask;
+	u16 mac_speed_mask;
 };
 
 #define GMAC_CLK_DIV1_125M		0
@@ -156,10 +158,12 @@ static int rk_set_reg_speed(struct rk_priv_data *bsp_priv,
 
 		val = rk_encode_wm16(ret, bsp_priv->gmii_clk_sel_mask);
 	} else if (interface == PHY_INTERFACE_MODE_RMII) {
+		val = rk_encode_wm16(speed == SPEED_100,
+				     bsp_priv->mac_speed_mask);
 		if (speed == SPEED_10) {
-			val = rsd->rmii_10;
+			val |= rsd->rmii_10;
 		} else if (speed == SPEED_100) {
-			val = rsd->rmii_100;
+			val |= rsd->rmii_100;
 		} else {
 			/* Phylink will not allow inappropriate speeds for
 			 * interface modes, so this should never happen.
@@ -341,8 +345,6 @@ static const struct rk_gmac_ops px30_ops = {
 /* RK3128_GRF_MAC_CON1 */
 #define RK3128_GMAC_FLOW_CTRL          GRF_BIT(9)
 #define RK3128_GMAC_FLOW_CTRL_CLR      GRF_CLR_BIT(9)
-#define RK3128_GMAC_SPEED_10M          GRF_CLR_BIT(10)
-#define RK3128_GMAC_SPEED_100M         GRF_BIT(10)
 #define RK3128_GMAC_RMII_CLK_25M       GRF_BIT(11)
 #define RK3128_GMAC_RMII_CLK_2_5M      GRF_CLR_BIT(11)
 
@@ -360,8 +362,8 @@ static void rk3128_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3128_reg_speed_data = {
-	.rmii_10 = RK3128_GMAC_RMII_CLK_2_5M | RK3128_GMAC_SPEED_10M,
-	.rmii_100 = RK3128_GMAC_RMII_CLK_25M | RK3128_GMAC_SPEED_100M,
+	.rmii_10 = RK3128_GMAC_RMII_CLK_2_5M,
+	.rmii_100 = RK3128_GMAC_RMII_CLK_25M,
 };
 
 static int rk3128_set_speed(struct rk_priv_data *bsp_priv,
@@ -382,6 +384,7 @@ static const struct rk_gmac_ops rk3128_ops = {
 
 	.speed_grf_reg = RK3128_GRF_MAC_CON1,
 	.gmii_clk_sel_mask = GENMASK_U16(13, 12),
+	.mac_speed_mask = BIT_U16(10),
 };
 
 #define RK3228_GRF_MAC_CON0	0x0900
@@ -396,8 +399,6 @@ static const struct rk_gmac_ops rk3128_ops = {
 /* RK3228_GRF_MAC_CON1 */
 #define RK3228_GMAC_FLOW_CTRL		GRF_BIT(3)
 #define RK3228_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
-#define RK3228_GMAC_SPEED_10M		GRF_CLR_BIT(2)
-#define RK3228_GMAC_SPEED_100M		GRF_BIT(2)
 #define RK3228_GMAC_RMII_CLK_25M	GRF_BIT(7)
 #define RK3228_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(7)
 #define RK3228_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(0)
@@ -426,8 +427,8 @@ static void rk3228_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3228_reg_speed_data = {
-	.rmii_10 = RK3228_GMAC_RMII_CLK_2_5M | RK3228_GMAC_SPEED_10M,
-	.rmii_100 = RK3228_GMAC_RMII_CLK_25M | RK3228_GMAC_SPEED_100M,
+	.rmii_10 = RK3228_GMAC_RMII_CLK_2_5M,
+	.rmii_100 = RK3228_GMAC_RMII_CLK_25M,
 };
 
 static int rk3228_set_speed(struct rk_priv_data *bsp_priv,
@@ -458,6 +459,7 @@ static const struct rk_gmac_ops rk3228_ops = {
 
 	.speed_grf_reg = RK3228_GRF_MAC_CON1,
 	.gmii_clk_sel_mask = GENMASK_U16(9, 8),
+	.mac_speed_mask = BIT_U16(2),
 };
 
 #define RK3288_GRF_SOC_CON1	0x0248
@@ -466,8 +468,6 @@ static const struct rk_gmac_ops rk3228_ops = {
 /*RK3288_GRF_SOC_CON1*/
 #define RK3288_GMAC_FLOW_CTRL		GRF_BIT(9)
 #define RK3288_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(9)
-#define RK3288_GMAC_SPEED_10M		GRF_CLR_BIT(10)
-#define RK3288_GMAC_SPEED_100M		GRF_BIT(10)
 #define RK3288_GMAC_RMII_CLK_25M	GRF_BIT(11)
 #define RK3288_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(11)
 
@@ -493,8 +493,8 @@ static void rk3288_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3288_reg_speed_data = {
-	.rmii_10 = RK3288_GMAC_RMII_CLK_2_5M | RK3288_GMAC_SPEED_10M,
-	.rmii_100 = RK3288_GMAC_RMII_CLK_25M | RK3288_GMAC_SPEED_100M,
+	.rmii_10 = RK3288_GMAC_RMII_CLK_2_5M,
+	.rmii_100 = RK3288_GMAC_RMII_CLK_25M,
 };
 
 static int rk3288_set_speed(struct rk_priv_data *bsp_priv,
@@ -515,6 +515,7 @@ static const struct rk_gmac_ops rk3288_ops = {
 
 	.speed_grf_reg = RK3288_GRF_SOC_CON1,
 	.gmii_clk_sel_mask = GENMASK_U16(13, 12),
+	.mac_speed_mask = BIT_U16(10),
 };
 
 #define RK3308_GRF_MAC_CON0		0x04a0
@@ -522,16 +523,12 @@ static const struct rk_gmac_ops rk3288_ops = {
 /* RK3308_GRF_MAC_CON0 */
 #define RK3308_GMAC_FLOW_CTRL		GRF_BIT(3)
 #define RK3308_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
-#define RK3308_GMAC_SPEED_10M		GRF_CLR_BIT(0)
-#define RK3308_GMAC_SPEED_100M		GRF_BIT(0)
 
 static void rk3308_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 }
 
 static const struct rk_reg_speed_data rk3308_reg_speed_data = {
-	.rmii_10 = RK3308_GMAC_SPEED_10M,
-	.rmii_100 = RK3308_GMAC_SPEED_100M,
 };
 
 static int rk3308_set_speed(struct rk_priv_data *bsp_priv,
@@ -549,6 +546,7 @@ static const struct rk_gmac_ops rk3308_ops = {
 	.phy_intf_sel_mask = GENMASK_U16(4, 2),
 
 	.speed_grf_reg = RK3308_GRF_MAC_CON0,
+	.mac_speed_mask = BIT_U16(0),
 };
 
 #define RK3328_GRF_MAC_CON0	0x0900
@@ -563,8 +561,6 @@ static const struct rk_gmac_ops rk3308_ops = {
 /* RK3328_GRF_MAC_CON1 */
 #define RK3328_GMAC_FLOW_CTRL		GRF_BIT(3)
 #define RK3328_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
-#define RK3328_GMAC_SPEED_10M		GRF_CLR_BIT(2)
-#define RK3328_GMAC_SPEED_100M		GRF_BIT(2)
 #define RK3328_GMAC_RMII_CLK_25M	GRF_BIT(7)
 #define RK3328_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(7)
 #define RK3328_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(0)
@@ -609,8 +605,8 @@ static void rk3328_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3328_reg_speed_data = {
-	.rmii_10 = RK3328_GMAC_RMII_CLK_2_5M | RK3328_GMAC_SPEED_10M,
-	.rmii_100 = RK3328_GMAC_RMII_CLK_25M | RK3328_GMAC_SPEED_100M,
+	.rmii_10 = RK3328_GMAC_RMII_CLK_2_5M,
+	.rmii_100 = RK3328_GMAC_RMII_CLK_25M,
 };
 
 static int rk3328_set_speed(struct rk_priv_data *bsp_priv,
@@ -639,6 +635,8 @@ static const struct rk_gmac_ops rk3328_ops = {
 	.phy_intf_sel_mask = GENMASK_U16(6, 4),
 	.rmii_mode_mask = BIT_U16(9),
 
+	.mac_speed_mask = BIT_U16(2),
+
 	.regs_valid = true,
 	.regs = {
 		0xff540000, /* gmac2io */
@@ -653,8 +651,6 @@ static const struct rk_gmac_ops rk3328_ops = {
 /* RK3366_GRF_SOC_CON6 */
 #define RK3366_GMAC_FLOW_CTRL		GRF_BIT(8)
 #define RK3366_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(8)
-#define RK3366_GMAC_SPEED_10M		GRF_CLR_BIT(7)
-#define RK3366_GMAC_SPEED_100M		GRF_BIT(7)
 #define RK3366_GMAC_RMII_CLK_25M	GRF_BIT(3)
 #define RK3366_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
 
@@ -680,8 +676,8 @@ static void rk3366_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3366_reg_speed_data = {
-	.rmii_10 = RK3366_GMAC_RMII_CLK_2_5M | RK3366_GMAC_SPEED_10M,
-	.rmii_100 = RK3366_GMAC_RMII_CLK_25M | RK3366_GMAC_SPEED_100M,
+	.rmii_10 = RK3366_GMAC_RMII_CLK_2_5M,
+	.rmii_100 = RK3366_GMAC_RMII_CLK_25M,
 };
 
 static int rk3366_set_speed(struct rk_priv_data *bsp_priv,
@@ -702,6 +698,7 @@ static const struct rk_gmac_ops rk3366_ops = {
 
 	.speed_grf_reg = RK3366_GRF_SOC_CON6,
 	.gmii_clk_sel_mask = GENMASK_U16(5, 4),
+	.mac_speed_mask = BIT_U16(7),
 };
 
 #define RK3368_GRF_SOC_CON15	0x043c
@@ -710,8 +707,6 @@ static const struct rk_gmac_ops rk3366_ops = {
 /* RK3368_GRF_SOC_CON15 */
 #define RK3368_GMAC_FLOW_CTRL		GRF_BIT(8)
 #define RK3368_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(8)
-#define RK3368_GMAC_SPEED_10M		GRF_CLR_BIT(7)
-#define RK3368_GMAC_SPEED_100M		GRF_BIT(7)
 #define RK3368_GMAC_RMII_CLK_25M	GRF_BIT(3)
 #define RK3368_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
 
@@ -737,8 +732,8 @@ static void rk3368_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3368_reg_speed_data = {
-	.rmii_10 = RK3368_GMAC_RMII_CLK_2_5M | RK3368_GMAC_SPEED_10M,
-	.rmii_100 = RK3368_GMAC_RMII_CLK_25M | RK3368_GMAC_SPEED_100M,
+	.rmii_10 = RK3368_GMAC_RMII_CLK_2_5M,
+	.rmii_100 = RK3368_GMAC_RMII_CLK_25M,
 };
 
 static int rk3368_set_speed(struct rk_priv_data *bsp_priv,
@@ -759,6 +754,7 @@ static const struct rk_gmac_ops rk3368_ops = {
 
 	.speed_grf_reg = RK3368_GRF_SOC_CON15,
 	.gmii_clk_sel_mask = GENMASK_U16(5, 4),
+	.mac_speed_mask = BIT_U16(7),
 };
 
 #define RK3399_GRF_SOC_CON5	0xc214
@@ -767,8 +763,6 @@ static const struct rk_gmac_ops rk3368_ops = {
 /* RK3399_GRF_SOC_CON5 */
 #define RK3399_GMAC_FLOW_CTRL		GRF_BIT(8)
 #define RK3399_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(8)
-#define RK3399_GMAC_SPEED_10M		GRF_CLR_BIT(7)
-#define RK3399_GMAC_SPEED_100M		GRF_BIT(7)
 #define RK3399_GMAC_RMII_CLK_25M	GRF_BIT(3)
 #define RK3399_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
 
@@ -794,8 +788,8 @@ static void rk3399_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3399_reg_speed_data = {
-	.rmii_10 = RK3399_GMAC_RMII_CLK_2_5M | RK3399_GMAC_SPEED_10M,
-	.rmii_100 = RK3399_GMAC_RMII_CLK_25M | RK3399_GMAC_SPEED_100M,
+	.rmii_10 = RK3399_GMAC_RMII_CLK_2_5M,
+	.rmii_100 = RK3399_GMAC_RMII_CLK_25M,
 };
 
 static int rk3399_set_speed(struct rk_priv_data *bsp_priv,
@@ -816,6 +810,7 @@ static const struct rk_gmac_ops rk3399_ops = {
 
 	.speed_grf_reg = RK3399_GRF_SOC_CON5,
 	.gmii_clk_sel_mask = GENMASK_U16(5, 4),
+	.mac_speed_mask = BIT_U16(7),
 };
 
 #define RK3506_GRF_SOC_CON8		0x0020
@@ -1361,8 +1356,6 @@ static const struct rk_gmac_ops rk3588_ops = {
 /* RV1108_GRF_GMAC_CON0 */
 #define RV1108_GMAC_FLOW_CTRL		GRF_BIT(3)
 #define RV1108_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
-#define RV1108_GMAC_SPEED_10M		GRF_CLR_BIT(2)
-#define RV1108_GMAC_SPEED_100M		GRF_BIT(2)
 #define RV1108_GMAC_RMII_CLK_25M	GRF_BIT(7)
 #define RV1108_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(7)
 
@@ -1371,8 +1364,8 @@ static void rv1108_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rv1108_reg_speed_data = {
-	.rmii_10 = RV1108_GMAC_RMII_CLK_2_5M | RV1108_GMAC_SPEED_10M,
-	.rmii_100 = RV1108_GMAC_RMII_CLK_25M | RV1108_GMAC_SPEED_100M,
+	.rmii_10 = RV1108_GMAC_RMII_CLK_2_5M,
+	.rmii_100 = RV1108_GMAC_RMII_CLK_25M,
 };
 
 static int rv1108_set_speed(struct rk_priv_data *bsp_priv,
@@ -1390,6 +1383,7 @@ static const struct rk_gmac_ops rv1108_ops = {
 	.phy_intf_sel_mask = GENMASK_U16(6, 4),
 
 	.speed_grf_reg = RV1108_GRF_GMAC_CON0,
+	.mac_speed_mask = BIT_U16(2),
 };
 
 #define RV1126_GRF_GMAC_CON0		0X0070
@@ -1672,6 +1666,7 @@ static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
 	/* Set the default speed related parameters */
 	bsp_priv->speed_grf_reg = ops->speed_grf_reg;
 	bsp_priv->gmii_clk_sel_mask = ops->gmii_clk_sel_mask;
+	bsp_priv->mac_speed_mask = ops->mac_speed_mask;
 
 	if (ops->init) {
 		ret = ops->init(bsp_priv);
-- 
2.47.3


