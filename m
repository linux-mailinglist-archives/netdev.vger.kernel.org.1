Return-Path: <netdev+bounces-140991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8E39B8FDB
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 11:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79301B214EE
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 10:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52127170A3D;
	Fri,  1 Nov 2024 10:58:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2093.outbound.protection.partner.outlook.cn [139.219.17.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62437155324;
	Fri,  1 Nov 2024 10:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730458729; cv=fail; b=V5BKRLrpRItwDgCIpkBL5ChDQhhrXs29f32Q+yYa3dmfKWFmqQS/SWKr49qgKf70Sr+Hac2URWT7DEgf7WfsLEoHdtXzd14FwRNoLwL3GqtBBugY7Todfh85i9s+qulDMGBoyc+SWWqpkxg4DYT7PvvvXkYvlwf5O6paHX+RkQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730458729; c=relaxed/simple;
	bh=OM5WEevAgbRAKoz+cI1l9NaI0Va1L6Uet5N29LpnIZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DPRvmpYEfkBoWZV+48OgcJNvvQkORFcp3Q7Fl5ndSUlZq1lOm4Jds5knDZ4YqtK3laU1wUKhCn3OWcgr7D+ILUGKzflePA0syZNVIE17rNnSl5VbM33/cZrrbTjza/bjAoFl3hcRwucageVUWBpW7uxaxVoSaua/27EgKuY3b9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8StXhXjIedfA0YX0g+E6Y3VeVoopE/9+4cB1f4CuYTJehnEN6MAHrgea0I8zATgJsvuKIjxMAAiH7VJPVxsPeGlWvM1VFYI3pifLIRXh3F/nWFYaeyavBghkEXRoI4gVgVxtj48WOfguapuKagD27Nv7iLKTgENNTyf0YxrNytcOlmZYQAmRgzjAjWTDhBCY7YosojeSp458yk45Gc8vY4iC6JlFJRxcVmKviGdZ/AvSGeqAicC+4vlIoB24Zpr0RmfJqqhea4Qi/8oU60zCBGDQWSkNlim+vCJli48/sQCw1EumvcbUwnzYNosRroOrE4tIEAmRMXo3Dbnds2FMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J39ztJJPp5Nd4R5VpwzQyK2Ms6KeAXzG+PM4hDlqzSM=;
 b=KbX1N20QWUZi7wrK2CPrNV0p8Qhs6d/y+rIbaiR8/hH3ChGwTN34WDVPksngHm3x2Th8lUYeb07/Qwrm057y88YoxKtpc8Y7bWS2PPBNqllAhOcuCGMQLzWPsi9s/l5axsycbi0pmy0Fql4sjRdXSCdAx3t1xyLnJgEzDbdkvMJaB/RB/+Tdf4B9ArHRn86WEEZTZ/2o0BZ6mRWCNj5UqfTRlBaqYN6qVuYgMt6qVVOL4qYOImPhZ+esYwuJ9rviyfmaIso+4WY2oVs45ep/l/IIN2g19GrV/g10DVyF5QGwDN8jjuSFZ5iHuIOlfADvPOhDifDysEueLt2jcK73Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12) by ZQZPR01MB1107.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Fri, 1 Nov
 2024 08:24:08 +0000
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 ([fe80::617c:34a2:c5bf:8095]) by
 ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn ([fe80::617c:34a2:c5bf:8095%4])
 with mapi id 15.20.8069.016; Fri, 1 Nov 2024 08:24:08 +0000
From: Ley Foon Tan <leyfoon.tan@starfivetech.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lftan.linux@gmail.com,
	leyfoon.tan@starfivetech.com
Subject: [net-next v2 3/3] net: stmmac: dwmac4: Receive Watchdog Timeout is not in abnormal interrupt summary
Date: Fri,  1 Nov 2024 16:23:36 +0800
Message-ID: <20241101082336.1552084-4-leyfoon.tan@starfivetech.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241101082336.1552084-1-leyfoon.tan@starfivetech.com>
References: <20241101082336.1552084-1-leyfoon.tan@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0015.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::9) To ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQZPR01MB0979:EE_|ZQZPR01MB1107:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e61733a-76a1-4322-75b4-08dcfa4e8e5d
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|41320700013|38350700014;
X-Microsoft-Antispam-Message-Info:
	/Xh5VepZfBhi5lvrZ2i7QqXO9Gap7MtUfsl/jCoeT4xTp3RizaIJL5bln56zMBOGqppx/UEOufi3YuRXpixON9VvpjQEc00dpNCTfi8Qsxupd/7iTr+mFC+4ZXXV/RVG81gIIBzzeM+oubgzvNC1Fy8AQkxvMujQubFlTj0Z0EvBNHp4j9U4NqrMjHfz3gI2PIXaEGCO9SUpXLFMDJD1iuZhRgugr51k+PVJW4PVRuRyibPSsIqEvQ+JZfExqryYUUbOGojLj6QzZL74vgIATT78i0KPCFPWKXilfSPuAF7aeGbWveFmywbVsQ3DZePBAFjPJtVKZZtopdJXge7bpfAo5BqDuPAsV2Iaux7QBfoSh08J5F5kewH3Jfb9BsFa6OU8MqjN7uIksbbQhx4AIPN0YpS4qCJtziIsFWHq0S29Ha9qgkGk/tRDxLx4m6lZV04wKouj7sqJI371HGEmNPsd9hNjUEkFdG4U58lTYc+D6PXZk88svJK78dvD1TM9XY29aswyICpYpVHro08qpQjM9go1c099MLTRr6HhR9bPjGBBOJMrEkAhssy9nURJ/3FuI4Kz7owlZC+v2Ep7fSXnfg0u8s3Hr1OjlPkGFeWkLHST1pmED0jVNoZZcn+Q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(41320700013)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0lCT+H1hiyi50kWSAKXprcwYaU4Lnn79wnWppv8XURY4pA2rOsyacLrqEfu3?=
 =?us-ascii?Q?Jr02tkk9Zc3XgFK0ORpuAXkDiYu6DTeZeHocDvzMupsnkJyoR1yY2A68708i?=
 =?us-ascii?Q?6OJqXbOLb+hWWFi6FOs1jhh+z7Vgeiwr7tcvUBCx+u/CSe5kK5tIRFv8zypm?=
 =?us-ascii?Q?J/kuj7E1lAoWwfBhlFLn65iKU0Bmcgo5gr61BofRRmrUlO7p4ICPU6fyluVW?=
 =?us-ascii?Q?o0M98UmaO7IsNZg5WgG5wnfT1OQ6P7IvxlbbQrfqun1LsA6tY1owKiBZrd55?=
 =?us-ascii?Q?gcUXx0u0vHTRgUVmAct0II9o4P5HxmV0sbpKyj6NfWpmd0JxSqO/G8dF/Bzn?=
 =?us-ascii?Q?JStNCkF9EYorRhtFrC20e41H4TaxgT4H6tEmXHOJkQGesY9BcwzB0UCh/Ucs?=
 =?us-ascii?Q?OKI6fR1XtADkkxbXLGJZ3NMJMGy8LZuSVZEZFBBPNM50B7oGvqgqAyzI1FuY?=
 =?us-ascii?Q?9fjCvdGJqEA94JSEtEMvBHC0CkH9QRyqI4ddkpnKKYDs1PXe39ZRypccBc+E?=
 =?us-ascii?Q?Cv0sfeYbCToLQYKPHozF4t/kD2nHBWA0lBJ1Gb6b5wrOJQvJET29SIM5vd+W?=
 =?us-ascii?Q?B1gb4w4MKe7as/4yGDMz0Qni1lfXR2owGYVdlr9TVVxuBTqsoMoE674DJWfV?=
 =?us-ascii?Q?Mi/X7LHB1N8UcmMfIj98HS0u1glLLiqNVB6M7gDq4QH0poRbJSB1Ifu5Uocl?=
 =?us-ascii?Q?Wrjg5JWTd8LYVhCsF9B7/6QLlticJJjxnnf2c1pQoFjcRX1Z+yhWjfvRadRM?=
 =?us-ascii?Q?Wg/qVGKMuhabsxgavqk99TULtUBtRHSQUmoVfrehEXfonfHlHzZiV/OEtmor?=
 =?us-ascii?Q?WSW6re0VUWNw/2XgIQF4QuM1Kuu9vNHvBKkaDA+w+J26+1Lbi736QWTSksP2?=
 =?us-ascii?Q?fE26HxpKmPZb6YbEJtjrYUjDp6bqKo5ISdCFnqLsxWT/L8P9VLyAG8wfJC5a?=
 =?us-ascii?Q?mUvLM9ItKR1xEGX9e7nWk6fPZzsjO7R/Z7oo2QijhQXwUIpqPMGQ+MfrCyyG?=
 =?us-ascii?Q?OKxG2dBb3i0G9yLRRdOFmlKq1DGy4OptLGPAvKB7sFpTDHDTbX1poxKF+R69?=
 =?us-ascii?Q?74jlolcMTfdv8LExCRGGTdir+xuqIShKNddpA+FSco4PU25YYQlB+VulcO5d?=
 =?us-ascii?Q?8xvBtZjcS4DzFo77+kfKePTs6BSxy/J5tmnY9wXUN5tXIkY6cwkRVvCs4C7G?=
 =?us-ascii?Q?HxAX7XvE6IKMxF3IsNsoJm/FTxGTUhhvoYNdowjz9+jCruvQhFpBy7K4q57W?=
 =?us-ascii?Q?gylgr2Rkvo9leXuFh8uX9Efjh3zp9Wdd/1+VbkjhpwOlhKq937aCQPE2ddc+?=
 =?us-ascii?Q?qQvISQBwPgeznto09ymeCV2JTaEQSX8EJvaMVuAkVJm90CwBlBs5eykBUkFq?=
 =?us-ascii?Q?V6UU4zSyCDPJfmqdfECtELgASlJcw9ZEGRvhhUM78GPrV6N0QwdvuSIhCN6P?=
 =?us-ascii?Q?m43fDee/llwjzpvD9d0ODEAq7CUavq5VMZueGxuXiDOSXSey5q7S9PpSqVJ5?=
 =?us-ascii?Q?A9tb6uMI5Ja3v1IzAKm2/+Afr0u60nLfYQ/I7CF15WXM3xK92Ev666HRztzX?=
 =?us-ascii?Q?DcEFGiSy+rk3nxgJ2kiP7uiB4dzC9V4z8QqEDxHnKthNMNXLAdUw2E7+axLz?=
 =?us-ascii?Q?P4J0Ueo8eqxsjt5vaq33Z+k=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e61733a-76a1-4322-75b4-08dcfa4e8e5d
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 08:24:08.4598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fmjVpnnHtNK709rRLo/FCYxvzproSsPXhoTBCeCYSyuCeuGOq4ZhriJJ1eCnltShdMw/Mjl9iR78ZX6I2owZpVBvQYzL7R5xc77l0EVFSp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB1107

The Receive Watchdog Timeout (RWT, bit[9]) is not part of Abnormal
Interrupt Summary (AIS). Move the RWT handling out of the AIS
condition statement.

From databook, the AIS is the logical OR of the following interrupt bits:

- Bit 1: Transmit Process Stopped
- Bit 7: Receive Buffer Unavailable
- Bit 8: Receive Process Stopped
- Bit 10: Early Transmit Interrupt
- Bit 12: Fatal Bus Error
- Bit 13: Context Descriptor Error

Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
index 0d185e54eb7e..57c03d491774 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
@@ -185,8 +185,6 @@ int dwmac4_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 			x->rx_buf_unav_irq++;
 		if (unlikely(intr_status & DMA_CHAN_STATUS_RPS))
 			x->rx_process_stopped_irq++;
-		if (unlikely(intr_status & DMA_CHAN_STATUS_RWT))
-			x->rx_watchdog_irq++;
 		if (unlikely(intr_status & DMA_CHAN_STATUS_ETI))
 			x->tx_early_irq++;
 		if (unlikely(intr_status & DMA_CHAN_STATUS_TPS)) {
@@ -198,6 +196,10 @@ int dwmac4_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 			ret = tx_hard_error;
 		}
 	}
+
+	if (unlikely(intr_status & DMA_CHAN_STATUS_RWT))
+		x->rx_watchdog_irq++;
+
 	/* TX/RX NORMAL interrupts */
 	if (likely(intr_status & DMA_CHAN_STATUS_RI)) {
 		u64_stats_update_begin(&stats->syncp);
-- 
2.34.1


