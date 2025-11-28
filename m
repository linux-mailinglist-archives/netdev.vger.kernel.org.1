Return-Path: <netdev+bounces-242578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ED64EC922F3
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 14:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FBAF4E1AC1
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 13:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA0B30EF65;
	Fri, 28 Nov 2025 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="pvHBeaEH"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81652417F0;
	Fri, 28 Nov 2025 13:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764338028; cv=none; b=Bu0+gAM/uCGQx4KOU4ouGCqd67Ej1tMxzELPBXBHqeBrGSSNUIv7UrlofhbYNOqq/SSnA2VtCF6QWyDwxssMjZJdw97m8xbsE5F1RTZTYKvZQmzGV4DNfDVW76OLlMvkXZXi7I08koaRGdszgE5shj5gn4vbII6Mjk9RkyJfVuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764338028; c=relaxed/simple;
	bh=fggz5XWbuFAd74CkiIlkgzkZvPGv9x5GbKR4bFumAEA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FMQH0saxlYAMExQSxThpUktI1XjuPG1+WZdIfp5MuNnI7ciU8fdPy38+wsZpDQOi6ldu7I5jw3AQAzocHRt0pfhlAclfcYcBFLoouwF14VFzs1vbiQ4KJ9UpcTm0ICGxvlVk4um4cL7YxcqtILdYzaSN3ZNsmpbaoEeW2691cLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=pvHBeaEH; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id DB8EDA078B;
	Fri, 28 Nov 2025 14:53:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=sLAchPg2rSsKp7RAybq9EonQbR9aCHhSrvXpvaorBVk=; b=
	pvHBeaEHioXMLsAEfJUGsudT5f8C3TBIqRMCmDnkkhUWtLuX1rhXOUI+WTPs14Dg
	P8mTVSDUM+DptyteVKo/DQNa/9K50tE8gv9G4wzyE2EGTl8s70+D/utlMQ9y567p
	XbhvhIp0pihrOuFWkM/DwJuDWGIJLGRtLBlcilieNRdcVsO36jIyYV4DPM/jIT1h
	J3aYAd/tqvOe44UYVenxcTLNWFW/DNSyO0+fxar63p8lwhJdFefrLejHxNOo6dXH
	M0k3FRVW7suG3YO8SSb4bOfGlizeCOhIIXCgcy864RlhX96L9eLQSGwssvGe/WUc
	7pzRQtXtxC6dvJi0MV4xrWhaRHV9mLylSrs/y/0Vj7mSvT869O3IEkVUFRYcawIU
	cEj+UslHzTCGk5Gw+Pzm5dT+JDl/6rUaVR6kdlwI1Ae3Je1llzBic8aT8kEjqBpa
	4fNWRPbbF2XDsJCFS42PuiBnxM5jjof7zmv0PqFTNwLE1qIQGGMuRNCCbmnW+Nvv
	eNKEuatiDGiZ++8CH0fff0GF1pGNqK6dLxXaucMFOOWTPzu/qjq82Q3YbEHQ7AGE
	UOtaiaSXF7ZQbZXUaD59nvrAtwIL93w1jnVX70fCRXv8S/EDTk7o2RYZlVC++WcR
	opEq5hlskXTYsCnmRayGk273J4TlHQX+IsmG58lRnWY=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net-next v2 1/1] net: mdio: reset PHY before attempting to access ID register
Date: Fri, 28 Nov 2025 14:53:32 +0100
Message-ID: <5701a9faafd1769b650b79c2d0c72cc10b5bdbc8.1764337894.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1764338014;VERSION=8002;MC=3517599472;ID=166272;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F607D64

When the ID of an Ethernet PHY is not provided by the 'compatible'
string in the device tree, its actual ID is read via the MDIO bus.
For some PHYs this could be unsafe, since a hard reset may be
necessary to safely access the MDIO registers.

Add a fallback mechanism for such devices: when reading the ID
fails, the reset will be asserted, and the ID read is retried.

This allows such devices to be used with an autodetected ID.

The fallback mechanism is activated in the error handling path, and
the return code of fwnode_mdiobus_register_phy() is unaltered, except
when the reset fails with -EPROBE_DEFER, which is propagated to the
caller.

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
Patch split from a larger series:
https://lore.kernel.org/all/cover.1761732347.git.buday.csaba@prolan.hu/

The refactoring parts of the previous patchset were already merged,
leaving this one. Functionally identical to:
https://lore.kernel.org/all/5f8d93021a7aa6eeb4fb67ab27ddc7de9101c59f.1761732347.git.buday.csaba@prolan.hu/

Comments were added for clarity.
V1 -> V2: added missing EXPORT_SYMBOL_NS_GPL for
          mdio_device_register/unregister_reset functions
---
 drivers/net/mdio/fwnode_mdio.c | 42 +++++++++++++++++++++++++++++++++-
 drivers/net/phy/mdio_device.c  |  2 ++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index ba7091518..28daabe63 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -13,9 +13,12 @@
 #include <linux/phy.h>
 #include <linux/pse-pd/pse.h>
 
+#include "../phy/mdio-private.h"
+
 MODULE_AUTHOR("Calvin Johnson <calvin.johnson@oss.nxp.com>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("FWNODE MDIO bus (Ethernet PHY) accessors");
+MODULE_IMPORT_NS("NET_PHY_CORE_ONLY");
 
 static struct pse_control *
 fwnode_find_pse_control(struct fwnode_handle *fwnode,
@@ -67,6 +70,34 @@ fwnode_find_mii_timestamper(struct fwnode_handle *fwnode)
 	return mii_ts;
 }
 
+/* Hard-reset a PHY before registration */
+static int fwnode_reset_phy(struct mii_bus *bus, u32 addr,
+			    struct fwnode_handle *phy_node)
+{
+	struct mdio_device *tmpdev;
+	int rc;
+
+	/* Create a temporary MDIO device to allocate reset resources */
+	tmpdev = mdio_device_create(bus, addr);
+	if (IS_ERR(tmpdev))
+		return PTR_ERR(tmpdev);
+
+	device_set_node(&tmpdev->dev, fwnode_handle_get(phy_node));
+	rc = mdio_device_register_reset(tmpdev);
+	if (rc) {
+		mdio_device_free(tmpdev);
+		return rc;
+	}
+
+	mdio_device_reset(tmpdev, 1);
+	mdio_device_reset(tmpdev, 0);
+
+	mdio_device_unregister_reset(tmpdev);
+	mdio_device_free(tmpdev);
+
+	return 0;
+}
+
 int fwnode_mdiobus_phy_device_register(struct mii_bus *mdio,
 				       struct phy_device *phy,
 				       struct fwnode_handle *child, u32 addr)
@@ -129,8 +160,17 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 		return PTR_ERR(mii_ts);
 
 	is_c45 = fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45");
-	if (is_c45 || fwnode_get_phy_id(child, &phy_id))
+	if (is_c45 || fwnode_get_phy_id(child, &phy_id)) {
 		phy = get_phy_device(bus, addr, is_c45);
+		if (IS_ERR(phy)) {
+			/* get_phy_device() failed, retry after a reset */
+			rc = fwnode_reset_phy(bus, addr, child);
+			if (rc == -EPROBE_DEFER)
+				goto clean_mii_ts;
+			else if (!rc)
+				phy = get_phy_device(bus, addr, is_c45);
+		}
+	}
 	else
 		phy = phy_device_create(bus, addr, phy_id, 0, NULL);
 	if (IS_ERR(phy)) {
diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index fd0e16dbc..1125c89e4 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -156,6 +156,7 @@ int mdio_device_register_reset(struct mdio_device *mdiodev)
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(mdio_device_register_reset, "NET_PHY_CORE_ONLY");
 
 /**
  * mdio_device_unregister_reset - uninitialize the reset properties of
@@ -171,6 +172,7 @@ void mdio_device_unregister_reset(struct mdio_device *mdiodev)
 	mdiodev->reset_assert_delay = 0;
 	mdiodev->reset_deassert_delay = 0;
 }
+EXPORT_SYMBOL_NS_GPL(mdio_device_unregister_reset, "NET_PHY_CORE_ONLY");
 
 void mdio_device_reset(struct mdio_device *mdiodev, int value)
 {

base-commit: e2c20036a8879476c88002730d8a27f4e3c32d4b
-- 
2.39.5



