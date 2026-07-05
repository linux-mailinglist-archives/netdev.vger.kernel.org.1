Return-Path: <netdev+bounces-304769-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LyuYOgFHSmpSAwEAu9opvQ
	(envelope-from <netdev+bounces-304769-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 13:58:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5809C709E39
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 13:58:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=dgaG3Ckz;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304769-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304769-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B36B300517F
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 11:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E548737AA61;
	Sun,  5 Jul 2026 11:58:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012050.outbound.protection.outlook.com [40.107.209.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1FD36CE06
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 11:58:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783252733; cv=fail; b=QnrGjKwlf7nm2eCyEs+Lr9h9J6OM71zOXYDfPYnJKO/NNYluG6+gzCRmBf8ZgkUDS9nz8Y1kuhSWqOZB8UFN4lLqttEKQwcVT8fzYCJuxequkVQ7kAHFd1yjQEciJ12thCR2hmlvqUdSUgy1Iro0kbKpE/0IxTPbJJpa0qtdcCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783252733; c=relaxed/simple;
	bh=YOJiXenBxuiiH9ICP+BLVYpxm2MCF2eoJwCsypuZy+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hUNw4OJzw80BtmeJOr2wi/fNOgQt80rUkru0+LmkH8cbtQi9MzvrN1JWrpEBQpGuzYDopxdP2yqlwT5kgPqxPDQv8QKVy63DmG3vlcASpUvg8+TpBNdgC5P6yOSeEuzm4kFBXW1sc7+8KdgRBKg4DbfM9TOizOhkIZNB1VjKh04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dgaG3Ckz; arc=fail smtp.client-ip=40.107.209.50
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAhRhkzWcNfZteGns1RxkpvO/Z6zINsPcgR130meT8vLgI+hEXT9QSpoy77OVRojA2YjqoQr41zSHWBtMhCtxPN+zPidvl9wjAxM3dHC7q43x5A4qDIL9uAD7zW/P8I6n6G/ReQtaZbg7hC16wJ8k0e9bFFHhTZBswOcDyWW9hAc11MVSM9DamCGCQG/O/3pp1n69EK0VQnBtnAuDQ+8uE5Pi0936MRDnZqULnIXqpcEmvfDIr+By7//zfX3k03QsllKZKd9/j30Papp+f59wwHVot8AZ3OOfbX/E2q11/pG3rhClkbnMa7GZMyNa0NdXZDVf5w97/6dwaZbPqaxyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gR1Vugik4f+lkxkhJ+FdQggEug3Pmt69uctmfHATsxI=;
 b=y3ThAN1b61jQbsUlTfhwtnURTjY0NRUXG7xUUGT6gEmBNMMM/Kai/VwN3NRBr4c5LOH5cdqUWObwazwKSSeOWY75Idhgk2DXUEctXTK03LqpcRnpkkeBMKB16n5IK5DGnoibSlGGrNMAUmyLovAG50y1pAUocS3/r9UAoLHPc8ewi8K63TsU14FJPDTRGpJsXFK1qfwdiMYhIFhUbgUI8Htk5uAA6cUoaezWIe/0fI/FgVET78v9Q9iVjpVX0G+ZQ9NrwcGt67VTaDgWpLGyJ9xKMbHcT+d+KJVuD9pfxcaHtsm/UwuWLvz/3/ap9gds8zS9gnUwK2c1Tuuo9e8hOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gR1Vugik4f+lkxkhJ+FdQggEug3Pmt69uctmfHATsxI=;
 b=dgaG3CkzpGQt49ceahjHRrsWPFArQ+kOT9xT4AWuO1jPP0eazRz0gs2zv/S3FiDUsCyAM2lQib36pPjcuOYuMOFt+muVpw7oiupb+UEsG40vl+SGqF5lzGQO21RrCCnNr4f9K3LWp7sNHU4o+OnUPyIlZskQNcESPiy6rRPDNgR2nqhBLEUHq5WTM0zzfyC/ztQ39ISchEz6bjmTzvv2CF1XfcPhT8kgd1wXkKcuWTHLTS4PWmq/aCOPWXFNE99w3+Z+t6VA40vxFiUbktKRNHkYMLi8Iu1waa7cZwau0xGYvmXkhG3d0S4BBLh0gB+D2H5YVfOVre5vE1w/UnAFoQ==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB7162.namprd12.prod.outlook.com (2603:10b6:510:201::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Sun, 5 Jul 2026
 11:58:48 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0181.010; Sun, 5 Jul 2026
 11:58:48 +0000
Date: Sun, 5 Jul 2026 14:58:39 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net 3/3] ipv4: igmp: Fix potential memory leak in
 igmp_mod_timer()
Message-ID: <20260705115839.GB194488@shredder>
References: <20260704194346.4065071-1-edumazet@google.com>
 <20260704194346.4065071-4-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704194346.4065071-4-edumazet@google.com>
X-ClientProxiedBy: FR4P281CA0272.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: 52f242d2-a42d-4964-d809-08deda8cc58b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YtQoaRIKCFZS70aJaE2wSyev+aCUvPBXuIxqU+S0P+YJVymz+ZAV1wY5IuujST7N4T3NSsvLvvp4OGsrdo/uOK84UruYS0TgX6Mfsw+Vv4WXXxnolWyUXDlpKiK+hD8tqZGgdqAbydJLH2iyN23xD1Pm997xcgqNaQokLscJKU6NiGZeki/vvJVVY1Umhbm4FkGuoaI3gf/i3ylKBNAbitJ/NtgNProvuNGu9D+xFlmHGpvvFmRY9B7M+onbppjQz5dgWYnHQG2IgjfPYwM0iHmVec85DcP3XbqTyapl+rKsHneR73rGSe4Z0HnY5jtIKP8GDYaSChgxMaGhBsPt7GjLUCYJqRKlZTBbmrSAMUg4Ag55cmdXdfoHf2mbWTgXcdQ35NIp6rd6P0PykDtp7bxvOJnVlgl1z48B6aHmz9g5GxL+zRZ30M9IT8v/61owq1Y6yIqsbzlVN+OUrb5WTtGdPbb9mspRBxEdgddCntfYSEDP+sy0lobXvXlLnLBVsyXX9bWm1XTlpHIezrXXVN/zEVjdZ7FC973ehA1s9SykoDSsmWx3L8tCQhMLvB7QFxoxl/PvQ9xs55NsQimbMydBhMLoThsIV+ISQ+RWtei+v2XwGsLNRRQUZfkpIxRhM4IO/iOKEc/wmLt1bZxQAUSTpPmrFLDqxG4o/TIjpb4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1lhtOKLdngusHjFIOi4NgeAh17Morh0HRXr0t4czlQMzv/cm443KzEiMuFyw?=
 =?us-ascii?Q?fOvOqAAT2+HXCLlq7AMXiX87RLTCMKo4qFTECzj4vQ474yOX3g82JFsC0OVI?=
 =?us-ascii?Q?hPPtITaHJgQm+X7YP6I8fPMge+XbxSyEwsbH5Zs8Il2gBqe+xRmz820ewEKZ?=
 =?us-ascii?Q?cstmYzLycNK+d4PLER+onaRvtOReLfVvX5YyOhxLmsESGv2rZib6mhU5kV5b?=
 =?us-ascii?Q?grJLfY/M+TLvjSJszffpZiHxVNvibxmApbXOaR0DoNjON/efNYfWNlzCgf0o?=
 =?us-ascii?Q?Tjks7cGec+8WDWZ6ypBt6K5rLg6xggAoz+Kn3Aefncu7TYLcqJGRb2+FFjGV?=
 =?us-ascii?Q?B+SSjTQ5wa0QaMOcdBtCY8S9ey66ZH3Z1IRh+3qJdT87LXRUKWXQYaHmB3qS?=
 =?us-ascii?Q?XdtCNDJzgg57QUqryT/Surr4or8GkN/tt2QlqlG+o8VAMTl6cqyL+GuHW6Dh?=
 =?us-ascii?Q?aBMUo/YokRPy8OU0hp45ZaVWJccN8U4V8orJwg2xlUMUGeK1bcTP4xbBOvkz?=
 =?us-ascii?Q?i/6EUq192bv0e3IuyxZYduZ2n+MnofPseKtOAYGEodUD/6Fp9h91Ala3jEFS?=
 =?us-ascii?Q?3FLGSHBro+VJtjMXEq/lLczuPgm+SsPtnTAsd7rvLiYpuf2F9x2jjNPqzbTs?=
 =?us-ascii?Q?M+zbIQZdPry29AgQgbN7Ix0To+h5lsTBOCzxZXX7IXCZ43RcyGF3+zieD7UN?=
 =?us-ascii?Q?RaZepg1+L05yutvjcIgpYMEr72N/RGr4QVwXNi3ofNHetCgFU4h4/WrRFhHQ?=
 =?us-ascii?Q?9vh+1geaNuG1EMAnVg9V4LNqkqKrb+dfXAXfCMcJITR2ylowinXxIMZi6kqH?=
 =?us-ascii?Q?Fhxj0MthoPQ71adAUhvCbagqoEfOMRwJ3UtCkFhgvaM/N2DJxOmmLVgGQTYy?=
 =?us-ascii?Q?HVtSG/OcgvnKKgGlzb3/tyFqSr+HUY1WPtRaM1qN8TizOFoRZQj2OZzEyTbO?=
 =?us-ascii?Q?esSKPxcH//BERlX0YX4kYAPzGlNMUgHcXRwyLu/8Ywhf9RQ9vW3ti6nAecSv?=
 =?us-ascii?Q?LhHaNBD05zATo8TKpbrjpQYz7XguNuM+BR3Z1gXZkzU/e0grZoxhMEVE7PbZ?=
 =?us-ascii?Q?Z59rp1uKja99ice8qQsJYy1CCs9VpDIHNWvU+w7SMw297Fg8lZpf+sdMuAAC?=
 =?us-ascii?Q?2BslpDClJYqhMsGSb7hN18U0VwlHmVxbkLtICzvFCCq5E5J1jPx073ESIF2r?=
 =?us-ascii?Q?5OhsuNelDj4DIYFGHQfXgUzMP5LdzHThSrRLG94/zIQXlet9xQfDOlxuK/zz?=
 =?us-ascii?Q?c5BXW3QQ0qCj3p4RD27E2SBWCZv3akwMPlcpNkGCG8/QRbguuC7Zc0f7QpA1?=
 =?us-ascii?Q?I8ZYn6gqxcoyYlajU6iw5BSUWPhulG9+mRy/LKlZtFbZpsufTrUDVZl0CTlo?=
 =?us-ascii?Q?OBt3wEEZfXyz9dTwaQfJOVcH10Fp517jTBjO8lm7UNbeUlKPpmtHebaVMBjW?=
 =?us-ascii?Q?pHb2BXQAppWjc7Zv8bU/IpGwOICZeIyMYAq4Cpjxkjo8hKqdKhKKfT3IwN44?=
 =?us-ascii?Q?Wyu+/hfreIs95qbjqbJaplywYnIKUkC/QBDU/oVlWvb0iyNRuwD2/27D4wry?=
 =?us-ascii?Q?QuVSbyY+5hUzb8RivrOX2O/WFHXN5K+fpUCAEqackki39df7ku7BeDbi52H/?=
 =?us-ascii?Q?VRl+oJxdyvefM72pE4ijvwcjSItcIN8LNyHzGKLX89PhsRrZWt1Qy5DSjrJe?=
 =?us-ascii?Q?fcYWPK1X2otE90YmTjmakpMSihjpssMKpJ0VPAFoefG7q1N7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f242d2-a42d-4964-d809-08deda8cc58b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2026 11:58:47.9352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPHAw0/vuQp3e9W78KONHvQLmSL/RZrKTkCJ80wyQUZ3B6x3aPFSCu7JJHOQZtFDtmM661V6AmAhRnghvoq6OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7162
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304769-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,shredder:mid,Nvidia.com:dkim,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5809C709E39

On Sat, Jul 04, 2026 at 07:43:46PM +0000, Eric Dumazet wrote:
> When a timer is deleted and not re-armed in igmp_mod_timer(), the code
> currently decrements the reference counter of the multicast list entry
> @im using refcount_dec(&im->refcnt).
> 
> However, igmp_mod_timer() can be called from the RCU reader path (e.g., in
> igmp_heard_query() via for_each_pmc_rcu()). If the group im was
> concurrently removed from the list by ip_mc_dec_group(), its reference count
> might have already been decremented to 1.
> 
> In this case, timer_delete() succeeds, and refcount_dec() decrements
> the refcount from 1 to 0. Since refcount_dec() does not free the object
> when it hits 0 (unlike ip_ma_put()), the im structure is leaked.
> 
> Fix this by using ip_ma_put(im) instead of refcount_dec(&im->refcnt).
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/igmp.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
> index f5f9763895641bf86bfcf9fd7fd7b06012fa4ece..2170b33ba147ce4990e3ee71ba4868e8696b00cb 100644
> --- a/net/ipv4/igmp.c
> +++ b/net/ipv4/igmp.c
> @@ -266,6 +266,8 @@ static void igmp_ifc_start_timer(struct in_device *in_dev, int delay)
>  
>  static void igmp_mod_timer(struct ip_mc_list *im, int max_delay)
>  {
> +	bool put = false;
> +
>  	spin_lock_bh(&im->lock);
>  	im->unsolicit_count = 0;
>  	if (timer_delete(&im->timer)) {
> @@ -275,10 +277,13 @@ static void igmp_mod_timer(struct ip_mc_list *im, int max_delay)
>  			spin_unlock_bh(&im->lock);
>  			return;
>  		}
> -		refcount_dec(&im->refcnt);
> +		put = true;
>  	}
>  	igmp_start_timer(im, max_delay);
>  	spin_unlock_bh(&im->lock);
> +
> +	if (put)
> +		ip_ma_put(im);
>  }

Don't we also need something similar in igmp_stop_timer() [1]? It can
also be called from an RCU reader (i.e., igmp_rcv() ->
igmp_heard_report() -> igmp_stop_timer()).

[1]
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 8e2b60dcc183..d08331b44519 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -217,13 +217,18 @@ static void ip_sf_list_clear_all(struct ip_sf_list *psf)
 
 static void igmp_stop_timer(struct ip_mc_list *im)
 {
+	bool put = false;
+
 	spin_lock_bh(&im->lock);
 	if (timer_delete(&im->timer))
-		refcount_dec(&im->refcnt);
+		put = true;
 	WRITE_ONCE(im->tm_running, 0);
 	WRITE_ONCE(im->reporter, 0);
 	im->unsolicit_count = 0;
 	spin_unlock_bh(&im->lock);
+
+	if (put)
+		ip_ma_put(im);
 }
 
 /* It must be called with locked im->lock */

