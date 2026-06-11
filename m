Return-Path: <netdev+bounces-298183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7UDUDZXZKmpMyAMAu9opvQ
	(envelope-from <netdev+bounces-298183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:51:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A16EA67335D
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:51:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Re4KqFsi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298183-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298183-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1254634BAAF2
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 15:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021733A6B9A;
	Thu, 11 Jun 2026 15:47:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011060.outbound.protection.outlook.com [52.101.62.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B179347BA9
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 15:47:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781192844; cv=fail; b=l4q82cSDGf0Ib4AsbgUnp8A3dHSjSfGLRG+LgiFMCr+6bX899J3iuZ0GKIXHytgIhS2aUi3nh74eiIlEuXz6X3OZjXFwzc1JvIuyjgbMZTsAx9RiFJ/iTo1RpNHE1pC3WNhCA1+/rJnDyJLyMUhd4Y0S6LPRsmP/KyqVtPz6NR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781192844; c=relaxed/simple;
	bh=XrzCttmZMPAZCVnqoJJh84tQNbS05tZ28ldBxYJ+2Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QQ7DkdvCq5cHBUtDj0WCmce0STsU+D4oNVj4rJRbgyScZS68GgJIXY+9QoUh0oRXWdVV76Vq9khCVxGnd2/OiL2OKqB4o+f/Z6chx/EOHlBW0zpCIo4b18GlibvHVF4YvFbQjN2EERn9WL/cZT6+ORgjlTQBx42e89zT69wRUss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Re4KqFsi; arc=fail smtp.client-ip=52.101.62.60
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OkY4UXF3ibFYfd72CZN4p13V/ikTxu5K9+qDQZxZE2rPh+8J7nFWzAPx/HVbLzTnOvhF9+KWWm1ICxRWhW3tC0RrcBTVTECoYgl6hRh1f4zn0tTb66VdhdgzEGkfmmjOKcFSklKf3jS9qfFGEg4b8+joySo2scTPPphe/LD/bAxLC9Zvk4ucehXjfXOLcF6GwrHyQ9sZdxg1Gnw+9x5gizO+ru8BlNINmo+ZzfvOtze1qsk+Ife3hpPA+8mYca4LPdi+zeCyso8Fcm8quHHoFL68fSOudyGYF5esLn2XoP8DbaYA+3wSk+nmVSJ4sWxNu6SwROt0OsACluRs773P1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuOaKklxgK7ikzK6MkRTypQdDgOIevub/hnMX0rInIg=;
 b=qmPV1fayeHZkCl+re2s9nFyx68Hics8r7VLPlJ2AXO1tyS43LQQOPuHz23ZJfyJ5VS6Nt+QtKbyp67BZYxcA1hHVxCdvWOvl0jaKEbEG9AeBEY1/hCSKdtWuV1sOM/8sK9BORu40znT+Rb0Mq0acFrPQF5LsK4L50Vo/d6LTP0dkq9Jo99rMZRQYNNRaX6rrH1YakME0zdaE7NecWWmG1il9dvc9jFV03BJWYjQgqqqo0Of7SLVlVafV2w5M3up/UW1YuYAgk9PWldHpFWwdFKjIOsr8VrepxMCm01UOm+diwNcae6yiTL8Wt60fCCFTYigaucvvW1atkkO8f9Xl5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuOaKklxgK7ikzK6MkRTypQdDgOIevub/hnMX0rInIg=;
 b=Re4KqFsif/awBCrZyFuEKe8ATTQLHv8J27G/B3PsPdpJQnBzbd0PkYMiW/3PiJ80fl2SDDkqYCmaXKbzAPZNGBJ1KsrlZiIfGGVweaRxSDi+vYdcaPzNXivlYscORpaPS1jdLL++XW2Mczt1a/nyZ8vLIMiXCxKog7O1nDb515CQ+dKG0iZeA1qeNYGZz+eEO4EmaNBUCZFvPfWtvyFmjxD135XdwRvCoDiDikmwn40j8ozK5huoE0xjisl7iQKcvkKC5IhHXYz7DqWPyWeZKvzhMXn6nNW9PvldPy20inxiYbgy1TR1hxMbpYi4rE74Knlzu7knGlCF+t9ef1jsCw==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA3PR12MB9157.namprd12.prod.outlook.com (2603:10b6:806:39a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Thu, 11 Jun
 2026 15:47:17 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.010; Thu, 11 Jun 2026
 15:47:17 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org,
	horms@kernel.org,
	willemb@google.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v3 2/3] ipv6: Honor oif when choosing nexthop for locally generated traffic
Date: Thu, 11 Jun 2026 18:46:04 +0300
Message-ID: <20260611154605.992528-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611154605.992528-1-idosch@nvidia.com>
References: <20260611154605.992528-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA3PR12MB9157:EE_
X-MS-Office365-Filtering-Correlation-Id: 28019fc4-0c0f-4d9e-16b7-08dec7d0b70d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|22082099003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	v+jrNZgVwrbPGXEpBUyzf6onTr4pugVLTq/w4pAqdTZyvg/yHbHs6uM/nX+NmZwow35nIFApYm0Dhco/4lrnJhmz0RchQ0tNK6U0/y5czSzcGNmkTzm0mYKvnaq03D4SasEf2MI55Ogmo275sqzy8+z0H0S2+cGl4t2GHRaQE7STOK8PUc1RWa3Tz8SkqKvuE4mrqibWJbiToSuTOVjK+oEkVyUOT1eTIpCQ1YEymCd0CFGIIFZnlzU2O2OQTfvWjd69BABRu/QdZmr7mwfdoUcWdoO+ZYmbuuSZwXuUJe6pxneehc77xwOmXV4/Q0NGKITzz3wMwL7wMtmhebkgZWKpPueajsLp5nyyHsQ8bX/9yyLhDUzZoHeLlWv9pzGFnytDWuUAK6jbCTGhVUxNXbtQnluo3qo5ShtRefTWv/McPvPVKI0bwJ6iloySuJF9C08pDAViKZy7HZt83BfdYu8m9HW+vk0BpNbhV1o8X5QZrxuk50uq7/oA7TZN4DIEsE/B4M0c1jXxJV9ZaccUi39rg1Jor9z1hpK7P9CJEVkx4naAg7xU81k/A3DrY2VAfnDD4SicIYxTNcrUhzK4guB0rlAFTD2CB7PucTeIgD8ig5Va/jvKB1dtq2YZ1qjes1K3iNPlFavuFF881+b/uAWnqHhw37I/QSSTblM7RwWN5VmWw6mucQNb28qcoe1A
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TC9QCyzBNBAg3kpSpPGDpke1YqU0CFMsbpOwcD2hKf0xzMVOwZ+27uZ6M/xc?=
 =?us-ascii?Q?FhCWJX1DNPfCUDgqT3ksp3KmY1U9l9410ljJ1hdsSirEhJfTBawau5DeBqfb?=
 =?us-ascii?Q?LfKXtSNb87A6lWcJm3EvjAbYYTnHbcdcRWWmUUp1Ymgvl+zpWMGRCRR0g/fL?=
 =?us-ascii?Q?nx46LqSkuxbIWQQ4aofR7ajZTSqqmL+VhxZEvVbhx/p+Wc0Cr5NHK8lo8msu?=
 =?us-ascii?Q?5oKsAjikJMBkdDf4vPTSc/8tVIeWkefK/QP186zEpfdNuf0yg8y6LaSqEzXV?=
 =?us-ascii?Q?0UoqQxv71mxj0sKwEV8UDeAJrIVPceMsODadKdEp7xR2Y0qAi9t6wm9vVAIe?=
 =?us-ascii?Q?qle/UuxmTUjsFPzLSYRvRgz50/vZCBx4eCFqPWxSMd9Zoj4JXplQb11LIEmI?=
 =?us-ascii?Q?KJrH4RrCYzenHw8VZHhJPkJjsP1JZu2KCbiTBgSPtkRyuR9xbtVjk+z6pzfT?=
 =?us-ascii?Q?zN8pii72RHwXCirjt82zk6015JMsKKaxDwwGW8np9s6GjhW+urMw6W0Xkvw+?=
 =?us-ascii?Q?5eS6Zmct3P0FvJS13T3vL3ewdF9t/FIMqhIi3G6220ukLEr344Kob93YQzPE?=
 =?us-ascii?Q?72brtPUlgEbpxTbaSA2rGHdhqKU8av8Gag804BE7hev7Gudmq23rs1tQgdw6?=
 =?us-ascii?Q?b2YqBEUHImseMOZzH+7Qq6HzNc3sAfApt0NeAUN7EwNeI8BFWhlUh88UtiuD?=
 =?us-ascii?Q?yW2F1pjM7IdeY2OQsGEShNRIjXVF+mg5n3tynfqU3qoVTzsQC83BI5WNpfar?=
 =?us-ascii?Q?jgYE4Aqhn9cMgfWj6aXCMD2cb88TxVbObcmoX0AAIlnHVzITBHiExVzQjXAj?=
 =?us-ascii?Q?qOq8SSZ5sZhKcULuUXSO3gEMgeiSou2C8RgjkVdEOz4H5rxZDP+BZwz6t0z4?=
 =?us-ascii?Q?ZCfQ1qFXNehWbQvkUJ89BR5LNAIVwTR28OsSY6OMRZEBpihRHkRsJ5VjK38O?=
 =?us-ascii?Q?5V6HVLlaymQ2JQpkWoLxzvXjr4tdPIt4vJQTU1CYLdnCnC3sYlzw1tgnC0dU?=
 =?us-ascii?Q?Gp3OhSHFTcFFvxq4luxObstZ/SN0kZotY4KhsbCzzyZGIN/CN+LUz4IN3MWE?=
 =?us-ascii?Q?Ky+izVUSoQeBL6zGScVBfZqt3vJj2NZZ39gEAglYfdK/NCFJ1SdCoK4RT9Bu?=
 =?us-ascii?Q?29GubxgKoebR+AS2BqJxGA5GplR6Db71YjyhxEbWqUlbTw40H2SXFXO9TuF8?=
 =?us-ascii?Q?rjoXf/KFivMe1S18rQ8THG7yOjb6ZtHwrBAdX2XOfrZRPvXd3kmY+Otc+f2F?=
 =?us-ascii?Q?oZhBUkkdOS1hlfctIiGHl7E4vzU4zpdlFX2j9GKMFdiT7EyKvx0vQv1QowJQ?=
 =?us-ascii?Q?UO1+rFUs2+ykjgbFsq5FdN3bFmJABED1f3mBc7Poq0/ukOuSMj4cAtHZRtSq?=
 =?us-ascii?Q?VzaaPXhcp1Nr35UAsY5iVnohEOVhDtvHjBGVhTm94PjuNsK3U8rSS8hI6+/9?=
 =?us-ascii?Q?72vQpx1eLu65NEYfe0SmTgFr71eDcUV3pkxgStiRuMV/WVPNNKbHue3uP6mr?=
 =?us-ascii?Q?z0Y2vDYfNJ0HL/12j7KTE/SK7vFCcEIkZhvgZ7uFvLfuq1oJhsau+X9odu3w?=
 =?us-ascii?Q?5Hb5MOMqY7MUhBL+znZDfMGS4V+URwfOUdbdBPS4bDz4tphVzAf7T0/voX0S?=
 =?us-ascii?Q?wmOunf1rUkAsyPt3CvvmWg0uFJzc4uf2Po5SHzCS/jRzoAq6/l4MNhitKe47?=
 =?us-ascii?Q?3guq7fdGvwPC7HglBtQWhAEI049qSLK2MDZgtOe4yQ0GLffh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28019fc4-0c0f-4d9e-16b7-08dec7d0b70d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 15:47:17.3285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9VtWHBToUNxFSwLrPE2uejX7p6CxZvAB+UglJsNMdh/Lc5kWRaGaksVi8HHESDdprJsjJ1xaKhZm6PIHa4kVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9157
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298183-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:dsahern@kernel.org,m:horms@kernel.org,m:willemb@google.com,m:idosch@nvidia.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A16EA67335D

Commit 741a11d9e410 ("net: ipv6: Add RT6_LOOKUP_F_IFACE flag if oif is
set") made the kernel honor the oif parameter when specified as part of
output route lookup:

 # ip route add 2001:db8:1::/64 dev dummy1
 # ip route add ::/0 dev dummy2
 # ip route get 2001:db8:1::1 oif dummy2 fibmatch
 default dev dummy2 metric 1024 pref medium

Due to regression reports, the behavior was partially reverted in commit
d46a9d678e4c ("net: ipv6: Dont add RT6_LOOKUP_F_IFACE flag if saddr
set") to only honor the oif if source address is not specified:

 # ip route get 2001:db8:1::1 from 2001:db8:2::1 oif dummy2 fibmatch
 2001:db8:1::/64 dev dummy1 metric 1024 pref medium

That is, when source address is specified, the kernel will choose the
most specific route even if its nexthop device does not match the
specified oif.

This creates a problem for multipath routes. After looking up a route,
when source address is not specified, the kernel will choose a nexthop
whose nexthop device matches the specified oif:

 # sysctl -wq net.ipv6.conf.all.forwarding=1
 # ip route add 2001:db8:10::/64 nexthop via fe80::1 dev dummy1 nexthop via fe80::2 dev dummy2
 # for i in {1..100}; do ip route get 2001:db8:10::${i} oif dummy2; done | grep -o dummy[0-9] | sort | uniq -c
      100 dummy2

But will disregard the oif when source address is specified despite the
fact that a matching nexthop exists:

 # for i in {1..100}; do ip route get 2001:db8:10::${i} from 2001:db8:2::1 oif dummy2; done | grep -o dummy[0-9] | sort | uniq -c
      53 dummy1
      47 dummy2

This behavior differs from IPv4:

 # ip address add 192.0.2.1/32 dev lo
 # ip route add 198.51.100.0/24 nexthop via inet6 fe80::1 dev dummy1 nexthop via inet6 fe80::2 dev dummy2
 # for i in {1..100}; do ip route get 198.51.100.${i} from 192.0.2.1 oif dummy2; done | grep -o dummy[0-9] | sort | uniq -c
     100 dummy2

What happens is that fib6_table_lookup() returns a route with a matching
nexthop device (assuming it exists):

 # perf record -e fib6:fib6_table_lookup -- bash -c "for i in {1..100}; do ip route get 2001:db8:10::${i} from 2001:db8:2::1 oif dummy2; done > /dev/null"
 # perf script | grep -o dummy[0-9] | sort | uniq -c
      100 dummy2

But it is later overwritten during path selection in fib6_select_path()
which instead chooses a nexthop according to the calculated hash.

Solve this by telling fib6_select_path() to skip path selection if we
have an oif match during output route lookup (iif being
LOOPBACK_IFINDEX).

Behavior after the change:

 # sysctl -wq net.ipv6.conf.all.forwarding=1
 # ip route add 2001:db8:10::/64 nexthop via fe80::1 dev dummy1 nexthop via fe80::2 dev dummy2
 # for i in {1..100}; do ip route get 2001:db8:10::${i} from 2001:db8:2::1 oif dummy2; done | grep -o dummy[0-9] | sort | uniq -c
     100 dummy2

Note that enabling forwarding is only needed because we did not add
neighbor entries for the gateway addresses. When forwarding is disabled
and CONFIG_IPV6_ROUTER_PREF is not enabled in kernel config, the kernel
will treat non-existing neighbor entries as errors and perform
round-robin between the nexthops:

 # sysctl -wq net.ipv6.conf.all.forwarding=0
 # for i in {1..100}; do ip route get 2001:db8:10::${i} from 2001:db8:2::1 oif dummy2; done | grep -o dummy[0-9] | sort | uniq -c
      50 dummy1
      50 dummy2

Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/route.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 09dac3aa8778..c14b078b0249 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2276,6 +2276,7 @@ struct rt6_info *ip6_pol_route(struct net *net, struct fib6_table *table,
 {
 	struct fib6_result res = {};
 	struct rt6_info *rt = NULL;
+	bool have_oif_match;
 	int strict = 0;
 
 	WARN_ON_ONCE((flags & RT6_LOOKUP_F_DST_NOREF) &&
@@ -2292,7 +2293,9 @@ struct rt6_info *ip6_pol_route(struct net *net, struct fib6_table *table,
 	if (res.f6i == net->ipv6.fib6_null_entry)
 		goto out;
 
-	fib6_select_path(net, &res, fl6, oif, false, skb, strict);
+	have_oif_match = fl6->flowi6_iif == LOOPBACK_IFINDEX &&
+			 oif == res.nh->fib_nh_dev->ifindex;
+	fib6_select_path(net, &res, fl6, oif, have_oif_match, skb, strict);
 
 	/*Search through exception table */
 	rt = rt6_find_cached_rt(&res, &fl6->daddr, &fl6->saddr);
-- 
2.54.0


