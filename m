Return-Path: <netdev+bounces-294171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yTu6FTDEHmqDUwAAu9opvQ
	(envelope-from <netdev+bounces-294171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 13:53:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3A462DBB3
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 13:53:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Ao6STu+R;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294171-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294171-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AC4D3036E45
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 11:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60CF3D6475;
	Tue,  2 Jun 2026 11:49:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013058.outbound.protection.outlook.com [40.93.196.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BD03D333D
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 11:49:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780400991; cv=fail; b=WdTXHO2cVxLJBJgChlTc2i86Sne8txNKTmyWpIfRyzn6fRj+4t5W9m6VTu0QhsuWxYoDdfGbxFQ+FVzHo5LFOEKaNs0QM7k92OeN10dYQxtDmckL5ywblbyPmObptYudsxTFjFvnlZCy1T1EM0iwVxlFGyJLR3gtMty1D1hsPck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780400991; c=relaxed/simple;
	bh=EuLPS3eL/8I2Fa8SFyHagNqNwl3krNKhgeMCPVeslkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V8pU+pZfAiCzgI++Dvik3ToIkpHHz1an70czbUw2SGfG9NRunUbTZTIgrHvADnVOmv+OjjsJV8Rk4B8f4U+81pk0UAjxS3UJ0vri3dnsdp+H9wGt4BUjpgj52kIuIegF9hnt/4qbZwF500/lvG2ftRfJb4btZFs833s5u/4W+EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ao6STu+R; arc=fail smtp.client-ip=40.93.196.58
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vxzf80fRTx6YRqyO5eEga0XDMgD9CXWsUHlArlbsn/1OiXeCcLhziyv9H9TwJ25ULB2L9fmfBcaG1iJPchCwe9XeGbo+FS3KYUTXlFzI695w7xkQ/ohmGbTwaPWkvN25V4/f/Q5+HkyTAlBpBTpqR3qL5btlqN4xfUMhjc92zVxWS95sQtCo2irpQNqf2ykPXRlTP2R6aP3HXFWbvVASbOxmG/Fvqd/82zxj8zJPS2VWykjmhF4ktPPZR/URjErAtA8N9Lbvot9lqO8nBA7TzyfgVuK1YISTep0hk4HXi0uoVWypw+nr9n2Lba/QOyDXHwV/bBQv+vvItVnXat9yPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69jxk/EiD3SflSTdOqTzYqcI9zcon7roUCX+vKul+jA=;
 b=A9k+9XHKTiDveONOgcfjUSaV9tThl1wJzrGvHqdX38EK5HFRmAF1Y3vt5zsBCp1SY2gIIFqVr9C03ve7LhEeC08sD0BeohgY3FDnPAJGvc4hZbXmt4FRAbroq0Rzx3gzCidvofC6/X19WNYp+sW9OaO4MIj6Yi0s0+uc87zUZzq+BlajWfnbfLIldkD11qKUw6Ath9/hRVeW8HnQENdaV+Eu7R8iQTKIqJH5yrImyuhZ2p9vE5sc+swmxo7N/0n/lPAAddTlBY9fIgmhXfsxt8BjbOxiXvyzG5hmEVhPmaJ/56TWs0w+bBkwfVbeCEqlYFsRzrjL3EWnDPsoP9ucRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69jxk/EiD3SflSTdOqTzYqcI9zcon7roUCX+vKul+jA=;
 b=Ao6STu+RdEIA0pB3EOR6gZe1JujnYXZndFzBjpcYa8uYZdt91LiXqtMTGDo6kdAF6DqoDkyEfBYoE3kuWqQralSDyF5PHUIiDe1vS+UoSVAbzEFslQLn86qK8KWISJMGJ1rEJYdXKpg8e77mmIQALx/rUl80LBP9KFXWtCAZctvuaAgB3dsHLaOQIq3l0Hz5Aqo9I++S3KEpg2ZtPgn1NIFbooMJVMVH91hbUbE2izXcofMgeg7kIVDtwdWmDx7MZ0EE9xO5+q4BuyJKFYAIoFNRc3nQq9YDUA3QN89wwA9hb+3F9y81uTQRrp7bsYMqnILVHfi4z2K3uIAdQ3OFPQ==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 11:49:45 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 11:49:45 +0000
Date: Tue, 2 Jun 2026 14:49:35 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, dsahern@kernel.org, horms@kernel.org,
	willemb@google.com
Subject: Re: [PATCH net-next v2 1/2] ipv6: Honor oif when choosing nexthop
 for locally generated traffic
Message-ID: <20260602114935.GA496834@shredder>
References: <20260601065300.267960-1-idosch@nvidia.com>
 <20260601065300.267960-2-idosch@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601065300.267960-2-idosch@nvidia.com>
X-ClientProxiedBy: TL2P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|LV0PR12MB999092:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e000682-ac6b-489b-058c-08dec09d0aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|4143699003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ZdvIxWs+UrgrYIm+5XcBYSuCAfk0kaDv9yPLiz8ft+NYvR2OO9Vz5kj26SB19n5PLeKe91r18p+P0kkCGOt2U76WfRP5VzQLvdNpy8Q7jgVgXuURd7SVbsEUEE3UgPWxJn2CNrawCTaq+1ZapZ6BWirdQ6pzf7BZLvMrHzJD4zIRbMlFk3GPxQ2A/h29WmumXV+U3YZtzvhZ81cSyu75Bwc010z3DkFF89d6RzwKOsipeCRAtAIW5xmBoecmyR79/9EiG7HAtyIBYmL9wbf7NS6S99no9Ge8l520xRBWJ6Pal/T4wdBFV55lJ3QBZ6+Cg3ZBZy2j/Y+Dn81XXYeLoHTG1F2tpHHxH4rzak+y0Q/9aASSeomd8RQM7XE+RfQp8dRVRIrT+36v1vPMJKi33nWzSzgGQ+H0USHbxSwR5aeoZXexKvNNUaRz+q4Xt2FAcDDbq/O46c/5zL/YAvfxsDkVcwSbMDYPSmTdYQfaLlU4Mj/8mzMLjeSeAhpanbs2yIOI421ZdRX5RYT9lQ2wNL355qnj2KImae7gTDL4rdWytFrTsR5J0lpIAn1ch3Bgzsfs3aq6XyLnqIdZ2U/ALq71K/MSZWpuT3wKHJx80KRsM1woyKwUA8LbBCOAcRGCdoZt8xMX5Lb0oOZQ+pMvSIZErfJXk9CNkshNd+DDZh0VRNMCyvxBRK7L6Og7n4WV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(4143699003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2ixm62KaKBghimmsR4gu7mb6A22C4RD3b190Q/+DTbBlTozc/xxObctA5F+m?=
 =?us-ascii?Q?/3tLYpRS+jaYyV6OkBjpfIzRam2efxfLZl54N5W7X6Hu6nb6FWHJDVd6C2A0?=
 =?us-ascii?Q?dLXWdLAQJjeftFFo2aYgHNjUcbA5AygxQIj/sQMPdaD5e94/qmHjx64nuH42?=
 =?us-ascii?Q?kv5Y3a2fltvd5eFJudDX3nz7dPIbNpr091WdWA8xmi6OtB/xvtWIuzSqVhIs?=
 =?us-ascii?Q?1SNkk7XOwF8Pm4jluXY6XRPQcVQVpJ9wjjn/5ZeNBLxypTb40/dsZpPH1m5y?=
 =?us-ascii?Q?aRKM15o1Bfk15MqzHkKztY//uTqu/6J0zGZqeTNALOCepsLHBjXrwgoXuR1z?=
 =?us-ascii?Q?mONlO+x6Eyhv5LIGbbFj756iHae6E9AHFeQdZ86VJX1er3PNgHnLwuEMn/i2?=
 =?us-ascii?Q?PbnEpEkllDJUf/OeO7uj4wR1f4wIOi/xZHIywRfpYz9D37QRtPAq8hEDWEdu?=
 =?us-ascii?Q?qU6RpVOAsdCktPUtkT8VNW5g2VBGesrw3VC6k4Dzj1xL6QfBJNsUVYXWgb3b?=
 =?us-ascii?Q?3654Porq/r5U8N3SxNIVL3zqjb6szRZxJzFBVnXeqbF5AkrXD/JfeMRurTDo?=
 =?us-ascii?Q?Gw8mgGZAlUtP7GOZmVqXZ5bP6FYSyAV78OzHcfRDo/D6epE0UTKOw1WV5DxR?=
 =?us-ascii?Q?ziKID7lyFDD2diizc9q8IgM6V82TUptBoR7JZeh3zDtYMgiqMrNqPmwOr4dL?=
 =?us-ascii?Q?HVOphDEd2s27DpPUaeWxeJOblzUe1ufA4q7trtp9qu0iQ7jEfJAFVpFkHo3T?=
 =?us-ascii?Q?yXiYNI8HwF/fE39nJqmXMnZf+4fQhjXxT4EfV98qwARSglhBtQ3U0Z+5uoB2?=
 =?us-ascii?Q?a8FJHagqg4UORavX/5Brrgc8uORov4lqtPNtPuSXcZoV7yiu2PykJgf/U9mR?=
 =?us-ascii?Q?gsFrm+kCO+pusU8fTqdPNT3dDRTmqhRckf5Z/w2YE1IcNscGKlKbxz2stQub?=
 =?us-ascii?Q?OZoQF+uqlGkY+StBu1/UU0ABao2ImlWRCeHs2fQCu6AKY74B6J2na8Z4feW0?=
 =?us-ascii?Q?EAwtTu03Y5dK8V5pRj+QIuMk7WJEF3k8eoYryLwyPUiGwSXGmUwbcjCm5JqT?=
 =?us-ascii?Q?n1rLR1aPGKLG6DBDrit/FoXd/7mSx/yb+qcB/lR1BmF+kr9BmqUOAxys1/mS?=
 =?us-ascii?Q?dJXetQiEDW7lULzynJglJEZAY/u7cDDnTXW9ZTtUA6N3T5RiMOVJ725iHbEb?=
 =?us-ascii?Q?8a7kpK6o12+dfIg1ZnChB7bBS6RW177NBPunvl38vHLZG992lmCtTMtPPKKT?=
 =?us-ascii?Q?Tx62wK4orqIaalRN8H2mxLcZnkUfSd39wmFO8QP4ukgM5SrgMlPuM2jT4WdN?=
 =?us-ascii?Q?o+hq3NP1yxlmfqeYpzk+aNzqfBc3DrqGknxgntujdpU/8zeeXGGhRap5aIKG?=
 =?us-ascii?Q?oTB8GW/+zLpt8tuXByynTMck0ihTB1RkKdW1NkSbPPyhzGGoi2WHWH8YaA9e?=
 =?us-ascii?Q?+UnrKLDdqPwXAOEA2NGpu5fPUZ9bd1hArddzhPoL1zbVhmYaTfbskJOyGoCf?=
 =?us-ascii?Q?6H3UMBWQGP7xwZQS4RbziaHe/N6s0BS9KdwSk+9A92wASnqjBnEP5SeXvO5i?=
 =?us-ascii?Q?u5X5VGkyN6cvFHwf5XXWFwafxD/t4GtBjMIZjxD0OuEsKKxSmgv+7Llg8I+w?=
 =?us-ascii?Q?zB6qtjhh9x/hsGWYLZ89qcMxvdN67B5WTvtmDZybJ+RcnKohtOZYVo0un8jq?=
 =?us-ascii?Q?1zbRab9dPQKz7fT0dSgVHAMDpcnrGEyM7MHBsOi60364v/Yf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e000682-ac6b-489b-058c-08dec09d0aa7
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 11:49:45.7400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YthoLaZjr1EJrf7eyEDw7bY7zXQB2ijf/z/6gjqBTaxT0prKmIlO0C73CbuHIQb7OYwhYh0OdDzv6m8LKQLPpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294171-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:dsahern@kernel.org,m:horms@kernel.org,m:willemb@google.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB3A462DBB3

On Mon, Jun 01, 2026 at 09:52:59AM +0300, Ido Schimmel wrote:
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index b106e5fef9cb..14633fd72288 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -2272,6 +2272,7 @@ struct rt6_info *ip6_pol_route(struct net *net, struct fib6_table *table,
>  {
>  	struct fib6_result res = {};
>  	struct rt6_info *rt = NULL;
> +	bool have_oif_match;
>  	int strict = 0;
>  
>  	WARN_ON_ONCE((flags & RT6_LOOKUP_F_DST_NOREF) &&
> @@ -2288,7 +2289,9 @@ struct rt6_info *ip6_pol_route(struct net *net, struct fib6_table *table,
>  	if (res.f6i == net->ipv6.fib6_null_entry)
>  		goto out;
>  
> -	fib6_select_path(net, &res, fl6, oif, false, skb, strict);
> +	have_oif_match = fl6->flowi6_iif == LOOPBACK_IFINDEX &&
> +			 oif == res.nh->fib_nh_dev->ifindex;
> +	fib6_select_path(net, &res, fl6, oif, have_oif_match, skb, strict);
>  
>  	/*Search through exception table */
>  	rt = rt6_find_cached_rt(&res, &fl6->daddr, &fl6->saddr);

The patch is fine as-is, but Sashiko [1] is correct that there is a
pre-existing issue when the route is using a nexthop group object. I
will prepend a patch for this in the next version and add test cases.

pw-bot: changes-requested

[1]
This is a pre-existing issue, but does this logic leave the regression unfixed
for routes using Nexthop objects?

The fix relies on res.nh containing the best matching path. However, when a
source address is specified, RT6_LOOKUP_F_IFACE is not set. For Nexthop
objects, the lookup in __find_rr_leaf() evaluates paths using
nexthop_for_each_fib6_nh() with the rt6_nh_find_match() callback.

Because the initial score (*mpri) is -1, the first valid (but non-matching)
path will score 0, which causes find_match() to return true. This aborts the
iteration immediately, without evaluating subsequent paths that might be an
exact oif match (which would score 2).

As a result, in ip6_pol_route(), res.nh is assigned an arbitrary path. The
have_oif_match variable evaluates to false, and the code incorrectly falls
back to hash-based selection via nexthop_path_fib6_result() for Nexthop
objects.

