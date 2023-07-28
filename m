Return-Path: <netdev+bounces-22328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4837670A9
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A2241C21923
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 15:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB57C1426A;
	Fri, 28 Jul 2023 15:35:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EC114268
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:35:57 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA585B5
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:35:55 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a425ef874dso1796808b6e.0
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690558555; x=1691163355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0L8MdedY0X8wnsjs4lzrDqZOSVz+oJAJQEkJT7CT0w8=;
        b=GOa/lzPz76CtHeOJW1QMngqdDhJeap5Cham6fZh3fQ0HdUqvQj1638C0pemyxi60a6
         hu+LDzqWNnFzGBy3NWtoh67WiW4bMcnPgqWQYy+8wQLtfegidiZUFI6RUNmCUD03lcvq
         Yjay/xRYCtLxFav3AiXSfrn1YpABi3urBa0SfeZB832axe97mAj2hOCfbcgnHANQsdQi
         Yxe1zxEfI7RCIUre4EyDIYGqervnC3pAZ9dr3KbjY8OIJmbBc4VQ4Vb6/d6L7Jo7EIwk
         21Cnjxp8oA1jBkmDd+GoBBfiT393UnPBb1YTtFL7sew8DuMk85EVBigQcwKgZSH/j7PE
         MSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690558555; x=1691163355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0L8MdedY0X8wnsjs4lzrDqZOSVz+oJAJQEkJT7CT0w8=;
        b=PmV2+eZh4A6HHKkS2+j6ZGK3A8yfv18qzRT42wD6oRcbPwMoKpby+LEUJV8vRLZ0Nu
         o0A5V2ew/CeY1G2AofqTFX6ymMx9lf1MP+V2o7R19ypu0ie55tPM+hgkpyTT4tQq4Zd/
         lPj8RQRIcmtbdvwnZEhi6nLhVolnPUt96S378NgDq2wiepzmo7Fq6dYOZzsBn4se3vZ/
         vySHPoEN/nmUC16DwABOrj1GD5dtf86XSKciPjlYBCNkigJaqUC5jCZgnUTY5y37HKJK
         lpblbNa5MvUxv5cdzg3OneCWR2PRJnilqClW+SiLHX22cgMW6d25gmFZtp/6kd9VF2Er
         zXTA==
X-Gm-Message-State: ABy/qLbzCtKv2jguwZEAxzVY8fvBxPMGgoxYgKYfufgrKWwnKAvUSqDA
	pK4H+p+Ya/Eq07xzHMMCrNx3LW3Uq0iKpyEgMsI=
X-Google-Smtp-Source: APBJJlFrsMEPTAqml/qDO/HvtY2cU2tZrSCyeKfAFqGRQPbdCV/yvVh0SadIR2FPJ8X1Be57I4OmHQ==
X-Received: by 2002:a05:6808:2a6c:b0:3a4:17b0:2b12 with SMTP id fu12-20020a0568082a6c00b003a417b02b12mr3023412oib.11.1690558555023;
        Fri, 28 Jul 2023 08:35:55 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:81ef:7444:5901:c19d])
        by smtp.gmail.com with ESMTPSA id u8-20020a544388000000b003a3b321712fsm1732893oiv.35.2023.07.28.08.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 08:35:54 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v2 1/5] net/sched: wrap open coded Qdics class filter counter
Date: Fri, 28 Jul 2023 12:35:33 -0300
Message-Id: <20230728153537.1865379-2-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230728153537.1865379-1-pctammela@mojatatu.com>
References: <20230728153537.1865379-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The 'filter_cnt' counter is used to control a Qdisc class lifetime.
Each filter referecing this class by its id will eventually
increment/decrement this counter in their respective
'add/update/delete' routines.
As these operations are always serialized under rtnl lock, we don't
need an atomic type like 'refcount_t'.

It also means that we lose the overflow/underflow checks already
present in refcount_t, which are valuable to hunt down bugs
where the unsigned counter wraps around as it aids automated tools
like syzkaller to scream in such situations.

Wrap the open coded increment/decrement into helper functions and
add overflow checks to the operations.

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 include/net/sch_generic.h | 26 ++++++++++++++++++++++++++
 net/sched/sch_drr.c       |  9 ++++-----
 net/sched/sch_hfsc.c      |  8 ++++----
 net/sched/sch_htb.c       |  8 +++-----
 net/sched/sch_qfq.c       | 10 ++++------
 5 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 15be2d96b06d..f232512505f8 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -599,6 +599,7 @@ get_default_qdisc_ops(const struct net_device *dev, int ntx)
 
 struct Qdisc_class_common {
 	u32			classid;
+	unsigned int		filter_cnt;
 	struct hlist_node	hnode;
 };
 
@@ -633,6 +634,31 @@ qdisc_class_find(const struct Qdisc_class_hash *hash, u32 id)
 	return NULL;
 }
 
+static inline bool qdisc_class_in_use(const struct Qdisc_class_common *cl)
+{
+	return cl->filter_cnt > 0;
+}
+
+static inline void qdisc_class_get(struct Qdisc_class_common *cl)
+{
+	unsigned int res;
+
+	if (check_add_overflow(cl->filter_cnt, 1, &res))
+		WARN(1, "Qdisc class overflow");
+
+	cl->filter_cnt = res;
+}
+
+static inline void qdisc_class_put(struct Qdisc_class_common *cl)
+{
+	unsigned int res;
+
+	if (check_sub_overflow(cl->filter_cnt, 1, &res))
+		WARN(1, "Qdisc class underflow");
+
+	cl->filter_cnt = res;
+}
+
 static inline int tc_classid_to_hwtc(struct net_device *dev, u32 classid)
 {
 	u32 hwtc = TC_H_MIN(classid) - TC_H_MIN_PRIORITY;
diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index e35a4e90f4e6..1b22b3b741c9 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -17,7 +17,6 @@
 
 struct drr_class {
 	struct Qdisc_class_common	common;
-	unsigned int			filter_cnt;
 
 	struct gnet_stats_basic_sync		bstats;
 	struct gnet_stats_queue		qstats;
@@ -150,7 +149,7 @@ static int drr_delete_class(struct Qdisc *sch, unsigned long arg,
 	struct drr_sched *q = qdisc_priv(sch);
 	struct drr_class *cl = (struct drr_class *)arg;
 
-	if (cl->filter_cnt > 0)
+	if (qdisc_class_in_use(&cl->common))
 		return -EBUSY;
 
 	sch_tree_lock(sch);
@@ -187,8 +186,8 @@ static unsigned long drr_bind_tcf(struct Qdisc *sch, unsigned long parent,
 {
 	struct drr_class *cl = drr_find_class(sch, classid);
 
-	if (cl != NULL)
-		cl->filter_cnt++;
+	if (cl)
+		qdisc_class_get(&cl->common);
 
 	return (unsigned long)cl;
 }
@@ -197,7 +196,7 @@ static void drr_unbind_tcf(struct Qdisc *sch, unsigned long arg)
 {
 	struct drr_class *cl = (struct drr_class *)arg;
 
-	cl->filter_cnt--;
+	qdisc_class_put(&cl->common);
 }
 
 static int drr_graft_class(struct Qdisc *sch, unsigned long arg,
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 70b0c5873d32..896cb401fdb9 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -116,7 +116,6 @@ struct hfsc_class {
 	struct net_rate_estimator __rcu *rate_est;
 	struct tcf_proto __rcu *filter_list; /* filter list */
 	struct tcf_block *block;
-	unsigned int	filter_cnt;	/* filter count */
 	unsigned int	level;		/* class level in hierarchy */
 
 	struct hfsc_sched *sched;	/* scheduler data */
@@ -1094,7 +1093,8 @@ hfsc_delete_class(struct Qdisc *sch, unsigned long arg,
 	struct hfsc_sched *q = qdisc_priv(sch);
 	struct hfsc_class *cl = (struct hfsc_class *)arg;
 
-	if (cl->level > 0 || cl->filter_cnt > 0 || cl == &q->root)
+	if (cl->level > 0 || qdisc_class_in_use(&cl->cl_common) ||
+	    cl == &q->root)
 		return -EBUSY;
 
 	sch_tree_lock(sch);
@@ -1223,7 +1223,7 @@ hfsc_bind_tcf(struct Qdisc *sch, unsigned long parent, u32 classid)
 	if (cl != NULL) {
 		if (p != NULL && p->level <= cl->level)
 			return 0;
-		cl->filter_cnt++;
+		qdisc_class_get(&cl->cl_common);
 	}
 
 	return (unsigned long)cl;
@@ -1234,7 +1234,7 @@ hfsc_unbind_tcf(struct Qdisc *sch, unsigned long arg)
 {
 	struct hfsc_class *cl = (struct hfsc_class *)arg;
 
-	cl->filter_cnt--;
+	qdisc_class_put(&cl->cl_common);
 }
 
 static struct tcf_block *hfsc_tcf_block(struct Qdisc *sch, unsigned long arg,
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 333800a7d4eb..05c8291865ae 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -102,7 +102,6 @@ struct htb_class {
 
 	struct tcf_proto __rcu	*filter_list;	/* class attached filters */
 	struct tcf_block	*block;
-	int			filter_cnt;
 
 	int			level;		/* our level (see above) */
 	unsigned int		children;
@@ -1710,7 +1709,7 @@ static int htb_delete(struct Qdisc *sch, unsigned long arg,
 	 * tc subsys guarantee us that in htb_destroy it holds no class
 	 * refs so that we can remove children safely there ?
 	 */
-	if (cl->children || cl->filter_cnt)
+	if (cl->children || qdisc_class_in_use(&cl->common))
 		return -EBUSY;
 
 	if (!cl->level && htb_parent_last_child(cl))
@@ -2107,7 +2106,7 @@ static unsigned long htb_bind_filter(struct Qdisc *sch, unsigned long parent,
 	 * be broken by class during destroy IIUC.
 	 */
 	if (cl)
-		cl->filter_cnt++;
+		qdisc_class_get(&cl->common);
 	return (unsigned long)cl;
 }
 
@@ -2115,8 +2114,7 @@ static void htb_unbind_filter(struct Qdisc *sch, unsigned long arg)
 {
 	struct htb_class *cl = (struct htb_class *)arg;
 
-	if (cl)
-		cl->filter_cnt--;
+	qdisc_class_put(&cl->common);
 }
 
 static void htb_walk(struct Qdisc *sch, struct qdisc_walker *arg)
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index befaf74b33ca..7addc15f01b5 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -130,8 +130,6 @@ struct qfq_aggregate;
 struct qfq_class {
 	struct Qdisc_class_common common;
 
-	unsigned int filter_cnt;
-
 	struct gnet_stats_basic_sync bstats;
 	struct gnet_stats_queue qstats;
 	struct net_rate_estimator __rcu *rate_est;
@@ -545,7 +543,7 @@ static int qfq_delete_class(struct Qdisc *sch, unsigned long arg,
 	struct qfq_sched *q = qdisc_priv(sch);
 	struct qfq_class *cl = (struct qfq_class *)arg;
 
-	if (cl->filter_cnt > 0)
+	if (qdisc_class_in_use(&cl->common))
 		return -EBUSY;
 
 	sch_tree_lock(sch);
@@ -580,8 +578,8 @@ static unsigned long qfq_bind_tcf(struct Qdisc *sch, unsigned long parent,
 {
 	struct qfq_class *cl = qfq_find_class(sch, classid);
 
-	if (cl != NULL)
-		cl->filter_cnt++;
+	if (cl)
+		qdisc_class_get(&cl->common);
 
 	return (unsigned long)cl;
 }
@@ -590,7 +588,7 @@ static void qfq_unbind_tcf(struct Qdisc *sch, unsigned long arg)
 {
 	struct qfq_class *cl = (struct qfq_class *)arg;
 
-	cl->filter_cnt--;
+	qdisc_class_put(&cl->common);
 }
 
 static int qfq_graft_class(struct Qdisc *sch, unsigned long arg,
-- 
2.39.2


