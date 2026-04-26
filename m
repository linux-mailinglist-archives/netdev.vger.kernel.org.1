Return-Path: <netdev+bounces-281144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7uaPDx3l7WnzoQAAu9opvQ
	(envelope-from <netdev+bounces-281144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 12:12:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 866A84695A9
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 12:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C1DD300CE63
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 10:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701F023EAB4;
	Sun, 26 Apr 2026 10:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FTJgHXW9"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011048.outbound.protection.outlook.com [40.107.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A954191
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777198360; cv=fail; b=hHxMESCMPwO5KDsYw48QXsc6IF5EDhvye6AP9Bb15+myb2tHBUXfdd4JIEXwNlAhv73D3Mc25eCw7ZGtnPnxlazWfAGK+jpJE/6/A5gLYfiGpR/DTu0+ZUWa/V8Lb4CYMwUqjIYgwxmiP0ktmgQW6TH7/aj1tZ54EkreFfTO8sE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777198360; c=relaxed/simple;
	bh=8Nnnf1zY3BPESH0rHH1Aw8pqxzWxIHtiu2Cw5H5oTcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DPcZyaAD9hMhjC+fWhyX71MlMPkjt6Gm3caP/V9PNAcLcg6d/8oaFZQhK6/HAA0FRkPUKWWNo1Tj4qjemRSsA/mZ/ncP9zCB1KpNjT5oJZGO0ZvZIma5H4caCVYzQk9n6ycyCC0ZZcQQbR5di9PRzJsIdaNQ7Cy5WNcQSsn9AKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FTJgHXW9; arc=fail smtp.client-ip=40.107.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgWioCT9+zlxxAvzDLB3s0S/2WF/RuLYAsve1jQD/HSzX2tY25t27DbRVYufQLNpxVtNNYbWWYc0tSbiogaLe/DaCAen/Wc/m10I9PHZKbl1OE1AFojJpq7B321Dti6PJbsnilTit+w71ERpQc0sZUW2xkN9gnuycUc9pjD3EJTRBTnzd+VsljztF0RzPrH+m13sRBrVTxItOGKRt2PcbPqZSMMOxOO5PGtV8W5aGwqnA1H7Xx9PWSiQKMEJRiBj93xkfI3vdJhEjX5HjO1CukKYm89gSyuqXJaNbhBPnLS3KJ5rQ4+SJcWn1wUTbKwQi8B7vYqG4ojG017TQdDsxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILIImt3jceC5/+yvoBf7VPIErrbibLgq09v2ayzoka8=;
 b=YBzZ654U0+uIYCWbbt0LIHLGNK8N22cUuvQWneRVKRvUJYDvHDwxSvDK+Lju8Zs4yICoJc2CPWWsC9H+33IVSViXGWkx1mP7Pg1eiqR5C2/7WlW5GkdjzEAkntHcVrzkFRNCL25QYOqESAkbosk8Tai28QRrofVijUM5J6ljX25s+uRs9ogWS3PWrt9UvTDY6nuu/fzBD6TFIkVvSNkW/+yIN1RryHyeFp/2aLYpzGG95TWi4sFg0BZ50ZrgQsgO99UPBmPlzNb5Jc6UGEoJMOQBwrmaXUT8v6B8ikHtUYZgDcs8n6xxmdECE0qGDfuKY5C2YEjMy04sOPoETPIb7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILIImt3jceC5/+yvoBf7VPIErrbibLgq09v2ayzoka8=;
 b=FTJgHXW9LcOA8NWWF7SCFAS4ADMnSnxw8NG0RPzYH4Y+Fd8dpnIZMbdN4QdDQhKMJUvCSRcXllmI8xyawowI8tlzbFhIHksIIxLgXfJgjlc/edK3n4FzJLT3mDwv2OjT95ijM+wu8pi4uSIN7bLvIACrGU8IeVf85vz55QHeVsZmfh0P4Ggm/I/Veh/jYumfGs/ar6gRbCWUgRr9Z5rqMzUSoleM1exJAjsIkhvu4nEmIqvF7VqL23eOnegG1PT5eSX9MYCvxnBV80XnvFEefURxXh/xdLbr55vPCTBagL8E9KV2rrNeSuG2q/2MzRyZjgagqvu2vsFeDEAoXzttuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH3PR12MB8354.namprd12.prod.outlook.com (2603:10b6:610:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Sun, 26 Apr
 2026 10:12:35 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9870.013; Sun, 26 Apr 2026
 10:12:35 +0000
Date: Sun, 26 Apr 2026 13:12:25 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	horms@kernel.org, kuniyu@google.com
Subject: Re: [PATCH net] neigh: let neigh_xmit take skb ownership
Message-ID: <20260426101225.GA151178@shredder>
References: <20260424145843.74055-1-fw@strlen.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424145843.74055-1-fw@strlen.de>
X-ClientProxiedBy: TL2P290CA0029.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH3PR12MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f5e26ce-f31a-4948-71a3-08dea37c562d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	J8jX783BF785haCxexMUwQYDcm0Z5+I8dEz8samKIPWSL5Fh2+Y1CE5bXdDr6bNGO/i77R37OIZJ6uVCEp9OLzEUqZ433UpUXVr5i5AK7JJhmix2Xzg0KA5VhWyXYrGUwgDCyaYu1gUZY41RDlV++GeijttLZRVIW7jsotFxoZe7oHKXq7G7bWpSXqwjCkCs29LByzKTTBmIja3nbjQenVAyP36sEdCpMdRylaVi+US7vUwoBhc8s9wsD+7LzZpOfHdQUKGa6kftQJre1mxrp9PY8uyivEDUvBM7adP5p+f4WLAp8xjs2t68QIhPGd+fKNhDjFre53Dinx/Gfk8CXJ2fNz8HpN6rwWbI0U9madf24JXF8Qk963gTg6tfoRiIdDKhqrRLwjhORsgMQqhBQw726Qv5fdX6GtnC3tUPfKral9AWppYaOpyDcK1wnKR28NEGtnWy9lIbpVdwkVqcCLEJqGBV7gnEkQ7W7zJ2XkfXvcZdPuw7/brrL7Z3uT6FPZn4zbH534Q0agDsp8P6NeEQMobazPy6K7stiUkRmbuvu2gwwDRNtCzPM6PiQIso8mUok330MKLObXh8gS7JS6XxO4gpHBMDbiCyrVvZzC9qlfolT4MJfskuxUunU6Tumnr0VfaWf58R38HVUMUHX6stx1bHbpeFqer3pV6lx3i3IWaGMHVuVfJpdj8QluWJPSIwIToKYcjIpMaahhIfll+bzSVnkg9bheaTtPUObJ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AAsKH3O/dPcqw/iGL+SoUJwauMSTmZ7Yj3vz2eCzYdA9EQnf70O4y5jVtxr3?=
 =?us-ascii?Q?WCsroKyPZu1J8fZ/ONyKf6yZgDTFLcpeoZQT4NntVsRsOZiObsvb+XsCI76g?=
 =?us-ascii?Q?XjNntYs3polZF2RgNzxue8C7Yy3FdIwdF8ddHfNePJ5Op3YDjjXtfJ3ymTBZ?=
 =?us-ascii?Q?6rXAeTWTBfeZyb3BkQi14e3banLupfmwGHCbfIQw+ZUX/pmhB/Qlv9Wlmqp4?=
 =?us-ascii?Q?0ShTyxXv2JQ1xUxpwTKXdoAiV50Ej0wJFr5x3le4PPYNZqP8cEMCQFenj8b4?=
 =?us-ascii?Q?K6p4AdWVoJ1WSgV8dgTvCH6M6pV1n8CBCO1Kiuj0tzpCZD5XiTmGMKO1WmFV?=
 =?us-ascii?Q?Ru43muws+qBoCLaNhIz6Q2IsXsYuVMmV/+wrTnzPaYro3jyHLn2HrdWTapKJ?=
 =?us-ascii?Q?N7M1gzDVmGH+VikooEEtthlQmgsKVqaK/DF1uD1d9wNu8v78Erb++nBU58rt?=
 =?us-ascii?Q?giZXUAPgPocaOxDz61Xy2EEyrb3EWIC8BhfYwsVaIzcsRtYTGwRy660C3dru?=
 =?us-ascii?Q?FYytTP35YkxC5Odr5R1xB76GW2C0JRgKd5w2Ohd4kmmgmfzhngKr9qO0uvvq?=
 =?us-ascii?Q?XmdFvXbIDnpLYYc4F3sWZBfMA3XRzCGcBVh9atuDXHQRTbXvqEYduWmB4euF?=
 =?us-ascii?Q?fAH8hGNr0i/WQ95/2lN5PWxpaifSKVbqEwaMCu4KffP9tjkV8raun2C5nBVu?=
 =?us-ascii?Q?/6jpOTU4n1jFsUj12x+NIC8+ybEi7TWsROk/PfJ2RJI/m9O9dsSQjtms0Lag?=
 =?us-ascii?Q?SPp9fVoP6RLBzqpiBBz7PamAgpC3YSw/ff9YDVsLS6k01VbJMDRywYcwkyZh?=
 =?us-ascii?Q?koi30/6XTtwyTIvIAQfhc+Rqcqh5TrfX1+VTZerw1h8xF6JaS/IKVueTs8Eh?=
 =?us-ascii?Q?PkH/SeaI5cXTZIbBXCHDb1rxP8O/Dq6UHovQYPntRX1Lxqi/RbDqQqi5qkRG?=
 =?us-ascii?Q?ZHwIDHWQr77ZH+GResODyk5mMEboeYepLP5vkHIPsG0+yRXyl6f0qD8iSvZ2?=
 =?us-ascii?Q?o73bwzS69GBYjOgD218ZZJwVo5KJPM7aORBw6vx3CIp0js9fuyqigk7GaXeq?=
 =?us-ascii?Q?bn3vYCCk0kScrzVoJ4brRmsEip3F3cs6S6mzWeVW6tMYHjnb8jsuq9YimjJS?=
 =?us-ascii?Q?PAfwCCLKEFykMWsu+JCsu5CiL2zCsm7l9jAuLqK4yPgKTEluo8TOC0MZzZS/?=
 =?us-ascii?Q?MUL6Ti2la/LxctIKILpDuVA6Mv6YIY3ULMB7F9PTOGkYpy5en7wUTAMxlMME?=
 =?us-ascii?Q?g8oAxT4Vsh/VslyZrfzA50gBuKOOJ0n+9xM4m5cCsSEfuqAOjKzzppMeKazf?=
 =?us-ascii?Q?WWOOlHeEokX8v62h9waCQ4/LV3nGLb0fqTdvfbjzkBjJCduVjBzTascalXFI?=
 =?us-ascii?Q?mZicZwVzBPx6QXYiZG6B0SKQtIYzjIGYdRoCkE/wqZWSbRsbHG85UHRX9R/K?=
 =?us-ascii?Q?xVTCAyYyzfbsy846AWm+DAHsJnwe9XpxLyaZx/+UraQwrtuVUHoQfX/sY5ui?=
 =?us-ascii?Q?3jEUvl0WgF/Se68FU6nTw9+jHm09Ip7Mdo29dsh+c9+N6J5NHWZb50P+VleC?=
 =?us-ascii?Q?s9/LSLqXsV3qXGXT9lGstkjhRbjKjXdMKEpsx2EwtrXvGU5m5ZcZMMosGmWF?=
 =?us-ascii?Q?IFyqd41cimJelSmn7o2NHCfDkzgMZHjjXMWGPxUsCfbPcn3s7waDm5/dIy8N?=
 =?us-ascii?Q?CdnQ/NoZXdPO8lkXWNcDWxD1vw5Im7M3cYKTt+q0A6mA2JIV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5e26ce-f31a-4948-71a3-08dea37c562d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2026 10:12:35.1868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MnpQfmLg9yB3CQ0xjb1AJPMiK+01NvTjF+d8eKw8CGoKoUPIXwwHFOGMkpwz23nFV0BxmK982Vw1IEISVDNbfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8354
X-Rspamd-Queue-Id: 866A84695A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281144-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:email,Nvidia.com:dkim,nvidia.com:email]

On Fri, Apr 24, 2026 at 04:58:38PM +0200, Florian Westphal wrote:
> neigh_xmit always releases the skb, except when no neighbour table is
> found. But even the first added user of neigh_xmit (mpls) relied on
> neigh_xmit to release the skb (or queue it for tx).
> 
> sashiko reported:
>  If neigh_xmit() is called with an uninitialized neighbor table (for
>  example, NEIGH_ND_TABLE when IPv6 is disabled), it returns -EAFNOSUPPORT
>  and bypasses its internal out_kfree_skb error path.  Because the return
>  value of neigh_xmit() is ignored here, does this leak the SKB?
> 
> Assume full ownership and remove the last code path that doesn't
> xmit or free skb.
> 
> Fixes: 4fd3d7d9e868 ("neigh: Add helper function neigh_xmit")
> Signed-off-by: Florian Westphal <fw@strlen.de>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

