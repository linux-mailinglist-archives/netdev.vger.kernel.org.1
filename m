Return-Path: <netdev+bounces-35245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 522FF7A8210
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 14:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66F581C20C81
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 12:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5623347CE;
	Wed, 20 Sep 2023 12:54:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7840E31A8E
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 12:54:28 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373DE99
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 05:54:24 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59eb8ed0e80so33225507b3.2
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 05:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695214463; x=1695819263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x0VgTHk2PJ1j6XQEHf68fMlf4idi54uWxAeee+hu+hc=;
        b=xgA3LcvtQsTshkp1ECp9BsEsK362Rj1ytHA9nUkHqB2dogV6a8oNRJ/ob84FARp7xM
         JJSPNqA/DPZu/RSktJc5+D/UpbwIDNPMZTohuWGdscj7MxpUL8q5+DXd00Pxn8ZOvTRt
         bONuEjCD5+p+RNsCLM8Y900GMNlLtxTW0aEJUxdDMogAqPN/u4fWgKwXmkTBCAnrBnyu
         7t4GqGUy+j+2calqaDPJuHqi6cCuWXRkmL1tjiBtm6PL4yfnesQcvkhFmpgiFki5/gqZ
         OISh/5jD/iE2JnqmewWXdTDIaZbSqQIgDaBG9f/pU+Meb2d+ydHoqt9+NbHQnzhsFew1
         Au1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695214463; x=1695819263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x0VgTHk2PJ1j6XQEHf68fMlf4idi54uWxAeee+hu+hc=;
        b=jUdBJuT1G7rzXVHRhpI5Qe3Zg8y/mB/5ilmdfyhwKD3wc2Pc5QFkwmsIpDglS2msr3
         A0McuMxUfvSIZoxXXVyfDhkD01yBjqCPaRIkw3bndKCdBCT826pJiQPH3KhroY8Q3Dxn
         IfKoDf5Nb7YbuMvhnvq1dF7Ep3h8sssl97ezmeRKcHWZ5UNWGAe9KpOROohUYzWJFAuV
         lVm3aBReD+bX0AvSubmn0O19aeJot/8r8E0POQwN2XXrZRa/El6896cME4ui8ZCXzkQz
         IXDUaCuxCBd/VGlAu5W17zxqUEO74I4JZC7Tiltd+uoITTXX+Y+u1FjNQykqtk8wqYIP
         VoAQ==
X-Gm-Message-State: AOJu0Yw0MiPux8dJrFithZKtgzsWavFq3bZJMNTVt1RVMiE/k85xC/aw
	l32saGiH8lgVjekfBIW9y4qgR9nYbIWFZg==
X-Google-Smtp-Source: AGHT+IHkOc++qc1e3OmSUG+ALRpHHL+5YHKf5f/jCYlfNOebToZwgXM3OlfDtgFSrEOThQcNxgktT/lzkZtfWg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:4081:0:b0:d10:5b67:843c with SMTP id
 n123-20020a254081000000b00d105b67843cmr34788yba.4.1695214463468; Wed, 20 Sep
 2023 05:54:23 -0700 (PDT)
Date: Wed, 20 Sep 2023 12:54:16 +0000
In-Reply-To: <20230920125418.3675569-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230920125418.3675569-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230920125418.3675569-3-edumazet@google.com>
Subject: [PATCH net-next 2/4] net_sched: sch_fq: change how @inactive is tracked
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

Currently, when one fq qdisc has no more packets to send, it can still
have some flows stored in its RR lists (q->new_flows & q->old_flows)

This was a design choice, but what is a bit disturbing is that
the inactive_flows counter does not include the count of empty flows
in RR lists.

As next patch needs to know better if there are active flows,
this change makes inactive_flows exact.

Before the patch, following command on an empty qdisc could have returned:

lpaa17:~# tc -s -d qd sh dev eth1 | grep inactive
  flows 1322 (inactive 1316 throttled 0)
  flows 1330 (inactive 1325 throttled 0)
  flows 1193 (inactive 1190 throttled 0)
  flows 1208 (inactive 1202 throttled 0)

After the patch, we now have:

lpaa17:~# tc -s -d qd sh dev eth1 | grep inactive
  flows 1322 (inactive 1322 throttled 0)
  flows 1330 (inactive 1330 throttled 0)
  flows 1193 (inactive 1193 throttled 0)
  flows 1208 (inactive 1208 throttled 0)

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_fq.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 230300aac3ed1c86c8a52f405a03f67b60848a05..4af43a401dbb4111d5cfaddb4b83fc5c7b63b83d 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -125,7 +125,7 @@ struct fq_sched_data {
 /* Read/Write fields. */
 
 	u32		flows;
-	u32		inactive_flows;
+	u32		inactive_flows; /* Flows with no packet to send. */
 	u32		throttled_flows;
 
 	u64		stat_throttled;
@@ -402,9 +402,12 @@ static void fq_erase_head(struct Qdisc *sch, struct fq_flow *flow,
 static void fq_dequeue_skb(struct Qdisc *sch, struct fq_flow *flow,
 			   struct sk_buff *skb)
 {
+	struct fq_sched_data *q = qdisc_priv(sch);
+
 	fq_erase_head(sch, flow, skb);
 	skb_mark_not_on_list(skb);
-	flow->qlen--;
+	if (--flow->qlen == 0)
+		q->inactive_flows++;
 	qdisc_qstats_backlog_dec(sch, skb);
 	sch->q.qlen--;
 }
@@ -484,13 +487,13 @@ static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return qdisc_drop(skb, sch, to_free);
 	}
 
-	f->qlen++;
+	if (f->qlen++ == 0)
+		q->inactive_flows--;
 	qdisc_qstats_backlog_inc(sch, skb);
 	if (fq_flow_is_detached(f)) {
 		fq_flow_add_tail(&q->new_flows, f);
 		if (time_after(jiffies, f->age + q->flow_refill_delay))
 			f->credit = max_t(u32, f->credit, q->quantum);
-		q->inactive_flows--;
 	}
 
 	/* Note: this overwrites f->age */
@@ -597,7 +600,6 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 			fq_flow_add_tail(&q->old_flows, f);
 		} else {
 			fq_flow_set_detached(f);
-			q->inactive_flows++;
 		}
 		goto begin;
 	}
-- 
2.42.0.459.ge4e396fd5e-goog


