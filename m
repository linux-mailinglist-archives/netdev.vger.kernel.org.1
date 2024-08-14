Return-Path: <netdev+bounces-118401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3563951797
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 11:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03C2D1C22B36
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 09:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98916143C5F;
	Wed, 14 Aug 2024 09:25:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2131.outbound.protection.partner.outlook.cn [139.219.146.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8191113A418;
	Wed, 14 Aug 2024 09:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723627507; cv=fail; b=uWY2KvnN2pVo3Gd/CQWUMwzLiLIiYnt1sabfsm1zYYazFeoPUxi2/2Tm6lsxEATd65f8wnhBlW45lDYANPsQNBMEfisZD+b9pTdMPGy2KdaykacP0ZLKBh08giIlsmGGv31MNJGAgjPIn4y34F860R6Cy/jjeUNgbfkROQtgdpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723627507; c=relaxed/simple;
	bh=6frO/9Cu4tzElbiBuIxz2yfIZdCuZJh4N+U+TOd+3Ek=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ww/dmOw6OAKvdD+VXnNicm4N0Dzyfuc0xFfNy4aVoJTOZr8ULwJuaH5ohIL86FYGTL/t61xi/IZh8q4ow/A0MRrzQn9orvj3at2muwnP49v2S34fiAUWD75uQsqUxFZ8igDC9KUqYuABtFut6DedBi+gvYU06whn0NS993jXeR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGW4D59Dr9mn5gCS0aR6RA3CndX4g1TKCO9Q9i6rALNVEF3sGcJ7Y+R323qLQHDVN2jyrb3koNo7YmeBbkHgw6GvUzi8TtIstyybM+WT0P6USb4gIxhYpM6Tr0KngmdVIcPyPSvz6dz1v3rU1QDqInHerAxSFSq3ro277/vgYWMH4yLzLRqOmV3urEHRXO3er1HkuG1j68rLsUws4Fr9k3qZS/k5/WPIwEnXQ1gl8Hudn0/E+W+uT7MIwsQrGOxLOtV0V9K/ZmiZ+5HvXq36vx18w6a19+19d9u+2ZKzWBz+2ILeJkyuY8l5riafqP9UGb0rnSHWmQyRQVflIRGfuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsZbYbN0YASxOOKRngI8P7kPMXYDojNGWyytj3iHm+0=;
 b=R0WFdOq5TBl1EL0/6mM5jDdly5dYRhuk/h3RAafmzdysFNDZuS5qklaZgoav/3uhCnYBezDe8mBEyGMtFhW3cTRLtOw54yBTjUUTND27jshBx/2B0yI6vITPg0ScYLOxmrrUOPZcN+8O8bS77SertZ7YMnDickcckReNdcU0f9NCkw/tNbNZX6Tw040i52WWs6lx/1TGIrrRe7STG14dCe1MHeTzATYxwiUXzpZa/MbgUPFc8UdY13a5svYSVN/85/NVZqajkOyBsdeiV9UmGDErIfFc6YRb2hJU8Q32N3FRlXhOfNZ6IcmEbHWnLHNGpW7QtwDAY3jdcz2vrd/jbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::7) by NTZPR01MB1083.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.28; Wed, 14 Aug
 2024 09:24:52 +0000
Received: from NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 ([fe80::e1c4:5bb3:adc:97f5]) by NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 ([fe80::e1c4:5bb3:adc:97f5%4]) with mapi id 15.20.7828.023; Wed, 14 Aug 2024
 09:24:52 +0000
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
Subject: [net-next,v1,1/1] net: stmmac: Introduce set_rx_ic() for enabling RX interrupt-on-completion
Date: Wed, 14 Aug 2024 17:24:38 +0800
Message-Id: <20240814092438.3129-1-ende.tan@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0063.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::30) To NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NTZPR01MB1018:EE_|NTZPR01MB1083:EE_
X-MS-Office365-Filtering-Correlation-Id: 4431ca2f-0a72-4e27-1b7a-08dcbc42f3a8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|41320700013|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	9jH0JSJm8hk8+yfue0ff5ZjR/ZqHlvD7KmHfz1qlmjojy6DCZK8VuPXrlfWf0ac5okIWCVsjxnSFL6Qnst+5YYX//PYsLhDmt5i5TFX/b7ok3H4t903YB5e3NOpXvvpWxU0k3UYDafAtg9fLfqcwSDGEMfcAAx2pf2jA/koPfQifQjK0wlAOPOaC9CxEmhei2BY7soOSMeD15YMeqlimRhx4G4w1Yf1zPIKHMOs0OxOW+tqmJdUCPSqN0Z33yuXTaT2jsa4HutlqeLXUa5E4xBUh879nUj1sIskai+Ut4CLqfbxVI2QvRRr3lpUYi6CD633vqZkTxThq1ir/UJiSo5jKPzXNhVWINlTrG+PB6tCd0qYdPg3xMUvmSqJXZWj+5jSKCJwe9ylKSU0iroM633ZKjxr8OsLovgFOoV0Mo9ZTd3fz1rt3Q+hWPTvao8+sbauqnhh/U7Nf0UF4bgeRs6Gmd3HHEg8NHX3BFyqMXSVtomOw95MRniv5U3OzgzLsalFzg8XLDFwcuc4on6y90JxzsdEG76GnPgVGduUX2BMaxEOhZCqa58EulM4s85wfYpSfd1EvPcsOXhGLVNwli+b+Rs0f36leFB9DyfadsSUhObrXYGCWNhbrDIpZm1UR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(41320700013)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1synvCw+izimBSC98//uM5h6lq2XYPELJnF3iXbq9Ofy2VfCD4/BT7oFJJpC?=
 =?us-ascii?Q?Uc9tbxjuB5VA97t+2eqywX722UaSjUUPH7hXBNUgMwnV6HBnQVV5UBVYyjWB?=
 =?us-ascii?Q?asPMSFoQcY+JKqOrpfvEz+14ExU9kaI1uHvkN9iCXsdHt7EQv0868lpfw645?=
 =?us-ascii?Q?yb5Zt5QQnD7hEGgDvLcNg+ItJtIuGJ136zSmeXDSKBeatuzX15ZBeu47N5Gx?=
 =?us-ascii?Q?tXVZmjyiur+BxVce6peOMwykrLZ37hBEdD2kmjt4D1aPUP/p+wTOvFgQWyMY?=
 =?us-ascii?Q?CEKMUSQoCERA8W/W69l5/4LRnUPPylYAp8y5l8LvK7cKQJn4BMKCBodn+vzF?=
 =?us-ascii?Q?eolyexJHivYCW1D8CIAZCGdUiXeWlw7jc3QQ0UhZPVzOLVjdfWCNElXxdT4o?=
 =?us-ascii?Q?h+vvnTd4TiMl63ewU07/USgBW0ktdiQhbzK4jZ2LFm6LiWimFwC5UA0g/pDf?=
 =?us-ascii?Q?QrW+AzG86G0A4pagY3555BCH0PTAzgVRyzjpdL37FffFYQsV8hajfxKh+p7z?=
 =?us-ascii?Q?PDhTUgA3RWZsd480+GqDWOc/vROrsIhJuSAbuYN2aG9bkwrXOnq85UitilGN?=
 =?us-ascii?Q?I/OmKJfSOvHjoSDx9W6jqIzJqJuRmK/UOVZ8hXDgt8HxVrsTAMPf7mbt2rug?=
 =?us-ascii?Q?8ZBJ1H3fmpWgi2DjB+llKwhOFPWVhTS1Jf99b8Bl8q0nLQ6NjNNcPf4cgH6I?=
 =?us-ascii?Q?HuE9XR5ztu2BU6kwM+06yIWVW1aT94hX6haOe+dRRlB8lYOaPP5U2yyhDLSw?=
 =?us-ascii?Q?X73jQhV3rjQCces8adxGzm7+PpBD31TLfB4C+jocufxN4M2QbPe0/oPMNEwH?=
 =?us-ascii?Q?qIDmgHnaXlok/9lt+hrnqDohuhpJMqDtVNH7HKd8fa19yzM/VKsTznn9Xsu7?=
 =?us-ascii?Q?fm+BYN0D5JOLs1MvvrH+EXfm8+II16lMgpZooF0DvJtA160rjfTemv/3tM1J?=
 =?us-ascii?Q?GJRqbUih9OA3utXa3hsRXLoH/kdK8BV25gBEx9DuzNBh6d2um4iZ4xfs0dSD?=
 =?us-ascii?Q?MEGc39bEtj9luf/gv3FBkpGifA4lLQK7JkRKrQZU28H0SoxKRXq1IA6dxmcq?=
 =?us-ascii?Q?XcJQ2MWEk6VNwb1Zo2D2962DxiW3++8WUH/7+Gg1ec16rS80JwMh1wbljdfp?=
 =?us-ascii?Q?imKG+lrqchW3vzLRLGdxLv2gzgPR6GyAbvXMd5NBlr8PBfcvx31plr1oTZLt?=
 =?us-ascii?Q?xY+Fbuc9FrPE7aXfU2kRPV/r7r2hEvZhcbAu/6TI3QVjxU/fCGKFGoKvgfPA?=
 =?us-ascii?Q?VdMvPB4BDmEB6CsIswArYZANP96EnoG7eNXj3xs6GoXsUiK4j7dkYtIjRIgZ?=
 =?us-ascii?Q?nH/JyZN4OsOQ1+YH8RYfbBe+oXRD66nncDeTha2rUIFvNeXukGXmzbeLFuSV?=
 =?us-ascii?Q?Io/RSte+JjGCxvhSiNIbX60twBQbZTHWgI36QUj39MTD5jlve6Zb9Wl2f9SA?=
 =?us-ascii?Q?MxbjqmGjsFMfA3CFWFrK6Zgs9xaHbYsODx+sAWm2iv3kbP7e4mYBi9zzF9lj?=
 =?us-ascii?Q?Ze0CV7kWjNLXaXaEEkZ9/Qou71it2+ijAyNGulPbRSg1o6DQaEU4qoVjIKbn?=
 =?us-ascii?Q?lQUM/dIs1nK8GbomNuHC4M2m/Yf4hI/ZyI3k+U0J7O2UriNQU0St3pCJQaCt?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4431ca2f-0a72-4e27-1b7a-08dcbc42f3a8
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 09:24:52.2834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WA3xiOVCI9lJF/S4v9xEEaO1fokViaB1xDTQLk0op7V1boAKytugai87vZQKIZ/p9dCiDZZ5TyBrGiZtBwt3HVxWSxgeTYjn6xq2n0fDtFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1083

From: Tan En De <ende.tan@starfivetech.com>

Currently, some set_rx_owner() callbacks set interrupt-on-completion bit
in addition to OWN bit, without inserting a dma_wmb() barrier. This
might cause missed interrupt if the DMA sees the OWN bit before the
interrupt-on-completion bit is set.

Thus, let's introduce set_rx_ic() for enabling interrupt-on-completion,
and call it before dma_wmb() and set_rx_owner() in the main driver,
ensuring proper ordering and preventing missed interrupt.

Signed-off-by: Tan En De <ende.tan@starfivetech.com>
---
v1:
- Generalized my previous patch to fix not only dwmac4.
- Link to my previous patch:
  Set OWN bit last in dwmac4_set_rx_owner()
  https://patchwork.kernel.org/project/netdevbpf/patch/20240809144229.1370-1-ende.tan@starfivetech.com/
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c | 14 +++++++++++---
 .../net/ethernet/stmicro/stmmac/dwxgmac2_descs.c   | 14 ++++++++++----
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c     |  2 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |  6 +++++-
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c    |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  6 ++++--
 6 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
index 1c5802e0d7f4..e9f95ca88e34 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
@@ -184,14 +184,19 @@ static void dwmac4_set_tx_owner(struct dma_desc *p)
 	p->des3 |= cpu_to_le32(TDES3_OWN);
 }
 
-static void dwmac4_set_rx_owner(struct dma_desc *p, int disable_rx_ic)
+static void dwmac4_set_rx_ic(struct dma_desc *p, int disable_rx_ic)
 {
-	p->des3 |= cpu_to_le32(RDES3_OWN | RDES3_BUFFER1_VALID_ADDR);
+	p->des3 |= cpu_to_le32(RDES3_BUFFER1_VALID_ADDR);
 
 	if (!disable_rx_ic)
 		p->des3 |= cpu_to_le32(RDES3_INT_ON_COMPLETION_EN);
 }
 
+static void dwmac4_set_rx_owner(struct dma_desc *p)
+{
+	p->des3 |= cpu_to_le32(RDES3_OWN);
+}
+
 static int dwmac4_get_tx_ls(struct dma_desc *p)
 {
 	return (le32_to_cpu(p->des3) & TDES3_LAST_DESCRIPTOR)
@@ -304,7 +309,9 @@ static int dwmac4_wrback_get_rx_timestamp_status(void *desc, void *next_desc,
 static void dwmac4_rd_init_rx_desc(struct dma_desc *p, int disable_rx_ic,
 				   int mode, int end, int bfsize)
 {
-	dwmac4_set_rx_owner(p, disable_rx_ic);
+	dwmac4_set_rx_ic(p, disable_rx_ic);
+	dma_wmb();
+	dwmac4_set_rx_owner(p);
 }
 
 static void dwmac4_rd_init_tx_desc(struct dma_desc *p, int mode, int end)
@@ -560,6 +567,7 @@ const struct stmmac_desc_ops dwmac4_desc_ops = {
 	.get_tx_len = dwmac4_rd_get_tx_len,
 	.get_tx_owner = dwmac4_get_tx_owner,
 	.set_tx_owner = dwmac4_set_tx_owner,
+	.set_rx_ic = dwmac4_set_rx_ic,
 	.set_rx_owner = dwmac4_set_rx_owner,
 	.get_tx_ls = dwmac4_get_tx_ls,
 	.get_rx_vlan_tci = dwmac4_wrback_get_rx_vlan_tci,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
index fc82862a612c..73b49d021508 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
@@ -54,14 +54,17 @@ static void dwxgmac2_set_tx_owner(struct dma_desc *p)
 	p->des3 |= cpu_to_le32(XGMAC_TDES3_OWN);
 }
 
-static void dwxgmac2_set_rx_owner(struct dma_desc *p, int disable_rx_ic)
+static void dwxgmac2_set_rx_ic(struct dma_desc *p, int disable_rx_ic)
 {
-	p->des3 |= cpu_to_le32(XGMAC_RDES3_OWN);
-
 	if (!disable_rx_ic)
 		p->des3 |= cpu_to_le32(XGMAC_RDES3_IOC);
 }
 
+static void dwxgmac2_set_rx_owner(struct dma_desc *p)
+{
+	p->des3 |= cpu_to_le32(XGMAC_RDES3_OWN);
+}
+
 static int dwxgmac2_get_tx_ls(struct dma_desc *p)
 {
 	return (le32_to_cpu(p->des3) & XGMAC_RDES3_LD) > 0;
@@ -129,7 +132,9 @@ static int dwxgmac2_get_rx_timestamp_status(void *desc, void *next_desc,
 static void dwxgmac2_init_rx_desc(struct dma_desc *p, int disable_rx_ic,
 				  int mode, int end, int bfsize)
 {
-	dwxgmac2_set_rx_owner(p, disable_rx_ic);
+	dwxgmac2_set_rx_ic(p, disable_rx_ic);
+	dma_wmb();
+	dwxgmac2_set_rx_owner(p);
 }
 
 static void dwxgmac2_init_tx_desc(struct dma_desc *p, int mode, int end)
@@ -347,6 +352,7 @@ const struct stmmac_desc_ops dwxgmac210_desc_ops = {
 	.get_tx_len = dwxgmac2_get_tx_len,
 	.get_tx_owner = dwxgmac2_get_tx_owner,
 	.set_tx_owner = dwxgmac2_set_tx_owner,
+	.set_rx_ic = dwxgmac2_set_rx_ic,
 	.set_rx_owner = dwxgmac2_set_rx_owner,
 	.get_tx_ls = dwxgmac2_get_tx_ls,
 	.get_rx_frame_len = dwxgmac2_get_rx_frame_len,
diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
index 937b7a0466fc..1f0666c43de6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
@@ -287,7 +287,7 @@ static void enh_desc_set_tx_owner(struct dma_desc *p)
 	p->des0 |= cpu_to_le32(ETDES0_OWN);
 }
 
-static void enh_desc_set_rx_owner(struct dma_desc *p, int disable_rx_ic)
+static void enh_desc_set_rx_owner(struct dma_desc *p)
 {
 	p->des0 |= cpu_to_le32(RDES0_OWN);
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index e53c32362774..6f3f8aacb0b3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -66,7 +66,9 @@ struct stmmac_desc_ops {
 	/* Get the buffer size from the descriptor */
 	int (*get_tx_len)(struct dma_desc *p);
 	/* Handle extra events on specific interrupts hw dependent */
-	void (*set_rx_owner)(struct dma_desc *p, int disable_rx_ic);
+	void (*set_rx_ic)(struct dma_desc *p, int disable_rx_ic);
+	/* Set the OWN bit of the RX descriptor */
+	void (*set_rx_owner)(struct dma_desc *p);
 	/* Get the receive frame size */
 	int (*get_rx_frame_len)(struct dma_desc *p, int rx_coe_type);
 	/* Return the reception status looking at the RDES1 */
@@ -129,6 +131,8 @@ struct stmmac_desc_ops {
 	stmmac_do_callback(__priv, desc, tx_status, __args)
 #define stmmac_get_tx_len(__priv, __args...) \
 	stmmac_do_callback(__priv, desc, get_tx_len, __args)
+#define stmmac_set_rx_ic(__priv, __args...) \
+	stmmac_do_void_callback(__priv, desc, set_rx_ic, __args)
 #define stmmac_set_rx_owner(__priv, __args...) \
 	stmmac_do_void_callback(__priv, desc, set_rx_owner, __args)
 #define stmmac_get_rx_frame_len(__priv, __args...) \
diff --git a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
index 68a7cfcb1d8f..10a5f5aaabf1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
@@ -153,7 +153,7 @@ static void ndesc_set_tx_owner(struct dma_desc *p)
 	p->des0 |= cpu_to_le32(TDES0_OWN);
 }
 
-static void ndesc_set_rx_owner(struct dma_desc *p, int disable_rx_ic)
+static void ndesc_set_rx_owner(struct dma_desc *p)
 {
 	p->des0 |= cpu_to_le32(RDES0_OWN);
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f3a1b179aaea..0d065166154a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4847,8 +4847,9 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
 		if (!priv->use_riwt)
 			use_rx_wd = false;
 
+		stmmac_set_rx_ic(priv, p, use_rx_wd);
 		dma_wmb();
-		stmmac_set_rx_owner(priv, p, use_rx_wd);
+		stmmac_set_rx_owner(priv, p);
 
 		entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_rx_size);
 	}
@@ -5204,8 +5205,9 @@ static bool stmmac_rx_refill_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		if (!priv->use_riwt)
 			use_rx_wd = false;
 
+		stmmac_set_rx_ic(priv, rx_desc, use_rx_wd);
 		dma_wmb();
-		stmmac_set_rx_owner(priv, rx_desc, use_rx_wd);
+		stmmac_set_rx_owner(priv, rx_desc);
 
 		entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_rx_size);
 	}
-- 
2.34.1


