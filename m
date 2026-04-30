Return-Path: <netdev+bounces-282579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HODEwWx8mlItgEAu9opvQ
	(envelope-from <netdev+bounces-282579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:31:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4C149C033
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C95E302ED6B
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A9826A1B9;
	Thu, 30 Apr 2026 01:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ni9q4qfk"
X-Original-To: netdev@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011032.outbound.protection.outlook.com [52.103.43.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FC621A459;
	Thu, 30 Apr 2026 01:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777512656; cv=fail; b=lJKq9gqJvT4AIJrZs+Hjk/29MSQeO+twFblTrFeKeOpwEBkc+QXWg+JfWDl+bsLbGWBqlIXW1o6BEZTWw+6R8vMnqR2l5E/2zqSJarzY1nmlJpuygwoVO9m43EVS7FgLUEOtXyw7dKKJKstdeiyGNAe5KdiINmbr3bjWXCJhLpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777512656; c=relaxed/simple;
	bh=k9I9DwlpwiFKd7DVWBqyzgOTOAvGSmjiIdLcozF0wks=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Xz2BGbyFCr2nyPrHWdtDGa6Te+9aQzhEn1ZaXNasyRaEGuI80sOodkZWAmBHbiQHLlwyNQKeKeZKapOiOsh+DR0EnK6h4ozXYruv1FlA6QLqzbIEr5WQ6GtLplR5wmGoej1tPBHC4muHY7Q6dV+PYrsyunSfFhFvOGtA8UwXwuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ni9q4qfk; arc=fail smtp.client-ip=52.103.43.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4XcbeEE4Yp88bjp7818x1jKkLa+S1yoCj+uGlzBl3qijN2p2YVpMsvk8Sjy6luFcFvkxTcYT1/RneMGxIrePUCkbWbn2OOwR+XxloJRXmHiksgQ52eS8uEZQFGkO6KIy0AiuKqutupjE4gZqlZWZ7Ojw/TyPaJB8i1sGZAC/DpEk5NROT3h8eq+egr1Avl+y/j8dCXVoGeG4bqyJXRZIZIicUvdhEZOLdNxh9K7iKzGIpebLCWeCR86Go1PKSViC8Poa3DrR30VxNngE9iVbNioqS7DWBvKfDZu2h/E90WhNy/Yi4Zrlll4NqT0yrKpJ7GrqZFAPaN/kW7OOKvnVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwhiUaUa6CsXJD4g6ZZxbRGKUAMWxxWDdnvDpI0jk6E=;
 b=ikwhlg4vriNYBufwGru1h5PyPC0rb6kovT4yB/4mBo011FzIWI3+l0IqDlwrfYqseku8VeRKKhXlhCt0NwZAuSDy51YSh/Ci4U4ANmGoUW5HIVCTmRH9h9WcQ9KbTXfoT5Dwu9ThClnS8EpgAAnWOHSjDOv6Dj91Mwtvefbwvy0ZcH00EGJAtxGwIwVFjBFWrE1rwAx2nEVXRVWUtlZ43Jqc/NibroEqUO5/e9NeQTi9HRq7JEi5UZmtryuHoAtA5bbDyrbxM4aPmXu/HPxng4YZ1Jx7674FNkaiWVMAKRzc8NJo6NEn6QA5N2qWt8sxeSwqZxHSJuQJPdoRbb4Eag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwhiUaUa6CsXJD4g6ZZxbRGKUAMWxxWDdnvDpI0jk6E=;
 b=ni9q4qfkwDJbNmwzTy/Jn8j+MYguTQpv0pgEWqX+EmAgamPEa/TLELi4yc3R5mIzsOolEMHLjrNxdUBH7x5jcfZAPOOCJecFJ6a+XJYL41PU09DQ62GcuWcP9KUgpEBAsPTfGoZB+IrjwrHt3rtWnXGkfuPqohqOWwBmEJJgTG9iijXp5MJRgJlczZ0f2JsHsIrFhPMTJPq+NOVHEEcTZW10r6APxaXqai5qsGywWAGYSNte+ywSaOfzzVNBrr4Sn+Hjf9tNNrTGjUw8c7eXySshiNM02ngehMAjO6AdqLUIjndOVn6KbOQKeiEaUg1UfzwVN1ScNjUjTt2Iv9xynA==
Received: from TY7PR01MB17205.jpnprd01.prod.outlook.com
 (2603:1096:405:32a::20) by OSZPR01MB8546.jpnprd01.prod.outlook.com
 (2603:1096:604:18b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 01:30:50 +0000
Received: from TY7PR01MB17205.jpnprd01.prod.outlook.com
 ([fe80::7d34:ceac:fb2a:947c]) by TY7PR01MB17205.jpnprd01.prod.outlook.com
 ([fe80::7d34:ceac:fb2a:947c%6]) with mapi id 15.20.9870.016; Thu, 30 Apr 2026
 01:30:50 +0000
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
Date: Thu, 30 Apr 2026 09:30:42 +0800
Message-ID:
 <TY7PR01MB172057C053E8D550485A29A08E0352@TY7PR01MB17205.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0211.apcprd04.prod.outlook.com
 (2603:1096:4:187::19) To TY7PR01MB17205.jpnprd01.prod.outlook.com
 (2603:1096:405:32a::20)
X-Microsoft-Original-Message-ID:
 <20260430013042.4046817-1-kong414@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7PR01MB17205:EE_|OSZPR01MB8546:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e803a32-5f47-4c5e-58e1-08dea6581b5a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25031999004|5072599009|24021099003|461199028|23021999003|15080799012|37011999003|19110799012|8060799015|8022599003|440099028|3412199025|26104999006|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l6HR7mtBhAZVJswAL7kdcYisCVIzl2qN+DN1JI2/MZ+QxEBAINSu9R1BfjMY?=
 =?us-ascii?Q?TPkSqRX88gNWp3EfqodwiJ+kEUR6giEg92Tuq6HBccK7fp2ySTg08fZdnjla?=
 =?us-ascii?Q?5WOFHauWS25L3SmroQeWdqEDZSv3yPJplfSGQJacyTq5/M3xVvdfoDE9BUwP?=
 =?us-ascii?Q?w5/B6uwletpwdlLLe/txe2ICOF7kYno5wmSRqpADdFY9ojKr3Q3+ZqVo9IAo?=
 =?us-ascii?Q?DEML/y5mIfDC0iKc40EcrNA8a+nVZ82mNtBelz8/QT6VDlJAgL5O7H4aiCJq?=
 =?us-ascii?Q?Pk5BuActhUjcy13PTo319WyuWE/F4ammtVf1Y91jkboMXy4jg2eQARxmjxp2?=
 =?us-ascii?Q?PHQV5uicQk/DC53RByEPWQPjbQYzq3g7jy6R3c904nLkb4zftie8gWePvaNY?=
 =?us-ascii?Q?ZKtBQe3kINK/1vmXlMvrOlheAzTpRm5apZGMMhZ6euOnCV41u3Acs7ujjQ+U?=
 =?us-ascii?Q?sd5aLHty8m3if4+uQjFEdbi/gVDQ2VQYREgYKt+VeIA0WT79+eC7rCxyhCeu?=
 =?us-ascii?Q?VEHidrUipiJHdkUEIMWY47u4TMcOAa6g7e+5O2YhhFFgVfAeLC00yudtLwhu?=
 =?us-ascii?Q?A2FfXI7HDlPe9nwsUC0rx8FdwJ8GhXjp8CMFsW/5B1g2wfRcBrIOaCtBxQqd?=
 =?us-ascii?Q?wHDp8I7NIMNtKfoT7CdMtSGZwJEBEO7qyRjTKklRndgSMmKhyrGZB9Rlmjl+?=
 =?us-ascii?Q?TL8uB91wTgoh/xVh7AB5v9KbKOl8RdS3OGP/uCXvpHTCN4LN13b5bS7ixW5c?=
 =?us-ascii?Q?bdB5u4NFmLDhCH2SWD0S3hV87IbYu1IlYifEJAqM+YnGbtWTDDrM182rnojO?=
 =?us-ascii?Q?cdOzhrToVCoV4bAALVVuMTsytopzSg4LxbzjJInUErn3iQk2gB0dkb+J39LR?=
 =?us-ascii?Q?PDB9QrjTC4iH9Gye55XbYEFrLhk9tSZ5DfNpGgklTIR7FKtxore0B4tX6n2I?=
 =?us-ascii?Q?yfKGV3q6Z7/C2EB+D4HFIRJ0hySLI1qNNTIbfzZJrgJIZcaJQWtWxHDK+o+u?=
 =?us-ascii?Q?BCn+mZaLxhUhkughOFMcBn49Rg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/NR4OSCUOR6O0pShAoIZG9NeyRG+Y/IHoSl56ZMPjcvkcrzOgRPB91jJowAI?=
 =?us-ascii?Q?dGw4I5P4LwXDVuo+SIxTfTj/KazYujRtMtS+NJBp9a4MROiroMVfSQCp+WOl?=
 =?us-ascii?Q?zsASjlnaTnRsz46sK6bXJwDYA+3NViA6w5wB5mdHqeZQSuoW/Q86PAUxt69B?=
 =?us-ascii?Q?hXkiBxNOXBjdBZTpFxewHNJ5ZMib2+AfJFmqxXBaPx4AocrPvOgZKOBGTQZH?=
 =?us-ascii?Q?BzK54pV5Cxb6tdRpgCom9JAUltxXKmvL5Dsp3Ao9SUv5BEUGy4z5alJOOIad?=
 =?us-ascii?Q?uULnXh1gVVsg7IHrRrSdVI7t67+s41hCIqtCFh2dPmXdooK9wMAYMIRSEnO7?=
 =?us-ascii?Q?rhMXtJUE8bImPO8DUt0QQmm1z++dA9RV3llT4DOhf67TbAx/5SXG2KeGooOf?=
 =?us-ascii?Q?SjCyNBJoWTf5Te892K3iOJF+JIgtVF17QvBb6FnfIhaCrTP6c8T99eNnBL4b?=
 =?us-ascii?Q?AgrWf3jTOqlpfN2sdtK81nMv910tcWRDu7uc00Ag7oIqXj6MmTVk+EpN7a7A?=
 =?us-ascii?Q?wmSSUX/TO/v/N8UonKT8moQt6iK65wmn9RG08SwH3rimSwf4SHVZb4GYxTru?=
 =?us-ascii?Q?rCW3kEkWFFATz/cZU2xkpuE1AL5mj5EQ7PIgQ1wLUdyzZ63Y7ar6Cd6lyGdo?=
 =?us-ascii?Q?NM37JNvUdL66UTRzZFOF63Em8NjQo3kQlh82nTqI5+Jqm4njpbF3tlcWt8Mv?=
 =?us-ascii?Q?b7/OdcotsNWyVioYqnqpVumP4Yg+qVXxnOAuCwb0Xbo5LJ7w2SCzVdkXkK47?=
 =?us-ascii?Q?99GI5PKxQhahWtme1orXNU1rvXBxBBaGeEowR80oiFYz/QpwWUiuaIL2R8V6?=
 =?us-ascii?Q?yAMBuhTkSjNdmhwVFzcJ/OdFAv3SwRB+mBzjAt/cPv9TReVNWgJBWDq8FbD2?=
 =?us-ascii?Q?+AMTtvBnlUVNsB61g3BlEQ6sj63at1uzcjXzPt7nXEeCArq9L+07IZkqv8/l?=
 =?us-ascii?Q?h6TYfBXEmz1jb5idEcm7jn21FQIggYCCxv44230q8pSeo0Us/KeJxXgJnM22?=
 =?us-ascii?Q?NDtkZ+cMQBRAhIaV3DsyVgbu3pJBYwBkOibsqT4si1M8FeWpZtwqYoGaNjPw?=
 =?us-ascii?Q?WGbxi35OcI2uQ/t9MnhBc7Il5/nwOPR18rzyKNWHL2jcvinID9lsWoCQ0vk7?=
 =?us-ascii?Q?r9oykIhW1LW/W+JUtU4HFivhNuo3II7CgP+mapVkVBgi41BxKDzCg027MFdL?=
 =?us-ascii?Q?TVb6QpdRm0xjbOsD4nmIF8fPNWXGHPlrm0BoHbeZ+H2ePi0K7jMSkszgm4+g?=
 =?us-ascii?Q?zvd0g6eDhxDDV3eI5TuE9Obat6zwZ2T2aOmK9t12p/74OCFamku+Qarh6VWR?=
 =?us-ascii?Q?CJ3EqJVEbZzwJSiv3PnI81E4OqUIqVpIjVs8EBQzU3Ol1XPn+0Z6+scj+SAl?=
 =?us-ascii?Q?ABIYlNxDeoujrGWM02BOldvxTiuO?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e803a32-5f47-4c5e-58e1-08dea6581b5a
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB17205.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 01:30:50.0372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8546
X-Rspamd-Queue-Id: AD4C149C033
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nokia-bell-labs.com,nvidia.com,suse.cz,google.com,vger.kernel.org,outlook.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282579-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[outlook.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:dkim,TY7PR01MB17205.jpnprd01.prod.outlook.com:mid]

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


