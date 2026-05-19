Return-Path: <netdev+bounces-289533-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKkuM0yYDGrWjgUAu9opvQ
	(envelope-from <netdev+bounces-289533-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:05:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB37582D0C
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 973D4306467F
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DC82A1B2;
	Tue, 19 May 2026 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="eBW0jOC2"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEF9409108
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779209909; cv=none; b=WWTkMD3dAN4yrD9U+DxC9CuIuXvKMZegYGP0WfXnPohAOYSrPbTVvCq/UfbQwM08hhYURJrD80EqtOpvNvFQoBzsHACRcB1ss8oLjforYN3qkNkOWj/9EnsTNiuk81fijJS2ZOH/UXhIAqCAGUDfnKUDi83fHiNBCqliW4rzZGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779209909; c=relaxed/simple;
	bh=tD2pf1RtTar4lIiMfRq849xiVsq5JB9G61Ez+sYmDuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEqY3A6yrXr++BEgJFDwLH1IKGzRec4cObQYu7uHSp6MfbMj6nGiYrIU+ARwgfWBE3IZ2o6bN47yQSUThwTSlp4AL9ViZqgRUwOmID5m+44Jx5qrH6O9GkwuB3vkPXyLPx//CHaq0D0zc52gZS5augjNUEMfJn2nfRNHsKI2Tcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=eBW0jOC2; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779209889; x=1779814689;
	i=markus.stockhausen@gmx.de;
	bh=RDUUzGnLyHGd5oRdEEvOcz9Yfvh4RVJPNlMPzTPz+0s=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eBW0jOC2fH8AJ3ZjFpT6bx9NjncxG6xCgg2zwQO87FgjxhzJZ/LfXr8gtmUhhsTx
	 Nm+HpEa3lrGgDcZHoUWY3ViwdZZiuFtvNh6vzuQ9MUyNF4kTx31ITiBlBn7imr7Hw
	 T/jJCl1tIuRva+hhwEYM/vzUIDsV5VXel/6fA8nzfWed78Kr14b9zPXYoyN0jgsJX
	 8p1+nlFC2JyZfeSETByknqtgICcbolZ2VuToL+oZBBvdaRa6uUan7nSvm4Mt2aRs7
	 xBKQeKZCNg6JoEfGqGhiAW5JhYy3g9+cLXkPyAtb9L0GjxiVPaP8nvEXA7rT3diT1
	 YrAdZOWBwCa1uVeucA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVeI2-1womP63vq0-00Uspr; Tue, 19
 May 2026 18:58:08 +0200
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
Subject: [PATCH 1/9] net: mdio: realtek-rtl9300: Convert to generic prefix
Date: Tue, 19 May 2026 18:57:39 +0200
Message-ID: <20260519165747.1288903-2-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519165747.1288903-1-markus.stockhausen@gmx.de>
References: <20260519165747.1288903-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dyXBM749/ijmrI/rC4bIS6HM5H+Er2SxPtRcAIpyT4GldMDqC+f
 6998Cv/OZj2iMhdTKtI1bDWN0anL49LQz3iYDjeU+nJO8VFODTUuF5k+pTAzO5x0/QhVdks
 5fwFOLfhqpIzku59afSRi57wSIZ89BYTlx+abffBxN9xxqfMhITBWI58jS1MarQhWjOwIUy
 xVQDUaEFl90idH7JyCung==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MlIap+nV+y8=;+eTfiI9cyaUyyoEsojABC5djqtO
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-289533-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Queue-Id: CEB37582D0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Realtek MDIO driver currently only serves SOCs from the Realtek
RTL930x series. This is only one lineup of the Realtek Otto switch
series that also knows RTL838x, RTL839x, RTL931x devices.

All of these share the same MDIO logic but have individual properties.
To make clear what is devic specific and what is device independent
split the function/structure prefix as follows:

- for device specific helpers keep rtl9300_
- Rename generic functions and structures to rtl_

Remark: rtl9300_mdio_wait_ready is being renamed as the command bit
is always the same in all SOCs. The read/write functions are not
renamed (yet) because they will only fit the RTL930x SOCs.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 82 ++++++++++++-------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 8d5fb014ca06..a3374d5241cb 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -48,7 +48,7 @@
 #define MAX_SMI_BUSSES  4
 #define MAX_SMI_ADDR	0x1f
=20
-struct rtl9300_mdio_priv {
+struct rtl_mdio_priv {
 	struct regmap *regmap;
 	struct mutex lock; /* protect HW access */
 	DECLARE_BITMAP(valid_ports, MAX_PORTS);
@@ -58,15 +58,15 @@ struct rtl9300_mdio_priv {
 	struct mii_bus *bus[MAX_SMI_BUSSES];
 };
=20
-struct rtl9300_mdio_chan {
-	struct rtl9300_mdio_priv *priv;
+struct rtl_mdio_chan {
+	struct rtl_mdio_priv *priv;
 	u8 mdio_bus;
 };
=20
-static int rtl9300_mdio_phy_to_port(struct mii_bus *bus, int phy_id)
+static int rtl_mdio_phy_to_port(struct mii_bus *bus, int phy_id)
 {
-	struct rtl9300_mdio_chan *chan =3D bus->priv;
-	struct rtl9300_mdio_priv *priv;
+	struct rtl_mdio_chan *chan =3D bus->priv;
+	struct rtl_mdio_priv *priv;
 	int i;
=20
 	priv =3D chan->priv;
@@ -79,7 +79,7 @@ static int rtl9300_mdio_phy_to_port(struct mii_bus *bus,=
 int phy_id)
 	return -ENOENT;
 }
=20
-static int rtl9300_mdio_wait_ready(struct rtl9300_mdio_priv *priv)
+static int rtl_mdio_wait_ready(struct rtl_mdio_priv *priv)
 {
 	struct regmap *regmap =3D priv->regmap;
 	u32 val;
@@ -92,8 +92,8 @@ static int rtl9300_mdio_wait_ready(struct rtl9300_mdio_p=
riv *priv)
=20
 static int rtl9300_mdio_read_c22(struct mii_bus *bus, int phy_id, int reg=
num)
 {
-	struct rtl9300_mdio_chan *chan =3D bus->priv;
-	struct rtl9300_mdio_priv *priv;
+	struct rtl_mdio_chan *chan =3D bus->priv;
+	struct rtl_mdio_priv *priv;
 	struct regmap *regmap;
 	int port;
 	u32 val;
@@ -102,12 +102,12 @@ static int rtl9300_mdio_read_c22(struct mii_bus *bus=
, int phy_id, int regnum)
 	priv =3D chan->priv;
 	regmap =3D priv->regmap;
=20
-	port =3D rtl9300_mdio_phy_to_port(bus, phy_id);
+	port =3D rtl_mdio_phy_to_port(bus, phy_id);
 	if (port < 0)
 		return port;
=20
 	mutex_lock(&priv->lock);
-	err =3D rtl9300_mdio_wait_ready(priv);
+	err =3D rtl_mdio_wait_ready(priv);
 	if (err)
 		goto out_err;
=20
@@ -123,7 +123,7 @@ static int rtl9300_mdio_read_c22(struct mii_bus *bus, =
int phy_id, int regnum)
 	if (err)
 		goto out_err;
=20
-	err =3D rtl9300_mdio_wait_ready(priv);
+	err =3D rtl_mdio_wait_ready(priv);
 	if (err)
 		goto out_err;
=20
@@ -141,8 +141,8 @@ static int rtl9300_mdio_read_c22(struct mii_bus *bus, =
int phy_id, int regnum)
=20
 static int rtl9300_mdio_write_c22(struct mii_bus *bus, int phy_id, int re=
gnum, u16 value)
 {
-	struct rtl9300_mdio_chan *chan =3D bus->priv;
-	struct rtl9300_mdio_priv *priv;
+	struct rtl_mdio_chan *chan =3D bus->priv;
+	struct rtl_mdio_priv *priv;
 	struct regmap *regmap;
 	int port;
 	u32 val;
@@ -151,12 +151,12 @@ static int rtl9300_mdio_write_c22(struct mii_bus *bu=
s, int phy_id, int regnum, u
 	priv =3D chan->priv;
 	regmap =3D priv->regmap;
=20
-	port =3D rtl9300_mdio_phy_to_port(bus, phy_id);
+	port =3D rtl_mdio_phy_to_port(bus, phy_id);
 	if (port < 0)
 		return port;
=20
 	mutex_lock(&priv->lock);
-	err =3D rtl9300_mdio_wait_ready(priv);
+	err =3D rtl_mdio_wait_ready(priv);
 	if (err)
 		goto out_err;
=20
@@ -196,8 +196,8 @@ static int rtl9300_mdio_write_c22(struct mii_bus *bus,=
 int phy_id, int regnum, u
=20
 static int rtl9300_mdio_read_c45(struct mii_bus *bus, int phy_id, int dev=
_addr, int regnum)
 {
-	struct rtl9300_mdio_chan *chan =3D bus->priv;
-	struct rtl9300_mdio_priv *priv;
+	struct rtl_mdio_chan *chan =3D bus->priv;
+	struct rtl_mdio_priv *priv;
 	struct regmap *regmap;
 	int port;
 	u32 val;
@@ -206,12 +206,12 @@ static int rtl9300_mdio_read_c45(struct mii_bus *bus=
, int phy_id, int dev_addr,
 	priv =3D chan->priv;
 	regmap =3D priv->regmap;
=20
-	port =3D rtl9300_mdio_phy_to_port(bus, phy_id);
+	port =3D rtl_mdio_phy_to_port(bus, phy_id);
 	if (port < 0)
 		return port;
=20
 	mutex_lock(&priv->lock);
-	err =3D rtl9300_mdio_wait_ready(priv);
+	err =3D rtl_mdio_wait_ready(priv);
 	if (err)
 		goto out_err;
=20
@@ -231,7 +231,7 @@ static int rtl9300_mdio_read_c45(struct mii_bus *bus, =
int phy_id, int dev_addr,
 	if (err)
 		goto out_err;
=20
-	err =3D rtl9300_mdio_wait_ready(priv);
+	err =3D rtl_mdio_wait_ready(priv);
 	if (err)
 		goto out_err;
=20
@@ -250,8 +250,8 @@ static int rtl9300_mdio_read_c45(struct mii_bus *bus, =
int phy_id, int dev_addr,
 static int rtl9300_mdio_write_c45(struct mii_bus *bus, int phy_id, int de=
v_addr,
 				  int regnum, u16 value)
 {
-	struct rtl9300_mdio_chan *chan =3D bus->priv;
-	struct rtl9300_mdio_priv *priv;
+	struct rtl_mdio_chan *chan =3D bus->priv;
+	struct rtl_mdio_priv *priv;
 	struct regmap *regmap;
 	int port;
 	u32 val;
@@ -260,12 +260,12 @@ static int rtl9300_mdio_write_c45(struct mii_bus *bu=
s, int phy_id, int dev_addr,
 	priv =3D chan->priv;
 	regmap =3D priv->regmap;
=20
-	port =3D rtl9300_mdio_phy_to_port(bus, phy_id);
+	port =3D rtl_mdio_phy_to_port(bus, phy_id);
 	if (port < 0)
 		return port;
=20
 	mutex_lock(&priv->lock);
-	err =3D rtl9300_mdio_wait_ready(priv);
+	err =3D rtl_mdio_wait_ready(priv);
 	if (err)
 		goto out_err;
=20
@@ -307,7 +307,7 @@ static int rtl9300_mdio_write_c45(struct mii_bus *bus,=
 int phy_id, int dev_addr,
 	return err;
 }
=20
-static int rtl9300_mdiobus_init(struct rtl9300_mdio_priv *priv)
+static int rtl9300_mdiobus_init(struct rtl_mdio_priv *priv)
 {
 	u32 glb_ctrl_mask =3D 0, glb_ctrl_val =3D 0;
 	struct regmap *regmap =3D priv->regmap;
@@ -350,10 +350,10 @@ static int rtl9300_mdiobus_init(struct rtl9300_mdio_=
priv *priv)
 	return 0;
 }
=20
-static int rtl9300_mdiobus_probe_one(struct device *dev, struct rtl9300_m=
dio_priv *priv,
-				     struct fwnode_handle *node)
+static int rtl_mdiobus_probe_one(struct device *dev, struct rtl_mdio_priv=
 *priv,
+				 struct fwnode_handle *node)
 {
-	struct rtl9300_mdio_chan *chan;
+	struct rtl_mdio_chan *chan;
 	struct mii_bus *bus;
 	u32 mdio_bus;
 	int err;
@@ -404,9 +404,9 @@ static int rtl9300_mdiobus_probe_one(struct device *de=
v, struct rtl9300_mdio_pri
  * ethernet-ports node and build a mapping of the switch port to MDIO bus=
/addr
  * based on the phy-handle.
  */
-static int rtl9300_mdiobus_map_ports(struct device *dev)
+static int rtl_mdiobus_map_ports(struct device *dev)
 {
-	struct rtl9300_mdio_priv *priv =3D dev_get_drvdata(dev);
+	struct rtl_mdio_priv *priv =3D dev_get_drvdata(dev);
 	struct device *parent =3D dev->parent;
 	int err;
=20
@@ -462,10 +462,10 @@ static int rtl9300_mdiobus_map_ports(struct device *=
dev)
 	return 0;
 }
=20
-static int rtl9300_mdiobus_probe(struct platform_device *pdev)
+static int rtl_mdiobus_probe(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
-	struct rtl9300_mdio_priv *priv;
+	struct rtl_mdio_priv *priv;
 	int err;
=20
 	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -482,12 +482,12 @@ static int rtl9300_mdiobus_probe(struct platform_dev=
ice *pdev)
=20
 	platform_set_drvdata(pdev, priv);
=20
-	err =3D rtl9300_mdiobus_map_ports(dev);
+	err =3D rtl_mdiobus_map_ports(dev);
 	if (err)
 		return err;
=20
 	device_for_each_child_node_scoped(dev, child) {
-		err =3D rtl9300_mdiobus_probe_one(dev, priv, child);
+		err =3D rtl_mdiobus_probe_one(dev, priv, child);
 		if (err)
 			return err;
 	}
@@ -499,21 +499,21 @@ static int rtl9300_mdiobus_probe(struct platform_dev=
ice *pdev)
 	return 0;
 }
=20
-static const struct of_device_id rtl9300_mdio_ids[] =3D {
+static const struct of_device_id rtl_mdio_ids[] =3D {
 	{ .compatible =3D "realtek,rtl9301-mdio" },
 	{}
 };
-MODULE_DEVICE_TABLE(of, rtl9300_mdio_ids);
+MODULE_DEVICE_TABLE(of, rtl_mdio_ids);
=20
-static struct platform_driver rtl9300_mdio_driver =3D {
-	.probe =3D rtl9300_mdiobus_probe,
+static struct platform_driver rtl_mdio_driver =3D {
+	.probe =3D rtl_mdiobus_probe,
 	.driver =3D {
 		.name =3D "mdio-rtl9300",
-		.of_match_table =3D rtl9300_mdio_ids,
+		.of_match_table =3D rtl_mdio_ids,
 	},
 };
=20
-module_platform_driver(rtl9300_mdio_driver);
+module_platform_driver(rtl_mdio_driver);
=20
 MODULE_DESCRIPTION("RTL9300 MDIO driver");
 MODULE_LICENSE("GPL");
=2D-=20
2.54.0


