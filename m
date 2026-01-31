Return-Path: <netdev+bounces-255522-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKY1JS+Cfml7aAIAu9opvQ
	(envelope-from <netdev+bounces-255522-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:29:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0C7C434B
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DC22306FFD5
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 22:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B93438B7D9;
	Sat, 31 Jan 2026 22:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="fj+Az3pp"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012065.outbound.protection.outlook.com [52.101.66.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12AC38B7CA;
	Sat, 31 Jan 2026 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769898351; cv=fail; b=PGBhDWPz8bYHUaG2TtilvoLMYXvb8aZZZA94LMjR3Y7aMjru778M/qdNVdMkpBvMC8kyvec9jOqcKTlFTABH1XLr7iUCmNwMzJy/WboLwgrQwHL69pQwfcUbTpfUurlnig8BxOSIj3uTbVpDiDaVx0ncPKAjX3kg8pJFgY5MHBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769898351; c=relaxed/simple;
	bh=52upW29ex2VBlQy6E9EIY9SdWpmj9Vjkrq8gztD6Rjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KMhUA6cOXRmhy4yArpQ98xFj3boKjXed/nLw8HrMgLJ1dGnan6rgdEWYHIZadPf+OAmteZoOHJlGv3OaRFNxH70sdGkr63gy1gcnNcxhRf36TVftgnGJ9fnYCgCoiAU6egp967ReLJ9f/gw0KzgBM5jxhR3zWkf7q+pf95sUCug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=fj+Az3pp; arc=fail smtp.client-ip=52.101.66.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekduTarMHtGJbXHM29dtXYTo+QmkvZ5qLPGUwu6/vHih3RiMJaBgzMaM3CyZRCIiHdLDgfEQ7nFGjVdlZXvCQNvKMXwHeNxcxLSxbA+bcS3W6szBsA6v5nJ7+dPxdk8g1sXGT9Z5iDpMeEnuJ1Z8Qvn54sL5ypwG9S+RsdmvZjovJHUB4CdtOZ+7WXzqGAqIBRKTtBaYZVqVliH4jGHZcAIfDkq4a2koq7mLrHIv2VAJ/68aZ4DwvJO+QrhEprEnrc/Xl9pai02OTv2swDNNHDASOMgzuv+oZAiSrRlE4mafbOlZ85Y6W59rQU/kMw+8evUjUsycKE/C0OBWb4jbSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3H9oC1V0O+DQRI2nhe44c5T1amcsvp38oL9WYYjROCw=;
 b=LeC+Y1gVF7zCnVIpih8Sy4BwKNMYtKIehf6yJ5f6pUiEwC6tjFQhLhX+bDSwKHswtFEgVqd4PgX1AUyAw+FhmcgQWB//j60bgvaQLpz/a67gX6QW5Pg5es+tlCr54N/ApJIpnwRx1zde/ovz22FzNe42KP2Mb+ytozLePqdWUQGU+50BoEhWf0xOn5KtSnGelKnk5RW72KI1fe4W8eUWr8iDJtB1OarTKCKTG0BRmaiL/ohIjA5sk2WZ76p0gi08SvSnzWlpbVyYFcutMrAY/DXyQLxncW8gRZDDcl1pkfoY3WepPICjpYBiPlP3KFMcLQBA0zc9fRyyQy1HrUhA9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3H9oC1V0O+DQRI2nhe44c5T1amcsvp38oL9WYYjROCw=;
 b=fj+Az3ppZNJFH1V7UPpEQeiFtvYlTZ/nGbnEFaPyoKuFz46sUgZlVyPjyZYeqevMbN7CSTzv4tZkiqZFZ5QNyQpR3LOJdkDwGJeSx6716tKDVygygmDjR+wcOnxXBGi6PT6pBJxRO+fRVm+U48PjmhIw4K4196+tS0HXGOK7zAoy7L2gaLiiCHlsZwExXmEmoZY0eL4Uewg/nRQiGIPVCtzKymPrA4vyLg3Zd0tUBX91KkwFXGZyddPRicmCKoAeNhh/IF3RSi51QKsovICtK2Pc5nqewXjIbBtslyg1jVsbx4VpmmMi0C4J2Ft6Ay4qxPIkNrkND1xUXBMS6CECCg==
Received: from DU2P250CA0022.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::27)
 by OSKPR07MB10542.eurprd07.prod.outlook.com (2603:10a6:e10:98::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Sat, 31 Jan
 2026 22:25:45 +0000
Received: from DB1PEPF0003922E.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::e9) by DU2P250CA0022.outlook.office365.com
 (2603:10a6:10:231::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Sat,
 31 Jan 2026 22:25:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB1PEPF0003922E.mail.protection.outlook.com (10.167.8.101) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Sat, 31 Jan 2026 22:25:45 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 911F1238DD;
	Sun,  1 Feb 2026 00:25:43 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v13 net-next 07/15] tcp: accecn: retransmit downgraded SYN in AccECN negotiation
Date: Sat, 31 Jan 2026 23:25:07 +0100
Message-Id: <20260131222515.8485-8-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF0003922E:EE_|OSKPR07MB10542:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f0bcd6c7-e369-4143-3dc8-08de6117ad41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fCVBBTxgkU9PfImviTMSPBKMXaCRzSOCdAcM6sYt7RpVBuc8wzBW9LpbIpR+?=
 =?us-ascii?Q?zooxab+jMPeOYAHRBKVMJOZVHpWauD0WezBkQo+HDipafZF3pC+qpmyUwJoC?=
 =?us-ascii?Q?j9wmZagmjUlXXCTpjHr4PnkdTEaRP7ZiPUzxmMzQFeezF5Oc1SNhwvnrqNCn?=
 =?us-ascii?Q?nIOV2ZsKo4OkEHeZVkmAuf+Ai4FuoepdtU8Xq9Wh8LA949iodxoG2RvE1s05?=
 =?us-ascii?Q?bSBvKrrLRwsMJfK7jkhhqAhUMNaKfWxFPSuRIbab4zVZBwme9eo02/OGv2Ru?=
 =?us-ascii?Q?gLCk/TnGthUQaR6SVYWiZlubwFuzF9W7sYnBYBuYJ7iMrzpEkmxd+9iMVQFb?=
 =?us-ascii?Q?Oc98dkKcSYV6FRjasdHYOTzLfDz3dN3ozpMBsLeLRrzpjJaORtVpVafv59Sp?=
 =?us-ascii?Q?T0amwyD5AXS+k0Ekm+BTwd1Z9sWQJCQCM+VVrL8NoVFoeH9hrwPuGr/LLKe5?=
 =?us-ascii?Q?uYy6FoJwbaJLuYHM2HhoQyPqZlSPdhkkVVPJc81rpU/SGL5P2OY/SFx0XH+P?=
 =?us-ascii?Q?bQ/GwMHzE1V/zRcPFl5nf++TYN/HQ969u42uWXGLzf6nxIY5PgT9QkAY5ijr?=
 =?us-ascii?Q?6KH9OSWQ7zVibp5VWxpDKc2jnh9ms9+efhcDR19QNPtKb/pGHuGcelECd0It?=
 =?us-ascii?Q?OXJ5Zch2Q1EN4WPSU7tX1ZfnZyiLETRXLz21W0DpTQpriPDrVmr0rdVZmxyb?=
 =?us-ascii?Q?Kz6XzIYTBSRfH0c7fKljePzS3mGZ9sDTajHs2iqFZg+b/5/0Z3NLPJJ9KREC?=
 =?us-ascii?Q?vHthWaplVfwQF7WqgW9oDT+stcgXfdD6Nbu4Stp4BfU8dC+yrKyj3TRC1D9g?=
 =?us-ascii?Q?UTO7vK051hiwnr5SBBqJQA5tMxDJuThmnVXHJeQAKmb+3GI2A1OldtudOd6d?=
 =?us-ascii?Q?yK33ainipO+7AGGYGJC6I51i6ujgnQL9iCgsUZ89BWN+EndM8XKbW0KJtkEn?=
 =?us-ascii?Q?QxlXYoNrKpD0eQFz0XBIK2J4ZhbS3VTFzlkwLrQlR6KaQDZ8dPF5D+JRsqz/?=
 =?us-ascii?Q?+VuD0hhVtjkZqVvUUPulozQ5O7C+MtLMri8+jN5/LgiFWAs8fkgY7pJeR1b1?=
 =?us-ascii?Q?w02Uuc8WUMDM2JtdX1cy/5nrnoByfEF4Tjjo4HKJOpBFj5NM7kwHFOSQPhNK?=
 =?us-ascii?Q?xYEl6htZfCpeBHgGzNJHZUUifcXm59RrI91L3+/7S6D57th8G4lNzqNkduNj?=
 =?us-ascii?Q?GZfVpQr+rOEX1clps6pJxa6yYJt/heygSWoe11WbsxdyS1sEudh1aNRdY5wO?=
 =?us-ascii?Q?YhjxzuXwO7RWCBfqwLw8htFCjduI8LoVj/E5YefuReoeXRnlDm0k3iiR76R5?=
 =?us-ascii?Q?4jFhy180Nk5KGzrL+1sJAqMB3nMYz5bHIIG7GWSfyEipgUmDKLi0a1AfVjip?=
 =?us-ascii?Q?NpMwCM7ovQNZiwddnhOAVUtSW2pEL4tw6RXXIw7pmWyFfx0/8xzaqoj3w7OX?=
 =?us-ascii?Q?bwtHouON5S/2sg29XybbMR4ArEGRZehWzoAKLovvuHCbBaxpuTs1oMWbFRhN?=
 =?us-ascii?Q?WS1gVmUJv1/+imvTw2M7VFCTcTXk9y8DILkfVNG5ZFbAQC56QIsiqu32zwEL?=
 =?us-ascii?Q?1nhYAkMvq0bveiWVkcQE/A8OBWWb2LxvoxW0EzqkeQ9SdkTYOriW/WG1sP65?=
 =?us-ascii?Q?rU1d4Dd946vzKi69siVdBK5yCGC2x0ExWBqxxcSZ0SXAuyf/pilQixLA96gY?=
 =?us-ascii?Q?RVStSwwgFpPU1cY9NpWDSxNp/MM=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	guTaLbRBxnLSh481h8RtLI80CzNLo61oZC1uzbnachUrk3d12BHr2xs9XU0aKlXMzyl4i2Gh4+dqHm8rkgn07Ya42WG0EgrFoOngICREUCaw0+Y4cOCYeteKm1BVA6sf5dZaLxapk2s+Hxt8pcWVN3gIZXhWuD7Gv6ET2JTojdimwuyG7bKFUD3rX5wqPbtr1K3TcdCyBScXlhSnGZG+VRBRuwpzQ2zfV0ntuVECluoa3ATKfDs0OZcAjIMiqk3QBXz2a3n8R4l1Ipo3UJVFaJ/K4si+kpmY22OQho9D5FCcGn+Znk5pUOluSUCl5/XnByB003Ezsq7ROeu9RIoGTNxaQPItEvHvemQgQs4zP1nPTQ58kYrcZ6+Q8p4xllfCaO9mQ9tNkv/HvdY9FQzAFlCmsxIYQG/McBnBWwABJb2uBJo578c/tEHe3e/R2s2J
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 22:25:45.1254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0bcd6c7-e369-4143-3dc8-08de6117ad41
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF0003922E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR07MB10542
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255522-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1C0C7C434B
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Based on AccECN spec (RFC9768) Section 3.1.4.1, if the sender of an
AccECN SYN (the TCP Client) times out before receiving the SYN/ACK, it
SHOULD attempt to negotiate the use of AccECN at least one more time
by continuing to set all three TCP ECN flags (AE,CWR,ECE) = (1,1,1) on
the first retransmitted SYN (using the usual retransmission time-outs).

If this first retransmission also fails to be acknowledged, in
deployment scenarios where AccECN path traversal might be problematic,
the TCP Client SHOULD send subsequent retransmissions of the SYN with
the three TCP-ECN flags cleared (AE,CWR,ECE) = (0,0,0).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v10:
- Update commit message

v5:
- Update commit message and the if condition statement.
---
 net/ipv4/tcp_output.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 597e888af36d..b28596655d73 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3606,12 +3606,15 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 			tcp_retrans_try_collapse(sk, skb, avail_wnd);
 	}
 
-	/* RFC3168, section 6.1.1.1. ECN fallback
-	 * As AccECN uses the same SYN flags (+ AE), this check covers both
-	 * cases.
-	 */
-	if ((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN_ECN) == TCPHDR_SYN_ECN)
-		tcp_ecn_clear_syn(sk, skb);
+	if (!tcp_ecn_mode_pending(tp) || icsk->icsk_retransmits > 1) {
+		/* RFC3168, section 6.1.1.1. ECN fallback
+		 * As AccECN uses the same SYN flags (+ AE), this check
+		 * covers both cases.
+		 */
+		if ((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN_ECN) ==
+		    TCPHDR_SYN_ECN)
+			tcp_ecn_clear_syn(sk, skb);
+	}
 
 	/* Update global and local TCP statistics. */
 	segs = tcp_skb_pcount(skb);
-- 
2.34.1


