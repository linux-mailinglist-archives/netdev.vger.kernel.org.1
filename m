Return-Path: <netdev+bounces-299439-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VOm8Aof0L2qNJwUAu9opvQ
	(envelope-from <netdev+bounces-299439-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:48:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FBA686613
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:48:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=SQierUNv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299439-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299439-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFD01315327A
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A692F3EFFC4;
	Mon, 15 Jun 2026 12:38:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011044.outbound.protection.outlook.com [52.101.57.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F113EDE4B
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 12:38:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527132; cv=fail; b=I5oG5sldd53TPSRpccFGHBxsJ83WrLZhWpBvTjh3PFx1UBv7PkEXkZqbiiNeN6UbbSOr1d17SUKKH+vrUoyyyjPFEGtpDOf90FaakXJZkHdgIbR4yKGqaiut9q89O8v+YPDLGBZ7mOiutPTY7zLCSN6EyMbB16sPlJSj7EDH4OY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527132; c=relaxed/simple;
	bh=pBYB/ZOIQDsssJtuqdyBthETpL2NJL1sCN51+27EiCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nsljizg3KYBUxpnhR3GiTlBz5ObfbfXe88+bbvcgs4lh2lwbxdWR3btcYgfqZnM4zBPQ0RGFNXltYBt53nkkRhgVsjdyBgSIeE4+k5e5Eie1zOitqCqdYn2WX5tLqgx6M/OfOCIGwGb2r7vJ2L0Te+zy1yppVVrhVJ/WiYpkcwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SQierUNv; arc=fail smtp.client-ip=52.101.57.44
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TafMOtkDmXVXthZl8rw4wVzE3arysWVIiaTnPLfprZ2y0SMj+740fc9NmQYCzCQC64HDzoOs48n8jyqozO+aQj6eNbqV6aIE5deCQhHlPZJgod80FTJPRSS5/ILfT09w2qXDf8eMBvtncghRoBnkXw4XVwl9xraQ7oA8DygNT28Nk6H2E5syvaUVotvGPytUhKPhBbqzLc5je42SqWG0hdGyzZWUeOu1bazfyAHQ/H9fIzrI2izgC9mJg2hzfLdUPDJ5GUuxcZikDDGYzdLZAvb52RWvW2j8IMrd90pzo67a3xO7VaE/nqdZwokeVyJ+HNWpHuvep/KbUZCfN+ZwSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zu4ePbPagFo8va20g5Br1Q6cV+G6B5RMBkPzZEgUP/4=;
 b=Kaifq182SFnS14eDlKeNLK+IILNLfw3QaM8sFj8QxaZ9L3o4heVFGSRaI0mp8ddknb5aJUG2GohIXtIVaj4W0LTo0xccUYCRg+MEN9KFOW2VOUbD84eAKyui0p70IKc1/rEC2yaWVcqYcwDuBtt3lX0Tqxb5aObQOH2titiQHYLlBTj8QrXPxQLyORJC5vDVsBhSPrN08f602fl2ASqRU4Zn/HW9rg5AKfxRCuDB1/yz88hAL4fa3oexWf283X1crsJCNkYbTdL0/wHFhPeY4XSbEh911zzvu39rYs1cWQonNnzZrfuQpWZJhr6rENlk1IApo+yhKcLV/Yuk41aobg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zu4ePbPagFo8va20g5Br1Q6cV+G6B5RMBkPzZEgUP/4=;
 b=SQierUNvEOKxRFQDE++bV5RRKXw6oiQR5+obAf6zFcYUlZDrsG+51QHilwCY9Jo2PWfFGfrZcbyIbSC7Lqq5XL2SBlWJXWhNJDtEJaOGhRS1/ti4XEQxaS0iSK4bl8H5+rAWB5ruGwrB1C1+Q4CxlFQtwxpEIlg5f2+ir/8R9x0tc/mPAtpr/wT5jfPHmgKtjLyzD6KSAuzbNH1pDRbJ+R4IEmKOWsKTUb7O+Z6Yp++6j4QvSl6KOSF34H/YJuwL25wsfD8ZDsT9jAmPjYT9g4JDHrk4+dgfdCsfWwlG+89x3c7O2v+C8Y0t3A9mGK9VFvO0xrwpNf1K6ua1AUB0tg==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 12:38:48 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0113.014; Mon, 15 Jun 2026
 12:38:47 +0000
Date: Mon, 15 Jun 2026 15:38:37 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 2/5] ipv4: fib: Call fib_proc_exit() and
 nl_fib_lookup_exit() at ->pre_exit().
Message-ID: <20260615123837.GB485439@shredder>
References: <20260612063225.455191-1-kuniyu@google.com>
 <20260612063225.455191-3-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612063225.455191-3-kuniyu@google.com>
X-ClientProxiedBy: FR4P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BY5PR12MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: d93370c2-5059-4b5d-4740-08decadb0bae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	T8+uMSgrA5LIXvK7V3Yt+H4KLZVIspX3Zbw3langiMAFKCBeDjW/12E60aFdSg9C8I/JEvrFqmVP0gEjZ/SDrHBnxvZyGXOg9H0TMdhIoQncs0ax/dwoB2xd+qFpyOzDWs5zZ9nWPvJT8jVxXd0C3jQ0NvJivR+H5ZTh0d5UnmD0mR+E1lux2e3E06mCEHNaTJBe8xr994im95Oisp2VhUGLPamBuPN/2pPAv5u0w5B4UUcNw1gKBbKgQRGKnOAPV9PZfzv7a5MNr9X5OBFv7C7olJnmgsyoV0Hn+L0fxljzV+HgKoUxvXZNdH4M9o/lGUg6rrAkwpokavBQjEa6x6P23h+a2+XUL1dQbUAbuuYrQXgwSu8YPfFrAkMZDIsrfyVl90yL8HNPJwv/UynyPJpL4TAda5Kz14SbofHKy+gXUrrqRl+dyVwQ/yCDjNXcNRyuvfuMtf8UT9afyjyEn+hEKWu1E9XfjUak4l4QywpW5cBoKd6b67MC2tPaY3W0ic5n+8GgcezoUJLd1i8oUdaloaUcUaqeHbf+zqhwrIyhsDuQzNAp7MsTiB3m7X0eKGUK4GpAmp2Nts5adCtKpUb6kXoJzHvTAl+JNNt9SSdXGSVEG82J/NR3z/6qHfHMolkJHj+pvp6In4NFPeFfTR89Sf3H0H9oWJ93rNT7azMsY/3wvx2mnJz1ceh2662Z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hm+AWUjwB4R0ZaM7td977GZxb8jRF6xMqCKXXvLNfGlfxR/TpEI0pu1NOcXR?=
 =?us-ascii?Q?t7Dy969jQ4k1guCMnm3XI4qVRQ9P2fZF8EVZrRGTuulFyj6Hwvl9zWYkL1oj?=
 =?us-ascii?Q?QChmPh9QSLndgoOmUWFKc1PKo21P195gl/VXlqEQ+yqFmpYWgBqmJa+dKrsv?=
 =?us-ascii?Q?Nlv/tm5z/vjD2BSnczP5auA7b251/cFTAaCkKyUqJVIAVNCKycmOKKqX7Ci2?=
 =?us-ascii?Q?ZDqvYnpk+RGFBEB40ozxGwiwcdQd+H389CeiDd6UG29VavE/B248NUsRZFnl?=
 =?us-ascii?Q?TSoPGpVB+8V6qG/E/89i6u/wHxYM1plkvSFqFT1HApIb2dJkKHN1/x4yAc55?=
 =?us-ascii?Q?7Mfu8HMtM4kfrvTLr8WDzbB1plyU6azVXJgR3M17XH0x+rhgyFdNpqewwwbd?=
 =?us-ascii?Q?aNecy6NugH7D3DxpxyiXABmkfCjBDmWZ9Jxq8dAJw0DMOHbRrAvRpDPlkRsf?=
 =?us-ascii?Q?b1MozyOlcXIInWE5Oq0FuwJemjnK/HzW9iPukNdfCOgyv9ir+ii6GhTXJdDp?=
 =?us-ascii?Q?XJ7Ck2L3NPuwHKBdEvNMjoMTm5pFS29UmBEyfR/jM9zzLZ0y98OgJwDXtxl4?=
 =?us-ascii?Q?brxDkvgYdGUTd+5AKDp7RH0lZ7chwVAuJLI6AER9BkQ6ucjSBeGdnVq7DB3N?=
 =?us-ascii?Q?prBqjnmp47nYgIDLwHAZ4P5IqVJE6IycjScBOkSoCuwxBb9eQGPwGW+xtVhf?=
 =?us-ascii?Q?9TOROog67iR7bs8ienGMOUyxVIQKSzUdmCplc7bmkbNbjNPw35g+U7iDUNP2?=
 =?us-ascii?Q?8MLUUQkvG7jym5DY1rWh2QX9eiUwcBdxcoVIpmwkixfZFOnVo8mICBC/eeLH?=
 =?us-ascii?Q?ag14ZSr3x1chYhKbZjMdsEZZInvIx298ih6Vci1I6H3lO0XHJD2jsCCIyLZH?=
 =?us-ascii?Q?oL6gG1d1dIh3WpaBEn5VWemuyoxBWFxvGdKb18D2KfTXpN+NNAeDIrQu41/1?=
 =?us-ascii?Q?ho54KLQMDE8S67MdOkK732sdQGK4SuahX1QUj/F7XKHCPC5t/0/yZxRiE5IQ?=
 =?us-ascii?Q?L9PgtVOBrqTD5PJdfkFtXOFklmDWghg2zQXh4UyIohLPinM13rGjiTj+f+UM?=
 =?us-ascii?Q?qQFaFiGetHZu7GbItzK0JJIDZOl9+tYAZL8jY3HT3JlQ9mp2pIHDbgeNsYTO?=
 =?us-ascii?Q?SqV+QLdWJJ9+pIfADroU5IoLFBq1OpCfpjQi8VVfaITHqbEyAT0TjyXMM45v?=
 =?us-ascii?Q?4Ibe/pISOOQO4uRoFfjwqfp8pOm6NVoKoOMVdvwl4x9QuCrTaT2cSz94AO1w?=
 =?us-ascii?Q?49Ive9RP81UGZKYoU7mU2MQ/DXHncuKNOj4q1PchYFzaZ9QYr7G+N32zZ8bO?=
 =?us-ascii?Q?s6dG9zL42jw3cOmzBN/xdkpf/yFPh6rzMPq4sT0r4MHUmZZX6FswaQZZjvhw?=
 =?us-ascii?Q?5elJFdbvWY4/NOr5HyPTNxvNrJDGCyt3m4uGVudXyiPU1eF5FdxH0ZpsnNrI?=
 =?us-ascii?Q?v11gJR9J2QJxB7EaoLFA6R4zbiFeSFyj/msXjyjKX3sknn0mHmYT4cj//+xo?=
 =?us-ascii?Q?G+knLYoVRrC6OE7db9VlIFPEeNgHudSLQIH2vZzSVgHUswmZj8cW33MdcGki?=
 =?us-ascii?Q?sPw/soTHftfwSepupPB+QeOQ5DYJ1S2T6BF5FgkXFiJ7Xk0pJBXzOInLTfEn?=
 =?us-ascii?Q?Pmmj9XIH1E2u2+EItQlxLAXDR94w/5PgniurEOV6Dy2JK4YRq9iCEARt8siX?=
 =?us-ascii?Q?ATtdC38ce3PlWVI25Oh0wirRMaGW84yLB4AC+O5W0QK5DNSm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d93370c2-5059-4b5d-4740-08decadb0bae
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 12:38:47.8705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1e4i8sViSeJ0FDxQ7OsTnfbqOkBT/TfJSfRwsEJbGgpDWgNbTRuQjwT96hcunc+EjNxYz5I8ZbJ8FIcikzWxkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299439-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,shredder:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58FBA686613

On Fri, Jun 12, 2026 at 06:32:05AM +0000, Kuniyuki Iwashima wrote:
> We will call ip_fib_net_exit() from ->exit_rtnl().
> 
> Since the exit callbacks are called in the following order,
> 
>   1. ->pre_exit()
>   ~~~ synchronize_rcu() ~~~
>   2. ->exit_rtnl()   : ip_fib_net_exit()
>   3. ->exit()        : fib_proc_exit() / nl_fib_lookup_exit()
>   4. ->exit_batch()  : fib4_semantics_exit()
> 
> the reverse order of fib_net_init() would get messed up.
> 
> Let's move fib_proc_exit() and nl_fib_lookup_exit() to ->pre_exit().
> 
> This is fine because procfs/netlink access from userspace cannot
> occur at this point and synchronize_rcu() is not needed.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

