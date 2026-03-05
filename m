Return-Path: <netdev+bounces-264324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHvxFO9rqWnH7AAAu9opvQ
	(envelope-from <netdev+bounces-264324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:41:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E53F1210B99
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5D533070341
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 11:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88F33932CE;
	Thu,  5 Mar 2026 11:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EQyusqOG"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013069.outbound.protection.outlook.com [40.107.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D4339281C
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 11:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772710797; cv=fail; b=RRcmZV0oNnutaOGH+Se63+zVdbih/FmnK1tqIn0drSGpaIocFkJq2ZpKMrNt5lX3l3mZRnS8JEQAVcwatHd3Kx9pM7wqofrmKALXznJhyajT7kQR8M3X5gL8lZFEK0V0yNsOz3iOP9hNMNzV+Xv3UnusTQZtHJiRpeQCQkZFcC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772710797; c=relaxed/simple;
	bh=nzjE/XEZsv0j8x6ReVu7qr5e0mvRfXmkp81tnVjtjKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O6PbLJG69gcyLa/XfMX8qDsPf/3akzLcC9Xz7rHuxY88qRQUbkAuyuCawalDm3NJHWgiuX+RWhZC10a6uv8gdi2MC5VpsHAnIBNK9HLHGfBII1I3eLeSO10uNd7YgNccBxP6ulD7JAu7Jyi5Bhb7P/SuuTm4+NCbKOKdzxvjXJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EQyusqOG; arc=fail smtp.client-ip=40.107.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9HVDK21iKceFlTeIgvOZ+0W796inrSXNjpv3uLe2Kyum3jEfYuwUCKUslLxzGsa3+cLZCt1mHbFyhXVWLl9mh3EHUPVBCozvkYEmOFkE8H1AbWP0c1qo46PQVZdjNQtPgCyyjHh6BMTWKUg5c/IPkj8uhizPNO8snPyANX7s6DuHHzrRsCmXVuKfMpRZPKZ/qUNfa+N9Jt3nbJ8Mf6HZBEh+gYekyj0szZTUb8Mx8lOe4IeDUJ+C18FJaUBkuSmZ65Awds5akHB05lZx5paR1hOk7fPvdPITMqc4UgTubIB7q2CVi3FjVk36EoOG2XfjJKcRO5ujh0pkdlJnRY3sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/O0cBAtYI3UPDlFQgSg0/8SZMogo/KFiTSDIZNgm68=;
 b=CVpuKFHBz37T6BpW6PwFuIQUuratUTis2QmcVty2F5YEXnVKgafUDfrOUdj2YFwZBtFneXcm6H0g8JiNF9jrC3se6aYFLuw9F41jmwOUvplMEXCLOSxATzkcCAYHUXr05h+lIfyqNbzhoiY8I0HTCXarELz6tbthvYzZriEl4FaWv0CJw0TUpFy8LYhbFazIcosXq0MmbSvb8+LO7/aAHEFv5PMoAAq9G/I/mT7SP+d1k/qj+apn18ZWdqof0eaAz4KgJTWMxweysxu18JVnKwkji4h+PlsXQSJnH8BFaCRJi8BHCnLtKc7GUL/kzB9AfHjkol1bIgMEoljmzlgchQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/O0cBAtYI3UPDlFQgSg0/8SZMogo/KFiTSDIZNgm68=;
 b=EQyusqOGFsuMwsfTWXhpr8oHJ/HfoCqL7TZpgv8MpeIOVVYQkOibFrJFf9W37bMZ5xlsg0Wn7jgdlFvgCS/l9vLLUX266dmBWVU87tve+xFk1L6Y3UrE5OaCgWOjYWFxiJc4YgUMFt67kpgpwZfku5u6cCYNA9CkrzQs+D3qaU4jo+ZYTrTe+b4A9hsN+ohiq6184jQ7JiwUDd8bw4dODLfpgmRVgEkk4QVb+A2l5cKK/+7lb2dstXdWfO97kzMNPPmR2DPkpUiZhMwxJ1t1OVDcZI164xmVecmavI867ioPRguIycSq37WKMgUxOli4hvhGFWhkZZNezdbdgRD3kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by DS0PR12MB7899.namprd12.prod.outlook.com (2603:10b6:8:149::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 11:39:51 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 11:39:51 +0000
Date: Thu, 5 Mar 2026 13:39:40 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev,
	roopa@cumulusnetworks.com, sdf@fomichev.me, petrm@nvidia.com,
	horms@kernel.org, razor@blackwall.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch, Guruprasad C P <gurucp2005@gmail.com>
Subject: Re: [PATCH 1/2 net v3] net: bridge: fix nd_tbl NULL dereference when
 IPv6 is disabled
Message-ID: <20260305113940.GA1359245@shredder>
References: <20260304120357.9778-1-fmancera@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304120357.9778-1-fmancera@suse.de>
X-ClientProxiedBy: TL0P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::18) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|DS0PR12MB7899:EE_
X-MS-Office365-Filtering-Correlation-Id: 8661dd14-2117-40da-a396-08de7aabe9a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	YSBM/1r0FGkm0dzfsDrSzmaNufdO+MdOLqyx0rEyTVbjSHwiwvMgRiGGnyTSsLsUvCKUaxPli4F9Og8CKcfxUht3RtLcChN8gciuUiOAuFlRzqWCWEQ8hsvu3slucC7BbnExH2Wt3aNUgsWGRKAyo14LFTIKVlFAFpk7tjqX16YQxdcUrBZBESknyaq6gHQHRSX3KB96/Q8/zjvmYJTiWINYP1RyBJGrySyy5feFf2N1rLYcKvhyNtY84q7Cn9CY/0JaDJp3qYclJzbucpHgNVnQviYv2aYniiYsVrB6DYepbIub++ssa1V7IZuyyB1izUfCeotly0XeO2hg+ta6w5z8K3uPU3fAf1zut+0ttif8SOzL/+uFZrtHGR/ic/1P/kdEnr6ZI+y3rqkS+j36HdUxqxhJwTVqgjcaSYXm2ardEYt+PElBaLr1593kxc8onOdxD7W/WsTn0vOyYOkniPR+HQZaTmEeHxpx4MYMRt90Sq1e6HDyG/feWET87whKp/Cs4UI6eoSJw/ht83n9tNoLAXvFNy5Kz3aNMeztelzPgC05oViNb7mLcshNZADOlQ0Mq+VemdQTNdK5aQTAh6lWdImjlG2DsWZstmReNfOJD7Ar9pNI0FZCmR5M2EdjR3oESOwWNufQtjyBprv1JT9EpX0xoGm0yPtj2AlsXSam9Jp8l2EAMfeBwaGG2SM9esxqir8Tgzdx8Ylkc5xbIU8SXQNj/ApsOAtyhQZ2evM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dqj3ULC6V5baVj7lv2xDtWWOeJ/aHtc4xvGTAyctCKnDRTd4ySC9lg+yo4Da?=
 =?us-ascii?Q?Selz+Ygl5skjccKqIDvS1XgAIl3IksX8mre6LlqPD2cau/orScXiRVPCkxo7?=
 =?us-ascii?Q?yZ6Kg/eq+fETcSWVtRFzHqUgQoIsuDhCjrUAfXlWQJUY4xeRuexUCq2CowFp?=
 =?us-ascii?Q?DwnGA1mnVWiPfuCWG1/RDBcskE5XDOUPmijLG2UawRuUmxNqTuLPHTDjTWsm?=
 =?us-ascii?Q?8nFBvO+pOP37+QZcWhvd9Zmp4TqFtqykCWDbKzm4kK19BQdRDrlzHSUB7IOw?=
 =?us-ascii?Q?ffEo/Z8KGZLOV9N8dpcSdUVTZkCZtvIyhBZ91+wrxbWjt5equOxCX5s9nnp4?=
 =?us-ascii?Q?d4AbalDuNTvTkO30w7TUyHHnsrVw1RHgk4T3X18GQuzy12v5S1RsppUfkf6r?=
 =?us-ascii?Q?2P8jS3DS+N7QUrV2W7i9W+p4akjTZjBKUOEpMKlKApwCg9tUmMEyZSAP8L65?=
 =?us-ascii?Q?8lfq0aY9g5TzycpThU/Z2ryFOiQ/TT/02MXScud3f4qf1OOL4EU9/M+5Hd3P?=
 =?us-ascii?Q?3LsGebutQOabjxxtYHMVtquvuuda86lHOyrUp4wk/xVCGoNKdelFvHYGrJ6u?=
 =?us-ascii?Q?J4N0J9yBmFhG+bj695knbHwwS2fTy9MiSHLFbqTHzw4kHW3hnBT+jx5+EBZv?=
 =?us-ascii?Q?eeDgj0BZ43CoYlAcQekSQ8dpH8DK78gExAMOsOAWHfa7oQFwoGWHsoeAdbfC?=
 =?us-ascii?Q?gzyjLEfHubjUYuVu7JFR/x/fcHV6Ouzx8WzyOoMZlhcpfmPPpYGlEggLmZad?=
 =?us-ascii?Q?ThVVBRdZaSmsqoMPBSEpxW95h9NHuj4Q7srGsG1hhtoJ0Uy2Lt4ir7qKp1Nd?=
 =?us-ascii?Q?ZeeNHNrAe2wgcs8S5CorotgrevrJDupRwwgGG2/dtpvODYE/tiKYZK7jrqJh?=
 =?us-ascii?Q?Zf4xQYotjbAfaJ8nhg43wsSwVYLDlqhJBzepnS1J0/MlotRy9AJj3pdipgWJ?=
 =?us-ascii?Q?4T2S6SEO0DjlgvmOzITpNgCO6Y2kf7he64093+Ewp6EV91A57qTNu9yb53zS?=
 =?us-ascii?Q?zO+4DOAauI9WRYcsrG6jcV6K2xgEcnAQ9r5w5+zDUqJ2E9Ht4UOrGcAWEOfz?=
 =?us-ascii?Q?bynMFRHwb8eIngA2GlYCqSWZ8+O8z6mGtSoWDgEpsGljBh1T4o3tT12jetsI?=
 =?us-ascii?Q?d+OIMWj/6QQs97iE3/3jTe49Rah3pXNt95R98qzBWe/VGKqizx4R06A9O491?=
 =?us-ascii?Q?JnrqfdqS/QkVmpnBSs2TWILTycxy4faHQcpoKizYZeD4B4rKU6aQDWzvA/ID?=
 =?us-ascii?Q?iIFl6QGfmm0Ot1mbNAHB4OgbAr1pNcHa85sFkmAYu5GHC76RqIgxu8lQlVZb?=
 =?us-ascii?Q?Ej82OiBED1qmSXmLbbmdFNXm7N1T4yT7d3MUxFmU2StvhV0ABqHLT1E50HQf?=
 =?us-ascii?Q?op0Va+z2xbEh/7KlGZlgy++2mxYCl3eb4s7lSm3daBoXJJTfFC3ZMkCs8y8z?=
 =?us-ascii?Q?0rZnpO7dqiiyXB/WPZI6LYsnKrGUGlMIGj0Uq3g1oaOPz6wMxdTGJd91Hj6N?=
 =?us-ascii?Q?JtQ2tyMV1mtuI6q2NqllXJmCzAaWEhz1s/Sf1sa8h+0PJm6GU/c8B1rgkkAh?=
 =?us-ascii?Q?xEhtSMNYgz1fI7VoIKiAj9a30SAzt9s/NIR1nAfG/FJyZPjjUnGpoA7dCiN4?=
 =?us-ascii?Q?Otignxn6pQnwVWLO3le3JSNiK94Jl6ciChQjCJlbUKiY91sERUZxMCG89sKu?=
 =?us-ascii?Q?gjc5jynlvUuJBaM0SwgKrefZix3zrmQuwxBFYC+KO8n5bk1nGgUk5+QArlA0?=
 =?us-ascii?Q?/rw9lL7XdQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8661dd14-2117-40da-a396-08de7aabe9a5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 11:39:51.3731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+hgPKY2yXF5maJ1O6NiDJ6C+S4XSmYWaoL9Cf1G53OEMvjEijlFN1oVvw/3LMGynN5IVJ1g645/aiGAhux71w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7899
X-Rspamd-Queue-Id: E53F1210B99
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264324-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,cumulusnetworks.com,fomichev.me,nvidia.com,kernel.org,blackwall.org,redhat.com,google.com,davemloft.net,lunn.ch,gmail.com];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.de:email]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 01:03:56PM +0100, Fernando Fernandez Mancera wrote:
> When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never
> initialized because inet6_init() exits before ndisc_init() is called
> which initializes it. Then, if neigh_suppress is enabled and an ICMPv6
> Neighbor Discovery packet reaches the bridge, br_do_suppress_nd() will
> dereference ipv6_stub->nd_tbl which is NULL, passing it to
> neigh_lookup(). This causes a kernel NULL pointer dereference.
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000268
>  Oops: 0000 [#1] PREEMPT SMP NOPTI
>  [...]
>  RIP: 0010:neigh_lookup+0x16/0xe0
>  [...]
>  Call Trace:
>   <IRQ>
>   ? neigh_lookup+0x16/0xe0
>   br_do_suppress_nd+0x160/0x290 [bridge]
>   br_handle_frame_finish+0x500/0x620 [bridge]
>   br_handle_frame+0x353/0x440 [bridge]
>   __netif_receive_skb_core.constprop.0+0x298/0x1110
>   __netif_receive_skb_one_core+0x3d/0xa0
>   process_backlog+0xa0/0x140
>   __napi_poll+0x2c/0x170
>   net_rx_action+0x2c4/0x3a0
>   handle_softirqs+0xd0/0x270
>   do_softirq+0x3f/0x60
> 
> Fix this by replacing IS_ENABLED(IPV6) call with ipv6_mod_enabled() in
> the callers. This is in essence disabling NS/NA suppression when IPv6 is
> disabled.
> 
> Fixes: ed842faeb2bd ("bridge: suppress nd pkts on BR_NEIGH_SUPPRESS ports")
> Reported-by: Guruprasad C P <gurucp2005@gmail.com>
> Closes: https://lore.kernel.org/netdev/CAHXs0ORzd62QOG-Fttqa2Cx_A_VFp=utE2H2VTX5nqfgs7LDxQ@mail.gmail.com/
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

I assume you will remove ipv6_stub from the bridge in net-next

