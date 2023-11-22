Return-Path: <netdev+bounces-50150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3E87F4BA2
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10163281319
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E7F4E1AF;
	Wed, 22 Nov 2023 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KUwobB1j"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B8F10DF
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 07:51:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xqj5TRsyDa4zDMDFtqePVBW+EQ2VC4Ayob0+8W0OI64sumd06Ax2VMaqCQflnVwJd6Aap11IRDFeowS60ab9TS3rjWqbTvqkrLUJ2tnvXFQWssdgD01hxWn0iPhdw4sHgXLIaiNFNPCuLX9QKjvd8Vf6E6yJE/GCA+CQzUoEa5PMJvEsQFNFbeDPIYOXHdinqBEMoybgzkUwpzyP/3SqlLylNUNkLqtwDxBgmAauR1n85iK6cg6XVnJ+I0YqpIAGEoxIQihZn4loA77KJltJdZDZ70QRzsbcXp+d7T3ZH7104tQjFe3NrXHmc5iMerViEKVBo8nkwBcZ4pofT+QzZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRqPWcX9VHq06aidQ78wp1Ljb0zltvQw9sF+qvlIN4o=;
 b=LgOz6kPrU/UUwysolm9FnL0wiDBMBp6YF3QTRBEC5hhJzE8h1dh43NMEHXBCpMJRyPZaNpwWD9rTt3PwTUHthtPC79GFklij8LLsUyhTcNGqWrF12nsnY0CVLLQAr0IiahhHE8KEA3XNcQNUbrQmJyV0mKgS1IcRk/9QVWD9fITdqXQPoABFCtaJKNBfAnUjq9wuMl5cwbYq6nv1VFGYOV8VW9H/cqX/8ow8cKoEAuxaMiVI01nGl8UxnioVerb4yIz5w+QHTn9vLAsMn/RlMUO3AVrkblVe2yfq4+kdvvrHJ6tVjw5mDhDJ0xIOVtD6Qde/CiduTRW6MxTv8vlMMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRqPWcX9VHq06aidQ78wp1Ljb0zltvQw9sF+qvlIN4o=;
 b=KUwobB1jPVdCPy9iYOwEQgqRgInvhTrTsPrvIqDuqC4CzsBc7OqND6dlCuLQqDAA5Umo3V7mOtJFWqZpFVjfJ+8Tygvy21REC98gr1Va2+mElowM8EWhZoyyfXtCiRd5eBA9OECarbfZWYbbrAlqZh75iuntncWcz9dKjH1LdjE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AS8PR04MB7878.eurprd04.prod.outlook.com (2603:10a6:20b:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 15:51:30 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 15:51:29 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: andrew@lunn.ch,
	netdev@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH net 1/3] dpaa2-eth: increase the needed headroom to account for alignment
Date: Wed, 22 Nov 2023 17:51:15 +0200
Message-Id: <20231122155117.2816724-2-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122155117.2816724-1-ioana.ciornei@nxp.com>
References: <20231122155117.2816724-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0037.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::26) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AS8PR04MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: eff987da-e694-44e3-ee7c-08dbeb72e4a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sk5jM5rOs+LBJBI6aL6hjsAsQ9pcmkzYsXvixecVXGJmF7eDFH/TPRi+EqHtEbSYxDgEfWfMUoQU4+ysU58e0adgrKjeMi18e7RK92rK5cEaDIiNn7O4t/GMZZ3k6lb/4fNfQ4SMsu3olM7s7EhRvidhtybffWIweAUquoy6ZJi4O3HnsWDz+4ord7vHDs+xndTw6azEhA3LPs6TXvGswdpz04svyNLEoncUkPBgRXmxZNLG6veHl/1OThLMqAKIVdkvkbdzfEX2ycxnlUQOXWxMeTm+KTSsguCcgPnhzkvTn/TXykLwTyOMSeVhO1Ze6NWDsL6js8CKACOZF5g/O5F1Y0AQEP3Syj3sPxjsd+WxWlfy+m4cHzxX4kGjkbwtm5PQ3hYFdo4Q7BicQst2XIs8T/0gM3JB5SNw0XoAemJebARbUEiShwNin4kMy2qohcqrPVG2XeXDcRGEWHLl8E0HkVDaQDhAX8f7iYT0EK4CzvaK+zxHU5Hga4QhwhRkjbwwy/NdLPMXrLggotHcBTo48sfsedNz3By0cnAS7h4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(66556008)(66946007)(38100700002)(66476007)(36756003)(86362001)(6512007)(6506007)(83380400001)(26005)(6666004)(2616005)(15650500001)(6486002)(966005)(2906002)(316002)(478600001)(1076003)(8676002)(4326008)(5660300002)(41300700001)(8936002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Eo05MJVZaYnofwog4tsCcX3rXcox3hCsnMNxxdbhOXmdaD69nhiFutJf7JlV?=
 =?us-ascii?Q?lyY4rG8aa+WAWnT8g1WBuiy0IRHgi+XuWQ/jtF2JYjFxv/Vjjje2WC6spY8U?=
 =?us-ascii?Q?REm+TlMs/+C5FkaeqSrjKYn78ucVdQHnni4kwejBM+EIhSbcJp4v3J1FwVQO?=
 =?us-ascii?Q?z9M1CfGFFdKzM4SY6Aoz8STbMAQM37LQGj36+JXuGam0L2e77RDjfvD0QJ4H?=
 =?us-ascii?Q?qQu1VjKzzPxldQx8pab1rDgc/VXIs120E5mowgBXaSjnHSkttegZbn5SPYf/?=
 =?us-ascii?Q?9hEe+Z4HXQHFzXlW0XIWUPwISQ2M2gylxao5zzGg2bvXFDxuY8r/Wwqb5f6p?=
 =?us-ascii?Q?rLDqgwUGYFFeezxb6gDaK7kDSJLGeNsMdS95IObGf7Bjb0STmaUnqJ+aKVyf?=
 =?us-ascii?Q?EZOb7HkgJ1kfyXxOQhGiqtnBTP6qRyk+5gG4Yzds7aWzriLIxLC2XF148vcp?=
 =?us-ascii?Q?rmEri1rSYl0g0YI/XzX2dt8lOUi9BDIpv0pFvzvdi6oXGpCSnYHlB0yJOEtd?=
 =?us-ascii?Q?wbjqe4bprkwa0ANsYcF1MYZdgLYgq/XkkxxFw0AdHOBefn7kEpkjwa3wlyr6?=
 =?us-ascii?Q?Ki/HVuZjfALg1uGiIJ671ryKkZiYGtnoZCi6XXKyt9IRmTIu8WrT4cvR6ZvS?=
 =?us-ascii?Q?23WVg5HcfY+A0AsRIywMaoJHkcvmY7+ihK5gUvdAYpF87evwAlJZBFfT67Wk?=
 =?us-ascii?Q?XrTzkrjxBgHGMFIYtnQC2q7tYV+Osy/tTMXqRmLJUJAxsZsDWEC3jYlt4MBz?=
 =?us-ascii?Q?zJsopJIlIMQd2HH7IW7/u0sOMX9gMQUc4QOc6TZL44spu/slzBsPnixl7v4w?=
 =?us-ascii?Q?+tT8CT0EYJYfdLYxRkmkMkWih9Mu8H7SMiw939yHlkg/8OqOfHy+XI5ohA0Y?=
 =?us-ascii?Q?sMOBHCM8RKdoIhG8GDP8LMJMeU9H+H+f40/wkKiUNiz9NkfB1t81t4C5qPjY?=
 =?us-ascii?Q?MbfPXRNgY+/03pYP3RQ5tPQmJQjoo2TSr8yMKoh4xc0tgFJRZgBGKunTRSJm?=
 =?us-ascii?Q?yAXRIKSWDTDBPGgNcdxl8wtvsViucxdHqOYlAKHxr41k/Ma4KD/vxv1iU5fo?=
 =?us-ascii?Q?6WAQlEZO7wSfYLO4xi4asEFouaDDVsaHjkbTcaRY2XomFTcgS7Wc/ZepHelo?=
 =?us-ascii?Q?guYIu4jagOKSOjs4U/YYrPAdjeSBdyS/Oi2VwaLFmB1fdONe9HO7J423j1H4?=
 =?us-ascii?Q?lW3itBfaLgrHUuz18TLAnPfEFsvRboe6rkCY9+j1k/ImJ0pLH/RwV1/larh6?=
 =?us-ascii?Q?u+9M0M0U628mX7fK58uutmSYJa2jSWrhJccsxQJk/Gz3jQ+O3Nk6fpHfpqck?=
 =?us-ascii?Q?46RvAdXam4cej7vY90+SQwla0r9+FSIXEBmoqI3rWucKupgggUP97ZeIZzih?=
 =?us-ascii?Q?07EjJFV5SuidsGAioFj6XpWyKG2kAlmBvVGaQ7cg2tfgCuko4GSlwj168LnY?=
 =?us-ascii?Q?uNK6cquiCNYjQPLfwrgq0+24hfD7GMjfArDKMezLI8bE0Lnv6yAI4Xy+DXRC?=
 =?us-ascii?Q?UUo2R5Yz2e2TpIDc48rSe9Q2DiBXS+H8uKbPBhgSdacff1BvnN9HAM6gLXPt?=
 =?us-ascii?Q?+DFA09Esc94OyoYYzrBszOHNxYLIDnl5qVMsrjbn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eff987da-e694-44e3-ee7c-08dbeb72e4a5
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 15:51:29.8967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SirC8wI2etzh+L1NeHSypmXFWxDEO8Od9zzISF9tJSYGKJP4hvRc+chSga/+IWDnXzwHYRZTJ4d8x0SbDKGClg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878

Increase the needed headroom to account for a 64 byte alignment
restriction which, with this patch, we make mandatory on the Tx path.
The case in which the amount of headroom needed is not available is
already handled by the driver which instead sends a S/G frame with the
first buffer only holding the SW and HW annotation areas.

Without this patch, we can empirically see data corruption happening
between Tx and Tx confirmation which sometimes leads to the SW
annotation area being overwritten.

Since this is an old IP where the hardware team cannot help to
understand the underlying behavior, we make the Tx alignment mandatory
for all frames to avoid the crash on Tx conf. Also, remove the comment
that suggested that this is just an optimization.

Fixes: 6e2387e8f19e ("staging: fsl-dpaa2/eth: Add Freescale DPAA2 Ethernet driver")
Closes: https://lore.kernel.org/netdev/aa784d0c-85eb-4e5d-968b-c8f74fa86be6@gin.de/
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 6 ++----
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 15bab41cee48..f2676fd50e1f 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -1073,14 +1073,12 @@ static int dpaa2_eth_build_single_fd(struct dpaa2_eth_priv *priv,
 	dma_addr_t addr;
 
 	buffer_start = skb->data - dpaa2_eth_needed_headroom(skb);
-
-	/* If there's enough room to align the FD address, do it.
-	 * It will help hardware optimize accesses.
-	 */
 	aligned_start = PTR_ALIGN(buffer_start - DPAA2_ETH_TX_BUF_ALIGN,
 				  DPAA2_ETH_TX_BUF_ALIGN);
 	if (aligned_start >= skb->head)
 		buffer_start = aligned_start;
+	else
+		return -ENOMEM;
 
 	/* Store a backpointer to the skb at the beginning of the buffer
 	 * (in the private data area) such that we can release it
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
index bfb6c96c3b2f..834cba8c3a41 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
@@ -740,7 +740,7 @@ static inline bool dpaa2_eth_rx_pause_enabled(u64 link_options)
 
 static inline unsigned int dpaa2_eth_needed_headroom(struct sk_buff *skb)
 {
-	unsigned int headroom = DPAA2_ETH_SWA_SIZE;
+	unsigned int headroom = DPAA2_ETH_SWA_SIZE + DPAA2_ETH_TX_BUF_ALIGN;
 
 	/* If we don't have an skb (e.g. XDP buffer), we only need space for
 	 * the software annotation area
-- 
2.25.1


