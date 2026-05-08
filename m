Return-Path: <netdev+bounces-285631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEywE85y/WlzeQAAu9opvQ
	(envelope-from <netdev+bounces-285631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:21:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA2B4F1E30
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42BFB30329B9
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 05:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626F233B95A;
	Fri,  8 May 2026 05:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="w1p5LVbi"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011027.outbound.protection.outlook.com [52.101.62.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2B133BBC6;
	Fri,  8 May 2026 05:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778217591; cv=fail; b=ovI4witVOalyFVPR+WBcSc12umjsKrE+VoQE0Pkly9iOx5BlhWwgosBzEgV3qWBsLi1aXWj7gbT90m+RBGVdR+VWOFSDXOM84hstUDIsuQD8B06Jch+7rsrodDlu9JjRZ44NzgmMOibXbR60nph3/pX0b9oUHehO8S+Bjcye6o0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778217591; c=relaxed/simple;
	bh=/UMPbEIBNA8DFAFRx4Ul/Z3g1J5hzDrzEe3/D0jz1yw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Y3/jO8MpG0cy+jWVOkexkgUJ5UpxMOfLie5VfXg5RcOpYCOKibp+80W32bowtGlSXWtxUr6GXoNBcpxwtiNjAYQdr5eFDonHKwU28VlIaiO6x7PgLuLIvFgD+dbF9ZP4eMJ1LsRXo794fDdv7wz8fhG+dPBkrthpS/Tv0+IKPhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=w1p5LVbi; arc=fail smtp.client-ip=52.101.62.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mB+qyDW3SDVCucPjvjsybo7KlMG1nTycBSagiwVKUWaUSYKdJEWtDgq8OI5uTBzXkR4QNcQJLZm8hksWttiqGT5yCoTyn1DhdwcZ5PcjQTgvUu17+Tx+3OJxyL8YG38e/GFZhRLB+oe7Q6/FHTddl2/Gp/p33/W9LpzgQjJV8yBt53x1nuLe1PzWfcjtR9JN+4LZZ+doN/UIP0mJjvLx8fsgEpD4/BzRsrm44gojJZksVZtCCztdMMAN1axzrSj5X4CMSYLZRW6vVtyG7UPiYAzbPsS06iqYuap+v+i5bNYyj10g20S5OJPG6fnPvlkCawBtTuYrZz2fdmiffejRrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymAcWeoSP9uw1ZPdLHbBM5h6Ouqfhnvs+mv4vcSnmag=;
 b=rhXYo/jg7TKpLcOq4CIhUM+y2HlKpyMg2c6md/p4MyYcZYvtzBtevR6rNrAOQoMFrapJI5KXHy9PcMplIR1NdYiSr2RYM/bpSkTS9MP3vV4qdWlGV4GM19k6cbbD4eL+QM72T1srYJ/35TQs1ndLPwKKgbd0OV/H169pfJbiBj3uq1PzwjGt3W+KL8ayHgwjxRyxPVyT06S3dCG8OJPsQZlACtETgqUzxdks00hXtfAfPOqK/mXUjczIs39qyEB8psIBB8PI2O06zA14nZgWoPbXK2gtUsndolHKmz8f5+0QXBfkPL0i+KonBU/QxLJCLGhU3G4syi1W7cLaObKmpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymAcWeoSP9uw1ZPdLHbBM5h6Ouqfhnvs+mv4vcSnmag=;
 b=w1p5LVbiALVHWxvgY6d9mYtVMNzDUf1v2kXgCMnbQthf4L2JCPRfjCb3aDgzJzDbN/XLUgfhXi4MP5SxNjATdXlLFXuDt/3wT+b0P1VFBLKB5Eo8+huxRF9kHhQSM4kcb1XarZfPoZWf09/HxmcUxSKPsXWNULUl6J3Y9rayVO5WiAdtpgAk0U3OBf1OdS7z/2wPaCOBPObCgTD8ZOZd9tl+HTWOfld7KmnNQfgpziJuEhF1M5Y9oH9BY+mKt6bMa/+wdfBZsTJBUHJ48pjMvnEcl1v9ynRgApAj9hKFLM1PorvlEHG/K5NuwIJ+wsNZU8XKuPorUiDfUhYlL56PKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by PH0PR03MB5734.namprd03.prod.outlook.com (2603:10b6:510:41::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 05:19:46 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 05:19:45 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4] net: stmmac: Add support for TX/RX channel interrupt
Date: Thu,  7 May 2026 22:19:43 -0700
Message-ID: <20260508051943.9029-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0350.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::25) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|PH0PR03MB5734:EE_
X-MS-Office365-Filtering-Correlation-Id: b961797b-7d12-483c-3b89-08deacc16a7f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|55112099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bLdvjuUN/T2At7LMUz0/Q9gCbaAoMJ1rv7kckS4MJBRIrzCxVj5qqMtsGV5l9ZIL2regSw2Snui6dy4KKC53/nCIQmC7uV1/IFg+v0lu5Zbrlnpx5lU4c2N8qxrOUNDZ/Ee7sxgwJxdfACvHd46gzT1vMqrjFlcJTIWrHCcyqz4fkP47dGbfbL72H4OowFGue30+WVrlW1H8oV2soWs3jRHbVA/CF+jat88yKuMXafaGn+CMd+XEPD79GCTgvuL8YBRDClwVW3OqhKW0ihDxDTG/sNg9FAOAKWfNPST+WIcboA97wubnPidIS2et1RPxHAOarqwIkRN0nlNJtXlC3PLc5DIbL0Q4tmWAWFdHKdN6JzX9vBv6OdujOf21Y92jsjFIB46WBHAsKgp03itbZGOpoE7p1HOn2ikwF1FpXT0tMMqrK1hZyVOT96ePEYwwiFlOQAQcZwUV5DLqD/R5rWUy7SXaMvNkMl02hJ8hLJgEi5DfWqQjhx+MkqyRtMOhw1Ed4434pAqQ1q5TwypTZ1dJa9yPqZ4tUZnvrbJUUi1tzA9vO08imxpq53jGQnMLQH0OEXB43TKUYuf7XCumkJBTcWy8ZMIMlZrgFK5UexMc9sLy9nAv351QXO7b/eJ9IfKwqmcZ8HmV89seA6WobM+Fv7ky8YpqKdNWFpCVE44Yw65RN88Ay42MVqhO16Tz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3+YtStlpSAYzfXeeZEstuUgOlaJ9DxjrKTI4rYeZv+p2MwpZVGdTql1MUMFk?=
 =?us-ascii?Q?YkkHdko/jOh/yAM//QvsAsJsTa2jEqYup3Q5nEFL66CWuzT+2Z9kF79aeH8K?=
 =?us-ascii?Q?8mfH19k+n76DUFq62LXcQlE4rbisRqrBMxiPBKxDTIHM+doAHyhwl/uiIBnv?=
 =?us-ascii?Q?GfsuN/5SlVwSKstMT3WSA36U5RrJNpPCt+FVwxRj+Azt409qhubsajyxgBSE?=
 =?us-ascii?Q?uHh9tRzL1E49JD29IEcNco2vWBCT2ixGZu/NHY8XAgPLmIOuXiA9xVV5kwez?=
 =?us-ascii?Q?50f1VU23PXzRrjc0TuL2AZ7OMYjgeX7VffrIDH3d+gKeCvM9itBMl9J7OZ9h?=
 =?us-ascii?Q?+tRpp/w/ODICyDmrOSr9b0jmSrZ5N1UO7plTVoTYRnpsFQl0iOIaNeeEEqED?=
 =?us-ascii?Q?11cq9tgN5NAsA6aPkRz2zql+YAPwkSlbITl+O4NCX9ZxrQexakVfcvQZTHXu?=
 =?us-ascii?Q?OWvXejBk/IccG4pOfLbpTZC73dgfshbMq0ZUarY074FNsTiJjPHgUvBW9b6f?=
 =?us-ascii?Q?btkAvrk5kUxuHCQWMGcqtULvzSp8a/f9VSWigiUBrmA36KPBbVkChkISh3ql?=
 =?us-ascii?Q?2UiHLcnbIqtZMGqSm71/5wt8wZxsu+d244U+kzkWasyr1OLKkLttwV18QYEp?=
 =?us-ascii?Q?k5sIdYjYTFcvQR2+yV5vjc8RspO8qKKLlwVA5eETodjRzPmNQt59csSXgj44?=
 =?us-ascii?Q?ZNinhDOmrC3nn3Q+aXDDLZY4rl0S6cv7eVoCsu9xg3tK2/gml/1EKUVlbaIB?=
 =?us-ascii?Q?CafoR0G7uLbOcdXmE9aGXopKk3qiV6ZuGfCAhartBLUdvwHRc1NEsB6r/8mi?=
 =?us-ascii?Q?lEoAOViC8kSevhWKI4pBeDw+aPEGkdh2M8/B6K7TeFlpDIu771vsANbE990h?=
 =?us-ascii?Q?G3B2/aX4ka7yHVxATX2s5+YqPobvXS6sh1cRTxuml6X7dM4UuYxoFnE6BaGX?=
 =?us-ascii?Q?HeRkfxT5cMy8T8eL8oYybQN3nn1nLJ/ZTw6jk65R9qsGPoS5xbnfxTDdOJSd?=
 =?us-ascii?Q?H8e3wru+ozaCBm452aDgdnEre/7OxEfRoiaDtmlCVrKX6vuDdvkg8MmeADR+?=
 =?us-ascii?Q?wnoZBbtQR67mTBgAc/tsx4NQqbrPh9nQD2fQZP4qoUsWKP8O4zqil8m4E8KF?=
 =?us-ascii?Q?z55kM+XvVCwQR6iIxk2eTlNXCMXH/p8WLuhzA4qYTVfkYs22ruBsGV3/dXwj?=
 =?us-ascii?Q?lOMSb2Uv24Rw8aarejH2ElyVmePc/Q0E0bHA0p5cxNUJ0Fxz4GK422n7bcAi?=
 =?us-ascii?Q?os0r3z7QmHhMO2tqgrfxgBLyrprZGFpnvJTjrlrUMR8mOTAjlVtaBpxcafOD?=
 =?us-ascii?Q?y+EpswLE+yGDBT3L86ui4zg38ZYSzjPHgaFWl2TiaCRvTm4Mez1kJ3T4lWid?=
 =?us-ascii?Q?cT2kG4s6T0f0QcTIy70yghQNyutW6hGJkuWijmNsmR8CCKeDtJKUXNoYgapt?=
 =?us-ascii?Q?Q9T8Wo2bODLBYQr9J9iCgZWffK4GRM/vrx/I3O0Nlt0DTppD7nkH/bL6NlsT?=
 =?us-ascii?Q?KNWMnS+yx3QEiljKW98z3diDZ8sjtcDfZGyPyU42iqj2qkN5GEo339PqpjDY?=
 =?us-ascii?Q?lfKeDT2axJazS0M8+NPrFExOftZ1aF72gGhxAAhB/xRkRZFqN9RGfEkCi0BM?=
 =?us-ascii?Q?hQ1UZbIy0DtGm5lXVeyVPdU4GwPapj4/A/RuWpmDnqlTS7bIgV73x+js6m49?=
 =?us-ascii?Q?tJxMk1SM81IOCFsB7kkqF9QzSf8HCOn70aIbvyEIRFhY7fO1wkhwt3FPxPC6?=
 =?us-ascii?Q?92Hcmn6hpCxO8AUhFv+cXt3JmQc/IljZ71jpQdJOz4YoJnsfJ6vSrHalzijB?=
X-MS-Exchange-AntiSpam-MessageData-1: vpNp6Fo44ojWtw==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b961797b-7d12-483c-3b89-08deacc16a7f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:19:45.1788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: II3t97KTEO72uyLc8MS61hJ/ga+WtvFxpEW2FYbKiOodLrmzB1XFf9D7ZKCUpWi6uvwAIcP6B12IM+Pmj3cRhGVKxEsS/mtevKySBCACBXNsjqCdy92UlRduHPEEZ8OYUsRM4fGJitW0hh83X4Mb4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5734
X-Rspamd-Queue-Id: BCA2B4F1E30
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285631-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,altera.com:email,altera.com:mid,altera.com:dkim]
X-Rspamd-Action: no action

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Enable TX/RX channel interrupt registration for MAC that interrupts CPU
through shared peripheral interrupt (SPI).

Per-channel interrupts and interrupt-names are registered as follows,
e.g. 4 TX and 4 RX channels:
interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
interrupt-names = "dma_tx0",
                  "dma_tx1",
                  "dma_tx2",
                  "dma_tx3",
                  "dma_rx0",
                  "dma_rx1",
                  "dma_rx2",
                  "dma_rx3";

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
Changes in v4:
- Rebased and reposted on the net-next tree.

Changes in v3:
- Add net-next tree prefix to subject line.
- Fix variable declarations to follow Reverse Christmas Tree order.

Changes in v2:
- Use -ENXIO to detect when interrupt name is not present,
  and return any other negative error code to the caller.

 .../ethernet/stmicro/stmmac/stmmac_platform.c | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 5cae2aa72906..8f8dc7f08f20 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -732,7 +732,10 @@ static int stmmac_pltfr_get_irq_array(struct platform_device *pdev,
 int stmmac_get_platform_resources(struct platform_device *pdev,
 				  struct stmmac_resources *stmmac_res)
 {
+	char irq_name[9];
 	int ret;
+	int irq;
+	int i;
 
 	memset(stmmac_res, 0, sizeof(*stmmac_res));
 
@@ -767,6 +770,30 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
 		dev_info(&pdev->dev, "IRQ sfty not found\n");
 	}
 
+	/* For RX Channel */
+	for (i = 0; i < MTL_MAX_RX_QUEUES; i++) {
+		snprintf(irq_name, sizeof(irq_name), "dma_rx%i", i);
+		irq = platform_get_irq_byname_optional(pdev, irq_name);
+		if (irq == -ENXIO)
+			break;
+		else if (irq < 0)
+			return irq;
+
+		stmmac_res->rx_irq[i] = irq;
+	}
+
+	/* For TX Channel */
+	for (i = 0; i < MTL_MAX_TX_QUEUES; i++) {
+		snprintf(irq_name, sizeof(irq_name), "dma_tx%i", i);
+		irq = platform_get_irq_byname_optional(pdev, irq_name);
+		if (irq == -ENXIO)
+			break;
+		else if (irq < 0)
+			return irq;
+
+		stmmac_res->tx_irq[i] = irq;
+	}
+
 	stmmac_res->addr = devm_platform_ioremap_resource(pdev, 0);
 
 	if (IS_ERR(stmmac_res->addr))
-- 
2.43.7


