Return-Path: <netdev+bounces-252798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFFCCBBVc2kDuwAAu9opvQ
	(envelope-from <netdev+bounces-252798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:01:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3956D74B67
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6BDBD300C540
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E7530214D;
	Fri, 23 Jan 2026 11:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="A/IttgXK"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A564D3033C8
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166073; cv=none; b=c2P2mY1Uj17AYgANtjHpcdRHEaxlyXzT0rO6s9eazSH9Oj2kg2D742w6Ujo8l9oCKQkwdHM9TzFmvQ2iuL2fsZOeicBf2ZAcoHrD/NYWdipmG5eb7Lu8ujurctEgLZtsSGm+U6Hqv0JHPaxLi9FGaCoj4bsq27kzUNbmO/3OUqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166073; c=relaxed/simple;
	bh=wsgwtoONg+1Xzw0F/U7NvAEzVU6gGUNy1jml33aZuUE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=IY1eCLK8yEHmyIyCmH0vLI1P4F2/I1JOb1oUFZ9YjRQk0hGDP/eVbIaRZWbh/VhKM3RCTEmdzygvWDIB68Vmyqe//KcJlw0Bec5ySG+4ox8Z2nLhyvlTVHbgnM3t7CGy3cXUt9XcupF57prAk0VY3ilV+04QUkytkn88oSfaxh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=A/IttgXK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JLUcVRXb4mb6a2uViUXf55RnQkSLAYB+PAY0ct+KWkc=; b=A/IttgXKYpblnA4Hw/ceWL+mcD
	T5am+VrR+piMSXKwoHMz8LqSKMq07By2sITzx0loEK+V3O1TVPhx6bNg0+E6H94YSAWUwVEK/e+J9
	NyjzRYflMFY1fkze4uNgJ6adUvk/WzSlFfU0pHuHID/ZRjtVNMKhQm0TvsUX1i0Blp8R1JffG9U2J
	dX6qzWygIpkGs7trXQ4kIanUt/WZdNWFBo3WMj00pjm5xmU+BUW9i/8/xtQc/GiuNZjk7BmevWMwQ
	tiBqEOPMhGDoEMYXphvgceGTBQqmZC++IYGdjgmOkXAsWSO9fpEwEE7UMrcubjaDCMukjvSyxBvmB
	ZD28mDiw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54966 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vjEuR-000000001oM-3Qwd;
	Fri, 23 Jan 2026 11:00:59 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vjEuQ-00000005ggK-2PCE;
	Fri, 23 Jan 2026 11:00:58 +0000
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
Subject: [PATCH net-next 08/21] net: stmmac: rk: move speed GRF register
 offset to private data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vjEuQ-00000005ggK-2PCE@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 23 Jan 2026 11:00:58 +0000
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
	TAGGED_FROM(0.00)[bounces-252798-lists,netdev=lfdr.de,kernel];
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
	NEURAL_HAM(-0.00)[-0.985];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,rmk-PC.armlinux.org.uk:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3956D74B67
X-Rspamd-Action: no action

Move the speed/clocking related GRF register offset into the driver
private data, convert rk_set_reg_speed() to use it and initialise this
member either from the corresponding member in struct rk_gmac_ops, or
the SoC specific initialisation function.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 114 +++++++++++++-----
 1 file changed, 81 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 48fc5b58092f..246a7b9205a5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -50,6 +50,8 @@ struct rk_gmac_ops {
 	u16 gmac_phy_intf_sel_mask;
 	u16 gmac_rmii_mode_mask;
 
+	u16 clock_grf_reg;
+
 	bool php_grf_required;
 	bool regs_valid;
 	u32 regs[];
@@ -99,6 +101,8 @@ struct rk_priv_data {
 	u16 gmac_grf_reg;
 	u16 gmac_phy_intf_sel_mask;
 	u16 gmac_rmii_mode_mask;
+
+	u16 clock_grf_reg;
 };
 
 #define GMAC_CLK_DIV1_125M		0
@@ -126,10 +130,14 @@ static u32 rk_encode_wm16(u16 val, u16 mask)
 	return reg_val;
 }
 
+static int rk_write_clock_grf_reg(struct rk_priv_data *bsp_priv, u32 val)
+{
+	return regmap_write(bsp_priv->grf, bsp_priv->clock_grf_reg, val);
+}
+
 static int rk_set_reg_speed(struct rk_priv_data *bsp_priv,
 			    const struct rk_reg_speed_data *rsd,
-			    unsigned int reg, phy_interface_t interface,
-			    int speed)
+			    phy_interface_t interface, int speed)
 {
 	unsigned int val;
 
@@ -165,7 +173,7 @@ static int rk_set_reg_speed(struct rk_priv_data *bsp_priv,
 		return -EINVAL;
 	}
 
-	regmap_write(bsp_priv->grf, reg, val);
+	rk_write_clock_grf_reg(bsp_priv, val);
 
 	return 0;
 
@@ -360,7 +368,7 @@ static int rk3128_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
 	return rk_set_reg_speed(bsp_priv, &rk3128_reg_speed_data,
-				RK3128_GRF_MAC_CON1, interface, speed);
+				interface, speed);
 }
 
 static const struct rk_gmac_ops rk3128_ops = {
@@ -371,6 +379,8 @@ static const struct rk_gmac_ops rk3128_ops = {
 	.gmac_grf_reg = RK3128_GRF_MAC_CON1,
 	.gmac_phy_intf_sel_mask = GENMASK_U16(8, 6),
 	.gmac_rmii_mode_mask = BIT_U16(14),
+
+	.clock_grf_reg = RK3128_GRF_MAC_CON1,
 };
 
 #define RK3228_GRF_MAC_CON0	0x0900
@@ -427,7 +437,7 @@ static int rk3228_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
 	return rk_set_reg_speed(bsp_priv, &rk3228_reg_speed_data,
-				RK3228_GRF_MAC_CON1, interface, speed);
+				interface, speed);
 }
 
 static void rk3228_integrated_phy_powerup(struct rk_priv_data *priv)
@@ -449,6 +459,7 @@ static const struct rk_gmac_ops rk3228_ops = {
 	.gmac_phy_intf_sel_mask = GENMASK_U16(6, 4),
 	.gmac_rmii_mode_mask = BIT_U16(10),
 
+	.clock_grf_reg = RK3228_GRF_MAC_CON1,
 };
 
 #define RK3288_GRF_SOC_CON1	0x0248
@@ -496,7 +507,7 @@ static int rk3288_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
 	return rk_set_reg_speed(bsp_priv, &rk3288_reg_speed_data,
-				RK3288_GRF_SOC_CON1, interface, speed);
+				interface, speed);
 }
 
 static const struct rk_gmac_ops rk3288_ops = {
@@ -507,6 +518,8 @@ static const struct rk_gmac_ops rk3288_ops = {
 	.gmac_grf_reg = RK3288_GRF_SOC_CON1,
 	.gmac_phy_intf_sel_mask = GENMASK_U16(8, 6),
 	.gmac_rmii_mode_mask = BIT_U16(14),
+
+	.clock_grf_reg = RK3288_GRF_SOC_CON1,
 };
 
 #define RK3308_GRF_MAC_CON0		0x04a0
@@ -530,7 +543,7 @@ static int rk3308_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
 	return rk_set_reg_speed(bsp_priv, &rk3308_reg_speed_data,
-				RK3308_GRF_MAC_CON0, interface, speed);
+				interface, speed);
 }
 
 static const struct rk_gmac_ops rk3308_ops = {
@@ -539,6 +552,8 @@ static const struct rk_gmac_ops rk3308_ops = {
 
 	.gmac_grf_reg = RK3308_GRF_MAC_CON0,
 	.gmac_phy_intf_sel_mask = GENMASK_U16(4, 2),
+
+	.clock_grf_reg = RK3308_GRF_MAC_CON0,
 };
 
 #define RK3328_GRF_MAC_CON0	0x0900
@@ -569,10 +584,12 @@ static int rk3328_init(struct rk_priv_data *bsp_priv)
 	switch (bsp_priv->id) {
 	case 0: /* gmac2io */
 		bsp_priv->gmac_grf_reg = RK3328_GRF_MAC_CON1;
+		bsp_priv->clock_grf_reg = RK3328_GRF_MAC_CON1;
 		return 0;
 
 	case 1: /* gmac2phy */
 		bsp_priv->gmac_grf_reg = RK3328_GRF_MAC_CON2;
+		bsp_priv->clock_grf_reg = RK3328_GRF_MAC_CON2;
 		return 0;
 
 	default:
@@ -607,11 +624,7 @@ static const struct rk_reg_speed_data rk3328_reg_speed_data = {
 static int rk3328_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
-	unsigned int reg;
-
-	reg = bsp_priv->id ? RK3328_GRF_MAC_CON2 : RK3328_GRF_MAC_CON1;
-
-	return rk_set_reg_speed(bsp_priv, &rk3328_reg_speed_data, reg,
+	return rk_set_reg_speed(bsp_priv, &rk3328_reg_speed_data,
 				interface, speed);
 }
 
@@ -687,7 +700,7 @@ static int rk3366_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
 	return rk_set_reg_speed(bsp_priv, &rk3366_reg_speed_data,
-				RK3366_GRF_SOC_CON6, interface, speed);
+				interface, speed);
 }
 
 static const struct rk_gmac_ops rk3366_ops = {
@@ -698,6 +711,8 @@ static const struct rk_gmac_ops rk3366_ops = {
 	.gmac_grf_reg = RK3366_GRF_SOC_CON6,
 	.gmac_phy_intf_sel_mask = GENMASK_U16(11, 9),
 	.gmac_rmii_mode_mask = BIT_U16(6),
+
+	.clock_grf_reg = RK3366_GRF_SOC_CON6,
 };
 
 #define RK3368_GRF_SOC_CON15	0x043c
@@ -745,7 +760,7 @@ static int rk3368_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
 	return rk_set_reg_speed(bsp_priv, &rk3368_reg_speed_data,
-				RK3368_GRF_SOC_CON15, interface, speed);
+				interface, speed);
 }
 
 static const struct rk_gmac_ops rk3368_ops = {
@@ -756,6 +771,8 @@ static const struct rk_gmac_ops rk3368_ops = {
 	.gmac_grf_reg = RK3368_GRF_SOC_CON15,
 	.gmac_phy_intf_sel_mask = GENMASK_U16(11, 9),
 	.gmac_rmii_mode_mask = BIT_U16(6),
+
+	.clock_grf_reg = RK3368_GRF_SOC_CON15,
 };
 
 #define RK3399_GRF_SOC_CON5	0xc214
@@ -803,7 +820,7 @@ static int rk3399_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
 	return rk_set_reg_speed(bsp_priv, &rk3399_reg_speed_data,
-				RK3399_GRF_SOC_CON5, interface, speed);
+				interface, speed);
 }
 
 static const struct rk_gmac_ops rk3399_ops = {
@@ -814,6 +831,8 @@ static const struct rk_gmac_ops rk3399_ops = {
 	.gmac_grf_reg = RK3399_GRF_SOC_CON5,
 	.gmac_phy_intf_sel_mask = GENMASK_U16(11, 9),
 	.gmac_rmii_mode_mask = BIT_U16(6),
+
+	.clock_grf_reg = RK3399_GRF_SOC_CON5,
 };
 
 #define RK3506_GRF_SOC_CON8		0x0020
@@ -830,6 +849,22 @@ static const struct rk_gmac_ops rk3399_ops = {
 #define RK3506_GMAC_CLK_RMII_GATE	GRF_BIT(2)
 #define RK3506_GMAC_CLK_RMII_NOGATE	GRF_CLR_BIT(2)
 
+static int rk3506_init(struct rk_priv_data *bsp_priv)
+{
+	switch (bsp_priv->id) {
+	case 0:
+		bsp_priv->clock_grf_reg = RK3506_GRF_SOC_CON8;
+		return 0;
+
+	case 1:
+		bsp_priv->clock_grf_reg = RK3506_GRF_SOC_CON11;
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static void rk3506_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 	unsigned int id = bsp_priv->id, offset;
@@ -846,11 +881,8 @@ static const struct rk_reg_speed_data rk3506_reg_speed_data = {
 static int rk3506_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
-	unsigned int id = bsp_priv->id, offset;
-
-	offset = (id == 1) ? RK3506_GRF_SOC_CON11 : RK3506_GRF_SOC_CON8;
 	return rk_set_reg_speed(bsp_priv, &rk3506_reg_speed_data,
-				offset, interface, speed);
+				interface, speed);
 }
 
 static void rk3506_set_clock_selection(struct rk_priv_data *bsp_priv,
@@ -868,6 +900,7 @@ static void rk3506_set_clock_selection(struct rk_priv_data *bsp_priv,
 }
 
 static const struct rk_gmac_ops rk3506_ops = {
+	.init = rk3506_init,
 	.set_to_rmii = rk3506_set_to_rmii,
 	.set_speed = rk3506_set_speed,
 	.set_clock_selection = rk3506_set_clock_selection,
@@ -912,6 +945,22 @@ static const struct rk_gmac_ops rk3506_ops = {
 #define RK3528_GMAC1_CLK_RMII_GATE	GRF_BIT(9)
 #define RK3528_GMAC1_CLK_RMII_NOGATE	GRF_CLR_BIT(9)
 
+static int rk3528_init(struct rk_priv_data *bsp_priv)
+{
+	switch (bsp_priv->id) {
+	case 0:
+		bsp_priv->clock_grf_reg = RK3528_VO_GRF_GMAC_CON;
+		return 0;
+
+	case 1:
+		bsp_priv->clock_grf_reg = RK3528_VPU_GRF_GMAC_CON5;
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static void rk3528_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
@@ -954,17 +1003,13 @@ static int rk3528_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
 	const struct rk_reg_speed_data *rsd;
-	unsigned int reg;
 
-	if (bsp_priv->id == 1) {
+	if (bsp_priv->id == 1)
 		rsd = &rk3528_gmac1_reg_speed_data;
-		reg = RK3528_VPU_GRF_GMAC_CON5;
-	} else {
+	else
 		rsd = &rk3528_gmac0_reg_speed_data;
-		reg = RK3528_VO_GRF_GMAC_CON;
-	}
 
-	return rk_set_reg_speed(bsp_priv, rsd, reg, interface, speed);
+	return rk_set_reg_speed(bsp_priv, rsd, interface, speed);
 }
 
 static void rk3528_set_clock_selection(struct rk_priv_data *bsp_priv,
@@ -996,6 +1041,7 @@ static void rk3528_integrated_phy_powerdown(struct rk_priv_data *bsp_priv)
 }
 
 static const struct rk_gmac_ops rk3528_ops = {
+	.init = rk3528_init,
 	.set_to_rgmii = rk3528_set_to_rgmii,
 	.set_to_rmii = rk3528_set_to_rmii,
 	.set_speed = rk3528_set_speed,
@@ -1116,10 +1162,12 @@ static int rk3576_init(struct rk_priv_data *bsp_priv)
 	switch (bsp_priv->id) {
 	case 0:
 		bsp_priv->gmac_grf_reg = RK3576_GRF_GMAC_CON0;
+		bsp_priv->clock_grf_reg = RK3576_GRF_GMAC_CON0;
 		return 0;
 
 	case 1:
 		bsp_priv->gmac_grf_reg = RK3576_GRF_GMAC_CON1;
+		bsp_priv->clock_grf_reg = RK3576_GRF_GMAC_CON1;
 		return 0;
 
 	default:
@@ -1165,12 +1213,7 @@ static const struct rk_reg_speed_data rk3578_reg_speed_data = {
 static int rk3576_set_gmac_speed(struct rk_priv_data *bsp_priv,
 				 phy_interface_t interface, int speed)
 {
-	unsigned int offset_con;
-
-	offset_con = bsp_priv->id == 1 ? RK3576_GRF_GMAC_CON1 :
-					 RK3576_GRF_GMAC_CON0;
-
-	return rk_set_reg_speed(bsp_priv, &rk3578_reg_speed_data, offset_con,
+	return rk_set_reg_speed(bsp_priv, &rk3578_reg_speed_data,
 				interface, speed);
 }
 
@@ -1370,7 +1413,7 @@ static int rv1108_set_speed(struct rk_priv_data *bsp_priv,
 			    phy_interface_t interface, int speed)
 {
 	return rk_set_reg_speed(bsp_priv, &rv1108_reg_speed_data,
-				RV1108_GRF_GMAC_CON0, interface, speed);
+				interface, speed);
 }
 
 static const struct rk_gmac_ops rv1108_ops = {
@@ -1379,6 +1422,8 @@ static const struct rk_gmac_ops rv1108_ops = {
 
 	.gmac_grf_reg = RV1108_GRF_GMAC_CON0,
 	.gmac_phy_intf_sel_mask = GENMASK_U16(6, 4),
+
+	.clock_grf_reg = RV1108_GRF_GMAC_CON0,
 };
 
 #define RV1126_GRF_GMAC_CON0		0X0070
@@ -1661,6 +1706,9 @@ static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
 	bsp_priv->gmac_phy_intf_sel_mask = ops->gmac_phy_intf_sel_mask;
 	bsp_priv->gmac_rmii_mode_mask = ops->gmac_rmii_mode_mask;
 
+	/* Set the default clock control register related parameters */
+	bsp_priv->clock_grf_reg = ops->clock_grf_reg;
+
 	if (ops->init) {
 		ret = ops->init(bsp_priv);
 		if (ret) {
-- 
2.47.3


