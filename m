Return-Path: <netdev+bounces-56529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0F580F36D
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 17:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87F6281D77
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 16:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEB37B3A0;
	Tue, 12 Dec 2023 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aWz+NyFQ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2062.outbound.protection.outlook.com [40.107.105.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD76CCA
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 08:44:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ucgj+0TvpumwmXMu47eOsy9v9W78TcFWEU02cDWu4ZJF0rWknOrH0gT9zDPRTjUF8UfP3+OrLkLO6p/9Z1agpvq7SvfRjqs0kSKdia5+LR61RaMRAgoF77XiwzBfl2D7JshGjO4ot8EfKrXKqjj/t4RJTYZQw2iWHZ8efgOidxxDMLD3NP7jodYW4yAywIvv1/t27VA2/h6VHKo+JEyEffHgDdDzIHC7PAdm3Dt5Dwns29xWBWnYcDEX6MgiQyrFIZrg2u++0H1R7Yma6hjr3VMRcYp48Yds/ngrwYFRKSIBQxiwFPAt8Wdrrwjmi8WZfne+Rogzzozv0J+KQcwSvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkLSafaQc65l2tBagVuELTxUCCaFS3jlnqQq2pFYbbM=;
 b=FRJDJ9Bh85Oo0seHD9207uWUn9V4QW/3u6HeIKa7RD+mlsp2e/p8kgGWopnK8B4qRn0S+jm+sHliYm9BxC2mFqavY+YO20iZEWDtolRh2FtK3627/oU/Pfx5oW3HGGjMjqDB8zXfLhRJU0ttYceGLV4DmyWq2B5eAmL5gCJhOG3HdB3aqmQFt5FxPfkvWji1Tcb/NZUKzaWY00HC6iaZWtoSWKMG5EHovsR2O0bF+WJoTZQB6M4kujAf492bwF1FMhTBhAJmcYRawBhHIc0kCe9Tnk0PlGgGtloevZflTBIRnQEyMgtnfwiQofA/iWIzttsPsNh0TpLSsQe146ugkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkLSafaQc65l2tBagVuELTxUCCaFS3jlnqQq2pFYbbM=;
 b=aWz+NyFQKDPDRQ5sk6GBi0qhgZwwHTZz4YmYBrUE+e05A9Yx3B2VI8sqZ/Dy72mkeUxOpW4sqQOctetlL0kqBl40MLit/XV2TVwAqsPSXMkvASXxDKtK2M3dW902usETqnEKnnFga1kLpEjaEbgErkZzWSe3iF5lGXh2NZ4MQRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by DBBPR04MB7641.eurprd04.prod.outlook.com (2603:10a6:10:1f7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 16:44:00 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 16:44:00 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: vladimir.oltean@nxp.com,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH net v2 2/2] dpaa2-switch: do not ask for MDB, VLAN and FDB replay
Date: Tue, 12 Dec 2023 18:43:26 +0200
Message-Id: <20231212164326.2753457-3-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212164326.2753457-1-ioana.ciornei@nxp.com>
References: <20231212164326.2753457-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0017.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::22) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|DBBPR04MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: 11a3ad45-91d2-4cfc-de48-08dbfb318a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vv/uHtXK8BV0AhyWY0yLCNpeJgS6EZqVBI50oE0X/IK54cXy6qDI5Rg9QH3WaorPSAxGc6Ul5xfoU3oL+K+FdHEN3wwlVQjH1qZXRGOAEPJ0JZ4o4F/aJSnjp89wOfTFGrU5cTROPmG2DGDAq2tkOGCOj6/7HBv7qpMNlLAdFDbxo1zNllOhbs6blMg02xTiyvobzm+v6+wk5d/X5iIPvqB04MhuCB8CRP2+Sg5ZjptB7rc/9t6sQOw80009dfnBb2IA+WwmGICTDm5FWJRlovJfz8yZyVRMdwFHzIHthEYD/Qtu/tNKBPkfIZqjw5bXhQRiIHaFt2ZtNN4yLgY+PK8mVfAUrb/hB9X+IPAXB3nxsXrikHmWOhW3Qc5fUx6+g8e9/MBYyhkR0zjji/0Z/JgzU1wpbWHa+I4TQn5NQD7/R61Uewc3LpxAgt3lw83nMFVkxCr92T+RpVTqbCFvKpRpQiRF0FW1MkVZnuqdoqZna9Tv9EwHqsGYWNUVIz5FwRBe8r9JQ1KBmTN4lQ9lc8R5Gho7ilMaID1QObP8VEAnvA+y7ZjoKMqwHmqc4cTD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(36756003)(83380400001)(41300700001)(8676002)(4326008)(2616005)(8936002)(66476007)(316002)(66556008)(66946007)(44832011)(86362001)(1076003)(38100700002)(6666004)(6512007)(6506007)(478600001)(6486002)(2906002)(26005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BVwZbIbaTnOrx7BrOZ7793YWPlD5fowa0TalauGQDMWZ4nS/z5FpEmV2LvdN?=
 =?us-ascii?Q?wjmK2eTyZ5VA1sgqAAa4kM+WRWMK11jFSwBI2p4Khz1pHZknr6GDCPkDcHxd?=
 =?us-ascii?Q?Y708k13afX7h+lTq98v8H1QYhKgwT20qcXMRS5WzlgazAbeUgMU0d11eyk+r?=
 =?us-ascii?Q?x+xNVMokzRI+SOL0faqj+UMC12Cip0LwKz61m+iv8cx5Qe+Z9L69+UuvsoZN?=
 =?us-ascii?Q?xZxYY8MS8aZnd7pMzmVAaD8+wtUOZ0WqLZj1MZ7blLH+R/MilkWVFeIhP9FG?=
 =?us-ascii?Q?BKGkKuOHCSTEQcsr3UkNU4Fd/3E/p9gzWRlCr8qByXPj40PqlZpZltXlX39X?=
 =?us-ascii?Q?KoTAV6l79e8g1tTu7URY+iO8wsugO3ZltKj7fUpL+8wYT7i+ukGarXSXvBR4?=
 =?us-ascii?Q?BwiGk1GXCaoWdPGWSEcVxdQ+t0gT6ht7yApQrVMVs1z7Q/Js7UVZLwdq3wSu?=
 =?us-ascii?Q?EQuwaGRJ4ZeQIoU5rRrlxxVG2Ds/pvkIE3ddtj5BY7LNN3y3pAwuBGV+fAKo?=
 =?us-ascii?Q?f80Zqxju6dEHzFJrv3p5RmJS8qFhpbpnK2Qbi06q9ISjQ0q4ZgmUtfB2ppZ3?=
 =?us-ascii?Q?cO/OIJ/5lYo6RjWUOhqlJfcsDnjCIqlV3oUODeUx3bWsDeAt2s5RAjUyfiMc?=
 =?us-ascii?Q?07L1vtQf3XVcZkX8KU891h+01LFbgPEDhgImeDF/O8AsEqSjpoPm66J1eDkR?=
 =?us-ascii?Q?JQV2tC2uI69qdhrUZn62NUWVJLlW4l++9ZDf5KxvBouDAeYPRqchiCOJhVo9?=
 =?us-ascii?Q?zEpBGcSiB8levpyck9zkrdkEZc5HK3DVo5XwvxWc7gCiWo4xLPuTd1t11r+3?=
 =?us-ascii?Q?X00DPl/lNUdfIO/zdxAutvs6JGsznfXseRSc0PdtoP25bSv+Rug9IJDPn4jo?=
 =?us-ascii?Q?olPAVUHRQgEP8WMyMmEtG/H8Ar73oFIM3Df5Yb7DmaF5PuxpT4mHE+YM1I+S?=
 =?us-ascii?Q?mPsm5vu+mlLCOR6IamM1OrMafeJ7eB9IAhP6HA7l4LLqD9dDU9RpOc/ub5tC?=
 =?us-ascii?Q?rmpsVlsUx2wMgjEHAtC2/noHuiSVpHEDVXFxpvdlN7ajKb+nRlYQIFYPg0+D?=
 =?us-ascii?Q?l3weGH6WWDVoAlTJTuLq0bPNZBks+ok8JA6wePTMwXMRsL752PCO8Zl5cpGP?=
 =?us-ascii?Q?BX3AyJUJGJ/0pbqnXPAhO1SUm5c0FgtGcDB6ojPHL1FnuYdmQi99lPQJnTGP?=
 =?us-ascii?Q?13PcO9iovCeoZ3AbWPWm0R0hzlci4WF7F8Vakk6AgTp/6WRbKNNe5qIWJbVR?=
 =?us-ascii?Q?FAaF7coA1B3gJs8YAm/1ivwSRd6baaHOvvkH9Dc6UCkzo6Mpl52+dLpv33q/?=
 =?us-ascii?Q?5K/q2mH81ZWD090RpVTNWCSnuS8fxMJ9gbgO4pQX5am2iAoKEeVeN5yN2Mgr?=
 =?us-ascii?Q?YLvMnIL97+07HTmYluoPENzvz/GM/EuNA+n/MvAs5pAjpiOefHvjN91nMZ3p?=
 =?us-ascii?Q?oznQxRA1ZepgSyVSFEL79KfW2B10sZdd+VmY4d8loP8WRdyCG13g2s7tkSU7?=
 =?us-ascii?Q?cHFHwGPXUM82APa1zg899JtsDouOqewnFhirdXKuhWfDMClFIjzRGYIMXxn2?=
 =?us-ascii?Q?fO6xAwcJovdRg1ySYrz3FplkvW9Hznjgj971aIzs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a3ad45-91d2-4cfc-de48-08dbfb318a84
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 16:44:00.1412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IlwTUkZgeT3XcX0TuLkTl7q/VL5zY515px+nvAM9RyaJooF8IliVrS67ggL6Bp+zNEZ9lZHhQRDj2mHarhqgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7641

Starting with commit 4e51bf44a03a ("net: bridge: move the switchdev
object replay helpers to "push" mode") the switchdev_bridge_port_offload()
helper was extended with the intention to provide switchdev drivers easy
access to object addition and deletion replays. This works by calling
the replay helpers with non-NULL notifier blocks.

In the same commit, the dpaa2-switch driver was updated so that it
passes valid notifier blocks to the helper. At that moment, no
regression was identified through testing.

In the meantime, the blamed commit changed the behavior in terms of
which ports get hit by the replay. Before this commit, only the initial
port which identified itself as offloaded through
switchdev_bridge_port_offload() got a replay of all port objects and
FDBs. After this, the newly joining port will trigger a replay of
objects on all bridge ports and on the bridge itself.

This behavior leads to errors in dpaa2_switch_port_vlans_add() when a
VLAN gets installed on the same interface multiple times.

The intended mechanism to address this is to pass a non-NULL ctx to the
switchdev_bridge_port_offload() helper and then check it against the
port's private structure. But since the driver does not have any use for
the replayed port objects and FDBs until it gains support for LAG
offload, it's better to fix the issue by reverting the dpaa2-switch
driver to not ask for replay. The pointers will be added back when we
are prepared to ignore replays on unrelated ports.

Fixes: b28d580e2939 ("net: bridge: switchdev: replay all VLAN groups")
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
 - Patch is new

 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 97d3151076d5..e01a246124ac 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -1998,9 +1998,6 @@ static int dpaa2_switch_port_attr_set_event(struct net_device *netdev,
 	return notifier_from_errno(err);
 }
 
-static struct notifier_block dpaa2_switch_port_switchdev_nb;
-static struct notifier_block dpaa2_switch_port_switchdev_blocking_nb;
-
 static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 					 struct net_device *upper_dev,
 					 struct netlink_ext_ack *extack)
@@ -2043,9 +2040,7 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 		goto err_egress_flood;
 
 	err = switchdev_bridge_port_offload(netdev, netdev, NULL,
-					    &dpaa2_switch_port_switchdev_nb,
-					    &dpaa2_switch_port_switchdev_blocking_nb,
-					    false, extack);
+					    NULL, NULL, false, extack);
 	if (err)
 		goto err_switchdev_offload;
 
@@ -2079,9 +2074,7 @@ static int dpaa2_switch_port_restore_rxvlan(struct net_device *vdev, int vid, vo
 
 static void dpaa2_switch_port_pre_bridge_leave(struct net_device *netdev)
 {
-	switchdev_bridge_port_unoffload(netdev, NULL,
-					&dpaa2_switch_port_switchdev_nb,
-					&dpaa2_switch_port_switchdev_blocking_nb);
+	switchdev_bridge_port_unoffload(netdev, NULL, NULL, NULL);
 }
 
 static int dpaa2_switch_port_bridge_leave(struct net_device *netdev)
-- 
2.34.1


