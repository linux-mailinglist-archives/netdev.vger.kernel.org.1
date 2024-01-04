Return-Path: <netdev+bounces-61532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C2D824333
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F23321C21D71
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46183224D8;
	Thu,  4 Jan 2024 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d9fUdd5L"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2054.outbound.protection.outlook.com [40.107.249.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF2422337
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4YPXx21DBe4oYyA2WJfOIjGxLYXTDTQppBtVP1UwYtz/kSv9Es3bQsnju4/MZSV+naufy3WLklTkRDNL7rvq+XKi2UztaHyKlA3+4J6St7Gv5zeLFUqDyfIgYzB3wnxEChX+4OlNhUp3U3gB5VTk0UXxAEssA3u8bCVqyfQs05pChPlnAadXXxEu/SE0ic3ScRDYKDYVH3CajAx+bZIooIocN/STkm3HaAXe0vZhlPXFE2iBEvD8XEMH5uCPVTU+czYny24dUO0ZuVOxF9cCQ/sMWBxGYXIR5F4+GSuZwm9jRGVRk1ehuYs7Z6fLHI2a2XTiIg736bRuXp+/8xKCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRvQQ2Oj4QkBeNR0CqdDSxBz4d9S77nXgw34Uk41Sv0=;
 b=G+2nhP/nY9iNaxSTWvr1uOfc9sK49IIzIyTAjo2PohWwJtQc3VHcepQzW1ph6th1aZXEpnZ4YXksBNCIRUHzBfdcrFd1/iYpWk9XfX7trpFCab49sgTLspbfWE5KCvzOHuVNQj41IwERoLE+aNB/0ZgbsqazX0r4Gz6Vv5a9DQl9KJZ/lJjX8ACLu9PLcmWRdjEWr854MuG6932aiHg/VlGn8rDLL1j6o5UNhfjx643sVjrwUcItwg7rPKevjSoqbYxddJNFeo+ljoHK4ukJFXACx4OHw+WeoStHx8sZPQKHC1GUwseDnRBbTpa1LU0er7TEQfDyvXTO/CeXTlX1WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRvQQ2Oj4QkBeNR0CqdDSxBz4d9S77nXgw34Uk41Sv0=;
 b=d9fUdd5LJI6eIyn+HbpAZW2mwpZXwscLCTZrWeelW12JVcUn7VzYYH2ufmZIskJhNftFxLf7IHABZz71a9aveeGYDUbumvE4EnYop1qMPBI36dDhFbtFPZTZbkpVZK25EVeJ5U6ZTejoKzhLomVZmPsD/5tcVQYav+egnAgKP7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by PAXPR04MB8176.eurprd04.prod.outlook.com (2603:10a6:102:1c9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 14:01:15 +0000
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
Subject: [PATCH net-next 01/10] net: dsa: lantiq_gswip: delete irrelevant use of ds->phys_mii_mask
Date: Thu,  4 Jan 2024 16:00:28 +0200
Message-Id: <20240104140037.374166-2-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d8565ea7-7e9c-48e5-4008-08dc0d2d9d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ifwsMAnLHfAZtRCaYqjH8u0i410Osno5sepGCOjx89HVaAkB8tDV/qGq4+w6Q9X8+QXhc032TMRDPcaDJwYdxWhliLUswbmw5ilVMGRAIRYSb6AYNSbHo/+LP8nHk5BSOh9kGMXvu1EoEvL7rN23gvROqwLyp34fGduvTK79eSkufLgBHOKqto2fmnw8cTz+bYWB4q29ruIzBvQdufySG0puHeeuU3UPvjRxjVuv3zIgApEKimzZj6I/iMBFnPEgzq9jE/hkJSbn3KDg33EyIOlZwK8+qHRfFwUsjw4LVHafYsmKW4HXik/NO0tewURk5Y1N++iyZiLU8doDgyLwOj4WjQS+SyQHxv4akKtZhMmobyy/Ab9+4mNrmyV3qVRAmNWrHM2/61HoL9M4dzrxLeHv40ZXAJTdLU82l4SPcYcv57CqVTHd5Z4ignCxwaxXWIIYt/bvvNQpaKaXDt0XQI/P7iRtEPt+2BuVUXPT8dyD8AJ/qaJIjoXOuZqcwntQ+6BkBBJzSdu8IovUopOPubCWwfImhBtTLksDkdWU+RIbbf9Mz+pTC+RcO/qlRB5vat1ahPsYifM+2qgB/sTajnUesfFkRpM3OFfQB96DGwLwYQZ3OArf6uHTldcg/HGm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(366004)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(7416002)(41300700001)(26005)(2616005)(83380400001)(38100700002)(1076003)(8936002)(8676002)(54906003)(316002)(4326008)(4744005)(6916009)(2906002)(5660300002)(44832011)(6666004)(66476007)(6506007)(6512007)(52116002)(66946007)(478600001)(66556008)(6486002)(86362001)(38350700005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y00J8Hr+WzKV+rVHFF9kZ0dkhnXzSKUCglZOJXE1aFsu4qyD49Bdu9xDghrR?=
 =?us-ascii?Q?sTJHnUy4MyZWKSPy4DhG0CBLj+tB8BJNherH7iqimyRglwrAIE0JOlgJFKo7?=
 =?us-ascii?Q?Z1gYuQSsEWjr5aXJY/jB04czceJ6j7F/lvb6742++bUzZOA670SL6p+MRgiY?=
 =?us-ascii?Q?ie4bVsnaetm+yXZggmPmHrZ9K+tHAb6+zbrRNrdlfGX4kYcPLpZqOWCckk4m?=
 =?us-ascii?Q?70hkTs/MBN9am7OyqUCv8XzOFx/dL38Tp/vdJkAGnjBHyF2D5mzjcq4E2X14?=
 =?us-ascii?Q?csws8/ACdnpwQpuSJXHbX2F8spAPL5NkZXcmeIl/zq0E9bT70NBQK4vMtl9t?=
 =?us-ascii?Q?MRz3Dw6uLIuEi7mrx6YAfbv5NG6kZh12WtuGL5CCglFzGIY7G7WuIPr5TLgJ?=
 =?us-ascii?Q?fXZTiRIwlWjtjn4MKMVjacIygTMrFZt2PHR+roqqRWVxz38RcxDcg5zbAMP1?=
 =?us-ascii?Q?dnQJG+8BQQNiZ3CL0YGVdtRDmR2MqB8lfbzsM8n01XFGo2opuJupFMrVFOH/?=
 =?us-ascii?Q?CsdnCbgSlmvCr/HUtkK8vsxrhLBZDVEdQoRz9jPfqdHYMNy3bxi1plJNNiYE?=
 =?us-ascii?Q?n8ldMg51LvG/8T44rxRfOonfHdcdU6Qeb4YMvS74hP0LgA5bCci81VRyANeQ?=
 =?us-ascii?Q?DL80sGnMvLXT28Ufd7wWXFqHLr+CLee9IxGr7lJiZpMHxSwvk9bQTd5PXX5p?=
 =?us-ascii?Q?uBtI29/uCXSX/1XoAiLEJEQs8I4LtAT3sK8pnX3ofTKygQZ6Vca7xfDeOgO7?=
 =?us-ascii?Q?wxMK0qpXqAhJ6pj8xlRltQiKcSqVRcGdt0oDVWKVvdPD9Jl5Lbtu/6xWt5Xl?=
 =?us-ascii?Q?rDF/vZb5JsO/cvJKgsiCG5VHvMOmdhOXTxXhU2sPf1/gipCSRxUEefHv7/IH?=
 =?us-ascii?Q?wecYMha4Rnor0ASxRqL7RkduAXF0F3cTZHL3hrCv6JjQpL4nJHxyUUDQSXYh?=
 =?us-ascii?Q?/ePsS3Ou4n7ORqaCnyHKcNYec4rTgDZtVRG82PTrKF3qBb5BR+Zfa8icSaaZ?=
 =?us-ascii?Q?a1E6JNnZ8o8XGPuESZmBHYlpf7lyc7L7R0nmmYQ+tB5tPOTiU3VMOuelhc8W?=
 =?us-ascii?Q?Xk1Hv9/fmivCAVYXQVST7kUrqfPQHm98CHcvEfnb4N0uaWA/bmPcYebBZlLT?=
 =?us-ascii?Q?8mdUpXqMmRBqleeFSNrwvZPidXNEYSQrKQGRVe4vUe2tVurmLqUlOMWW3FPB?=
 =?us-ascii?Q?RoBP34mXqVW/IaNz2fJiBz4hLZBzol+7+8ai4vowqztnxX1l6NHjUQrWI/Rs?=
 =?us-ascii?Q?M2DdNAh4bJuaYqNJ2bSXXMHNvIyFU+BD9z1k9cke4TD+rf9q4jOr234RQNyD?=
 =?us-ascii?Q?P/DnLx7vPpuVw8G6+rE+yHm1J/Gj4nBEuU3O2Zo2sZZ/ka+bh/6NDfOlrdpd?=
 =?us-ascii?Q?yuYHA9lgtU6sQozKOJ1QNFz6Pc46Yjwzt5aypjez3QAMFFnfTT6qAhyfUMQg?=
 =?us-ascii?Q?JCOxYj9hzUU4F4EYdk7OfgCDq1gBKEtmW7OxXASMw33ZYx1WRjrWBArLDVxF?=
 =?us-ascii?Q?x98FDexEYLKTMi2BY5sIltcjITGyUOtC+JCMclPzBx0dftsbexiHFmUeZgc7?=
 =?us-ascii?Q?10VQKMEQYMzIWiR5xlvOl+dHW+OrUQJYswpHrvCvsTDBYXJ6tFVWYnNkLDk2?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8565ea7-7e9c-48e5-4008-08dc0d2d9d00
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 14:01:14.0532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tg3LiPNaHQypAS8EUUP4AdU8SrvmTeISodCaRcYk27M0Q4+mAyiLaZKDts/0iLn+kMYUAFlgwL+zWBgc08OjhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8176

__of_mdiobus_register(), called right next, overwrites the phy_mask
we just configured on the bus, so this is redundant and confusing.
Delete it.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/lantiq_gswip.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 05a017c9ef3d..3494ad854cf6 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -521,7 +521,6 @@ static int gswip_mdio(struct gswip_priv *priv, struct device_node *mdio_np)
 	snprintf(ds->user_mii_bus->id, MII_BUS_ID_SIZE, "%s-mii",
 		 dev_name(priv->dev));
 	ds->user_mii_bus->parent = priv->dev;
-	ds->user_mii_bus->phy_mask = ~ds->phys_mii_mask;
 
 	err = of_mdiobus_register(ds->user_mii_bus, mdio_np);
 	if (err)
-- 
2.34.1


