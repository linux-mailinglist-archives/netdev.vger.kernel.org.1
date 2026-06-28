Return-Path: <netdev+bounces-302410-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6+DqBKFeQWpwoQkAu9opvQ
	(envelope-from <netdev+bounces-302410-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 19:49:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFFC6D493E
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 19:49:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=YKJnCG7a;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302410-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302410-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B01E300D841
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 17:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E10A2F8E87;
	Sun, 28 Jun 2026 17:49:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011052.outbound.protection.outlook.com [52.101.62.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD28E13A244;
	Sun, 28 Jun 2026 17:49:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782668957; cv=fail; b=asB861wq5ys2ist+pIePwUoLmEAMO+DGL6suYT4HEslnkLDdhXiW7K73clJt80Vq9XGJ0g9B0vuLsH8bF5GFDFNk1ii7UeW9htNJUjpHcW9+oDcptGZDTYM2HvgBDjuENzGfX821Twj/ehTpDSNyqhPKHcQppBiEYUCgmD9u+6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782668957; c=relaxed/simple;
	bh=a+jhvqT8PyWrcmeDT0YXSH2aQXeq4C60+aQfyaXHmzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mpg5O4S9TTM/hrrxo9+XOrDW0IDNr37dnKsRV24ZFmpg66MH0P4tKaxprP9d5IBiQOkAW4WeJ96b/3uoxY0lWLYe4y8/tGwF3yggZk8cYm+Dlpa4k4of4nFeg+UGWCg4+y3xP3WbqUXKKRglqaZf34/JU9k4oRFC4R6E2oTfx6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YKJnCG7a; arc=fail smtp.client-ip=52.101.62.52
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+RwvinnXfsPKBwZqaTD1w4+qrZBgMOOOx2IZiSu0tfPR7NTcXZtogQYegYFm6fmaeq2S7IbyDBfSdFf7KX+A8Sk8kS1GGYP7Vz8/8e78F+FpMUZLRD7DR6C6qz0QC4ltI03dKW+fEp0pevKne2ZY5J8HUlqsUtSFYPfrM/i4C06lH3darXa9JhiwOifllkQm4ZlT4ror9CpceS87y9nZBnTQhiDonbGrq1pBZ5VArw5MPDtjVjNy9V0PbNEyherNj3SHbImo9npDI0RO7sqCtC8dG9xMI9gVguxldxzclJJX4hflhRdOPbEG/+RUrw5Et8J/s9kE2h9HiZah8HBsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r952Rk/O2IWA6RVaPycRmJaOEsCWo0daVm9jEyqBcRU=;
 b=JuwMfiaoqZU/ay9MFrcafTqW9IJ2EoMNC4m5T/7/ZTzKtsyrJz+2lJKQdIk0LV2YFrDOMD+NmLwifQslg6ty2ZTU5XDOpDigimVS/Dpm8m1aiGf5OHvQD4DkhgX3UN3nB63myj2cHNYJ4wNIVd+qkN7CDhjDUXJVO/qbmhI+LA6Xh7NtbjJOQobEawBZeXr0bJHazS3wbPmggbSpP75hvrJ7GurkuDOrf554+hcpnzovW3SVjYd9yjvGLIxpzjaucYefKp3oJhhdJKn0QTCeHCFbUNZHflKKJT/j43wVxkotu5ay+lby6Gm0pyeMeC5VBMPN5TZm0I5TKzTkNmV73Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r952Rk/O2IWA6RVaPycRmJaOEsCWo0daVm9jEyqBcRU=;
 b=YKJnCG7aFT2jlc+g6/vS8bPHL9NDFMWW+/A8uekhzG6SJQ+gZGP4G/9G5+MBjguqxV1Eyopt9+gmlPRXPzPWNCg6NTPMUHqn77p0tOrb7feIUUUxg+4HCo5BunrU0aUZ30Ux7+O9qtWJXYvpFq69rI3yeIt0vLSQlyaAn1dFo6WggS6KWOuwAGYzwQOnhFX163WhW7HRJza1zr+3JpG0Zan9rf3ep/4oYcSZdLmwDccj3HdijMpdxDsJfUrx1AMr4pHzX0qRkcoA4lEzXgFCQ8HFro/x0scl/gf4YAaLd/Gu8tbOUeilQz6XFGlYmHUW0W0LD8vGTqApl+9O5b5Bxg==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH3PR12MB9026.namprd12.prod.outlook.com (2603:10b6:610:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Sun, 28 Jun
 2026 17:49:11 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0159.018; Sun, 28 Jun 2026
 17:49:11 +0000
Date: Sun, 28 Jun 2026 20:49:00 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: Re: Question: bridge: clarify MST VLAN list RCU traversal contract
Message-ID: <20260628174900.GA400397@shredder>
References: <20260627132539.3701630-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627132539.3701630-1-runyu.xiao@seu.edu.cn>
X-ClientProxiedBy: TLZP290CA0006.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH3PR12MB9026:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b4e9937-b50e-439b-b67c-08ded53d8f7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|18002099003|22082099003|11063799006|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	huLcn9RUOkwORAG8ly7T479G/Yxcaqky9NuAhUWn2e7BUyGscW7C/yT44u4an4RufkJlCPOL7m5/S0sftBDdTQXXi7Y1RUggVtSU2oBRghGMS9TSWX1MjENdLWterI3y2q4NksMcN2xr+GvVCLmaXpf4jEwZG1YGKMkeGzmvUweiubDxclHzJo162UvK8MvSfP3OwSQtIhUoc70K3gZD/8LzsWYIrKi9GffI+DTuTxLZ6N8Gm1/ZA2fTgpmPpepuJjQC6P4MJpR/Ug9Czd0v+Dk4J5s4sob9EWHPKg245wBeDqKa/mtoWgxgo0w/800LduTKVzpOosV5o78lnLZ21+jSaxhkuAyHcF0yDAj5GmQsZr9wjptBNXz319k2EyNzeMEsNVcyCYktgRTQS877eOXnIsyp6JamDPmv9sAf3s2l0N2DxIXJw4JCqC//haHOBdElcMnffS6zGKHGxK+zErSVrlTGxfm4x75XuFsozEwPS0GugSMi25XTxF3IWZyJtobeKJ3KtYm+aDd9mI8UCq9cfQnt1/30K0VRX0DZldrkgkC05XqMHdDnxgzzmNs760X859RJsDHtX0vS77pDQsVmzCIzuJPzpwsyHuXE0ml0mjhJNJ2j1WSW+f79eZ/QzBquD5LYHcOvdBG9ln3vtGFAK3757N9WBMva2+VRVK8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kW7TcSk50SIjFQLeTag0Qt5XjxxrxbFO9IvrRmdv/OyMWWV1G/cIzgIYODva?=
 =?us-ascii?Q?5FRFFPme7X5a6Um5Ah8/VjaNwk9ppwfqaQvqU4OwiWv8aEB6TKz5YPQIfw8N?=
 =?us-ascii?Q?mjUknMa5GZjVYCJHEhLKjEBcY7lfYYwxk20WghA8B5tHtdiQdI3TOWYltsyo?=
 =?us-ascii?Q?+AdFvd3wYS0sSdG45dEOEWNLqf8Prn+4wn8QaSQO6jjQswN2PdhRwQmy7Skv?=
 =?us-ascii?Q?sEnTuOPzRCYlHUyeG1DTO0v56TydltqsKbs/V7yAorYHsuppXVAmanoNGCFa?=
 =?us-ascii?Q?JgdtlvtkVwojqBeU12DfmqY5e/EIaY+fPcgDRLsOa9nAzHPVpZqqQa8BJ+ud?=
 =?us-ascii?Q?QNYAzuKL2Ss6JIhYBFKHWiLe74JXhNkCkHXjw2JINdzFI6CT6FYYKUpYLPY4?=
 =?us-ascii?Q?r7owIgSQ7Q1ucl1qc27VguisA+ZGAYG2maCHd9z0pBVfqQMpzK/cSkRuPaQo?=
 =?us-ascii?Q?cQrJyuvNLtK9rMXFQZsPVWvsu7pwguqDngZU5xnVJhba2Q4Xt3NnklA30mrg?=
 =?us-ascii?Q?HS8cwWRraSuNm1s8QRiXBzB/Zrkd20x8ayHln8rSRJZxGdeB9+N+z7dcMvBV?=
 =?us-ascii?Q?e0EU/nDvSmU2y3/n4iUNl1yLmu9PfON4fvcav26cT8GqbP8o1zDGX9ljJg6d?=
 =?us-ascii?Q?51+617G+rTqyii3emihCD0rfh2lgpHgvpgSkEwQ6wUuUxHIIOY11f4/O822u?=
 =?us-ascii?Q?QhDgUQrba4fitLwRhD53JbNDtnXsHQXj9Lb5qaCxDZme6YE9JGmhvbfKkNFc?=
 =?us-ascii?Q?D/INKHPcDBdOWJ8mt/7JsluX//I9tTNYXq60chiwxkE4iGjQoAUKp97Wf0wb?=
 =?us-ascii?Q?fHLa3K/pCu/M/EYseWsYyIEr3wm7cGu8G08guKjARbxkOEHBYMf8cMpJQvcj?=
 =?us-ascii?Q?Ns6Mwp4BlgtsPHpFbttqXh73q3dGT+iMvXxYAUpX5Vo1zPxOGacYxg4TTqCw?=
 =?us-ascii?Q?3RLXx6LjY/+f/1A+jD0KJpNgeIylWP48vh+jKPbIcUCSM8UzNHxTXTOmQGXY?=
 =?us-ascii?Q?HkvJ7wa1eefv5S3wvmjQie6LP+SgPZb8dSdtX4oJXlnPTb3648HnD50KBu+S?=
 =?us-ascii?Q?H198Xc3bhOWh9BkpEStFCXVEmrFs3+Y7BBKQ+rheoh+FXbMaMZQLSikdUArj?=
 =?us-ascii?Q?O10u5nd5SjEFpNHPTs+d5RB7/TeTRjkoRN0wO1BspKA2MnUk1NBshWuhxDCe?=
 =?us-ascii?Q?gPiI2UB9cFVpXdEaDyUvKQx4RyE56VFp0+QnMpYE+hc/ScRBKtaRbR92zwBf?=
 =?us-ascii?Q?NAIHNuP8N+TP5kVoOXeIVM2QjE8yZaA8bbJ7Y9iuhwBkI//mWMK0CEfHOx5Y?=
 =?us-ascii?Q?8lcwWGVyOizEjjEBahxbuLWMvu4k6iDzNo6Y5jpYFmPhY8N9tZYI5gEK5k/U?=
 =?us-ascii?Q?tgA0vUy7xMrzulqxdeT3OC3YoTtROgxPlQaJ39NFdWZj7SGkg4rMDXACx0pq?=
 =?us-ascii?Q?SCyneebS1PBs/VvYw+l4Q4B9HsceVlAeFEHhPqzSzPQMxm84CK/fbnHtcH2c?=
 =?us-ascii?Q?5rRwGPf+MRsPdB6Xin1r/soU+/0cdVNtXNcTIfFznr7K/meKIDsDJt+cTwIq?=
 =?us-ascii?Q?YeJmx4YVAar1P5CriQazAW1uhE0hq5ZYj/P9GdRv3IWdzuyHnLoNEUlBviFm?=
 =?us-ascii?Q?7EJZ8yrZHnv2Buwnbiil+1RJdwTeEYTBkKHGcEC3iq1L6TNFTRZjrEqsuH/H?=
 =?us-ascii?Q?xVft1Zt6RzQ4OqmdrLScBekdu9jC7spygWk3Ekncn0ORrDqQmymas4NnRZYs?=
 =?us-ascii?Q?R2WSQgVzLw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4e9937-b50e-439b-b67c-08ded53d8f7a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2026 17:49:11.2000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bzx4n7UbNQfcO0QSag/JsvOnUvNAE4rtxcLFR49HTanwo7oqI23t2DRz1tJ8BHMTUM9uv9JYbpwq8DQFMMFBOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9026
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302410-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:razor@blackwall.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bridge@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:from_mime,vger.kernel.org:from_smtp,shredder:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4CFFC6D493E

On Sat, Jun 27, 2026 at 09:25:39PM +0800, Runyu Xiao wrote:
> Hi bridge maintainers,
> 
> This question comes from a candidate found by our static analysis tool
> and then manually reviewed against the current tree. The audit used
> CONFIG_PROVE_RCU_LIST as target-matched triage evidence; I am asking
> for maintainer guidance because the source-level review did not prove
> a use-after-free.
> 
> A CONFIG_PROVE_RCU_LIST audit flags the VLAN-list traversal in
> br_mst_info_size():
> 
>   net/bridge/br_mst.c:251 br_mst_info_size()
> 
> The helper walks vg->vlan_list with list_for_each_entry_rcu().  In the
> direct local context, br_get_link_af_size_filtered() first enters an
> RCU read-side section, resolves the bridge port or bridge VLAN group,
> and calls br_get_num_vlan_infos(vg, filter_mask).  That local RCU
> read-side section is then dropped before the later MST sizing call:
> 
>   net/bridge/br_netlink.c:104 rcu_read_lock()
>   net/bridge/br_netlink.c:113 br_get_num_vlan_infos(vg, filter_mask)
>   net/bridge/br_netlink.c:114 rcu_read_unlock()
>   net/bridge/br_netlink.c:123 br_mst_info_size(vg)
> 
> The helper is registered through rtnl_af_ops.get_link_af_size, and
> bridge VLAN updates appear RTNL-centered, so the broader rtnetlink
> sizing path may already provide the intended serialization.  I am not
> claiming a use-after-free here.  The question is only whether the
> RCU-list traversal contract around br_mst_info_size() should be made
> explicit enough for CONFIG_PROVE_RCU_LIST to see it.
> 
> Would you prefer one of these directions?
> 
>   1. keep the MST sizing loop inside an explicit rcu_read_lock() in
>      br_get_link_af_size_filtered();
> 
>   2. pass a confirmed RTNL lockdep condition to the iterator in
>      br_mst_info_size();
> 
>   3. document that the outer rtnetlink sizing path is the required
>      protection and leave the helper unchanged;
> 
>   4. use a different bridge-specific pattern.
> 
> I am intentionally sending this as a maintainer question rather than a
> patch because the right contract seems to depend on the bridge/rtnetlink
> caller semantics.

I don't think anything needs to change. AFAICT, br_mst_info_size() is
only reachable via the get_link_af_size() callback and
rtnl_link_get_af_size() always invokes it from an RCU read-side critical
section.

Did you see a splat with CONFIG_PROVE_RCU_LIST?

