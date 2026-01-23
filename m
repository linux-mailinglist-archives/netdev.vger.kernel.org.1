Return-Path: <netdev+bounces-252807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wE1WABtWc2kDuwAAu9opvQ
	(envelope-from <netdev+bounces-252807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:06:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F99874C58
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BE70308FAB8
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19BC2D8DB5;
	Fri, 23 Jan 2026 11:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="C+TOxI2c"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003FC2FD1B1
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166125; cv=none; b=H8G6EixaeqXhIdBseC5pe44K78gJb9V+CuFaBceSlXA9Zthrp3PwArxtUmF4lRnyGThZTAKhnP35BgB7xYC0I77JlVMutwCMFeDIepoGCUfYBDl7Tl7JBodpyO7Y75hxgWfKi/aWW0cGbTm8xy3kM7/Ouq5UWrkr0KGy1bpxIis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166125; c=relaxed/simple;
	bh=FV9gr3mNVTqiEZPr9cmYmkjrk8UG9BYRwM6CpadHy9Y=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ur2AiaZ7KSvNMhOA7PIK42pDyCWX6eBYYTUjb1z+h9QOL5Da0RjlvxSBMifiRHjL39FZ0ojizVprJqRTS5NmhcuIWnYdEBHWzvwvfu1LJZEdrDmuDQW8GiqH97iddURMq2tzaMjFPUc8Zz4Yvu8Ja+WBf6DbHOttgctohutKolo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=C+TOxI2c; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qMuB1VqNdz1rKZJjl+xE7obRNyqoPwjPfuMuD+Mcmmk=; b=C+TOxI2cjPw/02paiTqrI9Uson
	ZGmkdXdZg5+G636dhJACmRZgWAZRL1x+RtMNZroOrCVVyjCUC14c08cZNX5USJKxw8JA23OiS1KBQ
	hc+1eRWo2P7MG29dOJmxCdFeyLdcLUkaIq+GMllWAHI+nJ3hWSNWt72q3MABLZKUUGXXGM/Ua8ToM
	s0mBDMMXirDqPNUqzmMqfRJaN++ow/xKBeij4rnkVJAak8n6kGfV2L+CT0/J/h3HHgDaRiRAp+Ofc
	cqXpTKVvp/4WFCfFed8nWQXKZ9286jslMlfVotJgqVyxwNRnD5E1DLpXYNA1B2fuTdTV/2hmOHVf7
	gO/16rHw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42720 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vjEvE-000000001r6-0lTb;
	Fri, 23 Jan 2026 11:01:49 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vjEvA-00000005ghD-2i2t;
	Fri, 23 Jan 2026 11:01:44 +0000
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
Subject: [PATCH net-next 17/21] net: stmmac: rk: replace empty set_to_rmii()
 with supports_rmii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vjEvA-00000005ghD-2i2t@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 23 Jan 2026 11:01:44 +0000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252807-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,rmk-PC.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3F99874C58
X-Rspamd-Action: no action

Rather than providing a now-empty set_to_rmii() method to indicate
that RMII is supported, switch to setting ops->supports_rmii instead.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 86 ++++++-------------
 1 file changed, 24 insertions(+), 62 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 49a075565832..2d464ecb0e8f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -255,12 +255,7 @@ static void rk_gmac_integrated_fephy_powerdown(struct rk_priv_data *priv,
 
 #define PX30_GRF_GMAC_CON1		0x0904
 
-static void px30_set_to_rmii(struct rk_priv_data *bsp_priv)
-{
-}
-
 static const struct rk_gmac_ops px30_ops = {
-	.set_to_rmii = px30_set_to_rmii,
 	.set_speed = rk_set_clk_mac_speed,
 
 	.gmac_grf_reg = PX30_GRF_GMAC_CON1,
@@ -268,6 +263,8 @@ static const struct rk_gmac_ops px30_ops = {
 
 	.clock_grf_reg = PX30_GRF_GMAC_CON1,
 	.clock.mac_speed_mask = BIT_U16(2),
+
+	.supports_rmii = true,
 };
 
 #define RK3128_GRF_MAC_CON0	0x0168
@@ -294,13 +291,8 @@ static void rk3128_set_to_rgmii(struct rk_priv_data *bsp_priv,
 		     RK3128_GMAC_CLK_TX_DL_CFG(tx_delay));
 }
 
-static void rk3128_set_to_rmii(struct rk_priv_data *bsp_priv)
-{
-}
-
 static const struct rk_gmac_ops rk3128_ops = {
 	.set_to_rgmii = rk3128_set_to_rgmii,
-	.set_to_rmii = rk3128_set_to_rmii,
 
 	.gmac_grf_reg = RK3128_GRF_MAC_CON1,
 	.gmac_phy_intf_sel_mask = GENMASK_U16(8, 6),
@@ -310,6 +302,8 @@ static const struct rk_gmac_ops rk3128_ops = {
 	.clock.gmii_clk_sel_mask = GENMASK_U16(13, 12),
 	.clock.rmii_clk_sel_mask = BIT_U16(11),
 	.clock.mac_speed_mask = BIT_U16(10),
+
+	.supports_rmii = true,
 };
 
 #define RK3228_GRF_MAC_CON0	0x0900
@@ -397,13 +391,8 @@ static void rk3288_set_to_rgmii(struct rk_priv_data *bsp_priv,
 		     RK3288_GMAC_CLK_TX_DL_CFG(tx_delay));
 }
 
-static void rk3288_set_to_rmii(struct rk_priv_data *bsp_priv)
-{
-}
-
 static const struct rk_gmac_ops rk3288_ops = {
 	.set_to_rgmii = rk3288_set_to_rgmii,
-	.set_to_rmii = rk3288_set_to_rmii,
 
 	.gmac_grf_reg = RK3288_GRF_SOC_CON1,
 	.gmac_phy_intf_sel_mask = GENMASK_U16(8, 6),
@@ -413,6 +402,8 @@ static const struct rk_gmac_ops rk3288_ops = {
 	.clock.gmii_clk_sel_mask = GENMASK_U16(13, 12),
 	.clock.rmii_clk_sel_mask = BIT_U16(11),
 	.clock.mac_speed_mask = BIT_U16(10),
+
+	.supports_rmii = true,
 };
 
 #define RK3308_GRF_MAC_CON0		0x04a0
@@ -421,18 +412,14 @@ static const struct rk_gmac_ops rk3288_ops = {
 #define RK3308_GMAC_FLOW_CTRL		GRF_BIT(3)
 #define RK3308_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
 
-static void rk3308_set_to_rmii(struct rk_priv_data *bsp_priv)
-{
-}
-
 static const struct rk_gmac_ops rk3308_ops = {
-	.set_to_rmii = rk3308_set_to_rmii,
-
 	.gmac_grf_reg = RK3308_GRF_MAC_CON0,
 	.gmac_phy_intf_sel_mask = GENMASK_U16(4, 2),
 
 	.clock_grf_reg = RK3308_GRF_MAC_CON0,
 	.clock.mac_speed_mask = BIT_U16(0),
+
+	.supports_rmii = true,
 };
 
 #define RK3328_GRF_MAC_CON0	0x0900
@@ -484,10 +471,6 @@ static void rk3328_set_to_rgmii(struct rk_priv_data *bsp_priv,
 		     RK3328_GMAC_CLK_TX_DL_CFG(tx_delay));
 }
 
-static void rk3328_set_to_rmii(struct rk_priv_data *bsp_priv)
-{
-}
-
 static void rk3328_integrated_phy_powerup(struct rk_priv_data *priv)
 {
 	regmap_write(priv->grf, RK3328_GRF_MACPHY_CON1,
@@ -499,7 +482,6 @@ static void rk3328_integrated_phy_powerup(struct rk_priv_data *priv)
 static const struct rk_gmac_ops rk3328_ops = {
 	.init = rk3328_init,
 	.set_to_rgmii = rk3328_set_to_rgmii,
-	.set_to_rmii = rk3328_set_to_rmii,
 	.integrated_phy_powerup = rk3328_integrated_phy_powerup,
 	.integrated_phy_powerdown = rk_gmac_integrated_ephy_powerdown,
 
@@ -509,6 +491,8 @@ static const struct rk_gmac_ops rk3328_ops = {
 	.clock.rmii_clk_sel_mask = BIT_U16(7),
 	.clock.mac_speed_mask = BIT_U16(2),
 
+	.supports_rmii = true,
+
 	.regs_valid = true,
 	.regs = {
 		0xff540000, /* gmac2io */
@@ -541,13 +525,8 @@ static void rk3366_set_to_rgmii(struct rk_priv_data *bsp_priv,
 		     RK3366_GMAC_CLK_TX_DL_CFG(tx_delay));
 }
 
-static void rk3366_set_to_rmii(struct rk_priv_data *bsp_priv)
-{
-}
-
 static const struct rk_gmac_ops rk3366_ops = {
 	.set_to_rgmii = rk3366_set_to_rgmii,
-	.set_to_rmii = rk3366_set_to_rmii,
 
 	.gmac_grf_reg = RK3366_GRF_SOC_CON6,
 	.gmac_phy_intf_sel_mask = GENMASK_U16(11, 9),
@@ -557,6 +536,8 @@ static const struct rk_gmac_ops rk3366_ops = {
 	.clock.gmii_clk_sel_mask = GENMASK_U16(5, 4),
 	.clock.rmii_clk_sel_mask = BIT_U16(3),
 	.clock.mac_speed_mask = BIT_U16(7),
+
+	.supports_rmii = true,
 };
 
 #define RK3368_GRF_SOC_CON15	0x043c
@@ -583,13 +564,8 @@ static void rk3368_set_to_rgmii(struct rk_priv_data *bsp_priv,
 		     RK3368_GMAC_CLK_TX_DL_CFG(tx_delay));
 }
 
-static void rk3368_set_to_rmii(struct rk_priv_data *bsp_priv)
-{
-}
-
 static const struct rk_gmac_ops rk3368_ops = {
 	.set_to_rgmii = rk3368_set_to_rgmii,
-	.set_to_rmii = rk3368_set_to_rmii,
 
 	.gmac_grf_reg = RK3368_GRF_SOC_CON15,
 	.gmac_phy_intf_sel_mask = GENMASK_U16(11, 9),
@@ -599,6 +575,8 @@ static const struct rk_gmac_ops rk3368_ops = {
 	.clock.gmii_clk_sel_mask = GENMASK_U16(5, 4),
 	.clock.rmii_clk_sel_mask = BIT_U16(3),
 	.clock.mac_speed_mask = BIT_U16(7),
+
+	.supports_rmii = true,
 };
 
 #define RK3399_GRF_SOC_CON5	0xc214
@@ -625,13 +603,8 @@ static void rk3399_set_to_rgmii(struct rk_priv_data *bsp_priv,
 		     RK3399_GMAC_CLK_TX_DL_CFG(tx_delay));
 }
 
-static void rk3399_set_to_rmii(struct rk_priv_data *bsp_priv)
-{
-}
-
 static const struct rk_gmac_ops rk3399_ops = {
 	.set_to_rgmii = rk3399_set_to_rgmii,
-	.set_to_rmii = rk3399_set_to_rmii,
 
 	.gmac_grf_reg = RK3399_GRF_SOC_CON5,
 	.gmac_phy_intf_sel_mask = GENMASK_U16(11, 9),
@@ -641,6 +614,8 @@ static const struct rk_gmac_ops rk3399_ops = {
 	.clock.gmii_clk_sel_mask = GENMASK_U16(5, 4),
 	.clock.rmii_clk_sel_mask = BIT_U16(3),
 	.clock.mac_speed_mask = BIT_U16(7),
+
+	.supports_rmii = true,
 };
 
 #define RK3506_GRF_SOC_CON8		0x0020
@@ -871,18 +846,15 @@ static void rk3568_set_to_rgmii(struct rk_priv_data *bsp_priv,
 		     RK3568_GMAC_TXCLK_DLY_ENABLE);
 }
 
-static void rk3568_set_to_rmii(struct rk_priv_data *bsp_priv)
-{
-}
-
 static const struct rk_gmac_ops rk3568_ops = {
 	.init = rk3568_init,
 	.set_to_rgmii = rk3568_set_to_rgmii,
-	.set_to_rmii = rk3568_set_to_rmii,
 	.set_speed = rk_set_clk_mac_speed,
 
 	.gmac_phy_intf_sel_mask = GENMASK_U16(6, 4),
 
+	.supports_rmii = true,
+
 	.regs_valid = true,
 	.regs = {
 		0xfe2a0000, /* gmac0 */
@@ -956,10 +928,6 @@ static void rk3576_set_to_rgmii(struct rk_priv_data *bsp_priv,
 		     RK3576_GMAC_CLK_RX_DL_CFG(rx_delay));
 }
 
-static void rk3576_set_to_rmii(struct rk_priv_data *bsp_priv)
-{
-}
-
 static void rk3576_set_clock_selection(struct rk_priv_data *bsp_priv, bool input,
 				       bool enable)
 {
@@ -979,7 +947,6 @@ static void rk3576_set_clock_selection(struct rk_priv_data *bsp_priv, bool input
 static const struct rk_gmac_ops rk3576_ops = {
 	.init = rk3576_init,
 	.set_to_rgmii = rk3576_set_to_rgmii,
-	.set_to_rmii = rk3576_set_to_rmii,
 	.set_clock_selection = rk3576_set_clock_selection,
 
 	.gmac_rmii_mode_mask = BIT_U16(3),
@@ -987,6 +954,8 @@ static const struct rk_gmac_ops rk3576_ops = {
 	.clock.gmii_clk_sel_mask = GENMASK_U16(6, 5),
 	.clock.rmii_clk_sel_mask = BIT_U16(5),
 
+	.supports_rmii = true,
+
 	.php_grf_required = true,
 	.regs_valid = true,
 	.regs = {
@@ -1106,19 +1075,15 @@ static const struct rk_gmac_ops rk3588_ops = {
 #define RV1108_GMAC_FLOW_CTRL		GRF_BIT(3)
 #define RV1108_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
 
-static void rv1108_set_to_rmii(struct rk_priv_data *bsp_priv)
-{
-}
-
 static const struct rk_gmac_ops rv1108_ops = {
-	.set_to_rmii = rv1108_set_to_rmii,
-
 	.gmac_grf_reg = RV1108_GRF_GMAC_CON0,
 	.gmac_phy_intf_sel_mask = GENMASK_U16(6, 4),
 
 	.clock_grf_reg = RV1108_GRF_GMAC_CON0,
 	.clock.rmii_clk_sel_mask = BIT_U16(7),
 	.clock.mac_speed_mask = BIT_U16(2),
+
+	.supports_rmii = true,
 };
 
 #define RV1126_GRF_GMAC_CON0		0X0070
@@ -1162,17 +1127,14 @@ static void rv1126_set_to_rgmii(struct rk_priv_data *bsp_priv,
 		     RV1126_GMAC_M1_CLK_TX_DL_CFG(tx_delay));
 }
 
-static void rv1126_set_to_rmii(struct rk_priv_data *bsp_priv)
-{
-}
-
 static const struct rk_gmac_ops rv1126_ops = {
 	.set_to_rgmii = rv1126_set_to_rgmii,
-	.set_to_rmii = rv1126_set_to_rmii,
 	.set_speed = rk_set_clk_mac_speed,
 
 	.gmac_grf_reg = RV1126_GRF_GMAC_CON0,
 	.gmac_phy_intf_sel_mask = GENMASK_U16(6, 4),
+
+	.supports_rmii = true,
 };
 
 static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
-- 
2.47.3


