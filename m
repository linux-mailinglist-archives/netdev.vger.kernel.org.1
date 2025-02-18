Return-Path: <netdev+bounces-167300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 992FDA39A75
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 12:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36D483B6ED4
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 11:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB5D240610;
	Tue, 18 Feb 2025 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uv9rtdpw"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34D8235348
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877326; cv=none; b=GK1BFc0zR1LESF9MWwAcQV7XFB7arHzzWW905e0jicVP2TF2AAo0d+LW1JklCbj6fM5RjEjB4PWwo4VLrCXjDhrsLFRsBUdpfQxL8sWIijDlpET8ZcGx2xf0F/KwxmEGXbCMFXXMOIVr2B+MBZnAn+K8RekoE1EpR2ah5BY20UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877326; c=relaxed/simple;
	bh=uFldTCxUA2semXSqYNSy/M5mFXhX3IZacV5YmHoJsnA=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=CE5xBXuu7Vc7I+tQ1GShWRkJzR5RKJFp1sGRFYOHN64rMhl826cRr6alD4RlM0PZgA2BZPJD1v466/iSET5U3u9D+5+kkUUNVfSmXDP1Dbjx9vHwJKfHs6C/t/T0yWVtfP1X9PvOrittx3lJ99RHY9BztfBULv7Vf1AqK2pbEcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=uv9rtdpw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2/XmkhtAV+FFIrfL1mhnGOI2K1euQozYUfSv7gmJ9co=; b=uv9rtdpwhiejEz7za9uMb8NeEP
	T8sqYCrF2FK1nOq2k3i69Zn4D9jcQdyiUoVFaDyDH341bsUxurlO34kwJY1kwsHEnGdbtsuuB380d
	10cJ0dc1cYBh7NFv9er7l+XjWCZG/Q+XdrQa7ImH/p78W2lMmb7Su3NFOispLhDG4odjaBvftIANj
	mQ2jsO4yfa5oJ3IHKNKonLXN8XrMwn33i/Df21BO/CqUrOvct1lxSk4IwOdVwmkyCZAz8VDB8O0rE
	fTA5/YCgmF7uyWGOqmTn6jth30rYvy2RLC4CeUzPjvUOxR11Jq+8Hnqf+XTXWywftyOFI7ovH+Ste
	7WaWUNdA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42754 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tkLZG-0001iW-1L;
	Tue, 18 Feb 2025 11:15:10 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tkLYv-004RZ7-Ot; Tue, 18 Feb 2025 11:14:49 +0000
In-Reply-To: <Z7RrnyER5ewy0f3T@shell.armlinux.org.uk>
References: <Z7RrnyER5ewy0f3T@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev,
	Inochi Amaoto <inochiama@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	netdev@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH RFC net-next 3/7] net: stmmac: dwc-qos-eth: use generic
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
Message-Id: <E1tkLYv-004RZ7-Ot@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 18 Feb 2025 11:14:49 +0000

Use the generic stmmac_set_clk_tx_rate() to configure the MAC transmit
clock.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index 392574bdd4a4..581c0b40db57 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -30,7 +30,6 @@ struct tegra_eqos {
 
 	struct reset_control *rst;
 	struct clk *clk_slave;
-	struct clk *clk_tx;
 
 	struct gpio_desc *reset;
 };
@@ -145,7 +144,6 @@ static void tegra_eqos_fix_speed(void *priv, int speed, unsigned int mode)
 {
 	struct tegra_eqos *eqos = priv;
 	bool needs_calibration = false;
-	long rate = 125000000;
 	u32 value;
 	int err;
 
@@ -156,7 +154,6 @@ static void tegra_eqos_fix_speed(void *priv, int speed, unsigned int mode)
 		fallthrough;
 
 	case SPEED_10:
-		rate = rgmii_clock(speed);
 		break;
 
 	default:
@@ -203,10 +200,6 @@ static void tegra_eqos_fix_speed(void *priv, int speed, unsigned int mode)
 		value &= ~AUTO_CAL_CONFIG_ENABLE;
 		writel(value, eqos->regs + AUTO_CAL_CONFIG);
 	}
-
-	err = clk_set_rate(eqos->clk_tx, rate);
-	if (err < 0)
-		dev_err(eqos->dev, "failed to set TX rate: %d\n", err);
 }
 
 static int tegra_eqos_init(struct platform_device *pdev, void *priv)
@@ -246,7 +239,7 @@ static int tegra_eqos_probe(struct platform_device *pdev,
 			eqos->clk_slave = data->clks[i].clk;
 			data->stmmac_clk = eqos->clk_slave;
 		} else if (strcmp(data->clks[i].id, "tx") == 0) {
-			eqos->clk_tx = data->clks[i].clk;
+			data->clk_tx_i = data->clks[i].clk;
 		}
 	}
 
@@ -282,6 +275,7 @@ static int tegra_eqos_probe(struct platform_device *pdev,
 
 bypass_clk_reset_gpio:
 	data->fix_mac_speed = tegra_eqos_fix_speed;
+	data->set_clk_tx_rate = stmmac_set_clk_tx_rate;
 	data->init = tegra_eqos_init;
 	data->bsp_priv = eqos;
 	data->flags |= STMMAC_FLAG_SPH_DISABLE;
-- 
2.30.2


