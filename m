Return-Path: <netdev+bounces-170167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB867A478DB
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 10:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC58188B355
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 09:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F25321E0BF;
	Thu, 27 Feb 2025 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="um/O8MtA"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4F822687C
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740647835; cv=none; b=ZMe5hGUz5vWVBI+iEvgpgtTWniJftFwYgrmcLQi4/9wwKcdZC9mKBmwOs5WOt/udhWcHB7qDirmAAXdWAAvXEQKl+I2djlQjaHxtsbhDlDCYkj2/X78dn2Ho9nuRZsRuotAiI2euqw5EjShLJPnH9UIOPCTrsDedSD+92+dv1EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740647835; c=relaxed/simple;
	bh=z49PLvmgXNGV1cRczdTakxBe8CKLzjJFPxb85sagh4o=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=dKEOmYQarSoRKbCdWzgl0DMT/KAEwpgob+2lZBAkzOpL+S9VseoWtyWgARKLFQC0sr6Lhn/7SwlSBo8ET2cOipcySU9jS4mqiHifNYH/jVCJyCX/SqB4s0tYzIv8N4USwlsXRF79URNehSi83pELlBCJE+UgwNp5TDE6iEUIwgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=um/O8MtA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=E+KYa1nF9rgBj7OxCXuLmQ8i8cj5XlLy3OJR2RsYgpw=; b=um/O8MtApsb4so1YWD2aOsqzOQ
	j8P9erdSesn82Q+HftJ0wMCZOClnoMS+zN9v6XG7rWqg8kQ3G95rfu5/gh0MK5Xhfn1UPA1CYq/IR
	NAFP/0VvhWibbzWea0IJEWEFCT2LRU/LCw/dnzq2a1KaCTEsqoNTNS0EgcLdxwxdDXmrfPrquhvmb
	GW+uiy+69Ez88x/zUJ/5TkIsj0F0bIWXnkv5MlH4l3wqlDrgTTO4gVSsgf+I2FgaRh1Y2rSPkAd0E
	wFnAAgtX5IzE5IEzAMOgU6qnisrnjRmCEQmazCzeWa9kGYpJ1xNjzrqUMlQ6DxGCnrygpbKwqYTzl
	/RBm/bsw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:45364 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tna0u-0006cX-2y;
	Thu, 27 Feb 2025 09:17:05 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tna0a-0052sq-59; Thu, 27 Feb 2025 09:16:44 +0000
In-Reply-To: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
References: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 05/11] net: stmmac: s32: use generic
 stmmac_set_clk_tx_rate()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tna0a-0052sq-59@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 27 Feb 2025 09:16:44 +0000

Use the generic stmmac_set_clk_tx_rate() to configure the MAC transmit
clock.

Reviewed-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-s32.c   | 22 +++----------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
index 6a498833b8ed..221539d760bc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
@@ -100,24 +100,6 @@ static void s32_gmac_exit(struct platform_device *pdev, void *priv)
 	clk_disable_unprepare(gmac->rx_clk);
 }
 
-static void s32_fix_mac_speed(void *priv, int speed, unsigned int mode)
-{
-	struct s32_priv_data *gmac = priv;
-	long tx_clk_rate;
-	int ret;
-
-	tx_clk_rate = rgmii_clock(speed);
-	if (tx_clk_rate < 0) {
-		dev_err(gmac->dev, "Unsupported/Invalid speed: %d\n", speed);
-		return;
-	}
-
-	dev_dbg(gmac->dev, "Set tx clock to %ld Hz\n", tx_clk_rate);
-	ret = clk_set_rate(gmac->tx_clk, tx_clk_rate);
-	if (ret)
-		dev_err(gmac->dev, "Can't set tx clock\n");
-}
-
 static int s32_dwmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat;
@@ -172,7 +154,9 @@ static int s32_dwmac_probe(struct platform_device *pdev)
 
 	plat->init = s32_gmac_init;
 	plat->exit = s32_gmac_exit;
-	plat->fix_mac_speed = s32_fix_mac_speed;
+
+	plat->clk_tx_i = gmac->tx_clk;
+	plat->set_clk_tx_rate = stmmac_set_clk_tx_rate;
 
 	plat->bsp_priv = gmac;
 
-- 
2.30.2


