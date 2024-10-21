Return-Path: <netdev+bounces-137371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 451849A5A18
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 08:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BADAF1F20EFA
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 06:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92D820309;
	Mon, 21 Oct 2024 06:02:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2123.outbound.protection.partner.outlook.cn [139.219.146.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8569EDF49;
	Mon, 21 Oct 2024 06:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729490552; cv=fail; b=vFfu7VSDrXxPiUyUBSwv8BtOR5WxJO35Z0CLgBvLMdtDZ6vCu43xSyaftmoOp/K3Eg7iljBid8a1IccCEHWWVHXMH45WL/5hFSvRIQUH+gD0bNJncx0lZ1rn+AIJtXTLyVQfpJb5eaX5TAz30UJhn1h/afp/MY3Gcy7SwEo1xGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729490552; c=relaxed/simple;
	bh=wgoiEgcO+qbznC3CaeAHqEAsbECjEHqD1UGQHABpUo0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UdMUiOXGspP5gzNl1HPQ6wwr/knQ1TQ9VRV2cN98E9Y7GMzVEPfPBpa2AlswSP7rsDVvVdijc5uZNvnW+iPXwWg2X8uzALFY0vCgThbFBTgYnf7Yjo1LsXKqAtGUYoAgJ3gPob+Qqcf4tFqZjqyHx61aEfNFdcKIVIMlMJxSGJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+48SacHmXmhkI4tQoyopOV/aZ2k1ofdyqPfcMyseNdERDhxDmR0JXTsz59XN/hVU93bwJlj8neGyb0evSUZCErGNam/1qEPQGuig/JWCH3cPPdr4vjx5M591384Dgce2jYcbCB1MJhBaA3f5uSS4Pq8cRR6R0LgsRUTcHUMdabthEempBmDPppO4B99M9ickQFX0fvRgU/kImeJB8iCIl8JQQtWECGuD90ypd2SLsY3nceczYedK9uWNAU3tiCEsyRp5wItXQB+JfGTZK+D4DNvxbYHMnWsIBXcyySKI4eGuj5y1LrAAfiV9MYG9UV9kpoJPZMeZV+UJ2zC5KKHcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyEHvfDYeuxuqDTcz2aB0yeN4MWNx6MzARP0SqH10nY=;
 b=iVta9K67zZC5ULZD2rQ8SK+KoApyw29YafU6Dp99fR1JSmbk7/rTsEfP0BN6c8616FRDrJZeJn5qSWuV3GSvVxKvi2nX7B299TOXSj4adLUpOttWyZdc5KnJVZR64GOGhxgJle97dLUOqcPYYtM0O5vuWAl0kT3uhU+wKWG28Zm07+iBFkZSuQqtkn+y/1EmSHVj2m5iyMrfdGWMp916r2VgC48xET4MIhVElO64GmUHnwZcft3RWwwrhTqkmmyi1HyIBXRj/T5ZmjEiGJK2lHcQmCkq7BB96Y+3b4xzxxn7j0mw5mawvwJgs/+tF64Uy+jM2Ps0jeaN7fFsaivYAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12) by ZQZPR01MB1089.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Mon, 21 Oct
 2024 05:46:47 +0000
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 ([fe80::617c:34a2:c5bf:8095]) by
 ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn ([fe80::617c:34a2:c5bf:8095%4])
 with mapi id 15.20.8069.016; Mon, 21 Oct 2024 05:46:47 +0000
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
Subject: [PATCH net v3] net: stmmac: dwmac4: Fix high address display by updating reg_space[] from register values
Date: Mon, 21 Oct 2024 13:46:25 +0800
Message-ID: <20241021054625.1791965-1-leyfoon.tan@starfivetech.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0005.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::11) To ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQZPR01MB0979:EE_|ZQZPR01MB1089:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e8c7189-f81d-447b-a9c9-08dcf193c0ad
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|41320700013|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	tjloJrbylN2lZ6UQy38YvJykgmMI5EYrnPIi4HoRk5RGoMA76OARMEDUC3Sfo1oP98ozw6cQaxG914jlnbrzSEgI4zmPh0uZpFl1ykpuud+J/EbsAAoAkU9HbF2wxFvvL36K2iGeQkssqhcjWJdEQAqp6hq05NuYBo/Ll3SoEUtWR6GxdiKkJioKfvMN6Or0cNatEl1dll9RtCriNtoAnsOaRhXE56w2nuTxF84/Zk7u5gARfzvSHAwkws6slPuI8mCVqao4IFxMfaLv9PKTpXAjcVOzIG6rDseaFTgXC1xUJh4IG5TG8V2fEVKBxrZBkj1AfOzLsEyEPIyVJsZYx12Sd898tgmQKLpeEJGNC3Jge3SNc7h1KQ61/h7Rdd1OejBLMiWRmGCCJE7Wfb1we/NsaPgB1qQS1fkXvEekAC3Tvh69S57Tsm0LCNx9+vyHUlZzF0alqKuSSV5GMb9s/t6KDy6ZWz91ouJbsYjb/mzlvsVR8WhGECDuFzDSWLvf9SCoCljyNdNt31IF0CSmy9P3550RNFJBmjG/T5g1/m5Ac7P5HwPwpwhYDVji7OHaX6yGT4FipmUvYrnGOCFRu/QRkZhae4FjrZ0P02bqOc0/yW122JrsvzC7wCCX2ADw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NR3qmbefBsRmDaOTRnaQpuqSc32wfdtqad1NlQx9G4/PgotNYSglnOwGQ5Us?=
 =?us-ascii?Q?0tU1G3qMRj7BPwUjbJpBZjUK0ekdqUq/KnMyScaHBvd+CIk3xHZglJcJ+m16?=
 =?us-ascii?Q?8U4lEIxVMkxseh+BM6INXtrhkY0pI85umVVHitmGbv2WpKhBMNuhf4PUyMsv?=
 =?us-ascii?Q?wiCrIPoS8H0X8xGkwwmGhDJB+5m3L8hLZVkWeg9fw7lp0JuIXhebcMSJ+VrA?=
 =?us-ascii?Q?d3pSZR/6m30Fez6/bc+ixPY2R03wO+jumEQnM05GNHQyDL8lDNmubPxFSYRj?=
 =?us-ascii?Q?DiRLyVvMqdhS6bgv1oSyV/i5QA3SH1LZ5MLiW/tvu2q792mKhlLBH45OGnFq?=
 =?us-ascii?Q?QizcpzmuzzTsqCq7lwilKTO7U0uNPthWzjKCnVrYkTaIyJjPMHFy+vhWtwXe?=
 =?us-ascii?Q?euqZ9kuyFeLP4SzFIR8Wu4Cvn783nmEZ8K8weVrdCVFsVUAP0R4k6cGaUu3F?=
 =?us-ascii?Q?PtNb7XsLH03OEyRMu3WiHpaYJkBnl21FWbXjynujWFWwu2rHtuzoykjEuhJt?=
 =?us-ascii?Q?9/mW0ooCmRQTsPqHNTkbz3McWlC4/5mHm8KX6MSP1OfeFxMNyr0SrKOU6pT1?=
 =?us-ascii?Q?p0OXi/a+YATr7ZlvRMK1Ttptl/9n7A6XeLYlrbBXEcuK8Tp3Kg/9ayOD1hDB?=
 =?us-ascii?Q?VfkKVBICaYpp6JlafssbGobnKyHUwj7OxcbGGWfIQz9Ri9cSHCaKU2lya5Rf?=
 =?us-ascii?Q?GEvZFAWAHsUFSEw52V4B3b9r+bXd0r84jsdzr9/pi2EW3jMCeGNFDkrtwuce?=
 =?us-ascii?Q?HjiHKMdFiOmULs9f9B6PcqUL/tYi0MUVT3UZXM0a3sKxTbGtiVmQo7EJY9rt?=
 =?us-ascii?Q?n6TQ9StOyRHwU8LGyPJMeJTs8Cu7T/lA2KQDPP5AwnW3b13lldpmVz2ZsCAZ?=
 =?us-ascii?Q?xP0R/g0BnSmzV9rCCYeJif4p/RqQah3GzUWBX9QrXQPWvFvNullj59fW2R4V?=
 =?us-ascii?Q?/MVoqR/BsgNb7GGz8ETaRnW3LUGSsyCQAXvZyCjArScYUG2KKDCDj4hnvIjP?=
 =?us-ascii?Q?8JHqu+DC3BD2wi/EAs3xfzrAlgfmOyN3bfSuX4oKp5qFfqvaec0mW+rNqZ//?=
 =?us-ascii?Q?0m1TtugY6glCLWz2EuV3rG+JHiovoz5o5mnmEorU8VTqrIO+vmB+bTIxaTvJ?=
 =?us-ascii?Q?8oAZksjGXBNcH28MaKHGANcav5Fp4cysR3sV7zgCscJvjHwR3sPXAU3szM2u?=
 =?us-ascii?Q?fWWkVIgfN09ID2wkz4AekSa3cgvasbRsNgP8ebugrH8S2LvVSYCymmUIJAVZ?=
 =?us-ascii?Q?i8ObpooH2UIrNmc8UOQ3/uznkrnQBgmJP6WYLLxNrZHqwncDTFlkfUS9ue5p?=
 =?us-ascii?Q?2yPAhFrLwUKYOFZH9td4PSXzMvoxp+CuvVDuHkDLM1vmLcMX+g0l8QavbiCD?=
 =?us-ascii?Q?1WshkLdeoou7IxpU7cALmX2VUPYHq06pAj+128ZS6phXokQvxPJ8poEhtyuu?=
 =?us-ascii?Q?/I46EU6zKkWrAmGqGWufUPsA6HeX7oX8b+Pi9xr8urwStqKzJZr52MJCapKQ?=
 =?us-ascii?Q?LTak9If253fU0wmee5PGi8+DkXurFrmBHAK8ayK4gQZY3CLDUwcEU6U2rupA?=
 =?us-ascii?Q?Ahg7yRPRSW5CJ5vdbfrSSoEmlal59bGug3NLxR2vRVhuAseh2K8ILkX2d/D/?=
 =?us-ascii?Q?bQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8c7189-f81d-447b-a9c9-08dcf193c0ad
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 05:46:47.6636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pa/IRbXEAn2vCKYPSOvkYstyX6JiFLSWFRvmUaBJdKmsTO6mzNQfNCpNBVHICAgqUZ+/ugwLIQ24LQVGlh/Lsman9Ur0D8XSRmzI845x7ZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB1089

The high address will display as 0 if the driver does not set the
reg_space[]. To fix this, read the high address registers and
update the reg_space[] accordingly.

Fixes: fbf68229ffe7 ("net: stmmac: unify registers dumps methods")
Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
- Split the patch series to net and net-next. Submit this patch for net.
- Rebased to net https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git

v2: https://patchwork.kernel.org/project/netdevbpf/cover/20241016031832.3701260-1-leyfoon.tan@starfivetech.com/
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c | 8 ++++++++
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
index e0165358c4ac..77b35abc6f6f 100644
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


