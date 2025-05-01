Return-Path: <netdev+bounces-187231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F2EAA5DF4
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 13:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDAA31BC4D7E
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 11:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB099225396;
	Thu,  1 May 2025 11:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="oheLXXR5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EDE33086
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746099958; cv=none; b=KmHddIlWfG+jCDiTD0eAXK2os6Ak+2/xiOOE3tPUH6hfTwslhuaedaCbWfkRL3gjNA9Sc3iisbWFYO4B8WIx75JyIoZdv3XlW2aX4Adr4+N9siceJMq5uEQ2jCgN3NeJK5sdQyDZSgE63Xw+P+h5PrKt5SuMQveG7KZDFbpSvUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746099958; c=relaxed/simple;
	bh=s1Hn1iumNKiWv8AZ91RErnNaCMFolyIlfyuDInn56Ak=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Cc4ilfIX97G28ux01m/loZFiOM1W+A34FeeSjViKSNpcq/+t/RmeSB3ASyJD7sZrMfcGf+NlyjHh8nByN8ajxdMkkOUN4WJuarwmCk3b5AkmzFvDnsDYlCNnV0qTcqcfsdHINhuGACbQN1V/UjDd3aXWjT086S+AoPhjvHceRx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=oheLXXR5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=y2NzlMux4LrqC/vPkr6or5eWcOWLuQXUxiLC+yJIl8I=; b=oheLXXR5lGWOjntwJ41mwnesps
	+hVg0vxSx3kC3VSHIMVsNlulhX3Jxnd7v/LE6oiJDZiOkg2qzBwkbd/k075b/Gfijz5hqnDOUrCUr
	HqiatDSeZrnLTQur8k0gU6knMFpVloA9HPhtBavKVFIf97/ZD6+mqEGfcnRWWipShqdZZ/7bVtmhn
	p9Q1GuKcxMtg1kEZYm+x0wd2IwGfNnoUovDqiM0e8w7EwR2EKxFHSU55qCd7xvIujcWEsbpx372DT
	gtPSzvCxr0hOr1MjpQ5oXOUfdN368z6lxoTtaeZ+7VpkoQJOMmG1p2pBPZheFAnkALBMZiZ59Aj9V
	XPkTcPfA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59436 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uASMK-000050-2M;
	Thu, 01 May 2025 12:45:44 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uASLi-0021QX-HG; Thu, 01 May 2025 12:45:06 +0100
In-Reply-To: <aBNe0Vt81vmqVCma@shell.armlinux.org.uk>
References: <aBNe0Vt81vmqVCma@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 2/6] net: stmmac: use priv->plat->phy_interface
 directly
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uASLi-0021QX-HG@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 01 May 2025 12:45:06 +0100

Avoid using a local variable for priv->plat->phy_interface as this
may be modified in the .get_interfaces() method added in a future
commit.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index fe7f9e3a92a5..ac6ab121eb33 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1258,7 +1258,6 @@ static int stmmac_init_phy(struct net_device *dev)
 static int stmmac_phy_setup(struct stmmac_priv *priv)
 {
 	struct stmmac_mdio_bus_data *mdio_bus_data;
-	int mode = priv->plat->phy_interface;
 	struct phylink_config *config;
 	struct fwnode_handle *fwnode;
 	struct phylink_pcs *pcs;
@@ -1287,7 +1286,7 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 	/* Set the platform/firmware specified interface mode. Note, phylink
 	 * deals with the PHY interface mode, not the MAC interface mode.
 	 */
-	__set_bit(mode, config->supported_interfaces);
+	__set_bit(priv->plat->phy_interface, config->supported_interfaces);
 
 	/* If we have an xpcs, it defines which PHY interfaces are supported. */
 	if (priv->hw->xpcs)
@@ -1315,7 +1314,8 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 	if (!fwnode)
 		fwnode = dev_fwnode(priv->device);
 
-	phylink = phylink_create(config, fwnode, mode, &stmmac_phylink_mac_ops);
+	phylink = phylink_create(config, fwnode, priv->plat->phy_interface,
+				 &stmmac_phylink_mac_ops);
 	if (IS_ERR(phylink))
 		return PTR_ERR(phylink);
 
-- 
2.30.2


