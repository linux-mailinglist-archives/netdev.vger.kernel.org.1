Return-Path: <netdev+bounces-35321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D674D7A8DB9
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 22:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC258B20BAF
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 20:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1397405DB;
	Wed, 20 Sep 2023 20:17:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322AD19BC2
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 20:17:24 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEEBB9
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 13:17:23 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d8486b5e780so359439276.0
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 13:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695241042; x=1695845842; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x0VgTHk2PJ1j6XQEHf68fMlf4idi54uWxAeee+hu+hc=;
        b=3ELrq4n3SfCItAMMKMZDm+xMp3cYcxAsRsCDUWgUCdTdxs/03OgyBaZkjRNP3rp8z0
         fRZPaQEFud5rm0IpnZvxLWe4H1L4Afut5OaESGC2s5FdFQ4ZA9oHW5NwF0vJNAyiMsMX
         LafwONA587ar5eVvBY66Cc5TjVqsdto+HXJ2hBiccbmy960pwt68DeRBi3aFcQLzrHDu
         DohSm6NkYNCNvn1yGiF+M200lNYy5IaaFLQHRKNVh7YJYfbfNviApetHUJuUtqhlB0lP
         D0/jeqH382Aw6m6P7XfGTriPm64x2GOhJzxUlwSdLuaoaKWstfo7MhScjSOfujLrhkGX
         zkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695241042; x=1695845842;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x0VgTHk2PJ1j6XQEHf68fMlf4idi54uWxAeee+hu+hc=;
        b=F5p2c1eVnaxB2xuYdPh4cl4H0pqQ1FG0FPrVg7wIh+Tpfx4gzf/upcaKxCm6/qlEr/
         3HQ3vz/6dXGy+xfASLHiZO7LkX2+oOvAFavj7rV2E7D1YQpx0oIgIHjaGf0mPbeHxgvN
         I7G6+iocjEGpWzMbYlNfMJ0V4OB93Mm/VTWgqjQOyvebFkIVYzMZcoo1mYN+vSXurv2z
         e+ciWKtuKBOATVCwxhqG2nXtaXnfc6IF3NZPLikJwas5qUlgAYBHni7vDSkGzuUcPi+j
         TQHzBI0AlGCmaLXj6R0LKB5hjxfJ8iLlqpbGvKPtRiKJE34RM4l5zJVhI60UEisPF/+o
         MZVA==
X-Gm-Message-State: AOJu0YxHr+GZxVuYJkANNbVKgGDsLyG3n+erHByiqXNlNUDh0yefKhaM
	lxRVnT2uzKr8dyOt7ecmSCyHF84roO2Imw==
X-Google-Smtp-Source: AGHT+IESLstp/5tlpW41WwmCajP9IDpf8gUZ2FWEhBaYJrl9NHblRe3yGdyWrOWGP/ikuOm9/VJ8whA/AVwJOA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1802:b0:d77:8641:670c with SMTP
 id cf2-20020a056902180200b00d778641670cmr56691ybb.10.1695241042247; Wed, 20
 Sep 2023 13:17:22 -0700 (PDT)
Date: Wed, 20 Sep 2023 20:17:13 +0000
In-Reply-To: <20230920201715.418491-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230920201715.418491-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230920201715.418491-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/5] net_sched: sch_fq: change how @inactive is tracked
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
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


