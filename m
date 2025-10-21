Return-Path: <netdev+bounces-231419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EDEBF9226
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 00:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E6FF63561D4
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 22:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DBB302173;
	Tue, 21 Oct 2025 22:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="EEWtocEY"
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA682E9EAA;
	Tue, 21 Oct 2025 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761086679; cv=none; b=bhegAZ0I+PiZz4fSDU185RMqW05W8bqaw3D+HUr2G8AVWeFb3L+Od+2wLGAnuFUI303eTDPwXXqj1DtiodOfQyzo64qgZmXfvO3y+7hnaRuL2HXyW43Bacmj3bPsxpBgHc8a0WQr0W9KRPoqZn34+jNNd9FXsRQuJH+ogtsib8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761086679; c=relaxed/simple;
	bh=d2i8l5d8l/iC4brGst0MSs82HZr1NyyBRW8AcbdQBxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzKyf2m5qzS207dnLCorq16d1Gz/p40AFBdbjJ5f3uKiRyA0R5aHwQvoFYQHGp9zoSZt50F/b+OYxgfd5ft4FRdegnzoi3mXibhbdtUo/q9TH9GC0D2LAOhsOfLQ48DeXcFNMr4ANgC12/hYQVojPRYJ+5jlKOP8I5QMq70d1Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=EEWtocEY; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=k337ivC7NrcTNieDT0Q2eCyvA/Xn4/BzwHpob3IicHE=; b=EEWtocEYifRPL35M5DCVbhER71
	srkwVoDTTN1rShvLxlZPgXDd+EDeu3IKVfHdF/KCQNwpEXi85il3xhUFF03wq7Kyvj2+HhbbwyNYs
	s9CI6ljwDopEZw4/6xul6a/r5YfLVIMuwhhOlVisR9QHW8Magow4D5i57wZj/QKib4p//Wm4Ev79l
	0D+ID/rOm4R3g8/SsRIrbUcl4QD7QF8rPZxyTw+aKrFbiQiTKjgzP2f8Ve2Snb/2npiCAQlXbVkle
	Oyp511ZNscRpQ0oVf8eVxnFW91yvE7J2QamQV7S6t77Rt+DQ1hvYY4GZZMVV1TccxgkNW2mbdSyAy
	WtItemvQ==;
Received: from i53875b19.versanet.de ([83.135.91.25] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vBL5e-0006q7-2z; Wed, 22 Oct 2025 00:44:26 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	David Wu <david.wu@rock-chips.com>
Subject: [PATCH 4/4] ethernet: stmmac: dwmac-rk: Add RK3506 GMAC support
Date: Wed, 22 Oct 2025 00:43:57 +0200
Message-ID: <20251021224357.195015-5-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251021224357.195015-1-heiko@sntech.de>
References: <20251021224357.195015-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Wu <david.wu@rock-chips.com>

Add the needed glue blocks for the RK3506-specific setup.

The RK3506 dwmac only supports up to 100MBit with a RMII PHY,
but no RGMII.

Signed-off-by: David Wu <david.wu@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 51ea0caf16c1..e1e036e7163c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -827,6 +827,84 @@ static const struct rk_gmac_ops rk3399_ops = {
 	.set_speed = rk3399_set_speed,
 };
 
+#define RK3506_GRF_SOC_CON8		0X0020
+#define RK3506_GRF_SOC_CON11		0X002c
+
+#define RK3506_GMAC_RMII_MODE		GRF_BIT(1)
+
+#define RK3506_GMAC_CLK_RMII_DIV2	GRF_BIT(3)
+#define RK3506_GMAC_CLK_RMII_DIV20	GRF_CLR_BIT(3)
+
+#define RK3506_GMAC_CLK_SELET_CRU	GRF_CLR_BIT(5)
+#define RK3506_GMAC_CLK_SELET_IO	GRF_BIT(5)
+
+#define RK3506_GMAC_CLK_RMII_GATE	GRF_BIT(2)
+#define RK3506_GMAC_CLK_RMII_NOGATE	GRF_CLR_BIT(2)
+
+static void rk3506_set_to_rmii(struct rk_priv_data *bsp_priv)
+{
+	struct device *dev = bsp_priv->dev;
+	unsigned int id = bsp_priv->id, offset;
+
+	if (IS_ERR(bsp_priv->grf)) {
+		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
+		return;
+	}
+
+	offset = (id == 1) ? RK3506_GRF_SOC_CON11 : RK3506_GRF_SOC_CON8;
+	regmap_write(bsp_priv->grf, offset, RK3506_GMAC_RMII_MODE);
+}
+
+static int rk3506_set_speed(struct rk_priv_data *bsp_priv,
+			    phy_interface_t interface, int speed)
+{
+	struct device *dev = bsp_priv->dev;
+	unsigned int val, offset, id = bsp_priv->id;
+
+	switch (speed) {
+	case 10:
+		val = RK3506_GMAC_CLK_RMII_DIV20;
+		break;
+	case 100:
+		val = RK3506_GMAC_CLK_RMII_DIV2;
+		break;
+	default:
+		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
+		return -EINVAL;
+	}
+
+	offset = (id == 1) ? RK3506_GRF_SOC_CON11 : RK3506_GRF_SOC_CON8;
+	regmap_write(bsp_priv->grf, offset, val);
+
+	return 0;
+}
+
+static void rk3506_set_clock_selection(struct rk_priv_data *bsp_priv,
+				       bool input, bool enable)
+{
+	unsigned int value, offset, id = bsp_priv->id;
+
+	offset = (id == 1) ? RK3506_GRF_SOC_CON11 : RK3506_GRF_SOC_CON8;
+
+	value = input ? RK3506_GMAC_CLK_SELET_IO :
+			RK3506_GMAC_CLK_SELET_CRU;
+	value |= enable ? RK3506_GMAC_CLK_RMII_NOGATE :
+			  RK3506_GMAC_CLK_RMII_GATE;
+	regmap_write(bsp_priv->grf, offset, value);
+}
+
+static const struct rk_gmac_ops rk3506_ops = {
+	.set_to_rmii = rk3506_set_to_rmii,
+	.set_speed = rk3506_set_speed,
+	.set_clock_selection = rk3506_set_clock_selection,
+	.regs_valid = true,
+	.regs = {
+		0xff4c8000, /* gmac0 */
+		0xff4d0000, /* gmac1 */
+		0x0, /* sentinel */
+	},
+};
+
 #define RK3528_VO_GRF_GMAC_CON		0x0018
 #define RK3528_VO_GRF_MACPHY_CON0	0x001c
 #define RK3528_VO_GRF_MACPHY_CON1	0x0020
@@ -1808,6 +1886,7 @@ static const struct of_device_id rk_gmac_dwmac_match[] = {
 	{ .compatible = "rockchip,rk3366-gmac", .data = &rk3366_ops },
 	{ .compatible = "rockchip,rk3368-gmac", .data = &rk3368_ops },
 	{ .compatible = "rockchip,rk3399-gmac", .data = &rk3399_ops },
+	{ .compatible = "rockchip,rk3506-gmac", .data = &rk3506_ops },
 	{ .compatible = "rockchip,rk3528-gmac", .data = &rk3528_ops },
 	{ .compatible = "rockchip,rk3568-gmac", .data = &rk3568_ops },
 	{ .compatible = "rockchip,rk3576-gmac", .data = &rk3576_ops },
-- 
2.47.2


