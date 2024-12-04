Return-Path: <netdev+bounces-148969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024A49E3A10
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 13:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C29286102
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 12:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2F41B4135;
	Wed,  4 Dec 2024 12:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="j5web6Zl"
X-Original-To: netdev@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3E61AF0BE;
	Wed,  4 Dec 2024 12:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733315807; cv=none; b=eg14No3SwVZNpoGjBhxwoKGRZQaOnmQyyRkpU0pJl/6kYguwpQcFX6mbxkz0ItmGhIc5wiNcd5hYbJxVAodmmR2QMQN2Cqok3I3Af9+Iwgkmcnjc26x721YRi3U/2gxCj2PWV2GUROVYOZLRU05Px3RlOz1dhurEGFS01wvSxNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733315807; c=relaxed/simple;
	bh=IEmkH8GSW9/Y3OBntL3jN3DJgggJ54xA6hhNJT1vCLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KrAzEVPYYscb1NpolZSkEdV+mpqzT0mPjZZDpi8tZ41T5c/tFBLlDdKaTy0WwTKAdhTmaaVXZmFdpiDLZl3IZxnNIIXjzNsQN6sznxEwIS25HkaVYr2n+3KAqIYg4vgcjyWAr/g54jZekJ3icPt60z0IdVINFFhXd2Nzyzz9KvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=j5web6Zl; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4Y3H070tSfz8tX0;
	Wed,  4 Dec 2024 13:29:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1733315383; bh=GzLRBhecWewOSKJk7GdiLRVGMSTktg2TiiUmTGfAi24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=j5web6ZlH+nobHJly+RcWyf9VYJLJPv19smEPJKfeqYK2NDC6NyR8jN+YpjQlJpB+
	 gErueCeECfXfirKpoFx6LgDvYL2EdFOFFr2t2LQNpysWPSHSl5L+KxsCfGrt28ctvm
	 N56K3jGiIK7v9euRD/mVqHB2aD3ngw7z3QrIC+ggMALPr/Hlq/CR+3QzcvaLRKmZaV
	 ihoaJUvLPoyZjSeKDebcS0iEDMQvtlmGys7FZQZJQpUoIJU7BXwD3UbTR6LrMHueVl
	 or/3Ep+VqSoWlRtgcM8jpOhwsR8a6GRpWah77iFXyJpFfoTf2bmS4/GYNcH47ayDKm
	 wYHogMW37/WUg==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 131.188.47.107
Received: from faui76b (faui76b.informatik.uni-erlangen.de [131.188.47.107])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1+h1vXgyFd22LVdiaXYJGWnfnea6/l2Vfw=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4Y3H044FBpz8tZf;
	Wed,  4 Dec 2024 13:29:40 +0100 (CET)
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
Subject: [PATCH v2] net/sched: netem: account for backlog updates from child qdisc
Date: Wed,  4 Dec 2024 13:29:29 +0100
Message-Id: <20241204122929.3492005-1-martin.ottens@fau.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241202191312.3d3c8097@kernel.org>
References: <20241202191312.3d3c8097@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In general, 'qlen' of any classful qdisc should keep track of the
number of packets that the qdisc itself and all of its children holds.
In case of netem, 'qlen' only accounts for the packets in its internal
tfifo. When netem is used with a child qdisc, the child qdisc can use
'qdisc_tree_reduce_backlog' to inform its parent, netem, about created
or dropped SKBs. This function updates 'qlen' and the backlog statistics
of netem, but netem does not account for changes made by a child qdisc.
'qlen' then indicates the wrong number of packets in the tfifo.
If a child qdisc creates new SKBs during enqueue and informs its parent
about this, netem's 'qlen' value is increased. When netem dequeues the
newly created SKBs from the child, the 'qlen' in netem is not updated.
If 'qlen' reaches the configured sch->limit, the enqueue function stops
working, even though the tfifo is not full.

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
accounted for and only the behavior of the backlog statistics changes. As
in other qdiscs, 'qlen' then keeps track of  how many packets are held in
netem and all of its children. As before, sch->limit remains as the
maximum number of packets in the tfifo. The same applies to netem's
backlog statistics.
(Note: the 'backlog' byte-statistic of netem is incorrect in the example
above even after the patch is applied due to a bug in tbf. See my
previous patch ([PATCH] net/sched: tbf: correct backlog statistic for
GSO packets)).

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


