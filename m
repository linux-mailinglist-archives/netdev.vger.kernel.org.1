Return-Path: <netdev+bounces-37415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B1A7B53CB
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 15:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id EE4941C209CB
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 13:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4F118E3C;
	Mon,  2 Oct 2023 13:17:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686C51947C
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 13:17:54 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8327DAD
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 06:17:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7ec535fe42so23958768276.1
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 06:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696252671; x=1696857471; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=40D/EJLvIc7rOlieYF89EpnJ1bo+scR7OAZkssazo5U=;
        b=UeQ/bNr19qwIWw0WdvCZIcQg8VcW92fkYMgI6raXdopcBZ1QzE+H9XNZO9OgdzoABf
         GD+cqbD/ztlKeuATGTB4C5fLFamok294eQI9jtqu4DrA/gDJEKPWDDgVE2MqoXeNKH5w
         0Zy3OUfdF7s3Ioy2GW06SIIDlA/qHZxUE/HXfFG8PLsGief6HAmEv+ypokc58hq9HuXO
         jkTFOpUGTqWrD6HdXHuftO5A/6A7BIjWvXv39lpzI0Bi7cIDVKeJ3H9EE+4A6GdvAN8Z
         ymjlpQ7jxdXkNZ40Dt+qtjltDHsextdadV0jI6IZN3iajfV7qqfjyXVzrC8g0pLrm3vs
         VZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696252671; x=1696857471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=40D/EJLvIc7rOlieYF89EpnJ1bo+scR7OAZkssazo5U=;
        b=GB6xV/WdpZ3MzFFBz+hdNFvXHVneXP/gb+lVlKzF/a0Tf2ipSw/Z6zHV0jzFcFWjUm
         BwfEkjzJIOgNJ72NJgn8TDOuJYie+ZeFzdiZ2gmRBl0rJwsnubMpWH7xF1AyVeRXESoS
         zNA2qCjq5uMprMeyLoc43E+CAUI9eZUqzhKsm8j0LUXDSbA4edhCvMEwkUEYCBxNkgfw
         ymDmFAUF//qmjjmgtKpPFiEVRFTmsVzvV4/JAhRa9YcIegOTSBj3dGJSr+Iy9hED3QDp
         3hbmfPsZVOUtso2Xki4RSsoildTyNH+x5lYQmUMVpk2xmf4+acMnR8XhAckqL7H+cZ3d
         SUrQ==
X-Gm-Message-State: AOJu0YxXaj9LL9BWpiSjwEtthu5P3zwjwp1YHzKA4BH5O97zZlPsg9/2
	1Jv+BUh+zJV8epbDZxmqjge5RFOKymykpg==
X-Google-Smtp-Source: AGHT+IEFH//qd8Ljpzoa6/1o7XSPMV8qpLwmc0oH9lmBxiyr2XnsZDtGM6gzbAhyyKS2606bqAhrAazbajEtUg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:cc54:0:b0:d81:7d48:a459 with SMTP id
 l81-20020a25cc54000000b00d817d48a459mr188031ybf.8.1696252671687; Mon, 02 Oct
 2023 06:17:51 -0700 (PDT)
Date: Mon,  2 Oct 2023 13:17:38 +0000
In-Reply-To: <20231002131738.1868703-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231002131738.1868703-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231002131738.1868703-5-edumazet@google.com>
Subject: [PATCH v2 net-next 4/4] net_sched: sch_fq: add TCA_FQ_WEIGHTS attribute
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
Acked-By: Dave Taht <dave.taht@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 include/uapi/linux/pkt_sched.h |  3 +++
 net/sched/sch_fq.c             | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

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
index 081105801fa674a74a570027e4681873aed0430f..8eacdb54e72f4412af1834bfdb2c387d41516349 100644
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
@@ -941,6 +945,25 @@ static void fq_prio2band_decompress_crumb(const u8 *in, u8 *out)
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
+			NL_SET_ERR_MSG_FMT_MOD(extack, "Weight %d less that minimum allowed %d",
+					       weights[i], FQ_MIN_WEIGHT);
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
@@ -1040,6 +1063,9 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
 	if (!err && tb[TCA_FQ_PRIOMAP])
 		err = fq_load_priomap(q, tb[TCA_FQ_PRIOMAP], extack);
 
+	if (!err && tb[TCA_FQ_WEIGHTS])
+		err = fq_load_weights(q, tb[TCA_FQ_WEIGHTS], extack);
+
 	if (tb[TCA_FQ_ORPHAN_MASK])
 		q->orphan_mask = nla_get_u32(tb[TCA_FQ_ORPHAN_MASK]);
 
@@ -1142,6 +1168,7 @@ static int fq_dump(struct Qdisc *sch, struct sk_buff *skb)
 	};
 	u64 horizon = q->horizon;
 	struct nlattr *opts;
+	s32 weights[3];
 
 	opts = nla_nest_start_noflag(skb, TCA_OPTIONS);
 	if (opts == NULL)
@@ -1175,6 +1202,12 @@ static int fq_dump(struct Qdisc *sch, struct sk_buff *skb)
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


