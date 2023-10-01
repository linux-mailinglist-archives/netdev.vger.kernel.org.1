Return-Path: <netdev+bounces-37274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C28B97B482F
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 16:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8FF552822B3
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 14:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D675FBFD;
	Sun,  1 Oct 2023 14:51:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF48F1802B
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 14:51:13 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F178FA
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 07:51:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a20c7295bbso44738097b3.0
        for <netdev@vger.kernel.org>; Sun, 01 Oct 2023 07:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696171872; x=1696776672; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B2AGvwXpb0WC95trVEwZsQK9/WLFvPeSaJf59DFRVl4=;
        b=UdchtQt0J/GsPSpAhv4u+3JtRH5wK6F7UOMjcz+U2+NIzQ+m6GzFwhfu1fwqYGAT/P
         1Ies0ra2o6lAilSTMqUoYjcRGBnrbVFwJmVYxY7lD0tkqh7m9wCGF+6FgvQSLhLG1dad
         3BBJcjvM/zwXXsBD1c/sTYXe6bAeQDW2ONPNW/1y5+M2dpWfj0YS9XBY8JrbOv7/DKEO
         4bb3556n9go69WeKUn5hlltjyOuy/MO6BzNAJpUEb3UQy09FI7A/RWn9zeckpmNvISd5
         IecbNIngh2h3G4sQmp/OImj2Bv9Tj8ROy3Ia0n4PP7qISC75pg6lTieAuw/e6wzefyam
         I+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696171872; x=1696776672;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B2AGvwXpb0WC95trVEwZsQK9/WLFvPeSaJf59DFRVl4=;
        b=uroT7AooRlx0zTVPq8ClhP7Phw+0amtHBqaMiqZDz5qxUx47Rp4beOh5WXOkl0clqe
         s94gV65u9FBNYTD7Uo3tyZo2lIHQOVQXcneA+39fW/f1CSTIStwdJntI7RoZ7f8n7ln9
         /NkMKRtQYWleUP/XK6CnfbDPtsfRiBdEzY4XaldkV7i205pBjiVmJfbp9DD51qNalD/x
         lK0cCMQfuv006UwyrndP6NuHPclw6PKIgWEdNNt4ydJ3GO05a9ODEJlnxlduIv0cFO+t
         h6UDzTWk/mhg9TXxJNihUmkELryHIFBh/Q45awuIKRaG+sllKp4qoW12vWnofwx0kSu7
         Pt6g==
X-Gm-Message-State: AOJu0YwfKJLxoGaD3Ay31cTdzgLfigVqWh13nSQhcXD78swsNg26Oeb3
	HwpnB2sinn+jf6Nj+IBpdGgROkK3Jb3EWg==
X-Google-Smtp-Source: AGHT+IE5Y+pt8hg+m7BeXP5McmYyD/GVvAnLvowqKPihfKgVrmPSpKobCjTtyw7fiZI5f4S4L11GGSbXrWcTYg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:ca13:0:b0:56c:e9fe:3cb4 with SMTP id
 p19-20020a81ca13000000b0056ce9fe3cb4mr217492ywi.1.1696171871775; Sun, 01 Oct
 2023 07:51:11 -0700 (PDT)
Date: Sun,  1 Oct 2023 14:51:02 +0000
In-Reply-To: <20231001145102.733450-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231001145102.733450-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231001145102.733450-5-edumazet@google.com>
Subject: [PATCH net-next 4/4] net_sched: sch_fq: add TCA_FQ_WEIGHTS attribute
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

This attribute can be used to tune the per band weight
and report them in "tc qdisc show" output:

qdisc fq 802f: parent 1:9 limit 100000p flow_limit 500p buckets 1024 orphan_mask 1023
 quantum 8364b initial_quantum 41820b low_rate_threshold 550Kbit
 refill_delay 40ms timer_slack 10us horizon 10s horizon_drop
 bands 3 priomap 1 2 2 2 1 2 0 0 1 1 1 1 1 1 1 1 weights 589824 196608 65536
 Sent 236460814 bytes 792991 pkt (dropped 0, overlimits 0 requeues 0)
 rate 25816bit 10pps backlog 0b 0p requeues 0
  flows 4 (inactive 4 throttled 0)
  gc 0 throttled 19 latency 17.6us fastpath 773882

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/uapi/linux/pkt_sched.h |  3 +++
 net/sched/sch_fq.c             | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index ec5ab44d41a2493130670870dc9e68c71187740f..f762a10bfb78ed896d8a5b936045a956d97b3831 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -943,12 +943,15 @@ enum {
 
 	TCA_FQ_PRIOMAP,		/* prio2band */
 
+	TCA_FQ_WEIGHTS,		/* Weights for each band */
+
 	__TCA_FQ_MAX
 };
 
 #define TCA_FQ_MAX	(__TCA_FQ_MAX - 1)
 
 #define FQ_BANDS 3
+#define FQ_MIN_WEIGHT 16384
 
 struct tc_fq_qd_stats {
 	__u64	gc_flows;
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 1bae145750a66f769bd30f1db09203f725801249..1a411fe36c79a86635f319c230a045d653571700 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -919,6 +919,10 @@ static const struct nla_policy fq_policy[TCA_FQ_MAX + 1] = {
 			.type = NLA_BINARY,
 			.len = sizeof(struct tc_prio_qopt),
 		},
+	[TCA_FQ_WEIGHTS]		= {
+			.type = NLA_BINARY,
+			.len = FQ_BANDS * sizeof(s32),
+		},
 };
 
 /* compress a u8 array with all elems <= 3 to an array of 2-bit fields */
@@ -941,6 +945,24 @@ static void fq_prio2band_decompress_crumb(const u8 *in, u8 *out)
 		out[i] = fq_prio2band(in, i);
 }
 
+static int fq_load_weights(struct fq_sched_data *q,
+			   const struct nlattr *attr,
+			   struct netlink_ext_ack *extack)
+{
+	s32 *weights = nla_data(attr);
+	int i;
+
+	for (i = 0; i < FQ_BANDS; i++) {
+		if (weights[i] < FQ_MIN_WEIGHT) {
+			NL_SET_ERR_MSG_MOD(extack, "Incorrect weight");
+			return -EINVAL;
+		}
+	}
+	for (i = 0; i < FQ_BANDS; i++)
+		q->band_flows[i].quantum = weights[i];
+	return 0;
+}
+
 static int fq_load_priomap(struct fq_sched_data *q,
 			   const struct nlattr *attr,
 			   struct netlink_ext_ack *extack)
@@ -1039,6 +1061,9 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
 	if (!err && tb[TCA_FQ_PRIOMAP])
 		err = fq_load_priomap(q, tb[TCA_FQ_PRIOMAP], extack);
 
+	if (!err && tb[TCA_FQ_WEIGHTS])
+		err = fq_load_weights(q, tb[TCA_FQ_WEIGHTS], extack);
+
 	if (tb[TCA_FQ_ORPHAN_MASK])
 		q->orphan_mask = nla_get_u32(tb[TCA_FQ_ORPHAN_MASK]);
 
@@ -1141,6 +1166,7 @@ static int fq_dump(struct Qdisc *sch, struct sk_buff *skb)
 	};
 	u64 horizon = q->horizon;
 	struct nlattr *opts;
+	s32 weights[3];
 
 	opts = nla_nest_start_noflag(skb, TCA_OPTIONS);
 	if (opts == NULL)
@@ -1174,6 +1200,12 @@ static int fq_dump(struct Qdisc *sch, struct sk_buff *skb)
 	if (nla_put(skb, TCA_FQ_PRIOMAP, sizeof(prio), &prio))
 		goto nla_put_failure;
 
+	weights[0] = q->band_flows[0].quantum;
+	weights[1] = q->band_flows[1].quantum;
+	weights[2] = q->band_flows[2].quantum;
+	if (nla_put(skb, TCA_FQ_WEIGHTS, sizeof(weights), &weights))
+		goto nla_put_failure;
+
 	return nla_nest_end(skb, opts);
 
 nla_put_failure:
-- 
2.42.0.582.g8ccd20d70d-goog


