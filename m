Return-Path: <netdev+bounces-56875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C7A8110DD
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 13:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338621C20E4B
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 12:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568C928E3B;
	Wed, 13 Dec 2023 12:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g+VWdHiS"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2055.outbound.protection.outlook.com [40.107.104.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80711F5
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 04:15:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GO6nslCUkY7usTx5vEaMP4N0Ysy4ZAViQj0vvJYX3S2R3G5UWBjOlqoP7ZA9A4rmQrlyqhPzAWcn2W85OwAqO8OJr4pehwJ6MQkQUcWlV4+gclnY58g6dCikLxgbACb5kgV5qdZq0rGaXr/OmZsdfIhUQaR7I0wcrizw8HijzZLxBQhqfh5FbWr8fWJHY1lfsC6r+Q+/x9GtYKM8vbSkpfbHQnSxboHn5/5lHzQFoqcnaooEqhtLXHzD/4+BuFxBK2C0Hn1RgBgoZGpqwafY+oZOFplWH9EG0pTsGQci28SYRYiXLkM60oM/yoqp451jC5F0hvgmu/kNXMR1wTXXHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzMkaaypMABxiT86bVIRC984Oc5rAq4qwGC0p6Z6ugA=;
 b=Vj01tx19t2IRo17nxoiHakcAhzL19zQTXPMOb1BoTzqR55bq89HLxJrxLyJvTlS8RUXkbeZYSFY/NoJYCjdh2NpnR+vdHR9ZwNq9Yww0lIHjCPs2T0G1I1QbrpmjJfzhoSV7/2yMn+hMU0QcSxqc8ynPSvW0ON5cyHvIbuGlEd7RRKnhFcTsDZwVWEjYNzUAatQhRm1gCafnVFd1caRTpMgBhlQYZBgA612wmvvpzEgeMmzAb1F3e+pN2Rz+Rwv9ozrJiWvfk5n/0WZ8vYfZJ7bsmwH9pru5O1BIYa5eZk415EvTiF2g1aKgtwicotCVJVGz4vfNpg8o0ksdPCplNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzMkaaypMABxiT86bVIRC984Oc5rAq4qwGC0p6Z6ugA=;
 b=g+VWdHiSZbOICy6TdgbX51YnzxzYVZtCEMSOAhDqVP69hO+8XgWtGp3W/eOHjqJyWjMKpvIvRQDi+WIOOtUMDzGdwxBxNL5npfhilA6j66m+PbuFSSBpDf3jQZuD6yf4FloIty3mr67Q2Uq43slXLxtk/TgA5mLlgt2d4RiZUos=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AM0PR04MB6785.eurprd04.prod.outlook.com (2603:10a6:208:189::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 12:15:55 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 12:15:54 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH net-next v2 8/8] dpaa2-switch: cleanup the egress flood of an unused FDB
Date: Wed, 13 Dec 2023 14:14:11 +0200
Message-Id: <20231213121411.3091597-9-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213121411.3091597-1-ioana.ciornei@nxp.com>
References: <20231213121411.3091597-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0063.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::13) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AM0PR04MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: 588849ed-116b-4105-53da-08dbfbd54147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fsbNTPIbEEBrLjxNG7yixyULVaDmBUjAwrynZDNLC1FBRTDoxC8Bi0SFCfBvkL0eMH9JYzI1b+MxfGxtNz6BwiKCUZ8huIiBq0HzCrKyND2yL2qMagM8/ewt4S+JJrNN4yciSv+gWBye7KxEfntlQtfDq54M8WFSRanrDUcW5DSUSsLHWKK0Sm31j5vMtsVptDbctKEZ1vjYfd9DErhi2CyJ4Mfe4wMZHDmfjwaZfnQ7/eHz63NtDbsKERE2yok47MW8Jpkk0v9248hpobL9MsZSQrpdS0/uE+o58FBBFFk3g/pmJfi0DUP8Z/CuNGritl1rogvrrOmTv7RRBFjxdJXjW+mpQWteku3m42oGOizvfU3LwJqZ3HIPbQ46QwKhI+Yt2VeE1NO3vyPEt8G5kglfEnM+SMyYxEh1wWHBDScFeCGllExHSHRAs5cDn9JZlZRQ7ct3Rgy5kqybs+lEY0ZUZDRKjxCwrUbamDDWS5zQ348OaNxcekW6NYFmLJ3b6YybV2Mo5SVL7YxJEaq1oTCNruR5KW5IcKVyVwvA4Q59X0AT8dzOGVuL5zKjPv2e
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(83380400001)(38100700002)(26005)(5660300002)(44832011)(8936002)(316002)(8676002)(2906002)(4326008)(478600001)(66476007)(41300700001)(6512007)(6666004)(6506007)(6486002)(66556008)(66946007)(2616005)(1076003)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qIFSuVBmg7VDbvuchBh9HgBqvt+44cLFjDA1rF/IpwzznCyqhra9JVTidpsO?=
 =?us-ascii?Q?cJI/kF4/qsyhfDKE+Q0xYMnmhGjxpWtvtYCjnjLxsjHhxgHE4l0i+1r2/QFR?=
 =?us-ascii?Q?qmPwdpLGnvnXSoR8RLN5k68iKguKQep5rqLQIEPZ7+IyIskMj1Ig9hFNt666?=
 =?us-ascii?Q?RVVatBDJray0nagF3SaqDyjjXysl5NpKDxkFNnp69MiD2VgHD10QE5koly3k?=
 =?us-ascii?Q?ZvTO3SCIGv9012SW8m9Isg6OAJU1bUyOu64JAAVNTqRqVfHsfsVxli+XysiY?=
 =?us-ascii?Q?QtAvSMfYCQUd3kfJ/FO9OvCKAgNvTvf7ddEex8AJnMW1v1Zt4Fr8DlOSCIZy?=
 =?us-ascii?Q?MU8wO3NLyTTF95k/NBlQoB/s39L5ppA1SL6BDg2dqoI02fPft5pspXQUtoR7?=
 =?us-ascii?Q?nIpy65Y2Ur3MkJUBKTJClrYu+arDAJpzYKrx7bs3qHu+/45+3C0a1ohqDyXw?=
 =?us-ascii?Q?wkHKD4hHt+nmg7eL9e4n73JnZ7M70tKzlUF4yYY21Ttv+GlmCFwftlyM8Lex?=
 =?us-ascii?Q?Naucg71Hw6uDpS9+0hIXx2Qrp0AlRm8KIUxdwYWPskQqJOJLmSL7sQoxvv/t?=
 =?us-ascii?Q?42P8pxeFCo70895LEJ2AV5mDUApIt6+zMcYWF0MQ5qrAnUv/OhSIispYS+Dn?=
 =?us-ascii?Q?H9VEGBpoOyF3gmdFfq4nNcA6FggNtJmuGBq5ZZ4c3UYrSI+8MxibCsgjrxSQ?=
 =?us-ascii?Q?Qddic7wGhnuj/TUI6n+k0b2TD9v3Cj7lG+Pvjpwy6obfU+VgqcPmb/J9MBF+?=
 =?us-ascii?Q?T00wDwYopHfaRcP/ZV2i7jSInNOWizHPoYEGAMR64f+Linpv/hpE1dSh+0oQ?=
 =?us-ascii?Q?XMSHpY7Tk3f95Laum3AaWwk5+YBA59gkJTwYsMLHwQYgzG2MPgtEmyKycrdR?=
 =?us-ascii?Q?FxUs1TSErCvS7ModzLLZJn6FsqidwDSAooIHQmdZNhoVOrXIUTEk4jKU/XKk?=
 =?us-ascii?Q?I5r1r1iC0/M9XlqJNJjV6ZUgdnOIsVQ+ILPN5DR6l2JkFGFZ9IjZCTzIY5WK?=
 =?us-ascii?Q?F0wI885UuBHgmHwH0QbYEdc+4vkFPMGgeqqCEPAwhXWhjWW0lz6JjIyCt96q?=
 =?us-ascii?Q?HjS1r1f5XOdiwEpDMwmBasGssDmfzZcpJOxjLSP01UnIhNTT+2dau/iLM09k?=
 =?us-ascii?Q?0L4IYRLt0W9IUPF3xU5zIwZ4Oi1xPUVYYEhovjAYjrZzviikxIQ3Y+Bm7wzS?=
 =?us-ascii?Q?KGxPbuKYvyRivQ4E3XJp2jbLgihyiknfOpVaXOsehbIgUud2w/W0Wp5pRo4b?=
 =?us-ascii?Q?haVDx5NmNMd0bxA4OA4+Nvjv9/XAH9P5IevmmDH2bJYaoDbawZc5tkMwmzmx?=
 =?us-ascii?Q?/IQfLyXweavm0dghGp7aQQIbAzBMIEub+4quFsH3d9T0Nak9dgpyrJRK220D?=
 =?us-ascii?Q?lMzTX8yTHJVygS6BrZfdTueMEt8x2ipVoNk8W3dqNIzwVnLFxSmfYvs2v/nr?=
 =?us-ascii?Q?qTmotsqlqwna/bVg6VFWh6aee4xuLWirIvfdFpZbbNvDClCKoJalmlIvIZjE?=
 =?us-ascii?Q?yCdBylnceRR/NtiVl4ttHxedZfeQAcl9CNk3YAcJntdtsja5eWywy5U2cLDK?=
 =?us-ascii?Q?VaOgs7yTh/HG+XUQnEFv6qbmAgu15kPCIEy+yN88?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 588849ed-116b-4105-53da-08dbfbd54147
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 12:15:54.6007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SnmPQCKyoU2yeM/uL30Q9vfS3xSmJ1BzenrP9MT22b0n4O5/0bfWSYRsfyGKdPNxkou2WM3LKUJPKhNVl8dqqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6785

In case a DPAA2 switch interface joins a bridge, the FDB used on the
port will be changed to the one associated with the bridge. What this
means exactly is that any VLAN installed on the port will need to be
removed and then installed back so that it points to the new FDB.

Once this is done, the previous FDB will become unused (no VLAN to
point to it). Even though no traffic will reach this FDB, it's best to
just cleanup the state of the FDB by zeroing its egress flood domain.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
- add a bit more info in the commit message

 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index dd878e87eef1..7ff678c759e4 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2007,6 +2007,7 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 					 struct netlink_ext_ack *extack)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct dpaa2_switch_fdb *old_fdb = port_priv->fdb;
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
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
2.34.1


