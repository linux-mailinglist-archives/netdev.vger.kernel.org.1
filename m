Return-Path: <netdev+bounces-252822-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDEUNoFfc2ngvAAAu9opvQ
	(envelope-from <netdev+bounces-252822-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:46:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E000875522
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 47DD3303D7ED
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA05E35FF7C;
	Fri, 23 Jan 2026 11:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="F8ibTIyH"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012000.outbound.protection.outlook.com [52.101.66.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80A1328259;
	Fri, 23 Jan 2026 11:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168373; cv=fail; b=HLPE28Zt0jdWWY2ltbsseCyE/lPLK1khFtKuHbJ0IeyYWgS3vw5+OuSqYNFdjJPkHhxTl2J5riI2PwOa9I0eui+20giTDK8ZgxW73FZ/y6NJXfaGtiDpoi12eox4EsAKy82VrrSaOd6bDJSK7OIHI6w9wvvS98w3psalAMsJJj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168373; c=relaxed/simple;
	bh=7hXgWDIkzKlSZoI0cc4Ax8GQtZ0vv7Wztr5NYh0fg5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=geHrCfObfKQKcK/JocLndSPMxd+idoq5rqQRrM6jYFpCFqD4w7OHW+YUo/35NOF6J74pCf4qKx+YYUVuUsbQew7ZXfRrtWUUQgvNzzNRORNGAj1MvmHAzr5C0nZs2V5Ccj5YeeJgMAvNLVwT8AVVdocAYmPRiDz87EKURDfDLT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=F8ibTIyH; arc=fail smtp.client-ip=52.101.66.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8q5QQvx+RaYWNb7xkVAR6izRq40Yqwlb7zKSm/f5bfTFwOJYN+kaJA136NZppad/r+t02OQQLs1GCbU4g+dPloLpG9Kd9bzA9MXtWWRMOVouUW98+pqsV12bT5y3qzh3BywxIaCMaG2FhnTP01JhurSq/lSTHl+2zGjbD8Si5RvzmHW7jSNkuw+SMFKrbDwzsR65ozh1BeoCWNhAQZ01XkWPUFcrl6hVs79GZ/VBzFe3gIUA/AbzoIjsxSoN8pO020OXohyvECXzVVr/FWyGEL5pTBo91c9D01HbFXOmGIW/2NC6DltFOIvSPWnrX+BHr0l6MqJphsqbc33dJrsZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1CysRedwa9SuUXM/Q+5zgh4GhrkbLsOMvR0A491Gg4=;
 b=SKB77zUubdIdaXw8uI3bT+n1PvZRgyCsEBX9bBe2qTHFQSOxZT7693OeOfyDi6uNkD2sYOQA64IM2HrB9PatxnhUI6MX4bZRVkMf8N8OtFaGC4hXnUkiXK6f4YFUCr5XQUbdGwba4TcSVTLPIZu+SRCvJX3sd1tA5YEnsX6a9FVpGUJyC+rZjWAV0r9pWT1I1OCHETRo8945UwsOXFEmp9Ld7MGGR1gar5ZFb313Hf2fwjgHESULxg6ppM9QlWO+t0WRk1RPqg9OB5tmga6w8vABufttaIxbFQKFQv6I0/BVsUX9UZYUPiPWUWEiQO0TI6r1ZW+/HK1AYH1PxA54cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1CysRedwa9SuUXM/Q+5zgh4GhrkbLsOMvR0A491Gg4=;
 b=F8ibTIyHFVDOYB+kwWslUHLUEy4NbZEuGDhT67fkbhK6MQrPHjSajwoV9/L94Ih8zkyYZgnIHnuspdvrP8wGoVLqtPO1x/KI8Vo7t1EauVK+x51ngO6YG9ay58r2GCEasV7uIrHQkrGDPQF6OFnzO8GLuQYNsWcqPywkXFmVPzEppfrixbizzQv41pnankMGa+o8Mlt3QhTX8Ctzgkrg/RT6/bPbonVovwlkJ1owhmxNcwLsDNsnoo03lrzpuqf1XBm5emmFPhiVg927uTMW/GvQcFFuB3NothsecZiC3G1F9aloQm8gyyMy9OCd0pluirddMI3tqpQZA78qgv2ypA==
Received: from DB8P191CA0018.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::28)
 by AS4PR07MB9609.eurprd07.prod.outlook.com (2603:10a6:20b:4f5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 11:39:21 +0000
Received: from DU2PEPF00028D0F.eurprd03.prod.outlook.com
 (2603:10a6:10:130:cafe::4e) by DB8P191CA0018.outlook.office365.com
 (2603:10a6:10:130::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 11:39:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DU2PEPF00028D0F.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Fri, 23 Jan 2026 11:39:21 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id C57F820226;
	Fri, 23 Jan 2026 13:39:19 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: alok.a.tiwari@oracle.com,
	donald.hunter@gmail.com,
	xandfury@gmail.com,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
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
Subject: [PATCH v1 iproute2-next 1/1] tcp: accecn: add tcpi_ecn_mode and tcpi_option2 in tcp_info
Date: Fri, 23 Jan 2026 12:39:16 +0100
Message-Id: <20260123113916.43227-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123113916.43227-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260123113916.43227-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0F:EE_|AS4PR07MB9609:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fc047f53-2f1f-4920-e666-08de5a740cfa
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?PDs+G3H0LV/gCDXcxUwUgWy9q/66gacLd13r4/joeGZ2VW/yKFpUGwjzIiGJ?=
 =?us-ascii?Q?MenZ8CgoIQLRkguXJAuIU6g1yk5FSLGcWi3QEq4bGpn8UqN6+0d+B+eL/oab?=
 =?us-ascii?Q?3Fz1PNFAk7T+WKcwMvtLVS/2f5AnbM+XPAbO5L8kePWip8YtXxwfUWddempq?=
 =?us-ascii?Q?Gq5PAUZITAnex2nKJ5v0CxTtafTW50hp7njJZlP6rXQZSxyxmLv18QuNGUrU?=
 =?us-ascii?Q?uPGBbH3Hbe+OA8B/nj7R7c+Qu1psicWROXs2jQRkR+Tpff+rcVznHGPGH8zD?=
 =?us-ascii?Q?Pd1tf51KiYIZmK7EXdmnGF8PW1gwAre8bYJFjb4vu4CPVR1QMkBlcZMsm3aG?=
 =?us-ascii?Q?z6wIL+Odm3x61Rn+0TPQfXTr6ymn9h97bnI/vz8wq8ubtdGmNTIrKFdRLlla?=
 =?us-ascii?Q?XJjjk1fS0VFIwPzGNHtimucWOKr/OIFammQrqv+VZfoJCOcpXZ5HzvEd0klP?=
 =?us-ascii?Q?582moKv5v8PIq087a/ntrnkLc6rGCY04l6osb4/YWQUckUaQ2pkzB0UuucIH?=
 =?us-ascii?Q?BzjONLg6ktkrs8ef9jy55gzQ4pZx+Z25mC7uFpzB9rBR2uk+bd86rE8ry3Ku?=
 =?us-ascii?Q?cXKSJ/S5py+/zU8JBP0QpkNDKbaGsjM20EdatEiXNAsTL56bDiN/vgGoIGR6?=
 =?us-ascii?Q?ZeTd5yvwa7HRJh+4LAOsbJN3rruXQ3xK2Vg8CH21xEiyxX1HKnQ8JO9J8/If?=
 =?us-ascii?Q?gbJkU32r5KRKfPhElB9oUe+bi91sIBwGiQpKDTHNFtdc77rs3QQzv4HuV9Vk?=
 =?us-ascii?Q?79oIhhR6sWtxxvozjrcQKL974yqsOfhzJFBGrLFzcRwgB7aFuxCm+wW2jdjM?=
 =?us-ascii?Q?ivW4XvNGmxedLQGzsAlU6wO4fEgBFOUXCCRY3wHEmLWam8b+LAGbAHVi9Ji7?=
 =?us-ascii?Q?ZKISLoEuVA8UjZq6xd/sLUhZ3F47OTfwQQcYoo2e68GIs41JyQ4Qlu8BCVh1?=
 =?us-ascii?Q?ncgbggWcNIl7MjMbTgVlNbnNaAWrm+UFjuoDebWT/xmSJEpawgFyzMhV010p?=
 =?us-ascii?Q?3fiYim2HvP5+kouRNsN6QmraUGJh5Hs5DkppLIfii6Vk2XL2l5wzzfmPC0xT?=
 =?us-ascii?Q?dQ1X6rZ7KIgP9psln9iFyNbIfmKTXQxi3hIVYP6wNPC120IaNBKUhTeMLyxB?=
 =?us-ascii?Q?gc1EL1Z3ciK6Ryj4BSZ08jE9O3dB8RuuKSj6wPw+qgSzRiIfvmnbOM4tbtjs?=
 =?us-ascii?Q?oU4IXWiPckN+H11YFHds/Iv7SlGAvXSMuBPj4aWKt7afRWRcMGW3AYqs6I2o?=
 =?us-ascii?Q?CD68eAitr+WuOQABeDy2O24h5nQ0iVS+TF1T2Bp6rQ4spGusf5IQh7G0Ts9Y?=
 =?us-ascii?Q?GPaTiVC3K07dW1aFClR7KZ++4jqb4ZJTIvPtr16eQ0RA/AxHVfzKHqBZpnGG?=
 =?us-ascii?Q?grJDKbQBG7L6fY4ohkgoGBGvWFV5hQW6IzpKxLabzPlc9np8TG0A5zFJyx8x?=
 =?us-ascii?Q?x7/rVPdAbBHKhZvV1GR18l1xxTXIrqI190IG6Q4nNyQroDMvruVaQvvO7cxJ?=
 =?us-ascii?Q?1HsM/YV0IwzwRLyNiVvrhR+kGvwX/Tp1lpPKosBzaB9DvWSjoRoS3xfYMv1y?=
 =?us-ascii?Q?kM8ZYvgJltkXArE2sUZxG+5qzCYZr+jISuwT24oUX3PoIjG6JtbR+34GAvyz?=
 =?us-ascii?Q?ZedkBEeSaIL/QpB/3jHFs3N8F53RHP6w7imQL5q9EVXdLXCxknc3Z+zbXI84?=
 =?us-ascii?Q?DYNiNMiJjM4+T3Iw9rdTdiRJ/6U=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 11:39:21.2602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc047f53-2f1f-4920-e666-08de5a740cfa
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028D0F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB9609
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252822-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[oracle.com,gmail.com,vger.kernel.org,redhat.com,mojatatu.com,kernel.org,networkplumber.org,resnulli.us,davemloft.net,google.com,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E000875522
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Add 2-bit tcpi_ecn_mode feild within tcp_info to indicate which ECN
mode is negotiated: ECN_MODE_DISABLED, ECN_MODE_RFC3168, ECN_MODE_ACCECN,
or ECN_MODE_PENDING. This is done by utilizing available bits from
tcpi_accecn_opt_seen (reduced from 16 bits to 2 bits) and
tcpi_accecn_fail_mode (reduced from 16 bits to 4 bits).

Also, an extra 24-bit tcpi_options2 field is identified to represent
newer options and connection features, as all 8 bits of tcpi_options
field have been used.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/uapi/linux/tcp.h | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index e35d416b..bac6e83f 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -226,6 +226,24 @@ enum tcp_ca_state {
 #define TCPF_CA_Loss	(1<<TCP_CA_Loss)
 };
 
+/* Values for tcpi_ecn_mode after negotiation */
+#define TCPI_ECN_MODE_DISABLED		0x0
+#define TCPI_ECN_MODE_RFC3168		0x1
+#define TCPI_ECN_MODE_ACCECN		0x2
+#define TCPI_ECN_MODE_PENDING		0x3
+
+/* Values for accecn_opt_seen */
+#define TCP_ACCECN_OPT_NOT_SEEN		0x0
+#define TCP_ACCECN_OPT_EMPTY_SEEN	0x1
+#define TCP_ACCECN_OPT_COUNTER_SEEN	0x2
+#define TCP_ACCECN_OPT_FAIL_SEEN	0x3
+
+/* Values for accecn_fail_mode */
+#define TCP_ACCECN_ACE_FAIL_SEND	BIT(0)
+#define TCP_ACCECN_ACE_FAIL_RECV	BIT(1)
+#define TCP_ACCECN_OPT_FAIL_SEND	BIT(2)
+#define TCP_ACCECN_OPT_FAIL_RECV	BIT(3)
+
 struct tcp_info {
 	__u8	tcpi_state;
 	__u8	tcpi_ca_state;
@@ -316,15 +334,17 @@ struct tcp_info {
 					 * in milliseconds, including any
 					 * unfinished recovery.
 					 */
-	__u32	tcpi_received_ce;    /* # of CE marks received */
+	__u32	tcpi_received_ce;    /* # of CE marked segments received */
 	__u32	tcpi_delivered_e1_bytes;  /* Accurate ECN byte counters */
 	__u32	tcpi_delivered_e0_bytes;
 	__u32	tcpi_delivered_ce_bytes;
 	__u32	tcpi_received_e1_bytes;
 	__u32	tcpi_received_e0_bytes;
 	__u32	tcpi_received_ce_bytes;
-	__u16	tcpi_accecn_fail_mode;
-	__u16	tcpi_accecn_opt_seen;
+	__u32	tcpi_ecn_mode:2,
+		tcpi_accecn_opt_seen:2,
+		tcpi_accecn_fail_mode:4,
+		tcpi_options2:24;
 };
 
 /* netlink attributes types for SCM_TIMESTAMPING_OPT_STATS */
-- 
2.34.1


