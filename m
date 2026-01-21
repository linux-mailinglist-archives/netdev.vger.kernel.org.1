Return-Path: <netdev+bounces-251929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eF9yEFDocGk+awAAu9opvQ
	(envelope-from <netdev+bounces-251929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:53:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C599A58C7D
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 00DBAA8B358
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AFD4A3409;
	Wed, 21 Jan 2026 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="NShnsBDN"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013058.outbound.protection.outlook.com [52.101.83.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6204E48C418;
	Wed, 21 Jan 2026 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005972; cv=fail; b=ZKv+pIqodfK/gn3Iy36Joq7LQ0wmgdg9D+/Lw+3LagYI/KCe2O+n9YBLijgNAb+1QYKXqiCE22GqFsPIhAuTL4UXFngyK2rW8Nq7CGuKnBr9cap1zd328HcEg6rBXm5AN1NLdAsNxwNmGubZawY5lzAGGhI+CXgUt0sgQqLqZ18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005972; c=relaxed/simple;
	bh=XPHra/U6CpikiCMPz0XVBJAaYfZPD5ZkwcFlx2LKh+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZiBwu/ngOin/8QKnL/8TatPIQUsNaN0Ri3+ZfPfGWkwOQeLmoPRo4ZiCOlsT5mlR6r5aVdFtdgzOOI9fNlSA0/yJ7qKNeER1ixG+/5sqBD0y1N85CKYRK9gg7tzmEuvdpiiNbraLTPsEynVGwxYCBiAqVN+9G3X7v7Fps8/txM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=NShnsBDN; arc=fail smtp.client-ip=52.101.83.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MzQVI4hbBzDu5E3YFNx08d+SdTxbYBqSu0que22axBw1+7Tx+BZPukTRN5GIXy0byspr+R8RortIewMKwuKYZcVfFy/1YFRVVUx6tQ2xJksEAc9qnq1oJDID4nUKC6W2a93bfsxSNAfzUt5zzy7g+lZYfnKdp429UGiW31VHjAGxlydf+xn3yO3A0JpZ5wBqI6aQZUJU+Me9G2IMwO3Q0twqQoN0oyevfKHiwj489YJBzCH8Be1GhGCsgwkbQuLGeCHCaRjMhAJwEmo+PBEycqNvTIiIznCw90IP5LSggTurGLNVHskWex0Y2LQYkPtoZ52f0YsTwB2S3Em98w0LVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLZrkZ23iEw25HckkW3DAZdKVTIWWu6vYfRfuN/M1R8=;
 b=sA7bGy+l1roMXfovhR56fwmKk0//36mhYE8Qh2IgmK4okdITYuXVhqUruaWaOlULZvjEtWrkoP7Jot4pbDhQGrxRoyC6HR37KCdgZJ94qXHSTu8uoE5grlSSmelNjiwx053r5rX0Q58tsL0vvKhE8tq+89DDzjlSz49j78UUCbZ9taYNR3T33aZB0WpmEnL8ppfOmOdM6OxwE8+iaifF/Djo8dtdxP2xkni4gWewRzAKJK1vZLxIozHJP1ST77eni3sOnStzSBM/BD5fcX66ImSxj0g2jYfrACKOUIm2P9AzDmywTvmG089fF4Fbcqcx2GpNjR9BIV6kxIk6kl+43g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLZrkZ23iEw25HckkW3DAZdKVTIWWu6vYfRfuN/M1R8=;
 b=NShnsBDN/o25yE31YIEcqMJpfDuVxzaN+EyuDVkJRKL0koEGHMeLYBIO3Z8dHhNQhKo94nUv0f6zBVlS5e+aTl7XcXbl62sTq7hYqRwDxgNobTqTz7Gb0O7T65vWG4ox4OIgEtxMqUoS73XcWEv3NBqUtszmhvGc3u0RBe5TKG76c5mcOPGg8ZuguyviAqN06ChOFoC2V5RYlocGwDb1BxgoqjtnEi+UN8gYZmA5bqLCH4zRZwrOJUvlW4z21sze29dE3gMaJXTjc4uw8lYDxWbR7IdmHeZnvmdUskJmLRi7ZSo0WHtrN819TjgOjuB8xF2gD4fhGzaOub/KT0r0OA==
Received: from DUZPR01CA0031.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::16) by GVXPR07MB11465.eurprd07.prod.outlook.com
 (2603:10a6:150:325::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 14:32:43 +0000
Received: from DB1PEPF000509F6.eurprd02.prod.outlook.com
 (2603:10a6:10:468:cafe::58) by DUZPR01CA0031.outlook.office365.com
 (2603:10a6:10:468::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 14:33:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB1PEPF000509F6.mail.protection.outlook.com (10.167.242.152) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Wed, 21 Jan 2026 14:32:42 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 678B82034A;
	Wed, 21 Jan 2026 16:32:41 +0200 (EET)
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
Subject: [PATCH v10 net-next 12/15] tcp: accecn: detect loss ACK w/ AccECN option and add TCP_ACCECN_OPTION_PERSIST
Date: Wed, 21 Jan 2026 15:32:12 +0100
Message-Id: <20260121143215.14717-13-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121143215.14717-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260121143215.14717-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F6:EE_|GVXPR07MB11465:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: dd608f1c-2789-4717-4861-08de58f9f00a
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?0SsrQkDcoE/oK+sW6MXhRo61zBw8psd6LP/hya/UFHkkBDczVLfuSKCXUdGD?=
 =?us-ascii?Q?4K1eb6Uhw+4N5kf2xRaVcvtRQlRduRYH8yleWMShALpVkLl5cqNKScNWtjV3?=
 =?us-ascii?Q?QhbVJrbIqAwxE5k+oXJl/IRBSVEuE5MBQmtY0Ak7bnmaMlMSofyYTRdxonAB?=
 =?us-ascii?Q?RYoTkBFzQK8joviprJJ/DSM3JoeMbDAsJ9jX+Us9kY58REjRi4p9XCDCIlZ3?=
 =?us-ascii?Q?eK9OoKIEKexBWEDKJh9cR6/N7doBSqRpewjH11zBXpo96qJ+nTtdL2aKjNdp?=
 =?us-ascii?Q?6uVLkfW83GocP95VIKep44jbgsl/lMowFlMnrbmI/3BI0Df45PEK4tPQ1GnH?=
 =?us-ascii?Q?3D+6GK1Ce3Z+eqgLh3tx93b++WY7sdiG7ItXjjHXVrA37udwOjPij8TsZg3y?=
 =?us-ascii?Q?hlMynWV5QtGijBpDXKH1d11fEIBTiDePwKYiUHRw/quyXxYRfrLbldLhJt+j?=
 =?us-ascii?Q?WvlpMnZsVIRDuA4YyqHblqz17pMyKkwzbrTMF0VQZB/Phx8GuKrD174m5ETd?=
 =?us-ascii?Q?pwhf3GWvQ2t5uUdJ20QyaGNPoQ65k2sNvH0ZUmK9S8+qsyEG9l4x5ZNlEe5g?=
 =?us-ascii?Q?4LswyGtxYRCTemjbPcqi7INxp6JlQAPIMAqlbtb0GqD9nQERcqs+o7ir3P/S?=
 =?us-ascii?Q?VPjuqjaiHIxbsszg8Om6yyx0dzEsy5JzQgXvx7j1Q64fhnqlNIzm5R/zg/SH?=
 =?us-ascii?Q?XGvmh5t7UAW1dlwPmM3yW70SbDWmefufEhzAzzWanoEsjlJPVwFANjL5YrmE?=
 =?us-ascii?Q?dawNObdWt3CdpL+xJ7j+aD+gPjHe3VrzRsGVE9m3FmjZm86N8GzMx2sUpgqt?=
 =?us-ascii?Q?owpkymarQ5vK7jCXjRI1bVU3bIe7L448qXqZQRFiTm7PM3G7g6ex37n+R0fo?=
 =?us-ascii?Q?BC36DIhFAN7e1kGBv6EgsAFemPqiOQUneeKVquMyBpREeBdamIjeNOEoE9Jc?=
 =?us-ascii?Q?4rW1kFNFlYb3DDxPCIooBMh/B0/6SmRjX2ENRFKZT+4x3AwLr+Luv9kABY8M?=
 =?us-ascii?Q?W4FNpn9gXrAdDVCInJ0B/PPNQ/64yE2xxnU7PmZhnYvDCDpN1JH6u/gz6/v5?=
 =?us-ascii?Q?VBnwATr11rCKGlp3j0suyArLAmHNEFcXD+5lv/NAYOaLAbl0P1PL9WAzW4/A?=
 =?us-ascii?Q?/curE69g1+movI6lqnWQ//x72DBn0RuuLeZTl/1ZnyIsTZQW2uaNTGNs5Qre?=
 =?us-ascii?Q?bVoYqF7ExSVV44qxqcvBiAv6BZk7IzNgQCHPXP9BKzZd2GFUKkT/4AKS1bdB?=
 =?us-ascii?Q?91Pbq9r8o3OdZFniJIhDHeYRb61rosC/hrzMqIMX7Il1hXw0brwHTG8OD0pD?=
 =?us-ascii?Q?dhJNujzAEf/W59SSwCeNtPOyiDqQfV3yNEUb3FmTEK7y3wmtiQWLA5jrZMgM?=
 =?us-ascii?Q?0A/66Ouggoovb5fOtTlsDd4NwvM0LcBRWEWncb/CfkPnXJrgsjglB5U+YZnF?=
 =?us-ascii?Q?79PBO0h6gBi+cSundHev3NpVbqSTCinNcfSb37V4dC4h64IrUooQxej3yshl?=
 =?us-ascii?Q?QBZZP9ronZgAApFtrAmK+1e4a3+6b06D9JYjXpkwRLfSur0gDz/BA/tOuFpR?=
 =?us-ascii?Q?x7lk6TBMhsppivQPnheHDdkQfGVwaK+JVvq1O3D/2Hm5Hvg28COizD7030rS?=
 =?us-ascii?Q?3y6FWkpB2CT7iermu1yd6Gv0kGKs0yttgozpbyqRVyFQVM5+kIkfU9IVeC03?=
 =?us-ascii?Q?UAJ3zbH9j8Q2e04TBD63XzQbQTo=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 14:32:42.9604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd608f1c-2789-4717-4861-08de58f9f00a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509F6.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB11465
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251929-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[nokia-bell-labs.com,reject];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C599A58C7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Detect spurious retransmission of a previously sent ACK carrying the
AccECN option after the second retransmission. Since this might be caused
by the middlebox dropping ACK with options it does not recognize, disable
the sending of the AccECN option in all subsequent ACKs. This patch
follows Section 3.2.3.2.2 of AccECN spec (RFC9768).

Also, a new AccECN option sending mode is added to tcp_ecn_option sysctl:
(TCP_ECN_OPTION_PERSIST), which ignores the AccECN fallback policy and
persistently sends AccECN option once it fits into TCP option space.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>

---
v5:
- Add empty line between variable declarations and code
---
 Documentation/networking/ip-sysctl.rst |  4 +++-
 include/linux/tcp.h                    |  3 ++-
 include/net/tcp_ecn.h                  |  2 ++
 net/ipv4/sysctl_net_ipv4.c             |  2 +-
 net/ipv4/tcp_input.c                   | 10 ++++++++++
 net/ipv4/tcp_output.c                  |  7 ++++++-
 6 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index bc9a01606daf..28c7e4f5ecf9 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -482,7 +482,9 @@ tcp_ecn_option - INTEGER
 	1 Send AccECN option sparingly according to the minimum option
 	  rules outlined in draft-ietf-tcpm-accurate-ecn.
 	2 Send AccECN option on every packet whenever it fits into TCP
-	  option space.
+	  option space except when AccECN fallback is triggered.
+	3 Send AccECN option on every packet whenever it fits into TCP
+	  option space even when AccECN fallback is triggered.
 	= ============================================================
 
 	Default: 2
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 683f38362977..32b031d09294 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -294,7 +294,8 @@ struct tcp_sock {
 	u8	nonagle     : 4,/* Disable Nagle algorithm?             */
 		rate_app_limited:1;  /* rate_{delivered,interval_us} limited? */
 	u8	received_ce_pending:4, /* Not yet transmit cnt of received_ce */
-		unused2:4;
+		accecn_opt_sent:1,/* Sent AccECN option in previous ACK */
+		unused2:3;
 	u8	accecn_minlen:2,/* Minimum length of AccECN option sent */
 		est_ecnfield:2,/* ECN field for AccECN delivered estimates */
 		accecn_opt_demand:2,/* Demand AccECN option for n next ACKs */
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index bf7d3f9f22c7..41b593ece1dd 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -29,6 +29,7 @@ enum tcp_accecn_option {
 	TCP_ACCECN_OPTION_DISABLED = 0,
 	TCP_ACCECN_OPTION_MINIMUM = 1,
 	TCP_ACCECN_OPTION_FULL = 2,
+	TCP_ACCECN_OPTION_PERSIST = 3,
 };
 
 /* Apply either ECT(0) or ECT(1) based on TCP_CONG_ECT_1_NEGOTIATION flag */
@@ -413,6 +414,7 @@ static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 	tp->received_ce_pending = 0;
 	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
 	__tcp_accecn_init_bytes_counters(tp->delivered_ecn_bytes);
+	tp->accecn_opt_sent = 0;
 	tp->accecn_minlen = 0;
 	tp->accecn_opt_demand = 0;
 	tp->est_ecnfield = 0;
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index a1a50a5c80dc..385b5b986d23 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -749,7 +749,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
+		.extra2		= SYSCTL_THREE,
 	},
 	{
 		.procname	= "tcp_ecn_option_beacon",
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 8b774019a3a6..472bd57913ae 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4863,6 +4863,8 @@ static void tcp_dsack_extend(struct sock *sk, u32 seq, u32 end_seq)
 
 static void tcp_rcv_spurious_retrans(struct sock *sk, const struct sk_buff *skb)
 {
+	struct tcp_sock *tp = tcp_sk(sk);
+
 	/* When the ACK path fails or drops most ACKs, the sender would
 	 * timeout and spuriously retransmit the same segment repeatedly.
 	 * If it seems our ACKs are not reaching the other side,
@@ -4882,6 +4884,14 @@ static void tcp_rcv_spurious_retrans(struct sock *sk, const struct sk_buff *skb)
 	/* Save last flowlabel after a spurious retrans. */
 	tcp_save_lrcv_flowlabel(sk, skb);
 #endif
+	/* Check DSACK info to detect that the previous ACK carrying the
+	 * AccECN option was lost after the second retransmision, and then
+	 * stop sending AccECN option in all subsequent ACKs.
+	 */
+	if (tcp_ecn_mode_accecn(tp) &&
+	    TCP_SKB_CB(skb)->seq == tp->duplicate_sack[0].start_seq &&
+	    tp->accecn_opt_sent)
+		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_OPT_FAIL_SEND);
 }
 
 static void tcp_send_dupack(struct sock *sk, const struct sk_buff *skb)
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 042e7e9b13cc..0cbba38ea87a 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -713,9 +713,12 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 		if (tp) {
 			tp->accecn_minlen = 0;
 			tp->accecn_opt_tstamp = tp->tcp_mstamp;
+			tp->accecn_opt_sent = 1;
 			if (tp->accecn_opt_demand)
 				tp->accecn_opt_demand--;
 		}
+	} else if (tp) {
+		tp->accecn_opt_sent = 0;
 	}
 
 	if (unlikely(OPTION_SACK_ADVERTISE & options)) {
@@ -1187,7 +1190,9 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	if (tcp_ecn_mode_accecn(tp)) {
 		int ecn_opt = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option);
 
-		if (ecn_opt && tp->saw_accecn_opt && !tcp_accecn_opt_fail_send(tp) &&
+		if (ecn_opt && tp->saw_accecn_opt &&
+		    (ecn_opt >= TCP_ACCECN_OPTION_PERSIST ||
+		     !tcp_accecn_opt_fail_send(tp)) &&
 		    (ecn_opt >= TCP_ACCECN_OPTION_FULL || tp->accecn_opt_demand ||
 		     tcp_accecn_option_beacon_check(sk))) {
 			opts->use_synack_ecn_bytes = 0;
-- 
2.34.1


