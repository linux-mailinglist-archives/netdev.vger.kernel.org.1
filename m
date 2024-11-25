Return-Path: <netdev+bounces-147285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCBF9D8EF0
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 00:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAB1EB229B3
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 23:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F201925AD;
	Mon, 25 Nov 2024 23:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="fpym/GOr"
X-Original-To: netdev@vger.kernel.org
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75F41CD2C;
	Mon, 25 Nov 2024 23:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732576767; cv=none; b=ZdPjMV0l1cxtLu4ezT/ytpoalp3b1gb30eKHT5IZJvP4fuDVMJzUYuMZHp6+xrDzoOFcAUufAAYNTQ/bbc2DxEPwOll86kcvCeaV7yaIvF2K0QeRe67IgOvT4QtwHbPV4vbf31np03tOHLK7eRc6W2/y4kNqDnklyHKn8i2Wfd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732576767; c=relaxed/simple;
	bh=AAKcvTazsTtzaizb2P/Gv3cineczqMLFnAjAu81+gg4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ViD+sTg6A9x1jeVsctgfx13C0aIs6e752sH4yHd0vC+IT02jv3btc4e0EGjEBSD2ClYuctW3L+52sIsvVd74Fv8ZuyUyuSri+HvqKnQ8NTcyP51lpv7D4YXhQKZLEnAOYPL029v/TjFf3a/kS8hKLj3a0qVzJmOouXhabPTuLtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=fpym/GOr; arc=none smtp.client-ip=131.188.11.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4Xy1qt0Q6tzPkVp;
	Tue, 26 Nov 2024 00:19:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1732576762; bh=hXNXvB1YkXWQBhSaqVTMLp4cvaSRmlShkxqkHuC1Xm4=;
	h=From:To:Cc:Subject:Date:From:To:CC:Subject;
	b=fpym/GOrf1hBVVsUSuK0o0QamH8DvxqdRwggB6CYT+jMw7+QtilvyHzJIu6n3f1YB
	 wI6vxNGsFCC/vWNyBZw2ubyUn/xAr6nOBKcoHQcb0ruSNVvR2ixy9KRkdQ3UuEOhgB
	 XYpyVeRPJxpjBLDNKTMBe7zH+AACANWgH2397IuCG4vYa8fL82rCm5uwXzgUoi/Dw/
	 AiXziqhmDs7VFqechs3XZX64Vv4oNSV/6O33YFNwsXJdz+JFgY6KJsiZ9l6yyI0UWt
	 qAUSUZENOeMycCWAc4fZBOZMUKof0+B5VVc1daQek7+JHT99ByrpbeV9zh1vtpGzH5
	 R0YD1mczS3RcA==
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 131.188.47.107
Received: from faui76b (faui76b.informatik.uni-erlangen.de [131.188.47.107])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX18MIWNQaQuiS8veO/+fA1bRqTG18I/Xv6w=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4Xy1qq3Q0QzPjml;
	Tue, 26 Nov 2024 00:19:19 +0100 (CET)
From: Martin Ottens <martin.ottens@fau.de>
To: 
Cc: Martin Ottens <martin.ottens@fau.de>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/sched: netem: account for backlog updates from child qdisc
Date: Tue, 26 Nov 2024 00:18:25 +0100
Message-Id: <20241125231825.2586179-1-martin.ottens@fau.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When netem is used with a child qdisc, the child qdisc can use
'qdisc_tree_reduce_backlog' to inform its parent, netem, about created or
dropped SKBs. This function updates 'qlen' and the backlog statistics of
netem, but netem does not account for changes made by a child qdisc. If a
child qdisc creates new SKBs during enqueue and informs its parent about
this, netem's 'qlen' value is increased. When netem dequeues the newly
created SKBs from the child, the 'qlen' in netem is not updated. If 'qlen'
reaches the configured limit, the enqueue function stops working, even
though the tfifo is not full.

Reproduce the bug:
Ensure that the sender machine has GSO enabled. Configure netem as root
qdisc and tbf as its child on the outgoing interface of the machine
as follows:
$ tc qdisc add dev <oif> root handle 1: netem delay 100ms limit 100
$ tc qdisc add dev <oif> parent 1:0 tbf rate 50Mbit burst 1542 latency 50ms

Send bulk TCP traffic out via this interface, e.g., by running an iPerf3
client on the machine. Check the qdisc statistics:
$ tc -s qdisc show dev <oif>

tbf segments the GSO SKBs (tbf_segment) and updates the netem's 'qlen'.
The interface fully stops transferring packets and "locks". In this case,
the child qdisc and tfifo are empty, but 'qlen' indicates the tfifo is at
its limit and no more packets are accepted.

This patch adds a counter for the entries in the tfifo. Netem's 'qlen' is
only decreased when a packet is returned by its dequeue function, and not
during enqueuing into the child qdisc. External updates to 'qlen' are thus
accounted for and only the behavior of the backlog statistics changes.
This statistics now show the total number/length of SKBs held in the tfifo
and in the child qdisc. (Note: the 'backlog' byte-statistic of netem is
incorrect in the example above even after the patch is applied due to a
bug in tbf. See my previous patch ([PATCH] net/sched: tbf: correct backlog
statistic for GSO packets)).

Signed-off-by: Martin Ottens <martin.ottens@fau.de>
---
 net/sched/sch_netem.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index fe6fed291a7b..71ec9986ed37 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -79,6 +79,8 @@ struct netem_sched_data {
 	struct sk_buff	*t_head;
 	struct sk_buff	*t_tail;
 
+	u32 t_len;
+
 	/* optional qdisc for classful handling (NULL at netem init) */
 	struct Qdisc	*qdisc;
 
@@ -383,6 +385,7 @@ static void tfifo_reset(struct Qdisc *sch)
 	rtnl_kfree_skbs(q->t_head, q->t_tail);
 	q->t_head = NULL;
 	q->t_tail = NULL;
+	q->t_len = 0;
 }
 
 static void tfifo_enqueue(struct sk_buff *nskb, struct Qdisc *sch)
@@ -412,6 +415,7 @@ static void tfifo_enqueue(struct sk_buff *nskb, struct Qdisc *sch)
 		rb_link_node(&nskb->rbnode, parent, p);
 		rb_insert_color(&nskb->rbnode, &q->t_root);
 	}
+	q->t_len++;
 	sch->q.qlen++;
 }
 
@@ -518,7 +522,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			1<<get_random_u32_below(8);
 	}
 
-	if (unlikely(sch->q.qlen >= sch->limit)) {
+	if (unlikely(q->t_len >= sch->limit)) {
 		/* re-link segs, so that qdisc_drop_all() frees them all */
 		skb->next = segs;
 		qdisc_drop_all(skb, sch, to_free);
@@ -702,8 +706,8 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
 tfifo_dequeue:
 	skb = __qdisc_dequeue_head(&sch->q);
 	if (skb) {
-		qdisc_qstats_backlog_dec(sch, skb);
 deliver:
+		qdisc_qstats_backlog_dec(sch, skb);
 		qdisc_bstats_update(sch, skb);
 		return skb;
 	}
@@ -719,8 +723,7 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
 
 		if (time_to_send <= now && q->slot.slot_next <= now) {
 			netem_erase_head(q, skb);
-			sch->q.qlen--;
-			qdisc_qstats_backlog_dec(sch, skb);
+			q->t_len--;
 			skb->next = NULL;
 			skb->prev = NULL;
 			/* skb->dev shares skb->rbnode area,
@@ -747,16 +750,21 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
 					if (net_xmit_drop_count(err))
 						qdisc_qstats_drop(sch);
 					qdisc_tree_reduce_backlog(sch, 1, pkt_len);
+					sch->qstats.backlog -= pkt_len;
+					sch->q.qlen--;
 				}
 				goto tfifo_dequeue;
 			}
+			sch->q.qlen--;
 			goto deliver;
 		}
 
 		if (q->qdisc) {
 			skb = q->qdisc->ops->dequeue(q->qdisc);
-			if (skb)
+			if (skb) {
+				sch->q.qlen--;
 				goto deliver;
+			}
 		}
 
 		qdisc_watchdog_schedule_ns(&q->watchdog,
@@ -766,8 +774,10 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
 
 	if (q->qdisc) {
 		skb = q->qdisc->ops->dequeue(q->qdisc);
-		if (skb)
+		if (skb) {
+			sch->q.qlen--;
 			goto deliver;
+		}
 	}
 	return NULL;
 }
-- 
2.39.5


