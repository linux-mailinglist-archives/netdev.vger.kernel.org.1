Return-Path: <netdev+bounces-158180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55557A10CB4
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 17:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9793167E5D
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 16:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567C91B6CFB;
	Tue, 14 Jan 2025 16:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="EdQOTFCc"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F45232459
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 16:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736873484; cv=none; b=KLaEBtO0ACn21xn4ztXI16pLk+lsyQf8F+UslEkhMi2jS3oG9LJrMy3U2WkPLR5A568cvf8Dy++S19G7bTc6fr/nAlwao5QPoB38FJ+2aTnnBMweCwBUDJqNv2UVT1drToJRXxRR4/Wcustq8mcxK8lTZO/eC/lHX9RjajBAf2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736873484; c=relaxed/simple;
	bh=sS0SNPUTBZCONHd/3nmbyQ70JqGsNVfOp+hf+q5fd5E=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=N9JqOvEIOP8wnjnkdRNBfpyxOfQ94MNw4gyDIA/IyZI6DNC6XxspjWmjlJGERVgcx5G8NHHGg/m/ZNf1dykJ+/iLrA9m/FsTWi+on/GRlkkeNjDdZqJIue3aJiC4TSrOMoV/8OaWNVorA6X3fhxJT9XJ979LQTqHVOU4qA7C260=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=EdQOTFCc; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oenY17GSf8f8EXzY6YS/3Oz03Km0J1tQZHiPenN9SJA=; b=EdQOTFCcpVQqJL9SbFTXjDlfow
	ydKYKjYnd9HevwZDOpEePzwsVzWzRC+tPQNZ7fK7GSQTwYNv7Y4+z837NdR9f8mtnWCfUXTu0ljOw
	LNvr1S2CtvzR4yFEii1UTpneUjnNrKY8f4R5rTcKfBMj3Foo9jB3GCyFyaFXoTG7L53SBNkQ/CNxp
	sFM6CM0zhsrafqsJLeipqGP15yUje5a6bCM8LZ9UlfVJe7KNYqSj1zsGCM4xpKsaoks6ZnaF4GeJX
	lUwkZC3bB1eIRuR8th9XBqj6N8CubGhWVa9uSGDG2sdYhuF9qBLnL7LeR/du5FmcO8a32Vh8bTr46
	LmghgCjg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60496 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tXk8L-0008OK-0R;
	Tue, 14 Jan 2025 16:51:17 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tXk81-000r4x-TS; Tue, 14 Jan 2025 16:50:57 +0000
In-Reply-To: <Z4aV3RmSZJ1WS3oR@shell.armlinux.org.uk>
References: <Z4aV3RmSZJ1WS3oR@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	bcm-kernel-feedback-list@broadcom.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Justin Chen <justin.chen@broadcom.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 3/3] net: bcm: asp2: convert to phylib managed EEE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tXk81-000r4x-TS@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 14 Jan 2025 16:50:57 +0000

Convert the Broadcom ASP2 driver to use phylib managed EEE support.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.h   |  3 --
 .../ethernet/broadcom/asp2/bcmasp_ethtool.c   | 31 -------------------
 .../net/ethernet/broadcom/asp2/bcmasp_intf.c  | 19 ++++++------
 3 files changed, 10 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.h b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
index f93cb3da44b0..8fc75bcedb70 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.h
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
@@ -348,8 +348,6 @@ struct bcmasp_intf {
 	/* Used if per intf wol irq */
 	int				wol_irq;
 	unsigned int			wol_irq_enabled:1;
-
-	struct ethtool_keee		eee;
 };
 
 #define NUM_NET_FILTERS				32
@@ -601,5 +599,4 @@ int bcmasp_netfilt_get_all_active(struct bcmasp_intf *intf, u32 *rule_locs,
 
 void bcmasp_netfilt_suspend(struct bcmasp_intf *intf);
 
-void bcmasp_eee_enable_set(struct bcmasp_intf *intf, bool enable);
 #endif
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
index 5e04cd1839c0..a537c121d3e2 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
@@ -348,20 +348,6 @@ static int bcmasp_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 	return err;
 }
 
-void bcmasp_eee_enable_set(struct bcmasp_intf *intf, bool enable)
-{
-	u32 reg;
-
-	reg = umac_rl(intf, UMC_EEE_CTRL);
-	if (enable)
-		reg |= EEE_EN;
-	else
-		reg &= ~EEE_EN;
-	umac_wl(intf, reg, UMC_EEE_CTRL);
-
-	intf->eee.eee_enabled = enable;
-}
-
 static int bcmasp_get_eee(struct net_device *dev, struct ethtool_keee *e)
 {
 	if (!dev->phydev)
@@ -372,26 +358,9 @@ static int bcmasp_get_eee(struct net_device *dev, struct ethtool_keee *e)
 
 static int bcmasp_set_eee(struct net_device *dev, struct ethtool_keee *e)
 {
-	struct bcmasp_intf *intf = netdev_priv(dev);
-	struct ethtool_keee *p = &intf->eee;
-	int ret;
-
 	if (!dev->phydev)
 		return -ENODEV;
 
-	if (!p->eee_enabled) {
-		bcmasp_eee_enable_set(intf, false);
-	} else {
-		ret = phy_init_eee(dev->phydev, 0);
-		if (ret) {
-			netif_err(intf, hw, dev,
-				  "EEE initialization failed: %d\n", ret);
-			return ret;
-		}
-
-		bcmasp_eee_enable_set(intf, true);
-	}
-
 	return phy_ethtool_set_eee(dev->phydev, e);
 }
 
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index 62861a454a27..45ec1a9214a2 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -619,7 +619,6 @@ static void bcmasp_adj_link(struct net_device *dev)
 	struct phy_device *phydev = dev->phydev;
 	u32 cmd_bits = 0, reg;
 	int changed = 0;
-	bool active;
 
 	if (intf->old_link != phydev->link) {
 		changed = 1;
@@ -678,9 +677,12 @@ static void bcmasp_adj_link(struct net_device *dev)
 		umac_wl(intf, reg, UMC_CMD);
 
 		umac_wl(intf, phydev->eee_cfg.tx_lpi_timer, UMC_EEE_LPI_TIMER);
-
-		active = phy_init_eee(phydev, 0) >= 0;
-		bcmasp_eee_enable_set(intf, active);
+		reg = umac_rl(intf, UMC_EEE_CTRL);
+		if (phydev->enable_tx_lpi)
+			reg |= EEE_EN;
+		else
+			reg &= ~EEE_EN;
+		umac_wl(intf, reg, UMC_EEE_CTRL);
 	}
 
 	reg = rgmii_rl(intf, RGMII_OOB_CNTRL);
@@ -1336,7 +1338,8 @@ static void bcmasp_suspend_to_wol(struct bcmasp_intf *intf)
 				     ASP_WAKEUP_INTR2_MASK_CLEAR);
 	}
 
-	if (intf->eee.eee_enabled && intf->parent->eee_fixup)
+	if (ndev->phydev && ndev->phydev->eee_cfg.eee_enabled &&
+	    intf->parent->eee_fixup)
 		intf->parent->eee_fixup(intf, true);
 
 	netif_dbg(intf, wol, ndev, "entered WOL mode\n");
@@ -1378,7 +1381,8 @@ static void bcmasp_resume_from_wol(struct bcmasp_intf *intf)
 {
 	u32 reg;
 
-	if (intf->eee.eee_enabled && intf->parent->eee_fixup)
+	if (intf->ndev->phydev && intf->ndev->phydev->eee_cfg.eee_enabled &&
+	    intf->parent->eee_fixup)
 		intf->parent->eee_fixup(intf, false);
 
 	reg = umac_rl(intf, UMC_MPD_CTRL);
@@ -1409,9 +1413,6 @@ int bcmasp_interface_resume(struct bcmasp_intf *intf)
 
 	bcmasp_resume_from_wol(intf);
 
-	if (intf->eee.eee_enabled)
-		bcmasp_eee_enable_set(intf, true);
-
 	netif_device_attach(dev);
 
 	return 0;
-- 
2.30.2


