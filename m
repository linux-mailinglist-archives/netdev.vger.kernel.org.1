Return-Path: <netdev+bounces-252766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFqVDrdIc2mHuQAAu9opvQ
	(envelope-from <netdev+bounces-252766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:08:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F33573F4E
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CEDE8300EBED
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD6637D111;
	Fri, 23 Jan 2026 10:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="K/hXdUgm"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013046.outbound.protection.outlook.com [40.107.162.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929A3376497;
	Fri, 23 Jan 2026 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162880; cv=fail; b=Amj/jC4E8i5avWz5Dpfw8b9lUgGRc49lggkibaazjre2zZshOjwPHfeLbaTNjuqbd2XZJWiuDwqXHjGq54m9rrZxLwuG7tdNJ6qd0cyokqfzBagYLiWR/pQlc9psxY8ugQSRJqP0PwMmdQTo7C0nRu8J2Z0I8r0ZgxlbvFFNux8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162880; c=relaxed/simple;
	bh=lISi7AT9P0+MjuHe06m9kprjbGvZC2k4XO7oKJiOnpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QvZ64CI/RJ9zChB8nZIoMnPP/5tWTSDT+cc+g1eS+qV0ODvMUZvkgyYhv2xzVnHWelJ7LfxWy3SKcSJ9b0W9IOh+ffzFGAjCpBsMBBEuklWi+N4zYa/F7MvgGuBJTo2Znpvx9//tUdH2gSfdHFT6vrqncmX2ufYxFsIyGIOEVeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=K/hXdUgm; arc=fail smtp.client-ip=40.107.162.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LAcq+WJqTF4mVmXaVtCbIukbsN0TOxQb9eHMOxGBdlbEQukEsOd0ecSRjrJwd4pFFyKEqafYp+rjsQrR0zAP5LFByFA01VaI681XY9x7tjMFGKHUA8oZa/q+JsUvsyrFHbjKfnohH4hAKDMYkTsSDrH+GlyFuSyDCi3NlD9xEuoo93Dw1JbujZihvkqKxKD8RlrAHFzEva8E9z4CQGWDfl+5hMKasos1WVR3Ur0r6jEBHcw9BgIJdwsrB3d+zfC0qDTjEBpKZcYckQ7qRsK0ylWhxEXlM3DyV36IdnuuzvhcYvjOAwmJxgpD0KHfrNvhIuIOENFUXtG0ovJt6WcB+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DfcORmyTBE8rcwkEjhhJCGQVol7xT6Wh5l9CKSWn9Y=;
 b=D6nD5/DM7b5lMclfiB10Eer3L6eczgL01aLTsMCz27jhL9ShQgMDZQchp1Gubgkx3scPCGfRU8vpTG8pm9lkeJ3bBfX7D7A5OaXCOOuRTO2VYyN1iJDs3DFjjO4n3lNF/LAwpw773tVwJiQTcdXCuAr3GdpHraTrqMUa1Fx9+QFeu5KLTmwLrlHcA6CCA0nuynriRA7wZ4k5c2+luD4O+57ICNcZZZ9j0bp2ls/FyO2F37259XV9yob6VnFtu50bVrHGM6HRFR4yKequQdut0fDeE9mwG6nIq6aEnAhF/4Juz4hCEeBtWqjfnIYAh+DKV03N+MMl56u40Eci81ykHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DfcORmyTBE8rcwkEjhhJCGQVol7xT6Wh5l9CKSWn9Y=;
 b=K/hXdUgmpAP4fDfieqraM56zddRBCYgjBoLORpkY4GfPK3XTLs0HfQYJFmS8UXasHy2dyiIDgPAzgoz6VhFuGYNE7agU+J0TN9cS0TvyW0K9a6um0Yd5qf214qQGjAAG4+p3djbHtgnkV3AmzIFH8Q9hl4G7QOKD6EERnDDJr9LyTpwP1SRaNkXTp0HbPcEtHn+djBUYmb3IybtMf5GHXfo7OxUxitN93W4V4R7a46rLX7w5Yp0ThEjh2E3JAY9efQJQt5+rnB3nJi1gstxixTWajP1Apc4+/Pu9vZx+ylXgN4MorMhjto2Fo4X5zjuAkcwn5lDKubtQJXODW8UiUw==
Received: from DU6P191CA0051.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::7) by
 PAWPR07MB9227.eurprd07.prod.outlook.com (2603:10a6:102:2e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Fri, 23 Jan
 2026 10:07:42 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:53e:cafe::2e) by DU6P191CA0051.outlook.office365.com
 (2603:10a6:10:53e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 10:07:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Fri, 23 Jan 2026 10:07:41 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 3EA031C0031;
	Fri, 23 Jan 2026 12:07:40 +0200 (EET)
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
Subject: [PATCH v11 net-next 09/15] tcp: accecn: retransmit SYN/ACK without AccECN option or non-AccECN SYN/ACK
Date: Fri, 23 Jan 2026 11:07:15 +0100
Message-Id: <20260123100721.42451-10-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A00:EE_|PAWPR07MB9227:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: df9347e6-8cb9-47ed-c02a-08de5a673f0f
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?u84vLGxEQYrhWU0mqRT8g3HU0yxIxQcN/J/X+FSpvCmVbSa43l3/RedGHPno?=
 =?us-ascii?Q?4ZWX2VB1ThY4GGsm06HHd9XyXWzjMMF0ksMElfWc4c4Ml0bINtqQsgzNENLz?=
 =?us-ascii?Q?W3HEbyJhqWw+xv90jps8qX68Hq0XAWnBwMJ76mS+R0ohGARm0lKGdXbalH3A?=
 =?us-ascii?Q?Yf/bd3LItC3C/j8eNde3sduNex0o2hPOwoVrq3G79gWmQhII+8tG76dVy4QU?=
 =?us-ascii?Q?mjAQhmIzc2BRd92bvuAqfjr4nV1JxBJDT5EuJXgJXS40OlhRojRsteUS9pmf?=
 =?us-ascii?Q?YSNtXo7ac1UPQkKSq23nIvHdwwY+Z43z/0PVftc+NsDgNnn2xMxUV3RSnAHW?=
 =?us-ascii?Q?jYgIYQ/kHl3FgmaRqOUixjMo/7edZFsuMxs9Umk4qZBSQ4/jtK0JDBgJhFI3?=
 =?us-ascii?Q?JMHhbqpW5Tr84KU6FY+uiJ0XG2/pyBAPPQOaXxooZzrURdpkoPxRn4LsJzne?=
 =?us-ascii?Q?kyU3UtReEzn44eO0sGo0OziVP8eUQoRbmx/upFILn3E8ApaQqSzQ5vf8+FIF?=
 =?us-ascii?Q?RrsH3yz+rVwHLLoajk/++1zWwocc58ZianLDxAcLI1LH4LG2AfnY9HoNrPJT?=
 =?us-ascii?Q?7LK4uXDIk1r4yiugRyvKJ5fwBpQuyjTMeBIf8q8C6J7G3Fe7gNbKAX7Ezozz?=
 =?us-ascii?Q?hNgXo0ojeq+jruuUiUqEjF1FaFsUngLFF4A0OKPipk6B1TT1O6WWknYY6DUq?=
 =?us-ascii?Q?+0DupDZlB/XduI54KH/A4IRdhBzMS94X5/FzhWaHH+47TZ42OdI7vYGPQphP?=
 =?us-ascii?Q?NR4TVhUq2fYTIRWgom03+7ZZpEjIfML3DXaSuPnOShgPoTRoh44eSz+BMGbO?=
 =?us-ascii?Q?ZPazxXJ15TNk087tvOYswGUKPWEaDUHIgR9M7nAIwn+tm8nfJxqBsxPWSjA1?=
 =?us-ascii?Q?Qf+C06Yihz1qh5lqHyeLZSF2n1Taxss955bqLTYhVdpijVHYs5IfFnBwPenU?=
 =?us-ascii?Q?duRG3+fWtW0WExv5pI0OhrKWOaNt5t4IuFyE2NkW/rJTFk6pIk5QxWJNyPFt?=
 =?us-ascii?Q?q+VyDcvO4b9Qqrs0+/DtNhacN5Vh11BnTFAi28Q552iSCgrbppQNM5rFVX9y?=
 =?us-ascii?Q?eTTBBYm2lGd1gPHPp8bOrL5tyhVUdHxyERlH+B34kjoFwdidrfwYyA+l/Bkc?=
 =?us-ascii?Q?YYvxUircapItsNLHjZBsqpQZs94SjDH0uFkdxu2aOSaeQBqrHEu8prpyYEhG?=
 =?us-ascii?Q?09BABXm7YjDNmdUcyjZ5GZO+jTp5IouYuX4P2G295/5go8aQGTtkPZwpXG+V?=
 =?us-ascii?Q?d9yQPrfZM5v6gg8Yrbn8i9evtEEo7FijDycJOgU9865spKppFIuShuikZ3v/?=
 =?us-ascii?Q?YnSnU9r2E+5W7ggCwwrIOpU49dyBJeB+rrxsqnIWPUaECjRVplj7+VAlKoRv?=
 =?us-ascii?Q?zSMQG9wmUXOL0HC3IT6D8i3T4ZjvW+1tIs/HmMNc2nDBms2Hn7LaS9hLSFTf?=
 =?us-ascii?Q?01qll/f0sJvoJr9C1q8D0hxa2A6FB3W/xkTuwR4d8KJXEJ1cptLxI0AvRjAS?=
 =?us-ascii?Q?xzPGv60yi2dL9LUuWRW2Nj8Zfq2wRPf8AN7SDaQcBFgp4Bl/4cqbJrURv3yI?=
 =?us-ascii?Q?++itzi30cs3UkzqtVGFfUDYwcrNysrYUG4ObZdAvKj+QfKCvdIRfydmfTzrj?=
 =?us-ascii?Q?acTrSUBBqFyuKgJgTo+sL7HsZRedUmBixZCe1SOy78RHwHWWwccqVrJ6BzDw?=
 =?us-ascii?Q?/COlfOtd6bjN6nmgH9XSJRlVThw=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:07:41.8534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df9347e6-8cb9-47ed-c02a-08de5a673f0f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9227
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252766-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8F33573F4E
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

For Accurate ECN, the first SYN/ACK sent by the TCP server shall set
the ACE flag (Table 1 of RFC9768) and the AccECN option to complete the
capability negotiation. However, if the TCP server needs to retransmit
such a SYN/ACK (for example, because it did not receive an ACK
acknowledging its SYN/ACK, or received a second SYN requesting AccECN
support), the TCP server retransmits the SYN/ACK without the AccECN
option. This is because the SYN/ACK may be lost due to congestion, or a
middlebox may block the AccECN option. Furthermore, if this retransmission
also times out, to expedite connection establishment, the TCP server
should retransmit the SYN/ACK with (AE,CWR,ECE) = (0,0,0) and without the
AccECN option, while maintaining AccECN feedback mode.

This complies with Section 3.2.3.2.2 of the AccECN spec RFC9768.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v7:
- Update comments and use synack_type TCP_SYNACK_RETRANS and num_timeout.

v6:
- Use new synack_type TCP_SYNACK_RETRANS and num_retrans.
---
 include/net/tcp_ecn.h | 20 +++++++++++++++-----
 net/ipv4/tcp_output.c |  4 ++--
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index a709fb1756eb..796c613b5ef3 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -649,12 +649,22 @@ static inline void tcp_ecn_clear_syn(struct sock *sk, struct sk_buff *skb)
 }
 
 static inline void
-tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
+tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th,
+		    enum tcp_synack_type synack_type)
 {
-	if (tcp_rsk(req)->accecn_ok)
-		tcp_accecn_echo_syn_ect(th, tcp_rsk(req)->syn_ect_rcv);
-	else if (inet_rsk(req)->ecn_ok)
-		th->ece = 1;
+	/* Accurate ECN shall retransmit SYN/ACK with ACE=0 if the
+	 * previously retransmitted SYN/ACK also times out.
+	 */
+	if (!req->num_timeout || synack_type != TCP_SYNACK_RETRANS) {
+		if (tcp_rsk(req)->accecn_ok)
+			tcp_accecn_echo_syn_ect(th, tcp_rsk(req)->syn_ect_rcv);
+		else if (inet_rsk(req)->ecn_ok)
+			th->ece = 1;
+	} else if (tcp_rsk(req)->accecn_ok) {
+		th->ae  = 0;
+		th->cwr = 0;
+		th->ece = 0;
+	}
 }
 
 static inline bool tcp_accecn_option_beacon_check(const struct sock *sk)
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 329e7e461c52..8536ad08a668 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1106,7 +1106,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 
 	if (treq->accecn_ok &&
 	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) &&
-	    req->num_timeout < 1 && remaining >= TCPOLEN_ACCECN_BASE) {
+	    synack_type != TCP_SYNACK_RETRANS && remaining >= TCPOLEN_ACCECN_BASE) {
 		opts->use_synack_ecn_bytes = 1;
 		remaining -= tcp_options_fit_accecn(opts, 0, remaining);
 	}
@@ -4039,7 +4039,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	memset(th, 0, sizeof(struct tcphdr));
 	th->syn = 1;
 	th->ack = 1;
-	tcp_ecn_make_synack(req, th);
+	tcp_ecn_make_synack(req, th, synack_type);
 	th->source = htons(ireq->ir_num);
 	th->dest = ireq->ir_rmt_port;
 	skb->mark = ireq->ir_mark;
-- 
2.34.1


