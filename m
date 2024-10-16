Return-Path: <netdev+bounces-136015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A8199FF51
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 05:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26CF3B25610
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B34F18B49F;
	Wed, 16 Oct 2024 03:19:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2131.outbound.protection.partner.outlook.cn [139.219.146.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE5D18A937;
	Wed, 16 Oct 2024 03:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729048747; cv=fail; b=hvoC6hBNk7JV6EDKMp4Z8yaBrFN9VjG9jxT/n1mNzijxXDAy4kZvq5ez6lOf8IkWZhZBAuod43qRU+f9baohuBme1Fx11X1IqgX2KGhbKNb/gZrW+G+Cf9AsQOvTLHvAIAtt8DP85a9BVPbDI9rbBiNn8lSox7h8BbEvnF8tve4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729048747; c=relaxed/simple;
	bh=sobNCl3ooaqbIlw9wt+4q+9FdFry1wzPHjzFTUUDqjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bnr+IMI6sN/EqqZuzNXIk4F4JuBCcQVSJSRfqqm9G/VAPc83gDeS4dLF4pgETCgBb1KS1rB1XrVgLe5BHOyy34pKjGLlHrTv8UgJkB6266QA9wdPR6dLKT6VKD845mMZcRO6DCwGzXDpbshFLP3M0qRwWZ99R3fAS6yEZbwCGLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5QQ+lJoTpn2mdGdtgip00DxDA7PahkvepOFiOFfdvq7ZnWjtoAqBKAZVycTV2JSldlJescST7D1DVsgRR5aYg8cHCEYteny2bAreCk7jxnFowRdrkdvh6LAORpWnq1jW0N/hKLtRvqibJu9gQob7mrdUW16BHEIZxyxko8pSU5n2JWMWKGat7YN1oKE1FvO60uQ1Osd/0wve/X8yDe+m6et58F8i3OL0XDW5SwZKsSg1xOdaGbxM5FuCVdGQm9L4Ki7AAv5souuLe3awrD3XjMEFbo6Ad/9eX/Y2yUnXp33MmLkYnNwzbAPlsTBVptF+4yBnNazD4nMfAGfyrhIhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDeunpIW/MhESRiJ+4Hk9C9fg8saeCUltfwpDOzTJwo=;
 b=YkypoE08qEugloT0inGqyOnQEs0SCl55keNA6OQkDS99pEbwU6GSSughrriXQO2bPq47QC4NSRTRA6QQyG/K9W1D1kgCTdNAuoI293aGErnVu+ncVj5CUbueeRtG82LyGB4FjrklEIagZqHsU5toJZqiphSQxafZfy2YChu8i6GpUBHgNzxsxyh/2h52jfyTIvF5pQ53XwFU3V/5SBXoVvDUox8mhAsknEn0t5/8KR3Nw0+LswWn5uO5NYK3+nSX50z3iMGI3atpDVPaTv2SS1q+MA2Re/tTB2HeBQggFmXTdq7Zx01cA4/2v8H9Z+BmZ3ptXOep1u4ANpqwTvDTaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12) by ZQZPR01MB1060.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Wed, 16 Oct
 2024 03:18:59 +0000
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 ([fe80::617c:34a2:c5bf:8095]) by
 ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn ([fe80::617c:34a2:c5bf:8095%4])
 with mapi id 15.20.8048.013; Wed, 16 Oct 2024 03:18:59 +0000
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
Subject: [PATCH net v2 4/4] net: stmmac: dwmac4: Fix high address display by updating reg_space[] from register values
Date: Wed, 16 Oct 2024 11:18:32 +0800
Message-ID: <20241016031832.3701260-5-leyfoon.tan@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: bb053883-ddf8-4359-8250-08dced9146f7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|41320700013|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	OUhUEbx/WaX03ORiiwxOHJtSRxy60oiKGX4iidb59dNZ5rJlVDyrUeX4fWBUOpST9t7wHdScBbr8E2JpRcT91eVaBtXgnhjcEZO1gaQa+iodJIKDq4tE2oANhx2uzOTlZ5Ufjqrxykn1enZhg5WwZePZ3rvebGrrWSlOtGh3qdidzco2k/hBebjCT/APfk4RY3t1e3i+mntYiUx6eX07T5hbUVCLMi6OiiWUERiD2p8xNAHqXga7NZaVt2//Lzbsv/1piUksSmu4XzVYYjhiRGTzeWUEn7GUqH73DdgEwdsw0evjzq6YVyEQ34T6sNPr4UbYRvtaL1hI+u79ZNeFKjr9N9DeGUjSPuuC+s3MP9Xa/7b+MYVzmY5++TsChTaMRtaSVS0u9m2KAl1F+vWoWdLoSBxCB0NMSrtnfXsW1SE9nWYU92t4xZ3rQFFbNYVt8bVKFSRdLVY0PT4ZnGEnFwwSk9Dn9WZdQTJNJ+3esNqUJT0MJR+Gkt/FQTx526T2n3UkUzfcdw2GS48hI9vrRn66nAOQdxrqzjkGL8FjRsGxToCvA9h8l78tVUXGCH+fNsFe2mt72fc32LjIxQbXu7PPeGhtFhRsbIiZCefX7ZysBVaA/fF4aSNyzo91k5RN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lAAqmJ5NDLG0ADkTMfASY8OyCfg31OaHbp8rTV0ZihYI49kznW+a5tlGbBLg?=
 =?us-ascii?Q?bq5xaJzB8JFIn3VRuKRowl6G7hS2QT4X3iijf0EqOCdQ/y/R3alTPAkg3JDf?=
 =?us-ascii?Q?mgKit3M0sjiErWqmVLmIp+wIw8vmwzeFDhJ3egZ1cIF8y4m5UI2q6LHWjpHz?=
 =?us-ascii?Q?Y9UwUqN/PmAn1voXBOQllQjPJL0hOUnkO017EnpJp9Srt1YBXhraeQWwtqXM?=
 =?us-ascii?Q?vTL5N45HwXZ2A+kfZgOjpNCXvX88sk8wB/rNn7TDJRzZmVswCKQmoBL+tjxB?=
 =?us-ascii?Q?+4CNfejKAdV/VpE9FaKR+XMk6zIGTWRdTioBu2fSaE3nM0I51DrhY7WIKnuF?=
 =?us-ascii?Q?c1dh1Al37SgbcAlOn7sJhS5tIjUhHFo2MyH9VVgJCDihsO+6MgGUxo10v6i7?=
 =?us-ascii?Q?c+SvLoKhWZL83Qv1snRtG+PbJi+nBlO6aW33UqV9Lbv2EZ4Xu9m9FPJBEarf?=
 =?us-ascii?Q?Aokd1pYbh13V1K0LsyEYE9jx04FRmb1/rmO2lLXAhIgfx183lHE+sELFJmvq?=
 =?us-ascii?Q?O7cLXk+429OcX8w8x4GmI16CgotUj4xHtDtsRFKZNWBAdM+HuIatKbsl1k7+?=
 =?us-ascii?Q?cACY2Jby1pW2FC8ti+1fjjNSyBoq3S6Nnigg8vdtCiVjB1L3K+UWhHVFIbFy?=
 =?us-ascii?Q?YssMSba0oz1OyZjwhGiJRi6ed0A0axklnM9f42iQ5uxaRd1EkEh/tr+gpU4g?=
 =?us-ascii?Q?E+f1s59J6WkU1uDxyOmbfpBSwcyrOYXwkBSblZCKSDfLuyNaicDPz87LLgYW?=
 =?us-ascii?Q?/MlcBS/PKWYKX6vqcI0R5MtIGHMTVXaQN5/B2siBJrOR26aIWBZT9uSPRxYT?=
 =?us-ascii?Q?PLl8wbkzwKyQGfdITrSb+LPNtabJ7p3qhd3YWxFS02ESBLHl//VHH/MVyIfq?=
 =?us-ascii?Q?S+ldArHOK9U8+NI9nNwCkpTAd/iVAhMbrYD12uFAfiDI6pB76WYjID0Uku0O?=
 =?us-ascii?Q?rzfD5UyVoxOhy9h54m2ymtKXTSwHgWr0lo866kjswe+kHfLinD4PmkB1+CWz?=
 =?us-ascii?Q?+P+6w6tSkwacqa/oB/oPdRDrnxwq0cMvc7XnArfMim5eHEPHs0M7xFO4V9Wu?=
 =?us-ascii?Q?gv8sxOGtpkU6XQrqTEQvFssJfBXgu1eHccKvUZjvaAYNwZDxTAUXIwyWidq0?=
 =?us-ascii?Q?uqja4kxOBWqDRlSXnqBpoUEsy2l2RkvB/S/UYozyL6X8Me9Ozg80bLL6Cq1V?=
 =?us-ascii?Q?uT4SEbjq8YtdMxA+d/5R+OUjfrAVgwN9vHV9SJtCdIP1PDtxcWwPKaO7tDc2?=
 =?us-ascii?Q?9Geg8A6xOKq39b6czE3PgEPMqiekohQJAWPJdgfWvyI24zMoCLVeF0PzlM9e?=
 =?us-ascii?Q?VW8oXCR564jdc304TJO2uyvSRWbXL4R+fAJy/iu44Gi5sQoFbXl9xl8uYiFd?=
 =?us-ascii?Q?9c9xDFGPu4dC6SSCVMDVwklJjqM4oagbwJLhPcBYXb/4kYGQ3gy00IVvJHrm?=
 =?us-ascii?Q?pEZiIwJ8RPFlvmJgE1nf123oxrlF34NE7ot8vpgfV6NaJpmyFq0lwtbhaT2R?=
 =?us-ascii?Q?IJU2vP0hQH1ZlvKTWGWCFnRGgr4M2jhgh2ngDzzmKc3e02AFV/duscc6XF3D?=
 =?us-ascii?Q?fxNRhnZkZEkcH9a+TpRwa5xFTMbNeHJ6nD69s5Gr43weBveqonFwrR50bzC4?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb053883-ddf8-4359-8250-08dced9146f7
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 03:18:59.8414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xZ+rAfUh3qWc94mFFDOsmM12FgmvhN1D+obQRNSAI41GVySdAaJzJIsk4cs/q8RQ61R3XlTa8PrwrQKzij0+UOtlUy2Jrif8KVSi5DPuts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB1060

The high address will display as 0 if the driver does not set the
reg_space[]. To fix this, read the high address registers and
update the reg_space[] accordingly.

Fixes: fbf68229ffe7 ("net: stmmac: unify registers dumps methods")
Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c | 8 ++++++++
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
index 4e1b1bd98f68..60cee7a06ba2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
@@ -203,8 +203,12 @@ static void _dwmac4_dump_dma_regs(struct stmmac_priv *priv,
 		readl(ioaddr + DMA_CHAN_TX_CONTROL(dwmac4_addrs, channel));
 	reg_space[DMA_CHAN_RX_CONTROL(default_addrs, channel) / 4] =
 		readl(ioaddr + DMA_CHAN_RX_CONTROL(dwmac4_addrs, channel));
+	reg_space[DMA_CHAN_TX_BASE_ADDR_HI(default_addrs, channel) / 4] =
+		readl(ioaddr + DMA_CHAN_TX_BASE_ADDR_HI(dwmac4_addrs, channel));
 	reg_space[DMA_CHAN_TX_BASE_ADDR(default_addrs, channel) / 4] =
 		readl(ioaddr + DMA_CHAN_TX_BASE_ADDR(dwmac4_addrs, channel));
+	reg_space[DMA_CHAN_RX_BASE_ADDR_HI(default_addrs, channel) / 4] =
+		readl(ioaddr + DMA_CHAN_RX_BASE_ADDR_HI(dwmac4_addrs, channel));
 	reg_space[DMA_CHAN_RX_BASE_ADDR(default_addrs, channel) / 4] =
 		readl(ioaddr + DMA_CHAN_RX_BASE_ADDR(dwmac4_addrs, channel));
 	reg_space[DMA_CHAN_TX_END_ADDR(default_addrs, channel) / 4] =
@@ -225,8 +229,12 @@ static void _dwmac4_dump_dma_regs(struct stmmac_priv *priv,
 		readl(ioaddr + DMA_CHAN_CUR_TX_DESC(dwmac4_addrs, channel));
 	reg_space[DMA_CHAN_CUR_RX_DESC(default_addrs, channel) / 4] =
 		readl(ioaddr + DMA_CHAN_CUR_RX_DESC(dwmac4_addrs, channel));
+	reg_space[DMA_CHAN_CUR_TX_BUF_ADDR_HI(default_addrs, channel) / 4] =
+		readl(ioaddr + DMA_CHAN_CUR_TX_BUF_ADDR_HI(dwmac4_addrs, channel));
 	reg_space[DMA_CHAN_CUR_TX_BUF_ADDR(default_addrs, channel) / 4] =
 		readl(ioaddr + DMA_CHAN_CUR_TX_BUF_ADDR(dwmac4_addrs, channel));
+	reg_space[DMA_CHAN_CUR_RX_BUF_ADDR_HI(default_addrs, channel) / 4] =
+		readl(ioaddr + DMA_CHAN_CUR_RX_BUF_ADDR_HI(dwmac4_addrs, channel));
 	reg_space[DMA_CHAN_CUR_RX_BUF_ADDR(default_addrs, channel) / 4] =
 		readl(ioaddr + DMA_CHAN_CUR_RX_BUF_ADDR(dwmac4_addrs, channel));
 	reg_space[DMA_CHAN_STATUS(default_addrs, channel) / 4] =
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
index 17d9120db5fe..4f980dcd3958 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
@@ -127,7 +127,9 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
 #define DMA_CHAN_SLOT_CTRL_STATUS(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x3c)
 #define DMA_CHAN_CUR_TX_DESC(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x44)
 #define DMA_CHAN_CUR_RX_DESC(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x4c)
+#define DMA_CHAN_CUR_TX_BUF_ADDR_HI(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x50)
 #define DMA_CHAN_CUR_TX_BUF_ADDR(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x54)
+#define DMA_CHAN_CUR_RX_BUF_ADDR_HI(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x58)
 #define DMA_CHAN_CUR_RX_BUF_ADDR(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x5c)
 #define DMA_CHAN_STATUS(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x60)
 
-- 
2.34.1


