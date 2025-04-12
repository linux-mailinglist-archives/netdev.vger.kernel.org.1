Return-Path: <netdev+bounces-181877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AE2A86BC8
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 10:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B477D8A7A31
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 08:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E242B19ABC3;
	Sat, 12 Apr 2025 08:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="svstFTNk"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A99199238
	for <netdev@vger.kernel.org>; Sat, 12 Apr 2025 08:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744445359; cv=none; b=qIsyuOmblL5Vsgfsd702/7nfnqHLKOTk1W+AFgNkOojhYISJB1IRm8AptfMeGGNnrR3yBzh40UmmDnRRiimKBved8IPwSeWU+S4cVEONgBdFe547bAmfdf0ypFdxE0tiLt3JRoxE2c/x7mytypW+5P4JwNA0E54K8iif/ZUwiik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744445359; c=relaxed/simple;
	bh=yJi/Mc1NOpNjJ/MeGCoCFFVncbkLTl/GbrWDve+FX6g=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=g7qxlgLLQ3wkVaqX7BXXXWdHd829ub9TdMykcEC+sDqqJxMWOxgMH9vTIla53vr9f9Y1xHsUTQmeVVR9WZRaSnQ4kVUXIAPSWBtCDtv415g9X4UwP9/Hc6bTWUzYc6tVdxHfS8CNvqFRWDI4ZupZhycSa2/0gvuDZ4tzjTRl0n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=svstFTNk; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=T1Mb38BSjKzMqPH9UJFq9q1axHklKlcNwBEoVhdqgOg=; b=svstFTNkQmymYuNbmb76DKR8jj
	KUdMC1U5AIo8ggJDqlkxWgF8MmMloTAw9Rzm1U0GNtI51U2Y5Lc77sTzdLArj+gWXWdvkHSvfM0Ep
	GAP9VQreSQzh4XPLpyCaE68mGNS0s04QQgNt1lQjW+Dn5u7mxT5al2xfmOPMnsgv7qc4jlaThT8Pt
	LhX4CCwntotIoCWeFMs5nctO+wupOvLJT240wxFuIBCWjttTpFT+BMWbddIvRd8MY4A1ZuUvuUCGg
	esQZ03zHo54z2NLRZniWYXZggO/se9cEJKrpJx4i+AW64mgzYCgfIvIF+hEB6Pu3cpPd2yxIVMJeE
	W+zDC5qQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:45140 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u3VvH-0004Lt-0f;
	Sat, 12 Apr 2025 09:09:07 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u3Vuf-000E7g-U4; Sat, 12 Apr 2025 09:08:29 +0100
In-Reply-To: <Z_oe0U5E0i3uZbop@shell.armlinux.org.uk>
References: <Z_oe0U5E0i3uZbop@shell.armlinux.org.uk>
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
	Philipp Zabel <p.zabel@pengutronix.de>,
	Richard Cochran <richardcochran@gmail.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH net-next v2 1/5] net: stmmac: dwc-qos: remove
 tegra_eqos_init()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u3Vuf-000E7g-U4@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sat, 12 Apr 2025 09:08:29 +0100

tegra_eqos_init() initialises the 1US TIC counter for the EEE timers.
However, the DWGMAC core is reset after this write, which clears
this register to its default.

However, dwmac4_core_init() configures this register using the same
clock, which happens after reset - thus this is the write which
ensures that the register is correctly configured.

Therefore, tegra_eqos_init() is not required and is removed. This also
means eqos->clk_slave can also be removed.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../stmicro/stmmac/dwmac-dwc-qos-eth.c        | 24 +------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index 5db318327d33..583b5c071cd1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -29,7 +29,6 @@ struct tegra_eqos {
 	void __iomem *regs;
 
 	struct reset_control *rst;
-	struct clk *clk_slave;
 
 	struct gpio_desc *reset;
 };
@@ -199,20 +198,6 @@ static void tegra_eqos_fix_speed(void *priv, int speed, unsigned int mode)
 	}
 }
 
-static int tegra_eqos_init(struct platform_device *pdev, void *priv)
-{
-	struct tegra_eqos *eqos = priv;
-	unsigned long rate;
-	u32 value;
-
-	rate = clk_get_rate(eqos->clk_slave);
-
-	value = (rate / 1000000) - 1;
-	writel(value, eqos->regs + GMAC_1US_TIC_COUNTER);
-
-	return 0;
-}
-
 static int tegra_eqos_probe(struct platform_device *pdev,
 			    struct plat_stmmacenet_data *plat_dat,
 			    struct stmmac_resources *res)
@@ -227,7 +212,6 @@ static int tegra_eqos_probe(struct platform_device *pdev,
 
 	eqos->dev = &pdev->dev;
 	eqos->regs = res->addr;
-	eqos->clk_slave = plat_dat->stmmac_clk;
 
 	if (!is_of_node(dev->fwnode))
 		goto bypass_clk_reset_gpio;
@@ -267,17 +251,11 @@ static int tegra_eqos_probe(struct platform_device *pdev,
 bypass_clk_reset_gpio:
 	plat_dat->fix_mac_speed = tegra_eqos_fix_speed;
 	plat_dat->set_clk_tx_rate = stmmac_set_clk_tx_rate;
-	plat_dat->init = tegra_eqos_init;
 	plat_dat->bsp_priv = eqos;
 	plat_dat->flags |= STMMAC_FLAG_SPH_DISABLE;
 
-	err = tegra_eqos_init(pdev, eqos);
-	if (err < 0)
-		goto reset;
-
 	return 0;
-reset:
-	reset_control_assert(eqos->rst);
+
 reset_phy:
 	gpiod_set_value(eqos->reset, 1);
 
-- 
2.30.2


