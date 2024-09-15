Return-Path: <netdev+bounces-128442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CACB9798A0
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 22:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2CFD1F2158D
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 20:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260112209F;
	Sun, 15 Sep 2024 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="VWO3sNtw"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC8DEAE7
	for <netdev@vger.kernel.org>; Sun, 15 Sep 2024 20:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726430567; cv=none; b=mGxjAgiEn4jVdTlZdJQpA7RD7GWx3alHxIWGJthBYHdCn9z9mCrtncWB2WPVSmEwnr7PgWgW3YYJvuS32Bq7RQZuUmXuNuufxb2kPFFv3mv02A0c00UZhau1Vel2cWpSERylGB6WdzKeCLeDdrZYDKe3SETyw4B9F1Oni896rEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726430567; c=relaxed/simple;
	bh=Ephtr5oOsQS9kPD5YO1grfkEHKRUoXF/eA9uDddGMxQ=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date; b=b9tsEU0lWVUQPiL33b8HH/QXA9EZNi6fmspDBKiNlNAeQaZfbTtzNx0fhI1/ZAZeXMIrIZbB0I4SPb6Hv73kjEiFP2JndzvHv7JE/WT1sbrG6xZCMTh+nN26ypcp2QXwH8+wJFtv5voRAJ2rhNPSAP8K7w0GGSv/8sqY2LHufm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=VWO3sNtw; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1726430547; x=1727035347; i=hfdevel@gmx.net;
	bh=G/pb2V+0FYFTdsUSNahAPG5pP/o6slUX+JjhleT9Sxc=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VWO3sNtwcFQhPeSP55sppC4DK71oy/1yBEUYPdmwl9yBtg/r83aW9HZvmHHeQtOb
	 Df26xA9K/hS0LVfiLRo9N+VQJk+uk3j8M+lg3MIUOS4ZwZ/fZ+e0nY49I2H14mUOd
	 5zXGTaFON9c4bDRVLE4n+I083qNCrkVMzi/qwfCryCfEgri+DAR7vXrWCh61XbOFo
	 W7lSXyVroHN2i0HqjtW79N537VeJa6EIyLlc0WkPIGTa9lUB1+mDnYKAl3Ec2K0xf
	 ohBw4p9pLG6G2qlG5c2HUWNzhmJQqvgdfNwDbsweBZPLnFgSWHGpi0m3A5BUueMLv
	 FbUHnnltagtcjLgjsA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [77.33.175.99] ([77.33.175.99]) by web-mail.gmx.net
 (3c-app-gmx-bap07.server.lan [172.19.172.77]) (via HTTP); Sun, 15 Sep 2024
 22:02:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-42eaee9a-aa3c-4923-bcee-329d2841997d-1726430547232@3c-app-gmx-bap07>
From: Hans-Frieder Vogt <hfdevel@gmx.net>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 4/7] net: tn40xx: create software node for mdio
 and phy and add to mdiobus
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Sep 2024 22:02:27 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:VrO+Wmon3buZLHPsKdEmh48E6KDjNIWFPdFCMDRPOuubtQks7otZSZdPCEHxgTQwBT0t5
 aRsdlEZ7NG3j9lryM4ZF7URattrSSTSgCG8r3QuyCJZMxZfJZven/XcxjYTujTXnTGV4mCoP67dd
 JUFdAY6fVp5S/7Exnciu1ptF/7L/hzpz3S2AiYcOLJwjDRFz3VlwBWtYSCnQKyHm5DCeZBXh56P3
 4UptXYejJOesZ2LRwN8icLPowzBz091cbJTfgw1n8ivt1dQiAf8uARUeWuezpvZN5tAp102cp7jN
 TE=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Agbe9w2iKyI=;QgVFq43BBIJl+oDsJ1ehP7mbOZT
 c8+QO6yX+RnorVPNmHVxdQcl90DJWiw6wyOTbdJuJycIv00lV3goOtFpMETCuF2FjjpI9kHyw
 dpNQ6WqgPUdXg8An2F3zi1RJG/yHnMG257vBHhaDnzmPwLnSQc84fmn5c1IhecPUYAdgg6RPJ
 muBn3b50eIn1vnVdgiKRteVgXuPFyTV4k6lAnvhrcuyJ3fBJTexS7FlTfC8nNHxDbaRidu/VG
 4Ula7MgnSsWkJp4D6thb6MNM4eT35iE/YyY/WFKp28lGdZi54eDzJbAnGVWR6mRfGEisN1h6X
 GAHWgtTluVw/y5WSSAmPjdTtr07jC/kwTvjhlN1eeULnmqFCWqNPl1tdXfUS+tBgtD300+fyf
 alp1Xv8/XRqhSidcxzZnDLZrVwidvs2GBd7+fgE4kRWDXYQghdT//0XdZldHFOsxiZMwpXmRb
 /5wWIi0UAbAm5FqtcU7QXPfAMrwOzuwqEeJvVJZavqBiNWjUSFpM21SN8+uHaBPX3kv6jLzyV
 hhS/rerDL0Jf5LOKuLSGOYjgA/n7JHNCJZtsBDgzDcgPdzSLA7HD/mKi+KmCqaxRCNySGeyp8
 6g+6S2Cl90EZMeh+QDtrt2cxEBRs9rf2lcOc04EauLXv16IU8IYhT1VKIggYczILa9FR4GE2p
 gCBdyHzD/Q1WzL9wPuscTEXkbW43Qy5AixcamKoKlQ==
Content-Transfer-Encoding: quoted-printable

Create a software node for the mdio function, with a child node for the
Aquantia AQR105 PHY, providing a firmware-name (and a bit more, which may
be used for future checks) to allow the PHY to load a MAC specific
firmware from the file system.

The name of the PHY software node follows the naming convention suggested
in the patch for the mdiobus_scan function (in the same patch series).

Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
=2D--
 drivers/net/ethernet/tehuti/tn40.c      | 10 +++-
 drivers/net/ethernet/tehuti/tn40.h      | 30 ++++++++++++
 drivers/net/ethernet/tehuti/tn40_mdio.c | 65 ++++++++++++++++++++++++-
 3 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/teh=
uti/tn40.c
index 259bdac24cf2..5f73eb1f7d9f 100644
=2D-- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -1778,7 +1778,7 @@ static int tn40_probe(struct pci_dev *pdev, const st=
ruct pci_device_id *ent)
 	ret =3D tn40_phy_register(priv);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to set up PHY.\n");
-		goto err_free_irq;
+		goto err_unregister_swnodes;
 	}

 	ret =3D tn40_priv_init(priv);
@@ -1795,6 +1795,10 @@ static int tn40_probe(struct pci_dev *pdev, const s=
truct pci_device_id *ent)
 	return 0;
 err_unregister_phydev:
 	tn40_phy_unregister(priv);
+err_unregister_swnodes:
+	fwnode_handle_put(dev_fwnode(&priv->mdio->dev));
+	device_remove_software_node(&priv->mdio->dev);
+	software_node_unregister_node_group(priv->nodes.group);
 err_free_irq:
 	pci_free_irq_vectors(pdev);
 err_unset_drvdata:
@@ -1816,6 +1820,10 @@ static void tn40_remove(struct pci_dev *pdev)
 	unregister_netdev(ndev);

 	tn40_phy_unregister(priv);
+	/* cleanup software nodes */
+	fwnode_handle_put(dev_fwnode(&priv->mdio->dev));
+	device_remove_software_node(&priv->mdio->dev);
+	software_node_unregister_node_group(priv->nodes.group);
 	pci_free_irq_vectors(priv->pdev);
 	pci_set_drvdata(pdev, NULL);
 	iounmap(priv->regs);
diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/teh=
uti/tn40.h
index 490781fe5120..e083f34f2984 100644
=2D-- a/drivers/net/ethernet/tehuti/tn40.h
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -4,6 +4,7 @@
 #ifndef _TN40_H_
 #define _TN40_H_

+#include <linux/property.h>
 #include "tn40_regs.h"

 #define TN40_DRV_NAME "tn40xx"
@@ -102,10 +103,39 @@ struct tn40_txdb {
 	int size; /* Number of elements in the db */
 };

+#define NODE_PROP(_NAME, _PROP)	(		\
+	(const struct software_node) {		\
+		.name =3D _NAME,			\
+		.properties =3D _PROP,		\
+	})
+
+#define NODE_PAR_PROP(_NAME, _PAR, _PROP)	(	\
+	(const struct software_node) {		\
+		.name =3D _NAME,			\
+		.parent =3D _PAR,			\
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
+	struct property_entry phy_props[3];
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
index af18615d64a8..b8ee553f60d1 100644
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
@@ -111,6 +113,46 @@ static int tn40_mdio_write_c45(struct mii_bus *mii_bu=
s, int addr, int devnum,
 	return  tn40_mdio_write(mii_bus->priv, addr, devnum, regnum, val);
 }

+/* registers an mdio node and an aqr105 PHY at address 1
+ * tn40_mdio-%id {
+ *	ethernet-phy@1 {
+ *		compatible =3D "ethernet-phy-id03a1.b4a3";
+ *		reg =3D <1>;
+ *		firmware-name =3D AQR105_FIRMWARE;
+ *	};
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
+	snprintf(nodes->phy_name, sizeof(nodes->phy_name), "ethernet-phy@1");
+	snprintf(nodes->mdio_name, sizeof(nodes->mdio_name), "tn40_mdio-%x",
+		 id);
+
+	swnodes =3D nodes->swnodes;
+
+	swnodes[SWNODE_MDIO] =3D NODE_PROP(nodes->mdio_name, NULL);
+
+	nodes->phy_props[0] =3D PROPERTY_ENTRY_STRING("compatible",
+						    "ethernet-phy-id03a1.b4a3");
+	nodes->phy_props[1] =3D PROPERTY_ENTRY_U32("reg", 1);
+	nodes->phy_props[2] =3D PROPERTY_ENTRY_STRING("firmware-name",
+						    AQR105_FIRMWARE);
+	swnodes[SWNODE_PHY] =3D NODE_PAR_PROP(nodes->phy_name,
+					    &swnodes[SWNODE_MDIO],
+					    nodes->phy_props);
+
+	nodes->group[SWNODE_PHY] =3D &swnodes[SWNODE_PHY];
+	nodes->group[SWNODE_MDIO] =3D &swnodes[SWNODE_MDIO];
+	return software_node_register_node_group(nodes->group);
+}
+
 int tn40_mdiobus_init(struct tn40_priv *priv)
 {
 	struct pci_dev *pdev =3D priv->pdev;
@@ -130,13 +172,34 @@ int tn40_mdiobus_init(struct tn40_priv *priv)
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
+	fwnode_handle_put(dev_fwnode(&bus->dev));
+	device_remove_software_node(&bus->dev);
+	software_node_unregister_node_group(priv->nodes.group);
+	return ret;
 }
+
+MODULE_FIRMWARE(AQR105_FIRMWARE);
=2D-
2.45.2


