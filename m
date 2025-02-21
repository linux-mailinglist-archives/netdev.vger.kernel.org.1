Return-Path: <netdev+bounces-168508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647CEA3F317
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 12:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E4DE171457
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 11:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D499E20898C;
	Fri, 21 Feb 2025 11:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GDinz2Zq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D539E208965
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 11:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740137940; cv=none; b=MxmMJSzQAciWFE5L9gU6UUnxX1vwn2egVoWO3Syq7+kIAS4D7ZqUxqcy9KiyogPj7m4F31pUEfeQySeRIxQN6X7Ul5bspa8ItKo6Y1wBzoRYM3ZT9MUjO7+6sOXt8EnmcCqAB6uyyJ+xcioB42pDDgP+UZdGa7O6Bp9N2qNwlIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740137940; c=relaxed/simple;
	bh=Q5C9jZ75/J4LVn1spUgkX1rO5finnriKgEaNk1n8gB0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=Je7IorjrSJy6pvtFABssFPxF7Wig3qzSlOvv9BMF5jQv/9XOKzpNsM24uKCxsgP/lJQAyB/5tqC0lKk2n+NdqCYH4FQJ/q01T3utWr0/LSd6YOcovDrRWkgXuVItmT/FHJeo4ZKmtM7IXEX5zAx/4Oop6zcTllyRTy1A4sNDbTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=GDinz2Zq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ubcFVw06F0SKzsJM+Oly32EtkAMHW1V2VY1dtGf6Alk=; b=GDinz2ZqhbKxZ7xTfoyg7eURJ5
	SwOazIMBpniKA2cButKSocN5EZvGiEwiq4h8n+KUQiO7cF0fw8UE8j4q1CMPaluCdSBDORArxrDdn
	jIS5wfETvNOhAoekSOUV+RqiFv5sa1vCyru2vWfriOUjxBQjoG18rUWrXGaPhaHNdZAfKnw56VNKF
	nsRMSvl+hk6YE1ywQAyCDu1jcbhuUMK0X92lkygkwuNUb7VEXMArWWp1zr1wcTeCY1bxs53/hNI5g
	TEcgsgQYhrqo4rveuK9XTv73cnLVLpOVs/bdX7lEpWLZPnVtSdxS3YsyrFFOoT13r1zSElx0iFF3x
	jM46SR0w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33920 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tlRMj-0004Pv-2i;
	Fri, 21 Feb 2025 11:38:45 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tlRMP-004Vt5-W1; Fri, 21 Feb 2025 11:38:26 +0000
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
Subject: [PATCH net-next] net: stmmac: dwc-qos: clean up clock initialisation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tlRMP-004Vt5-W1@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 21 Feb 2025 11:38:25 +0000

Clean up the clock initialisation by providing a helper to find a
named clock in the bulk clocks, and provide the name of the stmmac
clock in match data so we can locate the stmmac clock in generic
code.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
dwc_eth_find_clk() should probably become a generic helper given that
plat_dat->clks is part of the core platform support code, but that
can be done later when converting more drivers - which I will get
around to once I've got the set_clk_tx_rate() patch series out that
someone else needs to make progress.

 .../stmicro/stmmac/dwmac-dwc-qos-eth.c        | 32 +++++++++++--------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index 392574bdd4a4..9e2035d1fb86 100644
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
+	return 0;
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
+	eqos->clk_slave = data->stmmac_clk;
 
 	if (!is_of_node(dev->fwnode))
 		goto bypass_clk_reset_gpio;
 
-	for (int i = 0; i < data->num_clks; i++) {
-		if (strcmp(data->clks[i].id, "slave_bus") == 0) {
-			eqos->clk_slave = data->clks[i].clk;
-			data->stmmac_clk = eqos->clk_slave;
-		} else if (strcmp(data->clks[i].id, "tx") == 0) {
-			eqos->clk_tx = data->clks[i].clk;
-		}
-	}
+	eqos->clk_tx = dwc_eth_find_clk(data, "tx");
 
 	eqos->reset = devm_gpiod_get(&pdev->dev, "phy-reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(eqos->reset)) {
@@ -312,15 +311,18 @@ struct dwc_eth_dwmac_data {
 		     struct plat_stmmacenet_data *data,
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
@@ -360,6 +362,8 @@ static int dwc_eth_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "Failed to enable clocks\n");
 
+	data->stmmac_clk = dwc_eth_find_clk(plat_dat, data->stmmac_clk_name);
+
 	ret = data->probe(pdev, plat_dat, &stmmac_res);
 	if (ret < 0) {
 		dev_err_probe(&pdev->dev, ret, "failed to probe subdriver\n");
-- 
2.30.2


