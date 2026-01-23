Return-Path: <netdev+bounces-252771-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEuvF0lKc2mHuQAAu9opvQ
	(envelope-from <netdev+bounces-252771-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:15:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A75A7425D
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 454B431D1887
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C5F3815FC;
	Fri, 23 Jan 2026 10:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="uBQEL6Tu"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010002.outbound.protection.outlook.com [52.101.69.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5463D366543;
	Fri, 23 Jan 2026 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162888; cv=fail; b=fSwdamN5WM2PRYUH9qryxrHNXmC8Ok9VIHqe7257dJd7lovHd7cqyfwJ181H6bGycbvUn4B0Prc81WQf/ATB7jHVdsMTp5GpBBGYiIOp5KGwfY7mZN8XrTeL9TLAWyTqzeHNnHan8Ho5aTpchPgpuz6jJ7ltUjFbfO1PaQWxEXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162888; c=relaxed/simple;
	bh=Asg5rC23oYI8fZ0ID/U4gZIpjK8owfYhDbHAKkxZluQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R1OGbyjLYqlVlRxunCQmRUtNS/NqnZsRW+bzc0N0MIJ2HUhgWkNkTCD/P6a5SBljQkikkJg0WfOUoSyAMcNLmmPkP2gz97XNe0bQa/7X2m64HLpuZJcpUVOiOFcn+b76cSQjtILzdL73z7lDotyQU85tzhc90ZAvrWMinA2T4bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=uBQEL6Tu; arc=fail smtp.client-ip=52.101.69.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqS2E7wRNm+F7CRWYWL0OFU6AyxPp53K2CnN3Frv6V4g/H7mkHOOoKvsFUtPKuHL5MDRI1RRs48whIu8u59jMULO9C0kK02YdekvMuKL5kPCLIYb2rVv6El/hsVRQ6hhMl78HhzbXfaaLX3TwtVtNLa2qphzcautwycEUJR0JIjMpT4Y7RGPm7iKafZHeKqADGl6MOuhSBjiE7BCPk7LzoFMdVAhtLU9snojc/+CR3dbxlxQMjThSwiGdK7NIFSFUMW+cM835OHYljwM61BNywNDMY5ywFwXf/CN4QKYs8QFkynwC1Q1xw31QCr7GShuNNZiQ4X+ynnPpPw4NgixfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6lCAkct3PKp/w+UY5D1UKhnw+4sxvJgWtoSoiJmW94=;
 b=ruSATIn/aMcLrrSYMVAtw+g3stFStO/gvEdFRYezTjNtWyUTv8cQIQWFB0bsOKxdLJKXIpm1RRgmEhdv59NGXAIWnPyaciIfhe4Ds4M5BCijS+WVABHSNA03+aq+rQRCGz1QT0RYATBDNmsPGt1etNf/vHH/200ZAwEkuZxE8SbaebxyebL52T5fPJHoeo4JIO6qLcSR0Q0dZrSzhV1AER5XuGxWgv2VrlgdnR0I+zoftmanGeGDHGW/wIims3l6RBniYDbVp9bOVrvX2977cG61oZcAdlwko7B1ekTSGfcj9Z4coNdMiysMwt1/LlPtfygq4NXO65DCtko7RjzT/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6lCAkct3PKp/w+UY5D1UKhnw+4sxvJgWtoSoiJmW94=;
 b=uBQEL6TuGmKCg9LLSdhk/NMfiK+FuornZCmGgYKwtySxdmVfFcWETwcY7fvzha0drGE3JPzos5KOeiVda7laQ99p1is6IRpPwJN1+G30Pz7czinzARQh6DpSJGh1AFfaVP6f0uauA1+64/yUDd8WNd7AaY8hlxMtOoLXy0pJ3fcVKgG6hjNpKQ8JxO8+XVN1ARHbTEj0pqYatMzfvR601TXwirc3/+W41/irIwu5S+P08CSWK5ccWM/02ldRvoNu0V0ZmqPOJg98XkZTcuwRfSaSqhudzaksNj4vXIiVy6gK/8OFmT57Cx3Dad0rn+Q1yZiLUez2d5LDcbJvaTOawg==
Received: from AM0PR02CA0142.eurprd02.prod.outlook.com (2603:10a6:20b:28d::9)
 by DB9PR07MB9223.eurprd07.prod.outlook.com (2603:10a6:10:45b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 10:07:51 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:20b:28d:cafe::d4) by AM0PR02CA0142.outlook.office365.com
 (2603:10a6:20b:28d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 10:07:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Fri, 23 Jan 2026 10:07:50 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 32A5F1C0053;
	Fri, 23 Jan 2026 12:07:49 +0200 (EET)
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
Subject: [PATCH v11 net-next 14/15] tcp: accecn: enable AccECN
Date: Fri, 23 Jan 2026 11:07:20 +0100
Message-Id: <20260123100721.42451-15-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|DB9PR07MB9223:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3180ae25-6532-4ab4-6d57-08de5a67445c
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?KEEfHHCHBUuZ/ZBeKkYeXxoTgYn4CSPhM33GKBzjL88pKgPyg6AVunrVvcik?=
 =?us-ascii?Q?Xg9dm0YURUTa69p3mvWb7m9F5KnRHn1JTor6ZTsM4yDcpfg7R+6dvHIUkMTr?=
 =?us-ascii?Q?KXWQTJyXl/QXmTArTYmY75Fk6avuy2IS6k0Nuuhn612pVC0BfawPeQaI3JRJ?=
 =?us-ascii?Q?Hf0bbTROR2dQTCp3tPtUwxfS6g4AP6EryeCCCIWXK3Z+HjE7S6MqZVGGFbnn?=
 =?us-ascii?Q?0nni/01RSY/DiPoGbOKNf6x0eHemHfWFLeu26NJIAj4dH/rCg86V4gWtN8c+?=
 =?us-ascii?Q?pD9FClBm9uYBq58N5PkXejxiXG5UW5fXj04elPCyoRQTsx0bXYvEQiSTsd79?=
 =?us-ascii?Q?IeQn4SoxCk+Y0KC7K0FzTVf++u2koEXO/zslCsgtddi/ca0KvfZArbukecoC?=
 =?us-ascii?Q?DH54UBWGWh5Ki0uXjHN1fMZupCiYNgOJvfNhdm9vUWcliDMJ86arAXNBnqzT?=
 =?us-ascii?Q?hthPCOmeleZkV+t9SZcBKD7l7XnI7HVZAVHVfisIxMTc5cvl1893TIV2FAEn?=
 =?us-ascii?Q?aHd+5KpPOQhK97o4srtpuiTOHy2upyblIoMyGodEhr68dgIAICSBHOvfDk1f?=
 =?us-ascii?Q?zAhiHg3rkNN+TF+sAsDxNiTWBdBzwI8Y6LphxTisfwlU4Hgk6ivvAgeJvbOh?=
 =?us-ascii?Q?Y1YD0jvLikT4IOPk3Tl/mnzG7VCpIu7+ioEi/d8FHLsfuT999cEcR7jFZHEO?=
 =?us-ascii?Q?4Pykzg7YBr86/9OdhGjS10ggqwlD/v0FufHPrzPWNy7E5/tsQDm/kip4WJdm?=
 =?us-ascii?Q?rsaI3yEONFgw02WD4cnIANB6uNUKdN3oqBMDbkvr9+4C2SUDrxrG5syxmqFM?=
 =?us-ascii?Q?1Kghrs1fOYFVVRVhkoW5u0AV/fLli69LpvCsJwANw5X6CWKqAdGl7cOtOZTv?=
 =?us-ascii?Q?NSqYsKhzbczluX+xGiEArCRXzorQQI55SfPkAKdUfFeBA8VvcXJtSd8wlQAb?=
 =?us-ascii?Q?LYeSR1ICTjd6wtMt8wq0sG8oODFuEEF7Qc9L4t7OoL+Fx0x2OBg4pBQ2MRFP?=
 =?us-ascii?Q?h7SMtFgtWhAwp1Y835B6zaH1jf8y7ia35escAf/hm717LyM7oaRMOSVAMs2E?=
 =?us-ascii?Q?T/RKncyFpzK3pAcEqo9/KxKljY+Bq9WCP7y2CqvYIdgQrjSzPYJSwrOU+fih?=
 =?us-ascii?Q?q4AGGts163bHLIprAioksPwDViTpJf6d8Os+pNKokfYYxsoedOLWqy/3uqJB?=
 =?us-ascii?Q?BJ9Q/+FosJGYn7yktRxbF+X5xZRgBnSZzx7gkvfRORmqIDC4b1KfzZIqt+Gq?=
 =?us-ascii?Q?kFLGe93Ug3HekvzfdVjytHSZgN0OYvK/4KydyCJT6+bljcRVPDU4b2Olni1Q?=
 =?us-ascii?Q?T2KRRvqAil70AlmNJpVvVHcYME0tpsbVKEFX7bJ0959phFy8Qq5RoBLzcO1m?=
 =?us-ascii?Q?vO4XUtqwdWKHjlmEAFYqghkL+4bOvunhIuLiPwQxs/R3eN7DxgXZsj4L8DOz?=
 =?us-ascii?Q?gNtq0thQJiT+p0f91JV/4hurTHw6QIsNqO4jD6KRlAseUAXtmY08cnRuizGR?=
 =?us-ascii?Q?D5KFf1VV2EJyuUz9xSygv7n1kHOgoOGdnfwD0814WAN5cC24mh47lJREA76g?=
 =?us-ascii?Q?Jynd1CXfSznyZezRDlfsjTpxjSs4JKiD7b+IyxId3YDHpkGWvImzmUaNzh8i?=
 =?us-ascii?Q?dU97GPHoHuRlt+lDTkp+QZaeKwV1Cqqjx0q2qEgkPSwiYckA8PvbgB4dikEr?=
 =?us-ascii?Q?MiqrJL6ZnkVFocX8wAdW71918Zs=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:07:50.7487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3180ae25-6532-4ab4-6d57-08de5a67445c
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9223
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
	TAGGED_FROM(0.00)[bounces-252771-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0A75A7425D
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Enable Accurate ECN negotiation and request for incoming and
outgoing connection by setting sysctl_tcp_ecn:

+==============+===========================================+
|              |  Highest ECN variant (Accurate ECN, ECN,  |
|   tcp_ecn    |  or no ECN) to be negotiated & requested  |
|              +---------------------+---------------------+
|              | Incoming connection | Outgoing connection |
+==============+=====================+=====================+
|      0       |        No ECN       |        No ECN       |
|      1       |         ECN         |         ECN         |
|      2       |         ECN         |        No ECN       |
+--------------+---------------------+---------------------+
|      3       |     Accurate ECN    |     Accurate ECN    |
|      4       |     Accurate ECN    |         ECN         |
|      5       |     Accurate ECN    |        No ECN       |
+==============+=====================+=====================+

Refer Documentation/networking/ip-sysctl.rst for more details.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/sysctl_net_ipv4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 385b5b986d23..643763bc2142 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -47,7 +47,7 @@ static unsigned int udp_child_hash_entries_max = UDP_HTABLE_SIZE_MAX;
 static int tcp_plb_max_rounds = 31;
 static int tcp_plb_max_cong_thresh = 256;
 static unsigned int tcp_tw_reuse_delay_max = TCP_PAWS_MSL * MSEC_PER_SEC;
-static int tcp_ecn_mode_max = 2;
+static int tcp_ecn_mode_max = 5;
 static u32 icmp_errors_extension_mask_all =
 	GENMASK_U8(ICMP_ERR_EXT_COUNT - 1, 0);
 
-- 
2.34.1


