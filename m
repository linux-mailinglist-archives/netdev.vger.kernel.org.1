Return-Path: <netdev+bounces-287536-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WI0bIqdaBGqjHAIAu9opvQ
	(envelope-from <netdev+bounces-287536-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 13:04:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD1E531D9B
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 13:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D1FD30F5155
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB843FB7F6;
	Wed, 13 May 2026 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bUkCnLXA"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011015.outbound.protection.outlook.com [40.107.130.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30773FD132;
	Wed, 13 May 2026 10:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669838; cv=fail; b=QglB2oIsivAPV+7UbgfaiiHS4hzxmjKuJSjL1I8J60FD3z1IMI/xB4yimD6OSDPvXu1fKBYORXrOH81t9ZCf2dAefX8SbwcYVyCVBRPa/ud8FXL/FPWIED+cDR932wmziGGTFYwwvO/Qqqci6pbw3dxuKNyqvZDeFu7pnVLXWx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669838; c=relaxed/simple;
	bh=ttOY+E67xG3WFjEmlEYgPMfmHV72SM1pOL4Wp5kZL2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mMo3t4iFaphN6LnZOd5C0a1RzR8A4vUt2PkoVf8a1K/lrTRKRzod+9Y2IejF5IxTd6q4jqJ+Hid7JJcRbpLw0jQpM9FrN2YHKWYE83oFXe4kNmJvq0/1TUl9vh177GGn4Ud2QClyP26/2ZLVLE7FsBuH1D7D7/K9Bj2HzWfZpkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bUkCnLXA; arc=fail smtp.client-ip=40.107.130.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPLKmPlcfZh6LXXRa6pOCBs7FMRnkWRcZ3mbON7l0KPBSC3YNLMVhyCG4cpHu3sXExrsRw99OFVo2AkUTeAA078SNIV8KwOMIiw9q6kiy53TLMScpIvofXGFgclIl5iaLBFplrUeDqUe46UlrSKg4pYoEX52/YiWE8aTt4AgtwHCS9jfS9L5CzVut+oI/iCmzuYh0Zxp7xl7GStxremCvQ8+qTPODBDGRjKKCg+zgHYCTLJcKLsnyM4d2ZpykaVEmlIDdPxdo7CxRXW56V28N+DrGHnTL87rRRu1oXl5OKgev+D+UbGcXGD/t+AOOSiPonfM6rJROr5GjIn9NEFwyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EN4pgkky39Pi19KNOnxW/vJf9RNsA3T9NM/pGNtigQs=;
 b=l1ytEBTKzZ+pS78qqGVzwsADNEUNdk1D2aVdV3DTbHaGZmOgi6VwHTQT9LJkqAdTt8umt96Elk7BrIg+9CNH+zUs7IIUHuCsLQCeYrAOkPtX32zRKDdO7nxowaqyeHch1beEyZO7nFXocZnivB/zh2WbYz/5s/XRA+ZQ1SyfWK+gzyYOchql7JvRBowE1F/sK4tubtpIBOdp5Jxh4DGLHUcAp/yvcHoqJYcfGiNkm3ogo8Sf3RI9Qh1Jut4/HygaazQZklLdrDzUbx3SU+65kx+uDMcbOg9ZG1ysgPsMjC8M42uJblNVAK+k54rxHOFX4FC1ZP/9jqhmQNaQEL0ihw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EN4pgkky39Pi19KNOnxW/vJf9RNsA3T9NM/pGNtigQs=;
 b=bUkCnLXAuF01q6rNnysu9hwVXmEgcUOyN7LzJLkGfagVYwSEmjPDGQb3x0hHKw9Ul6TCnhsTKxSpJXMI2tTXKi6dAbVCKi92zw7iRAIwYISO+p+t3WD3oG6qPiLonWdqIAApds7r0zq8/gc+3/e3nQjaw5X3ECJGdUKALRSyAgsNpv5fD2T6B4mNagJcLCFKEjhkLfLRLPmeJh9SH/tmXYlBsa/DV9ChsP2LkHeqPF5EZ1J6k9SYa026eagf03xRXcDMaFINPh3DwVJ7UU/z12Dqysqg+jTXoAUihyR00JyLS/rOE0ieTamp6bqjxEK8+85GC7069BPq7woGveXOEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PAXPR04MB8427.eurprd04.prod.outlook.com (2603:10a6:102:1cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 10:57:11 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 10:57:11 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	catalin.horghidan@nxp.com
Subject: [PATCH net 5/6] net: enetc: fix initialization order to prevent use of uninitialized resources
Date: Wed, 13 May 2026 18:30:20 +0800
Message-Id: <20260513103021.2190593-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513103021.2190593-1-wei.fang@nxp.com>
References: <20260513103021.2190593-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0123.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PAXPR04MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: c3ede8af-864a-413d-22ad-08deb0de624b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|366016|56012099003|11063799003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	KjW363cmyxqQpjUSkn7hFULhEqOSSKXKYhlKXcQe2k9Jym8gzvoBTdsUr/GcYw31QJ2NJwgizbYiG7c30kTDJriWYUHife85tbuVsa2XcCTuCJHOaCM63qRSf2tYrNxnG2R507arVOSKJJnBqu57taOjKXHv8s99yFZvGQCmzfcQ7mrODqN1OdCjh7/505bXRWs7eL62AB5vyCGmZ7BnJbJwd1BFa94kUoNcvpM6vY+72wxJTK/HcXOFNn61kppOn8h01z/RLv24HwAvkUQoJeuE/NcxcFDDa5u0HF6ABrmDnJPqwzMLbKUfdVJoJdN79WqiJG9e4JOaYJ9DkYSmtlhGL1yAPnCwFcAZPjFKnBHxHFTdrJopKRaupprfApD1Ph155SwSLZae8tfsbXmZizNePE+e1mQK3gU6MES0q0TNRNKDgjWNEiZvvJu2eW6O4/6LHa4ABn/Ys/IkEhfJoLTVp0g0OTcQB6kVNfM8o5aoZ80KwDyTiJ5n04YTHtl8uHUVxPoQieLQ4grFJdvSj87z/R59TMhPCHEL5HCzY2D2ppEJYs4uzShnkHvJZXT/8Gx+qMoVNCJluXjCwzzD4SZCWxqFc79CNQIJ6OXbCIfi0zt0pEP3SXuXt7ilelGCjc/KuGsPQEj/c3L25ZVTfz6PaJROMLFEIIDvAQoapkM+Vi+quq5IdG7zsRO81nwE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(56012099003)(11063799003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j730LLGFuiZOiCv5f7U67X9qse21vGvENP5PhLbWAWNHAbaJcr2aaD5+nBEI?=
 =?us-ascii?Q?W1f8G6AasknhGaWq5vLVHb9xL558Qq1dy+Rgl7FP7f01qi9UbJpGjPaXnjfC?=
 =?us-ascii?Q?LcgDWoNr3Mn+r/YBEYkIIwpTlLbvMnZ8TR39/JeObi+16zgwpEqtCFp4gsDK?=
 =?us-ascii?Q?H3/lMsMZvejIi27csDf61flJBEvzZ7pLNh8g6WtqOzddsBJl2rsxx5qhXsQW?=
 =?us-ascii?Q?6qSbc2QfbJirBKVrAc+fijhXUsVva3TJ7xEeVvRknT1s08LtRTkFei0rBMyP?=
 =?us-ascii?Q?Yq+T+t6Irc8L2ObnO7Q5x3SacWDMQtXNP6TxTxnTvMIITighak4cR9o0Zlqp?=
 =?us-ascii?Q?RXqHZ+mytsmINK21QJUeVJYLd0p5c2IClwsVmNhwjiWASkaezwBws3OmORKA?=
 =?us-ascii?Q?bQZPzNGaxbtQgFC/KXkeceY4zv8uGKNAC56AKTvJ9WG6orHdwbIlJWilWSCl?=
 =?us-ascii?Q?x8BOw5H/hhkupAz4ACAUJPvOdmrW9IqxuJfSfFbNkoEWiM1Fb+/GwMZMwUpz?=
 =?us-ascii?Q?MrD8FeiP8LgKoMKhuW0e04Lus/CtTQvey4f/7wtykTP40xV7TnY5z1A7PwLP?=
 =?us-ascii?Q?Kz1ydiwD6+Yy0zuovrsu1r1ShPyKiNuA+QnJ0t8JOR1lubMc9bFaYUO6UCcW?=
 =?us-ascii?Q?wtjp43yMXBldjp9Mzhx9Y6I1N7s3YxCPpO2UVRsmYM4paVcfBd4qBoPDwUSf?=
 =?us-ascii?Q?aYRvgy3gjnWt57qCTJVrCdvov8M1m/xG8t9BpbnlKLx3Y5LZuTWby2mWKm+h?=
 =?us-ascii?Q?hERohWhOpmlRSmtiuMg7QL09Bs7pwMaTt4ImiNNpV7x4QO8I6QddptbXZ9Oz?=
 =?us-ascii?Q?w3LRlZ6LBEd5Wygg41gCs6A8NMGQIYkse/kZJ0bqEt2NN2lIm1GFh0sVfdWt?=
 =?us-ascii?Q?H1O7n9TwsGAgj4/+ToKjzzP4giazjQVwaRfeCcnCd4205vs7BBt+RYNroH/r?=
 =?us-ascii?Q?vYUOgofMpBX3OwHFEB/tq5N6pdLPlfcxAI4+QSFf/gnSEkNPQozsjb88HCD0?=
 =?us-ascii?Q?+axG4lApAyjO5V9MikrtqBg0Reuqq+deO0ZzfqSA0i4/Sx8fyTazlZsL2Gur?=
 =?us-ascii?Q?7sVm7eU67NAYpO2Tr7CY/O+KCh2uDAl4UhsdLWTacekMmq2PbNhAW5KJsT61?=
 =?us-ascii?Q?xThbV+7RGUFOE4XncTBA2QlJqHj/yzONFC8WyXrdgHO/MmkN3vtLuMU4vsJY?=
 =?us-ascii?Q?KB+UUjGCZwO/CdrgtTbLSG9m9r3SBSJDcHCB+SJ2F+nDSY9pryGzPxXOZteW?=
 =?us-ascii?Q?stlA5ZezkXZqWX89bDFh6PxnsSaxS86ocr8+Nq+hq4TE9OFf2Eqd8KA6sFYh?=
 =?us-ascii?Q?sBDKt6w4AB/F+tCahUsAxkrmTCyCK2aaUibA+s0aNh17dAM88pwaJQeVKtCT?=
 =?us-ascii?Q?ZkbbZSJqXGEhe9U5Xl6ITLkV8NnCLW/xc9Qy/3Dl3kqoVfvMWkFwCFhMeCKV?=
 =?us-ascii?Q?5aG705TfxbPrzYcOji5VU6ItMlFQFFK8ABXF3HGCqwl5zUld/XDSNDyV0aUw?=
 =?us-ascii?Q?aYIw1Lh00A9b2QcuSgp3hluAnxBydGe1tCbSaCEEugc45/8n6o+LmhCpctlQ?=
 =?us-ascii?Q?KLiQXHgkmh58M+rotWaQQ/54ZUmO2ZceyofxrJ7AgiJFv1OJ95RFRuSq2Rm5?=
 =?us-ascii?Q?peLF/An5MyhTj6R+y3+a2z+6jEBZCOfjj6WzQkEAda19fHF7stl8BblWKxT5?=
 =?us-ascii?Q?7AtuzHmXQLpkmE/em7pzcY0R4TDzPRkKtM7eC/9NY2uq2So2JUbLPQWu/1IL?=
 =?us-ascii?Q?UPBmyFqsSQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ede8af-864a-413d-22ad-08deb0de624b
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 10:57:11.5512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJtechujNzF4YX8LLB1rbY/B1opc9c3s+bVW1w41lPHfqbCI8ZnhqMeyM231o1oyHLgFqsIh9CnPZh9/WYRNng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8427
X-Rspamd-Queue-Id: DDD1E531D9B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-287536-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

Sashiko reported a potential issue in enetc_msg_psi_init() where the IRQ
handler is registered before DMA resources are fully initialized [1].

The current initialization sequence is:

  1. request_irq(enetc_msg_psi_msix)    <- IRQ handler registered
  2. INIT_WORK(&pf->msg_task, ...)      <- work_struct initialized
  3. enetc_msg_alloc_mbx()              <- mailbox DMA allocated

This ordering is unsafe because if a spurious interrupt or pending
interrupt from a previous device state fires immediately after
request_irq() returns, the registered ISR enetc_msg_psi_msix() will
execute and unconditionally call:

  schedule_work(&pf->msg_task)

At this point, pf->msg_task has not been initialized by INIT_WORK(), so
the work_struct contains garbage values in its internal linked list
pointers (work_struct->entry). Passing an uninitialized work_struct to
schedule_work() could corrupt the kernel's workqueue linked lists,
potentially leading to:

  - Kernel panic in __queue_work()
  - Memory corruption in workqueue data structures
  - System deadlock or undefined behavior

Additionally, even if the work_struct were initialized, the mailbox DMA
buffers (pf->rxmsg[]) may not yet be allocated when the work handler
enetc_msg_task() runs, resulting in NULL pointer dereference.

Fix by reordering the initialization sequence to ensure all resources are
properly initialized before the interrupt handler can execute:

  1. INIT_WORK(&pf->msg_task, ...)      <- Initialize work first
  2. enetc_msg_alloc_mbx()              <- Allocate all mailboxes
  3. request_irq(enetc_msg_psi_msix)    <- Register IRQ last
  4. Configure hardware & enable MR interrupts

This guarantees that when enetc_msg_psi_msix() runs:
  - pf->msg_task is properly initialized (safe for schedule_work)
  - pf->rxmsg[] buffers are allocated (safe for work handler access)
  - Hardware is configured appropriately

Link: https://sashiko.dev/#/patchset/20260511080805.2052495-1-wei.fang%40nxp.com #1
Fixes: beb74ac878c8 ("enetc: Add vf to pf messaging support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 24 +++++++++----------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index fe9680a97b0e..c156a566a751 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -109,6 +109,15 @@ int enetc_msg_psi_init(struct enetc_pf *pf)
 	struct enetc_si *si = pf->si;
 	int vector, i, err;
 
+	/* initialize PSI mailbox */
+	INIT_WORK(&pf->msg_task, enetc_msg_task);
+
+	for (i = 0; i < pf->num_vfs; i++) {
+		err = enetc_msg_alloc_mbx(si, i);
+		if (err)
+			goto free_mbx;
+	}
+
 	/* register message passing interrupt handler */
 	snprintf(pf->msg_int_name, sizeof(pf->msg_int_name), "%s-vfmsg",
 		 si->ndev->name);
@@ -117,32 +126,21 @@ int enetc_msg_psi_init(struct enetc_pf *pf)
 	if (err) {
 		dev_err(&si->pdev->dev,
 			"PSI messaging: request_irq() failed!\n");
-		return err;
+		goto free_mbx;
 	}
 
 	/* set one IRQ entry for PSI message receive notification (SI int) */
 	enetc_wr(&si->hw, ENETC_SIMSIVR, ENETC_SI_INT_IDX);
 
-	/* initialize PSI mailbox */
-	INIT_WORK(&pf->msg_task, enetc_msg_task);
-
-	for (i = 0; i < pf->num_vfs; i++) {
-		err = enetc_msg_alloc_mbx(si, i);
-		if (err)
-			goto err_init_mbx;
-	}
-
 	/* enable MR interrupts */
 	enetc_msg_enable_mr_int(&si->hw);
 
 	return 0;
 
-err_init_mbx:
+free_mbx:
 	for (i--; i >= 0; i--)
 		enetc_msg_free_mbx(si, i);
 
-	free_irq(vector, si);
-
 	return err;
 }
 
-- 
2.34.1


