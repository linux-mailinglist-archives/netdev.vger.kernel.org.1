Return-Path: <netdev+bounces-253446-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JXZBoZUd2nMeAEAu9opvQ
	(envelope-from <netdev+bounces-253446-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:48:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FB987D0F
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA97330037F1
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC7232E6B8;
	Mon, 26 Jan 2026 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XLgnlyc6"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6C530F958
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 11:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769427982; cv=none; b=jvbF+0tuICAzuAH5ba5so3RfvzJbCwoX/+MISFFpGx5AHBljwR2j8lRhbG4NrOupeduYeJqmF4tFbFqXxVtgntfks2fuQTz7SHSOXuJdjzCpcX1PqbgnFB5fRm3aNWV6Iw5Yt6m4E/+0AVH5fErJ6q/E3nxHadCjKRudFvOgKI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769427982; c=relaxed/simple;
	bh=P/LTvlhqrASjGOzYR1qdmDOK6f8ZkanYRFH4SNWZ4Lk=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=lzfVfOGSSq+n1zHrcxrId+tm3gPKN3GABJIUJXDDO0jdbn73B6b1bN32qC4UpjvWvQ97F127ELOr05sJQTVQ7ePjBuZiF1NjK7zkMu7QVP7mjEKINch0YwRUsItUmvjPWSlNZqNl0FUThJNSY1HhhAUu3q1lIDA4iQEFsDGvIqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=XLgnlyc6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mtCUPGqXBBJVis6ub9WeUuhZnbKwtE9mklg+Y9rdz/I=; b=XLgnlyc6w5b7YzV/7q6Q8uXXZs
	5wbbG+r8WoZHRh7JgsSNsSgQlL3puIfCw+Axplql4/iChBGLHYCyFKeMYjoMAbDSc9jsVTcGIg2PP
	agRGSTq0jJh8dw2b3ToKO1TSeAbH3PRuwCPHeF/mG+VPvowhM7n7amt9QBaraZsH2Jq+2Q7hAmOpB
	y902UPPB785KfT9LbEIMOhjkEovr5JAUOOfHqAB6NrXhsQWuOrSyEolFX42EFG+vDDZBZnlWYVI9u
	7fLWmw4AZnN2RKP6LtJSIIQHxGxvvCJquOq70p/a8Q8veN6DhJZuZbLMr4mh51tfrgSiSwoSwgeyF
	xh/f9eBw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:32850 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vkL2h-000000004gr-3368;
	Mon, 26 Jan 2026 11:46:04 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vkL2d-00000005utI-1mV3;
	Mon, 26 Jan 2026 11:45:59 +0000
In-Reply-To: <aXdTi4ViCkhhXvFI@shell.armlinux.org.uk>
References: <aXdTi4ViCkhhXvFI@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v2 12/22] net: stmmac: rk: use rk_encode_wm16() for
 RGMII clocks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vkL2d-00000005utI-1mV3@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 26 Jan 2026 11:45:59 +0000
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
	TAGGED_FROM(0.00)[bounces-253446-lists,netdev=lfdr.de,kernel];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rmk-PC.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 70FB987D0F
X-Rspamd-Action: no action

As all of the RGMII clock selection bitfields (gmii_clk_sel) use the
same encoding, parameterise this by providing the bitfield mask in
the BSP private data.

This is the last user of GRF_FIELD_CONST(), so remove that definition
as well.

One additional change is for RK3328 - as only gmac2io supports RGMII,
only initialise the mask for this instance.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 100 +++++++-----------
 1 file changed, 36 insertions(+), 64 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 7e82b1831e5b..71fb4f08e610 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -26,10 +26,11 @@
 
 struct rk_priv_data;
 
+struct rk_clock_fields {
+	u16 gmii_clk_sel_mask;
+};
+
 struct rk_reg_speed_data {
-	unsigned int rgmii_10;
-	unsigned int rgmii_100;
-	unsigned int rgmii_1000;
 	unsigned int rmii_10;
 	unsigned int rmii_100;
 };
@@ -51,6 +52,7 @@ struct rk_gmac_ops {
 	u16 gmac_rmii_mode_mask;
 
 	u16 clock_grf_reg;
+	struct rk_clock_fields clock;
 
 	bool gmac_grf_reg_in_php;
 	bool clock_grf_reg_in_php;
@@ -105,12 +107,24 @@ struct rk_priv_data {
 	u16 gmac_rmii_mode_mask;
 
 	u16 clock_grf_reg;
+	struct rk_clock_fields clock;
 };
 
 #define GMAC_CLK_DIV1_125M		0
 #define GMAC_CLK_DIV50_2_5M		2
 #define GMAC_CLK_DIV5_25M		3
 
+static int rk_gmac_rgmii_clk_div(int speed)
+{
+	if (speed == SPEED_10)
+		return GMAC_CLK_DIV50_2_5M;
+	if (speed == SPEED_100)
+		return GMAC_CLK_DIV5_25M;
+	if (speed == SPEED_1000)
+		return GMAC_CLK_DIV1_125M;
+	return -EINVAL;
+}
+
 static int rk_get_phy_intf_sel(phy_interface_t interface)
 {
 	int ret = stmmac_get_phy_intf_sel(interface);
@@ -161,20 +175,14 @@ static int rk_set_reg_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
 	unsigned int val;
+	int ret;
 
 	if (phy_interface_mode_is_rgmii(interface)) {
-		if (speed == SPEED_10) {
-			val = rsd->rgmii_10;
-		} else if (speed == SPEED_100) {
-			val = rsd->rgmii_100;
-		} else if (speed == SPEED_1000) {
-			val = rsd->rgmii_1000;
-		} else {
-			/* Phylink will not allow inappropriate speeds for
-			 * interface modes, so this should never happen.
-			 */
-			return -EINVAL;
-		}
+		ret = rk_gmac_rgmii_clk_div(speed);
+		if (ret < 0)
+			return ret;
+
+		val = rk_encode_wm16(ret, bsp_priv->clock.gmii_clk_sel_mask);
 	} else if (interface == PHY_INTERFACE_MODE_RMII) {
 		if (speed == SPEED_10) {
 			val = rsd->rmii_10;
@@ -215,8 +223,6 @@ static int rk_set_clk_mac_speed(struct rk_priv_data *bsp_priv,
 
 #define GRF_FIELD(hi, lo, val)		\
 	FIELD_PREP_WM16(GENMASK_U16(hi, lo), val)
-#define GRF_FIELD_CONST(hi, lo, val)	\
-	FIELD_PREP_WM16_CONST(GENMASK_U16(hi, lo), val)
 
 #define GRF_BIT(nr)			(BIT(nr) | BIT(nr+16))
 #define GRF_CLR_BIT(nr)			(BIT(nr+16))
@@ -362,7 +368,6 @@ static const struct rk_gmac_ops px30_ops = {
 #define RK3128_GMAC_SPEED_100M         GRF_BIT(10)
 #define RK3128_GMAC_RMII_CLK_25M       GRF_BIT(11)
 #define RK3128_GMAC_RMII_CLK_2_5M      GRF_CLR_BIT(11)
-#define RK3128_GMAC_CLK(val)           GRF_FIELD_CONST(13, 12, val)
 
 static void rk3128_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
@@ -378,9 +383,6 @@ static void rk3128_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3128_reg_speed_data = {
-	.rgmii_10 = RK3128_GMAC_CLK(GMAC_CLK_DIV50_2_5M),
-	.rgmii_100 = RK3128_GMAC_CLK(GMAC_CLK_DIV5_25M),
-	.rgmii_1000 = RK3128_GMAC_CLK(GMAC_CLK_DIV1_125M),
 	.rmii_10 = RK3128_GMAC_RMII_CLK_2_5M | RK3128_GMAC_SPEED_10M,
 	.rmii_100 = RK3128_GMAC_RMII_CLK_25M | RK3128_GMAC_SPEED_100M,
 };
@@ -402,6 +404,7 @@ static const struct rk_gmac_ops rk3128_ops = {
 	.gmac_rmii_mode_mask = BIT_U16(14),
 
 	.clock_grf_reg = RK3128_GRF_MAC_CON1,
+	.clock.gmii_clk_sel_mask = GENMASK_U16(13, 12),
 };
 
 #define RK3228_GRF_MAC_CON0	0x0900
@@ -420,7 +423,6 @@ static const struct rk_gmac_ops rk3128_ops = {
 #define RK3228_GMAC_SPEED_100M		GRF_BIT(2)
 #define RK3228_GMAC_RMII_CLK_25M	GRF_BIT(7)
 #define RK3228_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(7)
-#define RK3228_GMAC_CLK(val)		GRF_FIELD_CONST(9, 8, val)
 #define RK3228_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(0)
 #define RK3228_GMAC_TXCLK_DLY_DISABLE	GRF_CLR_BIT(0)
 #define RK3228_GMAC_RXCLK_DLY_ENABLE	GRF_BIT(1)
@@ -447,9 +449,6 @@ static void rk3228_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3228_reg_speed_data = {
-	.rgmii_10 = RK3228_GMAC_CLK(GMAC_CLK_DIV50_2_5M),
-	.rgmii_100 = RK3228_GMAC_CLK(GMAC_CLK_DIV5_25M),
-	.rgmii_1000 = RK3228_GMAC_CLK(GMAC_CLK_DIV1_125M),
 	.rmii_10 = RK3228_GMAC_RMII_CLK_2_5M | RK3228_GMAC_SPEED_10M,
 	.rmii_100 = RK3228_GMAC_RMII_CLK_25M | RK3228_GMAC_SPEED_100M,
 };
@@ -481,6 +480,7 @@ static const struct rk_gmac_ops rk3228_ops = {
 	.gmac_rmii_mode_mask = BIT_U16(10),
 
 	.clock_grf_reg = RK3228_GRF_MAC_CON1,
+	.clock.gmii_clk_sel_mask = GENMASK_U16(9, 8),
 };
 
 #define RK3288_GRF_SOC_CON1	0x0248
@@ -493,7 +493,6 @@ static const struct rk_gmac_ops rk3228_ops = {
 #define RK3288_GMAC_SPEED_100M		GRF_BIT(10)
 #define RK3288_GMAC_RMII_CLK_25M	GRF_BIT(11)
 #define RK3288_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(11)
-#define RK3288_GMAC_CLK(val)		GRF_FIELD_CONST(13, 12, val)
 
 /*RK3288_GRF_SOC_CON3*/
 #define RK3288_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(14)
@@ -517,9 +516,6 @@ static void rk3288_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3288_reg_speed_data = {
-	.rgmii_10 = RK3288_GMAC_CLK(GMAC_CLK_DIV50_2_5M),
-	.rgmii_100 = RK3288_GMAC_CLK(GMAC_CLK_DIV5_25M),
-	.rgmii_1000 = RK3288_GMAC_CLK(GMAC_CLK_DIV1_125M),
 	.rmii_10 = RK3288_GMAC_RMII_CLK_2_5M | RK3288_GMAC_SPEED_10M,
 	.rmii_100 = RK3288_GMAC_RMII_CLK_25M | RK3288_GMAC_SPEED_100M,
 };
@@ -541,6 +537,7 @@ static const struct rk_gmac_ops rk3288_ops = {
 	.gmac_rmii_mode_mask = BIT_U16(14),
 
 	.clock_grf_reg = RK3288_GRF_SOC_CON1,
+	.clock.gmii_clk_sel_mask = GENMASK_U16(13, 12),
 };
 
 #define RK3308_GRF_MAC_CON0		0x04a0
@@ -593,7 +590,6 @@ static const struct rk_gmac_ops rk3308_ops = {
 #define RK3328_GMAC_SPEED_100M		GRF_BIT(2)
 #define RK3328_GMAC_RMII_CLK_25M	GRF_BIT(7)
 #define RK3328_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(7)
-#define RK3328_GMAC_CLK(val)		GRF_FIELD_CONST(12, 11, val)
 #define RK3328_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(0)
 #define RK3328_GMAC_RXCLK_DLY_ENABLE	GRF_BIT(1)
 
@@ -606,6 +602,7 @@ static int rk3328_init(struct rk_priv_data *bsp_priv)
 	case 0: /* gmac2io */
 		bsp_priv->gmac_grf_reg = RK3328_GRF_MAC_CON1;
 		bsp_priv->clock_grf_reg = RK3328_GRF_MAC_CON1;
+		bsp_priv->clock.gmii_clk_sel_mask = GENMASK_U16(12, 11);
 		return 0;
 
 	case 1: /* gmac2phy */
@@ -635,9 +632,6 @@ static void rk3328_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3328_reg_speed_data = {
-	.rgmii_10 = RK3328_GMAC_CLK(GMAC_CLK_DIV50_2_5M),
-	.rgmii_100 = RK3328_GMAC_CLK(GMAC_CLK_DIV5_25M),
-	.rgmii_1000 = RK3328_GMAC_CLK(GMAC_CLK_DIV1_125M),
 	.rmii_10 = RK3328_GMAC_RMII_CLK_2_5M | RK3328_GMAC_SPEED_10M,
 	.rmii_100 = RK3328_GMAC_RMII_CLK_25M | RK3328_GMAC_SPEED_100M,
 };
@@ -686,7 +680,6 @@ static const struct rk_gmac_ops rk3328_ops = {
 #define RK3366_GMAC_SPEED_100M		GRF_BIT(7)
 #define RK3366_GMAC_RMII_CLK_25M	GRF_BIT(3)
 #define RK3366_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
-#define RK3366_GMAC_CLK(val)		GRF_FIELD_CONST(5, 4, val)
 
 /* RK3366_GRF_SOC_CON7 */
 #define RK3366_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(7)
@@ -710,9 +703,6 @@ static void rk3366_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3366_reg_speed_data = {
-	.rgmii_10 = RK3366_GMAC_CLK(GMAC_CLK_DIV50_2_5M),
-	.rgmii_100 = RK3366_GMAC_CLK(GMAC_CLK_DIV5_25M),
-	.rgmii_1000 = RK3366_GMAC_CLK(GMAC_CLK_DIV1_125M),
 	.rmii_10 = RK3366_GMAC_RMII_CLK_2_5M | RK3366_GMAC_SPEED_10M,
 	.rmii_100 = RK3366_GMAC_RMII_CLK_25M | RK3366_GMAC_SPEED_100M,
 };
@@ -734,6 +724,7 @@ static const struct rk_gmac_ops rk3366_ops = {
 	.gmac_rmii_mode_mask = BIT_U16(6),
 
 	.clock_grf_reg = RK3366_GRF_SOC_CON6,
+	.clock.gmii_clk_sel_mask = GENMASK_U16(5, 4),
 };
 
 #define RK3368_GRF_SOC_CON15	0x043c
@@ -746,7 +737,6 @@ static const struct rk_gmac_ops rk3366_ops = {
 #define RK3368_GMAC_SPEED_100M		GRF_BIT(7)
 #define RK3368_GMAC_RMII_CLK_25M	GRF_BIT(3)
 #define RK3368_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
-#define RK3368_GMAC_CLK(val)		GRF_FIELD_CONST(5, 4, val)
 
 /* RK3368_GRF_SOC_CON16 */
 #define RK3368_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(7)
@@ -770,9 +760,6 @@ static void rk3368_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3368_reg_speed_data = {
-	.rgmii_10 = RK3368_GMAC_CLK(GMAC_CLK_DIV50_2_5M),
-	.rgmii_100 = RK3368_GMAC_CLK(GMAC_CLK_DIV5_25M),
-	.rgmii_1000 = RK3368_GMAC_CLK(GMAC_CLK_DIV1_125M),
 	.rmii_10 = RK3368_GMAC_RMII_CLK_2_5M | RK3368_GMAC_SPEED_10M,
 	.rmii_100 = RK3368_GMAC_RMII_CLK_25M | RK3368_GMAC_SPEED_100M,
 };
@@ -794,6 +781,7 @@ static const struct rk_gmac_ops rk3368_ops = {
 	.gmac_rmii_mode_mask = BIT_U16(6),
 
 	.clock_grf_reg = RK3368_GRF_SOC_CON15,
+	.clock.gmii_clk_sel_mask = GENMASK_U16(5, 4),
 };
 
 #define RK3399_GRF_SOC_CON5	0xc214
@@ -806,7 +794,6 @@ static const struct rk_gmac_ops rk3368_ops = {
 #define RK3399_GMAC_SPEED_100M		GRF_BIT(7)
 #define RK3399_GMAC_RMII_CLK_25M	GRF_BIT(3)
 #define RK3399_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
-#define RK3399_GMAC_CLK(val)		GRF_FIELD_CONST(5, 4, val)
 
 /* RK3399_GRF_SOC_CON6 */
 #define RK3399_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(7)
@@ -830,9 +817,6 @@ static void rk3399_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3399_reg_speed_data = {
-	.rgmii_10 = RK3399_GMAC_CLK(GMAC_CLK_DIV50_2_5M),
-	.rgmii_100 = RK3399_GMAC_CLK(GMAC_CLK_DIV5_25M),
-	.rgmii_1000 = RK3399_GMAC_CLK(GMAC_CLK_DIV1_125M),
 	.rmii_10 = RK3399_GMAC_RMII_CLK_2_5M | RK3399_GMAC_SPEED_10M,
 	.rmii_100 = RK3399_GMAC_RMII_CLK_25M | RK3399_GMAC_SPEED_100M,
 };
@@ -854,6 +838,7 @@ static const struct rk_gmac_ops rk3399_ops = {
 	.gmac_rmii_mode_mask = BIT_U16(6),
 
 	.clock_grf_reg = RK3399_GRF_SOC_CON5,
+	.clock.gmii_clk_sel_mask = GENMASK_U16(5, 4),
 };
 
 #define RK3506_GRF_SOC_CON8		0x0020
@@ -959,8 +944,6 @@ static const struct rk_gmac_ops rk3506_ops = {
 #define RK3528_GMAC1_CLK_RMII_DIV2	GRF_BIT(10)
 #define RK3528_GMAC1_CLK_RMII_DIV20	GRF_CLR_BIT(10)
 
-#define RK3528_GMAC1_CLK_RGMII(val)	GRF_FIELD_CONST(11, 10, val)
-
 #define RK3528_GMAC0_CLK_RMII_GATE	GRF_BIT(2)
 #define RK3528_GMAC0_CLK_RMII_NOGATE	GRF_CLR_BIT(2)
 #define RK3528_GMAC1_CLK_RMII_GATE	GRF_BIT(9)
@@ -975,6 +958,7 @@ static int rk3528_init(struct rk_priv_data *bsp_priv)
 
 	case 1:
 		bsp_priv->clock_grf_reg = RK3528_VPU_GRF_GMAC_CON5;
+		bsp_priv->clock.gmii_clk_sel_mask = GENMASK_U16(11, 10);
 		return 0;
 
 	default:
@@ -1012,9 +996,6 @@ static const struct rk_reg_speed_data rk3528_gmac0_reg_speed_data = {
 };
 
 static const struct rk_reg_speed_data rk3528_gmac1_reg_speed_data = {
-	.rgmii_10 = RK3528_GMAC1_CLK_RGMII(GMAC_CLK_DIV50_2_5M),
-	.rgmii_100 = RK3528_GMAC1_CLK_RGMII(GMAC_CLK_DIV5_25M),
-	.rgmii_1000 = RK3528_GMAC1_CLK_RGMII(GMAC_CLK_DIV1_125M),
 	.rmii_10 = RK3528_GMAC1_CLK_RMII_DIV20,
 	.rmii_100 = RK3528_GMAC1_CLK_RMII_DIV2,
 };
@@ -1172,8 +1153,6 @@ static const struct rk_gmac_ops rk3568_ops = {
 #define RK3576_GMAC_CLK_RMII_DIV2		GRF_BIT(5)
 #define RK3576_GMAC_CLK_RMII_DIV20		GRF_CLR_BIT(5)
 
-#define RK3576_GMAC_CLK_RGMII(val)		GRF_FIELD_CONST(6, 5, val)
-
 #define RK3576_GMAC_CLK_RMII_GATE		GRF_BIT(4)
 #define RK3576_GMAC_CLK_RMII_NOGATE		GRF_CLR_BIT(4)
 
@@ -1223,9 +1202,6 @@ static void rk3576_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3578_reg_speed_data = {
-	.rgmii_10 = RK3576_GMAC_CLK_RGMII(GMAC_CLK_DIV50_2_5M),
-	.rgmii_100 = RK3576_GMAC_CLK_RGMII(GMAC_CLK_DIV5_25M),
-	.rgmii_1000 = RK3576_GMAC_CLK_RGMII(GMAC_CLK_DIV1_125M),
 	.rmii_10 = RK3576_GMAC_CLK_RMII_DIV20,
 	.rmii_100 = RK3576_GMAC_CLK_RMII_DIV2,
 };
@@ -1262,6 +1238,8 @@ static const struct rk_gmac_ops rk3576_ops = {
 
 	.gmac_rmii_mode_mask = BIT_U16(3),
 
+	.clock.gmii_clk_sel_mask = GENMASK_U16(6, 5),
+
 	.php_grf_required = true,
 	.regs_valid = true,
 	.regs = {
@@ -1297,9 +1275,6 @@ static const struct rk_gmac_ops rk3576_ops = {
 #define RK3588_GMA_CLK_RMII_DIV2(id)		GRF_BIT(5 * (id) + 2)
 #define RK3588_GMA_CLK_RMII_DIV20(id)		GRF_CLR_BIT(5 * (id) + 2)
 
-#define RK3588_GMAC_CLK_RGMII(id, val)		\
-	(GRF_FIELD_CONST(3, 2, val) << ((id) * 5))
-
 #define RK3588_GMAC_CLK_RMII_GATE(id)		GRF_BIT(5 * (id) + 1)
 #define RK3588_GMAC_CLK_RMII_NOGATE(id)		GRF_CLR_BIT(5 * (id) + 1)
 
@@ -1308,10 +1283,12 @@ static int rk3588_init(struct rk_priv_data *bsp_priv)
 	switch (bsp_priv->id) {
 	case 0:
 		bsp_priv->gmac_phy_intf_sel_mask = GENMASK_U16(5, 3);
+		bsp_priv->clock.gmii_clk_sel_mask = GENMASK_U16(3, 2);
 		return 0;
 
 	case 1:
 		bsp_priv->gmac_phy_intf_sel_mask = GENMASK_U16(11, 9);
+		bsp_priv->clock.gmii_clk_sel_mask = GENMASK_U16(8, 7);
 		return 0;
 
 	default:
@@ -1346,17 +1323,11 @@ static void rk3588_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3588_gmac0_speed_data = {
-	.rgmii_10 = RK3588_GMAC_CLK_RGMII(0, GMAC_CLK_DIV50_2_5M),
-	.rgmii_100 = RK3588_GMAC_CLK_RGMII(0, GMAC_CLK_DIV5_25M),
-	.rgmii_1000 = RK3588_GMAC_CLK_RGMII(0, GMAC_CLK_DIV1_125M),
 	.rmii_10 = RK3588_GMA_CLK_RMII_DIV20(0),
 	.rmii_100 = RK3588_GMA_CLK_RMII_DIV2(0),
 };
 
 static const struct rk_reg_speed_data rk3588_gmac1_speed_data = {
-	.rgmii_10 = RK3588_GMAC_CLK_RGMII(1, GMAC_CLK_DIV50_2_5M),
-	.rgmii_100 = RK3588_GMAC_CLK_RGMII(1, GMAC_CLK_DIV5_25M),
-	.rgmii_1000 = RK3588_GMAC_CLK_RGMII(1, GMAC_CLK_DIV1_125M),
 	.rmii_10 = RK3588_GMA_CLK_RMII_DIV20(1),
 	.rmii_100 = RK3588_GMA_CLK_RMII_DIV2(1),
 };
@@ -1726,6 +1697,7 @@ static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
 
 	/* Set the default clock control register related parameters */
 	bsp_priv->clock_grf_reg = ops->clock_grf_reg;
+	bsp_priv->clock = ops->clock;
 
 	if (ops->init) {
 		ret = ops->init(bsp_priv);
-- 
2.47.3


