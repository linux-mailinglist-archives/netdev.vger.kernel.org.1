Return-Path: <netdev+bounces-278132-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UK5MKM8e3WmSaAkAu9opvQ
	(envelope-from <netdev+bounces-278132-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 18:50:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B39BF3EFF23
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 18:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3C41B305D473
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9E330BF4E;
	Mon, 13 Apr 2026 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="SyDZ2mZl"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013056.outbound.protection.outlook.com [52.101.83.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B545A307AC7;
	Mon, 13 Apr 2026 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098269; cv=fail; b=oo+NA+ur1J+y3+A0guSB7U7MQT0k/oC5JtM9t5gDIwLMVUumg3Fy86awBPw0WYHka3bvmxYcqCIY/SqgOGsMruxItR4av7n+AjSNUq+cSt5hmGV9mPSuVvx4P/9kShNdn1WmXthbSuG5sh1R/Y6AdV1ItW4e2aqZY64lty9K04c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098269; c=relaxed/simple;
	bh=g/UqfiUIGkRmPWk8728GP6zQLuqVGUIaPN2y7MaS8vA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=F/kjNfwvpyEa06lr8BmCHCcVgVBbDSsK7rYUon8uUgYN1puWiXFPv0T+1ar0Y+YFhpwYT9DBUlG2mPs3UqhPv1VysU3wJQnhS+cwBIadhb3JHSTbiy8gcSMZ+yZql1s+diT63SACvvLNhBxKBQ90nnKV7z0wgAMx1YmosUBuTVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=SyDZ2mZl; arc=fail smtp.client-ip=52.101.83.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcR2bqfbk54VVhzlK7BZyG5YYe6RGRVJQj+i4AOdaBkLfwSbg5707/XCTT4QPLAuIRCsy0W4LZE4hntbV+15Tcm6k2dRKR1LJ3TQFcixQggbwrx6TopHcCTdv6GqjiqXPRoBV29ClBEUPnYTXIZe0eRJ61GjDDRJhtGLARXQ2+AI/N1k7hRBBNGt+qpqCmYc1VOIxzbkBdHjfD4aUXP/n8kDvo4eWSx529Jlgfwl8vsJmPoTg+N1VUmNHTQPuZaCEalxNySbq8DPChpNeK0AAWhluzojM4SnoU1/C/bcVABQ3unHI0cvklWoUvZTRXtbwf9a5Wrnmy5XZL5FIy8big==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlCjB7dK0tArYTFrfmC2wscGtBRrTm9ynYW1aZahGfw=;
 b=WgmgHRuui/uaC4BlEYz3g2tDWtaeeaelUxZl2nFLd2UlZETY1ta/QzQDv8fni00xWXeCBVfXqvglaNNSAmaJAB7CgmDYOFOPlCNu1Wyqh7cNPikn4PVlE2sBxoPX7Hi9KR7lVw6lSC1XNHbrHy9INWPglwENOzDb+cUzBPKaJvMb2j+2wePcFL36+V3gtb8n4PkjFVtuywDvWNIyAK82/j4KcQSf6Qi1vIE4QvQBXzus/DDaqL5cMi7B6ilFEr38LDZuDwTPASoTIhAXDsja9E3reDRv8Of4CqeXi8sFylSuqn7KesBZnY6zLu5bFuLdKEoPHvzNJcYyH6tAwnuiIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlCjB7dK0tArYTFrfmC2wscGtBRrTm9ynYW1aZahGfw=;
 b=SyDZ2mZlps8WBAxoIuQ0Z5+CN+9/M4NqUjjn3fvG6FqOWgvk+FyKZS1Ywv44d0Pa1cVBtaFJ7HCtN6ufe6SLUACxIgR2nBIPdJ2BBHEQQ7LAjnqFKsF/V5ObrWw4y8gIZaTFjZ0TeII00IdV4AWhhwGWc8Deoc0wg2tjcXDmQsb6HHSY64NTBN7mtYQudf/M5idaqwT0ohGe7Nn2+86oYqzDQvA0JWz/Aj6oz8jeHS+GZQP7s1Pe42/Ge9e6/6CEJxm6ntFCzfOlrnZLSp2oLjBijS6imrxTEl7VZB2dgIEEDwldotC5VMohZBc7IAtNixxeBhR2HPO2hvhnxJudlg==
Received: from DUZP191CA0050.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::23)
 by PA1PR07MB11045.eurprd07.prod.outlook.com (2603:10a6:102:505::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Mon, 13 Apr
 2026 16:37:43 +0000
Received: from DB1PEPF000509FA.eurprd03.prod.outlook.com
 (2603:10a6:10:4fa:cafe::e3) by DUZP191CA0050.outlook.office365.com
 (2603:10a6:10:4fa::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 16:37:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB1PEPF000509FA.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Mon, 13 Apr 2026 16:37:42 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 925E520202;
	Mon, 13 Apr 2026 19:37:41 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: linux-hardening@vger.kernel.org,
	kees@kernel.org,
	gustavoars@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	horms@kernel.org,
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
Subject: [PATCH v1 net 1/1] net/sched: sch_dualpi2: fix limit/memlimit enforcement when dequeueing L-queue
Date: Mon, 13 Apr 2026 18:37:11 +0200
Message-Id: <20260413163711.56191-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FA:EE_|PA1PR07MB11045:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d1ab6510-7be1-4e2c-1d7d-08de997afc33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|7416014|82310400026|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	39T8km+pQMfHIkg3/YyPjxS8MJ9xK5sLhydvNNNqbfQVtNDPDrAq1gbTw+pN2ru4vxEriWjizPmnJG8k5UR+sLXUEYP8UC0VvklBcJQurjb8aVkrtayK/svicVdnF42gRu3RwCzcGYbe21aIj7o94Hflwv5H0vmdEw/iUiXq1AylpLnU10wUoNPZ9MvgzcEzEPoNE8L0SKLSv1SSbac5yLVvjrlrwtrHgLfEXA/RHFWPKQcruQDzfY9XqzOQfCZRO64LcDZpznm1z99KrTxDPQd7Lx3PG5nN7QDmf6oBKZ0zwUVKEbZH4eTEfeAj34ilqoFGMTEcG8CzjtJnf6pRni9j+ObE3YZUE9latvbnMgBC+IxrjwOr6INX0VOzqClg0MPbg8IqUmmKpgxo39d0k1TZfsxYkTIa8kG6GkmU4XqbBhitDgmBD2FS1yxgXoH5f+Hvu1DpigVk+XNiXk8be1x1zL7CEDcnRYenPX7hrBZtLFx0d+JyTS3t3BVpVlaa6JnSaQqUTAmnNcjo6LU+DXUlan9OMz2cUUTIJ3jBUMVjj34+LR5zoP037H+fkjir0P2PUEYqr9R0p8Nx1+gjZb7VUMVuaGaifXTygdYlWha8nzustixOpD8k/RhRVzXGVwQ3MBpkIqPLkaQp9MiNaJzEDcXTbRwrtFoiL+WTWGSn79npG5a/LpEjgR2i3jyXIfnddDYI6HsvgGQb+BaiHnlRQa+MDe/fYvO+ArE9QkdK5i0RaY7Vsx8JXajWTZJz1EU9qUjIdFrZtdpWj9Ox+1QHLcXv+5mdsa8CGyuKACbtvIQcGoJAaU5VV5vd5f1P
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(82310400026)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ermysk/dwRQYA+3Re9hogNiQpzCkC/MqCKsSA3QYBN8WsheZ6xJOs1TwEg0PLF4QwB/GzYeajaAZ0Axqo8mCajpVf9oOy7Xiokra8mQ5WT1b9tFsgDX0l5K+1ZEtlLylO9JntrVvhi8/g1ahR9+3b7ydYSTYCclQ2I0lSEhizQgEboJzeJ2HWSp9WsvK3jh7Y8PFMKvXNo1mifUn29Osf4MvpbCBOL/xGrakeRsZ1uUr6msgeG8aTuTpPQSl3znmIBwg6drajtTSYUzTYnfM0cMU7uSD7j1bjPWLfDtzQhsOAzieS7171cvMlmESJDO4eyovwxTGEy9U+EzBjmLVA23mF2dCE1Pi+o9YmXzCcNbeqAR1aS33KtMzaSS26v5u+8HLnIkMyb4/vgdfreTGlmF53KEVdKJj1d6x5cm8vidi6Uf1kjl4u0zGFmLb/zjy
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 16:37:42.8390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ab6510-7be1-4e2c-1d7d-08de997afc33
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509FA.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR07MB11045
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278132-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,mojatatu.com,resnulli.us,davemloft.net,google.com,redhat.com,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B39BF3EFF23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Fix dualpi2_change() to correctly enforce updated limit and memlimit values
after a configuration change of the dualpi2 qdisc.

Before this patch, dualpi2_change() always attempted to dequeue packets via
the root qdisc (C-queue) when reducing backlog or memory usage, and
unconditionally assumed that a valid skb will be returned. When traffic
classification results in packets being queued in the L-queue while the
C-queue is empty, this leads to a NULL skb dereference during limit or
memlimit enforcement.

This is fixed by first dequeuing from the C-queue path if it is non-empty.
Once the C-queue is empty, packets are dequeued directly from the L-queue.
Return values from qdisc_dequeue_internal() are checked for both queues. When
dequeuing from the L-queue, the parent qdisc qlen and backlog counters are
updated explicitly to keep overall qdisc statistics consistent.

Fixes: 320d031ad6e4 ("sched: Struct definition and parsing of dualpi2 qdisc")
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/sched/sch_dualpi2.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 6d7e6389758d..56d4422970b6 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -872,11 +872,25 @@ static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
 	old_backlog = sch->qstats.backlog;
 	while (qdisc_qlen(sch) > sch->limit ||
 	       q->memory_used > q->memory_limit) {
-		struct sk_buff *skb = qdisc_dequeue_internal(sch, true);
-
-		q->memory_used -= skb->truesize;
-		qdisc_qstats_backlog_dec(sch, skb);
-		rtnl_qdisc_drop(skb, sch);
+		int c_len = qdisc_qlen(sch) - qdisc_qlen(q->l_queue);
+		struct sk_buff *skb = NULL;
+
+		if (c_len) {
+			skb = qdisc_dequeue_internal(sch, true);
+			if (!skb)
+				break;
+			q->memory_used -= skb->truesize;
+			rtnl_qdisc_drop(skb, sch);
+		} else if (qdisc_qlen(q->l_queue)) {
+			skb = qdisc_dequeue_internal(q->l_queue, true);
+			if (!skb)
+				break;
+			q->memory_used -= skb->truesize;
+			rtnl_qdisc_drop(skb, q->l_queue);
+			/* Keep the overall qdisc stats consistent */
+			--sch->q.qlen;
+			qdisc_qstats_backlog_dec(sch, skb);
+		}
 	}
 	qdisc_tree_reduce_backlog(sch, old_qlen - qdisc_qlen(sch),
 				  old_backlog - sch->qstats.backlog);
-- 
2.34.1


