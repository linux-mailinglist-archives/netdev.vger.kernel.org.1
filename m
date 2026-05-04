Return-Path: <netdev+bounces-283963-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oInSJtPM+Gma0wIAu9opvQ
	(envelope-from <netdev+bounces-283963-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:44:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 007524C18F8
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD5D43011BC0
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 16:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F035A3E0233;
	Mon,  4 May 2026 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lre3d30W"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012046.outbound.protection.outlook.com [52.101.53.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977979460
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777913026; cv=fail; b=F8adnPIJR6k46DNdez0UlsLtlgqmh138c49b3Q0e0xVr4//ccalKrX7gu78OSLUgtIqVIwDVQmQA9ytfwGu78ATZc9PBQoYXRMVOvi7yY6w4L1xYqqFiNyU360a5a5tffOQEh4DneShrgR7Bv1Gt5F+Rg7jO3kPngoXpscPaYKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777913026; c=relaxed/simple;
	bh=V0XcczcE8EizLP7ltqPFgAm3hY75v0dK7xXc3rEjl6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y8sFQDS5UFkwJ0QmBox5b9XJtYeO2vcKYP9KYZ2N+WAgMP/NFLAXy/VRpRBe+D6fWqhOrALCFIfDCQJcin/tBjrAgKG9F99eCzX6WSHd7Gw3GTUsoU2xEMTh3DrUukjLwzsqsIgS5dqUsYO1/9bI0+1pekxU+6Jw9+yl6GloqqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lre3d30W; arc=fail smtp.client-ip=52.101.53.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIrWCysutc1WqJuFRtASwxSSND8rYvcj16Dt1eWyAdIX1wDkLrJDauAox0/vEx7/VHFOgBWm+aRyPPsO69b/pBVAr1XsRubSlvIOOoJ1JowPr5rlUFO4WKAtiTHHDoh9+hUwharYrBIfnzH5RMdyLu84wcyXu3MzBe+VILPtzSagU/AvdpdcWsoTTt5HyOnYNJzcE6O3M4goLoyjTJ0drDlB7rSuWUTfPaaZxrAVi7ezV5kGGzFSzKC3Lnr/MMRN12TZD/YD5opSWkho2kaWYx8DqtqNRQ8DWedauToZm3rQrKWE2CAXIHDeHo4vpxQ527YJkEp0/xNFDMBY1VY+xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWju6+dJ/JBS6/O8nRgVOHT3d0a6S70tI3SPV+EwMpk=;
 b=ldwyPzYpavjppOLRAaS7uFfrIY6nZbvSMOqvbDpLb0HnxMskslCkPyr2NyuyK7rgxVRJa94ccAwzY8iSUsMyemoggESsM1FC1FDAfu9kStsizrx2hafarT7JhBAgvwNAevGrkgBxYj9mfoDj2275W25dfmx38U8LEtE3KWHGA6+tkBBcKRNthrx5tLEc74ieMmHGCp1RHMlizuKqWkaak/gGLiANVzvmbxSVU44ERVQIqGujtEJjmalBYWl5D3J5T7slXr/twwqOMAhPzqvzo9653T6GZfcwbx17DQRsmVWJYJ6NoZyQFZFGRB4TKKVa5mhHMQ3LTsiP/Jav8yURcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWju6+dJ/JBS6/O8nRgVOHT3d0a6S70tI3SPV+EwMpk=;
 b=lre3d30WoBYQDaMc36uWnarbSL2dKfOGkMknJm8AcG5I1zwnQnguQnubz0ruG5yJGg3c8H8kZEZhahYBz4lF12EocppP0ecsfdMHXVBr/S+PnI1q9df0e+ilsT6GAuMKAbtWY1pX+/ZiGFpJDFFEiMZuiC+kiE54lKvTBXfh0MIGBeI8FbaiCM2TepPu7UK0U9GO3NFoXcumR986MOx+rp2pIVMbgLLXreWZ854W5/AHg4YE8QguzR2875+v8RAVAKBsmVQ/Roxq9SSi05WDY1gEPia4k0/t9LJn8MwDYpREk+3eQuRG45DXdxM8efDuhyH/FBXppl8HUSwaGLwtBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY8PR12MB7634.namprd12.prod.outlook.com (2603:10b6:930:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 16:43:35 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 16:43:35 +0000
Date: Mon, 4 May 2026 19:43:25 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	syzbot+01f005f9c6387ca6f6dd@syzkaller.appspotmail.com
Subject: Re: [PATCH v1 net] ipv6: Fix null-ptr-deref in fib6_mtu().
Message-ID: <20260504164325.GA393023@shredder>
References: <20260504064316.3820775-1-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504064316.3820775-1-kuniyu@google.com>
X-ClientProxiedBy: FR3P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY8PR12MB7634:EE_
X-MS-Office365-Filtering-Correlation-Id: abf1bdf3-36d3-4b0f-d198-08dea9fc4903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	snZQqD0JPs83uxN1rUhVK3MGDCc7eoUDPesasTRCyM4PbWdMS5n1f+YAQvVoKUZlkDNe6dmJNCai/O4KPyQwWEzLq41FUa4PXS2ZS+OHDIL6C4pBqWc9uY2kOPq/iLMFlOodP4N7y7SzC902QNMvG9N3gEuK49WwuCKuNJiJheNQnfcn7dAhw3n41S3poQsieEHECZex2ioYImRqQWAa2eavCTQtUAagLrL/Gu8aYm7m9RGoJ+HATs4aHyxYGbTO+P2qfgMPnNSMHd2FmceY3x5Sw+FOFIqIJjDRv9wzkNaaGkwVc4HnADV3EfI2NEuHQRYiAc9q3pO8uQ3x4P3f9sZO4vSHL+YFz5gpi7FNGQwfmsQ8pDGLDecsAFjVX/G3yX1TlwgVxWPae82tkljLRLZXO2R03BHyQEh2bX0jZohGiCqAUnn68lfI9J5QvTRPC9L5cULpt/3dg9uFCip5zAcELox0+4tSZhQq6Xjfw80Z+gm7+XBgl1IM3AS8SVuYfeqZ4ZERAe/v4CxMajIpedFl7USaKNrH95iqUY9GHhbBJoZKCHYeAZfgt2P8Hj+Juq/AQasLt+DeFsv8SFCSsMfdRUxOY2yfmcUrups7mAtlgwtRkBRoeKXmzCV6CPkpjZwjgMK6uNBjVZ4lDTb33Q/f4Kj1i74u0UfylfblyjAfNlR/h2t/Du4XuVSydZxW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pLPc/k997Tmp8CB+W4nmcMnpKjAiqKzXitQgPgevu51yQ1wpTkzKteBSGQSJ?=
 =?us-ascii?Q?2DS4xGQskAXFwmv/xl1B9ZZs0zGN4KlX/fSZ4FQPj1kaVeaIXq7Y8W6VoqEj?=
 =?us-ascii?Q?HvAzQu9I/uSFCGEphUW2p9obqel84I+Q/CXWvN3A2Oz/sedUSJ6TIhwaaRCF?=
 =?us-ascii?Q?dgWe1h9y7vOZ8DZsvg90z4GCKKB6G7Iyb7hj2JjmkUAF0sBPfQdibnLZU6Cz?=
 =?us-ascii?Q?pTIv1bL3JqApBjUr89PMcEcqCAOWIUwf3vd3jN2Nq28uP6dt+AWyrsBpuEpd?=
 =?us-ascii?Q?mfD9wDlcV5ZUSd2SSgvSBCwFm47c9CP97BEU/EVdiPUFua99GSHuu5+bVY18?=
 =?us-ascii?Q?tMslmufoQ4fpo0jRAF9E5zeOkQJZEucLLqcaLlfH/WhcfeDw1i9UYT3cfHft?=
 =?us-ascii?Q?G8VzO3IBmDJ2HYhxBrh/CPO5MdhNKszCWrziu2YPWy5w7HxQpxilo8E9RdZ0?=
 =?us-ascii?Q?9ZANqa87W/KHlWiDy1q34EPVwv519EE1nctssgt53lgJ+NVtDIMv/UxFg2FP?=
 =?us-ascii?Q?P2TnuBzqDyO43602nZSebZeYdD5iJ0LWBsJLWPYHf8Q1w+El2XGilU45nVge?=
 =?us-ascii?Q?Y36m2tYae+tNwt3ZM1DyF3U7HS4nD7pfxlEsdW4qFBanawyysbbJihT+7cKw?=
 =?us-ascii?Q?Jw8ovS9TxJqyQadvEljvKGbrYojg2ymdRNxYQJt1B1FI/cGU2lNne8N3ovEh?=
 =?us-ascii?Q?onmEZJtPGpitI5VGTsX2Z2mXe3gVftXe7exGMmRIFdgcxZ8bn19BUwPAl3az?=
 =?us-ascii?Q?DgzBB/PdOIM3kv46DyohX8RFkbfGv0mUyo62wC0TP4OCci8qybUonryzzCrG?=
 =?us-ascii?Q?yMkCQXlMyVRms7WimXNzJQTiKWYPuwCbi1TzqGvtnEkVampjULsVB1sIIqx9?=
 =?us-ascii?Q?Px6Lq38Bw+9i66cs5Kgx409fRSaK+6X7WOF81h+juTLdvBlAoo1BiEn9jJdU?=
 =?us-ascii?Q?bZ+nqAfOJOHdMuRfiOapijF5WskkdJBtsD7L1WHRchasYCzaqz73Hy+TWCsP?=
 =?us-ascii?Q?r3BU6COiGVu7iITJLdtl92AuUTSiJnm7FQgllMOPE6vLs25sn/Bu2FAs9EmL?=
 =?us-ascii?Q?5UN0wAIWBBal1HMCabOsSjwOK5ffJJBnjqZDArL5vpQOHMecdy3lBYsim1I4?=
 =?us-ascii?Q?t7QVo7iCykVrwvKJj/1kHQWuFixxDh9e0g4x3ZlWtMr/SgNydAKeSTfnQV0l?=
 =?us-ascii?Q?4CSkKIKSehOFhu1JXXa+pucSENQzg1r2QdnJdjIf35TQBepj9WXUR3nQLdW1?=
 =?us-ascii?Q?+1leV34+LhQT4v2+OSII+44lC3BJUJL/jnL8OAIzJFSn7XkBSL2JjDuYigJX?=
 =?us-ascii?Q?l2Om5Az1Pvdm3+Hzx8rlxg3eUVA9eW5QcXd20bs+7y4esJ7HtDJCn2G9jMPA?=
 =?us-ascii?Q?jhcK9E44fhAPYzlpkUd3SF7Me0/7Ht7pYk9gl6IEEmakVJzxektOW7wjHpa7?=
 =?us-ascii?Q?tTUhQ/HUem5gB2kRL6zzH2ZxfGIrOic2DWvpESqvyDFopZ8ujjGCu4VOcs4d?=
 =?us-ascii?Q?EYCJwPBZ4hSJ5Aio+06v73SycrP5jlN6rSwoQacM4NhzYl3FqH0mtXW6GSHP?=
 =?us-ascii?Q?yjYSiIJ/3bPbVMMMLQNWfJN/JzTCQm6HOSz8vsDdvLOBVqw+tZMzdYJxweh6?=
 =?us-ascii?Q?+Zhb3F4u4rWjZejSgLtena8ZC4FkJWyM2OFN5+p9sYvmf5ud3jsF4DXQEYvY?=
 =?us-ascii?Q?AzdVprcF8WaSwU9n07aWr2lU84Gbk+1WAA+ZMTKY+9zhxVp0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abf1bdf3-36d3-4b0f-d198-08dea9fc4903
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 16:43:35.6179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5h2R7ocGi9X7U1JrH0Lq2nFPgU2huhDwohX8ArQHwMfKttiRBzfWKUkiyHtlAP4FlNWANXBWX1r6bqmaCY/LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7634
X-Rspamd-Queue-Id: 007524C18F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-283963-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,01f005f9c6387ca6f6dd];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,nvidia.com:email,Nvidia.com:dkim]

On Mon, May 04, 2026 at 06:43:13AM +0000, Kuniyuki Iwashima wrote:
> syzbot reported null-ptr-deref in fib6_mtu(). [0]
> 
> When res->f6i->fib6_pmtu is 0 in fib6_mtu(), it fetches MTU from
> __in6_dev_get(nh->fib_nh_dev)->cnf.mtu6.
> 
> However, __in6_dev_get() could return NULL when the device is
> being unregistered.
> 
> Let's return 0 MTU if __in6_dev_get() returns NULL in fib6_mtu().

[...]

> Fixes: dcd1f572954f ("net/ipv6: Remove fib6_idev")
> Reported-by: syzbot+01f005f9c6387ca6f6dd@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/69f83f22.170a0220.13cc2.0004.GAE@google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

