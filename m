Return-Path: <netdev+bounces-266646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFgZDt9ssWlVvAIAu9opvQ
	(envelope-from <netdev+bounces-266646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 14:23:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A19C52646C4
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 14:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3E3031979FD
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 13:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C916230F95A;
	Wed, 11 Mar 2026 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RiJTyx2w"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010057.outbound.protection.outlook.com [52.101.61.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAA430F52A
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235193; cv=fail; b=SsbRIA5U8HBkz1Ny7d4yFhzrF3GQ/0tUv0CGCLfU4ki2JkcfJyKAwLd2Emp5UWZg3Rq7GhYDrl6YpEY31oZYXaTfMV1Rc1xK9VfVtq/XvLE7KiLdB77FqiN4itPYgV+Y0JN/vJJLLY1IYD4/PRKnqr+3Arl1b8+d+2xzTYYNPJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235193; c=relaxed/simple;
	bh=mPjb8pXiYrv4EPc1oOVuwO/fUaGC5qLkkz8xE5Lp/l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oKs0594C3HkOVeV8LDYwIwpSfzBgKrANaxZbzwBpPo7jIbZu+yUQWkGumucPY+h2cLibJ+1yZbLRSJ8AUUDKajfCCf/VDZxt5GDUvWkeTELL9jTzxg2lxjwWVc6fLpe5p5wfz7hgWsKdtzyRSGeTtZLKItwVM6Io9Vd4q39VSbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RiJTyx2w; arc=fail smtp.client-ip=52.101.61.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCdpkCc6DVHW09MYMnPQUjjaFGP4ZUrxBfvfDS4ieVy2DO/7Uu7N81vmq+6+P+2ouKClWYHFU0e1qtYEoPWhO2DSy4Q5Q7PWrNxZ5sgMoyzIKp1a+N629Puz581b+2oTYg/bcoa6WuKlo25cxoHP5my+XpmvtulEb6yKOdQacXesVhUzWCUUQvtrLrk5fmywhRNUo1TvlslxUGfoBsN909MuW95aSkFCiqOs2Blc647k5QD3HS5PNU4bONO+CzFmXVN0wx9AicH5ySt1aZ/JaxDYtAqf1b+RIwQGDZDrYw9dlF6iegrWeKPw/lVCu/s2J8Is6xJEKXUBvAOe321H3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rDr1Btx5464YoY0LbLGjY++N9JKfcxue7tkbhJ50vY=;
 b=PPG5vpL2Xhgl4HD5ziYkCzT62exZZyNCTI5EEIKnXk+fITWN8BxEe6IWO4MeILMCU8O4F93hshVdlqzsJVUceQ2+AEX52ozke3AstdPmIe0tgMjjk9ZTKx5emtK5BNiWTeuTnTI6ptbthTSLDmqBmZRtoFQI1L5haBBOvyImuXW0uEK33MUA774d7BVKNBoEMmHB7qFbBjaTlHSE2qb4nocWedGj8guk2TC93Xfmxhkw+VG6yOIYCT2KL2G613RQovhV73pOMWfETXGGLQ7w6ZohrWoKv4k0EWLwxfy3PVnWQQBdrmG5Pbnc5vkxC/oy40kUgwzy6BmiZIAJnBwWGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rDr1Btx5464YoY0LbLGjY++N9JKfcxue7tkbhJ50vY=;
 b=RiJTyx2wlqcqkN9E6CXr+FSK/zyoOA+2blumqa8fklawj26/VOfcKkViZ71YPvEvBEk4FnP/ww7RAwfp8sD5MEHRGOLPXu/Ar6ov8tMOz1jAYX15a1+9e9AuLbRAWJoAcLteCWkfCYa4r2VZS0gmDW0mRzzBx69wMOn2jI1aoXEuJ6B+d+tm9I3/PbRerex/rW2az+bEbu2shM3yfiabGut72fkK+DVAqTi6x1viaSKkjTyNqIT1TIEH+MZlj5SeKLH8oHvDw5WxVLJwzyzTgGnk+fvRA6goGPZfsKb6d/YI/IHLfEvVKTpFnYvFUcxaLYCQx9jSHTxg3Z4LbEHczQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by SJ2PR12MB7990.namprd12.prod.outlook.com (2603:10b6:a03:4c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Wed, 11 Mar
 2026 13:19:48 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9700.003; Wed, 11 Mar 2026
 13:19:48 +0000
Date: Wed, 11 Mar 2026 15:19:35 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: lirongqing <lirongqing@baidu.com>
Cc: David Ahern <dsahern@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH][net-next] net: vrf: switch to synchronize_net() when
 releasing routes
Message-ID: <20260311131935.GA2415888@shredder>
References: <20260310105331.2371-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310105331.2371-1-lirongqing@baidu.com>
X-ClientProxiedBy: TL0P290CA0009.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::6)
 To DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|SJ2PR12MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a7cc1a6-011d-4ed1-f15c-08de7f70de4a
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	v9hDA1SVAm5LSWF88ozJIT9+vhe9j9x1NMpKfeTEsTUye02VqSaM+aKK1zr+HL56r5AVyvFyFkm82LnVZiI5lptthcdkdQtMS2t+4DiEc778Q+iWiDTOTHqHRp1BAyuTahluLkWZGGKVxUckdzDshBRVRdVlCniIIclpaWF33rKVOl4PjgObEzpDuvPQp4ZYxEMwa0QofZMs9YlxFCmVCwYdh1qsCIDEv9EomMINExwdeSsG3TN/VpbcKnXbc8ZRLGmrGxODfPuPU8DAHAaX3C1OCeAd4JJSscMOQ5WjcZosoHsD70d7n744QLCtfySo5FqkzBpDwB7bR5bEnvC4+7DQprCk8UlpcbkHwBy6a4L0RcbAp9rvGZAaNP0XLMkC9Ffw2qDIF9zWYu+C3LqtaKapUg47O8LY95QNUF2IANmbwGzf1WsF2JHqCU9PGTUQIZshwJmh8T0sU+HsysrszFjQVTveC1dVrWRPCjHsDZSkW8f+deOSLf2LkAWjZu6+O3PZLxYyxl87rGsfwk6pmuDCC05GQkXZi2gthB3bTOK7emmX7hLmD2+LvhGgsS0ETPEWFy9gCD14uJUsmhugO3Y5GqJzYiV3SlNTKh5BsSEjsWGJXuE6y9cmd8z5gY1f4kVFWQY6/TytghvyTQjHP0Mn6/RLMe8Pg+zmU7LQFhc0S2ZCssRIe/us761BNgoNqkvK9ibbFcjnx0bm/wO5zVEyXccNZgC5cO6L8P2KRDY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EaZ6cuNGXLt6WD4zMVRMjJ7mmitWti+6D+dADJwJ9H/joQ3tADZskVUk1bus?=
 =?us-ascii?Q?jywsgaqPFiZgj7PiNS1nI2bAoumOoFRxHz9/ovd43j2vKpDsQ51EuaeVcdcj?=
 =?us-ascii?Q?rOqDdvC4/wnisD091Jd8Ln5vsYulaY9mDZwFAvkB2TVwInMCzDm04KK6v8DM?=
 =?us-ascii?Q?fMDqyzSDbYROYflq2Hz1i5B0/5X9YdPiU8Q0eI/9NZDo2e15mWhkq3nTQ9XC?=
 =?us-ascii?Q?Kn0irf07GOXZzRV+Wo8LhM7g2NpS58t7fAdKpMniWOc3cEC5ClfOfcCUaqsV?=
 =?us-ascii?Q?Rv8f+39mpBV3zEWD2TSKNHMiQfBxJJfThROkGNMe3Km9Y9NRew9Cv9VZLFIM?=
 =?us-ascii?Q?6/gRFohzt2o2KYFGhw6bkBqepM+Af+ZZrYVWFVVUiVO57uWdAKY7/9rjsuYK?=
 =?us-ascii?Q?8TdaYYvnxTFCd4csN2ZQXgtWTIKu3SFgeVoFFoH5izcq1NLirTWmmXZUGdMu?=
 =?us-ascii?Q?saUWQJIq51MPBpYbGW9QjdZ/JIKxZuKK4XGKMr4wDs35oojYZXdC4te4xb/W?=
 =?us-ascii?Q?02PNZ7QVn/LfqlE18FMT8P3qbS7rvOL0uLwThe/fvdQK7tgLfMRz1BoIxIoC?=
 =?us-ascii?Q?WAQFXZCCqaPrgN4obqFsDeYZIlbchaKOETL71hOSkcyI7HK+Y5i1zSmGkWjS?=
 =?us-ascii?Q?592UnvA7toUJMbxBryrnoDfcXx4iv6WLjVZnOE6AOKxCmVSnhf1WHZp77pn7?=
 =?us-ascii?Q?QTPmiwyeFBoceWzusKNQGfYM+BzHplk2rHmjf2wQ9O+0J11p2TfwIlnnIi3T?=
 =?us-ascii?Q?0O7cuX5cnuLVWVEJEMP3NBgnmOg/+3VynrbplYFdWkd5qe9bcsZ6V5lgs27+?=
 =?us-ascii?Q?JFIRCbxC1JDQbPuO7crzqk1fnGnsT7/AmYPm3yIZKsDSBckb1fFD5cy29FIX?=
 =?us-ascii?Q?MipCkLqZCxrPbheNc+fZlRcev02nu1fPAKzfudbfpOpqg1KlQeTIwn/Hl9A3?=
 =?us-ascii?Q?i3SltgLPELIgBBbvht8RBCe60Xc1lzx3u0A/gBA4PPoguneYv9JfO/GCWk/l?=
 =?us-ascii?Q?hDzVHYg/PEtgM3n9z0tJrSNaXCPPsuXNcNZsqyQw7oZ3oOpg1q3nFAaSOpn8?=
 =?us-ascii?Q?2ZQovcIJ7AmaV7gM9fN2gHHfTs66vmrv62oO+UQkQKf66g1FboOe1M/afSbw?=
 =?us-ascii?Q?gSkkRQw7NklXfp1byfuhhCqD7Rmmeg+xEnG7Zru+cdlhLltTn+FdGlL9rMJw?=
 =?us-ascii?Q?/KUAEpuJrADFdVrtx/+zHtBQ4Ep9xRFfH7ocHfcebbB/aOlICYldXZApNKyP?=
 =?us-ascii?Q?oRqg2A3RFLMTDBqNBJvgr6buek3nxTyYykklTCYkX4e675kOhTRN5V1b6rDt?=
 =?us-ascii?Q?XVpst21I0nBr4yib6za3KGX4ItmUEh4YR+y7Vrg/KlQLZl0HZha+T9KPRRbz?=
 =?us-ascii?Q?yMhgDgInp+USVId3YCPOJWGOc+lX+8tw6oXe5BlYAZx/xlb0m9fC5TAz3NNQ?=
 =?us-ascii?Q?CrjM+FiMIrveytCwT3Qd3qYaux/8GYT2V1nqT45c/80b1kRGDvS70jd/Ymr7?=
 =?us-ascii?Q?lXl1anKUAYqVP8AVDcNSdZsqLLSWgf+H4yAY/zKzFKjVNlKfe+7GJ5O1KwiL?=
 =?us-ascii?Q?lNuCsPSMG4mJ1qzkwbi39QvNpFTCGHdDD92jP1EZdNof9DOI+KYAhBUtKvcn?=
 =?us-ascii?Q?deGWgW425200PFzMc8ud/5Akxe8V5H2c3o7b+KtDY0qldM0UROQVZdwTk4x9?=
 =?us-ascii?Q?jhL3TrWuMZ3tZweiqTVYiVZPIvUcA2zXWkbEnWRrNo4N7qTHrZgOlf8dXUwp?=
 =?us-ascii?Q?0678QiHZYg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7cc1a6-011d-4ed1-f15c-08de7f70de4a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 13:19:48.2033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWazsIlz0ScwlgRwSmlJwI6bXCbcKu0d+SUGqw289tW4EhHNvljxkMCn6eNCpVcHSLKodmsuppS5ziM45fJUTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7990
X-Rspamd-Queue-Id: A19C52646C4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266646-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 06:53:31AM -0400, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> Replace synchronize_rcu() with synchronize_net() in vrf_rtable_release()
> and vrf_rt6_release().
> 
> synchronize_net() is RTNL-aware and can use the more efficient
> synchronize_rcu_expedited() when the RTNL lock is held, avoiding
> potentially long wait times for a standard RCU grace period.
> 
> Since these release functions are called during device teardown where
> the RTNL lock is typically held, this change reduces the time spent
> in RTNL critical sections and speeds up VRF device deletion.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/net/vrf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
> index 8c009bc..92a0f4b 100644
> --- a/drivers/net/vrf.c
> +++ b/drivers/net/vrf.c
> @@ -755,7 +755,7 @@ static void vrf_rt6_release(struct net_device *dev, struct net_vrf *vrf)
>  	struct dst_entry *dst;
>  
>  	RCU_INIT_POINTER(vrf->rt6, NULL);
> -	synchronize_rcu();
> +	synchronize_net();

I might be missing something, but why do we need synchronize_rcu() here?
The code below calls dst_release() which will only free the dst entry
after an RCU grace period (assuming we dropped the last reference).

Also, I think that instead of using net->loopback_dev the code can be
converted to use dst_dev_put() before dst_release().

>  
>  	/* move dev in dst's to loopback so this VRF device can be deleted
>  	 * - based on dst_ifdown
> @@ -1002,7 +1002,7 @@ static void vrf_rtable_release(struct net_device *dev, struct net_vrf *vrf)
>  	struct dst_entry *dst;
>  
>  	RCU_INIT_POINTER(vrf->rth, NULL);
> -	synchronize_rcu();
> +	synchronize_net();
>  
>  	/* move dev in dst's to loopback so this VRF device can be deleted
>  	 * - based on dst_ifdown
> -- 
> 2.9.4
> 

