Return-Path: <netdev+bounces-298182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5o6qK4PZKmpJyAMAu9opvQ
	(envelope-from <netdev+bounces-298182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:51:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08418673357
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:51:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=rux6Jrit;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298182-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298182-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7279634A9397
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 15:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA612368D5F;
	Thu, 11 Jun 2026 15:47:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013061.outbound.protection.outlook.com [40.107.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2A837F8C0
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 15:47:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781192838; cv=fail; b=Rad2/LV9EbRLm350nWWuwT90kFx8XoJi94bmi42WxuSdjblkYqagUcmK326J7XCBjTsThBY/lR+iQSaFe/QjeE70KfVOMJa2bOlWV9ZBt+9hNsibmFVgx5UBUmfB6mRdJQEA7x0WBAoJMKzIwDPategreDGcq6xPAlmYHBWfDKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781192838; c=relaxed/simple;
	bh=C6ZzvqqkXjcVwvkXOQBG1LRV4wlnCgaYKLJN+iAcKf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oaZ1X/dwv4TY5X0OyQIwKKHDyHCZno3XGjbB1TDnwlL1rP7uKwx2bCYxCCUF3qOWUFibt1CB0rym54ZI4p6Bmii9Us7/7DOuqqCdn4dORmNkhlBcziWaGPx1edFaeT57wej0hYh7H8UJHCV7SF+GP/v/Oxm6xVXiF6pFStTQ7hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rux6Jrit; arc=fail smtp.client-ip=40.107.201.61
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySiA40dRswZozFYpTvP7w4SyEUZwIEURvhYKoly1p5z2uTfHN9rjKo5WthxbUv5OuDOyJ7wIANtIBQnZpeoLJXL4T1NktfZZWl+G29AHN5wbnDVOWCqnG9uFng9eD9tS0iX0do+Jbjf3CvHil2mVUqnWqI9Ep1Qo9W6c5frY3RYWanVpONnNhm9ATK8Z+aD0Kwqo2huCL1cAxbZvE2iH9A3wSFwU7MRbW1ljxkfkvCCfX7vN4JdfRlV8QYdPGKFEC6MBNMjMZ0yUThyZIZG40B52shvxI/jiJRCBvK8KeOgIuaMlyKwIHQp5mKLqyhk+AX9Q7zdLOJYt8F4eQEs1pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GPhF15kLZYLuGHxvABqDAemhmGVkZ2+9xhqCrL87ZY=;
 b=NyAqxiOkizmFNhJJVj2hsyfqT3WuVFOeQp5hESBBcdjYPHw+26/2kaYynDS96A7x6Z7tX2cJmB9l6zcXcXqtGQxPaXG9FtWh4fdDQBOBx0Ck52fWAlATARE7CPCHuwcB/x2NhsWZQS2AiZf0EnlMrLbQbb8ei4cRnICKW4L8bp3RPGPOF6azcjBPCb3LPYGIJjk7ESPLKSBk+vQj5uOdPCpiJxCNi0n5CVR1/Pdca/LpbJMkzfGv9s4ArID0mCHzlpNNN0mwwaLo9HG9UnoznX9/0btCUMJurMZbX6vHeQV3LX++UpAznEc8zpYYsdvO1wmBSB0iE5mqjvi2T61FYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GPhF15kLZYLuGHxvABqDAemhmGVkZ2+9xhqCrL87ZY=;
 b=rux6Jrit+LUh6aCY8A9KJbvCQyhfeY0wyCe1XsdTkl0n6kVrWF+stHwhjivHIgi7Kw0rLsw/q094YvT5azuqCWEUUKETbWBGEpdtl0br7Jtl5Dv412Yq9c2FdsN69tYoCuUCQ8/T7AzRep/so0XwfP2fZ7c+721ZTHQIVAjmy8DBiku7b0AgQzE+UkwV+jKHsg9lJiqT4cofu7awKdObYt3B/zB8jcT0nEzH0b/g2nS3UahCEfihyAEksO9ber85+mjAGuAnSVc44DqQ9yaumHSEO2su2LrqPPYFR+r/XbVI0nqENWnfylq7y0MYKdqsCsUWL8oJCNfguvLqb9yObA==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA3PR12MB9157.namprd12.prod.outlook.com (2603:10b6:806:39a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Thu, 11 Jun
 2026 15:47:07 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.010; Thu, 11 Jun 2026
 15:47:07 +0000
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
Subject: [PATCH net-next v3 1/3] ipv6: Select best matching nexthop object in fib6_table_lookup()
Date: Thu, 11 Jun 2026 18:46:03 +0300
Message-ID: <20260611154605.992528-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611154605.992528-1-idosch@nvidia.com>
References: <20260611154605.992528-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0026.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA3PR12MB9157:EE_
X-MS-Office365-Filtering-Correlation-Id: 98fe7c09-3a9d-47fb-4101-08dec7d0b124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|22082099003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	b0h2t228T2zv8N5iaU2BFqPhzGzqKJx8nEeihRNSxib0C5bBQy30dBYFAjCvdy+y5j+1XUDHl23w++RpDxRsI9M/rUKuOpeGPmqWCtQZyYPFuQrLVoYoUt3o2C6SdFm58anxOEe6cZAgJZN2faP3dy61Zou+BETjgAigdpV7240tIcxrNX5UHstDrjOjhygoC1jXMeLDWjFGBK624NRn58WUoxtfHuo85yKAtzCCtrcEYKZ3QtyIyACH+4bB5jzStN4MYEkkdGaQmuqc+KAh1CcOjjNNaAOxU37Q7/pUDYc46JTDu2Rc6tl+ucxPtpHDyvR9VM0IcjXYyCcagiA997FGIOPpr/GlRJPl76r8A7lMkGHK/NZdok+0ITDfFu+rxjDxfiwQSMoaK6SkkKs00TY+S7pI2hIkreG5xA8cDA7HmyJuQkMQhfZkQgTh1tAoWzAyrJBlcO2Dvuw8VBBDxaedWHHkarsFrzh1eUe559nlRD0KAbIgXDrkn4lDeJHeDatmecEQ1Wl3LRJool67+GgEqodg5J+73h/yddHs8OmuUrDLb5CKNt0DfS6gTy+9wWrCyiCCqw29tp6MQC/01m6jy6QbdWhCLe1Nsit6b6LWJoXWuLBQHMcGYARGkcigyyHJjTiBXtUM2WoRppf6/2byJLTZtXC2chxzjQlUWagqnftx71C1QhbCTkvfCnsa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iE4CuwQHM6/ts/P5DEXuljhwy9sjVFCjOpei78Zku/UHnuBGiJV9bqrnrfMp?=
 =?us-ascii?Q?CTxs/B1bmcmHs4YKZ86QsIob0WqkcIMJePXgvTSrtfgLRAKaXTR3UJtDVfux?=
 =?us-ascii?Q?i1CcXmFbm4gK0/l9kZejVlxiFxw1QRFg7e7iVvBotuFmWUWJYhx33P85u8lk?=
 =?us-ascii?Q?QX0R/SpkVSjjgjS12OyDas2xk/POnzAsy+lvC5TApDuACXiIasJttzQ1OCt5?=
 =?us-ascii?Q?6oU0OVkJQ3o1R27gaEGwuPWXKkMWV6wijf3kJsG/KEGqCwSV7/UzD95jcl+m?=
 =?us-ascii?Q?PwH8O9ViyVCHRC/d/69U19eEYpvpSMM5YWFg+5HxZC/VY1282gSb3bkE5u8r?=
 =?us-ascii?Q?mMHkKQ3ifqcCQQ3VSXmuv9ol1HLEFgRMF2M8GzIpK8mdLjsikxAIyMC7pZJt?=
 =?us-ascii?Q?/LWE6RNHYS2on/3DvI0l44NZ95lMi2OLII6wYQhxIzscZOewS/EVyW3bhr4d?=
 =?us-ascii?Q?tB9hQjJi6wEv5RARah4Yc7jsImzD41ZqT2yGa3kouLmIgof/8kTWGoG1iGoV?=
 =?us-ascii?Q?dUvDxSKatTRLzAoft07Js7fkSuxHPKVX1gn210UQ5eZHMctvvCiIxn3lclZU?=
 =?us-ascii?Q?De/pg1ml5T8IK7yNz6rby37Ec5aP713u9NXP7tFn/QW0ZWA3vMw51X7jTNXP?=
 =?us-ascii?Q?WuQGvqntvNpTHQo/Xi2/lFprfbBIpmckWjqiVwlUT67b8YeWmflGyFJRCfTz?=
 =?us-ascii?Q?ulk4IHylebY3fL0fiZsbSeZT82mfwYoYBNhT0kqhgv0QDpnqnnV2XPdLnJiQ?=
 =?us-ascii?Q?/GBcWB7mv5pJ2NnyHjuBzaRHEN0C8pM/+2Zbj3vVl5F+EkEsd9oD3qYNw5wH?=
 =?us-ascii?Q?c3tVxJdmUT5hr//gVeYlX95ghOVgX2MMWkYlKdf29ATwEI0F1Wg8NzTZsGYg?=
 =?us-ascii?Q?Y5ZpqdeGltjiP0/1W9ABEO5EIwO+ej+HLZ5s0FJudKYozJ3kK6gFTdEYUq2t?=
 =?us-ascii?Q?UNc5V9Ezv79v90wHwYsPoD9yMT4MS5aCFnojen58Qn0boJwjHPo+7IoPw/o1?=
 =?us-ascii?Q?9p9WB4qg+vVUaAlHoQX+ahzK6NBnVLcGtLsO2utvUm4VHcp2gUPxwfNBaQmy?=
 =?us-ascii?Q?RJcCGbZfshpFpEhFJBknuEXQaj/H3NKKqHY2x3oDHJPAzRUwoqEgkq2zc0tf?=
 =?us-ascii?Q?FUTj71AttaByXmEtYrSGf52gBRUxs00Nq3CxdcPch/a+IrZsd9ufsM+UH/B9?=
 =?us-ascii?Q?KOy14eqNh/ydBUXbMJUqOZ3TBkFMPJmVlPn8M2lBWdTUACvkO0zSfkYUvPGp?=
 =?us-ascii?Q?uIJke9cQSt8X1Bo/vA28rCRWnGa6PlvYt2y39QIVfzUkbocTcI658nfl6EXY?=
 =?us-ascii?Q?wNK7UYyTeYbRxFZOnFeMZQPyJ+f9TOpNkXPRG+rNk8QRQgQ4DeQqMt/yH8cD?=
 =?us-ascii?Q?Vk+MmCj9fZlurUN4aicpIsoPvI1qP26mwvkmT83ZE0a8UqYv7YdMDrqv6QTr?=
 =?us-ascii?Q?F0HOroD3UQUpBHumMKcGC5DjCt2D94nqHoQuXZ8vFANFKfqMs72Us3C8umZC?=
 =?us-ascii?Q?ONl3i/tDtdOGZyDa4/ECdRT1WyCnMlmnA6CoXsFxq49S81bBCava0uW3EcKf?=
 =?us-ascii?Q?NwAVm5bz/AnzvVXv2RBwC4N5iyvKMuKGpskNNi6ofXF1WTu4adymBX9W0Wu8?=
 =?us-ascii?Q?Ix/ARy4p9DCyFrzNggMl+IxXvwOErcWAuQXsB4D75tGEGLNOPmLLSJW/riT8?=
 =?us-ascii?Q?Dav1MWZ+6gshxUxE3G44M/MVITjPwkfUv/mMfDktyaVBaEQk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98fe7c09-3a9d-47fb-4101-08dec7d0b124
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 15:47:07.6380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 608A0AFaS8ebMJvNnhdilwb5xe6dMVnzMZITCdlJ2FYbE5dtQXGmUxzKWZd6/F7BJlT7bVLdSV0ie/4tGG8ayw==
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
	TAGGED_FROM(0.00)[bounces-298182-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 08418673357

Currently, when using multipath routes without nexthop objects,
fib6_table_lookup() selects the nexthop with the highest score. This
means that when both a source address and an oif are specified, the
nexthop that is chosen is the one that matches in terms of oif:

 # sysctl -wq net.ipv6.conf.all.forwarding=1
 # ip address add 2001:db8:2::1/64 dev lo
 # ip route add 2001:db8:10::/64 nexthop via fe80::1 dev dummy1 nexthop via fe80::2 dev dummy2

 # perf record -e fib6:fib6_table_lookup -- bash -c "for i in {1..100}; do ip route get 2001:db8:10::${i} from 2001:db8:2::1 oif dummy1; done > /dev/null"
 # perf script | grep -o dummy[0-9] | sort | uniq -c
     100 dummy1
 # perf record -e fib6:fib6_table_lookup -- bash -c "for i in {1..100}; do ip route get 2001:db8:10::${i} from 2001:db8:2::1 oif dummy2; done > /dev/null"
 # perf script | grep -o dummy[0-9] | sort | uniq -c
     100 dummy2

When using nexthop objects, fib6_table_lookup() selects the first
matching nexthop and not necessarily the one with the highest score:

 # ip nexthop add id 1 via fe80::1 dev dummy1
 # ip nexthop add id 2 via fe80::2 dev dummy2
 # ip nexthop add id 3 group 1/2
 # ip route add 2001:db8:20::/64 nhid 3

 # perf record -e fib6:fib6_table_lookup -- bash -c "for i in {1..100}; do ip route get 2001:db8:20::${i} from 2001:db8:2::1 oif dummy1; done > /dev/null"
 # perf script | grep -o dummy[0-9] | sort | uniq -c
     100 dummy1
 # perf record -e fib6:fib6_table_lookup -- bash -c "for i in {1..100}; do ip route get 2001:db8:20::${i} from 2001:db8:2::1 oif dummy2; done > /dev/null"
 # perf script | grep -o dummy[0-9] | sort | uniq -c
     100 dummy1

This is not very significant right now because the nexthop is later
overwritten during path selection in fib6_select_path(). However, the
next patch is going to skip path selection when we have an oif match
during output route lookup.

As a preparation for this change, align the nexthop object behavior with
the legacy one and make sure that fib6_table_lookup() always selects the
best matching nexthop. Do that by always returning 0 from
rt6_nh_find_match() in order not to terminate the loop in
nexthop_for_each_fib6_nh() and storing in arg->nh the best matching
nexthop so far.

Behavior after the change:

 # perf record -e fib6:fib6_table_lookup -- bash -c "for i in {1..100}; do ip route get 2001:db8:20::${i} from 2001:db8:2::1 oif dummy1; done > /dev/null"
 # perf script | grep -o dummy[0-9] | sort | uniq -c
     100 dummy1
 # perf record -e fib6:fib6_table_lookup -- bash -c "for i in {1..100}; do ip route get 2001:db8:20::${i} from 2001:db8:2::1 oif dummy2; done > /dev/null"
 # perf script | grep -o dummy[0-9] | sort | uniq -c
     100 dummy2

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/route.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 8259c7527aa4..09dac3aa8778 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -819,9 +819,11 @@ static int rt6_nh_find_match(struct fib6_nh *nh, void *_arg)
 {
 	struct fib6_nh_frl_arg *arg = _arg;
 
-	arg->nh = nh;
-	return find_match(nh, arg->flags, arg->oif, arg->strict,
-			  arg->mpri, arg->do_rr);
+	if (find_match(nh, arg->flags, arg->oif, arg->strict, arg->mpri,
+		       arg->do_rr))
+		arg->nh = nh;
+
+	return 0;
 }
 
 static void __find_rr_leaf(struct fib6_info *f6i_start,
@@ -861,11 +863,10 @@ static void __find_rr_leaf(struct fib6_info *f6i_start,
 				res->nh = nexthop_fib6_nh(f6i->nh);
 				return;
 			}
-			if (nexthop_for_each_fib6_nh(f6i->nh, rt6_nh_find_match,
-						     &arg)) {
-				matched = true;
-				nh = arg.nh;
-			}
+			nexthop_for_each_fib6_nh(f6i->nh, rt6_nh_find_match,
+						 &arg);
+			matched = !!arg.nh;
+			nh = arg.nh;
 		} else {
 			nh = f6i->fib6_nh;
 			if (find_match(nh, f6i->fib6_flags, oif, strict,
-- 
2.54.0


