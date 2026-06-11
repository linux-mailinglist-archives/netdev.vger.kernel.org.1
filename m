Return-Path: <netdev+bounces-298111-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zXZHETOrKmrXugMAu9opvQ
	(envelope-from <netdev+bounces-298111-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 14:33:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A734F671E1B
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 14:33:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=r1MNRG9z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298111-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298111-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 963D7308B7A8
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7513EEAC0;
	Thu, 11 Jun 2026 12:33:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9302F1FEC
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 12:33:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781181222; cv=fail; b=E4IrkTC8w9DvIcDfrUwBd2AKOEps4hSF/h1zwdrLT8k9d/3ofdbmiLkzrYP+30YeMh+00r5s2B/hKpRBYGCEqR1Xm7mjybk92lGPkMleZGFMnZgsWMEWP2DFvV2va0kolV2L991utuGg2SHKKa2CakXAA+Wl1qZYQHOOG4efwGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781181222; c=relaxed/simple;
	bh=6xQdDShP7YK+Vs2BhOdv+eO/NUN2sWiIGQnv1HPMD34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jMuzE9BMQ0Cz6wv+a9h3B7o2f+zsngblYlTGrjZf5CPuGN9nwoBjQdWqMiC82Yq6gVF6phM4qF4H7w+qyYfihDqPEUzhvWtO10MOIyAquXBxPdr7V2IURbPXRDbhu1Z1ixy9z7GKEhRgXA679bDRHdHnfqeGnFfud8M6u6bAEV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r1MNRG9z; arc=fail smtp.client-ip=52.101.48.22
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OxpOeGo29m9QlYz6BmRiQ8HNaBq79Lv0gVkxnPHJazWYCoGl65OL0a6gj8R6WZJAUMeIftSaPX2XCa0ehY+4j3wSlTsZrQrdhPpQi+G+oyRGhAwa42fDPTRB3vNoin8ycR2KunvSez7cha8mUZGa/4C9R77BGWKZ134nceAOCuO0Y/Wjk61bhB/uwANLjIyzLGiPiG17xdGxThIg6RYyZeVRpFg4Lv/3ZGo+5ID536yJAViCJ+zyCPe+bCKh9DQnn3IHBd2gBa9P3IcoeOHWfogfUsVebjKmChpybSLg9YOymrBxR0+3Zt8AFGyunN7e6t4BAuy+UxRQ1psJK3TtGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hCqsgRqB+vw/SN6qOd0Ozm0Wo0dKarU8XqgikSeHik=;
 b=gNuxR4h7Mfku/+sUeO0eEkmBqXVfPZ0qC5Wg3IDsrr/bgvOh8YW1T/5SPqRznd8SH50CUk4hWTzYVPEVcY7vNgT8o0zH48RbjkV4hsqFfpLq1yy2eDI6IzqECDWCHLb+KNmx+kfwSXoPWD2o+p1cA3AOiDu2boZ0F3tyvmE2zCcl02G55ymj/2WkLHIxpV5padGdIm2eL1f6DtzC0LUr4zBrMg9+GUphO+yjKSZkypFF9IRrUW1wfuookmUPIMAhnacquqJ5OCk0x71hb9SHOM7HpYQvciUTEJI9LR9j7c9D/7H8psp1REoy94O9IEj6ocSswNBsho2o6YDFpK/WGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hCqsgRqB+vw/SN6qOd0Ozm0Wo0dKarU8XqgikSeHik=;
 b=r1MNRG9zKX4qgcu5jPDQK3RLT+2ZpxId2u+7id0kdEF0K3BsdJH6qKBkgawM2sqCuDniPbIg1yLDqoz8MXVtpD76gFeYNXazSyKaZXJspv9KqcDp47nnE7CI3p4wxL4SfcxcSfgQn/q5tce1cSGROzFWNCEaUFwuMj2TjdUkm4WUhnjYX9DObb9dA7tnvuZL5MBLqmE8RwldZSrgsoUQW97m4UgWq7NtDvrIw7oTCoHrWZowJSsppQXIHlGG9pUv9oAFtQhjrKcrYwQEXYJM012KvVnDD639KS1bU+tfrMO1XpyvK6NxXs3Seyh67gYQ8bbzFDunHUJLfCjJV0JkHw==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS4PR12MB9657.namprd12.prod.outlook.com (2603:10b6:8:27f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Thu, 11 Jun
 2026 12:33:36 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.010; Thu, 11 Jun 2026
 12:33:36 +0000
Date: Thu, 11 Jun 2026 15:33:26 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Amit Cohen <amcohen@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	syzbot+cb2aa2390ac024e25f5c@syzkaller.appspotmail.com
Subject: Re: [PATCH v1 net 1/2] ipv4: fib: Don't dump dying fib_info in
 fib_leaf_notify().
Message-ID: <20260611123326.GA924647@shredder>
References: <20260610061744.2030996-1-kuniyu@google.com>
 <20260610061744.2030996-2-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610061744.2030996-2-kuniyu@google.com>
X-ClientProxiedBy: TLZP290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS4PR12MB9657:EE_
X-MS-Office365-Filtering-Correlation-Id: 39481d4a-fe60-45b8-a288-08dec7b5a847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|6133799003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	XKSmtP2uDRrnjIpxDkd8PHIhz/n5jr0hW9Kgqg0tZgXKNoX045rU1MBMla3GSCnD3tMabBMuKAMqLMc4d/XjIZrYcogsjwanXkCucPnenJsZMbA/d5LdhHJWnWqn89D+yxH9HyjdVWFwWw5gmwPvtU0jS/YobWBxKBhYGk1JujJulvTwupfcD7bMEpiLOfOtPgSd51Z9YDXuDvVcWrZOlpkvSKQRLDQPvp/Qm5PiQbQxyOxE1u8b7c+B+H6ODctZI13cDr/fGZAaQ41+narwbP4LP3ixQYgYyZz3Sn/vodlZn+vENCUQ5oR0petbvC/f/4p7c0Ua7/3XP5USCylKTZYmEWsrO82UBMMVO9iJ2jLtR/gTmlzKKlpnEKcy1d0TLi8kClW84E4cSzb+52GoWvkHDMpZ1MHJLynBd7Cp8IZjeMxUW3UILelhpRWWrboi/Y7imGvAVx3AztFz9Wh1mwlFizkUp91ResXtxf/cYYqASJqY75NnJvK2rdLchdXxgtdA/sOSEKMkg0YJycJ8rVPMRM2Xo8Cy+9AZ9kMhR2O0UiW1iPEpaHbz/oZojtg6oj2oJgQ15a0ry99buQ8jwNn9mXQiTs9wmeZ/hHQE2+JAQtmSOf9EJP2XrYm79P3Cm5xTATg07ejEwGUwg/tfOWz6dLiKv7aM7lse5MRvewDwtlRsa7zdKOhJiyKAYUKi+I4yWh+QHZ10l6XXBDPe5Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7hRhalf7YU8IIB0O40U/4iYAbQtCxhov1r+XYZjUirHnjxmyxJk6XKY3qQuf?=
 =?us-ascii?Q?KoN5MjYGHeTr2A4Bs/7WiZwAmWE5JsTuZHqD4bccvEDBmhw+bL/WrRVSuy8m?=
 =?us-ascii?Q?J951z6w/3FxpJsHupdCRlbLZgWuCyr43aCX/3eitY22wGB5NVE6QyJ/DHZeU?=
 =?us-ascii?Q?pqGHH+/fwdf4p5iBuQv7lAVuEkDKeQ8xCSZIpV32kD9SSVqryiQeSZ/Zc3G/?=
 =?us-ascii?Q?cr362M8N/E8/Z9A5KUH9zgaNrHqigKirx7UjaD59gi5d/VMVymk57b9VeiGo?=
 =?us-ascii?Q?zEaP4A+PxZDf9bwQxj8JLOKoo8cPHbkSgUdLHKLPGmOsQlIisx9rzMexP7N5?=
 =?us-ascii?Q?ilafFyvIxMNzCD2ajihVNOR4i01SHjjbViswzFI8n6Gdt3dbRYCViGUXx8oe?=
 =?us-ascii?Q?4YVXP3T/poZZ67ri9SDUWY2Tc3XcstcktGtxUvPW8+Mzz8yOZr2lItYYFJW9?=
 =?us-ascii?Q?BtdYHtfSMCrgqVFr+QcoitWz7n7jfA7zvioMavjdZZsybQT+KgZH3kgZYqBE?=
 =?us-ascii?Q?gOlRmekpOMoUwLbAZgPt6Zk79LakogS5y3Bd+iOVgiNt3ytEO8HQEyq0y56K?=
 =?us-ascii?Q?2C1xf0xqvXes99TegVPML9s/fmIWRSDBxJEhg9xDWsj505gfGYwi8Y3alz8W?=
 =?us-ascii?Q?DVC8jhSlEN4VW+cXzTq9uTQhUFXLhRA1RcLyneYhLGOm46woMbj8LkoH8nvl?=
 =?us-ascii?Q?eVChfDQxew6eyrS4mRVRJJ9n5CCc+VESQHS5cTCFuynNQKN2hGjFkFOs0qBu?=
 =?us-ascii?Q?U5pw3b4V1dNmt6cBOdgzi/3bLKg+Egse4P6u2wsJPHqK8uWXHTifAeGPrCXi?=
 =?us-ascii?Q?AF35Nk3kNHFOy/n2nqOnTZ1fC5WHYwyudMTF+ZXd3ithiUzzTS/LIv9RXWVN?=
 =?us-ascii?Q?r17HwF1n+o9S00BVwEH+Hl0L/C0GwG9NlILtK8IkXym5Dpancg/KzPbKCIcr?=
 =?us-ascii?Q?KzSNMa41JuKU8/dCvwXdlOKKfrgv59frjWyYbX2iTwAAUX+YrlnFe9PMbBMT?=
 =?us-ascii?Q?q8CHJXnq+NlsS3jvbElIl03MvJR+BHQKAJpX/X8gDrBMXgbdFgnbWcc1Od03?=
 =?us-ascii?Q?skJ/pC+9GC2SienJSw+rjKXg/1drDLqqxoW1pWBmfkY1rbh/aImdmP37VNM+?=
 =?us-ascii?Q?lIGTv1KidnlbhJsC9sBKD8IIrzucJ2Rg3ZBqG9zujgmxoZjuP18mopYnINCH?=
 =?us-ascii?Q?wzAW9RqFgfNux7mjfUoUOy1YQFPB3NhTDM7KFUNQGB+3+p+oqD8ORyXxzCU8?=
 =?us-ascii?Q?57+xty1+WZHGtAc5fiX+aWoTK1tQSWRNi+zx3EhyWMach/kWsOhS4jrr5ONx?=
 =?us-ascii?Q?LAQd3Spsz4xImCtRy5RiFMI8kxN0JuUGDzEJU/n9m2f/xBZ1+jR1Nsb0zF8m?=
 =?us-ascii?Q?eEsBhOjk5ntAafLYFS284PsuyKGI0n7IX3397tZXsRJwPKRyNxodzbFWiEnG?=
 =?us-ascii?Q?2w2pTlLQNb3ylLhzps8xLl+w13rPqiktP8aojNgqRenICllt+Ei/O0sNezWu?=
 =?us-ascii?Q?E2sf1ikK04GZIvyOskJNorQAkahIZn92iFQvKkvqrxEwnHpVlormdqtH4rA3?=
 =?us-ascii?Q?anqrEyu7oj3bjenzkNNj+OzfVnNoaj/FEX+/o8eBTuQ4Iw9xOPRWFi/Zf8k0?=
 =?us-ascii?Q?qImboDhxie3t6zInTHmYn388J4xmbPQqqFWCDeoKmzpZO9RKN0+e0hHOsAHE?=
 =?us-ascii?Q?H9z9+oAnL5YqwV6y5W6TLbDQiclt/hLw1oWv5O1YhBdQ/1eW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39481d4a-fe60-45b8-a288-08dec7b5a847
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 12:33:36.2449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PtVJTJ3yUql2F6vmuvjk+1LJjeRagVPdkwyjBYLecEnreblSDcIGa9fRoep/hrC2/IffLsz6G63EO4aH/zehRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9657
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298111-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:amcohen@nvidia.com,m:jiri@resnulli.us,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:syzbot+cb2aa2390ac024e25f5c@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,nvidia.com,resnulli.us,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,cb2aa2390ac024e25f5c];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A734F671E1B

On Wed, Jun 10, 2026 at 06:17:18AM +0000, Kuniyuki Iwashima wrote:
> syzbot reported use-after-free in nsim_fib4_prepare_event(). [0]
> 
> The problem is that the following functions call fib_info_hold() /
> refcount_inc() while dumping fib_info under RCU, which is unsafe.
> 
>   * mlxsw_sp_router_fib4_event()
>   * rocker_router_fib_event()
>   * nsim_fib4_prepare_event()
> 
> refcount_inc_not_zero() must be used, but it would be too late
> there.
> 
> Let's guarantee the lifetime of fib_info in fib_leaf_notify().
> 
> Note that IPv6 does not need the corresponding change since
> fib6_table_dump() holds fib6_table.tb6_lock.

[...]

> Fixes: 0ae3eb7b4611 ("netdevsim: fib: Perform the route programming in a non-atomic context")
> Fixes: c3852ef7f2f8 ("ipv4: fib: Replay events when registering FIB notifier")
> Reported-by: syzbot+cb2aa2390ac024e25f5c@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a290011.39669fcc.33b062.00b1.GAE@google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks!

