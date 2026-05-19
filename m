Return-Path: <netdev+bounces-289316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IO3sMuUaDGpJWQUAu9opvQ
	(envelope-from <netdev+bounces-289316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:10:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42264579B51
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FDE6311723D
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEA62F1FDF;
	Tue, 19 May 2026 08:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hzyuf2Lf"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011058.outbound.protection.outlook.com [40.93.194.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23B23D9025
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 08:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177681; cv=fail; b=gVf/aGAXjWdprnV4y1rLsxuodCtgVQ5c9qwS7E5YfogWO5xn6zrKu8P2iixCH0A353tFpjMw623+Wm3cXmSccGsjIPJKOZBPHY5+tE9sWT8g8vkTYWMJhSjs6kyNA8q2KddMs5Ig7VO/G0OQHo6KelMfyulYTuqd8AVyUpdpI94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177681; c=relaxed/simple;
	bh=rzdZpGUX0QO7zO3faRRw2NyZlcPq8Xjrb69O8ZCtEvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TAGIGk2Wm+C9JM+KTmTKtwGP88ncxdER0LysOLmeMACKBORjD/YbimiQ+9cobGV56izw8rFSo3X4PX59ZwbTETcKbPGYrPO6vMxgOW6MPFmq6VzUowVjsCZ0UuVZd+jA5s/WxmGkGPlR0EgoVrRKVFqHl2S/RH30IO+yxrOl/Fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hzyuf2Lf; arc=fail smtp.client-ip=40.93.194.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wvdQsuZXlVtzvbumOrG+QPjjPoBi4NHQlGnuo1qfR3WepVyM4jk7cvofdDnaAxIGY8Sd+G8DP+iQsM9dz/GPdD30DkvX+jlr37txGAvM7qzZF9sW/SI+golJxXHv00btY6U3Lqz/YWA9EiGK0HAcG5tkzidC3H0ODRg0BdqAtTJ6KD7yQYIN1IDclSQf2LBx/Qbr/3K13jWOf2gLV3k5be1GhrgGoPceiksivGTgO+dQfGIN7tjrRcS/ijEBC6cTwA3rwu/iJCd9RA5dRdoZhKmgCS5cHB4QUUCPOco5ySrKoNTolqjhQCmcbTUiEg887RZDNgq/XVR4SMFCNapjkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPD18we6SiwDCr7RqlhL7PASj72UJ2Sw9m6ZmreZYw0=;
 b=K8MXvgITj2wt+mRoyvCRA4nHX8wm1PY3sSvaKjxVMSrQen+PVr4wvfj780RUf5l5beznPocr5L9r/DX2TO8XAFMVsuNse4bP/Q+8fDBQkIBdgTXFfoMx7dpy0wyAsEIw1K3K6xxhLrevlQNRZi/bFYgJev9UsKekMUPC36h5PD/XcvqAC11w7+Dh58BD1JqBAmaBUsv1n7nrEaEhNZ+5TSFeI9IuPsR5UjBW1Qj2Vur79oZw7joex8Wz1scAXmdQO0Cc2/mMm39HN/DRa7T0/XFoue/VMkdrasH+qAfMkGr9AYy7L112ws68MKBWvbjrREBtHJ9dN+mFl4M4ulD/mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPD18we6SiwDCr7RqlhL7PASj72UJ2Sw9m6ZmreZYw0=;
 b=hzyuf2Lf16hSNp3f0MRes3Z+8WGT3hNucUXpmtVcfLIx1ql/OPTn9dzkny9/jii3Lg0Ud4svHkpinFdMGRsqQ2hdfLu4yqHD+FLaCAGtinuOZcxmfzcDmVWq5w2mR/cFp3zdmU0d7lSzUR8g8WLR68ooMyGyx882zwKKBxShs/Vjq5uy2XjrQ1MwC28pIWrfZlfAQ4NTTT17FN7ajNWKPPZ+kO301oCNAnMrkomR7cgc15NMV4ANqAM5TCESGFpHU5uCLt5/67dGfCz4n7y5lcz+nJwLhp8m6OGTthLXNo9uRrj2FzmseSasaJaEEVIZD3h25eFqIXyg0/aGP1H2rA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MN0PR12MB5786.namprd12.prod.outlook.com (2603:10b6:208:375::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Tue, 19 May
 2026 08:01:16 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 08:01:16 +0000
Date: Tue, 19 May 2026 11:01:04 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org, bridge@lists.linux.dev
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, razor@blackwall.org, horms@kernel.org
Subject: Re: [PATCH net-next] bridge: Add missing READ_ONCE() annotations
 around FDB destination port
Message-ID: <20260519080104.GA382551@shredder>
References: <20260517115009.175163-1-idosch@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517115009.175163-1-idosch@nvidia.com>
X-ClientProxiedBy: TL2P290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::9)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MN0PR12MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: dbfb2323-3516-40d4-66b0-08deb57ccdad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|11063799003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HwHWYk9Bw6nXC8liPFifGbLnEAwY8rBqibUnzTEb2w9v2l8Q3Ki2LcvpG7lISkNIzHHEWC95AuP67t/y/FYpZgXo9UBS4ZDdiZqoJylglWk7bfw+vNF8Qt6O/+rHCZ4znr4HmAJPZabdKweQlgWQbLFHZLyi3/lNFASqo6gZfSyh0wxHYwsad1qZkYsPpzjv0zMe2bEMXZU3d+aTponJ1mcymswY53M98r9q7JcBPjJPRfzeTDcRuNLuOJ5Frh3SoMOZfRlCTC7Z+8PgoDgAAW2lN4UOv6tua4D98X7BUPhq5BTDjE8FlrLd9gxs0MnudrXbYdFWCA97usmDSghUUThDC8IrdqUANyweMcizhsLRCgf0cGrRz1Ii+nIQCENACRiEORMpUaf3u3rQssSB8JInpyUE4qtixSPOZO0n7VhIjtoekDViNK3CmFzWiD1/phZeurn5Ctojv0fyq/k9+fo8pmc7qY49tmu3p38k04a5+kU2uzDSmB/8lPRxbVZUaxCQvGmaafyswV6fjs1hivLffx+lT/TaahARleAKDQIZ/yrji69uk8yNZ8htUZlhaL030UbvQMTkxDcJH1leFJ2xmY10fZgLVOqnN9enevd3p6/b06+sqQHIf0/yGISe4G5DurrVe+M62pC7ujIeQJcTg2FFDaxOdERb/r+y6PEtjYUogxvI7DAyI+aOX2Gv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(11063799003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XPKTyrzytAvKC/iVnkv6qD9s45INPU+kDzm9ScsiwAPqO0HpRZ0Ff5oateX6?=
 =?us-ascii?Q?lmycgDvg59gBino6yXE4RlYwL1SSVF0Kf7CXe+zg7hDoFmiXXnlyFIEtH8BY?=
 =?us-ascii?Q?jufERMTGSEjDu4X/7OgKRF68cvDREgw9XozgDvGEPuMX7xcaZOuKanPizRKr?=
 =?us-ascii?Q?e//sJSoDb5S2yZx8tktvcMzNTp/xuV7EmxAESUuR5Xr5cEIChV+SD81B7jR1?=
 =?us-ascii?Q?IrI6i/MYWAMvds1AFbC60REJbVc0yCpFHSUwhi6n9+tLRsg2yFX6l0U+iDdF?=
 =?us-ascii?Q?fM2XBpO0gOq0yNBGPzK3E1Xk14vJmqZVkBnr3Rbzqfnc2UjyVy3u7Kzz5yDs?=
 =?us-ascii?Q?n2ui0l1cIqSO4zRWpSF/DKaNlf+jeMGGss25uuLmbkEGt9zbM7Wsac6TG54i?=
 =?us-ascii?Q?qPz1+JyxcMJmBj/0bebNSoDLgRn/K+Qmh735QDq4ApMDX4DbeMaQJHyOtFS/?=
 =?us-ascii?Q?XyZp4tJn51sfOlJf7kjPbbSo2yP/rDDxvP4ZfToqIfdCYT6oVFYwnGl7WA8Q?=
 =?us-ascii?Q?LiDnXGg8yaM6+ZFY8ya2zT3F2dG6QoAcLt7V1MnFa81DrvnE6onzefI6R1ox?=
 =?us-ascii?Q?ts+PO0qM/7tS0LN3pRqoy7PaBLxTjGIFRZ6PHt9hMFMxYEsDZuVq++5GLzYr?=
 =?us-ascii?Q?pkyT98XBO9tyvOgtKaQesJJMhqWXaAo6YjP3P4kfuN7bYAJyuqHbJxis8AGy?=
 =?us-ascii?Q?gQbaeHkjrSnOs6tYc9zhRwzw+G+qg7F7a4+kt5Bv6yyJxnOuZSKvT0fY+R9k?=
 =?us-ascii?Q?aTwsEzIVxt6GXtuHAYR72PoJRrieOB7SXCx8INhl3BO6q3ls/LfC2449p94r?=
 =?us-ascii?Q?xcepa1hgXLVnpE3hIp8ffkCgt2bxgpc99OUyqKCgHiu37d4qSDZ0jIIoaint?=
 =?us-ascii?Q?pL0DMfmYk0BiNW2oi1nVR5vlq1qubsCseYy1Hhtuestq91t9u0tPg5mQ8cvM?=
 =?us-ascii?Q?Cm/XtskLmJHoxkzrCgu4XSJgILR8iUc92N7KqqSy6fDfk382XZoWfDmYvKBZ?=
 =?us-ascii?Q?lCvRTJasKWTr8+bsVgsaFNSAj46dNM7NYY1fidWtMqrgIUABmT1iKFeJbZoi?=
 =?us-ascii?Q?6V91eF2JVmBUvmArFvZctkfXNvfChZH5OLU/Yh4Y13f8h56BKuBpO5QpMblp?=
 =?us-ascii?Q?3NVNT0DiWsXMkoIdLvng1A5IZk0HJMxtRlAaaRvjTBAnD80dGucNPJX1A/kc?=
 =?us-ascii?Q?v1eP7ZDXexzZNk1ixo12/n5L720PS5BKa8SHvTVlEUhonSd0dQ8CyVS/3Mim?=
 =?us-ascii?Q?74ViIrSpEjiHDuuxDASnftz/9M+EaokQM7zSMZLNmd7VuqTz03K8OwPPpCh4?=
 =?us-ascii?Q?r9483Q74kw7KIFl66wgb4k9CNLuIURtKBZNcRbIjTeonfS4r0hb8+aWnI6g8?=
 =?us-ascii?Q?8/5tJedSOi7Q7fW8ODRDGgvfJU3wZ8LO3ssTFRqcb2DkeBmPp47hhYcdsC9n?=
 =?us-ascii?Q?9PkUWwS6KmG+gspMWp+uu6MD4lvQ3wkbjrdEjsuTd2lN38v9DE7UjV7lu5X/?=
 =?us-ascii?Q?59BN7UWgv6RBS2pAGw2fP0NlTelP688j+r29AtwIHZv9su108RDVJT+2df8T?=
 =?us-ascii?Q?ZZwJlXfzaQprJ4KKCsU4GcFtsiX6FQuS63LeGEguYB+axE402dSEgHpmE0Ez?=
 =?us-ascii?Q?p1GFSBSubrdT/Wfa+w+OJcau97XkK3CibbAdNeR4NiS6Z0PbMLRV4KB41U8I?=
 =?us-ascii?Q?TAR0lrR1EMUhzjmfkJKzXwrOVjyvYLtJTNRdxUzV/Q+BIhdG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbfb2323-3516-40d4-66b0-08deb57ccdad
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 08:01:16.5761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v8tU18AoG08X3eio+bt+j2wR5r2tocCCv0/qTbsNrkOLk3ZFgRQ7BXXV5DdsaWA/tJld37mQEMJmXc1DUyocfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5786
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289316-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 42264579B51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 17, 2026 at 02:50:09PM +0300, Ido Schimmel wrote:
> When roaming, the FDB destination port can change without holding the
> bridge's hash lock. Therefore, add missing READ_ONCE() annotations in
> both RCU readers and readers that hold the lock. In the latter case, the
> annotation is not needed in places where the FDB entry was already
> validated to be a local entry since such entries cannot roam.
> 
> Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_device.c | 2 +-
>  net/bridge/br_fdb.c    | 7 ++++---
>  net/bridge/br_input.c  | 2 +-
>  3 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
> index a35ceae0a6f2..e7f343ab22d3 100644
> --- a/net/bridge/br_device.c
> +++ b/net/bridge/br_device.c
> @@ -107,7 +107,7 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
>  		else
>  			br_flood(br, skb, BR_PKT_MULTICAST, false, true, vid);
>  	} else if ((dst = br_fdb_find_rcu(br, dest, vid)) != NULL) {
> -		br_forward(dst->dst, skb, false, true);
> +		br_forward(READ_ONCE(dst->dst), skb, false, true);

Sashiko complains about a race condition between br_fdb_update() and
del_nbp(), but it's a pre-existing issue. I will add it to my list.

>  	} else {
>  		br_flood(br, skb, BR_PKT_UNICAST, false, true, vid);
>  	}
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index ac81e58d5f70..a114373c9816 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -470,7 +470,8 @@ void br_fdb_changeaddr(struct net_bridge_port *p, const unsigned char *newaddr)
>  	spin_lock_bh(&br->hash_lock);
>  	vg = nbp_vlan_group(p);
>  	hlist_for_each_entry(f, &br->fdb_list, fdb_node) {

Sashiko complains that this needs to be hlist_for_each_entry_safe() for
PREEMPT_RT kernels, but I am not sure it's correct and it's not a
problem that was introduced by this patch:

"
Does this loop need to use hlist_for_each_entry_safe()?

If fdb_delete_local() unlinks f and the loop continues, the loop will
dereference f->fdb_node.next. Because spin_lock_bh() is a sleepable lock on
PREEMPT_RT and does not disable preemption, an RCU grace period could complete
concurrently.

Could this result in f being freed before the loop attempts to read its next
pointer, leading to a use-after-free?
"

AFAICT, on PREEMPT_RT spin_lock_bh() calls local_bh_disable() which
calls rcu_read_lock(), so I don't see how an RCU grace period can pass.

> -		if (f->dst == p && test_bit(BR_FDB_LOCAL, &f->flags) &&
> +		if (READ_ONCE(f->dst) == p &&
> +		    test_bit(BR_FDB_LOCAL, &f->flags) &&
>  		    !test_bit(BR_FDB_ADDED_BY_USER, &f->flags)) {
>  			/* delete old one */
>  			fdb_delete_local(br, p, f);

