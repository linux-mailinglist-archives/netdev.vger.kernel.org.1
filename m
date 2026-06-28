Return-Path: <netdev+bounces-302383-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6C1THXrZQGrFigkAu9opvQ
	(envelope-from <netdev+bounces-302383-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 10:21:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C250E6D3699
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 10:21:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=fhOTicBM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302383-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302383-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D31F3014D8A
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 08:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8F7372EF3;
	Sun, 28 Jun 2026 08:20:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010015.outbound.protection.outlook.com [52.101.56.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277DF2F12AC;
	Sun, 28 Jun 2026 08:20:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782634825; cv=fail; b=nE84DSKJXlAQCCKZ5E80CGyht4KQCdVYR2btGmGyJhE8aNwj2m4SfC4w7usevKbRGL2NRTDdRW2OikDEQz+mX5V3ARrO1eu170AcG7+giRE6VIWL0jm/6LerZZmPH1iMr8vudcBz2/n5WKfQZZm9g3RVBQ8a5uX+05/X4rx/z9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782634825; c=relaxed/simple;
	bh=K6eX0QDAg3XxAhnddjfNpEEWphcyUgHloG39mqlipcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iR0XFT71V/u5RyUWpW246mhhtdBx52PrzJ9N4eSw92AsHwZdgxzy7kRgNblhcBPgTEBoQLgkU+v4ACCXFFgGMVj6PI+cQvbRIoQkqHGGoGyrJgDUcmR5cUjC50uycK/G+B6E4KAu4MzrOOHuZkRGk/Yo4nXQqE0mXWBqNSNIaC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fhOTicBM; arc=fail smtp.client-ip=52.101.56.15
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/rp+DBQLf+Z0HCAjmTAWWG+YS3Z2R77LXfckiPFqZIXEEQ5TL8SrZE5IxjDfBCn46wLCfuTGh0ENVM2k6K/DAsEcdO8ZyBr0rzX/7gUNZMM8vG1aTJ4RdOKwclOREfIIIjAH18liojd7cDwMzcG0jD+YlO45iaoaGZCiu8u6BaM5iyrsES/E/19qb/6Cjw2M800g/BaAO/PRw5tPwFQkq5KvghZWXA6b2/jnP4is4mG3v83M41RFV8wNBOAtdyZyjNwy8j09A+/ALILyNpguZ1AHIgxa4V2xpo+R35u4TUDhDThaKHVfyv5rimPA+Xqsc21uRDEv7byxWITjAuFGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gk8JJ/hU9Rkq4iLt5+YqYukiBcPYv40Xham0/2K6T7Y=;
 b=xLWy6geKtZBSXak+JPXtDWgeAZJ4o1ZRu7Myzk+LVBTOfrmY7D8KiG/L248KkVJwbgxS8yEbjiNRUegBgQIcYxtd9aDBGzXMIBQ5zqWn0SsSRj6rA0RZwpxTKpBlKi45tyIVXdNcfIHkEwx7wrVzXiHetHUJk9fDwtYthcDiCICOjZhWAH7AUVqSXDtZCMGvTw68M5MX3csu/vakDQyCwjjsp408HNCPp0gayWKN2JrbLBeOzaIhu2eGDAGV3CCmTMyaw4StB3lOz5Jr+ij09Tt10iWGm2iMtbKy3OEyCcc0BInclcVH6xlS1Yhdwl9xzGgY6k2Z3ISW5Jmn+80qrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gk8JJ/hU9Rkq4iLt5+YqYukiBcPYv40Xham0/2K6T7Y=;
 b=fhOTicBM9zKXKfOFeY+QttW1MEJdpkyLxKRs6QyyNO8FVvaaKFcVO2CfRoK+XDi8XSRLqy4OXs9w7bcegPRCUcvJKu/DlsbjihxW324+i84fZ8SNXiGm7FNnvMJhHY+NybislAWyeHLlkn9fvam73YEtAUW1yBWTS/ukFm7CVXPuYuz60/rCqaO+gc2Z2Qc1Y6Kc81WlMnb0sc4q0N8QXOL6yGf+HArLJNASjZJb+MTlvvfm7bb1j2teid6vg9Smy6PEROmiJ6qDsAAOoDywY/XQN1hCAHaEUz+spJaDmG1QIvx13MPjIuB/BtYQdUzmcKEi7jDOYFFmFfUDbuU+Lw==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY5PR12MB6371.namprd12.prod.outlook.com (2603:10b6:930:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Sun, 28 Jun
 2026 08:20:19 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0159.018; Sun, 28 Jun 2026
 08:20:19 +0000
Date: Sun, 28 Jun 2026 11:19:42 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Pengfei Zhang <zhangfeionline@gmail.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	chenzhangqi@xiaomi.com, baohua@kernel.org,
	zhangpengfei16@xiaomi.com
Subject: Re: [PATCH net-next] ipv4: fib: fix route re-dump in inet_dump_fib()
 on multi-batch dump
Message-ID: <20260628081942.GA147785@shredder>
References: <20260626085636.1524451-1-zhangfeionline@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626085636.1524451-1-zhangfeionline@gmail.com>
X-ClientProxiedBy: FR2P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::6) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY5PR12MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f9c2fa-b86b-4f3f-7bcf-08ded4ee1729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pD/1o8PvfHdoBUtPtiSmJoBr37QsbwlsLK47TR6oEpGUkMI7s2Y4y1tpoXqpdMM1A5ZV9ItKEStoXKaQepkQNPyWtM3u7zTSfZWIX8VHwtlwQSTLpYyCoEzBHwG5eYEuEvHuNuEegZzvDyRhvqHoQAll5wsrjAbOqjszFtb7mSmW1M/VLX1Si9SUCMwpz9Q/96NVwJ3MlzZ4i/SHCI+dbgiF4iYxvOlI7DouTlDqoPwtM1OGPWF1ca77+Y2SI6+wjskmbfrsMtDyr0K67Fk1dwfxYiD7l/1iAd5JOA+bHeEKbdSqsjK1HJhhr+M1qOXlaOqvQjuNpN2pcLrk+IWf48aszrwPkd0G1RKQyY9ndrW+JfkICg/NuR/pj7CxqT3paODntuCeCsM9zxzf7I2oU7BHq+W/5bGUfbot6AdZqZhWCq/AMeef/THiSUrKdPUFE0lQRkMvoLPx60wBUmCRi0HVX6b4snipzqPxl7sk2n43uYWC1kVLJuF4PFcnA84clW7P2ZIQl2rw91qS31YYlaELeemPtXImiWkdMsvMHB/GaMJd3D6jTbWGUv1Z0n1rMI2KOTEkBSoB4LTXT5kyIzuLXmr2IUMdQMlWXw38K7+7qmuPq7jfcxKr4bkxaINyk2wXvKzbIStPL1g7WDRRTvtwKBUeoaoQoiCYB5/Z3To=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e2DFT98w35+jDA7ifh7B/mpKYY/F2LQkk+AlztSQNhfYmdfmruKGcibBXE1r?=
 =?us-ascii?Q?Uh7GIN5fjh+BUd75FIK4jD6VSlwrs/gGTPtGMz8SVAFqL5X0J41xMZt6IJrf?=
 =?us-ascii?Q?a4oerZLVCvVQgXbSC/j8cpLzT+dCHwLjC3JY6pxgcTiXh6mKDPdMWeUIblUk?=
 =?us-ascii?Q?PDEQKNC/Oeimldv8yVOjchsOXAh9ERRzawWeS57fvDihBd7liEg3MIg7lmB5?=
 =?us-ascii?Q?Ej18rRJKTpRt3MvBL3FhkYqiZ3CFST8YfLpZ52e/JCKc594jU7DFmTYxsc54?=
 =?us-ascii?Q?xkxAIlHetUg/m3Q+BZxtWd+ewMSy5D9+hyuXxFyjOPYGFXzZOdIF1nsCrAE5?=
 =?us-ascii?Q?B1M67S1XSlM6ajkbhB2lnxy1OV+j29XYPiA9GksqTScMAFi8QLVaIAXX2KDb?=
 =?us-ascii?Q?dj8Qkyrau7DpwdY8CgBnaKqhvWpfhPu0vTzLV8V9/ORo4gWXpyv3LUhSfrAw?=
 =?us-ascii?Q?eKYiHiDaPPh/quo66zTK10ueugKmeExK6nQbD3Dd01fqfgwZmnHrtTMFj535?=
 =?us-ascii?Q?mDbOxbaaiWLV2UlCfxZZQaxDli/bWgXyyxZWCaPpFY/xiX++ss/b9JJ8RP92?=
 =?us-ascii?Q?JnILD6GTUtgRpiCkwiRr7CZHzYd8+pEcoGv2yXUoz5nQjSLrPAq2aJa0rDDz?=
 =?us-ascii?Q?8vu3mI6EQflv5Q5qgcnwL5himMOg8z5oMwuSFm0e30VfyJh9d/lrUrF4z3F9?=
 =?us-ascii?Q?6elnaJ0zko0VnfqpbIVyUWH6iK3y3bAsf4SIh2sDZJyo2jc+/MnBPzpUFAOX?=
 =?us-ascii?Q?bBbGK6K287kWHFThllw3hmV/8Uw2nd8/gwfmB2yJmGv1TnbO2uH8S6V7FIvU?=
 =?us-ascii?Q?buJxR7FY0fhCFAsvbg/jAwLguQBOdEJKpxY7qEMAvW0yv7nGNNsq6SVK9Elh?=
 =?us-ascii?Q?kjvW7FH9vCyOt4T2wMlRcKDatdnjw1meiodH5598IRptXZG3tl93kJlkYybw?=
 =?us-ascii?Q?ss1RhDxhwC7atBbkUOdKAThHOaHtDGp/tG9gk+8Y1VI7bh5clmIx9CKSKnMi?=
 =?us-ascii?Q?5huhYK8qMBw9ExQyk1CVBPPQsDQe/HELE7UWBYf7/YWvdtHoYUoq4n5Wwacb?=
 =?us-ascii?Q?FZLffRWoGH5O/jOHV2WKXyvVfJl3CsHlQiApviEAamIUL6++NZVX34Qoqd7b?=
 =?us-ascii?Q?YBdzQ0/SliLKaja5TXRKo3FeDSvbEOU6Y3ZZ+eYt39E+oZ9G4otkYXZKMlCg?=
 =?us-ascii?Q?4Ic25TX3SE+UbzEGNKL3ybh8qmo6Lk1kuyTHaKSkuhch7s55SejJ9kU3Z5CP?=
 =?us-ascii?Q?VxQFRWeyJrcUOxw4Yly3djD3AywVCNahJ1y9tAli0Tp4fbYW8fYQ1Qpw2WH0?=
 =?us-ascii?Q?bqQHQAAV2po4oPSb2kvK8P66XIv+/3jWmuDzTPzk2NboHCtML+btafh8b3XK?=
 =?us-ascii?Q?YDXJrhbCTo40BIHXdxMkKHRHYlzgDzvODBMMqktE5EzOFH3glWdgQ+j3RQQb?=
 =?us-ascii?Q?lQUpomj0f/N8IdyDJX2LmOflRvNIq0f/LSdxKYqWFfhES+dh5+LVt6QxM/Fp?=
 =?us-ascii?Q?Z7xcvbzrT3VIFXvdDcS5wI8VxXCjjw2F+SqNOuBtMGtPaOsYo5nFTQmdfhpz?=
 =?us-ascii?Q?EYtHdrpNSMGTSwucw3gMBJKq7mtrhKSJ9ZSHs6jIM4OfcJNpxZnQ/5tsc4n2?=
 =?us-ascii?Q?HmHL0T924fhoPe3EwyjWNYDud9KJgK3a+nMpBSusdvDJxUesz4SJjp6bv8Y+?=
 =?us-ascii?Q?vTLxfwIb/Ui+A6wTC8Mi0jN6QTxqioXEcCjvjgUipYUhJhnM4e58f2OUOpTS?=
 =?us-ascii?Q?4AHRN8BaMg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f9c2fa-b86b-4f3f-7bcf-08ded4ee1729
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2026 08:20:19.1686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s5r+VIgcmzyw2711EoAG8DGFfOVuwBxo/F3hM56qscaPFkFqzK903aECYApwa4tQREt4KgZm+212huMJk217iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6371
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302383-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:zhangfeionline@gmail.com,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:chenzhangqi@xiaomi.com,m:baohua@kernel.org,m:zhangpengfei16@xiaomi.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,shredder:mid,vger.kernel.org:from_smtp,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C250E6D3699

On Fri, Jun 26, 2026 at 04:56:36PM +0800, Pengfei Zhang wrote:
> inet_dump_fib() saves its progress in cb->args[1] as a positional
> index within the current hash chain.  Between batches, a concurrent
> fib_new_table() can insert a new table at the chain head, shifting
> all existing entries.  On resume the saved index lands on a different
> table, causing already-dumped tables to be re-dumped and the
> originally suspended table to restart from the beginning.
> 
> Fix by storing tb->tb_id in cb->args[1] instead of a positional
> index, mirroring the fix applied to inet6_dump_fib().

Wait for it to be applied, then reference the commit.

> 
> Fixes: 1b43af5480c3 ("[IPV6]: Increase number of possible routing tables to 2^32")

Please drop the fixes tag given this is targeted at net-next.

Also, net-next is currently closed. Submit v2 when it opens:

https://netdev.bots.linux.dev/net-next.html

> Signed-off-by: Pengfei Zhang <zhangfeionline@gmail.com>
> ---
> Consider a hash slot containing two tables [A(pos=0), B(pos=1)] where
> B is large enough to require multiple batches.  On the first batch, B
> suspends mid-walk and the loop saves:
> 
>   cb->args[1] = e;   /* e=1, position of B in the chain */
> 
> The lock is then released.  At this point a concurrent fib_new_table()
> inserts table C at the chain head via hlist_add_head_rcu(), making the
> chain [C(pos=0), A(pos=1), B(pos=2)].
> 
> On the next batch, inet_dump_fib() resumes with s_e=1 and iterates:
> 
>   s_e = cb->args[1];   /* s_e = 1 */
>   hlist_for_each_entry_rcu(tb, head, tb_hlist) {
>       if (e < s_e)     /* skip C at pos=0 */
>           goto next;
>       /* e=1: tb now points to A, not B */
>       if (dumped)
>           memset(...);  /* resets B's suspended progress */
>       fib_table_dump(tb, ...);   /* re-dumps A from scratch */
>       dumped = 1;
>       /* e=2: tb now points to B */
>       fib_table_dump(tb, ...);   /* re-dumps B from beginning */
>   }
> 
> Routes from A are dumped twice, and the portion of B that was already
> dumped in the first batch is dumped again.
> 
>  net/ipv4/fib_frontend.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
> index 42212970d..65fa245af 100644
> --- a/net/ipv4/fib_frontend.c
> +++ b/net/ipv4/fib_frontend.c
> @@ -1019,10 +1019,11 @@ static int inet_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
>  		.dump_routes = true,
>  		.dump_exceptions = true,
>  	};
> -	unsigned int e = 0, s_e, h, s_h;
>  	struct hlist_head *head;
>  	int dumped = 0, err = 0;
> +	unsigned int h, s_h;

Move this line below the next line to maintain reverse xmas tree
ordering:

https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs

>  	struct fib_table *tb;
> +	u32 s_id;
>  
>  	rcu_read_lock();
>  	if (cb->strict_check) {
> @@ -1054,29 +1055,28 @@ static int inet_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
>  	}
>  
>  	s_h = cb->args[0];
> -	s_e = cb->args[1];
> +	s_id = cb->args[1];
>  
>  	err = 0;
> -	for (h = s_h; h < FIB_TABLE_HASHSZ; h++, s_e = 0) {
> -		e = 0;
> +	for (h = s_h; h < FIB_TABLE_HASHSZ; h++, s_id = 0) {
>  		head = &net->ipv4.fib_table_hash[h];
>  		hlist_for_each_entry_rcu(tb, head, tb_hlist) {
> -			if (e < s_e)
> -				goto next;
> +			if (s_id && tb->tb_id != s_id)
> +				continue;
> +
> +			s_id = 0;
>  			if (dumped)
>  				memset(&cb->args[2], 0, sizeof(cb->args) -
>  						 2 * sizeof(cb->args[0]));
> +			cb->args[1] = tb->tb_id;
>  			err = fib_table_dump(tb, skb, cb, &filter);
>  			if (err < 0)
>  				goto out;
>  			dumped = 1;
> -next:
> -			e++;
>  		}
>  	}
>  out:
>  
> -	cb->args[1] = e;
>  	cb->args[0] = h;
>  
>  unlock:
> -- 
> 2.34.1
> 

