Return-Path: <netdev+bounces-305350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zTNOLf69TGoqpAEAu9opvQ
	(envelope-from <netdev+bounces-305350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:51:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1E97195CA
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:51:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="URymIN/k";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305350-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305350-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C0263303FC40
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 08:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD2B34D92C;
	Tue,  7 Jul 2026 08:48:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011056.outbound.protection.outlook.com [40.107.130.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BA6386543;
	Tue,  7 Jul 2026 08:48:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414098; cv=fail; b=H9QpXXrXDftuNtyX92wwixy9stW4c4+pPDfYw8XvM6SkpEwqGZ9pwM25DNRdQeYo8Pwp2O94R8uE9Lm2xAGeeQZZ5qXvYD+gDDl6qBOHH0NXNugyxL3sTrrEVCKPyk4UoKC1ca2iHUtzpoG2DHgD59RVf1CC38xgZSoFlpD2m8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414098; c=relaxed/simple;
	bh=hT6UAUm0iBajZmBhVhnkiRZR7TDWOxnI5kuHhWqQV3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TiXhW+g2l/LVh6OPwtF+3v5vXbGVCNZ5RPzTFi3zp6sUdxJXAt0o5JHerCuDLsO5ozDqlUq8MO1nn+/jo1Xzx/aTnnidbqfR7XXlugWH/2SqoFrBkVqUEuP7B56UCEAPM+9GNI4pvfVZbKuCw3bylKakf+CXqSYR0zRtskaaSmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=URymIN/k; arc=fail smtp.client-ip=40.107.130.56
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yoa8Ex1bh0Osx+j6ieGKGn4JCcs6t5o7SvVVF/RPZju2k4ocbcX1kpfIVA78WLBDgBgk+sQhStIy9yUq5VWrX84/hd0Vp2AbYB8TDcGwGkZ+pAesMXOWDaLvwSrW30poSQv5tV1LSwHZ4r8Uk2+GP+rYU8vVa8P9mYxVm39C0wcPPD4011RmHxmT84wNbVbhppoTmqsaYOqMC3x3/fO/uhmAb8YBrP1grjPqybVAE4rnebgLzecMXR2X23oC8/DjVI2mIhva1Utqf3C4XFUk+CRfQBPd14r3rukjEnhdWbuUYOxtqvIZj6GaJ0r4l5Gpasya9UsAnj0fwKwHmr82ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLTF9WBAGeAwf9k55IX0Wuhsh8qjn6IELVpYq/SKvck=;
 b=M4UsNYIcaFkBeb+iAWdrP++C/YcBBZ80KRidDlH4zxDvYG9mvT5MRaRCaR8o3JXOaoqUat9x0jqcHSOJL5W8BowxC1EBqNOVbQP5chFAjkKVsFKD7WnHxCXazIzgwhDq11Q9dqv9GdSaXRX4KO2uNXE8dnCLmv/HddH0MBG41MtehPjc1EPxl+YVgLeKk0LAxMvzuMO84mHQyU4llLaaEIHosNgBqp0viWG+2cyBEtglKwDEzM2on/0oJ8VHxmuRb1VaEiQBH91ILIBR5O0c+w/UPzsrm6in+687zV5VaHamFqeDm6f5eTmdkXXuo21bd245lceCHYx5yDByb9xgyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLTF9WBAGeAwf9k55IX0Wuhsh8qjn6IELVpYq/SKvck=;
 b=URymIN/kAakyM4b/TYSiEqh9P4heVdFrLhbHunvVhZWbfNCF6goQ2W5gWA8XEMQnknRVHoHe2UPOo9ZieZdOsnzpUH6ATohGCmW+0KA/L1Jgwu6FVe7LVf7VeSJlcco6ZlqN3DhzeL6AhQXt+jfVwW4eBb6shdvKP5yFjoWApDq1m8v7cMqln+C86f1iZDsIDkstLk332/8S7R9ic7EvkYonlA5RCEKCXGmQwZnIu6IohbfoQgpS1mIXW0FXvlBBae0f8ozN4gC4WK7pzDJ+Xgkp55vx5I5gV0vltiOwH+sbPX2TF9NVUuAc039jJAeb7WlqQWCmLBqfDFi3oXkrBw==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by VI1PR04MB7182.eurprd04.prod.outlook.com (2603:10a6:800:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 08:48:12 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:48:11 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com,
	chleroy@kernel.org,
	maxime.chevallier@bootlin.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 net-next 13/14] net: enetc: use alloc_etherdev_mqs() to create netdev for VF driver
Date: Tue,  7 Jul 2026 16:18:33 +0800
Message-Id: <20260707081834.710730-14-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707081834.710730-1-wei.fang@oss.nxp.com>
References: <20260707081834.710730-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|VI1PR04MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c30acc1-33e3-4266-ce29-08dedc0479b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|19092799006|56012099006|22082099003|11063799006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	G5RmKhspaERoPxQ+P9kA1Qm8LIsuo1V0CT3m5YCTq2N1o2XbZh8U7wVhDEAzBAlC8AoNTBuNK97G428Mr8O/HruAb9sewd0fwCzYCOe3wxbT+F9eZmh/akCIUbumSf9IO9+1xGg100Ygmo1JgSN2S7lYee3bEICCmQzF/iMDQrV+E60FJ0rE11ebsbur7pelzcbfOZAocyRhquBK8Bjh5Fhn9Twht9l5s/9djNrGeyftCGhcGMAN3JqziOtvoGhUDvpYTEeIn/Vd7aQkvVxtcbs+3SDwCJnqlLM4P99ZC+x91TUa4sc8C1Vq74UY88K5DNtChGx6e1Dc9RtQ2XAFpAiR9WV4e9+YPaP+ATe9Ge9WGs2Jt4EC1/6L8GDXoFQ/H3KC1Of3+yPmZED2e/rNPCIkUAIVxX+Hcah0gmDnE7CfbpDcQug9vONuUXvbk7NidZb7Ex3FwOSrtHS+/J4QgwboIqOfZRED8oYhGmnDChk4Ko42/OAM68hAGMJTvwGUVEAm7cfcJoBOj+I7tgDvFomKPawiDG8DU40TaBIcBqudQvFujI2Toh1J/YJImc0Hy2W9smY05+knUgxpzdkgzaLuzbH50LvhAP5eTSU+WBagj5a4iK3v+gx8w7qUlnAHTm08DOYYwBMXitGjnCUY3jgQ+0N8AwyAfHZ6fhC9JwRNVCeez4VrBtArlu0Crm/kuEw2ZzmOYI0GPG6EAsqpBg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(19092799006)(56012099006)(22082099003)(11063799006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UNElAaRVwsYsbpeCNHmd9kvj24SZDUfeZTAUXperjjLfagRza4jVrCxVbojH?=
 =?us-ascii?Q?gxUFmycL8XVWwdh2x+uG1BjGAI43W1F/pKCXfp/lrkNke70V3dgIQ4Po4n0D?=
 =?us-ascii?Q?QbGotzPKsZ1oxy+Vzk5uw/ryjUo+eHt3Ne8ISYcg2URYzp0x+icZokyWwA0D?=
 =?us-ascii?Q?qUNXDucQDlQmt76+5crf+VfP984/o1AnRawQ/d7vvrzmZgQt7bNm4/bnIwst?=
 =?us-ascii?Q?G0U9V+tqxZdPEpFKF2V70sKuTs2pH22vLuX5Cm+kplVjTsuxUtI0Yl3zoU//?=
 =?us-ascii?Q?hh6lnFJv0GTdGkTnp8QsdnbyAeDBXnLX7vRIT2428PcRysQHgXiw4ZFLscte?=
 =?us-ascii?Q?CSvEnR/xBA2EwYWYnqGzTfjjbWuPolbGWziLgqCI1BUlpdVO1b6ysucA0ChE?=
 =?us-ascii?Q?YidVt9KaX/MCQBW627+5pBviUl5/jbAlqYE8XKmcBrX3MTMcrSTzXQjkbRNK?=
 =?us-ascii?Q?Hkga/ymowO5Gl1zjzTDol/kpqQxH4cDbd/6rEj/dLxuLaFxxvE64i/VIid/u?=
 =?us-ascii?Q?S/TOpNPXPJNK52JtQGf3tqTpzUKHRONjHtkr7yFb1avZoHt3qD364cLp8ORp?=
 =?us-ascii?Q?D5tgJQuQG5AcIOsDeZJ79Ssi/BGr55MAoDUEzg50nruFuGhV/IRJTz91E/bY?=
 =?us-ascii?Q?9tLmHvEqqK36NXay2hKKaZRY6mmt74WarBfvlhLEr7SqvWILl6Tcv5Vgt0Cm?=
 =?us-ascii?Q?nnJsJ/pqurCLTl17O3I95Gkeq40sAKRlQpH8fR+xUfeV7mnKhLpszrLktMBx?=
 =?us-ascii?Q?2lYC0BmxIoA1+t/5CiEtSjXJgsDnNHa5axPGfHLl3E+XCovGaENI9BlaTNWy?=
 =?us-ascii?Q?0ZMHOz21hfpbgOvJuDnArzznhtblPl+p1Oa6loV/fpYmyVf1WIgLI38r6ACa?=
 =?us-ascii?Q?cJR1ULmSwE6voennTNo/XQOiJRfBZAuyJ5kAvgA/kqC3SfkvlnPsFK3wSe6D?=
 =?us-ascii?Q?/E6Xa62FYFtiKycMTpiKjE9k8HK54d+pSMakM4NVr7OZcGBbkksLN3RwpqMa?=
 =?us-ascii?Q?awrZxKzMw208yTgB9nv6Y+v7Wx1/A60wuwijNlcuOzLyTvFVOX8pJJ74IHfL?=
 =?us-ascii?Q?F5PvGWYl79mbatquPGNDbCMK3GEteOYHrgQm0lMdwkHQ6eVBK/z6h3ecqoCk?=
 =?us-ascii?Q?BT36WGYXGwLvSpuuhYMJv6o3bU5ZDLp1OfPIpqLNXTD8ta/N4+4rnTqEn8GN?=
 =?us-ascii?Q?WVOffqqtAt+vC6FXW+IB+C46CRVib9HH2rQ3TrfwYxyoIzyE1WO4TuRhATgu?=
 =?us-ascii?Q?77vObYWa1KgvHvbZVIqrlJIBVUEeh7YCvTaObF9tdCzSwEyssV5H9Ozx2R+r?=
 =?us-ascii?Q?y5sDvoj70UAlP1/sneMipGRTODunIJJjpr/mgUYpJytVH+UPWKV/fBGMYtGG?=
 =?us-ascii?Q?IiXOrweDP13IdaztOWSOdJ9RnKKIPZ1OpHbg7CK6xY1E9pb19nPqkcwID5d4?=
 =?us-ascii?Q?AKVkTwrk/ust7Ouk2uf97WgugEghs4KH1SS9a9sTKXLqDn1yWtXM0yGMxkxW?=
 =?us-ascii?Q?VDKhTcoQ7WTMuZr11/saRqPleMrb8xALneUHwUu2x2WhNMlEZE7cidT7fYL8?=
 =?us-ascii?Q?JJlABPvYCjL4ZysY34Q8eyICLhiH/mc6uiMbfI4TWvuWRmAQfjwJ6d2LyFDy?=
 =?us-ascii?Q?vUEGIZDAYV1bFT3OcNt4qhcT4pWjn4PUZXTNmG4UbdeitH9o1o9nOS4Vmwst?=
 =?us-ascii?Q?rqyvcohDNwNZ9EXbpmDy0T5el+kbChcFlPh6MF0XrgAYpy46BD06Av+YZtGg?=
 =?us-ascii?Q?f3inZBMVruTjQ65GEfQO6PF00aUKr+jjsxGxK4pfoZ7g01k+Nkpf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c30acc1-33e3-4266-ce29-08dedc0479b4
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:48:11.4828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7TC0JzcLUTjWU96b80PXMKgrC+KAiDMpBeEKIKokbl9Z22LCCHwNN4rdfUOpU6zBwX9Tek3OLe/kUydGzF+t88KmazyAMXwYoeSXpyauH5JqJI1yRv850eSwoR/bix9N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305350-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:chleroy@kernel.org,m:maxime.chevallier@bootlin.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-arm-kernel@lists.infradead.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.nxp.com:mid,oss.nxp.com:from_mime,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A1E97195CA

From: Wei Fang <wei.fang@nxp.com>

The VF driver uses alloc_etherdev_mq() with ENETC_MAX_NUM_TXQS as the
queue count, which forces the TX and RX queue counts to be equal and
uses a compile-time constant rather than the actual hardware capability.

After enetc_get_si_caps() is called, si->num_tx_rings and
si->num_rx_rings reflect the actual number of rings assigned to the VF
by the PF. For the ENETC VF on LS1028A and the upcoming i.MX95/94, their
SoCs have no more than 6 CPUs, and the number of TX/RX rings allocated
to the VF is less than 8.

Therefore, switch to alloc_etherdev_mqs() so that the TX and RX queue
counts are set independently, each capped at ENETC_MAX_NUM_TXQS, based
on the actual number of rings assigned to the VF by the PF.

Note that if future SoCs have more than 6 CPUs and more than 6 RX rings
allocated to VFs, the size of the int_vector array in struct
enetc_ndev_priv will need to be modified. Similarly, if more than 8 TX
rings are allocated to each int_vector, ENETC_MAX_NUM_TXQS will also
need to be modified.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_vf.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 9cdb0a4d6baf..7dcb4a0246f5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -317,7 +317,14 @@ static int enetc_vf_probe(struct pci_dev *pdev,
 
 	enetc_get_si_caps(si);
 
-	ndev = alloc_etherdev_mq(sizeof(*priv), ENETC_MAX_NUM_TXQS);
+	/* Currently, the supported SoCs have a max of 6 CPUs and the VFs
+	 * have less than 6 RX/TX rings. So no issues for these supported
+	 * SoCs, but for future SoCs which have more CPUs or more TX/RX
+	 * rings, all the related logic needs to be improved.
+	 */
+	ndev = alloc_etherdev_mqs(sizeof(*priv),
+				  min(si->num_tx_rings, ENETC_MAX_NUM_TXQS),
+				  min(si->num_rx_rings, ENETC_MAX_NUM_TXQS));
 	if (!ndev) {
 		err = -ENOMEM;
 		dev_err(&pdev->dev, "netdev creation failed\n");
-- 
2.34.1


