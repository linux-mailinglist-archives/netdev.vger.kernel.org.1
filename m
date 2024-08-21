Return-Path: <netdev+bounces-120425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EECB959456
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 08:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DF64283D18
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 06:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BF816A954;
	Wed, 21 Aug 2024 06:03:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2096.outbound.protection.partner.outlook.cn [139.219.17.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414C1168487;
	Wed, 21 Aug 2024 06:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724220212; cv=fail; b=TEbzG43syhUz95YT6wsieRp2yrf5MX+RqPJU28ORMtLahp0uGYLdaClMOiNTyFBlmxaooSpGConTL34UvTy5TLRIbdBwghj2TEia+XGLpLs6ZNK1R73Z+7A2DGoVXY4vkoW/hL1BujlIzmQBLUoTQ2j12ELEeDZzJPKnjK70c7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724220212; c=relaxed/simple;
	bh=IT2RCFZnIXNKX7DddMnXCVTH+XRZJZmR2vWpKixhJFg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kdSzAANwuj83MGpaDPishaCWXmrKp/aKcC9dlASmw8cCJ9alulLcYqYZNaQIEXT8AUpPhPs/V1XeeUDWhiyhUeUZgfwesLugGkm4S671JB1EF4kBeBHjwJ904p9vOvC4j+6Fi0lrMZsCI+sPVyTIhUn5KGrPrz6tHQdkniFHaKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYaBQGEW0XNJku6dRTns2vEk2BNQLFNbU5ZGHUFRpJH1dD8HbnMBqGGTmnZATpVvtwPJe7TmmAKtq8Dudteb5BXMnGYN6tpZz0FBg1FWtrpwHA+9ktywN3bNTx5woNYHwPwvari5nuM1q/WBpYTHqOV4SD03NcVcX6TGdvbPHULmzlwqKPyJ7e67ZvNujHLTQ70YWZraEHAqBJ5Efmh4UYZT44hzFelagddQxW636ekZq6esepvyL+7Djg12eQCXRVql9JzsdgTHljfN/tSqcepLr2e7ls1hIGmuWwGbD8mwoaPuGCFXOlROVKpOyLQ9cXMofoLEhe3I5Mtf9iGx0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9D9QoSNSCch8sMt3vpZR4Q/R6B8e0FF7iRRaZ56bGE=;
 b=fWA7f/OIL7uR702jSZ1f0Hz/Xjndk3KC1L3uBF/7UBWzgSgtMEqF1UELf4VAhlN2BOz88l/hrFUKawVOyoh5L9qS9uP/R/J0KZmTC9et5p7OJa4BJSpCcmau8dwupYiiaXebtgzhPC9HuRqPm8n3MojcmHFo2/KLESOVxDUr15M9PQIXpRDYNW/5MlWSB4I6qbkELeMvWLU2Upm9b5Wqq1kV9hCn62j+pBu4ROI+iRJsrq1tkxABGip947KVQ7NK6n5DL9UGIDdnZ7Yq8Tlm9gVVDfAn+l02D+SMiIoGfc6rkhbvCly/nroMKNfzG6Sl/t/63/2grRmizw2oGh/zPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::7) by NTZPR01MB1097.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Wed, 21 Aug
 2024 06:03:17 +0000
Received: from NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 ([fe80::e1c4:5bb3:adc:97f5]) by NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 ([fe80::e1c4:5bb3:adc:97f5%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 06:03:17 +0000
From: ende.tan@starfivetech.com
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	leyfoon.tan@starfivetech.com,
	minda.chen@starfivetech.com,
	endeneer@gmail.com,
	Tan En De <ende.tan@starfivetech.com>
Subject: [net-next,v2,1/1] net: stmmac: Add dma_wmb() barrier before setting OWN bit in set_rx_owner()
Date: Wed, 21 Aug 2024 14:03:07 +0800
Message-Id: <20240821060307.46350-1-ende.tan@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0002.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::23) To NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NTZPR01MB1018:EE_|NTZPR01MB1097:EE_
X-MS-Office365-Filtering-Correlation-Id: cb7aa6b1-de3b-41b2-80ea-08dcc1a6f379
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|41320700013|366016|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	zt7Xt04coafzbvwTxlKPODIfvKjGObNHfOgwAygSWXClyBCHojP472ZH1h6ej84LFYyGnGxOoWXQFnG9ZxzoV3PSopURxyeVylPfowgfChfMWcrmH73qllsp/My5Jgtp0r4PkHK032G+oye6/yJS9NvJNIIN1GUkRMXCljF4X4TQmsTOk/vE8iQMN7Uxv1gpJ8T76vhyoWGnaP5rLEWYJYAgHlbn3c1bo8SSIJLetZqNtExcWB/7eANpF6ZKe9Y/cCVLydIpIIU5ZNnlDGCVtjj4252W0Ho+XyEQAlgwBfAtO50BAnfLMoy0hKi3U2nXPeZKqpI22GA/K8WGz21C03c4NuHZ1teTqln1ZrZYb2I/FHk2OQTkEG3aqi14/uG7pWHT4RUcRENME+yq+AbFkkcScdB2FAcziPCqPTQ3oOfEv1eai/ZA+B1XrcnMLe8rXbeSg5HGXiyG16qB10On3iWfXwLeY1kfkqDs9BABnulyVl5PpOQCI3mNj6l9oxyhxXqI/RcQuhou9hKl7YgiMqvMC3rmso6mGQfs6du3s79IJ50lXFTIFFSLJ6FApQyLSSBpAv5a1iMILENOFmUV/Zj7QDycFI4OxMC8G3k86V58jVAUu1SPMaHu4y1Z1ENj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(41320700013)(366016)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J7Lp8ecBF44zEGfyVKNuDPaeqLV46GDQkIjuVQRQL9/r9IBu8OnL5KXRBYu3?=
 =?us-ascii?Q?GZoc4wmIyWRhxVPzjXm+PNqiMZAT+7S77IXwxJs5cAU+QeDrz/VLwArw4K7W?=
 =?us-ascii?Q?Mmuf1fac1Rv/OdJrgC6795KA7PrgbjJ6UFRSdpxomma67OT3EizOevdDz1Hv?=
 =?us-ascii?Q?RzohhsbpEdVVtiMUHvPFb+fDFV2mIw+T+Oagn1sAV4UUusSeEvtFLkRr7+ut?=
 =?us-ascii?Q?tPGMEcpBHcdf+AW0/87JGuPkagExtgo0GJypmxaxu/TInxYPePAcAKPF0nOx?=
 =?us-ascii?Q?FYWTJrBgOUtbPCJALXVETVE15nx36JVB19jEefY7pMPhdJ1yrNuxA5W3j7JH?=
 =?us-ascii?Q?2GufJpWSAEOcUiDqo3vGDNC92Miw73ffORy9GGlasZqY9nZQ0bo87yM3aLMK?=
 =?us-ascii?Q?vFg/jRFqlAB+1fE4w9K+3F5ChYhLWCh9t1hFn6oJpdKzI7URW2IMzpZONnXw?=
 =?us-ascii?Q?l/l2i296RxilNPMpyBwdy5PCou+nTecY4sFdU2H3BztlRFKir7ySlXLZMHdu?=
 =?us-ascii?Q?x/vClKcNv4zBQJ5gSvB+KRHerJXKJrK88DOZ0b04zB1GVaWMiEUFwUmsyRm3?=
 =?us-ascii?Q?LSU3rJJCN7xGQaSlGjmdLnZfjDjZlGeEJCUUyDvGF285f98lU3MVA+gW8a8E?=
 =?us-ascii?Q?fjFoz3KiXdMKfmFvukPVcPc8RZQvRvXhX+pP72rCk2oxGtB4Hn4Kp5SDDzFO?=
 =?us-ascii?Q?RHb734og3C7ThgWFhF1TMqgqTixUrdX9meBpiPFt0KC5X4AKoGbl5wR3cEUO?=
 =?us-ascii?Q?K68MmLiLyjvgxnO7x5w/T7x5SH6EHF8gNz0TgEn2fsyGNvxcyGaVo9st2Dzh?=
 =?us-ascii?Q?lkNmfQ+7cLMG3KQheafTLcyD6nEsVyPERVW3DGqhUSUWi6Ml+kZT2TdqwRMi?=
 =?us-ascii?Q?BVgt9nb0I+UWhjORc+zWFnCF9H9ONH/OwTllqaW0eNPHacn+1RKqdrCbfUOo?=
 =?us-ascii?Q?Xjw8TWIP3IkG8nZJE4xVzS5tyF8AtUQSKqn4Pun0NORY04Yc6V1SEiFZ0I+j?=
 =?us-ascii?Q?zGmdZo4H/TVX/pGslPP4aAuV4YtUy/7A/AV/o56sHpKjF7OTEAr87ypTovtL?=
 =?us-ascii?Q?GWouP5zZG3/ivF1UhhrZjSEqkCzvHt6aFKyeut42doj7sw6lF51fMXlaqQjB?=
 =?us-ascii?Q?GIsF5YIaBsvD4ziCoIodqwzQUlKAOl2iQTnTSYslOMOUoIzVpdfp/5VQoeGA?=
 =?us-ascii?Q?XWMyDGrXH1dvGY2Fa7PeaYlC4d0KixpFLMy0otm3PGHDiad2PO3C1f7j96WI?=
 =?us-ascii?Q?JAGD1QgP/IFsWKJZ5QB+lf/p5RnKBC9nakA1Pe9J3wX5K2qSnXNxmFk81Pz3?=
 =?us-ascii?Q?Hmji9YhW0667ruxS4KLeDm3xgNvHfMlvtT917dlLOAhEPHMDXgBbNl/uYj8l?=
 =?us-ascii?Q?h3DR6zHrrcMPHA9nnGAA2VIy/R2239HT+SBjJNU8renDOv+2W5BVBQMmKWKg?=
 =?us-ascii?Q?tdl3taDu7Y17uyHIwsfxfbrx6JlIWqLWPvq3BHJCZJcNclDsecSwPkS1NF08?=
 =?us-ascii?Q?q2Dq4lQ/uhXF7rgFtFuTnvHqoDUwnNpcPBJ0QLdoOrK/WFg1t1ILe2XHBHjK?=
 =?us-ascii?Q?f8hq1TU8f4K2ZmHes1oChIS/Gf/vK8xY1ZIQc3aG6cCAWitbEi4scBTyP/yh?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7aa6b1-de3b-41b2-80ea-08dcc1a6f379
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 06:03:17.4318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkCX7Oo4q5N0Demc1HMx2lIXvbNQBJw2L9L1ZW1SLqee+wjZgMlsNglhUBCCRYcSJrN9mYDH6jCvydVBxh+Z32xZhDBAqcbDtgZK6bggzmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1097

From: Tan En De <ende.tan@starfivetech.com>

Currently, some set_rx_owner() callbacks set interrupt-on-completion bit
in addition to OWN bit, without inserting a dma_wmb() barrier in
between. This might cause missed interrupt if the DMA sees the OWN bit
before the interrupt-on-completion bit is set.

Thus, this patch adds dma_wmb() barrier right before setting OWN bit in
each of the callbacks. Now that the responsibility of calling dma_wmb()
is delegated to the callbacks, let's simplify main driver code by
removing dma_wmb() before stmmac_set_rx_owner().

Signed-off-by: Tan En De <ende.tan@starfivetech.com>
---
v2:
- Avoid introducing a new function just to set the interrupt-on-completion
  bit, as it is wasteful to do so.
- Delegate the responsibility of calling dma_wmb() from main driver code
  to set_rx_owner() callbacks (i.e. let callbacks to manage the low-level
  ordering/barrier rather than cluttering up the main driver code).
v1:
- https://patchwork.kernel.org/project/netdevbpf/patch/20240814092438.3129-1-ende.tan@starfivetech.com/
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c   | 5 ++++-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c | 5 +++--
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c       | 1 +
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c      | 1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    | 2 --
 5 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
index 1c5802e0d7f4..95aea6ad485b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
@@ -186,10 +186,13 @@ static void dwmac4_set_tx_owner(struct dma_desc *p)
 
 static void dwmac4_set_rx_owner(struct dma_desc *p, int disable_rx_ic)
 {
-	p->des3 |= cpu_to_le32(RDES3_OWN | RDES3_BUFFER1_VALID_ADDR);
+	p->des3 |= cpu_to_le32(RDES3_BUFFER1_VALID_ADDR);
 
 	if (!disable_rx_ic)
 		p->des3 |= cpu_to_le32(RDES3_INT_ON_COMPLETION_EN);
+
+	dma_wmb();
+	p->des3 |= cpu_to_le32(RDES3_OWN);
 }
 
 static int dwmac4_get_tx_ls(struct dma_desc *p)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
index fc82862a612c..d76ae833c840 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
@@ -56,10 +56,11 @@ static void dwxgmac2_set_tx_owner(struct dma_desc *p)
 
 static void dwxgmac2_set_rx_owner(struct dma_desc *p, int disable_rx_ic)
 {
-	p->des3 |= cpu_to_le32(XGMAC_RDES3_OWN);
-
 	if (!disable_rx_ic)
 		p->des3 |= cpu_to_le32(XGMAC_RDES3_IOC);
+
+	dma_wmb();
+	p->des3 |= cpu_to_le32(XGMAC_RDES3_OWN);
 }
 
 static int dwxgmac2_get_tx_ls(struct dma_desc *p)
diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
index 937b7a0466fc..9219fe69ea44 100644
--- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
@@ -289,6 +289,7 @@ static void enh_desc_set_tx_owner(struct dma_desc *p)
 
 static void enh_desc_set_rx_owner(struct dma_desc *p, int disable_rx_ic)
 {
+	dma_wmb();
 	p->des0 |= cpu_to_le32(RDES0_OWN);
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
index 68a7cfcb1d8f..d0b703a3346f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
@@ -155,6 +155,7 @@ static void ndesc_set_tx_owner(struct dma_desc *p)
 
 static void ndesc_set_rx_owner(struct dma_desc *p, int disable_rx_ic)
 {
+	dma_wmb();
 	p->des0 |= cpu_to_le32(RDES0_OWN);
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index d9fca8d1227c..859a2c4c9e5c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4848,7 +4848,6 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
 		if (!priv->use_riwt)
 			use_rx_wd = false;
 
-		dma_wmb();
 		stmmac_set_rx_owner(priv, p, use_rx_wd);
 
 		entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_rx_size);
@@ -5205,7 +5204,6 @@ static bool stmmac_rx_refill_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		if (!priv->use_riwt)
 			use_rx_wd = false;
 
-		dma_wmb();
 		stmmac_set_rx_owner(priv, rx_desc, use_rx_wd);
 
 		entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_rx_size);
-- 
2.34.1


