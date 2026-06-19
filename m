Return-Path: <netdev+bounces-300725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xBGZEzRdNWpsuAYAu9opvQ
	(envelope-from <netdev+bounces-300725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 17:16:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AB36A6A16
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 17:16:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=b1n.io header.s=key1 header.b=oWe0BT6L;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300725-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300725-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=b1n.io;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1D3B300EFA7
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 15:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEBC2D9ECB;
	Fri, 19 Jun 2026 15:16:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D8D33BBAF
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 15:15:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781882161; cv=none; b=lcj1c6AV5nHOu0sdaE/vXnCl54SNwu2BWEnxjJMjI6vXKH4gr4ckIcGRZphygL2tzq7UzXESEc/rCbcGacpll3ypZMbZRGqaHifeyIzZXSHnLePKLP9cusYVTrl4TYXZqyOR2OHYega/YdddcZwh/ocemFyQbCcWsbPm3IdHO8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781882161; c=relaxed/simple;
	bh=TGYgwiTJHtJNlt/17k021rosdmJg6Kpva8siZ53rSS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fg7FX0KR28vrsDLDKPSXJ4YmSd1QFFix8LCY9CAqbUnRYwHtIRw8t6gRjo/0Fjrz43cP95KMS2iViyfSPs7MkO0uyqW4I4myP2QBiUJtTEqkQDTRYdD9EvDKcYMP2PbzyCA8vYFyEBbLGCBIc3pspSbfkvfJ9rxmVf+eLmLdbMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io; spf=pass smtp.mailfrom=b1n.io; dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b=oWe0BT6L; arc=none smtp.client-ip=91.218.175.170
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b1n.io; s=key1;
	t=1781882147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PwWF7KrEgnuENNQxPC3DbTo9dxOZ56k4AODfX6tSOv8=;
	b=oWe0BT6LKfEp3HNDr0a0+gAFN8hTy9XeiHfsSLQcUELBdMJtLwZ1bbGlpAOXTXWP3nbRto
	7AjIjNUL2WmS1waIXOxsteHZ7TfTGkTzx0hxauNasBgBpxj5ky98xsdyzw9+7t5Pwv+NXn
	1RMheBWDJPUgt079/n/tmvYRHjddADaovTeIJ+UJNB4F9Zx2OpfznshY5A96Gh47dvN2qb
	UbkBn2oO6rB1GZG9O30Ifv0nBWl61xmrWsq3LCHsOOmgdEZhNz+60V5nukgwYwFpkuv/8f
	YSegefPrS3hBjIj0NjfR5HhZhMd8+hNhHO3qKwXC2jX2OPevlDJCSIWRRlrZcg==
From: Xingquan Liu <b1n@b1n.io>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Xingquan Liu <b1n@b1n.io>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] net/sched: dualpi2: fix GSO backlog accounting
Date: Fri, 19 Jun 2026 11:13:47 -0400
Message-ID: <20260619151447.223640-1-b1n@b1n.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[b1n.io,quarantine];
	R_DKIM_ALLOW(-0.20)[b1n.io:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300725-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[b1n@b1n.io,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:victor@mojatatu.com,m:chia-yu.chang@nokia-bell-labs.com,m:b1n@b1n.io,m:stable@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[b1n.io:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[b1n@b1n.io,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 16AB36A6A16

When DualPI2 splits a GSO skb into N segments, it propagates N
additional packets to its parent before returning NET_XMIT_SUCCESS.
The parent then accounts for the original skb once more, leaving its
qlen one larger than the number of packets actually queued.

With QFQ as the parent, after all real packets are dequeued, QFQ still
has a non-zero qlen while its in-service aggregate has no active
classes. qfq_choose_next_agg() returns NULL and qfq_dequeue() passes
the result to qfq_peek_skb(), causing a NULL pointer dereference.

Follow the same pattern used by tbf_segment() and taprio: count only
successfully queued segments, propagate the difference between the
original skb and those segments, and return NET_XMIT_SUCCESS whenever
at least one segment was queued.

Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
Cc: stable@vger.kernel.org
Signed-off-by: Xingquan Liu <b1n@b1n.io>
---
v3:
- Move the UDP GSO sender into tdc_gso.py.

v2:
- Change patch commit message.
- Add tdc test.

 net/sched/sch_dualpi2.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index d7c3254ef800..5434df6ca8ef 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -461,7 +461,7 @@ static int dualpi2_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		if (IS_ERR_OR_NULL(nskb))
 			return qdisc_drop(skb, sch, to_free);
 
-		cnt = 1;
+		cnt = 0;
 		byte_len = 0;
 		orig_len = qdisc_pkt_len(skb);
 		skb_list_walk_safe(nskb, nskb, next) {
@@ -488,16 +488,15 @@ static int dualpi2_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 				byte_len += nskb->len;
 			}
 		}
-		if (cnt > 1) {
+		if (cnt > 0) {
 			/* The caller will add the original skb stats to its
 			 * backlog, compensate this if any nskb is enqueued.
 			 */
-			--cnt;
-			byte_len -= orig_len;
+			qdisc_tree_reduce_backlog(sch, 1 - cnt,
+						  orig_len - byte_len);
 		}
-		qdisc_tree_reduce_backlog(sch, -cnt, -byte_len);
 		consume_skb(skb);
-		return err;
+		return cnt > 0 ? NET_XMIT_SUCCESS : err;
 	}
 	return dualpi2_enqueue_skb(skb, sch, to_free);
 }

base-commit: 96e7f9122aae0ed000ee321f324b812a447906d9
-- 
Xingquan Liu


