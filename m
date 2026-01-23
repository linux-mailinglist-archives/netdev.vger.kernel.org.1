Return-Path: <netdev+bounces-252803-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEMQONRVc2kDuwAAu9opvQ
	(envelope-from <netdev+bounces-252803-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:04:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D1374C41
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DC7E3019532
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07662F691D;
	Fri, 23 Jan 2026 11:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QwU19rgl"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDC529D29E
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166107; cv=none; b=Jh3YzWH5BVVnfkJqVNMLfVIW6ZnjogCNaVkCZYyiaH9f9dCslvz76Ixd19XRh5Tt2TnBZHHSP/vz4eRKdlmiur5WYnkZayK3CXkB7UGy0acYe0h0nUBfISC/wEdsbubPN5ZeRlMT5Mf6W7A27/b2MRStIQ5tZj6lVeKQQgTwwtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166107; c=relaxed/simple;
	bh=4KVQ1jFK+nKrGXYrFSDuTYRUegGuh9TxzwkXqR9UuGU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ReLJN05V+0XhIHloi94OEtwrv2B3ZJy+jel+Q6xH1jhcRbIOHUTTZoy53CVDIzQXztEvPCEx2zHfaeIB9tqAlNBRDfNZNnp2h1/jB07Wvwlh6wu3kRop/8aJyE3JHt++g3Z9ajWcej4LvU2A/F6MD7TZTLEr8SSBIAS1ol27kLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QwU19rgl; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1do7TlXni7JlF1GMJRl0MHIaHqcByxEdQkUkY9xdk/c=; b=QwU19rgly3DNHqQBTcdnEYXo8Y
	J8a1Kvtr7ckcsD0+hSJCXOEILydrGhM9l+tEa9rxrV0uPDxI1p6G3L8iMh35D7Yq+skodj3b7bGW2
	b/7lQj74k1UKEtvqFFJaeRuxCSybhi/4S9XMLlEMmLxEaYOMlcR+fiZxImga2NCl+4/3cI33ThIKY
	U4IxlIa1NRMMHT3+LfHqbl5T1GOLc1niCbGQYjPNTUvj0yBMSfS44YiVYj2ZNl2x7qG68yDR9Dxch
	MPLD9ysia3hJoYolM5zmZEifObHGcyYCTogDua3OnZOZJYnIBhb+iZ4+rpnBHI/fnDQK7Ui+LZvLt
	9vh0UQBw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50532 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vjEut-000000001pv-3j9z;
	Fri, 23 Jan 2026 11:01:28 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vjEuq-00000005ggo-0jYE;
	Fri, 23 Jan 2026 11:01:24 +0000
In-Reply-To: <aXNUlVZilT-CTgph@shell.armlinux.org.uk>
References: <aXNUlVZilT-CTgph@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 13/21] net: stmmac: rk: use rk_encode_wm16() for RMII
 clock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vjEuq-00000005ggo-0jYE@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 23 Jan 2026 11:01:24 +0000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252803-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rmk-PC.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 45D1374C41
X-Rspamd-Action: no action

The RMII clock is a single bit, which is set for 100M and clear for
10M. Move this out of struct rk_reg_speed_data (which gets rid of
this structure) into the struct rk_clock_fields as the bitmask for
this bit.

This gets rid of the per-SoC variability in the calls to
rk_set_reg_speed().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 191 +++---------------
 1 file changed, 33 insertions(+), 158 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 48852054390d..9ad9ea90d82c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -28,14 +28,10 @@ struct rk_priv_data;
 
 struct rk_clock_fields {
 	u16 gmii_clk_sel_mask;
+	u16 rmii_clk_sel_mask;
 	u16 mac_speed_mask;
 };
 
-struct rk_reg_speed_data {
-	unsigned int rmii_10;
-	unsigned int rmii_100;
-};
-
 struct rk_gmac_ops {
 	int (*init)(struct rk_priv_data *bsp_priv);
 	void (*set_to_rgmii)(struct rk_priv_data *bsp_priv,
@@ -159,7 +155,6 @@ static int rk_write_clock_grf_reg(struct rk_priv_data *bsp_priv, u32 val)
 }
 
 static int rk_set_reg_speed(struct rk_priv_data *bsp_priv,
-			    const struct rk_reg_speed_data *rsd,
 			    phy_interface_t interface, int speed)
 {
 	unsigned int val;
@@ -173,17 +168,9 @@ static int rk_set_reg_speed(struct rk_priv_data *bsp_priv,
 		val = rk_encode_wm16(ret, bsp_priv->clock.gmii_clk_sel_mask);
 	} else if (interface == PHY_INTERFACE_MODE_RMII) {
 		val = rk_encode_wm16(speed == SPEED_100,
-				     bsp_priv->clock.mac_speed_mask);
-		if (speed == SPEED_10) {
-			val |= rsd->rmii_10;
-		} else if (speed == SPEED_100) {
-			val |= rsd->rmii_100;
-		} else {
-			/* Phylink will not allow inappropriate speeds for
-			 * interface modes, so this should never happen.
-			 */
-			return -EINVAL;
-		}
+				     bsp_priv->clock.mac_speed_mask) |
+		      rk_encode_wm16(speed == SPEED_100,
+				     bsp_priv->clock.rmii_clk_sel_mask);
 	} else {
 		/* This should never happen, as .get_interfaces() limits
 		 * the interface modes that are supported to RGMII and/or
@@ -354,8 +341,6 @@ static const struct rk_gmac_ops px30_ops = {
 /* RK3128_GRF_MAC_CON1 */
 #define RK3128_GMAC_FLOW_CTRL          GRF_BIT(9)
 #define RK3128_GMAC_FLOW_CTRL_CLR      GRF_CLR_BIT(9)
-#define RK3128_GMAC_RMII_CLK_25M       GRF_BIT(11)
-#define RK3128_GMAC_RMII_CLK_2_5M      GRF_CLR_BIT(11)
 
 static void rk3128_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
@@ -370,16 +355,10 @@ static void rk3128_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 }
 
-static const struct rk_reg_speed_data rk3128_reg_speed_data = {
-	.rmii_10 = RK3128_GMAC_RMII_CLK_2_5M,
-	.rmii_100 = RK3128_GMAC_RMII_CLK_25M,
-};
-
 static int rk3128_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
-	return rk_set_reg_speed(bsp_priv, &rk3128_reg_speed_data,
-				interface, speed);
+	return rk_set_reg_speed(bsp_priv, interface, speed);
 }
 
 static const struct rk_gmac_ops rk3128_ops = {
@@ -393,6 +372,7 @@ static const struct rk_gmac_ops rk3128_ops = {
 
 	.clock_grf_reg = RK3128_GRF_MAC_CON1,
 	.clock.gmii_clk_sel_mask = GENMASK_U16(13, 12),
+	.clock.rmii_clk_sel_mask = BIT_U16(11),
 	.clock.mac_speed_mask = BIT_U16(10),
 };
 
@@ -408,8 +388,6 @@ static const struct rk_gmac_ops rk3128_ops = {
 /* RK3228_GRF_MAC_CON1 */
 #define RK3228_GMAC_FLOW_CTRL		GRF_BIT(3)
 #define RK3228_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
-#define RK3228_GMAC_RMII_CLK_25M	GRF_BIT(7)
-#define RK3228_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(7)
 #define RK3228_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(0)
 #define RK3228_GMAC_TXCLK_DLY_DISABLE	GRF_CLR_BIT(0)
 #define RK3228_GMAC_RXCLK_DLY_ENABLE	GRF_BIT(1)
@@ -435,16 +413,10 @@ static void rk3228_set_to_rmii(struct rk_priv_data *bsp_priv)
 	regmap_write(bsp_priv->grf, RK3228_GRF_MAC_CON1, GRF_BIT(11));
 }
 
-static const struct rk_reg_speed_data rk3228_reg_speed_data = {
-	.rmii_10 = RK3228_GMAC_RMII_CLK_2_5M,
-	.rmii_100 = RK3228_GMAC_RMII_CLK_25M,
-};
-
 static int rk3228_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
-	return rk_set_reg_speed(bsp_priv, &rk3228_reg_speed_data,
-				interface, speed);
+	return rk_set_reg_speed(bsp_priv, interface, speed);
 }
 
 static void rk3228_integrated_phy_powerup(struct rk_priv_data *priv)
@@ -468,6 +440,7 @@ static const struct rk_gmac_ops rk3228_ops = {
 
 	.clock_grf_reg = RK3228_GRF_MAC_CON1,
 	.clock.gmii_clk_sel_mask = GENMASK_U16(9, 8),
+	.clock.rmii_clk_sel_mask = BIT_U16(7),
 	.clock.mac_speed_mask = BIT_U16(2),
 };
 
@@ -477,8 +450,6 @@ static const struct rk_gmac_ops rk3228_ops = {
 /*RK3288_GRF_SOC_CON1*/
 #define RK3288_GMAC_FLOW_CTRL		GRF_BIT(9)
 #define RK3288_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(9)
-#define RK3288_GMAC_RMII_CLK_25M	GRF_BIT(11)
-#define RK3288_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(11)
 
 /*RK3288_GRF_SOC_CON3*/
 #define RK3288_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(14)
@@ -501,16 +472,10 @@ static void rk3288_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 }
 
-static const struct rk_reg_speed_data rk3288_reg_speed_data = {
-	.rmii_10 = RK3288_GMAC_RMII_CLK_2_5M,
-	.rmii_100 = RK3288_GMAC_RMII_CLK_25M,
-};
-
 static int rk3288_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
-	return rk_set_reg_speed(bsp_priv, &rk3288_reg_speed_data,
-				interface, speed);
+	return rk_set_reg_speed(bsp_priv, interface, speed);
 }
 
 static const struct rk_gmac_ops rk3288_ops = {
@@ -524,6 +489,7 @@ static const struct rk_gmac_ops rk3288_ops = {
 
 	.clock_grf_reg = RK3288_GRF_SOC_CON1,
 	.clock.gmii_clk_sel_mask = GENMASK_U16(13, 12),
+	.clock.rmii_clk_sel_mask = BIT_U16(11),
 	.clock.mac_speed_mask = BIT_U16(10),
 };
 
@@ -537,14 +503,10 @@ static void rk3308_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 }
 
-static const struct rk_reg_speed_data rk3308_reg_speed_data = {
-};
-
 static int rk3308_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
-	return rk_set_reg_speed(bsp_priv, &rk3308_reg_speed_data,
-				interface, speed);
+	return rk_set_reg_speed(bsp_priv, interface, speed);
 }
 
 static const struct rk_gmac_ops rk3308_ops = {
@@ -570,8 +532,6 @@ static const struct rk_gmac_ops rk3308_ops = {
 /* RK3328_GRF_MAC_CON1 */
 #define RK3328_GMAC_FLOW_CTRL		GRF_BIT(3)
 #define RK3328_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
-#define RK3328_GMAC_RMII_CLK_25M	GRF_BIT(7)
-#define RK3328_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(7)
 #define RK3328_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(0)
 #define RK3328_GMAC_RXCLK_DLY_ENABLE	GRF_BIT(1)
 
@@ -613,16 +573,10 @@ static void rk3328_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 }
 
-static const struct rk_reg_speed_data rk3328_reg_speed_data = {
-	.rmii_10 = RK3328_GMAC_RMII_CLK_2_5M,
-	.rmii_100 = RK3328_GMAC_RMII_CLK_25M,
-};
-
 static int rk3328_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
-	return rk_set_reg_speed(bsp_priv, &rk3328_reg_speed_data,
-				interface, speed);
+	return rk_set_reg_speed(bsp_priv, interface, speed);
 }
 
 static void rk3328_integrated_phy_powerup(struct rk_priv_data *priv)
@@ -644,6 +598,7 @@ static const struct rk_gmac_ops rk3328_ops = {
 	.gmac_phy_intf_sel_mask = GENMASK_U16(6, 4),
 	.gmac_rmii_mode_mask = BIT_U16(9),
 
+	.clock.rmii_clk_sel_mask = BIT_U16(7),
 	.clock.mac_speed_mask = BIT_U16(2),
 
 	.regs_valid = true,
@@ -660,8 +615,6 @@ static const struct rk_gmac_ops rk3328_ops = {
 /* RK3366_GRF_SOC_CON6 */
 #define RK3366_GMAC_FLOW_CTRL		GRF_BIT(8)
 #define RK3366_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(8)
-#define RK3366_GMAC_RMII_CLK_25M	GRF_BIT(3)
-#define RK3366_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
 
 /* RK3366_GRF_SOC_CON7 */
 #define RK3366_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(7)
@@ -684,16 +637,10 @@ static void rk3366_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 }
 
-static const struct rk_reg_speed_data rk3366_reg_speed_data = {
-	.rmii_10 = RK3366_GMAC_RMII_CLK_2_5M,
-	.rmii_100 = RK3366_GMAC_RMII_CLK_25M,
-};
-
 static int rk3366_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
-	return rk_set_reg_speed(bsp_priv, &rk3366_reg_speed_data,
-				interface, speed);
+	return rk_set_reg_speed(bsp_priv, interface, speed);
 }
 
 static const struct rk_gmac_ops rk3366_ops = {
@@ -707,6 +654,7 @@ static const struct rk_gmac_ops rk3366_ops = {
 
 	.clock_grf_reg = RK3366_GRF_SOC_CON6,
 	.clock.gmii_clk_sel_mask = GENMASK_U16(5, 4),
+	.clock.rmii_clk_sel_mask = BIT_U16(3),
 	.clock.mac_speed_mask = BIT_U16(7),
 };
 
@@ -716,8 +664,6 @@ static const struct rk_gmac_ops rk3366_ops = {
 /* RK3368_GRF_SOC_CON15 */
 #define RK3368_GMAC_FLOW_CTRL		GRF_BIT(8)
 #define RK3368_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(8)
-#define RK3368_GMAC_RMII_CLK_25M	GRF_BIT(3)
-#define RK3368_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
 
 /* RK3368_GRF_SOC_CON16 */
 #define RK3368_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(7)
@@ -740,16 +686,10 @@ static void rk3368_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 }
 
-static const struct rk_reg_speed_data rk3368_reg_speed_data = {
-	.rmii_10 = RK3368_GMAC_RMII_CLK_2_5M,
-	.rmii_100 = RK3368_GMAC_RMII_CLK_25M,
-};
-
 static int rk3368_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
-	return rk_set_reg_speed(bsp_priv, &rk3368_reg_speed_data,
-				interface, speed);
+	return rk_set_reg_speed(bsp_priv, interface, speed);
 }
 
 static const struct rk_gmac_ops rk3368_ops = {
@@ -763,6 +703,7 @@ static const struct rk_gmac_ops rk3368_ops = {
 
 	.clock_grf_reg = RK3368_GRF_SOC_CON15,
 	.clock.gmii_clk_sel_mask = GENMASK_U16(5, 4),
+	.clock.rmii_clk_sel_mask = BIT_U16(3),
 	.clock.mac_speed_mask = BIT_U16(7),
 };
 
@@ -772,8 +713,6 @@ static const struct rk_gmac_ops rk3368_ops = {
 /* RK3399_GRF_SOC_CON5 */
 #define RK3399_GMAC_FLOW_CTRL		GRF_BIT(8)
 #define RK3399_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(8)
-#define RK3399_GMAC_RMII_CLK_25M	GRF_BIT(3)
-#define RK3399_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
 
 /* RK3399_GRF_SOC_CON6 */
 #define RK3399_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(7)
@@ -796,16 +735,10 @@ static void rk3399_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 }
 
-static const struct rk_reg_speed_data rk3399_reg_speed_data = {
-	.rmii_10 = RK3399_GMAC_RMII_CLK_2_5M,
-	.rmii_100 = RK3399_GMAC_RMII_CLK_25M,
-};
-
 static int rk3399_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
-	return rk_set_reg_speed(bsp_priv, &rk3399_reg_speed_data,
-				interface, speed);
+	return rk_set_reg_speed(bsp_priv, interface, speed);
 }
 
 static const struct rk_gmac_ops rk3399_ops = {
@@ -819,6 +752,7 @@ static const struct rk_gmac_ops rk3399_ops = {
 
 	.clock_grf_reg = RK3399_GRF_SOC_CON5,
 	.clock.gmii_clk_sel_mask = GENMASK_U16(5, 4),
+	.clock.rmii_clk_sel_mask = BIT_U16(3),
 	.clock.mac_speed_mask = BIT_U16(7),
 };
 
@@ -827,9 +761,6 @@ static const struct rk_gmac_ops rk3399_ops = {
 
 #define RK3506_GMAC_RMII_MODE		GRF_BIT(1)
 
-#define RK3506_GMAC_CLK_RMII_DIV2	GRF_BIT(3)
-#define RK3506_GMAC_CLK_RMII_DIV20	GRF_CLR_BIT(3)
-
 #define RK3506_GMAC_CLK_SELECT_CRU	GRF_CLR_BIT(5)
 #define RK3506_GMAC_CLK_SELECT_IO	GRF_BIT(5)
 
@@ -860,16 +791,10 @@ static void rk3506_set_to_rmii(struct rk_priv_data *bsp_priv)
 	regmap_write(bsp_priv->grf, offset, RK3506_GMAC_RMII_MODE);
 }
 
-static const struct rk_reg_speed_data rk3506_reg_speed_data = {
-	.rmii_10 = RK3506_GMAC_CLK_RMII_DIV20,
-	.rmii_100 = RK3506_GMAC_CLK_RMII_DIV2,
-};
-
 static int rk3506_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
-	return rk_set_reg_speed(bsp_priv, &rk3506_reg_speed_data,
-				interface, speed);
+	return rk_set_reg_speed(bsp_priv, interface, speed);
 }
 
 static void rk3506_set_clock_selection(struct rk_priv_data *bsp_priv,
@@ -891,6 +816,9 @@ static const struct rk_gmac_ops rk3506_ops = {
 	.set_to_rmii = rk3506_set_to_rmii,
 	.set_speed = rk3506_set_speed,
 	.set_clock_selection = rk3506_set_clock_selection,
+
+	.clock.rmii_clk_sel_mask = BIT_U16(3),
+
 	.regs_valid = true,
 	.regs = {
 		0xff4c8000, /* gmac0 */
@@ -920,11 +848,6 @@ static const struct rk_gmac_ops rk3506_ops = {
 #define RK3528_GMAC1_CLK_SELECT_CRU	GRF_CLR_BIT(12)
 #define RK3528_GMAC1_CLK_SELECT_IO	GRF_BIT(12)
 
-#define RK3528_GMAC0_CLK_RMII_DIV2	GRF_BIT(3)
-#define RK3528_GMAC0_CLK_RMII_DIV20	GRF_CLR_BIT(3)
-#define RK3528_GMAC1_CLK_RMII_DIV2	GRF_BIT(10)
-#define RK3528_GMAC1_CLK_RMII_DIV20	GRF_CLR_BIT(10)
-
 #define RK3528_GMAC0_CLK_RMII_GATE	GRF_BIT(2)
 #define RK3528_GMAC0_CLK_RMII_NOGATE	GRF_CLR_BIT(2)
 #define RK3528_GMAC1_CLK_RMII_GATE	GRF_BIT(9)
@@ -935,11 +858,13 @@ static int rk3528_init(struct rk_priv_data *bsp_priv)
 	switch (bsp_priv->id) {
 	case 0:
 		bsp_priv->clock_grf_reg = RK3528_VO_GRF_GMAC_CON;
+		bsp_priv->clock.rmii_clk_sel_mask = BIT_U16(3);
 		return 0;
 
 	case 1:
 		bsp_priv->clock_grf_reg = RK3528_VPU_GRF_GMAC_CON5;
 		bsp_priv->clock.gmii_clk_sel_mask = GENMASK_U16(11, 10);
+		bsp_priv->clock.rmii_clk_sel_mask = BIT_U16(10);
 		return 0;
 
 	default:
@@ -971,27 +896,10 @@ static void rk3528_set_to_rmii(struct rk_priv_data *bsp_priv)
 			     RK3528_GMAC0_PHY_INTF_SEL_RMII);
 }
 
-static const struct rk_reg_speed_data rk3528_gmac0_reg_speed_data = {
-	.rmii_10 = RK3528_GMAC0_CLK_RMII_DIV20,
-	.rmii_100 = RK3528_GMAC0_CLK_RMII_DIV2,
-};
-
-static const struct rk_reg_speed_data rk3528_gmac1_reg_speed_data = {
-	.rmii_10 = RK3528_GMAC1_CLK_RMII_DIV20,
-	.rmii_100 = RK3528_GMAC1_CLK_RMII_DIV2,
-};
-
 static int rk3528_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
-	const struct rk_reg_speed_data *rsd;
-
-	if (bsp_priv->id == 1)
-		rsd = &rk3528_gmac1_reg_speed_data;
-	else
-		rsd = &rk3528_gmac0_reg_speed_data;
-
-	return rk_set_reg_speed(bsp_priv, rsd, interface, speed);
+	return rk_set_reg_speed(bsp_priv, interface, speed);
 }
 
 static void rk3528_set_clock_selection(struct rk_priv_data *bsp_priv,
@@ -1131,9 +1039,6 @@ static const struct rk_gmac_ops rk3568_ops = {
 #define RK3576_GMAC_CLK_SELECT_IO		GRF_BIT(7)
 #define RK3576_GMAC_CLK_SELECT_CRU		GRF_CLR_BIT(7)
 
-#define RK3576_GMAC_CLK_RMII_DIV2		GRF_BIT(5)
-#define RK3576_GMAC_CLK_RMII_DIV20		GRF_CLR_BIT(5)
-
 #define RK3576_GMAC_CLK_RMII_GATE		GRF_BIT(4)
 #define RK3576_GMAC_CLK_RMII_NOGATE		GRF_CLR_BIT(4)
 
@@ -1182,16 +1087,10 @@ static void rk3576_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 }
 
-static const struct rk_reg_speed_data rk3578_reg_speed_data = {
-	.rmii_10 = RK3576_GMAC_CLK_RMII_DIV20,
-	.rmii_100 = RK3576_GMAC_CLK_RMII_DIV2,
-};
-
 static int rk3576_set_gmac_speed(struct rk_priv_data *bsp_priv,
 				 phy_interface_t interface, int speed)
 {
-	return rk_set_reg_speed(bsp_priv, &rk3578_reg_speed_data,
-				interface, speed);
+	return rk_set_reg_speed(bsp_priv, interface, speed);
 }
 
 static void rk3576_set_clock_selection(struct rk_priv_data *bsp_priv, bool input,
@@ -1220,6 +1119,7 @@ static const struct rk_gmac_ops rk3576_ops = {
 	.gmac_rmii_mode_mask = BIT_U16(3),
 
 	.clock.gmii_clk_sel_mask = GENMASK_U16(6, 5),
+	.clock.rmii_clk_sel_mask = BIT_U16(5),
 
 	.php_grf_required = true,
 	.regs_valid = true,
@@ -1253,9 +1153,6 @@ static const struct rk_gmac_ops rk3576_ops = {
 #define RK3588_GMAC_CLK_SELECT_CRU(id)		GRF_BIT(5 * (id) + 4)
 #define RK3588_GMAC_CLK_SELECT_IO(id)		GRF_CLR_BIT(5 * (id) + 4)
 
-#define RK3588_GMA_CLK_RMII_DIV2(id)		GRF_BIT(5 * (id) + 2)
-#define RK3588_GMA_CLK_RMII_DIV20(id)		GRF_CLR_BIT(5 * (id) + 2)
-
 #define RK3588_GMAC_CLK_RMII_GATE(id)		GRF_BIT(5 * (id) + 1)
 #define RK3588_GMAC_CLK_RMII_NOGATE(id)		GRF_CLR_BIT(5 * (id) + 1)
 
@@ -1265,11 +1162,13 @@ static int rk3588_init(struct rk_priv_data *bsp_priv)
 	case 0:
 		bsp_priv->gmac_phy_intf_sel_mask = GENMASK_U16(5, 3);
 		bsp_priv->clock.gmii_clk_sel_mask = GENMASK_U16(3, 2);
+		bsp_priv->clock.rmii_clk_sel_mask = BIT_U16(2);
 		return 0;
 
 	case 1:
 		bsp_priv->gmac_phy_intf_sel_mask = GENMASK_U16(11, 9);
 		bsp_priv->clock.gmii_clk_sel_mask = GENMASK_U16(8, 7);
+		bsp_priv->clock.rmii_clk_sel_mask = BIT_U16(7);
 		return 0;
 
 	default:
@@ -1303,27 +1202,10 @@ static void rk3588_set_to_rmii(struct rk_priv_data *bsp_priv)
 		     RK3588_GMAC_CLK_RMII_MODE(bsp_priv->id));
 }
 
-static const struct rk_reg_speed_data rk3588_gmac0_speed_data = {
-	.rmii_10 = RK3588_GMA_CLK_RMII_DIV20(0),
-	.rmii_100 = RK3588_GMA_CLK_RMII_DIV2(0),
-};
-
-static const struct rk_reg_speed_data rk3588_gmac1_speed_data = {
-	.rmii_10 = RK3588_GMA_CLK_RMII_DIV20(1),
-	.rmii_100 = RK3588_GMA_CLK_RMII_DIV2(1),
-};
-
 static int rk3588_set_gmac_speed(struct rk_priv_data *bsp_priv,
 				 phy_interface_t interface, int speed)
 {
-	const struct rk_reg_speed_data *rsd;
-
-	if (bsp_priv->id == 0)
-		rsd = &rk3588_gmac0_speed_data;
-	else
-		rsd = &rk3588_gmac1_speed_data;
-
-	return rk_set_reg_speed(bsp_priv, rsd, interface, speed);
+	return rk_set_reg_speed(bsp_priv, interface, speed);
 }
 
 static void rk3588_set_clock_selection(struct rk_priv_data *bsp_priv, bool input,
@@ -1364,23 +1246,15 @@ static const struct rk_gmac_ops rk3588_ops = {
 /* RV1108_GRF_GMAC_CON0 */
 #define RV1108_GMAC_FLOW_CTRL		GRF_BIT(3)
 #define RV1108_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
-#define RV1108_GMAC_RMII_CLK_25M	GRF_BIT(7)
-#define RV1108_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(7)
 
 static void rv1108_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 }
 
-static const struct rk_reg_speed_data rv1108_reg_speed_data = {
-	.rmii_10 = RV1108_GMAC_RMII_CLK_2_5M,
-	.rmii_100 = RV1108_GMAC_RMII_CLK_25M,
-};
-
 static int rv1108_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
-	return rk_set_reg_speed(bsp_priv, &rv1108_reg_speed_data,
-				interface, speed);
+	return rk_set_reg_speed(bsp_priv, interface, speed);
 }
 
 static const struct rk_gmac_ops rv1108_ops = {
@@ -1391,6 +1265,7 @@ static const struct rk_gmac_ops rv1108_ops = {
 	.gmac_phy_intf_sel_mask = GENMASK_U16(6, 4),
 
 	.clock_grf_reg = RV1108_GRF_GMAC_CON0,
+	.clock.rmii_clk_sel_mask = BIT_U16(7),
 	.clock.mac_speed_mask = BIT_U16(2),
 };
 
-- 
2.47.3


