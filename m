Return-Path: <netdev+bounces-29123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF088781A8C
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 18:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3085A28106C
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 16:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7635518C27;
	Sat, 19 Aug 2023 16:35:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69628A57
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 16:35:29 +0000 (UTC)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D795F902B
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 09:35:27 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-56ffe7eee6fso495975eaf.1
        for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 09:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692462927; x=1693067727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HGvG8kemDNif8PiiKjFRJ4/vBmbS0xJERu31ArHdx8=;
        b=E4vUkSzHe95dU1onS2V91rLuatnjwT7Arg467ARgcTg5WcI7ZIrx/2BZ/Ico62GOgm
         cTCMl/+sT0+4a55J22tqGiCM/9BPURDFR/qqX54jc3uCeHs6fPfdI2Mq7NN2gW0/kw8O
         QvQImhC67rHVadt+Q456mh6QtfU8FU3iDpR6DArzWCdAum7/hn1krzOE7nImcqDNRIll
         CbuGqVqtAU0rN07U5/UXe0J5uQjiqljXhkfNLypmAZVms6FwwfsGawFdiFTp/gFf+U+b
         /K9xnlrGRJ5AoQwTqDkpLBzM+RRNHsKHYL+DN47rS2idiqAJ+rQy8dWjAt9dn/RVsvmp
         O4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692462927; x=1693067727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HGvG8kemDNif8PiiKjFRJ4/vBmbS0xJERu31ArHdx8=;
        b=cMD0F51KgzMGnjXufy6Jcbtt7pFNOYuOVwsfu7vRITRXVoWX8I9XNbCvcZ3/jggdct
         KCFqDaNMdOWJxDxNuRItinygSTpSr8nujBEc+s9ODC/pO+jXzd0zsUrMSD1LYtsE2FXu
         pJDylAMP+18RMw3xiGUJ+GAcm1THvTg/NZiI9oocSH4S3BYFec+1MWSll6QSrRYW+hTQ
         Mzl9t64i2oCqYnS0ev3xgNb9Xo7Z1hBLO0Wz69uNbkfD461WdvCRDgWDbCedDtahky/+
         AephN5GGztpZOTZkRtlZ6V1Hzmb5wKUACW2pldY4fcj5+AvWIfGQ2UqAkms6pH+WhuMJ
         0iRw==
X-Gm-Message-State: AOJu0Yx0k+snLfKvhRQtuw1M6B/PdqqK/iU9C+6Mv26lUN2ZQA3fLZdP
	HlfJcynC87P0+HPNjHpORdYj0A==
X-Google-Smtp-Source: AGHT+IFGFOE6f8lzw7nDIIppPSWqGG9nmKVWg6J5CQDIyshAUShYq1U8BkKsTVpiSDqdm675tT4sGQ==
X-Received: by 2002:aca:2811:0:b0:3a7:3374:9a43 with SMTP id 17-20020aca2811000000b003a733749a43mr2919949oix.57.1692462927216;
        Sat, 19 Aug 2023 09:35:27 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c1:d019:34ee:449:f6bb:38e9])
        by smtp.gmail.com with ESMTPSA id p187-20020acaf1c4000000b003a7847cf407sm2098303oih.44.2023.08.19.09.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 09:35:26 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: mleitner@redhat.com,
	vladbu@nvidia.com,
	horms@kernel.org,
	pctammela@mojatatu.com,
	kernel@mojatatu.com
Subject: [PATCH net-next v2 1/3] net/sched: Introduce tc block netdev tracking infra
Date: Sat, 19 Aug 2023 13:35:12 -0300
Message-ID: <20230819163515.2266246-2-victor@mojatatu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230819163515.2266246-1-victor@mojatatu.com>
References: <20230819163515.2266246-1-victor@mojatatu.com>
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

The tc block is a collection of netdevs/ports which allow qdiscs to share
filter block instances (as opposed to the traditional tc filter per port).
Example:
$ tc qdisc add dev ens7 ingress block 22
$ tc qdisc add dev ens8 ingress block 22

Now we can add a filter using the block index:
$ tc filter add block 22 protocol ip pref 25 \
  flower dst_ip 192.168.0.0/16 action drop

Up to this point, the block is unaware of its ports. This patch fixes that
and makes the tc block ports available to the datapath as well as control
path on offloading.

Suggested-by: Jiri Pirko <jiri@nvidia.com>
Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 include/net/sch_generic.h |  4 ++
 net/sched/cls_api.c       |  1 +
 net/sched/sch_api.c       | 79 +++++++++++++++++++++++++++++++++++++--
 net/sched/sch_generic.c   | 34 ++++++++++++++++-
 4 files changed, 112 insertions(+), 6 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index e92f73bb3198..824a0ecb5afc 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -19,6 +19,7 @@
 #include <net/gen_stats.h>
 #include <net/rtnetlink.h>
 #include <net/flow_offload.h>
+#include <linux/xarray.h>
 
 struct Qdisc_ops;
 struct qdisc_walker;
@@ -126,6 +127,8 @@ struct Qdisc {
 
 	struct rcu_head		rcu;
 	netdevice_tracker	dev_tracker;
+	netdevice_tracker	in_block_tracker;
+	netdevice_tracker	eg_block_tracker;
 	/* private data */
 	long privdata[] ____cacheline_aligned;
 };
@@ -458,6 +461,7 @@ struct tcf_chain {
 };
 
 struct tcf_block {
+	struct xarray ports; /* datapath accessible */
 	/* Lock protects tcf_block and lifetime-management data of chains
 	 * attached to the block (refcnt, action_refcnt, explicitly_created).
 	 */
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index a193cc7b3241..a976792ef02f 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1003,6 +1003,7 @@ static struct tcf_block *tcf_block_create(struct net *net, struct Qdisc *q,
 	refcount_set(&block->refcnt, 1);
 	block->net = net;
 	block->index = block_index;
+	xa_init(&block->ports);
 
 	/* Don't store q pointer for blocks which are shared */
 	if (!tcf_block_shared(block))
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index aa6b1fe65151..6c0c220cdb21 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1180,6 +1180,71 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 	return 0;
 }
 
+static void qdisc_block_undo_set(struct Qdisc *sch, struct nlattr **tca)
+{
+	if (tca[TCA_INGRESS_BLOCK])
+		sch->ops->ingress_block_set(sch, 0);
+
+	if (tca[TCA_EGRESS_BLOCK])
+		sch->ops->egress_block_set(sch, 0);
+}
+
+static int qdisc_block_add_dev(struct Qdisc *sch, struct net_device *dev,
+			       struct nlattr **tca,
+			       struct netlink_ext_ack *extack)
+{
+	const struct Qdisc_class_ops *cl_ops = sch->ops->cl_ops;
+	struct tcf_block *in_block = NULL;
+	struct tcf_block *eg_block = NULL;
+	unsigned long cl = 0;
+	int err;
+
+	if (tca[TCA_INGRESS_BLOCK]) {
+		/* works for both ingress and clsact */
+		cl = TC_H_MIN_INGRESS;
+		in_block = cl_ops->tcf_block(sch, cl, NULL);
+		if (!in_block) {
+			NL_SET_ERR_MSG(extack, "Shared ingress block missing");
+			return -EINVAL;
+		}
+
+		err = xa_insert(&in_block->ports, dev->ifindex, dev, GFP_KERNEL);
+		if (err) {
+			NL_SET_ERR_MSG(extack, "ingress block dev insert failed");
+			return err;
+		}
+
+		netdev_hold(dev, &sch->in_block_tracker, GFP_KERNEL);
+	}
+
+	if (tca[TCA_EGRESS_BLOCK]) {
+		cl = TC_H_MIN_EGRESS;
+		eg_block = cl_ops->tcf_block(sch, cl, NULL);
+		if (!eg_block) {
+			NL_SET_ERR_MSG(extack, "Shared egress block missing");
+			err = -EINVAL;
+			goto err_out;
+		}
+
+		err = xa_insert(&eg_block->ports, dev->ifindex, dev, GFP_KERNEL);
+		if (err) {
+			netdev_put(dev, &sch->eg_block_tracker);
+			NL_SET_ERR_MSG(extack, "Egress block dev insert failed");
+			goto err_out;
+		}
+		netdev_hold(dev, &sch->eg_block_tracker, GFP_KERNEL);
+	}
+
+	return 0;
+err_out:
+	if (in_block) {
+		xa_erase(&in_block->ports, dev->ifindex);
+		netdev_put(dev, &sch->in_block_tracker);
+		NL_SET_ERR_MSG(extack, "ingress block dev insert failed");
+	}
+	return err;
+}
+
 static int qdisc_block_indexes_set(struct Qdisc *sch, struct nlattr **tca,
 				   struct netlink_ext_ack *extack)
 {
@@ -1270,7 +1335,7 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 	sch = qdisc_alloc(dev_queue, ops, extack);
 	if (IS_ERR(sch)) {
 		err = PTR_ERR(sch);
-		goto err_out2;
+		goto err_out1;
 	}
 
 	sch->parent = parent;
@@ -1289,7 +1354,7 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 			if (handle == 0) {
 				NL_SET_ERR_MSG(extack, "Maximum number of qdisc handles was exceeded");
 				err = -ENOSPC;
-				goto err_out3;
+				goto err_out2;
 			}
 		}
 		if (!netif_is_multiqueue(dev))
@@ -1311,7 +1376,7 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 
 	err = qdisc_block_indexes_set(sch, tca, extack);
 	if (err)
-		goto err_out3;
+		goto err_out2;
 
 	if (tca[TCA_STAB]) {
 		stab = qdisc_get_stab(tca[TCA_STAB], extack);
@@ -1350,6 +1415,10 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 	qdisc_hash_add(sch, false);
 	trace_qdisc_create(ops, dev, parent);
 
+	err = qdisc_block_add_dev(sch, dev, tca, extack);
+	if (err)
+		goto err_out4;
+
 	return sch;
 
 err_out4:
@@ -1360,9 +1429,11 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 		ops->destroy(sch);
 	qdisc_put_stab(rtnl_dereference(sch->stab));
 err_out3:
+	qdisc_block_undo_set(sch, tca);
+err_out2:
 	netdev_put(dev, &sch->dev_tracker);
 	qdisc_free(sch);
-err_out2:
+err_out1:
 	module_put(ops->owner);
 err_out:
 	*errp = err;
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 5d7e23f4cc0e..0fb51fd6f01e 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1048,7 +1048,12 @@ static void qdisc_free_cb(struct rcu_head *head)
 
 static void __qdisc_destroy(struct Qdisc *qdisc)
 {
-	const struct Qdisc_ops  *ops = qdisc->ops;
+	struct net_device *dev = qdisc_dev(qdisc);
+	const struct Qdisc_ops *ops = qdisc->ops;
+	const struct Qdisc_class_ops *cops;
+	struct tcf_block *block;
+	unsigned long cl;
+	u32 block_index;
 
 #ifdef CONFIG_NET_SCHED
 	qdisc_hash_del(qdisc);
@@ -1059,11 +1064,36 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
 
 	qdisc_reset(qdisc);
 
+	cops = ops->cl_ops;
+	if (ops->ingress_block_get) {
+		block_index = ops->ingress_block_get(qdisc);
+		if (block_index) {
+			cl = TC_H_MIN_INGRESS;
+			block = cops->tcf_block(qdisc, cl, NULL);
+			if (block) {
+				if (xa_erase(&block->ports, dev->ifindex))
+					netdev_put(dev, &qdisc->in_block_tracker);
+			}
+		}
+	}
+
+	if (ops->egress_block_get) {
+		block_index = ops->egress_block_get(qdisc);
+		if (block_index) {
+			cl = TC_H_MIN_EGRESS;
+			block = cops->tcf_block(qdisc, cl, NULL);
+			if (block) {
+				if (xa_erase(&block->ports, dev->ifindex))
+					netdev_put(dev, &qdisc->eg_block_tracker);
+			}
+		}
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


