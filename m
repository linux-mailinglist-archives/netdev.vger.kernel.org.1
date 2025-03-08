Return-Path: <netdev+bounces-173214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5943CA57EA4
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 22:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 349201886AD3
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 21:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC88214A97;
	Sat,  8 Mar 2025 21:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="t8/PYxPE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F651A5B99
	for <netdev@vger.kernel.org>; Sat,  8 Mar 2025 21:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741469872; cv=none; b=mOiZw1TQuVRSbgjUX+uxr5zw8PD6BrOlF+oAE3oXchHRrImEBHmsYWIzrIUD74oHz7fs9GCgAXMe/GN41Jh7TcqScEfwO3LN4voYZUBLQKIepeZb0AgAePO1O1L3twiXbns0waQViyBGLvP3cc1gCDsqN7qxtzRtRZFHWyMZkvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741469872; c=relaxed/simple;
	bh=jv4tDZTTwStzQ9+56h0aOCvTHDpGzA9P2QxFXWKT8xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZTh6L8gVjXk4f0JVXnweynSSOVV9pRBgzzfgonmfZDquM8VGTPxM03WnvyFt5tPNgIo2ake9E8e6eZydDdMYAKv4yVvj+T0wsnPZvF6cMEN4fALwsWfxjClMGgE0YcrMPy0UoMUMUcPecWsVmsGeoE84VLI0iAbcPOuLHMOz5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=t8/PYxPE; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1741469870; bh=L3lm2pKDBhxfI+oBj9jTWq06myi7cTrg9V33m4Vwhw8=;
 b=t8/PYxPEosrBzJRdxRWG+r9dr+76n1PkRoU+6zL9WJQfKux2uhsSXQvEI19Vt0/aHsq9Hxx+I
 Pl89EVqVqT0n/YqqZnCdjKSBDUZfbBS3gsezoJRrJiLhqc3l1wMcYnJAsK1hzLjDUbYRTbc4wRC
 1MqjoKqPMHpOupegwU+RmZM+8WQe7tqiUD3s3KWG0kuU5qIWrT5JSFdH5O2qicRPUKKmB5rkrFR
 RFVIgy0JS5JnekRzeCUfPfrE9MLcvChXgrUWgMOJrGgfscwTJ9qFOVhGxcT4M255Bzi9NOQ13/A
 /CRURd/y0YjY/s0wTnMRU/3meC38/OP/+w6QgVQA4MLw==
X-Forward-Email-ID: 67ccb8a5bfe70eb1bfc13b47
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 3/3] net: stmmac: dwmac-rk: Remove unneeded GRF and peripheral GRF checks
Date: Sat,  8 Mar 2025 21:37:15 +0000
Message-ID: <20250308213720.2517944-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250308213720.2517944-1-jonas@kwiboo.se>
References: <20250308213720.2517944-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that GRF, and peripheral GRF where needed, is validated at probe
time there is no longer any need to check and log an error in each SoC
specific operation.

Remove unneeded IS_ERR() checks and early bail out from each SoC
specific operation.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- Split removal of IS_ERR() checks to its own patch
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 249 ------------------
 1 file changed, 249 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 5615f015c5fe..342463587d06 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -102,13 +102,6 @@ struct rk_priv_data {
 
 static void px30_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, PX30_GRF_GMAC_CON1,
 		     PX30_GMAC_PHY_INTF_SEL_RMII);
 }
@@ -182,13 +175,6 @@ static const struct rk_gmac_ops px30_ops = {
 static void rk3128_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RK3128_GRF_MAC_CON1,
 		     RK3128_GMAC_PHY_INTF_SEL_RGMII |
 		     RK3128_GMAC_RMII_MODE_CLR);
@@ -200,13 +186,6 @@ static void rk3128_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rk3128_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RK3128_GRF_MAC_CON1,
 		     RK3128_GMAC_PHY_INTF_SEL_RMII | RK3128_GMAC_RMII_MODE);
 }
@@ -215,11 +194,6 @@ static void rk3128_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	if (speed == 10)
 		regmap_write(bsp_priv->grf, RK3128_GRF_MAC_CON1,
 			     RK3128_GMAC_CLK_2_5M);
@@ -237,11 +211,6 @@ static void rk3128_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	if (speed == 10) {
 		regmap_write(bsp_priv->grf, RK3128_GRF_MAC_CON1,
 			     RK3128_GMAC_RMII_CLK_2_5M |
@@ -298,13 +267,6 @@ static const struct rk_gmac_ops rk3128_ops = {
 static void rk3228_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RK3228_GRF_MAC_CON1,
 		     RK3228_GMAC_PHY_INTF_SEL_RGMII |
 		     RK3228_GMAC_RMII_MODE_CLR |
@@ -317,13 +279,6 @@ static void rk3228_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rk3228_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RK3228_GRF_MAC_CON1,
 		     RK3228_GMAC_PHY_INTF_SEL_RMII |
 		     RK3228_GMAC_RMII_MODE);
@@ -336,11 +291,6 @@ static void rk3228_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	if (speed == 10)
 		regmap_write(bsp_priv->grf, RK3228_GRF_MAC_CON1,
 			     RK3228_GMAC_CLK_2_5M);
@@ -358,11 +308,6 @@ static void rk3228_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	if (speed == 10)
 		regmap_write(bsp_priv->grf, RK3228_GRF_MAC_CON1,
 			     RK3228_GMAC_RMII_CLK_2_5M |
@@ -420,13 +365,6 @@ static const struct rk_gmac_ops rk3228_ops = {
 static void rk3288_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RK3288_GRF_SOC_CON1,
 		     RK3288_GMAC_PHY_INTF_SEL_RGMII |
 		     RK3288_GMAC_RMII_MODE_CLR);
@@ -438,13 +376,6 @@ static void rk3288_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rk3288_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RK3288_GRF_SOC_CON1,
 		     RK3288_GMAC_PHY_INTF_SEL_RMII | RK3288_GMAC_RMII_MODE);
 }
@@ -453,11 +384,6 @@ static void rk3288_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	if (speed == 10)
 		regmap_write(bsp_priv->grf, RK3288_GRF_SOC_CON1,
 			     RK3288_GMAC_CLK_2_5M);
@@ -475,11 +401,6 @@ static void rk3288_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	if (speed == 10) {
 		regmap_write(bsp_priv->grf, RK3288_GRF_SOC_CON1,
 			     RK3288_GMAC_RMII_CLK_2_5M |
@@ -512,13 +433,6 @@ static const struct rk_gmac_ops rk3288_ops = {
 
 static void rk3308_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RK3308_GRF_MAC_CON0,
 		     RK3308_GMAC_PHY_INTF_SEL_RMII);
 }
@@ -527,11 +441,6 @@ static void rk3308_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	if (speed == 10) {
 		regmap_write(bsp_priv->grf, RK3308_GRF_MAC_CON0,
 			     RK3308_GMAC_SPEED_10M);
@@ -584,13 +493,6 @@ static const struct rk_gmac_ops rk3308_ops = {
 static void rk3328_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RK3328_GRF_MAC_CON1,
 		     RK3328_GMAC_PHY_INTF_SEL_RGMII |
 		     RK3328_GMAC_RMII_MODE_CLR |
@@ -604,14 +506,8 @@ static void rk3328_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rk3328_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
 	unsigned int reg;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	reg = bsp_priv->integrated_phy ? RK3328_GRF_MAC_CON2 :
 		  RK3328_GRF_MAC_CON1;
 
@@ -624,11 +520,6 @@ static void rk3328_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	if (speed == 10)
 		regmap_write(bsp_priv->grf, RK3328_GRF_MAC_CON1,
 			     RK3328_GMAC_CLK_2_5M);
@@ -647,11 +538,6 @@ static void rk3328_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 	struct device *dev = &bsp_priv->pdev->dev;
 	unsigned int reg;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	reg = bsp_priv->integrated_phy ? RK3328_GRF_MAC_CON2 :
 		  RK3328_GRF_MAC_CON1;
 
@@ -712,13 +598,6 @@ static const struct rk_gmac_ops rk3328_ops = {
 static void rk3366_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RK3366_GRF_SOC_CON6,
 		     RK3366_GMAC_PHY_INTF_SEL_RGMII |
 		     RK3366_GMAC_RMII_MODE_CLR);
@@ -730,13 +609,6 @@ static void rk3366_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rk3366_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RK3366_GRF_SOC_CON6,
 		     RK3366_GMAC_PHY_INTF_SEL_RMII | RK3366_GMAC_RMII_MODE);
 }
@@ -745,11 +617,6 @@ static void rk3366_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	if (speed == 10)
 		regmap_write(bsp_priv->grf, RK3366_GRF_SOC_CON6,
 			     RK3366_GMAC_CLK_2_5M);
@@ -767,11 +634,6 @@ static void rk3366_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	if (speed == 10) {
 		regmap_write(bsp_priv->grf, RK3366_GRF_SOC_CON6,
 			     RK3366_GMAC_RMII_CLK_2_5M |
@@ -823,13 +685,6 @@ static const struct rk_gmac_ops rk3366_ops = {
 static void rk3368_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RK3368_GRF_SOC_CON15,
 		     RK3368_GMAC_PHY_INTF_SEL_RGMII |
 		     RK3368_GMAC_RMII_MODE_CLR);
@@ -841,13 +696,6 @@ static void rk3368_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rk3368_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RK3368_GRF_SOC_CON15,
 		     RK3368_GMAC_PHY_INTF_SEL_RMII | RK3368_GMAC_RMII_MODE);
 }
@@ -856,11 +704,6 @@ static void rk3368_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	if (speed == 10)
 		regmap_write(bsp_priv->grf, RK3368_GRF_SOC_CON15,
 			     RK3368_GMAC_CLK_2_5M);
@@ -878,11 +721,6 @@ static void rk3368_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	if (speed == 10) {
 		regmap_write(bsp_priv->grf, RK3368_GRF_SOC_CON15,
 			     RK3368_GMAC_RMII_CLK_2_5M |
@@ -934,13 +772,6 @@ static const struct rk_gmac_ops rk3368_ops = {
 static void rk3399_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RK3399_GRF_SOC_CON5,
 		     RK3399_GMAC_PHY_INTF_SEL_RGMII |
 		     RK3399_GMAC_RMII_MODE_CLR);
@@ -952,13 +783,6 @@ static void rk3399_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rk3399_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RK3399_GRF_SOC_CON5,
 		     RK3399_GMAC_PHY_INTF_SEL_RMII | RK3399_GMAC_RMII_MODE);
 }
@@ -967,11 +791,6 @@ static void rk3399_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	if (speed == 10)
 		regmap_write(bsp_priv->grf, RK3399_GRF_SOC_CON5,
 			     RK3399_GMAC_CLK_2_5M);
@@ -989,11 +808,6 @@ static void rk3399_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	if (speed == 10) {
 		regmap_write(bsp_priv->grf, RK3399_GRF_SOC_CON5,
 			     RK3399_GMAC_RMII_CLK_2_5M |
@@ -1038,14 +852,8 @@ static const struct rk_gmac_ops rk3399_ops = {
 static void rk3568_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
 	u32 con0, con1;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	con0 = (bsp_priv->id == 1) ? RK3568_GRF_GMAC1_CON0 :
 				     RK3568_GRF_GMAC0_CON0;
 	con1 = (bsp_priv->id == 1) ? RK3568_GRF_GMAC1_CON1 :
@@ -1063,14 +871,8 @@ static void rk3568_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rk3568_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
 	u32 con1;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	con1 = (bsp_priv->id == 1) ? RK3568_GRF_GMAC1_CON1 :
 				     RK3568_GRF_GMAC0_CON1;
 	regmap_write(bsp_priv->grf, con1, RK3568_GMAC_PHY_INTF_SEL_RMII);
@@ -1148,14 +950,8 @@ static const struct rk_gmac_ops rk3568_ops = {
 static void rk3576_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
 	unsigned int offset_con;
 
-	if (IS_ERR(bsp_priv->grf) || IS_ERR(bsp_priv->php_grf)) {
-		dev_err(dev, "Missing rockchip,grf or rockchip,php-grf property\n");
-		return;
-	}
-
 	offset_con = bsp_priv->id == 1 ? RK3576_GRF_GMAC_CON1 :
 					 RK3576_GRF_GMAC_CON0;
 
@@ -1181,14 +977,8 @@ static void rk3576_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rk3576_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
 	unsigned int offset_con;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	offset_con = bsp_priv->id == 1 ? RK3576_GRF_GMAC_CON1 :
 					 RK3576_GRF_GMAC_CON0;
 
@@ -1308,14 +1098,8 @@ static const struct rk_gmac_ops rk3576_ops = {
 static void rk3588_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
 	u32 offset_con, id = bsp_priv->id;
 
-	if (IS_ERR(bsp_priv->grf) || IS_ERR(bsp_priv->php_grf)) {
-		dev_err(dev, "Missing rockchip,grf or rockchip,php_grf property\n");
-		return;
-	}
-
 	offset_con = bsp_priv->id == 1 ? RK3588_GRF_GMAC_CON9 :
 					 RK3588_GRF_GMAC_CON8;
 
@@ -1336,13 +1120,6 @@ static void rk3588_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rk3588_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->php_grf)) {
-		dev_err(dev, "%s: Missing rockchip,php_grf property\n", __func__);
-		return;
-	}
-
 	regmap_write(bsp_priv->php_grf, RK3588_GRF_GMAC_CON0,
 		     RK3588_GMAC_PHY_INTF_SEL_RMII(bsp_priv->id));
 
@@ -1426,13 +1203,6 @@ static const struct rk_gmac_ops rk3588_ops = {
 
 static void rv1108_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RV1108_GRF_GMAC_CON0,
 		     RV1108_GMAC_PHY_INTF_SEL_RMII);
 }
@@ -1441,11 +1211,6 @@ static void rv1108_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	if (speed == 10) {
 		regmap_write(bsp_priv->grf, RV1108_GRF_GMAC_CON0,
 			     RV1108_GMAC_RMII_CLK_2_5M |
@@ -1494,13 +1259,6 @@ static const struct rk_gmac_ops rv1108_ops = {
 static void rv1126_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RV1126_GRF_GMAC_CON0,
 		     RV1126_GMAC_PHY_INTF_SEL_RGMII |
 		     RV1126_GMAC_M0_RXCLK_DLY_ENABLE |
@@ -1519,13 +1277,6 @@ static void rv1126_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rv1126_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RV1126_GRF_GMAC_CON0,
 		     RV1126_GMAC_PHY_INTF_SEL_RMII);
 }
-- 
2.48.1


