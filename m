Return-Path: <netdev+bounces-252802-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qO1XOmFVc2kDuwAAu9opvQ
	(envelope-from <netdev+bounces-252802-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:02:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A5474BEE
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 495CA3008D30
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549AD2C0F79;
	Fri, 23 Jan 2026 11:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Pf8Pk5Gd"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35BD22D78A
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166099; cv=none; b=TI0o6xeE7hwpgKBec1O6bQ4og2KAHo0fuEY76GEU14M4CV3F+/XtvywdIatsdSdNMQlwTjx1Lwkx1PJ54DH3ENuHYRm/n6yak1lxJulITFCuhUfcVPvQGK13Vnd29M7krqXk5VC0n7PBG7OWNfLUYqfojroequ3VQYxedBKG8ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166099; c=relaxed/simple;
	bh=jeka+04x0P+6GGU+sDMEYunYCyf8QnxP8cTkpp2l8rA=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=riKGT/rpyFanogMW28soY/rlPy6gE5kECE/F/S4NJ7PeAu/ZXJMePNxLqT/xK0XS6xgKMaiwA7Ez/hvITMHLkO4xtO3i0pc2yFj1HeWDEa65D39rU/fBLvWHV9boA1xz4IEh4pD1p35uqI+VkEXLrdbx+x0ITqqv0+e5bnFHjpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Pf8Pk5Gd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0pAMmV06WpTBpCMnulw6ANqIkvdXlb2C/XPgyVldDps=; b=Pf8Pk5Gd0ZvF/1sYeTFDn/SnJJ
	4+8CMGILcOgQqd00g6ekLouax+SUGvMFrsy/miCb2qiC3SarF4zYU8LyHCzRbLuf8PP8/43X53Arm
	M2g8TIg8zORqRJ8u5VNOQWWvobFTkBLvAOSu6dBtdfgJODLvatzr1B7kDYELEnf/CtvDPqBMYqFjl
	NUgH8SwUHJyi6hQfTcE0hYDP9CHQcxPJPU8dCfiuIKp9aDdZP6Th93Soa/WUvqkjZvqAxVgRCaYoa
	5Xr6Y29490aOkLqTZys2g0Ff3/PnEuNdaNLZS49YqGTW/RnmIMgbNAIrYzaRQfN/3tkfzEkErgeGt
	T2uicy2g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50526 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vjEuo-000000001pb-16OS;
	Fri, 23 Jan 2026 11:01:22 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vjEul-00000005ggi-0CAA;
	Fri, 23 Jan 2026 11:01:19 +0000
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
Subject: [PATCH net-next 12/21] net: stmmac: rk: use rk_encode_wm16() for RMII
 speed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vjEul-00000005ggi-0CAA@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 23 Jan 2026 11:01:19 +0000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252802-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rmk-PC.armlinux.org.uk:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: D8A5474BEE
X-Rspamd-Action: no action

The RMII speed configuration is encoded as a single bit, which is set
for 100M and clean for 10M. Provide the bitfield definition in
struct rk_clock_fields, moving it out of struct rk_reg_speed_data's
rmii_10 and rmii_100 initialisers. Update rk_set_reg_speed() to handle
the new definition location of this bit.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 69 +++++++++----------
 1 file changed, 31 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 0f94304e721a..48852054390d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -28,6 +28,7 @@ struct rk_priv_data;
 
 struct rk_clock_fields {
 	u16 gmii_clk_sel_mask;
+	u16 mac_speed_mask;
 };
 
 struct rk_reg_speed_data {
@@ -171,10 +172,12 @@ static int rk_set_reg_speed(struct rk_priv_data *bsp_priv,
 
 		val = rk_encode_wm16(ret, bsp_priv->clock.gmii_clk_sel_mask);
 	} else if (interface == PHY_INTERFACE_MODE_RMII) {
+		val = rk_encode_wm16(speed == SPEED_100,
+				     bsp_priv->clock.mac_speed_mask);
 		if (speed == SPEED_10) {
-			val = rsd->rmii_10;
+			val |= rsd->rmii_10;
 		} else if (speed == SPEED_100) {
-			val = rsd->rmii_100;
+			val |= rsd->rmii_100;
 		} else {
 			/* Phylink will not allow inappropriate speeds for
 			 * interface modes, so this should never happen.
@@ -351,8 +354,6 @@ static const struct rk_gmac_ops px30_ops = {
 /* RK3128_GRF_MAC_CON1 */
 #define RK3128_GMAC_FLOW_CTRL          GRF_BIT(9)
 #define RK3128_GMAC_FLOW_CTRL_CLR      GRF_CLR_BIT(9)
-#define RK3128_GMAC_SPEED_10M          GRF_CLR_BIT(10)
-#define RK3128_GMAC_SPEED_100M         GRF_BIT(10)
 #define RK3128_GMAC_RMII_CLK_25M       GRF_BIT(11)
 #define RK3128_GMAC_RMII_CLK_2_5M      GRF_CLR_BIT(11)
 
@@ -370,8 +371,8 @@ static void rk3128_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3128_reg_speed_data = {
-	.rmii_10 = RK3128_GMAC_RMII_CLK_2_5M | RK3128_GMAC_SPEED_10M,
-	.rmii_100 = RK3128_GMAC_RMII_CLK_25M | RK3128_GMAC_SPEED_100M,
+	.rmii_10 = RK3128_GMAC_RMII_CLK_2_5M,
+	.rmii_100 = RK3128_GMAC_RMII_CLK_25M,
 };
 
 static int rk3128_set_speed(struct rk_priv_data *bsp_priv,
@@ -392,6 +393,7 @@ static const struct rk_gmac_ops rk3128_ops = {
 
 	.clock_grf_reg = RK3128_GRF_MAC_CON1,
 	.clock.gmii_clk_sel_mask = GENMASK_U16(13, 12),
+	.clock.mac_speed_mask = BIT_U16(10),
 };
 
 #define RK3228_GRF_MAC_CON0	0x0900
@@ -406,8 +408,6 @@ static const struct rk_gmac_ops rk3128_ops = {
 /* RK3228_GRF_MAC_CON1 */
 #define RK3228_GMAC_FLOW_CTRL		GRF_BIT(3)
 #define RK3228_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
-#define RK3228_GMAC_SPEED_10M		GRF_CLR_BIT(2)
-#define RK3228_GMAC_SPEED_100M		GRF_BIT(2)
 #define RK3228_GMAC_RMII_CLK_25M	GRF_BIT(7)
 #define RK3228_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(7)
 #define RK3228_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(0)
@@ -436,8 +436,8 @@ static void rk3228_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3228_reg_speed_data = {
-	.rmii_10 = RK3228_GMAC_RMII_CLK_2_5M | RK3228_GMAC_SPEED_10M,
-	.rmii_100 = RK3228_GMAC_RMII_CLK_25M | RK3228_GMAC_SPEED_100M,
+	.rmii_10 = RK3228_GMAC_RMII_CLK_2_5M,
+	.rmii_100 = RK3228_GMAC_RMII_CLK_25M,
 };
 
 static int rk3228_set_speed(struct rk_priv_data *bsp_priv,
@@ -468,6 +468,7 @@ static const struct rk_gmac_ops rk3228_ops = {
 
 	.clock_grf_reg = RK3228_GRF_MAC_CON1,
 	.clock.gmii_clk_sel_mask = GENMASK_U16(9, 8),
+	.clock.mac_speed_mask = BIT_U16(2),
 };
 
 #define RK3288_GRF_SOC_CON1	0x0248
@@ -476,8 +477,6 @@ static const struct rk_gmac_ops rk3228_ops = {
 /*RK3288_GRF_SOC_CON1*/
 #define RK3288_GMAC_FLOW_CTRL		GRF_BIT(9)
 #define RK3288_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(9)
-#define RK3288_GMAC_SPEED_10M		GRF_CLR_BIT(10)
-#define RK3288_GMAC_SPEED_100M		GRF_BIT(10)
 #define RK3288_GMAC_RMII_CLK_25M	GRF_BIT(11)
 #define RK3288_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(11)
 
@@ -503,8 +502,8 @@ static void rk3288_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3288_reg_speed_data = {
-	.rmii_10 = RK3288_GMAC_RMII_CLK_2_5M | RK3288_GMAC_SPEED_10M,
-	.rmii_100 = RK3288_GMAC_RMII_CLK_25M | RK3288_GMAC_SPEED_100M,
+	.rmii_10 = RK3288_GMAC_RMII_CLK_2_5M,
+	.rmii_100 = RK3288_GMAC_RMII_CLK_25M,
 };
 
 static int rk3288_set_speed(struct rk_priv_data *bsp_priv,
@@ -525,6 +524,7 @@ static const struct rk_gmac_ops rk3288_ops = {
 
 	.clock_grf_reg = RK3288_GRF_SOC_CON1,
 	.clock.gmii_clk_sel_mask = GENMASK_U16(13, 12),
+	.clock.mac_speed_mask = BIT_U16(10),
 };
 
 #define RK3308_GRF_MAC_CON0		0x04a0
@@ -532,16 +532,12 @@ static const struct rk_gmac_ops rk3288_ops = {
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
@@ -559,6 +555,7 @@ static const struct rk_gmac_ops rk3308_ops = {
 	.gmac_phy_intf_sel_mask = GENMASK_U16(4, 2),
 
 	.clock_grf_reg = RK3308_GRF_MAC_CON0,
+	.clock.mac_speed_mask = BIT_U16(0),
 };
 
 #define RK3328_GRF_MAC_CON0	0x0900
@@ -573,8 +570,6 @@ static const struct rk_gmac_ops rk3308_ops = {
 /* RK3328_GRF_MAC_CON1 */
 #define RK3328_GMAC_FLOW_CTRL		GRF_BIT(3)
 #define RK3328_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
-#define RK3328_GMAC_SPEED_10M		GRF_CLR_BIT(2)
-#define RK3328_GMAC_SPEED_100M		GRF_BIT(2)
 #define RK3328_GMAC_RMII_CLK_25M	GRF_BIT(7)
 #define RK3328_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(7)
 #define RK3328_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(0)
@@ -619,8 +614,8 @@ static void rk3328_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3328_reg_speed_data = {
-	.rmii_10 = RK3328_GMAC_RMII_CLK_2_5M | RK3328_GMAC_SPEED_10M,
-	.rmii_100 = RK3328_GMAC_RMII_CLK_25M | RK3328_GMAC_SPEED_100M,
+	.rmii_10 = RK3328_GMAC_RMII_CLK_2_5M,
+	.rmii_100 = RK3328_GMAC_RMII_CLK_25M,
 };
 
 static int rk3328_set_speed(struct rk_priv_data *bsp_priv,
@@ -649,6 +644,8 @@ static const struct rk_gmac_ops rk3328_ops = {
 	.gmac_phy_intf_sel_mask = GENMASK_U16(6, 4),
 	.gmac_rmii_mode_mask = BIT_U16(9),
 
+	.clock.mac_speed_mask = BIT_U16(2),
+
 	.regs_valid = true,
 	.regs = {
 		0xff540000, /* gmac2io */
@@ -663,8 +660,6 @@ static const struct rk_gmac_ops rk3328_ops = {
 /* RK3366_GRF_SOC_CON6 */
 #define RK3366_GMAC_FLOW_CTRL		GRF_BIT(8)
 #define RK3366_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(8)
-#define RK3366_GMAC_SPEED_10M		GRF_CLR_BIT(7)
-#define RK3366_GMAC_SPEED_100M		GRF_BIT(7)
 #define RK3366_GMAC_RMII_CLK_25M	GRF_BIT(3)
 #define RK3366_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
 
@@ -690,8 +685,8 @@ static void rk3366_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3366_reg_speed_data = {
-	.rmii_10 = RK3366_GMAC_RMII_CLK_2_5M | RK3366_GMAC_SPEED_10M,
-	.rmii_100 = RK3366_GMAC_RMII_CLK_25M | RK3366_GMAC_SPEED_100M,
+	.rmii_10 = RK3366_GMAC_RMII_CLK_2_5M,
+	.rmii_100 = RK3366_GMAC_RMII_CLK_25M,
 };
 
 static int rk3366_set_speed(struct rk_priv_data *bsp_priv,
@@ -712,6 +707,7 @@ static const struct rk_gmac_ops rk3366_ops = {
 
 	.clock_grf_reg = RK3366_GRF_SOC_CON6,
 	.clock.gmii_clk_sel_mask = GENMASK_U16(5, 4),
+	.clock.mac_speed_mask = BIT_U16(7),
 };
 
 #define RK3368_GRF_SOC_CON15	0x043c
@@ -720,8 +716,6 @@ static const struct rk_gmac_ops rk3366_ops = {
 /* RK3368_GRF_SOC_CON15 */
 #define RK3368_GMAC_FLOW_CTRL		GRF_BIT(8)
 #define RK3368_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(8)
-#define RK3368_GMAC_SPEED_10M		GRF_CLR_BIT(7)
-#define RK3368_GMAC_SPEED_100M		GRF_BIT(7)
 #define RK3368_GMAC_RMII_CLK_25M	GRF_BIT(3)
 #define RK3368_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
 
@@ -747,8 +741,8 @@ static void rk3368_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3368_reg_speed_data = {
-	.rmii_10 = RK3368_GMAC_RMII_CLK_2_5M | RK3368_GMAC_SPEED_10M,
-	.rmii_100 = RK3368_GMAC_RMII_CLK_25M | RK3368_GMAC_SPEED_100M,
+	.rmii_10 = RK3368_GMAC_RMII_CLK_2_5M,
+	.rmii_100 = RK3368_GMAC_RMII_CLK_25M,
 };
 
 static int rk3368_set_speed(struct rk_priv_data *bsp_priv,
@@ -769,6 +763,7 @@ static const struct rk_gmac_ops rk3368_ops = {
 
 	.clock_grf_reg = RK3368_GRF_SOC_CON15,
 	.clock.gmii_clk_sel_mask = GENMASK_U16(5, 4),
+	.clock.mac_speed_mask = BIT_U16(7),
 };
 
 #define RK3399_GRF_SOC_CON5	0xc214
@@ -777,8 +772,6 @@ static const struct rk_gmac_ops rk3368_ops = {
 /* RK3399_GRF_SOC_CON5 */
 #define RK3399_GMAC_FLOW_CTRL		GRF_BIT(8)
 #define RK3399_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(8)
-#define RK3399_GMAC_SPEED_10M		GRF_CLR_BIT(7)
-#define RK3399_GMAC_SPEED_100M		GRF_BIT(7)
 #define RK3399_GMAC_RMII_CLK_25M	GRF_BIT(3)
 #define RK3399_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
 
@@ -804,8 +797,8 @@ static void rk3399_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rk3399_reg_speed_data = {
-	.rmii_10 = RK3399_GMAC_RMII_CLK_2_5M | RK3399_GMAC_SPEED_10M,
-	.rmii_100 = RK3399_GMAC_RMII_CLK_25M | RK3399_GMAC_SPEED_100M,
+	.rmii_10 = RK3399_GMAC_RMII_CLK_2_5M,
+	.rmii_100 = RK3399_GMAC_RMII_CLK_25M,
 };
 
 static int rk3399_set_speed(struct rk_priv_data *bsp_priv,
@@ -826,6 +819,7 @@ static const struct rk_gmac_ops rk3399_ops = {
 
 	.clock_grf_reg = RK3399_GRF_SOC_CON5,
 	.clock.gmii_clk_sel_mask = GENMASK_U16(5, 4),
+	.clock.mac_speed_mask = BIT_U16(7),
 };
 
 #define RK3506_GRF_SOC_CON8		0x0020
@@ -1370,8 +1364,6 @@ static const struct rk_gmac_ops rk3588_ops = {
 /* RV1108_GRF_GMAC_CON0 */
 #define RV1108_GMAC_FLOW_CTRL		GRF_BIT(3)
 #define RV1108_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
-#define RV1108_GMAC_SPEED_10M		GRF_CLR_BIT(2)
-#define RV1108_GMAC_SPEED_100M		GRF_BIT(2)
 #define RV1108_GMAC_RMII_CLK_25M	GRF_BIT(7)
 #define RV1108_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(7)
 
@@ -1380,8 +1372,8 @@ static void rv1108_set_to_rmii(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_reg_speed_data rv1108_reg_speed_data = {
-	.rmii_10 = RV1108_GMAC_RMII_CLK_2_5M | RV1108_GMAC_SPEED_10M,
-	.rmii_100 = RV1108_GMAC_RMII_CLK_25M | RV1108_GMAC_SPEED_100M,
+	.rmii_10 = RV1108_GMAC_RMII_CLK_2_5M,
+	.rmii_100 = RV1108_GMAC_RMII_CLK_25M,
 };
 
 static int rv1108_set_speed(struct rk_priv_data *bsp_priv,
@@ -1399,6 +1391,7 @@ static const struct rk_gmac_ops rv1108_ops = {
 	.gmac_phy_intf_sel_mask = GENMASK_U16(6, 4),
 
 	.clock_grf_reg = RV1108_GRF_GMAC_CON0,
+	.clock.mac_speed_mask = BIT_U16(2),
 };
 
 #define RV1126_GRF_GMAC_CON0		0X0070
-- 
2.47.3


