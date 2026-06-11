Return-Path: <netdev+bounces-298202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7HvdBk7fKmokygMAu9opvQ
	(envelope-from <netdev+bounces-298202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:16:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB62A6735F0
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:16:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nokia-bell-labs.com header.s=selector1 header.b=he97EDrV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298202-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298202-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nokia-bell-labs.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5DC230FE44A
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94912426EB6;
	Thu, 11 Jun 2026 16:15:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013004.outbound.protection.outlook.com [52.101.83.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E477E4192FB;
	Thu, 11 Jun 2026 16:15:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194519; cv=fail; b=gZcWEQyq6WWgMMfCuBoQDTLPPPbY6ITEde8xH77oYQkVMoJl783UmwGCGlacA1p9b09tLQa4BSxaZZc0OkISD+vwVi8FzK0HRPAW++FbcpGzGBlxlyJ7764ccbgaUyWNE2K3hY4FTlhm3zW8OWSfhMUTfs/t+k19Hm0UxcfQm6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194519; c=relaxed/simple;
	bh=4+f+nbHoY2MopYpcRZt5bs+3M07Ri2+31zdvF3BdOz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kY7jKi+mkaEFEzcXQ+xaYXQMRWHZ52fgJNAqAHPLL1jmMUNRFFDAuzUMOzsNDvAP9ByRrXB80PMpOwgHNxZsoVLG3ugIHpg2XIcfg5ICaw4WV1a+IJe1f8/OdEIpvsb40wk56LMiFk7CI/QfJ54miLJh8ovQapAuddzf4j1nWXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=he97EDrV; arc=fail smtp.client-ip=52.101.83.4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tYN6AgVucoGw5FgwMGhnrT1bKrzTCjWn8eCCafmd1VlOeuXnA87XTMTWWCbiK6ILgVt19mAu4rMaMjg2hm52ujXGVTKqNYC5rep8YE14xkGGaGaN1N4hgd2y+rKnpSbd93qLGycUN1d0uEOiq7REn2LTWK3Bd5jm+8px1wRiPTRIzDD6rI/PijWeeqpaCuju14iLDH7tGwCJJgx2FC1QiZCfNKBt3QvepzFbRXf8qHByWD0rCJFRThQ4d24E/+GdvqqgtyIW2CSc5cnxEyfRRCLp+S4XDnrV4+r4hysKHA8Y6bIX1AjK35xQweNlFQZ9cJNplPGnhHefI6TuH8LwSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRMTBgWffy5dSTh8Zr8hly1bfBpzj0PfF14eaC1btaY=;
 b=I9CXl/pRYvQKpnrH0SkQxWnpXnvRovEFLCwUxT8BPJKn22Vjg0B09nverhIy6YFEsSRbjrXvIiXLhG9Okwt4of2tHorXfI1W0TDrVbmTPzjgflj3/bjcMZBH4nG8wSlVDDYGgNFn48QXcQXLJRtirCTzz2Ab81TzbvE27vLtYyVBuxhOx7VP6I2x+h1vmrzCKqXmeNtmssVVO1pw9B6MW6xXjx1lm3BUZbAaBAsOcyqHlcfk0g8d+NJXN/RUNtxVC7hXSpqjUXJPIpEl5eS/Oou3Pzw4hVjmE1nMqXA14Q6fnMNQAukqQDHn0NTP0IrP74I98QVOiKjcica5MVYsrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRMTBgWffy5dSTh8Zr8hly1bfBpzj0PfF14eaC1btaY=;
 b=he97EDrVKwbRoKj4IePTJxpoLRZk6hFlKmxTWQ7uovHUaGmQp7V+KONzea7DQ3LEI3bTEDNWYQiZn0i91j2hy2IX6MR477GplA7CRe8oZ9lNX211o9sxm/3l5vFw0ITQzhTAVBuaWD2an8885ZpmEc0QWqGeux+XJ3KS8aHp0qO58/A44FR+rd5nXpQ28mh/BW8KW4zo9TE1qYdXLoaE49dOwp4WOSiQjUPJsPXBPZk06uVHu9pdYKh1BmuzSE/phscT/CjHcyK9UDptcfU7vzefl3zdG/dH3tiPTg/XpKAGKJYr7tL/kE9Cnzh9Xd794bylKgaUUGODSVNKQCQT7Q==
Received: from AS4P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::17)
 by GV2PR07MB8987.eurprd07.prod.outlook.com (2603:10a6:150:bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 16:15:09 +0000
Received: from AMS0EPF00000199.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::15) by AS4P190CA0028.outlook.office365.com
 (2603:10a6:20b:5d0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Thu,
 11 Jun 2026 16:15:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AMS0EPF00000199.mail.protection.outlook.com (10.167.16.245) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7
 via Frontend Transport; Thu, 11 Jun 2026 16:15:08 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 6A9AA68004C;
	Thu, 11 Jun 2026 19:15:07 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: horms@kernel.org,
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
Cc: Olivier Tilmans <olivier.tilmans@nokia.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v1 net-next 1/4] tcp: accecn: Add ece_delta to rate_sample
Date: Thu, 11 Jun 2026 18:15:01 +0200
Message-Id: <20260611161504.228319-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611161504.228319-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260611161504.228319-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000199:EE_|GV2PR07MB8987:EE_
X-MS-Office365-Filtering-Correlation-Id: c56299f7-d80a-4675-0310-08dec7d49b6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|36860700016|82310400026|921020|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Mu/WSsslfNQwW5J/lpUYcUz+pSjNNln61veWPYyYXEu9912SOv3Y2kqKrmCM8e2wuV2YOZlRn7l/qkNEiIyAB1c+ftJ9UGfohuDOKt8t9/YJXNNXfsoBZh9WR4XP1a+3p7TT3+JDsheqv2mYVpjARAAEwUNkwPQ01MEDw3sMytJZnCKtOdAQCx1jZqsEq67k/T56bMS8ioUsDvpwGAeVILIiPhNA1tBhhy4d3HWPJXmpqfmJQjQ3GVfSIksoogN9kDYyMS4s5VPR841lz61r/bZ6rbNfEZ3d65YNckBBSAlLlfzvmJvvrzaVOGdKiAlKCiW/Qulog7UqSOzDkdFZHRSud/ZFW32gDQxdwoCqCDnTZeQvXo7saru1ZzeFfr1KOZu/ufD1um/A3OBIFhCQdbxLWyXf+Peq4lT7H+VgoILGuaPqABeZwwa4NdJGIv1YTqvlhpmdJBFt4SL6W0vh6XBzBSZarhKzexK2oB+yXiIwEdvkBsNQvru294tBWz8mqpP6G39sdx8r5N8KZUC8AsV7/OqRR7It30+lhN4Ow2oGWOAiTKflB6WEoOKn5LEaHYmb1r9ZmFiy9tPwA9CTX0fnatTBaF7/ZaIBtFhkNOd8jfXT1YudlUQQeJZDerdxxcBynnN20QRdimGqv9pq0uELLrTAk8ByATn2lOjThR/e9+W2lBY2BpQSacMQ32XdffE2pzct02vpAOi5pc3pLXX353qDdtVNOajKf1CfJEsJFr73ArLOsx5DljF2v2E374J2/CYT1I2u0am8m+LXsg==
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(36860700016)(82310400026)(921020)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5vfVUp9Js1m05mp2vZJ4CpESOWOG29U2EDTeDQkoeYJlfog3x9vgAIr7qZH7aFPKtjTaH7cbN4bytzTaeHI61oKQtujMjzFX88W4FdWgPKPeZQqkNcGAdCIXF81NL6B7BEVONLZ/XeUWtMcrA9kOxr/uAFfNdAGLKkwhy9dA2ClcA1NDgWmgOS6ZJ6Oeb0chBm8gtQ0brk/DfzMkoTcJr+Rk7r7tpLd2uFwqLXni9l09PR/SkV2YEqWxkfXgJBek/l+bZ0bNInSoNd2C7EAQ8XBAIvAsSUG8bNG1JTnLa2JF/oC6an3JutpO4NUAeQ0n617tvQzhO1P9E34c4/jxKUNpXSr3g5dCzLyry3byq+n4WltZHlt5wRnJ6pJFDP/sS3o3ZffsM3yGqTDgztQ2vZJkmoQ4ymgbP+9aCIWpsrpvcMSIV9I/h5LHG5YcbGkT
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:15:08.6645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c56299f7-d80a-4675-0310-08dec7d49b6a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF00000199.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB8987
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,redhat.com,mojatatu.com,networkplumber.org,davemloft.net,google.com,lunn.ch,gmail.com,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	TAGGED_FROM(0.00)[bounces-298202-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:dsahern@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:kuba@kernel.org,m:stephen@networkplumber.org,m:davem@davemloft.net,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:donald.hunter@gmail.com,m:kuniyu@google.com,m:ij@kernel.org,m:ncardwell@google.com,m:koen.de_schepper@nokia-bell-labs.com,m:g.white@cablelabs.com,m:ingemar.s.johansson@ericsson.com,m:mirja.kuehlewind@ericsson.com,m:cheshire@apple.com,m:rs.ietf@gmx.at,m:Jason_Livingood@comcast.com,m:vidhi_goel@apple.com,m:olivier.tilmans@nokia.com,m:chia-yu.chang@nokia-bell-labs.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:dkim,nokia-bell-labs.com:email,nokia-bell-labs.com:mid,nokia-bell-labs.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nokia.com:email];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB62A6735F0

From: Ilpo Järvinen <ij@kernel.org>

Include echoed CE count into rate_sample. Replace local ecn_count
variable with it.

Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h    |  1 +
 net/ipv4/tcp_input.c | 41 +++++++++++++++++++----------------------
 2 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index f063eccbbba3..aa5d779b99d7 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1316,6 +1316,7 @@ struct rate_sample {
 	int  losses;		/* number of packets marked lost upon ACK */
 	u32  acked_sacked;	/* number of packets newly (S)ACKed upon ACK */
 	u32  prior_in_flight;	/* in flight before this ACK */
+	u32  ece_delta;		/* is this ACK echoing some received CE? */
 	u32  last_end_seq;	/* end_seq of most recently ACKed packet */
 	bool is_app_limited;	/* is sample from packet with bubble in pipe? */
 	bool is_retrans;	/* is sample from retransmission? */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index c79b07899fef..1f4937a769b7 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -588,9 +588,10 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	return safe_delta;
 }
 
-static u32 tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
-			      u32 delivered_pkts, u32 delivered_bytes,
-			      u64 prior_bytes_acked, int *flag)
+static void tcp_accecn_process(struct sock *sk, struct rate_sample *rs,
+			       const struct sk_buff *skb, u32 delivered_pkts,
+			       u32 delivered_bytes, u64 prior_bytes_acked,
+			       int *flag)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	u32 delta;
@@ -600,11 +601,11 @@ static u32 tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	if (delta > 0) {
 		tcp_count_delivered_ce(tp, delta);
 		*flag |= FLAG_ECE;
+		rs->ece_delta = delta;
 		/* Recalculate header predictor */
 		if (tp->pred_flags)
 			tcp_fast_path_on(tp);
 	}
-	return delta;
 }
 
 /* Buffer size and advertised window tuning.
@@ -4190,8 +4191,8 @@ static void tcp_xmit_recovery(struct sock *sk, int rexmit)
 }
 
 /* Returns the number of packets newly acked or sacked by the current ACK */
-static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered,
-			       u32 ecn_count, int flag)
+static u32 tcp_newly_delivered(struct sock *sk, struct rate_sample *rs,
+			       u32 prior_delivered, int flag)
 {
 	const struct net *net = sock_net(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -4202,8 +4203,8 @@ static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered,
 
 	if (flag & FLAG_ECE) {
 		if (tcp_ecn_mode_rfc3168(tp))
-			ecn_count = delivered;
-		NET_ADD_STATS(net, LINUX_MIB_TCPDELIVEREDCE, ecn_count);
+			rs->ece_delta = delivered;
+		NET_ADD_STATS(net, LINUX_MIB_TCPDELIVEREDCE, rs->ece_delta);
 	}
 
 	return delivered;
@@ -4258,7 +4259,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct tcp_sacktag_state sack_state;
-	struct rate_sample rs = { .prior_delivered = 0 };
+	struct rate_sample rs = { .prior_delivered = 0, .ece_delta = 0 };
 	u64 prior_bytes_acked = tp->bytes_acked;
 	u32 prior_snd_una = tp->snd_una;
 	bool is_sack_reneg = tp->is_sack_reneg;
@@ -4269,7 +4270,6 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	u32 delivered = tp->delivered;
 	u32 lost = tp->lost;
 	int rexmit = REXMIT_NONE; /* Flag to (re)transmit to recover losses */
-	u32 ecn_count = 0;	  /* Did we receive ECE/an AccECN ACE update? */
 	u32 prior_fack;
 
 	sack_state.first_sackt = 0;
@@ -4384,10 +4384,9 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	tcp_rack_update_reo_wnd(sk, &rs);
 
 	if (tcp_ecn_mode_accecn(tp))
-		ecn_count = tcp_accecn_process(sk, skb,
-					       tp->delivered - delivered,
-					       sack_state.delivered_bytes,
-					       prior_bytes_acked, &flag);
+		tcp_accecn_process(sk, &rs, skb, tp->delivered - delivered,
+				   sack_state.delivered_bytes,
+				   prior_bytes_acked, &flag);
 
 	tcp_in_ack_event(sk, flag);
 
@@ -4413,7 +4412,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	if ((flag & FLAG_FORWARD_PROGRESS) || !(flag & FLAG_NOT_DUP))
 		sk_dst_confirm(sk);
 
-	delivered = tcp_newly_delivered(sk, delivered, ecn_count, flag);
+	delivered = tcp_newly_delivered(sk, &rs, delivered, flag);
 
 	lost = tp->lost - lost;			/* freshly marked lost */
 	rs.is_ack_delayed = !!(flag & FLAG_ACK_MAYBE_DELAYED);
@@ -4424,17 +4423,15 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 
 no_queue:
 	if (tcp_ecn_mode_accecn(tp))
-		ecn_count = tcp_accecn_process(sk, skb,
-					       tp->delivered - delivered,
-					       sack_state.delivered_bytes,
-					       prior_bytes_acked, &flag);
-
+		tcp_accecn_process(sk, &rs, skb, tp->delivered - delivered,
+				   sack_state.delivered_bytes,
+				   prior_bytes_acked, &flag);
 	tcp_in_ack_event(sk, flag);
 	/* If data was DSACKed, see if we can undo a cwnd reduction. */
 	if (flag & FLAG_DSACKING_ACK) {
 		tcp_fastretrans_alert(sk, prior_snd_una, num_dupack, &flag,
 				      &rexmit);
-		tcp_newly_delivered(sk, delivered, ecn_count, flag);
+		tcp_newly_delivered(sk, &rs, delivered, flag);
 	}
 	/* If this ack opens up a zero window, clear backoff.  It was
 	 * being used to time the probes, and is probably far higher than
@@ -4455,7 +4452,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 						&sack_state);
 		tcp_fastretrans_alert(sk, prior_snd_una, num_dupack, &flag,
 				      &rexmit);
-		tcp_newly_delivered(sk, delivered, ecn_count, flag);
+		tcp_newly_delivered(sk, &rs, delivered, flag);
 		tcp_xmit_recovery(sk, rexmit);
 	}
 
-- 
2.34.1


