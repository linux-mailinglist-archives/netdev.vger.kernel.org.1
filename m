Return-Path: <netdev+bounces-242991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A11C97EA4
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 15:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F3E24E1AC2
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 14:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5B331AF1A;
	Mon,  1 Dec 2025 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bvfLugZC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0028B31A7F4
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764600689; cv=none; b=Bs8XKjYrTehO2ULYqYJf4/DksY9qc3nhEuYJsFrYSr280rgCjhsqTR6JeP9YwkVoTrlug6gZkfLA7Q9KpR0tPzTdtlX/xRp/0PbsBRcIpUgatM8muapqn6EafstviGvSr3JmOI48UMj4nzlVBwkGBmchdrLfwdYIOwfTdHvLJug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764600689; c=relaxed/simple;
	bh=iXbQcdkJpuT6upeORlb1Kb9aiYnNTPTLbWmYvpGc8+k=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=gGOXMZLDPNV4CqZJbbAUV9CJmaWxUohjzYB6MjvFo0fAywkLgFgsJwNK2HJm0B6tnv/bxfA/gzSQP3vbVST1JQsIsX7vaYTOduJ8CtgiA0ywGddDdnCDST715nJo0efYiqb6NmY4AC+MOQiJkLhwgyXOfH2kH3nKTN3dtJCVsIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bvfLugZC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0gAW/zIovjQ39HSDBZ6zcI6nNuCaflm3sU6eOG1F+aE=; b=bvfLugZCRi5kW6sQyM7YIsKVGf
	VuoozQNWNt41dBj3QMPL/1GE5MQlD53ywY6j94+354tJKaZ2yeDPr0eWsq/+45JCUtgOPUl0uZMyB
	jASQTpM7dmeidRKeqwhBK0g5uELfztF0aWceV6JajLiglM3WC6CazTenx/YboinE1aUd8aGCvLgH8
	MkX/xhEO3CSYg9vKiOi6J4T5wxUtbO/huDfeWMmouzWmwvqE6uO6v0JAiQ1EBKjE9IrVyGQeEnEjC
	sd7KJnR5P2D9aLueZItSs8c8FsWFL9mzo1FY/makFdZD87wa9XFI+0Xtea0XPzZNLpqIJ06WISXXU
	U0Ijkrpw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50954 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vQ5FD-000000000gQ-19gI;
	Mon, 01 Dec 2025 14:51:15 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vQ5FB-0000000GNvz-1f66;
	Mon, 01 Dec 2025 14:51:13 +0000
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
Subject: [PATCH RFC net-next 06/15] net: stmmac: rk: convert rk3588 to
 rk_set_reg_speed()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vQ5FB-0000000GNvz-1f66@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 01 Dec 2025 14:51:13 +0000

Update rk_set_reg_speed() to use either the grf or php_grf regmap
depending on the SoC's requirements and convert rk3588, removing
its custom code.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 62 ++++++++++---------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index e2c5bfbeadc5..2061ced12d6c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -52,6 +52,7 @@ struct rk_gmac_ops {
 
 	u16 speed_grf_reg;
 
+	bool speed_reg_php_grf;
 	bool php_grf_required;
 	bool regs_valid;
 	u32 regs[];
@@ -134,6 +135,7 @@ static int rk_set_reg_speed(struct rk_priv_data *bsp_priv,
 			    const struct rk_reg_speed_data *rsd,
 			    phy_interface_t interface, int speed)
 {
+	struct regmap *regmap;
 	unsigned int val;
 
 	if (phy_interface_mode_is_rgmii(interface)) {
@@ -168,7 +170,12 @@ static int rk_set_reg_speed(struct rk_priv_data *bsp_priv,
 		return -EINVAL;
 	}
 
-	regmap_write(bsp_priv->grf, bsp_priv->speed_grf_reg, val);
+	if (bsp_priv->ops->speed_reg_php_grf)
+		regmap = bsp_priv->php_grf;
+	else
+		regmap = bsp_priv->grf;
+
+	regmap_write(regmap, bsp_priv->speed_grf_reg, val);
 
 	return 0;
 
@@ -1318,39 +1325,33 @@ static void rk3588_set_to_rmii(struct rk_priv_data *bsp_priv)
 		     RK3588_GMAC_CLK_RMII_MODE(bsp_priv->id));
 }
 
+static const struct rk_reg_speed_data rk3588_gmac0_speed_data = {
+	.rgmii_10 = RK3588_GMAC_CLK_RGMII(0, GMAC_CLK_DIV50_2_5M),
+	.rgmii_100 = RK3588_GMAC_CLK_RGMII(0, GMAC_CLK_DIV5_25M),
+	.rgmii_1000 = RK3588_GMAC_CLK_RGMII(0, GMAC_CLK_DIV1_125M),
+	.rmii_10 = RK3588_GMA_CLK_RMII_DIV20(0),
+	.rmii_100 = RK3588_GMA_CLK_RMII_DIV2(0),
+};
+
+static const struct rk_reg_speed_data rk3588_gmac1_speed_data = {
+	.rgmii_10 = RK3588_GMAC_CLK_RGMII(1, GMAC_CLK_DIV50_2_5M),
+	.rgmii_100 = RK3588_GMAC_CLK_RGMII(1, GMAC_CLK_DIV5_25M),
+	.rgmii_1000 = RK3588_GMAC_CLK_RGMII(1, GMAC_CLK_DIV1_125M),
+	.rmii_10 = RK3588_GMA_CLK_RMII_DIV20(1),
+	.rmii_100 = RK3588_GMA_CLK_RMII_DIV2(1),
+};
+
 static int rk3588_set_gmac_speed(struct rk_priv_data *bsp_priv,
 				 phy_interface_t interface, int speed)
 {
-	unsigned int val = 0, id = bsp_priv->id;
-
-	switch (speed) {
-	case 10:
-		if (interface == PHY_INTERFACE_MODE_RMII)
-			val = RK3588_GMA_CLK_RMII_DIV20(id);
-		else
-			val = RK3588_GMAC_CLK_RGMII(id, GMAC_CLK_DIV50_2_5M);
-		break;
-	case 100:
-		if (interface == PHY_INTERFACE_MODE_RMII)
-			val = RK3588_GMA_CLK_RMII_DIV2(id);
-		else
-			val = RK3588_GMAC_CLK_RGMII(id, GMAC_CLK_DIV5_25M);
-		break;
-	case 1000:
-		if (interface != PHY_INTERFACE_MODE_RMII)
-			val = RK3588_GMAC_CLK_RGMII(id, GMAC_CLK_DIV1_125M);
-		else
-			goto err;
-		break;
-	default:
-		goto err;
-	}
+	const struct rk_reg_speed_data *rsd;
 
-	regmap_write(bsp_priv->php_grf, RK3588_GRF_CLK_CON1, val);
+	if (bsp_priv->id == 0)
+		rsd = &rk3588_gmac0_speed_data;
+	else
+		rsd = &rk3588_gmac1_speed_data;
 
-	return 0;
-err:
-	return -EINVAL;
+	return rk_set_reg_speed(bsp_priv, rsd, interface, speed);
 }
 
 static void rk3588_set_clock_selection(struct rk_priv_data *bsp_priv, bool input,
@@ -1374,6 +1375,9 @@ static const struct rk_gmac_ops rk3588_ops = {
 
 	.phy_intf_sel_grf_reg = RK3588_GRF_GMAC_CON0,
 
+	.speed_reg_php_grf = true,
+	.speed_grf_reg = RK3588_GRF_CLK_CON1,
+
 	.php_grf_required = true,
 	.regs_valid = true,
 	.regs = {
-- 
2.47.3


