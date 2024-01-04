Return-Path: <netdev+bounces-61535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 624FB824337
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC968B2143C
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6314C224EB;
	Thu,  4 Jan 2024 14:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kKInA4t+"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2042.outbound.protection.outlook.com [40.107.249.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0D2224E9
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 14:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K98VYJ642ZMG2Q+97NcAlzF/Hjs2pB4GbsyHSvAP7ojfX2Wa0gqKt0Avw0yenIWLUxGfG6uj+XyWiwEwms3E2vtuJouQFVpVhbzeZSGFSKWpHWSI563DgeAvNEiHtSRQJRJe6yjJPUVt/chzxhz1RLi/r/Az5GG/N6r45NvLg/PXMoqhN2GnYCnfVVg9DtmD0IhPGPa97M0ZXRkKxTg75dMsXUXrGrxtPitqrQq1coVBCV6r/5lEyGFx4QOZcmzZfQkLNqv8PrBp86wejTunouHGAs/bKeE2SOKg9ykmBFtZuh9ALJbnQ4/1t7bePVNURe+ZBCP3CZAhBRI8+P/Q3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypm72puS72N6spNMbnAW0xBkNWgd8GMWGxVy4Lpnp+4=;
 b=ddwA5E8TzHwURslzoTAXOBT/qxGHXy/yarV04SosP0r4deadFG+ojN/nBm0qYhi0tQKZ8TrrqRc2Wjz+3kOn7TbXP7dS0MzqH4laRwzQ97c6GzITOGxvruSdpg1GOnNuOzabNmeKXElrAItGpaBUcmHwXF4W5veAN2vf+6KxRduh+G+5x2q+fptZOMOQFvO7YdMa9yN+/wlfM96HZL6M4Xs7WF8sZ1VJb9xmlbXVFNY8Pd3JOuUVHe+9RjqMZl6jO7vAAA9Z0Z6OYExGajWJWZu4R76NN9+JVFj+dXO5Ck5IUD52AudcqLTkbk/Aco7c9ZKKKcVPzTQ0FFR38DvmeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypm72puS72N6spNMbnAW0xBkNWgd8GMWGxVy4Lpnp+4=;
 b=kKInA4t+AeY0Pecrd2RElyalPwjv3LkdVIEjJiBtXt0xl8m4S4OFGhfpH5WXzHQvvLMGPOfw5gtBLeMR6bwVFj8biopFxphq6u1xbNxvFpj8JEuPXzB3lBX4AlQayctS5GXbbUnR9Uv5sS8B2X1PjuvfzdUsyqbXIjkKCY6UHrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by PAXPR04MB8176.eurprd04.prod.outlook.com (2603:10a6:102:1c9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 14:01:16 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976%3]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 14:01:15 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Christian Marangi <ansuelsmth@gmail.com>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
Subject: [PATCH net-next 02/10] net: dsa: lantiq_gswip: use devres for internal MDIO bus, not ds->user_mii_bus
Date: Thu,  4 Jan 2024 16:00:29 +0200
Message-Id: <20240104140037.374166-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104140037.374166-1-vladimir.oltean@nxp.com>
References: <20240104140037.374166-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0063.eurprd04.prod.outlook.com
 (2603:10a6:802:2::34) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|PAXPR04MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: a499dfeb-9310-4510-da7d-08dc0d2d9d79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pRjGeb3tfPbnBTvQ+A5P48V9O88sFEq+/DbPs4GeeA33wBwFCEo7BOmMUm/6DYvqR3Uni9svSy0khlRdO0mxdQrNZS+V7v1GsZG/lE/eMgD1an471RoZSd514I/oU0EVFrHhykmg+1eEwlvUJHZ3atdlsEsUjbJQKA3Q6Uj2QFjMK7mgrFwLiAVeRk3lZ0vjZnXiNIHgKgcC4u0s4u9eEiaHf+d+gWuUBD+6AiJYjb03Yyk5e7j96CvFt2+dvWEfAxjagGC9II43u8Iip2FyUM1P0UTgptxnzwvWnDgWNVZZlsu9wfSkbmSnuBdyZwOZetfh0NWi8+gaq7+9ThSFcPRxmkUCVGTCr59oWtE4cBmSJ721sSGTfXyM7GCIP8pt49CY5EOkyMbr/sUT9zFCg7S2EiIVn+TsViqekKrlzlkPo6rRXSIpNVJzNRxmEVs+5mjce3MRW2jyB2U/BKHhFkPuRNiVHBeo4fYA5kw1TugeRh/oSoWO7NWxh//ND5DdToJD7oBj2CzoNNA+Hnz+P3cuDRCIEyT0o3jV9jUWjXm3KXZXCQs6NbQEDPQNgOTqIryYUsEsst9U5hQQuhRlPTn6G/iUauEW5eISn+e23cI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(366004)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(966005)(7416002)(41300700001)(26005)(2616005)(83380400001)(38100700002)(1076003)(8936002)(8676002)(54906003)(316002)(4326008)(6916009)(2906002)(5660300002)(44832011)(6666004)(66476007)(6506007)(6512007)(52116002)(66946007)(478600001)(66556008)(6486002)(86362001)(38350700005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?efKHiOr2I8+YkurH4cywGRCXr0p3irY6A+IH39MjjAPUnBhIHNSnRjJNgTNX?=
 =?us-ascii?Q?fDgVfzR15yvUr+3Y0qOELJhroQSpmuOkpN1VhOAFspLZRIa203XBIlYSD473?=
 =?us-ascii?Q?5myKHhQ5xAO3JyKiqP09zzMfR6EtZCYSvRq+k8QE/4r7D5kSjaVJpHpPDNdh?=
 =?us-ascii?Q?qUCngdkD7Yr8Nz7pbbTFmkhnbBLc/UR2t1925sS23wSWJepcZZDCUnotG3+w?=
 =?us-ascii?Q?cJ2BWRBy85Oaw00lZfiwr6BwdHcsShqRrPwPPBCXSWI8jcr2NoiCigSb6wvP?=
 =?us-ascii?Q?aON6HDKu/pMAbMJlJPgtkPlym+AmSU0wpW1gthWwC1cb38eTN0jDayynFU0g?=
 =?us-ascii?Q?wGVsS+7xtXnwId/Ixvo+wKqYQQ4+p0pxTzcxEeF3RdOKc7Pfn7bbZGSlm+oG?=
 =?us-ascii?Q?71dDMLDLn7mPEuq/eVc6l65BBiRq3ASECSXV/o9jlCfD7eV5nav1RhNZKJYF?=
 =?us-ascii?Q?0hgiRvl5XjTWuGd/nXBdK8J0qc7GLeZxNsd4vDZXWULGdt2ctUKANKyYlrYK?=
 =?us-ascii?Q?Gqj7/mKWRtsKKCtvnHu0XqEYok2Y3vFsFU7RXdG5SoDTNnHQZ7NzmKngoMg1?=
 =?us-ascii?Q?w5WhLHPMFu2ZsWOF3oQ8v39GZRFZ2S873hsdrhU5wohNorZvz3wcEWWQBn4O?=
 =?us-ascii?Q?NTm5myfJ6v3cdkD+K6CFqJmrzsI5wI7E9cmb7SLSzVEPG6pk976IP6B2OpuH?=
 =?us-ascii?Q?cKRREbN1JbncTjlnR/hzGWHxmK2LjRnqooC0seKJGf3a2qMHXgTQRKRupPlB?=
 =?us-ascii?Q?gVgSw3YG/ogzKgPxOILR+vSzmwgrdZsVsl2ofPNjFvzBe3bIHg3cBeiIyBML?=
 =?us-ascii?Q?u6rnnCHjwn8Ea0KkGGx5prJkmz+tqyjeLoUGax1IxyVw/VF8vikWL2jP1cmW?=
 =?us-ascii?Q?IS2iHsUtWo55iDGadTBByECuO3cvfdPgHLJX3AoQAaCqj/SKtpeRmMqk6Zed?=
 =?us-ascii?Q?2XNM23OGVbd5PVZGhlM1OuYZkAjN2KIKfh4+HXaDFEG3h+IUhtgvVhFwaKb+?=
 =?us-ascii?Q?ZRKliMw7OJqVYeQ4YJQColrtThwKBUzWsHgMhTe+HF0FX6Qdf9kKf82jELUp?=
 =?us-ascii?Q?k/rLHfmFEHeMbvzK+rKvSa9sUYgqpOANNL+e8DA+Xj2MrzxX72iqULez4G6O?=
 =?us-ascii?Q?g1L/1RJyRO0PhRHurzCYv9NanG3b5VuQ3T/qtptKaruIvdRNlFeRIzG7v/1E?=
 =?us-ascii?Q?1vzdLL10VMcEQSYRSRjkilhwD4dKVZN/ut/iQMbusbllce+iezyGfWOZgquB?=
 =?us-ascii?Q?dbcCEu2nwmJW45+UVCzu2gJnFVlaKBbfVOm3M4wowkwwLNy/0/m30x9mXxME?=
 =?us-ascii?Q?sPhmo6emPhN8sFuQJvJjdQsaX78XlpVHTfyeKMC7pdHBaqFDfA/VIHZoz0Hx?=
 =?us-ascii?Q?CcBxrFi5KIV3z+LtrxozBUhfRoqqXMxcRpLG45PRhCQ27bCC1OmNBLkYKzxA?=
 =?us-ascii?Q?IWSANtY2utc6GnCXUE+Q8ro1iFeq8UGr0UmCapA6Gvl9hUlziI5Fwwi5R7Sj?=
 =?us-ascii?Q?O42DaCmZGgHQbZQ59lf3dwXME29pDBiE5hwK98FpfAGVuQA8zBETdQDsj43n?=
 =?us-ascii?Q?3liwyG/RzcO26j/RmzxRr9P/Apk5HoEv9Vy909nMKT6EstkteYJMOfjZs5E5?=
 =?us-ascii?Q?sA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a499dfeb-9310-4510-da7d-08dc0d2d9d79
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 14:01:14.8103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AqaW2ae0T/D4J8MlLVHpsI96xQZ6cQidahakgntTxrAMLHPyTj3mtAYDxdqmJiW+1eathoxr851+4XU6fejjyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8176

This driver does not need any of the functionalities that make
ds->user_mii_bus special. Those use cases are listed here:
https://lore.kernel.org/netdev/20231221174746.hylsmr3f7g5byrsi@skbuf/

It just makes use of ds->user_mii_bus only as storage for its own MDIO
bus, which otherwise has no connection to the framework. This is because:

- the gswip driver only probes on OF: it fails if of_device_get_match_data()
  returns NULL

- when the child OF node of the MDIO bus is absent, no MDIO bus is
  registered at all, not even by the DSA framework. In order for that to
  have happened, the gswip driver would have needed to provide
  ->phy_read() and ->phy_write() in struct dsa_switch_ops, which it does
  not.

We can break the connection between the gswip driver and the DSA
framework and still preserve the same functionality.

Since commit 3b73a7b8ec38 ("net: mdio_bus: add refcounting for fwnodes
to mdiobus"), MDIO buses take ownership of the OF node handled to them,
and release it on their own. The gswip driver no longer needs to do
this.

Combine that with devres, and we no longer need to keep track of
anything for teardown purposes.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/lantiq_gswip.c | 69 +++++++++++++++-------------------
 1 file changed, 31 insertions(+), 38 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 3494ad854cf6..a514e6c78c38 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -505,26 +505,34 @@ static int gswip_mdio_rd(struct mii_bus *bus, int addr, int reg)
 	return gswip_mdio_r(priv, GSWIP_MDIO_READ);
 }
 
-static int gswip_mdio(struct gswip_priv *priv, struct device_node *mdio_np)
+static int gswip_mdio(struct gswip_priv *priv)
 {
-	struct dsa_switch *ds = priv->ds;
+	struct device_node *mdio_np, *switch_np = priv->dev->of_node;
+	struct device *dev = priv->dev;
+	struct mii_bus *bus;
 	int err;
 
-	ds->user_mii_bus = mdiobus_alloc();
-	if (!ds->user_mii_bus)
-		return -ENOMEM;
+	mdio_np = of_get_compatible_child(switch_np, "lantiq,xrx200-mdio");
+	if (!mdio_np)
+		return 0;
 
-	ds->user_mii_bus->priv = priv;
-	ds->user_mii_bus->read = gswip_mdio_rd;
-	ds->user_mii_bus->write = gswip_mdio_wr;
-	ds->user_mii_bus->name = "lantiq,xrx200-mdio";
-	snprintf(ds->user_mii_bus->id, MII_BUS_ID_SIZE, "%s-mii",
-		 dev_name(priv->dev));
-	ds->user_mii_bus->parent = priv->dev;
+	bus = devm_mdiobus_alloc(dev);
+	if (!bus) {
+		err = -ENOMEM;
+		goto out_put_node;
+	}
 
-	err = of_mdiobus_register(ds->user_mii_bus, mdio_np);
-	if (err)
-		mdiobus_free(ds->user_mii_bus);
+	bus->priv = priv;
+	bus->read = gswip_mdio_rd;
+	bus->write = gswip_mdio_wr;
+	bus->name = "lantiq,xrx200-mdio";
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-mii", dev_name(priv->dev));
+	bus->parent = priv->dev;
+
+	err = devm_of_mdiobus_register(dev, bus, mdio_np);
+
+out_put_node:
+	of_node_put(mdio_np);
 
 	return err;
 }
@@ -2093,9 +2101,9 @@ static int gswip_gphy_fw_list(struct gswip_priv *priv,
 
 static int gswip_probe(struct platform_device *pdev)
 {
-	struct gswip_priv *priv;
-	struct device_node *np, *mdio_np, *gphy_fw_np;
+	struct device_node *np, *gphy_fw_np;
 	struct device *dev = &pdev->dev;
+	struct gswip_priv *priv;
 	int err;
 	int i;
 	u32 version;
@@ -2162,19 +2170,16 @@ static int gswip_probe(struct platform_device *pdev)
 	}
 
 	/* bring up the mdio bus */
-	mdio_np = of_get_compatible_child(dev->of_node, "lantiq,xrx200-mdio");
-	if (mdio_np) {
-		err = gswip_mdio(priv, mdio_np);
-		if (err) {
-			dev_err(dev, "mdio probe failed\n");
-			goto put_mdio_node;
-		}
+	err = gswip_mdio(priv);
+	if (err) {
+		dev_err(dev, "mdio probe failed\n");
+		goto gphy_fw_remove;
 	}
 
 	err = dsa_register_switch(priv->ds);
 	if (err) {
 		dev_err(dev, "dsa switch register failed: %i\n", err);
-		goto mdio_bus;
+		goto gphy_fw_remove;
 	}
 	if (!dsa_is_cpu_port(priv->ds, priv->hw_info->cpu_port)) {
 		dev_err(dev, "wrong CPU port defined, HW only supports port: %i",
@@ -2193,13 +2198,7 @@ static int gswip_probe(struct platform_device *pdev)
 disable_switch:
 	gswip_mdio_mask(priv, GSWIP_MDIO_GLOB_ENABLE, 0, GSWIP_MDIO_GLOB);
 	dsa_unregister_switch(priv->ds);
-mdio_bus:
-	if (mdio_np) {
-		mdiobus_unregister(priv->ds->user_mii_bus);
-		mdiobus_free(priv->ds->user_mii_bus);
-	}
-put_mdio_node:
-	of_node_put(mdio_np);
+gphy_fw_remove:
 	for (i = 0; i < priv->num_gphy_fw; i++)
 		gswip_gphy_fw_remove(priv, &priv->gphy_fw[i]);
 	return err;
@@ -2218,12 +2217,6 @@ static void gswip_remove(struct platform_device *pdev)
 
 	dsa_unregister_switch(priv->ds);
 
-	if (priv->ds->user_mii_bus) {
-		mdiobus_unregister(priv->ds->user_mii_bus);
-		of_node_put(priv->ds->user_mii_bus->dev.of_node);
-		mdiobus_free(priv->ds->user_mii_bus);
-	}
-
 	for (i = 0; i < priv->num_gphy_fw; i++)
 		gswip_gphy_fw_remove(priv, &priv->gphy_fw[i]);
 }
-- 
2.34.1


