Return-Path: <netdev+bounces-212583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8285B214EF
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 20:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8FF71A232BC
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A172E2DCA;
	Mon, 11 Aug 2025 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Cz8BBGgH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FAF2E2DCB
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 18:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754938334; cv=none; b=P0YehQaIK3fr750q3zKgPVsNFbFZ8LLvmGGpSCadFd4c/Ba+eXChE9LIvgzbGXyW77V71A60GVNssTxDipmhe1gaXSJJ6k6d8gxjHRj1DP9WGCrphvPdFtLAd8cJi2hiyBumr2CmmiSQTI5vFG5oy/bMOpxsaSBJseFbK1NVO74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754938334; c=relaxed/simple;
	bh=1LDFihwZEJPv560KLokJJ1T8x7weu50xQBegjCIPgDY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=cj7KVKpp+oJPMuROhAeptHyxQQLtzdlVMUUeLOVcEKisQ2jkJ/WeDs4Z+ds/v5MyHRUq43Fn+5ZifKAQ1UuxQRZlrXA09Dt/s0CqjfSDLyhuo/AkvB3eA6qzQ0RfNH5KyoTnjmdW7plNGLJAICzEoRu3JXBIpuY2OmqdiiluToo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Cz8BBGgH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kgCvgUS1eQnSBH48NMi+KNzNK1rq2y+DzfaY3NytqvA=; b=Cz8BBGgHAJHQ/tYQmz6RFf6SeJ
	eqNth5e0ze9DbEqG/ItbXMvwknOe49tawRBHWLORiEc0j0TMChfBwvOr6JFx3zv1SwAx6nB3baoZh
	495v7ulilMG6BfB8ntswfdT/4Qb8M6n9B1brUl4VbjbcdXeVqEMQG1X7/gAJBv0fXABD7+Vdb8n5y
	b6Uvy08vgvi0/iH53B6kW71ARvwIxEwgFj7D/ryWTf6QB8aYjU6J4MI99IBGt+HcAMoBhqT0W+tG1
	h2heG9sNlndj78WkQh+b9z+j3wM+6W0OZQpJ/42qENdebcmUUo/D/uK+TpYtHirSv0aVP06CT26F4
	yC+AtWMg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38358 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1ulXcl-0003c3-0l;
	Mon, 11 Aug 2025 19:51:59 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1ulXc2-008grB-9k; Mon, 11 Aug 2025 19:51:14 +0100
In-Reply-To: <aJo7kvoub5voHOUQ@shell.armlinux.org.uk>
References: <aJo7kvoub5voHOUQ@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 7/9] net: stmmac: rk: convert to suspend()/resume()
 methods
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ulXc2-008grB-9k@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 11 Aug 2025 19:51:14 +0100

Convert rk to use the new suspend() and resume() methods rather than
implementing these in custom wrappers around the main driver's
suspend/resume methods. This allows this driver to use the simmac
simple PM ops structure.

We can further simplify the driver as there is no need to track whether
the device was suspended, we only need to check whether the device is
wakeup capable in the resume method. This is because the resume method
will only be called after the suspend method.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 58 ++++++++-----------
 1 file changed, 25 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 79b92130a03f..ac8288301994 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -71,7 +71,6 @@ struct rk_priv_data {
 	phy_interface_t phy_iface;
 	int id;
 	struct regulator *regulator;
-	bool suspended;
 	const struct rk_gmac_ops *ops;
 
 	bool clk_enabled;
@@ -1706,6 +1705,28 @@ static int rk_set_clk_tx_rate(void *bsp_priv_, struct clk *clk_tx_i,
 	return -EINVAL;
 }
 
+static int rk_gmac_suspend(struct device *dev, void *bsp_priv_)
+{
+	struct rk_priv_data *bsp_priv = bsp_priv_;
+
+	/* Keep the PHY up if we use Wake-on-Lan. */
+	if (!device_may_wakeup(dev))
+		rk_gmac_powerdown(bsp_priv);
+
+	return 0;
+}
+
+static int rk_gmac_resume(struct device *dev, void *bsp_priv_)
+{
+	struct rk_priv_data *bsp_priv = bsp_priv_;
+
+	/* The PHY was up for Wake-on-Lan. */
+	if (!device_may_wakeup(dev))
+		rk_gmac_powerup(bsp_priv);
+
+	return 0;
+}
+
 static int rk_gmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
@@ -1738,6 +1759,8 @@ static int rk_gmac_probe(struct platform_device *pdev)
 
 	plat_dat->get_interfaces = rk_get_interfaces;
 	plat_dat->set_clk_tx_rate = rk_set_clk_tx_rate;
+	plat_dat->suspend = rk_gmac_suspend;
+	plat_dat->resume = rk_gmac_resume;
 
 	plat_dat->bsp_priv = rk_gmac_setup(pdev, plat_dat, data);
 	if (IS_ERR(plat_dat->bsp_priv))
@@ -1772,37 +1795,6 @@ static void rk_gmac_remove(struct platform_device *pdev)
 	rk_gmac_powerdown(bsp_priv);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int rk_gmac_suspend(struct device *dev)
-{
-	struct rk_priv_data *bsp_priv = get_stmmac_bsp_priv(dev);
-	int ret = stmmac_suspend(dev);
-
-	/* Keep the PHY up if we use Wake-on-Lan. */
-	if (!device_may_wakeup(dev)) {
-		rk_gmac_powerdown(bsp_priv);
-		bsp_priv->suspended = true;
-	}
-
-	return ret;
-}
-
-static int rk_gmac_resume(struct device *dev)
-{
-	struct rk_priv_data *bsp_priv = get_stmmac_bsp_priv(dev);
-
-	/* The PHY was up for Wake-on-Lan. */
-	if (bsp_priv->suspended) {
-		rk_gmac_powerup(bsp_priv);
-		bsp_priv->suspended = false;
-	}
-
-	return stmmac_resume(dev);
-}
-#endif /* CONFIG_PM_SLEEP */
-
-static SIMPLE_DEV_PM_OPS(rk_gmac_pm_ops, rk_gmac_suspend, rk_gmac_resume);
-
 static const struct of_device_id rk_gmac_dwmac_match[] = {
 	{ .compatible = "rockchip,px30-gmac",	.data = &px30_ops   },
 	{ .compatible = "rockchip,rk3128-gmac", .data = &rk3128_ops },
@@ -1828,7 +1820,7 @@ static struct platform_driver rk_gmac_dwmac_driver = {
 	.remove = rk_gmac_remove,
 	.driver = {
 		.name           = "rk_gmac-dwmac",
-		.pm		= &rk_gmac_pm_ops,
+		.pm		= &stmmac_simple_pm_ops,
 		.of_match_table = rk_gmac_dwmac_match,
 	},
 };
-- 
2.30.2


