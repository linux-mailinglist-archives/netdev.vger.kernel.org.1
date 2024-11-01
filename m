Return-Path: <netdev+bounces-140963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B75B9B8E56
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 10:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206CA1F23F18
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 09:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DE319995E;
	Fri,  1 Nov 2024 09:57:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2096.outbound.protection.partner.outlook.cn [139.219.146.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C7515B14B;
	Fri,  1 Nov 2024 09:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730455070; cv=fail; b=oXHKFZTWZ6PICzslHdYpcxG6NR9LPTcSfPF2DhAFp4VE/CKtu2FjyPKstdTJ44n0l39WT+9oOuIV3r+rRU6ouiK3H49nqLapyjeOIRaMrt4Ir1HghY+qFMgw8lUEpPuuI6heNl3DR2n+tsysuN2pMLloWpFdY+NxigvvVdrv/cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730455070; c=relaxed/simple;
	bh=cl21HXob9nXo2mGH5DM6P2Gk3R7PpVnGTas6NvwJI+U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=E29/whF9HKKuQ1xqIwRWd1/0xVvBRdMkSlRxXK1X/S0UC+hTu7Kgqa8Sf6EbFeTi+MGgzUsUvGCnYmJtCDAWUakb9JrPdWqP5dfY2xyWRKACl/bhT5kGv2P8C3lBaaS32FPUmygrGzLcf9XwLCzlKng/JR0iz/yDlR5tulf1YC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSg1KlbU6JNhqJiIPFNX94il/AJpx2uSHdMAbJfCJvLAaPoV460buo9rS8d5ML0/GOxCbyhoMms8ofCqxsjFTa9240xaSeyr7DYYLkdyw05D4H8+JLJ9QuwJbc+CMmVffazz1mPlGf9wrzEBolbbsCtGmVTWWLEu0WutqbBiMAUx1AKmzmPUtUi4zsJn8yqE5Mn9TLK6IWOFZ8Oc5HB80xeBNMRRhHCJGvTn2XfqsYMXTKHgz/JmxwiqXZJ7jE/Aur4JE1bjcjiWwzhItBk8ru3teInO1vKUELDebVD9snbuKTh7qK/rv/tcIIajmSCJj+Cw8RVss6WpeO+g8km9+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gL2odibtg5TQTIw8whdtYpTzsJn0jKKORT08sIewQc=;
 b=mGnLjk4Q4A88RRLoYtZxYFzxxhnsvPzcG+6wRuYuwlpUWqJjokdS5dU2/E/BXoi1zUPoNgw2/7e/jDf1B1sfw5l17XA4Rg9TTJBKmtjLoXgsDhzrwtUe1uUONndoEeiXtNUqFa1JPTVDD/ekyYpfFF4kBlk5quMIstMqjlSuuP5D6+xxqu7VigUm6rQbuRVjHH/7G40yHj+ewFkGOMurXd7ikpMVWX4DigNSVzTb21vRAjGa8FfZI9F7la2teraUNdgVM6kWPlPk/rcauc0AoxznXtH0Ds7XodXltblT71jKyLDEqSSpGzINOSF6KMc037q9jsffdzTQBRkrIn35tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12) by ZQZPR01MB1107.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Fri, 1 Nov
 2024 08:24:01 +0000
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 ([fe80::617c:34a2:c5bf:8095]) by
 ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn ([fe80::617c:34a2:c5bf:8095%4])
 with mapi id 15.20.8069.016; Fri, 1 Nov 2024 08:24:01 +0000
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
Subject: code From d0f446931dfee7afa9f6ce5b1ac032e4dfa98460 Mon Sep 17 00:00:00 2001
Date: Fri,  1 Nov 2024 16:23:33 +0800
Message-ID: <20241101082336.1552084-1-leyfoon.tan@starfivetech.com>
X-Mailer: git-send-email 2.46.0
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
X-MS-Office365-Filtering-Correlation-Id: 46112631-fdb0-4f59-40bd-08dcfa4e8a3b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|41320700013|38350700014;
X-Microsoft-Antispam-Message-Info:
	yqvjCA+SPrKIr7x6aPxjgSCF0iLT9IlRj71p9JuIeVrX64p2gUzT8rMdZ6EMw9lKqLdxm4yZBROZjDWV8DGpeAVO/WaXFoSi3NghVNwwL0w8tFlvYi1o+fVDZ59a03RcV7IR2yvgIRvP7H2vpWQAjTCtwIYmA937KOZTfHS4UeHU8Z8YxBm5okOymOqvKCDKV0ur2qHbFXVIuNbURf10rsZLjjs2rQbI7lHXQJE/y1h+Tfp2bkOjT2DQTCGyE5i76mYA7zussacjVI406+1vzZxYoq/RuSs3gVXACRo84ZITCjOIrpREFONstKA7Sp8gTWSiANz/DMCIiOK/mJCW0bsg+IiTBntZyDtR2KKsZjl6g0NMbBT7J/Z+l3SGhBRzJ9ySKYNP/ctrs7+igf56nH3SLwjcTSU2j3Ws7AKiP03Zg5f67l1CcPnwvzsdyfV/BAKVMuUF9iqZQdRIgLorUkRQNHKD1sqj6fMfmOf174pH22sKOEFXx24wBc13aqpaph0n9fq9DnkUfLMIitegSw/Bd55vtC3jgQla4k6w1YyKMz49j7N2QTkvb1ADSVQlCA9klvJ184kBNBSr2WGwCT5O/aoF+rWkAVhUQ3vF8xYXmz4lyAqbk2krkeM7N6in
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(41320700013)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lCVDj+RFAJlIoj0n1Qe9zKj3O3Y0FBW1i6yCcU4RsQ1APxCxoZWyLvbs6Qb5?=
 =?us-ascii?Q?qcLIemMyxsuexd9z3rGhCdCmF7BVwe86D0R1r7nNEodhk+ZDpzA7Dn8oIxz6?=
 =?us-ascii?Q?f2zqS7sVlp/JvuOw1oJrBuHyRGJ/F37l2AS3oqruxCHsvfSs9puSBtHvwfrV?=
 =?us-ascii?Q?U9JsUAvGdPKfYGWdieGcT7kHKym/vU5wMXSYXTHaThDzGg0olMbV8wm9dKM8?=
 =?us-ascii?Q?tsfR7wZt7Ylws2QhQmtE+rQ2QtfTs4m2hKLE22Xd9uw6lbfHZTLxTja753x/?=
 =?us-ascii?Q?O97W4olRo8YrS1ri14B5M8Itjo6XlCt7CONrahBq9EsC2WG8PztXMNFwKsGd?=
 =?us-ascii?Q?qqDSTUmGdVzR0OHiRpdG1wkPl9bLg65peilAe//VOKBbR4joX3ukH/ssd9NE?=
 =?us-ascii?Q?omVcynH1BLEHCqTO4ldXwFVdzblEPLW+hDWb9nILI/T8q4+n5R+ahA4ocFdu?=
 =?us-ascii?Q?1J/cEC2NRxzhlNZYw52iKH/Zb2w678mchObuf9QOXEJGnwvRF9pI1SD4iywD?=
 =?us-ascii?Q?B9yyEwMpdaY5+3QhCIcvrOER68sCFEZCjDIfdz6eIbB7bwciJN99vz8hrMcy?=
 =?us-ascii?Q?eijJN1GS8S5bO/iHlMqY+rA/k2QM0FSVkyJ6IQigoq9CSGZ73rJvkPoz2hae?=
 =?us-ascii?Q?vOMEHqgst808u4CmIcVQ7MmUmTTKR1YmLIX56qcA3Weo+qG9LxxuD9IkspZe?=
 =?us-ascii?Q?JOOQ1kNFz84tX3Vm9xF5vZ8R45r2HkGTpE7gdT60M+5udK5rDOAN5jYJCbRX?=
 =?us-ascii?Q?U1tnJnSr2CaxYyap50LxYSnLDCbql037Rlo8+XB5YoXTmkyZYk5LnApFB2Lc?=
 =?us-ascii?Q?KRTlhAU1MxZapEo+fQHNW4OfB8qsNs6cVoxd+MJQXIH+/6Bnk0bFzCvRQQ8F?=
 =?us-ascii?Q?l1Etoh6uUA4A9kDxPeQBEMddI7YcZhTe24HuoNFHcHMGVRW5hKx5jaLG31h+?=
 =?us-ascii?Q?YrfIYxag8PXnlgWJ67yJDE8HoimPOiybOUQmVyzdsVpnXvyZy9WfsusJVEoc?=
 =?us-ascii?Q?pbiaemkcPt3UGifyU5GNZcp5cjECov1OPdFSEWOFXKk8s0pqmqMnMaxuo2I3?=
 =?us-ascii?Q?zhyMVcSkGgxRhuKWHGMNm5dT1nhTi1Niq1ZeBWYido3ouzwao+HK31dRFXZz?=
 =?us-ascii?Q?nU/9pbgUVcE/sPnmTcVQ6QoVI+Pztd+2G5eklQWRMU3eN+aoO8SHjOJBsx+i?=
 =?us-ascii?Q?Sf19cH7+I+28AJw0Brs3MUd9/IyM8i0EwFcZf9a/dVtI6u0GFtnpNIVVYnoM?=
 =?us-ascii?Q?0AgUZtXgZFbae2BgSwRnan7Zy0nZL9MqWDWg8136GitIOzyxKwHgV3zFR/3Q?=
 =?us-ascii?Q?+8r0t/VGhYxm/oFn5a8+fRBS5anvte6iLDzeES/7OkHzZ/GYYZzAaBLIaBPx?=
 =?us-ascii?Q?znFWeSsqhYzPgxINeSpwTb/5SSA5689yID3bzZUSDRKnjnLpG8ng5pSFSZT0?=
 =?us-ascii?Q?ESvFZdtn63McbV89S5UZrSbEQSSrpKYLjF5RIrjRzGJ0dxDwd0hMSdNdfD38?=
 =?us-ascii?Q?YbeRSgCowFT8u+bLFQsF+QwCcwMkAp3S3rh2B9Jp0UBunLE3xgjTI65mMXgv?=
 =?us-ascii?Q?rP1+xp90GuqJMaUWEo0sQRLZ9Pl253U6hDiPRYCbUunFgrYmhpCsgTXzUhX6?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46112631-fdb0-4f59-40bd-08dcfa4e8a3b
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 08:24:01.5689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jcQnoqYJVHZat72CDyIEVmEaJn1E8MI7gf97J/M3iO2GS4aBJgWyolSA6d6rDWpgV488H4hLTWUHbxktPQ4Dv7z509QWSOl8NLdG/DGuGqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB1107

This patch series fixes the bugs in the dwmac4 drivers:

Patch #1: Fix incorrect _SHIFT and _MASK for MTL_OP_MODE_RTC_* macros.
Patch #2: Fix bit mask off operation for MTL_OP_MODE_*_MASK.
Patch #3: Fix Receive Watchdog Timeout (RWT) interrupt handling.

Changes since v1:
- Updated CC list from get_maintainers.pl.
- Removed Fixes tag.
- Add more description in cover letter.

History:
v1: https://lore.kernel.org/linux-arm-kernel/20241023112005.GN402847@kernel.org/T/

Ley Foon Tan (3):
  net: stmmac: dwmac4: Fix MTL_OP_MODE_RTC mask and shift macros
  net: stmmac: dwmac4: Fix the MTL_OP_MODE_*_MASK operation
  net: stmmac: dwmac4: Receive Watchdog Timeout is not in abnormal
    interrupt summary

 drivers/net/ethernet/stmicro/stmmac/dwmac4.h     | 4 ++--
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c | 4 ++--
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c | 6 ++++--
 3 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.34.1


