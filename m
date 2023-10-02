Return-Path: <netdev+bounces-37412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114BF7B53CA
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 15:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 44A07B20B4C
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 13:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B02C18E28;
	Mon,  2 Oct 2023 13:17:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF93718C2E
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 13:17:48 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906BBAB
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 06:17:46 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59e8ebc0376so287013927b3.2
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 06:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696252666; x=1696857466; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0x5U1CORmqnNqv8Gk9jNXGpAjh9/RHYxeRNYFDDJlOE=;
        b=p4gt7WqCDv3gIsA1JtOvotl1mxIF3uZjAuoxPLjsWsQ2j63n9nkmpBqiuoBAcMMhRd
         PR2AezSKgALnjBrv/3KVcGLSB4dv6r1bUkJ+AtGVrSkdzeOZLIb+1aOqTjq+3ts9ALuB
         YKKuAJborfWng3yJt9wz8XAGcutWHlZJN/yBmpoANgx5KLo+xXJh7w4Q2NQzJgnEd6xB
         yh2d5K5yCALYKarA9/5QuMXT+uVhACV8+xGZtUnDhC/mZ+pDfAQ5g9Dvokc6bMpaX9Dd
         M0L2AtXnB590IR9iP4NZxdZN7rmX9cCoA2RZS79lPLr4SVhC+tzd6QHmVfGMFAGfZqZt
         Ku4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696252666; x=1696857466;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0x5U1CORmqnNqv8Gk9jNXGpAjh9/RHYxeRNYFDDJlOE=;
        b=Vbi7rRtrby+M89OM10HcRGrmuPf9H8KpdtiSj4qe1ybvJbs0t3rFvvIHS8JEZzuL8Y
         +d1On0d9uXC1ceKE5RtZIVr1ITg384OfgyK4U7VXYTlPexCmOkqiJKTB5O3ezMOqIrEd
         1dguYCo6da1fe2iuOgYo4Ufiuo0J+pOI38H1r8tT9fQggw4iNx09JJBlpFHG8VecWn56
         wtx2NIWyXzqEDQYtYyuoNACl0fHGtWh5n3/LMLcDmRakZayPGUSeUYdRlt/ctrh0LuS+
         Rmk5lt1XU0zP8QEgDXUtALW6Nalh7M8rdk0+V3pT7XJUh3A/BqwnELMoPB9W70+VDOrV
         rEqA==
X-Gm-Message-State: AOJu0Yz9WfXiOKqcetHU9ZhzQHhbIhNoDmXfvqHsJV0ueSQTcrVgH340
	anAJ6y7XJitWzg8n6LpD4qqxTAwp4/abuw==
X-Google-Smtp-Source: AGHT+IE0AvhY+O5dECnfcaKnB7L9x0mKlI0Yu+2wEOcaf0ff4jy/rDN2CjLONjUOIWoLcd35vO3XIqSckYqYyg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:ad5b:0:b0:583:4f82:b9d9 with SMTP id
 l27-20020a81ad5b000000b005834f82b9d9mr177440ywk.5.1696252665853; Mon, 02 Oct
 2023 06:17:45 -0700 (PDT)
Date: Mon,  2 Oct 2023 13:17:35 +0000
In-Reply-To: <20231002131738.1868703-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231002131738.1868703-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231002131738.1868703-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/4] net_sched: sch_fq: remove q->ktime_cache
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Dave Taht <dave.taht@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Now that both enqueue() and dequeue() need to use ktime_get_ns(),
there is no point wasting 8 bytes in struct fq_sched_data.

This makes room for future fields. ;)

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-By: Dave Taht <dave.taht@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/sched/sch_fq.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index d35419db7b9407cedc8f48eaab783f41b366b2a2..818ac786379d4de1812e7be7d883adcbef4fc737 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -106,7 +106,6 @@ struct fq_sched_data {
 
 	struct rb_root	delayed;	/* for rate limited flows */
 	u64		time_next_delayed_flow;
-	u64		ktime_cache;	/* copy of last ktime_get_ns() */
 	unsigned long	unthrottle_latency_ns;
 
 	struct fq_flow	internal;	/* for non classified or high prio packets */
@@ -282,12 +281,13 @@ static void fq_gc(struct fq_sched_data *q,
  *
  * FQ can not use generic TCQ_F_CAN_BYPASS infrastructure.
  */
-static bool fq_fastpath_check(const struct Qdisc *sch, struct sk_buff *skb)
+static bool fq_fastpath_check(const struct Qdisc *sch, struct sk_buff *skb,
+			      u64 now)
 {
 	const struct fq_sched_data *q = qdisc_priv(sch);
 	const struct sock *sk;
 
-	if (fq_skb_cb(skb)->time_to_send > q->ktime_cache)
+	if (fq_skb_cb(skb)->time_to_send > now)
 		return false;
 
 	if (sch->q.qlen != 0) {
@@ -317,7 +317,8 @@ static bool fq_fastpath_check(const struct Qdisc *sch, struct sk_buff *skb)
 	return true;
 }
 
-static struct fq_flow *fq_classify(struct Qdisc *sch, struct sk_buff *skb)
+static struct fq_flow *fq_classify(struct Qdisc *sch, struct sk_buff *skb,
+				   u64 now)
 {
 	struct fq_sched_data *q = qdisc_priv(sch);
 	struct rb_node **p, *parent;
@@ -360,7 +361,7 @@ static struct fq_flow *fq_classify(struct Qdisc *sch, struct sk_buff *skb)
 		sk = (struct sock *)((hash << 1) | 1UL);
 	}
 
-	if (fq_fastpath_check(sch, skb)) {
+	if (fq_fastpath_check(sch, skb, now)) {
 		q->internal.stat_fastpath_packets++;
 		return &q->internal;
 	}
@@ -497,9 +498,9 @@ static void flow_queue_add(struct fq_flow *flow, struct sk_buff *skb)
 }
 
 static bool fq_packet_beyond_horizon(const struct sk_buff *skb,
-				    const struct fq_sched_data *q)
+				     const struct fq_sched_data *q, u64 now)
 {
-	return unlikely((s64)skb->tstamp > (s64)(q->ktime_cache + q->horizon));
+	return unlikely((s64)skb->tstamp > (s64)(now + q->horizon));
 }
 
 static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
@@ -507,27 +508,28 @@ static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 {
 	struct fq_sched_data *q = qdisc_priv(sch);
 	struct fq_flow *f;
+	u64 now;
 
 	if (unlikely(sch->q.qlen >= sch->limit))
 		return qdisc_drop(skb, sch, to_free);
 
-	q->ktime_cache = ktime_get_ns();
+	now = ktime_get_ns();
 	if (!skb->tstamp) {
-		fq_skb_cb(skb)->time_to_send = q->ktime_cache;
+		fq_skb_cb(skb)->time_to_send = now;
 	} else {
 		/* Check if packet timestamp is too far in the future. */
-		if (fq_packet_beyond_horizon(skb, q)) {
+		if (fq_packet_beyond_horizon(skb, q, now)) {
 			if (q->horizon_drop) {
 					q->stat_horizon_drops++;
 					return qdisc_drop(skb, sch, to_free);
 			}
 			q->stat_horizon_caps++;
-			skb->tstamp = q->ktime_cache + q->horizon;
+			skb->tstamp = now + q->horizon;
 		}
 		fq_skb_cb(skb)->time_to_send = skb->tstamp;
 	}
 
-	f = fq_classify(sch, skb);
+	f = fq_classify(sch, skb, now);
 
 	if (f != &q->internal) {
 		if (unlikely(f->qlen >= q->flow_plimit)) {
@@ -602,7 +604,7 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 		goto out;
 	}
 
-	q->ktime_cache = now = ktime_get_ns();
+	now = ktime_get_ns();
 	fq_check_throttled(q, now);
 begin:
 	head = &q->new_flows;
-- 
2.42.0.582.g8ccd20d70d-goog


