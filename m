Return-Path: <netdev+bounces-299810-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E5rGK5MtMWpodQUAu9opvQ
	(envelope-from <netdev+bounces-299810-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 13:03:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AC568E9B5
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 13:03:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=ig1EMD4q;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299810-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299810-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 906493004CA9
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 11:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083D7428838;
	Tue, 16 Jun 2026 11:02:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012016.outbound.protection.outlook.com [40.107.200.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CD44266A8;
	Tue, 16 Jun 2026 11:02:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607758; cv=fail; b=F0Oy/DqIkuy0u2jn3zM38JisyGR9pX7I3uaoew7WI5g55lwhuDjRxECwFMycT+8JXpwoyN3yc5hczj3+GRZ1FbC3Wv5f2fPXr1fbRe+GFKkIHGglPWDXvMmSN/zldOfI044m+9qI+q9HX1Ok5Y88cxSsc6X+dvyafoeHhCLW9ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607758; c=relaxed/simple;
	bh=RlLBjZ1sYeGXzB059zMpi/JUr5cSMKzTnoWMtSyt22A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qV02c6kCDbmaqDdzQQnt2b263o2iFgP0zAZUnGnl8A5fSco65+328riK0i1GkSOHOAEAfJD682ktDR/++2NPqHskVsHgWniMxOL0szTDO4T1PMcLeayQkXotQg4SOOlnhW0rDKGbjsEGxVav37Vv2yHsDto+Wh/oeo0A/berBKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ig1EMD4q; arc=fail smtp.client-ip=40.107.200.16
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YhYFun5vx4WNdcvwgOrvQ2LEeFzsUhUInnFrWdSQB469dKky3jbWC0CVfFTKnMfy7OPsnyvIUJQgOq7PwKasgE/Zb2jdOPoDXcwoUlIcsLB1ba6nqbP8Tv8YROtoPCUyHgV6OwucMf82uYLZ6DzejcTX31gSznLiIKs0LZQckOh6ux7wfz6Cn9X3LlD25S8yJkERzV73qDU5TcnlIu/y/PRFWP9Gtdsva7UOv6lk0xuluveG2S0UawUZba1igYNeKhQwPvaynAigd1lrrpw2qX9Ld5o+33CHEN/S4NwiDzbDJ8epLjPxM8B2KqPKErI6SRLeAN6eN97bqviPLQI2Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcH9pg+ExpBttc5S22z3vKIVyCle30gKXXIJdeUQ5Cg=;
 b=b3lFEqgoX+TvgTi/AIRa4c300VS+6a7dlo0dOGk3idqAX1LeuzxD/6ui+XCWlX0xKCCqWhp/UQklYg6EU8Mazm/Z0uaaf9UjFWwa6FJIqlsDVT1O4dLNo5nZSnjTNJegfExLtWcnOSBMaAghF2Fg+3s309kyeCiGOVj9ZC+nkamkvQLDPzC/n3hZDrNID5/npG341nsF+Y7n/bX+Jd0XdS5piAehGuKbWpc0FporHRfgLUJIEZ+K7jsjsXITwR6gn6alt3Uqrdi6FdSrxWuaBN1KhzrkDk8nvSzlV0mNsirzuP/kSL8jKg/r/tIdNMBk2O/3hvskg4I7nVOAN8TWaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcH9pg+ExpBttc5S22z3vKIVyCle30gKXXIJdeUQ5Cg=;
 b=ig1EMD4qaQdeuqi8vTI58qETpM6UhfDy+9YpzHNmGtJPJ/WrcLTU8EXavlovzh7OHiel3VOghKs4PVnIGcquOO1pCbroFaHLpuzHF6aaMdiWEJV0bDJ8YhkBlORarNkL1eNPUFKiZDqojxlNRexpcptQ6ulv0l7rL7iOpTdzcHpjO9bdjERsUWWs1lRyMPFtbeBJlm5J7bYaJTgT+/nDq5TQEamppmRVxSokKkOKu75cONIOPJ4CX4o4cKJwWZ5t8/MrpeSjj51+Kk7CmirJHgSftRUwghGvu1ZLuaJwFwWjdNB4C5wxM5LkFrQ2WhxT9LXkJ31FOikT/pWvTZDElA==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH8PR12MB999205.namprd12.prod.outlook.com (2603:10b6:610:35a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 16 Jun
 2026 11:02:34 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 11:02:34 +0000
Date: Tue, 16 Jun 2026 14:02:24 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: laikabcprice@gmail.com
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v3] ip_tunnel: drop stale dst from generated PMTU
 ICMP replies
Message-ID: <20260616110224.GA753154@shredder>
References: <20260614-master-v3-1-9f5060ba1ed1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614-master-v3-1-9f5060ba1ed1@gmail.com>
X-ClientProxiedBy: TL0P290CA0009.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::6)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH8PR12MB999205:EE_
X-MS-Office365-Filtering-Correlation-Id: 98ca7c2a-1885-4471-5fcb-08decb96c4b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|18002099003|22082099003|3023799007|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	0FMrEleXW12GQ9HOayaosHzDCXa/KdYA7gp6DMaDTk1WMGKFvrBWMiXhdtMaYd1TTKe4VSfO3HjCTulATKYSiNG/Q/OZw4aexv4aHQDVKl+wqC0fQHkyAkLkgORi+8LgKD1WYm+JL/p0W5ZYoKFgyVCefeCmTblsgz7c4FcepcmyEvC/ZiQ0HdzsyZL4idMMM2tNpzuG6UE1RSrr+tZ9TTXBwCEm1VRSPVsNd3fDA8S6Kc3YJiJWjWAKPLzai2OOFYUROmKA8SZcsrIBuLEKM301bcJVz91Dnc46TfLGPGQ0FnKCzas1Alugu1P45GAc/XeE1Cc1GcqvqHaan9EkvFQiIkR4QFWuRKRSt+FOPMoq21IBX3hqBNndJyD5oW5hh1x/vN4GzMFHccolirq/lJnez6LYJDr7uY2LmOcV1IKwde7nBGJ4xlapx7b/T7E4P7gPz1b0wmGlUYyJW8GL3d8zVgVb1MgGix5H5BDXhcaVwpVAJljEvYJu+4/K/MuH6WDzbJv0oe2pEizTaefcNCuqe4Is4qjt0pLUSXpF7bg7aaY8xvmWdnL/BUqvLqQtuK2o7Xi7e7mPj+hPnnjYVlJ6X6u6wJtfSnohKub7YOsOo+2V4NIfZlUxs9hqnc//pmwIpLiImf9fjxDFGKZi/RDLelklOeHCQHMqyAx5wo6o/1NsWrJG+ChS59GrG7Tlc6wUeXX7d/OCTlIhvpWlzg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6wfE4i063Wnb+wBjMritX7hJJG4udcFXt9RcXMCY25Uh7qI/v5yseNjCfbAG?=
 =?us-ascii?Q?EjKNBTgD3bbBXiESvt53LSyDWPQWwDZ/0F4GEYqsGbRAEtqI6372135Pqhss?=
 =?us-ascii?Q?9LL26RuTpnpKNE0J4TZds7mg3zjqdMeURL76OsdMjg5gK1f33BawT2aBaWvw?=
 =?us-ascii?Q?w5vcK2tPO5YkkZKTcY7OgWFKWt1/kkasWKJw2sQR8ZfD7JZAMHAyJNf22c3Z?=
 =?us-ascii?Q?NoFFPpOkxWwQ7t34MkK/R5lW03MieRQrW2aflRGyiQZSN14QzSiH3jU85i5E?=
 =?us-ascii?Q?+qByLHApk0yNtUVBKGvo41i3Nr+mbjEpQFd8aBesg1AHuHVx8LqByJDtwexb?=
 =?us-ascii?Q?DUahPsKXxEzzzTc6B85Llj3h8yPh/povEqh5qEfAqoODNN0xKW2B5E192cAV?=
 =?us-ascii?Q?z30TzuPAaWZX1rsKr3LMssH1qdZXxEFJYMqc7EtMrHV325sQMohia7+1KFBQ?=
 =?us-ascii?Q?yPVnDspDtzrVEnHH9MWBj2QPW8mqEV09ZU0h9XtlSywrsIvVJgx5ClqyD1/e?=
 =?us-ascii?Q?F6tegqI4wexQbzIqGdJyCTf4HPJYYLDC9kVcdTUjX4r7O2oAe8bH0P8Oq3/p?=
 =?us-ascii?Q?AmC1AJKt7iMxQxwYzN5KktJq4sL4D30DJ9j+bSmtbyulvoeyHuP2GQ2zhnT7?=
 =?us-ascii?Q?AhPMZOcxdhnf4VAg1S45uCDAGeQ7A8DdPjEvdU2IxYMd6W2EmqkBnnhazijm?=
 =?us-ascii?Q?Ag/PtMfX0FUnGsCmVny5FA1t9/Jhx4Hh6XhjfMMaN5/6n9jJvZsQz+qDPmMh?=
 =?us-ascii?Q?7gXt6mLe+vtf8AN1bMErY9xuUhEUFA3bGPN9Wx87+LJ5rTGJismADgH4uL7o?=
 =?us-ascii?Q?BoFxl9LFJvH6moazkOFTAfKInFpdoZlv/7Fwsdr3TXJb81FKDY1js00NzsYn?=
 =?us-ascii?Q?2cuE0BQLsrZxH0b6jbsTfgK7YT0chQMpX11MVbwaZn5VpgRmSEh1UQJv9qSq?=
 =?us-ascii?Q?aUj2PaR79L7sExZDCzDBYWzkDp8NFNE0VQ2HwxH6hZTcpR9maNSiYaVQdqL9?=
 =?us-ascii?Q?wZPt4YM47eNdsccHIoXSx5XgGXLmMRQCy6yBNA0BoKfjjGrwPUye5Poai/FA?=
 =?us-ascii?Q?oCczitjm1vA/H+AhBwJlG+iLwZqif3N6z89bBhSkmJ0CL6X07oI7zC5Dhinp?=
 =?us-ascii?Q?QDkHtqdYq8J6riN2JxdmRydIGFJaaOK8uTu+ceu1cuTkK8ev1IPna4lmXsM0?=
 =?us-ascii?Q?Ayd1XWNTL67D+PuBBtJTIN2c7j+eaUGT5TAkO3e2FU1DqIkpEEeHBfOkh8Vm?=
 =?us-ascii?Q?QuuVNQe9XVhowfEyTxzf6hJguDVcK++/ut/UJVQtEKdFk7iEttXPO+7PT+aK?=
 =?us-ascii?Q?XfbFEXV6y8KbhfLNwmPn/MI/qF41TLCeFAJw8LjJuTS5/MIvrYfehu+FRnMC?=
 =?us-ascii?Q?GuLhKkiu05J5xpddefktBYswxtlze6Jr5FpZ2ZsYeEBfPikZYuqTZCt17nC3?=
 =?us-ascii?Q?c8WBtHzV9rDWMJkQxpsya1wPJ8SRUghEny60iErIsRwZAPV2hORvVxCoCgwS?=
 =?us-ascii?Q?vNuvg1lmhwRqbVyGb3ZVGVj7k8CIF5Z8t+dZGDr1p+odwXCFbjA+0+q7D79T?=
 =?us-ascii?Q?7jW3XdisdIk4loUF+XZiL74+2NKtky26V535oWz3dyyQz04oYs/dh1uHzKwq?=
 =?us-ascii?Q?Dv6Zt5NbhAjxnpcJJMeTbmATyWbh29zlC2R0sKiQk/jQJ/IU/LL7hVp/pV0r?=
 =?us-ascii?Q?BMfNKYecLlPZBHR5pgVfnHA5+9qHAgpRLwAdVWoUVhZWMocD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ca7c2a-1885-4471-5fcb-08decb96c4b7
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 11:02:34.0449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26CCRw0YPQ0H/5/BKMTF8BlRpqSe9+SzK5oEthme3CBoZ/WjhY6kOdKJcHIZnIJVwe60Okzj/AtMHAU6AM1vZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB999205
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299810-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:laikabcprice@gmail.com,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,nvidia.com:from_mime,vger.kernel.org:from_smtp,shredder:mid,Nvidia.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ingest_mdir.py:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3AC568E9B5

On Sun, Jun 14, 2026 at 12:13:57AM +0100, Laika Price via B4 Relay wrote:
> From: Laika Price <laikabcprice@gmail.com>
> 
> iptunnel_pmtud_build_icmp(...) and iptunnel_pmtud_build_icmpv6(...) take
> in an sk_buff, modify it to create a PMTU ICMP error reply, and return it.
> As part of these modifications, the source/destination ethernet and IP
> addresses are swapped around which makes the sk_buff's current dst invalid.
> 
> If the stale dst is left, the packet can skip input routing and be
> forwarded using the original output device. This was observed when sending
> packets to a VXLAN over a WireGuard tunnel - the ICMP reply was generated
> but it was sent over the VXLAN instead of to the WireGuard tunnel.
> 
> This patch drops the stale dst after building the PMTU reply so that the
> packet is routed using its new headers when it is reinjected.
> 
> The pmtu_ipv4_br_vxlan4_exception test generates PMTU exceptions by
> pinging an IP on the other side of a tunnel. This was incorrect as it
> would return upon the first ICMP Fragmentation Needed due to the -w flag
> being used in conjunction with || return 1.
> 
> This patch updates pmtu_ipv4_br_vxlan4_exception to be in line with how
> PMTU exceptions are generated in other tests such as in test_pmtu_ipvX
> 
>     run_cmd ${ns_a} ${ping} -q -M want -i 0.1 -w 1 -s 1800 ${dst1}
>     run_cmd ${ns_a} ${ping} -q -M want -i 0.1 -w 1 -s 1800 ${dst2}

1. Please split the selftest fix to a separate patch (patch #1), explain
why the test is currently passing and why it's going to break with the
subsequent code change.

2. Use the appropriate Fixes tag for each patch.

3. Go over this doc:

https://docs.kernel.org/process/maintainer-netdev.html

4. Use ingest_mdir.py to test your patches:

https://github.com/linux-netdev/nipa#running-locally

> 
> Signed-off-by: Laika Price <laikabcprice@gmail.com>
> ---
> Changes in v3:
> - Squashed the selftest update into the ip_tunnel fix so the patch remains
>   bisectable.
> - Link to v2: https://patch.msgid.link/20260613-master-v2-0-061b70fd45dd@gmail.com
> 
> Changes in v2:
> - Fixed incorrect PMTU exception generation in the selftest.
> - Link to v1: https://patch.msgid.link/20260613-master-v1-1-df796e8e2d74@gmail.com
> ---
>  net/ipv4/ip_tunnel_core.c           | 2 ++
>  tools/testing/selftests/net/pmtu.sh | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
> index d3c677e9b..949150e43 100644
> --- a/net/ipv4/ip_tunnel_core.c
> +++ b/net/ipv4/ip_tunnel_core.c
> @@ -267,6 +267,7 @@ static int iptunnel_pmtud_build_icmp(struct sk_buff *skb, int mtu)
>  
>  	eth_header(skb, skb->dev, ntohs(eh.h_proto), eh.h_source, eh.h_dest, 0);
>  	skb_reset_mac_header(skb);
> +	skb_dst_drop(skb);

This probably needs to be:

if (skb_valid_dst(skb))
	skb_dst_drop(skb);

Both VXLAN and GENEVE use the dst after skb_tunnel_check_pmtu() when in
external mode, so you can't drop it unconditionally. This shouldn't be a
problem because both IPv4 and IPv6 will resolve a new dst if the
current one isn't valid (i.e., it's a dst metadata one).

>  
>  	return skb->len;
>  }
> @@ -370,6 +371,7 @@ static int iptunnel_pmtud_build_icmpv6(struct sk_buff *skb, int mtu)
>  
>  	eth_header(skb, skb->dev, ntohs(eh.h_proto), eh.h_source, eh.h_dest, 0);
>  	skb_reset_mac_header(skb);
> +	skb_dst_drop(skb);
>  
>  	return skb->len;
>  }
> diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
> index a3323c21f..9498d9f53 100755
> --- a/tools/testing/selftests/net/pmtu.sh
> +++ b/tools/testing/selftests/net/pmtu.sh
> @@ -1456,8 +1456,8 @@ test_pmtu_ipvX_over_bridged_vxlanY_or_geneveY_exception() {
>  	mtu "${ns_a}" ${type}_a $((${ll_mtu} + 1000))
>  	mtu "${ns_b}" ${type}_b $((${ll_mtu} + 1000))
>  
> -	run_cmd ${ns_c} ${ping} -q -M want -i 0.1 -c 10 -s $((${ll_mtu} + 500)) ${dst} || return 1
> -	run_cmd ${ns_a} ${ping} -q -M want -i 0.1 -w 1  -s $((${ll_mtu} + 500)) ${dst} || return 1
> +	run_cmd ${ns_c} ${ping} -q -M want -i 0.1 -w 1 -s $((${ll_mtu} + 500)) ${dst}
> +	run_cmd ${ns_a} ${ping} -q -M want -i 0.1 -w 1 -s $((${ll_mtu} + 500)) ${dst}
>  
>  	# Check that exceptions were created
>  	pmtu="$(route_get_dst_pmtu_from_exception "${ns_c}" ${dst})"
> 
> ---
> base-commit: 2a2974b5145cdf2f4db134be1a2157e9ca4a1cf0
> change-id: 20260613-master-b749dfae5ecc
> 
> Best regards,
> --  
> Laika Price <laikabcprice@gmail.com>
> 
> 

