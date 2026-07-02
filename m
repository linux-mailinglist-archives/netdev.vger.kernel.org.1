Return-Path: <netdev+bounces-304027-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zOkWLOYeRmo9KQsAu9opvQ
	(envelope-from <netdev+bounces-304027-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 10:18:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDE16F4B2D
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 10:18:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=lqvuYZX1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304027-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304027-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96688301A916
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 08:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A95413D96;
	Thu,  2 Jul 2026 08:12:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012069.outbound.protection.outlook.com [52.101.43.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6112B41226B;
	Thu,  2 Jul 2026 08:12:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782979929; cv=fail; b=In45dxZJgHnOxYrwRLORjypIgs8nkjb1v+kGFl/rOUlZ6bjXuvxxgDh18vTkCriqBmzXlVkViiJwyVlx0Ld/f++F6m+Qd3KCnpN6vDrkmOVkBKohtcVuGTFcJkIxh8/B9UYt0BPfOisLpcwYUzR6XCfxCDTbe8cuuRZHpte/QZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782979929; c=relaxed/simple;
	bh=Y/1eD7vnaF2e0jzi8xNIr33Alt7+8kSyt4Qgbzmq1/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oR4pIeY9rsvQFZHoXMJeX6KnXnwT2XCrgFT6Vg/eHLj39LYjmW/61sKPGFMeL48Z9BXITIcSSlHVNGfehTgtjuImzU7GGrPQO35t69ZmlvU0Hb8xHMW1ldvAk6fiehQgpo1UKIZWeafOwULdoz2UispjUp2sgSDQUIj2311kpYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lqvuYZX1; arc=fail smtp.client-ip=52.101.43.69
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKBOAq2x2wbb0GeN8Lp2sMzTKZs2RBiw2Zr4a7BuEeWvqA+MZiWUbtfcOndVxLm95ssMvU9j5bNnlPrEAtXT4PD4JsGBqsiEUTgnDiNgUJ93lvYDwuy4xmYiuDqkY7dw7Cj4NShMQPNxZrWuQdbeQNMdb+0FA+ZXfsjv97o5PCQ6Wi5HY0PLVp9Ba9cpSEBc5q0A3a1Q+XvXF5m33OkRUYixEMe3ETc7pOxZ48qC1jB0G5zATgLCzED/1buhOezmz7Ofp1tvpTW3fUt1QqhtBMO4Lc4W7wgJSIN3gkoh9rpmQlVN1T3zra1+rWGJGRU+ICSDC8ljJQrKNG909RpaEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DoE5KKtXlBxdyRaBF5B9H4/v8TT0BmS03RVTYloEAE=;
 b=wu/bNBwFIHkKAwSwN5FmXtWMJt4vst7leUr5S9k3aCDIckY8s1Lu6UK6vV245P5LBs5zxqR9XRCWUJwpkuK5s7F+rWrykSCGlz5CRanM5f3nzWODoh8lwYqr9MsWAczuiF1bwDb4WeRQA2TINQFznKiycst/oGgShXC2eUcMHgEjIBsNMNJoCltrIq8dGIlfrfhfocterczWh8e9YaiX6xzkJYUn7seLdpiim42vFJ+YjUZ2Zo/KNO+1w5zUP12hY934L30hKRfwgisEAiC64PpJ3ao5/J4Jt0a4IAKlCX8zLqNz6ueOy0d5GNqsyD1fqa8ypWbHo4IsxlR48CjvkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DoE5KKtXlBxdyRaBF5B9H4/v8TT0BmS03RVTYloEAE=;
 b=lqvuYZX1EsYze8tUmqICgy1Eo60d+J9yNo1ePSjxGjTfZQ//KyKMlQQZLHyQ8ETVUOocSTGm+d/8KcrIl4H5iAvm6AQa6c+oyiMhABSZc3ZNPuoO9OOOTJs+XZxFf1wqeq68IdkI6++gC6Vju/OOO8/azPfvGSf+CnMOUTdW/x8Mwu5cOadzQbKi/EHnF4tQzc18a4hr8/FxIPjFg1zhrrzsLj/6d1ATSO1jSaaVmJugyg3JYlIC/FOAI6ojg0bNDFyzKf8wdFCJIWVPlfTAFQRLvmZz2lk0t3TGCjG0BmLTh+UtBXeGLb4+K7BbmzIv4mGS01i8Z5eoxlAT9G8iiA==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH0PR12MB7485.namprd12.prod.outlook.com (2603:10b6:510:1e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 08:12:04 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 08:12:04 +0000
Date: Thu, 2 Jul 2026 11:11:51 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Ahern <dsahern@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: ipv4: report multicast group user count
Message-ID: <20260702081151.GA1574313@shredder>
References: <20260630110207.37841-1-sigefriedhyy@gmail.com>
 <20260630110207.37841-2-sigefriedhyy@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630110207.37841-2-sigefriedhyy@gmail.com>
X-ClientProxiedBy: FR5P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::7) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH0PR12MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d257aa8-8207-4900-254b-08ded81199d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	U/szLmno3dUmmfebbDjsUWapCQJD1yLf6ebks4o6JCqlRSg+ZAH8YAW3kNrK9KXQgpKinFSyox7aaDBk5VY/BiyVP+4yTXsuT1Mff00oFKPXZWttxTwv8lvu6pUlL9pMQ22wns/QYcZlGv9q+hQWp4MGG5LnVQ99O0Ycu8+tLerI4Lq0e9eMRDn6qnWzcti7/P2s6z+UGGDwhOWtbFMrucwp/YKUltvO2s1irtxmeigAPvRL1JpeVOM2r+dtIpHRaeIIgZRicVzRt4obnr1e2IY8I0ZlSSCPJ+54xmQlmZOZuHygV++sxLJi0YWpOAvsZPE7qpS1Kfpj4M8BoXZz0pLgyvU1fPI7q/SuxZhhxd04c9R2BnDXbrsNuwb3Jx7RCVCJFnsoAXvZeGe2eMiTD0PdlOoPIe9oGIVt4381Sy/5Qad+zovRVDRZUVKT4I7gYgxY8f9nml4qNW5jn8QeeWCYNA+q3pylubA8LTOrCYKZ5BmDBoHCCdoLfC8vs4ZIAURK/AuPpe7S8VTkXl+K+3K3DxgUU0TSpKCRnhYB19uwGTedPNdtBfmwQgkKw0qVHwNi4k2vo8IIjiso33iUL5ggFw12Ns+pBOEZ5ewh2xHUtKz/VSCNMSMIJjITre8kpkm9pTGDzxIem0oAxAIDStPL2irpcuv5kWdrt5+T8Vs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VXLSylt9rJrZgFt9vA7CmBdyw3FcbHzFqDoKSjwYTN+TckHj3eh9RHkhAilt?=
 =?us-ascii?Q?Aa5hUDEeEqMgEripFsibklz6Q7OHYdmLTldULw2ZM3jNaQHTNx9n+FwzQUOp?=
 =?us-ascii?Q?F0oxLrgVC543gT+Qi3I+aPR3HU5z4c06rR8b67+5KEtMgoyUhTnsmSDXav2t?=
 =?us-ascii?Q?WOIbkqwgL+8aPwrl3rt+n6fzXP9FBW3bP4GMCxNb1Y818z/3IC4QsGAVQx+h?=
 =?us-ascii?Q?2CFJJW7asSx6OdrGkTLdvgoAd/NDV07E6LTPVeDHsbFF5LOf2dFXkQb8XGR6?=
 =?us-ascii?Q?gqYI58PlskOrvQ640udeDzKOM+nb2olDptAvBZ7KwVSckjA1VqWggvZk2Xvj?=
 =?us-ascii?Q?8uN5u2xjYI5/0tSjhD6ECxEy3aJpvlIPFLetFN4kesLKoK0CD6xo0QbuFF0+?=
 =?us-ascii?Q?Hl5Cy9MkWUB2cTSB9zK4co83dItaBZIQxzUJ07iAiTMpFb2Ivol6u04Bl8wt?=
 =?us-ascii?Q?JbGP4moqL4sAcA9BhrrfWR2px2Ld+iFZzMWHW9UEE31o1s5a/eNGKrNsHzHo?=
 =?us-ascii?Q?VipYyGOYGi0muzyOrFdZl2zRInyZydgy+bYFxiyEfBoLucogML+2l8Eu+d13?=
 =?us-ascii?Q?a6gF3DVafqjTKnqFaRmGMAYsVOhlXPts2CVJrWua1fXYoiREzo7ajHludo/n?=
 =?us-ascii?Q?pZbj1xbj20FZOzdR4pQCa4MNiV0ZTEkA0kySfteNRRZJR12CXUH36AZ36tZT?=
 =?us-ascii?Q?wea6rj8KJqwQ4eZe5sElTXSL+mPoKoYkqNwuqxNlKMbQXtSiyt0JF12RJ3qS?=
 =?us-ascii?Q?ktMf6Kt5R++m/pXpuXmPYo39imswdiUHL5bw5c23fc5qHzwW0we0mygk6yQo?=
 =?us-ascii?Q?wIp/G4H1Ovg5WGPlemYRa6hK/oqPrRh/xcDn8AlJoT+6mc0k16zjxV6EsS3J?=
 =?us-ascii?Q?s1Db7fP5n6c0aON24hZOIH9Aaf4GaUJDHjfc+QOPf03k6uoXKMh/YRkEXU+j?=
 =?us-ascii?Q?gDmGvC0Hj/1lrpbEfrMoKc/XAbw8BV/9/ET4O+Nvtcu/TXXJ5Q+9WcJw8MN0?=
 =?us-ascii?Q?5ygA3dBMRCzHb9hC22HVxomnnQuVGqU8d41L/v4BL9R3YiHrMU8BlvlVPN3G?=
 =?us-ascii?Q?12z126T7wbnTcs+TKLpaoMwKhZoY3YxR60R6PjeURQQcPhnBY6exr/kYF5qa?=
 =?us-ascii?Q?xfC+aecLNghI0Byqwuc3Wkld9NRGwxNXccpdwsE84y2m5FwEeUHPUIJrS1/7?=
 =?us-ascii?Q?xiUke1hAA93/hegjzdegZjgQ6dRv6wfke9wgBh0TKHXk3dncjT2QdZmoBNb7?=
 =?us-ascii?Q?lmZ6iGn74zIkWlM3smJFBGyNchZBFcPhetShK+/S3YUiQJbYC4fRXhHlL43i?=
 =?us-ascii?Q?Z+jDW9ewL0W1MPArMQ5lB8b+hPj89oZN+7aQpMGs5nrV3VTlkRk0P+Glq67B?=
 =?us-ascii?Q?UmAPHC6fgViovulT3lZ/bCMc8QwrFL+q/itMOFecf99ntr8HgilnXvm9LUq9?=
 =?us-ascii?Q?Bh66vdzgCYWHbIFM+8AgbGiNF8KFIuwPKst09Rjjv9Yiua8muz+z7Xg6IsOd?=
 =?us-ascii?Q?2WXuQVPMtF7UUkv5dF3RpL6F+P1spWGIJ0s0+Ta+9ZB8Yg/4DdS8XggFvZe3?=
 =?us-ascii?Q?gBU2IZOrcU/1xq6T7wfC4Jgab5rL48dZr3Im+JOl91TmfmmwdnTk7K0xCNtL?=
 =?us-ascii?Q?Zyhnlbmo6eSN3k9hRpRPCu2Op25YLzPZltIQkmEgpO/tkA9uEFotixI2Fq55?=
 =?us-ascii?Q?c1HauPh7A4AsORunBV/QwA6LczDtjCBSSCH/YsWyPSWQSxL0t1jbUrReRmGb?=
 =?us-ascii?Q?7yj+s0nlgQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d257aa8-8207-4900-254b-08ded81199d4
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 08:12:04.2549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GezQkBC3M4QjgOvhHPJFa7a5szLkd0bH0Wzk/ud8zvMkC4R743pmCPeMRMmJrNnUBPF+S0+7+mYeQEO8hljcdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7485
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304027-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:sigefriedhyy@gmail.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:dsahern@kernel.org,m:donald.hunter@gmail.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shuah@kernel.org,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,kernel.org,gmail.com,google.com,redhat.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shredder:mid,Nvidia.com:dkim,nvidia.com:from_mime,nvidia.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0DDE16F4B2D

On Tue, Jun 30, 2026 at 08:02:05PM +0900, Yuyang Huang wrote:
> RTM_GETMULTICAST has been part of the rtnetlink ABI for a long time
> and already reports IPv4 multicast group membership through
> IFA_MULTICAST and IFA_CACHEINFO. It does not report how many consumers
> hold each membership, so userspace still has to parse /proc/net/igmp to
> get the Users column.
> 
> Add IFA_MC_USERS as a u32 attribute carrying ip_mc_list::users in
> RTM_GETMULTICAST replies and entry-lifecycle notifications.
> 
> This gives iproute2 enough information to migrate the IPv4 part of
> "ip maddr show" from procfs parsing to rtnetlink.
> 
> Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

