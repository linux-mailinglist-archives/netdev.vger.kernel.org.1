Return-Path: <netdev+bounces-35247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A305A7A8214
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 14:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3871C20C55
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 12:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899C436AF8;
	Wed, 20 Sep 2023 12:54:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58760347B1
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 12:54:29 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBE3AD
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 05:54:25 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58f9db8bc1dso78493517b3.3
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 05:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695214465; x=1695819265; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MSnmeH3gW0av1p9C7kARXgEA4d9ggStsMG4anmwNOkk=;
        b=qMMkcPjikYb7FjDIGtUQMMcabPDf03djlp/gF7hKq3CeXbkNl/8yjab4zl8hfKhDjT
         a072XAPakXy1jTwl0XhwNSw/d75L0d2Wob6rD1wDLAB8K3jEmAs2omj5bq8yzNKReRn9
         r2cgLcqWzwtgPNZR6NY/m0RNrl0TYYwGA/jsiqS49jFtEj4YWZwxA8jlKM9ZxVyY6trr
         rgIJ2+OXHcladH3MyDMCiYYk7AIsaDn3W/wfwuttuz+IjVZpi+nGUq1OwBxwYhttNKHE
         gv9YRfAPfzohwVR+AIpcR0IHWm4fMHA7TWfXucUbs6cV4noP551yPnRb8ajL1s00j/+I
         VxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695214465; x=1695819265;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MSnmeH3gW0av1p9C7kARXgEA4d9ggStsMG4anmwNOkk=;
        b=l4pCpCI38DEbFJBo4aWyHpGUReZzGoMNQZtQw/o2EZZlL1PQydl/TZokigQy7zNpFf
         y73P8fY3TGcYPeJetACKEnvTlrS2hzw5LH9bIz2HtAR5dqerdMB8hKb2OKc+/QIj/jp+
         scf1W4qVTqf7cr9lPCFCMCxIEye8hoijs8s6I5bj0zOvONP6yXErD6JXBQpfMrPFxgBv
         V+nDpqW0NMNJUJmpBT5oIwTMFsEL+vXxz4xL2iRoEB2IFKpQLw3/Y7BzKNCRbhLyJhuq
         +xsCI3nu7UJ8bI8VoXmaM/2WZB0eTaGLY1JbuW3F2ByYWQXzHFgjr8+MmJbcYr2MjYu9
         OgYQ==
X-Gm-Message-State: AOJu0Yy4W6bxMpfXjYXnBNXgdJwK37kRRXq7UsNyOYhMIrrdhk47HPy7
	XThJe8eXu9hFW1pkz1fzAL+R1s1df0gspQ==
X-Google-Smtp-Source: AGHT+IGAjFoL5QDbkiwB0pC2VPg32ICIQDtPl9ww3At7Woylv13l1BEW3A6DqzOMTF42iLTJTIgWDcDMxxM1Aw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:cb04:0:b0:59b:f138:c845 with SMTP id
 q4-20020a81cb04000000b0059bf138c845mr37749ywi.2.1695214464984; Wed, 20 Sep
 2023 05:54:24 -0700 (PDT)
Date: Wed, 20 Sep 2023 12:54:17 +0000
In-Reply-To: <20230920125418.3675569-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230920125418.3675569-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230920125418.3675569-4-edumazet@google.com>
Subject: [PATCH net-next 3/4] net_sched: sch_fq: add fast path for mostly idle qdisc
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

TCQ_F_CAN_BYPASS can be used by few qdiscs.

Idea is that if we queue a packet to an empty qdisc,
following dequeue() would pick it immediately.

FQ can not use the generic TCQ_F_CAN_BYPASS code,
because some additional checks need to be performed.

This patch adds a similar fast path to FQ.

Most of the time, qdisc is not throttled,
and many packets can avoid bringing/touching
at least four cache lines, and consuming 128bytes
of memory to store the state of a flow.

After this patch, netperf can send UDP packets about 13 % faster,
and pktgen goes 30 % faster (when FQ is in the way), on a fast NIC.

TCP traffic is also improved, thanks to a reduction of cache line misses.

tc -s -d qd sh dev eth1
...
qdisc fq 8004: parent 1:2 limit 10000p flow_limit 100p buckets 1024
   orphan_mask 1023 quantum 3028b initial_quantum 15140b low_rate_threshold 550Kbit
   refill_delay 40ms timer_slack 10us horizon 10s horizon_drop
 Sent 5646784384 bytes 1985161 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
  flows 122 (inactive 122 throttled 0)
  gc 0 highprio 0 fastpath 659990 throttled 27762 latency 8.57us

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/uapi/linux/pkt_sched.h |   1 +
 net/sched/sch_fq.c             | 107 +++++++++++++++++++++++++--------
 2 files changed, 82 insertions(+), 26 deletions(-)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 3f85ae5780563cdfb42fdb3a107ca2489d0830a4..579f641846b87da05e5d4b09c1072c90220ca601 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -962,6 +962,7 @@ struct tc_fq_qd_stats {
 	__u64	ce_mark;		/* packets above ce_threshold */
 	__u64	horizon_drops;
 	__u64	horizon_caps;
+	__u64	fastpath_packets;
 };
 
 /* Heavy-Hitter Filter */
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 4af43a401dbb4111d5cfaddb4b83fc5c7b63b83d..ea510003bc385148397a690c5afd9387fba9796c 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -2,7 +2,7 @@
 /*
  * net/sched/sch_fq.c Fair Queue Packet Scheduler (per flow pacing)
  *
- *  Copyright (C) 2013-2015 Eric Dumazet <edumazet@google.com>
+ *  Copyright (C) 2013-2023 Eric Dumazet <edumazet@google.com>
  *
  *  Meant to be mostly used for locally generated traffic :
  *  Fast classification depends on skb->sk being set before reaching us.
@@ -73,7 +73,13 @@ struct fq_flow {
 		struct sk_buff *tail;	/* last skb in the list */
 		unsigned long  age;	/* (jiffies | 1UL) when flow was emptied, for gc */
 	};
-	struct rb_node	fq_node;	/* anchor in fq_root[] trees */
+	union {
+		struct rb_node	fq_node;	/* anchor in fq_root[] trees */
+		/* Following field is only used for q->internal,
+		 * because q->internal is not hashed in fq_root[]
+		 */
+		u64		stat_fastpath_packets;
+	};
 	struct sock	*sk;
 	u32		socket_hash;	/* sk_hash */
 	int		qlen;		/* number of packets in flow queue */
@@ -266,8 +272,56 @@ static void fq_gc(struct fq_sched_data *q,
 	kmem_cache_free_bulk(fq_flow_cachep, fcnt, tofree);
 }
 
-static struct fq_flow *fq_classify(struct sk_buff *skb, struct fq_sched_data *q)
+/* Fast path can be used if :
+ * 1) Packet tstamp is in the past.
+ * 2) FQ qlen == 0   OR
+ *   (no flow is currently elligible for transmit,
+ *    AND fast path queue has less than 8 packets)
+ * 3) No SO_MAX_PACING_RATE on the socket (if any).
+ * 4) No @maxrate attribute on this qdisc,
+ *
+ * FQ can not use generic TCQ_F_CAN_BYPASS infrastructure.
+ */
+static bool fq_fastpath_check(struct Qdisc *sch, struct sk_buff *skb)
 {
+	struct fq_sched_data *q = qdisc_priv(sch);
+	const struct sock *sk;
+
+	if (fq_skb_cb(skb)->time_to_send > q->ktime_cache)
+		return false;
+
+	if (sch->q.qlen != 0) {
+		/* Even if some packets are stored in this qdisc,
+		 * we can still enable fast path if all of them are
+		 * scheduled in the future (ie no flows are elligible)
+		 * or in the fast path queue.
+		 */
+		if (q->flows != q->inactive_flows + q->throttled_flows)
+			return false;
+
+		/* Do not allow fast path queue to explode, we want Fair Queue mode
+		 * under pressure.
+		 */
+		if (q->internal.qlen >= 8)
+			return false;
+	}
+
+	sk = skb->sk;
+	if (sk && sk_fullsock(sk) && !sk_is_tcp(sk) &&
+	    sk->sk_max_pacing_rate != ~0UL)
+		return false;
+
+	if (q->flow_max_rate != ~0UL)
+		return false;
+
+	q->internal.stat_fastpath_packets++;
+
+	return true;
+}
+
+static struct fq_flow *fq_classify(struct Qdisc *sch, struct sk_buff *skb)
+{
+	struct fq_sched_data *q = qdisc_priv(sch);
 	struct rb_node **p, *parent;
 	struct sock *sk = skb->sk;
 	struct rb_root *root;
@@ -307,6 +361,9 @@ static struct fq_flow *fq_classify(struct sk_buff *skb, struct fq_sched_data *q)
 		sk = (struct sock *)((hash << 1) | 1UL);
 	}
 
+	if (fq_fastpath_check(sch, skb))
+		return &q->internal;
+
 	root = &q->fq_root[hash_ptr(sk, q->fq_trees_log)];
 
 	if (q->flows >= (2U << q->fq_trees_log) &&
@@ -402,12 +459,8 @@ static void fq_erase_head(struct Qdisc *sch, struct fq_flow *flow,
 static void fq_dequeue_skb(struct Qdisc *sch, struct fq_flow *flow,
 			   struct sk_buff *skb)
 {
-	struct fq_sched_data *q = qdisc_priv(sch);
-
 	fq_erase_head(sch, flow, skb);
 	skb_mark_not_on_list(skb);
-	if (--flow->qlen == 0)
-		q->inactive_flows++;
 	qdisc_qstats_backlog_dec(sch, skb);
 	sch->q.qlen--;
 }
@@ -450,6 +503,7 @@ static bool fq_packet_beyond_horizon(const struct sk_buff *skb,
 	return unlikely((s64)skb->tstamp > (s64)(q->ktime_cache + q->horizon));
 }
 
+
 static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		      struct sk_buff **to_free)
 {
@@ -459,49 +513,46 @@ static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	if (unlikely(sch->q.qlen >= sch->limit))
 		return qdisc_drop(skb, sch, to_free);
 
+	q->ktime_cache = ktime_get_ns();
 	if (!skb->tstamp) {
-		fq_skb_cb(skb)->time_to_send = q->ktime_cache = ktime_get_ns();
+		fq_skb_cb(skb)->time_to_send = q->ktime_cache;
 	} else {
-		/* Check if packet timestamp is too far in the future.
-		 * Try first if our cached value, to avoid ktime_get_ns()
-		 * cost in most cases.
-		 */
+		/* Check if packet timestamp is too far in the future. */
 		if (fq_packet_beyond_horizon(skb, q)) {
-			/* Refresh our cache and check another time */
-			q->ktime_cache = ktime_get_ns();
-			if (fq_packet_beyond_horizon(skb, q)) {
-				if (q->horizon_drop) {
+			if (q->horizon_drop) {
 					q->stat_horizon_drops++;
 					return qdisc_drop(skb, sch, to_free);
-				}
-				q->stat_horizon_caps++;
-				skb->tstamp = q->ktime_cache + q->horizon;
 			}
+			q->stat_horizon_caps++;
+			skb->tstamp = q->ktime_cache + q->horizon;
 		}
 		fq_skb_cb(skb)->time_to_send = skb->tstamp;
 	}
 
-	f = fq_classify(skb, q);
+	f = fq_classify(sch, skb);
 	if (unlikely(f->qlen >= q->flow_plimit && f != &q->internal)) {
 		q->stat_flows_plimit++;
 		return qdisc_drop(skb, sch, to_free);
 	}
 
-	if (f->qlen++ == 0)
-		q->inactive_flows--;
-	qdisc_qstats_backlog_inc(sch, skb);
 	if (fq_flow_is_detached(f)) {
 		fq_flow_add_tail(&q->new_flows, f);
 		if (time_after(jiffies, f->age + q->flow_refill_delay))
 			f->credit = max_t(u32, f->credit, q->quantum);
 	}
 
-	/* Note: this overwrites f->age */
-	flow_queue_add(f, skb);
-
 	if (unlikely(f == &q->internal)) {
 		q->stat_internal_packets++;
+	} else {
+		if (f->qlen == 0)
+			q->inactive_flows--;
 	}
+queue:
+	f->qlen++;
+	/* Note: this overwrites f->age */
+	flow_queue_add(f, skb);
+
+	qdisc_qstats_backlog_inc(sch, skb);
 	sch->q.qlen++;
 
 	return NET_XMIT_SUCCESS;
@@ -549,6 +600,7 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 
 	skb = fq_peek(&q->internal);
 	if (unlikely(skb)) {
+		q->internal.qlen--;
 		fq_dequeue_skb(sch, &q->internal, skb);
 		goto out;
 	}
@@ -592,6 +644,8 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 			INET_ECN_set_ce(skb);
 			q->stat_ce_mark++;
 		}
+		if (--f->qlen == 0)
+			q->inactive_flows++;
 		fq_dequeue_skb(sch, f, skb);
 	} else {
 		head->first = f->next;
@@ -1024,6 +1078,7 @@ static int fq_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 
 	st.gc_flows		  = q->stat_gc_flows;
 	st.highprio_packets	  = q->stat_internal_packets;
+	st.fastpath_packets	  = q->internal.stat_fastpath_packets;
 	st.tcp_retrans		  = 0;
 	st.throttled		  = q->stat_throttled;
 	st.flows_plimit		  = q->stat_flows_plimit;
-- 
2.42.0.459.ge4e396fd5e-goog


