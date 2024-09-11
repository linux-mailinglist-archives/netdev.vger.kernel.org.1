Return-Path: <netdev+bounces-127532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 010BB975AE0
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 21:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF88286423
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 19:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842F41B5808;
	Wed, 11 Sep 2024 19:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="ksk2lRff"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288E358AC4
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 19:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726083304; cv=none; b=Uq6+kjdog+2TP6r6RiicLFKQJAukGNyDbA2xy5eq+DwK7uzpMOZZ5wiG66wAc7O/L6V8FSLUE6wMjZNOb6HVVzZSMMIhwGzKq3E2E5y8mUYHaUlFSbrymoWqLNlRQdChoESmDpCK/j7/Zcny2inxEMhMsEPPCmx5KjZymE7qoyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726083304; c=relaxed/simple;
	bh=axuNo1nZ2tu+F0uU6zs0BBBVhTEUVv7cZlRk5j+0yU8=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date; b=sjfP/kXG2FgU4KcG19gz1JhzUTRctkentC9dWVV68yHCSaojhxIGlt1W69ePOIzCfqml7xAc8vOWUWxV80+xM9WT9WbEoDGIV4Zke1RcoH4/GIjYqYNmGXhBLkfLuYFrXXKZldDjchP8u5zYpDzA5F0n4VkpkB5VYthqloIMvPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=ksk2lRff; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1726083287; x=1726688087; i=hfdevel@gmx.net;
	bh=jT6lr+wj/vlcXsGK+AgyJh78W0qnZTV364UzhMOA6P0=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ksk2lRff8fX9qB1pFkQ9Z+xHrfCXUrMjgtlNHlICP5O4jm7Uye6w2VxbkTGywwhX
	 iX2kUB9Jcy53pRSUwYY52ja4r/Amus4/ChobN2iyOfolNKzVNVOfJsHLe1V1Ay+nH
	 ljUhSrnl5f/yoV26xtLR521vHCig03ImAOgReSxFNGsDOqcOkokmNGgFcCBOfv/K6
	 rtUQqaOcjqaY+wy1ZdJ15VxKO5Ymyf44TzFsXgOh56IzNM+jYDmwxVC8zfX4LotEc
	 cLbIutXDaGZwfG/eZtWp6fUufi3PzRzanUiCIlDNZ1VeFhlZ+QOtnIQdpEDSFLl0W
	 y97eyQkOwkhXaZxP3Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [77.33.175.99] ([77.33.175.99]) by web-mail.gmx.net
 (3c-app-gmx-bs04.server.lan [172.19.170.53]) (via HTTP); Wed, 11 Sep 2024
 21:34:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-e71bfb76-697e-4f08-a106-40cb6672054f-1726083287252@3c-app-gmx-bs04>
From: Hans-Frieder Vogt <hfdevel@gmx.net>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 5/5] net: tn40xx: register swnode and connect it to
 the mdiobus
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Sep 2024 21:34:47 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:DOTfdgfSNfF7nZLdh5ovdzHc711UDiIr1Bpr+ZhYU2oI7vQqQtUnCPmF+tAHng/8ZMw6P
 MuLn/FBMVWS0fcW6tR0W6agCNjBOsUhs+7vVgQQV58cP2Yw/achgtEwQoxWbcvFF0m2yp1g0Rqki
 hpWD5K35zrLrsccdtu/03p6rS+IynecIHlorYIbH0+Q1CkPp2NGxQamRlQvcgVl5+Lqnww2dsdSX
 wRhhmsIMiSRAvjKQuwoq8PPB/92ApzpudGvjVjYaSTG19Twl0xkAF1wg+Hl533z++N0e/b3Ajo/f
 rc=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1YdswcYv9EQ=;D83lWTlp3uGf/sGNg5E+cqvDQkL
 mt88iYtZgl5zqyKUkzE51flFuWBUIc4V6TEgmFXiaZrhzJf1vCVLoXLEJHkAysukDO7YLWPow
 dYJ5/Dtr90ruj2agqDT5tKy45W1cn43F8p2PNCBJn3VbP+kDxOb07fQ0cL7pQnSUNf7nigzH7
 /C6cDzE3om/An2VRX42K+ilSckfrx5zyg7pijD0flm89h/HlXCpdbedtQhSGKOTzvuYvItgcl
 4/n1sqNUfh3/Chi46gfVwQgCmnLucUlqLUP8JrFuty4fMXYIWpc+E/yz7DmohDxXDdxFrn4+P
 FXvdmR+kR5PPvrFrjIa6nOQNQT6TP+V+JmvHRMebQyK85Ew5bVcMlLtsVWzMgr8HO8zF4TfH0
 wLwTttp4FON9nQNmik5TyskWnivLje7X9gl5rZbFAKgCCtKIYS0+NO/i6Ma5WpTmVNcbdJTov
 pBeLh4FEXvXSf0O3T7yglzp76SyUd85i2yZk7u/0gh1rROYZ/DSd+2rBj6S22g7jOT8uqqymG
 WA+ctead7byDg6JH8gbI6DYPC1hEJeKGcek2HOGuIiFUB2mNtT4vaNZBBrPRwRzRoc1IK8xNT
 p/IbVw650Ws7zT2z99zfpAN0VgTxGtrxlwIeuKq9441QRVc/3GJSO1eVj4B76Tajr8rohUdNq
 83O9+xLwZU3bKvDSKzF87iKIrbKqSdu4cxYmLflo4Q==
Content-Transfer-Encoding: quoted-printable

Create a software node (or fwnode) for the mdio function
and a linked node for the Aquantia AQR105 PHY, providing a firmware-name t=
o
allow the PHY to load a MAC/MDIO specific firmware.

I suggest to place the firmware in the directory, where there is already
the firmware for the TN4010 MAC, so avoid pollution of the firmware
directory.

There is currently a little problem in the code that leads to an extra
increment of the usage counter of the software node
priv->nodes.group[SWNODE_MDIO] somewhere.
Therefore, I need to unregister it twice. This is hopefully only a
temporary workaround.

Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
=2D--
 drivers/net/ethernet/tehuti/tn40.c      | 10 +++-
 drivers/net/ethernet/tehuti/tn40.h      | 25 ++++++++++
 drivers/net/ethernet/tehuti/tn40_mdio.c | 63 ++++++++++++++++++++++++-
 3 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/teh=
uti/tn40.c
index 4e6f2f781ffc..240a79a08d58 100644
=2D-- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -1781,7 +1781,7 @@ static int tn40_probe(struct pci_dev *pdev, const st=
ruct pci_device_id *ent)
 	ret =3D tn40_phy_register(priv);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to set up PHY.\n");
-		goto err_free_irq;
+		goto err_unregister_swnodes;
 	}

 	ret =3D tn40_priv_init(priv);
@@ -1798,6 +1798,10 @@ static int tn40_probe(struct pci_dev *pdev, const s=
truct pci_device_id *ent)
 	return 0;
 err_unregister_phydev:
 	tn40_phy_unregister(priv);
+err_unregister_swnodes:
+	device_remove_software_node(&priv->mdio->dev);
+	software_node_unregister_node_group(priv->nodes.group);
+	software_node_unregister(priv->nodes.group[SWNODE_MDIO]);
 err_free_irq:
 	pci_free_irq_vectors(pdev);
 err_unset_drvdata:
@@ -1819,6 +1823,10 @@ static void tn40_remove(struct pci_dev *pdev)
 	unregister_netdev(ndev);

 	tn40_phy_unregister(priv);
+	/* cleanup software nodes */
+	device_remove_software_node(&priv->mdio->dev);
+	software_node_unregister_node_group(priv->nodes.group);
+	software_node_unregister(priv->nodes.group[SWNODE_MDIO]);
 	pci_free_irq_vectors(priv->pdev);
 	pci_set_drvdata(pdev, NULL);
 	iounmap(priv->regs);
diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/teh=
uti/tn40.h
index 490781fe5120..1897c79333f8 100644
=2D-- a/drivers/net/ethernet/tehuti/tn40.h
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -4,6 +4,7 @@
 #ifndef _TN40_H_
 #define _TN40_H_

+#include <linux/property.h>
 #include "tn40_regs.h"

 #define TN40_DRV_NAME "tn40xx"
@@ -102,10 +103,34 @@ struct tn40_txdb {
 	int size; /* Number of elements in the db */
 };

+#define NODE_PROP(_NAME, _PROP)	(		\
+	(const struct software_node) {		\
+		.name =3D _NAME,			\
+		.properties =3D _PROP,		\
+	})
+
+enum tn40_swnodes {
+	SWNODE_MDIO,
+	SWNODE_PHY,
+	SWNODE_MAX
+};
+
+struct tn40_nodes {
+	char phy_name[32];
+	char mdio_name[32];
+	struct property_entry phy_props[2];
+	struct property_entry mdio_props[1];
+	struct software_node_ref_args phy_ref[1];
+	struct software_node swnodes[SWNODE_MAX];
+	const struct software_node *group[SWNODE_MAX + 1];
+};
+
 struct tn40_priv {
 	struct net_device *ndev;
 	struct pci_dev *pdev;

+	struct tn40_nodes nodes;
+
 	struct napi_struct napi;
 	/* RX FIFOs: 1 for data (full) descs, and 2 for free descs */
 	struct tn40_rxd_fifo rxd_fifo0;
diff --git a/drivers/net/ethernet/tehuti/tn40_mdio.c b/drivers/net/etherne=
t/tehuti/tn40_mdio.c
index af18615d64a8..bbd95fabbea0 100644
=2D-- a/drivers/net/ethernet/tehuti/tn40_mdio.c
+++ b/drivers/net/ethernet/tehuti/tn40_mdio.c
@@ -14,6 +14,8 @@
 	 (FIELD_PREP(TN40_MDIO_PRTAD_MASK, (port))))
 #define TN40_MDIO_CMD_READ BIT(15)

+#define AQR105_FIRMWARE "tehuti/aqr105-tn40xx.cld"
+
 static void tn40_mdio_set_speed(struct tn40_priv *priv, u32 speed)
 {
 	void __iomem *regs =3D priv->regs;
@@ -111,6 +113,44 @@ static int tn40_mdio_write_c45(struct mii_bus *mii_bu=
s, int addr, int devnum,
 	return  tn40_mdio_write(mii_bus->priv, addr, devnum, regnum, val);
 }

+/* registers an mdio handle and an aqr105 PHY
+ * tn40_mdio-%id {
+ *	phy-handle =3D <&tn40_aqr105_phy>;
+ * };
+ * tn40_aqr105_phy {
+ *	compatible =3D "ethernet-phy-id03a1.b4a3";
+ *	firmware-name =3D AQR105_FIRMWARE;
+ * };
+ */
+static int tn40_swnodes_register(struct tn40_priv *priv)
+{
+	struct tn40_nodes *nodes =3D &priv->nodes;
+	struct pci_dev *pdev =3D priv->pdev;
+	struct software_node *swnodes;
+	u32 id;
+
+	id =3D pci_dev_id(pdev);
+
+	snprintf(nodes->phy_name, sizeof(nodes->phy_name), "tn40_aqr105_phy");
+	snprintf(nodes->mdio_name, sizeof(nodes->mdio_name), "tn40_mdio-%x",
+		 id);
+
+	swnodes =3D nodes->swnodes;
+
+	nodes->phy_props[0] =3D PROPERTY_ENTRY_STRING("compatible",
+						    "ethernet-phy-id03a1.b4a3");
+	nodes->phy_props[1] =3D PROPERTY_ENTRY_STRING("firmware-name",
+						    AQR105_FIRMWARE);
+	swnodes[SWNODE_PHY] =3D NODE_PROP(nodes->phy_name, nodes->phy_props);
+	nodes->phy_ref[0] =3D SOFTWARE_NODE_REFERENCE(&swnodes[SWNODE_PHY]);
+
+	nodes->mdio_props[0] =3D PROPERTY_ENTRY_REF_ARRAY("phy", nodes->phy_ref)=
;
+	swnodes[SWNODE_MDIO] =3D NODE_PROP(nodes->mdio_name, nodes->mdio_props);
+	nodes->group[SWNODE_PHY] =3D &swnodes[SWNODE_PHY];
+	nodes->group[SWNODE_MDIO] =3D &swnodes[SWNODE_MDIO];
+	return software_node_register_node_group(nodes->group);
+}
+
 int tn40_mdiobus_init(struct tn40_priv *priv)
 {
 	struct pci_dev *pdev =3D priv->pdev;
@@ -130,13 +170,34 @@ int tn40_mdiobus_init(struct tn40_priv *priv)
 	bus->read_c45 =3D tn40_mdio_read_c45;
 	bus->write_c45 =3D tn40_mdio_write_c45;

+	ret =3D tn40_swnodes_register(priv);
+	if (ret) {
+		pr_err("swnodes failed\n");
+		return ret;
+	}
+
+	ret =3D device_add_software_node(&bus->dev,
+				       priv->nodes.group[SWNODE_MDIO]);
+	if (ret) {
+		dev_err(&pdev->dev, "device_add_software_node failed: %d\n",
+			ret);
+	}
+
 	ret =3D devm_mdiobus_register(&pdev->dev, bus);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register mdiobus %d %u %u\n",
 			ret, bus->state, MDIOBUS_UNREGISTERED);
-		return ret;
+		goto err_swnodes_unregister;
 	}
 	tn40_mdio_set_speed(priv, TN40_MDIO_SPEED_6MHZ);
 	priv->mdio =3D bus;
 	return 0;
+
+err_swnodes_unregister:
+	device_remove_software_node(&bus->dev);
+	software_node_unregister_node_group(priv->nodes.group);
+	software_node_unregister(priv->nodes.group[SWNODE_MDIO]);
+	return ret;
 }
+
+MODULE_FIRMWARE(AQR105_FIRMWARE);
=2D-
2.45.2


