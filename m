Return-Path: <netdev+bounces-304764-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S4moAs83Smor/gAAu9opvQ
	(envelope-from <netdev+bounces-304764-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 12:54:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E5F709C72
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 12:54:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Uhhd1pPs;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304764-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304764-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 297B2300B627
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 10:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A488035F184;
	Sun,  5 Jul 2026 10:54:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010006.outbound.protection.outlook.com [52.101.201.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9AE283C82
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 10:54:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783248844; cv=fail; b=iqqwWkZDHbpnlsmwtN1SIIu75fe0AQppgH0zASupOcKxChOd4Le5eQ5+QFzmDB1IWbcobJQHkKX8l2QqdMgnlydZZiwMH8jPydOsapwbbVi6ZIxcg5QXC0n7QSdPEfcHOlfzsXv4ktPlbz3oWtInJdUCHbbxouS1z8F60sLpaTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783248844; c=relaxed/simple;
	bh=mRrjIqlVdlmyYXQJJF4Lq/iwMXUMQwq4136Wwbdauvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jDtIKRJu1VrIl0S02ibOVYWNJT3ep4r1Yw7m/1WqpIy9FDR/Cqkxt/jOncTVD+sc/lEDSU5Z5gjt/qN+9Tz/b7NwtzAR34DWe866rt4Z+4+qbhhFOX4h6aXMyAn7NuspuSruxsddF5IoZ4rGQ9+N/RxnaiIfHZ6SHCob8Cqc/2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Uhhd1pPs; arc=fail smtp.client-ip=52.101.201.6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXrZzgiQSQWaSYtn7vLGTU+EOVqBwqZVTIUluOHx/nljRq5U1IM9mls3Fvg/5GkI/9BqMKUl/cFHUEN1ja4uRzwc9zT+fzW16sTPnzQcx5WVnlh2jOR55yMBXNyZrtuKuCcpvhS7g+KXmh6SkZckEo70evOMRwVBD+zX25XUn63k81GpYDkE3jVhaqg9/kNs/F79hecBy5rVRjbiUOdrmmqrQkzsbr6Ag35seJzi7XtzltSF1vZNy8ZOYyDhEIjluOxONdHyEDUHWqMea2/vy5g19zM+GZysf3rinQNzdTdGyHEVwi9VrTIuu5/3Q4ZwpV5v3uQxUSvaDePO9jf3mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dy+JpyNWXPwBaOp3sFJBuwKAiPHJNU6xJM0Mmz9x8Xg=;
 b=NkqO8E9Miky61FcWnzauFA6RklMoLHRokxh/jKhy5BTXWoI2EGfm6mhR/nTFQP6we+xiDtnyo+oUJyZ8MaVpDBaPyjERPRRn8sZyU18nGnaqvn/tUQPfcs66ti44DgokZJktrAHIBh0ZSicZqehjJtnjpapf+FZ9/qTBx6QXpJXmrfRs9G2C4b6x1Yyo4NC2Fy0NMgccXXxq3seuKTtzWmt0nQ9EIcyz1qqkqwJ98M9akyBiO9jFhzDdYJ9DhBywRSbqcVfgyzVpIcwKLz3VpIv1qQohsm/pGZCkLdlTENoKB4P3BKFT1acB/kEKCL641nuZo48JFmGwsD/Ica+yWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dy+JpyNWXPwBaOp3sFJBuwKAiPHJNU6xJM0Mmz9x8Xg=;
 b=Uhhd1pPsO3oUZqB74bGZWdi1rNoc4rwBfALn2gIU/OaFwPzaLHigx8UWlzT5mvqdffPIH5T9SHyJy4g8i+CobDXAR3FvNYtm5FVSbxQX0FiKhkBHBg58Wu2foYIGi8wK7aU1raY0KcxuQl3cCfXsJHEXhh6TZzwWBN5tImNtIordEtj9kBoezGHJgbrb43wwMstHEppF9lstQtVWGkkinkGM9ZEc5yx9mzvwsPxpIgC2UIGZkocGJKUtbHXmbj6VdH3I/8VAoDUMM9BZVIqYhJzZ/kEebxahrSHfrhcrSclO3qQT015BTykkQCNy5ipWXh/xDYZSRVrouPeorz22TQ==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DSVPR12MB999147.namprd12.prod.outlook.com (2603:10b6:8:38b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Sun, 5 Jul 2026
 10:53:59 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0181.010; Sun, 5 Jul 2026
 10:53:59 +0000
Date: Sun, 5 Jul 2026 13:53:49 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net 2/3] ipv6: mcast: Fix potential UAF in MLD delayed
 work
Message-ID: <20260705105349.GA172278@shredder>
References: <20260704194346.4065071-1-edumazet@google.com>
 <20260704194346.4065071-3-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704194346.4065071-3-edumazet@google.com>
X-ClientProxiedBy: FR4P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::20) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DSVPR12MB999147:EE_
X-MS-Office365-Filtering-Correlation-Id: ef93b819-9629-471d-fec3-08deda83b79d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|4143699003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	sNuiUK1JIj48zeJ3flHRUbVtMmAqdeCzBOJNcc7+/x7saTi+23dIH4Mj+ZDKer10u/swBivuzIKzXJL8tVoHe8Cx4+fjW63cW76crhBw/En8wJ0jlce+W/8QaR8u2/tX1f9otI9/3Ib59+BvIcCHgpS25jqtOsnxxTPlLiBniRHmZN4eGy51fH74pbilbSt9XzX8BuHYbaizrbbjo7mI9da2lj3Ewll70V0jfbSNkJsV+t7McrySN0+Bi1dAvyvdEvDzB+ZDLKTV7mcjT7+J+EsbK/Nbc4v6cuQ23lf9DPRAcaP1NzJa9hBzbHDm4zD/xAtPFGEecHt1raufqpgd7SubrhAoqLcPLj73u/G3uxL8rO9/TQoBuY1GByO2jf299MiJiLN4hZtkW158l1USdJky6qSxSerYrVN88fhMbzg+w8491kTQB4aPA+6KcDWIFSLi42ZiSykWvjs758/HrAX6YZScddUi0R95lMGMsJuIddxdzEGyuARBNQUE/kYVrXYXakmCbBvHKygy4HNql1NUYH+M3gHEZTVB5Nwl1YQMuSGsVvabTc4EX3coaAsUDM9tBszvFhKDwKDQIpJSu8ctYHOHkZq4HPLw1PtJd/+NFlmah5Z5j9ivYefL7L66UagCNNT10sWs2ksAMCa0/LIboQfWu7FqokKmP9xVS9k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2WpMSivbyzqKOv9QnOXLOf7ucx9mfAU7cpx6fssRcHlJU/YdiXq5s5tyYPpe?=
 =?us-ascii?Q?sDwFlF/l1l30sRFGBgnAADYxhYuVV6sodHygPZYpQxUnOAvktOd07fXX3FwY?=
 =?us-ascii?Q?KXvUuNzoyrvEsUODl3ZM106MlJn8na+EXIVNiXy1iPrZ7p6eJjcupbvc4lwv?=
 =?us-ascii?Q?GCK0AE2tDuPTUKULDz3Adw0G7nSMuzzXmmVy0N6ThHdSpLDuqpj5AmM9fLvr?=
 =?us-ascii?Q?56i+7pptf/fAQJyLQHvakcykwwDI0rBGal4TdzcS8d5/0AIIcUyOhJndPO8y?=
 =?us-ascii?Q?QyeaBemHfsZ+sLoxD8ee44aysRmSpaWzSoBklhmbIMo1JWsZuP6HK5OIRzxU?=
 =?us-ascii?Q?jWz2ddtRqMYtSj3qJ/CLDzRjYIj/UqoZShBOtdqN8ZLeKHwws6p4YHINlw4x?=
 =?us-ascii?Q?/eomfweeB2plcYhaMYhAgvswQt/to5XJCwfGCa+dHjI4wiWbm2z+qYcv2IOF?=
 =?us-ascii?Q?od4cK+nsRyRh06sTj+TVb/3J+ziZ7SMEW1PYmrYok5BT9jKyQY24fcgSsT8p?=
 =?us-ascii?Q?nJojWDvOtoPN/FfkKxEU/eKTDSwgO8PV/Vhc+TH58sZx2K91EqqH3c5rozrt?=
 =?us-ascii?Q?nXiZ6ox9s1iNJJao60nt396SEMSroP51G8fRx5TKZ76XdZ3ZoX8dd/T2xFdA?=
 =?us-ascii?Q?ouSdKgPG/xOa4cdu9FCaM8QUXarShdXDL3UpTyEK6p380jXuq0MrEgwtOp7A?=
 =?us-ascii?Q?KiKFfr/t2rqCU+XCekMRgg5pJsBQZmRdYoHrA/boFwkruXkJg3VZgs6xCN8U?=
 =?us-ascii?Q?eLeVM+ltz465nezTr2V1ewYDiSSRCwl39TB1hiJLLPvS+d1y26X3bHrE6Jr8?=
 =?us-ascii?Q?U6O4Eqolq3mlM+6WgeQSL0dlsxocieL4Q/pW2yt+2OZn1SsI9WPBQfNi4/Rc?=
 =?us-ascii?Q?2nYLGiPVZNDe4Y0Va6af8q+JOusSY5y379l//ajo0aofxr+9N4SJzIXHiREs?=
 =?us-ascii?Q?weq5IgPtac3eQao2QGzWuL16DFUTvKrtuItX9dDpOJJQdvrgL1zlfYjPLH9t?=
 =?us-ascii?Q?hzdqzYAcSIuSAT4p7YM7cAkREmYR1/H2Vnd3+dy1ujT6/AUHFMkNuyR5pap9?=
 =?us-ascii?Q?eORqiGu2qfXVTWNAoIl6SfbAsdQIWnXy6zp2a8zRRFObStdqdJP0GFXvEQv3?=
 =?us-ascii?Q?8tzyEtOqUvdWb3hesiTzEZaCY7bqgLzAbWnM9EO1SZG0oSNwTD5MLCcuHqNU?=
 =?us-ascii?Q?SaRPLkhjjO0A8/4X/JtVkpZ5Yik7cojcRbPoA0ZYiR8bNu6/vT+JvqIM7sPE?=
 =?us-ascii?Q?q+yA2uPg6bXqAAxlHFhGjnKYHebDbWNocEur244DVtHF74h2491oYGCjcSJU?=
 =?us-ascii?Q?ajYaL4hYioa0yNuOSJ43Y+Yp9yk8N74TmMXp1TSFi3b7V90z5PPZgutf39bl?=
 =?us-ascii?Q?7dCT2LJYfINmpgaH9pCdZLlKtpt4E/fN5pvK+NkPqzKDuNhSrGcFHu8fyxln?=
 =?us-ascii?Q?oxfe0dnldnWWwEPbISlQ0VD0bkIq/KfbdEk+WLJ2TD5DuQUE0fy0UICOK3j2?=
 =?us-ascii?Q?BSrG8xKR2gP0FZwklGCTaRHiT8zy+v2Cpz7HySf8jffCvErSHnT7mo2StGTZ?=
 =?us-ascii?Q?2XDldzeqAQJC0USu1uwVeA9j1BLGonm//Dun4F0xyAvDpvGun2ZjEHmLXi+w?=
 =?us-ascii?Q?1iYXxTNcyEQerAMTJIFbAqBtqKYMhmWcFjblmA8WOovo5zqTwxmPjPe/gMuQ?=
 =?us-ascii?Q?4R3B6k/zqyFjHFHo/FBpNx2/PBJniiB+hmIY4Ghg16Y22kdn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef93b819-9629-471d-fec3-08deda83b79d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2026 10:53:59.1111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFJt73Oa+YdSVg3PgcMy89oK9ePu5dY8X6Gb+lrwgFes1GRttYgVJ7YSKwicwOI3O7rGEGEbwxiiWGF2SABb6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999147
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304764-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,shredder:mid,nvidia.com:from_mime,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56E5F709C72

On Sat, Jul 04, 2026 at 07:43:45PM +0000, Eric Dumazet wrote:
> A race condition exists between device teardown and incoming MLD query
> processing, leading to a Use-After-Free in the MLD delayed work.
> 
> During device destruction, the primary reference to inet6_dev is dropped,
> which can drop its refcount to 0. The actual freeing of inet6_dev memory
> is deferred via RCU.
> 
> Concurrently, the packet receive path runs under RCU read lock and obtains
> the inet6_dev pointer. Because the memory is RCU-protected, CPU-0 can
> safely dereference inet6_dev even if its refcount has hit 0.
> 
> However, if CPU-0 calls igmp6_event_query() and schedules delayed work, it
> attempts to acquire a reference using in6_dev_hold(). This increments the
> refcount from 0 to 1, triggering a "refcount_t: addition on 0" warning.
> Since the inet6_dev memory is still scheduled to be freed after the RCU
> grace period, the device is freed while the work is still scheduled.
> When the work runs, it accesses the freed memory, causing a kernel panic.
> 
> Fix this by using refcount_inc_not_zero() (via a new helper
> in6_dev_hold_safe()) to prevent acquiring a reference if the device is
> already being destroyed. If the refcount is 0, we do not schedule the work.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Eric, thanks for taking care of this!

> ---
>  include/net/addrconf.h |  5 +++++
>  net/ipv6/mcast.c       | 38 ++++++++++++++++++++++++++++----------
>  2 files changed, 33 insertions(+), 10 deletions(-)

[...]

> @@ -1395,6 +1401,7 @@ static void mld_process_v2(struct inet6_dev *idev, struct mld2_query *mld,
>  void igmp6_event_query(struct sk_buff *skb)
>  {
>  	struct inet6_dev *idev = __in6_dev_get(skb->dev);
> +	bool put = false;
>  
>  	if (!idev || idev->dead)
>  		goto out;
> @@ -1402,11 +1409,16 @@ void igmp6_event_query(struct sk_buff *skb)
>  	spin_lock_bh(&idev->mc_query_lock);
>  	if (skb_queue_len(&idev->mc_query_queue) < MLD_MAX_SKBS) {
>  		__skb_queue_tail(&idev->mc_query_queue, skb);

Shouldn't we only enqueue the skb if we managed to take a reference?
Something like [1] (on top of this patch).

If we failed to take a reference, then ipv6_mc_destroy_dev() already ran
and the queue will not be purged, thereby leaking this skb.

> -		if (!mod_delayed_work(mld_wq, &idev->mc_query_work, 0))
> -			in6_dev_hold(idev);
> +		if (in6_dev_hold_safe(idev)) {
> +			if (mod_delayed_work(mld_wq, &idev->mc_query_work, 0))
> +				put = true;
> +		}
>  		skb = NULL;
>  	}
>  	spin_unlock_bh(&idev->mc_query_lock);
> +
> +	if (put)
> +		in6_dev_put(idev);
>  out:
>  	kfree_skb(skb);
>  }
> @@ -1570,6 +1582,7 @@ static void mld_query_work(struct work_struct *work)
>  void igmp6_event_report(struct sk_buff *skb)
>  {
>  	struct inet6_dev *idev = __in6_dev_get(skb->dev);
> +	bool put = false;
>  
>  	if (!idev || idev->dead)
>  		goto out;
> @@ -1577,11 +1590,16 @@ void igmp6_event_report(struct sk_buff *skb)
>  	spin_lock_bh(&idev->mc_report_lock);
>  	if (skb_queue_len(&idev->mc_report_queue) < MLD_MAX_SKBS) {
>  		__skb_queue_tail(&idev->mc_report_queue, skb);

Same here

> -		if (!mod_delayed_work(mld_wq, &idev->mc_report_work, 0))
> -			in6_dev_hold(idev);
> +		if (in6_dev_hold_safe(idev)) {
> +			if (mod_delayed_work(mld_wq, &idev->mc_report_work, 0))
> +				put = true;
> +		}
>  		skb = NULL;
>  	}
>  	spin_unlock_bh(&idev->mc_report_lock);
> +
> +	if (put)
> +		in6_dev_put(idev);
>  out:
>  	kfree_skb(skb);
>  }

[1]
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 12d22de6f496..aaba4c2aae23 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -1408,12 +1408,11 @@ void igmp6_event_query(struct sk_buff *skb)
 		goto out;
 
 	spin_lock_bh(&idev->mc_query_lock);
-	if (skb_queue_len(&idev->mc_query_queue) < MLD_MAX_SKBS) {
+	if (skb_queue_len(&idev->mc_query_queue) < MLD_MAX_SKBS &&
+	    in6_dev_hold_safe(idev)) {
 		__skb_queue_tail(&idev->mc_query_queue, skb);
-		if (in6_dev_hold_safe(idev)) {
-			if (mod_delayed_work(mld_wq, &idev->mc_query_work, 0))
-				put = true;
-		}
+		if (mod_delayed_work(mld_wq, &idev->mc_query_work, 0))
+			put = true;
 		skb = NULL;
 	}
 	spin_unlock_bh(&idev->mc_query_lock);
@@ -1589,12 +1588,11 @@ void igmp6_event_report(struct sk_buff *skb)
 		goto out;
 
 	spin_lock_bh(&idev->mc_report_lock);
-	if (skb_queue_len(&idev->mc_report_queue) < MLD_MAX_SKBS) {
+	if (skb_queue_len(&idev->mc_report_queue) < MLD_MAX_SKBS &&
+	    in6_dev_hold_safe(idev)) {
 		__skb_queue_tail(&idev->mc_report_queue, skb);
-		if (in6_dev_hold_safe(idev)) {
-			if (mod_delayed_work(mld_wq, &idev->mc_report_work, 0))
-				put = true;
-		}
+		if (mod_delayed_work(mld_wq, &idev->mc_report_work, 0))
+			put = true;
 		skb = NULL;
 	}
 	spin_unlock_bh(&idev->mc_report_lock);

