Return-Path: <netdev+bounces-307424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kQLXBB0UVmqAywAAu9opvQ
	(envelope-from <netdev+bounces-307424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 12:49:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B35D75390D
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 12:49:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=L8Yjz5um;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307424-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307424-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 100FB3014678
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 10:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A1F37475E;
	Tue, 14 Jul 2026 10:44:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010041.outbound.protection.outlook.com [40.93.198.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29453363C60;
	Tue, 14 Jul 2026 10:44:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025886; cv=fail; b=Bo9X/08gggZ43wgIpxirEzDcPo45y8d4uUQVRz+4sFAhsCTPolvZQjOJgmLYYYGsZoltPc7st74TyJ64mnw1OVtsQgYNcy4tLzhqTGchTzH5sCLq+qWlxwF+Fxd8REgpT6jMfvRX2wv7awUskvEvPB/02DiKgvuOVXlhorDhlMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025886; c=relaxed/simple;
	bh=zcSNU6Xt187CILa2/m8AB1r9LDc0YzWZkPvtsXij0QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mznFtvS6BaurTjrbKfNc9T7gk74eEAI8W+zludL2CcYeU8tGZsnbIRL1tPm/vLZ+jMHMAnRLXLYYdsez2wMBrWYwvc3AV1F2gDADyaV+XACIWWv/611O64894hkEDkehXe2OW+2Cr0PqwVw1/x4Kn6wd81HxnOScjDeBHe2RvjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L8Yjz5um; arc=fail smtp.client-ip=40.93.198.41
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eR2iWkleDMXBmubqwv/BpnH68tBPs0uecRs37/lktLCW0/D2Ml+sB31kJVobhYx27pbXI5dcpv8HvtYfZpyDBUs+7RNpN9+8hPZe7QaWOEzRHaV6MMFYE9Ejs3XecXemVA4RSYdYk0CNbhVOGSe629viAS6cK123hEKfEJJISfukqlpzsZfAT1w/S47EAH0fL09SS90rX/vQpnFYjVHrPGTTn0ZxK85s7Hw1lKBgxDrKmkzXEDgzgdD6VjND8iT4ax8D5Qqm2ML8R96FeicqC+4MkR9ePm6STcakwvBQRCcjgSKXVfuLTW8ecVrV9+xCgSgXKQKZEi8WgfhCaM8kyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9s+LVRIcP5vDiFzb4EgcJNNN58XjTWFU+XktR4ZaFys=;
 b=twkZa5WqumkdlrK8rm00X3Rm/IZp8wbOWR4VsCQF4G0RZjCDpfvxGNm8pK+2MoYJ2USkPh5jvAIXUGpVSkSFjDASWwO6ayF47ckiAf8DYZEBWZMDwWYLMWJVBqMO1wO42vdcxONcUT7ibANhqBTnnFBVK9fid1zhwjapjK4Ej1q5VNxNgpAhiK6rylK1sRcWrYxvv7WnGlI5WSz1DboVyhYXzLjEiUbq1Jm2RKgU5Axf3/SnIqE8SrkwywXZcq2/m0Bltc/nehbMgiFQNhpEUUyMso0EZRYBnuvCf4FK79vm6KxDIUxJabTSSJwQJ4Xv5NUMvb9lrgk+GHhXAVUoqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9s+LVRIcP5vDiFzb4EgcJNNN58XjTWFU+XktR4ZaFys=;
 b=L8Yjz5um4RqNcrrgY+j4XmmGN9Ns2Vr8H7NtHuVoQsL3Oukv974tdWvI4z2bF/R4RtVZj4QVfl2FZwbDT1GuegHgZaGjJzb6ihZjUZqsHYsUVv9pDgu3zc8eeMUkauaUwP85Ohfui/akBxsiCdXlO9KeJKvXwB+HZV85zF086zfRFgB6HgHaUrMAz6ZZ5vGMlUyCfd09aR0kJ1OyMa41xmkTwZ5BGrtwiSkZ+s+LyHPfAqwvT4CRpog6A6iGk6d/YKIg3j/by21zzpunQUhKnPfy0PNnffCfOiJ89M4Lg4QcseHHjq7gtQb0net5qSUZ0VGnitiJsWptjJTM5zbVpg==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BL3PR12MB6619.namprd12.prod.outlook.com (2603:10b6:208:38e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 10:44:41 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 10:44:40 +0000
Date: Tue, 14 Jul 2026 13:44:28 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Petr Machata <petrm@nvidia.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
	kys@microsoft.com
Subject: Re: [PATCH net] nexthop: initialize extack in nh_res_bucket_migrate()
Message-ID: <20260714104428.GA838500@shredder>
References: <20260713221551.3344650-1-xmei5@asu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713221551.3344650-1-xmei5@asu.edu>
X-ClientProxiedBy: FR4P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BL3PR12MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 5311f34c-7800-44b5-f7be-08dee194e87e
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	NOkeryTGdio1rwrmI1wciEmIM+5x8NHCsvT+DMhW0ccMee9tzADz+ik6bEkK74pKsRIWCozr2YNOD+0zD2t0iOVW2nMNleJN3giMQoWJGt8/MG18fWafJQl43kJ3cS2vuV2I772PGE6ORpw7LlWRxJiRRxL8RuasnZmxigeITYWglqvA19RnHaeZXGLXoXWs+elCR65mMnFWOd9B5BTNgCSYGU8fcb2ceP7dHkvYOQuKEe/aYiBzoh+fkGhjv51AUWQ28ITLWj1D9DZS1GlXTd67f6QGzPWwzjHcXTpAm4+CowS59GPv6EY5XyX7/1G3KJgwtVfvuCtce8VZv1NpSKGhoN7zr1LEYGB2MB1rR1x5p5k/PaFCWxRWiRHSi1zAMDq6b5chRDukNPi+osRjaHc7F6dMRUY8Q0CmGx2gxILXeMZOapLHf766u9g0qJghC4k+5FJjVsuuqvGVSrpDl4G8d+Uh8AVvey1mJuOfEUIW1xBjpJBRJpxDlYfpBPBpiMEEDKZOH78mPjGCCxOfGgrGxJr/DCLajwd2qam96lr43vfGF1JD56u0D0taoIrpe1/hTY/sTo4byVyzTxllvgYbmp1oaRybROhwSJTT56rXagwLc/flIBvLTu51cN2PKaIbUyxQZHMerVm6ugZPxfBhjqXdXL3ke1OuK5nj1PY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S0Y1snOctTkZr2RkjoR5OabW8pp8LEjXe2Tod33m356l9aZN2RRTS7q8DQAE?=
 =?us-ascii?Q?+tOavbh3H2PIw+ln1nZtjSiyjSjV5kcgIVXhZd0L6zR78f19YFbhECXcYDTB?=
 =?us-ascii?Q?jMJp7MfzZ8r0mvyXslhwRAtWh2EwJ2rFY7FrwkRlzmLqHibPIgPEvZUflkmc?=
 =?us-ascii?Q?3VOUNslX239lYpWKBUugpD7xtCcfkexSvT7gD5DGjioLUlAgKC4Q6JUI/8oW?=
 =?us-ascii?Q?iDzFda8PSNE59l6ncVG70bedRRcOP3cT5KVGFo8YwVHsz7wET4iBbcfxGzUK?=
 =?us-ascii?Q?368+wYfsiIoLJFPeABz3605gUPU/UOl2auGTYihapT39D2nus96OsSCDOh3l?=
 =?us-ascii?Q?42z/JtSCeP4T1mLKdP759og56wfDatmg7w8GmsVPeuL3gtphbNX2Zsyp2rl5?=
 =?us-ascii?Q?PBlqdVhnwSNZn8CsJOcxowOmnsvvt5unthBU7vZrlB6Hsbn/+Ho4zoqDLFIh?=
 =?us-ascii?Q?LZQ4fjUAgNwDCjl9U+Se28koeUdKHO+qWfYmyBIviaNsCy12MxI615GoXfP+?=
 =?us-ascii?Q?uwi92QFHB0lik0lPWLOkiHFm7Jd0a9PgyWQGEOA7h0q9e1nPXeLMg3618AkH?=
 =?us-ascii?Q?bmO/HV2EOl3ZK7+qBxrYV5Y08AL7S/z9UY0WORd1QEoLL0tj+WGQzpt965s+?=
 =?us-ascii?Q?0G/YXdl91+Qp/IQBabgwOIK/TNsWabuW9uFejdbPGPyDLuetd3iEwTwfSm14?=
 =?us-ascii?Q?2meBIsy1WDGaAZfsX3IHaJDKruMrvdGXlVkwuhY0bbOJBuw+SD3VRCUaE5s7?=
 =?us-ascii?Q?JH7eWwPlAzUiejr05rXR4RQWT+6gcZMlkQRX4h3kFWDggAM9Y9XsQzGpTnta?=
 =?us-ascii?Q?Umeuq8vHajvv4h0YyHnc6Aee7fwz4nu/CRFyzw3rYToLMSS0qoDK9wx6X38V?=
 =?us-ascii?Q?bMUWE6V1oG/+uls3W4hAUwKJxhf6X6477jwcieMlLgQWOnI1gzSC7wWsM5GF?=
 =?us-ascii?Q?aQEOyEu4KZ4a9MlglhlxgvCfourGbf4vjVFIJFKhF5jxv3AfF509McTqwRFv?=
 =?us-ascii?Q?WG0+gf8anBBMLVfq0RmYTaLmwx+4BUpp2LdhYLPQ0nydiJyiLJgJFU5Qu+CJ?=
 =?us-ascii?Q?A9JXHslC2T7CDH0SwTrgWdQu021Chxzda+R/heKbi5TbrOsZBL5JEEIU4N4k?=
 =?us-ascii?Q?BEPeQ2DOL2pXLrI/0v7ruSw2DV5VyC+s+odPeAF6nI0wZObnP1GMQzlYsu1F?=
 =?us-ascii?Q?h+Khg7KOI91904tEvL/bosXY/jQtapX/RIpZ3YBPffW2njlCtA2TSDbM7EXK?=
 =?us-ascii?Q?Wn5lmUJ0TEVRb257jpKklSWNef6JZa2ptiRW0szdtThJouxLrl0yK10s8ubU?=
 =?us-ascii?Q?p59maztw171NnE8ThXBV5ZvLneWOECil3fDcnG8AagsSSx/suomHaK5Al0k9?=
 =?us-ascii?Q?Up7yKLirFeQJJ89cW1t7BrIvSWNzD7+MA597ZbA7foDrwH0yjeMUoypIpAjO?=
 =?us-ascii?Q?DLeH+tBtjvB7kbTTqOuBs64lJwG2pBkhPRQYFLMei19CFvLiwS7ULK6s2kDg?=
 =?us-ascii?Q?HhA2ltuXHah5azuC5mPNtab4i8+a9zi4PZaDheEdd6R7QSj6/DnbaocEizYD?=
 =?us-ascii?Q?5UGjbaopiPIPmj2enxXG+jscmAckn6fS1pthYQNHMfJFSDQkJb73cum2aTxn?=
 =?us-ascii?Q?bq1BJYZBy3q9Lg1T7jx09WAI8rWTxZVbT2q61siOnCwRdg1Y4heYrX5hO9j/?=
 =?us-ascii?Q?zGH/uOWz0TJh3Yttloc/eN0WvWMlRlCHjS/cBPTvRrTOBqeoOnKxYvV1r/Fr?=
 =?us-ascii?Q?EXY0hqrjpQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5311f34c-7800-44b5-f7be-08dee194e87e
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 10:44:40.8139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P44j/2OF+Qdj5CaL8DYkDif0wrfV0NX3HTCliPMP4y5W/yxjpArybhaeVDiXBBbGKmT6p+FqGrdQrlWkjGUGqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6619
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307424-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:petrm@nvidia.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,shredder:mid,asu.edu:email,nvidia.com:email,nvidia.com:from_mime,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B35D75390D

On Mon, Jul 13, 2026 at 10:15:51PM +0000, Xiang Mei (Microsoft) wrote:
> nh_res_bucket_migrate() passes an uninitialized netlink_ext_ack to
> call_nexthop_res_bucket_notifiers(). When
> nh_notifier_res_bucket_info_init() fails (e.g. the kzalloc returns
> -ENOMEM), the error is propagated back before any notifier sets
> extack._msg, and the error path formats the stale pointer with
> pr_err_ratelimited("%s\n", extack._msg). With CONFIG_INIT_STACK_NONE
> this dereferences uninitialized stack memory:
> 
>   Oops: general protection fault, probably for non-canonical address ...
>   KASAN: maybe wild-memory-access in range [...]
>   RIP: 0010:string (lib/vsprintf.c:730)
>    vsnprintf (lib/vsprintf.c:2945)
>    _printk (kernel/printk/printk.c:2504)
>    nh_res_bucket_migrate (net/ipv4/nexthop.c:1816)
>    nh_res_table_upkeep (net/ipv4/nexthop.c:1866)
>    rtm_new_nexthop (net/ipv4/nexthop.c:3323)
>    rtnetlink_rcv_msg (net/core/rtnetlink.c:7076)
>    netlink_sendmsg (net/netlink/af_netlink.c:1900)
>   Kernel panic - not syncing: Fatal exception
> 
> Zero-initialize extack so _msg is NULL on error paths that never set it.
> 
> Fixes: 7c37c7e00411 ("nexthop: Implement notifiers for resilient nexthop groups")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

It's very unlikely that nh_notifier_res_bucket_info_init() will fail. I
assume that fault injection was used.

remove_nh_grp_entry() also doesn't initialize extack, but
call_nexthop_notifiers() is using NL_SET_ERR_MSG(). Still, the same
problem can happen if a listener is returning an error without setting
extack. Please send a separate patch (targeted at net-next, no Fixes
tag) to make remove_nh_grp_entry() consistent with
nh_res_bucket_migrate().

