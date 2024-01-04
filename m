Return-Path: <netdev+bounces-61536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C408824336
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13083286D84
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B033C225CE;
	Thu,  4 Jan 2024 14:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GdIQj3c3"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC08224EF
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 14:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQpZwTK6IYElWf+L2n32K+f7vd72asr2sV4hEoeCHm3fONwjXj5z7KHSoukFIpk2+oibwLY1GhP6bDsSXSRF54Y1V6WOncOa8NCWhZnJpSGBu+XjQm9bRk4Wxrka9Q4+GVrKJgXHaI2KIZRUTP6ZrfAUbwce/MaFb1pNJyzBWNO3QJZIzxjirdAkJz1Vps7SQ3/ujqHhE4xaLfc/x8sN+bW5pYZeRdDGCP7hFu0DZXqAXZvYXyIkjc+REJU0ld6EP+DD/M6OKqIfd1oFcOBnmJ1QdTYBVVm+Gv8znRP3zAVo6uxjMB0ez9022/3go8N94D2HSh0o2zKN0DxRhZOTCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E21JpZq8u+HeuqNAzmt0s9z5fkAV6yBPpvD0VoJPRK4=;
 b=KKSaWsam9Vqug+fgBpw9i3mT1eQ79V/JHkeNnN07vnYRqd7BsgVlnxLLzSDhhKWyc82z4mpBXK3nJD/hoHOSr2UtYKNcE1oKyC+eMcMnIR5UXTRiHtp9mfNpkwL4n98Eka+kSfQJCaDWozqee4pvcdXWeSiGfevu3otT/fn+R7TcLctlHePKVzfMIHc5AHWMfFgSQ+Y+J/9ygZWvNbI0IIC3MoOaY84qW3datM8a1dMF6D7OCMxvk7YeMNFFZLBKHqD7gefbxbJ2oFVtv9JH7UUnaLfYebJiu5M45sZsBKvExFcWUrXsw0j2TeA9cDGQaGMcfdJrLHx00FdWLBKYdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E21JpZq8u+HeuqNAzmt0s9z5fkAV6yBPpvD0VoJPRK4=;
 b=GdIQj3c3rVkVqtOhBexAkp9jNk/aJ7bAugtmjm2+xUGizyrYo+l7rq+9RMhlootq9UqqFbChD/YBAEYQywgWrdt0WZ8+9iiSb44Wip8AsABYjO4K4XindGF38VSsLAR89LsJC8/qECSOy9bNEI+KsdVjADIf+/5ViPnniCdH/2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by AS8PR04MB8579.eurprd04.prod.outlook.com (2603:10a6:20b:426::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 14:01:19 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976%3]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 14:01:19 +0000
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
Subject: [PATCH net-next 08/10] net: dsa: qca8k: use "dev" consistently within qca8k_mdio_register()
Date: Thu,  4 Jan 2024 16:00:35 +0200
Message-Id: <20240104140037.374166-9-vladimir.oltean@nxp.com>
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|AS8PR04MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: e63039d0-1c4c-4afd-15c7-08dc0d2da051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	keVsx82efty3F0LZRJsnTVGpwd7F+QKgKpwkVa2U5MRGJqhvRf02Gf9lKx/5sexwZkFScVilamT/qWfLpGZqalkWPpWZ2T6DwdT4nvBKX1A0yOIlCIaw99kg+5xqzP/nbNJCwH7dGZ4HUJ5ZTl1PQiw1YbLCtA2NHQ3A5kHuV9iigBhTQxmb2dVEWmAgxbCyeCwMQn0HRXtNhlkGCW7BfeDmpkWPW2qBXdLFR/TNhVhNl3SlGtRjLqMWi+Epi9zW9QJGw9zaq0kSGDeW42b+LcRTEdlrB5iz8YVryXops4a+MrC1TlkBib2OhL79h+AIbdowOamiyY3lDeWme62oRIRatZvo7ZalVgdlddjaD0BG+b0kRQp8/UE4B8jfUWhUPnk9GKuHo7S+MJiFHD6y2wjcGU70jtCVHiLSfvzfuTMv5plny+vXSlxNXGW9gKhYTSjW7q6qMrP1dYxLZBihslCl5Z9INVbY6Xr1p9g/1/4UuhaAbg6CcXZznWOK+MGiFy2Yi/LOEIz37iP4xT1lqKPm7CjvYqb3XS6TAffWmjYR9TnA17xt8qvSEzIkcT6ZPSpXMULXmB8d3ae4lPdm727kJFc2pXipLmwGWVtKdw73ha85Dob64YyvtvsnpaRw7vcqoRG3QTjC4YKIwtoDuw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6666004)(52116002)(26005)(1076003)(2616005)(478600001)(6506007)(6486002)(6512007)(83380400001)(41300700001)(7416002)(2906002)(66476007)(66556008)(66946007)(6916009)(316002)(54906003)(4326008)(44832011)(8676002)(8936002)(5660300002)(86362001)(38100700002)(36756003)(38350700005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4joVPpNu7ClutSZQeo4EGmwBp1KcMPesLbm49lInNdYD3/8YvXzJDS/J0OCp?=
 =?us-ascii?Q?OxQjtjbexMKlEi+tAKuvfyjR9x8QGLVwTY6K/RVBSIUUr7N/nOyYijCMh29d?=
 =?us-ascii?Q?dfqnWRckgMXjbjvtKSu0RwqdhhmGrGnW0DP8FpGvANeRapmqhGmxrBhBqU9f?=
 =?us-ascii?Q?GFZYLvFS+Iqh049aBeUq6qux/vRBv2f/Lm91juOYY3Dy1NL6bMxiTAE0brvi?=
 =?us-ascii?Q?1YAzU/gw7rysI3VqtDn7xTmNLVNl00TGFzHNgMJkcakAw+sIS4hbATSw+Deg?=
 =?us-ascii?Q?XdgV1frfa36smBxqHG24nC3ro2mfUOlfbp63Nbeg1PX5zkFo2/XF/qX04rl+?=
 =?us-ascii?Q?/FRd5phRLEuSMA2i51iW/L5Bm8ZOgnCgjNT6D7/OvYQl8rM6LT8hhMNIvH84?=
 =?us-ascii?Q?sUzSRH7guzM9PdTNTtIAio+87qZKXWTr6QKM1w0CSAW+voLna4dyYvKeggY3?=
 =?us-ascii?Q?GsQTC4N69AIN9gp9fYvvLvNdNcyU2eIIMak4tBDaaHGcRkeO71c4nspK4rmC?=
 =?us-ascii?Q?S88t9jitvv+hz8tVZ8QgyPUn+lLerM36CN2ivTI/yXAU22uqhY/F/4XySman?=
 =?us-ascii?Q?CKsCsrkNwFnScyg0ICt+X52XEOcvNTqPTsXOy6lva1Z191x+mx8d6bAIs7Ib?=
 =?us-ascii?Q?VIJFTemg5HaC3quh0YsxtavU9QABp5VwSbTCPAI0TeoryjTZYCTRgFrKf1bc?=
 =?us-ascii?Q?S19azF6+BoqA/aJ7Ui2lS8bGlswnzRI5ke7la6ZDgavfE8S5QlOMGKnsCU+P?=
 =?us-ascii?Q?cESYIbSKNCO3a461XI9fVgl8LWQHGaFUmCwyb7lAGbAo89fLmW/fE9QRHxz6?=
 =?us-ascii?Q?SyO3frEa8EEsSsrxzYPWYARiC/xrxeU1++PHUGd8ore1LwLCXW4is3xvIa1A?=
 =?us-ascii?Q?f9ju2P3YhdhJpaxgjKmGdCIRi5EPk7NxdA+PT2SsiBKszPcHEKX4JX/65FfO?=
 =?us-ascii?Q?94n0RJkWaMe9l4bLP4RgLujX7jv5xklN/ZMLyJr0sCOZvogZHXM8Lm38tbO+?=
 =?us-ascii?Q?vo8MaMEkJ3Ood9tFYa5fNgFnn6cfA8gSk12ojohwquNqth8D0R0dz7xcca6l?=
 =?us-ascii?Q?hZV4SxcUS7hBJDl6DjQ349XLKnAMLIeY3Q7UZg239hT+2ZEHquaYjg1YDXT+?=
 =?us-ascii?Q?GLeJQykPXmHORELl03U7qlPl2Mj4Q0wx2rLJJxm8vROdz6+VnTzCbde3to6I?=
 =?us-ascii?Q?g6peCM1p8DMNt6ZatdAlNpUCKUUDOAyzPBGsF6RAbjYYE0MODA2slsPZoWMt?=
 =?us-ascii?Q?ByAoZlfAaaBSWgCrg+DK6VGhwnCaLX+wEIVnkAOREwS7LcWpb3GCCJt/CZta?=
 =?us-ascii?Q?BdQVaQeITnZ9rdHWNfzZuGVbXUjzblQG7QchFNkmm4Z1UqKWEhqABx0yQfKv?=
 =?us-ascii?Q?7aNXysjKSNwdpUqpTpNQYvvVKsXa4Df7EMJ+17N3Yt+l0kBLCxththEnd2Wl?=
 =?us-ascii?Q?1C/43d9paOLkHSPWaDiHvrWqmhfwKk0O5xUQxI2keBOpMwIOLg6Ubq7X5cgd?=
 =?us-ascii?Q?eDQo4AI3e88kE2IsAOmakkJlAkjDdF1xOQ7C0VP4HvIC0yCRFNMkAnmF3zDb?=
 =?us-ascii?Q?Kbr6wkIaufzyrAKzsARKPEAf+SIF2DqrhbYBCJxrXC1PHcXmoVPrzpvMG+hi?=
 =?us-ascii?Q?1A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e63039d0-1c4c-4afd-15c7-08dc0d2da051
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 14:01:19.5484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Si19bEu9Ds304+N5NXkRcloovV+vqGKq3pFl3/IQGfBIyJtWWMjJ2s3wtJJjAftepbuHB/FoMSNmMEL8IutEYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8579

Accessed either through priv->dev or ds->dev, it is the same device
structure. Keep a single variable which holds a reference to it, and use
it consistently.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index f12bdb30796f..c51f40960961 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -947,15 +947,16 @@ static int
 qca8k_mdio_register(struct qca8k_priv *priv)
 {
 	struct dsa_switch *ds = priv->ds;
+	struct device *dev = ds->dev;
 	struct device_node *mdio;
 	struct mii_bus *bus;
 	int err = 0;
 
-	mdio = of_get_child_by_name(priv->dev->of_node, "mdio");
+	mdio = of_get_child_by_name(dev->of_node, "mdio");
 	if (mdio && !of_device_is_available(mdio))
 		goto out;
 
-	bus = devm_mdiobus_alloc(ds->dev);
+	bus = devm_mdiobus_alloc(dev);
 	if (!bus) {
 		err = -ENOMEM;
 		goto out_put_node;
@@ -965,7 +966,7 @@ qca8k_mdio_register(struct qca8k_priv *priv)
 	bus->priv = (void *)priv;
 	snprintf(bus->id, MII_BUS_ID_SIZE, "qca8k-%d.%d",
 		 ds->dst->index, ds->index);
-	bus->parent = ds->dev;
+	bus->parent = dev;
 
 	if (mdio) {
 		/* Check if the device tree declares the port:phy mapping */
@@ -983,7 +984,7 @@ qca8k_mdio_register(struct qca8k_priv *priv)
 		bus->write = qca8k_legacy_mdio_write;
 	}
 
-	err = devm_of_mdiobus_register(priv->dev, bus, mdio);
+	err = devm_of_mdiobus_register(dev, bus, mdio);
 
 out_put_node:
 	of_node_put(mdio);
-- 
2.34.1


