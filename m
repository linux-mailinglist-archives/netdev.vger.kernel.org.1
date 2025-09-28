Return-Path: <netdev+bounces-226984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E64BA6C65
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 10:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1382F3B581E
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 08:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38062C027D;
	Sun, 28 Sep 2025 08:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FJSx76mj"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD32213236;
	Sun, 28 Sep 2025 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759049950; cv=none; b=N+boKL/AwRfCAqbTOiCjTPN0BRkKCdzQ2FseJm8ZYcXOK65VM59Z4+TaQSS1R+K6E92C6SfPee2VEbrjnL88otY1OueMoYg+1BuolKofWy4sUnonlly7T6KMhmrjm+fcTx8OqcOFkGmsuf5fdL9s3X+qpiNZo9LUcuqA27WbSgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759049950; c=relaxed/simple;
	bh=sltJehwGmgNGNkXehUDxNoleo8qQh6YQJ9OKkJ9KvnM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=TImqSQo9amtpJmj0B3AjxPnTwOBZd+EXPmXySyponrBIkMh9Alp76c4fThmwYGOFTB3cl43gcaWRTSOU1gd/LA1l4qSELQ0GrXEnq8TJ5q/nZqSNSR4fmRiGQmsOAic11/xPMycsQSzXPgr6WkRibngZApbk+uu32QK6dG1vs80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FJSx76mj; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dRHUASpZNpL3VRyQX74pzizWthRGiNuqvRODSjFvKBc=; b=FJSx76mj23T79CLUxd3KbBKvJL
	rnM5mlqwn4ussFrt7nROV+s/Aim8RZblq2mqVDi1UlaQTZjYGycszBu0LdXKJdtARbKg7eMZsqTrs
	78iUYJ9rMzgkcAkzIYk7mvbBxTfBnLirjERnvtpN2t1nc2oADPylLIXoEf7JzNGAuLLEaxNiSPrnc
	5HgFlScs7M6ljpdVDEDRnHedDLeKFZL+yrD2dbU8l/GfPSwLlQidYkX1wuJFaFEpUXPj25ERXUiJ3
	gfn9JXFIJE9uORGTpJaQvNEzGTsSuHZSdSJxBRbRfTmAPybyLLuPKsuofUP4ZUJOayDzuuhOVw6zq
	fuOzqM5Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36008 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1v2nFE-000000005Ak-27a8;
	Sun, 28 Sep 2025 09:59:00 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1v2nFD-00000007jXP-0fX2;
	Sun, 28 Sep 2025 09:58:59 +0100
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
Subject: [PATCH RFC net-next 2/6] net: phy: add phy_may_wakeup()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1v2nFD-00000007jXP-0fX2@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 28 Sep 2025 09:58:59 +0100

Add phy_may_wakeup() which uses the driver model's device_may_wakeup()
when the PHY driver has marked the device as wakeup capable in the
driver model, otherwise use phy_drv_wol_enabled().

Replace the sites that used to call phy_drv_wol_enabled() with this
as checking the driver model will be more efficient than checking the
WoL state.

Export phy_may_wakeup() so that phylink can use it.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy_device.c | 14 ++++++++++++--
 include/linux/phy.h          |  9 +++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 01269b865f5e..4c8df9f02eb3 100644
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
index 7f6758198948..2292ee9a93c0 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1391,6 +1391,15 @@ static inline bool phy_can_wakeup(struct phy_device *phydev)
 	return device_can_wakeup(&phydev->mdio.dev);
 }
 
+/**
+ * phy_may_wakeup() - indicate whether PHY has driver model wakeup is enabled
+ * @phydev: The phy_device struct
+ *
+ * Returns: true/false depending on the PHY driver's device_set_wakeup_enabled()
+ * setting.
+ */
+bool phy_may_wakeup(struct phy_device *phydev);
+
 void phy_resolve_aneg_pause(struct phy_device *phydev);
 void phy_resolve_aneg_linkmode(struct phy_device *phydev);
 
-- 
2.47.3


