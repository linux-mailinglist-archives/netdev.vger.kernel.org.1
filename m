Return-Path: <netdev+bounces-140964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5319B8E64
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 11:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B480AB221DF
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 10:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEF619DFA7;
	Fri,  1 Nov 2024 09:57:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2096.outbound.protection.partner.outlook.cn [139.219.146.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531B5199FC9;
	Fri,  1 Nov 2024 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730455076; cv=fail; b=PX+YH9WKG0CHC76RE/f/3Uytl2W3JSwKgOnCZco0at0ejCjRQMMVfI147NnxqoDMYB2wFrbeEWN3j06She8XcYe8yv6fBKIY3LRLwTSkme2aO6LD1azuu5nMglgPBn7cS03fUFteedOFNzmZkOdy9mR4wER2T0vz2Vx3FtawfBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730455076; c=relaxed/simple;
	bh=2NvD15LNkjZuc+hxij3G+HIru5sVuk2IvYTigAQ2uOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NGftUQyuyD9qHucvBH11W463yPgKQhtPFhCVLbfJMRbfzTGH9hwnIfMHgMQPiFFvbSp6QCTBjKOzCkH2ryVxJ14rcEW2Q23jPmkJsv+RHlM86FgB3O2wWWqnVAIsC1J+vIPTaMC8tMiSof/zfa4AeG+2jZ8TlPkqZJ2Wu32D4jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ih+s83I2zICJitjMtc/HRAt++70j4MZE/nqH9KJoDQsYc6lAaNHXuMgiRQZGGSQ7Lu0kJ88f7fyeG2hjI5SrWlsPnUrnFjF9lBh/Wb6HDLAVfLtRYKJ9ti2VOXCP+C5UJIx57LguwdeCcqzqv5ifqQtKN6u09dKUe1HQDfj41/P4HAFXdJOfXX+YF7F7QK26RlxosLhW8XeGgQP4S+IKN0LHHTmP1seDm0HsSQXBw/8BGqNDRo7Fop/whuuRh/eswLhUwapYPXSgWjo2X67eKGKfOD7kzczp70LZ14nAbfq+DjeVrvh52YuakvVgoG2uR/ZL7O09Ul+qSNA9D1+Fqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4OJP3dG+b6jMtZirVxAkm3476iD1/vHph0fe7hIxNE=;
 b=bSzT8fbWL4TmxQPmN5JLDMXfv0HD6ETw+3GbMtlBBwldrZvg62Ky1KB46Prb94dDWCAiu+envqU0bID1zWMI4au/qdzkfOl+mJ5N9inaACVn4QAmpoxYyuAAKH9oGsI2mLkOeWXGjtC8Au8GYvbv+VM8r1pTy1HGIZs7jpZ6wEB1wA8rvTqjHPR1pj27lpNMVKqUuZRR8hDsmeIt87meAfnthCc37fgsPdjDnsdoWGlLMrKyYRbIK3PjrjLh486fCwjP1brOse/6VFXoz3KSwEfl5tOcv754IWnZgYRzMZHWqVPskj0KlNnCGuHpg3P4FWp1uhNy6aLDFJJjXbahUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12) by ZQZPR01MB1107.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Fri, 1 Nov
 2024 08:24:04 +0000
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 ([fe80::617c:34a2:c5bf:8095]) by
 ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn ([fe80::617c:34a2:c5bf:8095%4])
 with mapi id 15.20.8069.016; Fri, 1 Nov 2024 08:24:04 +0000
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
Subject: [net-next v2 1/3] net: stmmac: dwmac4: Fix MTL_OP_MODE_RTC mask and shift macros
Date: Fri,  1 Nov 2024 16:23:34 +0800
Message-ID: <20241101082336.1552084-2-leyfoon.tan@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 62a34ed3-a266-4c8c-d4c3-08dcfa4e8ba2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|41320700013|38350700014;
X-Microsoft-Antispam-Message-Info:
	GRG4iQHE1R7vsdiUBqeW/0IP2SX9LxilKEIRaucZV9PxgFdQGYS9c5sAYZgbuqTDlufrM0SRD4GQPPJAVBzkrNGSP7pfRkamH4BE1zgas6Jd/2DlyVC1pq5JnEjFzvcVSt9/5rIV9rxNCcelYeKy/YuHp5pypb9FdFCYlRhUTSV4prhDIppvcsIOw+n+aNivEghjiRH42EwGPIz73K5PakdBF54nLG4pw4Whofe4oe9GtSI4klvX4NLmk+x7WwtgEnzOEcfqEKBNaur5ycd7b/OVi2JNId3gI0KUfC8xf3qrQhnx2ORcjKr1DAIdllXOqrsruBmE5f90vQZHHpv94dZtARXL1bJ13sis6ezsBJOoIMsaFukZXlY2aRGqtYDGhcP3jrYja0izVcktmhOvvfgpFaHPg/1DG4Et/RqQuDHzMxmIQTJoLOSKaJ2Adx8NC5Pi9eXbDhvFbslJOqSJUyOW7JVoViADv3xI3DUcPpa7fHyWgZuKgWbGZaCSmoo9NH/jr2SX94hC1HLtT16vEK+uc7ZCT5P/3Aj2LN/Bm6Cu9DolQZ/CCXnklKXPhg0EVorkCBFBVrMIqMAmGXITx/5xoTKvLHLQuxHNviwijiJX+mQoPwaQN4YNyMBcWKMj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(41320700013)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OK1t4ju2az1svnSksEF0BX/gGuneBXTiRazlhlLES7qm1LsB3j4WEn294p08?=
 =?us-ascii?Q?qCBAsyLBTVfAwYJt+HS0eJ5Tv9y3GChwopstwJRgUZUNiQLQjbSLwQ6C8C77?=
 =?us-ascii?Q?hJZq6QafY/KT6PRNMuunzJHIJfFOhHDqH7DpOf//iGeJPvlvWgbMHLv8SK/4?=
 =?us-ascii?Q?rXevej4PsfrD78GKTxRdez3hCZPct12v2ggIt9+pWCzkfg7EAltuU3Mv2c/J?=
 =?us-ascii?Q?E0DFWev0vJYpWbAC/Q1AEt8g/qGPAvyfwGr92rBIror7ZkYKreg4ZS06mEUz?=
 =?us-ascii?Q?RjIxY7ZHGFHC6qnQOfhOns9c16kAJYz1fiqvLjoYNcF6AWaOq93Ew2usD+Jh?=
 =?us-ascii?Q?lYk3jaIIIz9W7dy4Yy9nnuSryb57bSeNFmE/9DMLuod34on8IWk8fF9uSTV/?=
 =?us-ascii?Q?QAqri0AA8SYRjujHAlCuGln5jYC1QjCJbEvX7xwEgLtgE4s8sUH2JJK1YDhD?=
 =?us-ascii?Q?nv7knHpy0RhJEjoAGyk3zTV7w6ECUERaBB2w60tHKHBYf2p1qRm6c9mBcRS+?=
 =?us-ascii?Q?bpnIWFOQAkh7KNHFeIm312FMeo/NYNQMRlVSM9O5hSSFj4cBP87I3WFUOWlG?=
 =?us-ascii?Q?R3sIeSgxeSP6MO0ClC0MOR6zjZ8Crv0HwDwkQlc+0wli1NxG26Vqr3CGP7yD?=
 =?us-ascii?Q?S+tlUDvtrYNLJ/YzjtIAL2vgdW1K7Kc4BsYfaVyFNUh9t3Jsnww/AkAdotpL?=
 =?us-ascii?Q?21KCHs50JMyGoy+AA6K53LiWp7YcW2eTRxWTIoMKPt1tqseUV62jMmFQG+m2?=
 =?us-ascii?Q?EGooKUFWTEyN0yr9pOB1X5JhpphyjxLcyqcmYcQkuTLuC5ft8Uez654s94/M?=
 =?us-ascii?Q?RwDA/OYBm9kBBamhAMcyFit5efnWmnJxMtZPas5oc/fRHRKvlpggN8YglEcI?=
 =?us-ascii?Q?vmB80O1Wo76PpMPHcMAcDhDJmzocJeb+MkF6zI3Uf8aF2bokQzVNx+kRKdkC?=
 =?us-ascii?Q?sqpQEuW8vE/DS/ctnILuXZ32Gt735O3GnrI/T4h5LFbC9VTKNutub+6Ht9Bq?=
 =?us-ascii?Q?hqvJrhDJXmgLkQz3v99tqAbiZMgdUaCI1Zh9n4JdqOjBVcd0GR62qUE+TujV?=
 =?us-ascii?Q?xf7Ia4BJEG8TRKuKMyqawq/Xrv/+JevwNrT3mfQP1zQ2qYnbpo14TjUdkePj?=
 =?us-ascii?Q?Tmy5LmK1o85Hd3ez4SC1AHpZb1njmc5jEcBOZnRQLDk0HlhSzAsL051QeHJ7?=
 =?us-ascii?Q?fZ/aRnIla6HFsr38jjyadDL63WG/B1aDdjNuee1cYTDjD3XwFYhEITI/vMgL?=
 =?us-ascii?Q?+oa14Rjkgpg7e+GXwRQETWU168lZ85wDFQVXLhy5WcSGXckrq+QsHSmrKFPG?=
 =?us-ascii?Q?TxMEj8WqfTewwkFtVKYkZcpI/Z6Y4IHo5Iq4aCWyJzm3/+DpER5F8CW5aqC9?=
 =?us-ascii?Q?Gi/mECy3bwdlPfErPimtTtpNXdaLkgE6go+XICZNZMdVw5bdmSnqxbrtr6I7?=
 =?us-ascii?Q?1LuH4EGWkqATlXzdlFk+ZKsnY0MchQrS9OPF5UGy5wppdg82B7JsDnYExOQB?=
 =?us-ascii?Q?3ThNpLckkBbwFTcx+nS4dlaj/HmQiayE5n1it4ZYMk6FltYMp3kEhggAETg1?=
 =?us-ascii?Q?ZhHcTyRUuRIzUGvfUQ/483jr+auFK2wNRCadffsolC7+yrYPvR9D6ugxQSc2?=
 =?us-ascii?Q?exZbw4tEh3V5KfFm4wHQPTE=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a34ed3-a266-4c8c-d4c3-08dcfa4e8ba2
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 08:24:03.8803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hFhLD9lsl4h5hBRIXTtvRp2lXwXfieQekIsK6tqwmibz+H6FEb3jks76hW/LdsyG7ClINrQjOuIe5HAH04M+chOuiChhxxoecvT9wmzWto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB1107

RTC fields are located in bits [1:0]. Correct the _MASK and _SHIFT
macros to use the appropriate mask and shift.

Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
index 28fff6cab812..dd21dcfbbab3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
@@ -394,8 +394,8 @@ static inline u32 mtl_chanx_base_addr(const struct dwmac4_addrs *addrs,
 
 #define MTL_OP_MODE_EHFC		BIT(7)
 
-#define MTL_OP_MODE_RTC_MASK		0x18
-#define MTL_OP_MODE_RTC_SHIFT		3
+#define MTL_OP_MODE_RTC_MASK		GENMASK(1, 0)
+#define MTL_OP_MODE_RTC_SHIFT		0
 
 #define MTL_OP_MODE_RTC_32		(1 << MTL_OP_MODE_RTC_SHIFT)
 #define MTL_OP_MODE_RTC_64		0
-- 
2.34.1


