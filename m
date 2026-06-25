Return-Path: <netdev+bounces-301955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DotuJYkePWoIxQgAu9opvQ
	(envelope-from <netdev+bounces-301955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 14:26:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3182B6C58E1
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 14:26:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=qX1isLCm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301955-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301955-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 53C8C3042131
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 12:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5F63E0C57;
	Thu, 25 Jun 2026 12:24:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0713DB658;
	Thu, 25 Jun 2026 12:24:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782390270; cv=fail; b=YEjRcLKtAE0HZDMu3aFjUr8Abx03LKADHLgO8j2VPA0qfqlW3Y3EXfzOpB5B7qa8oWV4TGmuya/XI5SH+8TnT1FAJ3Z2mX+rKfx2Puzk+oZVDv1l0rJl07zaqEW+C3pb6WieM0lm5vjmdGa+Gh56y+eoPUWu/u4rPxjZLVQUXbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782390270; c=relaxed/simple;
	bh=crRiGgjhpmBfO5GvpCw+9oiA6wT7plhfG9yHTq4EhEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZIvFgI/t3xSZk0Wo2tVgYl0CBpTQFF8G+V00v66m+zLbTEYFy29mtFp9tifYMGBn2D+d7O3IuiZ+5yqIxvF2iPy32j7Kd6AtZX/T58oUXIIdUD0evojYro1ePpaPUGkEYp5iylXvyq/gAgt0OjP4jKCG9WXLdaexQxIXV7jLLbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qX1isLCm; arc=fail smtp.client-ip=52.101.85.41
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WcSmt6ue9YdX+V48Xj0hTG7yLnd0Ped/yjV7B3dy5fAwZVkakkf9aLBGuUQjMSdXQopFCOsiVfLlXXu8fDo0IEKRahf77xo9OQfhWfE66iivOG/vgA/BaAmo0JdR+j5ITI0cYZLqb8dQ5a3tJHGfUwRGX5vi8NiLKCH+9MiNf+gC7XOw/QpjcX97F+KhaXoi78D1/yOOZavAYV1NDc3cglmHuklqRZZY58vZyKGlGGNL/9fiSfn3s3z2soCbtWpGi+zcMDoy+N0lUds2LXF2/x1zl3QUrYoUJQbv5O9Tv1Ys4jxe/CwEab3CoqH6OlBNsk3iT3ATM2sRcNuYzpz2XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chx9chShOM9Dzp1Kp/zHxnKc6SJt1IBRihMti2FEWxQ=;
 b=KYiKKrvsEGNKdg3i+3iwVMc6VVIAHf5rwk5hFpcSTsCZu8U/8g3cJU1o+dBHe/l2ik8tsBsyIPm7oU975FMM8rvQTatrST32n1nj+bbc3JNDi1cfavPFzv6f78mKNR/TtA10VHHEtnxd57LyT9cq5gRxfLYw6JGd3nMp/53oQe8Xb7siIedxdoz0arPQefMU3HcsVfnbrqLhT8AuYIaEYYD1hSMRf1wtXH1/Gw7yyznO/Stf4sWNfuvVKlU9okEHqQx7wnzbln7FjrTs74qXVZ3MlKliVIRY1Frmc1B9DIdy+o+KljK6Ujlz9RFHPWaIIqspoY0Vyvzr6Vb9khxOPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chx9chShOM9Dzp1Kp/zHxnKc6SJt1IBRihMti2FEWxQ=;
 b=qX1isLCmvOX8DgpVMX9YTobxDVP1+Ds0Wdmt0gPaW9f1N4V9FJTwkzMycDaXXiioUtiRVSdcEdwv0lWicmcGDRs189BcJyJDMjF+UoqQsxt86/fvTHNGxWL/0RI9V2ttUnaLakYxID0t2kA6GhfZD4NYVPBHUshW85MgxV1sEEzrn21hTL/ALozEA2ZrTUpaikbgiZNWLRiD5pLhoZvM41diysR0JeiT0lN6Alroy+x4DkSfH+NxSyy/tul2iBaLAChgJ7poFnQRtJtfb6MkMGDj02zywK86tksK22J1W1Th09vBYIb4gBfac/WKlpiHIvorZ/a8lLkWQGYKpn9UZg==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS7PR12MB6166.namprd12.prod.outlook.com (2603:10b6:8:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Thu, 25 Jun
 2026 12:24:20 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 12:24:19 +0000
Date: Thu, 25 Jun 2026 15:24:11 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Pengfei Zhang <zhangfeionline@gmail.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	chenzhangqi@xiaomi.com, baohua@kernel.org
Subject: Re: [PATCH v3 net] ipv6: fib6: fix NULL deref in
 fib6_walk_continue() on multi-batch dump
Message-ID: <20260625122411.GA1175897@shredder>
References: <20260625070517.965597-1-zhangfeionline@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625070517.965597-1-zhangfeionline@gmail.com>
X-ClientProxiedBy: FR4P281CA0318.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS7PR12MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a4daede-582c-4e35-e86a-08ded2b4ae79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Io28GIEbpqejzAxmIfKsQVEIcj/s+Y3kRsgkAunm9OFKgwiUMbe0RqHj40NLkYy84KGKxcE+iLcgCMr2lmoUmz0iMp6Je6cBZZD/c82Rbg8/QIoABlKeGxhH7jhT2zDeiqGz29+PHwUcCILBgpjbGsQg5Q2VV/c+hmJZU4zaf/G5UEM+RkkCQK88p9qJf9928r/xAy3nWNDYy/sg58Q/OpmG7Cwu0d1iR6CvTfti9wAh1TKDhOznRhciSneRDoqD3zqw7ouot1Gza5F+cDhfYhcE7WP6MfX+4pFvHTo7Ct1EJvHr3kCfQlG5i8lcOQBbmaoi2UBd8R5FTdiK3iS+B7UOM0ryqJBr3TmZ6no51NoOHuGXGsyyYHLQPqpwxetYHqdKUskHfpelu9I0ES26f6d1MjA0Cf5cmnV9Ac135LSJCu1RtJSHQ1IgaAnixdWHJc70jBf7h5qXuRulL1W/x5Sk2+wOlkhxPY313FFDZzyUEX8jGlu+4K/9XWPqM5RZTHlZzv2hrGuBHrZmsFK9qctCzERayX3tzcOePt68YjB5/9nhQpkGADJvQii2JxMEylRE2VhYSoqz0TuJPioomXc0tYxz2VBioXFkpSC3P6/O44fWBwRh6/Mb2MxwJZBdPdDXiwBv3GX2cPxv1HojdSBSYkS4luMjXXu7O9o7LN8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BJ0FLkOTP481cTfgUoPKOzCcJ0u4EEDtORIuxvzebIXhZs17wyWfwvSLfwIi?=
 =?us-ascii?Q?WvE9sSqARacXz1Pn001kdsqA+xWwkJkcfbEK7hKQKeYMqjogGJHqJfD3qQvR?=
 =?us-ascii?Q?7skEVUiZyHt81QFy7gqREhddlXtqjQCMKqAqIl4DTCkEN9Nz1eDmmKRUhXu3?=
 =?us-ascii?Q?pqeMFO74TE41uTilIHeQdwO2YdCDqlIbt0qcebFqcaFrbUdqHI9vm0m11XnY?=
 =?us-ascii?Q?ZIg49bAxDpNqKNGBlO8urAZEgjsMFbFxkjHGMq8aFFoeYxFQSJEcZtNQTXj5?=
 =?us-ascii?Q?M+ySYU4wq93AAsAODmK1rREJGkV0mE5SpG/Dueor3F8K8v2cEKZgQgSpH83E?=
 =?us-ascii?Q?h9FALNMrjQNifp3SXSMEZIVp61NCTQ8H35Ebo8otU6MXYs0h7kDPPnd369n9?=
 =?us-ascii?Q?w2oUMptMROuZ3YMmJaUdElRbnbif+t4bGKAKjirJiSE6HBHnvtbf9KTtLhhj?=
 =?us-ascii?Q?SRy6usPFCpfjAeEimS884jP9gzQ0e2pYkeTFiGDSP7jLGr2FW5PF37DQX1Hp?=
 =?us-ascii?Q?j/yzBma0SbuQoGYZKnsPSPxOxTYXpHCumbkittH4+uKbOvfShPZLpbUBTZrB?=
 =?us-ascii?Q?Bh3fRN8QZawcvdiCoLh3E+fnAR/ia296kyYipt0OJtrJUusddjeG8kD3XyOd?=
 =?us-ascii?Q?IWwDbyVhIp5Kum1WAipksnPj396wJ4G5Ytec/uXtz2u/DoR2BCyEHzSiKMFI?=
 =?us-ascii?Q?cfnY7WjlQW8ze9CLWG+gpZAB28LTJDNXITLwwoEj1nnsS4U9JEX8ZyiY2CAs?=
 =?us-ascii?Q?trytTJN32R0I+Bf2UdscLaKPDo0U/D+Nj26h3MT4Su1dCKSyg47KHBwitsNX?=
 =?us-ascii?Q?vwgXULIB1zV4Ijz6GXfPHzUqGNIlfRT1oD/QjO+qZgC8/jMcEigCe5YfVkZ0?=
 =?us-ascii?Q?zVCiP7kNnY6vPViP79SuCnO34pFt5HxT8cM+WOrWqEfd+zR1AW/iSVUnFoX4?=
 =?us-ascii?Q?G782wO1TqbftpTzIjIRnI4cR9XNK+twINwAT40oSqnyvSi/hUkaP9nZELMMr?=
 =?us-ascii?Q?Y6FaRCaiKF/jIjtbL/9AwS99B94JQwB/QpNY453nMRNb6AcikBd0Yt3BkPNr?=
 =?us-ascii?Q?L1Gn87c1MxSdIQITZa6vXjUsHVYvf7Fb9hvcrGTKfDv5vO3zFafJ8p6IPQDZ?=
 =?us-ascii?Q?QLXZZaTxzchA9ZjWk0ltUmT8tUFI32zGDN31r/Oz17RXUs8UMQeEyebXff8v?=
 =?us-ascii?Q?zYcJ7BRRg425psQHpO+F4zoHgYpdcaYhwrQ+acnCvtn+3n0V0Is+E0ed2071?=
 =?us-ascii?Q?xvWz/8pzuaMcGFtXDPUE8vUOzW3O4ToihduxCdG3rPUXBtA9SucIsJMgef5x?=
 =?us-ascii?Q?QALwUABYN6tO+w5ZiZxLbxUnJS6vLKqdRekXYAa9Gz1RhCUQJEHnstgSywMA?=
 =?us-ascii?Q?fMt4FaYkajeal3ib4u7NYablBtgMtKF1ehK0/fl+byZS/5/pkAD05a/1aHeG?=
 =?us-ascii?Q?yW+R5J10+5TNZ6mR2sMTeFCstsSkU6bYoxSQt+BLYOclzOiYILqtfrxATHrH?=
 =?us-ascii?Q?zGZWhJd3foxxHkOq3WnH9FErhnEnAZOPtjNeo2xUfT5JCT//WwfeDUrE6BAQ?=
 =?us-ascii?Q?dh1pYdA7vBmF1obCPlP5ZFRT61ke4Xx3mdmx8EvdMSVlJPrBSIivLIeGNAQi?=
 =?us-ascii?Q?//tHLhN9ehTnNoAhG0DjgDh4zkOSN6U3bcXyTDe5e8r9lXUZPm0HzFM33eHu?=
 =?us-ascii?Q?IB66J/CHRB7kFihhrrgJVoReXVd2mIwu/S9CxXH3Taph3JwZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4daede-582c-4e35-e86a-08ded2b4ae79
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 12:24:19.9025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SNHu9bv8lOZqkA4fveSTNOVOwjhtB0m4DaQ8UKvKlBgsLZF7klEgJ0LleepA/T5KybBJmUDSBK++B8RNq+MNFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6166
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301955-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhangfeionline@gmail.com,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:chenzhangqi@xiaomi.com,m:baohua@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,shredder:mid,nvidia.com:from_mime,nvidia.com:email,Nvidia.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3182B6C58E1

On Thu, Jun 25, 2026 at 03:05:17PM +0800, Pengfei Zhang wrote:
> inet6_dump_fib() saves its progress in cb->args[1] as a positional
> index within the current hash chain.  Between batches, a concurrent
> fib6_new_table() can insert a new table at the chain head, shifting
> all existing entries.  The saved index then lands on a different
> table, causing fib6_dump_table() to set w->root to the wrong table
> while w->node still points into the previous one.
> fib6_walk_continue() dereferences w->node->parent (NULL) and panics:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000008
>   RIP: 0010:fib6_walk_continue+0x6e/0x170
>   Call Trace:
>    <TASK>
>    fib6_dump_table.isra.0+0xc5/0x240
>    inet6_dump_fib+0xf6/0x420
>    rtnl_dumpit+0x30/0xa0
>    netlink_dump+0x15b/0x460
>    netlink_recvmsg+0x1d6/0x2a0
>    ____sys_recvmsg+0x17a/0x190
> 
> Fix by storing tb->tb6_id in cb->args[1] instead of a positional
> index.  On resume, skip entries until the id matches; a concurrent
> head-insert can never match the saved id, so the walker always
> resumes on the correct table.
> 
> Fixes: 1b43af5480c3 ("[IPV6]: Increase number of possible routing tables to 2^32")
> Signed-off-by: Pengfei Zhang <zhangfeionline@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

You should have waited at least 24h between versions:

https://docs.kernel.org/process/maintainer-netdev.html

The same pattern exists in IPv4, but there we don't crash because the
per-table resume logic is different. Instead, it is possible that we
restart the dump from the wrong table and re-dump routes from the next
table in the chain.

I'm aware that netlink dumps do not guarantee consistency, but for
parity / robustness reasons I suggest to align IPv4 with IPv6 and use
the same tb_id-based resume logic there. Given we don't crash there,
target the IPv4 patch at net-next (currently closed, should open next
week).

Thanks

