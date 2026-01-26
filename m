Return-Path: <netdev+bounces-253452-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HK9Bg1Vd2nMeAEAu9opvQ
	(envelope-from <netdev+bounces-253452-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:50:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE8087D69
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C08830727CD
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697C0332EBE;
	Mon, 26 Jan 2026 11:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="k2Px6Aen"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5DC3314C3
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 11:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769428005; cv=none; b=psnlgYiKJYgpmOEb2tOgZb9hc++6su8J+0pWXUcFsstAXibtlpF+DuJNK7zX0VvJvJs+QfW2VzKxFjdSZio2jOCbxD7LmmEEosSyF3quPHJ2Pk8cXxQwYS2QsdH1xW/Zhm0xU7TRw+KQnwKMi0Zuo9kQBDRM2Tpwqf9bmQfeXJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769428005; c=relaxed/simple;
	bh=fVCwTlTIG++ONJfhpXViyu8oa1qLhtIzm0GHeNJMBSg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=RdokTjX6gSv7uu0XMYFUoqxadZ11hTJOuXfYvdMmZtnxUSfVjQZQDSG+bYKOGmmdQfm7XiqzBMj7PkTEufOWzK9Khm83MNFkxMGivMqVUAo8jeLxIq/YN9MF5LUECjmiqJ+QEJG5eQRe4I1Ji2Bx3eUYXOgZDM5m80s0F4Yw8s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=k2Px6Aen; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BcRCQGbERQBlu4r4BtiUcXeI1plsUu7iFbuJ2kGSDVQ=; b=k2Px6AenQDTIHL0HQl6O5oWCWN
	yc3teZUR0SbiOdUYPjc8f2OTn17KZinIRfhdUiGbxOcHIgmo8ZsKoz9TKVduXZb0yn4BX3uCH0XW0
	dZPyq/QblfAWoIgY2+bqU4Gqrhj1SsVYmgYp3/gOSpMYFOFAdqW4ip3Lp4DmX8vJ/Z+LLY30D427t
	sWYW2xo6bbn4nK8l42SYHlAdUf6YknGnzqp0w57tCQgcaj3b9i1MhwVdSfnQz/B2vTQj4nxA+Y5Cp
	KKAmqIdw70IRdsHys6f9V33Zr6083TaD5gxoB4cPPblDKX8TzbztsSIxUbNwBEvKNy/p4Ese4tEln
	tzVh67rA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55406 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vkL39-000000004ib-2rj1;
	Mon, 26 Jan 2026 11:46:31 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vkL38-00000005uts-0kDd;
	Mon, 26 Jan 2026 11:46:30 +0000
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
Subject: [PATCH net-next v2 18/22] net: stmmac: rk: replace empty
 set_to_rmii() with supports_rmii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vkL38-00000005uts-0kDd@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 26 Jan 2026 11:46:30 +0000
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
	URIBL_MULTI_FAIL(0.00)[armlinux.org.uk:server fail,rmk-PC.armlinux.org.uk:server fail,sea.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-253452-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email,rmk-PC.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 6FE8087D69
X-Rspamd-Action: no action

Rather than providing a now-empty set_to_rmii() method to indicate
that RMII is supported, switch to setting ops->supports_rmii instead.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 86 ++++++-------------
 1 file changed, 24 insertions(+), 62 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index ad6093f9d9eb..4f9b3705d264 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -268,12 +268,7 @@ static void rk_gmac_integrated_fephy_powerdown(struct rk_priv_data *priv,
 
 #define PX30_GRF_GMAC_CON1		0x0904
 
-static void px30_set_to_rmii(struct rk_priv_data *bsp_priv)
-{
-}
-
 static const struct rk_gmac_ops px30_ops = {
-	.set_to_rmii = px30_set_to_rmii,
 	.set_speed = rk_set_clk_mac_speed,
 
 	.gmac_grf_reg = PX30_GRF_GMAC_CON1,
@@ -281,6 +276,8 @@ static const struct rk_gmac_ops px30_ops = {
 
 	.clock_grf_reg = PX30_GRF_GMAC_CON1,
 	.clock.mac_speed_mask = BIT_U16(2),
+
+	.supports_rmii = true,
 };
 
 #define RK3128_GRF_MAC_CON0	0x0168
@@ -307,13 +304,8 @@ static void rk3128_set_to_rgmii(struct rk_priv_data *bsp_priv,
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
@@ -323,6 +315,8 @@ static const struct rk_gmac_ops rk3128_ops = {
 	.clock.gmii_clk_sel_mask = GENMASK_U16(13, 12),
 	.clock.rmii_clk_sel_mask = BIT_U16(11),
 	.clock.mac_speed_mask = BIT_U16(10),
+
+	.supports_rmii = true,
 };
 
 #define RK3228_GRF_MAC_CON0	0x0900
@@ -410,13 +404,8 @@ static void rk3288_set_to_rgmii(struct rk_priv_data *bsp_priv,
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
@@ -426,6 +415,8 @@ static const struct rk_gmac_ops rk3288_ops = {
 	.clock.gmii_clk_sel_mask = GENMASK_U16(13, 12),
 	.clock.rmii_clk_sel_mask = BIT_U16(11),
 	.clock.mac_speed_mask = BIT_U16(10),
+
+	.supports_rmii = true,
 };
 
 #define RK3308_GRF_MAC_CON0		0x04a0
@@ -434,18 +425,14 @@ static const struct rk_gmac_ops rk3288_ops = {
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
@@ -497,10 +484,6 @@ static void rk3328_set_to_rgmii(struct rk_priv_data *bsp_priv,
 		     RK3328_GMAC_CLK_TX_DL_CFG(tx_delay));
 }
 
-static void rk3328_set_to_rmii(struct rk_priv_data *bsp_priv)
-{
-}
-
 static void rk3328_integrated_phy_powerup(struct rk_priv_data *priv)
 {
 	regmap_write(priv->grf, RK3328_GRF_MACPHY_CON1,
@@ -512,7 +495,6 @@ static void rk3328_integrated_phy_powerup(struct rk_priv_data *priv)
 static const struct rk_gmac_ops rk3328_ops = {
 	.init = rk3328_init,
 	.set_to_rgmii = rk3328_set_to_rgmii,
-	.set_to_rmii = rk3328_set_to_rmii,
 	.integrated_phy_powerup = rk3328_integrated_phy_powerup,
 	.integrated_phy_powerdown = rk_gmac_integrated_ephy_powerdown,
 
@@ -522,6 +504,8 @@ static const struct rk_gmac_ops rk3328_ops = {
 	.clock.rmii_clk_sel_mask = BIT_U16(7),
 	.clock.mac_speed_mask = BIT_U16(2),
 
+	.supports_rmii = true,
+
 	.regs_valid = true,
 	.regs = {
 		0xff540000, /* gmac2io */
@@ -554,13 +538,8 @@ static void rk3366_set_to_rgmii(struct rk_priv_data *bsp_priv,
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
@@ -570,6 +549,8 @@ static const struct rk_gmac_ops rk3366_ops = {
 	.clock.gmii_clk_sel_mask = GENMASK_U16(5, 4),
 	.clock.rmii_clk_sel_mask = BIT_U16(3),
 	.clock.mac_speed_mask = BIT_U16(7),
+
+	.supports_rmii = true,
 };
 
 #define RK3368_GRF_SOC_CON15	0x043c
@@ -596,13 +577,8 @@ static void rk3368_set_to_rgmii(struct rk_priv_data *bsp_priv,
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
@@ -612,6 +588,8 @@ static const struct rk_gmac_ops rk3368_ops = {
 	.clock.gmii_clk_sel_mask = GENMASK_U16(5, 4),
 	.clock.rmii_clk_sel_mask = BIT_U16(3),
 	.clock.mac_speed_mask = BIT_U16(7),
+
+	.supports_rmii = true,
 };
 
 #define RK3399_GRF_SOC_CON5	0xc214
@@ -638,13 +616,8 @@ static void rk3399_set_to_rgmii(struct rk_priv_data *bsp_priv,
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
@@ -654,6 +627,8 @@ static const struct rk_gmac_ops rk3399_ops = {
 	.clock.gmii_clk_sel_mask = GENMASK_U16(5, 4),
 	.clock.rmii_clk_sel_mask = BIT_U16(3),
 	.clock.mac_speed_mask = BIT_U16(7),
+
+	.supports_rmii = true,
 };
 
 #define RK3506_GRF_SOC_CON8		0x0020
@@ -884,18 +859,15 @@ static void rk3568_set_to_rgmii(struct rk_priv_data *bsp_priv,
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
@@ -969,10 +941,6 @@ static void rk3576_set_to_rgmii(struct rk_priv_data *bsp_priv,
 		     RK3576_GMAC_CLK_RX_DL_CFG(rx_delay));
 }
 
-static void rk3576_set_to_rmii(struct rk_priv_data *bsp_priv)
-{
-}
-
 static void rk3576_set_clock_selection(struct rk_priv_data *bsp_priv, bool input,
 				       bool enable)
 {
@@ -992,7 +960,6 @@ static void rk3576_set_clock_selection(struct rk_priv_data *bsp_priv, bool input
 static const struct rk_gmac_ops rk3576_ops = {
 	.init = rk3576_init,
 	.set_to_rgmii = rk3576_set_to_rgmii,
-	.set_to_rmii = rk3576_set_to_rmii,
 	.set_clock_selection = rk3576_set_clock_selection,
 
 	.gmac_rmii_mode_mask = BIT_U16(3),
@@ -1000,6 +967,8 @@ static const struct rk_gmac_ops rk3576_ops = {
 	.clock.gmii_clk_sel_mask = GENMASK_U16(6, 5),
 	.clock.rmii_clk_sel_mask = BIT_U16(5),
 
+	.supports_rmii = true,
+
 	.php_grf_required = true,
 	.regs_valid = true,
 	.regs = {
@@ -1120,19 +1089,15 @@ static const struct rk_gmac_ops rk3588_ops = {
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
@@ -1176,17 +1141,14 @@ static void rv1126_set_to_rgmii(struct rk_priv_data *bsp_priv,
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


