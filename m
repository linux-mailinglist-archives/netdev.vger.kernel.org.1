Return-Path: <netdev+bounces-56873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FF78110DB
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 13:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83CFA1F212ED
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 12:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD28C28E26;
	Wed, 13 Dec 2023 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oIdJ25qZ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A7ACF
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 04:15:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AA934ggZjf7PCplBiuAWh+OJBMgs+plMANYBd/HiMC6iDRPPq0qHm74Of6kcJ1nQPFEffqiRGF34HCf5PfGSo1Bn6/7Z6VlYgJ8vGR1UVFt6qNPOU65Y70/e66h5eAYIa9LMOtngv0AW0eq+HTfOD8hU8YWwpUg1D6izJsk9JMPTsUlFfnyHzVWVjx4UyMDgZBkZXLbqEcUkpROpEFiRBkfCtzwgCvnx/pf+YehAoDnbUhh9v+Wvqx11FFpa1Oew8r7dNuunYhCh0fYE84/iHPjdMQNqJUQkXZi3ybj8EVE6LelWDVx3LgpwinLKZ49F1Yw7m2QprUg5ddiSB9xwqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdltuH3SZgiHn+mCN7QDEGebCcb4fWERK38PuZULMHs=;
 b=NqWm6MI6QD5zPwddA9DhrY9QQujN8sCRiDeGDJJxTeD6dGUaPLTucdqFF8W4ONj2E98h6BOcaYEMxBWxBoeq7gytS5t39pCrtt+EOsbIVKPfE59A1yz/BF32jmv/idzAwrmcvrXaam05dR/tJ+WK/9OuYZmPIKRWaOZnmiU+HQ6wkTKWKXQZTEGF/H3wlUoTuqv+sceD+GgXPLtK1pZehiEX3Q5Qqhbo0Z6jAfoi8wG4kTHQgSRlT/zTWnhFAAf59SBeED+uRHZopA5iCmDjY3KjW9fkFc0suu6AebtfcYYax5S3jZtmFYdlxs/opmBsDmG4p0S11hgP0caXJ1eiqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdltuH3SZgiHn+mCN7QDEGebCcb4fWERK38PuZULMHs=;
 b=oIdJ25qZzB9bu8c4dErmTT/6xLzbdVS2Kcrtha+JlV+eHARFo8v86EWWSlOHrkSxbCPMlajLEtEMcIgIVuEJ9rX3RcPui4ObortVJpTFLfhc6NApzOeB5anxJ7Tm5sM5poHS0nEYf4AEJUvUCWsxiwbdRrg5Qu1lKGZ5dsVGZXM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AS8PR04MB7894.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 12:15:50 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 12:15:50 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH net-next v2 6/8] dpaa2-switch: reorganize the [pre]changeupper events
Date: Wed, 13 Dec 2023 14:14:09 +0200
Message-Id: <20231213121411.3091597-7-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213121411.3091597-1-ioana.ciornei@nxp.com>
References: <20231213121411.3091597-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0059.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::29) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AS8PR04MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: be251c65-a4c5-4b99-e30e-08dbfbd53f0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bWBxA0gCCmWSPPKo7EUaQWieIa6ZCPbQs3v1HLeBFiaed9eGghBegvBSD1UuY9fnt8mGhm3JT4smADKql9h8yrCveY8mByN/jtVmzoBi3X4oFuaC1oR4Vj1RbABRbqFSquQpeRHn7sqBSRWK6WXIZz1O5L1TyBlSBuIZWWtMx063z1u4R0JbWr9fBq/DiSdcAQA4uyMgkcXK08nvQdlc+wnjX2tWY3wJn3yrI3vF9MughJjovEVdQo+ty3jRfE/mlIqxgWrDsYC36AI/VMP1Wm4bWT5jWJ4C/btKsdAy5gSwunIogVLT7ciJn5F/o7WcJAWoye+GWPAGX2zndULoAElGqbkAe7KfVL0Y7NsGRAkJUoZd6avLoQsLaNHaU/jyMpEIHqLpTqa0Iv3xEiVnLxIEkTgAqn+L5HkJlN3rRgjQ9P1gHiyXSVFxhiciZrEFA/KXYJq+Rk43FchRsOYDd/oAZwzdyrCvOw3MyCfJcrmICr5UMFms8eqAw0xEz7PsRDTTi+USVrDaGCt0olAIZ3ksBhTIgVd7iTFSyFBADYvl0T/r0RDKx+NXzmJJj/LB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(26005)(2616005)(1076003)(86362001)(83380400001)(6666004)(6506007)(6512007)(66946007)(6486002)(44832011)(478600001)(4326008)(8936002)(8676002)(36756003)(5660300002)(41300700001)(2906002)(38100700002)(66476007)(66556008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cipKXvk+yWVi+zDLddx6/Dc7gsKKBtkI4HmB0NMCVO0om/JVPrj5aXHji60J?=
 =?us-ascii?Q?NwKLfx3bGdGEdHJdHVWU9bGyY2f3RzX3QLEHBOnmwh+IbDZZuaQzgBXeYlkf?=
 =?us-ascii?Q?ZTQtujtwKqgXwop6s69tAOh2QByu4h+dNQf4OfsmNYvMQkYjPRVrtFenZ1HE?=
 =?us-ascii?Q?f5svY3BOZptA035o8vVjILsvGLhK2ivdgqQ7oU+U9nABNaf++JqVQPvxubsY?=
 =?us-ascii?Q?3p98UUnVv2jQviW1KqZga+Gp7hB63FJUO5iu1B8V+sEwH2Ex63xOf0F4MMUp?=
 =?us-ascii?Q?BhrwvHDbBYX4h3Lsvg87mWbwGuivwbLj5Q1jFk0Q7pxlddYesbpv1Q1gdhBF?=
 =?us-ascii?Q?IMThbjArVHkT3NmGcjl5csagy0piNH3hcO263zI0/NP8vXXiEiyjArt3CQnj?=
 =?us-ascii?Q?tIyzLz0LMXt+MBjib0j2punTJLh1ilSFXixTYbhFCdVAPqwRDXp+MgpQJmuy?=
 =?us-ascii?Q?84RKgw7l9Sq+Xoh6V6pH7U/iql7a4cjVjNko4mFzb3TZUsZzdEvObuDlTKSA?=
 =?us-ascii?Q?Vp5Sa76TJdn7KGt/I26uwZGyZ+iyW0qoTkXlSgKX44Su4hnmpg6Iv7UPjh3/?=
 =?us-ascii?Q?vJRH+QHh0tJBrqNSZl9zGgce8n2CE6y6ZIlzjcEheaKljmCU4rdt19DmDExs?=
 =?us-ascii?Q?Bu5jsd7NqkXjHGJEj1oIr26IFdONw6WKyLuWL8T4Gk6J5kCD3jpB0FVLnyz+?=
 =?us-ascii?Q?iExxrmKxbbtbExrOTh7mJeyxgZ79T5tQvChj11XT55Hgw14U0x+UnfsehIAc?=
 =?us-ascii?Q?y+OG2wd4zI8sdxZKRZO84TdG6ObIkEGMmU4bV4IM68zoo94Gib1ImLD3hGzP?=
 =?us-ascii?Q?Q3mRSAJnjYfss8k5/TfDOxmTR+omQuDsAoJZCXPY/y9RGByRjUHPK4C4pVLi?=
 =?us-ascii?Q?KjQLbRAq4JfM5PKnIW+gS+YWgexPfShq4Myk2b/OqNWPih8C+R2S0JYERjmv?=
 =?us-ascii?Q?TjPUkQCDXaBsepzc+Jah8l7sf0I9/c+mX3LBNjZ5TaIfHL48jYnQTDKCh4Cd?=
 =?us-ascii?Q?1INRGkyBGwqwB5h7QX5FP0hGikcp/XqXj33ejFgcxo2+EU7R5srHxZKqcFeK?=
 =?us-ascii?Q?bVqaEHEPKByyO3sKgK5nHjlf+cC3ZXghTvOOr8EkMkpX7Up9FWzHTT+OYJep?=
 =?us-ascii?Q?+I4MU4luA/av+Yn6HxALQi8Y2fM9a5vgk+RaDIdwNw5dUlYWzFw4XmhR8P2T?=
 =?us-ascii?Q?rDOhNsDoEeBtEgn7lO04HF9fGFE+pjXtpOyqSrY4KM/Cp1VQsQuMjn1OymIK?=
 =?us-ascii?Q?5pDEDo/vuvGCqFbjwgKMaKdzP6gVLOPID93mI2mqFdI8sn88Us/V2ixEBJ+k?=
 =?us-ascii?Q?KynLBbvJacmigUHyyf/WGA9+Ie9LqrF87H9nM84jgoZ8XREZZlJL586G5nbL?=
 =?us-ascii?Q?ZFltrVv9E2mdSovLEKxtwqC403C6AIW9BgFvGeDWosaH+JXQ10rPH328UQd0?=
 =?us-ascii?Q?cKxh8FZrcwK3WxgYizsoeYRuf4r4f/0IMfjwjcyg5ZyaWk37A5oXYl9a1vbB?=
 =?us-ascii?Q?VkUzW8CSu+WSiv2qkY61myFb4dmo7qrdOAP0ndMj5phgKomj6hEI+Gvm4ZUD?=
 =?us-ascii?Q?HLw5YH7hw5bTOOfG0HPv74X5kiHzZxNBc7znrTy8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be251c65-a4c5-4b99-e30e-08dbfbd53f0f
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 12:15:50.8692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9ovMtD6+eG1TEPn7eVG+bvIYEljhLIe3iFjXzYCnanq62boJiCfa0/kh3l/iej85lewrHOJIU1rzmxGidAvSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7894

Create separate functions, dpaa2_switch_port_prechangeupper and
dpaa2_switch_port_changeupper, to be called directly when a DPSW port
changes its upper device.

This way we are not open-coding everything in the main event callback
and we can easily extent when necessary.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
- none

 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 76 +++++++++++++------
 1 file changed, 52 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index d9906573f71f..58c0baee2d61 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2180,51 +2180,79 @@ dpaa2_switch_prechangeupper_sanity_checks(struct net_device *netdev,
 	return 0;
 }
 
-static int dpaa2_switch_port_netdevice_event(struct notifier_block *nb,
-					     unsigned long event, void *ptr)
+static int dpaa2_switch_port_prechangeupper(struct net_device *netdev,
+					    struct netdev_notifier_changeupper_info *info)
 {
-	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
-	struct netdev_notifier_changeupper_info *info = ptr;
 	struct netlink_ext_ack *extack;
 	struct net_device *upper_dev;
 	int err = 0;
 
 	if (!dpaa2_switch_port_dev_check(netdev))
-		return NOTIFY_DONE;
+		return 0;
 
 	extack = netdev_notifier_info_to_extack(&info->info);
-
-	switch (event) {
-	case NETDEV_PRECHANGEUPPER:
-		upper_dev = info->upper_dev;
-		if (!netif_is_bridge_master(upper_dev))
-			break;
-
+	upper_dev = info->upper_dev;
+	if (netif_is_bridge_master(upper_dev)) {
 		err = dpaa2_switch_prechangeupper_sanity_checks(netdev,
 								upper_dev,
 								extack);
 		if (err)
-			goto out;
+			return err;
 
 		if (!info->linking)
 			dpaa2_switch_port_pre_bridge_leave(netdev);
+	}
+
+	return 0;
+}
+
+static int dpaa2_switch_port_changeupper(struct net_device *netdev,
+					 struct netdev_notifier_changeupper_info *info)
+{
+	struct netlink_ext_ack *extack;
+	struct net_device *upper_dev;
+	int err = 0;
+
+	if (!dpaa2_switch_port_dev_check(netdev))
+		return 0;
+
+	extack = netdev_notifier_info_to_extack(&info->info);
+
+	upper_dev = info->upper_dev;
+	if (netif_is_bridge_master(upper_dev)) {
+		if (info->linking)
+			return dpaa2_switch_port_bridge_join(netdev,
+							     upper_dev,
+							     extack);
+		else
+			return dpaa2_switch_port_bridge_leave(netdev);
+	}
+
+	return err;
+}
+
+static int dpaa2_switch_port_netdevice_event(struct notifier_block *nb,
+					     unsigned long event, void *ptr)
+{
+	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
+	int err = 0;
+
+	switch (event) {
+	case NETDEV_PRECHANGEUPPER:
+		err = dpaa2_switch_port_prechangeupper(netdev, ptr);
+		if (err)
+			return notifier_from_errno(err);
 
 		break;
 	case NETDEV_CHANGEUPPER:
-		upper_dev = info->upper_dev;
-		if (netif_is_bridge_master(upper_dev)) {
-			if (info->linking)
-				err = dpaa2_switch_port_bridge_join(netdev,
-								    upper_dev,
-								    extack);
-			else
-				err = dpaa2_switch_port_bridge_leave(netdev);
-		}
+		err = dpaa2_switch_port_changeupper(netdev, ptr);
+		if (err)
+			return notifier_from_errno(err);
+
 		break;
 	}
 
-out:
-	return notifier_from_errno(err);
+	return NOTIFY_DONE;
 }
 
 struct ethsw_switchdev_event_work {
-- 
2.34.1


