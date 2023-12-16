Return-Path: <netdev+bounces-58295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DA9815BBC
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 21:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3177284B47
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 20:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186FF321A5;
	Sat, 16 Dec 2023 20:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="lfQwmNey"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ACF1E490
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 20:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5bdb0be3591so1488199a12.2
        for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 12:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702759487; x=1703364287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Of6J+086OPjEIj9keVzyqTPwLJ+HMrnbr9lLx0QxZhc=;
        b=lfQwmNey8F3iWB8i4CY77vqRk899xCjzVdXp6GWYuAe2/PyeDbe2rTbzAy7xj8vrFA
         H2cOEn2lGYPVr7wJseCXnzOH0372+4M14XONqO2VNWLJ1Hb1iXZQFA8mllQ6149GR1l2
         KUx1OWvrxFqnVCT7lL8Ha4I+tdcMXw7xKBNWi/u4WJ/jvDjTQsAF4QG74kFGGjdFr0YS
         0BFnHHm6gt/0noYEoB39HqtmasUfBAyVV1FGtg+e77WQit59D6xwR6LGCgPFgJuy11SJ
         L6vKQ2U5Ja2lr10UWjL5lGNhvuTjKRCC8Jpm++Bl4oWooTJDvWJkmNvE6VsgnWAdmQzs
         jlPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702759487; x=1703364287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Of6J+086OPjEIj9keVzyqTPwLJ+HMrnbr9lLx0QxZhc=;
        b=glBCJLh3usY2rzzP4vnnoMZ9V0NfN2Xc1BFp57yL8KF9qFbf2ao0PkwdP9eIyc2Gpb
         rsZBmsFNZwwLOesiP7etZYuS6dXhLLdF10xcsuAsCO1XQ4hlAHzE7FV6xsiqX3PT8VUH
         W6uXNtUxUwmQXl4QysKBjvsNsntKDmWV8/lPidshMnkrlzz1cKvxcjIC2DwzgUq6wI+x
         zQf7sepHxAJ+bBBGd0j3bTAC65qOaRd9TRVDkgk28mSKsAIy1wklSNSqOe4d9KnCnoPT
         IH44j4CoyefHZOdKaGC9tsSe25r79Ap/wOLmXxbOgcm4j4LA8U9lkNw7uW2TTicCbMLL
         yRpg==
X-Gm-Message-State: AOJu0YyrMSVuQFE8cojegJ/aJrYT8XwG3feajML2BohRY4ZIIpu6eznA
	2tEkJh7HqKXUVkPnRFMxmtpDzw==
X-Google-Smtp-Source: AGHT+IHE979GmK7E7xv7s81+MfVFrSzG8Scjk0zTxmQBuos7gERa5mKs3KaHE0yJiguQzQqhnQgiXA==
X-Received: by 2002:a05:6a21:186:b0:194:2c8b:8ba1 with SMTP id le6-20020a056a21018600b001942c8b8ba1mr814661pzb.58.1702759486836;
        Sat, 16 Dec 2023 12:44:46 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c0:60e3:4c1:486f:7eda:5fb5])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090a390d00b0028b5739c927sm1380343pjb.34.2023.12.16.12.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 12:44:46 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@iogearbox.net,
	horms@kernel.org
Cc: dcaratti@redhat.com,
	netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH net-next v5 1/3] net: sched: Move drop_reason to struct tc_skb_cb
Date: Sat, 16 Dec 2023 17:44:34 -0300
Message-ID: <20231216204436.3712716-2-victor@mojatatu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231216204436.3712716-1-victor@mojatatu.com>
References: <20231216204436.3712716-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move drop_reason from struct tcf_result to skb cb - more specifically to
struct tc_skb_cb. With that, we'll be able to also set the drop reason for
the remaining qdiscs (aside from clsact) that do not have access to
tcf_result when time comes to set the skb drop reason.

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 include/net/pkt_cls.h     | 14 ++++++++++++--
 include/net/pkt_sched.h   |  3 ++-
 include/net/sch_generic.h |  1 -
 net/core/dev.c            |  4 ++--
 net/sched/act_api.c       |  2 +-
 net/sched/cls_api.c       | 23 ++++++++---------------
 6 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index a76c9171db0e..761e4500cca0 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -154,10 +154,20 @@ __cls_set_class(unsigned long *clp, unsigned long cl)
 	return xchg(clp, cl);
 }
 
-static inline void tcf_set_drop_reason(struct tcf_result *res,
+struct tc_skb_cb;
+
+static inline struct tc_skb_cb *tc_skb_cb(const struct sk_buff *skb);
+
+static inline enum skb_drop_reason
+tcf_get_drop_reason(const struct sk_buff *skb)
+{
+	return tc_skb_cb(skb)->drop_reason;
+}
+
+static inline void tcf_set_drop_reason(const struct sk_buff *skb,
 				       enum skb_drop_reason reason)
 {
-	res->drop_reason = reason;
+	tc_skb_cb(skb)->drop_reason = reason;
 }
 
 static inline void
diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 9fa1d0794dfa..9b559aa5c079 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -277,12 +277,13 @@ static inline void skb_txtime_consumed(struct sk_buff *skb)
 
 struct tc_skb_cb {
 	struct qdisc_skb_cb qdisc_cb;
+	u32 drop_reason;
 
+	u16 zone; /* Only valid if post_ct = true */
 	u16 mru;
 	u8 post_ct:1;
 	u8 post_ct_snat:1;
 	u8 post_ct_dnat:1;
-	u16 zone; /* Only valid if post_ct = true */
 };
 
 static inline struct tc_skb_cb *tc_skb_cb(const struct sk_buff *skb)
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index dcb9160e6467..c499b56bb215 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -332,7 +332,6 @@ struct tcf_result {
 		};
 		const struct tcf_proto *goto_tp;
 	};
-	enum skb_drop_reason		drop_reason;
 };
 
 struct tcf_chain;
diff --git a/net/core/dev.c b/net/core/dev.c
index 0432b04cf9b0..16af89a733e4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3923,14 +3923,14 @@ static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
 
 	tc_skb_cb(skb)->mru = 0;
 	tc_skb_cb(skb)->post_ct = false;
-	res.drop_reason = *drop_reason;
+	tcf_set_drop_reason(skb, *drop_reason);
 
 	mini_qdisc_bstats_cpu_update(miniq, skb);
 	ret = tcf_classify(skb, miniq->block, miniq->filter_list, &res, false);
 	/* Only tcf related quirks below. */
 	switch (ret) {
 	case TC_ACT_SHOT:
-		*drop_reason = res.drop_reason;
+		*drop_reason = tcf_get_drop_reason(skb);
 		mini_qdisc_qstats_cpu_drop(miniq);
 		break;
 	case TC_ACT_OK:
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 3a7770eff52d..db500aa9f841 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1119,7 +1119,7 @@ int tcf_action_exec(struct sk_buff *skb, struct tc_action **actions,
 			}
 		} else if (TC_ACT_EXT_CMP(ret, TC_ACT_GOTO_CHAIN)) {
 			if (unlikely(!rcu_access_pointer(a->goto_chain))) {
-				tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
+				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
 				return TC_ACT_SHOT;
 			}
 			tcf_action_goto_chain_exec(a, res);
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index dc1c19a25882..199406e4bcdd 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1657,7 +1657,6 @@ static inline int __tcf_classify(struct sk_buff *skb,
 				 int act_index,
 				 u32 *last_executed_chain)
 {
-	u32 orig_reason = res->drop_reason;
 #ifdef CONFIG_NET_CLS_ACT
 	const int max_reclassify_loop = 16;
 	const struct tcf_proto *first_tp;
@@ -1682,13 +1681,13 @@ static inline int __tcf_classify(struct sk_buff *skb,
 			 */
 			if (unlikely(n->tp != tp || n->tp->chain != n->chain ||
 				     !tp->ops->get_exts)) {
-				tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
+				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
 				return TC_ACT_SHOT;
 			}
 
 			exts = tp->ops->get_exts(tp, n->handle);
 			if (unlikely(!exts || n->exts != exts)) {
-				tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
+				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
 				return TC_ACT_SHOT;
 			}
 
@@ -1712,18 +1711,12 @@ static inline int __tcf_classify(struct sk_buff *skb,
 			goto reset;
 		}
 #endif
-		if (err >= 0) {
-			/* Policy drop or drop reason is over-written by
-			 * classifiers with a bogus value(0) */
-			if (err == TC_ACT_SHOT &&
-			    res->drop_reason == SKB_NOT_DROPPED_YET)
-				tcf_set_drop_reason(res, orig_reason);
+		if (err >= 0)
 			return err;
-		}
 	}
 
 	if (unlikely(n)) {
-		tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
+		tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
 		return TC_ACT_SHOT;
 	}
 
@@ -1735,7 +1728,7 @@ static inline int __tcf_classify(struct sk_buff *skb,
 				       tp->chain->block->index,
 				       tp->prio & 0xffff,
 				       ntohs(tp->protocol));
-		tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
+		tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
 		return TC_ACT_SHOT;
 	}
 
@@ -1773,7 +1766,7 @@ int tcf_classify(struct sk_buff *skb,
 				n = tcf_exts_miss_cookie_lookup(ext->act_miss_cookie,
 								&act_index);
 				if (!n) {
-					tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
+					tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
 					return TC_ACT_SHOT;
 				}
 
@@ -1784,7 +1777,7 @@ int tcf_classify(struct sk_buff *skb,
 
 			fchain = tcf_chain_lookup_rcu(block, chain);
 			if (!fchain) {
-				tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
+				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
 				return TC_ACT_SHOT;
 			}
 
@@ -1806,7 +1799,7 @@ int tcf_classify(struct sk_buff *skb,
 
 			ext = tc_skb_ext_alloc(skb);
 			if (WARN_ON_ONCE(!ext)) {
-				tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
+				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
 				return TC_ACT_SHOT;
 			}
 
-- 
2.25.1


