Return-Path: <netdev+bounces-301888-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /U8NBHfePGpWtggAu9opvQ
	(envelope-from <netdev+bounces-301888-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 09:53:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D53B6C381C
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 09:53:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=uUKNWHa+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301888-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301888-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E9CF3007891
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 07:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ED2332604;
	Thu, 25 Jun 2026 07:53:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011057.outbound.protection.outlook.com [52.101.52.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7795B2C027C
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 07:53:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782374004; cv=fail; b=sOiU71T/V2bjcwg4104rwADEmFW5HfvVFjV44Z6VJiUmRyz5MJNeHWTxfTTeU1Xs5anKjzfc9sS5wEGW/+JAgHE8/td19ADRO9eaNkUuTXN3ahgJCBWTayAKoqx8SjYnshis6BQizQQFZl/E0QaLO7tQ68S1dUWdHHlsXsDFkDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782374004; c=relaxed/simple;
	bh=yIfWmeO57Yda18WYtzSo/qV0PPPGbbYzDY2dY05UdpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ri3+OTp/nPl22gYO7XzgNf213rKOCdG9ewseuQsJZYP6VRcTYWW6qLBUpEakuG/cfCNQl9B+gCR8A/XKkJPh5suvvnDTeR7hSpmq37oaU91HUVYAsP9A2k+goPa7urr3ZOom+Q+DtCSOy5zWlQPFiWs+aJeHaCE9zCunHY2PMgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uUKNWHa+; arc=fail smtp.client-ip=52.101.52.57
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYozSYPwaZERzGxpjQD2eHJa0Z+rJoMwUnj82MjU7Fu/RSozDBBAlsPvuXtNpFiEUrpC0K/gbNEbPlBWvD3qM/0N3aHN18ZcOgiQ2402zIOqOizqGy/ttkDcevIbHSA3VCQANkn05RgqzuoJA67YaUKRmNo+IM3geWQYwSAlipuWcCUEwnB2l5Al/7IHAsnJVT7rGvoOaNyOASdGpKSMZy2iuDq8uQjBi89H5DyduEna0ljczPH13KxrLYpNLh5pjbxkxCGno8zajoE7PUGGjli/5AhUJZhQhj3rZcI6pLPmVxwin0xHSAlQZjUP/gIq03WE57EZ3ofPQaN/T86nGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3voIQY4eNMhdlvvIJB6PUA65U1rkMDQkXOOauX9Gdo=;
 b=xRjUFYrV39DNS9hmFK9fcosbfVh/RMjvRywcNmBWJzWKOjSAM/OI25LTX9yBezwJDWlTMpsZ2qsqFrVfmMB4O1WJHk//jU/rbeyxnrA+isn4AqWICJDQx12i5JM8LVgQa8MNgP7u4YK7iJyT2jUiV2IA6zlmtM+0M5+IlWJeZqol+fHf2qdpdY8UNqGOfdwVSvhxGguwpIrfwBWWuPolJ2y8+llSzb2d4oPJtzwOYfC4GxszYwLcWuuFp/zgDjZX9gQEP7FrI2EAr1CvjGnIS6UQDNRdzoe7kCduVmPojznYAX2s+5bE5YVCV52v1P1ru5waM4H6ho8650tMfSAMvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3voIQY4eNMhdlvvIJB6PUA65U1rkMDQkXOOauX9Gdo=;
 b=uUKNWHa+O7l2Xl/vWR0d6pEwXj8u1v+2gZ0mxcbaguwGdHFjsruimxBmmsNnj9UI4O31YjAG9Jecf9PqLtjfGSk3bKQye24ldOJIdhYSnQX5cd2GPTfOngU1BjZuOg/2rVo6qdq/XK87xILGg5GxJmQlb/gy1tkLnaNtO4YCKJpZ5IcUD5PI2Iubz5sUbanH1Un1gYg2V1KmhJO9NfmdhM0zaonZnznBbZ8OowAdT3iqHARyIpqAHol43T1TQzU0VtzNCBlo6emjjq0oBk842fyBBU96PX6G8NVXSTeNHmdz9mdkwkLA13+RAgaOkT5zSAHZtLUlDPEN/537T+AWdw==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 07:53:19 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 07:53:16 +0000
Date: Thu, 25 Jun 2026 10:53:04 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [net] ipv6: honor per-interface proxy_ndp in forward and NA paths
Message-ID: <20260625075304.GA1033422@shredder>
References: <20260623085600.396401-1-zhaochenguang@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623085600.396401-1-zhaochenguang@kylinos.cn>
X-ClientProxiedBy: TL2P290CA0018.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::17) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c94d77d-504f-4489-fa6f-08ded28ed0d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|56012099006|3023799007|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VYG9Na0z3km2zGwSj9+yEYg41SqwfM//0lusxwm0fEU1lJkzMuW9/kjEmmIKHlydniNAddij6Kr0IRv70XhGvAbxIcQGmS7LxXeylEurpcf/Ks1SDeOJtYmjKkYGw5LRZmQakQizJZcB6JNo1gnxAwLfK8n3eGpYciShs4K7biZn1miOqld0s/o2HDmzOhQMueHWJBLHt6IRIwj0FYhEotmtehlb58qH0/CF8gZfdimjsxjBzdksUOf+yLoFNpJkLkdII3L59F9ERXK90rbyd/E4pHUt6lRu8np4t1e1aLILaqQMazB5mD4vMANKG17syUi/DbB5a7WIOoPQkxTUNkchdalIjDsJHED8AfTbdrCeR8jW9Z1cxglrzc9p+NDF83xFzI+WilPR04bNR0fitPDh2cPXMlu56PyfDEh7orkw4YkKbgI5+Sr4+Fs6wTOSuOmHtvothewMyy36SvsIhbYjpaOCx8IDTeTy3trQVigqJlhi0M6Va1n8aj7G9oj3zUdOIT1nuihH7Ni5oSNXenuitheG7TGDtgvgMaoclmMNEYUMl2GuL2QeP3hkE6hz73z0ocOMJnS9k43qjcI++p+zPbfUtat+zLqm0lAgfefPachPe2sh2oZ1q7UrqhU73a6OtKkhI74dIczEI6+gvSAkKCHoF1lp1bAlKXI8rIg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(3023799007)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tMjs6U1yHLT9GPmvN0x/oKhluwJvuL44F+A5jTq3l6UCcMgq8uRSF6SwvB7v?=
 =?us-ascii?Q?ZnEePHziD8c3l76DqD6dxWvrSTr6dJjhbkWENu77HSgO/dYYu9NiNvMk8uFM?=
 =?us-ascii?Q?4lqKK4nfTTNDOMdAgW+yvrNp64a8utwuzsybKt/d2VzP/Nl6TyQkAaTK9kHb?=
 =?us-ascii?Q?El4ugZQwxAoR+ICktzHL+UUVq2I9oedwf0l1aQpNEuG4+yFlxzAfHrWszWN/?=
 =?us-ascii?Q?Vg88aEvFkMngkBbn8KYxLMqojimnYX2pzuaZLHj3YMHrKm6mtr9UDi0MAldO?=
 =?us-ascii?Q?D7+oS4RwySmVYFHFjDnxOZLU+woPxKzAP8bFG+Xd4hhyraEHZ49cJ5jlJsLg?=
 =?us-ascii?Q?OQuXkRThnssBbGVa0qkCnslYEcbvNptwEaAlZDlZ23UQu6D6yp8yEx55nygA?=
 =?us-ascii?Q?GA2iKK6lo2hO1t9/E7WXFEwWUdkzCwrnOfySGB4gUHZ7LwBNrGOTgY82z1Kz?=
 =?us-ascii?Q?NgLXzSt6kCXLKwouaZ65BKxJkbHjN+8KAqo/4cQuf7Xe0jnMD08DSar5xv1H?=
 =?us-ascii?Q?t17WH6M5ou9CPhwm0hVOcTaOmJkgNZQbn8QFPzSC+rt/CknAdjSZUTK+kcLS?=
 =?us-ascii?Q?lICsDgKcJA+krQNKXRDCh3NmRhASN6YEII831KiWjrvdOaiKn8qZNnQly7ck?=
 =?us-ascii?Q?duRkYLCJf83pNCy8aGEY/yPkaS0C0nktkgBILNZTbwDSWkoITQgQCQyw6XvR?=
 =?us-ascii?Q?gQpO0ibXjzbwvX9eSoNiZK2kc9Qy4tn8Wl80ylz6tBDacjRKxxV+J/XNr2P+?=
 =?us-ascii?Q?jMfdl7pYEOD9CoUiOrZUqu6ALyXigzNDNtuV+pvFltGOwDfBp01J3WJ/bdaA?=
 =?us-ascii?Q?XNXHZGH1EW8tMaKa0ttWOfwytlo672GVWom2y2AuhdLEWyTTgqw9neEv4GQv?=
 =?us-ascii?Q?yGUYfJeWaiQJhf5DbS+X1FWqiO/bgrJAxjmAaaKzaPiDYsFtzQteD7Urzh+4?=
 =?us-ascii?Q?m7aPxOu/vE8jT+pob13SiN3jXgCS9BtFZLxKZD2ughivQPx3sFjmQKdlRIhk?=
 =?us-ascii?Q?jwH4WONX7PnrPkvcnIg1TCEcneJ9iVIdCcHRJP2Ni1GcHM8Oms88zKSQraEY?=
 =?us-ascii?Q?6WubsvkD10MeFI9aYF8BtOI78DLOpEujB52qlcPhcsEzX4nDqljiYwhCa3Z/?=
 =?us-ascii?Q?ICMeGgZzdU4Hpdpg2OL1H9m6SZlIqxoYimSfE9lolnmv6AZ4mlXG08gALTDj?=
 =?us-ascii?Q?2x0DyhykjhCH0v8oqBKsOeRTMM85A9j93YJ0Ml5ymUSJVSdkPelU5qNwXmwP?=
 =?us-ascii?Q?YXGDM7+gCZDo6WXIyoR6Lc65qSAMz+xzjWnxMBrWOD49q+TUatkAaPJnHtBh?=
 =?us-ascii?Q?Fx1aUr/wZUTsJzz2cII0SkNr2UKSS96ayTCYpEHNBdo+SIR100njPUmPXZPi?=
 =?us-ascii?Q?/v1jodSw6EuAXXodYQKvUzZNZ1e6Lh3j7EA0AcHZsoDnkJDMhiO0V4tXRSLp?=
 =?us-ascii?Q?uu1XI0lVtW511N+tCHvOnjDcLSaGGLsqWU6f0ifb0LpD4bSP27o+OKoLXogH?=
 =?us-ascii?Q?fzbuWKadrxHKlrjtPnUu2pzMOtVSqN4ivyCPHOXqxUdlKO1IcBmVMCdKHVrb?=
 =?us-ascii?Q?VETf/SprxFLT3sO8Hdn3oGagsHerI69A3YEhKktsax2C0kumhDItX6BJhfB6?=
 =?us-ascii?Q?CWa8xHu1y+9VWbmd1RJ7OIBana356l5F74eQUuAkEJ+Ay6Cq162A17lUW8k+?=
 =?us-ascii?Q?f3RIpwuBc7zu0J670B0RrE7nA05eMDIKcH9jqGnuW/uxnAF1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c94d77d-504f-4489-fa6f-08ded28ed0d6
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 07:53:16.8127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4x/U55dob3/wPIdB8LV3Z0rIJGvewXWpzlNhrQ71rQYY4ZuRCVQEcXqO3ukht+1/f+7GRFvhUfyhIiik/ezbAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301888-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:zhaochenguang@kylinos.cn,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D53B6C381C

Subject prefix is incorrect. See:

https://docs.kernel.org/process/maintainer-netdev.html

On Tue, Jun 23, 2026 at 04:56:00PM +0800, Chenguang Zhao wrote:
> ndisc_recv_ns() has always checked both devconf_all and idev->cnf for
> proxy_ndp, but ip6_forward() and ndisc_recv_na() only looked at the
> global setting.
> 
> Honor per-interface proxy_ndp in both places to match the NS path and
> allow setups that only enable proxy_ndp on specific interfaces.
> 
> Fixes: fbea49e1e240 ("[IPV6] NDISC: Add proxy_ndp sysctl.")
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>

Given that this never worked and that the patch changes a 20 years old
user-visible behavior, I prefer that you target it at net-next (without
the Fixes tag) when it opens next week.

Also, did you look into why these "XXX" comments were added in the
original commit from 2006? I *assume* that it's because back then both
ndisc_recv_na() and ip6_forward() were missing an idev, unlike
ndisc_recv_ns().

> ---
>  net/ipv6/ip6_output.c | 4 ++--
>  net/ipv6/ndisc.c      | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 368e4fa3b43c..c4ca4a813479 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -579,8 +579,8 @@ int ip6_forward(struct sk_buff *skb)
>  		return -ETIMEDOUT;
>  	}
>  
> -	/* XXX: idev->cnf.proxy_ndp? */
> -	if (READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
> +	if ((READ_ONCE(net->ipv6.devconf_all->proxy_ndp) ||
> +	     (idev && READ_ONCE(idev->cnf.proxy_ndp))) &&
>  	    pneigh_lookup(&nd_tbl, net, &hdr->daddr, skb->dev)) {

Note that idev doesn't necessarily correspond to the device with which
the neighbour lookup is performed (skb->dev). See 0857d6f8c759d.

vrf_ip6_rcv() does not modify skb->dev for neighbour discovery packets,
so this happens to be OK in this case, but you need to explain this in
the commit message.

>  		int proxied = ip6_forward_proxy_check(skb);
>  
> diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
> index f867ec8d3d90..e03e94681738 100644
> --- a/net/ipv6/ndisc.c
> +++ b/net/ipv6/ndisc.c
> @@ -1096,9 +1096,9 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
>  		 */
>  		if (lladdr && !memcmp(lladdr, dev->dev_addr, dev->addr_len) &&
>  		    READ_ONCE(net->ipv6.devconf_all->forwarding) &&
> -		    READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
> +		    (READ_ONCE(net->ipv6.devconf_all->proxy_ndp) ||
> +		     (idev && READ_ONCE(idev->cnf.proxy_ndp))) &&
>  		    pneigh_lookup(&nd_tbl, net, &msg->target, dev)) {
> -			/* XXX: idev->cnf.proxy_ndp */
>  			goto out;
>  		}
>  
> -- 
> 2.25.1
> 

