Return-Path: <netdev+bounces-136014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD7A99FF4F
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 05:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D90285EDD
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A52189F2F;
	Wed, 16 Oct 2024 03:19:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2131.outbound.protection.partner.outlook.cn [139.219.146.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7720618A6AA;
	Wed, 16 Oct 2024 03:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729048745; cv=fail; b=CaV39Ckk6gulpDYOVM9y1aXd98Ho9fbgg3v8SK9DK3TebqkGN4nHKQV3dSM0hw3/MZdo8l75eQ/pgir2B0cjiY2JyYGGeeVNMTzYanmvcR8bEjh1+g6M/OSwDfO2rshPDADlCVN1FyOjaVTbz7RE/IkwfF6Vu3uhSsuvDUnZ3gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729048745; c=relaxed/simple;
	bh=R+EeBlj86pRNtPtgXv896mqaSsSseyfHwsT8jQ5djoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PyE0CAeLPAKiNZvvziSuEjFNciXm6pt5lLWABmeR+b4eoBX1BX9R3P9DtqOneYUj4Cl+7Mpy32ADwsxGzOoFoh87xrSIZ5lLmz7raaNRFqG7SWNHsX2E0Ic48AcDAgozeFhzJGTxTET8qyPL3mGNvHOjihjze3fxXFwwOO45mFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbyjTeA07B1TMFziCaQcJkhKK31rX+VxlcArzux8ocF3oVPwG9VSW6JPrnM1oZt/1vyt/PCBTqM3ZK0gLX1rY8UaDBmWecVVy65umdXjfSamRFj8uFBL4szF38N2Ogm6/82gZ50Ydu0+PxQfR4IaHVhjEcftd0FBcd8Qu+nigbHngXTUfgTEnhyprHS5NI0hB//f++Y12LALmRq3nkG43Rzw81UyNCjzDeV5qn+vZlJuOGuwbCrVX0lefzIWT8OezzLmdlogtmqDT8SvMNuoVI9ELgmM2icj9/8qfVMJCZ5P6m8tzCKXOixSTMemt2JBz0h+/UfuagalXjhIqrml4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sNVfhZi9kq6WRMkg6s9bACOW5z61wVpEKgboggd3Zs=;
 b=JdqgtoHYGz42Xqsjkwcmms6IGeXU0qPjlN+vVqLXLNAOVQnWLOr0nfNYf7eTujhcBCVvZQ58nxmj27Fo3Jhdylry7COSmkxwllyh3NCmq+tZHBZiv64FdBqzKOdGKR0kQ9GZHYlzVztXA/2U25JqHY9n3EM7CxcgSI4WdOHI3uSO7uOt/V0dvZtfzxbdmDytoxQTO7qjIvt3x4Vh5vAM7O1npQ0MspXAulRMy5LwsabBOJ0kk/LJ4UVhfSvX4ZFouFc5lWpeM9QBpoOqaYlhyPnOk5stDcgDjyhhvd/fQmUXjb7KfVEMrTKlo+TnNjybWYNIzOpIXRgzWlflvtmOZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12) by ZQZPR01MB1060.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Wed, 16 Oct
 2024 03:18:58 +0000
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 ([fe80::617c:34a2:c5bf:8095]) by
 ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn ([fe80::617c:34a2:c5bf:8095%4])
 with mapi id 15.20.8048.013; Wed, 16 Oct 2024 03:18:58 +0000
From: Ley Foon Tan <leyfoon.tan@starfivetech.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lftan.linux@gmai.com
Subject: [PATCH net v2 3/4] net: stmmac: dwmac4: Receive Watchdog Timeout is not in abnormal interrupt summary
Date: Wed, 16 Oct 2024 11:18:31 +0800
Message-ID: <20241016031832.3701260-4-leyfoon.tan@starfivetech.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241016031832.3701260-1-leyfoon.tan@starfivetech.com>
References: <20241016031832.3701260-1-leyfoon.tan@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0053.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::20) To ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQZPR01MB0979:EE_|ZQZPR01MB1060:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d769a77-4f75-4d71-7c49-08dced9145f6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|41320700013|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	Vd150yzDPrWggLTrlSnR33krlsU8WH8qpS0gHtlWO4LdWVcSfo5EaKAKUH4h/T1VJOKBPvHSu2VnGskw9wRWs6ylGwOwATIZnraNvt4eiI/A0OlyNIGs66ovFCagl2NyIOiwm4bSoKHxOaZ1a46Ql+LGaxUl1Y5Xj893IUprPrpwLQ9MRgjquH2YsBwGFKpO98sY1PlhftIbOFSBUzFvw+zrZpi3Ietyx9ue+esrV/vTsLm2iRGeXsGSmYwYZLx9D9J8OSfOYrRKHtoEmgX7+iq5V0e38pAxnmfIn9O/ghMg240h16Aa/iDEbLEVeNuDuiuXDuOXgd0z5uHkyrUoZ8YZncP8SoWV3lfQD5Ase3jZSgH8y1Y/b1ygVtaa/yWB41xu4IN2wzEkdYnPhzFEZDQLvkCVqGpgc28DW9n03RSFr8PQqK0oxU+fmXHWFhSPErC1ef3KyC222GRVJAY18CGj5HtvNwXAAnGsNfVfhf+b1bQ5pl9bhF/eN7SdRazptH5E+7Xn7g+BXV7b2vmSVuv/h0ZGQJyIXRzLn/lMkpzC0Nu4Im60hB7rc0GMmtxBpbisosoZSgdb4jU/rW8pFNWdOQmIubNU9ZCVLrpA/7Sl87m3lBJz1QSsONpsVbeC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OuFa03FAiVv73DNllqXLdw/4y15lcNNXf8iXpNLQ603OsuYpM/7tA0NoMqkr?=
 =?us-ascii?Q?4xv4DFErA80SDwXbWOnjltGbrj+K9pCHTKlfLngh/mZIBfNKTVTwFWe+Eeo9?=
 =?us-ascii?Q?ZvBIQ3VRohKzOpdObJ7IudkuUcgekvvV/bR9+gyRwAoilc2EcJaTlUsBy96Q?=
 =?us-ascii?Q?T1SgNdN/f7kB8ysYMyr4IdH0EuWMRH0ADxVzQ65mb5wP3s/UBdECqsZoJQO4?=
 =?us-ascii?Q?k19J2K4U6avjwGG2DXvrzqaC/0GyA2tvz4c+8XG/ksCg8YPCvCxAqF6TSk+V?=
 =?us-ascii?Q?jmmBtQHehWhada6PPqFolweXOIrXBe9VE42fqGff47ERtx01trBGfX/OBMFU?=
 =?us-ascii?Q?EwGa2nQFn4JycAuwPQ3MqhKvziv8aNyAb6PDxuA7wvCDc+ceHiseCjOHOF4C?=
 =?us-ascii?Q?45j3neQ/ean2FllmspK1rWqGYcErQeunbviHDPWakyrlaNe3GNU6PIr+hY7P?=
 =?us-ascii?Q?00tVKzQsFhFyParqsovAm+iCYPdx7fo6+J60eWvK7qb/klfRoTHMmW+/KJ6+?=
 =?us-ascii?Q?rs0f70/w5+LKvglRE2VigCfWaAu5E1qdvabIyXMJLtpWTMLSpnh8Am1LfgWH?=
 =?us-ascii?Q?XrkwvxsCNxiOQTWijtGIVaKPn64tQ3htqXTkmsVGi9AcRCiAO6KPAEI5V0ZR?=
 =?us-ascii?Q?2qqEMKbUzAbM9lMoSC/yyDYDEq2+gj+rQChtAQzNWc0kZtRVWZ9Ld7LjEzDC?=
 =?us-ascii?Q?eTSGOcN2GuAmBjwZ2x4yIoctChAhLwmD/6G8ZhDKhC3ml0uh13sL42agtPuk?=
 =?us-ascii?Q?ksuFM9tugB2K8LgWDaKUXs5oWT47OevDOjSMcEwRSPIYWXWUwC7xTJ+tF2fP?=
 =?us-ascii?Q?gAA2OulFsd4eeRzh8tAS5VUS4n0S/dUJTRLOOO8n+ndNgu5w3kgu+ocGdmNc?=
 =?us-ascii?Q?hqeSFvrM8ccVLYELDqGe/T9hVjz+Hm3Qkyg6Q1ylTLnYX9qS7aeiibdJTn+X?=
 =?us-ascii?Q?joIqsUYOdMnxwUpqqVLpYhygj5Tes5g3EGUvhRmMx/QYt5hU+u5aLsynzqMm?=
 =?us-ascii?Q?BT+2XsVnTAg0o4CcgnhHhm9rQR9JKMo6es1DrLr1csNCR8gXg2BJIA/vkXHh?=
 =?us-ascii?Q?SZd4nKjp0UstsR3wg4Nqi1Z/ElKAv9NH5M1GJlVDws+7I36N2KlPCXHrPPKv?=
 =?us-ascii?Q?Yt80qN5pXIN0Ad+3M44A25Potfdz9nBY+so5DNult+UQ8unW7cDYX3G2ojCq?=
 =?us-ascii?Q?WHK7pqs5j4PsdqnIu96BQWr8KhzZz/rZq7fdDiTM+kXI2mpqNjAK65ls80Ad?=
 =?us-ascii?Q?fg7Fee1vYwspsaOJObUhp427MMJQVZC0QQOnoMSCv3fODfOeAm9yAh+wFWSz?=
 =?us-ascii?Q?GzFUqw0aH5MzfoGNPcG+A0+0T7rgwjdzl+01JW8LkzS7+ph60nUqIm9v0Sg0?=
 =?us-ascii?Q?+emA5AzxJYL21xi0YP9hYxda2aKLJud1PKxvwoO+gnUJUWK1VhZ3nGsfojVC?=
 =?us-ascii?Q?aNf9ClgDO5siwk+haaL84rJadQK0f16qgQ/eUSdgXnm48cQmt6+c8M6Dc1ww?=
 =?us-ascii?Q?ihKc4M/vXNUSp1p5sVaBzPcukK8j95IWowYBDTwncV/Lj+o6EscxF+S+U72C?=
 =?us-ascii?Q?TWAjPRVq6QLTpRl9netQwkUrQi5cO3gvUkR/24KEiPbnNZD4jHWX2VBNigJ5?=
 =?us-ascii?Q?yA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d769a77-4f75-4d71-7c49-08dced9145f6
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 03:18:58.1444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Muw6QpaRV5Hlpr5fYj0f/1GrpJtNh/aiAf/PZK3WzoIUjcwLj/pYWfTfb4xS8ZQ5W9bOqg3rGskXb0KYreJzrAoKgiSKS6woM/lxYPkXhHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB1060

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

Fixes: 48863ce5940f ("stmmac: add DMA support for GMAC 4.xx")
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


