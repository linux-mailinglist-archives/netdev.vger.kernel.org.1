Return-Path: <netdev+bounces-182879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DF7A8A429
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8010189D0FB
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9ECD2797BB;
	Tue, 15 Apr 2025 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vaTzTQml"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D7228B4F0
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744734603; cv=none; b=AoYe6ynzJwQ6RWgWa2G3Y/Fett7jRwOkI6CmNxgPXpurSvG2f674txkEhCqFHBlKyj6zYwk97V9PdvQMZChas8UaTVG9+Q59+4TP8VhZptPA/nQ3emHsT49FzHGcuuxpIATySqNX2KJ82hvXKrGuZy64K2ddPfxPAQINjGmonEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744734603; c=relaxed/simple;
	bh=YPSszhs/kE3fPqBXZqWwcJ1Bzy1TsRsjmyQromLF4k4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Fu1tX466ON3E4cxBerSb2p3x0t6FAph4AEbQ8QJysIkvQoPVlTOFnqldJM14X8s1wRo8PhRChJqtfFeIly/01XOW99RdQfEm0Mp1HgiTHEgwm6MGrIJozKvDwjQBrss2ezRXCSbrrnzvggIH11bt776wSEwTPH8YTaLF4UyTKZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vaTzTQml; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VbzIJjZ9JRmtU3xRpmTgeptOfjJrc8wP+yXsF4MdjLc=; b=vaTzTQmlGrvz9jvjfnYtmU6Hbg
	UMzF/p1jwIgVwaNYN4vcUkRJVizqpXrSUDmm58qfsTwteGGWkaEh7b2IXsIiWq4fWb7dkReG6w3T5
	k0sAX88w3eDtxPJCsrP/glKNMswgtQmL78FV4i0eLS9ffXsS809KGc7Md02kz/XD+0AsYT5VhxNBu
	ZByRF3akn/aEBGK/QLwhngmpbIwy/TFyxPxn7MziEIKt40Nc46EZNyBXUVu/cePYwp+DQqQZtjhhF
	fhqm/SRcisbbJFfRTkCH+vtPGHXsEebXMlCoDK3EMF1FhbuRN/SBOfjvoVhaZb5tQRG9wVkcwPNcq
	zeReGIRw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47230 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u4jAY-0008Tn-1U;
	Tue, 15 Apr 2025 17:29:54 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u4j9w-000r1V-Ur; Tue, 15 Apr 2025 17:29:16 +0100
In-Reply-To: <Z_6JaPBiGu_RB4xN@shell.armlinux.org.uk>
References: <Z_6JaPBiGu_RB4xN@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 3/5] net: stmmac: socfpga: convert to
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
Message-Id: <E1u4j9w-000r1V-Ur@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 15 Apr 2025 17:29:16 +0100

Convert socfpga to use the generic stmmac_pltfr_pm_ops, which can be
achieved by adding an appropriate plat_dat->init function to do the
setup.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   | 39 +------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 000d349a6d4c..69ffc52c0275 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -493,6 +493,7 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 
 	plat_dat->bsp_priv = dwmac;
 	plat_dat->fix_mac_speed = socfpga_dwmac_fix_mac_speed;
+	plat_dat->init = socfpga_dwmac_init;
 	plat_dat->pcs_init = socfpga_dwmac_pcs_init;
 	plat_dat->pcs_exit = socfpga_dwmac_pcs_exit;
 	plat_dat->select_pcs = socfpga_dwmac_select_pcs;
@@ -516,42 +517,6 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	return ret;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int socfpga_dwmac_resume(struct device *dev)
-{
-	struct net_device *ndev = dev_get_drvdata(dev);
-	struct stmmac_priv *priv = netdev_priv(ndev);
-	struct socfpga_dwmac *dwmac_priv = get_stmmac_bsp_priv(dev);
-
-	socfpga_dwmac_init(to_platform_device(dev), dwmac_priv);
-
-	return stmmac_resume(dev);
-}
-#endif /* CONFIG_PM_SLEEP */
-
-static int __maybe_unused socfpga_dwmac_runtime_suspend(struct device *dev)
-{
-	struct net_device *ndev = dev_get_drvdata(dev);
-	struct stmmac_priv *priv = netdev_priv(ndev);
-
-	stmmac_bus_clks_config(priv, false);
-
-	return 0;
-}
-
-static int __maybe_unused socfpga_dwmac_runtime_resume(struct device *dev)
-{
-	struct net_device *ndev = dev_get_drvdata(dev);
-	struct stmmac_priv *priv = netdev_priv(ndev);
-
-	return stmmac_bus_clks_config(priv, true);
-}
-
-static const struct dev_pm_ops socfpga_dwmac_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(stmmac_suspend, socfpga_dwmac_resume)
-	SET_RUNTIME_PM_OPS(socfpga_dwmac_runtime_suspend, socfpga_dwmac_runtime_resume, NULL)
-};
-
 static const struct socfpga_dwmac_ops socfpga_gen5_ops = {
 	.set_phy_mode = socfpga_gen5_set_phy_mode,
 };
@@ -572,7 +537,7 @@ static struct platform_driver socfpga_dwmac_driver = {
 	.remove = stmmac_pltfr_remove,
 	.driver = {
 		.name           = "socfpga-dwmac",
-		.pm		= &socfpga_dwmac_pm_ops,
+		.pm		= &stmmac_pltfr_pm_ops,
 		.of_match_table = socfpga_dwmac_match,
 	},
 };
-- 
2.30.2


