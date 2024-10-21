Return-Path: <netdev+bounces-137377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 549389A5CA3
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 09:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC33286A1B
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 07:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015471D14FD;
	Mon, 21 Oct 2024 07:22:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2127.outbound.protection.partner.outlook.cn [139.219.17.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8552B1CF285;
	Mon, 21 Oct 2024 07:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495340; cv=fail; b=Hl9Wdvywq4yvI56fJoXap1H3c+8gQixp/xkXTr2j/r32Ud1T8SR9vuqWRfow3Ww7WHek1LJw80dIPo3aKDoA/qRoYPnLk1TkpnRx+yVppMEOr9+Kvkwf1p1nOKdpmiV0DWdVtt4iNQLdrOrdgzIia63R6Up151AlMLtp3/NclXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495340; c=relaxed/simple;
	bh=HW8KSwXWeO/6JE4pbs1n16h4fsVPU8jQQFlgxBrKAI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XG6DOzMFcFsyXR0ZkfbuVXyFa4BhX7pL+vQRm3e3LDGBQWVZGxOThgqd5vj+FU0v7sJ4nMA4D2S8R9N+gMJKxaMhw38WLGBFVgy0wvP8MxfPgHhjUohWHuqDS22QPrdxGTUG7Go4q8MmbbLH6sTVwJRrqz9ysM21atMxSgIzdlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIlZ2aaoIxWSkEBWwyeAPIpaww8jawiQssCpxJWhHn3sLYnpI9PG85nH0dOafX4sC+0WsVjQL1SEvWusRgPwLXe33guU9L6QuyZ0zFhZQHoNB2U73IoxYizs1gqg759z5yLWrkIDY8oHGOs6li27Aj1eIHjB+M0ln797yzko6LechUa0ibm39TU92UnTK9/mLwv26wJiwF6ZtAecG03YIvLb30DxbHIDescrD4LPT3cir6LfLIRnlfYsFMCz+BSz85WvY8h3X6pm4exJ640NWXfsCr8n+LwhMUQdM8VT1znDRCJyJoWjzQ/v0AZOgNdHrGuk2Xn3WxSP6Tgb2WfhYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImfW7z7XD5azVTc+abegwuNShrnp0d2Wh4zrw+IKVkY=;
 b=iuu5TIQowKQyi7PX52xRPXNshOQoCt75dLn8XXsiDIVHkT3NY4miId1/nSABRv3lAyvQy2gcKf6GhKbmWEZIhf/96ZbwqH0biFftwlepGEpH6kaqYUOgwxBbzTA8tUNO/5WqWk+XG7tIMmE8KU1Z833wiAQr1kZC/FYJMnxKEBOsq45qsOZykjO9fzNVI+5h7edVrTD3KqJny9Uhq/NXg52c1ABTAckAVsu3STT2US86EejbZpMCh+ek9o0tpC01h9Leuw9Hg7KL0rmfayKHagCOQw3D22PqvatsvQpsSs9RNtgaoeSDwhCyKAGib2ra5/T4x4lgjlcnVdRNtrZqug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12) by ZQZPR01MB0996.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Mon, 21 Oct
 2024 05:49:14 +0000
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 ([fe80::617c:34a2:c5bf:8095]) by
 ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn ([fe80::617c:34a2:c5bf:8095%4])
 with mapi id 15.20.8069.016; Mon, 21 Oct 2024 05:49:14 +0000
From: Ley Foon Tan <leyfoon.tan@starfivetech.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lftan.linux@gmail.com,
	leyfoon.tan@starfivetech.com
Subject: [PATCH net-next, v1 2/3] net: stmmac: dwmac4: Fix the MTL_OP_MODE_*_MASK operation
Date: Mon, 21 Oct 2024 13:48:47 +0800
Message-ID: <20241021054849.1801838-3-leyfoon.tan@starfivetech.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241021054849.1801838-1-leyfoon.tan@starfivetech.com>
References: <20241021054849.1801838-1-leyfoon.tan@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0028.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::15) To ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQZPR01MB0979:EE_|ZQZPR01MB0996:EE_
X-MS-Office365-Filtering-Correlation-Id: b22898f1-019b-4fd5-d80f-08dcf194181b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|41320700013|38350700014;
X-Microsoft-Antispam-Message-Info:
	5xPyOS8+gJndNrStGK0RcXFHsg19JZ9wDpNfVY5uIDZD8e98hNUaVtR8NzY3k1Eq1c1nMY0lQvQESa5xP2m8+iYKSHiZxuQuuxy6UABW8SSza4qcdLACb1kW/cfg1lkjkwurM9wc+07DS3wTcNrsYyeXfqc5m0DxAOZmwgCvOL+E+Bc79Hbw2fwg9b6uKAjQWJ/eR2LZh6BMiMYb2ciBaRNDzo6u0pyVI58kb/OC7QFbHO073TprW9VZW1Ku3DLEithy/jz5hlfX2yP9HX+LYZJvi78/qftz1CeQzEUfOu6Z3UKy4FxSRmURUPHj1iNoXS3yTvrgpibCDQUNz9oPSoeyBz5Jrq1g7nI/eimaTdGFmcod7rbvz3qC43HAxKS+RI2sEBI2xE3v9v7BkBwT15UweHadSXIGIGpl6q4JAYiJEo9xPyUJSqyt+Ttch0QhMnAzHsdcKVXdSrY6sNGpnRJOcMYPRN/SrNiERYz2qw+ayy1eY0XRqvQmeSo0ZvdpyJ+fjPixNfg7Vjan2NGA4Gq1AV6k7wJK7Tr+KKv2MhO9Yiu7S0MZHtmKOlq3YKtwg9KeTPrUPEs+MuvzF7NmkHeo0xLBR3fJi/8g7Qm6QBYfMhSPzl0sRIY1i+wq4/r/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(41320700013)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x1G4sGsB7ftfgk59+oZRPyYqfYqThXB1ULKGYDu0LRIdazRQBgtozgFq+g7e?=
 =?us-ascii?Q?j5h759vqf8ZSLgD6ivKas5+zwOgiElZU2oNj5qB4Ortj04gnz085denJPL1+?=
 =?us-ascii?Q?C7iAveT/yG4HwU4B0vSxJuXUIzoUe+x3Y8hFiEIh3dFoRUvjWesP9RiF/69Y?=
 =?us-ascii?Q?cYEmh2EjxQLlRRfVytbfWkv1O+yeiXX6TjnmtA6j/KZNQ6O0Y2YKNMIDNJth?=
 =?us-ascii?Q?8HxqTOd1HUQv2G3tBEZW3qNaFvTolmZ1QhUjK+IuDujVFQ1NvvJ9H8awpRPd?=
 =?us-ascii?Q?F/ZkFRRvEC4/scqvXGBqkNZxYqQuJ41TV31KVfn62p+Ar0zAq5V3OSFqWsk3?=
 =?us-ascii?Q?IPSo98VPSf/WKiT04wDxq5BBojEpqcTcUSeGLDysFrF5qQSGh/cvEkisK6+t?=
 =?us-ascii?Q?CwPlBJlcxIrvIORB4pp0TIOXBkAuDcGu1NDTMivhoiCIQ61WSujJUCSpj60Z?=
 =?us-ascii?Q?IAbYPsL68VZT+L/bLLe1GjLN2V0lVff0W13i6k4ji3ep22sDc/a1Au33FRie?=
 =?us-ascii?Q?X7WSge7wbwlTbpSNeZXQhigkwGgC03hcXvyaro/Wr1udEfAgLLb6+ykEpaDB?=
 =?us-ascii?Q?iYpRGVuydqZ8fbmFy+HdQybT799AgsGtbsARrv8Hzq67ZwXyEmBLE8CXqj2w?=
 =?us-ascii?Q?sItWCnMcDFZsE8xF/yTpbyiHoRTY7Rt8LCJRNkCWAhNnq45FhPQgtXpjgNzR?=
 =?us-ascii?Q?r9CGlouU94E8kKftiySLCupUod6/2at0KyekDjcPZUFqZQ391YjIfua7bP3x?=
 =?us-ascii?Q?CGFAJo1UgVuawyWWJxwyAmpCINYfebFMzkE1Lm5XJdJpPW1hgVYaS9FHTeN9?=
 =?us-ascii?Q?N9wdcjUAt3eRsi8tXpjBkqKz06JWEYH9KCIpJtNQavWjTRPBUB6urYESefWY?=
 =?us-ascii?Q?i/KnBogSoWnYZR/oaTPNjE27guzGWLN+gXXfetzG5cNfZLvQUAXgoRONNjJ6?=
 =?us-ascii?Q?0+3ZUHWkUq5CDxF8yTxtmKZ2L5VEzYp79Lc1Zd0BEJLRlvEyBAPlNtfTtUoY?=
 =?us-ascii?Q?IiykmSuAvPfKshY5aqZcP5+e1wAXjniD/P67WQkfxzInZLF0rn61aqRMf9ZS?=
 =?us-ascii?Q?Mi+YaXcAx97IWsVoACMjTVqIJuymb5Bwk7aGR1hJgtz2NsAwGg3cB7wWQ8kX?=
 =?us-ascii?Q?X/LMmqjRhAnG43TPGZaQ3RSnPnxA98XZtgwokJ7jcfCzpIXspaJbMlvzSxAi?=
 =?us-ascii?Q?KlOYoyEFGo0t4i0Yp0aHqu+W/4at1GCAI2ixBnontMHSIrcRNXuNN3Gk1gbc?=
 =?us-ascii?Q?wDrB06psjd9kPLiTIKCSPdtCHr7e8kRfQq8zhcfLUZzY8krOipQ65a2SORx0?=
 =?us-ascii?Q?2sE4vtKAs3G47gpcEZr/GJiUcTqjVaGtse9pL7TnO5ImeAApy/5guFXtbFPF?=
 =?us-ascii?Q?lshIEukxtbqvdwXfokk48pg3oNjnrmLtCc3PkiTU2erLqQw5VzoWlFlKXMpB?=
 =?us-ascii?Q?+LGPw3v8NN3a1792u3O5EIg5pNO0oK+uUqiC5v4CE5vsCIEwtcvSpnI59/fl?=
 =?us-ascii?Q?0Tw3k/RloQrnW5MCaHKd70JY0OXkZbZjeRfghdkt3FUazAjTgU3kI3lLWY4N?=
 =?us-ascii?Q?bFVuVI+vpfGKiyqV1YpPuANomden1qkuxDuPsewEM8ObLO0/cYjXTZynERM5?=
 =?us-ascii?Q?og=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22898f1-019b-4fd5-d80f-08dcf194181b
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 05:49:14.3103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Wl+Jv8HoaJPYedKhygBwHpG+PmqPLieYIxRnyblafMF5z8Fzyqlp88WYOVMQyDaUx9mSrTFJ0X50+qpGC+ov2G1EOq+6qzwZsN+4inZV8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB0996

In order to mask off the bits, we need to use the '~' operator to invert
all the bits of _MASK and clear them.

Fixes: 48863ce5940f ("stmmac: add DMA support for GMAC 4.xx")
Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
index e0165358c4ac..4e1b1bd98f68 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
@@ -266,7 +266,7 @@ static void dwmac4_dma_rx_chan_op_mode(struct stmmac_priv *priv,
 	} else {
 		pr_debug("GMAC: disable RX SF mode (threshold %d)\n", mode);
 		mtl_rx_op &= ~MTL_OP_MODE_RSF;
-		mtl_rx_op &= MTL_OP_MODE_RTC_MASK;
+		mtl_rx_op &= ~MTL_OP_MODE_RTC_MASK;
 		if (mode <= 32)
 			mtl_rx_op |= MTL_OP_MODE_RTC_32;
 		else if (mode <= 64)
@@ -335,7 +335,7 @@ static void dwmac4_dma_tx_chan_op_mode(struct stmmac_priv *priv,
 	} else {
 		pr_debug("GMAC: disabling TX SF (threshold %d)\n", mode);
 		mtl_tx_op &= ~MTL_OP_MODE_TSF;
-		mtl_tx_op &= MTL_OP_MODE_TTC_MASK;
+		mtl_tx_op &= ~MTL_OP_MODE_TTC_MASK;
 		/* Set the transmit threshold */
 		if (mode <= 32)
 			mtl_tx_op |= MTL_OP_MODE_TTC_32;
-- 
2.34.1


