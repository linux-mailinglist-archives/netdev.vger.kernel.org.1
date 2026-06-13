Return-Path: <netdev+bounces-298920-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e/4XJA4QLWqBaQQAu9opvQ
	(envelope-from <netdev+bounces-298920-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 10:08:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB9D67E123
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 10:08:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nokia-bell-labs.com header.s=selector1 header.b=J7Nuy8H8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298920-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298920-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nokia-bell-labs.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E6F83006834
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 08:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF833C3425;
	Sat, 13 Jun 2026 08:08:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011047.outbound.protection.outlook.com [52.101.70.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AA53C1960;
	Sat, 13 Jun 2026 08:08:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781338123; cv=fail; b=UU2Th6Jl1spbER7b7UadAqrRCZEztHuxZTByCR1kufI6gPO8ZRVDfb3r32zvMDbvZ6c0bgQLj4KcVYzjz/1SPmGR9Q2ybHoYMypIy2oC5aYSMTSOhkGjVrT4B7xG4i/1I3V4AYm7Uavk/zBOLjthKhXnpOA5GJMcIgol3BMPEpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781338123; c=relaxed/simple;
	bh=PHboUmjO/vknC4bRBITWjVs+rpvGSLdN7HQo8LE+RGI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=X58wCiHVCswlmJj4O4I0GQP4U41SDq8pew4Ov1ZUdtKbdiDsClCL1dDdfMfv2TNXpqDKkvwiR5VuUSwTgiagsA40CmpYjl9//PDxUsq/6CZRKiz8m3cpxUWg11Tirt46UHd5Z3RCSKk40R6ygXqBJb0LUpUxZqN40IR/5Xrx1xE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=J7Nuy8H8; arc=fail smtp.client-ip=52.101.70.47
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NbpXXF27RD2tT0MHn04p6OgxEPse1WSii6I1QehzHUJGS7m6kIZIXH9+4Ponr76uWxIAGJOrjlHFwP3gYtomXeMVTOtPWV7ZnStOrRT9gOcUlbXO1LDZbCgcLLwNgcObBmNdOaYRQutzZAm9kBgfu6BahY4ZfFbHVqIsZ/l82Cy3+K4FjZk5M4ZJgdGh/QTGIrrS11J/3zmWdZEoYxt31k5chtVfWINOYv8PP6v2i9FtRwsEAJqi6qJNMvmMX5owME1neRN+rBibOjwyTAscw//G5XZ9ksdiVRHTiXBP5hbv+NRznmjB46kXZal4mqw+oIOmNn5XJNbK0NjkBx4ASw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hl58T7prI5/kjUBUrOEn2iOGpqud8QSqp0xX3lNwVSY=;
 b=ymyIFkVp38HYyJcWSsG/m1fJEnnyexa5DLJu36Jrtz2UEmf5rDzE0VldKnvModYB6nwTwU00QCoAqxCPeOn5I3Q7YJWI6kX4MrwXQQZ7eKDWorIl5vV3WK7UJL7pqV1fx7iV7qy2jLDBK4p55M0zy8Pf9FlZODYA3C7Pld+jmafClBd0NgAFFl9cemXTcT1tUaRXeyS8gEOH+StTKtEtNaly9gMWEJiTDG2GpFZfbs48YeaAA4bLf8rY7xKx8UB53lY+04BpAV/XJ7xdYUG80d5nWL0DltSbudPs8mZ3niC/S3JOkh/Od5f7kJhMBwaoIrnf5oJuF44bQJd7SgnShg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hl58T7prI5/kjUBUrOEn2iOGpqud8QSqp0xX3lNwVSY=;
 b=J7Nuy8H8VMU8O7ORFMfZYbu6/Nip98quu0Tdant6/ylgZY8ccrv7kHelRPSjpME7pVZrr08EVTos01Sj3VdxXbVjLKcCENKBI9bkSkXSL/2dez+RqNHOyoKlYu6ZTH83S6VxfpBE3Mc6/sxTTg8ciZHm3EpgIkSdKVTYOfWY68MLI+fGNB/coHEAnYjRikVSMIydaNod12r3cIMwYL9bA6h3Hu8yOrocKvhtiZcBF6Bm/a/kYdFnVMaCIcL2QNUWISGhUFf2NNCXuQUs2fMiOfL5FCcVg5z7/dqE8xjMn8uOQ1mSGJcBQPlLZKb5ZU3HU+rByhbJNr8YE4IwXg0kEg==
Received: from AS4P250CA0019.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5e3::10)
 by AM8PR07MB8123.eurprd07.prod.outlook.com (2603:10a6:20b:36e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Sat, 13 Jun
 2026 08:08:37 +0000
Received: from AMS1EPF0000004E.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e3:cafe::73) by AS4P250CA0019.outlook.office365.com
 (2603:10a6:20b:5e3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.15 via Frontend Transport; Sat,
 13 Jun 2026 08:08:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AMS1EPF0000004E.mail.protection.outlook.com (10.167.16.139) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7
 via Frontend Transport; Sat, 13 Jun 2026 08:08:36 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 6975D200E2;
	Sat, 13 Jun 2026 11:08:35 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: andrii@kernel.org,
	eddyz87@gmail.com,
	horms@kernel.org,
	dsahern@kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	davem@davemloft.net,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	kuniyu@google.com,
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
Subject: [PATCH v1 net-next 1/1] tcp: Replace min_tso_segs() with tso_segs() CC callback for TCP Prague
Date: Sat, 13 Jun 2026 10:08:31 +0200
Message-Id: <20260613080831.236636-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004E:EE_|AM8PR07MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 9164164b-5a96-4c09-d3fb-08dec922f87b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|7416014|1800799024|376014|82310400026|921020|18002099003|56012099006|3023799007|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	ItvfhepSfIWBeSFl8sP0EDi7tQnC36VzSi44ZBF3uFhP9AfYzVadrAUKrX/I7X/MSplm8GdpcQV5JicTtKFss7ULpBH32u3E1ftn24b3gddHuvEb8603p0cYl1dhzhk6+odbUsEVQCLBVukaAzvIzY/CamHfhA/k4Omk0z3fHYJNiX7mjQuRt+J+hrArsatxdixGmfx/eNqY1fCnlVtZdfylzVoJAzuh+GuBV5pLAkZpTEn6/orXes3jd0XTjW5g+zMGZilMPNm3lelEShrcHzTQ/3ZBqc553Znmrb4QyOIaUWp6946I/43v4lt/9CPH4kHikEX6KZx4/xw2v/QXFxKNvD+upb325WWrfzhtuAm13WEtTKxHy9YvG5EAZh2nIbdrgasF6d1VTn0UcNKpETHT0K+mXYVmjoKJ/F3vyuxFh/RtlzeKzc70LdoYKzf3B+f4d3azoWSw9dn5tS9miTqbSZ6nbJGFdsX01d9xa3Kdvdb+8LQlJc13tCGoqfVXI9Lg7+zK5dq7lxwNJiszCUoPw/AjU05+TP3f5jeXBFd1E31+9PIAW3ClDAn5UfjfySemetJ/SfWfBZeG0lyUKbK7W/bq+FrKMSenvMVTHvwtPhSetfZ+YQp5e9wuISwlNznZWeeR+PwzmdqjcxeVYmzjwAo1YJYoJ7Zu3OW5wHS6QIEbk1sO+PogHbsJJH/66jj2yWrrbMeI2t3ndE/G8RK7xW0MXj9EJWSjOrKTfJW1uiIYMLnfBpN/z/pCtcbx/SaYSJoGM23x04I53UFOEA==
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(1800799024)(376014)(82310400026)(921020)(18002099003)(56012099006)(3023799007)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rGCDbem9B65BWF49z2FURbHdIOKVsLQsSa69uQ1PlKVCsni9QSykMU1obf7sC7KaCjxhbD+f9HXvlti30o0dtaxdezb203SLVpiTugN7JBJdZJ/wbi4o8VEgwqlp0mIC/9jbG+PQo4FXrA5d92LMI1BlCTBXUZoW3Bq+hJ2uK7Okk3uNn7Om51he1TQ73axC3dVJCsnIJcCHU4pQksCfCrIiz8/np6Qltr5qato/OzgTTHX973YiMM2Ww3wUCCRtU+cWNk/d5JIoq6ITEy2rdpyenf31jPu4Ta4C2O2ldEqfZNXt1rtDDoipbSlwZOPDHBDnPUoe8RgrHGBllf2JQuICrsIMEUr2HNV70b1/bdB7aRltvTW8gpgHppOdzmgao6qqh1KiEeY4ZIGzrxzXF009TA/NNKSplQFiqCbrtSNhONezeuU8jktGnqMFJFvG
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2026 08:08:36.7168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9164164b-5a96-4c09-d3fb-08dec922f87b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8123
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-298920-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,vger.kernel.org,redhat.com,mojatatu.com,networkplumber.org,davemloft.net,google.com,lunn.ch,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:andrii@kernel.org,m:eddyz87@gmail.com,m:horms@kernel.org,m:dsahern@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:kuba@kernel.org,m:stephen@networkplumber.org,m:davem@davemloft.net,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:donald.hunter@gmail.com,m:kuniyu@google.com,m:ij@kernel.org,m:ncardwell@google.com,m:koen.de_schepper@nokia-bell-labs.com,m:g.white@cablelabs.com,m:ingemar.s.johansson@ericsson.com,m:mirja.kuehlewind@ericsson.com,m:cheshire@apple.com,m:rs.ietf@gmx.at,m:Jason_Livingood@comcast.com,m:vidhi_goel@apple.com,m:chia-yu.chang@nokia-bell-labs.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2FB9D67E123

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

This patch replaces existing min_tso_segs() with tso_segs() CC callbak
for CC algorithm to provides explicit tso segment number of each data
burst and overrides tcp_tso_autosize().

No functional change.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h                                |  7 +++++--
 net/ipv4/bpf_tcp_ca.c                            |  4 ++--
 net/ipv4/tcp_bbr.c                               | 14 +++++++++++---
 net/ipv4/tcp_output.c                            | 12 ++++++------
 tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c |  8 ++++----
 5 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index f063eccbbba3..34d370ea9ceb 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -824,6 +824,9 @@ unsigned int tcp_sync_mss(struct sock *sk, u32 pmtu);
 unsigned int tcp_current_mss(struct sock *sk);
 u32 tcp_clamp_probe0_to_user_timeout(const struct sock *sk, u32 when);
 
+u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
+		     int min_tso_segs);
+
 /* Bound MSS / TSO packet size with the half of the window */
 static inline int tcp_bound_to_half_wnd(struct tcp_sock *tp, int pktsize)
 {
@@ -1361,8 +1364,8 @@ struct tcp_congestion_ops {
 	/* hook for packet ack accounting (optional) */
 	void (*pkts_acked)(struct sock *sk, const struct ack_sample *sample);
 
-	/* override sysctl_tcp_min_tso_segs (optional) */
-	u32 (*min_tso_segs)(struct sock *sk);
+	/* override tcp_tso_autosize (optional)*/
+	u32 (*tso_segs)(struct sock *sk, u32 mss_now);
 
 	/* new value of cwnd after loss (required) */
 	u32  (*undo_cwnd)(struct sock *sk);
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 791e15063237..ed4fea98dfde 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -284,7 +284,7 @@ static void bpf_tcp_ca_pkts_acked(struct sock *sk, const struct ack_sample *samp
 {
 }
 
-static u32 bpf_tcp_ca_min_tso_segs(struct sock *sk)
+static u32 bpf_tcp_ca_tso_segs(struct sock *sk, u32 mss_now)
 {
 	return 0;
 }
@@ -320,7 +320,7 @@ static struct tcp_congestion_ops __bpf_ops_tcp_congestion_ops = {
 	.cwnd_event_tx_start = bpf_tcp_ca_cwnd_event_tx_start,
 	.in_ack_event = bpf_tcp_ca_in_ack_event,
 	.pkts_acked = bpf_tcp_ca_pkts_acked,
-	.min_tso_segs = bpf_tcp_ca_min_tso_segs,
+	.tso_segs = bpf_tcp_ca_tso_segs,
 	.cong_control = bpf_tcp_ca_cong_control,
 	.undo_cwnd = bpf_tcp_ca_undo_cwnd,
 	.sndbuf_expand = bpf_tcp_ca_sndbuf_expand,
diff --git a/net/ipv4/tcp_bbr.c b/net/ipv4/tcp_bbr.c
index 82378a2bfd1e..15536564246c 100644
--- a/net/ipv4/tcp_bbr.c
+++ b/net/ipv4/tcp_bbr.c
@@ -297,11 +297,19 @@ static void bbr_set_pacing_rate(struct sock *sk, u32 bw, int gain)
 }
 
 /* override sysctl_tcp_min_tso_segs */
-__bpf_kfunc static u32 bbr_min_tso_segs(struct sock *sk)
+static u32 bbr_min_tso_segs(struct sock *sk)
 {
 	return READ_ONCE(sk->sk_pacing_rate) < (bbr_min_tso_rate >> 3) ? 1 : 2;
 }
 
+__bpf_kfunc static u32 bbr_tso_segs(struct sock *sk, u32 mss_now)
+{
+	u32 min_tso;
+
+	min_tso = bbr_min_tso_segs(sk);
+	return tcp_tso_autosize(sk, mss_now, min_tso);
+}
+
 static u32 bbr_tso_segs_goal(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -1151,7 +1159,7 @@ static struct tcp_congestion_ops tcp_bbr_cong_ops __read_mostly = {
 	.undo_cwnd	= bbr_undo_cwnd,
 	.cwnd_event_tx_start	= bbr_cwnd_event_tx_start,
 	.ssthresh	= bbr_ssthresh,
-	.min_tso_segs	= bbr_min_tso_segs,
+	.tso_segs	= bbr_tso_segs,
 	.get_info	= bbr_get_info,
 	.set_state	= bbr_set_state,
 };
@@ -1163,7 +1171,7 @@ BTF_ID_FLAGS(func, bbr_sndbuf_expand)
 BTF_ID_FLAGS(func, bbr_undo_cwnd)
 BTF_ID_FLAGS(func, bbr_cwnd_event_tx_start)
 BTF_ID_FLAGS(func, bbr_ssthresh)
-BTF_ID_FLAGS(func, bbr_min_tso_segs)
+BTF_ID_FLAGS(func, bbr_tso_segs)
 BTF_ID_FLAGS(func, bbr_set_state)
 BTF_KFUNCS_END(tcp_bbr_check_kfunc_ids)
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 26dd751ec72a..14fde0aa14be 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2253,8 +2253,8 @@ static bool tcp_nagle_check(bool partial, const struct tcp_sock *tp,
  * for every 2^9 usec (aka 512 us) of RTT, so that the RTT-based allowance
  * is below 1500 bytes after 6 * ~500 usec = 3ms.
  */
-static u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
-			    int min_tso_segs)
+u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
+		     int min_tso_segs)
 {
 	unsigned long bytes;
 	u32 r;
@@ -2278,11 +2278,11 @@ static u32 tcp_tso_segs(struct sock *sk, unsigned int mss_now)
 	const struct tcp_congestion_ops *ca_ops = inet_csk(sk)->icsk_ca_ops;
 	u32 min_tso, tso_segs;
 
-	min_tso = ca_ops->min_tso_segs ?
-			ca_ops->min_tso_segs(sk) :
-			READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_min_tso_segs);
+	min_tso = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_min_tso_segs);
 
-	tso_segs = tcp_tso_autosize(sk, mss_now, min_tso);
+	tso_segs = ca_ops->tso_segs ?
+			ca_ops->tso_segs(sk, mss_now) :
+			tcp_tso_autosize(sk, mss_now, min_tso);
 	return min_t(u32, tso_segs, sk->sk_gso_max_segs);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c b/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c
index 0a3e9d35bf6f..58262e490336 100644
--- a/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c
@@ -10,7 +10,7 @@ extern u32 bbr_sndbuf_expand(struct sock *sk) __ksym;
 extern u32 bbr_undo_cwnd(struct sock *sk) __ksym;
 extern void bbr_cwnd_event_tx_start(struct sock *sk) __ksym;
 extern u32 bbr_ssthresh(struct sock *sk) __ksym;
-extern u32 bbr_min_tso_segs(struct sock *sk) __ksym;
+extern u32 bbr_tso_segs(struct sock *sk, u32 mss_now) __ksym;
 extern void bbr_set_state(struct sock *sk, u8 new_state) __ksym;
 
 extern void dctcp_init(struct sock *sk) __ksym;
@@ -90,9 +90,9 @@ u32 BPF_PROG(ssthresh, struct sock *sk)
 }
 
 SEC("struct_ops")
-u32 BPF_PROG(min_tso_segs, struct sock *sk)
+u32 BPF_PROG(tso_segs, struct sock *sk, u32 mss_now)
 {
-	return bbr_min_tso_segs(sk);
+	return bbr_tso_segs(sk, mss_now);
 }
 
 SEC("struct_ops")
@@ -120,7 +120,7 @@ struct tcp_congestion_ops tcp_ca_kfunc = {
 	.cwnd_event	= (void *)cwnd_event,
 	.cwnd_event_tx_start = (void *)cwnd_event_tx_start,
 	.ssthresh	= (void *)ssthresh,
-	.min_tso_segs	= (void *)min_tso_segs,
+	.tso_segs	= (void *)tso_segs,
 	.set_state	= (void *)set_state,
 	.pkts_acked     = (void *)pkts_acked,
 	.name		= "tcp_ca_kfunc",
-- 
2.34.1


