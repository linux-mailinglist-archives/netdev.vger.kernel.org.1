Return-Path: <netdev+bounces-282583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJYYA56x8mlhtgEAu9opvQ
	(envelope-from <netdev+bounces-282583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:34:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EAB49C09C
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04F893036EA0
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0445327A476;
	Thu, 30 Apr 2026 01:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Oso3QZpl"
X-Original-To: netdev@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010001.outbound.protection.outlook.com [52.103.43.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A398426A08F;
	Thu, 30 Apr 2026 01:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777512808; cv=fail; b=pNK/cMtInQcBTuddXdtHAL6Hh8YrIXsBmgLsS4JYiANsAKg2ozX/Q1WlBjXRGn5r4xllw7WVhfVDWOvMUU1MUkiH/RMtQ1pNCX2nxKTCfDHElKsiJIj8Bsa0iOsybeNe47bfP4wj6vWGtqrFKThRwlbTUL5aOJ6sg5OezNUTAcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777512808; c=relaxed/simple;
	bh=GVlJcRe81w3PIUNLq/A4XHWeYZye1UPKpnX+LrkQAGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q5FguZxR8Th6LlK6N/Tx0B5f9zI5ajnSWfeD/FUL+9QI/D6nBGWGi5pvVltwB/jWF80t+2sNf0mcaaM27b46iEAAUJjqvm6AiDnmbZtyTPsNdWG1iiSIlIsGjr5jyOXIposRSSwkbM8wvRVpjXmDJu9lsSnccphyB/eAjagskb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Oso3QZpl; arc=fail smtp.client-ip=52.103.43.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkFiAWA+Om/I4R7IY+FIcI2YQqjVJfeRoEOhZiQiThRDNgNJiI6a1JOcxMwv8Bo1/8go4U+u+g1IEmKVxVFEohLP7rCrdHzVB2kh2IG8kqS79Z5aaU44a2tzZqPL6n7ZxbnXCdL22iQqaJO8c09ooVYqTw4og12kOVe9h9EYnOUUL7cj6/nZx88OimRxk2N3H6F34C6ygF7CnbWyhStuMG6JFHEpVLGUWQ8JDmmicTyAIY1/m+005f8MxS5nSOd1umCZjErFdFC4Qtf2N4CDi4Tq11EmrkdR98UrkCZf+oCaqE/0TgSD9XodBC2TsBCZF2sun7ER3dfu9EYGB/eOdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10joYZ4iCbOMRwXxn7QblVKQZkX1l7nTwTTdokKl8Ok=;
 b=KEuiyve7qODyXNCLyZq7m8mrx4++uopNJenqwfR2L14l4YubIY0p3zpY8boHrcgIFB1lpAMrVycvNBBBF9v3zUrm3xmmFMPox1x1fLvtpO+L34hRHDOhU527ygVyFXNGbhYfXIfGJIOJdPkX8lhqNz3wHMzzV+uupF/CvFbnMgbYap9S8Xz/REdcz6YPF/kvT5s81V9Rh/fMcaUv+gOA5pUUABUoiPPWMODILW11dMszGPBcdlLxIn+kIi1f5BX+/ip466av4Zz2sZoRSwpuTkIX+6B+gL01PbXYiwXpCVaa0OddoA7je6kfe7PsZ+xmARbzNR0v4Wsem6wfI1GkTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10joYZ4iCbOMRwXxn7QblVKQZkX1l7nTwTTdokKl8Ok=;
 b=Oso3QZpl76EdvFwhD0nuLM8eLpvmhl5PJmLcryk7GZVEcz6gzKfx1Nz9IipMldb7KnCHI0BZyLG6B0775ZLh4T7n5tm+KFEeSUXQBYwhx36gu19WTUCUp0zKeENKCIM9AIp4S1SStkKgofCm17fcBjSd3CVRcyM9Q3HhQsrb+H8hTXQIT7VhcVWPC4jCRmgUAEaQNuoc7aOVHRK/9hx57IISm1oX38tiDxt7aj5ebyVtR0h022L/DXbnNxalqupokCtOlQO0WvUzb9SKaFkoSWD76WAXohaK2cPx/t/zqunxd5FClnplPOai4rONyyvxpxm7anlEpC4F2lQhi2TEOw==
Received: from TY7PR01MB17205.jpnprd01.prod.outlook.com
 (2603:1096:405:32a::20) by TYCPR01MB9433.jpnprd01.prod.outlook.com
 (2603:1096:400:199::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Thu, 30 Apr
 2026 01:33:21 +0000
Received: from TY7PR01MB17205.jpnprd01.prod.outlook.com
 ([fe80::7d34:ceac:fb2a:947c]) by TY7PR01MB17205.jpnprd01.prod.outlook.com
 ([fe80::7d34:ceac:fb2a:947c%6]) with mapi id 15.20.9870.016; Thu, 30 Apr 2026
 01:33:21 +0000
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
Subject: [RFC PATCH net-next 2/3] net: ipv4: add netns_inherit_tcp_sysctls sysctl
Date: Thu, 30 Apr 2026 09:33:09 +0800
Message-ID:
 <TY7PR01MB17205D42D4C8BC7AB6BD3539DE0352@TY7PR01MB17205.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <TY7PR01MB172057C053E8D550485A29A08E0352@TY7PR01MB17205.jpnprd01.prod.outlook.com>
References: <TY7PR01MB172057C053E8D550485A29A08E0352@TY7PR01MB17205.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0201.apcprd04.prod.outlook.com
 (2603:1096:4:187::23) To TY7PR01MB17205.jpnprd01.prod.outlook.com
 (2603:1096:405:32a::20)
X-Microsoft-Original-Message-ID:
 <20260430013310.4048623-2-kong414@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7PR01MB17205:EE_|TYCPR01MB9433:EE_
X-MS-Office365-Filtering-Correlation-Id: 02a3e923-03ba-4bb1-7c62-08dea6587679
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|15080799012|16051099003|51005399006|37011999003|23021999003|25031999004|24021099003|19110799012|461199028|8060799015|40105399003|440099028|3412199025|26104999006|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qwxvjgFJry+MDE0CZ8KUzy06CMw9pA2+z3ibyarg9RNQr0BVWMIrHv955NfV?=
 =?us-ascii?Q?vKRmKhRvRTG1vmlasTN5FY4ivXS4a9i8d5KZlRttpvOrwmypQTBxHR+2pwoi?=
 =?us-ascii?Q?m4OiqBGSwxLaD7EcLaHGzw+nrtm9DDtq58lqVy9ov6cvrOU8IhyRlKJqDB4d?=
 =?us-ascii?Q?t5qBpUj9GkdCU4OTftuoLKdMhwjKoutur95eQmMLhO6S9/KMRubmvgpkPvBG?=
 =?us-ascii?Q?7d0rnvrOpRGJ52H8fEkEye4d1055CE/qY+r/kFHvRzABpe8vI89SByMnBR70?=
 =?us-ascii?Q?qNlcYY3bPBg1HzMgxxDOAsiFZPkQ8xG7Fw/QFFbtq9uLPyxD6JKaDyWO5jfM?=
 =?us-ascii?Q?IF4pakFkuvmuUFlPba/UXsJ1pv3i38trrdEJhKtAnSwq3NI5Zh9Tw4Qtp5jV?=
 =?us-ascii?Q?e55FfIoEwHE2aTK8doASMW/4wROx4xhyuveVXyw4DY/a8ae8C49TE7yqwUr+?=
 =?us-ascii?Q?FsGniv+w09X2Ktv0kK5tDa3zcI9fnMOOHuwpqh8ahAAjaIDgdtsB84j3CmcE?=
 =?us-ascii?Q?xmEVXLIa+Bb7B7Fz8MiC4J9WBNjVjvI2qRX3tvrgJt59V7/9WEUfHrmxK8xT?=
 =?us-ascii?Q?ekMKguB8sCkYbjt4nDp+mi9FxVLsDGH2EB8bRQUsMx1+vbiGRRJ+STGo00XA?=
 =?us-ascii?Q?VMub8zRQhZOWe4jl3X5pmFIdhxBLg5fpceBBWEjCJDrZol6T3vF39YRyMrtS?=
 =?us-ascii?Q?f0kN4kekaYcp5FdnkvJVaSNB29TCBb0cgrZqO8c0+wrQruc9WlGD8z178Gla?=
 =?us-ascii?Q?SJVWYvNhXiLmoXmYLiNlZRmrY1UtaJ5QMvQVH0AUETpL/BMguFNx35tBUkxM?=
 =?us-ascii?Q?rsosEmMs4PNaQtgAo4xqWfbfqvUii3GS8XcWxTJbqQCa8w1vL5tH6ntv5bjB?=
 =?us-ascii?Q?txxQr4MWswdq84ARbfd/26T61PHqK6Egd5ym+vwTky5g0zpt/udQtaoAWzvB?=
 =?us-ascii?Q?/oEtd3w1F4/9zdbWRg53hyjdI+9ONkHu9gcc58dw1jx8ZPDFL0hSwTunmo98?=
 =?us-ascii?Q?EFrY9y1faGT6sIruKCJYa8q/U82+2G9gxM2BxuW9COrgJc72DI8h7pzgDEJb?=
 =?us-ascii?Q?U4dewQe2vpnJZTjTPpqqGdXMcO8Sag=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yaIp90Gj+JCnT4OlmJFV7BC/9ZeOuSCncMq6JHGq8N/gBqcLaAhekFvGpDts?=
 =?us-ascii?Q?Pj8EggmsIsBiRrZb0qjqN0hat6rnwZrKcK/rX+i+mM8zznepNoqrYpKEvx0H?=
 =?us-ascii?Q?eFbDVWoY4XuPQwXWALKCUGXUzUCcnBZBHk1nCNu9o16x/ZVGNu8StNA8Vc9P?=
 =?us-ascii?Q?N4chuPwpW0lIXEj9jsR7tcMFzaCQu4rOU96Ys5L1l/rCGmYJDnUEAhAgeRYk?=
 =?us-ascii?Q?qoVmWtGGw188laGqObcrbhdWtk9gSl4mFqBXvuWiYGRWHd1htsS5+zfP0Md5?=
 =?us-ascii?Q?bISKuGhDCIgK7dh74ngdUviZsZmiBAg86cEdcfRo/dgbZKfVUjsm0bnD/5b9?=
 =?us-ascii?Q?lHSdfHTYHgClOMxsD/lJWtZmmqaaI2lyDq/Um/lxYjLoGY+5GxsSotC6Z5km?=
 =?us-ascii?Q?3rduH5JeGxy1m1em4N63NIDMm8nvHQkPRam1ZUJVPv9VwajsiA+JB8Kllyb9?=
 =?us-ascii?Q?1JRqZcJnfnr+1PdxTk159Ll/VYHoECj2rZMUfriguJ1vnmWFMWNkBxtHLiV2?=
 =?us-ascii?Q?EOJYnKmVwKmD7naWppYKmvmok4F7UfEVZlD9lf2Q3YbTnyiCCBx2Hwqsa1kh?=
 =?us-ascii?Q?rP8q+MXO8V5Aqvanjf2g96H3agitd02fQKKLbLcBlz06QCzkrLQq7gS0slNq?=
 =?us-ascii?Q?hTDvZqE/n1LfsNsnvVKbIt8FqSPZbcmX4EJ6ddIWjqrcDkUGZTYtYyAwhz+h?=
 =?us-ascii?Q?pUPWrS/gnNlTZJL4n8+Pi3KIO7Oqvq2vvS7ojRLxLukCm7qDAuFnakcvlKYC?=
 =?us-ascii?Q?vnNpgtKFQq2asjigQtgYlgYMJlqNjuetgUMYzdSsguQ7tllPtH0eqsMHATAD?=
 =?us-ascii?Q?+dWWRbgMFI3F63qHBiXmjAVD1xc2xQyApNq6DQF/T6UbqcTrRg6P8ygKYfGE?=
 =?us-ascii?Q?BnU1sn+xj5RNg9yVCSxtjCiJ5kEUAUopiwzrlJvgyGEtzmEACfHFwu3NWNVp?=
 =?us-ascii?Q?xcekXkhJWfM7qu3qQBOKieddYRswkXXOMSYc7ZM3PU0vbj/S1KAwD10b+cX2?=
 =?us-ascii?Q?zqFtyYHYiJtz3zez8fHd1OEqzbRzlI2VfJyvtQzGXPSEJ7f+xeibuh4KZxXZ?=
 =?us-ascii?Q?nvf9IponnwWxVVxSZDHdhfYSVs8uWeyEr3c2t0XS1fTTeVG3ifb8H5ANIRQo?=
 =?us-ascii?Q?8MEz1lPVUy/rsQxxZ7lsFjX1SIi2gTSge41N3MWXPuZAyof9cxywJZ1dLDmg?=
 =?us-ascii?Q?Q3XWED0/vHFCH1OLcovv8Edl9B/UqTrEJRs/Tb5TsnREqN0wSv5uJSYkNAeO?=
 =?us-ascii?Q?+3f5/0nprk/R/XiuE01YhsgTWJDBIhI1Kgk1M+AKcSoXdWkWRugg6W195VrD?=
 =?us-ascii?Q?Uw9B1iE6tqsgFRZCZlvCBsXm8TZAkj/ICUO1RjkOIz2guFDffu3Go+YqrFql?=
 =?us-ascii?Q?cnwC5ULCf1UTMaM2kJsnaC7iDzVI?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a3e923-03ba-4bb1-7c62-08dea6587679
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB17205.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 01:33:21.1222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9433
X-Rspamd-Queue-Id: 76EAB49C09C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nokia-bell-labs.com,nvidia.com,suse.cz,google.com,vger.kernel.org,outlook.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282583-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[outlook.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Add net.ipv4.netns_inherit_tcp_sysctls to control whether a newly created
netns inherits selected IPv4 TCP sysctl state from old_net.

Default is 0, preserving current behavior.
When set to 1 in old_net, child netns receives parent TCP sysctl policy
during netns creation.
---
 include/net/netns/ipv4.h   | 1 +
 net/ipv4/sysctl_net_ipv4.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 53b180cc7a94..184498d4d541 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -60,6 +60,7 @@ struct netns_ipv4 {
 
 	/* TX readonly hotpath cache lines */
 	__cacheline_group_begin(netns_ipv4_read_tx);
+	u8 sysctl_netns_inherit_tcp_sysctls;
 	u8 sysctl_tcp_early_retrans;
 	u8 sysctl_tcp_tso_win_divisor;
 	u8 sysctl_tcp_tso_rtt_log;
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index a1a50a5c80dc..58a310c029d9 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -1641,6 +1641,15 @@ static struct ctl_table ipv4_net_table[] = {
 		.extra1		= SYSCTL_ONE_THOUSAND,
 		.extra2		= &tcp_rto_max_max,
 	},
+	{
+		.procname	= "netns_inherit_tcp_sysctls",
+		.data		= &init_net.ipv4.sysctl_netns_inherit_tcp_sysctls,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 };
 
 static __net_init int ipv4_sysctl_init_net(struct net *net)
-- 
2.47.3


