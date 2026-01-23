Return-Path: <netdev+bounces-252809-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBiUGZ1Wc2kDuwAAu9opvQ
	(envelope-from <netdev+bounces-252809-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:08:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9798974CB9
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67461305AE68
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B656258CD7;
	Fri, 23 Jan 2026 11:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mctqiiGG"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7021025BEF8
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166206; cv=none; b=Q+QhZNW1aqQOKaSg/iRZOeFasPLU9ESo2hC0s1RspN7bKCavdKEi1uteVn9t/OjFGFJll01pT01+Lm68lZzazbCa+hOrX06LJrNJaDiHg46SV0FqA+Ki/yyxawTUK2KMnjG6gCFEWo1DBNchp+DuDrQOF28QSr0mu5dmElrz4g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166206; c=relaxed/simple;
	bh=N00DUDoX8Fc+1JHBuN5IixHTSPQSSbc1trxeX5jWFgE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=H06ugFzQhvEwbqD58KaXQbUiObvt8iFQ6KWcAJpSDRjfmAYBSTYtn8UX0DFivmFUb1WuIvQFTaRFZEiXK1waHmd0np6GPX5zvLJuBZ05ykN1Rzfud0RawijmoPVZPZXzTWhyjsQMDGV2WDnbUNCKX3I1yGGahDjRsYXw+aFtj2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mctqiiGG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3vbOcszqA5Hufjdy8TMCsw0OsErRSBDMsgH/AbrRhjY=; b=mctqiiGGN8WR5x1MAnPYxzVOrB
	hW/YNnc4+XsqzbSjcux3yWUSkWbrcV89QTkMfoUzcGw4uKE3c9ZyEE+zcwU8CJI6HNLipjvR+MZME
	NwFANr6Ocw1GWk+idpJmjFUBg0MHJa7kVbZ1L6DS67liOjlrsJCLOh0ETHSyHBnVQHCwoN+9pqm9v
	U9+hgr0TByN7XR8nS+ip30jhH2e4hAf4rJUF+gGhYRsmRPYlOqJqZhGjgnePGibL9j2SXs20J2Uip
	emZT6Lmwjj3r+yM2pcs7XZ5+kMKiJ2RhZ//syit5ACxyFD6tunNJU8r/5JfiVs/3J0BaDlP1XP0Ws
	7ZtzbRJw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55782 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vjEvV-000000001sJ-42NE;
	Fri, 23 Jan 2026 11:02:06 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vjEvV-00000005ghc-0ZkO;
	Fri, 23 Jan 2026 11:02:05 +0000
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
Subject: [PATCH net-next 21/21] net: stmmac: rk: rk3506, rk3528 and kk3588
 have rmii_mode in clock register
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vjEvV-00000005ghc-0ZkO@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 23 Jan 2026 11:02:05 +0000
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
	TAGGED_FROM(0.00)[bounces-252809-lists,netdev=lfdr.de,kernel];
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
	NEURAL_HAM(-0.00)[-0.982];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rmk-PC.armlinux.org.uk:mid,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 9798974CB9
X-Rspamd-Action: no action

rk3506, rk3528 and rk3588 have the rmii_mode bit in the clock GRF
register rather than the gmac GRF register. Provide a mask for this
field in the clock register, and convert these SoCs to use this.
Add the necessary code in rk_gmac_powerup() to write this field.

This allows us to get rid of these SoCs set_to_rmii() function. As
such, we need to mark these SoCs as supporting RMII mode.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 62 +++++++------------
 1 file changed, 22 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index ebbc09ea572a..759deb66ef2a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -38,6 +38,7 @@ struct rk_clock_fields {
 	u16 gmii_clk_sel_mask;
 	u16 rmii_clk_sel_mask;
 	u16 rmii_gate_en_mask;
+	u16 rmii_mode_mask;
 	u16 mac_speed_mask;
 };
 
@@ -695,21 +696,15 @@ static int rk3506_init(struct rk_priv_data *bsp_priv)
 	}
 }
 
-static void rk3506_set_to_rmii(struct rk_priv_data *bsp_priv)
-{
-	unsigned int id = bsp_priv->id, offset;
-
-	offset = (id == 1) ? RK3506_GRF_SOC_CON11 : RK3506_GRF_SOC_CON8;
-	regmap_write(bsp_priv->grf, offset, RK3506_GMAC_RMII_MODE);
-}
-
 static const struct rk_gmac_ops rk3506_ops = {
 	.init = rk3506_init,
-	.set_to_rmii = rk3506_set_to_rmii,
 
 	.clock.io_clksel_io_mask = BIT_U16(5),
 	.clock.rmii_clk_sel_mask = BIT_U16(3),
 	.clock.rmii_gate_en_mask = BIT_U16(2),
+	.clock.rmii_mode_mask = BIT_U16(1),
+
+	.supports_rmii = true,
 
 	.regs_valid = true,
 	.regs = {
@@ -733,10 +728,6 @@ static const struct rk_gmac_ops rk3506_ops = {
 #define RK3528_GMAC_CLK_RX_DL_CFG(val)	GRF_FIELD(15, 8, val)
 #define RK3528_GMAC_CLK_TX_DL_CFG(val)	GRF_FIELD(7, 0, val)
 
-#define RK3528_GMAC0_PHY_INTF_SEL_RMII	GRF_BIT(1)
-#define RK3528_GMAC1_PHY_INTF_SEL_RGMII	GRF_CLR_BIT(8)
-#define RK3528_GMAC1_PHY_INTF_SEL_RMII	GRF_BIT(8)
-
 static int rk3528_init(struct rk_priv_data *bsp_priv)
 {
 	switch (bsp_priv->id) {
@@ -744,6 +735,7 @@ static int rk3528_init(struct rk_priv_data *bsp_priv)
 		bsp_priv->clock_grf_reg = RK3528_VO_GRF_GMAC_CON;
 		bsp_priv->clock.rmii_clk_sel_mask = BIT_U16(3);
 		bsp_priv->clock.rmii_gate_en_mask = BIT_U16(2);
+		bsp_priv->clock.rmii_mode_mask = BIT_U16(1);
 		bsp_priv->supports_rgmii = false;
 		return 0;
 
@@ -753,6 +745,7 @@ static int rk3528_init(struct rk_priv_data *bsp_priv)
 		bsp_priv->clock.gmii_clk_sel_mask = GENMASK_U16(11, 10);
 		bsp_priv->clock.rmii_clk_sel_mask = BIT_U16(10);
 		bsp_priv->clock.rmii_gate_en_mask = BIT_U16(9);
+		bsp_priv->clock.rmii_mode_mask = BIT_U16(8);
 		return 0;
 
 	default:
@@ -763,9 +756,6 @@ static int rk3528_init(struct rk_priv_data *bsp_priv)
 static void rk3528_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
-	regmap_write(bsp_priv->grf, RK3528_VPU_GRF_GMAC_CON5,
-		     RK3528_GMAC1_PHY_INTF_SEL_RGMII);
-
 	regmap_write(bsp_priv->grf, RK3528_VPU_GRF_GMAC_CON5,
 		     DELAY_ENABLE(RK3528, tx_delay, rx_delay));
 
@@ -774,16 +764,6 @@ static void rk3528_set_to_rgmii(struct rk_priv_data *bsp_priv,
 		     RK3528_GMAC_CLK_TX_DL_CFG(tx_delay));
 }
 
-static void rk3528_set_to_rmii(struct rk_priv_data *bsp_priv)
-{
-	if (bsp_priv->id == 1)
-		regmap_write(bsp_priv->grf, RK3528_VPU_GRF_GMAC_CON5,
-			     RK3528_GMAC1_PHY_INTF_SEL_RMII);
-	else
-		regmap_write(bsp_priv->grf, RK3528_VO_GRF_GMAC_CON,
-			     RK3528_GMAC0_PHY_INTF_SEL_RMII);
-}
-
 static void rk3528_integrated_phy_powerup(struct rk_priv_data *bsp_priv)
 {
 	rk_gmac_integrated_fephy_powerup(bsp_priv, RK3528_VO_GRF_MACPHY_CON0);
@@ -797,9 +777,11 @@ static void rk3528_integrated_phy_powerdown(struct rk_priv_data *bsp_priv)
 static const struct rk_gmac_ops rk3528_ops = {
 	.init = rk3528_init,
 	.set_to_rgmii = rk3528_set_to_rgmii,
-	.set_to_rmii = rk3528_set_to_rmii,
 	.integrated_phy_powerup = rk3528_integrated_phy_powerup,
 	.integrated_phy_powerdown = rk3528_integrated_phy_powerdown,
+
+	.supports_rmii = true,
+
 	.regs_valid = true,
 	.regs = {
 		0xffbd0000, /* gmac0 */
@@ -975,9 +957,6 @@ static const struct rk_gmac_ops rk3576_ops = {
 #define RK3588_GRF_GMAC_CON0			0X0008
 #define RK3588_GRF_CLK_CON1			0X0070
 
-#define RK3588_GMAC_CLK_RMII_MODE(id)		GRF_BIT(5 * (id))
-#define RK3588_GMAC_CLK_RGMII_MODE(id)		GRF_CLR_BIT(5 * (id))
-
 static int rk3588_init(struct rk_priv_data *bsp_priv)
 {
 	switch (bsp_priv->id) {
@@ -987,6 +966,7 @@ static int rk3588_init(struct rk_priv_data *bsp_priv)
 		bsp_priv->clock.gmii_clk_sel_mask = GENMASK_U16(3, 2);
 		bsp_priv->clock.rmii_clk_sel_mask = BIT_U16(2);
 		bsp_priv->clock.rmii_gate_en_mask = BIT_U16(1);
+		bsp_priv->clock.rmii_mode_mask = BIT_U16(0);
 		return 0;
 
 	case 1:
@@ -995,6 +975,7 @@ static int rk3588_init(struct rk_priv_data *bsp_priv)
 		bsp_priv->clock.gmii_clk_sel_mask = GENMASK_U16(8, 7);
 		bsp_priv->clock.rmii_clk_sel_mask = BIT_U16(7);
 		bsp_priv->clock.rmii_gate_en_mask = BIT_U16(6);
+		bsp_priv->clock.rmii_mode_mask = BIT_U16(5);
 		return 0;
 
 	default:
@@ -1010,9 +991,6 @@ static void rk3588_set_to_rgmii(struct rk_priv_data *bsp_priv,
 	offset_con = bsp_priv->id == 1 ? RK3588_GRF_GMAC_CON9 :
 					 RK3588_GRF_GMAC_CON8;
 
-	regmap_write(bsp_priv->php_grf, RK3588_GRF_CLK_CON1,
-		     RK3588_GMAC_CLK_RGMII_MODE(id));
-
 	regmap_write(bsp_priv->grf, RK3588_GRF_GMAC_CON7,
 		     RK3588_GMAC_RXCLK_DLY_ENABLE(id) |
 		     RK3588_GMAC_TXCLK_DLY_ENABLE(id));
@@ -1022,22 +1000,17 @@ static void rk3588_set_to_rgmii(struct rk_priv_data *bsp_priv,
 		     RK3588_GMAC_CLK_TX_DL_CFG(tx_delay));
 }
 
-static void rk3588_set_to_rmii(struct rk_priv_data *bsp_priv)
-{
-	regmap_write(bsp_priv->php_grf, RK3588_GRF_CLK_CON1,
-		     RK3588_GMAC_CLK_RMII_MODE(bsp_priv->id));
-}
-
 static const struct rk_gmac_ops rk3588_ops = {
 	.init = rk3588_init,
 	.set_to_rgmii = rk3588_set_to_rgmii,
-	.set_to_rmii = rk3588_set_to_rmii,
 
 	.gmac_grf_reg = RK3588_GRF_GMAC_CON0,
 
 	.clock_grf_reg_in_php = true,
 	.clock_grf_reg = RK3588_GRF_CLK_CON1,
 
+	.supports_rmii = true,
+
 	.php_grf_required = true,
 	.regs_valid = true,
 	.regs = {
@@ -1412,6 +1385,15 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
 			return ret;
 	}
 
+	if (bsp_priv->clock.rmii_mode_mask) {
+		val = rk_encode_wm16(ret == PHY_INTF_SEL_RMII,
+				     bsp_priv->clock.rmii_mode_mask);
+
+		ret = rk_write_clock_grf_reg(bsp_priv, val);
+		if (ret < 0)
+			return ret;
+	}
+
 	/*rmii or rgmii*/
 	switch (bsp_priv->phy_iface) {
 	case PHY_INTERFACE_MODE_RGMII:
-- 
2.47.3


