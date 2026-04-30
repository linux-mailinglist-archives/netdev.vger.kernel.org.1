Return-Path: <netdev+bounces-282581-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FRdJ1yx8mlItgEAu9opvQ
	(envelope-from <netdev+bounces-282581-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:33:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4149449C076
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 99D063008338
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65D2262D0B;
	Thu, 30 Apr 2026 01:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lQbBoPxw"
X-Original-To: netdev@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010004.outbound.protection.outlook.com [52.103.43.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E201A6823;
	Thu, 30 Apr 2026 01:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777512791; cv=fail; b=IV/92uV297gHz8Dyuwq1xFspdn36KhSWmF0Ci72WCIq5uWik0o4uhbdkq3hkB+Z1OC4ZZ7vgTtcCFL6d4f4FUP9aywEpY7aQFF0Cq+eO2ZUaRLkmBGThvwDJ9PkzZSmkqzj158O+CeAXdscdxZMxITqyecSOnyhiLc05YTNjOXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777512791; c=relaxed/simple;
	bh=k9I9DwlpwiFKd7DVWBqyzgOTOAvGSmjiIdLcozF0wks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m8tDuhsIGVPSUyd6zkh3NjKCeQLk4CNJ7wAbGQ0Qm8QmKemUVJqcSPwhOmJkGY52Z9tJ9eULI5Djol5Ixk0shMSO4FPOXc7HeZFG9jYDfCLcy8zdJ05gklyvlzFcp4XhEX0Ixg0RgGHQjCHM3FgXdKRmWybzvTgCLS0Z/xMf0Fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lQbBoPxw; arc=fail smtp.client-ip=52.103.43.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0BonvApkSOkKh4fR987IWl5V0qZIDsXwXRfqvi1a4Mu541tcCTWSGp1Yp8xx/MV62UNsdhx+rB1/+e9jUKeEpTLP0ofN3O5sDuuNU96/MXie5Crj9dbn3gUQM3q2gumakiO4uNYFbpKM4IdmATO/lxwSSk3Txke77M0uvC0hgcJPhWFJtuAqHuruKgz9WqE5sgIKDaDQH2ebikkz8zbldQoACcL4oi/GOcOfvRMxwnHvXgWYCy3xBZhYk2G6LG/d7aorF9EgNxY1Eq1IbVW8nl/ZLB4//2p3nlcgyDPGZHe65/x0OasqrAqf6bMAJvXKok0PT2JMySyCVt7tfuVQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwhiUaUa6CsXJD4g6ZZxbRGKUAMWxxWDdnvDpI0jk6E=;
 b=Z6703O1L1cvjDRMr+MAfWLZ90JJdNaXY6Bw6HeBbY8c8TaJs5v5aiwEFibevLqhTeZNsM9tBGiS+Loh2NIAg9n6kFk3T3KA0KFbHMU4SiVmYLiYH8ufgrhP185u5DfKNfHbGSvIYexgdPI6DFUHH01S892qoH5/Pf0199pdtgj7nLbhTwsZWjgBGkgPdqybzi+SNz1Fz6MtHYw5jjOyoH46kJd2thDEFN7LIbBCK6ch1nC6wtu0qaGZ9lIgS29Wjp+RvIIz/ZAOYQo+QGAgwXlgRjj8N36a1YLk3QhDp1fYDcG6qf7mf3t/vxQUml5y7wQGp188cDlGspwJrYS6SiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwhiUaUa6CsXJD4g6ZZxbRGKUAMWxxWDdnvDpI0jk6E=;
 b=lQbBoPxwsdeVAMbYWWfB8knXWYFPBLGTiJNJZkCQfCfuGhhhJBBa7hlmMxQqV3XRnlyF7wHheRPMwy+l+WGxvmKl0bdKphpdDyNPB3WmbE1IszlMH3hNhAPoj1h/0cwchD7GTuHp130shadHiGKqvTlzWV4VEBPRVfbyuOjLuLpyPjgc97VeV94S2Uas0pSmbkAdUlw/hmWRg7vMlbez8aVwSv0zzn3O7iSpVSDxKzT4afcVfAqzgsqzevc9vQ/iCnCos0M1X1xpRRvXGFI/GRSi+UN1DDyP8wmd/SNdYpW8cncQuWpF6noKtsBbWQPrK3djf6xpA/nB61Dziy7Bxg==
Received: from TY7PR01MB17205.jpnprd01.prod.outlook.com
 (2603:1096:405:32a::20) by OSCPR01MB14631.jpnprd01.prod.outlook.com
 (2603:1096:604:3a4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 01:33:03 +0000
Received: from TY7PR01MB17205.jpnprd01.prod.outlook.com
 ([fe80::7d34:ceac:fb2a:947c]) by TY7PR01MB17205.jpnprd01.prod.outlook.com
 ([fe80::7d34:ceac:fb2a:947c%6]) with mapi id 15.20.9870.016; Thu, 30 Apr 2026
 01:33:03 +0000
From: nmreadelf <kong414@outlook.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	corbet@lwn.net,
	dsahern@kernel.org
Cc: horms@kernel.org,
	chia-yu.chang@nokia-bell-labs.com,
	idosch@nvidia.com,
	ij@kernel.org,
	brauner@kernel.org,
	jack@suse.cz,
	kuniyu@google.com,
	jlayton@kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kong414@outlook.com,
	lance.yang@linux.dev,
	leon.hwang@linux.dev
Subject: [RFC PATCH net-next 0/3] netns: optionally inherit IPv4 TCP sysctls from old net
Date: Thu, 30 Apr 2026 09:32:55 +0800
Message-ID:
 <TY7PR01MB17205DBECC94EE6807248685CE0352@TY7PR01MB17205.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <TY7PR01MB172057C053E8D550485A29A08E0352@TY7PR01MB17205.jpnprd01.prod.outlook.com>
References: <TY7PR01MB172057C053E8D550485A29A08E0352@TY7PR01MB17205.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0202.apcprd04.prod.outlook.com
 (2603:1096:4:187::20) To TY7PR01MB17205.jpnprd01.prod.outlook.com
 (2603:1096:405:32a::20)
X-Microsoft-Original-Message-ID:
 <20260430013258.4048458-1-kong414@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7PR01MB17205:EE_|OSCPR01MB14631:EE_
X-MS-Office365-Filtering-Correlation-Id: b7249f49-992c-484d-bff4-08dea6586bf8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|37011999003|461199028|8060799015|19110799012|15080799012|51005399006|24021099003|25031999004|5072599009|3412199025|440099028|26104999006|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0C2akqWYQPXUivcgm9uq4KSQrHVJuQQkKw+aYjAHs7zSgfuNtmX/2wGOJIAb?=
 =?us-ascii?Q?h+ni+orHcffpUeHfu7qWVulAv/+r6YJq7esSo7QrYdBipOcAYhES7dVZ8BF6?=
 =?us-ascii?Q?9ayZYQ9h27/Vh0EB8vczY2pQXUjqEgt35fjc0psPqCR+WB+N/L0Q/6n4eSsO?=
 =?us-ascii?Q?Y0K34tIBo9ZLIo2DHza5JTkK6NSUmXx7bd9nvCZkf1xFg8anvWrBy4sW02ba?=
 =?us-ascii?Q?R4dEAk4VotmSR6NhV9F1SMe1/sXe13ypcM7MbN9vTVwzRW8EZf7xDxeKYuAU?=
 =?us-ascii?Q?EK7Y0jp7yXV7wZ5fjc6SW4v5P495W9Ckz4Ipz24yEiMEND3LczJZ5Z61NDtJ?=
 =?us-ascii?Q?M3Eh4A+g4jKL9AeK5OHto0hJM9cYdxoAwCcp4c11fcg2PjGvVBj3eVPPx7c/?=
 =?us-ascii?Q?uJpoRd4T01Ec60TwAwk8tsHVrQRW6XcO0ffMbPYPYLGqiafa9Emupki2LlKK?=
 =?us-ascii?Q?V5jUQl4u3OkTqI8ufkqvA54zdG3BacJmZax5FVTDIN9FayvU6gVhbAhg4WMy?=
 =?us-ascii?Q?UkxrBJURH1tW+HRhCWnfnJxklqG0OZbRU9dikIZn9Xt+l5547HO0NrPtnOTu?=
 =?us-ascii?Q?tVw/tlf0oYC+SG1SzvX5s9YksUufVks/uBvrZ3w0Jw1rnptVC+N5lfgpm3gQ?=
 =?us-ascii?Q?5WQbo4OILxm5wfsFMnpe43J8eKcW87kgZen+SWfTKv9bMDL1c/EaiiJaVIvT?=
 =?us-ascii?Q?K8rwmCRDV7GeSs3uNXfjPkD1MZA5Hx0Nii9h5glneVhEGeHizGV3pXWUlK4n?=
 =?us-ascii?Q?8OG5cfLksMhpZhUyIxXBdJlk4jFYb2+pUMg4P0BUHbxalNY0RK5295WnC2zL?=
 =?us-ascii?Q?LrjLpMQdk7Deyv5vfjdglodGCXHwFA7kOVSPyzRGaTLJRtX5WimmFVIg/UP9?=
 =?us-ascii?Q?NE19sa6BzTS4QLFjegkHPjSFSG/efB79+fseZa3JcoMtv9Ewy/aaOaT2IOXh?=
 =?us-ascii?Q?+lwiaXaN1vBYxPqh5b1vNPBJh5t3xPE94aORHE4isDThdxSPLxcPxja1drDf?=
 =?us-ascii?Q?P++fn9BVKgfszGXw5h+oZgtEVHj/OpFicKMwmlR7k7a/XP7SM6ztWpEP/oTJ?=
 =?us-ascii?Q?uW6WUU+E?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eBOCYyfkTrU7ea3JZni5Mj9p5PN0M6aDfYPwRJP9OsTFXC/1gPUhKAZybHV4?=
 =?us-ascii?Q?scLaTP0qpVQCaQmxdqk0Dz2CT1xgM4MI/Hb/eLLb/zcl1v144ta1YM8/F08W?=
 =?us-ascii?Q?9BdY9slwPUISIYI45FBZKaKEW24q/R9/9hKOPm7lj1zudSvhciE7IkspOh/l?=
 =?us-ascii?Q?jS5NfGpmgorhIGyKpyhLP/w6knesYIrCBjVb4F+l4I/E5VZhFNI53/VZzMd9?=
 =?us-ascii?Q?XFt5bUVjkG7dsPZEZLr0xxupVQEQbCUv9kLyt6qgwZ9P5GEoJlyaoG95uXxH?=
 =?us-ascii?Q?k31jbOIhRIu9Ef6f7GvLPkGtbg7IKPjLXuQkwEJgg6h15D4r3HjRpiAHBbiU?=
 =?us-ascii?Q?bkfDkug0+AFuHx4a4F0SoqtFuejjHdV/i+w9JzrIdHyM70+gd78iZJ5Ugld8?=
 =?us-ascii?Q?yxpVvP22xs7yS+qI4G4fOf2oAJEYGSfxYULm0e8PoVWoRAQb85l9co8CgqjW?=
 =?us-ascii?Q?vp1iXD4jIwiO5jXc+PjRG5NoXKycfSXN9EbX2A0YUgqh9AC9YKvMXjRGhMNz?=
 =?us-ascii?Q?UDECE5kMw22Jh4YZrz9gv+yXeWw0e/062/Hh99YmUO6v7HRFTRfUtMFSHO08?=
 =?us-ascii?Q?PwNxvszKlU4ZS7WRY37N3JfibmGm0NU5xnZm4eJlI8N7L/kNZZVKuElhyZKD?=
 =?us-ascii?Q?YcqgTGICQiJgCHwCRIdFlrRxWyltd3HQ6entSrV7okxruLPQofcEpW4T53Ev?=
 =?us-ascii?Q?GO7b0uwruzJnIlgjTt1+oFLpA2ZJXqQLii1F6xX/8lOz2TbvRVOa0fEjXHbR?=
 =?us-ascii?Q?74+tgkQslhVMyzRCET/eZ8ipKiovjnNz2qEcTypG2ut3Zz2GGP15NDUuu800?=
 =?us-ascii?Q?BvLZZ2dsgWbBQbslzonhWx0JdwcTnx69qy4ABxB3KVTDhKKo2Xfp4bpQi9xK?=
 =?us-ascii?Q?Vph/3KKb2wYLthLsgDbKq6oeap95CVmkIrVSnVswhjfr5iGYP6XOuMqsc72Q?=
 =?us-ascii?Q?MQBsbWs6AvDRIuIBjzZtnDnZb6rWv+jKReVQ+GSBUZbS9Caa79rYYncQbu69?=
 =?us-ascii?Q?gqMOfSQuL0mNxSy+ueO6rRwhuJqyFS0Keh87cTWUcdr0IyslehYutoyVGqRZ?=
 =?us-ascii?Q?d0PLq/67Cd80Mr4DkjtqPtqAOrcX4LlgHqUxM+ERtRSz9a8bLsoLAgJg31tb?=
 =?us-ascii?Q?5xDg6Ka7+bvmlyu85/lY2MYU5U8RDRYnQgx5rLc28uv8t5dJ7Daz0lM3YTcD?=
 =?us-ascii?Q?oiYupoWm9xfBBeCirq6rmbHFYEYgDgoZW+AVxt5yrfGyzwVBBgBwiAOqVO84?=
 =?us-ascii?Q?hT6xFCxquEI7KoB8gXNRIstZbwmMn+RT5JWTIeT9k3HiZZTrbeEzM2RvRVJx?=
 =?us-ascii?Q?OZTIFuUNvbIH5RuVQYLenFOmueQbTFAW3cGbcFpZh+VTi1yIXW780ECoVGPR?=
 =?us-ascii?Q?ycUr8TKkndFHJ3ZZfcB+AdWgQ8ZY?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7249f49-992c-484d-bff4-08dea6586bf8
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB17205.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 01:33:03.6134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14631
X-Rspamd-Queue-Id: 4149449C076
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nokia-bell-labs.com,nvidia.com,suse.cz,google.com,vger.kernel.org,outlook.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282581-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[outlook.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[outlook.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kong414@outlook.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,TY7PR01MB17205.jpnprd01.prod.outlook.com:mid,outlook.com:dkim]

a new network namespace starts with built-in TCP defaults.
In container-heavy setups, operators often tune TCP sysctls in init_net and then
need to re-apply the same values for each new netns.

This series adds an opt-in mechanism to initialize per-netns IPv4 TCP sysctl
settings from init_net at netns creation time.

Behavior:

Default is unchanged.
When net.ipv4.netns_inherit_tcp_sysctls=1, new netns inherit
TCP sysctl from old_net.

nmreadelf (3):
  ipv4: netns: group copyable TCP sysctls in netns_ipv4
  net: ipv4: add netns_inherit_tcp_sysctls sysctl
  tcp: netns: optionally inherit IPv4 TCP sysctls from parent netns

 .../net_cachelines/netns_ipv4_sysctl.rst      | 25 +++----
 include/net/netns/ipv4.h                      | 33 +++++----
 net/core/net_namespace.c                      | 72 +++++++++++++++++++
 net/ipv4/sysctl_net_ipv4.c                    |  9 +++
 4 files changed, 114 insertions(+), 25 deletions(-)

-- 
2.47.3


