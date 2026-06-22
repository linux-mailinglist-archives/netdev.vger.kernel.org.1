Return-Path: <netdev+bounces-300964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C6S6FDzYOGrTiwcAu9opvQ
	(envelope-from <netdev+bounces-300964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 08:37:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 716F16ACF86
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 08:37:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=ZaKAb0MN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300964-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300964-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 124BF301413B
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 06:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6691A35E1CE;
	Mon, 22 Jun 2026 06:37:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010063.outbound.protection.outlook.com [52.101.85.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC29340A52
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 06:37:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782110265; cv=fail; b=BM7TksYrRyh2fsT9xeb7ovGQbxuq5Yifl8SlH+DonkF9WIBl2oJioBsJHJTWKdWzBTnSJIrck1i0jQyVEVF+7PvDtLYnAGKtN+SrEVy9BnLxeUm33QHfUy1IfXwu7CHRFSFBiahu0H1tvGL4nayCg1+xwpR5NGJDQSZXpBZSVEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782110265; c=relaxed/simple;
	bh=zf1r+styy33An/l4kQM1oQRV1fCcOj8q89FvLP60q7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n+l7iCbawNjaCJcAoTdI4aNds3RU0AFcRUpBuIK4LPd48xkMX1V5X8eh1zpWNkyJ9OnEXOhte81JIGwIqgbcHLFgS414vKzHR13+O0uiyqE8c73LZsZkN9KmyvDVDVyzTDvxdlWQCfQEw7IBMMFUuZ6zg/SBuvtXvVt+6Jcte4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZaKAb0MN; arc=fail smtp.client-ip=52.101.85.63
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZy61K0Wp9gKV5JjewaYboAbXvXHZ9zSOendvE/8cb8zvyLhEGRhkN4zuIRjcCi+OqEaDv00z21lI5ruHz+1YScuegU8UYfiJkLTb8T3rm79/bAJ1Wpcds5LztrLoyXIn2y6FZ3CHbiLYkG5l86BsKN+6ePz/fu1z55Hf4VNvKiujTTxmy+aT7QgxMcQNYZgD6L5vEUeO7kqsyIkL+eJjpy/Hwtb9T6j3OP+MG4smwG7aXAE6pDcJYEnOOo79sL0eM4EHHCtkDt2DtXrYYkykBWPT26MHp4F6Ke0Ugey1SRwbcNxkMSXvjjPCrQgSS3lb2OdOLD5MGMRB8OPmzg5Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpzCsfNBy7mbqKNeIMCvuwqe2rwOGjrgRviuAJRJMtk=;
 b=BGLaCNWzZuTTQbTblrI2GIiDyfEhQqAKXK/kUo2Bv+g+rhTioeqyrWKZPbXb/INLTB4zHKmmQEX/vn3II58h3CYHbTLHITyl6XsoWAa6IR9SIKxbVh5BbeOwF7oFCo8NDOt4LMKahBpIUbJq1fnZrIXV3wceQtEXkWBf5XIBb5yjKPGaCNCNOd6q8OVGhvxTG3padh47CHr3HtC8jgnU7shMbx0ZjjWl0wliHEdV3eq1CiZM4yNW9wYBH1LeQaPEokQ6yxLRNQL3mBDD1CQrqyjTDqUTIjyjCGxv6GrTtWHxTOl3Is7Xn4m5PkwtVWjTK/duLrfyRfL066hIbf2cdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpzCsfNBy7mbqKNeIMCvuwqe2rwOGjrgRviuAJRJMtk=;
 b=ZaKAb0MNeUToiwdyYJhHcq3h1tr4vj3qFWiFyo4XQJ4BTJZanoWi4nk/wqxtJGzfNiXVusGjlRNuo7eKNXNT4F8uMqHwD0HrJdiZcRqCIi/aeR+7mRNwjAtAsrYGu682VqPW+ytliAJSBqc5iecneKOSXoHx1Pp2bu6YqTF8TxFbRffxw2KIiKoUunFQTv6qABdKsZJNNbIJeVn3B0UgTfYxk17U2A520BD1lPHD6nHTDVBkZkurnAQFOInksGCNzRPlPtOs/L5WD8cTg2opvFyIqAt8vGfvmBeJX5pt2Obpe7w9Qeg3NYLbuVYBDrTzkFbOJ8OgzHEUl6Be2/CJZg==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA1PR12MB7319.namprd12.prod.outlook.com (2603:10b6:806:2b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 06:37:40 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 06:37:40 +0000
Date: Mon, 22 Jun 2026 09:37:30 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: xmei5@asu.edu
Cc: dsahern@kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, kuba@kernel.org,
	horms@kernel.org, bestswngs@gmail.com
Subject: Re: [PATCH net] ipv6: Fix null-ptr-deref in fib6_nh_mtu_change().
Message-ID: <20260622063730.GA72186@shredder>
References: <20260619045334.2427073-1-xmei5@asu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619045334.2427073-1-xmei5@asu.edu>
X-ClientProxiedBy: TL2P290CA0021.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA1PR12MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: 237e35bb-240f-4634-edd4-08ded028c1cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rUSmmLP2Tv3952GpBZalWKfxCf14Whcj1Cz/jNcl3AgaeVDkZmRBrPno2iT6afHlkNv6ecRqLmYaUZnhtgBO29nBkfDWY0yFOxWclqujGDXFbTG8Kjk+JXLhRb1eL3lUJ5OiGo32QwsMJC/bbHXNFDzXz3op+IFV+JYJ7QMds+svuqts4koPCEJXllkhZESTqGo9jypMUCM7Z0ySu1MzhqCUznrxiscoT2z6uhiLqE7VLZPs9wyhddvvMvRLqmnRI7Hebga9ajWPpvk2St62D32wqhVVgITtpNX39+lzCd0+yIGzjdHuuheZ6xQLS6lLXmERrESry5Buo8+nrCQKaexFwIwWfZR9NMK6r5lZ7W8wNN1Yo6P9hbPcMArrHHQZ1ki0EP8THMkm+wS7Ken/HrAqQt+hWWOkBXsLtdfamHaoyMYHAGEdMhXPtfuzybCa1KVl3AVpcPuySLm0UUucix4K/JECo4VyTCDIOSE8oMbb20o++m+MisOAFFCmF6FtYAbI5bHWPjW8DDkVA31xN5UFVJBwRtNat2SJnecb1L7FiVHHsgvbM6ck9fVNqFpKuQqXR3LARQCPB3YIwjlUoijbrS/iEv9HceOWrfZImKVvegXAiZVP9wewilD0jmvCmMU9n01pncDSsiX5Itfk/Xh+5eMZwaqJtLPsX9TmIJc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pO8IwLAWmPmXSNb+JQooAmuV9qjXt5TLaJN8DcZNuojcy+x56liKT77SWnSE?=
 =?us-ascii?Q?KKb0rnotM4HTeh0bWNMak2R3p6x4mc1yAoCqHTKTCt3wo6zcKCOOOHJ/1oYS?=
 =?us-ascii?Q?g56QtF8OrzvI18ypNmyMNRFkYNKPRcxvWSOZ3hIebJBdEO+JRbd8Ts6wLPxp?=
 =?us-ascii?Q?ZQxAZ/l11whWD5n9d/onvzw8bNWMzNcyThGmWmnlrjB4FziGRHu+cMWZvpw9?=
 =?us-ascii?Q?tl35yk79mVmfE+ewjS8mBSLfTdy6haFSITdv8QZR6rPPJirEu9vYDG25Bjm3?=
 =?us-ascii?Q?kmUZUWUTnSLBAuW6qRUYfmr8T0rQco/Uotw+Wo3vdq75fPIAAMhq/ISq6WbB?=
 =?us-ascii?Q?AfXYZREOXgnzvhOvsonAJCE9XNTmOTe81PCoy5hkDHKPrydkRngdHBM9OeIi?=
 =?us-ascii?Q?2p8/ZSVxsRxwWPXMjnjeGl0uRSHrn7ahNaJyNeOvUQo1KD6YFA070oIu/6RE?=
 =?us-ascii?Q?e5FifE9mB2XhUz9HOdT3ryTGqhGvA+ZAF/xCVEH+WlK6dBl2Od6FIAPMf92q?=
 =?us-ascii?Q?r2avoMbdEzt8Nuu8YjzfZ0wauXNI71HalNGBZb8/NVRUu1zHFFFWo/8j9wum?=
 =?us-ascii?Q?19YL8sncd1ptUjqJ/z5d01/2bWgaw0QAXEnw16GXOmQekYo0HKpox+EBy/aJ?=
 =?us-ascii?Q?huNHuUik1qZciSeXpaIPg64OsAFq/NNBFQgfCFMBt9FMCGf+qOvh+/C3O9AZ?=
 =?us-ascii?Q?QImud5JXK6dIUB4DIXUzRthJKAOLLQfbIn8q7qSsf/8hoBG9pL0UTLbGl37x?=
 =?us-ascii?Q?7n5Amrdv7XO0PFdz2De5IXMMnw+Fg1W5KC6znE0HFvxgOraGhS9O+zGbvaFS?=
 =?us-ascii?Q?ACZXEY3aT44Z+MxEokph4/MlaPClxxRg2A0cLW22SZwZRR4qoCo/5Y+KKJ6k?=
 =?us-ascii?Q?mPOtx5e7u0lZ8JUZmxKo47u2lBNDu9uDXRvswy1ivgLt5SH4ysoKmGnFk1TY?=
 =?us-ascii?Q?VPfsd66UjAElUae9jSqMHBWd2SOJc7MPLKX6JqikC56GQLDbErbyaKwKNOMO?=
 =?us-ascii?Q?FmhN6turkZTpmJwpc6DhqPN1BTbBp5eIJbvx1YX4eXrbpD/3wIPxTWaKhAf3?=
 =?us-ascii?Q?GRBu49BAdXWwkdIpJ4HfBRQ1FezmPY7wvzXjPOLsroKc5oM9qeJPHpbGea15?=
 =?us-ascii?Q?vcUImADSntO/3KqUlPUCs8Co0W3oLoY7U3ogsgDA6DJrEcyxB21xt7J8DybI?=
 =?us-ascii?Q?k6cWKlaWJ9QfaT71Kg1hcNg2wthNM/nEmYWvJJYOV4JY6DCZ1EUDMNRMXq91?=
 =?us-ascii?Q?g4/GgL1M8FcbCffyCO+zAfsnqcJ/0jZwPWUyjdERZK+F/l4CItnATDhlbsCO?=
 =?us-ascii?Q?hFdE0d5rQTonocttNsaNdObUpbOEKvGABeFhDZHI5jghMuwNFwOBR0A0nP8w?=
 =?us-ascii?Q?cc/M3bXgbRFIZaeI+o4SSV0FSvmGRHPyb8qAidJ8N0Lw9u7WcdaKNZwX93pB?=
 =?us-ascii?Q?H7j1yqdpKXp4ZinwMgccM7dE+8B7EY9wNVIqTnRK/wgymJUT3aSMAtJSlNLZ?=
 =?us-ascii?Q?2t1MC87v5hMu5qS/m9+olSMaUgCyp7nHaXcfcoFd2O0+aEiqL8AimoUaZ1pS?=
 =?us-ascii?Q?15C99FDQmLyQ+RurPnwFcNnCGfz2W3eTzT5BvCDY82tQxT+MsSeufe4rsAsY?=
 =?us-ascii?Q?nFS2MfGTi8LrMKJsjQiYfLEvlkDCy45OENcB99SIWAnibr92//Llhv+/Sc+T?=
 =?us-ascii?Q?AYMiv6eLwa6ZxAqQo41E3o6/ruekBXSOfXhjZ2eblxa9lTzm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 237e35bb-240f-4634-edd4-08ded028c1cf
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 06:37:40.3442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5y3HpZjbl+Dtk5KYHl2iMRk+Ae0MHF+Ywjs4i6/A6o5r++SREGkHxcf3uyBgLrf1vRZV52fQkIwUsxK2gHfcIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7319
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,davemloft.net,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-300964-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:kuba@kernel.org,m:horms@kernel.org,m:bestswngs@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,asu.edu:email,shredder:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 716F16ACF86

On Thu, Jun 18, 2026 at 09:53:34PM -0700, xmei5@asu.edu wrote:
> From: Xiang Mei <xmei5@asu.edu>
> 
> fib6_nh_mtu_change() re-fetches idev via __in6_dev_get(arg->dev) and
> dereferences idev->cnf.mtu6 without a NULL check. addrconf_ifdown()
> clears dev->ip6_ptr with RCU_INIT_POINTER() after rt6_disable_ip() has
> released tb6_lock, so the RA-driven MTU walk can observe a NULL idev and
> oops. The caller rt6_mtu_change_route() guards its own __in6_dev_get(),
> but this re-fetch is unguarded; nexthop-backed routes survive
> addrconf_ifdown()'s flush, so the walk still reaches it after ip6_ptr is
> nulled.
> 
> Return 0 when idev is NULL, matching rt6_mtu_change_route() and the
> fib6_mtu() fix in commit 5ad509c1fdad ("ipv6: Fix null-ptr-deref in
> fib6_mtu().").
> 
>   Oops: general protection fault, ... KASAN: null-ptr-deref in range
>         [0x00000000000002a8-0x00000000000002af]
>   RIP: 0010:fib6_nh_mtu_change+0x203/0x990
>    rt6_mtu_change_route+0x141/0x1d0
>    __fib6_clean_all+0xd0/0x160
>    rt6_mtu_change+0xb4/0x100
>    ndisc_router_discovery+0x24b5/0x2cb0
>    icmpv6_rcv+0x12e9/0x1710
>    ipv6_rcv+0x39b/0x410
> 
> Fixes: c0b220cf7d80 ("ipv6: Refactor exception functions")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

