Return-Path: <netdev+bounces-252768-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNylOBdKc2mHuQAAu9opvQ
	(envelope-from <netdev+bounces-252768-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:14:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63865741E5
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 055AA317A413
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FA637F72B;
	Fri, 23 Jan 2026 10:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="f6/lTK/9"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011040.outbound.protection.outlook.com [52.101.70.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E227835029D;
	Fri, 23 Jan 2026 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162884; cv=fail; b=R4TJYuiTm1DFfuvYtgMHaOvdVKgaVTcKG7BCYYuPRwLPnr0xSBLyZT6TI+PHI1k/CnGV6LvX1nHSTbHjbElgC1H6aCRdsf7J4N4YZthD9RJCuhNAnu7a1H8WpENbMvhb9H4lUNvkwEpSrhM3G/nDPgtBGdHnzkTOV9sXfBQ6e4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162884; c=relaxed/simple;
	bh=HfeAA8XjQSReHeQutWOAsbnU/1suOgAjGRpB1wmV8nw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XU6MJbICkCFlc0W7cWbuE9CllWgjd+5UBuJVPmpRPo75wQZBTvm3GsMyi37a8KhzBjhADD6044EC/t8aweJUYVmhzq9FJnT/JRWPX4146sentEhRl2FNCbEs6K/dg4tZcR2ftuCL2+jYGUd/x2lyBfuZ69e+THdmNo0ai4B846Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=f6/lTK/9; arc=fail smtp.client-ip=52.101.70.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBqIGswDNwQmVvpP7N8z1YiYsbIRYXy3uOC6syyGPOGl+94d7NyUYudn77WqDMthBnH+dAO/Wl21Rw6yJt+65jfhi8BdxZvRVEAopLwpjkkGJyyN81Hn67mqlSLDJLqYtZd8ECYG6lrVhbVR4oRDo/YJknPcN8bWm2GQywHB80krwjaQCsUdd84jY56fHZqUfjotyvcFoAZmNvj53TzNl9ZnRYA4T7odt1xYnxB6AKOwDkVfKogU5v8Pr/oqx2K8pIfPPyH7vQ5FWwkaPepSZhfRL4DwIwETLjlYOq+tVu9Q9oOv5Q21RW6rcxld+HW1HJR2w9UFEsnJ95cipzN7aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9k8NMqdJup3zED9duGtd1YHEMAer/PLP41qHZiZMcQ=;
 b=h4kXvzXhFri76bknebEW2/Xw0JiDO2kfZ2e5k8OcqaG4Rtv6eAtBN+QJsWaJ0lddD+re57AXxQ34Uy+AENeOkOl0FZo/Gr3jt+zNNH1n1Rfow7TtBn1895lzw/I6OpaqyAVvBV4jZWsI8mkcdB90bBqLXwnfKK6qAIiHFLvlLjke3jIglq7b5ytJ9VHxqSAANiwwJJcVKoFYmefROAgjZXCgg09H6IO5fPvtxSozPebG+/ztBxeaUtUHWpZ9zZ/QLe8YSpNxZWkmDShnqbgmkjkLw1tSS/BRDmrpjUZJPJs+bM8CRYyA8rCK1jkIHONS7DkqXWNs4zjAAz2Myk++DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9k8NMqdJup3zED9duGtd1YHEMAer/PLP41qHZiZMcQ=;
 b=f6/lTK/9MnUHzEaUS7gY824PEvV5coQm2iCvnfaXHyke5fVDjScCpQZLVI9Wfp2sb/o/0XZZSQRvB7jovvFBnb3+HwbqQNki2myeCgba1kkttg4VoMiMBs2Gcwm1dERAYI5NbORp//iC63vCL+tXJ4lYZlKY9RJpGmq6vMXjuLLXveUN+wi85wI5ulX7D0xm5txk1Spjq2wT1DpRiW/FHsqfn/1oJZ8lVt0b7qSYK7CfEV1urUCGvM8kNv9mJyZboBYUeawG64gjR0GvJ49BoYzZtyJJqOS8zcG5o2RB1R+mPqsKgnL73jhlRwQiUXHfd0/kClECGcBLbRHc9BrCHg==
Received: from DU6P191CA0072.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::25)
 by VI1PR07MB6319.eurprd07.prod.outlook.com (2603:10a6:800:132::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 10:07:45 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:53e:cafe::36) by DU6P191CA0072.outlook.office365.com
 (2603:10a6:10:53e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 10:07:40 +0000
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
 via Frontend Transport; Fri, 23 Jan 2026 10:07:45 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id CF8751C003B;
	Fri, 23 Jan 2026 12:07:43 +0200 (EET)
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
Subject: [PATCH v11 net-next 11/15] tcp: accecn: fallback outgoing half link to non-AccECN
Date: Fri, 23 Jan 2026 11:07:17 +0100
Message-Id: <20260123100721.42451-12-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A00:EE_|VI1PR07MB6319:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5d261642-25d4-461a-e148-08de5a674142
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?J2yxWRF2O5eMYQFwDe9ER0Dw9PLeXCNCSZxieUr5DI8qVGMYhGXGL+oF0FvT?=
 =?us-ascii?Q?XBNMUdveYsdMbRRhSFeVwJwJMXsm0JLC2KBPpQW426B4dcfiZRr/50BulnwL?=
 =?us-ascii?Q?D0/zkWrcAo160f5WVMd9JVx0yenB9KG/XF+30riZsKIRxJjXYnnMrrb1y+py?=
 =?us-ascii?Q?aEh5ksv3pVwcBMDX1Ew65Zw82NMnHD0HywGyX6qAkrDi/CrAYfh8P4D536cV?=
 =?us-ascii?Q?ZPLarGjCVr8FPT/Yl5iBKA2DKgmen56INzt5pB3h7xCFpuKXj4HxyoIShfCP?=
 =?us-ascii?Q?1vJnmzWJKBYQwNmIc3M5PB5zZ0xT3P7RYnYHfmD+h4fQl6bNahe56vglEBle?=
 =?us-ascii?Q?GOhD65KDdNzREZq9jrjYFb63mSiRX353qZ3mNxSMQJzplorMYH4PDuz/1HiV?=
 =?us-ascii?Q?3cOx1UKo+Zyx3WceTptDD/IXhHZTaAxZjl4pXaTKEpGKh30jOb+ZIArzG+gY?=
 =?us-ascii?Q?RuYpFWTEgbTD6KvQI0ZWK5TmPHR0NC10PdXrq9deCFN3LpvWlh2ibKKMTmUl?=
 =?us-ascii?Q?ozK2NfZQrQRicji5y7rRMprNt2ffk8lPBuiz2LsR6a8hHcOxbfni/ujv5pn7?=
 =?us-ascii?Q?Ae9R7CQz2ZBlzota8NGDwd0if1c4/yY7TPmoHPPvN93/cCBzJswggn1VPzcT?=
 =?us-ascii?Q?PqaU26KqNyRf3GLzyeRhyKDLiN89byZB7rzgstL8t2/Rh52RwHJ9GUgT1INj?=
 =?us-ascii?Q?Rbvbre8oHd64D3qUE6nA8D9Dakk0HpCHA8NuaLlh7/mWok7PMrg+zsQn1hvC?=
 =?us-ascii?Q?+FB6otVGEYj31btcv8EmmWbHpbfI6yWKDso7q6yYCcsPyJFg9Uxw9upgO/nL?=
 =?us-ascii?Q?YYr8he4LDQZN5BHKHcVpcBg7B5ieGVosEn5VghKqOgWhFMQEfsjRC5LAINOZ?=
 =?us-ascii?Q?gP1cHpIrPxaWECb3gw3lu4Ew03mnz0TL5FCI8LKsxoCE82nZxBEUkOP5EDYv?=
 =?us-ascii?Q?Z+rwNBc3lhY7T7Y1LQQSd3LDHdpET2nCJQekhF5oFsmxeM3VyyGoDWugTjVj?=
 =?us-ascii?Q?uNqcwj0C/LEPvL0CqyVoMCf0Fv/4dPr9Waq4qP1bEXZJBCAM4z0rdYbWgmju?=
 =?us-ascii?Q?p992IbR36b5fx6OPdnMdE0gb+yNQoT/hPwPMMXd2IKK1vF+AppJHenAqtD+9?=
 =?us-ascii?Q?KLGo1T167vPKCuJH+TamHEBMO+R6+w/xA51NUnJxG8hOjOUwdsWBuTTSJ6z6?=
 =?us-ascii?Q?8ieW1Y0ZPvWhqJqf07PbxPVHVNSiE11SRqE1rdu3pQI94ke5TGlq4JFs8u9i?=
 =?us-ascii?Q?duHZ4AvqOT3nwjfIZa5+tkfaThiQt2XqHClxFd3gXXd7MxJXY8ZLiqyzQTa7?=
 =?us-ascii?Q?zJPBhcaagXtC1TQhmxAQHEXoGF4K84RfvmQuE+t8Gbxk8fA3FWAF82jcSQAp?=
 =?us-ascii?Q?G2FvnNYP9MyTG0eO6fYaCQVWk/mT0Iog9HkeF79bDHhVjTA8uLQJ3R2MuYRY?=
 =?us-ascii?Q?3FITTTj5yeDWu+/eCi0EoN6o52zLRDyWEjshnB44nuiNQuvjPoF259v5asqQ?=
 =?us-ascii?Q?a0LoNYN9lUuJQaaHoc91C6VlIcXeqXPtxdQ+wog9wFXAo/q6v0SFqw4Ivd1I?=
 =?us-ascii?Q?/3sU2cfQaTXHSzSU7xqF7bOXq6DrrmJXZbAKivCt7umKWtLz2UbROL+v4WWx?=
 =?us-ascii?Q?HhAv1yyhKv6N4ClMXzaS5gMRDEgwuRt7IkIemcebYr45q13Y0k9oUxRvYhRz?=
 =?us-ascii?Q?p7PKjcnRSpP//12wgfXZf/lENHQ=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:07:45.5427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d261642-25d4-461a-e148-08de5a674142
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6319
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
	TAGGED_FROM(0.00)[bounces-252768-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 63865741E5
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

According to Section 3.2.2.1 of AccECN spec (RFC9768), if the Server
is in AccECN mode and in SYN-RCVD state, and if it receives a value of
zero on a pure ACK with SYN=0 and no SACK blocks, for the rest of the
connection the Server MUST NOT set ECT on outgoing packets and MUST
NOT respond to AccECN feedback. Nonetheless, as a Data Receiver it
MUST NOT disable AccECN feedback.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

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


