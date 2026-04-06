Return-Path: <netdev+bounces-275554-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Py8Hh6M02nFiwcAu9opvQ
	(envelope-from <netdev+bounces-275554-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 12:34:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCECD3A2D32
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 12:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17ECE30097ED
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 10:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A66C325714;
	Mon,  6 Apr 2026 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="boN7gDB9"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011050.outbound.protection.outlook.com [40.107.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADC029AAEA
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 10:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775471643; cv=fail; b=HEccmnaJiEIUpXk1ONfrbiMKfpunKSYtFWCgwgNCvukP+yhqhmCVUaNUPNM17sTlz++KD24NCaMif7i/Ls4vjgRDpnB9r4KhWTGbpP60GvDlCoFi+sdaiR2nORIT37kfDGeBhKI3KJypO8hVQNwe/Yz5+wo9Za8TreV5JkmgAMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775471643; c=relaxed/simple;
	bh=31r6/gbFLdUA42HBvbJ9gJ+39ZTJMHlaSEDwe16EHns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bpoAglgqTz0cXOT6sRXfBNCWA7rCcchKEZ94JV9Gu6wR13sO8JemYznrma75wwzjANqIHnOYdiFoELCED9r2LXM6Io/sNHBd+Btqcq2QDyZnW83pSmyk8/xRZcQpgMIbMXdHH0LRt8/CJL5HGsQxP9DxOwKMQV1xciqA1cXTX/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=boN7gDB9; arc=fail smtp.client-ip=40.107.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ft74VvFC2QKRPqAVNh8Ai8sv3HDOpgD85eXw/dbdg4OssMNqYtQtidNcLAYeotN/UbQf1nWnndH3hqLHnsLHYonJtLgsbDafdwRbuB+DMAb0qebFR2zY8ZZhmtbStvAFIenU8xMgcKugeMRm0bb4ojYzMtJXs1gckUiLDhQ99z4Bxw83f1NtFdyDuFq7Af4/cO7yUAaxSocTg2F4yrc8asQYl2nm68t9nTRgib1ATCYJLN7h0XIilJO7L1kSjCUBkY88F/c8EdlY1NjyX4JsaRcJvRQSlILQjTEr+pfd1q1a2hg66bSP5Q2L2+XYb2qvQMm2cAi3vBG75e4XzYgyuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cihneloriHYRMGpiiIgF7qxWE/Cs5VjKz7dzULBFQnM=;
 b=fzRwQmvsho4Izo6j7Obp1FUXdX31d19BhW00OrT4PEPLCrub87M9lsuAzzpO6SgPcdo1q+dkqRMGZRiIH9pC8HyJJB90f49doHbTiokudz+BK3Sp5xTHwUk9eFxLltOO4vIwMS7YufuXSL9YsV7OoW/KXf4sr05pe2BZcVPedTv2NhQXqdM6zh5A8dgh8Sb+VplzHd0GixHG1dY2BUS27yl4Xoy3WRbleVwAcI+auzg1rCSN5dkGMqhfl4VTaXTrU1FPFOwrSRY5OFufMhqmNL9K0Kri1pBpOTz27p6qWC20Un0uHgjVktIZJxTEaLowUmlzzcGzFJ8MdcczvYqPEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cihneloriHYRMGpiiIgF7qxWE/Cs5VjKz7dzULBFQnM=;
 b=boN7gDB9tJ9tJhJrStC/QtJX3x0rNjR1INC2KZ9ypqxquyFcBxTtf9UA5wMAN8zbc2rtBc0RQ53c8wlq5nN+kSk+xrmBIANHhvCkLn/Dk0NG9b9Fn0UyIqyKE7a9691JASbbPgijlWhfiKdIB6ped0n9AZOjpCbYYfxFCF2txIEd+owOzqaZYEsL2uXFhipZzKkLmj0Nva0EPuXtz8OEJ3Omz5o+HzHHBu6NnypsvStnjJIQgbRgQBC/xgUhkVsEA61vkY9mQGfXXAgJ169R4rwfYFRl9XK8Ugd/xqarREJlQVcguJ8/9bD9GOZPEy7u75HpAtFzTJB6/Ile4QM3+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ2PR12MB9191.namprd12.prod.outlook.com (2603:10b6:a03:55a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 10:33:58 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9769.016; Mon, 6 Apr 2026
 10:33:58 +0000
Date: Mon, 6 Apr 2026 13:33:50 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ao Zhou <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>, Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>, Haoze Xie <royenheart@gmail.com>
Subject: Re: [PATCH net 1/1] net: l3mdev: Ignore non-L3 uppers in
 l3mdev_fib_table_rcu
Message-ID: <20260406103350.GA654671@shredder>
References: <cover.1775062214.git.royenheart@gmail.com>
 <b3b88cddc7e79d4b43756b26ae5db965678f3ba9.1775062214.git.royenheart@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3b88cddc7e79d4b43756b26ae5db965678f3ba9.1775062214.git.royenheart@gmail.com>
X-ClientProxiedBy: TL2P290CA0028.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ2PR12MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b5da29-ff17-4fd8-e9df-08de93c802b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	KpBrC/Oi+VdANtza6WrsAXbTofHDhuDCYuJLDP/e5vHr4ebPSiRMwVXXKf6cqTvCrvUXNPqkWO4FzDdVJmRjLwY43YFJ9s6j3T3Aa6/PmqdSmkMBmPzZPzyFwNOAZQB4IBxL9uCMBOht7z3+4Vsk+twam3+aooMbm1B3G9qSesdO3WT9bXFmpbfcmmZeuBJPquhb9umRJhQ4G5pTFRlzViHldwjhYygaJxxwzgenxYJbWRlHXwiEhHYxMLxGzXznX5LI6ksk6pwXroRtaQb/4YPn735ZjEc4o5G0+GOHEd8s2wRVB7uRrQJtZfsrMMQiiKU6eWqOaj+fCtDuG8cQ/TKwtYrOMcW2X4KsWNMjDVYb4Mp/tJaZymfLHFCumghuLsoMEf3pMdzRF1+qm5UIq62jKkAuvMFapKtXzShLffES68JxkavfSCTZMZ0zdF9WyE9cyDj8xD8taDvltadL7XL+kzB+EMsPd22/hAwRmAmWoy7pJ0qg5h9MndBFCMMnP8626eLQyVwsjlXSOJvD9pkiAfNUqO3T4iaNuEjFL9jC7K+96Z8smopAk/xcUxzoeUckvZEhlAnJO1E47ZguGKgy1BoqpO17jlzzGDOJe4fc2SXEq3gNA6gQvP+6ZPGxm4C1A4HufzpTJfrUQ8a3DixzQTOMirXWOKSgM4xITfNlyuNCva5XXUSc8DdGgi9gMwgIoIeKyNqHaNIYlKaiU7Ulj+rN7bdWUMTDwbmdK90=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3QTqFybWQc6UBXxob7Ckh9ROOHpI+9r3NnQQ6VKEMnDRfr3bG6Iwa9MS8zFj?=
 =?us-ascii?Q?UjNfOulBp+p47VP2bYgBdC+rU/ZAcgUUW2PW3vFrYx/5KHdejgUBG9lSvda6?=
 =?us-ascii?Q?tWOx9qxXvbu0vPF5zRNW5jEDj3qn+NDa6oNpzt5gonGAp63irkFZ0/u3I6W3?=
 =?us-ascii?Q?nEpfzd1y6jZqMhLgFLH7TkY+6gMOjAByI8WkcK0JgyfzMJuUJl4ir+QLzCaZ?=
 =?us-ascii?Q?nJY/zWt3LZ3SiM+S+hUE70mz8956bO6R7J3Sajs7vnO7RxVziMVVf9ApNx55?=
 =?us-ascii?Q?+6IOZEBD67DGdXxpiHrnriWS5wKfe9cx0ZQD90iOIFirJI34UCMe9Vx1AspZ?=
 =?us-ascii?Q?r9MDPd+pshhOTmiu5sDW2phhpMt279jFvE/f17ovFM3p5gvb0xItePAbYDfo?=
 =?us-ascii?Q?8vK8ZN056jbGLxKlYShcZoXwHRIA0C3/h6JK5EIr9IAFpPU57tz0Q9X6XJuJ?=
 =?us-ascii?Q?R+W4jw1dQnT6f0LmYii78eDu17RkH6GBWlsXLzC19R1S6pjMCjvqLt7qKSlI?=
 =?us-ascii?Q?6jc47cceGINcF1Vr9AhIKHUtJG9nGLbcGbvABRXbwJy+rLOZMiwB/Q3j0Bi8?=
 =?us-ascii?Q?fYr2vysctejJdTMtKQeuAVSr/OTr8i32fdx8bNiGArf1Dcx38+nKVodesBtk?=
 =?us-ascii?Q?E6OhkUqMApcGYBFdKrmX6W0LSJJMmUtss2kuoykEYhV5LncoBOXo244AOF+I?=
 =?us-ascii?Q?qGOd7dZXabIYlr2m7f9A+wTgsgNaIncssE9WYUmegQzD3gCNnObX8I+i45fT?=
 =?us-ascii?Q?yrAOs9h9Gq3qFgrWwEERt5dcJScuQrMIXjs6IwUu8HrFbz40bMiazJRgXcRL?=
 =?us-ascii?Q?W3Ndf8kNo4RcldCYD4MgAhB3m8W8AOmznGSnV2qHkNn0B4maP0LUsmMldtLr?=
 =?us-ascii?Q?E/KIxQgO0bw1sT4YNXmspBmVwbrNtbAzExh7kAp+LEED/0rAsGjloU1M0tnO?=
 =?us-ascii?Q?7Q2tnm6At3EeMEKYxaLvFv9Utyt8W7NJREMFVQiuJ0aaMRqxfP70fsb1TjyR?=
 =?us-ascii?Q?aB5B0ddJXZTWrAUZd8NOHbxjpa0ExTj6CskrWFUoFXEQXW/XaCYP6tmK4zgk?=
 =?us-ascii?Q?Calpha14nHKgSYT8HgK2/g16dks4P6c5N6WC4uN9syVL6+Orgy6ik1JaoBFt?=
 =?us-ascii?Q?NextqzT36c17f9ML+4axjMbL6sFs2+GB5cFpq/ve/s521+xEyqGlml1AM2e6?=
 =?us-ascii?Q?7xyjhPC6QOecmLAA+Oc3flNdF/rXm/TWa8ygv447efSU4AS2vAbFJWN2CcQF?=
 =?us-ascii?Q?rD0TV6KYgKUh16w3lTAIWGa90tfdnxw0eBOnkeLBngd8KlCb1ZFqdoK+bZ8R?=
 =?us-ascii?Q?NJmbIexdnVOLeh5+33gCnaTub2vmdb5xe8v7MAJ2zrkIvAFaNz1v08AvYpPm?=
 =?us-ascii?Q?t8PMNB+k0s3e6Ti8ZiQsltGjfXKAltDwNrJUwdfif382WedC7i4ZLYBWZGaf?=
 =?us-ascii?Q?0uE/22ZfylT9oNpqOE10xgrUwUf8jnPuUWSrXpOTDOjzdmvfB5yv9Spj6g25?=
 =?us-ascii?Q?KomAfjGim3DC14WqmWEeR/cXyJi1p97HC2/7xh9iVaQV2DEBZiTrC+B8BP4c?=
 =?us-ascii?Q?OOnXvyGOskxEYcUTlDUrNr7YF4ah7Yryyn6r/CXT9aGehgEENKgDNNQWOsil?=
 =?us-ascii?Q?DMNjB4jqivNiXCsNEeP7PsaYAkDjSiUS44gTzZ2UAxCaKQiiV4mE50DiMiqa?=
 =?us-ascii?Q?HTWcwv10hFO8Pr1YRMDp7cevBiZBgAe7+g/KJVPNKDggr/dx+acPBLHI3Yjn?=
 =?us-ascii?Q?76FHIlUEWg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b5da29-ff17-4fd8-e9df-08de93c802b1
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 10:33:58.3727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yc97Y5q/aEMMCFPc5MAUOlg5Ug8c6rb4HI/xeG7OFUjlQQWeMDTtweSi0YrhcZvZ38E5FyvGoaReYD9vWRuaSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9191
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275554-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,google.com,redhat.com,gmail.com,lzu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lzu.edu.cn:email]
X-Rspamd-Queue-Id: CCECD3A2D32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 04, 2026 at 07:52:03PM +0800, Ao Zhou wrote:
> From: Haoze Xie <royenheart@gmail.com>
> 
> l3mdev_fib_table_rcu() assumes that any upper device observed for
> an IFF_L3MDEV_SLAVE device is an L3 master and dereferences
> master->l3mdev_ops unconditionally.
> 
> VRF slave setup sets IFF_L3MDEV_SLAVE before the upper link is fully
> switched, so readers can transiently observe a non-L3 upper such as a
> bridge and follow a NULL l3mdev_ops pointer. Require the current upper
> to still be an L3 master before consulting its FIB table.

Do you have a reproducer? I don't see how that can happen.

do_set_master() ensures that the device doesn't have a master when
ndo_add_slave() is called. Meaning, if netif_is_l3_slave() is true and
netdev_master_upper_dev_get_rcu() resolved a master device, it's
guaranteed to be a VRF.

> 
> Fixes: fee6d4c777a1 ("net: Add netif_is_l3_slave")
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Haoze Xie <royenheart@gmail.com>
> Signed-off-by: Ao Zhou <n05ec@lzu.edu.cn>
> ---
>  net/l3mdev/l3mdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/l3mdev/l3mdev.c b/net/l3mdev/l3mdev.c
> index 5432a5f2dfc8..b8a3030cb2c4 100644
> --- a/net/l3mdev/l3mdev.c
> +++ b/net/l3mdev/l3mdev.c
> @@ -177,7 +177,7 @@ u32 l3mdev_fib_table_rcu(const struct net_device *dev)
>  		const struct net_device *master;
> 
>  		master = netdev_master_upper_dev_get_rcu(_dev);
> -		if (master &&
> +		if (master && netif_is_l3_master(master) &&
>  		    master->l3mdev_ops->l3mdev_fib_table)
>  			tb_id = master->l3mdev_ops->l3mdev_fib_table(master);
>  	}
> --
> 2.53.0
> 

