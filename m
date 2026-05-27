Return-Path: <netdev+bounces-292148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNqIOPagFmqBnwcAu9opvQ
	(envelope-from <netdev+bounces-292148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:44:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0955E096B
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8BA7E30028E6
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4BF3C942C;
	Wed, 27 May 2026 07:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rwuoPy4b"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6646827AC4C
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 07:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779867889; cv=fail; b=DmHK0W7l1FHmv2gxL3tAVpmkzUDSXOCK7wfSlznTT2s+P2xT+PvHGqBBBlK4pVuqBToG0PF5ChCaM0rO/ML2J2YvPIjNN/5c1m6UKtXXCwhdqfGgNxDetPYC7/RIfI1CODFZxFOfhXkW9FXzbr593c+2TQ+fTTWU9olBhKClKss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779867889; c=relaxed/simple;
	bh=A9EHMFZNLb0f2OcbAgtGNFp1ZeB8UjDwlE3sM2olH3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eauBROfw/2V9OygtqjegnIMD0qTFDANFlHHi1QW+kEZ8CacERG5ODoCHeRP3V5SxHHDTxRMeP4slNRa6VJsBjci16URja8nrYBoYb5nqfVXJ2BOxzeouh0C3aZbrkaRl6jX+46PgA/lFSwXox4AR5BYv/Gi0XDQrKQ+bwAFCJF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rwuoPy4b; arc=fail smtp.client-ip=52.101.48.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVAR0L3pd38V31/9fOmot5GO2f6jeekcND/2tC9F9oK+zO4/SiWinYBz2QNU09apu7vAZZHG4EB7qk90QFHNHyIj+SG9NUAYppj8PvV7VR0sH12KjIvGaaJG5KSA7K8NKZxl/gNUXVO4595I6fmkhjOvDVEytWqPeGHBthmrrn6YJYaYlLIiQX8+BZesqqX3xWmqvfFk2wurBZpbJBswe41tXI5+hSkIAemCnox/ya06QrVn83oarJu2fk9C+DRtDfBsO4T5XHe1hkYY/5QdQfsjDxCq4CqP3IN8xaRo9ec1bI1pvs9TckpGH9BY7i7fp6YO3NtW/EIq2lvPJQJjBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxzY2jlnXr9crLvLbDOD4uowyc17Xp3HP85fHYCJfEU=;
 b=r5GTfubLjF/xVnGzZCW6OuFPT3qiIYW/i2hifYjN4MZ4yVYNKI5b8IwYiiqg4RlXS2I9ZzcebMKwwnZ0thMD7bKiRM02HCqdlSSFg8s7b5K7qTtz8vshVr5tgh4JjgopcvIsWU85ZtNElQYJ0TEdgV06vpo7/lYcGcbw6Uls53l1kB2Jmo0AlkCDTiQz9MWrgVs4YJAAQ5wkotYL8KXovpj3GZ26zVBgAphS/aLgYPrY5HD8qy1LNyD70K+ew4jNz2jx83QUCxCJuRYG7iXBQ/4dJPbJKq2TBuz3aljs6YAJ+/b3fCUM2SqY48YH1xt3z+NpLNYh+k60/6c3n0OB/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxzY2jlnXr9crLvLbDOD4uowyc17Xp3HP85fHYCJfEU=;
 b=rwuoPy4btTF4lC55fxSazb6NOxBjt0nEj4glFiygUzwR5qoNzT2GOcep5/886lAf4JhuTC+BfOsSfNRU1Wtcyk6RmOnIckckxa9pZC7lnOOvpzJZN+1itkLazXnH3x3ahYeTTiW03+WtA592AGiNbz+/9rwSGFNdpumBz/b3LEL9qTYHNmUkZk7wywNd6sA9ybjgEX6Rw6EqQZjc/1yLRx60R+zhFDMYDN399olwMA330QG9x02Er3njdXqFlBqiAOv/8ilMsEzT6kdX0IhJcSBXQslVK/UGaSXS6Od4eXSfqoCReUx3NqdacZ84VHnHGOqJHZaajz+nedjZNcQpOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MW4PR12MB7215.namprd12.prod.outlook.com (2603:10b6:303:228::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 07:44:45 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 07:44:45 +0000
Date: Wed, 27 May 2026 10:44:35 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 2/2] ipv6: frags: cleanup __IP6_INC_STATS()
 confusion
Message-ID: <20260527074435.GB434943@shredder>
References: <20260526145529.3587126-1-edumazet@google.com>
 <20260526145529.3587126-3-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526145529.3587126-3-edumazet@google.com>
X-ClientProxiedBy: TL0P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::17) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MW4PR12MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: 330c1376-7f6c-4ad9-308f-08debbc3d24a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	q4XPxGVaGE5xYubX1JLyrYAgQMBShMCi1FTiz7WSWYPkBSlz7fzoXcmGKIOhUWtGeNk/+2WFPHCKA4vvALtuzu3HIcsAbIyLdx7Ix1WmAkI45IHGMTjtwzS3tdSFVVKzN+yo3A+VGGY99GPSSPVLqYezyKOKCvgFjjV9QXa2fjikiEpp5K2ZjdPpecRKKQC2KM5+f18kIUPmC3gSL3SZqdtXy1qJ1i27XDfzmubZ4TabuxZg0YLE8aKKyfGD+YoHwdsmfWCBG8KogcgMj4wtBjvzVfRpNBVGak9wpTOlFRZKG1NYGf0aXcxsOrOMm9wELc3+CXyFOmnli9sZeWB8cHDgDY/MbXRpfa9Tb/Tszgj9+UeRGnM3iaKpAeDhvyGegwyfLsliW8leJcKwLHT8bZM6GWBqy13Jo8wA/T1KxgVtGm7ZELS3cpmUqhxwMgXEDz26LqizO745dnjVqNyiPEY0IriqyLpEfTiKCv0GPb94LlzEVk0NFsWa8BQffDfz1J9gvucteDkUiqNPoMfcVfCpdtM2zFFfceiXfIl38aMvKI16pkJGSDfyPJdkSsj73R78JDkr4lGOcTlfuZOlgFzeThLVyrkJq1fz+z9N8XGpV8s5a5VvC7Y5CSDTHUuGrx0ni8KkhsWpbcd6fmVao45/ofeb8kn5Zn8a1i63m1cIefHCX1MEhpNBORI5slww
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8k4im+KaFWX2UD+FGs3FFCxF/BgRUyCIiWIE43RKgmDThDMKuWkGxTDTW/kL?=
 =?us-ascii?Q?0vLhLjv1xPbC1xxEScIqwxOs6P9Rxrn1udjKMGrbN8KH6gIoErqsdRDutf5i?=
 =?us-ascii?Q?ORgZzDCy8Qd4dbf5lW+gZ54BwZ3Khzupk4fOzhfGSIY49jVrICuM9toLQstP?=
 =?us-ascii?Q?6OcplADoW+CpEyrxXv/cCF6lMRXbQMvcyo1OsreiaFio4z9LOW2Dp2dH3A/P?=
 =?us-ascii?Q?nm9QcoblBviRexms8U9EfXZtOareiqAAyTvOHAbj9kmcjBXb2DSbf0p2ZMVi?=
 =?us-ascii?Q?sx8aqcznRi9t050ZjP92U6S5hvgBzE2Z6jpu8Rzfm1FrGf0kogFMBchyCzC8?=
 =?us-ascii?Q?ugx+LcRWWjl+ylwlkLmP/ZW0GPGPfMC0p05lcs41uBa6zL+ZJJ1wNmJNCUOr?=
 =?us-ascii?Q?P2IcJKXi8XOHw2gvmR0IJRgacrHJFYIgpF70LfpRCSUEcR4c/tMS5r5BfAWv?=
 =?us-ascii?Q?hYJx0RVK3yN302OcGBANvEMt2vx4xZrzEbF0RH8NJ2G4cLtyQx28vcY9L8Fb?=
 =?us-ascii?Q?o5T9QKL26ZM7EGW01NR2hGF081Hsjggo1xp6bF2Q1pTdpvAJVEKnzyA5Me38?=
 =?us-ascii?Q?CwJAs1+q5vY3CvCb/m9kcEwSV8hZgJIjLV2NrDKQ6q/DJINuLa40hdhcdcPt?=
 =?us-ascii?Q?Xm9YCkJpf7vMFRoecU1RJoCKYGvpnPlaoD4/3joN5Bvg7AgDcMKa+bimNqDU?=
 =?us-ascii?Q?FBwd4byn+1HpD8iaSPX+eJJQ6PIUPnzHyvREh+gW4NL7gkif6yOReGqTL7v6?=
 =?us-ascii?Q?sUfZfq5Epqdzwd8ysSV/O0koYeHBt86b7PymP/r3bnl5m/RvtcKH2DhhU7g+?=
 =?us-ascii?Q?5Lim3nGB9QVjnmhLqOzYmkuzWeuD+ZN7DGwrhMBaqtwIJlmRsluSYpACqpoG?=
 =?us-ascii?Q?gwD3w+XiZ2wKn9E3XH5C+5GrFUEFe2/xUyhR/5DxErHh6HEondSn7mZ/Skma?=
 =?us-ascii?Q?z4G1M9FZbrb3qTFR4ay+163Tu0oWppKipVHMWsZWaye4BRkcyL4m4Oa3i8xe?=
 =?us-ascii?Q?mT4/0e91xkjoOyK6o4+grd3s0aGDqtWIG4tN5ZATzV6wCRbvxBQbXZqA366W?=
 =?us-ascii?Q?VMCbIGjAeB7Jtp/ufSJMq+T8DfGZBakJ6POsUoHF2o4bQgrjy3UASR6ERFul?=
 =?us-ascii?Q?nUSymKhlgGD6Gs+pzvul3VaSzZ2xSO2n0KaAYbQqGTKyzsJv32GAiOc/S6rX?=
 =?us-ascii?Q?N63b3wxmyx1xv+0/DP/S/MvzmnBLPmA1lrjCZIY51n+uhqV7tuJtIjpKDD6k?=
 =?us-ascii?Q?rSvMTD14oUFvTpSxGl419bu0jTvpsapGkEndXFe7DLyUM2bW80RNfwoEiZ85?=
 =?us-ascii?Q?pYxpaWxWuNY0KeSlz5a0bIMIx0f/zCqWTljPZYeQ1nHe1E3b0S1ye1R3ZrIz?=
 =?us-ascii?Q?rhmn9+5H+3z3GfiuWgq5Sphs6XvPXrUxZFvfTk1zxInmKJ7dM2CW1Bp5knbW?=
 =?us-ascii?Q?4bzp5OH4/F7yk7dG7maXRrzEvAclzSZPWRR+SQByklmNc1+YhWaYalhPCQDb?=
 =?us-ascii?Q?KCix+14D5KP7ubSY42hzDXvOLfHnwtPGpYapk4geoK2e/4Kq/KZnzMP02nlU?=
 =?us-ascii?Q?kv2Tzw8C3fqEKRrLhqLeSbYHPOc5eq6oHBLRVWQcM7gvX+T2CulaqpoN7viJ?=
 =?us-ascii?Q?DIOoybfIuRJQrPLQo9v4UDj6qKUDWMCa9iOZYnoc4ee4L1POezsK2deDRdg1?=
 =?us-ascii?Q?uGbL/EQtH5RibLfPVcgysUDQkhh54d9SEiWXRj7+xc917qol?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 330c1376-7f6c-4ad9-308f-08debbc3d24a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 07:44:45.5414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y45tRpXcpWxig9ivq3melgQHQLBefXvjtvKtWHmW1ZlkzmoAei8pYz9qQvOFB8A0cw747Nvf6gVUkGyIFkTOzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7215
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292148-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:email,vmlinux.new:url]
X-Rspamd-Queue-Id: DC0955E096B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 02:55:29PM +0000, Eric Dumazet wrote:
> After commits e1ae5c2ea478 ("vrf: Increment Icmp6InMsgs on the original
> netdev") and bdb7cc643fc9 ("ipv6: Count interface receive statistics
> on the ingress netdev") net/ipv6/reassembly.c uses three different
> ways to reach idev in various __IP6_INC_STATS() calls.
> 
> - ip6_dst_idev(skb_dst(skb))
> - __in6_dev_get_safely(skb->dev)
> - __in6_dev_stats_get(skb->dev)
> 
> Lets centralize this from ipv6_frag_rcv() and use __in6_dev_stats_get().
> 
> Note that ipv6_frag_rcv() tests if skb->dev could be NULL already, so
> I chose to also guard against NULL, but we probably can remove the
> tests in a followup patch, because I do not think skb->dev could be NULL.
> 
> iif = skb->dev ? skb->dev->ifindex : 0;
> 
> idev can be NULL, __IP6_INC_STATS() deals with this possibility.
> 
> Small code size reduction as a bonus.
> 
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/0 grow/shrink: 0/2 up/down: 0/-145 (-145)
> Function                                     old     new   delta
> ipv6_frag_rcv                               2399    2362     -37
> ip6_frag_reasm                               705     597    -108
> Total: Before=31455552, After=31455407, chg -0.00%
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

