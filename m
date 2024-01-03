Return-Path: <netdev+bounces-61170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB38B822C33
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 12:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63FAE285277
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 11:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EEC18E21;
	Wed,  3 Jan 2024 11:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RUfPzIn6"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2044.outbound.protection.outlook.com [40.107.247.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E348B19441
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UiBVNwe0CdhmvyUxSpnvdtBxkOd8BYqXkOrjz8ZVMmB9nJtvOpSBA36DsmGgFN/i9Dc7buDI49HmKp7RwZYq0//0ZsUtBVP7YwRpuK33UCfwNReXiigNk2Xd7sWTCPEG5nqxoCa4JI9t+GecXSgCH3zmvZpud4v5ObCOQiwQuAhXIJlfHRDbG5fCao107hYyaqN8n3tH7pXVEz0z7MvrJjWqDOhijXBCMuARqXdkagf6sQwK6gLIDCCt+uLL1ojMa3yruFr7mFM/twg/9pTN8YmXv6HXFubMSq5snVVM4weXs4FpVcn1b476FGcc5tddrgjHfAGnIIx+ghMuxJywzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLooxqQgVFR1lW2n2maj4jStUSd70g/xePlXXo3MuEg=;
 b=dFRMNXjVPt1Nr7fXaXqYRCunXCV6YXNmqlOd4ecBw3yoFcjT1vQaZxGNZ+Bu4GiHIAQt/9XTq8Dm4mrCwSo4cCfrq2qemUw1z6JPAoEz+2ckxMqoziUQTwkWfLu5vaZHnsLtpuUNBob9CHfQTS10FZJXrFnF6h/KjBxzWLq1GpXdjx16AJZNNHM1yi+AFUHHaMmOzL78dUzsFk/HZ/8oZ+q5V7o5oNpCx9jAWXGU6NarOj30er3pfXN5Ue7UQc8BkyoFTlKxsHmXTXmN1D82oMg18Yg4mUTum0tOUPk5rqHPDBn1+RYu0urznu7GQuf5lng0TRKzxAsNYPsVsM+yaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLooxqQgVFR1lW2n2maj4jStUSd70g/xePlXXo3MuEg=;
 b=RUfPzIn6+RKz4ZEVVomGVwJZrj7RgVjS6Gp5rD6fCkaxcpL1Z4CKjZphBwosDomAy3vVdn06/NCI8LmvpQqjNqQjX2SqZVx35Pgb3hBi/BhuT7VWaZOvF89yTtXFD/TWlGjIAz7z1rcSY39xWEjv9g/uwl0dbOwhOVTof3D7TVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by DUZPR04MB9793.eurprd04.prod.outlook.com (2603:10a6:10:4b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 11:35:01 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976%3]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 11:35:00 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Claudio Senatore <Senatore@fs-net.de>
Subject: [PATCH net-next] net: enetc: allow phy-mode = "1000base-x"
Date: Wed,  3 Jan 2024 13:34:45 +0200
Message-Id: <20240103113445.3892971-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0017.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::29) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|DUZPR04MB9793:EE_
X-MS-Office365-Filtering-Correlation-Id: d6d1311e-9881-4e42-2f8b-08dc0c50055d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dUQR5aGJgAXYYLxr3NiGoeYeuLObcOvtAjlgVychhiAzIzyfnJGL1L26T+gvDcgSTnLYy2RTAZd3IHrPiHxVCT39YKB7ZkhttjN9dEa7nym1jJDmYufiP9QyyWxCA/YI67btotYR7gU4mkk/TaTXjRCEROrFHzWNjr1R2TNCfKajXM9+tiutynEiG1Hbz8//U8RRkQ/BlkWRv5qtVNNOlnT/2h431ITPx0to8JJRYjXMBPQvQ+kF3Z56XDtFReWStk74yiowAtorgb7dV2p2VD3e9hYew6g9jnZJjwyc2TCkf2IGA3c7f2nmRQw/7wRbLvEIlOgLMeAOPvvbUEdFhshBb5o/5uKkvymADErRVB8wHXyAjPiaCfGXXXJb4WRoDtHu+04nSjwq+7ibRWAW7tGzVZgOTnRTl/CnYmwbvMVy2RoANC9j0Ef6rrTeLH14WJrLqdy1nf0MDFxE9Mp7lxQt1ANIDmHEnH0OZTh4Ws4RXANwDEq0Dj8aF+1OwnCAmYiVYxLYtrW82dDxCIDjypDzG0aU7MY8doki/ExyUk08n5i8Bcjpb9TxYIRSHTsPEyIUd6fchOKk2kMIRcbU4gUpoPvfA60PtvnMystbLPuuTxdRYChWvaik09aVthIg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(376002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(6916009)(66946007)(66556008)(66476007)(316002)(54906003)(8936002)(8676002)(38100700002)(4326008)(2616005)(6512007)(6506007)(26005)(1076003)(5660300002)(478600001)(2906002)(6486002)(6666004)(52116002)(44832011)(83380400001)(41300700001)(36756003)(38350700005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i4qi7SiUu+CTBUhAAQV1+01txUoZYVWiX26vY7ISFzla4njpuai9bHvpZfa/?=
 =?us-ascii?Q?iEB2qMr6Njm0UVWXnGaCNt/3bfkm2fQIi7hgjN0RyRHCaPe12iaGKiSjKLm6?=
 =?us-ascii?Q?8PkkPecxHpaRlvuy15YYeNb/Y9uUuc9kiqYTY1aKEl6L/pnibwHpyuDVsc/q?=
 =?us-ascii?Q?mYbFGw0eSsUWFLZ9Gbdu76cDF1PNwL+cByyPOPjL/NZ3BNuQ+R/BlkqcoIAo?=
 =?us-ascii?Q?mBa0idq7Wjn3g3MBIYH4NTwDy6hSLd1vtGN5ZatMwUAIhXBbXf/Is5HglGVt?=
 =?us-ascii?Q?fIQeTJUqZ4j4vU0NZO2KSZ2z5mvQaurCYj7wtCVC3zN2/WwSEyFTWgRJ0E3n?=
 =?us-ascii?Q?Nt/PLTbIpMZa1HrJecd2SZYOLEKOwIYsY+BVLRRlO20WXh7p4GzkKM4rKwUs?=
 =?us-ascii?Q?0ZOawUVztioromx3eRfgrl8bVQCDzHdpnOO0+ZF5/PLeBtnTQdVUp27kCaXH?=
 =?us-ascii?Q?cnBHMHfCfmW0tcWqovAU+0KI5ql8WESpwlEnnlqd3xqceS6VwnyTaBnzdGBq?=
 =?us-ascii?Q?WqYLJMiMn4E8fxPmprjoYu3zFlcc1wZTWM5L64XNnGlfFgfS64iGqMG+RBr9?=
 =?us-ascii?Q?LauUunQPKce14FWPsSKRUiv1Ge0+8RnrcBC8YBzuvPgt0r7WGYJcMYsS4von?=
 =?us-ascii?Q?f+qbf2mCG5zXlYqpIJyxmNqduVk87cJAe64evItT+o+Q7hB+89D5MiJD48G1?=
 =?us-ascii?Q?xzdQPj0a1/3M/lfpTGC83d4asp5Mhd5WwyAOm2NFL7oE99oWDDETg3vWr1Zx?=
 =?us-ascii?Q?8OIylKRoexBHzA10sCINPuerk1MCNOslSc0JKLq8et/nUTpjdBaZROmLNKYK?=
 =?us-ascii?Q?wtxFa4eTQgnU9XMcvTVK44aLvs0WaR4oW8y/6jg/+c1zEVzh6kY580Z9Yyqk?=
 =?us-ascii?Q?6cgn9MUJJ/PWSY1BYNwZKNOdS1qfx4P8olBMcsGNy2OAYII0vtpd6zv4l5bx?=
 =?us-ascii?Q?zisUaYkNOggBDm+gmbfx8VDcWNPB1byFoBuJjY6T9cQIZUyiE6NrxYCS46ZL?=
 =?us-ascii?Q?7P1ckRWErHTLdVBiUdveAmVu/FgfNfGrsshjdQqQu/BhykPflNqOXREsoZIK?=
 =?us-ascii?Q?XbgRyxkZ2RxmY9mXMY/mHvKI6Ld/HtQBeTVJk4T3NLGbceBfS4JgAqF9wW/8?=
 =?us-ascii?Q?k106F8N38LBpv2UMS1btvztmFqUdTWCgO4XhOEhtQ2NzWfB2EiUWBS7dYcR0?=
 =?us-ascii?Q?6EYWUSKYbx7CIwbqcg+wmcInJMwFWtzMLNgKfgJ+o/1sd5UR+xesW/zd51Ti?=
 =?us-ascii?Q?sOagqvn/CusPTZ0t239zN2XghuSVb+Y1lWIjyIhEkJ5F2BXtCtChZ7p2GY+s?=
 =?us-ascii?Q?yGgCnGdrtsNcpL4Imto86o0GlQGPYmfxpgU1djGVpOdtdBty7LlM8if4BUZS?=
 =?us-ascii?Q?yIvXulZn25PZeUWLgtAgSw+nXsrcRvt5qwe13fjSR64PLO5So7jyp3nSx7La?=
 =?us-ascii?Q?slv3D1NQ8GX8Z00ECP5ZN4S/x5SOk3pd4KNjX+r1jlvGhkC37705PX3xctSO?=
 =?us-ascii?Q?RkZG0Heeonl1LyjB9lCmYB0wHupSAptROalhzHV+SD1tMja/bp0pCTgS5WEL?=
 =?us-ascii?Q?8Dftzobzt4z+dt7Tb9qWKrjMcgi+b7E53Fd2R2oeTIGE++yeStsuyUaX1y2c?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d1311e-9881-4e42-2f8b-08dc0c50055d
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 11:35:00.8172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pyCdrqkLA0AJnhABkmLVbcHe/o5jpG6K2MQeej348FxhOlBjebT0f50VNznpekV0ELQQYorAp45nmTvsCeEPDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9793

The driver code proper is handled by the lynx_pcs. The enetc just needs
to populate phylink's supported_interfaces array, and return true for
this phy-mode in enetc_port_has_pcs(), such that it creates an internal
MDIO bus through which the Lynx PCS registers are accessed.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_pf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index c153dc083aff..11b14555802c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -920,6 +920,7 @@ static void enetc_imdio_remove(struct enetc_pf *pf)
 static bool enetc_port_has_pcs(struct enetc_pf *pf)
 {
 	return (pf->if_mode == PHY_INTERFACE_MODE_SGMII ||
+		pf->if_mode == PHY_INTERFACE_MODE_1000BASEX ||
 		pf->if_mode == PHY_INTERFACE_MODE_2500BASEX ||
 		pf->if_mode == PHY_INTERFACE_MODE_USXGMII);
 }
@@ -1116,6 +1117,8 @@ static int enetc_phylink_create(struct enetc_ndev_priv *priv,
 		  pf->phylink_config.supported_interfaces);
 	__set_bit(PHY_INTERFACE_MODE_SGMII,
 		  pf->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+		  pf->phylink_config.supported_interfaces);
 	__set_bit(PHY_INTERFACE_MODE_2500BASEX,
 		  pf->phylink_config.supported_interfaces);
 	__set_bit(PHY_INTERFACE_MODE_USXGMII,
-- 
2.34.1


