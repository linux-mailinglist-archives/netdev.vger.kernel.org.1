Return-Path: <netdev+bounces-251923-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELjjJgnscGk+awAAu9opvQ
	(envelope-from <netdev+bounces-251923-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:08:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E111F58F62
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E995A6AE1D4
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594404A13A5;
	Wed, 21 Jan 2026 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="qzFePLdo"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013052.outbound.protection.outlook.com [40.107.159.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE834963A2;
	Wed, 21 Jan 2026 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005960; cv=fail; b=m6fTyf8tHkWf4nnVZAlndKj7gzccWTAayysFt6tHCBUxvX4r8jzVL9kfQP5vQLDoj9hfZgIj74JEqChs715vmLn5hq4cuCy1kaQTJc48Fz7v+fWg0nE11ZIbY8qjXAP/nr9fr8Nv6xk2WPXVwR0eYiWMHhoUdpqE8VowRGn7sQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005960; c=relaxed/simple;
	bh=UZKusTYGKBNsR+p1cWCQuxj0agzXS47OlVX+Rl3Uh6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DAPrst2l38N+lblv86o4MVJ0KriqZqQzDL9K2yQqi1zQUMUt8yB+YJnAoD/thfLiVOVjASx7AOfPfKV3YUFLMv5Y1E6BpxWQ1ApTuFGkZlM4sSo1mChKa7ZCRBCTaRm6Y2XXy9CAjR4HBxKancp1KoBDHBwypSvWynTFYe/rpW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=qzFePLdo; arc=fail smtp.client-ip=40.107.159.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KgM4SOkBGcJ14Px28CJmzftVM+SQRnK9/CLjbLbKIIimZojHbk+RBR6eVlOFKcPeMIQgC3FzalK2dCy3oFJztG/TEEhpKMxSTIvWD7QF6xMT9fbcfvcXTbHsAZr15wBnPnwReKa0TgIQRG1nFYdaLpJx6jUN7TmKpZKYQPHmbQHd188H6o8ChhB2//VUfiRClKTWvYAYIlyfe3q1Wp/rh4/8Kax7+4qxWLh4AQyBvz1Cs2EESxBYr8K6Q3IsbkoqlndJaSfGm1O7Y29hVMJVF1bsIk6Lcor87EwfQXLWgOo4UVBtmB7U4Cd8g7s4pqYykGR/NTkbr97/t3yUMoJ5eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86eKZY8UsqJAg8PU+paZvLEf6RQnbBtPGl/dPqew/lM=;
 b=CgecOTIUU+wSD5Ox09aO+NtFJx+rE8dZ4rmNgPdqtBYJFSk7GlBiThO2ce9rCSpzAuPn7BFMmBpgRM3fhsU6GL5c2eytg/LxwJVs5bwFffxIxY8R5rVjWV1SfqZ+U0hDhxhT8x5PfRhg8A4QZG1ivZF9WniKt28CBiXQaw4Q0TGxZ3f00Q47G+X/8kcETReY4V4WI/xBkb8CItB2Cj02y8jYBpfhNrE70pZ16ZqpAigYd/EteiVHEdfh3+43lMSxRJ0H1dLuYd1B5QJWoVH5BR7eyuaYyG7VHJoK4TL54DrKsMEAbWexmAs7Jh3sDXDYanylwJsJL4ppT8pxocCXvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86eKZY8UsqJAg8PU+paZvLEf6RQnbBtPGl/dPqew/lM=;
 b=qzFePLdo25BucFsUIr9ymJFFMPz4eMA3bDN6IuweLjMtYdOXQCgUg5/9deEjKi5sQsOxCaVQSHsTlbnffdyLNl/PmICmP/nHuEqVrpg3zfZeOYd2jtUYXONCUcNu22Roa/oZ0EtS52ywb6EcJ3vBj3kclAtQL3IPiUceq+uy+TXoTF+/g9CD/YMuhpdDUbr827latKXmk+1/SXK5yFFqkR0ekhl96bKU1yV3rrZyFLB0kujq9r/33WSEEWwYyaIK/8/xCeRxmt0pAQOFulcJ646OPGzcF+eDtKh9vSAiALzxBPwhbNNP4BbZKO6oGblca2wI52mS1n2opJZ5yPTtaA==
Received: from CWLP265CA0416.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b6::11)
 by AS8PR07MB7510.eurprd07.prod.outlook.com (2603:10a6:20b:2ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 14:32:33 +0000
Received: from AM4PEPF00027A6A.eurprd04.prod.outlook.com
 (2603:10a6:400:1b6:cafe::67) by CWLP265CA0416.outlook.office365.com
 (2603:10a6:400:1b6::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 14:32:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM4PEPF00027A6A.mail.protection.outlook.com (10.167.16.88) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Wed, 21 Jan 2026 14:32:31 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id F3A1E2053E;
	Wed, 21 Jan 2026 16:32:29 +0200 (EET)
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
Subject: [PATCH v10 net-next 06/15] tcp: accecn: handle unexpected AccECN negotiation feedback
Date: Wed, 21 Jan 2026 15:32:06 +0100
Message-Id: <20260121143215.14717-7-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A6A:EE_|AS8PR07MB7510:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1ab336cb-82f7-40f4-0e07-08de58f9e93a
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?CJrZZSBuwZZhNFqQTJrz+q1ON+fTnn+cC3OZX2oGl7gtf3xNyDXuKuM/jbVm?=
 =?us-ascii?Q?uAwEpHnJ0LjyZtzVtQG3a90XjczgMb3OMVipHfbRD3azv9YHBVV9nWwn7jwU?=
 =?us-ascii?Q?A7TwQoW+nORXvnANP48mjfEsDdNPZVgy5HcsgyQwwYFxmGJYenitRpxUwhI8?=
 =?us-ascii?Q?5YBCQTde4Q5Cg5fxt246nDgWCaePj2ZGOfulcd3oG4U8GBSFfTp3EMuzRrco?=
 =?us-ascii?Q?VtKEDF7tVkkPbrqsFHLfDBXz++MMNluR4lII5JYBEnrHiRqV83vAwCZsdpxH?=
 =?us-ascii?Q?ho2UJ9ZZtU0oSSBKRoUbYQnZD5O4qV2DD6dHRIykkY5ykdbHI1X7cVvN2ur5?=
 =?us-ascii?Q?l4Jdgw4Gs6CbMNHD62sF/NJoi4DTdxje1vUlilgcUqm0//SodbGNlhswRxpz?=
 =?us-ascii?Q?3MinPWfE+Ik5VfHIgVxq3P5wwLT5Bz8MRYsW1MSp/sU1kKnwK9+mKusntoO1?=
 =?us-ascii?Q?JnBHFj3kRjFB6+KwuiJxlsOgQhsIk/n0LtqklFRyX0ykZBMKhtw4DKrgYShE?=
 =?us-ascii?Q?MX1IXPegMVABm810HUidruiWDC+lDfDUWFLKTIHtqddGr6ZGcC/2niPmjuEM?=
 =?us-ascii?Q?j9vmDN33Pugl98X9cGQ7V9UDLNK/G7058XbtRNKLoATBlVnjWR+mAlgRrkpm?=
 =?us-ascii?Q?VcUzrI3a+7ZxhSmS1fN8CNncXplpxhx8jVhBx5YvWO11TN9ObXz7OP7Af7Eu?=
 =?us-ascii?Q?GtjeBHyMsaG7tA60Ox9nosYlpDu9oz8+Aaa+bRQdpBxURdueU3Iord8e5KiK?=
 =?us-ascii?Q?G1tGbuaX2ASQHHh4goDYD+XgFBy7aJNJfxC03sFKnSFmdq9tdAns+pzXNjVV?=
 =?us-ascii?Q?kn2jCxxHHipARop5KcuWtB5iFIwBG/xoGq2/APBiXlAdDy11SXCKBP7aybKy?=
 =?us-ascii?Q?7YLIuTRiNS9zxGJxI+zj4vRLlwNJ/vI56J4KQBzeyZjJTd6FuYp2X2cvhPCx?=
 =?us-ascii?Q?vR0H2aEK0ZIp3Bci5uF8SlsJRJ04jz7rz2+DZaJV/i3YVcOLXI1/2IrtLIRn?=
 =?us-ascii?Q?D6/ry8WXnT8yyPuQb8Ee3gvXHlVktbU9dWzC38PaS5qVQqFSm9zHRxqXX7Os?=
 =?us-ascii?Q?46KciSLNEGwGun2gkjQ1FTtwode45405ILeOlnGyqDVjOSkH5M0OYnJQomiA?=
 =?us-ascii?Q?Xf9Jn3p0Ba8nmEj/ejaiamYZETAjNP1uBmTuAhsaIjPedBTv3uZ9KSmORQe6?=
 =?us-ascii?Q?wAThY5lkRqzzr55ZNlPF+hoVPZ5h1w93dtK9165xaN0+W23Zv8EItRkGp+zZ?=
 =?us-ascii?Q?WHbqrpHurL5JeM+gez4oG3FoJE43Ook3M2udgknQ5r1ShCtSOY9MZ2G80XM5?=
 =?us-ascii?Q?wGCmhdw2CRJpaIby1ERUPd+jwge6W13TRd8JteQwkdNxQQnHyLJpiyzUjt5z?=
 =?us-ascii?Q?FWIlIniGk6nzgLxpoDs6WsEKjZOxCPDiuItE8nmIv+r4fhpYkrvEDEoQMp5V?=
 =?us-ascii?Q?lAuiL4tfr0ps/LzAojKUR9qzhoIxSPY3dMsiBjKwiT8TB0C8lQP8DXUGDQk9?=
 =?us-ascii?Q?84Drbu6U4v1JBS7/Jq9DlPQfNbrR451lH6smCtodPLntkVr84FoeHZFLriqz?=
 =?us-ascii?Q?coND0n2iX/smoPnoGMXbVmeHxpcA5LB8OODkXP/vuaByPGPFdRET/vSweNS7?=
 =?us-ascii?Q?pMfvCH9vN+O+XlUFuLg2luvLf1QgdA+Mdv/XYs0twDNDJT4F31HFWue50n37?=
 =?us-ascii?Q?t5Bb7cXZvVHfUhzWGrfxyQvhASU=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 14:32:31.5240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab336cb-82f7-40f4-0e07-08de58f9e93a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00027A6A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7510
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
	TAGGED_FROM(0.00)[bounces-251923-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[nokia-bell-labs.com,reject];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E111F58F62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

According to Sections 3.1.2 and 3.1.3 of AccECN spec (RFC9768).

In Section 3.1.2, it says an AccECN implementation has no need to
recognize or support the Server response labelled 'Nonce' or ECN-nonce
feedback more generally, as RFC 3540 has been reclassified as Historic.
AccECN is compatible with alternative ECN feedback integrity approaches
to the nonce. The SYN/ACK labelled 'Nonce' with (AE,CWR,ECE) = (1,0,1)
is reserved for future use. A TCP Client (A) that receives such a SYN/ACK
follows the procedure for forward compatibility given in Section 3.1.3.

Then in Section 3.1.3, it says if a TCP Client has sent a SYN requesting
AccECN feedback with (AE,CWR,ECE) = (1,1,1) then receives a SYN/ACK with
the currently reserved combination (AE,CWR,ECE) = (1,0,1) but it does not
have logic specific to such a combination, the Client MUST enable AccECN
mode as if the SYN/ACK onfirmed that the Server supported AccECN and as
if it fed back that the IP-ECN field on the SYN had arrived unchanged.

Fixes: 3cae34274c79 ("tcp: accecn: AccECN negotiation").
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v10:
- Update commie message with full texts from RFC.

v5:
- Add "Fixes" tag.

v3:
- Update commit message to fix old AccECN commits.
---
 include/net/tcp_ecn.h | 44 ++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 2e1637edf1d3..a709fb1756eb 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -473,6 +473,26 @@ static inline u8 tcp_accecn_option_init(const struct sk_buff *skb,
 	return TCP_ACCECN_OPT_COUNTER_SEEN;
 }
 
+static inline void tcp_ecn_rcv_synack_accecn(struct sock *sk,
+					     const struct sk_buff *skb, u8 dsf)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
+	tp->syn_ect_rcv = dsf & INET_ECN_MASK;
+	/* Demand Accurate ECN option in response to the SYN on the SYN/ACK
+	 * and the TCP server will try to send one more packet with an AccECN
+	 * Option at a later point during the connection.
+	 */
+	if (tp->rx_opt.accecn &&
+	    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+		u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
+
+		tcp_accecn_saw_opt_fail_recv(tp, saw_opt);
+		tp->accecn_opt_demand = 2;
+	}
+}
+
 /* See Table 2 of the AccECN draft */
 static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb,
 				      const struct tcphdr *th, u8 ip_dsfield)
@@ -495,13 +515,11 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 		break;
 	case 0x1:
-	case 0x5:
 		/* +========+========+============+=============+
 		 * | A      | B      |  SYN/ACK   |  Feedback   |
 		 * |        |        |    B->A    |  Mode of A  |
 		 * |        |        | AE CWR ECE |             |
 		 * +========+========+============+=============+
-		 * | AccECN | Nonce  | 1   0   1  | (Reserved)  |
 		 * | AccECN | ECN    | 0   0   1  | Classic ECN |
 		 * | Nonce  | AccECN | 0   0   1  | Classic ECN |
 		 * | ECN    | AccECN | 0   0   1  | Classic ECN |
@@ -509,20 +527,20 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 		 */
 		if (tcp_ca_no_fallback_rfc3168(sk))
 			tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
-		else if (tcp_ecn_mode_pending(tp))
-			/* Downgrade from AccECN, or requested initially */
+		else
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 		break;
-	default:
-		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
-		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
-		if (tp->rx_opt.accecn &&
-		    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
-			u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
-
-			tcp_accecn_saw_opt_fail_recv(tp, saw_opt);
-			tp->accecn_opt_demand = 2;
+	case 0x5:
+		if (tcp_ecn_mode_pending(tp)) {
+			tcp_ecn_rcv_synack_accecn(sk, skb, ip_dsfield);
+			if (INET_ECN_is_ce(ip_dsfield)) {
+				tp->received_ce++;
+				tp->received_ce_pending++;
+			}
 		}
+		break;
+	default:
+		tcp_ecn_rcv_synack_accecn(sk, skb, ip_dsfield);
 		if (INET_ECN_is_ce(ip_dsfield) &&
 		    tcp_accecn_validate_syn_feedback(sk, ace,
 						     tp->syn_ect_snt)) {
-- 
2.34.1


