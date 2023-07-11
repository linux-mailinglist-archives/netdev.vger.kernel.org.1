Return-Path: <netdev+bounces-16966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0296374F98B
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 23:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E012812B7
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 21:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D221ED24;
	Tue, 11 Jul 2023 21:01:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8A519BDF
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 21:01:29 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B7510F1
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 14:01:28 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b87d505e28so5077251a34.2
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 14:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689109287; x=1691701287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlnDNLdpdnv+uiB8Iv7LsxctH7UI4fZlMEPS3+5XDa4=;
        b=RC01A3frKl+2h6CPdwGYGi1mSfnsVL6K9/1SbXH6mcgZopWrJv2FWA0pT55jKzqgfG
         6rVbpUtaYkumYdFoi0yhwwExwXS6RBuqz0JzOHXtBIVFH0XTNqwCYyUYKvVd+LIERhct
         c7/FOi6sTn0d1Lpv4iVZEw6fxdnI2u2JcTMfh2/KV7M0I7ES5AMPBSiHaKQKqjQEM47b
         BR43RkxcZnIbzm0MWExn4sbGigncWn2pQXi0mXvV3mDaf2qwd/+3aboZA7IZVUVjDBkB
         TibKqpbmoCIXNOLW7YZONYwKCezxrGTiG6Vm2hOqv2yDCnGG7nV2y7OyytiGyLru1r7T
         T4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689109287; x=1691701287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlnDNLdpdnv+uiB8Iv7LsxctH7UI4fZlMEPS3+5XDa4=;
        b=M3dSc+qMoXEfwuNvtOp+83xOVy/973TVFAyrIfZmHcqtgKMaK1ZO1aoY/ZqLTmwoqK
         +lpGuKQ78fgJTYQGd2u7ZXp/lnmlu3lFs7qW7zAl8ejywLdCL+7A5HUqprEMVu4XTbge
         YeehdYYbBhq0b7Pb++98DYs2b0Kfedd5eJy1BQq+jOFg0bFmVf3drrhL2gycTx101SO0
         CosRYuVZn3Dt9dA6Q3hF7ZEnz0Uz1GySXx7bKnMlCtbr4xjt0Mkx2fVVhsC/6P8bZfnU
         BxY0g4V8+bp90eKJN+m2KIUVcZE2kBbDz+D6vf1e2UXpXLX1JBKDHzC7L+/t9Il+65At
         OjGg==
X-Gm-Message-State: ABy/qLbALpqOLjeSkbJAjFvlBjkMTW949De/TjfQ7a9Xu4EVyH6CPdbj
	R/x8sd2pcnrcq77Tx0UgqchB/vB7fnLV/0vR7Lk=
X-Google-Smtp-Source: APBJJlEtAwWPBKyTATbAWq0zNmOeg/OpGavRC4200jfzNYCn30afUorLS0PwNpfE4PY319OB92sOEg==
X-Received: by 2002:a05:6808:f0b:b0:3a3:ac49:77dc with SMTP id m11-20020a0568080f0b00b003a3ac4977dcmr17366105oiw.1.1689109287244;
        Tue, 11 Jul 2023 14:01:27 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:d1e8:1b90:7e91:3217])
        by smtp.gmail.com with ESMTPSA id d5-20020a05680808e500b003a1e965bf39sm1290575oic.2.2023.07.11.14.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 14:01:26 -0700 (PDT)
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
Subject: [PATCH net v3 3/4] net/sched: sch_qfq: account for stab overhead in qfq_enqueue
Date: Tue, 11 Jul 2023 18:01:02 -0300
Message-Id: <20230711210103.597831-4-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230711210103.597831-1-pctammela@mojatatu.com>
References: <20230711210103.597831-1-pctammela@mojatatu.com>
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
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


