Return-Path: <netdev+bounces-179857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D44A7EC33
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7756D447797
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D59725FA33;
	Mon,  7 Apr 2025 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1RecS8AL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F9125FA36
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 18:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051172; cv=none; b=ltN02A4nfHEtedZIKp0YiGnDEaFENez7b+Ud3LQk/FAavrRO5wQjZAdqGjF2NvEuSTj2oCfzx2jNNUX33dSGLV7eBAV/8p0sPi9agJ3V9PIJXD2CJhYzCu2KaDUOpmmbQKL44iBY3mhBWetAm8XYnmE+t8WrmRJq0fuF3HI2QWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051172; c=relaxed/simple;
	bh=yKujef+ptJklvSC1NtFpczdKZxTrS+rU4U8KRDa7V6Y=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=jP+LGl0qbnci6VUrGAez0DO3jGCaCOgyognyN/nAdCMBcsGBT2lQsUjJbSgZTEM1qQTyS0OiNr41y7UJxVkBxT6R4SvAhJdqAvJuJIAPJhOrh7StT13NAra8d2HsRGAtjDr5zCNI47fsqrH5dZ49e853CbxqPSUPYFO9LUDndog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1RecS8AL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9nhON7d7ilA53RmXCxpTrqwKr6s5RmBvqbzbh5d99wA=; b=1RecS8ALc+mHMxlJNcMSQQHhel
	f2nJLUB2XfwBYx7xtIafEm0jwHCAWMysXqJod4EiSGsZ1C6cl8o3vWsJdUJBrk3n0Ac08O5/rE9d7
	dUTLKvEBagPE5Sk7P9GzV89jhI1VFaempRJ+r7nQHzW8sgXSFFft4Lp4SSXjHidvJ0BEZS+TZm3sz
	PsL1GMKpraPZEZJw0Ro7lK7AQMlvYSfsZB+JV7yaPa+JvSqSt+X7Ol61IbNsm67sn1UpgNBv0cWFF
	SIfwnFe4UZWhb9SOsUayyJo6CHh38eCqhTU14A7jwz0uscgQicVDIrwdDudYg6aWg5INDFerzKYVo
	W4SFbtgw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37868 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u1rNR-0005rq-2x;
	Mon, 07 Apr 2025 19:39:21 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u1rMv-0013ON-TJ; Mon, 07 Apr 2025 19:38:49 +0100
In-Reply-To: <Z_Qbw0tZ2ktgBf7c@shell.armlinux.org.uk>
References: <Z_Qbw0tZ2ktgBf7c@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH net-next 2/2] net: stmmac: dwc-qos: use
 stmmac_pltfr_find_clk()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u1rMv-0013ON-TJ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 07 Apr 2025 19:38:49 +0100

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index cd431f84f34f..f5c68e3b4354 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -34,16 +34,6 @@ struct tegra_eqos {
 	struct gpio_desc *reset;
 };
 
-static struct clk *dwc_eth_find_clk(struct plat_stmmacenet_data *plat_dat,
-				    const char *name)
-{
-	for (int i = 0; i < plat_dat->num_clks; i++)
-		if (strcmp(plat_dat->clks[i].id, name) == 0)
-			return plat_dat->clks[i].clk;
-
-	return NULL;
-}
-
 static int dwc_eth_dwmac_config_dt(struct platform_device *pdev,
 				   struct plat_stmmacenet_data *plat_dat)
 {
@@ -132,7 +122,7 @@ static int dwc_qos_probe(struct platform_device *pdev,
 			 struct plat_stmmacenet_data *plat_dat,
 			 struct stmmac_resources *stmmac_res)
 {
-	plat_dat->pclk = dwc_eth_find_clk(plat_dat, "phy_ref_clk");
+	plat_dat->pclk = stmmac_pltfr_find_clk(plat_dat, "phy_ref_clk");
 
 	return 0;
 }
@@ -242,7 +232,7 @@ static int tegra_eqos_probe(struct platform_device *pdev,
 	if (!is_of_node(dev->fwnode))
 		goto bypass_clk_reset_gpio;
 
-	plat_dat->clk_tx_i = dwc_eth_find_clk(plat_dat, "tx");
+	plat_dat->clk_tx_i = stmmac_pltfr_find_clk(plat_dat, "tx");
 
 	eqos->reset = devm_gpiod_get(&pdev->dev, "phy-reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(eqos->reset)) {
-- 
2.30.2


