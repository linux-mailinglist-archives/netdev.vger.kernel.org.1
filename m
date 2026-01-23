Return-Path: <netdev+bounces-252762-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PwDEZxJc2mHuQAAu9opvQ
	(envelope-from <netdev+bounces-252762-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:12:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBA8740DE
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FEC130AEF1D
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B28378D66;
	Fri, 23 Jan 2026 10:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="YWK5XN5j"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010064.outbound.protection.outlook.com [52.101.84.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F3F343D8A;
	Fri, 23 Jan 2026 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162874; cv=fail; b=JGYRTDiMw3vkoHgxjgQlz5DEFFfk+ix73HVgour6U4jlU5igyG90b4yAgdhW9VQ49rRQ3iipqlyvM2tQ2sJWIxm3T7Y4I0ypQQhNDwUq/GvZ4XHcuMleU7a7yBmN2QEEG/EI37iYTnRhgs44q+6sLOiXualtY8FO+bYAgdPQGoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162874; c=relaxed/simple;
	bh=+auiPovcMDl4S5mwHcVKCJFJy7tYD8JG2gFJo/6wsQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i2JeGWHRyXwxMY76hqEGh89tmMkDbZ5etFeGgvnK9TSYG6QPHdk9Sh/Fxku4oT1oT4I/mF48ydBNX5LcAeKoiOc0xy/paxwcXjX/bOc75iIBb1URnsNxukVVvsdsjpiBhl2OXzVoKH53mr0+IMyWDZbylP31Nl9nxhD4CvnVv1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=YWK5XN5j; arc=fail smtp.client-ip=52.101.84.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNShfnQ4wGLbeWSeGU8hNDkB68x23waY1diaKFm+qTVRrAXmIdGR8GN/c4VwcohtVkNwb9YUZ8LIko+tlMNDhtTcv8VBr6AvX2DdG/SQXOnODmCdKI43fQBfbP3NZM5h3R+F/48MgcWNtlzfNODId8WlbGNTXVRbG9lQypbyKMRMC3YtbQuBszo78VI0Ev1P4gFaKODxVTgcDWZpZpGpCnWfrQ/y8Sr37TwSjQLcqgUG9J91tN2gnwMqCzVtYxBVjX49jMxaM18QTt1yj1M0M5NY1dlF3/0H9Y7fTuMwAlN9igNM9s7JtRi0i27LvzBpJsmkASNvC/qOTjIFOmjL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1VlfliBpC4goVo6bP5WxhRaldxfKZE1wbrH2C2bv+w=;
 b=tr+10N5gllctEXEZIRS5SzZBBaR6GVhMkiBTi7CIVXyrFcskhJ4iwPa6Cp5hRCwJb2vRAWrvl6mywcb4kWRo2qnWJak3Sj4OaFtnNK82myIvkxxz8ABY5+e+b3zbwJMVg74eMX0EtH9PYbUFxJClPb/CH230T7rqJpnW9rcN4JpxYIQHlbv8Bf77B9Yb6t3PQce3UUnmtTRQs+kLdsqv4JH1pxmm6VwYqkhONAnHomDgykm1qUnl/pZkKOCjjPF45evfZv7tRj89iStmi53/FQIjjbL0xHegEty+lmN8dFYsb2FdmmE8QEsD2KmqzYdMEFkiHxLCv6BPghFmTHjbcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1VlfliBpC4goVo6bP5WxhRaldxfKZE1wbrH2C2bv+w=;
 b=YWK5XN5jQgvGfgDGngT4te+Tu5kCr5Z7OkH52AOTiEpvSvpFS3N1EjNpguT7db2J2guqojrSCUQVMei8dRMn+garZSoC+0IZHy+g5y5twTls2RsQSyeXJCuYoPXxkIhMbO1E9RUNWMZ5W/TApy7bNrWn5NYUxGBdIots9bnvZ9DNJ9AShvruRgdrKH36WA8A5v2Gt+uIqgqmKBgGKwFVRyXZzJSfawF9R/GkT43nvXJKUIphYRqFIpHcQOto7nAqSa64t2WCDNpaXDzbbYjjs36GqhR04mJrwcrsMcWhTWhu7eptfn/SMp2AQtZZNSkCbiLTeO4wtWR0R23KVGfJ5A==
Received: from AS4P192CA0001.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::15)
 by VI1PR0701MB6847.eurprd07.prod.outlook.com (2603:10a6:800:190::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 10:07:38 +0000
Received: from AMS0EPF000001A8.eurprd05.prod.outlook.com
 (2603:10a6:20b:5da:cafe::29) by AS4P192CA0001.outlook.office365.com
 (2603:10a6:20b:5da::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.12 via Frontend Transport; Fri,
 23 Jan 2026 10:07:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF000001A8.mail.protection.outlook.com (10.167.16.148) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Fri, 23 Jan 2026 10:07:38 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id D245C1C0030;
	Fri, 23 Jan 2026 12:07:36 +0200 (EET)
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
Subject: [PATCH v11 net-next 07/15] tcp: accecn: retransmit downgraded SYN in AccECN negotiation
Date: Fri, 23 Jan 2026 11:07:13 +0100
Message-Id: <20260123100721.42451-8-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123100721.42451-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260123100721.42451-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A8:EE_|VI1PR0701MB6847:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4b314580-6054-45f5-b9fa-08de5a673d04
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?v50FyA1XZ8T9M6Y8Lon48q90LxI98x7HCG6N1oiP8BMgLt4mP5RWM2obI/v0?=
 =?us-ascii?Q?OPYZ9G6Yf1rTZlt4C8s4tt2XaZNoj5H1yAiDh9oI5ekafWQPJBGknsMSIM4h?=
 =?us-ascii?Q?jdcdq+zQG9nv1TMZBUR+aoAQdYwFHuWqopeb6ZuCtFKsyzyNQHvxfSKEZ+rj?=
 =?us-ascii?Q?rHMYjD60JfyrLAAddVl1O36DficHG2EgoI6/4fnrAimWYAZAY5NrbAAMBcec?=
 =?us-ascii?Q?lCgMzwmUs1JwaBv7uBZQcQjYpwf4wXwJ3dqliVDURcxIA02UbF/jIIezE0C2?=
 =?us-ascii?Q?Xm5Ym7OZRciKYwJzP8wLF7OAFIqq+An+fjMqzfVKxWSO1E576Wzp5YWFua+Q?=
 =?us-ascii?Q?UWbQMqNiGLV71Cxa1kG8U8w+jPBE8znZ4Ibb2Bkq2XQzpBsLOBE+RQGih0LM?=
 =?us-ascii?Q?a3m5B5bliiCHDTPRVvDtMHszcxkiFuKNEvhDwMdLDeBuo+aoMruvJ8mEqleJ?=
 =?us-ascii?Q?/8gvqe3AOrvud2YhKLwN1pDnsB9K2/ke2e43YNMyqQtt4GwtKcnCKmRjCRJo?=
 =?us-ascii?Q?FEJl+eZscn6aJE/5EMTa9kDclU4ey09R4YAYW/Dqif2/yqAXvhhNDAxT9h8F?=
 =?us-ascii?Q?egqKYD4Gzfs3j0dKIxzjdIPTWiopC7AE2HSFaYYX2kyya+OFyMrCN4dmEW8j?=
 =?us-ascii?Q?IzqI5aSq3vF85T5KGuFIFfVy4eqxabrMYr+sSvKUeHdPX/o4MnMlg1XtCU5L?=
 =?us-ascii?Q?1PpxZOwP9ajsr2cHwTz5c4hRKXzZibU96H3HeKg8OFC5aX0PizosbaQw0rLp?=
 =?us-ascii?Q?YP8tjTHdLjlRSoDJgT7AwxYf5c8jcrocKay8cUtQSl8cEsAoZyzkZmEbCOg1?=
 =?us-ascii?Q?pHQOfJejAXzQ7EIn8xgP4Lgkh/VNi8QM6844Rp4Qa2X8RSmuUWlbOU5HkDDM?=
 =?us-ascii?Q?h+fljRMrtkXvd8VyClgQNyPf/eb9c4q3dq1OTdxbt6FdMpCSDywK6mJs2QvV?=
 =?us-ascii?Q?T0Hj9U9n5xlrsliMrMVSb1ojgAMD9ly7ozXNdlp1kGFCryRaLS8kFJeQcG6h?=
 =?us-ascii?Q?IH2JL+w4KUFUFWhylE44KP8twCtrkllLxJ/4jsO/FSU7Y13FspRYQI1FkGmA?=
 =?us-ascii?Q?YuqcyKMP3KopizIZv8safWcOH4BupRmZIiEB12dJKL6duDnRR8CRKjKxbaPw?=
 =?us-ascii?Q?xXfO69Z3wx79p0QPL5F0ltk/NrtFIxt17swey+sy7nMIye6VMfqPZgqaiEhg?=
 =?us-ascii?Q?okslI2Txjloe2mwjig9eJQNnALTIU+4gPAzz+Ak6nRXD0P0qCKxq9WiYlm/N?=
 =?us-ascii?Q?NFRjtme+FsTB71/HgvBktcL1363e7xv6V+IizNsZuMh4aLS48lt0WESB6lp6?=
 =?us-ascii?Q?MJ6iqzT4JG8XTIgDR0ep6QTgJYYMfOU5PklX8VaanGTaasDaArLryVNVXEhb?=
 =?us-ascii?Q?7ApHEE6em0bTxnuAY0sxMoRjogUOQczn8OHppJPKvXfLGpA1s6W4mKzkjwYb?=
 =?us-ascii?Q?yKNvAUBbUYeck5b/HW/wO8CwCqKUOTE9kOYIwuqEaOiE0IP+kUvhCZeXxtZj?=
 =?us-ascii?Q?7uFA7T5GuDwwNaFOTuTrKoKm8zfALTq2m8Kg33lCwbVDuZOVoaWQnCDi9zQn?=
 =?us-ascii?Q?mtQ/5qHuHLN5zUlG25zyYP+Vm6tAKLpRtLhGbN6Sx2bmiHFzF2wXS3k1kN0C?=
 =?us-ascii?Q?DhCeBy8NcNLTrJupr/O2b1uS5a1gDBzMUwGnUv72cLjT0YxrR+xTs4Yy6Hkp?=
 =?us-ascii?Q?tplZ5JSDTHah4R49VTyPqqXNluY=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:07:38.4337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b314580-6054-45f5-b9fa-08de5a673d04
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF000001A8.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6847
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252762-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8EBA8740DE
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
index 256b669e8d3b..d5d695a501f8 100644
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


