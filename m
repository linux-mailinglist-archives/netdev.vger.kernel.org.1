Return-Path: <netdev+bounces-302110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vwrhGGcqPmoAAwkAu9opvQ
	(envelope-from <netdev+bounces-302110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 09:29:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADAD6CAF20
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 09:29:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=j449DEWu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302110-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302110-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 68FF33006930
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 07:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DAC3DF00C;
	Fri, 26 Jun 2026 07:29:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013016.outbound.protection.outlook.com [40.107.159.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111233DC852;
	Fri, 26 Jun 2026 07:29:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782458978; cv=fail; b=HAh31kPsEpT0gdE74fARp8yOWNwrOaLgNqciOhUaODx9VH30v7kbHH9h7Pe1Ii0E2nP6g6c+8yDcGDeo9NUg3e/WEDseCLyehIU9jdcEXNbeaByI6dQLb8OF/KS0JQMGBYST+CWypjf6TCuQw7ejIouyBuvoAvl5tjmHS1GFdHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782458978; c=relaxed/simple;
	bh=z7WrdeABLrKvNP3fwxlOqdbE5rSrVnFzXKBCjyGlGUU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IM+weK1GchR8Y0geM8Wo7NOW6Y1UeHUJcgkr/Ecq5Etor4qlSSRpucps+o1kd6QHyUK5ZdMJ8KgyE2OVoeiG/D99vceu1e+GTe7mleniYLwAt3wkXUiqK/e2HuIE59apnShxwajf0E/vFanGutEHDfOd1Hu/KIjzjvXnYpLMGGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=j449DEWu; arc=fail smtp.client-ip=40.107.159.16
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVSgtESzo/6LMwj0ManYqQSzjJ84ocULkaoZPE6FnpoMfdeVEyGgJ/WFf3cNV09waS7Tc0HzM5hmVKvm/I7Kj+8RXf1Y9g2qKnmcCIbrDd9utbhaL8G+M0bRIxnif2/nCd4qZA5Tux7r1hLVfg2fm4utUSxzZ3LXIGJPxxJTALdf1xm5CsQBcCWrYxTn81caIpBWivMnncLMHraOdJ04NlEWdbwbp2OV0LT3NV+xbxD+Sflx0GffnAoA7EgtUOb31AjQdhRfwSQuhEj1ZlVBETeu8hPt4248h7nILhVQVcntit73GbqrqCglaAqQGTPnFsXw1T+xIttnL/gFKZ8V4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4g5GKPIBEGYb53j2SYgOKBPv01wPqZk9j1EsdHvkbM=;
 b=DZjw0gqgXEtavxmAeP5LTckZjK1TP0UxHr6gYErNqYmtHD38RNc13B5GnqV34uVlATkMAWlteMyg7JKjGWzfHtEHihd+5v/Z5COi/Ns1a/J91nBUEaVCDO2ErrHCVWbIPmpPoENZsU8SbMTMLkXmcP8LqU3JjPfZ3sIsw4oW+irSW/kmBgmCnV4yEKtZYE5G1NTWzNDuq2bOyawDnMhVXNPQa+6WQFr/CKqBHluhPghQRta0MNWuj7QRI07BQEi5UqxsORtSZCesa0KvT5RL3UTsfG0U0w85RMGTRLU6yhYJ5PU6S1wUZr4DyVARGVPFWcOPWjXMOQp2anQhBNjX3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4g5GKPIBEGYb53j2SYgOKBPv01wPqZk9j1EsdHvkbM=;
 b=j449DEWu7Zf2yTox9g57807o/0yXYB7VT5ODhmcT5VTwNavDgl86Ub1Dv73OtTPYjFjg5xrYIwKk9Be/RlYSN57UaaohA/ZcmnmVGy7N09i8Y1XhuxQTnKcddNG8jlbkg8yh8dK0Xm/EXwCSCY1mtMjBfd9HlHfl9vET22KKDNZ3EfrH0Q0kRValXbbFEk20LCRb3VYywUaNcm6p3GkSciElmctbbkFKcfqZc2z3Ya7lgjDnibPeQ91A4nnXEkzZx/PXyk+wlhF1SPRzC5boKLfVPcMj5twsg2681ZZfaESLLVsLYN/vnhZXhUwFhfGytSQuC+ligUcbI9O62KpRbQ==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by MIYPR04MB12597.eurprd04.prod.outlook.com (2603:10a6:290:7a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 07:29:34 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 07:29:34 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net] net: enetc: check the number of BDs needed for xdp_frame
Date: Fri, 26 Jun 2026 15:32:44 +0800
Message-Id: <20260626073244.2168214-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0285.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:221::8) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|MIYPR04MB12597:EE_
X-MS-Office365-Filtering-Correlation-Id: b52eff9b-423e-4f0c-2acd-08ded354ab36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|1800799024|23010399003|376014|18002099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	3ZBa4cGw6iusZJhTt4IzBKXo9SNXFJ9I7eME5cHLjT8lUdSXw8rOOtmkZtREW5M1xY0/BWojaK/THel6PHbSlPpq8sHtrgIOMpNXilQDOi9cRHNSW3LLJwcd3Sx5+X0snTXL7VcE5IZ+uvVHZ5pjsyGrxGJ2K2IOE88XCtc9sfOjJVClYSi42pzuJ+s+gi75DbYyxdOPDYyXGwyzVzGXdFqcmC/81az3UrMe3tFbda9MdIJ46o+CPLCAWpS/OMeyPDP246evbezOlhLVotd6VFtN2wzhURBN6RCqQf8iEUGfANgKso0OWEMcCfoZ6jCzJ2p5NUBxHW9xBixXa6mHf1Zjpo/g8gUy6okrdl/2GmQ6zV+5dzRAgElnowzt2Wwjz9BpPyGnn6MTwiwZ7VryydpM4bPm35gV3kj4WGKqIY4wJzUtceK+cOrSRzOC0w5DxHwVWE82qu4H1lis2Y6r9cRLc3b6cx19DQoyOa2wbzVQPUKlcKDfn616hRs+wiU4lsJbUra6gEp/pHqxoCLpbuzrqlEwnRAJ2vPU8wkixDC8MPLmse6w9w+oLGMvpOSLRX/UKOhNmSN0duACqiPsyGlPtvsPJgRmgvdLXgh0Gnsuvkl3jZ/xv25aaIWj37YRLZ7IlhUPr90bWEIQxjMbqr1KQOEIoha0LanQ6StyqD/t4gs/TuGRvZVgrXhwOWuuV3l7WDQkS4cnmxGkq+TSrw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(1800799024)(23010399003)(376014)(18002099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5c/YMb9kdOT9fHPsVrc+xXj4eEu/jEKVAtHRXIEy1bdg3m6QELLpAgQqWXhZ?=
 =?us-ascii?Q?22RRI+if4Nb2b1uIlZGgIV5SjJ8GwupILpZTaMTkeYj4SaDjw7mW5+W3PVbu?=
 =?us-ascii?Q?90KNMZwt6qQ22VRjeRfZQ1mJeerM/HImUedBh8Lg55UDmQr8o7O1moS25Xen?=
 =?us-ascii?Q?rFwK+TNE+BP8LU5VydjuMDHlZ+fQwV1kZltX+/InJSUmYoJsFN0LXgrdlf71?=
 =?us-ascii?Q?PLu5QsPuYIc+8JdQMml8p1Bjyu239RAUG7Y7sZA+/IIvf4dUDpO+1msPPqQu?=
 =?us-ascii?Q?o0r2DGO8jrAg7I9RsuxYcNl+LOvbShlqYGvlfWDCOYA18QJTnO3JHw6s/z0C?=
 =?us-ascii?Q?wTZtORIfDcHpoISd8NcNmFEdI1tbwAUvMo7m+kw6FDCkokGgWzBTDnZnDW5Z?=
 =?us-ascii?Q?io6ocHq6gM0frpEa7ZR/0hAApWs7C82GyMHsl4YsrxmGvOEPs6uL5A+kD3dB?=
 =?us-ascii?Q?TNXfiXwrP+y00mpp+16Fp+rDQ+L33YQxfVkC9iWrg5FgV1JJoLfBxuZiIRuN?=
 =?us-ascii?Q?6FfYZqCotbtvkQ39mWz/7uymAaJ7laDHVty/nFI2DbHFCm82YO3rXetUJGiX?=
 =?us-ascii?Q?3PM94TXa9mIE5W1B7vEyx2GM1PlzZwFWEGhE6t5uKs606PwwRR7F6wGOffx1?=
 =?us-ascii?Q?oA5OHXpBMRC2BBLVbgTV0RhGZEYvggU/rkxU914HWJ+fQ0hCXB9YDFNKcm2o?=
 =?us-ascii?Q?uvPvfC2OJRQ3g9MqZFCY7gFnOppZ2MrzlVzZR6kgZvM700mmSId+kzYOtJdB?=
 =?us-ascii?Q?nP27ds8WwsQhg0B7lEI7VqXJtU3TQd/pSso5MPJ5ZhGbJ8iWnJVrXAq9iHsO?=
 =?us-ascii?Q?bk3L06AlbL+wX/CZQ/z2rw+WwstumpwB6UOSn7GSD9W1+3mP0RreMHIt8aZn?=
 =?us-ascii?Q?sRwV4fwu44diT7ZE6lmf4LazHbsTQ9nO5x0TU5+nnoPTRrQBaz2YBetjedCb?=
 =?us-ascii?Q?/cZIPJAxGOljSf9UUCwB+nGQuR22eP78ieCM//dfagk1oemDsGrwEPkhykaE?=
 =?us-ascii?Q?0IYFY1NmTrbQqufE9OLbI438jUwHk21yZvLPdSkw9M7r650Yn9qPMJwTfg32?=
 =?us-ascii?Q?7bk5RTcMFlhdQABFk7fzqp0h9WF7JQvXxpf+feSB0SFv25eo/EWgaHwc4aNA?=
 =?us-ascii?Q?7BgdVzyE0Ihim9/PlH4Y6wMzeMAaPCQ/rC4ve/9rEDjh3jBo3mQhBIpZso3T?=
 =?us-ascii?Q?nzN5KskHBMMJ70bc97lGMaUwwc/p1Db7Frz6Q43S88/rYk6IlWEAEWKRBlFE?=
 =?us-ascii?Q?OBA+92mQe6/szfr2TPjy3JzxjOfOCVTN8UE0P03LQ/KpxTXBxvWo48hXG94u?=
 =?us-ascii?Q?HyQVVzPhQvTqmTbTN7n4RomWU4zvtrQWA3+OGikV/pN8Dl+5m26T/CyN6gmV?=
 =?us-ascii?Q?36yIN4zlgzjPhZ7C63NYKnYYDEGu6KB5jk3E4yciu68TgDwkXc1WMwYV0v+2?=
 =?us-ascii?Q?BcfCIbE+yT+RXrRlXE9BCk4zg+mkJ60g8Cq6JTlaOctcI9PB2uYnCTiJvXtF?=
 =?us-ascii?Q?NTjXiMyTY8Jeopr/MMueATnYaHvHI6XLg1mW9E5cizADdCG3Wgfjo5k1R0EY?=
 =?us-ascii?Q?IUuHSUkuYoGvvVAeTLyLQ9L2RB+cMiT/unD/TsfkVt/Lc+dKpRyoSvPlyyQL?=
 =?us-ascii?Q?MkMxj+V5ujGd5s05tF3gnYVhoyOfmdsbTFObGrS/09ZfYXFPYWybr5R407zG?=
 =?us-ascii?Q?AJ3XZSkXyd0GaMztbcfWdMmvg1v6WNK0s+u2vQh4XnC4WAoNy8u8MJhpY7WR?=
 =?us-ascii?Q?l75Od93LFINeM+MRrqPWs59N0LUdAApIzzp1k5bNBARXKV8t0WDa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b52eff9b-423e-4f0c-2acd-08ded354ab36
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 07:29:34.0572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +oyZFZpDBuWsfp3f2grvX/awQfhEOEr2bxqy1tAvGLBXbtS+u0oWawMnl6ICFvZQKViAQLS/3EvYo9lyBvvRNK11SShSPqIFqpJdRE/+ec2UaAwhvnRD6dIf9a0prU0r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIYPR04MB12597
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302110-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:wei.fang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.nxp.com:mid,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5ADAD6CAF20

From: Wei Fang <wei.fang@nxp.com>

The size of xdp_redirect_arr array is ENETC_MAX_SKB_FRAGS. However, the
number of fragments contained in xdp_frame may be greater than or equal
to ENETC_MAX_SKB_FRAGS, which will cause the access to xdp_redirect_arr
to be out of bounds.

Fixes: 9d2b68cc108d ("net: enetc: add support for XDP_REDIRECT")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index aa8a87124b10..8e3f345dd9aa 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1783,6 +1783,7 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
 {
 	struct enetc_tx_swbd xdp_redirect_arr[ENETC_MAX_SKB_FRAGS] = {0};
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct skb_shared_info *shinfo;
 	struct enetc_bdr *tx_ring;
 	int xdp_tx_bd_cnt, i, k;
 	int xdp_tx_frm_cnt = 0;
@@ -1798,6 +1799,12 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
 	prefetchw(ENETC_TXBD(*tx_ring, tx_ring->next_to_use));
 
 	for (k = 0; k < num_frames; k++) {
+		if (xdp_frame_has_frags(frames[k])) {
+			shinfo = xdp_get_shared_info_from_frame(frames[k]);
+			if (unlikely((shinfo->nr_frags + 1) > ENETC_MAX_SKB_FRAGS))
+				break;
+		}
+
 		xdp_tx_bd_cnt = enetc_xdp_frame_to_xdp_tx_swbd(tx_ring,
 							       xdp_redirect_arr,
 							       frames[k]);
-- 
2.34.1


