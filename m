Return-Path: <netdev+bounces-251927-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JS1KWrwcGmLbAAAu9opvQ
	(envelope-from <netdev+bounces-251927-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:27:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49306592BB
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8319A7612F8
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A564A33E1;
	Wed, 21 Jan 2026 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="i4MlV30X"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010070.outbound.protection.outlook.com [52.101.84.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8349E43E480;
	Wed, 21 Jan 2026 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005970; cv=fail; b=dfiuknMCPMkYlDs9alMDDEODcq8y30Qfl01YpH6hB3rSThtaWHGcHRwZ+caF1cIZ4BE78qbi+5ejntBsB3mVeoTenHnV8SrF7vpWFDzD4xMABtyDq/GNKHt/L9LbfpxgH2PGv/wP3fRLNIWqp3gM5D2xNkjU0TVX+32tt1R0mQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005970; c=relaxed/simple;
	bh=bGrDa5EkVhUN+KgRlhyfCNJ/vfklSbtm7Gj3iIz80Yw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T6zQ8ni4BEZwvzfYcL8HmfNCHSKkBuVE4Mqqv4+3K4mZMbsFbK93Tbn0EYJ35qo0DQ9gOfOqHiNS9DMYN4obX98AmJmORDXpuQcXXz4ip0wiVO4/Y+COse5efwrtuCG/n/mEKWaz2/kMv+HVzLvmMN114i8H0nkEeXXY8dR2h7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=i4MlV30X; arc=fail smtp.client-ip=52.101.84.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4wuH5ydLsBH9ACVb8Y4LyXtyzwjRGErmynH3BpAO5Oy0v/sC8F9FuL1oj2LSd3nenKZb+V6HZi4mlW+qGMtjnq2Yzp2bkiumPfrtlKSfu+KxKcw9qSEW5eDsgouAxwTWEoUGct5qhA+AxAsKBVMOQsu4x/9WMCPY6mRFYLHdSbQ8Hetga9pVWwo+ugfiosk6NzJ067TEaADbEUme9CLnrbaRnAMRF631I2bfln6fW6/8eE10YVAPul8pymZRG9p74Nfm3rqH+UcjCg5K9tAkx3Sz/DAY8GYHljulop7IIytQzJGGmmEN4ZpLeFndoHnigNOTvRdUuPMvKpZFzRCxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pr5Wlj5y4UaCCLUMXC/uQIvk3dFXSguLdULxWSqrRwI=;
 b=dlnw4qBYl8BDCmaJ8HPy5M5vX+71OoZdTdQHm/b1EJndvuLDHwinZMoOJRRdHWXuR+F0LIG1/ry6coPimnn7OKx6ATWkQAbYMAYPgXn/VKX0GrJG7KANMY0Q16dP+6XL0IYSbp/s14CyRo2DhWn+PcVoU2knmlve6zE5J8+yySkAagni2JMUJNtG2xGc1JI6eTk5rjmxzYo606A9m10HFKBPQMDDmUaSY8AuEP/GtUxZm5cdtme1hBMqwV8OVvJxynhn21+6NrAv9NP39YTTW7Z849WdfP1YeIysfOmt7qAGfaYuScKrcV1m4BZPlngl4b8DAYMaEQzPcxOQTdIPUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pr5Wlj5y4UaCCLUMXC/uQIvk3dFXSguLdULxWSqrRwI=;
 b=i4MlV30XTkin2/Nu6Xz4FbplMrxqcOAtI4r1S2JkzsgvpBZHCIBzYYTgdescQUXrsiSrILO6GOBX644Bdtc8+K/qJ1x7/s15PIxVPmZ5lrc1QTGiBarpuUByI4PXdG4YIuhAtkwuIWcrLZBXHT//Re/qvIGoJqrYcQdvT5lwmDy2A41Hjd2rw4+Cdt6ThjRZIoV+BGZmSVYeWPD3n5xN3uiozIBDjncMvDmt+QwKIG+3kSEesS2LmhTjB6EOQ4cYTtiVGN5SnEdCjMVb2h7YSlSH0RgKmYKZpT7C5s+eYzR99YEALuv42SdrsCVBvxENsYKC2W9DZzLWW7ZMn/0Lhg==
Received: from AS4P195CA0013.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5e2::16)
 by PA1PR07MB10976.eurprd07.prod.outlook.com (2603:10a6:102:500::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 14:32:43 +0000
Received: from AM2PEPF0001C709.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e2:cafe::a4) by AS4P195CA0013.outlook.office365.com
 (2603:10a6:20b:5e2::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 14:32:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM2PEPF0001C709.mail.protection.outlook.com (10.167.16.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Wed, 21 Jan 2026 14:32:40 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 69D2820539;
	Wed, 21 Jan 2026 16:32:39 +0200 (EET)
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
Subject: [PATCH v10 net-next 11/15] tcp: accecn: fallback outgoing half link to non-AccECN
Date: Wed, 21 Jan 2026 15:32:11 +0100
Message-Id: <20260121143215.14717-12-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C709:EE_|PA1PR07MB10976:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 493e9686-e72a-4344-a723-08de58f9eedb
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?+K5KoZGKcu93AupvWVMsTqSELEUrpfH2HdJc2JUpgGrhLfh6nFHcBUsXvLqH?=
 =?us-ascii?Q?fxsb9T7BEpiF1nAdhtEjua9St9BJDFqsKoL8vUdshLdFBm1s6VG/gJBX4XpY?=
 =?us-ascii?Q?dkQjapbg5mma24BsUACDyE1ZKe76wUZs/k8yuURCGOpI0Gyd6aI9pSzMITyi?=
 =?us-ascii?Q?cPzOHKCyvdKDmLOu4VKQghKf64rjTxk4mTUabgHeQNQPFWBB1l3UtvlnfDfK?=
 =?us-ascii?Q?xmitWXcR13uUWu6DEeBUk5JbQJXcTLWeYrEeeSGCEespwV0L7WLur90YbITK?=
 =?us-ascii?Q?zrCY0rLuq635+a+ENghEqPfOvDYUjS89w4nLeLz9ay4jRjsPB66Kkyb5Pw8G?=
 =?us-ascii?Q?rEEAnjF70dAjkJIfo2pA2Wa8z1+9uI3ZACRNnlLQqp6pJDH3aFFQEni0EYsi?=
 =?us-ascii?Q?p+MrHVx7PXixzxmiRA7iRQfoOsOgdV56FQnXKOxz7CBrEAindfSwaOk70QOg?=
 =?us-ascii?Q?EEiRgllZJem1+4WxlNV5fDlUJgvPEMGMnfRSj6OjoOVgI0p3QHd7a2PdV0Tx?=
 =?us-ascii?Q?/HLspC72K0NqkDrusyiGTMDRBst63nofgn6ckZ1lYaBfo4Bsv4FUnxURY7Ff?=
 =?us-ascii?Q?oew4NGNySrd8xW66D1eBHhtxP9qGUrVjAfdniMze8/AsN9IuZ5pZYeMqwavn?=
 =?us-ascii?Q?M497tgOFdmpc+jmu8JWUbE3xAPPxKHvUydTfmX9kgkpHPzb6oe1cir8ZWhPh?=
 =?us-ascii?Q?bqWn+vVwAhc1tFkuOSRhV1loj0RQo2/AouJsZAx0r6SkDMQSJMTFE7/IGAJI?=
 =?us-ascii?Q?N91RX6Ek4MSN34LZJucdvPShyYWni02RcIh5h3aMic41uk0cGWaV13HUPfap?=
 =?us-ascii?Q?38HSyPH63Xs3REgVXo2huKL0fjesgbanKd4tzl3lQwW0tqoZbpoqLMCVByuO?=
 =?us-ascii?Q?IcnCQMowVUHdvq7IwxS36XXBuEGFrjc9eLfApGdSYGoKPS1EuCIQOSSOuYXs?=
 =?us-ascii?Q?sTVaZpNpFxAcbjSMtOx8KcA0xA2BxDII76lpdHrDieEOQyKAop+4aZkNRHOO?=
 =?us-ascii?Q?CTtGos48MG3wypRGkvCt0HrSN1G0q6ds9mknfPf6e3vOcuAKiXMPcsKYZ97e?=
 =?us-ascii?Q?fJ322Gvc79PdEvCoGQxnlUxfHztj5EeRwoweHKDvAbBgqjHF70K521yzdyQ7?=
 =?us-ascii?Q?b/bDSWgkhDHS6DOjl8qNtRIx28DMgH+1zjUAxLWbERZj0xG3YqbVjwKAn/XP?=
 =?us-ascii?Q?91IdbH2co2ott1RPsJOzEi1k7oclOlfXTXhxbTU56g8FwxYt4ZhBqq4EYvSW?=
 =?us-ascii?Q?Aq3cWpYZvqREUTjE+Zm4CIxW+It0W42++JKyZ6d0kZkVSPbym0dKFAu2l1vc?=
 =?us-ascii?Q?1NlSErWu2jtxooN6lcgv35l+xXw7cV4lIu8qPIITsgirzF5RWZZOua/cChZN?=
 =?us-ascii?Q?jOzhjFpJMu9mby22LLUVBGdvBNgxcXniEUr1GP4dQJc7zj8TVp4f1B3zdjCn?=
 =?us-ascii?Q?Hz6O8DS71JoFh05evwPNr5xL+EZoNRvL8i5EGDnFCEiHXBCkjFkpDL4QToO5?=
 =?us-ascii?Q?DhmJDOi+g3IMDVR2msIh2aw7mq6CcrzJ/U5aptBy7plYusM/hYwWLKyJGAWI?=
 =?us-ascii?Q?XbSl7p6VtpK/Bgqof7N7iBaOgX7sdWmqTPYIAL0K2B7W3PqcxLPJBWhiAJKI?=
 =?us-ascii?Q?MFsUTaZkqWWINdcKy9UxHLlYkJpjWfQusfjCgDVrpzuc2r6zi/bO3BGy5/Xz?=
 =?us-ascii?Q?Ar5AZT5SuSGsPeDu7wYbLIk3if4=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 14:32:40.9964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 493e9686-e72a-4344-a723-08de58f9eedb
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM2PEPF0001C709.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR07MB10976
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
	TAGGED_FROM(0.00)[bounces-251927-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[nokia-bell-labs.com,reject];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 49306592BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

According to Section 3.2.2.1 of AccECN spec (RFC9768), if the Server
is in AccECN mode and in SYN-RCVD state, and if it receives a value of
zero on a pure ACK with SYN=0 and no SACK blocks, for the rest of the
connection the Server MUST NOT set ECT on outgoing packets and MUST
NOT respond to AccECN feedback. Nonetheless, as a Data Receiver it
MUST NOT disable AccECN feedback.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>

---
v3:
- Remove unnecessary brackets.
---
 include/net/tcp_ecn.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index f5e1f6b1bec3..bf7d3f9f22c7 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -182,7 +182,9 @@ static inline void tcp_accecn_third_ack(struct sock *sk,
 	switch (ace) {
 	case 0x0:
 		/* Invalid value */
-		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV);
+		if (!TCP_SKB_CB(skb)->sacked)
+			tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV |
+						     TCP_ACCECN_OPT_FAIL_RECV);
 		break;
 	case 0x7:
 	case 0x5:
-- 
2.34.1


