Return-Path: <netdev+bounces-252760-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OvPA5FIc2mHuQAAu9opvQ
	(envelope-from <netdev+bounces-252760-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:08:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3202D73F0C
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DCBED3009381
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A272936F42E;
	Fri, 23 Jan 2026 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="bcrEwkwu"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013025.outbound.protection.outlook.com [40.107.162.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DE1259C80;
	Fri, 23 Jan 2026 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162867; cv=fail; b=GmpI0Ua0TDdRGy7CfdjdOOhX8j3h3o383IFUTzjQhTLB4UmdA/HviIuOqeaEq24x7GTXHycbLeGvPIViFhcivWGfftrOViT5bNdLAgrs9djbB/+zh8Zl65DO5SK0qa3yz4Vw5g8XLhcCZAftiEnCf6sbW/dHCN3FS2qjaNjSHb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162867; c=relaxed/simple;
	bh=QnHh/fJ2T5iQaKg34Ot+lLxWo2DBXfgBeqqAD1tMjOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LKkJwXP6I2UiJAg6uHV63jykxVH7Lfcsqdi5b/St4+6LiOWl+vwyyacm2VY7BhxiXE4argMnFkUHIAZPxGF5EWsyg8tpPGiVmh846LMAE+1zOMqZkQcoPz6fX3wA/qw8nvjg2/VV8Sx1UwU4ZzjprAqjpZfMVoB9lyMZ9COoeao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=bcrEwkwu; arc=fail smtp.client-ip=40.107.162.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GseeKHQBmi+mpcyrE1PfWfthWy8QkM1+aDAILy8lofZg1yY8kDT2O0dqd6USxPoEPY+6Ld9Yo5vo7JcXK7WAIjJ3srV41HfUF0lW81UMsp7UsEHv5+JVkXhF+s2mew6JotXJPoaNB5074k0BTXp7SNgc/xAwKJG+ouJaxTpbne+OS6Tz+aqX12PxPFy2AgSv6UuEySKWCkiZmMAnuLpV3ehq6TA160VYiQskgl9F1nHrw3x/nAExi8pn/kwDTQBdDx9h2fPJSBG+UpzIrUlBLsIBdrn/XgKnvKJtXqqinUEVPl4MvUa8NYX5Y91YgxCxmRez/s1Iz844uRuiv0HkCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eltGCKg1pWq4cGc5yivHhhE58zndSpbeTPjlnTQwfVM=;
 b=BVIdPcBesP3y5o14iedcsYukMn43mW3l+m+pIyTZpvCotc6ofg2yILHVEcTLU6qrDowcVtb/PUB3cx6mYSBYqNsc+aiuv9ZGGAPblIKOBmoOH/bL8UKR8fR4If65om+0nO/PPx7iXz58ScU2CB2IXEBcdzCRQwfIb+8zYJ7BSbtE7VuOqIB6LwY6tHUT1RnQjWfpWoqfkdKa6uFVElHS4xkrzfJZTDSFuEdnPtNywfNXQGmO0ItW2C3x8bE186ifAsfPkwdLZ5H467FR02aK9xVGRnRzt91GQqefI9wIcf9GNWoYHfiTbTTqF4AqU1K8yyL0LfS2CNV6+y0tEHq4/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eltGCKg1pWq4cGc5yivHhhE58zndSpbeTPjlnTQwfVM=;
 b=bcrEwkwu0xrC5Lhocq5SV6XFLljgping+Bu8q82Pc05ntcgFAJQ7ubV6xaYHPU4BgW4Lt2ZFQ1Xpnmha70XeUFDyma/uHTSkKMOplVtBrTHGxkHXMTAMOrYWISxdgpkeQFYenVp+T6C4ZKgaUY2CWI6rci7KHD/C1tClozw9bLMkLj10yF1duRpO8brQ+B9raVvzkZrANdSo5tfw9+HWrxVDtyyNaiJrm3BzHR7aZn8e9NJpcfvKdWZiHp+LagpcfnEX1oTXIqKTNkGEwFLnd8WVa4R/GXx2Pnym4Jsb5bsDkURufRC/jLLNK9DS7H1ky37NEx3q0lXBuYuOMfKudg==
Received: from AM0P190CA0020.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::30)
 by DB9PR07MB10124.eurprd07.prod.outlook.com (2603:10a6:10:4cd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 10:07:34 +0000
Received: from AMS0EPF000001AA.eurprd05.prod.outlook.com
 (2603:10a6:208:190:cafe::b1) by AM0P190CA0020.outlook.office365.com
 (2603:10a6:208:190::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 10:07:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF000001AA.mail.protection.outlook.com (10.167.16.150) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Fri, 23 Jan 2026 10:07:34 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 338031C0030;
	Fri, 23 Jan 2026 12:07:33 +0200 (EET)
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
Subject: [PATCH v11 net-next 05/15] tcp: disable RFC3168 fallback identifier for CC modules
Date: Fri, 23 Jan 2026 11:07:11 +0100
Message-Id: <20260123100721.42451-6-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AA:EE_|DB9PR07MB10124:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ea405092-22cb-4c85-a4d9-08de5a673ad4
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?LWh+9Cpad6svmd7ayprf+J9o09sKpTfUe7qutyi5UnDhzWw7tXrYK7FmlIBN?=
 =?us-ascii?Q?KZoyZoX6fdz7dDfswsq3sqC5IQind6+ujB6kXmUF2aMSCJ4xqCg6kSeqau9v?=
 =?us-ascii?Q?nWXYibqRZU3zztTWENjmyFIvTLHxVjYm5OJgDvFq1T2upKKIfHIZRQyLQPPQ?=
 =?us-ascii?Q?QK2PsG0tmwfpYysyLNYd7Fi/yo3nvH0YPysuPDngj3E5DSOcmeKMfvW1wt2I?=
 =?us-ascii?Q?pHdcdy5vAWwSm2Yg9v+ZnLVJvh7tPU6ku0R24rgMYHjVpAcP0WbF/iQvNQrI?=
 =?us-ascii?Q?MJBekw/mv3KgSmWtsI+BJMNBDzMzXeWD6Nf91Ii0kIEkwdqNW91usGurZbUP?=
 =?us-ascii?Q?BXRgVYQoiZ9dewkOD3BXO73mUnlzIQ7urpkUaFuYHclhshhCzDYqccQeeWak?=
 =?us-ascii?Q?kl2ytW5oKgzz4VfhHozJpUEAk3qGllQLWMfHm5ne32AlaEZ4Xpqi8ZEx/fmX?=
 =?us-ascii?Q?SWzds3yi0GRMN0SVfoUNnqgj5E/UKCNZv7m4GapEGrNyRDuSKH2yH1AMOp+X?=
 =?us-ascii?Q?kVTGriH2lcRn1Xkm5zv7bh7HFxHctFKd19mne1qAdMVeqqwtV/seIN+WBou+?=
 =?us-ascii?Q?gzCWM7NGxukzLiNZ8a48KEHTosha4peJHC/0Qwl87hfCwnxPKEHzmcQDJzfQ?=
 =?us-ascii?Q?6jCp/jM873T+W3stq/exl2jo0sk1etD9P5Xc8Paw5t2wIK4969FLH/7QfLWB?=
 =?us-ascii?Q?cBLAgZdCSrs1v7LU8eyQSDZWCm+YP8dYJxYYXn53G1dL67i98+r0uz2GkCoe?=
 =?us-ascii?Q?5938qV1EZZGM0O1SoOIDhOm26qSESS/wdJUk5ZrsXMroUILzlMxLe3lD5koV?=
 =?us-ascii?Q?xDLSmlp/d69PEH/GDbkomyWV1hM+phhxrgQPGoDV22RtMh710fow4DnQwHh3?=
 =?us-ascii?Q?WJzCgkbaD5bJ2fJFfYmN21pSP5fpUD0GTwfQ3mkaPJUk3PDprxoXyOwCBPpq?=
 =?us-ascii?Q?92PR+22zbOJrxfmOEw8WgeyLJmEo4ggz8Au1savmN3XvmEJJAvwXypWj0rUU?=
 =?us-ascii?Q?OtD2PBlU5ezcyQD/cv/SnPww/PscekyyqOoeKFxnV+u4OHosePVqjnEG6G1j?=
 =?us-ascii?Q?DvSGqWSqWMPehbA2X2G0hsLeLDtdRb3FUTxSDrK+UYSvySD/KFoixdCqlbA+?=
 =?us-ascii?Q?9KSf0H0DKbaFinx0H1H2U3LUrreVuwBP27bjMPU+NTVpogpeGT1xcabEUKgv?=
 =?us-ascii?Q?ET+DUmbR5s0+rLmRvpDDvGNurKkzLAG7uw3kTpmkI2A5VHNzsjXK8kfU1trO?=
 =?us-ascii?Q?E0Xhe27n7GYkouLVOaUI1DxJYUmH0DS+NdxcPnhYmn0P8QoOqltTSR3i0z4p?=
 =?us-ascii?Q?+iZuPSxA1rXKcYT3QaJjDA7Nka8AtFooV9kuPrAa0KYA8m2Xrzq3PklgO6bo?=
 =?us-ascii?Q?y4+uqbXKaaVjmK3fb6lE5/dMTWcIkiMlk84jVcPRDhrKcDRgwLAu0CgHNsbN?=
 =?us-ascii?Q?wBdqhlAry/6gJ3XKu7FmYecDl7aG0G3swdRP0bqt6TN5KOcJMY2cU5figQVo?=
 =?us-ascii?Q?A5dkQcy0JJXGAuXkNnKB75kTuVhb4TLPTYtwVDox2puB4JJpt6awtgfVdBfw?=
 =?us-ascii?Q?YqwebEcqb313PelDMm/epda11fDbF3tCJEWRFcOWa37DSA5CzNCXlNy7QJ58?=
 =?us-ascii?Q?NvNKE2rctoVDJubB4jmg6I+hAO8h08mLWpfVaa2q2BAoyHuSifZ42Pbx16PN?=
 =?us-ascii?Q?Arb3HA=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:07:34.7645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea405092-22cb-4c85-a4d9-08de5a673ad4
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB10124
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
	TAGGED_FROM(0.00)[bounces-252760-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3202D73F0C
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

When AccECN is not successfully negociated for a TCP flow, it defaults
fallback to classic ECN (RFC3168). However, L4S service will fallback
to non-ECN.

This patch enables congestion control module to control whether it
should not fallback to classic ECN after unsuccessful AccECN negotiation.
A new CA module flag (TCP_CONG_NO_FALLBACK_RFC3168) identifies this
behavior expected by the CA.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v3:
- Add empty line between variable declarations and code.
---
 include/net/tcp.h        | 12 +++++++++++-
 include/net/tcp_ecn.h    | 11 ++++++++---
 net/ipv4/tcp_input.c     |  2 +-
 net/ipv4/tcp_minisocks.c |  7 ++++---
 4 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index ba347b87a63c..7965d4bfb4d7 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1208,8 +1208,11 @@ enum tcp_ca_ack_event_flags {
 #define TCP_CONG_NEEDS_ACCECN		BIT(2)
 /* Use ECT(1) instead of ECT(0) while the CA is uninitialized */
 #define TCP_CONG_ECT_1_NEGOTIATION	BIT(3)
+/* Cannot fallback to RFC3168 during AccECN negotiation */
+#define TCP_CONG_NO_FALLBACK_RFC3168	BIT(4)
 #define TCP_CONG_MASK  (TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN | \
-			TCP_CONG_NEEDS_ACCECN | TCP_CONG_ECT_1_NEGOTIATION)
+			TCP_CONG_NEEDS_ACCECN | TCP_CONG_ECT_1_NEGOTIATION | \
+			TCP_CONG_NO_FALLBACK_RFC3168)
 
 union tcp_cc_info;
 
@@ -1364,6 +1367,13 @@ static inline bool tcp_ca_ect_1_negotiation(const struct sock *sk)
 	return icsk->icsk_ca_ops->flags & TCP_CONG_ECT_1_NEGOTIATION;
 }
 
+static inline bool tcp_ca_no_fallback_rfc3168(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return icsk->icsk_ca_ops->flags & TCP_CONG_NO_FALLBACK_RFC3168;
+}
+
 static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index fdde1c342b35..2e1637edf1d3 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -507,7 +507,9 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 		 * | ECN    | AccECN | 0   0   1  | Classic ECN |
 		 * +========+========+============+=============+
 		 */
-		if (tcp_ecn_mode_pending(tp))
+		if (tcp_ca_no_fallback_rfc3168(sk))
+			tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
+		else if (tcp_ecn_mode_pending(tp))
 			/* Downgrade from AccECN, or requested initially */
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 		break;
@@ -531,9 +533,11 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 	}
 }
 
-static inline void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
+static inline void tcp_ecn_rcv_syn(struct sock *sk, const struct tcphdr *th,
 				   const struct sk_buff *skb)
 {
+	struct tcp_sock *tp = tcp_sk(sk);
+
 	if (tcp_ecn_mode_pending(tp)) {
 		if (!tcp_accecn_syn_requested(th)) {
 			/* Downgrade to classic ECN feedback */
@@ -545,7 +549,8 @@ static inline void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		}
 	}
-	if (tcp_ecn_mode_rfc3168(tp) && (!th->ece || !th->cwr))
+	if (tcp_ecn_mode_rfc3168(tp) &&
+	    (!th->ece || !th->cwr || tcp_ca_no_fallback_rfc3168(sk)))
 		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 }
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index cbc8e28fe492..aef6f2bbcd0c 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7015,7 +7015,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		tp->snd_wl1    = TCP_SKB_CB(skb)->seq;
 		tp->max_window = tp->snd_wnd;
 
-		tcp_ecn_rcv_syn(tp, th, skb);
+		tcp_ecn_rcv_syn(sk, th, skb);
 
 		tcp_mtup_init(sk);
 		tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index bd5462154f97..9776c921d1bb 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -485,9 +485,10 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters_payload(sk, skb);
 	} else {
-		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
-				     TCP_ECN_MODE_RFC3168 :
-				     TCP_ECN_DISABLED);
+		if (inet_rsk(req)->ecn_ok && !tcp_ca_no_fallback_rfc3168(sk))
+			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
+		else
+			tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 	}
 }
 
-- 
2.34.1


