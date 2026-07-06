Return-Path: <netdev+bounces-305124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Umm2NcfoS2qOcgEAu9opvQ
	(envelope-from <netdev+bounces-305124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 19:41:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A8071400E
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 19:41:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=pSeYGVd0;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305124-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305124-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35CA6309B472
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 15:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC3C3A6EE4;
	Mon,  6 Jul 2026 15:29:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013029.outbound.protection.outlook.com [40.93.201.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA24E3921DD
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 15:29:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351756; cv=fail; b=Edo0J4lrpB30KnAVVZ+JEBc3ctdmj6hGLvai/W95FhyooBqzglO7p7qU/+ewtQ+nNavhlQeSlrWv2et/ryE1cfzYJBj7MJz86YkUd/vi9C4xc0TdouchbzfiLHIkm8FaG6a+2ZcSWZPo22ZU2ULnT8vDP2ggC6yKnUJRCmSEQ+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351756; c=relaxed/simple;
	bh=3X63jBeB5BcoJOjStZ7Zc4WiSU1jf+gw4B6rUDS8hpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WwAc5n1Irw9/KwlfdL1pUzvAKuSK1dFFC3xxWLX5JdI4yect60HdNDuDTSg0ZXuH3xeQxQxH8x9Kbt6q8AmfYgntbrpQSNQ4jtKWSqhZwTgW8/UIBNc61p8vCwNgeAC6UCxxcEo2yjNfLV+9xzRh/OLSia2LNuSfjz6b3d++j4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pSeYGVd0; arc=fail smtp.client-ip=40.93.201.29
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxVbJDHSF0BAPg6RMTtPSj79HYXdmNJhLD1WpFTfbsvNUt150M7jXlCZDLCRgySv8g3nbfqbtfUUiGgudGxAeZg/j47JLFH0V2apYUgGlO/3gRU3oS/URWOEi21opb3Sg2gFLKmnYBwUsURK87cyUbiZ/soh/2maDbuvWoPc4Yq22n9ljpcJC2ZXj+oV/XEgJZKMvyd+jVQLF5PyGQIWu5Zofs4V87Fb/t3Ot7/pZVGyyYbtaH2YMW4OOxQsNcu02Y2mLJYiyhzaG2ZN5VOwKWEZbxeSc2iB6JWmL7dFFK9C1un5ea3qwQ8UZJKd5mmsYIDv7fRJ3uwObIqrqRU0YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujb+7eXax4XWLVGSBTsiBYZZd+ND3hJ6Pkcbd5E5I3M=;
 b=IsHOW6404GSA9F3j5hdls+66HBj8/zoxVhhYy57Ru8FCOrOzadG1z9zdS19Ee/OVjJzcf5Zf0TnxnD5AJq47gcqzzX7PyrqB9m0YUAtAbIANjhEoYk67BxvN+6AZnV1ziYVk/DrWeWNZ5uebXDwsrzf7koeEA3gSVjiIydHbwyVp8PMhWIEnNtHDqYvYBTxbicsLE+1pEzZ3GnSYWaJyyUakkXM3V8tReuy/bwiaUFJvEoQJD9jrlaeRfkMAb2HfDQKeIhCcFfmD9rDlRx3Tq+TvmVqiTaXRDoJR0oapCKLmsBkREb66sjUJjQdWXfysazh7Chg82DzgBZuNeaJxCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujb+7eXax4XWLVGSBTsiBYZZd+ND3hJ6Pkcbd5E5I3M=;
 b=pSeYGVd0jrswKE/hecPruqkN5yKsEa13OTfyRZm0HFJ5IMsS8shcc3nvSWEjXcKHqCDEElAQOClXdYc5qL3DOBbZKXb6MMwKPfIpszw09Ge9JpD5YVrLJMy1zUJVKZInLTatn+C3XNEi9n3+9yrYf7zQAOPwbPItVsiWlj/5mCMh2Q+XfNClFNimlaVCNUNQ1fBnl70hgY/nSLsSDfzorNgfNV+cYHdNB4b2sGwY10A5TEy6ErjPYb1W3/Ybk1Y1TxBbaM3fzetFgNqZrc802Yiw6x6ZG472v3wBSeIrumu5xxtYdWyGx7K73xG7D3aQjj4rA8CvuA+l1fncvLdFLA==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA0PR12MB7074.namprd12.prod.outlook.com (2603:10b6:806:2d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 15:29:11 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0181.010; Mon, 6 Jul 2026
 15:29:09 +0000
Date: Mon, 6 Jul 2026 18:28:58 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	Zero Day Initiative <zdi-disclosures@trendmicro.com>
Subject: Re: [PATCH v2 net 1/3] ipv4: igmp: Fix potential UAF in
 igmp_gq_start_timer()
Message-ID: <20260706152858.GA410724@shredder>
References: <20260705181756.963063-1-edumazet@google.com>
 <20260705181756.963063-2-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705181756.963063-2-edumazet@google.com>
X-ClientProxiedBy: TL2P290CA0016.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA0PR12MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b089411-a60c-44ac-675a-08dedb7352f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|366016|18002099003|22082099003|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	BQgaZTtJqn16y28ulgBGeTUMnleNbHuGPgF7Bz/Fd38QOeYHD3+5Aa7wBxkocaE8+tbMIjf4NF8dmR0ulyOYuHqnZj/QKyKGXiLDCr0AoyA3DX3BDQ69NOpSWKnAoNdLCLsdy6WA2zHxiRv0CdL0NtjvHiMx7+xcTuHd+hL5vB6lttBcDyf9dlZMgUXZIx4MvBVf2v+P7rb19SnHOHg7FCKyF7tIt+lNSXD4qDkRXC6oJX5GCLhQh6afAteDknOTKkjmmQD7N/5cQDTXzJhIzHSqpOVse5gfqYrgwmjv/5BVfSa0e7mfYVotftXMdS5+Y3sPO2g5Bbz5M9geqFZ/IPg145T8BGLuqpNOEkLhmFZOhdR2H6wYlyOq1LKNr2Fd6b8XrLcx5PJ/wD/cDGYHTbTO0v5Rjekj9asvTd6wq2Iwwi6wICvL0Gor84xX4BoUS68+p4NNh1oy77q/93n7FALYtlMEKxnYsha5eODqZ37vqXUsg2tTK8u/FARf+x8IGG4ZP/uUsc9zTbRQbIT4J+oGjCfS9UnJCvQm8VclyTYkcZVXYI75bfqHrZIHoNu/jk45INE7xwLunqBS19JRSrOBsc1VlBB5M2R5Z+Q9hwfxkAZ2fJ66KxeGJ4L0vWe6bPM8z7a3u1tKfWQMV+zNil+4bXlCy+hpJIYbyjgOsPY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h6rSO2xgDxozZ3Q4xSRWxfnyFWjcBIY6s4DNHKJo62HR66Tz3r6+ASmunmGl?=
 =?us-ascii?Q?mhkzGOXAV9FwP4SygEDm0/OfKoxvhQI9zdMgjzJNLv4T+FpMy1RBdN6p08/S?=
 =?us-ascii?Q?6URRmB3SDc0UvGUcKLHa7eudizLwWEtnvuPC6vT0Pjq3wJzE9g26Q/IfHdAl?=
 =?us-ascii?Q?r72ctThVYICAkEiKMfpl+l1HKAhO9W5mzbMN2P1Fmgis7HI2lYGWPGNehCnE?=
 =?us-ascii?Q?ysIgCuoNZr/9THlOGh8Xqivows7MOiR01gS4ShXYrLYevt/DQBZb+mL9nS3p?=
 =?us-ascii?Q?ee0JfLfoUpblJGWLr5DEMFEn2B3ZBV7fswDtuENuICVu9Lw+mysIn/QEdQKo?=
 =?us-ascii?Q?2zqpj0Fl7c00MDHmNjjW62rzd4Xka4DLSLyYPhb0SKCSomuxInKr00aRT2Nu?=
 =?us-ascii?Q?3h04mB9GFJrHG6DLT0PXTo2DAMhX2/bUEctMx38JwITUHekqzydHTH8BVBR4?=
 =?us-ascii?Q?KXdWkkxNLONUe8VdEhf5wvH3BshQoK4X1swMXeNSI3GZj/kElMLmiyaWquyH?=
 =?us-ascii?Q?NmX+Ou++3iIlPfKQvUDHpNnUAI3Ws6wnCQDcirP6o6b3bZBt+XGGaqq2QSfy?=
 =?us-ascii?Q?a6x9Op/dEyYi7oPSF89exrZ4VlmqYj5mrxdgwdA3in7ta4FgZV+ItPAOZGs6?=
 =?us-ascii?Q?4tQYJMBsw6GEXKQfh5/GIGMTK4HDQ1QI26sP1um/ibgVQ5yBcSpllkig9Lhg?=
 =?us-ascii?Q?n0nqkOo2NuxAmGYLcsTVH4HnZOJvK2XkIV9IzOVvksrz3+gRYaKS5Kh9jBIb?=
 =?us-ascii?Q?oEGkPBf/hc4TMMYG9hfZi2jgPobn9ElmHShVceV8WRb4vJ5Mfyd+wg9vXLIS?=
 =?us-ascii?Q?Xu3zSirsCTFA1PXy/ko+YnUguXLR6OtkfSLU8jHSR5jDH+oJ87YwZCVDuojy?=
 =?us-ascii?Q?eM/bw9Ws2dIt0UHxFUmPs168h25EnCzH5OxHjzP9Gmekd9JZgbyKdz4Futlu?=
 =?us-ascii?Q?l4Fe2IGkoyCv6EMU3AwvYOVp3DxA4hN0Y+ZFJXC/1LJDKo26e/HuRkoVqDBd?=
 =?us-ascii?Q?IsTdTXZyGdQmEOedGB2kzO59qmNHQhx8uKGm5B1fqcMI4eFUMDHBNvZ4//cu?=
 =?us-ascii?Q?pq5nclAwSPT8YECUFVtJRqA8mEgBxPG/Av5tFt+zpT5+IPfXchuNMK+AWeuX?=
 =?us-ascii?Q?60Fr5uOrcLMEg8sBx8jiPllUVa3NeHlA8wsaELJu3pVRnq5yh63GTq5EkwDq?=
 =?us-ascii?Q?ZB+lP3vUiP1f4eqC0PfF3o5ZeD5+kyH4bkC9NBXoTPLWCHKHopXMy9baVCH7?=
 =?us-ascii?Q?LP+fI7rLqgjsvpdoMp731REP5a/tr2lfGdHgMKiRhjvzpOOgoJinZ/ZlYuh4?=
 =?us-ascii?Q?LXB0CvVUtBawb5A2e0OvyPCogRghzDYyauFQcaAGejJBY4uU5EHi/4ft9MzE?=
 =?us-ascii?Q?pmSoDD2dIx4JvJ3ITwbbraebq+SxtQ8lGmPX20ZgY+xuNQf1EP7A3Mmvf5Bg?=
 =?us-ascii?Q?dxd8MzwZ3nBjISfzoQDtnztfYgsvAhHl9rh0Z6lsiiK/oVyzXsm5kLjv9W3a?=
 =?us-ascii?Q?7rCEsRT85EYFQpWcECDsZcA3FIu6jTXbhtkLNR/6AIyO4fxDfX0YK+PeY3uv?=
 =?us-ascii?Q?5gdR8cTlbuCvHcTY3y/rz+bMq0lUn9fGIGlfdx/nOClSqFUUSGxqye+6bJKD?=
 =?us-ascii?Q?jJaKc1SpjxlkdVUt2zl3l6JoZzke3MHhOuQIFkHaLfUQflxsiR/dRjbm34Xe?=
 =?us-ascii?Q?FoMs30jROZqBm0Zsar0O7w5qYEBZjWjlitjHp3gLBUNETKj0r0nO0+0Sp1Wh?=
 =?us-ascii?Q?fTwzDi3WVw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b089411-a60c-44ac-675a-08dedb7352f3
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 15:29:09.6461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15Jrklvd21HRedCSZ/n7sq19gtq3mkMyqpEuvjqTisSdY7agOWVarzV1Y8ZY3BEMngoeH+29l/votFLrqfZENA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7074
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
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:zdi-disclosures@trendmicro.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-305124-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com,trendmicro.com];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:from_mime,nvidia.com:email,trendmicro.com:email,shredder:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 50A8071400E

On Sun, Jul 05, 2026 at 06:17:54PM +0000, Eric Dumazet wrote:
> A race condition exists between device teardown (inetdev_destroy) and
> incoming IGMP query processing (igmp_rcv), leading to a Use-After-Free
> in the IGMP timer callback.
> 
> During device destruction, inetdev_destroy() drops the primary reference
> to in_device, which can drop its refcount to 0. The actual freeing of
> in_device memory is deferred via RCU (using call_rcu()).
> 
> Concurrently, igmp_rcv() runs under RCU read lock and obtains the
> in_device pointer. Because the memory is RCU-protected, CPU-0 can safely
> dereference in_device even if its refcount has hit 0.
> 
> However, if CPU-0 calls igmp_gq_start_timer() and re-arms the timer, it
> attempts to acquire a reference using in_dev_hold(). This increments the
> refcount from 0 to 1, triggering a "refcount_t: addition on 0" warning.
> Since the in_device memory is still scheduled to be freed after the RCU
> grace period (as the free callback does not check the refcount again),
> the device is freed while the timer is still armed. When the timer
> expires, it accesses the freed memory, causing a kernel panic.
> 
> Fix this by using refcount_inc_not_zero() (via a new helper
> in_dev_hold_safe()) to prevent acquiring a reference if the device is
> already being destroyed. If the refcount is 0, we do not arm the timer.
> 
> A similar issue in IPv6 MLD is fixed in a subsequent patch.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Zero Day Initiative <zdi-disclosures@trendmicro.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

