Return-Path: <netdev+bounces-270319-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HluVLHgmwGkTEQQAu9opvQ
	(envelope-from <netdev+bounces-270319-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 18:27:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 149E42EA2C6
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 18:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F6EC300C020
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 17:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B286136921C;
	Sun, 22 Mar 2026 17:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eQOU9P1l"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013012.outbound.protection.outlook.com [40.93.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39320327BF8;
	Sun, 22 Mar 2026 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774200437; cv=fail; b=sJIH0Bn3t6ayARpf78j7Kvekcn0ZbqDTmB6UbZf2Y6yErxXoCPO6z5oNUwRYndWzt4qlhZ/j2lwcazRjGdsxAld+xGPD/zZm4SJdROjoAfTUx1ZzW0fLmX5+m6qEjpopYy6NmD3Dh3zGFg5eSaSxP7gnMv0CSXpctIrJ+h+BBg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774200437; c=relaxed/simple;
	bh=0K4FRfzHgavWgVCxB4a+htaWyUxcaFYT/l5sYC6G1Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pl1Rg/+R2w7Ka8gQ5v4JrAMyt8oYqKbXYjdqACIsoUyUIohe6Pp5JgtEWCWM201IJy8JxLKtq3bAfraktdm22Lny2rBzsP5PWdd1EDMtNRj6MrPvJrDGaDUokht+pdffLf6CXZnuLIO+EY3Q0Y2Fc4clYRymvYdkKZmh+AbG7Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eQOU9P1l; arc=fail smtp.client-ip=40.93.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WR2FTlV3oqY4QryFR7rf1lVuqJeSjn+/vlme4qBsXSnXk9wGGSXTWh118Bzl2UO9CC945LM3gzggztLYIZzAMpPjRLNegdUbzguGHApznyGEbFBVotYYMS5DPTDS+IaeRJq8lx0ux9zQFFDIehq2diOgqvSAtcyrc1PrSaCBdDohiQGEANrHtCQJ4Ux/C9ilQgd62ieF3uE+rNQeF22wiJZoZlp554U9gKv7nSxTqyol6uvtPek7sV0cn4Pp/IUC0oJV8roj+1AvE+BzD4TgYyJw4za/pG6CsFRNLb0XGXhtMGA4AS9fwSZ4+v03wLuKuo/OR0x2v3+aVBNKSKk2Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKjv7zv4kHDfDCnvW1CShTxi7QBWBQ6NuJ3UhsTTSy4=;
 b=HPBKZnPeVv4V3mgy1HP/OYNF5RIhq/Nfr8SBOYUkmDsat8evhf3t6ad4sahW4DVZbioHV8gdP6xmHsxaQWkQyaJo2SOoOLF9a+8UaSA/lU1FzQx3uM6notWC3vSe4EUSRx9l5P13tWoGm8A0baHMYXXkjxtcuQ5+wYVQFTMkumUjfJXGB4zfDlorhlzRVs9iAo0s5gSeRhqqKWqVLMkyPnyntzXgfhquhHPawWBybjwWhp43wEdjC7WO3gnHR3tkPX8MTrg/Xvy92W6CDSLPZ401JK9PYNrNAAVRKgHqbEASIjnswOS3Bd0yfbwiSkZben2KqipLXuUTdfq5DEk0GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKjv7zv4kHDfDCnvW1CShTxi7QBWBQ6NuJ3UhsTTSy4=;
 b=eQOU9P1lr1d94UYjLlW8u1tT6kxh+EH4IUu5HrUzj80Vcr+DU7Uwp41TK5q4eaHC2IaTnwpTa+LvDItaBQArTcojaICvULGg8EH36npUR8QgxwHPWNU+TCIC0Tk86lXj7FBhZ1fo/u50iQncb+zrXlhakwSBg3Nhvv/YndTEMtN9GzQJWBo9PBZlH7/RQLQheAiiM5S3nNv5CqudKeUUfOsLwRwT6GJETaqsZupKY1NiJhhU0lUfnPNMhJ+ohxspNamWsW4Db0a2UGZb4OIJAvBm6Iv3PmF+MTP6cqWBdT11cIV46zaKxEtR+4XOZW5/HZuH81nfe+KBKzZkxMrzSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by LV8PR12MB9230.namprd12.prod.outlook.com (2603:10b6:408:186::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Sun, 22 Mar
 2026 17:27:11 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9745.007; Sun, 22 Mar 2026
 17:27:11 +0000
Date: Sun, 22 Mar 2026 19:27:02 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	dsahern@kernel.org, rbm@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11 net-next v4] Convert CONFIG_IPV6 to built-in and
 remove stubs
Message-ID: <20260322172702.GA121169@shredder>
References: <20260320185649.5411-1-fmancera@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320185649.5411-1-fmancera@suse.de>
X-ClientProxiedBy: TL2P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::20) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|LV8PR12MB9230:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eff34ef-f424-43a2-13d4-08de88384069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	j8Zus0gc0sZyrysI+0eyauDiDkgyDDv9SIPgWWgVZqpLhnYIbpJ2f1dWSCRECbNn1Qj6xYopVktPkmyrvvLDGDIvymuFWfpEll9sdR783zAIyKAXSWGyJ6i8g55W0fmMhIQzCSGO1FQu12cj4dCq7RemiAvYycAkyqfuOIdST4LDylpHph4lkA8R7IgN0nuxls6QTb1KHUZfjsJC+YYlJ3/62ok20FvMaljRtHfmPq0Oh7yiM3CrvgqRuu/4qIdnclAlJql7Emkb4cE9xBjxZqFq+xb/3Kojilq6bNY/wNgJ9EHIYc06w++t34DAkBqNpaR2qEuFeXOdTa263quk3t+r/++Q3bsnzfFvY5GcUiBrz/DNpaVYfwxbQOCwFdBnRnw10D6XHcoJVzhqtJCryGn5aGJslNH+qA69K4WVlWGUMO8RT4MYbMJyIBmojlKmlbXcSmXQqizdXHwFdyaIqaAzMJYAZIOzoj7BrhUjm3oeiLamLUAmJluhEHyHrIAf6r0E2hkPYH67mtTRkxcP40PrpSrZwmQ6jRlYLF85DD3B78vm8VNdIhkkthXuU/RqI/MfeX7UYXz5rKjjwixb+ROHdosysdf7jgbDGo39OwtkYUXOn3Jc4hkoLJ59pcstJbqJkDUURwMD5k8yF9L7yCNnyRhjoEvXMeqmGx1NDgrFEPCuNp6WTv59asJE3FUmkbkQEN3PUm2pRZ6pzeq5MP3c4JHt4japobvDsqg4x+o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/l688gqWG2GCvtk5nMNgQY6KDvaeXCx3j4AvYMG3jzuAk1eKpOjjAjQgZLjV?=
 =?us-ascii?Q?V+/Qby501ozThNqhWLUQrbj6IIWPo9+K+lXXnJrwQ2BOvALP8hJQ1jPvxmJJ?=
 =?us-ascii?Q?9y9bvbs9LXnwh45yuie2F9YGuKv9J2lFkiV4MdDO7wk+vltljL1gtBEJc1jX?=
 =?us-ascii?Q?bkkpX2abepXjdwTsODPosVcBKzLPM6nfNwrj3JfKDkhWjv/S6ZeTeu96sJwl?=
 =?us-ascii?Q?jh7ZN4qnPKLfcK0C/X8EJcVVlV8DXiqgCXvbMUIiWZAcpdfbUwWu4/lmps8L?=
 =?us-ascii?Q?+RA37fS0cxKeoB7Pn9+gAF5nmPWU/mdS2i4fL4xZPUjeG3h/fbiSNQiqSSJz?=
 =?us-ascii?Q?/wk3K60dcAHO2F7fswgNdpgpft+7nH85geWFqIHxmsgWW8HjK6vmhmgEmUZ/?=
 =?us-ascii?Q?GrpEqRZm7k27vS+Y/8dd3SbBK2/Dm075wMEXqSMHjInRhWyNWpznsRoc5Mof?=
 =?us-ascii?Q?EkoplKDCF22/AJfVkcdtmyhJ8qCkCH01W84zQNL0pGzwyyaQVWw3/LraWl9h?=
 =?us-ascii?Q?RqBqFrMjehUDvNnwOGFVO5mpc9CGtT62w0OUXjHPlLEZftS8G8QCsxa9Al2y?=
 =?us-ascii?Q?te/fmtDwSukWJwAbgvev1+DFX4if6Nwmv7LrULdeVlBv8dJ4uZnEoZdcyDFe?=
 =?us-ascii?Q?Z5cGj5xWj8ijdsixrwfb4xmNpUsXR/v8XC2HP82KBzmkCVA99Z4egsXqY4xD?=
 =?us-ascii?Q?b/lsy043BhGpdkednRLphZKhSfBtwZLQzEnhNQRq1m2g+B1JL+0VU9xlEQnM?=
 =?us-ascii?Q?ABP7ggmKaQymVyPuuPU0GiVDp3qiNst8cS46gRo2qZNKSe1H4ZHFDwrnzOvm?=
 =?us-ascii?Q?6tby0jL1thd97GtKcWXdmnZAhUSRAmGjOqey0fSEuTv+oy+8LGjn4PZP/IMX?=
 =?us-ascii?Q?1ijvk8i1Q5XhZuC+Yj9rrh49G5zFzzxs2GNe5/Wef85n9Kvg5y6b1pIJ1NA5?=
 =?us-ascii?Q?MNm0lgMSa0nH7JshE34BV9087YnJcOoS/OH5JzSWCHGuf9o8pn5ewT2X7sIy?=
 =?us-ascii?Q?uxHYyXHwGDN8mE8CN1ZyXz4okF40DIQfc86e1Lhsu8bQy76fTWtVH5KlP587?=
 =?us-ascii?Q?0QL4L/rOS3UWAPhFA6A2aWlGc/C4lqdlr+w5yn8RX7pUKOBVmSc0c9EgysbB?=
 =?us-ascii?Q?SpEfL4FZyNFOyGc1Ufx8dxNblkXU2GVbAkbCEEt+GGCvKxCVVNFGCd2NmwL2?=
 =?us-ascii?Q?u2f+ktK0+kw9/HLv+Zg9BnmAQPINzqMNo2P6QXT9PcYutqdwVhWBALvZ7AGc?=
 =?us-ascii?Q?0KxHKXUy4fz6Jgoar6udLqCefsvRj/WrtQT7CPkQ/NjU5iMoA3nThfLlZWhI?=
 =?us-ascii?Q?SJLsMMtJe2Vsd1golgyRapKyns2kIDBdNshxfVo8mj82X1LP+RUqv0xn7wqR?=
 =?us-ascii?Q?QtAol1KjfJpnTHwW9ojt6mSENc9SYaDb3Rq7i1wdwg7dCUOpZyKkvd1X1h1a?=
 =?us-ascii?Q?9qgCddrxTPX4ghmrenzzYAwsMEyqcg8bb8osOugTn3nmm+bR9Wcggyd9ki9y?=
 =?us-ascii?Q?AnSr3P/LWXqlAaU3dz3h0CNvavQcOzo33DYz+4DSoylKma37OLhBuJUop1Gn?=
 =?us-ascii?Q?kq58i2zXfJ9lmqDAZuJVOpcd2Lm5RYD/zBakg0M/Luic5uxR9UWvBvTg3IYm?=
 =?us-ascii?Q?liBYZTzPBp6YWSDQPptFRiGf0J5alOrYHjYMEuqcXHhzmk4P+Krxpo/EGPXs?=
 =?us-ascii?Q?C5r9iBMGXSJJHMbavc9npYkldRnf0IJvY4OhzeJQuWVJDEUoOwPDV4sC/pcV?=
 =?us-ascii?Q?iXOiEWvTQw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eff34ef-f424-43a2-13d4-08de88384069
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2026 17:27:11.5397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: diq44FaETmxhA9rSHQ9rwMYn+tibRqLg2tzqmL7xzPr3qOGsYhhX3IXjQ8comklEayKinFEUjvHKosVPfUwnuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9230
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270319-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 149E42EA2C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 07:55:52PM +0100, Fernando Fernandez Mancera wrote:
> Changes:
>   v4:
>     Patch 2: new patch introduced on this revision
>     Patch 3: drop some IS_BUILTIN(IPV6) on files compiled only when IPV6=y
>     Patch 5: introduce ipv6_mod_enabled() checks on fib6_nh_init(), ip6_dst_lookup_flow() and ip6_fragment() to avoid crash when ipv6.disable=1 during boot
>     Patch 6: use &nd_tbl on code guarded by IS_ENABLED(CONFIG_IPV6)

The IPv6 code is still using ipv6_get_nd_tbl() for some reason. If you
remove it from there (it's not needed), then we are only left with
handful of users that can be converted to use '&nd_tbl' when IPv6 is
enabled. Something like the patch below.

diff --git a/include/net/ndisc.h b/include/net/ndisc.h
index 9043ec00c050..6794ce58acca 100644
--- a/include/net/ndisc.h
+++ b/include/net/ndisc.h
@@ -67,12 +67,6 @@ struct prefix_info;
 
 extern struct neigh_table nd_tbl;
 
-#if IS_ENABLED(CONFIG_IPV6)
-#define ipv6_get_nd_tbl() (&nd_tbl)
-#else
-#define ipv6_get_nd_tbl() NULL
-#endif
-
 struct nd_msg {
         struct icmp6hdr	icmph;
         struct in6_addr	target;
@@ -360,7 +354,7 @@ static inline u32 ndisc_hashfn(const void *pkey, const struct net_device *dev, _
 
 static inline struct neighbour *__ipv6_neigh_lookup_noref(struct net_device *dev, const void *pkey)
 {
-	return ___neigh_lookup_noref(ipv6_get_nd_tbl(), neigh_key_eq128,
+	return ___neigh_lookup_noref(&nd_tbl, neigh_key_eq128,
 				     ndisc_hashfn, pkey, dev);
 }
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 4b0c98f0d994..d55525cc5540 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6093,9 +6093,9 @@ static int bpf_fib_set_fwd_params(struct bpf_fib_lookup *params, u32 mtu)
 static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 			       u32 flags, bool check_mtu)
 {
+	struct neighbour *neigh = NULL;
 	struct fib_nh_common *nhc;
 	struct in_device *in_dev;
-	struct neighbour *neigh;
 	struct net_device *dev;
 	struct fib_result res;
 	struct flowi4 fl4;
@@ -6215,7 +6215,7 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	if (likely(nhc->nhc_gw_family != AF_INET6))
 		neigh = __ipv4_neigh_lookup_noref(dev,
 						  (__force u32)params->ipv4_dst);
-	else
+	else if (IS_ENABLED(CONFIG_IPV6))
 		neigh = __ipv6_neigh_lookup_noref(dev, params->ipv6_dst);
 
 	if (!neigh || !(READ_ONCE(neigh->nud_state) & NUD_VALID))
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index b576dd74d678..3e8fadc28798 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -585,8 +585,8 @@ static int fib_detect_death(struct fib_info *fi, int order,
 
 	if (likely(nhc->nhc_gw_family == AF_INET))
 		n = neigh_lookup(&arp_tbl, &nhc->nhc_gw.ipv4, nhc->nhc_dev);
-	else if (nhc->nhc_gw_family == AF_INET6)
-		n = neigh_lookup(ipv6_get_nd_tbl(), &nhc->nhc_gw.ipv6, nhc->nhc_dev);
+	else if (IS_ENABLED(CONFIG_IPV6) && nhc->nhc_gw_family == AF_INET6)
+		n = neigh_lookup(&nd_tbl, &nhc->nhc_gw.ipv6, nhc->nhc_dev);
 	else
 		n = NULL;
 
@@ -2146,7 +2146,8 @@ static bool fib_good_nh(const struct fib_nh *nh)
 		if (likely(nh->fib_nh_gw_family == AF_INET))
 			n = __ipv4_neigh_lookup_noref(nh->fib_nh_dev,
 						   (__force u32)nh->fib_nh_gw4);
-		else if (nh->fib_nh_gw_family == AF_INET6)
+		else if (IS_ENABLED(CONFIG_IPV6) &&
+			 nh->fib_nh_gw_family == AF_INET6)
 			n = __ipv6_neigh_lookup_noref(nh->fib_nh_dev,
 						      &nh->fib_nh_gw6);
 		else
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index c65f88b253b9..9703e67d552a 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -1401,7 +1401,7 @@ static bool nexthop_is_good_nh(const struct nexthop *nh)
 	case AF_INET:
 		return ipv4_good_nh(&nhi->fib_nh);
 	case AF_INET6:
-		return ipv6_good_nh(&nhi->fib6_nh);
+		return IS_ENABLED(CONFIG_IPV6) && ipv6_good_nh(&nhi->fib6_nh);
 	}
 
 	return false;
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 802c68a1b446..bc1296f0ea69 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -446,7 +446,7 @@ static void ipv4_confirm_neigh(const struct dst_entry *dst, const void *daddr)
 
 	if (rt->rt_gw_family == AF_INET) {
 		pkey = (const __be32 *)&rt->rt_gw4;
-	} else if (rt->rt_gw_family == AF_INET6) {
+	} else if (IS_ENABLED(CONFIG_IPV6) && rt->rt_gw_family == AF_INET6) {
 		return __ipv6_confirm_neigh(dev, &rt->rt_gw6);
 	} else if (!daddr ||
 		 (rt->rt_flags &

