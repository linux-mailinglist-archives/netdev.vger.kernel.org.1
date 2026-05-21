Return-Path: <netdev+bounces-290579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NkrL05SD2pEJAYAu9opvQ
	(envelope-from <netdev+bounces-290579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:43:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB1A5AB332
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A55C6315807D
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991A437DAAA;
	Thu, 21 May 2026 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="B2lFnZ1h"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDB83F210B
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 17:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779386389; cv=none; b=sa0V6h7aZTTlL/3+tesJvZARqPBnHs2oWTMRKtVyP4LJ+vzZXEzIM8UASP2p7yaPpNKY5sGc2TowpWIXIBJTHL7lc0n7iZIKzWm3caJAp5A26Ti+xP5KW42Y+5E0oo38tHeHOb0BLht+prHr+GYHhAWZ/JgDT951fUwDOD53HGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779386389; c=relaxed/simple;
	bh=RFWH28xiyZL6UGfjauNvplsGVdLASD2SV76GNnK3YVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izFeDX4NgpoW2TV00LeB+lh0+Roh1gKn0QZNWUBPcqcud2QbFqYkLbhzyPrUfVIrKIS42kj1WGpqeXnu9E/dx7ujItvmdhaBJ3FjeO5mqYcP5yd/E3wfFQIYXo3PBPi9nC40CzsJCHIwLMbk67dT0+K4Q3l3WHRAIM00IbZiOdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=B2lFnZ1h; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779386376; x=1779991176;
	i=markus.stockhausen@gmx.de;
	bh=lrTI3H8Gl/3apM6ItYd3VAiWeRUHMOhbNUGZKLrfTnw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=B2lFnZ1hB4ZlD0tfJSn5p6YmaZu9M2l9FpXWSBP6P/j8ypQqT/g9PnT44qpFc/2h
	 fGtVDXsxe5vescDmGz3gDJcPaEYQsx2un+bLBcYJFuGkB/KzCf+1dZExDS+3d3dGh
	 lIrZVEWZGFoQ2hn/kaJ3Xwj8AJfYUghZtu6k1Z8Ount9KEqlj8b/MTJwKw+BaDxn1
	 hySjZzzpO++QS5MmwX1mcNaTXYogrWHPWbTunSerX/bHJqporolgVPVJN3b2HPFVU
	 4UZbH30DvdZ/Mh/AwnQt6wtTUe2pixEqC7MCg7Zm9/X34cpmKhv+9pZ9KlSCzbKUb
	 a5evk0NR+G7I/BqCPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtOKi-1xD8Z73moA-014WCS; Thu, 21
 May 2026 19:59:35 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v2 1/9] net: mdio: realtek-rtl9300: enhance documentation & naming
Date: Thu, 21 May 2026 19:59:10 +0200
Message-ID: <20260521175918.1494797-2-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521175918.1494797-1-markus.stockhausen@gmx.de>
References: <20260521175918.1494797-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gm34J81Rk5eQ9tOmXRLSy7QacWIZ9o6lcBQzlAFhDy8RqRj7E10
 zsq8AGXSHozz8YtpYnuGZh/OUZtakynIYOXOAmvhmOAgbh66pHVWbB7WKknEUlQIi/EjWjD
 RFb36WL/IJd5dUz4vUfGZLID/g2qgAkhf/b3p1lzp9sOfZPIXgACXOXe4yBq0d4ElAT9GNH
 LicNPyUEh04qPCyFZZ0SQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1VuQi4Q/3J8=;q/hHSr3n3dZ1QBb1vKf0hNnd+7c
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-290579-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,gmx.de:mid,gmx.de:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,bootlin.com:url]
X-Rspamd-Queue-Id: BEB1A5AB332
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Realtek ethernet MDIO driver currently only serves SOCs from the
Realtek RTL930x series. This is only one lineup of the Realtek Otto
switch series that also knows RTL838x, RTL839x, RTL931x devices.
All of these share similar hardware with comparable MMIO access logic
but have individual variations. Important to note

- Controller works on switch ports instead of buses and addresses.
- Devices incorporate additional MDIO hardware. E.g.
  - an auxiliary MDIO controller for GPIO expanders [1]
  - a MDIO style SerDes controller [2]

To avoid future confusion enhance the driver documentation and
function naming. Make clear what this driver is about and what
parts are generic and what parts are device specific. For this
rename the function and structure prefix as follows:

- for generic functions use otto_emdio_
- for device specific helpers use e.g. otto_emdio_9300_

This prefix naming tries to align with the watchdog timer [3].
It paves the way so that drivers for the other Realtek Otto MDIO
controllers can be added in future commits using the same naming
convention.

Remark 1: The read/write functions are kept device specific for now
because they will only fit the RTL930x SOCs. Renaming will take place
as soon as the I/O handling will be generalized.

Remark 2: The driver name "mdio-rtl9300" is kept for now.

[1] https://git.openwrt.org/openwrt/openwrt/tree/target/linux/realtek/patc=
hes-6.18/723-net-mdio-Add-Realtek-Otto-auxiliary-controller.patch
[2] https://git.openwrt.org/openwrt/openwrt/tree/target/linux/realtek/file=
s-6.18/drivers/net/mdio/mdio-realtek-otto-serdes.c
[3] https://elixir.bootlin.com/linux/v7.0/source/drivers/watchdog/realtek_=
otto_wdt.c

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 139 ++++++++++++++----------
 1 file changed, 84 insertions(+), 55 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 8d5fb014ca06..98484c689126 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -1,11 +1,40 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * MDIO controller for RTL9300 switches with integrated SoC.
+ * Realtek switches of the Otto series (RTL838x, RTL839x, RTL930x and RTL=
931x SoCs) have multiple
+ * integrated MDIO controllers. This driver targets the ethernet MDIO con=
troller. It serves only
+ * 1G/2.5G/10G ethernet PHYs attached to up to 4 individual buses.
  *
- * The MDIO communication is abstracted by the switch. At the software le=
vel
- * communication uses the switch port to address the PHY. We work out the
- * mapping based on the MDIO bus described in device tree and phandles on=
 the
- * ethernet-ports property.
+ * The controller is programmed through MMIO. The MDIO communication is a=
bstracted by the hardware
+ * and uses the switch port number for its addressing. For this to work, =
mapping registers need to
+ * be setup in advance. With that the controller translates each port bas=
ed I/O operation into the
+ * physical bus and address. This gives the following end-to-end communic=
ation
+ *
+ *     +----------+       +----------+           +----------+       +----=
=2D-----+
+ *     |  phydev  |  ...  |  phydev  |           |  phydev  |  ...  |  ph=
ydev  |
+ *     +----------+       +----------+           +----------+       +----=
=2D-----+
+ *              |                  |               |                  |
+ *   mii_bus 0  +------------------+               +------------------+  =
mii_bus 1
+ *                                 |               |
+ *           +-----------------------------------------------------+
+ *           |  MDIO driver                                        |
+ *           |                      translate bus/address -> port  |
+ *           +-----------------------------------------------------+
+ *                                        |                             S=
oftware
+ *                             - - - - - - - - - - - - - - - - - - - - - =
- - - -
+ *                                        |                             H=
ardware
+ *           +-----------------------------------------------------+
+ *           | MDIO controller                                     |
+ *           |                      translate port -> bus/address  |
+ *           +-----------------------------------------------------+
+ *                                 |               |
+ *       bus 0  +------------------+               +------------------+  =
bus 1
+ *              |                  |               |                  |
+ *     +----------+       +----------+           +----------+       +----=
=2D-----+
+ *     | PHY 0/1  |  ...  | PHY 0/31 |           | PHY 1/1  |  ...  | PHY=
 1/31 |
+ *     +----------+       +----------+           +----------+       +----=
=2D-----+
+ *
+ * The driver works out the mapping based on the MDIO bus described in de=
vice tree and phandles on
+ * the ethernet-ports property.
  */
=20
 #include <linux/bitfield.h>
@@ -48,7 +77,7 @@
 #define MAX_SMI_BUSSES  4
 #define MAX_SMI_ADDR	0x1f
=20
-struct rtl9300_mdio_priv {
+struct otto_emdio_priv {
 	struct regmap *regmap;
 	struct mutex lock; /* protect HW access */
 	DECLARE_BITMAP(valid_ports, MAX_PORTS);
@@ -58,15 +87,15 @@ struct rtl9300_mdio_priv {
 	struct mii_bus *bus[MAX_SMI_BUSSES];
 };
=20
-struct rtl9300_mdio_chan {
-	struct rtl9300_mdio_priv *priv;
+struct otto_emdio_chan {
+	struct otto_emdio_priv *priv;
 	u8 mdio_bus;
 };
=20
-static int rtl9300_mdio_phy_to_port(struct mii_bus *bus, int phy_id)
+static int otto_emdio_phy_to_port(struct mii_bus *bus, int phy_id)
 {
-	struct rtl9300_mdio_chan *chan =3D bus->priv;
-	struct rtl9300_mdio_priv *priv;
+	struct otto_emdio_chan *chan =3D bus->priv;
+	struct otto_emdio_priv *priv;
 	int i;
=20
 	priv =3D chan->priv;
@@ -79,7 +108,7 @@ static int rtl9300_mdio_phy_to_port(struct mii_bus *bus=
, int phy_id)
 	return -ENOENT;
 }
=20
-static int rtl9300_mdio_wait_ready(struct rtl9300_mdio_priv *priv)
+static int otto_emdio_wait_ready(struct otto_emdio_priv *priv)
 {
 	struct regmap *regmap =3D priv->regmap;
 	u32 val;
@@ -90,10 +119,10 @@ static int rtl9300_mdio_wait_ready(struct rtl9300_mdi=
o_priv *priv)
 					val, !(val & PHY_CTRL_CMD), 10, 1000);
 }
=20
-static int rtl9300_mdio_read_c22(struct mii_bus *bus, int phy_id, int reg=
num)
+static int otto_emdio_9300_read_c22(struct mii_bus *bus, int phy_id, int =
regnum)
 {
-	struct rtl9300_mdio_chan *chan =3D bus->priv;
-	struct rtl9300_mdio_priv *priv;
+	struct otto_emdio_chan *chan =3D bus->priv;
+	struct otto_emdio_priv *priv;
 	struct regmap *regmap;
 	int port;
 	u32 val;
@@ -102,12 +131,12 @@ static int rtl9300_mdio_read_c22(struct mii_bus *bus=
, int phy_id, int regnum)
 	priv =3D chan->priv;
 	regmap =3D priv->regmap;
=20
-	port =3D rtl9300_mdio_phy_to_port(bus, phy_id);
+	port =3D otto_emdio_phy_to_port(bus, phy_id);
 	if (port < 0)
 		return port;
=20
 	mutex_lock(&priv->lock);
-	err =3D rtl9300_mdio_wait_ready(priv);
+	err =3D otto_emdio_wait_ready(priv);
 	if (err)
 		goto out_err;
=20
@@ -123,7 +152,7 @@ static int rtl9300_mdio_read_c22(struct mii_bus *bus, =
int phy_id, int regnum)
 	if (err)
 		goto out_err;
=20
-	err =3D rtl9300_mdio_wait_ready(priv);
+	err =3D otto_emdio_wait_ready(priv);
 	if (err)
 		goto out_err;
=20
@@ -139,10 +168,10 @@ static int rtl9300_mdio_read_c22(struct mii_bus *bus=
, int phy_id, int regnum)
 	return err;
 }
=20
-static int rtl9300_mdio_write_c22(struct mii_bus *bus, int phy_id, int re=
gnum, u16 value)
+static int otto_emdio_9300_write_c22(struct mii_bus *bus, int phy_id, int=
 regnum, u16 value)
 {
-	struct rtl9300_mdio_chan *chan =3D bus->priv;
-	struct rtl9300_mdio_priv *priv;
+	struct otto_emdio_chan *chan =3D bus->priv;
+	struct otto_emdio_priv *priv;
 	struct regmap *regmap;
 	int port;
 	u32 val;
@@ -151,12 +180,12 @@ static int rtl9300_mdio_write_c22(struct mii_bus *bu=
s, int phy_id, int regnum, u
 	priv =3D chan->priv;
 	regmap =3D priv->regmap;
=20
-	port =3D rtl9300_mdio_phy_to_port(bus, phy_id);
+	port =3D otto_emdio_phy_to_port(bus, phy_id);
 	if (port < 0)
 		return port;
=20
 	mutex_lock(&priv->lock);
-	err =3D rtl9300_mdio_wait_ready(priv);
+	err =3D otto_emdio_wait_ready(priv);
 	if (err)
 		goto out_err;
=20
@@ -194,10 +223,10 @@ static int rtl9300_mdio_write_c22(struct mii_bus *bu=
s, int phy_id, int regnum, u
 	return err;
 }
=20
-static int rtl9300_mdio_read_c45(struct mii_bus *bus, int phy_id, int dev=
_addr, int regnum)
+static int otto_emdio_9300_read_c45(struct mii_bus *bus, int phy_id, int =
dev_addr, int regnum)
 {
-	struct rtl9300_mdio_chan *chan =3D bus->priv;
-	struct rtl9300_mdio_priv *priv;
+	struct otto_emdio_chan *chan =3D bus->priv;
+	struct otto_emdio_priv *priv;
 	struct regmap *regmap;
 	int port;
 	u32 val;
@@ -206,12 +235,12 @@ static int rtl9300_mdio_read_c45(struct mii_bus *bus=
, int phy_id, int dev_addr,
 	priv =3D chan->priv;
 	regmap =3D priv->regmap;
=20
-	port =3D rtl9300_mdio_phy_to_port(bus, phy_id);
+	port =3D otto_emdio_phy_to_port(bus, phy_id);
 	if (port < 0)
 		return port;
=20
 	mutex_lock(&priv->lock);
-	err =3D rtl9300_mdio_wait_ready(priv);
+	err =3D otto_emdio_wait_ready(priv);
 	if (err)
 		goto out_err;
=20
@@ -231,7 +260,7 @@ static int rtl9300_mdio_read_c45(struct mii_bus *bus, =
int phy_id, int dev_addr,
 	if (err)
 		goto out_err;
=20
-	err =3D rtl9300_mdio_wait_ready(priv);
+	err =3D otto_emdio_wait_ready(priv);
 	if (err)
 		goto out_err;
=20
@@ -247,11 +276,11 @@ static int rtl9300_mdio_read_c45(struct mii_bus *bus=
, int phy_id, int dev_addr,
 	return err;
 }
=20
-static int rtl9300_mdio_write_c45(struct mii_bus *bus, int phy_id, int de=
v_addr,
+static int otto_emdio_9300_write_c45(struct mii_bus *bus, int phy_id, int=
 dev_addr,
 				  int regnum, u16 value)
 {
-	struct rtl9300_mdio_chan *chan =3D bus->priv;
-	struct rtl9300_mdio_priv *priv;
+	struct otto_emdio_chan *chan =3D bus->priv;
+	struct otto_emdio_priv *priv;
 	struct regmap *regmap;
 	int port;
 	u32 val;
@@ -260,12 +289,12 @@ static int rtl9300_mdio_write_c45(struct mii_bus *bu=
s, int phy_id, int dev_addr,
 	priv =3D chan->priv;
 	regmap =3D priv->regmap;
=20
-	port =3D rtl9300_mdio_phy_to_port(bus, phy_id);
+	port =3D otto_emdio_phy_to_port(bus, phy_id);
 	if (port < 0)
 		return port;
=20
 	mutex_lock(&priv->lock);
-	err =3D rtl9300_mdio_wait_ready(priv);
+	err =3D otto_emdio_wait_ready(priv);
 	if (err)
 		goto out_err;
=20
@@ -307,7 +336,7 @@ static int rtl9300_mdio_write_c45(struct mii_bus *bus,=
 int phy_id, int dev_addr,
 	return err;
 }
=20
-static int rtl9300_mdiobus_init(struct rtl9300_mdio_priv *priv)
+static int otto_emdio_9300_mdiobus_init(struct otto_emdio_priv *priv)
 {
 	u32 glb_ctrl_mask =3D 0, glb_ctrl_val =3D 0;
 	struct regmap *regmap =3D priv->regmap;
@@ -350,10 +379,10 @@ static int rtl9300_mdiobus_init(struct rtl9300_mdio_=
priv *priv)
 	return 0;
 }
=20
-static int rtl9300_mdiobus_probe_one(struct device *dev, struct rtl9300_m=
dio_priv *priv,
-				     struct fwnode_handle *node)
+static int otto_emdio_probe_one(struct device *dev, struct otto_emdio_pri=
v *priv,
+				 struct fwnode_handle *node)
 {
-	struct rtl9300_mdio_chan *chan;
+	struct otto_emdio_chan *chan;
 	struct mii_bus *bus;
 	u32 mdio_bus;
 	int err;
@@ -380,11 +409,11 @@ static int rtl9300_mdiobus_probe_one(struct device *=
dev, struct rtl9300_mdio_pri
=20
 	bus->name =3D "Realtek Switch MDIO Bus";
 	if (priv->smi_bus_is_c45[mdio_bus]) {
-		bus->read_c45 =3D rtl9300_mdio_read_c45;
-		bus->write_c45 =3D  rtl9300_mdio_write_c45;
+		bus->read_c45 =3D otto_emdio_9300_read_c45;
+		bus->write_c45 =3D otto_emdio_9300_write_c45;
 	} else {
-		bus->read =3D rtl9300_mdio_read_c22;
-		bus->write =3D rtl9300_mdio_write_c22;
+		bus->read =3D otto_emdio_9300_read_c22;
+		bus->write =3D otto_emdio_9300_write_c22;
 	}
 	bus->parent =3D dev;
 	chan =3D bus->priv;
@@ -404,9 +433,9 @@ static int rtl9300_mdiobus_probe_one(struct device *de=
v, struct rtl9300_mdio_pri
  * ethernet-ports node and build a mapping of the switch port to MDIO bus=
/addr
  * based on the phy-handle.
  */
-static int rtl9300_mdiobus_map_ports(struct device *dev)
+static int otto_emdio_map_ports(struct device *dev)
 {
-	struct rtl9300_mdio_priv *priv =3D dev_get_drvdata(dev);
+	struct otto_emdio_priv *priv =3D dev_get_drvdata(dev);
 	struct device *parent =3D dev->parent;
 	int err;
=20
@@ -462,10 +491,10 @@ static int rtl9300_mdiobus_map_ports(struct device *=
dev)
 	return 0;
 }
=20
-static int rtl9300_mdiobus_probe(struct platform_device *pdev)
+static int otto_emdio_probe(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
-	struct rtl9300_mdio_priv *priv;
+	struct otto_emdio_priv *priv;
 	int err;
=20
 	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -482,38 +511,38 @@ static int rtl9300_mdiobus_probe(struct platform_dev=
ice *pdev)
=20
 	platform_set_drvdata(pdev, priv);
=20
-	err =3D rtl9300_mdiobus_map_ports(dev);
+	err =3D otto_emdio_map_ports(dev);
 	if (err)
 		return err;
=20
 	device_for_each_child_node_scoped(dev, child) {
-		err =3D rtl9300_mdiobus_probe_one(dev, priv, child);
+		err =3D otto_emdio_probe_one(dev, priv, child);
 		if (err)
 			return err;
 	}
=20
-	err =3D rtl9300_mdiobus_init(priv);
+	err =3D otto_emdio_9300_mdiobus_init(priv);
 	if (err)
 		return dev_err_probe(dev, err, "failed to initialise MDIO bus controlle=
r\n");
=20
 	return 0;
 }
=20
-static const struct of_device_id rtl9300_mdio_ids[] =3D {
+static const struct of_device_id otto_emdio_ids[] =3D {
 	{ .compatible =3D "realtek,rtl9301-mdio" },
 	{}
 };
-MODULE_DEVICE_TABLE(of, rtl9300_mdio_ids);
+MODULE_DEVICE_TABLE(of, otto_emdio_ids);
=20
-static struct platform_driver rtl9300_mdio_driver =3D {
-	.probe =3D rtl9300_mdiobus_probe,
+static struct platform_driver otto_emdio_driver =3D {
+	.probe =3D otto_emdio_probe,
 	.driver =3D {
 		.name =3D "mdio-rtl9300",
-		.of_match_table =3D rtl9300_mdio_ids,
+		.of_match_table =3D otto_emdio_ids,
 	},
 };
=20
-module_platform_driver(rtl9300_mdio_driver);
+module_platform_driver(otto_emdio_driver);
=20
 MODULE_DESCRIPTION("RTL9300 MDIO driver");
 MODULE_LICENSE("GPL");
=2D-=20
2.54.0


