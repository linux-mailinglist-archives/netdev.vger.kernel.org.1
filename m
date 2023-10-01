Return-Path: <netdev+bounces-37272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3547B482C
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 16:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4C11C281F78
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 14:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB97916436;
	Sun,  1 Oct 2023 14:51:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519E6FBF2
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 14:51:09 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C11DA
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 07:51:07 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59f8040b2ffso203528787b3.3
        for <netdev@vger.kernel.org>; Sun, 01 Oct 2023 07:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696171866; x=1696776666; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nI/NlHADxwd+Ftu+PAcwO8xZarE7070jRku+HQBTTLs=;
        b=jLmgF0eMY2xzG9D2o6XNU9a7w2pKa0FQZ9ETPGIVyfbw5+XYtVo4d5sm5qmDyn3Z+i
         fjhOtu20N67Q7LMOfoZdT/dBrGZoxp47VZkHxvyBti2Yhs6MuiTpH5koj6opnyMOR9ol
         RjUsrpIwzgFFaEnLNTF8Ckn1KG2URkNyKDsVusijYSLCA0cM0JArYmPEnBP/we+PrsLe
         tkH0AY/+xIHQrR6pZM+k4has5AdZGYGuyMN5MbdSf5zsIcAOBxshu/+fjgl9nK2fryN6
         fPBG2JAPfU0eAF3Vw1O5d9KEsYs5iX1LNu6HIV0md6juRXNlSIt+W3lqmeMKPNDZSGyT
         ejOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696171866; x=1696776666;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nI/NlHADxwd+Ftu+PAcwO8xZarE7070jRku+HQBTTLs=;
        b=EvYo+IFIk1bKTVhzpuZ3AstDbW6o0kpihUwTgjZM9m27G3qMPwC58VIsSwiVe+Ahva
         MKOsZ/R/WqK7bJVH1efDWI8qX7dziHIzXELBlm3lPIACKTrzpJI3wwKD9OIxutV6Rk7E
         N8jhy2U4OXbbWO78QQaglGMrytcp2Bl5jiMrWRUYNGbsT19HZz9Rv4BqpQM4SFsRZLyz
         Il7lGAa87jsAUxddG6QPWTXm9kmgSxcqzUXlfR7Wg4zm5UEfJbY/SnxFtu8+03xnR17e
         BbD2w2HhgwweNudfqKnXfSHHfbaDXjixxXKz1JYwNZ8Lnk5mlGzUmo/oNMTgV+f4gNRC
         svHQ==
X-Gm-Message-State: AOJu0YwayRfOlIlhuGSH0A9JxVIZTswWYKXlKOPA6c4IDpMRUdxQPuej
	dc1QQbZl4X8M0rFUHiRiPZvvQr18QTzUmA==
X-Google-Smtp-Source: AGHT+IEdWtxDMXmY//gQIaRVhoGS3jG1V9Anio/Iuiucp6Dp2w/GBMXbEc5dcOa0zDp0ygRfqOVn+TYTeupLzw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:3412:b0:579:f832:74b with SMTP
 id fn18-20020a05690c341200b00579f832074bmr161726ywb.10.1696171866604; Sun, 01
 Oct 2023 07:51:06 -0700 (PDT)
Date: Sun,  1 Oct 2023 14:50:59 +0000
In-Reply-To: <20231001145102.733450-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231001145102.733450-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231001145102.733450-2-edumazet@google.com>
Subject: [PATCH net-next 1/4] net_sched: sch_fq: remove q->ktime_cache
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

Now that both enqueue() and dequeue() need to use ktime_get_ns(),
there is no point wasting 8 bytes in struct fq_sched_data.

This makes room for future fields. ;)

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_fq.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 681bbf34b70763032c68d89003307ceec8ab46b4..91d71a538b71f9208f2507fd11443f784dffa966 100644
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


