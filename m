Return-Path: <netdev+bounces-19991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E932675D3CA
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 21:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0FCF281C52
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 19:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D909E20FA9;
	Fri, 21 Jul 2023 19:14:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFE620F98
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 19:14:13 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC7C30E1
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 12:14:11 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6b9b835d302so1676421a34.1
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 12:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689966850; x=1690571650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWlXVVTJIeHhmNRhl3Ge/vab8+YcHvAb2XGzoXiUWK8=;
        b=qACO00fJMe7I1YifhewXMaVKVxymq2aL55ajN2kieh8Whx68+jSf00OkfBj4CrHpMF
         4KczWom1wptPDnUmZfG5jR93nlieAX9d4PBS4cRyBP7SXjLyLNpmdoCA4D3zxbW/Q7wi
         jM7Z2aTvm0KrRBZvyOvtjTHb+VSuZkmx8crLiafm56g9M/kJjoX0zTSexDqXYuQJpQHF
         TVnX9yHgpGOfoF/ex1HXGggph4KVrKQ15R6HY4f8XwrWmi0dluI2ouWlv5CnqhxoSUDS
         4NqMFUNtIhC5xGuo6K5wO0NS8kMwrTqluz5PU+3s6axWuABs/832BXExK9ivEg0P52YU
         4JXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689966850; x=1690571650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWlXVVTJIeHhmNRhl3Ge/vab8+YcHvAb2XGzoXiUWK8=;
        b=EwSzehw87YDRXEh2rBGXU9X1zBoyyTpO781Un0X/7zm8wW87S9GBU21yHvBR0CValB
         CJaOWr0hH0UImk7PDLubLRd9X5y3vs2AfWlauRVJ9uwC8iZknzlwayjeP1Y6l53eLjtS
         TrFIZBwK2KC++3T0SIc9JeHgt5g1CVEYCmTyk+ryYiRL0sxk8e/cwa2vglo6rIvk901G
         OkT0995kKLzj2ZRus9lGPZy8uAU7r1d7btGEVqTOccJXxyX+kuwW6SuC9eeXy4vyGVFY
         pOELQof/zhZnnrne4TaY10+0+EKq8ewQLitMNTlbTXWxfkP5kpq5SyZDES+Np47fIkrt
         iJRg==
X-Gm-Message-State: ABy/qLaoQiK9djOkXw2ofmkTUzVKmAAqugvu318Ea7JarnGv9E9tkadm
	t7mjWiABeG1pRJrgOVaqDr7Wm6xgUWq6Kf/lRdM=
X-Google-Smtp-Source: APBJJlHg/9vlAMLzaUAXAL/9XFrutXaKaLh5IgZiFpSaljtA0Qh3eavEGNkBxFsof21JHhfNsBgdDQ==
X-Received: by 2002:a05:6870:46a2:b0:1ba:64a5:d2d1 with SMTP id a34-20020a05687046a200b001ba64a5d2d1mr3068365oap.20.1689966849745;
        Fri, 21 Jul 2023 12:14:09 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:2414:7bdd:b686:c769])
        by smtp.gmail.com with ESMTPSA id e3-20020a056870944300b001b04434d934sm1813731oal.34.2023.07.21.12.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 12:14:09 -0700 (PDT)
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
Subject: [PATCH net-next 1/5] net/sched: wrap open coded Qdics class filter counter
Date: Fri, 21 Jul 2023 16:13:28 -0300
Message-Id: <20230721191332.1424997-2-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230721191332.1424997-1-pctammela@mojatatu.com>
References: <20230721191332.1424997-1-pctammela@mojatatu.com>
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

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 include/net/sch_generic.h |  1 +
 include/net/tc_class.h    | 33 +++++++++++++++++++++++++++++++++
 net/sched/sch_drr.c       | 10 +++++-----
 net/sched/sch_hfsc.c      |  9 +++++----
 net/sched/sch_htb.c       |  9 ++++-----
 net/sched/sch_qfq.c       |  9 ++++-----
 6 files changed, 52 insertions(+), 19 deletions(-)
 create mode 100644 include/net/tc_class.h

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 15be2d96b06d..891ee8637a92 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -599,6 +599,7 @@ get_default_qdisc_ops(const struct net_device *dev, int ntx)
 
 struct Qdisc_class_common {
 	u32			classid;
+	unsigned int		filter_cnt;
 	struct hlist_node	hnode;
 };
 
diff --git a/include/net/tc_class.h b/include/net/tc_class.h
new file mode 100644
index 000000000000..2ab4aa2dba30
--- /dev/null
+++ b/include/net/tc_class.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __NET_TC_CLASS_H
+#define __NET_TC_CLASS_H
+
+#include <linux/overflow.h>
+#include <net/sch_generic.h>
+
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
+#endif
diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index e35a4e90f4e6..0bffa01c61bb 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -14,10 +14,10 @@
 #include <net/sch_generic.h>
 #include <net/pkt_sched.h>
 #include <net/pkt_cls.h>
+#include <net/tc_class.h>
 
 struct drr_class {
 	struct Qdisc_class_common	common;
-	unsigned int			filter_cnt;
 
 	struct gnet_stats_basic_sync		bstats;
 	struct gnet_stats_queue		qstats;
@@ -150,7 +150,7 @@ static int drr_delete_class(struct Qdisc *sch, unsigned long arg,
 	struct drr_sched *q = qdisc_priv(sch);
 	struct drr_class *cl = (struct drr_class *)arg;
 
-	if (cl->filter_cnt > 0)
+	if (qdisc_class_in_use(&cl->common))
 		return -EBUSY;
 
 	sch_tree_lock(sch);
@@ -187,8 +187,8 @@ static unsigned long drr_bind_tcf(struct Qdisc *sch, unsigned long parent,
 {
 	struct drr_class *cl = drr_find_class(sch, classid);
 
-	if (cl != NULL)
-		cl->filter_cnt++;
+	if (cl)
+		qdisc_class_get(&cl->common);
 
 	return (unsigned long)cl;
 }
@@ -197,7 +197,7 @@ static void drr_unbind_tcf(struct Qdisc *sch, unsigned long arg)
 {
 	struct drr_class *cl = (struct drr_class *)arg;
 
-	cl->filter_cnt--;
+	qdisc_class_put(&cl->common);
 }
 
 static int drr_graft_class(struct Qdisc *sch, unsigned long arg,
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 70b0c5873d32..122fe775c7ab 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -67,6 +67,7 @@
 #include <net/pkt_sched.h>
 #include <net/pkt_cls.h>
 #include <asm/div64.h>
+#include <net/tc_class.h>
 
 /*
  * kernel internal service curve representation:
@@ -116,7 +117,6 @@ struct hfsc_class {
 	struct net_rate_estimator __rcu *rate_est;
 	struct tcf_proto __rcu *filter_list; /* filter list */
 	struct tcf_block *block;
-	unsigned int	filter_cnt;	/* filter count */
 	unsigned int	level;		/* class level in hierarchy */
 
 	struct hfsc_sched *sched;	/* scheduler data */
@@ -1094,7 +1094,8 @@ hfsc_delete_class(struct Qdisc *sch, unsigned long arg,
 	struct hfsc_sched *q = qdisc_priv(sch);
 	struct hfsc_class *cl = (struct hfsc_class *)arg;
 
-	if (cl->level > 0 || cl->filter_cnt > 0 || cl == &q->root)
+	if (cl->level > 0 || qdisc_class_in_use(&cl->cl_common) ||
+	    cl == &q->root)
 		return -EBUSY;
 
 	sch_tree_lock(sch);
@@ -1223,7 +1224,7 @@ hfsc_bind_tcf(struct Qdisc *sch, unsigned long parent, u32 classid)
 	if (cl != NULL) {
 		if (p != NULL && p->level <= cl->level)
 			return 0;
-		cl->filter_cnt++;
+		qdisc_class_get(&cl->cl_common);
 	}
 
 	return (unsigned long)cl;
@@ -1234,7 +1235,7 @@ hfsc_unbind_tcf(struct Qdisc *sch, unsigned long arg)
 {
 	struct hfsc_class *cl = (struct hfsc_class *)arg;
 
-	cl->filter_cnt--;
+	qdisc_class_put(&cl->cl_common);
 }
 
 static struct tcf_block *hfsc_tcf_block(struct Qdisc *sch, unsigned long arg,
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 325c29041c7d..5223b63cec00 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -37,6 +37,7 @@
 #include <net/sch_generic.h>
 #include <net/pkt_sched.h>
 #include <net/pkt_cls.h>
+#include <net/tc_class.h>
 
 /* HTB algorithm.
     Author: devik@cdi.cz
@@ -102,7 +103,6 @@ struct htb_class {
 
 	struct tcf_proto __rcu	*filter_list;	/* class attached filters */
 	struct tcf_block	*block;
-	int			filter_cnt;
 
 	int			level;		/* our level (see above) */
 	unsigned int		children;
@@ -1710,7 +1710,7 @@ static int htb_delete(struct Qdisc *sch, unsigned long arg,
 	 * tc subsys guarantee us that in htb_destroy it holds no class
 	 * refs so that we can remove children safely there ?
 	 */
-	if (cl->children || cl->filter_cnt)
+	if (cl->children || qdisc_class_in_use(&cl->common))
 		return -EBUSY;
 
 	if (!cl->level && htb_parent_last_child(cl))
@@ -2108,7 +2108,7 @@ static unsigned long htb_bind_filter(struct Qdisc *sch, unsigned long parent,
 	 * be broken by class during destroy IIUC.
 	 */
 	if (cl)
-		cl->filter_cnt++;
+		qdisc_class_get(&cl->common);
 	return (unsigned long)cl;
 }
 
@@ -2116,8 +2116,7 @@ static void htb_unbind_filter(struct Qdisc *sch, unsigned long arg)
 {
 	struct htb_class *cl = (struct htb_class *)arg;
 
-	if (cl)
-		cl->filter_cnt--;
+	qdisc_class_put(&cl->common);
 }
 
 static void htb_walk(struct Qdisc *sch, struct qdisc_walker *arg)
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index befaf74b33ca..2515828d99a6 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -15,6 +15,7 @@
 #include <net/sch_generic.h>
 #include <net/pkt_sched.h>
 #include <net/pkt_cls.h>
+#include <net/tc_class.h>
 
 
 /*  Quick Fair Queueing Plus
@@ -130,8 +131,6 @@ struct qfq_aggregate;
 struct qfq_class {
 	struct Qdisc_class_common common;
 
-	unsigned int filter_cnt;
-
 	struct gnet_stats_basic_sync bstats;
 	struct gnet_stats_queue qstats;
 	struct net_rate_estimator __rcu *rate_est;
@@ -545,7 +544,7 @@ static int qfq_delete_class(struct Qdisc *sch, unsigned long arg,
 	struct qfq_sched *q = qdisc_priv(sch);
 	struct qfq_class *cl = (struct qfq_class *)arg;
 
-	if (cl->filter_cnt > 0)
+	if (qdisc_class_in_use(&cl->common))
 		return -EBUSY;
 
 	sch_tree_lock(sch);
@@ -581,7 +580,7 @@ static unsigned long qfq_bind_tcf(struct Qdisc *sch, unsigned long parent,
 	struct qfq_class *cl = qfq_find_class(sch, classid);
 
 	if (cl != NULL)
-		cl->filter_cnt++;
+		qdisc_class_get(&cl->common);
 
 	return (unsigned long)cl;
 }
@@ -590,7 +589,7 @@ static void qfq_unbind_tcf(struct Qdisc *sch, unsigned long arg)
 {
 	struct qfq_class *cl = (struct qfq_class *)arg;
 
-	cl->filter_cnt--;
+	qdisc_class_put(&cl->common);
 }
 
 static int qfq_graft_class(struct Qdisc *sch, unsigned long arg,
-- 
2.39.2


