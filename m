Return-Path: <netdev+bounces-116957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACCD94C33C
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 19:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1EE4B25818
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 17:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC951191F8A;
	Thu,  8 Aug 2024 17:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="avIOnsiy"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D243D1917ED;
	Thu,  8 Aug 2024 17:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723136438; cv=pass; b=NaCftm9Ttr2pGC7yGNBjYQ6vX0uypIitf4vqQc7r8vGT2Y0Pl99XLq8ZOUd8NU8eT6VOZump5st04DK+Zoz+0Qn4GqBAcEgQXzD0WvyCLv6O76wI/FUfuOH33CnZwqzEj5nO8kGUxEn65HNatXD4ydxWsryj7Jxy7MsRAkOp3RI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723136438; c=relaxed/simple;
	bh=zZeN9Ol19HOHosRc4lcMNNIP49ERoUO0hY/cOllfT2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXwo5trFQhtcUcKTnpQHPJkIqPWEfBEVCIVHTxIyyDSNRIgu+y5uSL7E1WYM0zLzqUss1hWVMWMPl/eqqbXJFsXCvRCuKPayNAZmuWNWsB1HpHvP7Zuv21bciKC6rz61fPMnm+GWp3zD5WjHzP0glAURw0dMgFwZ50yFOe0jyKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=avIOnsiy; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723136404; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Y1khZaNYJOJehUcadi0Ebk8llRNdz2aWNnGf9ptu5/82RT1oGZ9O+/BsK4u02LRV6bTIQh6h34dQdtPeV/i5B0BKBKqo/6AnCIMTCr17hmGaN8ckUWI4AAwG+D1KjinV9q5iheONWvLnBjiJTR8iUZeoT48h5RbAjcdWxllTIqc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723136404; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YC9mK9tDux9if1jjq44zZCozmGqOGn8PObz3o8/d74c=; 
	b=EROUBlB518PboYi2PE+FYAmji+gApfEYuvQMBbHT75lk9Lh+o7QivfnGuiFXKeyEdFfC85/3JU2NQY+x6vW8sI92+NEXyDnLPd/dCTdOhfYCNrWBKSx460w3uaAThiz4dCMmrd08RiGJRmMNngHrgE7rmhQljJT7qgWKcm7/xas=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723136404;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=YC9mK9tDux9if1jjq44zZCozmGqOGn8PObz3o8/d74c=;
	b=avIOnsiyyS2G6W+aOBzZ+vXiF9nXKmi2a56EFAi/eV2V/XvE3PovSKUZ4TQNh77s
	hMTV4V9iAaF2o5LM4SU6Ym2KE68TbVOlAKgXNAbQp7Z3X1JpxFRGwcig38BM/OXYG1a
	eXQrfKr04N2oKMvTXsRTGw0t/uNAwRLBvWDdTRos=
Received: by mx.zohomail.com with SMTPS id 1723136403611383.43297244538667;
	Thu, 8 Aug 2024 10:00:03 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	David Wu <david.wu@rock-chips.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	kernel@collabora.com,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v2 2/2] ethernet: stmmac: dwmac-rk: Add GMAC support for RK3576
Date: Thu,  8 Aug 2024 13:00:18 -0400
Message-ID: <20240808170113.82775-3-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240808170113.82775-1-detlev.casanova@collabora.com>
References: <20240808170113.82775-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: David Wu <david.wu@rock-chips.com>

Add constants and callback functions for the dwmac on RK3576 soc.

Signed-off-by: David Wu <david.wu@rock-chips.com>
[rebase, extracted bindings]
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 156 ++++++++++++++++++
 1 file changed, 156 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 7ae04d8d291c8..e1fa8fc9f4012 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1116,6 +1116,161 @@ static const struct rk_gmac_ops rk3568_ops = {
 	},
 };
 
+/* VCCIO0_1_3_IOC */
+#define RK3576_VCCIO0_1_3_IOC_CON2		0X6408
+#define RK3576_VCCIO0_1_3_IOC_CON3		0X640c
+#define RK3576_VCCIO0_1_3_IOC_CON4		0X6410
+#define RK3576_VCCIO0_1_3_IOC_CON5		0X6414
+
+#define RK3576_GMAC_RXCLK_DLY_ENABLE		GRF_BIT(15)
+#define RK3576_GMAC_RXCLK_DLY_DISABLE		GRF_CLR_BIT(15)
+#define RK3576_GMAC_TXCLK_DLY_ENABLE		GRF_BIT(7)
+#define RK3576_GMAC_TXCLK_DLY_DISABLE		GRF_CLR_BIT(7)
+
+#define RK3576_GMAC_CLK_RX_DL_CFG(val)		HIWORD_UPDATE(val, 0x7F, 8)
+#define RK3576_GMAC_CLK_TX_DL_CFG(val)		HIWORD_UPDATE(val, 0x7F, 0)
+
+/* SDGMAC_GRF */
+#define RK3576_GRF_GMAC_CON0			0X0020
+#define RK3576_GRF_GMAC_CON1			0X0024
+
+#define RK3576_GMAC_RMII_MODE			GRF_BIT(3)
+#define RK3576_GMAC_RGMII_MODE			GRF_CLR_BIT(3)
+
+#define RK3576_GMAC_CLK_SELET_IO		GRF_BIT(7)
+#define RK3576_GMAC_CLK_SELET_CRU		GRF_CLR_BIT(7)
+
+#define RK3576_GMAC_CLK_RMII_DIV2		GRF_BIT(5)
+#define RK3576_GMAC_CLK_RMII_DIV20		GRF_CLR_BIT(5)
+
+#define RK3576_GMAC_CLK_RGMII_DIV1		\
+			(GRF_CLR_BIT(6) | GRF_CLR_BIT(5))
+#define RK3576_GMAC_CLK_RGMII_DIV5		\
+			(GRF_BIT(6) | GRF_BIT(5))
+#define RK3576_GMAC_CLK_RGMII_DIV50		\
+			(GRF_BIT(6) | GRF_CLR_BIT(5))
+
+#define RK3576_GMAC_CLK_RMII_GATE		GRF_BIT(4)
+#define RK3576_GMAC_CLK_RMII_NOGATE		GRF_CLR_BIT(4)
+
+static void rk3576_set_to_rgmii(struct rk_priv_data *bsp_priv,
+				int tx_delay, int rx_delay)
+{
+	struct device *dev = &bsp_priv->pdev->dev;
+	unsigned int offset_con;
+
+	if (IS_ERR(bsp_priv->grf) || IS_ERR(bsp_priv->php_grf)) {
+		dev_err(dev, "Missing rockchip,grf or rockchip,php_grf property\n");
+		return;
+	}
+
+	offset_con = bsp_priv->id == 1 ? RK3576_GRF_GMAC_CON1 :
+					 RK3576_GRF_GMAC_CON0;
+
+	regmap_write(bsp_priv->grf, offset_con, RK3576_GMAC_RGMII_MODE);
+
+	offset_con = bsp_priv->id == 1 ? RK3576_VCCIO0_1_3_IOC_CON4 :
+					 RK3576_VCCIO0_1_3_IOC_CON2;
+
+	/* m0 && m1 delay enabled */
+	regmap_write(bsp_priv->php_grf, offset_con,
+		     DELAY_ENABLE(RK3576, tx_delay, rx_delay));
+	regmap_write(bsp_priv->php_grf, offset_con + 0x4,
+		     DELAY_ENABLE(RK3576, tx_delay, rx_delay));
+
+	/* m0 && m1 delay value */
+	regmap_write(bsp_priv->php_grf, offset_con,
+		     RK3576_GMAC_CLK_TX_DL_CFG(tx_delay) |
+		     RK3576_GMAC_CLK_RX_DL_CFG(rx_delay));
+	regmap_write(bsp_priv->php_grf, offset_con + 0x4,
+		     RK3576_GMAC_CLK_TX_DL_CFG(tx_delay) |
+		     RK3576_GMAC_CLK_RX_DL_CFG(rx_delay));
+}
+
+static void rk3576_set_to_rmii(struct rk_priv_data *bsp_priv)
+{
+	struct device *dev = &bsp_priv->pdev->dev;
+	unsigned int offset_con;
+
+	if (IS_ERR(bsp_priv->php_grf)) {
+		dev_err(dev, "%s: Missing rockchip,php_grf property\n", __func__);
+		return;
+	}
+
+	offset_con = bsp_priv->id == 1 ? RK3576_GRF_GMAC_CON1 :
+					 RK3576_GRF_GMAC_CON0;
+
+	regmap_write(bsp_priv->grf, offset_con, RK3576_GMAC_RMII_MODE);
+}
+
+static void rk3576_set_gmac_speed(struct rk_priv_data *bsp_priv, int speed)
+{
+	struct device *dev = &bsp_priv->pdev->dev;
+	unsigned int val = 0, offset_con;
+
+	switch (speed) {
+	case 10:
+		if (bsp_priv->phy_iface == PHY_INTERFACE_MODE_RMII)
+			val = RK3576_GMAC_CLK_RMII_DIV20;
+		else
+			val = RK3576_GMAC_CLK_RGMII_DIV50;
+		break;
+	case 100:
+		if (bsp_priv->phy_iface == PHY_INTERFACE_MODE_RMII)
+			val = RK3576_GMAC_CLK_RMII_DIV2;
+		else
+			val = RK3576_GMAC_CLK_RGMII_DIV5;
+		break;
+	case 1000:
+		if (bsp_priv->phy_iface != PHY_INTERFACE_MODE_RMII)
+			val = RK3576_GMAC_CLK_RGMII_DIV1;
+		else
+			goto err;
+		break;
+	default:
+		goto err;
+	}
+
+	offset_con = bsp_priv->id == 1 ? RK3576_GRF_GMAC_CON1 :
+					 RK3576_GRF_GMAC_CON0;
+
+	regmap_write(bsp_priv->grf, offset_con, val);
+
+	return;
+err:
+	dev_err(dev, "unknown speed value for GMAC speed=%d", speed);
+}
+
+static void rk3576_set_clock_selection(struct rk_priv_data *bsp_priv, bool input,
+				       bool enable)
+{
+	unsigned int val = input ? RK3576_GMAC_CLK_SELET_IO :
+				   RK3576_GMAC_CLK_SELET_CRU;
+	unsigned int offset_con;
+
+	val |= enable ? RK3576_GMAC_CLK_RMII_NOGATE :
+			RK3576_GMAC_CLK_RMII_GATE;
+
+	offset_con = bsp_priv->id == 1 ? RK3576_GRF_GMAC_CON1 :
+					 RK3576_GRF_GMAC_CON0;
+
+	regmap_write(bsp_priv->grf, offset_con, val);
+}
+
+static const struct rk_gmac_ops rk3576_ops = {
+	.set_to_rgmii = rk3576_set_to_rgmii,
+	.set_to_rmii = rk3576_set_to_rmii,
+	.set_rgmii_speed = rk3576_set_gmac_speed,
+	.set_rmii_speed = rk3576_set_gmac_speed,
+	.set_clock_selection = rk3576_set_clock_selection,
+	.regs_valid = true,
+	.regs = {
+		0x2a220000, /* gmac0 */
+		0x2a230000, /* gmac1 */
+		0x0, /* sentinel */
+	},
+};
+
 /* sys_grf */
 #define RK3588_GRF_GMAC_CON7			0X031c
 #define RK3588_GRF_GMAC_CON8			0X0320
@@ -1908,6 +2063,7 @@ static const struct of_device_id rk_gmac_dwmac_match[] = {
 	{ .compatible = "rockchip,rk3368-gmac", .data = &rk3368_ops },
 	{ .compatible = "rockchip,rk3399-gmac", .data = &rk3399_ops },
 	{ .compatible = "rockchip,rk3568-gmac", .data = &rk3568_ops },
+	{ .compatible = "rockchip,rk3576-gmac", .data = &rk3576_ops },
 	{ .compatible = "rockchip,rk3588-gmac", .data = &rk3588_ops },
 	{ .compatible = "rockchip,rv1108-gmac", .data = &rv1108_ops },
 	{ .compatible = "rockchip,rv1126-gmac", .data = &rv1126_ops },
-- 
2.46.0


