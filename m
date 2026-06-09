Return-Path: <netdev+bounces-296938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l4uuJbDEJ2pY1wIAu9opvQ
	(envelope-from <netdev+bounces-296938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 09:45:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0D865D598
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 09:45:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=UgSJ4NXy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296938-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296938-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49E2B30374A7
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 07:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326FA318B85;
	Tue,  9 Jun 2026 07:45:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BF833C195;
	Tue,  9 Jun 2026 07:45:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991105; cv=fail; b=HB4MCn3Mx7LQJ+AarJv1YRcO7tu90xxuOeuz4xJpUFPfrCRwCLvDJAaiER7/fpDUCI0jsf+qa7w3C7irGouioEqheZM/Ot6SKNp8vNMICVyoFQCp/zFLQm7w40QxEQOgp5RKeykmAed++MsLWVWM6wNpCfLjvKBUhEP+tY3Bv9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991105; c=relaxed/simple;
	bh=ESGRvBBkarlfToIhlvCSjHcMjIE1a8scdQmml4dihdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I21vYYgl3RRaCbZr1zTqfG3Jqx8rmMcZCxQX+qoZ/jv0qUKmwH03xufwC8qAXePFYAU+jgIUGOGENZHut9LKbBGdYnt9bcD1QYd26m1yo5uAZ9Mx02roKaN6WPd2emhnSNjasY2hsbXFV4O3AqDmSsXcXhVa8FAyAuq379RGSCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UgSJ4NXy; arc=fail smtp.client-ip=52.101.48.37
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkJZQr1liF6SmqcpIHceOQFFOjuNkgH1BK2zG4Ejzo8BX3tfwr8s36MZWUDMTK/Z5OHZQFO4ghVSENpkKTHXBKZc95GzMiFgd89JlVI7b4MRCzWj4nbkWIjPkv0+mGfi6VkrJd8Swqk4j071wfT8e2R3CUbBz6ztBnA7qrrLfYCC1lWXr1rjcbmjRMHZ2RK+Q4sGwNFHHfftznTl0fL3l3wAUwuGilDwoat0dqAdhQ2zWXN+b2L6GOH5kEN3gclgxapYsSC4jiQYKr7tErIjf2NmZonRLUazGHj9yqg97Rm6oFA0TIYGWPuWBqW3Vs1S58b3dlX7n+BsmLHFenTXaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqxetYIIWY3+MZ/+NKPZJgiE+gRGgHXuuPxWGKQcoE0=;
 b=Zcn+/wfSALziyjs1NwX3QyQh4eNgYYg+ZusKO+CV4nIwGO1IRtaCTt5ASh9uSjVOSoz5IkAKO3vTvY2lDIJfppu6F9JBF+Uau9bbZ+QWu7AS9EwT3tj1Gh7FvlSqwEpbnT2nC2yUFtxOyU17SPTc5B6qloTtGDjQDU5RDXT76U0tEe5dqE9Z+DsVYuMlpNYeRQSJOI3vgWEnQMqlLsOelKhYnLzrHAueMF1JgpUcyVQUZl0A7n3oI6ZCxJxGIN3lqb+xj2TDD/HifcHKAijOadAAoSqq/ZTzoY5Rlt8eyjx/EvKfIRDpgmCYFvaR5xpvzTevkWll2tJp07TjAcETFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqxetYIIWY3+MZ/+NKPZJgiE+gRGgHXuuPxWGKQcoE0=;
 b=UgSJ4NXyEX7NbYFE54cqWc39AJOyhJMsGABNup7PyUKLVaMXJgSsSLLTjdZ7FWQk0z9rauad8Em4yuxIsv57RBix1prLfR9k9SVJo4CLvTwAssKraCkxJTrervzGCcBj0wit5YWiYbAdQXTKwW8g4o/m4RC+uuOIpsDxt1t40wigJikFzc+PHieOJ+KUWaIIIsycnW11YyTLw9k8C0OGqDOGNPN4ZKCB5S6XcWgGPffcKYTusqiN35xrl+IDLKTthbzB3GHbpB51I51biqu1KoimE84Jfe2o7/n9tqrJwINvS7FqmYiKr39w7GtLdDKZHT0DMCreqoifaFZk6WAxFA==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 07:44:57 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 07:44:56 +0000
Date: Tue, 9 Jun 2026 10:44:47 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] ipv6: mcast: annotate igmp6 timer expiry
 race
Message-ID: <20260609074447.GA663407@shredder>
References: <20260605145759.59639-1-sigefriedhyy@gmail.com>
 <20260605145759.59639-3-sigefriedhyy@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605145759.59639-3-sigefriedhyy@gmail.com>
X-ClientProxiedBy: FR4P281CA0267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f329eb7-a019-47b0-5216-08dec5fb005c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|3023799007|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	UutKmZP6opLu4x/y5oBn93c4tD3GgMzOBxIvUvFxCBckFFbQ/+aUrEct6F++C2vEHfcl711aknSCQ3awo8zf+7yMXAAYglY/RNoQwXwdkQYbHrRFUhFstmnBdNq8V3o7y81maxeNEOTcT2s/Z91hs59P2oPpu8MfXa/4gB34YPUYfyoyXGMChhHbRej65Nhlmmg9O4aJfyjaBsjeDm7pqzsbmgxZsCRrWUkG42oTmGcvShE+6OrT+YvzWGU8jXky3Sl1qbv+FkNhs0QpDDNe7HwjZjuaicH8f7MlszyhOFUl3bpvXWpWEhkK75R1WQZmIdyxOnztzuIzTTKfQa9RBxN0k8YJ4iwgMpd1QLs5H3mKjsfd+6Xy0mu7SP9WVzPQk1ccxIx1EZF0dj1JeWUy2Sb0Oc5fA6J3xt2DOXyHJ6vJ/eBZAuDk6DgFc8AUNLU0vwV4FG7Nqkn73cB5H7n2ea8rQH8bn5oUuDIP5ITknNG/dXP5xpmba9OCONDv1agsh8I+ltZxM+Qhz6eaXUhWI5+3z8iNWsd7GFEGWrzhljfGyr9hK1hIwmLrfroc+6ywdwS/wss7dZUsKEKdIfsiSL0FW5eqm3Wl5Dian9bjwdiCoMnKDrkWV9FyNxwuCq69g0OjHLsnmmE/PGtR2CFYvhHIRDNSU5NUdn6t7/EVg80YA3d3oBTt2NW/AQdyF5wu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(3023799007)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TlLUrMMSMthuaPnB1mLT6M1KaXB+Y8TssnIkjZwZDqyzW52TEFsmEWFc8llk?=
 =?us-ascii?Q?tSRysBsSTvZ5iAWVU+Hsmh36ITfKwBJKJW5+GKCHyB6W6y2ebA0KgGEh+fcV?=
 =?us-ascii?Q?++u1a+/vGX83Ixn684Mh34EpDQMgz7nJFUUQ3b+gv/WC+bJFKGj0H0H6fe5K?=
 =?us-ascii?Q?sqCZ7TX/yMrNbvd5ocQkowu6xzL7P3izseAq91xtoNYqh3DtbApOnIBhoNsi?=
 =?us-ascii?Q?Mo5DqEPI/DcXxCuYeVDy9OWlT8skd+DxQM0WqqZa2aBBAIf6V/gPA1Wrq84+?=
 =?us-ascii?Q?/YhAqABWZ4dZvdezccS4ddFobQIOKX9nZhhEG/ezqAQgEQULpG0savENGrkq?=
 =?us-ascii?Q?yNknYRy+9veG3D6dJbq15mLtiiEjMX3EdFlT/iYzkDoDE5Pp9sU0Yc/AhH1X?=
 =?us-ascii?Q?2G3kYHN+CcB/hPfo8+yoqw84P9apIHvz8rT9zgvLLmtaYxqCsc+DAppkLHbU?=
 =?us-ascii?Q?/pyQqzP3u1FzpBX6jrwonlX6P8ye/rbkX9ZFm2buQMyip1acOQETZwQuiOGB?=
 =?us-ascii?Q?znjW6VAG55fA/hOuiLBI2MJQU9OFSxYSYDQd9lwEWLD8N4ltmVaIhtkiIdhE?=
 =?us-ascii?Q?qSYiIEaK/JwTMYnd0dXL+lYmDpMZFpYEyTd5OekE0eEcOr3B7cEBVpRvf9jB?=
 =?us-ascii?Q?0ls/4pNQhilS1rQMfCHGFfwjz882ADKdWWSOYTqmkYATCZTymYs6Ots8IDdI?=
 =?us-ascii?Q?hZr5yHdgLnJoeGcUiTrnpAC2hUaOuk2f6KRvpFt1fqV8LpAYCkPXGp17hF/n?=
 =?us-ascii?Q?bLgNINQkSJpoZS8vdafnnDWUWnSqAARh9SOZio3yX4MrYFrFGJFoftl0o9CW?=
 =?us-ascii?Q?xYW88N9parMSLkHAJHiWOqLQb0KxNn1+ntVYWtjvbDZNoiQgv+y+2D3KduC4?=
 =?us-ascii?Q?KORShUQzQBJKbOZOnyZTjThg/0XxVffhdS7JcNIn6AZD7+WPx8J2xn2W7jB2?=
 =?us-ascii?Q?ASqA0WqMLv2on6YowFQwiCbHVNt+2wCqN8fbu3kCsId/yCmG8et5H+9sSa4V?=
 =?us-ascii?Q?jtjkxg5foTPv81Glk2ad45sPgDn/NDcRyrvK5H3P8uXFBSPxosuOg8mSwoNQ?=
 =?us-ascii?Q?XVVM6ks7QJzvreenQDiViJpKGDKe8itQrotjtBuXG5cHwizAkfVRh2HRCTLT?=
 =?us-ascii?Q?aeP5PCisvvfdHzMuQ8HVme00cJlRonzoVYX7NAt6EDdyDYAwPx9sf1ACfOfP?=
 =?us-ascii?Q?/m3r8xm4KWEA6NWNtt3cz0Y5aNTC0WPXf+Di6Y018wAmshxtElYUQf5m4gI2?=
 =?us-ascii?Q?veNR7T23ifW4/kZrHcWlqeUgP7/h4bxQxSyI2qFURyjj1TDvDfAdLvCZ3RBw?=
 =?us-ascii?Q?YakWfq0YSpSbXOaoBcjcBRHYYeQCnBRp6Cdb6oqTYWDdKrRVkOYLEHFNPqXo?=
 =?us-ascii?Q?nx7O6tVDZGM2vqoPmFL9q89+P4p8EA8ttW+Gp7njrc+ygzU+P7QnTghUfK59?=
 =?us-ascii?Q?Gjn/L+FR1OGxVh/yz8NiU8eClssS6LOKYrAdvUEbCEkCdNDV6EreVpHKobSU?=
 =?us-ascii?Q?5xbRSvrk0BO6EfNUvyLN9ZT2IJA51EZ84Fw2Z41QgBb3f46Zxu7q6d8wM7l6?=
 =?us-ascii?Q?rtdaiCc7YpmRvY+TxlHB+UYwjyewZ+ySE8kqzBCXGz1/WHVew6ihYjfKp+aX?=
 =?us-ascii?Q?ykwuI/OpZWnh/EFDGLwSWdS1GTRBDz8ngBn0pxmlnZ/NN+1IyWpe/m4CHYkc?=
 =?us-ascii?Q?xP60FkBUMIHUcXj0uAAyEXa63iq8sLm3DW4+1SkzQmAWcaGz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f329eb7-a019-47b0-5216-08dec5fb005c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:44:56.7987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEqM2WWbe1exOB2yIZh7ds/00XbY+sGA6SjufqPDwqEX7q18ASwyMhrL/pjMVHKrwJ0xkGoLskNcA0+eO9hvmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296938-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sigefriedhyy@gmail.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	URIBL_MULTI_FAIL(0.00)[nvidia.com:server fail,vger.kernel.org:server fail,shredder:server fail,Nvidia.com:server fail,sea.lore.kernel.org:server fail];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
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
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF0D865D598

On Fri, Jun 05, 2026 at 11:57:59PM +0900, Yuyang Huang wrote:
> /proc/net/igmp6 walks IPv6 multicast memberships under RCU and reads
> mca_work.timer.expires to print the remaining multicast timer. The
> delayed-work timer can be updated concurrently.
> 
> Annotate the intentional lockless procfs snapshot with READ_ONCE().
> 
> Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
> ---
>  net/ipv6/mcast.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> index bd3972730aa0..184e57469086 100644
> --- a/net/ipv6/mcast.c
> +++ b/net/ipv6/mcast.c
> @@ -2983,6 +2983,7 @@ static int igmp6_mc_seq_show(struct seq_file *seq, void *v)
>  {
>  	struct ifmcaddr6 *im = (struct ifmcaddr6 *)v;
>  	struct igmp6_mc_iter_state *state = igmp6_mc_seq_private(seq);
> +	unsigned long expires = READ_ONCE(im->mca_work.timer.expires);
>  	unsigned int mca_flags = READ_ONCE(im->mca_flags);

The comment from Sashiko about inverting the order looks valid. In the write
path, the MAF_TIMER_RUNNING flag is always set after modifying the timer:

"
Does unconditionally hoisting the read of timer.expires before mca_flags
create a time-of-check to time-of-use race?

If a newly allocated multicast group has expires initialized to 0, this
sequence could happen in igmp6_mc_seq_show():

CPU1 reads expires as 0:
    expires = READ_ONCE(im->mca_work.timer.expires);

CPU2 concurrently arms the timer and sets the flag:
    mod_delayed_work(...)
    im->mca_flags |= MAF_TIMER_RUNNING;

CPU1 then reads mca_flags:
    mca_flags = READ_ONCE(im->mca_flags);

Because the MAF_TIMER_RUNNING flag is now set, CPU1 evaluates the timer
output as (expires - jiffies), which is (0 - jiffies). Does this
underflow and cause /proc/net/igmp6 to print a massive garbage timer value?
"

>  
>  	seq_printf(seq,
> @@ -2991,7 +2992,7 @@ static int igmp6_mc_seq_show(struct seq_file *seq, void *v)
>  		   &im->mca_addr,
>  		   READ_ONCE(im->mca_users), mca_flags,
>  		   (mca_flags & MAF_TIMER_RUNNING) ?
> -		   jiffies_to_clock_t(im->mca_work.timer.expires - jiffies) : 0);
> +		   jiffies_to_clock_t(expires - jiffies) : 0);
>  	return 0;
>  }
>  
> -- 
> 2.43.0
> 

