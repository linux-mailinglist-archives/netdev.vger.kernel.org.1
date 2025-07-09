Return-Path: <netdev+bounces-205424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4FDAFEA16
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82F5B7B30A7
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 13:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33222DD61E;
	Wed,  9 Jul 2025 13:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="YImFyduj"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3992D3EFF;
	Wed,  9 Jul 2025 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067479; cv=none; b=Ismg3FGoYPaTtBrZ5YN3RzkXt2Jk6syhLBrjgS7t+1LCaDz86LWY3XJV4MgAFN4Cc+HvZJ1y+9OEf9lLB7pxqvexut7om3DvH3e5z+bxNTKyETBE2PHo9zIRDn3XV5/nOrdPZ0rsGabpYvDo+tOTcQH9XyNl3sUik74Um5zjfvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067479; c=relaxed/simple;
	bh=0CMdkCD+Gnywy5WXpjLIkPQlIGWoX/ynYgGIfUb18p8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q79kxO1B4iDeVlVAAVtv3bLShDHTAJmuNzloepxg4YGlUtVPcPKDGJA4ouIAgg+EUlufP9QFAvgKVNmpliVXJ0JAA9TRQ9ot1Tfu02ne5+2WlHqJud3sjUdqlqp7ISwBIc+QEJ3ajMZhYXgJluhoZUrmNoj0RSReA6bEntXI7L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=YImFyduj; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 72C56A0AE6;
	Wed,  9 Jul 2025 15:24:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=ap4l4ZavPRJIIz6XqI8DVedkNK/Oh8jJblcsWkIXeaA=; b=
	YImFydujvVhzIRpuYPB2JO77dDnXelj6Wz1sn7SNulXld3XrIhx6bwb6YKbPvvug
	K75YLYhYuJoh6cgZYowtbiOxlWf83naBguACkX+4d8Utdj3XuoukUjWsaMi+NT43
	8iluuKo7kWH7YuvKH9UwIAi31iv13+iel1vfVAPykBd5c08LEdkh/7AsXwxJUXl/
	gaPFKDqrTO/a5mMqjco1WvInlcRCaP/T3K0wm+N/wC81L/9KkNiYoZGWcTGImI92
	Rp+yaP6ri5ZbvGmvhUb0oAyrGFNdfYvJ+pe/xgbTzee8EUwXOiv0iVehls/oklXK
	Jw2t5jCHhkP1Q413QXmK+5dYB+uMsphiSLAB/nexHmWcrnpGcWaXrywvsaKz0Si/
	Tm4L1HnnoDuucOyoZp2dGXHW9bCHFelVXcugWX2O7MXjzSAUnrPdbFLGdiFW+SpX
	9ntuMwnCEQvhP171MncHzWW9tlxlzrHWDJTN3RwkXSZcH0HJlGtSkKq1H1keG/ZU
	NFrbghnnrmWlaHAyA3ZdWB5Fb55XM5f7Cv9eltduxcIetD/ops2lcN28bvpMS9Fr
	ix0MFgOBpdG8Wbux9/DOFnS57BgFU7jUlFU3JBTLK8ik3HXP7aYwvvgKO3tn2nnn
	gIxQbR88WduuwxRMYWx1xAgLggbzogSKuOLvlJHwbIY=
From: Buday Csaba <buday.csaba@prolan.hu>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>, Andrew Lunn <andrew@lunn.ch>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] net: mdio: reset PHY before attempting to access registers in fwnode_mdiobus_register_phy
Date: Wed, 9 Jul 2025 15:24:24 +0200
Message-ID: <20250709132425.48631-1-buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1752067471;VERSION=7994;MC=1675866844;ID=104516;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515E657164

Some PHYs (e.g. LAN8710A) require a reset after power-on,even for
MDIO register access.
The current implementation of fwnode_mdiobus_register_phy() and
get_phy_device() attempt to read the id registers without ensuring
that the PHY had a reset before, which can fail on these devices.

This patch addresses that shortcoming, by always resetting the PHY
(when such property is given in the device tree). To keep the code
impact minimal, a change was also needed in phy_device_remove() to
prevent asserting the reset on device removal.

According to the documentation of phy_device_remove(), it should
reverse the effect of phy_device_register(). Since the reset GPIO
is in undefined state before that, it should be acceptable to leave
it unchanged during removal.

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
 drivers/net/mdio/fwnode_mdio.c | 20 ++++++++++++++++++--
 drivers/net/phy/phy_device.c   |  3 ---
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index aea0f03575689..36b60544327b6 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -139,8 +139,24 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 	}
 
 	is_c45 = fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45");
-	if (is_c45 || fwnode_get_phy_id(child, &phy_id))
-		phy = get_phy_device(bus, addr, is_c45);
+	if (is_c45 || fwnode_get_phy_id(child, &phy_id)) {
+		/* get_phy_device is NOT SAFE HERE, since the PHY may need a HW RESET.
+		 * First create a dummy PHY device, reset the PHY, then call
+		 * get_phy_device.
+		 */
+		phy = phy_device_create(bus, addr, 0, 0, NULL);
+		if (!IS_ERR(phy)) {
+			if (is_of_node(child)) {
+				/* fwnode_mdiobus_phy_device_register performs the reset */
+				rc = fwnode_mdiobus_phy_device_register(bus, phy, child, addr);
+				if (!rc)
+					phy_device_remove(phy);
+				/* PHY has been reset at this point. */
+			}
+			phy_device_free(phy);
+			phy = get_phy_device(bus, addr, is_c45);
+		}
+	}
 	else
 		phy = phy_device_create(bus, addr, phy_id, 0, NULL);
 	if (IS_ERR(phy)) {
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 13dea33d86ffa..da4ddce04e5fb 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1102,9 +1102,6 @@ void phy_device_remove(struct phy_device *phydev)
 
 	device_del(&phydev->mdio.dev);
 
-	/* Assert the reset signal */
-	phy_device_reset(phydev, 1);
-
 	mdiobus_unregister_device(&phydev->mdio);
 }
 EXPORT_SYMBOL(phy_device_remove);
-- 
2.39.5



