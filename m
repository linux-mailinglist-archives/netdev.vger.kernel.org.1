Return-Path: <netdev+bounces-226988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E1EBA6C92
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 11:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 848F53A9137
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 09:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02832C15A2;
	Sun, 28 Sep 2025 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DqgYUnER"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CC32BEFF8;
	Sun, 28 Sep 2025 08:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759049979; cv=none; b=vBIK5tdYR3dqbWB5KKpGQuPeDstoK25gvVcbvQWkzh4GnHthYADzSUL4Q2IOs+0Bex70iP3lMZ17A+BeB406IXes7QyODufBGVxc0L7aXcZZVHihyi89klt3RiV4KF8OP68X1scG/brygjAQvg24jTvbFuyA/GUAVi9v3vX0z+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759049979; c=relaxed/simple;
	bh=4vniLi8C9goigp8i7K2za5WqcBRykgM+uRE16WVj3ZY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=CPL6ijtFrLIh9i2F9CLdmHg195Dr4LC5h2RvvifoQkbqzj5GvhQSYTvFs/UPyo5p/3qXxD1nIGpwJ8KCmgoU1E8q7iMYxmLQ/yEqDTdt4Z9JUs9JMPvq2k+7FhduVSmkTgGky4PqV9xgSSFJ5P0hdbsuoqa0nLSa+BjYUuKF7NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DqgYUnER; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=g1oVnAqIRynEdvtoz62JGVAuoit/j3pFYMM2fpFBQec=; b=DqgYUnERY07W98n11vJicdqk2c
	go4P3eNuR4PhwpX9UriGbqN914adWhCxKX1xklzqxcuTc4WmC5k02LkVbwLSVp54/6p8645fclIJn
	vueeOYLqex3ojNdfYWAuFARcfeBNOWUVCfQLP6Q2RSygJEgzcmt3+9I5f+SfaroLxbOhYpFRqa4i7
	wpGNXMxzMSWFf3888PzzEy89aR38G61KzonQZNpJ/aIXPbJO+M47tOWIvUPRUyLG1o8CPZhZKvjga
	Sg74MoNL7UDBbccqR6Xv+4k7MPU3ZshqYrn3D7T8YbGTE7ovXzAYVZ1IntRvaAC2zvvbmiGXor5cC
	kTqK31iA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:40264 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1v2nFd-000000005Bv-3hCj;
	Sun, 28 Sep 2025 09:59:26 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1v2nFX-00000007jXn-2pUD;
	Sun, 28 Sep 2025 09:59:19 +0100
In-Reply-To: <aNj4HY_mk4JDsD_D@shell.armlinux.org.uk>
References: <aNj4HY_mk4JDsD_D@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	 Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Tristram Ha <Tristram.Ha@microchip.com>
Subject: [PATCH RFC net-next 6/6] net: stmmac: convert to phylink managed WoL
 PHY speed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1v2nFX-00000007jXn-2pUD@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 28 Sep 2025 09:59:19 +0100

Convert stmmac to use phylink's management of the PHY speed when
Wake-on-Lan is enabled.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  5 -----
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c  |  7 +------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 15 +--------------
 3 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index db4f82672d9a..d10da13ad645 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -376,11 +376,6 @@ enum stmmac_state {
 
 extern const struct dev_pm_ops stmmac_simple_pm_ops;
 
-static inline bool stmmac_wol_enabled_phy(struct stmmac_priv *priv)
-{
-	return !priv->plat->pmt && device_may_wakeup(priv->device);
-}
-
 int stmmac_mdio_unregister(struct net_device *ndev);
 int stmmac_mdio_register(struct net_device *ndev);
 int stmmac_mdio_reset(struct mii_bus *mii);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index fd29b551a082..7ab736de308f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -793,13 +793,8 @@ static void stmmac_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 static int stmmac_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
-	int ret;
 
-	ret = phylink_ethtool_set_wol(priv->phylink, wol);
-	if (!ret)
-		device_set_wakeup_enable(priv->device, !!wol->wolopts);
-
-	return ret;
+	return phylink_ethtool_set_wol(priv->phylink, wol);
 }
 
 static int stmmac_ethtool_op_get_eee(struct net_device *dev,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index abe88b74239a..7b4f0c54b9ec 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1189,14 +1189,6 @@ static int stmmac_init_phy(struct net_device *dev)
 		phylink_ethtool_set_eee(priv->phylink, &eee);
 	}
 
-	if (!priv->plat->pmt) {
-		struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
-
-		phylink_ethtool_get_wol(priv->phylink, &wol);
-		device_set_wakeup_capable(priv->device, !!wol.supported);
-		device_set_wakeup_enable(priv->device, !!wol.wolopts);
-	}
-
 	return 0;
 }
 
@@ -1265,6 +1257,7 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 		config->eee_enabled_default = true;
 	}
 
+	config->wol_phy_speed_ctrl = true;
 	if (priv->plat->flags & STMMAC_FLAG_USE_PHY_WOL) {
 		config->wol_phy_legacy = true;
 	} else {
@@ -7795,9 +7788,6 @@ int stmmac_suspend(struct device *dev)
 	mutex_unlock(&priv->lock);
 
 	rtnl_lock();
-	if (stmmac_wol_enabled_phy(priv))
-		phylink_speed_down(priv->phylink, false);
-
 	phylink_suspend(priv->phylink, !!priv->wolopts);
 	rtnl_unlock();
 
@@ -7936,9 +7926,6 @@ int stmmac_resume(struct device *dev)
 	 * workqueue thread, which will race with initialisation.
 	 */
 	phylink_resume(priv->phylink);
-	if (stmmac_wol_enabled_phy(priv))
-		phylink_speed_up(priv->phylink);
-
 	rtnl_unlock();
 
 	netif_device_attach(ndev);
-- 
2.47.3


