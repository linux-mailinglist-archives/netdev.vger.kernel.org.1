Return-Path: <netdev+bounces-282315-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAeKJkbL8WlCkgEAu9opvQ
	(envelope-from <netdev+bounces-282315-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 11:11:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E63384919AC
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 11:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67AB63015E11
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFE41DF25C;
	Wed, 29 Apr 2026 09:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ozbzU3xX"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011016.outbound.protection.outlook.com [40.93.194.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0D53BD25E;
	Wed, 29 Apr 2026 09:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777453720; cv=fail; b=S3Tw3VwdT281tL7gEoR9xH4vQ2IsOFXJ2l/JDeEdcrvJRsaFFKjQS8kmvDYz0pibjYp6+aqeSdGN1Q9dJdmjBIZSWMuSZTw+qdBAN6Q6efz4Mu0nMwKAFZ0+RG4R0OLCOHMnTXSgpTkwa8ceXBu6hNLPkk3Rf/cU9Msmx3hmLC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777453720; c=relaxed/simple;
	bh=vYCYoJmo3qj96YM/Q37Es8BbcZ+1AcDshhdwvNhhtO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KEzMuisYksLBOuGCLzmpcgVR291OI/qF55P0JsVfToEk/MXiujQ4YUxwdM5uhGuS0cuR+ywwKLzmF1dQJKdt5c2AmvUSC6Zhy7Q+/dBSp//OXn7ImtS8LU6YxKqoWUAjANMQlpKMULjawpjT4RvA2+e8ZRGUUISu7AEhQgrMfag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ozbzU3xX; arc=fail smtp.client-ip=40.93.194.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UG6aZauNNLBLjhRsaUQdWs1h0FL0BysIH+KIIs5195gSoBelGQGG8E+RF3z2OYpx1CiY37aRokR5Yk58D0ZpVeSlcn8/SSvukcG6Ylekg2XfAl/AgOmYrRGybEmVNoz/owkQdooWxkkHdEFOpp0TydhKOJJ+JrHTlx5qDPtKS4jjotZIXftQkxT7dNEQXPoj+XebEk1izpa8g+94AqTR8xcVdy07R5Cmh7kKLlJOfi7kJLH8EvxDDjLAF8rN8sBKZ5RJ8WzuEuRC5rWUpzOTR4uZbTm+Jq0TRca2RppB6hTWGn+/AnmfBNpeAyPAMDP082Yg+IfH24cUFGARq2ZUeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gi25KPDXfrR0HMr0K6c7BKtqMoDAT5jS6rSzBYX/C2g=;
 b=lBKu2K/3Z3Bxqv5lIaN1KD6IdJhTW+yPYLyRtLzPV5aQ2U8XQDhZB80kzAx2r/00LQdwSPuNmjkDQt3U136pxwBUaM+N1hsm7WrJ4TojmRrx3+mdoPUhS8M0SUH5RK/lJAcjhwTAHkirPjYQjKHRCQqjY51yirejqgMw9n5Olvt3KQGX3e1+W7BFCeaOcuRtkHOoFvmf8OKwXknoi4krkrrkiTDOPIH9fNcfiN7Zt9M842q4ZjgQmX8hA3Sh6QjWhLKj1Uhy414RgK6GpoTCN3mRHI7SZucaBBWvCDVYD5stXugdH9RSmVwu86kUKJPeakzLILGbcRcAakdUyHRG0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gi25KPDXfrR0HMr0K6c7BKtqMoDAT5jS6rSzBYX/C2g=;
 b=ozbzU3xXsuUXROMSbLVRKy+5vJzpFAnrzHhm/HIjepYqgglUl0DqWuOLLwK3OALTwZEB3ypWokOKOaF5AK7a/LGimQmdC1gIcOrMRgpbGkCoPVo5J60+I3II7/1XaTmIPmkMr6RncRd2bky+y29kqbMbG7/swE7j4ow+IZcKdmHyfz/3UEg1Ep3mZPXXYas08rPrn+zC8XvEb1v7jGst+m5CIeZVeE1/fzfIFxnmj7xs36T4Lk+z2UKTewsfvBX+lD6fika7Wu0kIRQYwAtuJ8qju643RNWaxBLdbIue/jGc51yBSxPu7TtPD8nLVYg3RGAxYhOKicMbGubJTIIXJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB5973.namprd12.prod.outlook.com (2603:10b6:510:1d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 09:08:34 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 09:08:32 +0000
Date: Wed, 29 Apr 2026 12:08:22 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	stephen@networkplumber.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] ipv6: addrconf: skip ERRDAD transition when
 address already DEAD
Message-ID: <20260429090822.GA758041@shredder>
References: <20260421075033.1110816-1-lilinmao@kylinos.cn>
 <20260429012651.1580303-1-lilinmao@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429012651.1580303-1-lilinmao@kylinos.cn>
X-ClientProxiedBy: TLZP290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB5973:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b57335e-1403-4c4d-ebbd-08dea5cee304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WifF34wUGU1got8r3ScMgtpTCtKZlwLTGVbkUvNOeo3/W9DUN6lNzQ8YH3IOyKeAF41w9HvqVA92Esi+uPaSfTdFvYTYNp/gBoflP3iUWrMWxi3uZHeRo8qkQoKLrQ4y7uD3lSDil+M+F1c6gaqgYwzNojs2pC9Tj64juy+8LVrb0z9veqTmNMXMtDhXmgwqSK0lZJWcFe0s7pUc8Q7CRRuwPPrphNEiFQVDQ9gI8duc+AtEnY2P3rg90yGGuB5Y4yiU8FJBXleBgAQ0JYRxk9q4vKZpKSoXyPca0oe9rqeuKxv4/qTtRc8Z11CKx1UGUE2qyX+TNd0aLI3FdAJJvx1ZapTRG7SCtuQiGLA4H1WTbPTHp/rwWL9A3IbtmUL9yeRgdGjiFIyDZen5Oq71GQqeVIAvpJ4li+kZR5Q5/qZodDM14wE+aozUQ9oS7HW7iJQR/b394LWUO5W3SksBaesJgQAE1utfEKdpCexTy3jBgcC5uA5oZDed8YHeuPsXBf6Y1c96TY5tFNeCRFQuP5jeqOwi9lHujIfKQciRVcpWtvbuw7ZygZrDRi6DAZ0ini9ABcnH8K1/3GKOgvnf47lcZD7PzOIXiRTIh2pQ2Tq1VKGiwKLkG9p18RS4oIOUh1CAlcnuv4610Bxnc00pI8K7/ERISGHi0XHoHuAyCMxM0ExVPpWC9N3DW1dgte7+jYbBqV9ZqjMhc182Qk2WaQt/xGShQC2S8iZonLwGOyk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8gzeHsHSt5MyPmJQsWEgt33y6SPhg4udnt401gxD9Ev3DNlFJStIpCeRAyy9?=
 =?us-ascii?Q?SwkbtvjfzUyspb4rJjtIf0J9LjgR90DzkmQOKQCYu6LDnirkaRy/PlP7Nteg?=
 =?us-ascii?Q?HFuUyR2xxki5F/TouF0aGkhmZmsuxTeI8sDuYagZOjfBwhyhG41KI6xeK3AY?=
 =?us-ascii?Q?pCGDLWqffZTVBTiz3nq9S6W4PLRcA+l8f80VzGNbZf6+frTuB2trSNKFI9bv?=
 =?us-ascii?Q?rTBkCdl07n4ON3arJQKwPpchxT++Z+Si4hfiN21sw4Da34kZNdvJpuQnDX2U?=
 =?us-ascii?Q?v4zDvFjucZdarT/1nGRoeAX0iN4N9OeKlafjrJuL8JQj20Qb9v6cXGFdawP8?=
 =?us-ascii?Q?3O1E4ix8Wiv4JDjFVkR8BnVEXddaO7ZRbC0BpnO9UKtcgJ6O8ys6pI14Alqo?=
 =?us-ascii?Q?E8+SkcTOTN4fVJbORobfrvj8jrBa+JKXtOu8ViptcKEQda2q/a2//e50hro5?=
 =?us-ascii?Q?o9KrHfAADEfMIVPgKGCwqdvQ0Y3HE3KDPdiqLGakeSW6mKLp5ro4PS1wGhCP?=
 =?us-ascii?Q?4M79s1VXogU1M0Tj1jCeJ/zPb51PuDT9XQZCEcfZEBc2rFV9qK8zcoeTNsAD?=
 =?us-ascii?Q?sALvf+Lbh6mXjYg3Y8fmu5O0AzdeGokK4U5ynFKhZnU3bmi2okfU3aLGx8gV?=
 =?us-ascii?Q?YaaFAcPs7sPDXC2aDdSW8kvk3Uhyf0s0CG2unoHE9O98Yt3h9ZJ1U7o3bXgc?=
 =?us-ascii?Q?AI7OxzoupH0Ho+lNuObMKlqyPwO+2ZG/O806o5sGcYvNzRneYzaxDqDCG17H?=
 =?us-ascii?Q?Kvd55omLKJrt7NJeWDBNrerstQ1xGHjO4UjtlM7D+ljI23Eh3dcHg7k7iZAY?=
 =?us-ascii?Q?vgr75JwyNLOrLwnXnpot3XgPzXlsZSWEV+39N+bbwsSb543c2/Cj7fIDuj6L?=
 =?us-ascii?Q?xMoJuHkdl9je8wd2brlfHf2huZC+91DdK6QfqCmWPBM5umLkIen9EMoiODio?=
 =?us-ascii?Q?mrlnzd4ZKJ3JT5n4IQ/Bevrch3ji4jJMdBnydFiBVB6GGMEd5YDOPaHz45kA?=
 =?us-ascii?Q?nSHWuKDjPaz8IqmriS6wAGZlGnENQdupz6Mhk9VrN6NcaDVehvByssl96n2+?=
 =?us-ascii?Q?sYd6rJqMwHWJNb6P3/5iIVu3gCBanYUmnOwIDVjPqIIXOKBhKbTpjKhurbSC?=
 =?us-ascii?Q?UWsICQgiAznyy725EtTgBgnyKoyROe0G9h3Vr/JdEKuN/4bwKkd2jMwqukf6?=
 =?us-ascii?Q?m7brf3rzu0myxVqkgfB5q06VPsfg4/a0Z6dQSxT4kkxsp8s6duGOrd0K3g5o?=
 =?us-ascii?Q?xiaz7qcASJ3NO1ZMynCrGJjlJfnu+GJ/KzlL6xoDfGHErK+6UpgUzJ7xCf30?=
 =?us-ascii?Q?wjW7FNknxZH97KX7EJdak2YY4+a/YGT+RkRKxs/KiGhVYkyuLr5E/nkoOXyG?=
 =?us-ascii?Q?58En6RMXcJ5O2ysgpAkUDAmRzrSDfsEZUBD7UAJgqZhDfTiCI9SIpi/AJdft?=
 =?us-ascii?Q?6HUkVlcgEqqSBOOYRo4o9j/Sf8vK5o/ycs7r/yxyWQMVNKWOLbTsIo5Q17Jc?=
 =?us-ascii?Q?8jY12W7A4K2wblppUUvES6XSiYuC76JL1gqrluNGpk2Y0HgjHgoaMpGi/k0u?=
 =?us-ascii?Q?qlyz2KJ3nybnKXZxbmcpGezW8tZYzCtXJoJY8OknRnwxQr7zcBzRS/3gyWO2?=
 =?us-ascii?Q?0vxput1j94849Fp0lPGO06qUeI/Fa+0WRRBJHjDj7SRS7ihqR41CUKwTneDi?=
 =?us-ascii?Q?Vrb2PqCQEf2duBwuAgblZjy35BP5nBz3Pntd7Wc+yVm9KYCd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b57335e-1403-4c4d-ebbd-08dea5cee304
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 09:08:32.5620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4dWQMyBTp6GWLH/+iqd2JnuMcRO6QFGHjx6gDp/K9pGcZzz9Iz/8nGJvbaJK+4O8QFH8t249/YwXOvYH2ToxXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5973
X-Rspamd-Queue-Id: E63384919AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282315-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]

On Wed, Apr 29, 2026 at 09:26:51AM +0800, Linmao Li wrote:
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 5476b6536eb7..b58bd9f11606 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -2166,16 +2166,18 @@ void addrconf_dad_failure(struct sk_buff *skb, struct inet6_ifaddr *ifp)
>  	struct net *net = dev_net(idev->dev);
>  	int max_addresses;
>  
> -	if (addrconf_dad_end(ifp)) {
> +	spin_lock_bh(&ifp->lock);
> +
> +	if (ifp->state != INET6_IFADDR_STATE_DAD) {
> +		spin_unlock_bh(&ifp->lock);
>  		in6_ifa_put(ifp);
>  		return;
>  	}
> +	ifp->state = INET6_IFADDR_STATE_POSTDAD;
>  
>  	net_info_ratelimited("%s: IPv6 duplicate address %pI6c used by %pM detected!\n",
>  			     ifp->idev->dev->name, &ifp->addr, eth_hdr(skb)->h_source);
>  
> -	spin_lock_bh(&ifp->lock);
> -
>  	if (ifp->flags & IFA_F_STABLE_PRIVACY) {
>  		struct in6_addr new_addr;
>  		struct inet6_ifaddr *ifp2;
> @@ -2223,6 +2225,11 @@ void addrconf_dad_failure(struct sk_buff *skb, struct inet6_ifaddr *ifp)
>  		in6_ifa_put(ifp2);
>  lock_errdad:
>  		spin_lock_bh(&ifp->lock);
> +		if (ifp->state == INET6_IFADDR_STATE_DEAD) {

The code below expects the state to be POSTDAD, so wouldn't it be more
robust to check for anything but POSTDAD rather than specifically
checking for DEAD? Otherwise we risk overwriting a state that was set
while we weren't holding the lock.

Also:

1. Please post new versions in a new thread:

https://docs.kernel.org/process/maintainer-netdev.html#resending-after-review

2. Please include a change log:

https://docs.kernel.org/process/maintainer-netdev.html#changes-requested

> +			spin_unlock_bh(&ifp->lock);
> +			in6_ifa_put(ifp);
> +			return;
> +		}
>  	}
>  
>  errdad:
> -- 
> 2.25.1
> 

