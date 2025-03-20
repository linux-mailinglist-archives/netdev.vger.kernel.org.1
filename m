Return-Path: <netdev+bounces-176603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EA2A6B08B
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 23:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85FFF4A2E55
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 22:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6C222A4EB;
	Thu, 20 Mar 2025 22:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dPynrXQV"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707C922B8CF
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 22:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742508708; cv=none; b=suWSdaiz1KhIw/6Z9QlsTC7d5wokBqFkWZa//rIiU9kOOOSlCFf6H7IeZPQ3EZH/udnMfEIPYcv25uwa0qBZ+8/0JNVlQ8msg5aARsaL1s80cwv6N00J6/rPdy1k2fQyNVXq5bJEbl7tpdWp/QLJnk1MCpZTCJbKQ9ImK94lrLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742508708; c=relaxed/simple;
	bh=cYFWFZhSQx6dIi6CL0IO2pSHDv6OgurpSbyG0qojCmo=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=lAMPf7X8fqvcI2js2dKeUmaO7k8guxtyOJPQqIi5+fIpowWZI6MfzFNJw7g3gXTo46Du4S8LAOO4NYDezqZuVRI5M8G1RvM5PRf91iX+SmF8SuXN4jhoQT7OHrbKxR5N8G7M1k1yYNmNV3QeakPXTyt2HZze6WMHb1pSuuj3vl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dPynrXQV; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zFupyxRw5puB7rY+I+pSpWWinqc8yOvuXTzK677/+ko=; b=dPynrXQVBUh0EjRZA7HxfWyQtR
	WRKRPt7Q8mN0m1CGloIwWN5CB5VJkKlpI6uwLxiJlW6rAWVAMUQlPJbYpKA+xZclj6glqHhtozKES
	1EdwLJfnDNQB9GRA2pORTp4y+mDPp7N2jh2dUGU7UjKSy2lRFWSj9aKtpxo/Hl2j8MXXjIsHjq8za
	0dJzaL7Y7M29ab/QFiH0PpvtJ+hH9Zm7lvoW5YLJuuraPHfPtpL20TXhGRHjoLGAeA4enDKnH3kEP
	bGlQy8hQR3IxAEn5TXoNKEofQHI0nQ/IUUqGM8ML5yOgAc+IRs10Do+RWx3fXUgrsudcZzLQnE0Ho
	fSi6WbHA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60908 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tvO70-0008E5-0O;
	Thu, 20 Mar 2025 22:11:38 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tvO6f-008Vjn-J1; Thu, 20 Mar 2025 22:11:17 +0000
In-Reply-To: <Z9ySeo61VYTClIJJ@shell.armlinux.org.uk>
References: <Z9ySeo61VYTClIJJ@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 3/5] net: stmmac: socfpga: remove phy_resume() call
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tvO6f-008Vjn-J1@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 20 Mar 2025 22:11:17 +0000

As the previous commit addressed DWGMAC resuming with a PHY in
suspended state, there is now no need for socfpga to work around
this. Remove this code.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c    | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 6b78ae730466..116855658559 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -523,24 +523,6 @@ static int socfpga_dwmac_resume(struct device *dev)
 
 	dwmac_priv->ops->set_phy_mode(priv->plat->bsp_priv);
 
-	/* Before the enet controller is suspended, the phy is suspended.
-	 * This causes the phy clock to be gated. The enet controller is
-	 * resumed before the phy, so the clock is still gated "off" when
-	 * the enet controller is resumed. This code makes sure the phy
-	 * is "resumed" before reinitializing the enet controller since
-	 * the enet controller depends on an active phy clock to complete
-	 * a DMA reset. A DMA reset will "time out" if executed
-	 * with no phy clock input on the Synopsys enet controller.
-	 * Verified through Synopsys Case #8000711656.
-	 *
-	 * Note that the phy clock is also gated when the phy is isolated.
-	 * Phy "suspend" and "isolate" controls are located in phy basic
-	 * control register 0, and can be modified by the phy driver
-	 * framework.
-	 */
-	if (ndev->phydev)
-		phy_resume(ndev->phydev);
-
 	return stmmac_resume(dev);
 }
 #endif /* CONFIG_PM_SLEEP */
-- 
2.30.2


