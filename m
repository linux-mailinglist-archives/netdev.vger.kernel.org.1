Return-Path: <netdev+bounces-282853-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAuDEndV82mLzgEAu9opvQ
	(envelope-from <netdev+bounces-282853-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:13:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C484A33BF
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C12613011589
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C180B41B35D;
	Thu, 30 Apr 2026 13:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DY3cItEk"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD91041B355
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777554674; cv=fail; b=mGSgjr0QBokaX9EQv6oSFjzzU3bbN6M9MidxZ4vqBGW8gOzryWJ9m9o56Bhql5x/AmV/Dc0k+cblhF4QscZE009RtexnSEwTGYdCRPZlI5tucvKdeSLe9tmdo1BKb3z7IEu70vfblmukYUcjyqdiz9661GaHtY4gpDFCbh4zvBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777554674; c=relaxed/simple;
	bh=wqRpZIDh7htWupA6cJCzViOKgdYExLMR7+uN+XdpOcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XQ/0MPYX6EVtGHDKiFJVn27YvDhA1Wog+4rj7t49XKps7ddvIAv+Nu6lnPYEtOxQKPTbQNh36w97Xe9ErmDlEYKnRNgKO7u46H+HkrmmXz4YRky4lT7QSn1nAnh8ik8NkG8E3oXczMQ55r3EYU4vap4JEZS5gps76NKMnnvJvXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DY3cItEk; arc=fail smtp.client-ip=52.101.61.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzn2jluriB7A/f6EvEmY+NrqBqjhZCkn5DdkyoDEEf9xr7bKjfA9xv1wsVuVf/rqaScs7NxnqtMhDIQ/E9aA7c4IFLGxXTh99lcRrmlCGl1R+l9m0qFa5HX0S4OLGcdb6AhON9dxlnDyiUHUI9r0W5Ph7bmCzl0nd08P31VUnMFY1+b5SUup9q3nZl1Aj/8pdwtgAXkI5461D7JpW3sYMF2HnBTp06C0FE62ddSzFqIk0guhe+FZYfKfwkyudX4i201DUwKbmpYFteU15oMoBs41yUnsANg88FD9QRJPRGFIzs5EKJ+4r1kHvyKaekzU4rIjGg78ZssiYFnQiilctw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyXlbhUYJNXU4gjycixYc/zmQGD+mN7P6/zz9M81aF4=;
 b=adAJGlH2ow3q/RTQ+wXArePvsLBREIS8awRiinXA9QZGlJxV6gihOKhKVrSFNroA1BS76aOK2Jd/xiiMzhDhFL46o6QSwi2hGQ7WE63nqjTYM2ekyeCyc3SJ6mqFBuXAkKz7A078+Xhv/nE+7ri2dklQ3GbIv11IafR6lngAgFl/E1hK6HTqkIiNqq/A7mrB+X2lmLpvwght5qA3jv3AnHxQZj5G13Wo3hEBZUvG05tmZxEIKtGcLxvitKA3rjnrqFRszmZi8m5wlrvYHhynMZYS5fklDH59KeaoZ0lMI0aBTKj7/IPHkRcGByOQitdGmYDlCDC+ivDh1lz89pHzEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyXlbhUYJNXU4gjycixYc/zmQGD+mN7P6/zz9M81aF4=;
 b=DY3cItEkaBEzPfRyOKja1dB3F2R+oL197/PrEr/OThrQEnmG3GmS0bU3XxFMmk2szPhrDGcmPtgDNnLypsPaAX19hb16dQDtTdn2KG0qCrH35FGVOCpzcoBE3EI/UwFF8mR3bZ7gnXznXqKG1tX+EsdV8VMKVpRY4dgXYv2gDw7+FPFDAyK8Cw52B1o+6s8hxvbGUuXo9pHbtedufkpKlDYchLE2qXC+Jvs7eOLSGQuJCcXzEmcfU0MEeTfYlFEGDuXPraDoWT0zqtOa4YLgie0HwbvDqqV6Gha5BsDTLo/DkHK+NG0vENu34EI5SwWepAuku/tJs8bItxhqJiWm4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH2PR12MB9541.namprd12.prod.outlook.com (2603:10b6:610:27e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.21; Thu, 30 Apr
 2026 13:11:05 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 13:11:05 +0000
Date: Thu, 30 Apr 2026 16:10:55 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Yiming Qian <yimingqian591@gmail.com>
Subject: Re: [PATCH net] ipmr: prevent info-leak in pmr_cache_report()
Message-ID: <20260430131055.GA976630@shredder>
References: <20260430070611.4004529-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430070611.4004529-1-edumazet@google.com>
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
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH2PR12MB9541:EE_
X-MS-Office365-Filtering-Correlation-Id: bf8cea31-918f-4dce-4bea-08dea6b9ef70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	FuOUjMglCfUrkNWTd8OaCAa2W8AP1UR0AiHWkNOXSpLHIzjVinTUrYFQcQGCOOml74gK8sn/JGa4PA0vyGDAbB815sVpn0YGnvoczKO6NYoQZpWMsnUAI5ewLtOBSvHNJM6hKOqddoYoQXnXhE4CoP0418daf6DFmdW5Atv5T8HwFzygJ97ieIC2NO6SYj+gVM0FUekzhYnHZaDZ2SNwsyfO6VOAuRRYyj51ciY1Qk5ax5LBf4wFwJvwUWEBn5nig5tor0ZN0YoKZ27vNZhzwzbaCkNwe14+UF4zArAgeNYQ13gwoXVBEIJ6fjQyWdrmoAtWvOU1Gg0MPCi7hKU40rVtOHBi+r3RMeBjKJEfrutaimpIu9BbzLLDLWSNGvvog+5y2y3dD6FkHpk99FaHos3rj0G+nvAhqy3xmXM4hwkuMmp6vOp6SlzuKykf7Hj4DUUYebi35ipPuThIlb4IfDLHm3pUtw7GsU4s9GZ4w44Wut9dAXi+Jl4bSpvIb/MFGXLpIGWyVTD/Ff//KOte88Qoyk85NG/LWJdb4uBmMkO/QIbtSo5/7L4UkvEkzU5OpDRMg0BXrsk5i8SBa2YYeWWGMy92ccO2bBzXsKgk/M6TkdnyRdDmLN4Vkci9nlRWWhvpvoWWMoVl+UJToJ3rHY4Exf8dtoBrGw7gLm7RT5l5okExMrGgF0cbip6NC2+76spxyLdi59sOOImcTlKcW+1SlieAQvQoNMj37+o+Qb4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ofLwf9Ce20eTlWlFl4a7674krz0bU3O95y2/Xlr35ym2E/0S8/2R7zJOP7Og?=
 =?us-ascii?Q?8ipl31fcYAYKvWibYlHg+GCYr82oJlHVAMnVXbL0yMp6vHO+SVCTlXNGGFMP?=
 =?us-ascii?Q?YPFpAbBWT0yUiygym7Um0AUL6Y5SsBYgiQ5omRki7tgxIi0n3gx6s9xiGhsH?=
 =?us-ascii?Q?qKjVobQJ9DIN/jJovWe36zPdtr7bhn5sBM2hBHvMuPlKvLaZnjxgMsUfJk2D?=
 =?us-ascii?Q?BRe6d9T/0DNw8IM7/5wNHcMzdWpO3eXEbytRuBMiSyga5lRxSEBjLnl/wXnv?=
 =?us-ascii?Q?Qo2QBzLEt8oAjNSc5t0VWUnpu/CnivEf9k2HpUB5g5j3kvaLSmiGEY1/+hrg?=
 =?us-ascii?Q?nUZYtko9xL6WmTXphPblOgrNNWYwlpcZTreUQSi+j3a8KgZM/8N46izXyp5M?=
 =?us-ascii?Q?gTs34X3ng1yXeZn8ectFTIunxXcYapq0pFPFaI/TpaHD9cqEVrjAiw+FbsYM?=
 =?us-ascii?Q?fqKo59GQTwrPm+ji40L1g/vHfHiNcwtlWR4eWgeFU13OzPZqrECL16lCABGS?=
 =?us-ascii?Q?7yGii+Wi9DO3uQljlcW4xdGTKhjuBbtMDIxbBS6wcLO0A1WAs2+I56vFrqvn?=
 =?us-ascii?Q?i0FGzf/baeuaYYCa+gORyOapV4uX1e9shckGWibItMGS5jh6x0vhxq2lYtKX?=
 =?us-ascii?Q?B4uFvcLuWuFgMCMbgwKArzcPB/rd8sNg+GRRq+2pgv0CcQZmd5+D8DAT3PPi?=
 =?us-ascii?Q?HVgrzEHFjDwI9xI2ZZ24Bhnz1pSFER7adnbeI5ZXa2JmmBGRWoNXg6JMYxYb?=
 =?us-ascii?Q?ghE9jYZxmhNSYaQjizuddkUHYyHfjTvZdcFpawD4spF0ESEjsuTqfMCr4En7?=
 =?us-ascii?Q?E6RPOKB8ghJzaFMhictxHYbeyoLqSlz9/RvVt0Yh8ISeVXz505q6+TWsxzqi?=
 =?us-ascii?Q?xD/6ECs5fmNu7oug/XfCDfeHoRn1jO7a/p7C6ebULK4g9riXRkGwfkD6QQS1?=
 =?us-ascii?Q?2tMa8v0Vjvi/Y6pUx1oBxvH0YBXJnPm7Xo2IoN4tIno3uIKDaLrSNjAzyF6W?=
 =?us-ascii?Q?7dg1+QRt2AMGMlm3f5Dd+aihMzIBXApThtalTiavd9QaxjcndrR01eBwqwvd?=
 =?us-ascii?Q?92hdbwkLknDCpey7mqzUQ5mrITykQY3IOwOwREpCAGxAnb9yLUqBGoHY1Gli?=
 =?us-ascii?Q?Cerns5I2iabCCiHgmL7AmyGYkZxEJMtCDqxajSta8LQ1M0ugaoREC5Cn+o3f?=
 =?us-ascii?Q?fWswqHBvzeTkwnh6nXBV3ke2YUEY2BAZuUbpnpsfWjvcFK1sbLkNieWZyZqY?=
 =?us-ascii?Q?7V5v5Qazsfge56zA3LVtFxEAwd+59drUuDscCxB0yiG90KYZsYkj2ZiBBIkw?=
 =?us-ascii?Q?rz6SAmoo6BOQhKfa7eHoyNYz2NL4jys5NsbQINnojEoB7VlHa+i+oIPgrC5u?=
 =?us-ascii?Q?TDDecEVch5k1i4V0cZUos6Y/xJrzlse5Mxhvld6/Xdtbjah2pNMx/imWjn5n?=
 =?us-ascii?Q?0hRSZU9XYP7OdHZJhAP+hE2J1Y1pnKPvfVq6UO8ZRokI+XFbgWrBhiIJXm+N?=
 =?us-ascii?Q?TWgpF8qEZ2eF0EpzY9ft3xui5ZWmk0fOEFCOSUdB1vQe+D7Tkkd6wikOjoWV?=
 =?us-ascii?Q?R09doEJgxc7ZCKbz/njqfk+E9HN1rtxbH2t70kiJ49jJt7eYJGrNbkpw392w?=
 =?us-ascii?Q?20e9SrSL4noE/9jIVQY3Tk1uQuq7DslkLzsTanmADSEiTeFsqWFS41D3M/aW?=
 =?us-ascii?Q?rIFcjhsGoPFMre7obS8XJMp7bGTV/6AluXvK/RR/JOoxuWeG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8cea31-918f-4dce-4bea-08dea6b9ef70
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 13:11:05.3581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bc6UFEiH6+VCsQe9tX/ltWuGH43oHwkL3IZSs3h6u2DFwQDbO51FgAsOQaul2ol6NjwyGDF9XXtw8bJ9Ez+Lyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9541
X-Rspamd-Queue-Id: A0C484A33BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-282853-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]

Nit: s/pmr_cache_report/ipmr_cache_report/ in subject

On Thu, Apr 30, 2026 at 07:06:11AM +0000, Eric Dumazet wrote:
> Yiming Qian reported:
> 
> <quote>
>  ipmr_cache_report()` allocates a report skb with `alloc_skb(128,
>  GFP_ATOMIC)` and appends a `struct igmphdr` using `skb_put()`. In the
>  non-`IGMPMSG_WHOLEPKT` path it initializes only:
> 
>  - `igmp->type`
>  - `igmp->code`
> 
>  but does not initialize:
> 
>  - `igmp->csum`
>  - `igmp->group`
> 
>  Later, `igmpmsg_netlink_event()` copies the bytes after `sizeof(struct
>  igmpmsg)` into the `IPMRA_CREPORT_PKT` netlink attribute and emits
>  `RTM_NEWCACHEREPORT` on `RTNLGRP_IPV4_MROUTE_R`.
> 
>  As a result, 6 bytes of stale heap data from the skb head are
>  disclosed to userspace.
> </quote>
> 
> Let's use skb_put_zero() instead of skb_put() to fix this bug.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Yiming Qian <yimingqian591@gmail.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

FYI, I checked and ip6mr_cache_report() seems OK.

