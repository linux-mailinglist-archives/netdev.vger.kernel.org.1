Return-Path: <netdev+bounces-16152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC27374B958
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 00:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 673CE280D54
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 22:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6062D17ACE;
	Fri,  7 Jul 2023 22:01:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51036C2CF
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 22:01:34 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BBFB7
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 15:01:33 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b72c4038b6so2219679a34.0
        for <netdev@vger.kernel.org>; Fri, 07 Jul 2023 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688767292; x=1691359292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXw668lhVjY+nVyco9iMBAc5I6s5jIufQ48UxaWrmLY=;
        b=bhk2aT6a1/9LbHmkIGABaaG3464OnL6FGE2RcCvHKJE0/0Smz35iyuINW5aaWhq1XU
         8joz4ss5QJXEnFp/oG+xlYcHJf6KjSQmlPB0vb/2Srgfy1pVvQjqnWONT094/O0SD+jA
         ifGAPZXYDH3wAIzli6IiDGAAgC2UICptCT4Odwq+EZoEPTJ7YLxK/diE5ZQE0Lazvh+5
         RWPIkE1QFriAsK3K6b2hKpNSEk8eUOExvd4OonbRdeuszw3f3yDnUE6V/cdPHfP07y/2
         qZnx4o2gWGHJvIazqdSeNRSDWKOvHzuOmd9bvqJfXfSL4/rhNSh1A/npusBS2nsEP2O8
         kk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688767292; x=1691359292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXw668lhVjY+nVyco9iMBAc5I6s5jIufQ48UxaWrmLY=;
        b=jcTv8jmtDMlBKbxHzwrtfz9wEbA44ZTVrs9qoY2BWzLbqaAzN1J92LviiYq6obAuX9
         nU9H0W7slpUFd9bZe+H/0C32TyCCZAVfx3TQAs3aF9ayXmrhYnRUnL1TBOGSfqa6F4vy
         xyFOB7kvzmtBEfp70Jnpv1VAxQIDGYUY/y08gUBgodh5fDupkQyjZuknwNhvhIhJQrTM
         ZRSozvbrG2mcdJcR/qicLRhgp2B6623aD/dbegJVpTREkUR99LcyQ4F8lLzedZv/KBgR
         Kk+lGZL+9Qme6mddy/ejuF7XmNFJVPp00Y+2RVe5xlOnQ46HxVB7CEYpNipqykx7yWz4
         bBLA==
X-Gm-Message-State: ABy/qLZJPq0Dl8AeYxsBCO+3w8To2jIoT/3FREh3PZVj8sj4zt8xBB5J
	AY8VZQByp24FOFSdsZ8tN5ciLg7D9xfwVQKcaKQ=
X-Google-Smtp-Source: APBJJlHhjy6w8B94WHluJxwprN/SeCxzAIDNOgsNEX3xB8/3ySQqaPm3CAqOXu+scUCUxf6JkH3OEw==
X-Received: by 2002:a05:6830:1e72:b0:6b7:9a33:8580 with SMTP id m18-20020a0568301e7200b006b79a338580mr6585128otr.30.1688767292346;
        Fri, 07 Jul 2023 15:01:32 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:9dd1:feea:c9a4:7223])
        by smtp.gmail.com with ESMTPSA id p9-20020a9d76c9000000b006b45be2fdc2sm2055533otl.65.2023.07.07.15.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 15:01:32 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	shaozhengchao@huawei.com,
	victor@mojatatu.com,
	simon.horman@corigine.com,
	paolo.valente@unimore.it,
	Pedro Tammela <pctammela@mojatatu.com>,
	Lion <nnamrec@gmail.com>
Subject: [PATCH net v2 3/4] net/sched: sch_qfq: account for stab overhead in qfq_enqueue
Date: Fri,  7 Jul 2023 18:59:59 -0300
Message-Id: <20230707220000.461410-4-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230707220000.461410-1-pctammela@mojatatu.com>
References: <20230707220000.461410-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Lion says:
-------
In the QFQ scheduler a similar issue to CVE-2023-31436
persists.

Consider the following code in net/sched/sch_qfq.c:

static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
                struct sk_buff **to_free)
{
     unsigned int len = qdisc_pkt_len(skb), gso_segs;

    // ...

     if (unlikely(cl->agg->lmax < len)) {
         pr_debug("qfq: increasing maxpkt from %u to %u for class %u",
              cl->agg->lmax, len, cl->common.classid);
         err = qfq_change_agg(sch, cl, cl->agg->class_weight, len);
         if (err) {
             cl->qstats.drops++;
             return qdisc_drop(skb, sch, to_free);
         }

    // ...

     }

Similarly to CVE-2023-31436, "lmax" is increased without any bounds
checks according to the packet length "len". Usually this would not
impose a problem because packet sizes are naturally limited.

This is however not the actual packet length, rather the
"qdisc_pkt_len(skb)" which might apply size transformations according to
"struct qdisc_size_table" as created by "qdisc_get_stab()" in
net/sched/sch_api.c if the TCA_STAB option was set when modifying the qdisc.

A user may choose virtually any size using such a table.

As a result the same issue as in CVE-2023-31436 can occur, allowing heap
out-of-bounds read / writes in the kmalloc-8192 cache.
-------

We can create the issue with the following commands:

tc qdisc add dev $DEV root handle 1: stab mtu 2048 tsize 512 mpu 0 \
overhead 999999999 linklayer ethernet qfq
tc class add dev $DEV parent 1: classid 1:1 htb rate 6mbit burst 15k
tc filter add dev $DEV parent 1: matchall classid 1:1
ping -I $DEV 1.1.1.2

This is caused by incorrectly assuming that qdisc_pkt_len() returns a
length within the QFQ_MIN_LMAX < len < QFQ_MAX_LMAX.

Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
Reported-by: Lion <nnamrec@gmail.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/sch_qfq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 63a5b277c117..befaf74b33ca 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -381,8 +381,13 @@ static int qfq_change_agg(struct Qdisc *sch, struct qfq_class *cl, u32 weight,
 			   u32 lmax)
 {
 	struct qfq_sched *q = qdisc_priv(sch);
-	struct qfq_aggregate *new_agg = qfq_find_agg(q, lmax, weight);
+	struct qfq_aggregate *new_agg;
 
+	/* 'lmax' can range from [QFQ_MIN_LMAX, pktlen + stab overhead] */
+	if (lmax > QFQ_MAX_LMAX)
+		return -EINVAL;
+
+	new_agg = qfq_find_agg(q, lmax, weight);
 	if (new_agg == NULL) { /* create new aggregate */
 		new_agg = kzalloc(sizeof(*new_agg), GFP_ATOMIC);
 		if (new_agg == NULL)
-- 
2.39.2


