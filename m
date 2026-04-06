Return-Path: <netdev+bounces-275667-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gB3ME37t02nInwcAu9opvQ
	(envelope-from <netdev+bounces-275667-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:29:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A60C23A5B24
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAC8630557CA
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 17:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62342390CB7;
	Mon,  6 Apr 2026 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="a865KlS8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0727A3909B6
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 17:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775496426; cv=none; b=AkuIEZz2pTWWB8HMTnpAFU9eaq4PnN/3GaoJB11XvwzSjISVua1eSit4XIqZ5Igy2rpR5TIj5pKGvelpMPCNCVAdFPAtAegAU23kudxohTpwxX/JVr9L8TFte3y6K5EXRGdaNoJHDDPZocRolOUMEz1XQ5l8iUZCqEvT4SHAJwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775496426; c=relaxed/simple;
	bh=em4t/SfKffb29HsRWbQtk7bdC8BLB0kbDzipiE/8AcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiPyaJVaLBc1DDVLrwrH+NhlH5cli27ylZ00/0Hl5quNm0Y4r/Extiunrxs9vrA9z4jyeAYeYaDE0IcKtkO4UkcY5zBQDDzJr82tleXK0lhgtPJ8PJje/4dO1KjmZtCf0C/m8SVHIMMAj1OTImHDBTsmvYmdLYpKA+mfi7x//dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=a865KlS8; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c742d4df00cso1979912a12.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 10:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775496424; x=1776101224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tq1yeguXsY5C6wxznsO+0ouXfV3sO6mnORMOp4qF4Fw=;
        b=a865KlS8382hduPbwWtIha4QrkEpxQPQBHD4zQ/jSZyEGzjHkz01hNkf+/KS/YKXUC
         QWmccEBSJu5Vl5NHBJ9KUYpo4NWzcR663hO9DFQFNxIWUNIPcRNdBcWHMFqUk1Vt3g3m
         ZrYqQEUwnTkoRo25bXade8u7xGp4HmQvv1u3Fbh65K/aGCy+6NkNxqSC6012lUpt7VL0
         fzT0ovvWWoTorSX4nOq46JsYy7fie/vFyogARKWuMhasBlz+90TIV0NJAPxyXsOY0P4z
         ebfmS9/HLK6Uj5sDtZuwoY2TKwb4pb1WklB4bdJPXNqBqF6KyGzzj4k1KzQW5C1MhoKN
         Us3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775496424; x=1776101224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tq1yeguXsY5C6wxznsO+0ouXfV3sO6mnORMOp4qF4Fw=;
        b=MYzDG/hoe9VImAWOG7tD9QOhNxSADqhJHYKkDvwWQuO9ZXW2UKzSLWKAwj+a/BzGn9
         klmbsCKnkvIQdXaTIgYHq1iYjwoC4UuA8xiNooZgeuFsZk+b7STbGJxKefQEULBQqNmU
         tQ7N6JobMDcECoE2ZxXLdmfGhEpfKmtw+XUXhPGTmst6GUVgf2uuTpPKOjrR9rsNJY2d
         8qQOxAMR0H6/QZCgpKpRZ9QoSDz2O2TSB8ZzYmXN8jahbV4V3k671TjHEeueXdlr9xDB
         9PY1+gG/gnECscFgwcbfDYZRLIC21Xjt+G5hq4QkUbYMoVaAkTj67KU9oKy2GStjLQw2
         Y+ig==
X-Gm-Message-State: AOJu0YwmpRsfcilq0hMowBhAbBHQxPz9WxLuYZR/SxSXLYftb/Bmq5Ap
	/iv+bucTUNLpturm4U+613lInS3RXflod3bNd+SM6mjG7NQPcFhDBUPRT46xUNsIRFhQrztqEi/
	RqzFD
X-Gm-Gg: AeBDiesFgrzX2BT2Q3n7NqufkSEQdGZ3VK/qHzbv3hupkg4y65KmPLgDORaqgfQJAtN
	ZCxUZ1C3vi7zuRqMPbhvQn4Vy0GSpnl/3nbcDyj3YVD+mFgJJzk8FdPbBzVl0kWbSisn2xHAuTB
	xOKiLuYllFNMMt8k99osaV23Ofu1Cu+0mTR9psEu6Vtc//ZV+rp2VPtKAFC9wbye9GW2XF55orf
	cLdrEYtWZmJTIWms242eWB8BfOVVEZ0iEweWuhILVE2qLRj2yFklBprPJQBtLfMjaj2YdVDoUlo
	KirjS+5+SY9P+R6/HuVFlcxKmc0ibj/uSBfCb4D/AF+txRMkSf7YPB3x9u+YRHRxSoKSoFpAlDa
	276YkKGC74pKcAemoFneG6gLbAJkaO/8JcIcRwGXebRaYYIyN/QUqfwDZSpRZRh8h1TeDD9YncM
	5tbcgn0D0C0AGsh3CTXmJ+RoI7g/recc39
X-Received: by 2002:a17:903:90d:b0:2b2:4c30:e6e2 with SMTP id d9443c01a7336-2b282092271mr131570135ad.16.1775496424344;
        Mon, 06 Apr 2026 10:27:04 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27477a13dsm146437945ad.26.2026.04.06.10.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 10:27:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v4 5/8] net/sched: netem: batch-transfer ready packets to avoid child re-entrancy
Date: Mon,  6 Apr 2026 10:25:13 -0700
Message-ID: <20260406172627.210894-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406172627.210894-1-stephen@networkplumber.org>
References: <20260406172627.210894-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275667-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A60C23A5B24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

netem_dequeue_child() previously transferred one packet from the tfifo
to the child qdisc per dequeue call. Parents like HFSC that track
class active/inactive state on qlen transitions could see an enqueue
during dequeue, causing double-insertion into the eltree
(CVE-2025-37890, CVE-2025-38001). Non-work-conserving children like
TBF could also refuse to return a just-enqueued packet, making netem
return NULL despite having backlog, which causes parents like DRR to
incorrectly deactivate the class.

Move all time-ready packets into the child before calling its dequeue.
This separates the enqueue and dequeue phases so the parent sees
consistent qlen transitions.

Fixes: 50612537e9ab ("netem: fix classful handling")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 49 +++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index e264f7aefb97..b93f0e886a2b 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -734,8 +734,10 @@ static void netem_slot_account(struct netem_sched_data *q,
 }
 
 /*
- * Transfer time-ready packets from the tfifo into the child qdisc,
- * then dequeue from the child.
+ * Transfer all time-ready packets from the tfifo into the child qdisc,
+ * then dequeue from the child.  Batching the transfers avoids calling
+ * qdisc_enqueue() inside the parent's dequeue path, which confuses
+ * parents that track active/inactive state on qlen transitions (HFSC).
  */
 static struct sk_buff *netem_dequeue_child(struct Qdisc *sch)
 {
@@ -743,31 +745,28 @@ static struct sk_buff *netem_dequeue_child(struct Qdisc *sch)
 	u64 now = ktime_get_ns();
 	struct sk_buff *skb;
 
-	skb = netem_peek(q);
-	if (skb) {
-		u64 time_to_send = netem_skb_cb(skb)->time_to_send;
-
-		if (q->slot.slot_next && q->slot.slot_next < time_to_send)
-			get_slot_next(q, now);
-
-		if (time_to_send <= now && q->slot.slot_next <= now) {
-			struct sk_buff *to_free = NULL;
-			unsigned int pkt_len;
-			int err;
+	while ((skb = netem_peek(q)) != NULL) {
+		struct sk_buff *to_free = NULL;
+		unsigned int pkt_len;
+		int err;
 
-			skb = netem_pull_tfifo(q, sch);
-			netem_slot_account(q, skb, now);
+		if (netem_skb_cb(skb)->time_to_send > now)
+			break;
+		if (q->slot.slot_next && q->slot.slot_next > now)
+			break;
 
-			pkt_len = qdisc_pkt_len(skb);
-			err = qdisc_enqueue(skb, q->qdisc, &to_free);
-			kfree_skb_list(to_free);
-			if (err != NET_XMIT_SUCCESS) {
-				if (net_xmit_drop_count(err))
-					qdisc_qstats_drop(sch);
-				sch->qstats.backlog -= pkt_len;
-				sch->q.qlen--;
-				qdisc_tree_reduce_backlog(sch, 1, pkt_len);
-			}
+		skb = netem_pull_tfifo(q, sch);
+		netem_slot_account(q, skb, now);
+
+		pkt_len = qdisc_pkt_len(skb);
+		err = qdisc_enqueue(skb, q->qdisc, &to_free);
+		kfree_skb_list(to_free);
+		if (unlikely(err != NET_XMIT_SUCCESS)) {
+			if (net_xmit_drop_count(err))
+				qdisc_qstats_drop(sch);
+			sch->qstats.backlog -= pkt_len;
+			sch->q.qlen--;
+			qdisc_tree_reduce_backlog(sch, 1, pkt_len);
 		}
 	}
 
-- 
2.53.0


