Return-Path: <netdev+bounces-53552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EEE803A73
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 17:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 869B81C20B0F
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 16:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6755F2E627;
	Mon,  4 Dec 2023 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hqp1KtIG"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2048.outbound.protection.outlook.com [40.107.7.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B5E9B
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 08:36:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArAC/tJgVxB27cVDnqnhwXkZYQRv1p5xIHhUI7KmGTbgGyaKhnKKA30co3FyRspfNgZKOxlcGugSBmz9LzkwzY6TWhnVOMUkwb+8xyAHduy8VUOOUVEwbbto9MttFWCgcEY7eM293hy8UQeNozkzEBP/CVYZpGyEdx6T2FLY0I3fqrlqGQE/vLYB+xc2RPFLg4jzD9nwlR2EaODLntX5BOWip5jmiYzoVn4XMvBGsj6z/udpaLmUyH62v9XHJR4lOB3smGHplJu0duvCifH/tnKtc2/3fHeZREXChtriEh3h/VlkQg0+Spa178VEsMIq6m15pd3JBViKv5foBPYCog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xqYtUYrZxCEaQKnzG9+YfLrmnMxc3AKXSS5EYeyANk=;
 b=fCB7Fbdr66btgInvMfR2OTC4lzRlgFy2reF4WedvUAyr+QwESifvs9uUObUecF0gTMK5a2gkSLbBeHMR/+n/63hoGeASB7c8Ghoem8iI/1A37+2VAhasLkxWkUPExiUVxQdPsOLRQtRC07ww7H0sFyoU/eJYQhQvy4/4wp5oqoWloXF+lr6vf/tVXCXB9K//+sJ+FgWUROTZPRX6Gp8G5VOslg2aIBVqNpUHA6f0w91EXBOE1wJEBfZnHhqzxuo2svnOi/30f3DeQ3aC/7pwS5UiQs/nZPF8bMetwirsiyZE4oSAJL1ym0BTr4p1nuiLl8rcP2ovyfNEFJKp2RKJOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xqYtUYrZxCEaQKnzG9+YfLrmnMxc3AKXSS5EYeyANk=;
 b=Hqp1KtIGNdMg7uhY+aHzbOGSeXQLFPPwrZ+RHn4qnUdyY+WBNgZJTxGHFf4Gw5dSlvOF8wfep0Zk4rpP/mtPB6F+A62Y00ty7UPIN9cULKb4oYvf2Qq29PetfQelBZSwP3JjTVz08vfwKSwHwm0FA2rxGzcFxH/Xjv6zXK6iR40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AM9PR04MB8356.eurprd04.prod.outlook.com (2603:10a6:20b:3b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.22; Mon, 4 Dec
 2023 16:36:09 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7068.022; Mon, 4 Dec 2023
 16:36:09 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 8/8] dpaa2-switch: cleanup the egress flood of an unused FDB
Date: Mon,  4 Dec 2023 18:35:28 +0200
Message-Id: <20231204163528.1797565-9-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204163528.1797565-1-ioana.ciornei@nxp.com>
References: <20231204163528.1797565-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::10) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AM9PR04MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: eced5242-d31b-44c3-d134-08dbf4e71ef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FjkxY+99sapnmUBFCz23jc2HlM0NOKHZB/zmVJehU1KbEmffdVpdu4aNp3Tgqv+Cl1M32VwvkFno8Eyh4Vz0SK4fkUciMcqoMh1h3pwXhPiVOIvsl2o5I8yfS6h6E/ZcilMdriAcDsKNCyCEti1CsktF/MtFnnCTOsGcrrqHtCPuSikawfF4ndln4RSo4oj5qcoCsJMg+d+vu6mvf4fpRVRMf3EgvP8RS/pPpQwTaurJcXn264lff9vO5C4rH8GlOy00BTFPYxZJWeWyTkV/EbmajrLsJUBss8/rxQxuCFH1tCTroRgRIPqvXzKaRNU0JHDVlcfPb8hoQ+aKNhjGb7gi09fMwsSdx9bWd13OxzSGvjiPP6WEP2epvdyGT1YY18Dn4fUzrAWCdpT6HBqkgopa2Ld0uDEzQ/AJAuKKt282SCixu5XEV4wEG2xoObh6RQKI+kisU1Cft0R8rKpxKkIOVkcE5R5uo769R+xW75u6CKnj4D7SAE80ProHNF73WsvV/ubbhqN9t3SHyDFDJfk7URgPVoKzlm3LwF1tc+wpLeUW8lbIK7XbLn/Oo0dI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66476007)(44832011)(316002)(66946007)(5660300002)(4326008)(8936002)(8676002)(6486002)(38100700002)(83380400001)(86362001)(478600001)(2906002)(6666004)(26005)(2616005)(6506007)(6512007)(36756003)(1076003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NCB2SZN6Kd0xNMR+daNxr9Bt4Qhq8F2gDmAcogSZmcqv62QylIxzkjz4cnP/?=
 =?us-ascii?Q?8GPeOasPdtImRkVmmQjjOXdkKzzbctnrzfscgA8LCEsCC1LH38ueZPgPv4ax?=
 =?us-ascii?Q?kzGeH0xmXzGT9mhQ877Cl/lFNTJob/Q8IZXAMVs6MdgQNG9Oo/ykoJcrY4K4?=
 =?us-ascii?Q?g1cz80wf/OkImkXDcGx4d41Im6oLPaqcgNHE5X6p9Lt2RPXuxbaFZ/GvMA+R?=
 =?us-ascii?Q?DrGGe9uOui0aEXOKlImFV6dfRkescjIB+zK857F8kY9KOGVpnCACVFaqvLjm?=
 =?us-ascii?Q?5CU3NfHgKNO3mgr4KYIrYmOMnpZTvYiQdd+3YWly8DRjhXJK+hslt07DoVIp?=
 =?us-ascii?Q?jZlIij8wmNKaqUU20a8H3uoouDuVPb46BnlOaird07n2Hm6768i5TX+30/8Q?=
 =?us-ascii?Q?g7fTv9SEKV6sLOPiRkJWXGZfAyKm1uuVEe1BVBU54nIyMMegFeg7rBp78Sw4?=
 =?us-ascii?Q?6RIHbq8ne4LiqwvB5ngU3vRm08SlBJycvnS7vIOJCdZ8X7qbJyCbuWKBTwbZ?=
 =?us-ascii?Q?sspwEiv39x4kgtn3d46C7gvaSTXwXKBodpkY03nfny0V8Lym8e+Oy38ECZsC?=
 =?us-ascii?Q?t4E3YwbxCZv18YatAQYoskqQkEHiRfBinQkHQ8Z5h+3D+3upQfJs9zv2yDdr?=
 =?us-ascii?Q?HnGKj+XVUUrDx3nOK6FHUl89AGyXiJx7c5OgpRFZk4CUrThovcaMbFSYCPaK?=
 =?us-ascii?Q?xpxzPbwy/IeuAC+4V39TDFAcLP+acdpV4fu7C4l9HVRnFfN7v6Cjr5e8vaQp?=
 =?us-ascii?Q?mC+atO5Bb2BLFnTNT0c+0wA/Dv7Flo0as1HC0eEQ8TNoHgigo/dOaAZ3apol?=
 =?us-ascii?Q?+c9kFrJoZzcrodxBmVjznH1QwSH+3xnXNd7xY05hlwXp1tUYkpDKW5CxGC0y?=
 =?us-ascii?Q?o9QiOZ47sbTiMjX+OknwpnO9aPbIdVRutxme+1k/bi4pr6x7i27AQE6bHoKs?=
 =?us-ascii?Q?n4EMgNNCTAmhnrwwIKo2QggYNDAIZVqgPlxe2jgwR93Rv2Tk/YY9WYjWVjkw?=
 =?us-ascii?Q?nRqeFnVQd5vvzB7mQUMiPvGBRJklPJsma3SrTx9m0nq1EgYkS5lwbOLJ1evK?=
 =?us-ascii?Q?QJg4VvozGiwt7BZg/Z9AkVZbFLK2Er70d9Y0B0k2VclUwmukOjyDPozn18Il?=
 =?us-ascii?Q?Al8nOFwh60wZ62jhKz2Oz+byVT2C3Dz+8IHOku4peOVaZSpVnajPUbiblh5G?=
 =?us-ascii?Q?11MxOkxLGlUUaZlxLE6uf3w5UJao9iuXzShDZYWhyHWXIYliZnDBJ95OWvW7?=
 =?us-ascii?Q?4d317t6H8080+ZhmpTd90blcP6muUB2SZpvCVLKejS6h4dHEIfbrbgOf4OM3?=
 =?us-ascii?Q?l21/I1Oc5k8t9pagS8M687PgBAaMjGcadfTpukY+Us+36PcbJslAlfNWTw/w?=
 =?us-ascii?Q?aT7aD4qwQlNrehP+3QiV3xN4t5u8IlOgjQB6TidcThbuUuQ7dOCnNqGLAoP8?=
 =?us-ascii?Q?9iuy/aOPWfir6yinrw2OVRIND9nfoZdgUP4movXTB0Wd2ls1cxlKkklxH7fu?=
 =?us-ascii?Q?2GGXgx35LpVKnzYFUPPfG2X5VUJrArC6rfRrPogXT7uC2aTUA4WLnh4PGqiT?=
 =?us-ascii?Q?wkchP21GQNWhsLYV+ZJ4m/u+QvRI3J8tKuQcM/bi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eced5242-d31b-44c3-d134-08dbf4e71ef5
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 16:36:09.8480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E3yH0KPHNf9iHuxDyN6M61WMpYJ+5JrspVByMiDsuhty+nSoafN2bJ3EoL2vu/n1hTg4hX4V8EQRUtCTxGq5Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8356

In case a switch interface is joining a bridge, its FDB might change. In
case this happens, we have to recreate the egress flood setup of the FDB
that we just left. For this to happen, keep track of the old FDB and
just call dpaa2_switch_fdb_set_egress_flood() on it.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index dd878e87eef1..35f71c3668ba 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2008,6 +2008,7 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct dpaa2_switch_fdb *old_fdb = port_priv->fdb;
 	bool learn_ena;
 	int err;
 
@@ -2028,6 +2029,11 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 	if (err)
 		goto err_egress_flood;
 
+	/* Recreate the egress flood domain of the FDB that we just left. */
+	err = dpaa2_switch_fdb_set_egress_flood(ethsw, old_fdb->fdb_id);
+	if (err)
+		goto err_egress_flood;
+
 	err = switchdev_bridge_port_offload(netdev, netdev, NULL,
 					    &dpaa2_switch_port_switchdev_nb,
 					    &dpaa2_switch_port_switchdev_blocking_nb,
-- 
2.25.1


