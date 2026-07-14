Return-Path: <netdev+bounces-307432-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 83jQA4seVmq+zQAAu9opvQ
	(envelope-from <netdev+bounces-307432-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 13:33:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B7481753EEF
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 13:33:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=p6ROsv0B;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307432-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307432-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 31E75300917A
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C1037188B;
	Tue, 14 Jul 2026 11:33:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013033.outbound.protection.outlook.com [40.93.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575DC367F48;
	Tue, 14 Jul 2026 11:33:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028809; cv=fail; b=hclJeshIuV97AHBpAXTC8LOXt+GW3yUgvTBohAdSP0RLkXMwhomrFC2/gYSlWrJ0Vmkmet7G719lZGCHRswjoW4QAVKJk/jBBGKboL4vXi4E79KBBF0UTzrQzWYXHKSYdOSofcobiA3gKG/p5WDfGHTlA/0Ho9AvK1T+HjfL0J0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028809; c=relaxed/simple;
	bh=7iY9+xM/Okcmt1SRkQGLtdppJGRcHHR16bC28/VjQEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ntnkzpNgcGhoTVae422nd3Qz64fSA7VkJ9fy+X7df1XrcfaHpcGTIBBIdtxrwRagqmfWj+iOLb8MqTAqcgw2v9H6a/dUIx4MQ2Ifj3nlxgfQ0Ugw2vBqChxT6+JRtIpaQeTCBEpFvcayIv1whubyFW2QvwoBWUwzqg7v5xRxY3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p6ROsv0B; arc=fail smtp.client-ip=40.93.201.33
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VywobrFXCoODk9O7VT6g1FfHOOj1k7eJQ1hIrzbAJqJcDDS8X8SpI6c+u/Y9jUALzArDWWZmEaYDDcoT5J28WxVYo4bZP0RSa3FanAMDcwkpCmY4MEPnmWC/NfkT9ErEkEc7pkjjauCluu8B1BAuDCUmPkPpwb0dxqyl3XwLVrwGZlpFuPk1oNpPefaQiMEJ1q8eQjIHeTbPPJ5puJ1VkOpv35Q9B6x4yycwCxz88nBTYzm92eP965QyhoO0ngop/7g6Y9/f33OQtDElLP0Uk++swQN7UPcQoNkWR/4NoAUBr+dJpxPq+ybhm9XOvQ9ZA1BJfHIgcDUUvFyQ+ATFFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHrt9NzVsHqF94vWVTPQNHdF8D8akXYZdcyAlpWDdWU=;
 b=L7B2Ucv/aGkaWvvLZHpssBLOB2tSAT8h+S4guIWJUtNOxnNeOYmsYo7w8YZ+tLsiyxRpTXy+St/toyKLPqyb2/wHoAR7uKoytnd2bSGsSTywXqFxfiT6mgLWqGR3YPxefWAP+4QTDMiOP4NR7AdXWk6YQF8bAkFnlkwKmjeXkZygbLykh9XaeSS0Eq43D0JQuJ+sMxZZQrpt2agUnNzTdiLPH+Op+lMuTT7FjJrDGruMnCgPGiAfDw8OmOF6ZYgBGVCRAz1rqt+tW607BEZ7lh9r4fjnn2sogk5KMxa478uKVPjN5+OZ+J/D++AIUMa162o3bc1ggQLNYvQ5+a7zaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHrt9NzVsHqF94vWVTPQNHdF8D8akXYZdcyAlpWDdWU=;
 b=p6ROsv0B+xpAliVEg3NQayNf6saQ5BCmWcnDjXsYSx/D/4YKnGgCy2tfgfkrWTOTnk8QjpwBSErGFkiWPxHy/ut+V3+6SSf+ITP2bW6xmUE0KnkfX+BRM/hQ/MZ8nNwfhYAfyws/q0+/8XKStZJV9gUeclXrbpSJadwLeO7xbC2BeTa7+mLj12ddiz3OTPuwYDuY3ItksaAO0tUrP9YjOg+IsqtuZsMFGsnLRthB1vMPsS2QnKphZw0zo99L1ZnkVBWC47F5R95JVXcdNFGoY5IJ/TrLd740EK0PHL6rdpCuAma22LJ9VCXLu07zH4rqmks/yPE78gVFM/9aTjOTxQ==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA3PR12MB9197.namprd12.prod.outlook.com (2603:10b6:806:39e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 11:33:24 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 11:33:22 +0000
Date: Tue, 14 Jul 2026 14:33:10 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: gre: fix lltx regression for GRE tunnels
 with SEQ/CSUM
Message-ID: <20260714113310.GA868099@shredder>
References: <20260713150945.1779628-1-yun.zhou@windriver.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713150945.1779628-1-yun.zhou@windriver.com>
X-ClientProxiedBy: FR4P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA3PR12MB9197:EE_
X-MS-Office365-Filtering-Correlation-Id: fdaf212d-5378-4f80-da5b-08dee19bb5e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	gYXNTrk1Jo1ATwPj2BvyyeEtGm74c3FzygOOEE29iYqWS5bGxr883qIjQSynrs4uG1KPc1sbpIFX0/p/ea8ho9UJQOxcX6lTvVUbm/B0SEQAOvPa0tjR0MTFqPjKfrNpZ3KR6meLR3C6UwKGYJVP8dgnd2uTp4a9E30ZLb4OXFN8StgETgP4r4k2ZDwXUMqBntGnQlNQfHWIn3ryWybiHp9XB3BJBCF9sxqmdHeD8UD0nyalHe/74yzyUvjMnrHkiq3T1rRYBv8FLUyplxl29hakz//OcTBOJoGAoJTRNoiMa3/ei/AjMTxbDtjYtJAePkcoEeaqddiICaF9DhrY9CMur7u/VswjHbZYAms3obl0xM4q9nA4KgEdkZyFl2MW5clkR9bN9i0RZBqulQpgRltCAs//IwCfuhmnzyRWs6L65WN86ZLfLC4QT/7HROarWI57zcC60hzxA/FMeYevpp3X5RcElQfxE/Rt1kOEVWXxf7GgafJaeOU5/2soy8QNwS30GPCF9VprLfib2mGEw3CdFYAsJ4gwjC9DLweKaJFYkHwJc4LcJ9/+Ib2v/xHU3MeHtscMoH+Fw+cUQ8M8ojbs706q8y3aqNGZEn4fcaOSk/sa/uk+Y+W49wBqiDhfBkvIsNWcFiBLKMEm3H+xRqHmizd7QjpytU1djy9RkTU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t/ErhB+Mp2Y6rkLyD7mOVcg9Bmo1aSRWSjkpa1FGkjamEuqh3Bnad2nG0SwZ?=
 =?us-ascii?Q?DbKW2bug+eGb+NczKMLl3it2Eqh27aijDKr+6SiV5RUUIkKMb01OoHruCRYO?=
 =?us-ascii?Q?mkHyKz8xkIU2FbNqR86Wkyaxx3j0gOsd3gasKNGdvRlFL+kxIIjcZp1vOzSe?=
 =?us-ascii?Q?E3UBU36vUTrD3I45mXTaBJFPqTtz2w8AbaEB1ZSv3r0zqXdptw48lAIT7Dra?=
 =?us-ascii?Q?dijCnkrOnoiXCbdpCKgJKFmBn9dsbaZp4TTouOhJ32mQq6sgod0SxJIucnkR?=
 =?us-ascii?Q?435beaIdOG7WE3nQpWUx9abb0riqxJSdvR+DeuGcQnKN+AWhZ5OlFbqqRscJ?=
 =?us-ascii?Q?3P5YY7tQ3AbVa/2PfXm5heVkaw0WV2o8IRUJii3jOrbOkG5xUExnZnylAJ/j?=
 =?us-ascii?Q?vYHkh25jcASVauwTp0Ukn2yWJvIdJAvvqhN/PS0DG5FRi9pXVxGp8Qw+rxXK?=
 =?us-ascii?Q?SNlVW1SCRL0JSvC4nUhAEXobcn2+LbOl/uceTfw1b7SDwqfdFQcUJpdiP+DJ?=
 =?us-ascii?Q?bnauNPuQ6fKAfoUfJn+zQagm6BSfOAXKCv0XVBL+CFx5/dMeM1i4HG+8UJUC?=
 =?us-ascii?Q?UugJNnsoMMvynfr9qNQif+5JqrqDAt/QYazgtA5aFrQ2uPXBxk7Og2QFZtPa?=
 =?us-ascii?Q?VHcU8GFZAAmt3v9A+UjbmGE4LZ1wxnCE7nIi1Buc6BDaeO5ohKQgg/G6XUL2?=
 =?us-ascii?Q?jGa+IBXa9iDIb9PNgtHB6rYUkNIf0af5qN9RusYVnaZY5CA+rpnyqd4UDAjq?=
 =?us-ascii?Q?liR8YOggvtA30ThoysIe0a5p6nVgqzQjoyRZkPl0NOv5rn5p0eguWPp4qOS7?=
 =?us-ascii?Q?RU1cdsTIbjJDTrpZmBv1YnrWza0QcJLBFZZBWBep7+pFyRLf2ME+hf5Nx6A8?=
 =?us-ascii?Q?5xhs4ZQNc2OE8Zg4rYZ/QhHSEaOAELWll9bl7XB24cPS2LbtpKWWbOYT1JNT?=
 =?us-ascii?Q?CoOWQjKOcKCc2ZVs8eGPiKfG4v8c4tvSzHfD1fdwYb7rgp8h4rgjwojz7QvY?=
 =?us-ascii?Q?HFuMo6WnBAJdVnP7Gil8Rhirlzci6HYWKh4JPd3MAbLJ6HZ/X09UbzQh738Y?=
 =?us-ascii?Q?V++bYYX1EKiAgKWOGWyYy30xryQJY30/HM0Th4u1ls2il+R+MKGsi09VO0Hn?=
 =?us-ascii?Q?biutDfiSuXTNzEQY6FW+Z8XerxcuBuL6mzlmcL0oYVYRtDsRaOSsxxSVahdX?=
 =?us-ascii?Q?Dr+AC5cIAWoyklOaovHuk/3QSPA23CWA/Ft1jhr1WiPfamteH1Y85COBuf+e?=
 =?us-ascii?Q?tyttC/az4KeLdvdgO9CtQT6wq3M5nuzIKZG7Wz3uRJ4m7/q+u1PnhvDtzHeo?=
 =?us-ascii?Q?O7n9+CNTDXq9JGXz8giWxBJ8bdllc+P5aejg4f1DUyRGbDpgjFYpTcSgikQN?=
 =?us-ascii?Q?SQ4To0MW+MDSZ2x7mcgo23B6jkLPVTUQ8nXLBIksfz9YAiByBfN+8TWj3d61?=
 =?us-ascii?Q?uCNzZm7rCOJ2hzKsk46IkqRH7tXUd1/pwfjH2XWJBb18g68LiTbsONb7ZJXz?=
 =?us-ascii?Q?9+WRHXKvGX19zOMPw0OibisfYwzLAQO75KtfljWdAlE0iMcgjaB3OjXMp1vD?=
 =?us-ascii?Q?rvEncmTh0M7/7xSATzFd6ExYPWzqHlqMxHSdr0tY2aAyXt4JBHfTFO5brUXW?=
 =?us-ascii?Q?tLrQg5zstAc7LndCDuFggYVcxgccQXvHtf15xfKPKIYcmuJsQ3YZRlawWZsF?=
 =?us-ascii?Q?gn1VmoHdhqacwl8l6sPLdnE2YHse95T0gsic5AF71ttCq5PiCqat+JRbDykq?=
 =?us-ascii?Q?Hp2xHhNBXg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdaf212d-5378-4f80-da5b-08dee19bb5e4
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 11:33:22.3165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNYWxI8KtHWi0Dy8Ud6AVeC8H1DDlyWhiv7A7ImM5Dwsa2xDr/WlaQ7w0IJiZaK+zJHnNaC4s0uc0ML9zz3VQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9197
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307432-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:yun.zhou@windriver.com,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:from_mime,Nvidia.com:dkim,shredder:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B7481753EEF

On Mon, Jul 13, 2026 at 11:09:45PM +0800, Yun Zhou wrote:
> Before commit 00d066a4d4ed ("netdev_features: convert NETIF_F_LLTX to
> dev->lltx"), NETIF_F_LLTX was set unconditionally in both
> __gre_tunnel_init() and ip6gre_tnl_init_features() alongside
> GRE_FEATURES:
> 
>     dev->features |= GRE_FEATURES | NETIF_F_LLTX;
> 
> When that commit converted NETIF_F_LLTX to the dev->lltx flag, it
> placed 'dev->lltx = true' after the SEQ/CSUM early returns instead
> of before them. This causes GRE/GRETAP/ip6gre tunnels with SEQ or
> CSUM+encap to lose lockless TX, reintroducing _xmit_lock acquisition
> around their ndo_start_xmit. Since GRE xmit re-enters the stack via
> ip_tunnel_xmit(), holding _xmit_lock risks ABBA deadlock with the
> underlay device.
> 
>   CPU0                        CPU1
>   ----                        ----
>   lock(&qdisc_xmit_lock_key#6);
>                               lock(&qdisc_xmit_lock_key#3);
>                               lock(&qdisc_xmit_lock_key#6);
>   lock(&qdisc_xmit_lock_key#3);
> 
> Fix by moving dev->lltx = true before the early returns in both
> functions, restoring the original unconditional behavior.
> 
> Fixes: 00d066a4d4ed ("netdev_features: convert NETIF_F_LLTX to dev->lltx")
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

