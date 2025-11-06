Return-Path: <netdev+bounces-236287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CE0C3A889
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 596DF348F7F
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EE830DECB;
	Thu,  6 Nov 2025 11:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fD3K16jR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E5E305954
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428212; cv=none; b=aMk5MOzWlRVJgr6P3JRsXAoWJJvxXsuH+pR/I4QjFzMSexCfn5GxQYkCNle+hiHWSXh94z/WRzRG+VLoMose5SpQwitkNtniusosbU/vyTEEkbDdhnL07AYoF8+Mu1eSNppFrCSDsWhgrY3NLMhFcLv542Jzn/uKz+AbrIfOKhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428212; c=relaxed/simple;
	bh=6FOzw1BCRNPReCp3o/iiakMwSps/2VDDb+C2MAD1AVE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=IWsP0cc189slHRjYj5bVtRSq7DHOQDb0LCPF9kiM+E0hJvuy6u9ZB7x9Fa38TtTIxHu8mynY93VrstvuYG30Wj5bsoTMKculM8MGqs7THv486BxXfoRByFaKUK6flsIqwzQAz94DTKOQu320GZkBWAprgiHZmljHgckXDtjBRxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fD3K16jR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UbI1YBkNbkL1m3nH9wF/7sSHdhGhbNg4Qx8ET2/j3FI=; b=fD3K16jRRcrTp8UhND0cnnSVeo
	34NHVQlN4J0QmzSCMFE+yoGPJWwSY18YLL2EZZArFUocRnekA2QMmvMCrs+JWXdAX+tEPIMW/Eey3
	nsA6v9IC9kERa6a4KXcH5+ZLNoxBU1+2a69K2HxplK02WI8tjOZLMjNiHM21W+wOyfE91OV6+XaSV
	22ZRmrIKcDHFVKUCaHTzlpg3dTmz8qheBtcfCc8wErbyH/iDCJKnKqEn1DExUpteAmE604O4aPfQh
	a837y3CQHWHJdrz6XgXiKytpXIHTrY8FmUNvZTE8reRGMNyoMIsEd2Yjk205xCCUi/irp4Cz0Eluy
	eK7rpzDg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52982 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vGy5K-000000004uk-3Kvp;
	Thu, 06 Nov 2025 11:23:22 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vGy5J-0000000DhQD-46Ob;
	Thu, 06 Nov 2025 11:23:22 +0000
In-Reply-To: <aQyEs4DAZRWpAz32@shell.armlinux.org.uk>
References: <aQyEs4DAZRWpAz32@shell.armlinux.org.uk>
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
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH net-next 3/9] net: stmmac: lpc18xx: use
 stmmac_get_phy_intf_sel()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vGy5J-0000000DhQD-46Ob@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 06 Nov 2025 11:23:21 +0000

Use stmmac_get_phy_intf_sel() to decode the PHY interface mode to the
phy_intf_sel value, and use the result to program the ethernet mode.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
index 895d16dc0a4b..0f6be2a17e65 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
@@ -47,15 +47,14 @@ static int lpc18xx_dwmac_probe(struct platform_device *pdev)
 		return PTR_ERR(reg);
 	}
 
-	if (plat_dat->phy_interface == PHY_INTERFACE_MODE_MII) {
-		ethmode = PHY_INTF_SEL_GMII_MII;
-	} else if (plat_dat->phy_interface == PHY_INTERFACE_MODE_RMII) {
-		ethmode = PHY_INTF_SEL_RMII;
-	} else {
+	if (plat_dat->phy_interface != PHY_INTERFACE_MODE_MII &&
+	    plat_dat->phy_interface != PHY_INTERFACE_MODE_RMII) {
 		dev_err(&pdev->dev, "Only MII and RMII mode supported\n");
 		return -EINVAL;
 	}
 
+	ethmode = stmmac_get_phy_intf_sel(plat_dat->phy_interface);
+
 	regmap_update_bits(reg, LPC18XX_CREG_CREG6,
 			   LPC18XX_CREG_CREG6_ETHMODE_MASK, ethmode);
 
-- 
2.47.3


