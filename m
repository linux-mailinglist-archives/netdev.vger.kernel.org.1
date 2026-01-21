Return-Path: <netdev+bounces-251926-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJ8PCsTtcGk+awAAu9opvQ
	(envelope-from <netdev+bounces-251926-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:16:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8886A59077
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D01BA8A40A
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8CC4A2E30;
	Wed, 21 Jan 2026 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="M+DIILPG"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010033.outbound.protection.outlook.com [52.101.69.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334AC4A2E1C;
	Wed, 21 Jan 2026 14:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005967; cv=fail; b=uwEVDH11ptsXyxwCXwkRYP1H+iof49vDyOYFbp6sAhHpu3tRf+DkOM0nMoGY2+6/vDV7VV7OerqWi1dAyACbOVuDwdfO576ct6OMuObC7PMZGZS5yfaMqqnniTp2Qz+q+ZAu7qcjpoEwL+9UmlDFzu4B0xbvAvoOveEuoS7s0+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005967; c=relaxed/simple;
	bh=GoRRxO9KuRpNVIKIZ8cVgifwgkM+TOvHwvQLjLaVkGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ADktM7fM5uKZaflPvhqkeMIAM4RPxU4pLMgyt/6HMHt/2UecUrfaLN1pL6Z9DakEnW2k6Uz7+hwmOVfL1nT5JQcriWPjN6bFyKacsEWt6b9EnmwG39wa28q15Xwk4v5ITQ2Wym3gqorNVWEUSaLnHv3bTq0avEKByYEMxKQm+4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=M+DIILPG; arc=fail smtp.client-ip=52.101.69.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUFK7/Ik+doN3KxOzBDMpyumQvJkYStkXylo4HppNnJlFd4shp//vO2B3E+uDwh0iPgg3JnIYyXeZp3VnDL2tw2cXfBdlprerFg7r3YUlSS7tQEbgp4n50mAIbdL9BeHiheorcLu+g+PzQwkridbzGsCiC6RyqLYxOzJ9Dsi+qYZr8QSnyq7rHAhN9ZnT0Z+J6BqoOolghZteiAC+QlXNwT4XklinqnhWXCf+4hap8/iEmaUVa0aFzhfEPP7pg0dNmcFgM5psWkxrlOv7JU6CVHFUDd+FkIAWYgJfYqqvdW3vTmTSOc6cbUhfe0criY10pBmy+OfEX5HHijQCv6zEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DOxTOvaQqL1rTyXbUDNUcwwFKyo1wrSXcqK6adeLYo=;
 b=K6BN/tCwVRKvaHU9u7RvXUqAmB3S3t+sYr2HPp7GLUNTKz6an81WkRRECxqi8uY4NTP5BGFD0YTvGp5YUoRwgz8TPLISH8BkLSVJStDD5NVu7LtbiIQ5WEtstFAgsp5JacSAQgHt6opoWl8elH3kjTVQryTrzeuAJnWNzqtGk6vVlJzEoQc7ScGbH9W/OdSv8ku61JW3HE3eSfuwC9Qr7dprnXdnbIZdIaCEFv+8n+mp9omQ6KkN9xlyk4MwX8ak8dFaG/xemaxkJmp3yoiUS1fX3uekW0MGRUYOlew9idwuLH+zUET4ArOdPC+1ag82Nt0OjHJnrqtDFe8DiiuPDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DOxTOvaQqL1rTyXbUDNUcwwFKyo1wrSXcqK6adeLYo=;
 b=M+DIILPGJVvdHL5DT/iIfhC1oxGb+NDrEleF3ktqcUiMff7hmrmOdmNjyd/YtFY0OT2sugFL5AvoLKHejU544sRxtUMXjOopABec46ykwzrn+w4+dFbpVWK0AFxOPRauKkmW9QbhSZU2UFd1e8nEJcRhRkKnt1QxvIKjFQR3Rvfhg3s5rCUYce75/ZnQ3manBkXofxpXKnaFibCx87hiKeTO8/urezsfwIFvrhFey1qrPqjqjfrTRrBJyAvDheVj87JkWgO5x+4k2dj+wpQFa3aGykg2M36dzMvo2W6DYu4TJaKDcDg2GDdSz7YfVQgFKhDYw5wy9sJo/6gGLOOONg==
Received: from DB9PR05CA0021.eurprd05.prod.outlook.com (2603:10a6:10:1da::26)
 by AS8PR07MB9157.eurprd07.prod.outlook.com (2603:10a6:20b:569::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 14:32:39 +0000
Received: from DB5PEPF00014B8F.eurprd02.prod.outlook.com
 (2603:10a6:10:1da:cafe::27) by DB9PR05CA0021.outlook.office365.com
 (2603:10a6:10:1da::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 14:32:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB5PEPF00014B8F.mail.protection.outlook.com (10.167.8.203) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Wed, 21 Jan 2026 14:32:39 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id A46A020545;
	Wed, 21 Jan 2026 16:32:37 +0200 (EET)
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
Subject: [PATCH v10 net-next 10/15] tcp: accecn: unset ECT if receive or send ACE=0 in AccECN negotiaion
Date: Wed, 21 Jan 2026 15:32:10 +0100
Message-Id: <20260121143215.14717-11-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8F:EE_|AS8PR07MB9157:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1fa384de-347b-41b2-6166-08de58f9eddd
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?WQ4VGPMWXpB5Sle3FcUFcYsCuxVA4iNY7XCzYYCYKobcrmv3scGPQhEc+kXi?=
 =?us-ascii?Q?w7KF2FMCe37xyglXUvm9VJzvCaXQ0qks27mlskgPFx0aXCXZ+1qcf92Nboxq?=
 =?us-ascii?Q?eTFkTzQyeWenCUYPx1zP8lo4c9ikUFQM+2a+kzt1rHXntMQ/g8SGTJbvGz4N?=
 =?us-ascii?Q?jxLQX0PbCOoityTTOTteyTksiifC/dSh4aNXOOqYrfuZXuu5W+9e6UJiwekH?=
 =?us-ascii?Q?hNH95UcFlETbDn+7KDjLk5qVVJ9FevAdvYhZLsvicaAYh4ZjCiAc5vQvLFmS?=
 =?us-ascii?Q?Tm7U6Mhp1gPlaPWiH8xTCZ56gMXk+Xmn9t/+IryBeSd52eC65eS51HOsAh9o?=
 =?us-ascii?Q?yoSQNOYyVq0LmHPvXPpc9xm/LqBpqZv06LFEC+QN1dnBTf4QkOVTavdsg3x7?=
 =?us-ascii?Q?zVoS1oAJIj6/Co/qQJwaTsNqzmFbyt40L6+XbpcL/J4FJMIi4liOBXSxY+8P?=
 =?us-ascii?Q?tAUw1zV9EwPOB2z2E/naAM8RTmfuEUnpWRQfkxw/cmVLWsD9i8ZLFIOlQmqN?=
 =?us-ascii?Q?7cMge5UDBzhG58hwmB+HBEJHTBTdIjUmn42z4WvEqS99+xDGC/uAVXL/ABQS?=
 =?us-ascii?Q?aOHkuOeDgpTCrnzj9+Uls/0HOhBS+DRnQEO4+HEQkYuSz/D1iW5pFxcpv9U2?=
 =?us-ascii?Q?AWiahBLH5oAiT99zjh2ty/XJ7IY4URmx9aUFHz4xHaHrX+dP0pTb0yhnfjhC?=
 =?us-ascii?Q?VPnSjkB3YtTkPlZgZdJAJiVMWpMp7j96HUuDFwveLB3j9IYh1nccIWBVsq5P?=
 =?us-ascii?Q?tANg0ddfo9OXsFvLuFaaiznHMeC3vH9WL/QJn5wq8GmVFZfLtGSSCsfJ96xy?=
 =?us-ascii?Q?OZD9BkFLWSOcuAu5IFH2xk3oKR4TENESX/Jlw5ypCrV2X91axtOToXopATi9?=
 =?us-ascii?Q?121KOnpvHsk1BSYwTMkCDuKhTXbzARcbrKvlEWwilsDfVBe8gQBwCVJ4pd5T?=
 =?us-ascii?Q?eODe+mezEx7Ya/J94GURPGKC8OJq3lz1X+2VeWxY+Sm7bH6Y+M+EONcntlM3?=
 =?us-ascii?Q?qKJMgFfSLKRdkw4gnVCZlXowdRT3mmfYyOVD9MW8iFYgXO/p0jy6dBuuJp0y?=
 =?us-ascii?Q?Pe8bwnQFEZ6Gms80B5RhrEODBgB7uK6nMlZYGNOwG59LISuyJncTvAXRSfov?=
 =?us-ascii?Q?gjRTE26GEYFzh/dAaqhO87i0K/ouMzVpn1aUsBU00EyKcEr+8xENgQT9XvY6?=
 =?us-ascii?Q?4yJ3D63aHglWlNp1/p53gbwh8rtBI8/ZAR7tSo5HnpUnChDYOZaDmMcd4skQ?=
 =?us-ascii?Q?Klfp5ddtLlNAYKsLmC3xpexS5+aJzaNP2QjzSbvbNkFWZYcXE+AHdnkeJ9Wk?=
 =?us-ascii?Q?k+kgPSpbP9v5lOofwnTF7WNAsGV1GBH+J0Ti82W46OMoyQFO6A9fNkeB1/XU?=
 =?us-ascii?Q?S/g1Ib/fEoRJPTKFSrnBZDMcDtVLn50aQizZzo/a9ZUCG4yLf6lUbzgGIllj?=
 =?us-ascii?Q?WAcZFui64qwcdujpLuDVL1qcFEvP/f2sK0k+jD+MKHLzfh3sZeqBTmiK5YvN?=
 =?us-ascii?Q?Rvd2vIJLfmmqa1mUlRp341KmO5zpTN/zR2E4hXzSABkkucJW64YureDiyKxS?=
 =?us-ascii?Q?xO5kXMpaXZS1qQsk+qzGR+H5G96ZAmNipbBFP5Z6Mt7Twk0U+6LBJekIxD7s?=
 =?us-ascii?Q?qZOTHwuj/FPUmV1aMcVHuRlb/RAmIKldHseTHD88X4RvoYkqChOK/pNyV8e5?=
 =?us-ascii?Q?VhD2VX9Jzk7mVVxcE0BXRW2EyfI=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 14:32:39.1879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa384de-347b-41b2-6166-08de58f9eddd
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B8F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9157
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
	TAGGED_FROM(0.00)[bounces-251926-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[nokia-bell-labs.com,reject];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,ietf.org:url];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8886A59077
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Based on specification:
  https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt

Based on Section 3.1.5 of AccECN spec (RFC9768), a TCP Server in
AccECN mode MUST NOT set ECT on any packet for the rest of the connection,
if it has received or sent at least one valid SYN or Acceptable SYN/ACK
with (AE,CWR,ECE) = (0,0,0) during the handshake.

In addition, a host in AccECN mode that is feeding back the IP-ECN
field on a SYN or SYN/ACK MUST feed back the IP-ECN field on the
latest valid SYN or acceptable SYN/ACK to arrive.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v10:
- Set AccECN error flag on request itself via tcp_rsk() to avoid
  changing directly on the listener

v8:
- Add new helper function tcp_accecn_ace_fail_send_set_retrans()

v6:
- Do not cast const struct request_sock into struct request_sock
- Set tcp_accecn_fail_mode after calling tcp_rtx_synack().
---
 include/net/tcp_ecn.h           |  7 ++++++
 net/ipv4/inet_connection_sock.c |  3 +++
 net/ipv4/tcp_input.c            |  2 ++
 net/ipv4/tcp_minisocks.c        | 38 ++++++++++++++++++++++++---------
 net/ipv4/tcp_output.c           |  3 ++-
 net/ipv4/tcp_timer.c            |  2 ++
 6 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 796c613b5ef3..f5e1f6b1bec3 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -97,6 +97,13 @@ static inline void tcp_accecn_fail_mode_set(struct tcp_sock *tp, u8 mode)
 	tp->accecn_fail_mode |= mode;
 }
 
+static inline void tcp_accecn_ace_fail_send_set_retrans(struct request_sock *req,
+							struct tcp_sock *tp)
+{
+	if (req->num_retrans > 1 && tcp_rsk(req)->accecn_ok)
+		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_SEND);
+}
+
 #define TCP_ACCECN_OPT_NOT_SEEN		0x0
 #define TCP_ACCECN_OPT_EMPTY_SEEN	0x1
 #define TCP_ACCECN_OPT_COUNTER_SEEN	0x2
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 97d57c52b9ad..8fda50b78c86 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -20,6 +20,7 @@
 #include <net/tcp_states.h>
 #include <net/xfrm.h>
 #include <net/tcp.h>
+#include <net/tcp_ecn.h>
 #include <net/sock_reuseport.h>
 #include <net/addrconf.h>
 
@@ -1103,6 +1104,8 @@ static void reqsk_timer_handler(struct timer_list *t)
 	    (!resend ||
 	     !tcp_rtx_synack(sk_listener, req) ||
 	     inet_rsk(req)->acked)) {
+		if (req->num_retrans > 1 && tcp_rsk(req)->accecn_ok)
+			tcp_rsk(req)->accecn_fail_mode |= TCP_ACCECN_ACE_FAIL_SEND;
 		if (req->num_timeout++ == 0)
 			atomic_dec(&queue->young);
 		mod_timer(&req->rsk_timer, jiffies + tcp_reqsk_timeout(req));
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 6382938921ef..8b774019a3a6 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6284,6 +6284,8 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	if (th->syn) {
 		if (tcp_ecn_mode_accecn(tp)) {
 			accecn_reflector = true;
+			tp->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
+					  INET_ECN_MASK;
 			if (tp->rx_opt.accecn &&
 			    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
 				u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 9776c921d1bb..1c66c3a67836 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -481,6 +481,8 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
 		tp->saw_accecn_opt = treq->saw_accecn_opt;
+		if (treq->accecn_fail_mode & TCP_ACCECN_ACE_FAIL_SEND)
+			tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_SEND);
 		tp->prev_ecnfield = treq->syn_ect_rcv;
 		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters_payload(sk, skb);
@@ -749,16 +751,32 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 		 */
 		if (!tcp_oow_rate_limited(sock_net(sk), skb,
 					  LINUX_MIB_TCPACKSKIPPEDSYNRECV,
-					  &tcp_rsk(req)->last_oow_ack_time) &&
-
-		    !tcp_rtx_synack(sk, req)) {
-			unsigned long expires = jiffies;
-
-			expires += tcp_reqsk_timeout(req);
-			if (!fastopen)
-				mod_timer_pending(&req->rsk_timer, expires);
-			else
-				req->rsk_timer.expires = expires;
+					  &tcp_rsk(req)->last_oow_ack_time)) {
+			if (tcp_rsk(req)->accecn_ok) {
+				u8 ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
+					     INET_ECN_MASK;
+
+				tcp_rsk(req)->syn_ect_rcv = ect_rcv;
+				if (tcp_accecn_ace(tcp_hdr(skb)) == 0x0) {
+					u8 fail_mode = TCP_ACCECN_ACE_FAIL_RECV;
+
+					tcp_accecn_fail_mode_set(tcp_sk(sk),
+								 fail_mode);
+				}
+			}
+			if (!tcp_rtx_synack(sk, req)) {
+				unsigned long expires = jiffies;
+
+				tcp_accecn_ace_fail_send_set_retrans(req,
+								     tcp_sk(sk));
+
+				expires += tcp_reqsk_timeout(req);
+				if (!fastopen)
+					mod_timer_pending(&req->rsk_timer,
+							  expires);
+				else
+					req->rsk_timer.expires = expires;
+			}
 		}
 		return NULL;
 	}
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 8536ad08a668..042e7e9b13cc 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -334,7 +334,8 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 		return;
 
 	if (tcp_ecn_mode_accecn(tp)) {
-		if (!tcp_accecn_ace_fail_recv(tp))
+		if (!tcp_accecn_ace_fail_recv(tp) &&
+		    !tcp_accecn_ace_fail_send(tp))
 			INET_ECN_xmit(sk);
 		tcp_accecn_set_ace(tp, skb, th);
 		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 160080c9021d..a07ec1e883f1 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/gfp.h>
 #include <net/tcp.h>
+#include <net/tcp_ecn.h>
 #include <net/rstreason.h>
 
 static u32 tcp_clamp_rto_to_user_timeout(const struct sock *sk)
@@ -479,6 +480,7 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 	 * it's not good to give up too easily.
 	 */
 	tcp_rtx_synack(sk, req);
+	tcp_accecn_ace_fail_send_set_retrans(req, tcp_sk(sk));
 	req->num_timeout++;
 	tcp_update_rto_stats(sk);
 	if (!tp->retrans_stamp)
-- 
2.34.1


