Return-Path: <netdev+bounces-59014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BB8818F9B
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 19:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 600681C24CB2
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 18:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075E937D18;
	Tue, 19 Dec 2023 18:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="uMiGf9HG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D5B38DE9
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 18:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d3ce28ac3cso15732055ad.0
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 10:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1703009796; x=1703614596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQM7qwcrspGj9463ucX1D7t5PuWYmon3CQwKnuOsjpA=;
        b=uMiGf9HGE6tX4sbhgxH2sWevG6z8lq7XEjRtYzB4KUBrJTMV34Uz4V/x5+PX59wwZL
         ab13bHW7jeO27lzogPDxe2ehDLjJUajQKszRB2efqU8LdJszQGHODByDzVr1L0mTqIcr
         oUCwnY54X0GmMLzAle7dESQJJ2P52FCbcSDGebwbHJWdEpWaoI+j/JYFayZ/NLXielqj
         nCRIRiQAZQYyYsK8wdV5GDEQEPohnj3Vma09oLyIyzP5j82uawhPffWKpMLmLkinmSJA
         iaFf0UFCPK5fKHlQkm4EmYATx9lh08z/TQDVnFu5GWo5ElLIuHzjbTrZZc+jlXMQABvF
         D50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703009796; x=1703614596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQM7qwcrspGj9463ucX1D7t5PuWYmon3CQwKnuOsjpA=;
        b=ejGTBTfasd22RPIphEfxeTHmPREB9tr1hjWnQ4BUMc8zlOnJj1NB0TJ6ep3vIGABlo
         HcJ+Lwb+5NRO/5N9Vq0MGeoBVCdv0Gw4K+qX0cBCOpfcIW1uvsSZsj9SuqBh68vtXNR0
         O9FrsO7DSbsf89TUu6cymmF5XKLfBHimUWcIal1MskgdKe8ZJQEs2BMGwkmb1oWfZnm2
         DunxuQndem71o5WdZ3KMvGa8zlmygQL51YukmL5DwKcZFlVyOUyC/OSiCfW5ejQv74tr
         YL78BRqChrtYrJ9xNQvFBcn3bsSlnoyPGMnGgrT/o0UHHiczj8oDujxDqvayvOS+ES6n
         jXUw==
X-Gm-Message-State: AOJu0YzyA0A6TA5iYuCA1jEAlaHaYBoMSO7zvvdZ5GGfXAVH4Q5nT2fZ
	nffawMxL0wKI/zwbsJojNy1WGg==
X-Google-Smtp-Source: AGHT+IFV8uuuNcPRGEypjtqQv9W+rBBfmEgkEvWf5FIRWQ8cLQao/Gj9oSbg8vAsBn9zcvuZGnLnNg==
X-Received: by 2002:a17:902:a383:b0:1d0:84f1:6fb8 with SMTP id x3-20020a170902a38300b001d084f16fb8mr7847794pla.68.1703009795980;
        Tue, 19 Dec 2023 10:16:35 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c0:60e3:4c1:486f:7eda:5fb5])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902f54b00b001d348571ccesm4372188plf.240.2023.12.19.10.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 10:16:35 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us
Cc: mleitner@redhat.com,
	vladbu@nvidia.com,
	paulb@nvidia.com,
	pctammela@mojatatu.com,
	netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH net-next v8 1/5] net/sched: Introduce tc block netdev tracking infra
Date: Tue, 19 Dec 2023 15:16:19 -0300
Message-ID: <20231219181623.3845083-2-victor@mojatatu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219181623.3845083-1-victor@mojatatu.com>
References: <20231219181623.3845083-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit makes tc blocks track which ports have been added to them.
And, with that, we'll be able to use this new information to send
packets to the block's ports. Which will be done in the patch #3 of this
series.

Suggested-by: Jiri Pirko <jiri@nvidia.com>
Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 include/net/sch_generic.h |  2 ++
 net/sched/cls_api.c       |  2 ++
 net/sched/sch_api.c       | 41 +++++++++++++++++++++++++++++++++++++++
 net/sched/sch_generic.c   | 18 ++++++++++++++++-
 4 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index dcb9160e6467..248692ec3697 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -19,6 +19,7 @@
 #include <net/gen_stats.h>
 #include <net/rtnetlink.h>
 #include <net/flow_offload.h>
+#include <linux/xarray.h>
 
 struct Qdisc_ops;
 struct qdisc_walker;
@@ -457,6 +458,7 @@ struct tcf_chain {
 };
 
 struct tcf_block {
+	struct xarray ports; /* datapath accessible */
 	/* Lock protects tcf_block and lifetime-management data of chains
 	 * attached to the block (refcnt, action_refcnt, explicitly_created).
 	 */
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index dc1c19a25882..6020a32ecff2 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -531,6 +531,7 @@ static void tcf_block_destroy(struct tcf_block *block)
 {
 	mutex_destroy(&block->lock);
 	mutex_destroy(&block->proto_destroy_lock);
+	xa_destroy(&block->ports);
 	kfree_rcu(block, rcu);
 }
 
@@ -1002,6 +1003,7 @@ static struct tcf_block *tcf_block_create(struct net *net, struct Qdisc *q,
 	refcount_set(&block->refcnt, 1);
 	block->net = net;
 	block->index = block_index;
+	xa_init(&block->ports);
 
 	/* Don't store q pointer for blocks which are shared */
 	if (!tcf_block_shared(block))
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index e9eaf637220e..299086bb6205 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1180,6 +1180,43 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 	return 0;
 }
 
+static int qdisc_block_add_dev(struct Qdisc *sch, struct net_device *dev,
+			       struct netlink_ext_ack *extack)
+{
+	const struct Qdisc_class_ops *cl_ops = sch->ops->cl_ops;
+	struct tcf_block *block;
+	int err;
+
+	block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
+	if (block) {
+		err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
+		if (err) {
+			NL_SET_ERR_MSG(extack,
+				       "ingress block dev insert failed");
+			return err;
+		}
+	}
+
+	block = cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
+	if (block) {
+		err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
+		if (err) {
+			NL_SET_ERR_MSG(extack,
+				       "Egress block dev insert failed");
+			goto err_out;
+		}
+	}
+
+	return 0;
+
+err_out:
+	block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
+	if (block)
+		xa_erase(&block->ports, dev->ifindex);
+
+	return err;
+}
+
 static int qdisc_block_indexes_set(struct Qdisc *sch, struct nlattr **tca,
 				   struct netlink_ext_ack *extack)
 {
@@ -1350,6 +1387,10 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 	qdisc_hash_add(sch, false);
 	trace_qdisc_create(ops, dev, parent);
 
+	err = qdisc_block_add_dev(sch, dev, extack);
+	if (err)
+		goto err_out4;
+
 	return sch;
 
 err_out4:
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 8dd0e5925342..e33568df97a5 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1051,6 +1051,9 @@ static void qdisc_free_cb(struct rcu_head *head)
 static void __qdisc_destroy(struct Qdisc *qdisc)
 {
 	const struct Qdisc_ops  *ops = qdisc->ops;
+	struct net_device *dev = qdisc_dev(qdisc);
+	const struct Qdisc_class_ops *cops;
+	struct tcf_block *block;
 
 #ifdef CONFIG_NET_SCHED
 	qdisc_hash_del(qdisc);
@@ -1061,11 +1064,24 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
 
 	qdisc_reset(qdisc);
 
+	cops = ops->cl_ops;
+	if (ops->ingress_block_get) {
+		block = cops->tcf_block(qdisc, TC_H_MIN_INGRESS, NULL);
+		if (block)
+			xa_erase(&block->ports, dev->ifindex);
+	}
+
+	if (ops->egress_block_get) {
+		block = cops->tcf_block(qdisc, TC_H_MIN_EGRESS, NULL);
+		if (block)
+			xa_erase(&block->ports, dev->ifindex);
+	}
+
 	if (ops->destroy)
 		ops->destroy(qdisc);
 
 	module_put(ops->owner);
-	netdev_put(qdisc_dev(qdisc), &qdisc->dev_tracker);
+	netdev_put(dev, &qdisc->dev_tracker);
 
 	trace_qdisc_destroy(qdisc);
 
-- 
2.25.1


