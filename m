Return-Path: <netdev+bounces-307240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ESh1GPEMVWqejQAAu9opvQ
	(envelope-from <netdev+bounces-307240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 18:06:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 257A474D6A3
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 18:06:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=bt8FwfYg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307240-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307240-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D0B530812FA
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 15:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F235D3090C5;
	Mon, 13 Jul 2026 15:59:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011034.outbound.protection.outlook.com [40.93.194.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E10305968;
	Mon, 13 Jul 2026 15:59:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958357; cv=fail; b=lrREPAnSCLweWwm1U+8N+FNAtYC95LAsGfM/yQhC/qfKDUja9MiGe9LKmmrm7IGrD84piNQrB8xyeEKYkhZvo+HXxO6W32HDejs/jI1CD3OZ9xsX3wRbhwmrXNyOVkBBBfJeIVO2uzpW1iqhoOaATlkqaIA9IKg2B4U9+MbmMvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958357; c=relaxed/simple;
	bh=xK5WWgCGQfgSIliWxWJ2UyTuhpBU2T6eG8UDoDtg13M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IXujJxoZ5IPgNa7Zbe8MCXMUfBa3o0JFY6HrDQ/Xusy3o8ZeKc8aik1IuEorHR+Icyu/eetdtT7NfAH6jaQB2BY/8uZEnpe9XLTl7zZy60krnirtZs+L1kNPeFLINMkmsdqtWG3VLkubu+qsNcQFpwr5XnQPAFg5MGFUYfyNV2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bt8FwfYg; arc=fail smtp.client-ip=40.93.194.34
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3pHrVZcQtl50FtD127X5vVIp5mG4t9XBJEWM5beu/m3Kty0VVAO2MBmxZXQ2yPOhojrrnfrwa3ZRFPPrg2XjtVkECc/2kJwJpDslTm/+mlg4KqwkeolYIiEWxdQtE1lTZGenR/W/+DpJ+4ZzlLDc6V52RYjdw6MH93JKuQpKnOPQrOYalHspoashazs+uTpl7Xvh4E/amK35ysF//eA5sB9nTQUSpZ66IE/OIJll4afafgcR40s/gwQ3kiCSl7sVjgz/fFTHJ+ZjR+M/iOVi4ZfRUWsr9clvgM15NdfUeQQM5ZLbiI4CGsap0sq3rOMP28VsLffXMZK+viQoQdUCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHAiymX8sJo262ckLIamJx9r/ZzWtQEKGOv+H1mX9rg=;
 b=SHTFbYYWO5F3S0ca4ukhBy3c6Aq3QFoC9B4OjQiW5cT+wrgI23cSTnbE7kv/4ufjCafgihSI3pBdp79juB/uhqpYANaWGS4s2fs3XWfqzk7YOG6yctoXUOQ2fIPZY1/uE3Oc7VSk7AgDN73DCqsulXAUXqyf7/ejOhnGZ2QxocVbTXtF2RXumQPKWASkQFF8pWDAUEJByqZ7jYY/XSGJ15qiIIEI9cmW9BtS2q7e79E7e5m4MILg1hmq3YJ0aeDou4a/lod3ESdr/HgqXDNmVQBIlyEmWpkkMZiYXcqKEyNroktA+lTZ9bTDjIQHnOYVhridOTucV/8fDXuNBmdQQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHAiymX8sJo262ckLIamJx9r/ZzWtQEKGOv+H1mX9rg=;
 b=bt8FwfYgQHbwI8jIPzsPVBQ+tKtQqT0y4LmL8SDZ0kscLbbdfEUwvpFhwRUfRIFv/wLQ606mf1goL9L+RFpd3356Tm007OtqRlmr89BSah1WJLOwwDknURKqP7OdhzbB6X4stzxmKBoOvjyFETtd2LGMaAMzAKz8dY757TgvviTtzOAmjDr57Fgt4hlWwgH7SEnhKUijFqoxZCYM8IfpB52bnW3NDC0m6ymcSxaIuISH1JNZ3rNxMQyKMVhu457WyvSShVjLQa5mlJa5venJe3/r3ZKwGKp7c0IABvfSjRZlIpeemVieH6729wHkmW+xMbFqBI1CFPNC2VnAVUTD6w==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 15:59:11 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 15:59:10 +0000
Date: Mon, 13 Jul 2026 18:59:01 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: xuanqiang.luo@linux.dev
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net-next v3 2/2] ipv4: snapshot dst.dev in
 ip_rt_send_redirect() and ip_rt_get_source()
Message-ID: <20260713155901.GB656327@shredder>
References: <20260708060537.17188-1-xuanqiang.luo@linux.dev>
 <20260708060537.17188-3-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708060537.17188-3-xuanqiang.luo@linux.dev>
X-ClientProxiedBy: FR4P281CA0412.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::20) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY8PR12MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 82041767-6518-4f77-aa67-08dee0f7ad6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|6133799003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	V2a5FaOztpZhLLZab+NXHiL689Y6sDDNWL0WaGQ228d1hU3jKyE96MlXlXlc0haliL+d2PBfxv0vnHve67A5DyWGKwg73gTubjndMDWJmUF1PxBbRWgRmhW7z5NbKeiLQOdKdglK/LRUCozESb8Y9EJ505Vhevv5n+Pah3OaK1Hmy2d6XC5UbOGhbDOjGdnXTkUA3wyW8lE5cYAtiS0+btMHqylo9C+WvvOoyse5HIMDv+qiPabU5FwKksX04bISd0kTowz119kOpvl8VwgEVJ2NC6InfC+GH37dbFl25QsB+TeIfZ4gb5u5Pq1knWB0jMyKqRpds79BSHSHmZ/JuSX2t4/E6GjEhNtcp2fpWEVm3D697eIkg/8z4tnOtcDznl8WdMS1jsLmn4otBy0Q8IeYLF/O1JgHRSUsdwJk5o/35LRxsJPoJc8MKfZBAvX4Q09EvXRuBv8kpJbRFCg5a28IsMuEaHSzjZUUeY1+JcQGWVUhXXfsc/AGgpi04yg0trWl+2B5wyPmT2UqCL5pmBQ72ekUVKGbgGNpeyQewyoar+thiy81hmTRnTv1omcNYhohlo8iATJf7hzh6rLy5vcrsPKBRkUJFlMeZIA1b61x5NRlsuuLJi1m01wlxqO8YRcBuvONU4FwC09XUj1g4c62y+qZ+o0ywt7z3bfqKL8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(6133799003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k57qyPvHFTK/9PLqk9/XxQL/h1JHkRWjxXqeZSaNPH7ntSRZCJfwRpXsjrfh?=
 =?us-ascii?Q?AF/Qb/CZJvxOG6PwCd/ayVY5uuXdEu+Af/bbD515uG6UMJmf9kh3Sv6wY8zr?=
 =?us-ascii?Q?B9uqs4rEirDRJ+fdBaHNiCQr6hfcAlqj3F1M0GuViS6sq3D5Zq7sY0jSpy53?=
 =?us-ascii?Q?aXFp+4af534up5LHesu+3dOIyhzPcBAeP72fzaavSvkGIbp83KnZ/JGdqX/c?=
 =?us-ascii?Q?C6sNqalvgpnsxxHyWq+PJ+J4734sA5IpHcJ0nDTAlFLTqxYT1abh6VuyxXBT?=
 =?us-ascii?Q?NVNYC55cvBIn0IYnsVH8XKWXg1NeF9t73TDSconaLU1/iluAeE8xLd0JHjcS?=
 =?us-ascii?Q?nJWMuOeDa0d/XRoxMz4lciFVLfe55Nynnhs+IohYGzktzDMQkVfonJYNs+Sk?=
 =?us-ascii?Q?rYxqxXAnzds4sdYPfmrbO/CsJ1fPnj0xdNDL0ZCxHlfZxLWO1gGFf7UoLElJ?=
 =?us-ascii?Q?W9k7pqZzNWgHH9z+bpbjq7JEBRu2Q3zLei98yYMyqY9MeH0dvuC/YqtpwZNN?=
 =?us-ascii?Q?twQFQrwZdZNgnLvz+LU2qH8fvd4KO/0KOTvbKO6hgKPq0YY/HhsueuX7pgz4?=
 =?us-ascii?Q?hxbYt9Wd9doltwRZbQOHniJGSAZnx4EKeCtXUqgCKn9VeA5EMlW77tJPQYXt?=
 =?us-ascii?Q?9McjSN9l3M71F6r4PXlkIPOsL/JZR7mfXLkEpAZ+wCkjXH+tyBoTqsu/qTCj?=
 =?us-ascii?Q?QB9nBgGQd0Rnz3GCffzf1IWzbP6CGS7xp4HIBdfOmE7hl65rUdScHkmgf4Lf?=
 =?us-ascii?Q?vs8CvquE0uG89VHjIPU41XqBGcIA3RbHJxnQv/6/+fpJaHKJABqmDy2+QVEp?=
 =?us-ascii?Q?z9aSVF97VYilPWx59ONTI32XcgNP0Q7qLzdoH8vampPPxDY3itmPGnYgOVUG?=
 =?us-ascii?Q?F+/bUpHyBTqW9mB+zzk41KxdzPibo/2UblPm+fkV+Rz9mTZmT8ztJc+V8MP4?=
 =?us-ascii?Q?gJVxfR/NRugugnBmGEzgmsAv1q9HMm6OqVD28i1ovZ5ngcxVyzTDh/RG5Ugh?=
 =?us-ascii?Q?n8Z2DU/ERl6KSM/m3/a5B6EDpNMi0GwxD8ZC1MDY61r1+b2T0umKElbd50ow?=
 =?us-ascii?Q?NzmxLuBpR6QfFLpVdR2ofatWONPUbntsaI6JfXWUivCE56P5795RyjPY//8M?=
 =?us-ascii?Q?BDssKrqchqFE0/RtmENVAU70Uc2cAWeN7x/NevJ6IDfeXCiSBpPi1aMPuhK9?=
 =?us-ascii?Q?0NsXHq/gy0Vjxxna8zEkYVYjchWmeBlifuE+YqE/6iAaoBYjdomqcEu6wndj?=
 =?us-ascii?Q?Sm2I9jSojMgXcT3sgUgGVYHib1bGLh9q0yPbM1ijB4MaDgRGhRffd58o3BZa?=
 =?us-ascii?Q?q9Qy7iRzsQoEr1hJYCqlIMoZ4wi7T0BKcfxejLc6XbKbkCRwHOe7zgd5/iLb?=
 =?us-ascii?Q?+Oncu5vKpYBG/PmfmtBZH3Q7Qyr8G5tGT6dLkA6uxlteok1eW6YmAUGdGsJb?=
 =?us-ascii?Q?zeBej0Zj1hibeFX4ehpILawvQsEB4zFU5ikU1wNYJH30g0+wjOwdaMBVeFir?=
 =?us-ascii?Q?EyY/Xdvt5zlRwnRiLhEVcKAFHoMprs+WLsFU39HeSzsPGosEOzH3jOygpiVp?=
 =?us-ascii?Q?Dk3W2qgrgRXKRoqPEOcMGAzHRxCVT+qdHgkcmtlzQC0WJfYUW3s0/E6gH9Zb?=
 =?us-ascii?Q?e3wKrF/I85fJ4szaypRcSkJyYpPttEzMwMf9atEtcksJvfDvKYFM2TbUChf3?=
 =?us-ascii?Q?GBP8LenQioCMEoIkB1qGgylb85t8i9mwL2D+pulv470P/bpK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82041767-6518-4f77-aa67-08dee0f7ad6e
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 15:59:10.5726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9TZ5h0S5nnNWQcnhbwYjDerfsanCGDxYEDLTJfNe+s7hyR8m7iTk1vkL+MjJirvP4ML9fu/199vzJppER0Iyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307240-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:xuanqiang.luo@linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:horms@kernel.org,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luoxuanqiang@kylinos.cn,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,linux.dev:email,nvidia.com:email,nvidia.com:from_mime,Nvidia.com:dkim,shredder:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 257A474D6A3

On Wed, Jul 08, 2026 at 02:05:37PM +0800, xuanqiang.luo@linux.dev wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> rt_flush_dev() can replace rt->dst.dev with blackhole_netdev while RCU
> readers are running.  ip_rt_send_redirect() and ip_rt_get_source() both
> read rt->dst.dev more than once and use the results in one operation.
> 
> If rt->dst.dev changes between those reads, the operation can use values
> from two devices.  For example, ip_rt_send_redirect() can use in_dev from
> the old device and the L3 master ifindex from blackhole_netdev.
> 
> Read rt->dst.dev once in these two functions and use the snapshot for the
> later device accesses.
> 
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

