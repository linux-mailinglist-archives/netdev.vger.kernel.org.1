Return-Path: <netdev+bounces-299441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cfc1DunyL2pmJgUAu9opvQ
	(envelope-from <netdev+bounces-299441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:41:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE726864EE
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:41:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=B8G9bVCC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299441-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299441-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBE8A3016BAF
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83483F23D5;
	Mon, 15 Jun 2026 12:39:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012016.outbound.protection.outlook.com [52.101.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08C03E832B
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 12:39:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527166; cv=fail; b=tgMGtqPIQXUHe7jvTPbtoaVL6eWWtMJHe8D8NwWHwwJ9mgNmxzXuJvNaE9zVJTND7oO1wd6tC7+vB3BsOYzvarHTEsqad9oLj02GrEpfz2OcnexB6k0R9vXbsoUA7KFLApMhOAs7fyn0wr0IkDG6TPNZ5/dlaDLKW5fhJFwFJ4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527166; c=relaxed/simple;
	bh=dQsSZX9hJ9Y1V1uQHUW/r4dhgtKvmFghbYTPsHcMv1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VNI8JUNDfLbKAvVxGHssguZHup+KktA+F0q4lTstHAwQH+Bb0ZO06ajwAe73KdT0Gtqsx/livE8YCfsRfx1qVc4SyAVTwlCRiCASLTll3Uw5p0C3zj6fggeZ31APvWT3cpr5i+my4vOP9fEhKhrnqvkYOlff1fQotI4yrYG9uHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B8G9bVCC; arc=fail smtp.client-ip=52.101.43.16
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gj/vFgmd99mGldGJW/L5cAfJy81xI6tltvRoSxgZYYmNYqYrc79yOjZfgWtJzKEKL7cU0+AYdHimthE0xS/5p28EDg0B1TZ5fRH9xdO6RlNnThuSVXYvGUdhcEk7tUffmvOI2VGIOSABeXsBx3TdiWQZ0Rs7WGmIlYS6+y39dAoYdwZ5tSom+kZj4XVGXFyl9uaQ9Z/jhiYW6xw+UPtVJgZ2eFNwYFvWPa8acbQB25x1aCnpqbB5Yb0f2SQn7nVhPlzhql5RwnigyoXm6p1YBs1x7I0agHSC+0ss5IG0P1TPNMvcmuB/a+b4NcGN5NAZ3qMGswcRjBwsJ7/DvzPrpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HuiHCG17glS5NGbxm4fdqAr/5HcJ68uaPfUQ5jWKYI=;
 b=l9b7piLTM7Z65NlhVZDSIQ/C/C3RLF+YsDB/CCI/8KYTlXMe7FPTZrP0TXYBubkuYthYrO9IVBHDCO/86hAS2r+ZVBzrtKEDNnAf7hGgFid4lFvqqlz4+L+Jq4rA26gYrT1AvYlaSMFkSfvTR/2+QmqKM5J1/l3YtueU8977UdbdU9EWd3DeLQ0nXHgCaBggUbEkOM0Bo/0CDroGCOa46D1tACzM3+I0UOz50x4t38J60V2jhIdpCLTF/h2Fkk7HWJpL2EWPifxnOXsPCqlbkCjSZ6y6vEdHp/bj3uDYKGDNfIzNQYISUvo7iQmLYB0h+ZHv143Y0bTm+8SFIESYCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HuiHCG17glS5NGbxm4fdqAr/5HcJ68uaPfUQ5jWKYI=;
 b=B8G9bVCCABftvaGyUmfDgZ/L9HLbxQW9WFLmdaL9iTcY9EpVAgrMxsquKBr3K5JU2dndOKpEuDgNAhoJOkz5UPrnXiu+zWllIfSSYsKoYSBNCAwM+2h9qT0wktUFIiQkE9tznLdtfzHZh3I5XaD2hIOgITou5JL/F7vBYYcasCEo5battnewQWyTJunWxcUkx1EoWxntVBthoJU+YlbDBY/472P8ArCCjBQmd3BkYN6TnmQyoiIndqXa7uL1MmvBE2JBZ3zMK+w18vGyRvSktvHGLzDInqXducBqsqyAsobvP9AZSr5owdojdVhZ3NkFLXIC25FsL11pZ5eaffOjmQ==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 12:39:22 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0113.014; Mon, 15 Jun 2026
 12:39:22 +0000
Date: Mon, 15 Jun 2026 15:39:13 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 4/5] ipv4: fib: Avoid calling
 fib_trie_table() in fib_new_table() for dying net.
Message-ID: <20260615123913.GD485439@shredder>
References: <20260612063225.455191-1-kuniyu@google.com>
 <20260612063225.455191-5-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612063225.455191-5-kuniyu@google.com>
X-ClientProxiedBy: FR4P281CA0271.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::20) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BY5PR12MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: 380b66e0-0054-4c91-623d-08decadb2084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jN8XENEcIMwSn0zulHI+c82vTHxZ9E2+kL9CbW0JrtbAJ7HT2/rHafIGD1jc562CWkThtskKbTA+vhfICmgWTHSg0uUpe0jcxjyg9wfDR6bm2ei+/llWQCM8VSxRNKGOOcZ5Eizv3drRcQr8WgTizHAHfNaCFbe7NN9SBzLOGCO/AQrnMLF92/7hAjQlTqt1fZVOxcQm8gbBVkZCcANQG9EqET3Zzc/aVBjC/a3gR/kmJ5grzM7C5yezwtLTL2CrqAAFJI/L8AX+U6h56f23GTwWEr7a3d6ETu2fW1r8l4gZP+Ecbr4DZfkWqNVMlJelmO1eU9M/fRizKceXB7sZHRZR2XiicZ6nwzR5aYnufUwCySS5NlG5X+H2dHRRVazodxaLxyr3478ExYcrarBv4nRPIPQHDxbgYdpXUU93ldxcv8nJyN+AIB4mPw9yGpOSSZ+u46h4bQt+daYDdmWR5oepGh2XyMwW6FfKlgwuZjLeETHlU1E1U7oYPz0p0dH9HdiT1gerEGAcL0xBOzAZxdpr4fXi85/o9iGOlLCTS/12LT/q+QGViSyqNNPK3HkQUax4yGR3U8Uq1AsuPRYfOrCXy0BdeGEPwKnyYOKqcBslXj0VShsbEOZxVqU6ZezDyk+dCwrlDh78eaYUY7giyypeUl8ki6lRtWsvi/C3Mdcqtd7SM7JWwAlphSKzGLQr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5X2ZHrn87v4TQ91tTVrvgDEwYH8dDD2d2oAoOpOO2ENZ+W2zyxwiwz6No++j?=
 =?us-ascii?Q?2sp0yJwiGcfU3YrnvVSFTc8zhIlfpsIyHiOdMGbxBHChkVMmoNYae0M0hH2d?=
 =?us-ascii?Q?0m9Um3iKKocQ7wmoGkGz4teVcsLx43tAzL8rMI6mHMd7ZvpIFl3LAUvUvSYw?=
 =?us-ascii?Q?sPIlRYGK6RnDOWcfN5H2ym3Ki2+hQ7JT1oJ0en+IK2Sy35EpLK1K2OnBKqp6?=
 =?us-ascii?Q?d1Esk8uMJkJemB/ugknJe4u8GRaix6zCusf1Ztd7O+PerM98Q9wSx+RNpGx+?=
 =?us-ascii?Q?yRzpu4fHIPakNNNy0g6DRfTInjhW+LdDhhjTRI9ERkp8Wpdv6hButtMGoB3b?=
 =?us-ascii?Q?Af1lhEUgvkuU1+vva2NuVbTGfd0Ekaolkla9NdbOIs8dqPlqIwugdSeT1I9z?=
 =?us-ascii?Q?peC1zwls34mJQ2ZehYnP83hbHm84BxloNDwVfWGGLmtP9ZuJ0/ILqTx+1/r3?=
 =?us-ascii?Q?jFOsv4yOP+yHUF8N1DO2O8518iWLOWLxCoMQ0lD6hawMrc23i8fhK5GE1YWn?=
 =?us-ascii?Q?usJxb34A9eDe9IUItmNKuMRWTZqp9J2FaEWC4A8Fc9rhyV/z1GKemuoHtdDh?=
 =?us-ascii?Q?VVfOyAOEjRUROXcRnqbnLSJqqz/ci9fZ6GKvmBKB8DKbS0A2qdg+nEj2iaBg?=
 =?us-ascii?Q?TY58098rm+QOwcEwtWy0uK51XYw5UpqhQAM3XBdFO1knyiA1z8aHXToJl8uy?=
 =?us-ascii?Q?zgZwls1yca2g0HXgDv1zvhMgZagcOZEkIzkATMHlwRRrHptszmaD34NeXzQ7?=
 =?us-ascii?Q?8jKWKudGkdXQXmuD/4xb6nxPQSv3AC01EV8WfUE9R/LYFr62z0pesCK0NV8g?=
 =?us-ascii?Q?zZ8j4Rsb1G92WCBo5jEnw64SqMb4ivenu0xzKJeMCo3xrkL31se+6dJdKN/8?=
 =?us-ascii?Q?xJ/Ptmz1aO+rBiznbDpwWnhNXbHpl6fwfEMqOCuOC3r3vdhEksqGZv9U5zsL?=
 =?us-ascii?Q?eyhpsfAybuTwv2mvGrwhPqpMZRCxp5CD8FU0zLhCV5C6jk3fI/DHbNvoqR6a?=
 =?us-ascii?Q?E397Z8dt7rVt8dIpBkDvfd+X6HYY9YXe8OLds+bJ+vg/BwTk/VR7vFqwq3o7?=
 =?us-ascii?Q?VmO+zu3qaykQgeqWs6NoFeLOsdSZxUZwfJGxqMbsn9Bq3n9sVfa3D36oI9a2?=
 =?us-ascii?Q?roXO8hb6ef4YUAOhJxABRB6ywIMLfxdlzON7K16Urlq9NPJZCJmNl1k7btMu?=
 =?us-ascii?Q?ClRByArnt9yH1J1rg9NhvKaDSa7K6HTlOFknC90N4YbqvwcTpZdPE7x+XwoE?=
 =?us-ascii?Q?w5zzWZccHyRDlEdWMfYzrT0YVA/NpZP/UWE4A5FhRsfjXjJoTGlzF3Hm4vKU?=
 =?us-ascii?Q?ueK/1dxnFHa7eOVtggJlPr3rmaZhmpknDl4HCkS8MFMQP2f6wGsZqSAiTVWI?=
 =?us-ascii?Q?4x0vtYzTcO8nuFcv9R9ATUwejzeZ7u4IMPgh7stl/Cqe4YczZ4OPEnYisb2P?=
 =?us-ascii?Q?lPlOTHk/VnjMiQG1r3IcGIY9v61powHr/wZqwqxKc6pD3K8r2J8e+6HwaT1/?=
 =?us-ascii?Q?YMhq9jyxz1TM7oPqUt9hS9CcJqHU44ng5xF0jwRJ63coex0YrHokrkrPA9UY?=
 =?us-ascii?Q?xtVdwiobT7MzbJ1sMLnof0F9R2RHZA+bPcAmuJPTfI2VtGvoGAP5VIeBrgQu?=
 =?us-ascii?Q?1QJIA8d3EI8Pij54xe1IkDnz3F8kjREWObbwiYATMDVZsACMJIQLTj+LmEhD?=
 =?us-ascii?Q?BIR9ixjCQO8gQH/1k/npkqyh8m0c2EXt6qzo+OR1WBilPLXm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 380b66e0-0054-4c91-623d-08decadb2084
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 12:39:22.6733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 41yg/4m1Kjq2M0bR9zOoKa7XNGQXmd6hxuZeCUvUFCauAkgrnxj2+38eVO7Z3zvdwwBh2t06ubEx8EZzGl6xNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299441-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:from_mime,nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim,vger.kernel.org:from_smtp,shredder:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FE726864EE

On Fri, Jun 12, 2026 at 06:32:07AM +0000, Kuniyuki Iwashima wrote:
> We will call ip_fib_net_exit() from ->exit_rtnl().
> 
> All fib_table will be destroyed before devices are unregistered.
> 
> During device unregistration, inetdev_destroy() could call
> fib_del_ifaddr(), which calls fib_magic(RTM_DELROUTE).
> 
> fib_magic() calls fib_new_table(), but we do not want to create
> a new table after ip_fib_net_exit() destroys all tables.
> 
> As a prep, let's add check_net() before fib_trie_table() in
> fib_new_table().
> 
> fib_trie_table() is also called from fib_trie_unmerge(), but
> fib_get_table() fails first in fib_unmerge(), so the same
> problem does not occur there.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

