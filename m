Return-Path: <netdev+bounces-298201-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CG+RCznfKmoeygMAu9opvQ
	(envelope-from <netdev+bounces-298201-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:15:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DD66735E3
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:15:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nokia-bell-labs.com header.s=selector1 header.b=axaAwMd8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298201-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298201-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nokia-bell-labs.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 715F930F1843
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DAC426685;
	Thu, 11 Jun 2026 16:15:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013071.outbound.protection.outlook.com [40.107.162.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5928C2848BE;
	Thu, 11 Jun 2026 16:15:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194518; cv=fail; b=S5cTtgqoVR9XtHIczuHO8GFW8aVANAXA5ztnElqZ05RMAPc5yV4BK2/SSIb+75EoPAEr9VApP3ct7j2Jf83Jb7DFJ9N6ZhzKo6kx6hIl4EKICHK7Q+ZuQqgylDHxHnzAhkWNf0JW19rSZllpdyv6zYZem8iQHYJJsG2pNBX+pnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194518; c=relaxed/simple;
	bh=WWmkv5sZkTamHzR2bv5H2jMrbdu+i4T92xNj4ydnWiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WR7RMrBbxe5A2kEdE804gAeN5EUdM44hc6VuZdp7B8bx+DiL8YwUM7RnzBnYJlh0TToDu/gbDCwBF7NhJAjcZj0bgXwPkB+iaVZ8z5BpNzmdfgBGkuBfZQwkIX0x9/2iEfTeFpbRTWoJGa6sflkL7wjR9tgnRDACEv2QKgPH1w0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=axaAwMd8; arc=fail smtp.client-ip=40.107.162.71
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZL5Ml5j2hqI4PlsOFalzjslj+U0na3jtNxntGVQO6MQ9N10nQSCQhKigI4WuvKbUSSepkfy0w1hqa8n/BvSb7fsk+9K84zIJwdEHPxIoUuJFDZqweQJ6QN6w+N/ksc4NSdqPY92VQyZM9rKQzbjiefzc5UmYJiyK5p9sGueMlcFBDaJa1w9YLuV0W4mldZrhRrQn7nTqbfB6lq/ArhhCwhfE4yva2tXBIZN6O9YhLgtJr9lTuYPYCKSYmK4wSsxVzQIbSvVbrrSK3AitcxkR9qIB7gVpITT23noJpoj+GLefTor8HjtFtbPwM38XU4vz6a1VR+KHZW9pyTNWsZr92w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIPZPXyidQEK00B3WmUO7F8i5P7I8muLaYe8N04vw+U=;
 b=tnF9Rje8D/jvFHsTB5TSJSC8L7B7iupp5bt/RB58LKXHbj+HLCYsf0Zv+u/OO1BbUEorFzotDOAF/E6wjFh8FK5SCtLDuApw3f6e7dibkHTmfKsD1RJuz5rfNc7R+kPgnQDIGYUCc2RPqS3r4iZs8KIIu0aQO4YJxls0eEZC1V7yNq5YUnrxT/zkQZQvE5EYUQ4OuW/w6d0XovtqT2dGPlyqtM7zTL04Hz89ajDfkQyXUZSvpTao+G/8w6DqepeSCc4vl7v0Qj6LkoEifD4mH+zYnlVRDCsm9ZhkWI6CyC9b/HSlfk0oqA1cK7Zz8lXilpO3FSxc1PFvO4yw+WJxKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIPZPXyidQEK00B3WmUO7F8i5P7I8muLaYe8N04vw+U=;
 b=axaAwMd8msxi2Lu9LlM/xoWJED1y96DU/j6bQ8FE3iwBKBEMHdFazqa86qZr8YaeAmETbpalczd+dVDVPU3Y5kN2bjfH1Eki6n+y/IABluihwflOTteTNOedbwSDUPTMAVfpO/TJ8KhgVBrJkZVYAiahzwALm/KdOsWTHaX2S/9i8aKkDzHUDkn2cL5hJLwD7UHfEjJW5qgTJ2OUnPL4rzK3pd+W6JprcTVzxOc8sN/Zjzdg+dUmnRgq0Xo5uO1uEeXK77Hi4gJ4LYiOWumk1RyQf610zd6V10vtkxkTrQtDItxGaAigTBOyiRmJ/wcAg3I8bdgWtDC1U8yuJA4O6A==
Received: from DUZPR01CA0349.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::14) by PA4PR07MB7600.eurprd07.prod.outlook.com
 (2603:10a6:102:c5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 16:15:11 +0000
Received: from DU2PEPF00028CFE.eurprd03.prod.outlook.com
 (2603:10a6:10:4b8:cafe::7e) by DUZPR01CA0349.outlook.office365.com
 (2603:10a6:10:4b8::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Thu,
 11 Jun 2026 16:15:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DU2PEPF00028CFE.mail.protection.outlook.com (10.167.242.182) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7
 via Frontend Transport; Thu, 11 Jun 2026 16:15:11 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 68DA868003E;
	Thu, 11 Jun 2026 19:15:10 +0300 (EEST)
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
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v1 net-next 3/4] tcp: Add tso_segs() CC callback for TCP Prague
Date: Thu, 11 Jun 2026 18:15:03 +0200
Message-Id: <20260611161504.228319-4-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFE:EE_|PA4PR07MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: d9bd5d93-822d-46b9-86eb-08dec7d49d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|376014|7416014|36860700016|18002099003|22082099003|921020|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	HqjRsHWo3cAh1neXdnNvqAu2DJGH16NVByLzvL+OVYfXsLPXa4ut8yFw3QlNwzr8Sl3k7USIlp66Kcno9aVuk4dlwkYV2WobsTfpcEZqgpUsQXI0BIw0ZQsGjoH2XNMq4VwJUUCFDUYlatLMkT1DSboIv0czfpLhiAeQ/GTO2vmdSY1Vs7bYQXi89AbIuTHJogc10C1q/+2yckP3BczMQ561oT2/q4NjJIQ7Yh23pmeA1P7/00bI/vb2yo330aFW0RtvpF+latimIS34TOGiRVpcbMHnX+F/oUXlJHlcZXRdCRDvP11VscrBpmy6cYIergEv7rdjsUECUEfgVa5UwzbK9OiEeqi5AuhHw5l/915lsAyLn8nZ/EdtY+n/lzqcUaUvd89PqyDI72vK3n+vmh76j1y74q4Pmgl9Ht0M14tKqAokjt2YONVd3dnCpDukOvn7tklVQ5NKIDCqsgeobPojfdsqFEkcbaDUmEskcDtTwYfTRYoxE+c+rGqUUmmDaSjF1v4emANfZxM2FrBNid/Av96WvPKq4OCMtuCND/q0mf3LNiZ5bYin+dYvJ6o20sFbKdis6DXM+nBeC3Rp+a6ZPB+aj98cHQ1Tl6GRgQFke0BiyD+6i/3KOmzQsEAGjvpik5FFj1JReZml0qoBTi/TwXu+dUDUQS4tSw6E4M3JddGPVsySkf8YtxhUEo7e1dByGjdYI5jJFX2if3IdPXJELfWW1hamwU1dtwTFNy335OGqQBDJDhiuJo3CAtBYTGJ0e4drje8MKnj+ZjgGNw==
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(7416014)(36860700016)(18002099003)(22082099003)(921020)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CrJ0lQf9rtYzWmlgg0ZKonZTfR81bylm/zUnl9qFlr4AHV6BWek/UWmXmw9aYizfjvOtGBfvNYm9l/KZs6s8mwCeKBATkRq/aQyxcYXc21JnvNyyo/HylHV67LzJhzDL58Whu3/a0xOJHOcVyx6IvEvJY+Ev+zkgotpcBoaWN1uQLipi/TM5/1homxQ+Ou0RxexmnZF3dYhz7AtZQjiXuHWsngHQtawMqIo4RaIVzopdgn5fqXZA0kL2fPctR2duzyRGmVXyKR4brLorwGgaAxokXbrZdjBiXSQlM3sJ/CX3EHzd9GAsdIOY27Cs12p0wICFLOKgqz3oZUNf76AinoD8nfjwRCzJ7fRs3IjY70IQNlX2PJDlLoteDJuBSwm4uc/9dGSg15DbYRPVzJwe+QMjPmtIS2KSr/khoNBJcTEVRUjcfGzyCS9i8bDZW45b
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:15:11.6645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9bd5d93-822d-46b9-86eb-08dec7d49d35
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028CFE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7600
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,redhat.com,mojatatu.com,networkplumber.org,davemloft.net,google.com,lunn.ch,gmail.com,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	TAGGED_FROM(0.00)[bounces-298201-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:dsahern@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:kuba@kernel.org,m:stephen@networkplumber.org,m:davem@davemloft.net,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:donald.hunter@gmail.com,m:kuniyu@google.com,m:ij@kernel.org,m:ncardwell@google.com,m:koen.de_schepper@nokia-bell-labs.com,m:g.white@cablelabs.com,m:ingemar.s.johansson@ericsson.com,m:mirja.kuehlewind@ericsson.com,m:cheshire@apple.com,m:rs.ietf@gmx.at,m:Jason_Livingood@comcast.com,m:vidhi_goel@apple.com,m:chia-yu.chang@nokia-bell-labs.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nokia-bell-labs.com:dkim,nokia-bell-labs.com:email,nokia-bell-labs.com:mid,nokia-bell-labs.com:from_mime];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C6DD66735E3

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

This patch adds tso_segs() CC callbak for CC algorithm to provides
explicit tso segment number of each data burst and overrides
tcp_tso_autosize().

No functional change.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h     | 3 +++
 net/ipv4/tcp_output.c | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index e8090f542f7c..3b415c9dcc54 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1366,6 +1366,9 @@ struct tcp_congestion_ops {
 	/* override sysctl_tcp_min_tso_segs (optional) */
 	u32 (*min_tso_segs)(struct sock *sk);
 
+	/* override tcp_tso_autosize */
+	u32 (*tso_segs)(struct sock *sk, u32 mss_now);
+
 	/* new value of cwnd after loss (required) */
 	u32  (*undo_cwnd)(struct sock *sk);
 	/* returns the multiplier used in tcp_sndbuf_expand (optional) */
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index fe725d94a225..a7206fa61957 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2274,7 +2274,9 @@ static u32 tcp_tso_segs(struct sock *sk, unsigned int mss_now)
 			ca_ops->min_tso_segs(sk) :
 			READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_min_tso_segs);
 
-	tso_segs = tcp_tso_autosize(sk, mss_now, min_tso);
+	tso_segs = ca_ops->tso_segs ?
+			ca_ops->tso_segs(sk, mss_now) :
+			tcp_tso_autosize(sk, mss_now, min_tso);
 	return min_t(u32, tso_segs, sk->sk_gso_max_segs);
 }
 
-- 
2.34.1


