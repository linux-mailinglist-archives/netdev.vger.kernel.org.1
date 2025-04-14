Return-Path: <netdev+bounces-182318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EA7A887C8
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B243A6A92
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C4D2749EE;
	Mon, 14 Apr 2025 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qhVjvgGH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456B027587A
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744645907; cv=none; b=ft13R3jYrs6Z8M9nlKlNlWPKkGjYtQHhD9TO5XexRFl1rjnsKVsTKqQqfBjiKBqLEueTa360VJozno/i4rsrGeNeR3DpLwH1R2Zv67Vt0UrkbKwdMRiNQ6Is/VpnIQQGL+N43zR5MaKIb/+PBTOJXTNZ9N5pZ8+eILRc665CxtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744645907; c=relaxed/simple;
	bh=2cZPejoIQoNL32ew56Y0kWUTAzWy+CnAbFozLOThkOw=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ZfmKKfPx12llIdMDdZPFkJPA/jjwFZmKmrCsEEo+7LK3yIZZhMsdw9tpuxqRyFsembykYxrzTnxywUlDnSfo2QCLTymRnjlR9Bvb19Eym7LuujB03Ru3Ry71ewabN0BYySbNVpOaq3aE8goZephkWjZowAzlV0jbDYuF83fUtbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qhVjvgGH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bbXV7Jz6WVrITK8Rs8Q4HW4Bd6iCFtQ/awDMcDecl1w=; b=qhVjvgGHXjNDAvZ4HJXz0AbBNl
	RiHSjoIDbWdlCw2DVdJuC04xFJXIbLimHZTYMOp3IB1Acqtyl2KkqQPeT2uSyT10Rm/djAuowFmQ3
	peHZeVjM2K9bVfAQVmq/NFO7/9lAdYr5iEGgjgNYf4i9VOoeIkDDIVfOsV1tifk64oQIij1sbnH2d
	4XhoWlUlJ7hx86y4A0QUQM9WSKfhJtYEuLke63itNtl/mxQFggZ0Jiu0G2OqfNEpkxNrkZcn2WzuT
	Cm0A9riejTsK3Vg2+eqxL6AW/5ib6InnZfMZa6ECE/olhIrDVDUM0qZdSQTMFi7HX1uBJfd21TLRK
	YLZDWqOw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47054 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u4M5y-0006o9-1L;
	Mon, 14 Apr 2025 16:51:38 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u4M5N-000YGD-5i; Mon, 14 Apr 2025 16:51:01 +0100
In-Reply-To: <Z_0u9pA0Ziop-BuU@shell.armlinux.org.uk>
References: <Z_0u9pA0Ziop-BuU@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 1/2] net: stmmac: ingenic: convert to
 stmmac_pltfr_pm_ops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u4M5N-000YGD-5i@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 14 Apr 2025 16:51:01 +0100

Convert the Ingenic glue driver to use the generic stmmac platform
power management operations.

In order to do this, we need to make ingenic_mac_init() arguments
compatible with plat_dat->init() by adding a plat_dat member to struct
ingenic_mac. This allows the custom suspend/resume operations to be
removed, and the PM ops pointer replaced with stmmac_pltfr_pm_ops.

This will adds runtime PM and noirq suspend/resume ops to this driver.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac-ingenic.c   | 41 ++++---------------
 1 file changed, 8 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
index 066783d66422..607e467324a4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
@@ -56,6 +56,7 @@ enum ingenic_mac_version {
 
 struct ingenic_mac {
 	const struct ingenic_soc_info *soc_info;
+	struct plat_stmmacenet_data *plat_dat;
 	struct device *dev;
 	struct regmap *regmap;
 
@@ -70,13 +71,13 @@ struct ingenic_soc_info {
 	int (*set_mode)(struct plat_stmmacenet_data *plat_dat);
 };
 
-static int ingenic_mac_init(struct plat_stmmacenet_data *plat_dat)
+static int ingenic_mac_init(struct platform_device *pdev, void *bsp_priv)
 {
-	struct ingenic_mac *mac = plat_dat->bsp_priv;
+	struct ingenic_mac *mac = bsp_priv;
 	int ret;
 
 	if (mac->soc_info->set_mode) {
-		ret = mac->soc_info->set_mode(plat_dat);
+		ret = mac->soc_info->set_mode(mac->plat_dat);
 		if (ret)
 			return ret;
 	}
@@ -284,44 +285,18 @@ static int ingenic_mac_probe(struct platform_device *pdev)
 
 	mac->soc_info = data;
 	mac->dev = &pdev->dev;
+	mac->plat_dat = plat_dat;
 
 	plat_dat->bsp_priv = mac;
+	plat_dat->init = ingenic_mac_init;
 
-	ret = ingenic_mac_init(plat_dat);
+	ret = ingenic_mac_init(pdev, mac);
 	if (ret)
 		return ret;
 
 	return stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int ingenic_mac_suspend(struct device *dev)
-{
-	int ret;
-
-	ret = stmmac_suspend(dev);
-
-	return ret;
-}
-
-static int ingenic_mac_resume(struct device *dev)
-{
-	struct net_device *ndev = dev_get_drvdata(dev);
-	struct stmmac_priv *priv = netdev_priv(ndev);
-	int ret;
-
-	ret = ingenic_mac_init(priv->plat);
-	if (ret)
-		return ret;
-
-	ret = stmmac_resume(dev);
-
-	return ret;
-}
-#endif /* CONFIG_PM_SLEEP */
-
-static SIMPLE_DEV_PM_OPS(ingenic_mac_pm_ops, ingenic_mac_suspend, ingenic_mac_resume);
-
 static struct ingenic_soc_info jz4775_soc_info = {
 	.version = ID_JZ4775,
 	.mask = MACPHYC_TXCLK_SEL_MASK | MACPHYC_SOFT_RST_MASK | MACPHYC_PHY_INFT_MASK,
@@ -373,7 +348,7 @@ static struct platform_driver ingenic_mac_driver = {
 	.remove		= stmmac_pltfr_remove,
 	.driver		= {
 		.name	= "ingenic-mac",
-		.pm		= pm_ptr(&ingenic_mac_pm_ops),
+		.pm		= &stmmac_pltfr_pm_ops,
 		.of_match_table = ingenic_mac_of_matches,
 	},
 };
-- 
2.30.2


