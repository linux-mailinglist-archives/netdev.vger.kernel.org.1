Return-Path: <netdev+bounces-232023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F2926C00307
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 76D8D3592C6
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 09:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58BC2FDC38;
	Thu, 23 Oct 2025 09:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OugVG+J5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A78B2FBE0E;
	Thu, 23 Oct 2025 09:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761211002; cv=none; b=C+5TIpP+BicJRWlGW3XLFu+r1AsiQKK/nlffD65fklprXMVxhMrva+4p3PwPXQmZbdyBlSO2QdL9tBZuAC3rwaKVVq/ZZq00A4I8xIQ1v8OK7g9mvpK8iDEd+18eMiYcXxfVy8nuHIouF+VfBJ9FbO73UxVi4Nv7G1x1mlhir5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761211002; c=relaxed/simple;
	bh=EX7LYjpEcUy9Kf5lMB3Zb6bXFXHbvIoxgBaEMkDjTqg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=CluJ6TH/F1/jaFlP84AW6agbcZOEDMl62iAdcM7+HwBZu6GXds0O9vUcEZvfG8TNqyc+urzu33s2b0fdx9LBCmBQGJDYkEyjINUt7OEPhi7BrHvyDWjSocz4CWIqiuTDrbcBzRVKTby7NknTzc7qTz1ogYOQc693UIxRcmZX52Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=OugVG+J5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SuSMaY7MNOlG0YYGuQqrpd/fTe1RDOR/qBM77ZJNoHI=; b=OugVG+J5prG+LhML3KAld/bi/9
	h+qdx58grUvdJgn/+UUAetp/AM0xRi8T/NLzp6uxswGlbGSbvrZuHS6LMa2ninaTw3BniqedEe6t3
	PdEZWxiNQUiUbzZZ6WSsM5cuieaccgNE3GflevAESupOa7mcoL0wxfjMr2KpoS44Mvf3wiiQ52r/F
	gtV7HS/EkDa4HZuH4qC4t3AFFlrJzYczrR1Lb+OjKePRFvTTU9nwfUUBrV4DXjBMejScdImeBNgXg
	084ZSixR5qHOLm3DaJ4LPOUoXChbvHVcRtrua1hi3Axsm9wn6Km0VC2MzKHA3hWS9Wz3WTISedKyE
	f2e4RtAw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46454 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vBrQy-0000000060u-0xMF;
	Thu, 23 Oct 2025 10:16:36 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vBrQx-0000000BLzO-1RLt;
	Thu, 23 Oct 2025 10:16:35 +0100
In-Reply-To: <aPnyW54J80h9DmhB@shell.armlinux.org.uk>
References: <aPnyW54J80h9DmhB@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
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
Subject: [PATCH net-next v2 2/6] net: phy: add phy_may_wakeup()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vBrQx-0000000BLzO-1RLt@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 23 Oct 2025 10:16:35 +0100

Add phy_may_wakeup() which uses the driver model's device_may_wakeup()
when the PHY driver has marked the device as wakeup capable in the
driver model, otherwise use phy_drv_wol_enabled().

Replace the sites that used to call phy_drv_wol_enabled() with this
as checking the driver model will be more efficient than checking the
WoL state.

Export phy_may_wakeup() so that phylink can use it.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
v2: fix kerneldoc description
---
 drivers/net/phy/phy_device.c | 14 ++++++++++++--
 include/linux/phy.h          |  9 +++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 7a67c900e79a..b7feaf0cb1df 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -251,6 +251,16 @@ static bool phy_drv_wol_enabled(struct phy_device *phydev)
 	return wol.wolopts != 0;
 }
 
+bool phy_may_wakeup(struct phy_device *phydev)
+{
+	/* If the PHY is using driver-model based wakeup, use that state. */
+	if (phy_can_wakeup(phydev))
+		return device_may_wakeup(&phydev->mdio.dev);
+
+	return phy_drv_wol_enabled(phydev);
+}
+EXPORT_SYMBOL_GPL(phy_may_wakeup);
+
 static void phy_link_change(struct phy_device *phydev, bool up)
 {
 	struct net_device *netdev = phydev->attached_dev;
@@ -302,7 +312,7 @@ static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
 	/* If the PHY on the mido bus is not attached but has WOL enabled
 	 * we cannot suspend the PHY.
 	 */
-	if (!netdev && phy_drv_wol_enabled(phydev))
+	if (!netdev && phy_may_wakeup(phydev))
 		return false;
 
 	/* PHY not attached? May suspend if the PHY has not already been
@@ -1909,7 +1919,7 @@ int phy_suspend(struct phy_device *phydev)
 	if (phydev->suspended || !phydrv)
 		return 0;
 
-	phydev->wol_enabled = phy_drv_wol_enabled(phydev) ||
+	phydev->wol_enabled = phy_may_wakeup(phydev) ||
 			      (netdev && netdev->ethtool->wol_enabled);
 	/* If the device has WOL enabled, we cannot suspend the PHY */
 	if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 3eeeaec52832..17a2cdc9f1a0 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1391,6 +1391,15 @@ static inline bool phy_can_wakeup(struct phy_device *phydev)
 	return device_can_wakeup(&phydev->mdio.dev);
 }
 
+/**
+ * phy_may_wakeup() - indicate whether PHY has wakeup enabled
+ * @phydev: The phy_device struct
+ *
+ * Returns: true/false depending on the PHY driver's device_set_wakeup_enabled()
+ * setting if using the driver model, otherwise the legacy determination.
+ */
+bool phy_may_wakeup(struct phy_device *phydev);
+
 void phy_resolve_aneg_pause(struct phy_device *phydev);
 void phy_resolve_aneg_linkmode(struct phy_device *phydev);
 
-- 
2.47.3


