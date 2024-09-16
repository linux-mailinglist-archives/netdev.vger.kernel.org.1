Return-Path: <netdev+bounces-128515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E59979F2E
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 12:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881971C220A6
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 10:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1828714EC5B;
	Mon, 16 Sep 2024 10:22:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2114.outbound.protection.partner.outlook.cn [139.219.17.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56AF13DB9F;
	Mon, 16 Sep 2024 10:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726482156; cv=fail; b=C26DtRfw/jUwI7mrxyn3ocBivBjQ/KOCK6uK15yy9gWX5X/iK/mU7d44aN647BgP/01ujOHrbtp/2G3H+mOwIoC+sjLTvfMzthMPu6j3sCxJ/BXmQrqDCTo3II8CDd9mLZdaFE0KahPNGoa3iVQMZn+bfHIw5LiUdAmPXaox3qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726482156; c=relaxed/simple;
	bh=CElQV9Ih36pb2VQwMtg0wqN4+b3sc7xor/TKezH8NMo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mOxn0k329MmG4qPlBiny9GwJbvUhgoVlEEvm9dWTmgPCubJeke7tbdG2HwRi8y+3sKuHS98/Vb2SbaAveb+Iw/YToLGomD69AAeX8LTob45SSX8OfWpzqvFEikBkvkZUxaomipdl4l13RS0UuhMO6bIH/da29+yla7xHMbrXFjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dne6s/EqQfI8YOHw1j0f43fBeC1hTxV054AIGn0jsp21t68ELI4c8yJsw0GB7PxLsR2t6SLKQ3F70zxSLgD7dSSMLOuC64spfnSbhQpZzgs1IQ8Nood4j+ahBzNY3K/2UliE0IHCHxAd9HYsWQjGd8KwLLSJXeiV93o54jSLCo1AtXDzR4A3irXXzqVk7Zjoid+LmhFNoeyO4j+2b6BozsADEaEuVOwS834Rv+RYItksHxI6baltYNY9eSbE//BytPUnexU6CifCVv92IXHivObwiatc8hSgKcDkBSVyT+mKx55fn017z2GM5AriFeXjlNbwr/HiU4r6ixb70EPTHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GT59sCN5tWsnC3d4zLHfMDorsWWyWuyHMtbm2DPVUqQ=;
 b=DhJ5ryHCHcLy20QocQ6sNw+bv4H4nfyGPwdBvy5DgWAqvdkG4f/yB3u+pKX1AkkqRq55xHOIGmlEoZ64PFB78v4yiX6fRrqjTIJpK0gKng9VUe9pM2DpXXXX3ThTCazZehpGSrD5jD2R+9LO8xDslQb2LKzCSGqzIacsT4TAmA/agj/rdWe9zdKnc5pnl9RrN9jaKBRRhKpp0Stt8tsx2qDLTbQ4NX4Unr4UUu5R19QTqSKE74gJB81+vEjWQIGzSm31sXRdbYNPgcVu7iHFxQSso7cGNqzQM2pdVdMwkB5qfwvwtiFK+dCRz+wpUBT/CyIkO4jEdSJvkkxBO2fiuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0814.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:24::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.22; Mon, 16 Sep
 2024 09:48:19 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%6])
 with mapi id 15.20.7962.022; Mon, 16 Sep 2024 09:48:18 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v1] stmmac: mmc: dwmac4: Add ip payload error statistics
Date: Mon, 16 Sep 2024 17:48:12 +0800
Message-Id: <20240916094812.29804-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0019.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::28) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0814:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e13c74-7794-41cb-1176-08dcd634b14a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|41320700013|366016|1800799024|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	dDB53/qyRtRg9J1NevibhrRQa3CpZyY58jIUuDLfGjeiR8rQMSbO/H4Fi09py49P//IsDSYdDktwOH5Tt8KK/HSaUghlt3tdApFS5dtel7T6ME8llZ3JDiY68sGr3fHX3yzaL1E5gTVcLI9X/OyIIWV8UtbN56GjvYlUBzBnBLNDjgZ5LaZsWeN1tEEP7L6IMwhA3Ewi6le1f9L7fgyg+HBDXOwmei7Ejk8BGVDPI1UQ1IrOW7HbCp8Cf95qDAUCoEdUceRDdnWowMWzWErPWWbW6NN7rhRdetxdD0+rwvLlgJ6xKbNGTgkAVhBTsChjUX7s6zJh/CMGzZIJv7pP6prNFKvjfJ/XC3cWTxXjd6cf55yQW8N3sjslVO8MTcXxfh4qpZJyYLHcVYWIYe4vD8OYwzR1kUUB7lFKDfT17Csi93AEqETE0NH2hnLXnCmtO62dOaaBro5e5G7xakPq0NFWwmz8xspVao1KpC2/0l2tNZAXNfOJzuNT0zmB3cfWaC8DZ7ZXWvcDVC7qJXTA22UDvMf1clKv3UtZLOBq5NFjv7CDcd+gmmgJoK/B1rI7QlwrWHqJ2XSaRgvuc6qvt/usdxphKWg5489UadmJdzqQBGm078LSiLZRl3w1ZqTn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(366016)(1800799024)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n+1dkvMkZEi6P8elUNPfWEupiIN3/oX2b4x1Hxp+VZ8W0W8tebgyUW1V8oOD?=
 =?us-ascii?Q?2SWmXSytixa4CHbZ2NNfnUKyikkJ0fYOqGoWLDW8Zv1bYwF0f4Q5j65BSVyr?=
 =?us-ascii?Q?vvkc5KTU0MD4PQDLiiKzO6dRoFTHsZaN+XpMpjNUYxr7BKeoo/yi/llLWCS6?=
 =?us-ascii?Q?gJDWbFplvS1pLVU9oA7et1uMbfI9LSetfRntSP8pqYZNqFzmT5H29tUHrNE0?=
 =?us-ascii?Q?MdKF/mJLxku2uA2dQ5KiYPd/GoWSz/0Zg//ne2Lo6itH6o/WZPWZrmjZvogX?=
 =?us-ascii?Q?cUtrOXfsXEPrubSBA0RLufOVh7qcZgspjXhcITq/0OV9hMpsmnQcX68Dl4Bu?=
 =?us-ascii?Q?lWF76yrJLcKAZSDLqValmIACVsum89Fz83dvX4zLutkHzgypW8EsLE4WfVLP?=
 =?us-ascii?Q?R2NPS234S+cL/WhIidB0l7RT7BMZq85rD/bj9cysPj4tF6kncgFqVqXNwi65?=
 =?us-ascii?Q?4U0Ny5OCjVyxLL5kfwaDBUJ8gdIDcNa2fMfRA4hBPukANmMt5LyAi75RhDDR?=
 =?us-ascii?Q?/3Tq2qqtzpfBy+Yz1ZB9VbVRQO/PomgpLImFgSOVhrJilLFReZ8uqIkqiXDA?=
 =?us-ascii?Q?uYY4z0t473AzYbff+HRmL6vvY175Jk3l45djCBM9VezuL66sBWxR0QeUvDjK?=
 =?us-ascii?Q?CUPgDFY7kbt2yb6DjepxpHWMaXEokMgDUmHDwnea5Wf4BIEwq9a4wFoGKcPr?=
 =?us-ascii?Q?It7PHNuCzgOVccXxXscJbTlekS2ijC898Zg1qA1HCbbxjpYzt88XX8xeJde4?=
 =?us-ascii?Q?8YcvxvoaFKBS5Sv+Hi4ZgaSZSR2+G/0KAo4Da7jC08ET2CivB42e6YQSXSRK?=
 =?us-ascii?Q?JtAGgxDVYTDVk4FOMbrIzg4QBYcD4IeMmEWMqQUOtglCOcIQZHz3NzZXqicz?=
 =?us-ascii?Q?UJxG40Wm4G7VIN08fZBuCul4Qgse/3Zv93m40JTIlcnC7ynsoLem/Z1wsstw?=
 =?us-ascii?Q?1vAztOgxIWa/isVoNNNaeHkxXthFB47o/+T7GE5k9G8uxTospwdSVvPCrgf6?=
 =?us-ascii?Q?7b1uSqZ9Onr2sg2s8/RC00HQhtNyT1vgpSssL8RSfFCHNgg6gxSCqewXF4KJ?=
 =?us-ascii?Q?clZuy4EQ4Ou1NuPD+smat68djtCIe0IEfwTwS+5K72u75OuHrsM8efESVbVE?=
 =?us-ascii?Q?0QRLAzUq6PjRTGl56UgYptawnOWEw2VNbucAJuFedmiemUW2a7+pWCzNDn5q?=
 =?us-ascii?Q?2UwFnF6bTmpA+fPPMRJ7NmHdj2ZJhw21XkTHsnOl4l+9LCyADVbj3lAIe379?=
 =?us-ascii?Q?dJddVaf3uRWAt2DUMoxbV5JzfTKlc0o41LgY5emcznJlsMEnUVI2lcpksi+e?=
 =?us-ascii?Q?FeQhkf0pwvJg/8nlT2zrcXF58t5lKdFgc06xvcEw6MGJdUz4N5bOidY3LCwQ?=
 =?us-ascii?Q?kVLh0608cEDmgyyID8GqAD02nGfjpdIGrXrskhH4ou+oBOrDgyVPIc6DHqQL?=
 =?us-ascii?Q?38k985FPyetoHRfMimkEHNGzK+Ve1hTss07/64HNQ7XZHAC+AFGNroUbm9Il?=
 =?us-ascii?Q?Sn3jOuoj04co/3jMVTQU8d3VU0xrzDG+TumEb5NtnUgEAJs7DHb5TeV7JLu0?=
 =?us-ascii?Q?gXvziCeu2tljZVvw21x1t9n5dGjFKKw8/kUKo86Hf0t7QZFi4Z4EKIk3CpMA?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e13c74-7794-41cb-1176-08dcd634b14a
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 09:48:18.8017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJhRW/HDJkCW+wSPrf2lVPpqvWyPzlzCAlpoOsc1dmuc/aOR6p53Pk4CPLo1E7NzG8Gor+r0tayfa41v97XH4adeXDBzUL+zo7L0bqtO1NQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0814

Add dwmac4 ip payload error statistics, and rename discripter bit macro
because latest version descriptor IPCE bit claims include ip checksum
error and l4 segment length error.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c | 2 ++
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
index 1c5802e0d7f4..14d9ad146241 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
@@ -118,6 +118,8 @@ static int dwmac4_wrback_get_rx_status(struct stmmac_extra_stats *x,
 		x->ipv4_pkt_rcvd++;
 	if (rdes1 & RDES1_IPV6_HEADER)
 		x->ipv6_pkt_rcvd++;
+	if (rdes1 & RDES1_IP_PAYLOAD_ERROR)
+		x->ip_payload_err++;
 
 	if (message_type == RDES_EXT_NO_PTP)
 		x->no_ptp_rx_msg_type_ext++;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.h
index 6da070ccd737..1ce6f43d545a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.h
@@ -95,7 +95,7 @@
 #define RDES1_IPV4_HEADER		BIT(4)
 #define RDES1_IPV6_HEADER		BIT(5)
 #define RDES1_IP_CSUM_BYPASSED		BIT(6)
-#define RDES1_IP_CSUM_ERROR		BIT(7)
+#define RDES1_IP_PAYLOAD_ERROR		BIT(7)
 #define RDES1_PTP_MSG_TYPE_MASK		GENMASK(11, 8)
 #define RDES1_PTP_PACKET_TYPE		BIT(12)
 #define RDES1_PTP_VER			BIT(13)
-- 
2.17.1


