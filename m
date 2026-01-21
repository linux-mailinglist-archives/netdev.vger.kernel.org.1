Return-Path: <netdev+bounces-251922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8K1hHrnucGk+awAAu9opvQ
	(envelope-from <netdev+bounces-251922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:20:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA2D59153
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1877660C8A0
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EB5496914;
	Wed, 21 Jan 2026 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="H77yGe3r"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011030.outbound.protection.outlook.com [52.101.65.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEE64968FE;
	Wed, 21 Jan 2026 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005959; cv=fail; b=OhsGnfsw+DHH92EfBZR1ilZM8Aon8Q+JxOoZPs7x1W5snMZze6N/ffwgDEIt7gyoFfHpqp316DaLGin4Qg0Q+46zqAM7Wf7BGZjFRZz74bnYiw3EiMFpiMjDYDB14mrqpEeI/WYwbK/O0JZ8/TVqJCEp3yDjdSWR1EUJLUzOedk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005959; c=relaxed/simple;
	bh=+auiPovcMDl4S5mwHcVKCJFJy7tYD8JG2gFJo/6wsQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n6MstQAhFmpah2+HQ4EeLo/FJu3xwL5EUwneSgP7PDUJx5y6zPEi9PXMh1itqCkOrao5Zhsc6SaEd7J1AER9bTjKJCzDLeVIRGZeDJPEiO+jIesQpIFQCQ/LmDIcmMhpa15l0fU9HZ7bcvOVrNLgAEILaGBaZEX6JDI5QXdaz28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=H77yGe3r; arc=fail smtp.client-ip=52.101.65.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZmxJy+VTyjZmWgKAtblXKc44hbBgs+XAlMhG+DS/tgxsX8fdLg4CUc/X06GdVjX/zL+jBUg0TnuKxf6RLXO44Q+B1Y9oAVlHlI+3PCd3EBqvUoWgbZ44H2CZrIbS2WUunWU6tMKHfYeBME3XCNCt5FopDty6LgIlNiwjS8JFJHenXWA9DXdvV/kyJ1MdNeBw4OaNZQqJ5iemCBF8JMTzOvv+KpTkGL5ndhy3vGTisEorZwq9xkohkEiV4FN+SOiVAbBtwKt+c6VTLPmEdaH9APdPDaI1NbySqjAtS8Go/N/wqDlYpaV+AymtkCmu1roH/R/9RBWNhXz2LO/5bGCzjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1VlfliBpC4goVo6bP5WxhRaldxfKZE1wbrH2C2bv+w=;
 b=CrEU62mMSLsc+SKPUpjLKe2RDia0DD7IlWPpEpp5RumwFgqEbwXjDSAfV3B+dNZitG5mu9iwAsNu50lxC0g/deeh9AugvR+GIbtI1dctS6ME8OC9vOq/WPMpP5qs0Lc2dKsAiTa3C2yRfTYblelOdjmO1xeN/vAkHC2AtLF6opVhuYWO+OFA56wa2vMlCbQkkymkDWdcMqDS5cjZvL5buS2qYjrUQOBgvPjXzKisib5gZ7c6TkBr+QxCCCk+r75cccYtYqwxvr3Mg77cODl1invsT4njaGfSywT+skjn4vytaJpLXst0ehGysdu6hik295xpMHhd5qeOq3GyleEBSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1VlfliBpC4goVo6bP5WxhRaldxfKZE1wbrH2C2bv+w=;
 b=H77yGe3rV3sqRmhhgxJFfmqCeUpEfn9bI8XEFRVX7UFWWx/NyoUClMsBts/bBO5VLqx92v2+mVM3GTySO5Y7Xfnb1DBfjSv/sjpyV49A3khLtIsPyPO3eZshQcxJjTeTG+PmIf4pPdZ6CSKiqtdWPF2WSv8+ZtrDHgaDdg2riEZQ+2Dl8hx3ce8ahWfKqRKBZeB8eiL7QLUvGqJvsocBOYdK1vRMfQdVb46ss83nvCCCFng+oAP7hthBTrRt4V0Yz216OIZJmBw099CNuZ3/0MjYbQxvNXcmmXLVwBdCGNfk9duQKuxmS4UZc08+L2b3ZZBkXq1O4C+KIXUbwfRyjQ==
Received: from AS9PR06CA0247.eurprd06.prod.outlook.com (2603:10a6:20b:45f::14)
 by DBAPR07MB6840.eurprd07.prod.outlook.com (2603:10a6:10:17c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 14:32:33 +0000
Received: from AM2PEPF0001C715.eurprd05.prod.outlook.com
 (2603:10a6:20b:45f:cafe::2) by AS9PR06CA0247.outlook.office365.com
 (2603:10a6:20b:45f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 14:32:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM2PEPF0001C715.mail.protection.outlook.com (10.167.16.185) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Wed, 21 Jan 2026 14:32:33 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id DC5BB20546;
	Wed, 21 Jan 2026 16:32:31 +0200 (EET)
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
Subject: [PATCH v10 net-next 07/15] tcp: accecn: retransmit downgraded SYN in AccECN negotiation
Date: Wed, 21 Jan 2026 15:32:07 +0100
Message-Id: <20260121143215.14717-8-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C715:EE_|DBAPR07MB6840:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8f963e2e-7dce-4c7a-c8f7-08de58f9ea6e
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?GPL2sBwY2DT3gym4HhHDfO74+lA2fG9OucsSxQEI0TrTa2fuqn6dyxfbYNjZ?=
 =?us-ascii?Q?AhEh/iAPSN+8o1yxhLUf3ZYg4Jq7HZRKMdhMXPg3d7USjkNAomejG3BAt5Ku?=
 =?us-ascii?Q?K7c0T8JQ8mMnddz1q3rvwIhtgUy6+H/ac0HMxFp22feWi9oUrpLmuLHUNAkg?=
 =?us-ascii?Q?m2w6+aLrrIJ94c5fS4BnBqhjV4gH29+BAC7bxnqtOTKmTLu6Zm3bawck+i4x?=
 =?us-ascii?Q?nNKxxtq07AFy9J730+8r3ar2PLYPtXAjx11GeW84dChHrm1xMw3poSkK2eC6?=
 =?us-ascii?Q?sGQVxfveOvdvKwWjPJkgsHtaGLGQ1K3pCN/8t87ja1gZSbBoma4vD4SnMF9+?=
 =?us-ascii?Q?BCJfdzJoXaMxiV33SiYVJ85a6JuKsEnRRoL0p8+DRZM1Ge0McHgKtFJ0XovS?=
 =?us-ascii?Q?d1ZwbRBgqP4ODuGK4fYhayXI/TlDRDRevUeJD2gOKh2jltfW6OrGeVYf4+sL?=
 =?us-ascii?Q?7hlBggGIQed73Vv7iKsCeTxbmtWJoru4zr4SWa7JiLZQGez3pLbip7Vmq1kQ?=
 =?us-ascii?Q?JcoNhg5i2HSC5SmmBetzIyiNwMpzsQrml4tsNDYZIoWFHgoqmqD8QPRfKPO8?=
 =?us-ascii?Q?+KNpla3minpyzagz4UkoKYJ+lChKEuQQAtJBFlrkBrYtSIxfMWtgOun17m5O?=
 =?us-ascii?Q?RPKHCi6RHxlNufaZK4THbIMRilGcysF4XnFQw0TQjkShHxn1H96MzLo9L+Aa?=
 =?us-ascii?Q?g7rTrf7feauYLSt3ic/reGRT3KBEEBABJpiCRzx5cHs2PK/o0gK+F4G7dqDh?=
 =?us-ascii?Q?3wsan55ilRh4cVi8Gv68mCOgMwortgGerh1h89+2HjqXn10B7Lh10AkB8skY?=
 =?us-ascii?Q?cpu7qzWvxhC0fvHxIMhr+hu510Kaokwd0gQctD306AV4UnfKa++2Ja1n+E2d?=
 =?us-ascii?Q?yhb5s6fRIucJriyTmDj7vAcVwtukRWx2OuyeaPH8gOcTqi4PyMsi5m17dfFE?=
 =?us-ascii?Q?rwtbSJVQw7pTpMYA1RC2E3r6pSSnYDGdb/JT2rmCC2j7hCBCue5eTwC90+8E?=
 =?us-ascii?Q?mfiHAYfv5hE7Z+zLdhTURq5uif1q9C7Nz6ei8IL/FEjX5wCVejgyHWOwLKMC?=
 =?us-ascii?Q?nVeKdBovtCefr7tHVlMElwoCqJKBaPWUFybtkOSuzJBsbcwTXRxgSjsDhg1S?=
 =?us-ascii?Q?pH/tzt8mZqfLqttz2sOSsnakmf5gWhT0Jw59Gs3g1YG7tu9D6aN+aKz1aAAV?=
 =?us-ascii?Q?5aSzTHUpnQ3QGr8i4welBdP6oXfn/X+HnLcaez4kdOE6WYuMa/CPAuYlNrFY?=
 =?us-ascii?Q?28kWm05gbofMaVxAD9AXYgdzolYw/g/n1W5jEhScdX9E5O8+Mvrt265MnT4z?=
 =?us-ascii?Q?9t5gjEnmM8DVZ2DOwi7mS+JJMOH11wAfDQVuY4tyQkrxfAVBPzH9P3Ay3RgG?=
 =?us-ascii?Q?mwuQTG4aw/Yhiesi2oFupZgnD8SjZ8R2ps54T4i/+aUgsxg9M2NSvlvKQcSS?=
 =?us-ascii?Q?1QvA+GSsQ7gk+2gTOgAuUk7sgv3bk1Kf6IVRLw8/IhcHGRwSUfSVrXTQ1pym?=
 =?us-ascii?Q?04q2NJib87vXAjHKxWmkpqz8Dql6Clk2u4OB8WPXsAHn+mmt7cBW5+MuXzEn?=
 =?us-ascii?Q?wgsvCe168RWEKaYub1RHIbL6GgRE0lsE6Bh1eRhWoZ28zT5Csj+fQ0hYe+Lw?=
 =?us-ascii?Q?1UYvE7Zb+MIammzauvkvFDTpi9lzKHyzvflUGHxqt2U1irilPdYnRo/wFLak?=
 =?us-ascii?Q?Xz4zVPs7GH+oERVdmc+WikbDyf0=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 14:32:33.5712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f963e2e-7dce-4c7a-c8f7-08de58f9ea6e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM2PEPF0001C715.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6840
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
	TAGGED_FROM(0.00)[bounces-251922-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[nokia-bell-labs.com,reject];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EBA2D59153
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Based on AccECN spec (RFC9768) Section 3.1.4.1, if the sender of an
AccECN SYN (the TCP Client) times out before receiving the SYN/ACK, it
SHOULD attempt to negotiate the use of AccECN at least one more time
by continuing to set all three TCP ECN flags (AE,CWR,ECE) = (1,1,1) on
the first retransmitted SYN (using the usual retransmission time-outs).

If this first retransmission also fails to be acknowledged, in
deployment scenarios where AccECN path traversal might be problematic,
the TCP Client SHOULD send subsequent retransmissions of the SYN with
the three TCP-ECN flags cleared (AE,CWR,ECE) = (0,0,0).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v10:
- Update commit message

v5:
- Update commit message and the if condition statement.
---
 net/ipv4/tcp_output.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 256b669e8d3b..d5d695a501f8 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3606,12 +3606,15 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 			tcp_retrans_try_collapse(sk, skb, avail_wnd);
 	}
 
-	/* RFC3168, section 6.1.1.1. ECN fallback
-	 * As AccECN uses the same SYN flags (+ AE), this check covers both
-	 * cases.
-	 */
-	if ((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN_ECN) == TCPHDR_SYN_ECN)
-		tcp_ecn_clear_syn(sk, skb);
+	if (!tcp_ecn_mode_pending(tp) || icsk->icsk_retransmits > 1) {
+		/* RFC3168, section 6.1.1.1. ECN fallback
+		 * As AccECN uses the same SYN flags (+ AE), this check
+		 * covers both cases.
+		 */
+		if ((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN_ECN) ==
+		    TCPHDR_SYN_ECN)
+			tcp_ecn_clear_syn(sk, skb);
+	}
 
 	/* Update global and local TCP statistics. */
 	segs = tcp_skb_pcount(skb);
-- 
2.34.1


