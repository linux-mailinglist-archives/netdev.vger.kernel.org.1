Return-Path: <netdev+bounces-177926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E29F8A72F15
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 12:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74C3F174BE1
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 11:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F24A212B34;
	Thu, 27 Mar 2025 11:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qLBhByWi"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6200E211A3F;
	Thu, 27 Mar 2025 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743074797; cv=none; b=kMkrhipEgpQDWWe1NnSL3DrmH32jtEZTtyEUUNYWa/X+qEHTsJSW6hpj2WURYOFlk/fSs+/i7nNQLrnp5s/kkekBj4g/iCn/wmiYrbqZ0wNYzNqYDleQn10z4JkoYFIDUhYzh2/tbDNZIWDCzCW/L5Lamdk3XKMgvujq0iIS/2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743074797; c=relaxed/simple;
	bh=MJfswdiszz/jsfopd5O6MRPtbPlWT5LbW0ckpCP1U8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKjorTYnQmsMmWIpC28KUC8MyTMnL4XAx0GEQm3xl2ZO6xdfHtUWJx+54rsPUrztqF0xIJuugN/fvgR2G2xPEzP3dsZbIDv8+dll4SWHgY61qTyAAWyVvhV6Sfp4K+jbWOVJ0h+htvQ0lB829wnkpIcKZi1jto1ZnuXNYDhOlro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qLBhByWi; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6NtYN4mXRZiQeFSzRJfC4lHgxGcXmDM920RCDFEB12s=; b=qLBhByWi2m4ErsKnTpR5MzuTFD
	IglG4piMJNUpQR2HOEjLhjMxDaxyajTeDq5HTnC7Bormvev49EFte2dw/GStuBZF19CbrZjD6WRyl
	dO7jpfeNQYGGaR+yz4FiT5MVa0cfZWt+ADhu1U1duC3KcEBrLppMa9uZV4EW2M6tm3usdkmpHW4gM
	yV0O+VpvxpEKj1O5WrZ6KYwLji5JcvrowZ6TM8t1XQtyyo5dF+EgYWY1mUV980qQmxmui1y8Xg7ER
	T3F7wjmav9ziN7toqmNMuXfxVb18RbjUJIjuk4Tl5kPf5qTEz5uqrHQiCrU4aQlIWneyKPYOxXKzm
	VW3KSDBQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47800)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1txlNR-0007Ay-0B;
	Thu, 27 Mar 2025 11:26:25 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1txlNP-0005az-2Q;
	Thu, 27 Mar 2025 11:26:23 +0000
Date: Thu, 27 Mar 2025 11:26:23 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v3 3/4] net: phy: Add support for Aeonsemi
 AS21xxx PHYs
Message-ID: <Z+U1368bId9jTUKr@shell.armlinux.org.uk>
References: <20250326233512.17153-1-ansuelsmth@gmail.com>
 <20250326233512.17153-4-ansuelsmth@gmail.com>
 <Z-U1anj6IbSdPGoD@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-U1anj6IbSdPGoD@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Mar 27, 2025 at 11:24:26AM +0000, Russell King (Oracle) wrote:
> If I'm reading these driver entries correctly, the only reason for
> having separate entries is to be able to have a unique name printed
> for each - the methods themselves are all identical.
> 
> My feeling is that is not a sufficient reason to duplicate the driver
> entries, which adds bloat (not only in terms of static data, but also
> the data structures necessary to support each entry in sysfs.) However,
> lets see what Andrew says.

I did have this patch from a previous discussion which adds support for
a single phy_driver struct to have multiple matching IDs. I haven't
rebased it on current net-next, so may no longer apply:

 drivers/net/phy/phy_device.c | 64 +++++++++++++++++++++++++++++++++-----------
 include/linux/phy.h          | 16 ++++++++++-
 2 files changed, 63 insertions(+), 17 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 2e7d5bfb338e..7e02bf51a2a5 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -522,12 +522,51 @@ static int phy_scan_fixups(struct phy_device *phydev)
 	return 0;
 }
 
+static const struct mdio_device_id *
+phy_driver_match_id(struct phy_driver *phydrv, u32 id)
+{
+	const struct mdio_device_id *ids = phydrv->ids;
+
+	if (ids) {
+		while (ids->phy_id) {
+			if (phy_id_compare(id, ids->phy_id, ids->phy_id_mask))
+				return ids;
+			ids++;
+		}
+	}
+
+	if (phy_id_compare(id, phydrv->id.phy_id, phydrv->id.phy_id_mask))
+		return &phydrv->id;
+
+	return NULL;
+}
+
+static const struct mdio_device_id *
+phy_driver_match(struct phy_driver *phydrv, struct phy_device *phydev)
+{
+	const int num_ids = ARRAY_SIZE(phydev->c45_ids.device_ids);
+	const struct mdio_device_id *id;
+	int i;
+
+	if (!phydev->is_c45)
+		return phy_driver_match_id(phydrv, phydev->phy_id);
+
+	for (i = 1; i < num_ids; i++) {
+		if (phydev->c45_ids.device_ids[i] == 0xffffffff)
+			continue;
+
+		id = phy_driver_match_id(phydrv, phydev->c45_ids.device_ids[i]);
+		if (id)
+			return id;
+	}
+
+	return NULL;
+}
+
 static int phy_bus_match(struct device *dev, struct device_driver *drv)
 {
 	struct phy_device *phydev = to_phy_device(dev);
 	struct phy_driver *phydrv = to_phy_driver(drv);
-	const int num_ids = ARRAY_SIZE(phydev->c45_ids.device_ids);
-	int i;
 
 	if (!(phydrv->mdiodrv.flags & MDIO_DEVICE_IS_PHY))
 		return 0;
@@ -535,20 +574,7 @@ static int phy_bus_match(struct device *dev, struct device_driver *drv)
 	if (phydrv->match_phy_device)
 		return phydrv->match_phy_device(phydev);
 
-	if (phydev->is_c45) {
-		for (i = 1; i < num_ids; i++) {
-			if (phydev->c45_ids.device_ids[i] == 0xffffffff)
-				continue;
-
-			if (phy_id_compare(phydev->c45_ids.device_ids[i],
-					   phydrv->phy_id, phydrv->phy_id_mask))
-				return 1;
-		}
-		return 0;
-	} else {
-		return phy_id_compare(phydev->phy_id, phydrv->phy_id,
-				      phydrv->phy_id_mask);
-	}
+	return !!phy_driver_match(phydrv, phydev);
 }
 
 static ssize_t
@@ -3311,6 +3337,7 @@ static int phy_probe(struct device *dev)
 	int err = 0;
 
 	phydev->drv = phydrv;
+	phydev->drv_id = phy_driver_match(phydrv, phydev);
 
 	/* Disable the interrupt if the PHY doesn't support it
 	 * but the interrupt is still a valid one
@@ -3485,6 +3512,11 @@ int phy_driver_register(struct phy_driver *new_driver, struct module *owner)
 	new_driver->mdiodrv.driver.owner = owner;
 	new_driver->mdiodrv.driver.probe_type = PROBE_FORCE_SYNCHRONOUS;
 
+	if (!new_driver->id.phy_id) {
+		new_driver->id.phy_id = new_driver->phy_id;
+		new_driver->id.phy_id_mask = new_driver->phy_id_mask;
+	}
+
 	retval = driver_register(&new_driver->mdiodrv.driver);
 	if (retval) {
 		pr_err("%s: Error %d in registering driver\n",
diff --git a/include/linux/phy.h b/include/linux/phy.h
index fd8dbea9b4d9..2f2ebbd41535 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -542,6 +542,7 @@ struct macsec_ops;
  *
  * @mdio: MDIO bus this PHY is on
  * @drv: Pointer to the driver for this PHY instance
+ * @drv_id: The matched driver ID for this PHY instance
  * @devlink: Create a link between phy dev and mac dev, if the external phy
  *           used by current mac interface is managed by another mac interface.
  * @phy_id: UID for this device found during discovery
@@ -639,6 +640,7 @@ struct phy_device {
 	/* Information about the PHY type */
 	/* And management functions */
 	const struct phy_driver *drv;
+	const struct mdio_device_id *drv_id;
 
 	struct device_link *devlink;
 
@@ -882,6 +884,9 @@ struct phy_led {
  * struct phy_driver - Driver structure for a particular PHY type
  *
  * @mdiodrv: Data common to all MDIO devices
+ * @ids: array of mdio device IDs to match this driver (terminated with
+ *   zero phy_id)
+ * @id: mdio device ID to match
  * @phy_id: The result of reading the UID registers of this PHY
  *   type, and ANDing them with the phy_id_mask.  This driver
  *   only works for PHYs with IDs which match this field
@@ -903,6 +908,8 @@ struct phy_led {
  */
 struct phy_driver {
 	struct mdio_driver_common mdiodrv;
+	const struct mdio_device_id *ids;
+	struct mdio_device_id id;
 	u32 phy_id;
 	char *name;
 	u32 phy_id_mask;
@@ -1203,7 +1210,14 @@ static inline bool phy_id_compare(u32 id1, u32 id2, u32 mask)
  */
 static inline bool phydev_id_compare(struct phy_device *phydev, u32 id)
 {
-	return phy_id_compare(id, phydev->phy_id, phydev->drv->phy_id_mask);
+	u32 mask;
+
+	if (phydev->drv_id)
+		mask = phydev->drv_id->phy_id_mask;
+	else
+		mask = phydev->drv->phy_id_mask;
+
+	return phy_id_compare(id, phydev->phy_id, mask);
 }
 
 /* A Structure for boards to register fixups with the PHY Lib */

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

