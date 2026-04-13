Return-Path: <netdev+bounces-277977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0O6IF3ag3GkEUgkAu9opvQ
	(envelope-from <netdev+bounces-277977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 09:51:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F03F13E8891
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 09:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5235A300599E
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 07:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270E639EF33;
	Mon, 13 Apr 2026 07:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YNGCaWcn"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013049.outbound.protection.outlook.com [40.107.159.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B27139A05A;
	Mon, 13 Apr 2026 07:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066666; cv=fail; b=hVvXiF5jFHkR44vA7Vrd42qpC1lVYx6RxNJ73wnrzLWVPWZSOUswf8BBt39+oiGAu6jtYWo5yfyJTw287B39M2E4PfLTb6hLGDF81G1+5ZDQa8aHu/u3nXQ6pGY5o0RwUq8N73vHuCHgoqlOu8OtbceHw+qQBcBnB1oJEtNa424=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066666; c=relaxed/simple;
	bh=dCXJsdkLfzF2IqG/STFJCXBpvaiUMxI+IcU1ksZBY5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FE7TdSTsYdojFBPyGsGaxgCqLoNdoEdTbBkTBmivTihu7HAzLbK4V+3E4g3fXPmXFiQpfoGXhTJ6HtFBywlh+f/ZxLs1+GJSNd/2xrEGpUJ42Ko5yLX051IHRG2kMqXrT5M8L2erQbiDnrPxXBx1MAGfeMv3JTFd2EpEpvoouns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YNGCaWcn; arc=fail smtp.client-ip=40.107.159.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vatks7fuaEbxN1OqDdum4S3ihiVzDBaAptlIawwE2waHZYQmnEOVH1G0vRLuZrmWYic0NrwoJ/XooaElFsoJW38v1OQSn3FW8yvYCLD/THM8peorvVHcufHezsAbOh4RHciQIyVkuwMBhS1buLlGbKCPQEdUgfxnLJNivNEFmW3fjUbNdcosrn4qkABv7EQu7JzUh1l+AJv0z7eNk/8s3FbGZ48gcawkrG+v163N/cmWjq0kunnzrYFPkKjzsT+g6a1FcUTstcvdQjBH6nG+qOQuvNCM0wzT24XaTaLcKZ/+5LzkCijq5xw751h9bU5Gab9VJ8LsDxe93E9IFpv5rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fmphqKwb0TwqBXKtyWbZh8v9y5oBNjn1xeHgIQJZ7k=;
 b=XL+c4oZ6j2GaJrU7S59ZissHgcDe9BsWOpfQRxfiGH5l8hxlI6a3lQ18ZXaAam3KL1F00l+l+O/+LFMTcVxhuDCcNl5vyFmnEwg7JUEFiuoMMGbKq7zw2U0Hl3Rjq2k+jXJYntwUJKmY66q54Hu++X/HFgmFJGRuGkxoNrsgsIb43rRYC0QJ94FYATHSNaE5VJRN11TLzoctPNN5LmjfG88SZg8gThwP/BTgoI+Ls1+dFrVN23cxmF48a+xOdA4k7r7PwLe6Fg4KX5GXwK8dxOMW2fuY2GcsdMSohz3dTFL98fddkaVik1NMIj4af1QsVussXaLA+9I0bFZH0Lpp6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fmphqKwb0TwqBXKtyWbZh8v9y5oBNjn1xeHgIQJZ7k=;
 b=YNGCaWcnHz809fqWWa0sv+VSOEo3+iGrAZduHecJ7HQehAZHjbUY7aBfwiOWceIVD4nHDdB69B2k+nUx2WjH6ktxxbbtd5KRWnW2RVSYDOQAU/zc3HN3let0EIVpFGu/CStc/AwbEzC4Q8BwPQR5131sZOSFw3cvQxaByKmIG2bQqaibtigC8FK0hph7MQ1iEtldKmrPyVjf0WJNxpJ7bZqeUWiNUrGjkTXDCHPxLlNg/34uCTUOzhcuNTxIJd0RitEHV5TrOWJI7aptQQqDlhttp3DF/oi3TniPyLU5NvkkLVdvjys8uai/UilYCv7nG7yFGSva4ESb6++KZNZ1Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by DBAPR04MB7463.eurprd04.prod.outlook.com (2603:10a6:10:1ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 13 Apr
 2026 07:51:01 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 07:51:01 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net 1/2] net: enetc: correct the command BD ring consumer index
Date: Mon, 13 Apr 2026 15:52:49 +0800
Message-Id: <20260413075250.281653-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413075250.281653-1-wei.fang@nxp.com>
References: <20260413075250.281653-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0236.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::10) To AM8PR04MB7284.eurprd04.prod.outlook.com
 (2603:10a6:20b:1dc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7284:EE_|DBAPR04MB7463:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c7608c-acce-4e0e-92c2-08de99316789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|19092799006|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MUIjxBD6XM5U/ZK46K0DsVa8A3P7u0ZCM8k6UGLzcvye0AkCVW4+8D3fD5PPBNPOMjC1HPkHbwTNlFvTpbfZIftcvfWppLQfSyYBJJBIN7tKn3SknaxhVVsPea/RRkZpOfyogZLRWVhvsZjWTneRi6wCMFSYFjD8+mlkFIG20Yi213DMPwsOqpPspJSBBb6ApmRCg/kfEHlQr7Zjx41dzfwpwwvUaUesrWEaGmqrChOuS4bsJk45zW3Fd2033jySOHPPThDGtMr4TndUEiCZGIQEae8DPU4amcJ0R0vK4A8YtsV+NyGOYrNam60PIqd2YFQIvCMWBW5ZUOGFStq/CSWK74r2V+swLnQzzg4vlWjwkUXf6WqXa6xh45HykN/bzzyQs8M2TbuxDXy+XsfTHi5+5uQ5Wx97+DOT8b77KVwMacDsgfvabhxk0oNauY40Gwm4csDBvbNKMr+EjleN4G6ci+85og7baAnBaZwhQtkV0nup42YEacZgZaRpopiuj7EV3RgNasTBkZHgoiqY5ZFBbth5CrwvDRzEKigUyhS40ceJzXWVCGGHHtrWDY1jiUMj6yvd1JVldHpRbcrypwBOBaTtoM9pw+m96hJ82bbrHpIVqBylmo8YfyENH7dqC+G9ajKhQD/IRuOT+d8pv1hmnyH+HUR4IAbM5hxO4GqK45Hko0GGkDcF9ZxtbL6d7GJ+RerHsIdG6UQI3Hzjj4OWpS+uCy6GMRjJ3dbj6lxlyvwbgXkB+ymBB7JTKUP1IND9LBwZ47TIVESM5ZD2ZgwUgVSTO/xa/6fTmJYXGy8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(19092799006)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TBt4xwYqJpBJ3eZgmBRKmmBTvFuRBayXnzonsfzFnsBrtiyE9IgTZE7WFGjc?=
 =?us-ascii?Q?D7GPR4jZ9EfRKdZ9n3e6bpmlp1UfDvNUggXDTR21AuD6K+IwqlZsNrBtXTOJ?=
 =?us-ascii?Q?Idwxfr8xvoXL7UCAsP/Ibb7QFwT2YP6iJxkHG07kfPWmtOnd8LIkXi+i4jdf?=
 =?us-ascii?Q?2Bqwk6YepWygH42ozYnTALOiTmI/llvd1Snj2fpzVX5JKnXSlG3c8pJJJ06J?=
 =?us-ascii?Q?aQNrDR8X0GU/t8kLum0YZAnqYWL3ggmb5L8CPXmrvk6WeU0nQaZ0lQkFQZ8/?=
 =?us-ascii?Q?RUwDEEFnFk2Ofx0s6+oWYJ3cX5RaNv9dFvXHHUebXr28gDrhW0BixXoWarsC?=
 =?us-ascii?Q?buC9xOU4H1Xp0X2RzvugDpDSdIznQDvirpdopkdO5FAm9p2QXSBMKwDKiPhp?=
 =?us-ascii?Q?xfgU6O/Q4CzUZeJea78rFUEKGbcu8UZYrSm0pDhN/N5mdtVAKg8ZHRIgzXmC?=
 =?us-ascii?Q?yI/V5W0c9QzwjznILTn9FlHgeYhZdLtHUaAEMNDMJMYZxhcnZheDbijbbBL0?=
 =?us-ascii?Q?cNGys7czRAEkIF3kJKOKcv2pP0WoYTWLXasnvrGHsF3Xz0I/swfJqigwdhyB?=
 =?us-ascii?Q?zHvebMj4whRnAg4adQIL2DW6irTpQCeNWc3aOM0Sreyll+tkeaZLJe5PALDC?=
 =?us-ascii?Q?Pq0NMfZfAr2cR4xmegu6/d70CH98Ds2Oq39S2oBL4sNKvLxvCt+KzGvvd8sM?=
 =?us-ascii?Q?eZ1yVrsstVNgbOhmqlovTssRFbcjrZzgvQR1lW1JGTvy7jAyWKmBLXzWHpOi?=
 =?us-ascii?Q?1+MU/Rnl64DsafKzUCSnpklbvOC3lyXipRycEb+AucKU4hxyyREZO57e+axH?=
 =?us-ascii?Q?7DHWlF8VCKIdnQKoVFXxKRHcoSuTlJ4CBqaPulKgrRjalRSCE2nMPaeH2mq/?=
 =?us-ascii?Q?+7SRLodsCW9PNRBvvFsdiclqRfyHdUXvvGU25JUT/v2oXNvpPpfE8wK/OCv6?=
 =?us-ascii?Q?kdXmFxGcph/ienSJwRuQThh5JJu4a9dmtNYOL8+G/dqs0fI/LX6r6TJ6m7cT?=
 =?us-ascii?Q?HydMROmx/9+437mT2oVmRWxHgqLTFukH8g7d7+m5L+x9UTJR6qhO5hjHysak?=
 =?us-ascii?Q?fM9Re+pNWZoT1CyFxyeyUduqEwFMGvMGQJKSEZXwGPHwygSrzEyHTdqC6Uk/?=
 =?us-ascii?Q?EI3sqfNfPW+DmFqFpXFs9lXoskZgRb2k49UuwptI+7lq1O+HkuLwUYjWDggF?=
 =?us-ascii?Q?tR120JCJdsQrzb8PiEB1RZpVA5BYrykaILwpiAYdzJb2/Oc2iM49aWxBcqLJ?=
 =?us-ascii?Q?8eNA6eVqfGnjLxdr6NorIN3Fon8RaZCSN1KzhhJyNEj83kXHZnyljHCWyUa0?=
 =?us-ascii?Q?1iLAr1hcALgU/ZfiUFR39HEimgTG7+Y7xLI2GNEKJOeuuT0fgbyxtCJ0aZM3?=
 =?us-ascii?Q?u+0zS7WAGcAEzkRn8nzP+MVdSTLyRjXWk6+rOqYeBNkdeMVmxlbZ86sxQ83S?=
 =?us-ascii?Q?9rXJTXWdo4hjpjpkFZx12xU6+7c1YgOHBY2MQGZuxC/Gy5D/r7BHWKWnZmng?=
 =?us-ascii?Q?STbvcKXQZpNjKNsEtEK+7OpBHuDOdF5ul92Ms0WmxplaqNLU0yiWMAjLxYdC?=
 =?us-ascii?Q?xBtPkAlGM/C9URUyuvrfDcV545/l2/nNloZKuV6b3px1YfFfxbJhchnNqvZ9?=
 =?us-ascii?Q?/jJ/naFiHnHLp5U9IkECTlPybFHjYDMByty5fVAqhFC/b9AVUjR9ya/TPg8I?=
 =?us-ascii?Q?/3KnqWHPSw48snJE/35WcgG4BkStgLvgaqI1D3Yk5WHhF+inCd9DcKwcMIxB?=
 =?us-ascii?Q?07GoFpz0bw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c7608c-acce-4e0e-92c2-08de99316789
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 07:51:01.0253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0opaxWxupVaOXKrb0imnGX0DPTrKxvgkMP6K2I3+kudLu5SJKyGnKywjbL3XXs//02Ky7jZ6gHf338niwP5Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7463
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-277977-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: F03F13E8891
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The command BD ring cousumer index register has the consumer index as
the lower 10 bits, and the bit 31 is SBE, which indicates whether a
system bus error occurred during execution of the CBD command. So if a
system bus error occurs, reading the register will get the SBE bit set.

However, the current implementation directly uses the register value as
the consumer index without masking it. Therefore, if a system bus error
occurs, an incorrect consumer index will be obtained, causing errors in
the processing of the command BD ring. Thus, we need to mask out the
other bits to obtain the correct consumer index.

Fixes: 4701073c3deb ("net: enetc: add initial netc-lib driver to support NTMP")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c         | 7 ++++---
 drivers/net/ethernet/freescale/enetc/ntmp_private.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 0c1d343253bf..1b1ff0446d0a 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -55,7 +55,7 @@ int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 	spin_lock_init(&cbdr->ring_lock);
 
 	cbdr->next_to_use = netc_read(cbdr->regs.pir);
-	cbdr->next_to_clean = netc_read(cbdr->regs.cir);
+	cbdr->next_to_clean = netc_read(cbdr->regs.cir) & NETC_CBDRCIR_INDEX;
 
 	/* Step 1: Configure the base address of the Control BD Ring */
 	netc_write(cbdr->regs.bar0, lower_32_bits(cbdr->dma_base_align));
@@ -98,7 +98,7 @@ static void ntmp_clean_cbdr(struct netc_cbdr *cbdr)
 	int i;
 
 	i = cbdr->next_to_clean;
-	while (netc_read(cbdr->regs.cir) != i) {
+	while ((netc_read(cbdr->regs.cir) & NETC_CBDRCIR_INDEX) != i) {
 		cbd = ntmp_get_cbd(cbdr, i);
 		memset(cbd, 0, sizeof(*cbd));
 		i = (i + 1) % cbdr->bd_num;
@@ -135,7 +135,8 @@ static int netc_xmit_ntmp_cmd(struct ntmp_user *user, union netc_cbd *cbd)
 	cbdr->next_to_use = i;
 	netc_write(cbdr->regs.pir, i);
 
-	err = read_poll_timeout_atomic(netc_read, val, val == i,
+	err = read_poll_timeout_atomic(netc_read, val,
+				       (val & NETC_CBDRCIR_INDEX) == i,
 				       NETC_CBDR_DELAY_US, NETC_CBDR_TIMEOUT,
 				       true, cbdr->regs.cir);
 	if (unlikely(err))
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 34394e40fddd..7a53db8740db 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -12,6 +12,7 @@
 
 #define NTMP_EID_REQ_LEN	8
 #define NETC_CBDR_BD_NUM	256
+#define NETC_CBDRCIR_INDEX	GENMASK(9, 0)
 
 union netc_cbd {
 	struct {
-- 
2.34.1


