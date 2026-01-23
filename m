Return-Path: <netdev+bounces-252797-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFGBF0VVc2kDuwAAu9opvQ
	(envelope-from <netdev+bounces-252797-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:02:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA14B74BD9
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93003302FAA2
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFA02FFF94;
	Fri, 23 Jan 2026 11:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1c6fwhIL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D582F691D
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166071; cv=none; b=uCLabyybyga6BjBgY3auuNgyvGfysWvKNS/et/NPGRqJCt1rY60mSUQ2f+RvcHgl/UuVYohhr8BUir579BYmCCVJ64dJpZ3xVQQb8HcEMLgZye2FjUoiHEyxzUkdRAfmcu4EsBMHg8inqcFcU4/S5Y7wblnzz7HMUfy9aDK3UdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166071; c=relaxed/simple;
	bh=/HI5b3xpAY0KQW2JWLsBoH79KZvVjA9prXtfAksWQiw=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=s9bO2TYf9D/qj34GAlFxbobTf0pqbIBz8n6+KqbaU8JPWR/yokcTV5trkYWoU+hcJSaKYNw3HjEoNZFUNUrY03UbSpVgc9u/RONZQGy0LyW7jb7F4x8tVgXiTKzPRhY1qjCA/zTjR+cu1UZ8/AI5OEqdpzlYxWjiOWH9IToBVRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1c6fwhIL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=s1oYlzDBUVY78zRoFMyRlL4wSmE+aDXvR9qlEQOYlAk=; b=1c6fwhILmhhQf4WL+KVlNBiVTn
	bcum7VKCjlN+IOd+p0K8BDcNrTlFR9g0Ev708sGvBddzwIapiJCPrJAh74gi6uip1JFSO6N4lxZne
	oKR0uVRwC32J01tMxDWnwcxRe1cEFRtFjZCDp0pMMZHrP64Pe2z219MwGa/ht23gnDqIR/EcSwGQv
	uoL0c3/0W8qOouljM6WdPj3S+sV/tKzaI6w6tu1ZyOrvit0i/cK4mE7xs/Xo3EsZZ5GXMrHouZ5nh
	XPhPkZ8mSjnuKZ92L/8WNIu40D/Jjg8cwXN1FpoXiUjRuvy77Gusn7WDFkQzP+VT4FfV05c9ZNxup
	/bej/tdw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47244 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vjEuO-000000001oA-0JYf;
	Fri, 23 Jan 2026 11:00:56 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vjEuL-00000005ggE-1z5W;
	Fri, 23 Jan 2026 11:00:53 +0000
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
Subject: [PATCH net-next 07/21] net: stmmac: rk: convert to mask-based
 interface mode configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vjEuL-00000005ggE-1z5W@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 23 Jan 2026 11:00:53 +0000
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
	TAGGED_FROM(0.00)[bounces-252797-lists,netdev=lfdr.de,kernel];
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
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,rmk-PC.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA14B74BD9
X-Rspamd-Action: no action

The majority of Rockchip implementations require three common pieces
of information to configure the PHY interface mode:

- The grf register offset for configuring the GMAC phy_intf_sel field
  and the RMII mode bit.
- The bitfield in this register for the GMAC's phy_intf_sel.
- The bit position for RMII mode but clear for RGMII mode.

Introduce members for this information into struct rk_priv_data and
struct rk_gmac_ops, which will be used to pre-initialise the struct
rk_priv_data members. We describe the register contents using
bitfields, even for those that are a single bit for consistency.

As each register comprises of two halves, where the upper half enables
changing the bit state in the lower half, we can describe these
bitfields using a 16-bit data type, and provide rk_encode_wm16() to
generate the actual register values from the field mask and field
value. We are unable to use the FIELD_PREP_WM16() macros for this as
these require the field mask to be a constant.

Add code to rk_gmac_powerup() to get the phy_intf_sel value, validating
that the resulting mode is either RMII or RGMII. No other modes are
supported by any of the Rockchip SoCs supported by this driver.

If either of the bitfield mask values are populated in struct
rk_priv_data, use these to generate the register contents, and write
the resulting value to the specified GRF register.

Convert many Rockchip implementations to use this new infrastructure.
For those where there is a single GMAC instance, it is merely a case of
filling in the new members of struct rk_gmac_ops. For those with
multiple instances, one or more of these members depends on the GMAC
instance, so setup of the members in struct rk_gmac has to be done via
the .init method of struct rk_gmac_ops. The corresponding code is
removed from the set_to_rgmii() and set_to_rmii() implementations.

Since the member name documents the purpose of the field that is being
initialised, providing preprocessor macros to define the bitfields is
deemed to be less than useful given the massive size of this driver.

The existing mechanisms remain behind for those SoCs that can not be
converted to this scheme.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 281 +++++++++++-------
 1 file changed, 171 insertions(+), 110 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 4117f6863ff0..48fc5b58092f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -45,6 +45,11 @@ struct rk_gmac_ops {
 				    bool enable);
 	void (*integrated_phy_powerup)(struct rk_priv_data *bsp_priv);
 	void (*integrated_phy_powerdown)(struct rk_priv_data *bsp_priv);
+
+	u16 gmac_grf_reg;
+	u16 gmac_phy_intf_sel_mask;
+	u16 gmac_rmii_mode_mask;
+
 	bool php_grf_required;
 	bool regs_valid;
 	u32 regs[];
@@ -90,12 +95,37 @@ struct rk_priv_data {
 
 	struct regmap *grf;
 	struct regmap *php_grf;
+
+	u16 gmac_grf_reg;
+	u16 gmac_phy_intf_sel_mask;
+	u16 gmac_rmii_mode_mask;
 };
 
 #define GMAC_CLK_DIV1_125M		0
 #define GMAC_CLK_DIV50_2_5M		2
 #define GMAC_CLK_DIV5_25M		3
 
+static int rk_get_phy_intf_sel(phy_interface_t interface)
+{
+	int ret = stmmac_get_phy_intf_sel(interface);
+
+	/* Only RGMII and RMII are supported */
+	if (ret != PHY_INTF_SEL_RGMII && ret != PHY_INTF_SEL_RMII)
+		ret = -EINVAL;
+
+	return ret;
+}
+
+static u32 rk_encode_wm16(u16 val, u16 mask)
+{
+	u32 reg_val = mask << 16;
+
+	if (mask)
+		reg_val |= mask & (val << (ffs(mask) - 1));
+
+	return reg_val;
+}
+
 static int rk_set_reg_speed(struct rk_priv_data *bsp_priv,
 			    const struct rk_reg_speed_data *rsd,
 			    unsigned int reg, phy_interface_t interface,
@@ -241,14 +271,11 @@ static void rk_gmac_integrated_fephy_powerdown(struct rk_priv_data *priv,
 #define PX30_GRF_GMAC_CON1		0x0904
 
 /* PX30_GRF_GMAC_CON1 */
-#define PX30_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(6, 4, val)
 #define PX30_GMAC_SPEED_10M		GRF_CLR_BIT(2)
 #define PX30_GMAC_SPEED_100M		GRF_BIT(2)
 
 static void px30_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	regmap_write(bsp_priv->grf, PX30_GRF_GMAC_CON1,
-		     PX30_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII));
 }
 
 static int px30_set_speed(struct rk_priv_data *bsp_priv,
@@ -283,6 +310,9 @@ static int px30_set_speed(struct rk_priv_data *bsp_priv,
 static const struct rk_gmac_ops px30_ops = {
 	.set_to_rmii = px30_set_to_rmii,
 	.set_speed = px30_set_speed,
+
+	.gmac_grf_reg = PX30_GRF_GMAC_CON1,
+	.gmac_phy_intf_sel_mask = GENMASK_U16(6, 4),
 };
 
 #define RK3128_GRF_MAC_CON0	0x0168
@@ -297,7 +327,6 @@ static const struct rk_gmac_ops px30_ops = {
 #define RK3128_GMAC_CLK_TX_DL_CFG(val) GRF_FIELD(6, 0, val)
 
 /* RK3128_GRF_MAC_CON1 */
-#define RK3128_GMAC_PHY_INTF_SEL(val)  GRF_FIELD(8, 6, val)
 #define RK3128_GMAC_FLOW_CTRL          GRF_BIT(9)
 #define RK3128_GMAC_FLOW_CTRL_CLR      GRF_CLR_BIT(9)
 #define RK3128_GMAC_SPEED_10M          GRF_CLR_BIT(10)
@@ -305,15 +334,10 @@ static const struct rk_gmac_ops px30_ops = {
 #define RK3128_GMAC_RMII_CLK_25M       GRF_BIT(11)
 #define RK3128_GMAC_RMII_CLK_2_5M      GRF_CLR_BIT(11)
 #define RK3128_GMAC_CLK(val)           GRF_FIELD_CONST(13, 12, val)
-#define RK3128_GMAC_RMII_MODE          GRF_BIT(14)
-#define RK3128_GMAC_RMII_MODE_CLR      GRF_CLR_BIT(14)
 
 static void rk3128_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
-	regmap_write(bsp_priv->grf, RK3128_GRF_MAC_CON1,
-		     RK3128_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RGMII) |
-		     RK3128_GMAC_RMII_MODE_CLR);
 	regmap_write(bsp_priv->grf, RK3128_GRF_MAC_CON0,
 		     DELAY_ENABLE(RK3128, tx_delay, rx_delay) |
 		     RK3128_GMAC_CLK_RX_DL_CFG(rx_delay) |
@@ -322,9 +346,6 @@ static void rk3128_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rk3128_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	regmap_write(bsp_priv->grf, RK3128_GRF_MAC_CON1,
-		     RK3128_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII) |
-		     RK3128_GMAC_RMII_MODE);
 }
 
 static const struct rk_reg_speed_data rk3128_reg_speed_data = {
@@ -346,6 +367,10 @@ static const struct rk_gmac_ops rk3128_ops = {
 	.set_to_rgmii = rk3128_set_to_rgmii,
 	.set_to_rmii = rk3128_set_to_rmii,
 	.set_speed = rk3128_set_speed,
+
+	.gmac_grf_reg = RK3128_GRF_MAC_CON1,
+	.gmac_phy_intf_sel_mask = GENMASK_U16(8, 6),
+	.gmac_rmii_mode_mask = BIT_U16(14),
 };
 
 #define RK3228_GRF_MAC_CON0	0x0900
@@ -358,7 +383,6 @@ static const struct rk_gmac_ops rk3128_ops = {
 #define RK3228_GMAC_CLK_TX_DL_CFG(val)	GRF_FIELD(6, 0, val)
 
 /* RK3228_GRF_MAC_CON1 */
-#define RK3228_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(6, 4, val)
 #define RK3228_GMAC_FLOW_CTRL		GRF_BIT(3)
 #define RK3228_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
 #define RK3228_GMAC_SPEED_10M		GRF_CLR_BIT(2)
@@ -366,8 +390,6 @@ static const struct rk_gmac_ops rk3128_ops = {
 #define RK3228_GMAC_RMII_CLK_25M	GRF_BIT(7)
 #define RK3228_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(7)
 #define RK3228_GMAC_CLK(val)		GRF_FIELD_CONST(9, 8, val)
-#define RK3228_GMAC_RMII_MODE		GRF_BIT(10)
-#define RK3228_GMAC_RMII_MODE_CLR	GRF_CLR_BIT(10)
 #define RK3228_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(0)
 #define RK3228_GMAC_TXCLK_DLY_DISABLE	GRF_CLR_BIT(0)
 #define RK3228_GMAC_RXCLK_DLY_ENABLE	GRF_BIT(1)
@@ -380,8 +402,6 @@ static void rk3228_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
 	regmap_write(bsp_priv->grf, RK3228_GRF_MAC_CON1,
-		     RK3228_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RGMII) |
-		     RK3228_GMAC_RMII_MODE_CLR |
 		     DELAY_ENABLE(RK3228, tx_delay, rx_delay));
 
 	regmap_write(bsp_priv->grf, RK3228_GRF_MAC_CON0,
@@ -391,10 +411,6 @@ static void rk3228_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rk3228_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	regmap_write(bsp_priv->grf, RK3228_GRF_MAC_CON1,
-		     RK3228_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII) |
-		     RK3228_GMAC_RMII_MODE);
-
 	/* set MAC to RMII mode */
 	regmap_write(bsp_priv->grf, RK3228_GRF_MAC_CON1, GRF_BIT(11));
 }
@@ -428,13 +444,17 @@ static const struct rk_gmac_ops rk3228_ops = {
 	.set_speed = rk3228_set_speed,
 	.integrated_phy_powerup = rk3228_integrated_phy_powerup,
 	.integrated_phy_powerdown = rk_gmac_integrated_ephy_powerdown,
+
+	.gmac_grf_reg = RK3228_GRF_MAC_CON1,
+	.gmac_phy_intf_sel_mask = GENMASK_U16(6, 4),
+	.gmac_rmii_mode_mask = BIT_U16(10),
+
 };
 
 #define RK3288_GRF_SOC_CON1	0x0248
 #define RK3288_GRF_SOC_CON3	0x0250
 
 /*RK3288_GRF_SOC_CON1*/
-#define RK3288_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(8, 6, val)
 #define RK3288_GMAC_FLOW_CTRL		GRF_BIT(9)
 #define RK3288_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(9)
 #define RK3288_GMAC_SPEED_10M		GRF_CLR_BIT(10)
@@ -442,8 +462,6 @@ static const struct rk_gmac_ops rk3228_ops = {
 #define RK3288_GMAC_RMII_CLK_25M	GRF_BIT(11)
 #define RK3288_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(11)
 #define RK3288_GMAC_CLK(val)		GRF_FIELD_CONST(13, 12, val)
-#define RK3288_GMAC_RMII_MODE		GRF_BIT(14)
-#define RK3288_GMAC_RMII_MODE_CLR	GRF_CLR_BIT(14)
 
 /*RK3288_GRF_SOC_CON3*/
 #define RK3288_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(14)
@@ -456,9 +474,6 @@ static const struct rk_gmac_ops rk3228_ops = {
 static void rk3288_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
-	regmap_write(bsp_priv->grf, RK3288_GRF_SOC_CON1,
-		     RK3288_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RGMII) |
-		     RK3288_GMAC_RMII_MODE_CLR);
 	regmap_write(bsp_priv->grf, RK3288_GRF_SOC_CON3,
 		     DELAY_ENABLE(RK3288, tx_delay, rx_delay) |
 		     RK3288_GMAC_CLK_RX_DL_CFG(rx_delay) |
@@ -467,9 +482,6 @@ static void rk3288_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rk3288_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	regmap_write(bsp_priv->grf, RK3288_GRF_SOC_CON1,
-		     RK3288_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII) |
-		     RK3288_GMAC_RMII_MODE);
 }
 
 static const struct rk_reg_speed_data rk3288_reg_speed_data = {
@@ -491,12 +503,15 @@ static const struct rk_gmac_ops rk3288_ops = {
 	.set_to_rgmii = rk3288_set_to_rgmii,
 	.set_to_rmii = rk3288_set_to_rmii,
 	.set_speed = rk3288_set_speed,
+
+	.gmac_grf_reg = RK3288_GRF_SOC_CON1,
+	.gmac_phy_intf_sel_mask = GENMASK_U16(8, 6),
+	.gmac_rmii_mode_mask = BIT_U16(14),
 };
 
 #define RK3308_GRF_MAC_CON0		0x04a0
 
 /* RK3308_GRF_MAC_CON0 */
-#define RK3308_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(4, 2, val)
 #define RK3308_GMAC_FLOW_CTRL		GRF_BIT(3)
 #define RK3308_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
 #define RK3308_GMAC_SPEED_10M		GRF_CLR_BIT(0)
@@ -504,8 +519,6 @@ static const struct rk_gmac_ops rk3288_ops = {
 
 static void rk3308_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	regmap_write(bsp_priv->grf, RK3308_GRF_MAC_CON0,
-		     RK3308_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII));
 }
 
 static const struct rk_reg_speed_data rk3308_reg_speed_data = {
@@ -523,6 +536,9 @@ static int rk3308_set_speed(struct rk_priv_data *bsp_priv,
 static const struct rk_gmac_ops rk3308_ops = {
 	.set_to_rmii = rk3308_set_to_rmii,
 	.set_speed = rk3308_set_speed,
+
+	.gmac_grf_reg = RK3308_GRF_MAC_CON0,
+	.gmac_phy_intf_sel_mask = GENMASK_U16(4, 2),
 };
 
 #define RK3328_GRF_MAC_CON0	0x0900
@@ -535,7 +551,6 @@ static const struct rk_gmac_ops rk3308_ops = {
 #define RK3328_GMAC_CLK_TX_DL_CFG(val)	GRF_FIELD(6, 0, val)
 
 /* RK3328_GRF_MAC_CON1 */
-#define RK3328_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(6, 4, val)
 #define RK3328_GMAC_FLOW_CTRL		GRF_BIT(3)
 #define RK3328_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
 #define RK3328_GMAC_SPEED_10M		GRF_CLR_BIT(2)
@@ -543,20 +558,32 @@ static const struct rk_gmac_ops rk3308_ops = {
 #define RK3328_GMAC_RMII_CLK_25M	GRF_BIT(7)
 #define RK3328_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(7)
 #define RK3328_GMAC_CLK(val)		GRF_FIELD_CONST(12, 11, val)
-#define RK3328_GMAC_RMII_MODE		GRF_BIT(9)
-#define RK3328_GMAC_RMII_MODE_CLR	GRF_CLR_BIT(9)
 #define RK3328_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(0)
 #define RK3328_GMAC_RXCLK_DLY_ENABLE	GRF_BIT(1)
 
 /* RK3328_GRF_MACPHY_CON1 */
 #define RK3328_MACPHY_RMII_MODE		GRF_BIT(9)
 
+static int rk3328_init(struct rk_priv_data *bsp_priv)
+{
+	switch (bsp_priv->id) {
+	case 0: /* gmac2io */
+		bsp_priv->gmac_grf_reg = RK3328_GRF_MAC_CON1;
+		return 0;
+
+	case 1: /* gmac2phy */
+		bsp_priv->gmac_grf_reg = RK3328_GRF_MAC_CON2;
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static void rk3328_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
 	regmap_write(bsp_priv->grf, RK3328_GRF_MAC_CON1,
-		     RK3328_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RGMII) |
-		     RK3328_GMAC_RMII_MODE_CLR |
 		     RK3328_GMAC_RXCLK_DLY_ENABLE |
 		     RK3328_GMAC_TXCLK_DLY_ENABLE);
 
@@ -567,13 +594,6 @@ static void rk3328_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rk3328_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	unsigned int reg;
-
-	reg = bsp_priv->id ? RK3328_GRF_MAC_CON2 : RK3328_GRF_MAC_CON1;
-
-	regmap_write(bsp_priv->grf, reg,
-		     RK3328_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII) |
-		     RK3328_GMAC_RMII_MODE);
 }
 
 static const struct rk_reg_speed_data rk3328_reg_speed_data = {
@@ -604,12 +624,16 @@ static void rk3328_integrated_phy_powerup(struct rk_priv_data *priv)
 }
 
 static const struct rk_gmac_ops rk3328_ops = {
+	.init = rk3328_init,
 	.set_to_rgmii = rk3328_set_to_rgmii,
 	.set_to_rmii = rk3328_set_to_rmii,
 	.set_speed = rk3328_set_speed,
 	.integrated_phy_powerup = rk3328_integrated_phy_powerup,
 	.integrated_phy_powerdown = rk_gmac_integrated_ephy_powerdown,
 
+	.gmac_phy_intf_sel_mask = GENMASK_U16(6, 4),
+	.gmac_rmii_mode_mask = BIT_U16(9),
+
 	.regs_valid = true,
 	.regs = {
 		0xff540000, /* gmac2io */
@@ -622,7 +646,6 @@ static const struct rk_gmac_ops rk3328_ops = {
 #define RK3366_GRF_SOC_CON7	0x041c
 
 /* RK3366_GRF_SOC_CON6 */
-#define RK3366_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(11, 9, val)
 #define RK3366_GMAC_FLOW_CTRL		GRF_BIT(8)
 #define RK3366_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(8)
 #define RK3366_GMAC_SPEED_10M		GRF_CLR_BIT(7)
@@ -630,8 +653,6 @@ static const struct rk_gmac_ops rk3328_ops = {
 #define RK3366_GMAC_RMII_CLK_25M	GRF_BIT(3)
 #define RK3366_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
 #define RK3366_GMAC_CLK(val)		GRF_FIELD_CONST(5, 4, val)
-#define RK3366_GMAC_RMII_MODE		GRF_BIT(6)
-#define RK3366_GMAC_RMII_MODE_CLR	GRF_CLR_BIT(6)
 
 /* RK3366_GRF_SOC_CON7 */
 #define RK3366_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(7)
@@ -644,9 +665,6 @@ static const struct rk_gmac_ops rk3328_ops = {
 static void rk3366_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
-	regmap_write(bsp_priv->grf, RK3366_GRF_SOC_CON6,
-		     RK3366_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RGMII) |
-		     RK3366_GMAC_RMII_MODE_CLR);
 	regmap_write(bsp_priv->grf, RK3366_GRF_SOC_CON7,
 		     DELAY_ENABLE(RK3366, tx_delay, rx_delay) |
 		     RK3366_GMAC_CLK_RX_DL_CFG(rx_delay) |
@@ -655,9 +673,6 @@ static void rk3366_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rk3366_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	regmap_write(bsp_priv->grf, RK3366_GRF_SOC_CON6,
-		     RK3366_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII) |
-		     RK3366_GMAC_RMII_MODE);
 }
 
 static const struct rk_reg_speed_data rk3366_reg_speed_data = {
@@ -679,13 +694,16 @@ static const struct rk_gmac_ops rk3366_ops = {
 	.set_to_rgmii = rk3366_set_to_rgmii,
 	.set_to_rmii = rk3366_set_to_rmii,
 	.set_speed = rk3366_set_speed,
+
+	.gmac_grf_reg = RK3366_GRF_SOC_CON6,
+	.gmac_phy_intf_sel_mask = GENMASK_U16(11, 9),
+	.gmac_rmii_mode_mask = BIT_U16(6),
 };
 
 #define RK3368_GRF_SOC_CON15	0x043c
 #define RK3368_GRF_SOC_CON16	0x0440
 
 /* RK3368_GRF_SOC_CON15 */
-#define RK3368_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(11, 9, val)
 #define RK3368_GMAC_FLOW_CTRL		GRF_BIT(8)
 #define RK3368_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(8)
 #define RK3368_GMAC_SPEED_10M		GRF_CLR_BIT(7)
@@ -693,8 +711,6 @@ static const struct rk_gmac_ops rk3366_ops = {
 #define RK3368_GMAC_RMII_CLK_25M	GRF_BIT(3)
 #define RK3368_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
 #define RK3368_GMAC_CLK(val)		GRF_FIELD_CONST(5, 4, val)
-#define RK3368_GMAC_RMII_MODE		GRF_BIT(6)
-#define RK3368_GMAC_RMII_MODE_CLR	GRF_CLR_BIT(6)
 
 /* RK3368_GRF_SOC_CON16 */
 #define RK3368_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(7)
@@ -707,9 +723,6 @@ static const struct rk_gmac_ops rk3366_ops = {
 static void rk3368_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
-	regmap_write(bsp_priv->grf, RK3368_GRF_SOC_CON15,
-		     RK3368_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RGMII) |
-		     RK3368_GMAC_RMII_MODE_CLR);
 	regmap_write(bsp_priv->grf, RK3368_GRF_SOC_CON16,
 		     DELAY_ENABLE(RK3368, tx_delay, rx_delay) |
 		     RK3368_GMAC_CLK_RX_DL_CFG(rx_delay) |
@@ -718,9 +731,6 @@ static void rk3368_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rk3368_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	regmap_write(bsp_priv->grf, RK3368_GRF_SOC_CON15,
-		     RK3368_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII) |
-		     RK3368_GMAC_RMII_MODE);
 }
 
 static const struct rk_reg_speed_data rk3368_reg_speed_data = {
@@ -742,13 +752,16 @@ static const struct rk_gmac_ops rk3368_ops = {
 	.set_to_rgmii = rk3368_set_to_rgmii,
 	.set_to_rmii = rk3368_set_to_rmii,
 	.set_speed = rk3368_set_speed,
+
+	.gmac_grf_reg = RK3368_GRF_SOC_CON15,
+	.gmac_phy_intf_sel_mask = GENMASK_U16(11, 9),
+	.gmac_rmii_mode_mask = BIT_U16(6),
 };
 
 #define RK3399_GRF_SOC_CON5	0xc214
 #define RK3399_GRF_SOC_CON6	0xc218
 
 /* RK3399_GRF_SOC_CON5 */
-#define RK3399_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(11, 9, val)
 #define RK3399_GMAC_FLOW_CTRL		GRF_BIT(8)
 #define RK3399_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(8)
 #define RK3399_GMAC_SPEED_10M		GRF_CLR_BIT(7)
@@ -756,8 +769,6 @@ static const struct rk_gmac_ops rk3368_ops = {
 #define RK3399_GMAC_RMII_CLK_25M	GRF_BIT(3)
 #define RK3399_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
 #define RK3399_GMAC_CLK(val)		GRF_FIELD_CONST(5, 4, val)
-#define RK3399_GMAC_RMII_MODE		GRF_BIT(6)
-#define RK3399_GMAC_RMII_MODE_CLR	GRF_CLR_BIT(6)
 
 /* RK3399_GRF_SOC_CON6 */
 #define RK3399_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(7)
@@ -770,9 +781,6 @@ static const struct rk_gmac_ops rk3368_ops = {
 static void rk3399_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
-	regmap_write(bsp_priv->grf, RK3399_GRF_SOC_CON5,
-		     RK3399_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RGMII) |
-		     RK3399_GMAC_RMII_MODE_CLR);
 	regmap_write(bsp_priv->grf, RK3399_GRF_SOC_CON6,
 		     DELAY_ENABLE(RK3399, tx_delay, rx_delay) |
 		     RK3399_GMAC_CLK_RX_DL_CFG(rx_delay) |
@@ -781,9 +789,6 @@ static void rk3399_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rk3399_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	regmap_write(bsp_priv->grf, RK3399_GRF_SOC_CON5,
-		     RK3399_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII) |
-		     RK3399_GMAC_RMII_MODE);
 }
 
 static const struct rk_reg_speed_data rk3399_reg_speed_data = {
@@ -805,6 +810,10 @@ static const struct rk_gmac_ops rk3399_ops = {
 	.set_to_rgmii = rk3399_set_to_rgmii,
 	.set_to_rmii = rk3399_set_to_rmii,
 	.set_speed = rk3399_set_speed,
+
+	.gmac_grf_reg = RK3399_GRF_SOC_CON5,
+	.gmac_phy_intf_sel_mask = GENMASK_U16(11, 9),
+	.gmac_rmii_mode_mask = BIT_U16(6),
 };
 
 #define RK3506_GRF_SOC_CON8		0x0020
@@ -1007,7 +1016,6 @@ static const struct rk_gmac_ops rk3528_ops = {
 #define RK3568_GRF_GMAC1_CON1		0x038c
 
 /* RK3568_GRF_GMAC0_CON1 && RK3568_GRF_GMAC1_CON1 */
-#define RK3568_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(6, 4, val)
 #define RK3568_GMAC_FLOW_CTRL			GRF_BIT(3)
 #define RK3568_GMAC_FLOW_CTRL_CLR		GRF_CLR_BIT(3)
 #define RK3568_GMAC_RXCLK_DLY_ENABLE		GRF_BIT(1)
@@ -1019,6 +1027,22 @@ static const struct rk_gmac_ops rk3528_ops = {
 #define RK3568_GMAC_CLK_RX_DL_CFG(val)	GRF_FIELD(14, 8, val)
 #define RK3568_GMAC_CLK_TX_DL_CFG(val)	GRF_FIELD(6, 0, val)
 
+static int rk3568_init(struct rk_priv_data *bsp_priv)
+{
+	switch (bsp_priv->id) {
+	case 0:
+		bsp_priv->gmac_grf_reg = RK3568_GRF_GMAC0_CON1;
+		return 0;
+
+	case 1:
+		bsp_priv->gmac_grf_reg = RK3568_GRF_GMAC1_CON1;
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static void rk3568_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
@@ -1034,25 +1058,22 @@ static void rk3568_set_to_rgmii(struct rk_priv_data *bsp_priv,
 		     RK3568_GMAC_CLK_TX_DL_CFG(tx_delay));
 
 	regmap_write(bsp_priv->grf, con1,
-		     RK3568_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RGMII) |
 		     RK3568_GMAC_RXCLK_DLY_ENABLE |
 		     RK3568_GMAC_TXCLK_DLY_ENABLE);
 }
 
 static void rk3568_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	u32 con1;
-
-	con1 = (bsp_priv->id == 1) ? RK3568_GRF_GMAC1_CON1 :
-				     RK3568_GRF_GMAC0_CON1;
-	regmap_write(bsp_priv->grf, con1,
-		     RK3568_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII));
 }
 
 static const struct rk_gmac_ops rk3568_ops = {
+	.init = rk3568_init,
 	.set_to_rgmii = rk3568_set_to_rgmii,
 	.set_to_rmii = rk3568_set_to_rmii,
 	.set_speed = rk_set_clk_mac_speed,
+
+	.gmac_phy_intf_sel_mask = GENMASK_U16(6, 4),
+
 	.regs_valid = true,
 	.regs = {
 		0xfe2a0000, /* gmac0 */
@@ -1079,9 +1100,6 @@ static const struct rk_gmac_ops rk3568_ops = {
 #define RK3576_GRF_GMAC_CON0			0X0020
 #define RK3576_GRF_GMAC_CON1			0X0024
 
-#define RK3576_GMAC_RMII_MODE			GRF_BIT(3)
-#define RK3576_GMAC_RGMII_MODE			GRF_CLR_BIT(3)
-
 #define RK3576_GMAC_CLK_SELECT_IO		GRF_BIT(7)
 #define RK3576_GMAC_CLK_SELECT_CRU		GRF_CLR_BIT(7)
 
@@ -1093,16 +1111,27 @@ static const struct rk_gmac_ops rk3568_ops = {
 #define RK3576_GMAC_CLK_RMII_GATE		GRF_BIT(4)
 #define RK3576_GMAC_CLK_RMII_NOGATE		GRF_CLR_BIT(4)
 
+static int rk3576_init(struct rk_priv_data *bsp_priv)
+{
+	switch (bsp_priv->id) {
+	case 0:
+		bsp_priv->gmac_grf_reg = RK3576_GRF_GMAC_CON0;
+		return 0;
+
+	case 1:
+		bsp_priv->gmac_grf_reg = RK3576_GRF_GMAC_CON1;
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static void rk3576_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
 	unsigned int offset_con;
 
-	offset_con = bsp_priv->id == 1 ? RK3576_GRF_GMAC_CON1 :
-					 RK3576_GRF_GMAC_CON0;
-
-	regmap_write(bsp_priv->grf, offset_con, RK3576_GMAC_RGMII_MODE);
-
 	offset_con = bsp_priv->id == 1 ? RK3576_VCCIO0_1_3_IOC_CON4 :
 					 RK3576_VCCIO0_1_3_IOC_CON2;
 
@@ -1123,12 +1152,6 @@ static void rk3576_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rk3576_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	unsigned int offset_con;
-
-	offset_con = bsp_priv->id == 1 ? RK3576_GRF_GMAC_CON1 :
-					 RK3576_GRF_GMAC_CON0;
-
-	regmap_write(bsp_priv->grf, offset_con, RK3576_GMAC_RMII_MODE);
 }
 
 static const struct rk_reg_speed_data rk3578_reg_speed_data = {
@@ -1168,10 +1191,14 @@ static void rk3576_set_clock_selection(struct rk_priv_data *bsp_priv, bool input
 }
 
 static const struct rk_gmac_ops rk3576_ops = {
+	.init = rk3576_init,
 	.set_to_rgmii = rk3576_set_to_rgmii,
 	.set_to_rmii = rk3576_set_to_rmii,
 	.set_speed = rk3576_set_gmac_speed,
 	.set_clock_selection = rk3576_set_clock_selection,
+
+	.gmac_rmii_mode_mask = BIT_U16(3),
+
 	.php_grf_required = true,
 	.regs_valid = true,
 	.regs = {
@@ -1198,9 +1225,6 @@ static const struct rk_gmac_ops rk3576_ops = {
 #define RK3588_GRF_GMAC_CON0			0X0008
 #define RK3588_GRF_CLK_CON1			0X0070
 
-#define RK3588_GMAC_PHY_INTF_SEL(id, val)	\
-	(GRF_FIELD(5, 3, val) << ((id) * 6))
-
 #define RK3588_GMAC_CLK_RMII_MODE(id)		GRF_BIT(5 * (id))
 #define RK3588_GMAC_CLK_RGMII_MODE(id)		GRF_CLR_BIT(5 * (id))
 
@@ -1216,6 +1240,22 @@ static const struct rk_gmac_ops rk3576_ops = {
 #define RK3588_GMAC_CLK_RMII_GATE(id)		GRF_BIT(5 * (id) + 1)
 #define RK3588_GMAC_CLK_RMII_NOGATE(id)		GRF_CLR_BIT(5 * (id) + 1)
 
+static int rk3588_init(struct rk_priv_data *bsp_priv)
+{
+	switch (bsp_priv->id) {
+	case 0:
+		bsp_priv->gmac_phy_intf_sel_mask = GENMASK_U16(5, 3);
+		return 0;
+
+	case 1:
+		bsp_priv->gmac_phy_intf_sel_mask = GENMASK_U16(11, 9);
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static void rk3588_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
@@ -1224,9 +1264,6 @@ static void rk3588_set_to_rgmii(struct rk_priv_data *bsp_priv,
 	offset_con = bsp_priv->id == 1 ? RK3588_GRF_GMAC_CON9 :
 					 RK3588_GRF_GMAC_CON8;
 
-	regmap_write(bsp_priv->php_grf, RK3588_GRF_GMAC_CON0,
-		     RK3588_GMAC_PHY_INTF_SEL(id, PHY_INTF_SEL_RGMII));
-
 	regmap_write(bsp_priv->php_grf, RK3588_GRF_CLK_CON1,
 		     RK3588_GMAC_CLK_RGMII_MODE(id));
 
@@ -1241,9 +1278,6 @@ static void rk3588_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rk3588_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	regmap_write(bsp_priv->php_grf, RK3588_GRF_GMAC_CON0,
-		     RK3588_GMAC_PHY_INTF_SEL(bsp_priv->id, PHY_INTF_SEL_RMII));
-
 	regmap_write(bsp_priv->php_grf, RK3588_GRF_CLK_CON1,
 		     RK3588_GMAC_CLK_RMII_MODE(bsp_priv->id));
 }
@@ -1296,10 +1330,14 @@ static void rk3588_set_clock_selection(struct rk_priv_data *bsp_priv, bool input
 }
 
 static const struct rk_gmac_ops rk3588_ops = {
+	.init = rk3588_init,
 	.set_to_rgmii = rk3588_set_to_rgmii,
 	.set_to_rmii = rk3588_set_to_rmii,
 	.set_speed = rk3588_set_gmac_speed,
 	.set_clock_selection = rk3588_set_clock_selection,
+
+	.gmac_grf_reg = RK3588_GRF_GMAC_CON0,
+
 	.php_grf_required = true,
 	.regs_valid = true,
 	.regs = {
@@ -1312,7 +1350,6 @@ static const struct rk_gmac_ops rk3588_ops = {
 #define RV1108_GRF_GMAC_CON0		0X0900
 
 /* RV1108_GRF_GMAC_CON0 */
-#define RV1108_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(6, 4, val)
 #define RV1108_GMAC_FLOW_CTRL		GRF_BIT(3)
 #define RV1108_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
 #define RV1108_GMAC_SPEED_10M		GRF_CLR_BIT(2)
@@ -1322,8 +1359,6 @@ static const struct rk_gmac_ops rk3588_ops = {
 
 static void rv1108_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	regmap_write(bsp_priv->grf, RV1108_GRF_GMAC_CON0,
-		     RV1108_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII));
 }
 
 static const struct rk_reg_speed_data rv1108_reg_speed_data = {
@@ -1341,6 +1376,9 @@ static int rv1108_set_speed(struct rk_priv_data *bsp_priv,
 static const struct rk_gmac_ops rv1108_ops = {
 	.set_to_rmii = rv1108_set_to_rmii,
 	.set_speed = rv1108_set_speed,
+
+	.gmac_grf_reg = RV1108_GRF_GMAC_CON0,
+	.gmac_phy_intf_sel_mask = GENMASK_U16(6, 4),
 };
 
 #define RV1126_GRF_GMAC_CON0		0X0070
@@ -1348,7 +1386,6 @@ static const struct rk_gmac_ops rv1108_ops = {
 #define RV1126_GRF_GMAC_CON2		0X0078
 
 /* RV1126_GRF_GMAC_CON0 */
-#define RV1126_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(6, 4, val)
 #define RV1126_GMAC_FLOW_CTRL			GRF_BIT(7)
 #define RV1126_GMAC_FLOW_CTRL_CLR		GRF_CLR_BIT(7)
 #define RV1126_GMAC_M0_RXCLK_DLY_ENABLE		GRF_BIT(1)
@@ -1371,7 +1408,6 @@ static void rv1126_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
 	regmap_write(bsp_priv->grf, RV1126_GRF_GMAC_CON0,
-		     RV1126_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RGMII) |
 		     RV1126_GMAC_M0_RXCLK_DLY_ENABLE |
 		     RV1126_GMAC_M0_TXCLK_DLY_ENABLE |
 		     RV1126_GMAC_M1_RXCLK_DLY_ENABLE |
@@ -1388,14 +1424,15 @@ static void rv1126_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rv1126_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	regmap_write(bsp_priv->grf, RV1126_GRF_GMAC_CON0,
-		     RV1126_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII));
 }
 
 static const struct rk_gmac_ops rv1126_ops = {
 	.set_to_rgmii = rv1126_set_to_rgmii,
 	.set_to_rmii = rv1126_set_to_rmii,
 	.set_speed = rk_set_clk_mac_speed,
+
+	.gmac_grf_reg = RV1126_GRF_GMAC_CON0,
+	.gmac_phy_intf_sel_mask = GENMASK_U16(6, 4),
 };
 
 static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
@@ -1619,6 +1656,11 @@ static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
 
 	bsp_priv->dev = dev;
 
+	/* Set the default phy_intf_sel and RMII mode register parameters. */
+	bsp_priv->gmac_grf_reg = ops->gmac_grf_reg;
+	bsp_priv->gmac_phy_intf_sel_mask = ops->gmac_phy_intf_sel_mask;
+	bsp_priv->gmac_rmii_mode_mask = ops->gmac_rmii_mode_mask;
+
 	if (ops->init) {
 		ret = ops->init(bsp_priv);
 		if (ret) {
@@ -1654,6 +1696,7 @@ static int rk_gmac_check_ops(struct rk_priv_data *bsp_priv)
 static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
 {
 	struct device *dev = bsp_priv->dev;
+	u32 val;
 	int ret;
 
 	ret = rk_gmac_check_ops(bsp_priv);
@@ -1664,6 +1707,24 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
 	if (ret)
 		return ret;
 
+	ret = rk_get_phy_intf_sel(bsp_priv->phy_iface);
+	if (ret < 0)
+		return ret;
+
+	if (bsp_priv->gmac_phy_intf_sel_mask ||
+	    bsp_priv->gmac_rmii_mode_mask) {
+		/* If defined, encode the phy_intf_sel value */
+		val = rk_encode_wm16(ret, bsp_priv->gmac_phy_intf_sel_mask);
+
+		/* If defined, encode the RMII mode mask setting. */
+		val |= rk_encode_wm16(ret == PHY_INTF_SEL_RMII,
+				      bsp_priv->gmac_rmii_mode_mask);
+
+		ret = regmap_write(bsp_priv->grf, bsp_priv->gmac_grf_reg, val);
+		if (ret < 0)
+			return ret;
+	}
+
 	/*rmii or rgmii*/
 	switch (bsp_priv->phy_iface) {
 	case PHY_INTERFACE_MODE_RGMII:
-- 
2.47.3


