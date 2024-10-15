Return-Path: <netdev+bounces-135443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B0699DF4F
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE1E1F2282E
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 07:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A60F1AC420;
	Tue, 15 Oct 2024 07:30:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2116.outbound.protection.partner.outlook.cn [139.219.146.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7EF198E9B;
	Tue, 15 Oct 2024 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728977402; cv=fail; b=AZcSgEffTgMS7m85I+ykQZ5E2QgZTryjdyTFEoZkrKxBugSqjRkytD7qmrj1t9rq2L5C4O11ScDa9bDmsjkss9Uj/evxjspV5u8FDA9hAYwscUYzCbvdwT0XtkmQw2627idaVg6LW1WoG4oW27+SPvSYjOyWDANdgn4Cpdo6uu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728977402; c=relaxed/simple;
	bh=bLzd0eS3L6Jmo7TCTI/akWhZAsYGVTw5+EX7Ge8m9sE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WTdzvCtvj0TugyrXm26luidG8tXQBeTfKpGUdlzj2uJJcNTpU6bnrd8chUhmxMrHEx3qHKXU89u6lmViMu4KYTPhuW+7I6qYfR0bSw9i7wlLYLAgPk5PhWBeEN1BjV9KpeX/DPGYZ+9iJjHu5niJOh42MFWJho1qeNB9F2XKAU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLW+950HJadrdw1MOeTd3wtdRLK+p840wMnG4E1hYfLdu4H1qDyCKdGbRXoegIAoA2hHbRbb6FjqXnj8eSwulN1eJlE0cs/HIod3l3JyrfAPNxiH1PJUxovJYViADdnmJwBJHEcOlvWYAV/45a/EIBKJLyFqK9zS9egjLG4YuUFQCAzTMHArG2PoBTRpH1AA68xUYt/5tQlajjwG8dTh8VaO0u51kuqtVlmH8Z3aNGHJ92khMMrZiiRbTzHFSO0CSVM/HM0ueA9izhsszVKOlZ4Pdqwje/jRIqS0CotNnZLD7gOALSZ5kHcQ2cu2ccUrp4FVe73BgWKgZmprLhlU8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9jVMtRFsPCo3HS2I26E6bGM9KeUSpTylAxw3pJ2MqM=;
 b=Iu7k+XUOwMa1PoA1BJswnqteE1pqy4hw2i4N2T9vV1dc4SxqTsj6GrndS/2gWKmaO/j2iy5f394yHwFP7dUCkKXa3k+H318y1Sd9Mz54vSHcGa1fFgV52f6kCRBZHwDpdD0R8x79+oiZcqzEx++Q5PE89ILxoldtHBuyGJ+hF4zY09rwyUdsrqoZK6KaTvhn3OYY88kiG0WGALYdfYxCH75HOhB2SSfw3cTljE4dlOFbUK+l0wuFEUkrewuevul0oNr548rCMsayLgAkF/vBOtueFWiq3F5ZltPQfO6ky0uI9FPZYACwgrziFIPCdgBEmD8/i+/RBuPlbZQGgEp7WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12) by ZQZPR01MB1105.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Tue, 15 Oct
 2024 06:57:42 +0000
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 ([fe80::617c:34a2:c5bf:8095]) by
 ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn ([fe80::617c:34a2:c5bf:8095%4])
 with mapi id 15.20.8048.013; Tue, 15 Oct 2024 06:57:42 +0000
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
Subject: [PATCH net-next 4/4] net: stmmac: dwmac4: Dump the DMA high address registers
Date: Tue, 15 Oct 2024 14:57:08 +0800
Message-ID: <20241015065708.3465151-5-leyfoon.tan@starfivetech.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241015065708.3465151-1-leyfoon.tan@starfivetech.com>
References: <20241015065708.3465151-1-leyfoon.tan@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0067.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::34) To ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQZPR01MB0979:EE_|ZQZPR01MB1105:EE_
X-MS-Office365-Filtering-Correlation-Id: 96413965-669b-42df-c786-08dcece6aa47
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|41320700013|38350700014;
X-Microsoft-Antispam-Message-Info:
	GQ1uH14mh0k33SyhZFfmMxWfXxqUmGh4JXEriYk8hcgr4Slx28UOZgTVoCPno1/Ec2Ij7K/bNIkactzqUpIapxapDm4jl4Fa419gEp6y5yIdvbeBCYTmOvifqxzo7NbHRoygxt0x/yXioqEpIoQx4rHPdKJC/NrWF0yy9Q4eSQPH3Sw0rxJi01SFf+QfbsL9IkPfoOJ6kaT9l6YR7rABuj8oJfMb1HaQz3OVlOX6aQO7O3/NeAju+SkejReMWS1yK4s0wWdxQhQiitwKeU7+wcZm11K9t6Q+cCZ6H6gvrtBkQaaQX7gAOdCy9TfUMdy8j9TdWwRoCfRj61PE/idoz7VJUaAjRPSOA2k42AF2+NIFdVN6GJaNUfEs0zzm/FwCc5d/lwtdvVEFlo8PeijhqPYwPAJgC1hlL8xGRs66sFupPpjcbhFShLyWqch0XBhx4Iajmgtz2lURNW1Hen6HEL3bB+TYjSdHFhoG5211h9q6c0BfoAHNwfvBrFl4cjld3yFjTsh40+z0Qk96D1YjYnIwwSz3h97X47nqIqP+yo+g4Pa9uBsxz9DqLtYv42ciIAtuPO77sFzaP0xW39/RoPoviv4VjIqk+2seV4TGKAlqlThA3PRuz22ZWcjLqfud
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(41320700013)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xmRV0pqcihnXxkmnMfJcEGs4+yZrF9Vt1um8qVj5rQ80N+IjwTYjMbwJ5fZH?=
 =?us-ascii?Q?g6Rk6g/cJv4kBH4o9E9+un0KzUzIOgt+HbZnbEitt7X67cEWwAMK6ZXDG6ZN?=
 =?us-ascii?Q?l4qV9U3GNafjacvH+ro9rKPTQ4Vld6wuXMwHTQjhnS2Rn+7i4jTwHJOTx6eu?=
 =?us-ascii?Q?DUBkmcKwqw/WIRaaXQOgu+/bFkgauvSvaavBBPYbWd/JQrnnoviajQfoaChK?=
 =?us-ascii?Q?RGS4QW8jGJKz5zQq6su7njYvQHY3bB+6yScMwxOVMs9IhOQaDtX/hJEGOee8?=
 =?us-ascii?Q?xvdec0jrCYxM8mZUuTLELPuZB/KTOi5sUey/FRgJY4pcIV4ahGYKFWCdVbse?=
 =?us-ascii?Q?HWORQ+NnmCn9j2tqn6OsRWJqDvSup8t8rQQEEyqgrtji/PZFNcXHPW7S4YMp?=
 =?us-ascii?Q?daw4RgGOJAvbto7eAek9RMv1eZLDDKVfEj/PuuXC2d0noKKtmhWXlw4t1UZ1?=
 =?us-ascii?Q?aRunwY7XPeUsS9ZBf2ou1luDBfGbuoo42p7PRekhDipBqMmLTum6nZbsmd3D?=
 =?us-ascii?Q?nHcrkb27IBCtkFQ+52q613cdiMYmpDhK9HbSesIByzGbxbQa4OkdoQtVeJvp?=
 =?us-ascii?Q?v7LEZUbiFixhjeN5JftDhJoLCFGJWbAFMts9CN5weUCiAi+AgB2UoXj/1MAq?=
 =?us-ascii?Q?nf/ZIP/1j4RhHw8K9N+nogpIqc8mKFR1VUfStyWepLXOD8WI5dQb6GvWRCpJ?=
 =?us-ascii?Q?UpqxRBKeffJqOvkr/FUNJwHtoyo84BWioqtFTfWwRqbKd14lLmfQ7hwGRPDS?=
 =?us-ascii?Q?5r04Tf5I3LMMVSDJK7GkRlqezbm7xcrtaEpPwl9KePlQpM6DDTv0JgtPYVtl?=
 =?us-ascii?Q?rj8ijNUPMLvHm/K2mEnCAXHCARvyuQ+a+T5C3WiHBGIrc4ZrRAsxYe4+dEYb?=
 =?us-ascii?Q?78UD0kQ/DVaeLQmmMVeSbY3u91uFd19MdwbrMYNUZgfin3W4S99j6ihOo6tW?=
 =?us-ascii?Q?qmNiQL+dhaDFGdgtbecjOjVeGf8weoQ3/Sysn2Ogzczib8XvjlSz9lQG4p2p?=
 =?us-ascii?Q?A6C/q42ujsAFBAOyIhd/qm2TURyOaKmT6Dxw40SkO6zxQ1FmdHoBd7MA4y9B?=
 =?us-ascii?Q?hSyJllxrF8XukL/tu0f2A8lPjrVgUtcaoOegs6uXOdCoip2E2sCXIYFR8HXa?=
 =?us-ascii?Q?pSxggMnu66I4Yg/ik52oupe5/s5IuC/odNlxsVfJPifDBLn0sH+UhSE9pH0o?=
 =?us-ascii?Q?VVPXC+TXDzDyyS8P/HY/eB/bsbtaKw9klGRrXXKKeq47HOoIet9A44Qni7UV?=
 =?us-ascii?Q?nHTImub6KCU60KTNdcjh6E3dBUN/owV0xr/KNbdYy7oAwKD4zVRQwzZ3NPiV?=
 =?us-ascii?Q?L+pTzthrEs3qcWzOESjRk/xltc0Ez2aBGBRMOHMRWJ5fTcF0hi89UtXgGCoA?=
 =?us-ascii?Q?W/pPtw+GGZrLcMC3ejN3Qv42l1/ZzoBBlnfbFI9YkSx3o0nOHfOWNjF6H3ck?=
 =?us-ascii?Q?zyrkYGCdefd/Zy8BBAxHT8L+mTrd5Diz1KjdC25mNGTOow5KA4MI7QJGErLJ?=
 =?us-ascii?Q?nftXGTEINJPnJRi2wG7KoxQvVBMiHabcP9p2iZUkD5/Y80ZOBBtZvypBBQ0D?=
 =?us-ascii?Q?OT6DH08iNG9r5jKsVmnzbofM5il38FCXSxQ6+nAmLm3+4us2VsOfxoVsEd5L?=
 =?us-ascii?Q?dA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96413965-669b-42df-c786-08dcece6aa47
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 06:57:42.4835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UO/E+cIgL87WAq1EN9cDcoDdtW7+4JN8H9hxuDCSCeQ6JwNtbj1UWTtFMDUvj63yWC8DzpPR2ORa6KY105oNDMN1ODcPwK1zUqvYvZty5SQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB1105

Dump the DMA high address registers (upper 32-bit address).

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


