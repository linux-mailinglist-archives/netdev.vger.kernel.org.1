Return-Path: <netdev+bounces-180632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D580A81F4A
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 10:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6AB43ABBAC
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 08:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F358A25A638;
	Wed,  9 Apr 2025 08:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bfE9L77h"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF2725B67E
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744185787; cv=none; b=F2pX+nOmdtfampzD1CdwMnhsL/L9BJaTe41LJk/lpBfpjFWvOFt4MSWeN4EF9jY1tWmfVz6WEVH7btmmvXMDGWeJPsgd7AZ5niEPZOsKKHCRiidx45xosPpdgKtrfe17vNiitJwtDOnGJVYgMbZn8ptyN6eWfjtz2MsSkADdx2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744185787; c=relaxed/simple;
	bh=aeVrOHlFAPZgzI8fjMux7DsD9Vy0huBABrXUtUyypOE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=FYZD0m/iTIf8h94G+/HGn2T37cfP5Zyz1U7m1FNrNqfsvKKEjw/HqBJVN6z82YkcW6OivmYusj9UQ8k4hvOrTRtYumUjXjyRFKwlOQ8H268bT3hKR70RPAtGCRcpRXbsuor6klpaaLOMI3pNV9t0/GbLmpRhhz6LWnqTEzZXTDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bfE9L77h; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8/xV1cO2oXV+b6Bf/7SmXDB+ZKmv25NuBLYX/vUrYxc=; b=bfE9L77hrHJjWsg2AqAViMnX9S
	wwQqkHYlkwWowvtVlet1lLhxFkSHrLg3Et9ujnLIwKewuWLjiSpfBppTA3iuhEyc/JErOxBe/hICY
	/XE2gbvrCyqLxiW8mMlwD+oZIvurWpd4828MMpHQLnWaOQkDWE8DdaxuNmn7/PtsGG/pEj0vfCn2s
	77bqiSoh0iFcBFgyQQE1IadExhGiulwsLo8Bp0TLDxfOVscbA/UI6yocUG/SWciye7tO1aAqgJp64
	1AJVyZcR8+bF2FqRT/QxAfejVe8mAJFG/c9KWHHq1ykcxF1tb33y+Vd8sh6ldmVN0kLMuudt3P/ny
	sqnvG7bw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39196 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u2QOf-0000Cq-2h;
	Wed, 09 Apr 2025 09:02:57 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u2QO9-001Rp8-Ii; Wed, 09 Apr 2025 09:02:25 +0100
In-Reply-To: <Z_Yn3dJjzcOi32uU@shell.armlinux.org.uk>
References: <Z_Yn3dJjzcOi32uU@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v2 2/2] net: stmmac: dwc-qos: use
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
Message-Id: <E1u2QO9-001Rp8-Ii@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 09 Apr 2025 09:02:25 +0100

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../stmicro/stmmac/dwmac-dwc-qos-eth.c         | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index cd431f84f34f..5db318327d33 100644
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
@@ -362,8 +352,8 @@ static int dwc_eth_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "Failed to enable clocks\n");
 
-	plat_dat->stmmac_clk = dwc_eth_find_clk(plat_dat,
-						data->stmmac_clk_name);
+	plat_dat->stmmac_clk = stmmac_pltfr_find_clk(plat_dat,
+						     data->stmmac_clk_name);
 
 	if (data->probe)
 		ret = data->probe(pdev, plat_dat, &stmmac_res);
-- 
2.30.2


