Return-Path: <netdev+bounces-282582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFsKNG2x8mlItgEAu9opvQ
	(envelope-from <netdev+bounces-282582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:33:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DDF49C083
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 773E23008302
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F148926A1B9;
	Thu, 30 Apr 2026 01:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VkFDnk9n"
X-Original-To: netdev@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010021.outbound.protection.outlook.com [52.103.43.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDE426C39E;
	Thu, 30 Apr 2026 01:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777512803; cv=fail; b=oprYFD1ShWM3JM7FP6EYiT0XL0SSUHGX/81AlaSkO3UmHBr5ovz7yLtoR+77wl1Vey+rZKKRR0akNFnApLIF+8Gon9IPdsiJtsHpz4HP9tGf7FdPIyqzKg388gYIVnorfkbnntb4speRzTMHEP5WXFt0OT3Fq6v8NJplCAYMicc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777512803; c=relaxed/simple;
	bh=qDbVvdg0rHKbVz0p3oOdSxToVWB/iK6vjCcFzQ0+F0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GG10XMiw5vhHNhdXReYQfoJASMi70kgySwZEUXtG6jtzxE+M2BQMyc7c9xdWS54r2pIch/9ZCy2PyB55As6Big+YejOZisgAMb+AW/TnNWvgUCzP9Q3YjPaGaOo2FCn37whDVZx0uOBTsBxIkG7o0pOz6hFdA34XE8TTY0G7V0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VkFDnk9n; arc=fail smtp.client-ip=52.103.43.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6PGT+C751n3uqi1M0S4i5KNp/Ujmps88+2exvoy146dfCcW7629Kj5oSYQMTLTV9SQ8r0Q6XFtmV4B9zV0NBYFkw2YxiCJQGwLNEUFPuT2MGk82UOMDVQy7UvSfi2mFqwn5k4Bfk7Cculeesv91+3AezDdn18U2KkR1Z7MkhZ+eCgWBHudM1d64xKF7qy1h3kaU33s4WWmRd5aayrEaYZc6kLOvbMed4mnjk+zY1F3IZLvbz0Gj5JEEFbNNy66mOdKvZ8c/qDBrOYO2QjgSa67RxbGx3r8Pj2scKxU6Dxj9q7oEKBXfO9CWIjv+5kk1acXMFD+52Q2iQhi1Y2qCPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiOoOzWpBtK3nf6XWggteAZVA7Cj1sL4hhnIijkqkdg=;
 b=uQJ9wNdOuTMbkPzVMb0OJUNxxY8Qv1PEWshFybnViQmUpZtCen/vNQYKq8Sw8NBHfhsCJbklOlz2t1mjeBdLV/VvgSu2XqjabBg1yKgDlr9kMo2iKS9zP7QRuILaFDww/p7Goy3Aqwyc06XrTViQWG7JAYrKyre07EiadlQQ5VyPfoQxkl6LYCGOx86lOy6fsm53KXmJmaLFfbitoChuQ7X4ubgMoL/VPOzklL/DGJpcNlXUNdW/jzwMbZjZgywDT3ze5XJFNt/uCofX5NVe0p1Q6MpOF/n3GxghXaNRADM6f1lAYGg4aqGihbOv/3bj9YD6Ay2TqdCd15h2mPnfQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiOoOzWpBtK3nf6XWggteAZVA7Cj1sL4hhnIijkqkdg=;
 b=VkFDnk9nHYrmtZJtRWeUh4t6UiSKfFxBBzNIdBHzNP9EKU6rBJq2Ib6cfPlrhONIQa1IaibJX8ZxKMIDBOlfReLG2SHKzvnSpFDVXKJaLikJ1/pa6wRBsLrBAuXUjA2kd1DyRvVdu7CBgikNQy6QRxQzdNlxs0JLqc5j2XImTcDPAZuHGZMFLvVmgTHsR05wKn5nyOZtABHmcfVRDkgaSxJ0PVV5s/JQrJz1LKb1PC0wsd/rsuyGAvEPISP+WvuEPleSniqLPvEhVKtk2rT7jl6p/vzhRk6u2dlD8SD6z2Sq75XemUxDMCnCFA+tJEFIjhl5hOu8OFBVKxU7whGi6w==
Received: from TY7PR01MB17205.jpnprd01.prod.outlook.com
 (2603:1096:405:32a::20) by OSCPR01MB14631.jpnprd01.prod.outlook.com
 (2603:1096:604:3a4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 01:33:16 +0000
Received: from TY7PR01MB17205.jpnprd01.prod.outlook.com
 ([fe80::7d34:ceac:fb2a:947c]) by TY7PR01MB17205.jpnprd01.prod.outlook.com
 ([fe80::7d34:ceac:fb2a:947c%6]) with mapi id 15.20.9870.016; Thu, 30 Apr 2026
 01:33:16 +0000
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
Subject: [RFC PATCH net-next 1/3] ipv4: netns: group copyable TCP sysctls in netns_ipv4
Date: Thu, 30 Apr 2026 09:33:08 +0800
Message-ID:
 <TY7PR01MB17205147FB6E55AB0964F0BAEE0352@TY7PR01MB17205.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <TY7PR01MB172057C053E8D550485A29A08E0352@TY7PR01MB17205.jpnprd01.prod.outlook.com>
References: <TY7PR01MB172057C053E8D550485A29A08E0352@TY7PR01MB17205.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0204.apcprd04.prod.outlook.com
 (2603:1096:4:187::16) To TY7PR01MB17205.jpnprd01.prod.outlook.com
 (2603:1096:405:32a::20)
X-Microsoft-Original-Message-ID:
 <20260430013310.4048623-1-kong414@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7PR01MB17205:EE_|OSCPR01MB14631:EE_
X-MS-Office365-Filtering-Correlation-Id: 33d9ef8b-860b-4de8-d3f2-08dea6587383
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|37011999003|12121999013|461199028|8060799015|19110799012|15080799012|51005399006|24021099003|25031999004|5072599009|3412199025|440099028|26104999006|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3aM0wzNANwFetzdNATeenVHkFC/gz8Y497rhwg+guhW32eF81RR9EK67mX5a?=
 =?us-ascii?Q?GM16u1QvFkRTR8AAg67J+qWa4ddj2R7Dj0tkCrAPheeaL7GJUKr8U4p7BSuH?=
 =?us-ascii?Q?xherXwFlRD5VexjzJZtlcpjCWCOb4ossH/6xKqYZMSllhMQjrWjCyc/j/ak1?=
 =?us-ascii?Q?YzuYks4rm2Cj4/fq/Td3KjQb4O6d1gdtr7SwhzUD/Ru8VNjpWJ1Q0D0jnUyq?=
 =?us-ascii?Q?EM3FC+0MAqcJlMb79sg+UA6EJTFaawWkaT8sgOV4p64Bs1WlKLRO08H88kaB?=
 =?us-ascii?Q?Irzvip46eJNps8KVEQtL98xZbhhUN9KC5xkh094eNKiuD+LJTr1gqyQKkUWt?=
 =?us-ascii?Q?dGbPmlBe/Vw4+ctFzPlCX5NLih5N+WS7yOz3iJYUFTRpZX8bO6jHFS0LsPoq?=
 =?us-ascii?Q?YgwzZlaLMwwthGPmNSFoH5bZNAVfdNQ7Okuknyd6hScMbuw9ld1baI0uLr2D?=
 =?us-ascii?Q?4FiR1AeJIAmHQKyRmyT3OsvOZ+plBXE6bf1ZXK+j1PbipKP4v1HcYnlg3TnH?=
 =?us-ascii?Q?HGiU2p4WcO4MGloIblwAl1RCe1OhTgBrectWAC1MmtOxwc9d/ME4lxNMIVEV?=
 =?us-ascii?Q?Ewe4sxdsqZPtZIjPvlZIkIicWtUjAQkPWFilHvUmiOH2jyVpNSlUtqWXzcki?=
 =?us-ascii?Q?+deBGyC2MNwjgnurmq/1SCwntW/GBw9WXY17epaqq+zOgsoo2WLQ/60TXfgZ?=
 =?us-ascii?Q?i/LyjVCh+H+fmxHv0lXghjYQVImjOxZ5nIUuqI0vfKF3V5WpaFWK8JHm8ICJ?=
 =?us-ascii?Q?P1H/u0ZZSMtknr5YPDFvqtj4GIbD62wv1jbP+N1qZzDllve3OF0PnudG51KJ?=
 =?us-ascii?Q?GG1UDc90Gg0xl8E2pxLLL0EKdkj3etdis3M282cr/1cm382AQ+YUp5ulDX7x?=
 =?us-ascii?Q?Qo85upRuJTgfcguv23f0uQixbrWiKToPKAJofwPWocEgba5qTyOD5E51t2MT?=
 =?us-ascii?Q?HcA9KXyQHCCMcektFc3tUTh15Vxw3+FhhP0XNpgN/HtVjlypMO0VK7GaQQiz?=
 =?us-ascii?Q?nE3lXsvmVMD2hMsD9zEjm7sSj3gSyFuvQE3MgEJKpmDAEV7t/NRrZu8yT26W?=
 =?us-ascii?Q?jlyvAWe2MiBGd1f9MilvKbTprfAqog=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qvybc+Q/anEV3g5EIrAPnDIACWK1dncxe8rGInl1OlF3yvhd4r0yg0lOSb4Z?=
 =?us-ascii?Q?4a/Fv68xCWTuexqU2Xh9w/Oq7w7z/v8vuMrHd7nStVBxunEyWJwkrfeLH6th?=
 =?us-ascii?Q?WkpMt4Czc1KAZPgI1ykg5OuCXluGmAWpLryiPwp7mJb1xHK9ZZv+7U+qghSu?=
 =?us-ascii?Q?Pw9j0XR7feC9cxIFoNV4YUfGqx0Eu5z2TCuAXL6TnUKUWrd+D1SN+hZBeuqH?=
 =?us-ascii?Q?s8IDKYlxUQwzEOg4VsP4G46rC/oUl5RanVr83gL2dqNYwyMnpqKE/71KGeOc?=
 =?us-ascii?Q?hiRnbBSZK5Vj2gAdkRkZKPI8ZZK7kZDI0tLBXvkB3u5tKN9m4g72Jnx42CSe?=
 =?us-ascii?Q?RVk0JAa7cPFOJh9AWUzXxLYCMPkuT6Gi+GiYF47y0dhC6XsjpXtCSIvoPqQm?=
 =?us-ascii?Q?+WQgg/EiZQKI/a2dLuKnhghQZqafyaMvOiMjvUJ6v+SVNJcfboDw4uVvoVIX?=
 =?us-ascii?Q?7L0fEOriYb1ULKNM7GjJ6Bw73DopHCc7sgDFPW3iBTHLoJNyf4e5vgK2Bhat?=
 =?us-ascii?Q?IVRcX6dsTqNCHVVkqIu9J+/wwCHGWwaGkCFtx+5zELq+fabPoh1r/Gfa+vfk?=
 =?us-ascii?Q?2JXwUF0KVrZTvjFZ6lWx2X6U4UHnrDo4BLuKoAoJxsWyCrrzfL44F7Vh4uND?=
 =?us-ascii?Q?baLUMYA3CuXAHgU5qk4B/GUi6FotYXHeCdmZh132MNAO3+V93KJvog7F/PSe?=
 =?us-ascii?Q?A/9mIo0B+rUfs+oFzk808tu5cBf49kzbUWZPcywkgP8qbYGCFbg7DpSY1yv/?=
 =?us-ascii?Q?RkumovhXiYIfexK0La3lXYlbNmJsEL3xgLVdirqHOjNN54n17wYuRjE+yU+O?=
 =?us-ascii?Q?bM08zw1MVGgSNAEskKSABLduuJpC7dIY3B2697F7bnJhLH926CmVaMe8tB5Y?=
 =?us-ascii?Q?nH3NMkI+0Bam5KUMDXIlnnY1YgXXIFmr15vuTnMLTzqAoK4lMOJCeQvFAuMV?=
 =?us-ascii?Q?e74d/F3g+bqGjjQrSdKbzazFyYozeCpyWyXvEV93SpLF4JWhhVEi7m7jKdBT?=
 =?us-ascii?Q?fmhFTpzJRJBh/xPoV4KR8XEnZyuEQUn/jzsYqfe86XuL5nq2gc9gg7zUh55U?=
 =?us-ascii?Q?YrgoTicGBKVWc7/ri+/PA4Nmo7w1pCVMxK0XLq5QtjSrIldVPcDtJvzlT/fU?=
 =?us-ascii?Q?qDffKiFDdUOmENLmQH92f+n5H8p1tVHYHAwFd6gVhQcB+6FGwpl4j/Hz6Ff4?=
 =?us-ascii?Q?QtFaZgW2Zd/xX3PQ9gq4yJWzc4oTmsXne/5WB07UEfu6o+bXxgYEtIX/L7xZ?=
 =?us-ascii?Q?I18V/aMh2yRqwlQyeljNFKkGd1UJwDtb63lG/88bxT0qwj9Vm0w43cufIeq5?=
 =?us-ascii?Q?Aaw2EUrr8braEXJkD/Aa84vy57d6RqNsaYemd6zvDYJLkk5iYfoPNI4GRCVI?=
 =?us-ascii?Q?jos/3bcBqc3QdLQzEK/dSClWCWXd?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d9ef8b-860b-4de8-d3f2-08dea6587383
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB17205.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 01:33:16.2048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14631
X-Rspamd-Queue-Id: 50DDF49C083
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
	TAGGED_FROM(0.00)[bounces-282582-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[outlook.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[outlook.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kong414@outlook.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:dkim]

Group the TCP sysctl members into tcp_sysctl using struct_group().
This makes the memcpy and sizeof boundaries clear in follow-up
patches, avoids relying on writes across neighboring
members, and improves readability.
---
 .../net_cachelines/netns_ipv4_sysctl.rst      | 25 ++++++++-------
 include/net/netns/ipv4.h                      | 32 +++++++++++--------
 2 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
index beaf1880a19b..f6edf02618fa 100644
--- a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
+++ b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
@@ -43,23 +43,20 @@ u32                             ip_rt_min_pmtu
 int                             ip_rt_mtu_expires
 int                             ip_rt_min_advmss
 struct_local_ports              ip_local_ports
-u8                              sysctl_tcp_ecn
-u8                              sysctl_tcp_ecn_fallback
 u8                              sysctl_ip_default_ttl                                                                ip4_dst_hoplimit/ip_select_ttl
 u8                              sysctl_ip_no_pmtu_disc
-u8                              sysctl_ip_fwd_use_pmtu                       read_mostly                             ip_dst_mtu_maybe_forward/ip_skb_dst_mtu
 u8                              sysctl_ip_fwd_update_priority                                                        ip_forward
 u8                              sysctl_ip_nonlocal_bind
 u8                              sysctl_ip_autobind_reuse
 u8                              sysctl_ip_dynaddr
-u8                              sysctl_ip_early_demux                                            read_mostly         ip(6)_rcv_finish_core
 u8                              sysctl_raw_l3mdev_accept
-u8                              sysctl_tcp_early_demux                                           read_mostly         ip(6)_rcv_finish_core
 u8                              sysctl_udp_early_demux
 u8                              sysctl_nexthop_compat_mode
 u8                              sysctl_fwmark_reflect
+..                              struct_group(tcp_sysctl)                                                             bulk-copied via memcpy() in tcp_sk_init()
+u8                              sysctl_tcp_ecn
+u8                              sysctl_tcp_ecn_fallback
 u8                              sysctl_tcp_fwmark_accept
-u8                              sysctl_tcp_l3mdev_accept                                         read_mostly         __inet6_lookup_established/inet_request_bound_dev_if
 u8                              sysctl_tcp_mtu_probing
 int                             sysctl_tcp_mtu_probe_floor
 int                             sysctl_tcp_base_mss
@@ -85,6 +82,7 @@ unsigned_int                    sysctl_tcp_notsent_lowat                     rea
 u8                              sysctl_tcp_sack                                                                      tcp_syn_options
 u8                              sysctl_tcp_window_scaling                                                            tcp_syn_options,tcp_parse_options
 u8                              sysctl_tcp_timestamps
+u8                              sysctl_netns_inherit_tcp_sysctls                     read_mostly                             tcp_schedule_loss_probe(tcp_write_xmit)
 u8                              sysctl_tcp_early_retrans                     read_mostly                             tcp_schedule_loss_probe(tcp_write_xmit)
 u32                             sysctl_tcp_rto_max_ms
 u8                              sysctl_tcp_recovery                                                                  tcp_fastretrans_alert
@@ -123,18 +121,21 @@ unsigned_long                   sysctl_tcp_comp_sack_delay_ns
 unsigned_long                   sysctl_tcp_comp_sack_slack_ns                                                        __tcp_ack_snd_check
 int                             sysctl_max_syn_backlog
 int                             sysctl_tcp_fastopen
-struct_tcp_congestion_ops       tcp_congestion_control                                                               init_cc
-struct_tcp_fastopen_context     tcp_fastopen_ctx
 unsigned_int                    sysctl_tcp_fastopen_blackhole_timeout
-atomic_t                        tfo_active_disable_times
-unsigned_long                   tfo_active_disable_stamp
-u32                             tcp_challenge_timestamp
-u32                             tcp_challenge_count
 u8                              sysctl_tcp_plb_enabled
 u8                              sysctl_tcp_plb_idle_rehash_rounds
 u8                              sysctl_tcp_plb_rehash_rounds
 u8                              sysctl_tcp_plb_suspend_rto_sec
 int                             sysctl_tcp_plb_cong_thresh
+u8                              sysctl_tcp_shrink_window
+u8                              sysctl_tcp_syn_linear_timeouts
+..                              end_of(tcp_sysctl)
+struct_tcp_congestion_ops       tcp_congestion_control                                                               init_cc
+struct_tcp_fastopen_context     tcp_fastopen_ctx
+atomic_t                        tfo_active_disable_times
+unsigned_long                   tfo_active_disable_stamp
+u32                             tcp_challenge_timestamp
+u32                             tcp_challenge_count
 int                             sysctl_udp_wmem_min
 int                             sysctl_udp_rmem_min
 u8                              sysctl_fib_notify_on_flag_change
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 2dbd46fc4734..53b180cc7a94 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -116,7 +116,6 @@ struct netns_ipv4 {
 #endif
 	bool			fib_has_custom_local_routes;
 	bool			fib_offload_disabled;
-	u8			sysctl_tcp_shrink_window;
 #ifdef CONFIG_IP_ROUTE_CLASSID
 	atomic_t		fib_num_tclassid_users;
 #endif
@@ -149,11 +148,6 @@ struct netns_ipv4 {
 
 	struct local_ports ip_local_ports;
 
-	u8 sysctl_tcp_ecn;
-	u8 sysctl_tcp_ecn_option;
-	u8 sysctl_tcp_ecn_option_beacon;
-	u8 sysctl_tcp_ecn_fallback;
-
 	u8 sysctl_ip_default_ttl;
 	u8 sysctl_ip_no_pmtu_disc;
 	u8 sysctl_ip_fwd_update_priority;
@@ -169,6 +163,14 @@ struct netns_ipv4 {
 	u8 sysctl_nexthop_compat_mode;
 
 	u8 sysctl_fwmark_reflect;
+
+	/* TCP sysctl fields enclosed in tcp_sysctl group are copied
+	 * using a single memcpy() in tcp_sk_init()
+	 */
+	struct_group(tcp_sysctl, u8 sysctl_tcp_ecn;
+	u8 sysctl_tcp_ecn_option;
+	u8 sysctl_tcp_ecn_option_beacon;
+	u8 sysctl_tcp_ecn_fallback;
 	u8 sysctl_tcp_fwmark_accept;
 	u8 sysctl_tcp_mtu_probing;
 	int sysctl_tcp_mtu_probe_floor;
@@ -227,24 +229,28 @@ struct netns_ipv4 {
 	unsigned long sysctl_tcp_comp_sack_slack_ns;
 	int sysctl_max_syn_backlog;
 	int sysctl_tcp_fastopen;
-	const struct tcp_congestion_ops __rcu  *tcp_congestion_control;
-	struct tcp_fastopen_context __rcu *tcp_fastopen_ctx;
 	unsigned int sysctl_tcp_fastopen_blackhole_timeout;
-	atomic_t tfo_active_disable_times;
-	unsigned long tfo_active_disable_stamp;
-	u32 tcp_challenge_timestamp;
-	u32 tcp_challenge_count;
 	u8 sysctl_tcp_plb_enabled;
 	u8 sysctl_tcp_plb_idle_rehash_rounds;
 	u8 sysctl_tcp_plb_rehash_rounds;
 	u8 sysctl_tcp_plb_suspend_rto_sec;
 	int sysctl_tcp_plb_cong_thresh;
+	u8 sysctl_tcp_shrink_window;
+	u8 sysctl_tcp_syn_linear_timeouts;
+
+	); /* end tcp_sysctl group */
+
+	const struct tcp_congestion_ops __rcu  *tcp_congestion_control;
+	struct tcp_fastopen_context __rcu *tcp_fastopen_ctx;
+	atomic_t tfo_active_disable_times;
+	unsigned long tfo_active_disable_stamp;
+	u32 tcp_challenge_timestamp;
+	u32 tcp_challenge_count;
 
 	int sysctl_udp_wmem_min;
 	int sysctl_udp_rmem_min;
 
 	u8 sysctl_fib_notify_on_flag_change;
-	u8 sysctl_tcp_syn_linear_timeouts;
 
 #ifdef CONFIG_NET_L3_MASTER_DEV
 	u8 sysctl_udp_l3mdev_accept;
-- 
2.47.3


