Return-Path: <netdev+bounces-50776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520F87F7164
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 11:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F2A281855
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 10:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2A51A58A;
	Fri, 24 Nov 2023 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F2THoBOt"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2082.outbound.protection.outlook.com [40.107.8.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10749110
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 02:28:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JU8EcIuEZV6XBvb911X3ZQMhptsF5GoC3GbC7Jz2O04JfvN/ySRop1h5rloB6Qxl/6EKuVXLhHW+tLk3YkAm31BdmoEL8U4ERzdDiK1DhDn33yM+ua1iTM9HjTO3oMlVzYFbWIAurEP0Z/HD30xT/qxJUZaXVwYuXJ6/fOhl1rniO5DhLpIpS48DQqiWM0/7EjRLt5oFX5vl1Frykm/mVb+Sg8eRvD6uW+KIu07WtiYPl+yFMnZsgdfp2Ey5e1HRsnOmHwW6hiqt4qWbifjMZ0/Oxl0PGgapfLSeiN92wQbwyp8VflimByNfKA4GxGq6mCLZAVcQMsE/YZsd0TLQyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGBu4/+oHXvt+fB86WX34Efdv01pKOoP+zc6X9539U4=;
 b=APqu2crtjdF4J72RtQHFOL2SdOcHKn0Lek6VStqclJraPU6lhr7g+9F3uMgY7963F9GWfnY/Q2DJPEMNUspNqmEgflrkJWj7MZJDHjMjoyepKukF7cDM5ORIDvzgSF9n8nP6OLFSAHO9XQKCjR4Uqe2kD8icC6hbeXwXCOAE0U2jaaoyKRg3gWmaadoYfF21wiAfHI4ajH5iGML5pXHoPn8DqhllxEfsTgVU/+HZNJn5RYhS/R7g1sV1dww8p17FPcs4uchBUxK163L+udYK+qfDSDwwWavauUzfMR19T4VVKxBLpJ8FZ++aJTR58hcO9tDaECtB3J6bL+Cj71WM1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGBu4/+oHXvt+fB86WX34Efdv01pKOoP+zc6X9539U4=;
 b=F2THoBOtCDkYv1gC8efStL8/IjZLBw4GbQElnZO+3d+wSxZ5O6Vs3RiLQwzyuJTOlzeYFblU3QadvpfcoxjfMUb6V1O4kfyKrcRt2YPqjgnaiRWsQu/IETMmBy2YQn87Eqi967wJO3jWU8HkNGx2SZiR2PPoJuDFx30Gl3PXPAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AS5PR04MB9856.eurprd04.prod.outlook.com (2603:10a6:20b:678::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.12; Fri, 24 Nov
 2023 10:28:15 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7046.012; Fri, 24 Nov 2023
 10:28:15 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: andrew@lunn.ch,
	netdev@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v2 net 1/2] dpaa2-eth: increase the needed headroom to account for alignment
Date: Fri, 24 Nov 2023 12:28:04 +0200
Message-Id: <20231124102805.587303-2-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231124102805.587303-1-ioana.ciornei@nxp.com>
References: <20231124102805.587303-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::8) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AS5PR04MB9856:EE_
X-MS-Office365-Filtering-Correlation-Id: bccb48b6-1168-4fe3-c0cd-08dbecd8113d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NbfFZP6jG2evGBe5J3I0ed1gfnCjcgxZSyM1vc/4yk8eR0y25lXB+ExOPMAQEaMFwefJW1Hw4C12ddmmmxYK2kTVfxuDlAGnUkK9UBJgPVSjGVJW0EHEVPvaXsPAqNqlALMcOyObOR0uoZYCoTBYVt7UX7l8kbDFNjLh7EyOMbN+z+Iz+l71aHsu7dJZOuDIRGr+zOho4b62Il+ripRntIYWAj78jK7K7ltv4WDzjYehZXYoXaTGfyZ3Sdct8jvBwYHYoFp4ULKLf6mZAfRYNrlZ5EA5x/Vxg1H198P2QcePHrOGTvyUrO8szq2GnM3znDkmfVV/jTOym4lVgjhaPKDUHQ5oJHKHkqbvOC/u0SBZ5+0OBk/ICLXVljHan7Zfu9ZEnUer25Zmv0h17884YOw2hvYN4rBBi66Fip/WTOAHHvuzaQzGn2ys7MMH8jBvu/7IszJVW2CzTFtV1ejfhEZQJMXOcASA0KrCT2gwUizmzb1KbccaHVIQSwZFjWd0jOsuP0w7SG4BewS8Rx9v86ALkaCg+fSVbvtRQDo40Fg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66556008)(316002)(5660300002)(66476007)(8676002)(15650500001)(44832011)(8936002)(4326008)(2616005)(966005)(1076003)(26005)(2906002)(478600001)(6486002)(6666004)(6506007)(83380400001)(66946007)(41300700001)(6512007)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?teHJJlbJ9r2EUGGMk6jsiN3RoQ7C3NSt4E1iB9AHpIiUjaIJky4Hrr4QC945?=
 =?us-ascii?Q?qAahfWsBLdqNN9DeBRXEOwikcrng6RcncYlSE3UC1iW1t78Ro3jnilv9/eLA?=
 =?us-ascii?Q?17m8yVDz+OGu92/kJvmJSHuCQ3G4yuQkDX9VDGfMrf87lPtq14KQw2Lb34tM?=
 =?us-ascii?Q?k2Pk+gsH3bidIh+OQq7ZljJ2VWQrbxSj3HuVO7Z4oTtRdUC3L62NJy0evZvy?=
 =?us-ascii?Q?+5eyJriCyOlWJlz3WtK8Pun7a1xLW2ce+du3G3HN7nDGBF/+OuR1jSoR9XfD?=
 =?us-ascii?Q?BYJrmxZb+voGc10eIHejBx4aNUTtBsvGlCtsiGF/nKB9tzpKHElLTq/zQ63d?=
 =?us-ascii?Q?0bs7Um5iL4QR6A7vTqMMfojTwxtXL4Og/bKXoctxLTBmXjtPV09F7mnTgrKw?=
 =?us-ascii?Q?ZLPheDUFTZqdEVJNkdI0zo8+wYXkWrW1KYJ+MTvhuKX0iHDk8jabNZ+2XNXY?=
 =?us-ascii?Q?Tx3dYwwk/lwkTKhMr+3BBKs8I5GVH1nmdW86NQ/UU03j7CLrGN6wPhIMqMUQ?=
 =?us-ascii?Q?7bzgE/XGdIiWZLkIaqaKcK+GcGHJNKwfZIFMbAJGrov0w694XEjh5VcH5gpp?=
 =?us-ascii?Q?qD3BDB12d1wCLoLu3xqtgn0r40DAQ6M8qdHEWOKVGsnK/dC+Tz8hhJV/Xx2q?=
 =?us-ascii?Q?lt6+U8w4Mc0027jpPsM33+GWb08pvRRrnXgS3Db/XVLeR7jv29J4CrEI/Jzw?=
 =?us-ascii?Q?NGHzx9pTvoPhIvOOG9XlZSfgf/auhsJig/+VBco8gzQxl9oWixP6QAlGWRyE?=
 =?us-ascii?Q?looYjHutiwGKEnzP3ZeOP3CZS+q6O17rH5h6517XOy5jlSFmwOByJV57QatX?=
 =?us-ascii?Q?Vt+8r1Npf+OvyE0HNvtLl++XCahlHm2qGiRv7sKVLDFyYgosKlElZf/7u+8A?=
 =?us-ascii?Q?QOPfxWGKiiPu1g+Px/PSwuRO8oNVPx7QT18QCY3Wp18tTGBWmIZdfq2yJHPA?=
 =?us-ascii?Q?xp7XtgzBRUDtBe8NGGBwwUNObxvmgQZPDqbhG/uEVNpIqnrzH2F8I9ske8se?=
 =?us-ascii?Q?K5Kx2b6wwo4pIiiu8psCcgM/+Hkw0NcMc8cmybGND6EYMBk6WeN5AeoieSeu?=
 =?us-ascii?Q?gauJVAxzWbjkCCnqmcf4BNl8xj7kvdO3B3ByZVvJjZlJtsekNDy6g+RivJPG?=
 =?us-ascii?Q?RtT71IVGonwKW369By04J/KdQQyrB2GFLnbHm2M727KfgEwAES0yl76wlOTw?=
 =?us-ascii?Q?c0Hqj+cU7Z8zQ80VcxtX9N8VoPMj7dpn6msd6ly8/PUsQ9sAL/r2h84QyiyY?=
 =?us-ascii?Q?u0bPxkRBqnzrsglxeOUURTyAysDWH97gP2NKMpzO+kQIJgWKIAkgpH8O5Z5+?=
 =?us-ascii?Q?SkLpd+/69CcEugXPc2Pt4r+pVG2KqUH/tcLSzgYMq/IC1LxAUCT9OcnrgOcF?=
 =?us-ascii?Q?Q1Bp+Z8Oi3MFJ4YX81pXukzWPfDSGPf5uxnXnI7dXetY1lbJf/v+MVt5Pjo7?=
 =?us-ascii?Q?Cdd4Tx7SH6NUXthO62bkZhCLXll4u1YOGwp14LauIJudv/lL91jyZEFykvty?=
 =?us-ascii?Q?WbO4DGBM8xdt5Fp+1pABmwZJSaYVhI0foDJCcHgTD2UfVBdEzahlaD+4kGl4?=
 =?us-ascii?Q?jq3gC7Yxkj1hfzQrmOg9KOPKcw68HZa4KHoccwkZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bccb48b6-1168-4fe3-c0cd-08dbecd8113d
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 10:28:15.1179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wP92I9Z8JaG9NgcNzQWWH6eJI4i8iTMLmIDflDx/0nezTGbGMXSm/Eimz8gLMoUUjKQiUkoNxvf0WbgPKyuRqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9856

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

This patch also sets the needed_headroom net device field to the usual
value that the driver would need on the Tx path:
	- 64 bytes for the software annotation area
	- 64 bytes to account for a 64 byte aligned buffer address

Fixes: 6e2387e8f19e ("staging: fsl-dpaa2/eth: Add Freescale DPAA2 Ethernet driver")
Closes: https://lore.kernel.org/netdev/aa784d0c-85eb-4e5d-968b-c8f74fa86be6@gin.de/
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
- squashed patches #1 and #2

 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 8 ++++----
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 15bab41cee48..774377db0b4b 100644
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
@@ -4967,6 +4965,8 @@ static int dpaa2_eth_probe(struct fsl_mc_device *dpni_dev)
 	if (err)
 		goto err_dl_port_add;
 
+	net_dev->needed_headroom = DPAA2_ETH_SWA_SIZE + DPAA2_ETH_TX_BUF_ALIGN;
+
 	err = register_netdev(net_dev);
 	if (err < 0) {
 		dev_err(dev, "register_netdev() failed\n");
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


