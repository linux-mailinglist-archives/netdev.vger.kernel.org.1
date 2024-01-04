Return-Path: <netdev+bounces-61538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F842824339
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D22FB1C23E7B
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5DF224EF;
	Thu,  4 Jan 2024 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RFSYr2hP"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2042.outbound.protection.outlook.com [40.107.249.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A738C2232E
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 14:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJslLxxPRqFsCZuDKxr1hZ8kCxd/tf8bLb959ANTf66hRdaT2miShKFAtgES8XmxDy0xqfnWciRfq8XLxU5v1toOu+tsdLa+Pgz+S0PJtFN3KvBaf4zN53qEnvvunfXLtN8baakh6w4iskPrV4MwtdiXO32dPPoVAggFNz+lkqooh2DoWfU68ELGKtSxYD4PF+8saZbiuBzDf/KUDD6cDVBmdtM8TS383U8mJ3b+N5iNXK7S3Ewkp/u5yRKjfbYLYQSRH8c9OZccTXUTG3w0D2VyRs8Na1FcoWrayfmUvfQ2dAarpYP6g+rKoCcQON2waCoyYl+8vk99rmX2J5vM9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mxt9j3PpfXE9XA9fMVohhl2144RJTCkgGVJJkRRClg=;
 b=DG/HqpiXgIKFJMo9YPJeEzivfzTZSW6+VNS/ydHmmHnBSTl3Ngf8PXYJWZ9Lnc1tjr+ljYDhbgFT0xjkobXvw+jXbqx1Zdm0KXp5MH1rVrAMWJpJqTkRcPd0hiTikEGNvUC4Pn0Y0uK6dploBQ5iTZ978z4ebNJc1ghEsKudWEml8LWNkf7IaneA2pNJSbSpVpTekohsqMtmcU+hjghP+hO8+4KbcaeQHZW2EsdfhZaan8SIpAXVZzqf4j+uu6++UCJsC60QbKbpxIDXjZirESVrD/2IAz8c2kErL1f684iYoBSQLnQkxZZhSK8dYMobaacZsX/bTE7GurEp32d1pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mxt9j3PpfXE9XA9fMVohhl2144RJTCkgGVJJkRRClg=;
 b=RFSYr2hPVqVpytl/ERN/HmYcl3zSe0kdTL1qPK9zfstto1W6jsGizNLUvPFlKh0JI41/leM2L8gvKKhflU6bG5e5GB8jchGFjX9UbvEapKR19IPAvTcNmWH1kNPSaYHanaA5C1X8v3h5dBmOiHR+OZVbPPnGevgu5+g2yYDu1EA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by PAXPR04MB8176.eurprd04.prod.outlook.com (2603:10a6:102:1c9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 14:01:17 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976%3]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 14:01:17 +0000
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
Subject: [PATCH net-next 05/10] net: dsa: qca8k: skip MDIO bus creation if its OF node has status = "disabled"
Date: Thu,  4 Jan 2024 16:00:32 +0200
Message-Id: <20240104140037.374166-6-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6944ada6-7e35-4575-6e29-08dc0d2d9eeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4SjleXU5DA2xxb9ubLoJujKqDD//FbFzqBoXd6TLzYJ60znniFBDpwPBRlFamC5ahygz9+AlVegp1BRYCP7SjqkEXOE1lpBvLLBZsjnmAvi9ydIBkL6TNs4cb5VRrwPvNY+ovaYtZ+yWCZjBkWPwxzj0Xef1ErfVCHa9pSd761poB7DlbB4FFZXg56phpw4dKveoMq3CwCRVTrJR3Dhm6A6wXwNFLwoVRvFwIJ4iTffgCjJLX7S+6AOTx6P8Xo5nv8bgqgTH4BTrzbn2c6/wvZ+cxvG4StvInm4Ac6GPWrqoJzsq8KmyWaZhu6Am+f+uQFX43PjT02mfOOk8OmAp77Laso5lU5VzZpnfd4yR6eY1cOahwt1UWOlLJy/HEHKP2Erut4ov0dfKEi/Q7d2tMWX18OxY1IE/c8Md8vDhE/leWlXvMTMImwqCJqfcSi3+yuMJHiTsezJ7PcgfaPkdq+GRzrp0ZuLGW41jKmtrg9EHK/Wm4ptZDFXWLLggay6nX9Yd0f+rDTYdS8oL/l+kE4xEp8dVzYq6HXXIeqbtJBkt3bjkMPplg32yXhYaGjO9RQ6OM1tgD4CaMhymCEjPlJCjMICgxPeKJLM6JAKxTPKV1kZm7G5hIVZXChsv+IdBalu3hfcTUmnmc8TTFqCnZQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(366004)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(7416002)(41300700001)(26005)(2616005)(83380400001)(38100700002)(1076003)(8936002)(8676002)(54906003)(316002)(4326008)(6916009)(2906002)(5660300002)(44832011)(6666004)(66476007)(6506007)(6512007)(52116002)(66946007)(478600001)(66556008)(6486002)(86362001)(38350700005)(36756003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mKf/1+HJwEInUIZ5HJ6rU6B6FP+jbpz18uPFCZBiKkDtq6XIvm2AxIXb/9e5?=
 =?us-ascii?Q?4ukpuMxKMnFVXsNYOu0Hwd/6kOfIB1+2lGwFB38mK39nbLdzK7sdlK9LaWN1?=
 =?us-ascii?Q?dmbSSqQZWK3muYweZczGJ1kaRsbY4JA0nCJOwjMsW8W2Q1l3suKep8H5+Nah?=
 =?us-ascii?Q?cV66JfoUdGt7334PLFX1cOBF7n9R1jT2IE1NuwNzmzd7ZlCqfwFy+3WAj4tY?=
 =?us-ascii?Q?W8L/NhH3LMO+S25dmVCFS0W5f7VRATl0IzeaufG7pvjQyotPHLDlTtuq0Hy/?=
 =?us-ascii?Q?S2YbUASnjvCe9Xxfjnzrz150dksJnQXZHxYyMZ/mUNHXSARb4ahl0VqVvp/V?=
 =?us-ascii?Q?0CiENA3vD1vlyIncD8TmEVYuuUyXy0zAVnJqQzzZ6SvfaAF3JchPwrG3m4iX?=
 =?us-ascii?Q?ZiIlorkn+3phaMONPigNGrughNOuQzVh+I23wEVs5SzRJwgD5PRxMU+5zzLl?=
 =?us-ascii?Q?Y0nlSEyv0sE0xGTyNCrDfTyOIoeylyIvLGNh23OFJa6r+EQnlB8UEH0Ms2lz?=
 =?us-ascii?Q?cntmlfxfEo18921vpM+ON4740Ec5EioYDGZhoizCFtrRWDiMaUjkWt8Z5u4B?=
 =?us-ascii?Q?fznDuoIJlWMijdTz/Gmuy0CJGYh23fzXKENIt0VgdzT+B+7cstQQKN7s8mfz?=
 =?us-ascii?Q?tVrbt3NKPFZMnlOHbuYErd7D7VboHb7il+VR8Y0TsCvDQKswEICn/S68qua/?=
 =?us-ascii?Q?cb4nFse4MqjAgItKbAHmud7c2cU/L7xgLXTK/ASXGZV6Ig2eAuGeviozK2UR?=
 =?us-ascii?Q?EbfYzyiKVVk2vUPTxIfADKuUNbEvqedIaW1TMNmjTi0x3NM160u/JezwzCB+?=
 =?us-ascii?Q?OE1bj3Jw5lsFeP0fNmihlGJUPZO9N1d83VSE4jsKzc8Pe/My3CcrZvbftXTV?=
 =?us-ascii?Q?pJzojpZTbDY6qe63RQwff8tZ5zIipbcWbvvBvNH2s9zeohLiaVnkvKNpWWcU?=
 =?us-ascii?Q?oKWDwSOvUCFPRVhqKH323coqyl0gH7SClJha0YdJtTCxxdVftGFU/3uzZUMo?=
 =?us-ascii?Q?dweU0yl1vugqNOoccFsXmTBJDxJIIl3dHr0xPPup/ycLiLUcSm2xzfjr7MyV?=
 =?us-ascii?Q?Vd85TGF4BS1Ex3c6VPPefy/uBXj0Ci8MnT0V8FidyIImNL8kOrMPZyUAwi7l?=
 =?us-ascii?Q?RpyWTA50wpAhsZZxoJt/XtKYchhWn4yqAtRuYgsL3fYM26YIF7+1QOe61tmj?=
 =?us-ascii?Q?EGQgISQGssG59rTY5sxj3PFbmAhMn5DT6zG1rQ9j0VhLu2kI5+j41WVr+ywc?=
 =?us-ascii?Q?5eFOGgwvmmFLD3c/V0ViW4plO2jLNiH6yFiNi7DSggCD+S5jODzG7nnFzY8S?=
 =?us-ascii?Q?3bHZNTTs3/4Ev4j2bvqbv/kP5b1bGKxTZ5WIs9f8ZLu6YSYJv1GlayJvlOc/?=
 =?us-ascii?Q?gvNQnmu523c0U6Wu6RYb0JhrPqdzDYZHR7zyJQGpoTvn0I9zx7fYn9kYtXi6?=
 =?us-ascii?Q?6Z2Je6pm/khnxmY7LeZXEBPAvOWTWR+ob/c9GazP7Tn6Zubd/uxapUM2b0Sl?=
 =?us-ascii?Q?5ILkKezYw42uzPfOtQJflu1dOZj5NRgGz3IJgXY4ZUS9bYkyJDP8egymCPkT?=
 =?us-ascii?Q?RARN7vjBQSACnQ7u6WNo4C1w5SSPA52PRT0X1Ii5F+D1tGr6ilYOQ2Os8UWc?=
 =?us-ascii?Q?kg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6944ada6-7e35-4575-6e29-08dc0d2d9eeb
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 14:01:17.2058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s8fKm+SI7A9wVBggJgtmbDddRkI58/2qEyGtQALZJnp1lhqNWJj6zUjQVsDp9W+ZZndwMi3yuozN2GqXjciXHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8176

Currently the driver calls the non-OF devm_mdiobus_register() rather
than devm_of_mdiobus_register() for this case, but it seems to rather
be a confusing coincidence, and not a real use case that needs to be
supported.

If the device tree says status = "disabled" for the MDIO bus, we
shouldn't need an MDIO bus at all. Instead, just exit as early as
possible and do not call any MDIO API.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 5f47a290bd6e..21e36bc3c015 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -949,9 +949,11 @@ qca8k_mdio_register(struct qca8k_priv *priv)
 	struct dsa_switch *ds = priv->ds;
 	struct device_node *mdio;
 	struct mii_bus *bus;
-	int err;
+	int err = 0;
 
 	mdio = of_get_child_by_name(priv->dev->of_node, "mdio");
+	if (mdio && !of_device_is_available(mdio))
+		goto out;
 
 	bus = devm_mdiobus_alloc(ds->dev);
 	if (!bus) {
@@ -967,7 +969,7 @@ qca8k_mdio_register(struct qca8k_priv *priv)
 	ds->user_mii_bus = bus;
 
 	/* Check if the devicetree declare the port:phy mapping */
-	if (of_device_is_available(mdio)) {
+	if (mdio) {
 		bus->name = "qca8k user mii";
 		bus->read = qca8k_internal_mdio_read;
 		bus->write = qca8k_internal_mdio_write;
@@ -986,7 +988,7 @@ qca8k_mdio_register(struct qca8k_priv *priv)
 
 out_put_node:
 	of_node_put(mdio);
-
+out:
 	return err;
 }
 
-- 
2.34.1


