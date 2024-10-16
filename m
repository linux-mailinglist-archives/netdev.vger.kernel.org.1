Return-Path: <netdev+bounces-136013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A59399FF4D
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 05:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 857B2B25103
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E808A186298;
	Wed, 16 Oct 2024 03:19:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2126.outbound.protection.partner.outlook.cn [139.219.146.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7D818756A;
	Wed, 16 Oct 2024 03:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729048741; cv=fail; b=B/APHm9d3hxJ3ivRJDq7Z0Y42ltIylzqJXc+pkgN1kOs3DvMZojDByHkHrvqLRjK2slV4vjiqlDNGOQ70h+yVAYVQrT80Qm3Ilfg8X75+Bu32eE80yyd8ObM1lyQ4be6phiRmv8hT4fp8gYVmZ/5E7z7uRhQPsNt6t8Wkeyx8oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729048741; c=relaxed/simple;
	bh=HW8KSwXWeO/6JE4pbs1n16h4fsVPU8jQQFlgxBrKAI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IIqX+f2SKOEui5hZGDFTYmnFFgPTG1ltjQ2QO+J2h/26muQzLn4tThQserE2vcmUcqWqg7yCJTPk2CRgB8EaEta3e2s7nK0AaFZkiLCEv1iWkoPYd0lnIviRzteLuZ3/xcEZcOBPruDuTyV8+nhK7qDCWxril8QNkxejfpqLwv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U32De4qvwgVrbFAvEXm3lVD3JjO4SbLlKTbdnYh6gZ0IKsCQ/ZStb8Zqtrvw2pTTZgBstourqgon/5VeXZ7wZCf3poyaQDC7zFIgq654KT7U/8OXPy/gw1lT213LADrIw+CCCWitA4fTagAWFJsuvxc9eSVLH+DKDp7Lxei6ABqO+syhJ4Fcyrslq+Z2qod/bTHiH3PXZir4qjRX6+NNsmnUo6nzoDo9M1TDuiqRtwrhYC0eDMubDQ8cQPnyYCcC5oS8yKvMuBEHhn57Yad0ADRM+LoifMaeQC9eTFDeKnOHJsPansn24j/k2dZDs3IYWkLdvvM7236ciUd8XzrWHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImfW7z7XD5azVTc+abegwuNShrnp0d2Wh4zrw+IKVkY=;
 b=L7CxUQ+rVV1NTLSMET62sqLnajtDTg2qjzYhtLtEwDB86RPI/2pXspo1JwbmzUyi9fIbRG5Uw4c1oJLHUanCmRxFj17ugNKF382LhztmgRPnDKCYGd7uReFgWJRGcgaHCcSKX3U8OA/L5oAKiod521ppur1SbtMNv0YRcb/coWbe0JoYxzRe9CBI8kY8Qo/FuTMoBJJgSYC/quXXV3nttaLOV9rE1BXqBjCfA2H0mYNJ2S7AzwvX4X1biuDWqJdeN9iqdRobV42xivC5OfjvyvMeSyb8pmFzsQx31O8F2+N4cZKDZw170fmUhlu/SXzofw5g4D+N5XRkub5ulKkeDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12) by ZQZPR01MB0961.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Wed, 16 Oct
 2024 03:18:56 +0000
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 ([fe80::617c:34a2:c5bf:8095]) by
 ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn ([fe80::617c:34a2:c5bf:8095%4])
 with mapi id 15.20.8048.013; Wed, 16 Oct 2024 03:18:56 +0000
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
Subject: [PATCH net v2 2/4] net: stmmac: dwmac4: Fix the MTL_OP_MODE_*_MASK operation
Date: Wed, 16 Oct 2024 11:18:30 +0800
Message-ID: <20241016031832.3701260-3-leyfoon.tan@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: ZQZPR01MB0979:EE_|ZQZPR01MB0961:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d035553-893d-46a7-e82d-08dced9144f4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|41320700013|38350700014;
X-Microsoft-Antispam-Message-Info:
	1G+3ud2Qgtavm3jbMBsCiFGbJjQ266LJXfBNJ/C0DAtM9N5/FcM2VkUg2+9omBabaAp8/Ptn3QWxcqSlM6/l3wNUsXdlLPh8YJZw24hSOYemb47AEpy9kvAqj08OhPpu603godXUdeYab4PqmEbM204cSpRqtm9C6jSxoAtIkeApZRwUWq+lWkM+Bj3JLp0Mo+r/giCnp/zRZboapwYl32XGrKLCBeg6ZCLHCyEMRg5YM9nNLGBvOR+YRypyiD2W2U4KrLfufop/YLFa/wfRgwDMkHakuOlcW9bC28AddHzsHSccYwbhL92CJDfZRFuoHDsS1jnkZwCCEQQQoTIxUG07tyNgTVY0KJBWB3L3DEQuGAUdQe1/WAycOu+KPotU3TjCT8iggOv/uIpsJ69sNmV1q+ZXCkmZ7IhGxju/vTegigyBpb0nqEFWz12tOYP3O/5vG3LbgrkfyuOuGE7mg2G+8Etwnd86HJ99LeeUWdpXm3iRnuwEWyF/VxKAOBJiYgAqzi8ArGblf7/zlu9m7Zy9umRZNDxom2naL+83lVznASmIpQDoU9Rk5c4CVYQHMhBZc/4rdaE1gIfIoSlAC9AjLEClhq8JG6Yw6dtdrCUm1O2fA67pm/fjWqj0ZK/+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(41320700013)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7prceT+XCoiOQXdq/9mdtQ0S3prAUnPeFA22ztDDTEkrzC7YBnRQNqBrEFEK?=
 =?us-ascii?Q?NGOtGeGwzlj+ZZrQCe7hNTKvSCSe2TBLdqIEuFL1gKJtTYL+e5WtKdcqSVD0?=
 =?us-ascii?Q?7qtmETuXlTO3UDV1bglqGh2rW66b9r2T714FnQWBT7hVzuMDAZxMdwniya5K?=
 =?us-ascii?Q?+fFtkzPa/qxSmbsR4f3LxObPG0Nc7dytg9MiQGbjHtc6W24x+LLgPEgVHYb+?=
 =?us-ascii?Q?w5i9nyZZmugX3VsjMD9qEE3a7IAXAgvZJ5+KghTZvVML6r+ukEw7ws0B1NSF?=
 =?us-ascii?Q?K/ucRWYzwGoeBhkH6GiihzArYGhXPCiWH4RO73MasrilsOS+ySV3SU0jb5is?=
 =?us-ascii?Q?mvTTaZ2LnoPSksLKF84G0Q/iZyIEeMP+2ZyAo/LvQZrmSqWJy1KXfp3LYOPU?=
 =?us-ascii?Q?x2RBzeo9vEefhQWnBFw+jmVzxU62J+E5X5eGkBOgNemAAYrUDsfGcFg9LBiP?=
 =?us-ascii?Q?6255ARbdCPhwtENwvkszcjD4/GKI6+swed5hSTT8o+g0VAaTqEjQn2T6+K0l?=
 =?us-ascii?Q?K+uSiLdrpgiqPKC5VURVa+PGpmfFYfN8bZJlaN/ipj1n60MIQw0u+mTUGjBb?=
 =?us-ascii?Q?a9oM5J/YCHsOzMFkZueN70WTlnE0HISZ8NeytUW9lq5N8PqYamaJYMBd9djN?=
 =?us-ascii?Q?R2okI8MFRiGCj1RGr5fQGf08IFyXXIaFc27gBuIOUqOPq0PSxsssQ9FAMPqQ?=
 =?us-ascii?Q?/MfF9RIGv4laQ7jQZznqHMM9nviklF1hmYqblAJmM57ZQ9Z/HZViJUwfPl79?=
 =?us-ascii?Q?OqIPUc6Px/e90vAmWW4sanwEyapGk7udfh8YouuiVE9k3bckErh07/pT48yU?=
 =?us-ascii?Q?aoRDSDSFWfcwI361SFGPzK6hpBO2qtAXxustJotrX2lgzhyobY2aWclhTN6q?=
 =?us-ascii?Q?AnsFESh16jrwRYndF7KKEsZvONBRZ7ACDGSu8ZPUb9vKf488EdSiG7lJQKml?=
 =?us-ascii?Q?o51k5HtSbYGTqwiVMmVBVf9mgPqiGKdx1uGTsV/LCdto7aKrtgTBxOLLd9gk?=
 =?us-ascii?Q?pVMrOGaOAnsiq2IBW+Z0k5G6zezjJpxAboum89woNrLUaS8cJ8A5vpf5/QMU?=
 =?us-ascii?Q?1YdDgEarFS+/FZG0qTDXeeR5eJW+OT3y75Qbq7zLdPas+30zGHQgRl2x18P1?=
 =?us-ascii?Q?ejWgR750owO1WqPM521NXysAHMztPgSL+zwLnSaaKE0A580Ymg5IvFYhYqK6?=
 =?us-ascii?Q?LOQauzGtFQ7WXeVIZz/rkigu91IJYVE27OMxtA7mTKGpnIqwHfl+cXPMfGFe?=
 =?us-ascii?Q?uGw70uS7U7rGXVnQ9eGVKj9WOByRKmOGak1Wt+prcJsRlJOBNQSuHDn72MwF?=
 =?us-ascii?Q?Oa8qFVHTrsWTNr83+xHeKXxhOKeP7AMzVdbyS20hMuasxRCd+Su0oAhgGXwQ?=
 =?us-ascii?Q?i5vb140uY4jn0t6XGdjyGpSUMwzNySQF9H15LvRLfOhIjYGjI6GmDEQveDgY?=
 =?us-ascii?Q?VMnYI3kPI0HrDvnPMh4iM/EJAGZL4NOrhizzEDMu1ayKlEoYhwIdnkNR0TU+?=
 =?us-ascii?Q?LzO47sPjlpI8vu1zVpIJ7zaLKZrc05MQIsIoIOFARhqizRTVqto7Z19IXN7Z?=
 =?us-ascii?Q?7mk3sIaHOTSFMOeer1WmAS39ntGV421XYA9RTlaxRLPNwnW5JkbBli6xYHl7?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d035553-893d-46a7-e82d-08dced9144f4
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 03:18:56.4581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzsGHxXf/axMw70NE5NLuj/eGIn5ELChdY3GEkzpNltQzQz0qGc+XFX2V857jjvULrHkR5kpyRbNVwJQYO/YPTw+sDIwzdtO6M5Hm2rNRcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB0961

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


