Return-Path: <netdev+bounces-271088-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QD9xDwqTwmkXfAQAu9opvQ
	(envelope-from <netdev+bounces-271088-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:35:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D3565309832
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 290363007BA8
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8133FB7F7;
	Tue, 24 Mar 2026 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FzzP3ut1"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011067.outbound.protection.outlook.com [52.101.62.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2FB3DD519
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774359303; cv=fail; b=bPVzybUHTmDi1vXPW9m7z5TND69rdnVSYHGo/xESQ4Sz7kLYUsNvNP7QfcOD1bjMD3ZgUc+dkeG3T9ovwPYH0eM2p3WkvyVexAYMLwOzqowdGKtoYAFLEElJ6SmjoqC/DBAD1wu4jNYc6NvHwD/sHqokCzgCtvqXNSiJP8QkzD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774359303; c=relaxed/simple;
	bh=jzccKwiXfE7N8wYzcy1C0R7u0Vem2gVled7dxoYGo9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LytzwXcRWuyFvrIFhRggGDEBZeFZ17Acqm0p6bf4q4OtzkWsFPZUhs8fAj6MICK+jzXfbks0jrElZy0TP5q1J89w56BeqkLygteyNKGAjB+4yBUeCzChWDTBCH2JzdyyDS7WuBUcN4cWoSlQMNhmXEuPYOKn3dp1Ctyz71fGOJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FzzP3ut1; arc=fail smtp.client-ip=52.101.62.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+oKRsKH4dmTjz7Q8GZzUCpRxVtEzG0c6ABZ+GqHVFMlqps8p1cudDfsy+YdiMXzSWUv2N9buoI+/hlCpsXqSDRVwLb1PfMS+w/189p/pFwvisTsJYIwFZajy3fP8B6lVUm9DOzlGWsyRh2HPNE42h9/VVhoZaExnGiMucxZoTT2E8Wkh5wRlPkbwONC/CiTvJJU6qdWE5wDed9ouiojk9He3U6DiVRwykDywH58LRsnJLXZeX0KT2eL3074pHJrsT0WMo8N0i2TeQF7CSGTRtN2TBZ8r7brI90KdYu0qRGe4fgQGc3nwo+XBECujCVrIVg1IlqasXbqX7ZosSS/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91+jTYDDcQ/7JCSDSpdlADHJ7ikCvwrV9rCZhpkpB/M=;
 b=NIOErVZw25iMEO7CNsyW5Lr98bdsQIVCRxD0bxTkKMembSghiK78UIseHhEicYFxDb+eVee4G4dMWowXtRYT+4OHkeMj7oqxMmPTCUCF2zJd+l1MZmMg4RkLi4flQ2S8lmmUwcNIrxCK9K0H2jRVqEKaNx+cVY0BujcTMMYJ4a0XVPAHxBXCniXiPODVm2EgvD25X5qvoz97kZVNwDYKCa1i2nIzlD3486rOSBmSzw2NSrEy+ZxxRm/83m4YIAw0sF7JHE3T/D3+bOB2WPoxocw29hjKB+pqXQUWh7utSVRtZW8qfFs4ZUrre5JrncSA3UIbAMCGxGMl8Zmt5whfRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91+jTYDDcQ/7JCSDSpdlADHJ7ikCvwrV9rCZhpkpB/M=;
 b=FzzP3ut15/2btBKKZ5aIhPbOT7peVhvU+J7ASU56yEZch7nDVqB8bHvuVLg40IgPu7os7sAfbCzTm5zt3vmMjyLVKYvjnU1S2XLmbCCsBghCR3zQgI4+25fN73dMSZhVjIEp+41m7ZACrKFTd752rsw9FKcJdrtnpogBN8dJapQAWi5L2/TsAtlBT1d+Dh9e38maiDL/Q2MIh8Dd5B7+NDlj2jAFXXdNI/W6qFTEF6wwNZfRsCZbYVMI2/LAYSaB27gPbyX/5tykq7UDQGbhUxeglVBBGPAxG0GExEpj500vHXRb85TOgBwUIwXIO4vwqYR4ZIb0bj2WbAQ+gwbccw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by MN2PR12MB4421.namprd12.prod.outlook.com (2603:10b6:208:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 13:34:58 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9745.007; Tue, 24 Mar 2026
 13:34:58 +0000
Date: Tue, 24 Mar 2026 15:34:49 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net v2] vxlan: fix NULL dereference in vxlan_igmp_join()
 and vxlan_igmp_leave()
Message-ID: <20260324133449.GA460138@shredder>
References: <20260323095544.3311285-4-bestswngs@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323095544.3311285-4-bestswngs@gmail.com>
X-ClientProxiedBy: TLZP290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::20) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|MN2PR12MB4421:EE_
X-MS-Office365-Filtering-Correlation-Id: 60731143-12de-4eff-e928-08de89aa2429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1q/XJuxCkhI2ZPYsxhhbdbYadFwJ6hqJVGr6oMA7BBIOfgZS3IzlzHQ2BRxwxq4I+qgJiLKbZJvhA87+5sTYxc2oqoouM5HSwjhVVgAiEbyy8JTzteSOObWFDnzHhYPz2yOU2HnCoRyju5HcYt+09ZBf64jXoXnUKyV4jdLT7RpQI8uEAMWZKzlahl3I+jwMPn8OvsP7nqSR+Tg7WjEbSNmX/xD9KfmJWJ/lcmj01KekIDFSmYFr4uACaamvGupqLKalsidDGa7TBfbdVTKWZ22W10SRXHkF2BghXWffw4N/8FuSl0IzvkE9iPezWxiQA2IzxXbPYQRY5+R1hXoBTAnRbmveKe2BGuLo3/w/j+/YbrXdbBh/utgQw0UHz+o08cg9hbZ4LTLdFZNDWwwia12sGxphsrb8l2pPb+iFPFZmb441MMZnM9LgfPGm5567yvEKvKkt9F9jSB0gCBPtZKc6K65pRQIqE72p9GHmZh0oPquhxONH0kFhY1zosv6RAbd1oKbcSdC7Jp1NTbUZr01Ebmtb+n2np1emhJkj19aYG/iGQGnJRDbD7RnWMUZy+vLV266tez2wGJBRocEkmUzSxNHs5lIKOsimOi4oahL5K9oivOFRMSgFDDh9tFNL0RoBewTUbaIPi+oUyTaeoYTdTguNC/zTbW2SCC42mGlv0IZpmMSc84QJoqZNd2ogWPjjYlAF1vzXfeCXprR8df3aw5cCA/gfo5F7oM+wPCM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ayb9f5MUYm63IjI7R0wrz9xjDhtz+sdfg+qjbkbrBHhCM5hqrt+oAIZsA4Ch?=
 =?us-ascii?Q?Wplh6HI31MPdDlic5QQRz4tOy2Rzno0L6YG60Sxrway8EPeXKVrxNMlVhj0p?=
 =?us-ascii?Q?gZqUAM1EwXuAxv4OCxrQheQG9oPuzdHOjATbCjL1f/WxT8xEHIWCiA+gAi1M?=
 =?us-ascii?Q?8Uf05x2mdyoLMGcIJDwiZMmgKsT0jPIY4Pxs2tmPY7IVDqJCztVa0BEQCcXX?=
 =?us-ascii?Q?EpuRV7lW3KujsbEtebFj19Q0q09JbKb5Livn+NNVnWkDoYECQ82TOPJ58Pqc?=
 =?us-ascii?Q?Ur26mMoT/e8WXaOvKypBpFHUNz3rp6Lg5iY930W5E+5KXkgU8c6hEinw7bUR?=
 =?us-ascii?Q?BqLqf5/M2zNfhWgLDNl8s8oTkOcUReZiHe3eCltDUajQhOP+t54zZomgtYrL?=
 =?us-ascii?Q?bIMxxrloNGxMj0908yBI3FRuXcoKSCNkSzisHBX3Xk+btp3z8asOxIi/opRF?=
 =?us-ascii?Q?Nmg+Puea9YMTKoicaUjgsuDbgZ55wHbcYVwshzF3CB2Zb5zsS11iO4ZLYG/7?=
 =?us-ascii?Q?6xWlZuN1h0bIw9OsZBJqvzO94B5HZ52/iXOVaeaI4vzy6eiP/SWjfXIyDiNt?=
 =?us-ascii?Q?d+tbBUM3qJTj2Kd0dW7MqR1P2W5XOpax+vmY7awEZNfBqda8ET2YSKnKlDw5?=
 =?us-ascii?Q?TBi2AIPZfZcX0NaQTU6X0fjiyFSfNg0BHE4Pn9/2qng7W/uOB1PBZZbXsrre?=
 =?us-ascii?Q?E8CHnea7QP7NCtz/f1dd7o/g055y+WY9zRjxUa44i0GmTVhItiiSHmYF3Gsp?=
 =?us-ascii?Q?Uj9Agk7oGjDOqG3EnvAx4hsOXFcDINq99tsGx6CZbgmpyl7dFqX1q/4a+2sk?=
 =?us-ascii?Q?z19CBeqN4ixNd9a0ydNtZMRtD2HMTeqAQXILCsTJCbODup/l8v0sAYcrAF0m?=
 =?us-ascii?Q?Wb0RYQTIelRGSi9CsC2iI2l1YApbe2S6A5l//Ilc1aYyhHQRRSXhTu5LQlTw?=
 =?us-ascii?Q?bEmYrC6WDbox+zyiZt+SnFKXdKjkH0443AMRrtNf6PmkHkoI1qMpnVOKudlp?=
 =?us-ascii?Q?kcpbjG7FQvu7n1pugKXWf5jbZunNw4xdZIzVrvJ9A5BUx0HC8ncgDEp6s1xq?=
 =?us-ascii?Q?fIgViA3XcuolPXqmsOIuvIN5CbdaLPITMaol5PS5DbffrouDDrRE4tldWLmn?=
 =?us-ascii?Q?MTyJm/MFUgdtlShmHTI7MoIQmcFn0aSAKqXOiC7LjFAeSkLDviFbRfJepkLg?=
 =?us-ascii?Q?YsrGuDajW5We1C2U1CLOmcNvRM0rVny94iJGI5MzwsmNu8nyAe3R0sJ2ppHW?=
 =?us-ascii?Q?1ZLvaec5h5bKY/YXfgeJldYxWLnLnJFl0pxciyzbfexToTAhK1F5VuQMl0Is?=
 =?us-ascii?Q?FURuThUY5oItVf6ZhOR7ToXoFpzFX41c+0wa2TC1ChHGefoohqVMPK30Bj5m?=
 =?us-ascii?Q?1EiSMKwh8dP7kIpzun+RKIJREm0nsQmxHfKs21VXFi5ndanGIWxNr6uE9AhB?=
 =?us-ascii?Q?HxDT+pvH8Jd11ORtAKYXDQe4Rrrt0vuRDquUV7Dwtbi8cuVqVO7eXJ6gxWHT?=
 =?us-ascii?Q?ZvLDbSBJn8LLw5JgjKj1rmumcYfrYl0gApuk0p9TQLeQ1ma3vXW/ri2NP5zy?=
 =?us-ascii?Q?ph7Xc2Y8bdoPBm4+xr76lVQ/Bm8F2tMnnHkOYUAqlnuhWEMT06bHVvKZFpf2?=
 =?us-ascii?Q?Vu28zAx9vIC2lc4cKYDpe04d44+kuDNbXq+dCOfOFXARhc/iwZQyYCz+ECS0?=
 =?us-ascii?Q?M6l/pltDh7dzegyO61cT4eqgpY4AvJ0Xii9dnEUKLbL6eIbBGxFebgyjgZ8X?=
 =?us-ascii?Q?0edBdQtCFw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60731143-12de-4eff-e928-08de89aa2429
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 13:34:58.1986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/u1qIArY5+trrWgycBA8zTP5iQLid0BzHI0ZulHu4K2ZGLd2FXo/yfR9QE0JFITsu5AOJ6QKJWRRidIJ7pBRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4421
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271088-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D3565309832
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 05:55:47PM +0800, Weiming Shi wrote:
> vxlan_sock_add() tolerates IPv6 socket creation failure with
> -EAFNOSUPPORT and brings the VXLAN device up with only an IPv4
> socket, leaving vn6_sock as NULL.
> 
> However, vxlan_igmp_join() and vxlan_igmp_leave() unconditionally
> dereference vn6_sock when handling multicast group operations for
> IPv6. When a VNI filter entry with an IPv6 multicast group is
> added via RTM_NEWTUNNEL on a collect-metadata VXLAN device where
> the IPv6 socket was not created, the NULL vn6_sock pointer is
> dereferenced, causing a kernel crash.
> 
> This can be triggered by booting with ipv6.disable=1, creating a
> collect-metadata VXLAN device with vnifilter, and adding a VNI
> filter entry with an IPv6 multicast group.
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000010
>  Oops: Oops: 0000 [#1] SMP NOPTI
>  RIP: 0010:vxlan_igmp_join (drivers/net/vxlan/vxlan_multicast.c:40)
>  Call Trace:
>   <TASK>
>   vxlan_vni_update_group (drivers/net/vxlan/vxlan_vnifilter.c:573)
>   vxlan_vnifilter_process (drivers/net/vxlan/vxlan_vnifilter.c:976)
>   rtnetlink_rcv_msg (net/core/rtnetlink.c:6986)
>   netlink_rcv_skb (net/netlink/af_netlink.c:2550)
>   rtnetlink_rcv (net/core/rtnetlink.c:7005)
>   netlink_unicast (net/netlink/af_netlink.c:1344)
>   netlink_sendmsg (net/netlink/af_netlink.c:1894)
>   ____sys_sendmsg (net/socket.c:2592)
>   ___sys_sendmsg (net/socket.c:2648)
>   __sys_sendmsg (net/socket.c:2678)
>   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
>   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>   </TASK>
> 
> Fix this by adding NULL checks for vn6_sock in both
> vxlan_igmp_join() and vxlan_igmp_leave() before dereferencing.
> Return 0 rather than an error code because all callers treat
> non-zero returns as fatal -- vxlan_vni_update_group() would
> abort a VNI add that already inserted into the hash table,
> and vxlan_multicast_join_vnigrp() would fail vxlan_open().
> Since vxlan_sock_add() already accepts -EAFNOSUPPORT as a
> non-error condition, the multicast helpers should do the same
> by simply skipping the join/leave when the socket is absent.

I don't think this is the right fix. An error should be returned if the
user disabled IPv6 and is now trying to join an IPv6 multicast group.

The situation in vxlan_igmp_{join,leave}() is not the same as in
vxlan_sock_add(). EAFNOSUPPORT errors are suppressed in vxlan_sock_add()
since in collect metadata (external) mode the driver tries to open
sockets for both address families and if IPv6 is disabled the device
should still be able to work with IPv4.

Regarding "vxlan_vni_update_group() would abort a VNI add that already
inserted into the hash table", the fact that there is no rollback in
vxlan_vni_add() upon vxlan_vni_update_group() returning an error seems
like an omission that should also be fixed.

> 
> Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
> v2:
>  - Drop unnecessary sock4 NULL checksjjj
> ---
>  drivers/net/vxlan/vxlan_multicast.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/vxlan/vxlan_multicast.c b/drivers/net/vxlan/vxlan_multicast.c
> index a7f2d67dc61b8..a442c9e6d1a72 100644
> --- a/drivers/net/vxlan/vxlan_multicast.c
> +++ b/drivers/net/vxlan/vxlan_multicast.c
> @@ -37,6 +37,8 @@ int vxlan_igmp_join(struct vxlan_dev *vxlan, union vxlan_addr *rip,
>  	} else {
>  		struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);
> 
> +		if (!sock6)
> +			return 0;
>  		sk = sock6->sock->sk;
>  		lock_sock(sk);
>  		ret = ipv6_stub->ipv6_sock_mc_join(sk, ifindex,
> @@ -71,6 +73,8 @@ int vxlan_igmp_leave(struct vxlan_dev *vxlan, union vxlan_addr *rip,
>  	} else {
>  		struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);
> 
> +		if (!sock6)
> +			return 0;
>  		sk = sock6->sock->sk;
>  		lock_sock(sk);
>  		ret = ipv6_stub->ipv6_sock_mc_drop(sk, ifindex,
> --
> 2.43.0

