Return-Path: <netdev+bounces-169088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE09A42861
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 17:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F801672FB
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 16:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87683263C72;
	Mon, 24 Feb 2025 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aYpPnCOz"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970021A0739
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416024; cv=none; b=b+O6xirlm8VjyXxzhfLa1cncV4ZEx1wq3ff+GrVxLahqSMQSYD3xoOmCxF1N8UgP414UlNkAZnkOYM8x+qTllzFjBy1I6IiCu0okGu/U2X+OEmTh1p68iqSL5k3lcpz9vaBaJf2B795jx9oT9T3BKoJ/LfmaKm8ntE3pjBFCm0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416024; c=relaxed/simple;
	bh=9fXk748hUuJg4q5FuoyflqOdH+uAH6tyyGjuSklhq7s=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Ds5tCBteZN9t9G/oBn9g74Ne5KdP4DhtGS/nAjxSa5UfoT3VlSJ9G0uNz4WgXFCY/Uea6dSX7SJwajyLbLpKO+BLS/w5WsXt04iKnR0DjfduhpyIZ9yPm5o4x45FKMIj1wAgBtOI3VtzM67qfowznSvqC6fe6g71hGC0vEunLU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=aYpPnCOz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=umYeIPet2tcZyz4GzEekGgRyYmU8ulrysbDkXqBk+Z8=; b=aYpPnCOzBaiW1h9FMViYsO37xl
	uAu9j110cWm/Xiq3L68vMVAL/DIQ+DgbH+Ai8s/Ke4BGIaXTgd01H+Tg0YhFLyrf7okYzaMstmIak
	bwtexRyX/keJy4Fd2U2+3Un/R7HvbQX6GbTfyIs9qDHK5NyBSJiHSv4xLzJnKZc7KcwEuvCWj1b4t
	RSFhlZUsTxvnG6tV9CAJclg6sBxk9uE6ZQ1+3RHN/0miGmM2UY6R+jjUQfn5EBSNWG+e0yAcHpqZi
	ycg5BJmJ5e/AhnaY5qTjU+/7yUYHJ1wTgLNsXV3to29zatZqDhT6QHK3GMsJ999r2LnAFdT68dvpe
	cX9BzIGw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36038 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tmbi3-00070W-2M;
	Mon, 24 Feb 2025 16:53:35 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tmbhj-004vSz-Pt; Mon, 24 Feb 2025 16:53:15 +0000
In-Reply-To: <Z7yj_BZa6yG02KcI@shell.armlinux.org.uk>
References: <Z7yj_BZa6yG02KcI@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v3 2/2] net: stmmac: dwc-qos: clean up clock
 initialisation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tmbhj-004vSz-Pt@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 24 Feb 2025 16:53:15 +0000

Clean up the clock initialisation by providing a helper to find a
named clock in the bulk clocks, and provide the name of the stmmac
clock in match data so we can locate the stmmac clock in generic
code.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../stmicro/stmmac/dwmac-dwc-qos-eth.c        | 33 +++++++++++--------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index acb0a2e1664f..6cadf24a575c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -35,6 +35,16 @@ struct tegra_eqos {
 	struct gpio_desc *reset;
 };
 
+static struct clk *dwc_eth_find_clk(struct plat_stmmacenet_data *plat_dat,
+				    const char *name)
+{
+	for (int i = 0; i < plat_dat->num_clks; i++)
+		if (strcmp(plat_dat->clks[i].id, name) == 0)
+			return plat_dat->clks[i].clk;
+
+	return NULL;
+}
+
 static int dwc_eth_dwmac_config_dt(struct platform_device *pdev,
 				   struct plat_stmmacenet_data *plat_dat)
 {
@@ -121,12 +131,7 @@ static int dwc_qos_probe(struct platform_device *pdev,
 			 struct plat_stmmacenet_data *plat_dat,
 			 struct stmmac_resources *stmmac_res)
 {
-	for (int i = 0; i < plat_dat->num_clks; i++) {
-		if (strcmp(plat_dat->clks[i].id, "apb_pclk") == 0)
-			plat_dat->stmmac_clk = plat_dat->clks[i].clk;
-		else if (strcmp(plat_dat->clks[i].id, "phy_ref_clk") == 0)
-			plat_dat->pclk = plat_dat->clks[i].clk;
-	}
+	plat_dat->pclk = dwc_eth_find_clk(plat_dat, "phy_ref_clk");
 
 	return 0;
 }
@@ -237,18 +242,12 @@ static int tegra_eqos_probe(struct platform_device *pdev,
 
 	eqos->dev = &pdev->dev;
 	eqos->regs = res->addr;
+	eqos->clk_slave = plat_dat->stmmac_clk;
 
 	if (!is_of_node(dev->fwnode))
 		goto bypass_clk_reset_gpio;
 
-	for (int i = 0; i < plat_dat->num_clks; i++) {
-		if (strcmp(plat_dat->clks[i].id, "slave_bus") == 0) {
-			eqos->clk_slave = plat_dat->clks[i].clk;
-			plat_dat->stmmac_clk = eqos->clk_slave;
-		} else if (strcmp(plat_dat->clks[i].id, "tx") == 0) {
-			eqos->clk_tx = plat_dat->clks[i].clk;
-		}
-	}
+	eqos->clk_tx = dwc_eth_find_clk(plat_dat, "tx");
 
 	eqos->reset = devm_gpiod_get(&pdev->dev, "phy-reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(eqos->reset)) {
@@ -312,15 +311,18 @@ struct dwc_eth_dwmac_data {
 		     struct plat_stmmacenet_data *plat_dat,
 		     struct stmmac_resources *res);
 	void (*remove)(struct platform_device *pdev);
+	const char *stmmac_clk_name;
 };
 
 static const struct dwc_eth_dwmac_data dwc_qos_data = {
 	.probe = dwc_qos_probe,
+	.stmmac_clk_name = "apb_pclk",
 };
 
 static const struct dwc_eth_dwmac_data tegra_eqos_data = {
 	.probe = tegra_eqos_probe,
 	.remove = tegra_eqos_remove,
+	.stmmac_clk_name = "slave_bus",
 };
 
 static int dwc_eth_dwmac_probe(struct platform_device *pdev)
@@ -360,6 +362,9 @@ static int dwc_eth_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "Failed to enable clocks\n");
 
+	plat_dat->stmmac_clk = dwc_eth_find_clk(plat_dat,
+						data->stmmac_clk_name);
+
 	ret = data->probe(pdev, plat_dat, &stmmac_res);
 	if (ret < 0) {
 		dev_err_probe(&pdev->dev, ret, "failed to probe subdriver\n");
-- 
2.30.2


