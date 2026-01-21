Return-Path: <netdev+bounces-251924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IjBLFrocGk+awAAu9opvQ
	(envelope-from <netdev+bounces-251924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:53:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 635EE58C93
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E028DA46E8D
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39ABB4A2E00;
	Wed, 21 Jan 2026 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="h6lpJolA"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013055.outbound.protection.outlook.com [40.107.159.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DFB4A13A1;
	Wed, 21 Jan 2026 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005962; cv=fail; b=NZNtlgDEvJ1tYDVnxDeKCsvSYAfwFLeP8J4W2PYDyyouGLlstxIjMLmOVGojLfBz3LXEIRlKcMUsOgGp8iDxtvDfPA0XqXRnJrjvJ9MfeGgPi0Ie2fO4PRyIBfg6KaHJijzOTpz6EAomMJYFAfavm5u5MTsFTyzAYsF5QEWrgSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005962; c=relaxed/simple;
	bh=UtmVNGtjMnucPp/zDoNfGrNA9Cu4MqNFJgFBCiEs69U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/HzDHsCqPLkE/rCJ18/ZJLlugUUP0avt7mHRzmBg9gQiPaWUIpRUpd260TQddtSikthIRMqrRX+Pm0V6BYbJ+vGVrAb282/iz8bJM0VEfnOtUIu7WGwoMr6Rt2mRvQAZV2uzH02iBUAbxRXInBLb0W45fa7Q44vy6paTCNNNH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=h6lpJolA; arc=fail smtp.client-ip=40.107.159.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=miW8bWRa5xg1/aEl1QxJDQ1Ec9lkc8SXPYV/BWhG03Df31sUdXSAp/Dnc++Nn889uQSvwcDb5GDPTNi+lCK0JOlMMEpEvVfjvqm7/THP3UJk09tYtz8CNSxZfNoUNK+DzkJe2b4RFuzuFRS3uIuhjHpdj3QkMxzyz9qwV8i5umknGMSBv2GauL2jqgGGWMMLVa4uHzNXO24/tEavF36/MhWipxyahcuwbEpYiDqPBGNkdLMEv5/yOWMfA5rezh8tc8sf3cjazypR36e2OphZvtI6fbuDX2ZhrMavDiXGp4T5al9WoXZCI6igqgeLZTD8HsmTyMmQRtkN4DXkcR7rEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEwJatgdLzNxGBjJLg/R6oVXTrhjj5kf/E5zorz3m7s=;
 b=PZNKWj28Mob7le0l37V182/NNfYG3BTgA5tYato+Bx4zM4s4n7hA9EI7ZwwViwqcFQsbl+dxo9GAtqvgAanqvcD61PRDBI1WFUi+dhDEUhGuxBOAWY7B17ER5gBac0kVsraT94c+YsVqQ5cWVPKRc/Qpf0870TJr95gvSDMFqHAW/XR7mjRA7R1L4hrMnmr6sOC1rHcLiHkkAd+2EMi1ku3XqNQvELgchlZjC8EHghkeP1j43cdu3SM1RdItyZUJ0EiH3CRopZhanA5V3xsJM0i0CuehueJUBrddoAjGtSHem38dzo/9JeJUranNyf5hBoJXklm8bt7cn+3hdNzB/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEwJatgdLzNxGBjJLg/R6oVXTrhjj5kf/E5zorz3m7s=;
 b=h6lpJolARIOCcU3B2FtuEClsJsrldv/Pw3rc9Q4A5aQZ2f+9JTkvhVa43TxW4I8hY9FMT5n0Xxzdt+8SwSiJkFSulEjBo3FXJk1Fsm9zX804YUhnRSjnx4s1jcXPVVWD8DIho1gdzOTpXO1w0o9vuchu8UNaoTDyJSRaff0a6WOVE9iFGL3iyK31EvfCsOBAPMqd5/E/3vsqWgh14eNH2HsuDUEfELJFlmZiGtN2q6PcHz9uZ71iGWemCz4D2el1cNOe/wjzvChdji68ulqNJAEFEbr1rXyVVvK8BXqTD/okkvjM3OXxIDUYyG7Y9zS5m5cFJfJLnTiR4wgssVs7mA==
Received: from DU2PR04CA0339.eurprd04.prod.outlook.com (2603:10a6:10:2b4::18)
 by DBAPR07MB7016.eurprd07.prod.outlook.com (2603:10a6:10:198::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 14:32:35 +0000
Received: from DU2PEPF00028CFF.eurprd03.prod.outlook.com
 (2603:10a6:10:2b4:cafe::1a) by DU2PR04CA0339.outlook.office365.com
 (2603:10a6:10:2b4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 14:32:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DU2PEPF00028CFF.mail.protection.outlook.com (10.167.242.183) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Wed, 21 Jan 2026 14:32:35 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 185D420538;
	Wed, 21 Jan 2026 16:32:34 +0200 (EET)
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
Subject: [PATCH v10 net-next 08/15] tcp: add TCP_SYNACK_RETRANS synack_type
Date: Wed, 21 Jan 2026 15:32:08 +0100
Message-Id: <20260121143215.14717-9-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFF:EE_|DBAPR07MB7016:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5153e168-7856-4602-586f-08de58f9ebad
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?emBGgA87itClwybP13JOy1Oc0DCyOe2f1zJmHhdlycIwTAQRY4xQD1PBxYwF?=
 =?us-ascii?Q?dVizmhr6nA1n/pLbXFnxJRYbEthlBoxPXz+iqL8bPJRad4eyLEgakmwG5oJ7?=
 =?us-ascii?Q?KwMLmQjrtq/jXx9SenUrb0AsWqlzKpVSWBm+AKHAzQxVOduSc2UBzXaMnPzG?=
 =?us-ascii?Q?E+hJ9ssQI393a9HyDBRF1iGIc8+67rcdDr9ssU9V2ciqNTPqAPAAXrNVfhLR?=
 =?us-ascii?Q?1Sk5KjyLoO4v//XD2Y84EqA/sfM3jM4RU1fHQEQmigYNILas+z8DupBw3GNS?=
 =?us-ascii?Q?dmrKuWVTvPVw3YlS3ZzWaffhzY4Cql2xrp0B8PqOt4yApBjr9ZanMB/ZH9H/?=
 =?us-ascii?Q?Qxsf120RMLfMYO1PASazVv+O8c1TtaBk806F6Sjh3haMtYy74RmjpolQCTX/?=
 =?us-ascii?Q?/rUDZC+9nQvpdsc/a5f17U0NAPy59Svl/Rp6nJbAiE6DNtodJvJc3MkiiaWD?=
 =?us-ascii?Q?7F8fkE53n1EA2PwZVVBS0RCc/uSSk9J4IzH7pSWBqrUrL5l9waMqC7GY/3sX?=
 =?us-ascii?Q?HANTi0b9cZrK7BZQ87tqbSbOJA7w4Q2LFWqOofxM7lH+Mq+8zm5i7lx9QPrs?=
 =?us-ascii?Q?gRIlnMJOPycDbq6q+fCoYnX8XvFKFrD0Wj83yOwe2No6Bt/drmFc3iv6tO1x?=
 =?us-ascii?Q?msNqBGvdFZ6t/5pQK93AfvjqxBC82zqRbbuXWmR9DB1sxv+5bfkkYEe/CcPt?=
 =?us-ascii?Q?jwNQc76w/Ar/TNu1hf/OhCk11C2YQlhQ3zYAkxHeoPmSUm8ILhSLovnUGNJG?=
 =?us-ascii?Q?clujvQ4PYWZzAdQ1zbDA2RILLhOAonSV5T7Mjlx8W1ezqaidZzRVVo//Qxxo?=
 =?us-ascii?Q?Fa7cR44BjB9lFsdtFNCvak7D9/DWi+UDDKvMvAEIOelZ8Xwh49tHhLX6U75R?=
 =?us-ascii?Q?iYlKDDl0AmVPfKyJlvRmAFi6H58eFdGT5FLvAsgFzwvakPX5Rts6k8OAGZzP?=
 =?us-ascii?Q?Omb8p3DVztzMji04a6Ii03rwksbz/QIYW6aHWDEAy0eZsC1NSdqUBhy0ldYu?=
 =?us-ascii?Q?N2lPRdodtObhePfZrkU6iArJcUOp7hNZ2rQRz8oJ4RmakzggcLWKxTAPY1Vk?=
 =?us-ascii?Q?1J6dtstZfwpz4/rGU2Nhel8qKu5PUdotWxG7nNObMkCqTtWOZlvzd1FxHsr8?=
 =?us-ascii?Q?Nap3w7E2lxaWYK5qv6RNkApeao0wDegm9x6B5WTYhQPN7Mhs2uuaJDaJ7zm1?=
 =?us-ascii?Q?gjdoxyfO9hXUCC4q1okPsh4jOG+FYQ54XtVpOWmFEnMx4G/LEIi4wxf9k5AS?=
 =?us-ascii?Q?NXKMoQLUKzg0t3a4QBpGnjgD1QGyTMM/r1zuutS/zJR9NOVkY2+A6dYI7oTb?=
 =?us-ascii?Q?/SOpSWcqQKgF4k6Qy5HcXV3lKx0FNVLAXNivSaiFFf2JA9Rc6a+q7N/JcP5U?=
 =?us-ascii?Q?ec09w5BlQRnffm/V/ncPDC4CxM3DjSSm8WYspjyQPpNoiTeOi+SzrnwqmWHi?=
 =?us-ascii?Q?je/9pGNt8/dO9vV722MgvhnnI6DeNCPebpt5JIXhSMIGklntFBf/BxAXZAPV?=
 =?us-ascii?Q?LZofRepI1iHaQ3yhOYnv+eFV7PNT/7CVoa91R2b2oJtNcCqSfJKpLhcRX5E0?=
 =?us-ascii?Q?Aj2hAsj9Ad76NTS7WxCuLFMR+MQPsMHxeEFMq0qZB7kL7uUVnC8yRkrIiSmN?=
 =?us-ascii?Q?ZZt8ZsdkZpWE5OQYFVDvC2sRgtUsXw21+Jq+GCiwvE2ibxfJ91q1cgosyiYC?=
 =?us-ascii?Q?YafK5nMwywy9ghsm8On7GtuIYJc=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 14:32:35.6431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5153e168-7856-4602-586f-08de58f9ebad
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028CFF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB7016
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
	TAGGED_FROM(0.00)[bounces-251924-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 635EE58C93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Before this patch, retransmitted SYN/ACK did not have a specific
synack_type; however, the upcoming patch needs to distinguish between
retransmitted and non-retransmitted SYN/ACK for AccECN negotiation to
transmit the fallback SYN/ACK during AccECN negotiation. Therefore, this
patch introduces a new synack_type (TCP_SYNACK_RETRANS).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v6:
- Add new synack_type instead of moving the increment of num_retran.
---
 include/net/tcp.h     | 1 +
 net/ipv4/tcp_output.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 1b1ec53e9961..0de6686b8d42 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -541,6 +541,7 @@ enum tcp_synack_type {
 	TCP_SYNACK_NORMAL,
 	TCP_SYNACK_FASTOPEN,
 	TCP_SYNACK_COOKIE,
+	TCP_SYNACK_RETRANS,
 };
 struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 				struct request_sock *req,
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index d5d695a501f8..329e7e461c52 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3956,6 +3956,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 
 	switch (synack_type) {
 	case TCP_SYNACK_NORMAL:
+	case TCP_SYNACK_RETRANS:
 		skb_set_owner_edemux(skb, req_to_sk(req));
 		break;
 	case TCP_SYNACK_COOKIE:
@@ -4641,7 +4642,7 @@ int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
 	/* Paired with WRITE_ONCE() in sock_setsockopt() */
 	if (READ_ONCE(sk->sk_txrehash) == SOCK_TXREHASH_ENABLED)
 		WRITE_ONCE(tcp_rsk(req)->txhash, net_tx_rndhash());
-	res = af_ops->send_synack(sk, NULL, &fl, req, NULL, TCP_SYNACK_NORMAL,
+	res = af_ops->send_synack(sk, NULL, &fl, req, NULL, TCP_SYNACK_RETRANS,
 				  NULL);
 	if (!res) {
 		TCP_INC_STATS(sock_net(sk), TCP_MIB_RETRANSSEGS);
-- 
2.34.1


