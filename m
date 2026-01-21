Return-Path: <netdev+bounces-251920-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4H1ZKs7ycGk+awAAu9opvQ
	(envelope-from <netdev+bounces-251920-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:37:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE85594F9
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C1103701025
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD454963D1;
	Wed, 21 Jan 2026 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Q8LMDqoL"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013021.outbound.protection.outlook.com [40.107.159.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084134963DA;
	Wed, 21 Jan 2026 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005957; cv=fail; b=VNltl68aHEugz3ctZOjf1cUjWJw/U7go1Na3yQZ7DJ9+87LagAvSAPHY1dKTP3EndskRyp04CePIQan2xDJ+EJwPwEVL15pDlEFY54Hxmk07RDzxPGHcmtm9zjOSs+InYiMR8Qgycwk4ji08Ey+uoX5OXBpnt5+vwIS5LrL0Ke8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005957; c=relaxed/simple;
	bh=VVLqiI/LZgIJdx4AUX8TxVmVzhREw4VM1NGofOfPN5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GElYklju+6XYkgse2FynNO3tyWPXu5fjJ4DArPcZ6iSHCaWyaHM71s8RPNlDoUY4korGxkS78fuuLKJqphJutfStW/wYeZQHJbWyMnhst544TSZz0gzfB9iyY/OxP+1qURwWOsGlvjph7TamDbdlSESuXB4q3jyAbJNtFWVaOP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Q8LMDqoL; arc=fail smtp.client-ip=40.107.159.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekvEn3sxa55q5Hsyy2xd+SgZ+GbE8bXQJuIwr56pQ+32wIhsGTvgzsKgh3Sy70WxXFPyVCuyp/ylmw03oPv8UlD1YM9+/iIQ3xGl3HqBEu8p5n6/Yyk/LpPOBC2wicXRUOw7cH3Jtrqc0IKHwz/EO3cN+bwJJ4IBrrDODpDvOvMnSvQEfbWuCrAuqkaLnvcloop/y8Pl21mkSdm75hNodtqbex0NUBnNOXf64gG6xXdDP/6Ctae3M44aCLURXhqPQffysaXLFUwVfOCwfrvXo4a2dgTC/4m8yoIjFGtpxVVtcKHDf9f7meTHHukytmW+QahEo/fc+e6hhDAKrtnDjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byxPH48lnObGm/JMWDGq3lAzRM+CA1uaP/FYqDKC/z8=;
 b=VGKnzHn5YdfN7QjHWEv8b1RA16+bfG6HlhD2VVsHeWx0NtYqmc7GvRCkRRYSJQDRfMBfn+B0UHZBwA07TFGk2QrmYSEOblYkVAGaTeqt2kBq6ol+I2mMniKBEr8KuyzrAzuB/xkKDOY/vQLy5WE+tADS/TGUE5gR3u77tZk0oyPe4itmip7mJwIuG0PiHApsGzL3JXm4x0spkDLI92hLcWb9G+zG8xkuo3XxksPfeoA6dwt7zzNnUTOWRiZsV9HtHpChrHKGPcwCawa4GY7x+1RVUOTfg2ZZMWIiPMWxqYWygLqi2Tb5cXWGYxiGv2+b+gMVBKsdpwxgCng5g5ZkOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byxPH48lnObGm/JMWDGq3lAzRM+CA1uaP/FYqDKC/z8=;
 b=Q8LMDqoLhkygzhs1O/LTnZ8Zbg+isrfi5K4F9lwAe7HE3iLTcPM4I951qteWDoZGgbQbyxuobMbNYHP6aFhgXN+ku/I9IfKxZ0whGE3HIluBp54oL/XabG30/hP8eSSER7U0VhPQNdFp/SaruZ/pSM7B4sZ/u1Ip6rl8opRYvegQiFjaPJ4nSDgKsAi6ePcTt8X9JjdQWJXPMxICBwUuMclNtGelDzQLaeFU5k9ROyWfiKegwiWH34WV54aG3XZnKZQPHBqj81z8CfQJlBYi6SKnzf262N/GqssMMj531d7kaV9v1dtS5nKdJ4JBi4AesPYFKGwznf1RHJ2jKZYh8Q==
Received: from DU7P191CA0013.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::17)
 by AM7PR07MB6881.eurprd07.prod.outlook.com (2603:10a6:20b:1ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 14:32:29 +0000
Received: from DU6PEPF0000B621.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::b9) by DU7P191CA0013.outlook.office365.com
 (2603:10a6:10:54e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 14:32:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DU6PEPF0000B621.mail.protection.outlook.com (10.167.8.138) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Wed, 21 Jan 2026 14:32:29 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 431FE200E4;
	Wed, 21 Jan 2026 16:32:28 +0200 (EET)
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
Subject: [PATCH v10 net-next 05/15] tcp: disable RFC3168 fallback identifier for CC modules
Date: Wed, 21 Jan 2026 15:32:05 +0100
Message-Id: <20260121143215.14717-6-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B621:EE_|AM7PR07MB6881:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cf526b52-4b67-49ba-51f2-08de58f9e82d
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?teXbIGpNbJmA5JM2eHvxB1gyLSaYXZbNPwqvIuXVEU2ak1lc3jQIbv+Ooj6T?=
 =?us-ascii?Q?pZtLtcVMbDn3G4UpkBQely/su5Kuh0UgTBV/PRz3g8Pg8KZA+VsR+oCrXRAd?=
 =?us-ascii?Q?x0OUM/D/WWKxxX8PqJnXUe2VcnGulpCZUzt6WuoUiju5idV38zKGLHFf6Qe+?=
 =?us-ascii?Q?ytPfYTknjikCrM1JT/2NkFgzUYFrxmT0Y9jp9oBn35Sau98xCAh7NEh+y+Q1?=
 =?us-ascii?Q?uWHYmyFE3t0UpY0qtbi9VaSsnD1Z7km45ID82yZuoPHuhbTIEiyFju76Ob4U?=
 =?us-ascii?Q?l36xObCXpbAbH0zvpGUBO0VwJHLTCTqa18i8UAb1g+5vCE0th7k5DMxnCwau?=
 =?us-ascii?Q?YOIcnAmGdTTRGWYpUoClN5s9f75p2RSBzLqnvLIpjbGp/ouX88BRGmZraLHy?=
 =?us-ascii?Q?pYXxZS9FyvqXz1FvBlgcRU20gZUpVgJhXrChqHm+97f1PVfgHSzgiBPQAmHJ?=
 =?us-ascii?Q?kQ6GDbeV62flnJgiRCDG1VN9p77bPm/1/0R3aQNVPKdQ+UeyN0+p27mtXtZE?=
 =?us-ascii?Q?GXD3Q4ikGrtx7cIRd8G8Mi2fiCGtMIKC9Xg2M1BxYXbdsDe9iM2VR4h62Lsb?=
 =?us-ascii?Q?8JbaFwgmu8ynk65lYzu0HPYXiUh72xjrPGXZ/3OFV0pv/Mm8ndfD5ijZ67dS?=
 =?us-ascii?Q?8U07TnUA9Eqen1CvoE/R0jos69t836+GvOQSglzQJobFEMykwkcXvzdvlVFE?=
 =?us-ascii?Q?4SU9PqE33wTiroPd6BpdAtvJ5m9+F9bMq4IgeIspdy5YnFwGXD+AEn3CUylI?=
 =?us-ascii?Q?41NVsfu04CwKnJg3fwHg6DdL5aYLaercgY5iFZUsT9lbMOxVJsU8958Wn1cR?=
 =?us-ascii?Q?8EtaqPDeafWdfiYfDIPWZOrPkqriCv6P81/2OUIBQIWKrY5/LPgND50S5hvt?=
 =?us-ascii?Q?rIBVNdHuxjtXHcSZY8rsNpInhoHVN+3u9O/ElAmKXiGBTjsc+7N/rygUF6VF?=
 =?us-ascii?Q?G4OxHLF16UpVKE3uF05lQMkrQECy4JgAIWtwxV6hID0aNRFTPI06u55q93Wr?=
 =?us-ascii?Q?Hw/M/Wo8shUdrWbfF83Y5zR79WRTNJDjUajkajfzRXr22WCM0+VB91bYM9pf?=
 =?us-ascii?Q?4C7ba2g5UjNPpsTa5RZcs5dTQo2dHnQqACxVHxQUk6M0UUr6DjV0qNXOlQAT?=
 =?us-ascii?Q?JkczWwhQ6ToMHFJaOV399iOVkW4qI9+CaPpn6IY6Fb0rn9lzPRHebtq2iQzm?=
 =?us-ascii?Q?Av5cibP7gj23akddU1BR+6ulSWifLBuANOAggx11T7pYJth5l3oDnO6nPl0S?=
 =?us-ascii?Q?nlhzg0WHhbHPS8IR19Lnr7X/hqB2uYakup1YUEq5mH62xDldzxfpD9wAuFMd?=
 =?us-ascii?Q?KY15TlIKB7hdctsfF77Z7OUKA6TWF7Tvw9DcLL4L9LD4in0eMgqNZQBoW69o?=
 =?us-ascii?Q?rDN0hcRqL4NRG6uAUGuWyQmSCHJby+rEm2WEklr9NYfIgP5pS5BaKUYdakpf?=
 =?us-ascii?Q?UkFQYSnrenW7L2quoki417X6hiMmwAc4fQunCO7CZA654n3okS5nHSuF/Vqn?=
 =?us-ascii?Q?vrul52yULblqzBXMTNjchh9ZmT74K6JLnl1iec7aVgk6Rv9jIEjP/VBqhvC8?=
 =?us-ascii?Q?VrTVB4lMD/pg1ueNlXiv5vobZ1TpVYGjqMCgCtJdkWV50yIIZelPLjLYLYSA?=
 =?us-ascii?Q?TfX+GMHAQCzGk1oVC8S33fc4aotppLhdwD6p43R8fYqHjwjlpo7J8UPEhGBe?=
 =?us-ascii?Q?ymdugg=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 14:32:29.7765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf526b52-4b67-49ba-51f2-08de58f9e82d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU6PEPF0000B621.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6881
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
	TAGGED_FROM(0.00)[bounces-251920-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[nokia-bell-labs.com,reject];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7DE85594F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index d643dcb0a93e..1b1ec53e9961 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1207,8 +1207,11 @@ enum tcp_ca_ack_event_flags {
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
 
@@ -1363,6 +1366,13 @@ static inline bool tcp_ca_ect_1_negotiation(const struct sock *sk)
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
index 922f10bc3d57..6382938921ef 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6905,7 +6905,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
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


