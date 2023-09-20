Return-Path: <netdev+bounces-35322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E607A8DBA
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 22:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DD94281AE1
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 20:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30210405F5;
	Wed, 20 Sep 2023 20:17:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8A2405E6
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 20:17:26 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83390A9
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 13:17:24 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59bdac026f7so3671497b3.0
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 13:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695241043; x=1695845843; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cZLV6TJKtldFT3YtoCDoFAorKSdb4xsV756EtQFVYMU=;
        b=gzd5lI6pBZWjFz+eSRWBr99pPCrw1qpvwiocseZhSWqF6cQRiCRypmM61tIjTVgrZk
         R+teH8nCclJeHz71WZ97lIiKfLCfgTF3GvOJ0HOcDOJWSwYKSKiei0MpwL7Lk2FGNvRP
         kuDdBD+BZsIu2Uon/kHNqP77Cieh2sHgzFRoqsFo0jpwmlrZs66xVzLr0y1DUCqCc7HE
         PgSss19tUY+FugKWVeOljvDz1WtBiBY/cO7SuxZRfBcBfaKQLxy/WMiOC/efER45+AEt
         DbSbgrqSWqaU4bzu5SsvLaSg69gquA5H6zq28nwH6HROswH1xWx5rOXW5TZgvtRFBo5M
         FImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695241043; x=1695845843;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZLV6TJKtldFT3YtoCDoFAorKSdb4xsV756EtQFVYMU=;
        b=TVK5vnztWTlUIS+0RuluO7HYhbIh2+NahwQN0J7i45pSUgUiVMGgUxGkGpu3TPU541
         sMgIpYE+mNyqAY54CjZpU3TDKbaSuFkTCMI8xiBunpKtCuqeRMDmlI001O5vC/PDLbOt
         /LuHq6RWXm6fxBiLtS3T/SwsbS7boO6Bk6dKwTXZRJHK1jnD4k+9HdBjF6z8OzQdZJkX
         4/ZPNKJV/GA2WstPYXbdv/nDf7AzgZTzJeWGKaRVc73919CA87gJzbkZAYTrb2EHpcfL
         gm9p8DulRM+bgCwfNfjSFb4KYdFShdzjJaI6ccZ5gD/LwLuIDAc/2XnSAPnsSnig/bVO
         OEYg==
X-Gm-Message-State: AOJu0YwriplEC5XDIBFKcHckCGKykftSYPlRa7pITUAw/s1Bi4Y9vMWX
	+TyyN4c3cmKWm+yLTlE7US39yKeFr3A2cg==
X-Google-Smtp-Source: AGHT+IEn6dLKiR4SGHkuL+3KqV+LTQC2VCt5xKnn34lNWb6Ip8bmm2sOtPFjW0B26oC/JWvGKJWP6fTIQUjE/Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:c84a:0:b0:59b:db15:a08e with SMTP id
 k10-20020a81c84a000000b0059bdb15a08emr60526ywl.5.1695241043793; Wed, 20 Sep
 2023 13:17:23 -0700 (PDT)
Date: Wed, 20 Sep 2023 20:17:14 +0000
In-Reply-To: <20230920201715.418491-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230920201715.418491-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230920201715.418491-5-edumazet@google.com>
Subject: [PATCH v2 net-next 4/5] net_sched: sch_fq: add fast path for mostly
 idle qdisc
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
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
I have measured a 5 % increase of throughput on a tcp_rr intensive workload.

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
 net/sched/sch_fq.c             | 128 +++++++++++++++++++++++----------
 2 files changed, 92 insertions(+), 37 deletions(-)

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
index 4af43a401dbb4111d5cfaddb4b83fc5c7b63b83d..5cf3b50a24d58d0e22c33997592696c4a03ec8ee 100644
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
@@ -134,7 +140,7 @@ struct fq_sched_data {
 
 /* Seldom used fields. */
 
-	u64		stat_internal_packets;
+	u64		stat_internal_packets; /* aka highprio */
 	u64		stat_ce_mark;
 	u64		stat_horizon_drops;
 	u64		stat_horizon_caps;
@@ -266,17 +272,64 @@ static void fq_gc(struct fq_sched_data *q,
 	kmem_cache_free_bulk(fq_flow_cachep, fcnt, tofree);
 }
 
-static struct fq_flow *fq_classify(struct sk_buff *skb, struct fq_sched_data *q)
+/* Fast path can be used if :
+ * 1) Packet tstamp is in the past.
+ * 2) FQ qlen == 0   OR
+ *   (no flow is currently eligible for transmit,
+ *    AND fast path queue has less than 8 packets)
+ * 3) No SO_MAX_PACING_RATE on the socket (if any).
+ * 4) No @maxrate attribute on this qdisc,
+ *
+ * FQ can not use generic TCQ_F_CAN_BYPASS infrastructure.
+ */
+static bool fq_fastpath_check(const struct Qdisc *sch, struct sk_buff *skb)
+{
+	const struct fq_sched_data *q = qdisc_priv(sch);
+	const struct sock *sk;
+
+	if (fq_skb_cb(skb)->time_to_send > q->ktime_cache)
+		return false;
+
+	if (sch->q.qlen != 0) {
+		/* Even if some packets are stored in this qdisc,
+		 * we can still enable fast path if all of them are
+		 * scheduled in the future (ie no flows are eligible)
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
+	return true;
+}
+
+static struct fq_flow *fq_classify(struct Qdisc *sch, struct sk_buff *skb)
 {
+	struct fq_sched_data *q = qdisc_priv(sch);
 	struct rb_node **p, *parent;
 	struct sock *sk = skb->sk;
 	struct rb_root *root;
 	struct fq_flow *f;
 
 	/* warning: no starvation prevention... */
-	if (unlikely((skb->priority & TC_PRIO_MAX) == TC_PRIO_CONTROL))
+	if (unlikely((skb->priority & TC_PRIO_MAX) == TC_PRIO_CONTROL)) {
+		q->stat_internal_packets++; /* highprio packet */
 		return &q->internal;
-
+	}
 	/* SYNACK messages are attached to a TCP_NEW_SYN_RECV request socket
 	 * or a listener (SYNCOOKIE mode)
 	 * 1) request sockets are not full blown,
@@ -307,6 +360,11 @@ static struct fq_flow *fq_classify(struct sk_buff *skb, struct fq_sched_data *q)
 		sk = (struct sock *)((hash << 1) | 1UL);
 	}
 
+	if (fq_fastpath_check(sch, skb)) {
+		q->internal.stat_fastpath_packets++;
+		return &q->internal;
+	}
+
 	root = &q->fq_root[hash_ptr(sk, q->fq_trees_log)];
 
 	if (q->flows >= (2U << q->fq_trees_log) &&
@@ -402,12 +460,8 @@ static void fq_erase_head(struct Qdisc *sch, struct fq_flow *flow,
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
@@ -459,49 +513,45 @@ static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
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
-	if (unlikely(f->qlen >= q->flow_plimit && f != &q->internal)) {
-		q->stat_flows_plimit++;
-		return qdisc_drop(skb, sch, to_free);
-	}
+	f = fq_classify(sch, skb);
 
-	if (f->qlen++ == 0)
-		q->inactive_flows--;
-	qdisc_qstats_backlog_inc(sch, skb);
-	if (fq_flow_is_detached(f)) {
-		fq_flow_add_tail(&q->new_flows, f);
-		if (time_after(jiffies, f->age + q->flow_refill_delay))
-			f->credit = max_t(u32, f->credit, q->quantum);
+	if (f != &q->internal) {
+		if (unlikely(f->qlen >= q->flow_plimit)) {
+			q->stat_flows_plimit++;
+			return qdisc_drop(skb, sch, to_free);
+		}
+
+		if (fq_flow_is_detached(f)) {
+			fq_flow_add_tail(&q->new_flows, f);
+			if (time_after(jiffies, f->age + q->flow_refill_delay))
+				f->credit = max_t(u32, f->credit, q->quantum);
+		}
+
+		if (f->qlen == 0)
+			q->inactive_flows--;
 	}
 
+	f->qlen++;
 	/* Note: this overwrites f->age */
 	flow_queue_add(f, skb);
 
-	if (unlikely(f == &q->internal)) {
-		q->stat_internal_packets++;
-	}
+	qdisc_qstats_backlog_inc(sch, skb);
 	sch->q.qlen++;
 
 	return NET_XMIT_SUCCESS;
@@ -549,6 +599,7 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 
 	skb = fq_peek(&q->internal);
 	if (unlikely(skb)) {
+		q->internal.qlen--;
 		fq_dequeue_skb(sch, &q->internal, skb);
 		goto out;
 	}
@@ -592,6 +643,8 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 			INET_ECN_set_ce(skb);
 			q->stat_ce_mark++;
 		}
+		if (--f->qlen == 0)
+			q->inactive_flows++;
 		fq_dequeue_skb(sch, f, skb);
 	} else {
 		head->first = f->next;
@@ -1024,6 +1077,7 @@ static int fq_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 
 	st.gc_flows		  = q->stat_gc_flows;
 	st.highprio_packets	  = q->stat_internal_packets;
+	st.fastpath_packets	  = q->internal.stat_fastpath_packets;
 	st.tcp_retrans		  = 0;
 	st.throttled		  = q->stat_throttled;
 	st.flows_plimit		  = q->stat_flows_plimit;
-- 
2.42.0.459.ge4e396fd5e-goog


