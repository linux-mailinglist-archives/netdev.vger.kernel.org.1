Return-Path: <netdev+bounces-305125-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IPEdDdzoS2qZcgEAu9opvQ
	(envelope-from <netdev+bounces-305125-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 19:41:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4EB71402A
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 19:41:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Hi21l59+;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305125-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305125-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B95EE356FC3B
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 15:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63AE396D38;
	Mon,  6 Jul 2026 15:29:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010035.outbound.protection.outlook.com [52.101.46.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACED3A8746
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 15:29:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351791; cv=fail; b=bkLkIoMnSPQOAReYD9gmH64AeN0k8Kpx3NiLhwsniNXXTr5DY/HKWZHG3a4hJ36YSW5wuK7Fq19mX//yj7LrBxACuZRYrmHYWFp8Mj9k/313XRMyKDFJW9TPb78JPknGSe61zCBMaSWlMdtJMzs4pJZ79l8qyKOeop08yczMhAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351791; c=relaxed/simple;
	bh=U4wNWqca20L5nxpXiqswI/+Xa199trtDtlfHoXtey6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e/6DsKJ/J0fo8AMPGQijt1tw3cYenjZcWcxxIIq0A9S4zEjrQeO082UVqM3ROk0aPm/l/ddwFT2YvFzqSd3n4o5s6VwKwgdNHe1FuBE7EIJrAZu4B6zkisvRiM6iBDVhgvYV8UzyGqf3Hue53f5yk4cPUUnV79QR2s0dME+r1W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hi21l59+; arc=fail smtp.client-ip=52.101.46.35
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLYrM1DieAjZ8dep4czUBo5xNRRYaQE6h8yJClYRL5ZS/ypZZfv3hUAFuQZ/riStia33e+1dcHO48a9Ll4jMznyW1bL/GCDTY+Y1DAB9KAzK6kq+/t12beQ9iujK0TkCweExtukOpE8SY6VzkeqZQcBqLn6zpdOSk7wbXd7MAoqA5q+304Cvzl0ECqrJCEIAEiiEUTTdIIEkDN1+S3M545EMldRrHNL5IAxHSGPVJbmHSKa4A7ysgE2txNznk1hYSBPmdHk45+Jq0VaTahfhknUn58CDKs2dMoztmV3RAhF0jibN78edloiADsDg+d//6n8XBMh/Tk/PnnMTk8SnHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwhKdzxb4cDL25IKC0Dj12gmMuobrGLKTrTX9Qgu4wI=;
 b=SpCLe2Qa3QuoSPkSvdMbNLuz52NevNkBpNiSEmKiz8T9zyeXm2pX1s+/5+/IMi+Xpvo93nR4RXTnxsfIvxr5EECL4uAEhgYoG2ncODz+5SWPkunB3GnOm1bcugS2iae+aJL3kTh3VHmiVGeGlA/rgaUPrTtNrQ8yJnggjwX0Vs1GtSSofaIg6156fDKl1snq47w2XMYvrIWnPJeKXUsKv4/aEkF2ewYnTGA7lXhADRjXdqLUhAfJbw/9UAOL2Tqz/7SOaOxhsk3wsgL8mM7djIWCfpYbw3k4bdTt2laNpwCAaOgtGlUHcpcqcA3z9mhbJnRdeD1vULBk/GZJwaRbcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwhKdzxb4cDL25IKC0Dj12gmMuobrGLKTrTX9Qgu4wI=;
 b=Hi21l59+gkIfEE2pLPy+N25tGjmDgdO+52X9kdh4mj0YvmTy1NY7BqjIbhyPlAqz7mXa8ZhhCy893olPzGxdEJoVJzbX82o3IimaoA0X0WVgex1SmUakJf1gkRpTQoVOlcf21bWU2sltXxAEHv79m78IBtPOKYRq8NvGgB5+jE0v8zn2ALMS2EF2J07QSUhWuS3TA3YjEhLi/lzVf+u4u+t8mXOPJpdyBIIh3O2XN0rZ3bOdNCAud8pidNBggvGggSxTiCBKA+RZ4MpoxFZRwjViadU+IvKJzV4Qkzudny02wmofjgztLbXhfPo+4gyAWVKq5R/ekXAdVl8ZCb3nCw==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA0PR12MB7074.namprd12.prod.outlook.com (2603:10b6:806:2d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 15:29:45 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0181.010; Mon, 6 Jul 2026
 15:29:45 +0000
Date: Mon, 6 Jul 2026 18:29:32 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net 2/3] ipv6: mcast: Fix potential UAF in MLD delayed
 work
Message-ID: <20260706152932.GB410724@shredder>
References: <20260705181756.963063-1-edumazet@google.com>
 <20260705181756.963063-3-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705181756.963063-3-edumazet@google.com>
X-ClientProxiedBy: TL0P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA0PR12MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: 907a3bab-a976-4b3f-888b-08dedb73683e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	U2sHE1w7GZbFtwGzNcl90ySktSdUF79iBDTQRhDjqNaHNuB5n3oAsj+rz9bn8pR2T09zGQWr/KW/DiljiZQ/SW0BlVmIiatf6o07FGHJ7NBj+iFNiZYLRsDfIyO1bo+z6yejJNaJm1mgI1mEji7B0TXgUGvK98eQLtgBgg9MkjQkTZCer7j2fFao9ZPGCku9NvRxxTf//4G2Ukfx3gGO/6FQhikwRm1zBRRFCfV9o358EHH5X9X+8OZCXdB/hOl+YQpgQwOsSmmIv/o754WuZircf7gFG2eaMzeSyyv149dIvfGCYeQ3RBB5NceaBOrWtnBG4SnNYkF2ZNvlF3EZwZvhISner7DOra1IZde7lqWhheo7WoBUs2fmHDa+quy6oQ6Veg7pQWaGj1YIyU1LBB6ymdXZZrosbyJLkPro4SxisOfEjDpyRh7mHufuipNk676L4IMb2icgB1YcOhyLURjeYB5k60ICAOUP2nEUZzSbEwnlLHySuxTA3woUgIiPHoy4uvDRTBY1JxsJAoth8cmlCiwRcGrINU9KI6RKI/L8usIaElQYlHLV5GcNIl/OFTF/a+pRG1pkXE/tvFD9SwDfbwR58IMD+Z7UNOr8bXJ+fR4i23WBPnrU5C3RzZ9PKfphfaGJ5wc3zDlE6tJTEq8siiN9N5m3/9u04jREfzM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qsr0O5QegtfJ/zSmMZlDFyfJsrcU2NisyiW7P5d39Ss1xFhisE5X4cAPWqiQ?=
 =?us-ascii?Q?4jbXhYMMfDxLQ6RVTY7yEmmco7BSsz+TGA//ceJyfZlr292MR5KL8fqRWUpW?=
 =?us-ascii?Q?p7MwyxiJctaQZyTkuQ4TD0w2Zyy1kOG4nNZtC5akROqL/pSzsuq1tgSy4eGR?=
 =?us-ascii?Q?8Jvz5n15/Tvln2z7sc1wpR7RphnGUF/6Z5cVFDwoVLWXoIQ8nW5IMFbqKV4K?=
 =?us-ascii?Q?E1XANpCVIrWFRvVIkA78F8IhwIOHrpEY8hYVIX+rBdy5Q2HcaGz/FMxcqB47?=
 =?us-ascii?Q?F9CQE/n6DQmqYWkdfKB4omDN+e92YD3mXslagfAXzEjx/+AwhvpYAYIhCNCU?=
 =?us-ascii?Q?6oy7R+0B/vvUXHAt6mP4ww39hjupIObRmk1gL5imUtkbyL3C8hgPMHeQfVH3?=
 =?us-ascii?Q?nwx580lU8Q6AI6SToKG+TlTrbWuDwjBh12oeK4cyRBMFnaVVreup/OWpsB2K?=
 =?us-ascii?Q?WZzb4qTOQJeulJEvmnYLiB6U4IumJqyNde28JD/s7tJ75TAvAYmlF00ph6ns?=
 =?us-ascii?Q?NoYuVPsyEBicv8GH4e+42l/Pf9PfOWWLjB99nnlUEYioSX3scvFbgD+gytyq?=
 =?us-ascii?Q?H9SPWK/tlbTnLr31aL/JvmC2y7PEEBMo5xm0GQFCjNnPBiKgU1Qz76YTlQ/f?=
 =?us-ascii?Q?BLyAaRO93PrlSvt8lHr3AuvC+qqLO9ebt0Qng7WQccq+S5PbJp41bnVV7Rnn?=
 =?us-ascii?Q?u0bFcJ2zNz5LlZk2bKbkO3iNqWe6CJks7At5U0KvmuVxfBSUV/ogYtBk+xBI?=
 =?us-ascii?Q?aXdAcHELZ2OQX+SdeGXykAPgkdQMXDyf5dyX7CQeiseuEK3Q3xq6e5eahlQh?=
 =?us-ascii?Q?AZiFLHlojnJba7yzTYga53PcuCuDeObvLREDjPwh94C/2rMZU66FJud74tA1?=
 =?us-ascii?Q?En8PXUc3hVRLi2Wz98jB/1SUtIXMxUnGATnfsagP7jD41r+fpkxyKN5V8oTf?=
 =?us-ascii?Q?WNFtZSDNt6uYw9zmYzYBX/4TawjWkSu4Zg99YFfMBd0zrFCpsILKSnWX3IDh?=
 =?us-ascii?Q?tJQljZH8cR8DQx9+BLo/op3HV2LSS59irfvOhYrFl5f+mha5Ut5iYebyBiM6?=
 =?us-ascii?Q?B+y1zH/Pn9vJspQVh7K0WeKourtIgDBVEBlLR1L00ptXDH48Thb3kwkMauJ/?=
 =?us-ascii?Q?YJZDEcb6VQlNd6dgEO/ssHHO8XZXvraeXePLFfPSRugshEURrt6mLnPMCJdn?=
 =?us-ascii?Q?FQI+3uSL1F6xSRM/g9q6UHMD9S8/EOYxeMtIVtEJWgmSA/FMCIzbZDn/QMmA?=
 =?us-ascii?Q?+OCmJ0ECW76YZQmZHUthDezg+GXnhIgEOFny0e1Tas443XDuba7HEJpfI7eN?=
 =?us-ascii?Q?NBUWeI5HLmPI1wnkIaUPa2g3+DOm9WUQ1Vgx7iNt7uAnifjUMPGarjSNWhcS?=
 =?us-ascii?Q?inGnJ+z0zs77SdZ07SQt9MUTDfUimZGbG+ktOyCRfRgo3cdagtHX8Nko6FIh?=
 =?us-ascii?Q?TGyAw7ozT/WRtKR+G2k/kZ/IRtitUh49tnRpCr5EYBQfSgjHnpxeEOcQYoPK?=
 =?us-ascii?Q?4rsO2o8lugHVqok+yfYSvrUCl2jGMvmN7iba8WmFo3FrOmBp7T+2M3rwGIQb?=
 =?us-ascii?Q?YPNBKlqsNpjhKjGgSoPGF+td0Joa/ZWHuVNaiYaHZ/qm19MIsuZyekKvoN74?=
 =?us-ascii?Q?sSMBMh0t6NuoV3a7qRORowAZAv0M0TpZ616WPq4wBTnruzzK6xrET33VZ0Tj?=
 =?us-ascii?Q?cG+/lRdKRnuBynq7tC3VCUFS73uFsN5lJ/IjOFHeyUB9yNJzo9Oh1i1/5txh?=
 =?us-ascii?Q?VzsGc5gUmw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 907a3bab-a976-4b3f-888b-08dedb73683e
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 15:29:45.1976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oev5K3zRmR44bMT+X4fr9QXUvLzAUr0cAPHNWSDqfZM6sZXT1vIhGui7xSt/ZlFIS6gkOqnUujIYkT/fTKq/Rg==
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
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-305125-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:from_mime,nvidia.com:email,vger.kernel.org:from_smtp,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shredder:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C4EB71402A

On Sun, Jul 05, 2026 at 06:17:55PM +0000, Eric Dumazet wrote:
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

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

