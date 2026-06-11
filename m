Return-Path: <netdev+bounces-298112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lTxTL82rKmoEuwMAu9opvQ
	(envelope-from <netdev+bounces-298112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 14:36:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9B9671E76
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 14:36:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=XEGjQK2A;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298112-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298112-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAC5330B141F
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814DE3F6C4C;
	Thu, 11 Jun 2026 12:34:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010063.outbound.protection.outlook.com [52.101.201.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BB23F58EF
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 12:34:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781181243; cv=fail; b=LrmzNoyrMPvAUhrS6+dcm2BE4fzZyxGX1cmSANd5oZLGdGMIH5kxD0uPGW2y1V7DdE3yzZOBh2O+xSEpuLA7UkAXDF3/knMPiDH0hgkxhEYXwfDMJsUOYOH38XZKTPv8mfYyqboH0aMX5BDHg0a053p3f87doYNjvdZPPUw0aIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781181243; c=relaxed/simple;
	bh=9NSA8uZUXqkXOQqVkjoRy15nOWSuyR+hpstr+t4gWJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=phRjmb0gpBi6FY77GjGwzo4ctSZLmVyK+NpUbccVQxd1W4owXnJlc8Cyyo1NvTXrBQykdBtAgPghVAwE8ZzfdtaF5bJU6auugZ0b/WnnoJrc1gB0js1ofDoYZKV+jBUiHpnB1zqbzQCIfz6yfXIAo2BiFvvO8+hrrEVVWSzy7Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XEGjQK2A; arc=fail smtp.client-ip=52.101.201.63
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJIpQBNZW4k0oJVxmi3tmZrEmI2zPBAC+iGheToGsftD0x70WnFRA+ghaqLultkM9ztKM9gxTZzSmJ+H+G5+VnG+Q2NU6rk6MaCsPsPQ8NDFdhNFfYpDkGjusF7x3hkb7wC7YpAR6BjgzzEGwkGwjyYNVDuW6IcLAbLl2RN4ecf5K6LKrnfliFhkophl5u4DBR5X9rn/QeCVJK8nywYWdMi7an9UieMNxT1lX0EmgJslyM/xRKVAZiRjjcK3C5xA4LE0z5tinWNPlUqP1oHyVfTd+Ala6x1uQncMJAtDQ0rPhSQVv0u3RE9RmmDY/acZf8eqmAmXAgI3wyd+aUINPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5N7PxrKJkGhfeHEa/76X5x2S8jkKK+QFXQ65zcgrnM=;
 b=X4nMRx8B7C7hwa/vtnZvlhf3HGSbkNfuUed4ey6XVDkLa4x0X6GOoIYmu1fiv8IpzXhE/26fk6UStRYVOjmatbS/M6JPIsFnOus1NzG8k5ctRshsyFFfUmpHS1q4rBGxp7ZdQSEClqrBEblGb0xLlouMHLrZXHdLJJ36UQEU46uLFYXvPWyRkz1tAg1bsCwDqBn41MZrstYiRXDHlOMWwCfTxFrf1nd3wz0zrFOkP00Aupq5UZSXewQ/5OFbnILZsvQgXLbVnUh+KtxsDILj/PFDqsGi7Vi3V2YLohrwy5/7gVtCfR76fODnbYNogvJ6tUbyo0Hu2Sq+1jVfGpqI6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5N7PxrKJkGhfeHEa/76X5x2S8jkKK+QFXQ65zcgrnM=;
 b=XEGjQK2AphdhthO52kkVCBknUsOTI3DYZj9l6IdJQx+5v1FUiqCUS99cbemdG5ze5EMEYvpyqES1REJJ7N04ar3rXKpCGbUDP8fTkZ44vbqB0wKI61juzys0tibVXy95/r/z8B/NU8wzrcuINbAj1x+E4TJd6DUpHdUaz3Ja1rSkhD+iRUK+rqMxAxDkS7ATX+syaftE5rcuRs0agqnP2tE9+uZtHWIVi2VZVghnYToQUcJUWQCwCWKQFoAetGoWz1HTRjAGzDVGmdNt55Q3V228VdftyvTEisOMWUHSxDP8yG2M7v5PT0pS4QWY/8wWua30OCAYORe3j62uyLDw+A==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS4PR12MB9657.namprd12.prod.outlook.com (2603:10b6:8:27f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Thu, 11 Jun
 2026 12:33:58 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.010; Thu, 11 Jun 2026
 12:33:57 +0000
Date: Thu, 11 Jun 2026 15:33:48 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Amit Cohen <amcohen@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net 2/2] net: fib_rules: Don't dump dying fib_rule in
 fib_rules_dump().
Message-ID: <20260611123348.GB924647@shredder>
References: <20260610061744.2030996-1-kuniyu@google.com>
 <20260610061744.2030996-3-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610061744.2030996-3-kuniyu@google.com>
X-ClientProxiedBy: TL2P290CA0027.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::11) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS4PR12MB9657:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f5b814-073c-4911-ac51-08dec7b5b54e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|6133799003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	mEPBB9J2EVXGvBjxpQN9aYlpcELV0R7VaHzaogL71Lr7rPY68zlcHh4WPtXsJQB0k5Ya9CSmIA/9TzPdegwybKpcNB4udcYuiTNjn6712nPge0Qg7oP4v6GujwJsk9n6P1pf+a5ANf+ikLAYULoJHQxFwKGlL1jh4u8Yg8lvvIKcH2Y6+jVZ7g7nRUmEXgG2hfz9ty0ckEBQyUbkDCSLTa9it9H8sQWNbpvixjp/nr+BGEUF3ADqUfa4dB57G2+mFd69BlFgqzYsyVK5VUkM8+J/SlOvFGbsSaYBUxoXYdnRg3H0Pz6ZknMP418O/WbnrhFB8GknlRs3oAKluRBLa9K3bVrEb9JZxttY71dWFGePmlZO7BWbL3dh2vqp6+RwzOLzhlGP2q8r7Vm+GJ7FlkIh4NV83lodCU/jLpYPFRSft9xItLjtE+BcpS7S+5Th5xKNFwz9NJx4klTUycsj1/LbVskQAmScZRsk2R+8eNM4G1u7OuU9zYfq8aycbn+V05z+yJuPPBLRzqXeCTNBGStTwGY89xu43QNKCAZ+mykPaRmJp+3pR25/g5yFzRqHKo9xLGhsE9MC/Cvk/d5LCTo57/XUJB76VNe8tdnKjI6uaPNtycGFrjAF0u52HmblSrcUQ9n9eRTf4P/nVQYcXepAbKeNN4R8hgBUAFblxZ3dHag/devBMtwlGE0ztv9B
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lPF9Tp69qmI8oXOGzGHssDJqQQ360gFwlxPgp+GMBteXtacf8key/PayTPmK?=
 =?us-ascii?Q?qnt8+fiTg/yeoOfG1mbrCdAO6Dn1yESRMT4IqjzpIgi9xKylIrHgcGQcv/LH?=
 =?us-ascii?Q?WzD+b/0/ZauDo7904xclfvnWRWarFVr6c6ItbSLbeVCWWH1NZl5l5WKgMxui?=
 =?us-ascii?Q?gTeOhAQoCPBGI0MFvT658Oc1uVQpvjHQn2SJOqAF9JO3OAkJMkZtW/7YUYYL?=
 =?us-ascii?Q?gDtrrsGi2w++fObQMYRJA1jweMrdho4u2t1fmyhtGNLyi/+hjPvKZnO5sjie?=
 =?us-ascii?Q?MpZEr9hqmzB86ilNOuXQnqFJUXCkzN/pOsgvyLSE/HT+Ud52QmL5UtlBAJOA?=
 =?us-ascii?Q?KqamDb0PklcalGDabubSEne0pub7xE0NvJSYQJ5CVjjMyQ/z8VJiaJsiKP+9?=
 =?us-ascii?Q?dVcMHMBIDP9FUDU5S85Sq5nIpHcizsM6IhSQWfI6NCrN4qHTN4qnySS2MGjm?=
 =?us-ascii?Q?4DGwN9TV0Yjfa5nJIDIQPdqYBKceAbvu93ig31iAXjYsUIZ3y6vPWqrZwDmp?=
 =?us-ascii?Q?wHdeOB9P1mwlTo62UUDTCP/i1gTCgmmF9qMHtRfndz6b/CcejJnbOMBTO+oH?=
 =?us-ascii?Q?hxuuvAmSoqQNPkhx1YHvBSVwCqX4ndxXkXqNEe38trn3BUaxYDN3yWeGqnoy?=
 =?us-ascii?Q?KdtMcxx5uuMgvtCLasrGdi7NpDsVzHiozoQjSLTmnRJTxDB2Dg2oB1YYaqvX?=
 =?us-ascii?Q?s1Iii75eBLZ7zsqmoXjredYZRs4mcLaYC9qKC96WnBhrWeojboPjKCqqybiC?=
 =?us-ascii?Q?ar0oKGEZ65ejWwoQy2zfZSKxZbAVKEmMdKQ72q099vxNiGGX7QuOt5DXscCv?=
 =?us-ascii?Q?tNuAxcA9EROH3M9s2v+dTuMaunLojXb8Yk0044wKYOLiiL0x/LaAAObUtzDX?=
 =?us-ascii?Q?wUagbmDRi9JuzZTn6liimXdJLkkEMtGDcTrpaJKHJ2tresSdWADZeUFMbTXq?=
 =?us-ascii?Q?wGISW6HbbP8zTUmTSz18H8+3VsljnNx9Eg6t7TjeHR9iPaGMvfdWaiaxfYWf?=
 =?us-ascii?Q?jFqSNd7NQ7NgduxPXOk3hUByK/iu9g8S0QK1d57y/wMwk8XxZrMZA+BIyrTt?=
 =?us-ascii?Q?AfgLj/z4icIRyA/6d2gvMqAtVut9OyCQqyTcGRPaJOt0JaUi+yS/BD/9Ynmd?=
 =?us-ascii?Q?rPOMhH8lCi8h/JuUdU2kpuzFeWmo5PRaTjSnP00kzJBZLURJiQMXX3wodQaL?=
 =?us-ascii?Q?ncIcLkAY5aSesRQ6idKM00FGgkyTKuUUO3+dQvSSBgJeB4NnJ2lMzIqXebDH?=
 =?us-ascii?Q?/mm2NbrDaP+XaEwMnX4VeKwNJbo3amGp3hAnhEgFPpRw5RYV5yYEDmxUGgS6?=
 =?us-ascii?Q?+8PJOp3PcHwfkoQThsG0B3cqGrBh9RGOCaMCwqu3YjvzN5OaJjrjNl2ccjM5?=
 =?us-ascii?Q?dIfpDXMxsvYaAunETsWZwhuadSRdtuJvJ+f+kqtndVsKF118xEXeDNMfwfeA?=
 =?us-ascii?Q?2SEv6EisLXyylu6OOjm7yjjqjM9y/OF3yuqVkeHK5jcxeN1bvnO2lP/DOHa4?=
 =?us-ascii?Q?HP3PT7VpO6iZKeZjR1SL5DrN/tuKJ2gyDufh0ll8rfvoUZIo8mQNuJ+DkyLj?=
 =?us-ascii?Q?pDm9bUL4lzxn0qXup8fIY+VEnL7WWFpXrOC7HquGnbjy+Sg3rWsGlxCZXe6V?=
 =?us-ascii?Q?S6wgxYVhBeZee8ENCTG9htqaNnV5K617NL784NWzrH8uKDQ9j7QMUvyzGJxO?=
 =?us-ascii?Q?HRNq6ltX0PT2HAnvAXSzHYfVKWZPNg3v3nw7u2+7LUsVlf1L?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f5b814-073c-4911-ac51-08dec7b5b54e
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 12:33:57.9178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yiVKzxmyWBwro853zWstP7plNaMb6FDXxmg4Gep3zyrdvTcw+3wfKP6qzLY8MCGY+0FeJiBmJslMq9j6YVphJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9657
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,nvidia.com,resnulli.us,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298112-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:amcohen@nvidia.com,m:jiri@resnulli.us,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A9B9671E76

On Wed, Jun 10, 2026 at 06:17:19AM +0000, Kuniyuki Iwashima wrote:
> rocker_router_fib_event() calls fib_rule_get() during RCU dump.
> 
> If the fib_rule is dying, refcount_inc() will complain about it.
> 
> Let's call refcount_inc_not_zero() in fib_rules_dump().
> 
> Fixes: 5d7bfd141924 ("ipv4: fib_rules: Dump FIB rules when registering FIB notifier")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

