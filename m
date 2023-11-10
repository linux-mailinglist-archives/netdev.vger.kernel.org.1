Return-Path: <netdev+bounces-47153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F017E853C
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 22:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85BF5B20C25
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 21:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218863C694;
	Fri, 10 Nov 2023 21:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="tUZLpby4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D203C6BD
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 21:46:33 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A917F131
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 13:46:32 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6b5cac99cfdso2289074b3a.2
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 13:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1699652792; x=1700257592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLZ2DL850ho8P3vKfdiUJyV00VKN43aA9i9uJjJoJO0=;
        b=tUZLpby4TrCMXTkrvyNSPHMPZMz9AhRjsA5yc8eeD20xYIm/9qCrlJLce3dNAKdQNE
         j6ZeEmRYihBcii5EFs3/7EmDwtQ9JrfOb/EGpjJM8GLGQEpnF2VG+fzNoQ2NRm1T+aJz
         d1HWyFXJerM47Qt1MmWw5EwHGBeKohW1Pwr0SmCb9g626bsTkOZ0KNvuG/hjZCjHmLL0
         XuIIGphd9Lesd+1tttN8f15pFq/X5yGliNRXm2est31I8VoDGhEgM6S5ivgp/FyfxrK+
         LWVE4/sG9xTH5rfTEX2ntocIytrueyUL5KvKnGkCB5WytBhWhNurxbb5YRzdHhj3Thv7
         SmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699652792; x=1700257592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLZ2DL850ho8P3vKfdiUJyV00VKN43aA9i9uJjJoJO0=;
        b=XhYcUpH9JuVPZQl+m1vUNV+iEnbvGosJEPr0tShlzFgdNNLSAitSXJz+r7tnMcc328
         hFpbUPkEKESghzqtpfHfzRP1eggex0w+O23E/n8NYOzMSJX2YIY7Vo3asCnCTqnFdF/g
         J9znMPZQ3dBy/3H9Jh2AnSJ4+cpUwPmfEUbf2v2y798lWUIeAol9Idf3EeHbaWxRYdKV
         giH9WoPlmBybdFkCTpYXXJUwHkcobLMnPitovLKazei4v0QSXmgrHGVamWKHBFIYas3t
         RcOhoJKbVBkG0OM32jzPM3lvNf41iok9IuToa9UQO9zjnI9W4dGC4DnGb3HCmcRjIYGC
         CXoA==
X-Gm-Message-State: AOJu0YxSFSoCEdNHeIP9INdfJiN9AlajcA/u6wVW84MqURKp8gnHM2d1
	bz7fr9w05p4WEnEWKM1Gn5kGgg==
X-Google-Smtp-Source: AGHT+IGRa2YgzXNzT6Asloe1QQbgy6ghk82dyxPbZ8m4ls2ggYLxgOXlN7PvHaCN8WZUdl2dfMXZHw==
X-Received: by 2002:a05:6a20:7487:b0:181:1fc8:c5de with SMTP id p7-20020a056a20748700b001811fc8c5demr446914pzd.43.1699652792162;
        Fri, 10 Nov 2023 13:46:32 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c3:6a74:a464:c4ff:7a79:ee97])
        by smtp.gmail.com with ESMTPSA id d13-20020a056a00244d00b006b90f1706f1sm166343pfj.134.2023.11.10.13.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 13:46:31 -0800 (PST)
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
Subject: [PATCH net-next RFC v5 2/4] net/sched: Introduce tc block netdev tracking infra
Date: Fri, 10 Nov 2023 18:46:16 -0300
Message-ID: <20231110214618.1883611-3-victor@mojatatu.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231110214618.1883611-1-victor@mojatatu.com>
References: <20231110214618.1883611-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tc block is a collection of netdevs/ports which allow qdiscs to share
filter block instances (as opposed to the traditional tc filter per port).
Example:
$ tc qdisc add dev ens7 ingress_block 22
$ tc qdisc add dev ens8 ingress_block 22

Now we can add a filter using the block index:
$ tc filter add block 22 protocol ip pref 25 \
  flower dst_ip 192.168.0.0/16 action drop

Up to this point, the block has been unaware of its ports. This patch makes
tc block aware of its ports. Patch 3 exposes tc block to the datapath.
Patch 4 shows a use case of the blockcast action which uses the tc block in its
datapath and then multicast packets to the tc block ports.

Suggested-by: Jiri Pirko <jiri@nvidia.com>
Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 include/net/sch_generic.h |  4 +++
 net/sched/cls_api.c       |  2 ++
 net/sched/sch_api.c       | 55 +++++++++++++++++++++++++++++++++++++++
 net/sched/sch_generic.c   | 31 ++++++++++++++++++++--
 4 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index dcb9160e6467..cefca55dd4f9 100644
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
@@ -457,6 +460,7 @@ struct tcf_chain {
 };
 
 struct tcf_block {
+	struct xarray ports; /* datapath accessible */
 	/* Lock protects tcf_block and lifetime-management data of chains
 	 * attached to the block (refcnt, action_refcnt, explicitly_created).
 	 */
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 1976bd163986..42f760ab7e43 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -531,6 +531,7 @@ static void tcf_block_destroy(struct tcf_block *block)
 {
 	mutex_destroy(&block->lock);
 	mutex_destroy(&block->proto_destroy_lock);
+	xa_destroy(&block->ports);
 	kfree_rcu(block, rcu);
 }
 
@@ -1003,6 +1004,7 @@ static struct tcf_block *tcf_block_create(struct net *net, struct Qdisc *q,
 	refcount_set(&block->refcnt, 1);
 	block->net = net;
 	block->index = block_index;
+	xa_init(&block->ports);
 
 	/* Don't store q pointer for blocks which are shared */
 	if (!tcf_block_shared(block))
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index e9eaf637220e..09ec64f2f463 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1180,6 +1180,57 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 	return 0;
 }
 
+static int qdisc_block_add_dev(struct Qdisc *sch, struct net_device *dev,
+			       struct nlattr **tca,
+			       struct netlink_ext_ack *extack)
+{
+	const struct Qdisc_class_ops *cl_ops = sch->ops->cl_ops;
+	struct tcf_block *in_block = NULL;
+	struct tcf_block *eg_block = NULL;
+	int err;
+
+	if (tca[TCA_INGRESS_BLOCK]) {
+		/* works for both ingress and clsact */
+		in_block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
+		if (!in_block) {
+			NL_SET_ERR_MSG(extack, "Shared ingress block missing");
+			return -EINVAL;
+		}
+
+		err = xa_insert(&in_block->ports, dev->ifindex, dev, GFP_KERNEL);
+		if (err) {
+			NL_SET_ERR_MSG(extack, "Ingress block dev insert failed");
+			return err;
+		}
+
+		netdev_hold(dev, &sch->in_block_tracker, GFP_KERNEL);
+	}
+
+	if (tca[TCA_EGRESS_BLOCK]) {
+		eg_block = cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
+		if (!eg_block) {
+			NL_SET_ERR_MSG(extack, "Shared egress block missing");
+			err = -EINVAL;
+			goto err_out;
+		}
+
+		err = xa_insert(&eg_block->ports, dev->ifindex, dev, GFP_KERNEL);
+		if (err) {
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
+	}
+	return err;
+}
+
 static int qdisc_block_indexes_set(struct Qdisc *sch, struct nlattr **tca,
 				   struct netlink_ext_ack *extack)
 {
@@ -1350,6 +1401,10 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 	qdisc_hash_add(sch, false);
 	trace_qdisc_create(ops, dev, parent);
 
+	err = qdisc_block_add_dev(sch, dev, tca, extack);
+	if (err)
+		goto err_out4;
+
 	return sch;
 
 err_out4:
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 4195a4bc26ca..83bea257904a 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1049,7 +1049,11 @@ static void qdisc_free_cb(struct rcu_head *head)
 
 static void __qdisc_destroy(struct Qdisc *qdisc)
 {
-	const struct Qdisc_ops  *ops = qdisc->ops;
+	struct net_device *dev = qdisc_dev(qdisc);
+	const struct Qdisc_ops *ops = qdisc->ops;
+	const struct Qdisc_class_ops *cops;
+	struct tcf_block *block;
+	u32 block_index;
 
 #ifdef CONFIG_NET_SCHED
 	qdisc_hash_del(qdisc);
@@ -1060,11 +1064,34 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
 
 	qdisc_reset(qdisc);
 
+	cops = ops->cl_ops;
+	if (ops->ingress_block_get) {
+		block_index = ops->ingress_block_get(qdisc);
+		if (block_index) {
+			block = cops->tcf_block(qdisc, TC_H_MIN_INGRESS, NULL);
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
+			block = cops->tcf_block(qdisc, TC_H_MIN_EGRESS, NULL);
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


