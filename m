Return-Path: <netdev+bounces-58879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC0E8186D9
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 13:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891F21F24736
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 12:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8742168A7;
	Tue, 19 Dec 2023 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CTErAHYW"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2060.outbound.protection.outlook.com [40.107.6.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FE716423
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 12:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZ76IVcOqmpjBtaNWD6VAMGhJAxbCSYymVNaFMXhpsCo15pwGws+vn8AGZ+xjMpMOMtpgXSep8KZM/bibmI9pKdeB4YCFzGlMckudV60twb02/4TAV5M8eGL7riutwHjc4tnUChZ4dApg+H8Xkl3NCSGjuFq2CxlDzwyeNXLymTXO5cE012pL7zeRxWcr2CMfG4oqPp60hYwaPYWnuJN8pMlJd8r72a0j+GJ9LlKiKd9V+z++ep9odlbJBbDW8yEK0xTyuj/9FYgJBprxOddMCPoM93hDOxvkRYpAiDlKFeWnC5BP9DWTSRcNjtmdjvJdxpThSjVGW94v3txGwjaeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j56tiUg+QQRSMpOIxwL2QVnsNYrYNkzTU56xK45evqQ=;
 b=k0BPbnVu0pt/UUE9sFZ6KY34lsKl4d2PpW26x1JAhHxKnJn9Hc5WerfTj4I6lNGrvp3kg7kOCkQCvMx+bD6Oj/CXa5Nw9X0tPKxOoL784MTEW0008svJb3UzYb5F0LWoOVxlIV9XEvJ3FNlWi/3E8Xuq8Bkq4HIcbDtb/G2a+BHrsXz/QOQ7jK+gL/jUcsgc0W1GLnZFEdCU+upXd/SrnKIyHjzEEIjEDVmdwl9okEp6NYbOWAjHO70siwHG1soUEpkDgsDyjD0Eo3yfIAi18iac40RbMvMHcNsQF4ncVJwE1ti5HEncbn56zP0lSSd8jdYtGv8BEccl5EWGw77aVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j56tiUg+QQRSMpOIxwL2QVnsNYrYNkzTU56xK45evqQ=;
 b=CTErAHYWrUfqahrvsLgwVEI44d+kOjgped9Kbh6FP4hSrrJdFz5wZrZ+sWmb6ui+N30BtcYoEo9medstPd1WjK6RIq1WTcWf8progAgHmhuH+G2kWAHCJTqqEnK/bYZNYYgtHpd8QugPfuU/ziCVGZJkYaBqb+hyrBln9UUvBmI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AM8PR04MB8033.eurprd04.prod.outlook.com (2603:10a6:20b:234::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 12:00:10 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 12:00:10 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v3 8/8] dpaa2-switch: cleanup the egress flood of an unused FDB
Date: Tue, 19 Dec 2023 13:59:33 +0200
Message-Id: <20231219115933.1480290-9-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219115933.1480290-1-ioana.ciornei@nxp.com>
References: <20231219115933.1480290-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0014.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::18) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AM8PR04MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: d03bbfd9-353c-4efa-4668-08dc008a0d14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ylle8TVWEj5fNsqlyjxP+GPSM0Zqz0/bqSNLdk46sZh3hUpGntmcvHLPFNQD7Vu0V3zwPHC2THoY+xveOjwSBFVj1b0Of4f0G06f/SUT2tFGA91+idZjT+FKWwarAoLrLEG238yqg8/hM6OOiY2BXgSxOi5TN8coUmlW7t7Hd/IvaZdmH9WujGly0h2vY8xCxjvp0JlY9TBRKb8v69hDNio9AAJEXpTzW2N9w/SRTQ05SeotwiQBGbZ1+MYVkdfkESRMTcIvFsUZe5JC/At0c5U0OAkDc7zOX7YcD/MSs1BI37CNquEifPdOskWmGiPfpyPlZDRF8ENVeQ2mu0JQ7D0cIT8CckXirTNSYju0OZootEf7Q1h+qvERJIEEnqGyLvZc8YGlgbaD1AJJVQsxOOBqhzBmJCEIuC7qYL4A8VyafZSoZg7aivDSPv5lBaTGBA1u10uhQG7MWyoxuCFQydm2Tp9AdnhcHqCPjHjYEro95T3d0D6z8MK11DpWnwyqusg0d2WdQ3Ez9H9UY++Sfz24Y+k+6QuZagT2g/Bl5vaXug3xHesOWcsJ7/P4lB28
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(1076003)(2616005)(26005)(38100700002)(8936002)(8676002)(5660300002)(44832011)(4326008)(41300700001)(2906002)(66476007)(6506007)(66946007)(478600001)(6512007)(6486002)(54906003)(66556008)(6666004)(316002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xg8Qx7irs1CQ60ccIgfbW/QtQHTnDYgB4TOAddb4rf0CYZuISVG0oVp6UC5e?=
 =?us-ascii?Q?tl9eDkp8YbHIcaogWt8gLAjXJZMTmIfzUtA7zAgEFXzGdUOUkyYsTZ0btZ8I?=
 =?us-ascii?Q?v3Hr8P8Jwyf5t3H8dp8pzMyTPsSyS42Acnqv84G8KIcffzw7dmUQJr0hPUja?=
 =?us-ascii?Q?qjD9vHmtipcYnTo0SK9s0JMUgq+XDL/LHhnD3JqAzji1RWMpkbI3OizqgMLA?=
 =?us-ascii?Q?I1hp7EIV7VbRgtElz7DU2y3DCfrWJR0l8U8gaekaj2SNETHquDphvthycva3?=
 =?us-ascii?Q?RU58q7EcVVMnH7RV1AhVc/+oGwGSqR2iwfJyFbfohJrbxBIgLmk6pH8HeD/s?=
 =?us-ascii?Q?bxL4gwXZV6jRzFQeb24L4MzB16hjX/pqkPo/2/UfeuHdO64wXLhyDibBPWlk?=
 =?us-ascii?Q?y1D5QCs9OHNwt1T2Kxvr+xwIAqEGADsNZUl3AAl3nO0fr0e1KKgchvfe620i?=
 =?us-ascii?Q?vGVqY8S1a8h2d5GwU3np22CgJzAdr93Yw+apCMwV0WGfKqzI2BKlLbgoryyh?=
 =?us-ascii?Q?DHonkNdm7rOLPbEhMN2p1MmW7/nOT2hgddwsW0bJd/0ohwdzZkpIGGkblGpY?=
 =?us-ascii?Q?k0IyeWPeu0CHWknAo9OCv1xggVf47tmnSLS23RObdzhXwc7K7zV+Etn9+Zbn?=
 =?us-ascii?Q?OFrZdLZJ7l5VGltjFc3Sahs5rvVhmoRslwnhr1gyHWYNbwnRxTF2nI6YIISG?=
 =?us-ascii?Q?AvMFdJX/qktiP48dcky24tA2VVGTwwi+DC6KcJd58CcT3atyqVbjs3p+/Yj+?=
 =?us-ascii?Q?fJ98Sji1BRTyU2IynsaVpS18pTn91genaNreGiKOcE2bBbGT1E5TH1CcAKHg?=
 =?us-ascii?Q?1qCIUkcI6KcDM+LzL61Yzmf74UZbWPtpIwWMuT9FeMc/0bcOBSIN3ILjwSLG?=
 =?us-ascii?Q?MTXCrxDIsQVaxrMkZSCuMiGjb3MxJ/1fNN53vNCFl9Jla4BPTBmB4b/dxiHG?=
 =?us-ascii?Q?j77AXEuijBi/tGS0D5Mlu79frtq1fYLsIGQBWkggOychWxeagieWQY4pmpxd?=
 =?us-ascii?Q?jJQWFJOsxjEsLkqvRXeoix6LHdkO2eSoRBgSTDG0+w1/ch3y13Tzuc4TBjQj?=
 =?us-ascii?Q?OHpE7DobkIqFwhXZdwydW8eov1O4s2tiRNg0BnOgBvxdZ/3RRpDwsDoPtesL?=
 =?us-ascii?Q?5V7/u7oVwokHMZJeDi0FvDbHwYx5THOrWC2TMkG87X6Ilz1HvnpOfSC5CPXT?=
 =?us-ascii?Q?+bPanq/klAvcUvKzhIJfCG7mae652cQLzQm+7B7Zt2MpqqEXrvuFnu6rPMIZ?=
 =?us-ascii?Q?uXohf97DLm6djrdZMw3qw6Ekrx20Qj408bbq3nXRNCXnVHEbwjGZYyam6Vc/?=
 =?us-ascii?Q?VgIvT3kdrhid/sDStzWzSZz1ivR/Wz+CGidWWsZS3ShZplGyCJHorE2rrZ4E?=
 =?us-ascii?Q?KKYEdRrpkgPbDwnnQqjj1zVmQfE494UmsGmB++gouNCGlmQmDv4bauhHA16O?=
 =?us-ascii?Q?07DxTJUtymQjv2WzmnN4s91mO1zISPCCyKwC0NQjZCyygR2CsrkoGlZLK2vW?=
 =?us-ascii?Q?dkRXx3oH0q3s+SMOa+CCaBnYhVCSJvzzJGRih9PhCYSyqLYaDSHZyLMF8Ty1?=
 =?us-ascii?Q?SaIdcQClc/UO6No9hshfD83L1LyBuS5tHVHZqu9C?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d03bbfd9-353c-4efa-4668-08dc008a0d14
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 12:00:10.5916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTNJIe+rRVf/E1xK7dZF5QpAd4mBKKL9zsCJ8K9b9JMkmPoZR9wFv8qEPw340RG64tC1NxYJup/oChJFr2AODg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8033

In case a DPAA2 switch interface joins a bridge, the FDB used on the
port will be changed to the one associated with the bridge. What this
means exactly is that any VLAN installed on the port will need to be
removed and then installed back so that it points to the new FDB.

Once this is done, the previous FDB will become unused (no VLAN to
point to it). Even though no traffic will reach this FDB, it's best to
just cleanup the state of the FDB by zeroing its egress flood domain.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v3:
- none
Changes in v2:
- add a bit more info in the commit message


 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index bccdaaaf5ea1..f3543a2df68d 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2004,6 +2004,7 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 					 struct netlink_ext_ack *extack)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct dpaa2_switch_fdb *old_fdb = port_priv->fdb;
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
 	bool learn_ena;
 	int err;
@@ -2025,6 +2026,11 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 	if (err)
 		goto err_egress_flood;
 
+	/* Recreate the egress flood domain of the FDB that we just left. */
+	err = dpaa2_switch_fdb_set_egress_flood(ethsw, old_fdb->fdb_id);
+	if (err)
+		goto err_egress_flood;
+
 	err = switchdev_bridge_port_offload(netdev, netdev, NULL,
 					    NULL, NULL, false, extack);
 	if (err)
-- 
2.25.1


