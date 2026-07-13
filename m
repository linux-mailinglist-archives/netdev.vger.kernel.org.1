Return-Path: <netdev+bounces-307094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TR0sBcmnVGqgowMAu9opvQ
	(envelope-from <netdev+bounces-307094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:54:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A655B748FB6
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:54:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=IZFI83lv;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307094-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307094-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DBE3E301D602
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573693D413F;
	Mon, 13 Jul 2026 08:53:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012037.outbound.protection.outlook.com [40.93.195.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD99B3D2FF7;
	Mon, 13 Jul 2026 08:53:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932822; cv=fail; b=r0wVA1g0el244bM1SnC5jbYDDmvckQ0PbiCWiAxvG7cHAq8XgUAzp4n5O/jU+b86tnEZGb1B01KQD/FvKDa8ST2kP2A20HncYKJNG+GBh1bm7mpYZneMqR7L3ZYOtxwfjNL2rL2qMyQs4ssq5ZvLzsnKoGJ7WHSG9ZjuPtIleBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932822; c=relaxed/simple;
	bh=PdV0FoPtcmAxCo35ijpumQ51RuwCWfk3XCoHIx+bpRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WuNIVh7L3NTvk6raHa5FdF6sHBc3K2jbrCykaH1zDTALLMCxVZCywfonqg/ccfp2KIw94XUo01dfEAaDs72zWo2BJkYE+KKuzQu5xjQqIsAhw/FgRgm6y6ALg+hXP0jzSM7ceIypLvfQb+4KsJOLOCNSe0CgFNNS0vGy/jOU7dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IZFI83lv; arc=fail smtp.client-ip=40.93.195.37
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+7ccXDXkm08FWr6hDWEt3jErtsSqOF8/i3JIuLgtHCYuP2SovYuLduJMf+L88v5BFJZycidp0W+11Ykhv9qgDnYvlySagBzNYneP07N8AEmtVDRkFVxRQ6igoV7vtRxSFCXYtvwTcmF3Lo/B9JI/4UV/AgR+LXeHcOKaE7yzpneH784+ckn2zAFgLKePwvyAjk1dCTejsAqAV11xclM1Vf/KzumcGz6vB7s3MZVEIwe2O5vdv3IqlhUEhqR45oRnfZU+v9sVjijCyJEV6X0d7X/rChQQmkUKD/0k8bIqbZEly6nmfsKyKEcmt/bOhsqXfgkb/wzj1UXkaBfKrrq/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6OUI6Rs4jLqJf7P1SrdiXm4Mj5pO/bdm79Js8wEBpw=;
 b=lAMHGnbKg0M8ZU+Gp4hzeYnOQwulpJp6ivclTYgOGfVjzRvgdJJDAtEFizco8BQcAxCLZquJPZwu/ZynPfGRCrbB6ZBkTHk8q98BkCgKp0Qva9JXSsvcYQB0Fh5N7IGklVzT3NKsFbIyQOfq5B/9+7QyUbO4m977MO4dzKB2X+wcEqrNIleUOcu1ryoMCpm4G0w6dT6FQXELBqT0H5JRzbb3KDYsoAU8KrmyaUgFVT18yCA2pQRqhoEWYU4d5wod1iAc1OixgGPlr+KAYaUnGctnDF5wNjBtiI9BhKW4ox8dpweFeuLukxgDGgj7lCue6BeYivXoU3gZUzjewa7fMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6OUI6Rs4jLqJf7P1SrdiXm4Mj5pO/bdm79Js8wEBpw=;
 b=IZFI83lvRbppEUowwH5D30W7e3nbTArGJaWqs9eZTKzKl3hoAWXd2NUtQNO1WJzWEztj1+OLF9LyxTYB+6Wdr8ILB/JwAT1e0wQBp0bHYpbGXWeVdLZM3W4Xxug4dSykhhaZenh+UYIiFghI3kCd+5H4K5svC6L2MbZjoIH97FfvOKBhLuFoA44HlSOJFdiClf4sKEzajN7l53glNYVz4hVXYvHmT3txuztnxaXzrQqeQeU0Fl7zwCXULyXe5qdh7BB8+YhGoloOS5koVGVU6mIn4V7S/BYEP0tQQhCe8d9ErhXVk6q5wrZtV0gvz7TrwK1EJ9EzJ+KcwyI+7kH/Vg==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MW4PR12MB6684.namprd12.prod.outlook.com (2603:10b6:303:1ee::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.19; Mon, 13 Jul
 2026 08:53:36 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 08:53:35 +0000
Date: Mon, 13 Jul 2026 11:53:25 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: gre: fix lltx regression for GRE tunnels with
 SEQ/CSUM
Message-ID: <20260713085325.GA472073@shredder>
References: <20260709105243.864835-1-yun.zhou@windriver.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709105243.864835-1-yun.zhou@windriver.com>
X-ClientProxiedBy: FR0P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MW4PR12MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: ba224db4-7b66-47d6-9134-08dee0bc3993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	m0P9AuLne3NSaN08aqgzldOJuaCa8m9DCxZi7WI+ZsxUlaiOQxolGIAvq8YvDKRaKk8eMJ6whisZgC9SbAyyb4aIIe0Go2NUo4POsUxV539aVw6dDSpzYzkxrQv37Qu2GE41euxdo7yqnO5pZl15QiO2xfhiakWNJK3XuB8kC67Xw00DGvlAHxdD8sLwZsDi/ws51YNaVNWfrqkhoa9EF60NBtr1LRlPHliyZnMvHFfoejMxMxi5zb2bNZwTaCPTB2PyjoOZYDSdHXxA+vjSgb2iKJTPMYfIoB7UcTisbdPo4b16ludcxbgHtKh78uJdqsp1g9EgVbeFmhMN4cPQJ+g5foqBzAyZGVKcSG+3ZPukg9WnHe3q152iJ904EkfW2BgFKzm+C79uwgSycNtwl5yZoJwyeBoeP7/zpqiIawTi+jhTZeo0iicrNtZMcnXyjEYZyM67slByqrrGJfMrEEDJqU3KVfdF9mRnqQMCdARSO1m4MmDFnaQKdSJxAvrwNBN7WUsUv27GQGmBrM0DcxxP4mHr4tWawySfZR0FgpKx8DWKWM3ZSxLFdBHprV1kCSJd9RCD+87cEbsn5/rT5Z/Mc9GSAwoyEIZCsBus3L6dZHIFD+cGgGLYf49IJCGI9b8s5SXtcO9hpkZ+BZhMT7mAZaNmHTaAXLL7VozoDps=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qeQbiC7RJN1JZy4o5Yi0Vtwba0XcjyEZzuS8F4n5qgC1QGAskCDlK12miDj6?=
 =?us-ascii?Q?s2NeobhAyhfHxUpcZ0PGP5E8Xpq2HqFfSICqjdlvovlYVcJlwy39yc+i/B7H?=
 =?us-ascii?Q?+xecoFkzeUrIwCfcvj+ahPqj4bjkf+fsMdJNwolwj+HdmqhEE8/iMxY3omZh?=
 =?us-ascii?Q?n86r7fdLkbni5McrVwbNyHFB/bp4Azmg88OKuAwgiBLstWQQMbiae9B59g75?=
 =?us-ascii?Q?YdUhpdRx8XG4ixlpLXNhWrAyTzOjM5Mr/D+sdmTiCRPak+k0fElyKQ6Sw68M?=
 =?us-ascii?Q?1y3jJ5qJ4Fk7hEYW2zJUocCz3zNCeP8DSrBBmMIjW1eb222Cy0dwRv2ibHmX?=
 =?us-ascii?Q?5Vc7G+uSeqaXVP79VZcKTVfdfCuvXFRyAQUWU0Znep73K/r1Q6eLRphlFN9y?=
 =?us-ascii?Q?/gayi0aqhjs1ywjqI350WyG17sqURlK3bR3H2G2OAUuLIBWZpAWkN0cQWU9W?=
 =?us-ascii?Q?Ahc8zAc8c4jdHXnrYI4dLaa8m6AxGCTDB2Q0DIzk673hzzdaXsp9FKVn5N1Y?=
 =?us-ascii?Q?tgEt30nWyXkVqJsL3CIZS4c/3+xb55gKCtdaGGHdUy5RW6rIzLJUEplh13Zf?=
 =?us-ascii?Q?g+eKalxLKhDRJvGWa1VcvxR9VUY3owJ1YuYKdgPINm80iWrUgwfjPars37Un?=
 =?us-ascii?Q?hZWAt5o83Tb/7gvMKkhbV9m/ZGppOkrLCMj1jnosRy1EdxLQG6VPg7E8ZVZS?=
 =?us-ascii?Q?ozuXC3/CmlsPw3YZHQkFyOZhPvZsXncnRaGqI00Gp9BKVKfGazgFFaFQVapT?=
 =?us-ascii?Q?MQfrpy8yGEGOno1TmatARu7R3RmRbmeT+2hSk8OmSq1qKhYzG9bDrtLJFzkl?=
 =?us-ascii?Q?YVi1c4cYrra7nKR3F5aPfbSsPvfiFpZUA80IqTiEtox4pK5NPdpnrYqkqAer?=
 =?us-ascii?Q?qGrC150eyZle1d9j26JMayoExMwQiKAQuYJDLWtQb82sR3YBzzCD7LsUcuPi?=
 =?us-ascii?Q?TwGHn5BYGFH5yfjppZ9G3rjLAB1Vzjfv0n066riHRkhy+u1JqcrI6LpBkP1N?=
 =?us-ascii?Q?lkZjrE6XJbHUSl3c5LfovWotZpZjpZtGUF2JF4E24OSjRdI4OvcVi8SdiQYz?=
 =?us-ascii?Q?rNbhrpLN3axOG6djJHz8qiLBQCN5PJcaYmGVYikjGZfL0sV9CokIYr3bNnNT?=
 =?us-ascii?Q?k8p8yfstLICQnzaXhIXUqMELBiJzZfOPi0ZtPy680p9TwfNtN7E6l7UcQELQ?=
 =?us-ascii?Q?MaWo+bSAPseSuo6nxYpzCv7IpWa4LGXWbvC1fnYyp3D6N/WfmlkbZmTIh8vF?=
 =?us-ascii?Q?tNMOMW9uu2V6JefURc0zp/o2CT9M/d8xGNYJALewEGe+v0MiyP02nGohiX8+?=
 =?us-ascii?Q?CtpCMNJQ7rpdLPHGn5SS/gIUEKaRPWjGo5++4GWNTpJRoIBCc6V/r9TGZCo9?=
 =?us-ascii?Q?YLULYG14rXfXiPjHR27ZkgyNpella1J+WiIuahIufOiLt8P2hU/33mjqZ4Sv?=
 =?us-ascii?Q?+gCINnydkMw7Nzvxel2kBaOCdxdrKeo6ZtTZxu8o/gpq+TH5ut9SA6gz9TpE?=
 =?us-ascii?Q?Jw4R9Y+1yM2DmARbJR0U3g9YbzfnaRj10lMR/kUYaFZO7z7NWGMLTXnHIQjK?=
 =?us-ascii?Q?ttcFskoCY0gjAym4kl5VvDd9+OjgtjiPZTZefBGTe39scZK1eabeXYJ+ryJA?=
 =?us-ascii?Q?N0ENYhVsxgARWigknG7z/AboQOD43t4nqPJcOODmq10mBagAzP3zp8CuvslM?=
 =?us-ascii?Q?+shJVC2k2bLy1FGhdYChDA+VfRGNFY1emsAidk703pgSg/6V?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba224db4-7b66-47d6-9134-08dee0bc3993
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 08:53:35.8981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLF7HsvAVomtmRQJZrmABPg9nnCIKgZCr4YkyRXHHkj2w7uLZPu+NbbFjpAQPbCEEHkZWQJ+4oqXQ/ZQ5ILNFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6684
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307094-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:yun.zhou@windriver.com,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:from_mime,vger.kernel.org:from_smtp,windriver.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A655B748FB6

Patch prefix should be [PATCH net]:

https://docs.kernel.org/process/maintainer-netdev.html

On Thu, Jul 09, 2026 at 06:52:43PM +0800, Yun Zhou wrote:
> Before commit 00d066a4d4ed ("netdev_features: convert NETIF_F_LLTX to
> dev->lltx"), NETIF_F_LLTX was set unconditionally in __gre_tunnel_init()
> alongside GRE_FEATURES:
> 
>     dev->features |= GRE_FEATURES | NETIF_F_LLTX;
> 
> When that commit converted NETIF_F_LLTX to the dev->lltx flag, it
> placed 'dev->lltx = true' after the SEQ/CSUM early returns instead
> of before them. This causes GRE/GRETAP tunnels with SEQ or CSUM+encap
> to lose lockless TX, reintroducing _xmit_lock acquisition around their
> ndo_start_xmit. Since GRE xmit re-enters the stack via
> ip_tunnel_xmit(), holding _xmit_lock risks ABBA deadlock with the
> underlay device.
> 
>   CPU0                        CPU1
>   ----                        ----
>   lock(&qdisc_xmit_lock_key#6);
>                               lock(&qdisc_xmit_lock_key#3);
>                               lock(&qdisc_xmit_lock_key#6);
>   lock(&qdisc_xmit_lock_key#3);
> 
> Fix by moving dev->lltx = true before the early returns, restoring
> the original unconditional behavior.
> 
> Fixes: 00d066a4d4ed ("netdev_features: convert NETIF_F_LLTX to dev->lltx")

Both sashiko instances indicate that this commit introduced the same bug
in ip6gre_tnl_init_features(). Please perform the same fix there and
fold it into v2.

> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> ---
>  net/ipv4/ip_gre.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 9fbff16cda1d..8c5ad8ec8d09 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -1018,6 +1018,8 @@ static void __gre_tunnel_init(struct net_device *dev)
>  	dev->features		|= GRE_FEATURES;
>  	dev->hw_features	|= GRE_FEATURES;
>  
> +	dev->lltx = true;
> +
>  	/* TCP offload with GRE SEQ is not supported, nor can we support 2
>  	 * levels of outer headers requiring an update.
>  	 */
> @@ -1029,8 +1031,6 @@ static void __gre_tunnel_init(struct net_device *dev)
>  
>  	dev->features |= NETIF_F_GSO_SOFTWARE;
>  	dev->hw_features |= NETIF_F_GSO_SOFTWARE;
> -
> -	dev->lltx = true;
>  }
>  
>  static int ipgre_tunnel_init(struct net_device *dev)
> -- 
> 2.43.0
> 

