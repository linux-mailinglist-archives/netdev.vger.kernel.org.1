Return-Path: <netdev+bounces-35024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B31E37A677A
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 17:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C0872817D0
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 15:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766293B792;
	Tue, 19 Sep 2023 15:00:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8F03B784
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 15:00:02 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5EFBE
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 07:59:58 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1d544a4a315so3693543fac.3
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 07:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1695135597; x=1695740397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ufVOoMpvW9FQfBsBIFyklxU9HWLd48epQsjq/3gNMsg=;
        b=eVbFwZmZyctl5nJFvI4dfM4BVfv9fvfrp0vkpsIPntofYNaCpPjCj/5I1CCW3g2jUK
         MOl7h1fEHfaJVIZHdKuXwhEf1kGqerhi4+f0TFsxifKRVEC1oTPFQNCvxDghH6i3ta35
         lrag7RFRQc09LH6GStOaarHcn+dTMV/McSTFfAyUwdYEGB5NQhvEFzta0vfCUU2L2+A2
         Gt2EdHj9z6Y+mDIAtW/95L49JZFXjIBLfCzpQc79e+QmhJgHBlemaB1IP/qLm9nttvpD
         94T25ajK+av5XsdbvdRrpVbBuEHTemMUSVMLVWlkhe0ngZULbGNtvwpFMAcYbB0twF+x
         XSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695135597; x=1695740397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ufVOoMpvW9FQfBsBIFyklxU9HWLd48epQsjq/3gNMsg=;
        b=nrBJMSePUcMxFjdtvN3hUUzLdsss8p3Pf8ziEFMn49bGARy+sNFkGCY9Ehiqdop9Y+
         f5A7NaCxEpZTftu+gI7OhsAin3xLx9fRZvNYLuxz42ggNZ1vthoK7UovGNHnV0yOXSzs
         rFGNhkPSb6cH9zuUqxlhcX1u7DY+/pI242RmdMQgmjVq3EKLoj1srlSdqC2rSRGyxe41
         l5IcuXLqEDUFLOMUUlKMSGqFitotqlZiDRCBpzEPINsGN1zakh34DhAoCHEpyMe2HeQ+
         Yb5BV+JEYhgVYRPIodlOHFGSOZCo4vA4ssLnPQhdKlI0HlymOupiOltiYV2CGERyEjV1
         6aAw==
X-Gm-Message-State: AOJu0Yx8cNp/qHOrqtEQQXLPAR7mtnDvujyZKyDubgguS8A/V41EyYMi
	uwyDPkhJuB7BfajjaKfKv9ydhtvrBlqKj466Xdw=
X-Google-Smtp-Source: AGHT+IEBQDJVtRdT5sMzsOjiAfc1sEwK2IjWaCDWKzzihav7EFAllQsAzZp3kJoL4FD8RhPlWDD9sw==
X-Received: by 2002:a05:6870:6127:b0:1bb:8333:ab8a with SMTP id s39-20020a056870612700b001bb8333ab8amr13590545oae.4.1695135597535;
        Tue, 19 Sep 2023 07:59:57 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f1:e2c2:58f9:c053:39fb:8dc4:3de5])
        by smtp.gmail.com with ESMTPSA id h4-20020a056870860400b001d0ff8c90fbsm6180918oal.33.2023.09.19.07.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 07:59:57 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	paulb@nvidia.com
Cc: netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH net-next 1/1] net/sched: Disambiguate verdict from return code
Date: Tue, 19 Sep 2023 11:59:51 -0300
Message-ID: <20230919145951.352548-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently there is no way to distinguish between an error and a
classification verdict. This patch adds the verdict field as a part of
struct tcf_result. That way, tcf_classify can return a proper
error number when it fails, and we keep the classification result
information encapsulated in struct tcf_result.

Also add values SKB_DROP_REASON_TC_EGRESS_ERROR and
SKB_DROP_REASON_TC_INGRESS_ERROR to enum skb_drop_reason.
With that we can distinguish between a drop from a processing error versus
a drop from classification.

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 include/net/dropreason-core.h |  6 +++++
 include/net/sch_generic.h     |  7 ++++++
 net/core/dev.c                | 42 ++++++++++++++++++++++++++---------
 net/sched/cls_api.c           | 38 ++++++++++++++++++++-----------
 net/sched/sch_cake.c          | 32 +++++++++++++-------------
 net/sched/sch_drr.c           | 33 +++++++++++++--------------
 net/sched/sch_ets.c           |  6 +++--
 net/sched/sch_fq_codel.c      | 29 ++++++++++++------------
 net/sched/sch_fq_pie.c        | 28 +++++++++++------------
 net/sched/sch_hfsc.c          |  6 +++--
 net/sched/sch_htb.c           |  6 +++--
 net/sched/sch_multiq.c        |  6 +++--
 net/sched/sch_prio.c          |  7 ++++--
 net/sched/sch_qfq.c           | 34 +++++++++++++---------------
 net/sched/sch_sfb.c           | 29 ++++++++++++------------
 net/sched/sch_sfq.c           | 28 +++++++++++------------
 16 files changed, 195 insertions(+), 142 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index a587e83fc169..b1c069c8e7f2 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -80,6 +80,8 @@
 	FN(IPV6_NDISC_BAD_OPTIONS)	\
 	FN(IPV6_NDISC_NS_OTHERHOST)	\
 	FN(QUEUE_PURGE)			\
+	FN(TC_EGRESS_ERROR)		\
+	FN(TC_INGRESS_ERROR)		\
 	FNe(MAX)
 
 /**
@@ -345,6 +347,10 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_IPV6_NDISC_NS_OTHERHOST,
 	/** @SKB_DROP_REASON_QUEUE_PURGE: bulk free. */
 	SKB_DROP_REASON_QUEUE_PURGE,
+	/** @SKB_DROP_REASON_TC_EGRESS_ERROR: dropped in TC egress HOOK due to error */
+	SKB_DROP_REASON_TC_EGRESS_ERROR,
+	/** @SKB_DROP_REASON_TC_INGRESS_ERROR: dropped in TC ingress HOOK due to error */
+	SKB_DROP_REASON_TC_INGRESS_ERROR,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index f232512505f8..9a3f71d2545e 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -326,6 +326,7 @@ struct Qdisc_ops {
 
 
 struct tcf_result {
+	u32 verdict;
 	union {
 		struct {
 			unsigned long	class;
@@ -336,6 +337,12 @@ struct tcf_result {
 	};
 };
 
+static inline void tcf_result_set_verdict(struct tcf_result *res,
+					  const u32 verdict)
+{
+	res->verdict = verdict;
+}
+
 struct tcf_chain;
 
 struct tcf_proto_ops {
diff --git a/net/core/dev.c b/net/core/dev.c
index ccff2b6ef958..1450f4741d9b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3910,31 +3910,39 @@ EXPORT_SYMBOL_GPL(netdev_xmit_skip_txqueue);
 #endif /* CONFIG_NET_EGRESS */
 
 #ifdef CONFIG_NET_XGRESS
-static int tc_run(struct tcx_entry *entry, struct sk_buff *skb)
+static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
+		  struct tcf_result *res)
 {
-	int ret = TC_ACT_UNSPEC;
+	int ret = 0;
 #ifdef CONFIG_NET_CLS_ACT
 	struct mini_Qdisc *miniq = rcu_dereference_bh(entry->miniq);
-	struct tcf_result res;
 
-	if (!miniq)
+	if (!miniq) {
+		tcf_result_set_verdict(res, TC_ACT_UNSPEC);
 		return ret;
+	}
 
 	tc_skb_cb(skb)->mru = 0;
 	tc_skb_cb(skb)->post_ct = false;
 
 	mini_qdisc_bstats_cpu_update(miniq, skb);
-	ret = tcf_classify(skb, miniq->block, miniq->filter_list, &res, false);
+	ret = tcf_classify(skb, miniq->block, miniq->filter_list, res, false);
+	if (ret < 0) {
+		mini_qdisc_qstats_cpu_drop(miniq);
+		return ret;
+	}
 	/* Only tcf related quirks below. */
-	switch (ret) {
+	switch (res->verdict) {
 	case TC_ACT_SHOT:
 		mini_qdisc_qstats_cpu_drop(miniq);
 		break;
 	case TC_ACT_OK:
 	case TC_ACT_RECLASSIFY:
-		skb->tc_index = TC_H_MIN(res.classid);
+		skb->tc_index = TC_H_MIN(res->classid);
 		break;
 	}
+#else
+	tcf_result_set_verdict(res, TC_ACT_UNSPEC);
 #endif /* CONFIG_NET_CLS_ACT */
 	return ret;
 }
@@ -3977,6 +3985,7 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
 		   struct net_device *orig_dev, bool *another)
 {
 	struct bpf_mprog_entry *entry = rcu_dereference_bh(skb->dev->tcx_ingress);
+	struct tcf_result res = {0};
 	int sch_ret;
 
 	if (!entry)
@@ -3994,9 +4003,14 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
 		if (sch_ret != TC_ACT_UNSPEC)
 			goto ingress_verdict;
 	}
-	sch_ret = tc_run(tcx_entry(entry), skb);
+	sch_ret = tc_run(tcx_entry(entry), skb, &res);
+	if (sch_ret < 0) {
+		kfree_skb_reason(skb, SKB_DROP_REASON_TC_INGRESS_ERROR);
+		*ret = NET_RX_DROP;
+		return NULL;
+	}
 ingress_verdict:
-	switch (sch_ret) {
+	switch (res.verdict) {
 	case TC_ACT_REDIRECT:
 		/* skb_mac_header check was done by BPF, so we can safely
 		 * push the L2 header back before redirecting to another
@@ -4032,6 +4046,7 @@ static __always_inline struct sk_buff *
 sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
 {
 	struct bpf_mprog_entry *entry = rcu_dereference_bh(dev->tcx_egress);
+	struct tcf_result res = {0};
 	int sch_ret;
 
 	if (!entry)
@@ -4045,9 +4060,14 @@ sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
 		if (sch_ret != TC_ACT_UNSPEC)
 			goto egress_verdict;
 	}
-	sch_ret = tc_run(tcx_entry(entry), skb);
+	sch_ret = tc_run(tcx_entry(entry), skb, &res);
+	if (sch_ret < 0) {
+		kfree_skb_reason(skb, SKB_DROP_REASON_TC_EGRESS_ERROR);
+		*ret = NET_XMIT_DROP;
+		return NULL;
+	}
 egress_verdict:
-	switch (sch_ret) {
+	switch (res.verdict) {
 	case TC_ACT_REDIRECT:
 		/* No need to push/pop skb's mac_header here on egress! */
 		skb_do_redirect(skb);
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index a193cc7b3241..ebd031f3ac5a 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1682,11 +1682,11 @@ static inline int __tcf_classify(struct sk_buff *skb,
 			 */
 			if (unlikely(n->tp != tp || n->tp->chain != n->chain ||
 				     !tp->ops->get_exts))
-				return TC_ACT_SHOT;
+				return -EINVAL;
 
 			exts = tp->ops->get_exts(tp, n->handle);
 			if (unlikely(!exts || n->exts != exts))
-				return TC_ACT_SHOT;
+				return -EINVAL;
 
 			n = NULL;
 			err = tcf_exts_exec_ex(skb, exts, act_index, res);
@@ -1708,14 +1708,17 @@ static inline int __tcf_classify(struct sk_buff *skb,
 			goto reset;
 		}
 #endif
-		if (err >= 0)
-			return err;
+		if (err >= 0) {
+			tcf_result_set_verdict(res, err);
+			return 0;
+		}
 	}
 
 	if (unlikely(n))
-		return TC_ACT_SHOT;
+		return -ENOENT;
 
-	return TC_ACT_UNSPEC; /* signal: continue lookup */
+	tcf_result_set_verdict(res, TC_ACT_UNSPEC);
+	return 0;
 #ifdef CONFIG_NET_CLS_ACT
 reset:
 	if (unlikely(limit++ >= max_reclassify_loop)) {
@@ -1723,7 +1726,7 @@ static inline int __tcf_classify(struct sk_buff *skb,
 				       tp->chain->block->index,
 				       tp->prio & 0xffff,
 				       ntohs(tp->protocol));
-		return TC_ACT_SHOT;
+		return -ELOOP;
 	}
 
 	tp = first_tp;
@@ -1760,7 +1763,7 @@ int tcf_classify(struct sk_buff *skb,
 				n = tcf_exts_miss_cookie_lookup(ext->act_miss_cookie,
 								&act_index);
 				if (!n)
-					return TC_ACT_SHOT;
+					return -ENOENT;
 
 				chain = n->chain_index;
 			} else {
@@ -1769,7 +1772,7 @@ int tcf_classify(struct sk_buff *skb,
 
 			fchain = tcf_chain_lookup_rcu(block, chain);
 			if (!fchain)
-				return TC_ACT_SHOT;
+				return -ENOENT;
 
 			/* Consume, so cloned/redirect skbs won't inherit ext */
 			skb_ext_del(skb, TC_SKB_EXT);
@@ -1784,12 +1787,13 @@ int tcf_classify(struct sk_buff *skb,
 
 	if (tc_skb_ext_tc_enabled()) {
 		/* If we missed on some chain */
-		if (ret == TC_ACT_UNSPEC && last_executed_chain) {
+		if (res->verdict == TC_ACT_UNSPEC && last_executed_chain) {
 			struct tc_skb_cb *cb = tc_skb_cb(skb);
 
 			ext = tc_skb_ext_alloc(skb);
 			if (WARN_ON_ONCE(!ext))
-				return TC_ACT_SHOT;
+				return -ENOMEM;
+
 			ext->chain = last_executed_chain;
 			ext->mru = cb->mru;
 			ext->post_ct = cb->post_ct;
@@ -3896,15 +3900,23 @@ EXPORT_SYMBOL(tcf_qevent_validate_change);
 struct sk_buff *tcf_qevent_handle(struct tcf_qevent *qe, struct Qdisc *sch, struct sk_buff *skb,
 				  struct sk_buff **to_free, int *ret)
 {
-	struct tcf_result cl_res;
+	struct tcf_result cl_res = {0};
 	struct tcf_proto *fl;
+	int res;
 
 	if (!qe->info.block_index)
 		return skb;
 
 	fl = rcu_dereference_bh(qe->filter_chain);
 
-	switch (tcf_classify(skb, NULL, fl, &cl_res, false)) {
+	res = tcf_classify(skb, NULL, fl, &cl_res, false);
+	if (res < 0) {
+		qdisc_qstats_drop(sch);
+		__qdisc_drop(skb, to_free);
+		*ret = __NET_XMIT_BYPASS;
+		return NULL;
+	}
+	switch (cl_res.verdict) {
 	case TC_ACT_SHOT:
 		qdisc_qstats_drop(sch);
 		__qdisc_drop(skb, to_free);
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 9cff99558694..359cf7303b09 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1656,8 +1656,8 @@ static u32 cake_classify(struct Qdisc *sch, struct cake_tin_data **t,
 			 struct sk_buff *skb, int flow_mode, int *qerr)
 {
 	struct cake_sched_data *q = qdisc_priv(sch);
+	struct tcf_result res = {0};
 	struct tcf_proto *filter;
-	struct tcf_result res;
 	u16 flow = 0, host = 0;
 	int result;
 
@@ -1667,24 +1667,24 @@ static u32 cake_classify(struct Qdisc *sch, struct cake_tin_data **t,
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	result = tcf_classify(skb, NULL, filter, &res, false);
+	if (result < 0)
+		return result;
 
-	if (result >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
-		switch (result) {
-		case TC_ACT_STOLEN:
-		case TC_ACT_QUEUED:
-		case TC_ACT_TRAP:
-			*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
-			fallthrough;
-		case TC_ACT_SHOT:
-			return 0;
-		}
-#endif
-		if (TC_H_MIN(res.classid) <= CAKE_QUEUES)
-			flow = TC_H_MIN(res.classid);
-		if (TC_H_MAJ(res.classid) <= (CAKE_QUEUES << 16))
-			host = TC_H_MAJ(res.classid) >> 16;
+	switch (res.verdict) {
+	case TC_ACT_STOLEN:
+	case TC_ACT_QUEUED:
+	case TC_ACT_TRAP:
+		*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
+		fallthrough;
+	case TC_ACT_SHOT:
+		return 0;
 	}
+#endif
+	if (TC_H_MIN(res.classid) <= CAKE_QUEUES)
+		flow = TC_H_MIN(res.classid);
+	if (TC_H_MAJ(res.classid) <= (CAKE_QUEUES << 16))
+		host = TC_H_MAJ(res.classid) >> 16;
 hash:
 	*t = cake_select_tin(sch, skb);
 	return cake_hash(*t, skb, flow_mode, flow, host) + 1;
diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index 19901e77cd3b..39d2dd411cbe 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -295,8 +295,8 @@ static struct drr_class *drr_classify(struct sk_buff *skb, struct Qdisc *sch,
 				      int *qerr)
 {
 	struct drr_sched *q = qdisc_priv(sch);
+	struct tcf_result res = {0};
 	struct drr_class *cl;
-	struct tcf_result res;
 	struct tcf_proto *fl;
 	int result;
 
@@ -309,24 +309,23 @@ static struct drr_class *drr_classify(struct sk_buff *skb, struct Qdisc *sch,
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	fl = rcu_dereference_bh(q->filter_list);
 	result = tcf_classify(skb, NULL, fl, &res, false);
-	if (result >= 0) {
+	if (result < 0)
+		return NULL;
 #ifdef CONFIG_NET_CLS_ACT
-		switch (result) {
-		case TC_ACT_QUEUED:
-		case TC_ACT_STOLEN:
-		case TC_ACT_TRAP:
-			*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
-			fallthrough;
-		case TC_ACT_SHOT:
-			return NULL;
-		}
-#endif
-		cl = (struct drr_class *)res.class;
-		if (cl == NULL)
-			cl = drr_find_class(sch, res.classid);
-		return cl;
+	switch (res.verdict) {
+	case TC_ACT_QUEUED:
+	case TC_ACT_STOLEN:
+	case TC_ACT_TRAP:
+		*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
+		fallthrough;
+	case TC_ACT_SHOT:
+		return NULL;
 	}
-	return NULL;
+#endif
+	cl = (struct drr_class *)res.class;
+	if (cl == NULL)
+		cl = drr_find_class(sch, res.classid);
+	return cl;
 }
 
 static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index b10efeaf0629..cc73d4f96fdc 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -374,8 +374,8 @@ static struct ets_class *ets_classify(struct sk_buff *skb, struct Qdisc *sch,
 				      int *qerr)
 {
 	struct ets_sched *q = qdisc_priv(sch);
+	struct tcf_result res = {0};
 	u32 band = skb->priority;
-	struct tcf_result res;
 	struct tcf_proto *fl;
 	int err;
 
@@ -383,8 +383,10 @@ static struct ets_class *ets_classify(struct sk_buff *skb, struct Qdisc *sch,
 	if (TC_H_MAJ(skb->priority) != sch->handle) {
 		fl = rcu_dereference_bh(q->filter_list);
 		err = tcf_classify(skb, NULL, fl, &res, false);
+		if (err < 0)
+			return NULL;
 #ifdef CONFIG_NET_CLS_ACT
-		switch (err) {
+		switch (res.verdict) {
 		case TC_ACT_STOLEN:
 		case TC_ACT_QUEUED:
 		case TC_ACT_TRAP:
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 8c4fee063436..d70d0585f769 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -77,8 +77,8 @@ static unsigned int fq_codel_classify(struct sk_buff *skb, struct Qdisc *sch,
 				      int *qerr)
 {
 	struct fq_codel_sched_data *q = qdisc_priv(sch);
+	struct tcf_result res = {0};
 	struct tcf_proto *filter;
-	struct tcf_result res;
 	int result;
 
 	if (TC_H_MAJ(skb->priority) == sch->handle &&
@@ -92,21 +92,22 @@ static unsigned int fq_codel_classify(struct sk_buff *skb, struct Qdisc *sch,
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	result = tcf_classify(skb, NULL, filter, &res, false);
-	if (result >= 0) {
+	if (result < 0)
+		return 0;
+
 #ifdef CONFIG_NET_CLS_ACT
-		switch (result) {
-		case TC_ACT_STOLEN:
-		case TC_ACT_QUEUED:
-		case TC_ACT_TRAP:
-			*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
-			fallthrough;
-		case TC_ACT_SHOT:
-			return 0;
-		}
-#endif
-		if (TC_H_MIN(res.classid) <= q->flows_cnt)
-			return TC_H_MIN(res.classid);
+	switch (res.verdict) {
+	case TC_ACT_STOLEN:
+	case TC_ACT_QUEUED:
+	case TC_ACT_TRAP:
+		*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
+		fallthrough;
+	case TC_ACT_SHOT:
+		return 0;
 	}
+#endif
+	if (TC_H_MIN(res.classid) <= q->flows_cnt)
+		return TC_H_MIN(res.classid);
 	return 0;
 }
 
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 68e6acd0f130..63d87ea2f187 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -81,8 +81,8 @@ static unsigned int fq_pie_classify(struct sk_buff *skb, struct Qdisc *sch,
 				    int *qerr)
 {
 	struct fq_pie_sched_data *q = qdisc_priv(sch);
+	struct tcf_result res = {0};
 	struct tcf_proto *filter;
-	struct tcf_result res;
 	int result;
 
 	if (TC_H_MAJ(skb->priority) == sch->handle &&
@@ -96,21 +96,21 @@ static unsigned int fq_pie_classify(struct sk_buff *skb, struct Qdisc *sch,
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	result = tcf_classify(skb, NULL, filter, &res, false);
-	if (result >= 0) {
+	if (result < 0)
+		return 0;
 #ifdef CONFIG_NET_CLS_ACT
-		switch (result) {
-		case TC_ACT_STOLEN:
-		case TC_ACT_QUEUED:
-		case TC_ACT_TRAP:
-			*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
-			fallthrough;
-		case TC_ACT_SHOT:
-			return 0;
-		}
-#endif
-		if (TC_H_MIN(res.classid) <= q->flows_cnt)
-			return TC_H_MIN(res.classid);
+	switch (res.verdict) {
+	case TC_ACT_STOLEN:
+	case TC_ACT_QUEUED:
+	case TC_ACT_TRAP:
+		*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
+		fallthrough;
+	case TC_ACT_SHOT:
+		return 0;
 	}
+#endif
+	if (TC_H_MIN(res.classid) <= q->flows_cnt)
+		return TC_H_MIN(res.classid);
 	return 0;
 }
 
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 3554085bc2be..9a45596b87bf 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1122,7 +1122,7 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 {
 	struct hfsc_sched *q = qdisc_priv(sch);
 	struct hfsc_class *head, *cl;
-	struct tcf_result res;
+	struct tcf_result res = {0};
 	struct tcf_proto *tcf;
 	int result;
 
@@ -1135,8 +1135,10 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 	head = &q->root;
 	tcf = rcu_dereference_bh(q->root.filter_list);
 	while (tcf && (result = tcf_classify(skb, NULL, tcf, &res, false)) >= 0) {
+		if (result < 0)
+			return NULL;
 #ifdef CONFIG_NET_CLS_ACT
-		switch (result) {
+		switch (res.verdict) {
 		case TC_ACT_QUEUED:
 		case TC_ACT_STOLEN:
 		case TC_ACT_TRAP:
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 0d947414e616..8ebb56e4ea91 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -220,8 +220,8 @@ static struct htb_class *htb_classify(struct sk_buff *skb, struct Qdisc *sch,
 				      int *qerr)
 {
 	struct htb_sched *q = qdisc_priv(sch);
+	struct tcf_result res = {0};
 	struct htb_class *cl;
-	struct tcf_result res;
 	struct tcf_proto *tcf;
 	int result;
 
@@ -243,8 +243,10 @@ static struct htb_class *htb_classify(struct sk_buff *skb, struct Qdisc *sch,
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	while (tcf && (result = tcf_classify(skb, NULL, tcf, &res, false)) >= 0) {
+		if (result < 0)
+			return NULL;
 #ifdef CONFIG_NET_CLS_ACT
-		switch (result) {
+		switch (res.verdict) {
 		case TC_ACT_QUEUED:
 		case TC_ACT_STOLEN:
 		case TC_ACT_TRAP:
diff --git a/net/sched/sch_multiq.c b/net/sched/sch_multiq.c
index 75c9c860182b..07c5247e9c50 100644
--- a/net/sched/sch_multiq.c
+++ b/net/sched/sch_multiq.c
@@ -31,14 +31,16 @@ multiq_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 {
 	struct multiq_sched_data *q = qdisc_priv(sch);
 	u32 band;
-	struct tcf_result res;
 	struct tcf_proto *fl = rcu_dereference_bh(q->filter_list);
+	struct tcf_result res = {0};
 	int err;
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	err = tcf_classify(skb, NULL, fl, &res, false);
+	if (err < 0)
+		return NULL;
 #ifdef CONFIG_NET_CLS_ACT
-	switch (err) {
+	switch (res.verdict) {
 	case TC_ACT_STOLEN:
 	case TC_ACT_QUEUED:
 	case TC_ACT_TRAP:
diff --git a/net/sched/sch_prio.c b/net/sched/sch_prio.c
index fdc5ef52c3ee..9abd093b7941 100644
--- a/net/sched/sch_prio.c
+++ b/net/sched/sch_prio.c
@@ -31,8 +31,8 @@ static struct Qdisc *
 prio_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 {
 	struct prio_sched_data *q = qdisc_priv(sch);
+	struct tcf_result res = {0};
 	u32 band = skb->priority;
-	struct tcf_result res;
 	struct tcf_proto *fl;
 	int err;
 
@@ -40,8 +40,11 @@ prio_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 	if (TC_H_MAJ(skb->priority) != sch->handle) {
 		fl = rcu_dereference_bh(q->filter_list);
 		err = tcf_classify(skb, NULL, fl, &res, false);
+		if (err < 0)
+			return NULL;
+
 #ifdef CONFIG_NET_CLS_ACT
-		switch (err) {
+		switch (res.verdict) {
 		case TC_ACT_STOLEN:
 		case TC_ACT_QUEUED:
 		case TC_ACT_TRAP:
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 546c10adcacd..9874aefa1994 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -680,8 +680,8 @@ static struct qfq_class *qfq_classify(struct sk_buff *skb, struct Qdisc *sch,
 				      int *qerr)
 {
 	struct qfq_sched *q = qdisc_priv(sch);
+	struct tcf_result res = {0};
 	struct qfq_class *cl;
-	struct tcf_result res;
 	struct tcf_proto *fl;
 	int result;
 
@@ -695,25 +695,23 @@ static struct qfq_class *qfq_classify(struct sk_buff *skb, struct Qdisc *sch,
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	fl = rcu_dereference_bh(q->filter_list);
 	result = tcf_classify(skb, NULL, fl, &res, false);
-	if (result >= 0) {
+	if (result < 0)
+		return NULL;
 #ifdef CONFIG_NET_CLS_ACT
-		switch (result) {
-		case TC_ACT_QUEUED:
-		case TC_ACT_STOLEN:
-		case TC_ACT_TRAP:
-			*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
-			fallthrough;
-		case TC_ACT_SHOT:
-			return NULL;
-		}
-#endif
-		cl = (struct qfq_class *)res.class;
-		if (cl == NULL)
-			cl = qfq_find_class(sch, res.classid);
-		return cl;
+	switch (res.verdict) {
+	case TC_ACT_QUEUED:
+	case TC_ACT_STOLEN:
+	case TC_ACT_TRAP:
+		*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
+		fallthrough;
+	case TC_ACT_SHOT:
+		return NULL;
 	}
-
-	return NULL;
+#endif
+	cl = (struct qfq_class *)res.class;
+	if (cl == NULL)
+		cl = qfq_find_class(sch, res.classid);
+	return cl;
 }
 
 /* Generic comparison function, handling wraparound. */
diff --git a/net/sched/sch_sfb.c b/net/sched/sch_sfb.c
index 1871a1c0224d..e1085c9f8925 100644
--- a/net/sched/sch_sfb.c
+++ b/net/sched/sch_sfb.c
@@ -254,26 +254,25 @@ static bool sfb_rate_limit(struct sk_buff *skb, struct sfb_sched_data *q)
 static bool sfb_classify(struct sk_buff *skb, struct tcf_proto *fl,
 			 int *qerr, u32 *salt)
 {
-	struct tcf_result res;
+	struct tcf_result res = {0};
 	int result;
 
 	result = tcf_classify(skb, NULL, fl, &res, false);
-	if (result >= 0) {
+	if (result < 0)
+		return false;
 #ifdef CONFIG_NET_CLS_ACT
-		switch (result) {
-		case TC_ACT_STOLEN:
-		case TC_ACT_QUEUED:
-		case TC_ACT_TRAP:
-			*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
-			fallthrough;
-		case TC_ACT_SHOT:
-			return false;
-		}
-#endif
-		*salt = TC_H_MIN(res.classid);
-		return true;
+	switch (res.verdict) {
+	case TC_ACT_STOLEN:
+	case TC_ACT_QUEUED:
+	case TC_ACT_TRAP:
+		*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
+		fallthrough;
+	case TC_ACT_SHOT:
+		return false;
 	}
-	return false;
+#endif
+	*salt = TC_H_MIN(res.classid);
+	return true;
 }
 
 static int sfb_enqueue(struct sk_buff *skb, struct Qdisc *sch,
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 66dcb18638fe..c20a4c8d0785 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -164,7 +164,7 @@ static unsigned int sfq_classify(struct sk_buff *skb, struct Qdisc *sch,
 				 int *qerr)
 {
 	struct sfq_sched_data *q = qdisc_priv(sch);
-	struct tcf_result res;
+	struct tcf_result res = {0};
 	struct tcf_proto *fl;
 	int result;
 
@@ -179,21 +179,21 @@ static unsigned int sfq_classify(struct sk_buff *skb, struct Qdisc *sch,
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	result = tcf_classify(skb, NULL, fl, &res, false);
-	if (result >= 0) {
+	if (result < 0)
+		return 0;
 #ifdef CONFIG_NET_CLS_ACT
-		switch (result) {
-		case TC_ACT_STOLEN:
-		case TC_ACT_QUEUED:
-		case TC_ACT_TRAP:
-			*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
-			fallthrough;
-		case TC_ACT_SHOT:
-			return 0;
-		}
-#endif
-		if (TC_H_MIN(res.classid) <= q->divisor)
-			return TC_H_MIN(res.classid);
+	switch (res.verdict) {
+	case TC_ACT_STOLEN:
+	case TC_ACT_QUEUED:
+	case TC_ACT_TRAP:
+		*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
+		fallthrough;
+	case TC_ACT_SHOT:
+		return 0;
 	}
+#endif
+	if (TC_H_MIN(res.classid) <= q->divisor)
+		return TC_H_MIN(res.classid);
 	return 0;
 }
 
-- 
2.25.1


