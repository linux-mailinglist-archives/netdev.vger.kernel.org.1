Return-Path: <netdev+bounces-182895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00952A8A4AD
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 167327A62B4
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B34129A3D6;
	Tue, 15 Apr 2025 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="V/1KUVqN"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1069297A40
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744736018; cv=none; b=Po3s3Kt6ICdnY99S1ZcknAONno7GfzIyllC7xAu+PnPr870yOie/OwW47aFojQjZJqe6IbNfQ3s9+8io/rS9BoKnCXxS2/3IHaa/fEqSzzsodnQ0rklkajdp7fK0ZfmfyZJa3mX4BGPj8YC3LKarUoZ9Ns6KS9ubun5S3QTLdE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744736018; c=relaxed/simple;
	bh=IyoTweuH+lt9rGlc1YcepqOlfSAHB1hbpGD1P9RFycY=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=NDcPQxpKh8cnpqIVowU0UxeQon2+aFIj1/g5yAxvdNfOPZ1TKef5UuGm/n9hvqp1Ew+WG5L/PDZRjtjwhY1ENkVJHgM6oWRH4Z+0zlb/t1ofwuRF8E6UKDlCxhyDvsfyhKx2RiUYUHOE5NkWzW4qYkHVt0Xp2ztmPDU4p2HhfZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=V/1KUVqN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Z9uB0KYn8zVxro3kGLqgothoEUdhI7FT8dLFfsszWRQ=; b=V/1KUVqN5tyMZuWSwxLF+0Df7W
	8b4PwSDTdeIfZwJ4lm3NQl8NoGj/rIhOhxcXXlHJk9+xFZe0owlEXXTsvHVGATBVlTcYHau9r9cAl
	it5mzTTiFneTVqwlrrWN5h8iNn6sQAXkjVj3ZlYRu+bgb+OQcc7fex3W+I1tzZONMYV0HMwZkJE6j
	E++SwwuwSJOy2pLjeXtO6wkq6Ad0A9ZPKGWyQ8ATLiRpIVgEw5l0AOcH9Y4QUjEUzLBEaNntkJHFE
	4R4teUNIieB/WwOMW7ZEKiDvK8nvhn6fmxNMIBe76uklu407AmXFMoYqWM5076NWWqM7cMPa1FwUc
	unQhKPTw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42580 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u4jXK-00005z-0W;
	Tue, 15 Apr 2025 17:53:26 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u4jWi-000rJi-Rg; Tue, 15 Apr 2025 17:52:48 +0100
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
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: stmmac: visconti: convert to set_clk_tx_rate()
 method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u4jWi-000rJi-Rg@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 15 Apr 2025 17:52:48 +0100

Convert visconti to use the set_clk_tx_rate() method. By doing so,
the GMAC control register will already have been updated (unlike with
the fix_mac_speed() method) so this code can be removed while porting
to the set_clk_tx_rate() method.

There is also no need for the spinlock, and has never been - neither
fix_mac_speed() nor set_clk_tx_rate() can be called by more than one
thread at a time, so the lock does nothing useful.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac-visconti.c   | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
index e1de471b215c..2215aef3ef42 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
@@ -51,22 +51,16 @@ struct visconti_eth {
 	u32 phy_intf_sel;
 	struct clk *phy_ref_clk;
 	struct device *dev;
-	spinlock_t lock; /* lock to protect register update */
 };
 
-static void visconti_eth_fix_mac_speed(void *priv, int speed, unsigned int mode)
+static int visconti_eth_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
+					phy_interface_t interface, int speed)
 {
 	struct visconti_eth *dwmac = priv;
 	struct net_device *netdev = dev_get_drvdata(dwmac->dev);
 	unsigned int val, clk_sel_val = 0;
 	unsigned long flags;
 
-	spin_lock_irqsave(&dwmac->lock, flags);
-
-	/* adjust link */
-	val = readl(dwmac->reg + MAC_CTRL_REG);
-	val &= ~(GMAC_CONFIG_PS | GMAC_CONFIG_FES);
-
 	switch (speed) {
 	case SPEED_1000:
 		if (dwmac->phy_intf_sel == ETHER_CONFIG_INTF_RGMII)
@@ -89,12 +83,9 @@ static void visconti_eth_fix_mac_speed(void *priv, int speed, unsigned int mode)
 	default:
 		/* No bit control */
 		netdev_err(netdev, "Unsupported speed request (%d)", speed);
-		spin_unlock_irqrestore(&dwmac->lock, flags);
 		return;
 	}
 
-	writel(val, dwmac->reg + MAC_CTRL_REG);
-
 	/* Stop internal clock */
 	val = readl(dwmac->reg + REG_ETHER_CLOCK_SEL);
 	val &= ~(ETHER_CLK_SEL_RMII_CLK_EN | ETHER_CLK_SEL_RX_TX_CLK_EN);
@@ -136,7 +127,7 @@ static void visconti_eth_fix_mac_speed(void *priv, int speed, unsigned int mode)
 		break;
 	}
 
-	spin_unlock_irqrestore(&dwmac->lock, flags);
+	return 0;
 }
 
 static int visconti_eth_init_hw(struct platform_device *pdev, struct plat_stmmacenet_data *plat_dat)
@@ -228,7 +219,6 @@ static int visconti_eth_dwmac_probe(struct platform_device *pdev)
 	if (!dwmac)
 		return -ENOMEM;
 
-	spin_lock_init(&dwmac->lock);
 	dwmac->reg = stmmac_res.addr;
 	dwmac->dev = &pdev->dev;
 
@@ -237,7 +227,7 @@ static int visconti_eth_dwmac_probe(struct platform_device *pdev)
 	__set_bit(PHY_INTERFACE_MODE_RMII, plat_dat->supported_interfaces);
 
 	plat_dat->bsp_priv = dwmac;
-	plat_dat->fix_mac_speed = visconti_eth_fix_mac_speed;
+	plat_dat->set_clk_tx_rate = visconti_eth_set_clk_tx_rate;
 
 	ret = visconti_eth_clock_probe(pdev, plat_dat);
 	if (ret)
-- 
2.30.2


