Return-Path: <netdev+bounces-32966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D80B79B15B
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 01:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745451C20A37
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 23:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A8A8F6B;
	Mon, 11 Sep 2023 23:53:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3408BFA
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 23:53:01 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951C9142602
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 16:46:53 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c3bd829b86so11244485ad.0
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 16:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1694475942; x=1695080742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9D1Bhl0H8NbU3jUa3NQDcpZpCbAhCcaGuz0/sGstloI=;
        b=NegXA//iT0MFUr7axfPO0o/XyBko/Ua1UfsMgGlmGseEBcDXVHaa8HmG+lfmksipnI
         MgluKTYE/EMMi3uqzLpp2JW/SwO73b5+3VU5ZCU+b03lSqzi5VAZss8Vdp3AMgGepRdn
         hbVclN+I7C5WGPZmOH36MMU8C02mL8TsBvWeHZv661TevD6y9RSUjr76fYVoMCikrtkP
         8/S7S4MaUxofG36ZyZq/snNLhHi0/F73WGYzLHWlz4IDSVMugDvZmRC2i3zDvt4enCu9
         uiz4P/22TTc7m9XLnBLJTVIyv4hkXP5ekVoUNuDgvgr5eJ6wWUNTQZ1iBbDnFKawsMhC
         Mghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694475942; x=1695080742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9D1Bhl0H8NbU3jUa3NQDcpZpCbAhCcaGuz0/sGstloI=;
        b=u4brBocMwxz3tMhVp/eWgSuZKIFx7voVOZa0NmNkt2F/WqSHSFQ3COmsJLLmPDze47
         3U2qseowZPp2NcZGWH45OiYdEIW64BiUwFuJgTkhNpYyNCwtMLbtWEzxdw46mL8ov9Bi
         fD8NefQV6o3sDHl19H8RQJ+8mFIHhi11wV/rh6Zmw3Ed554PDC1UJFTUFj/Rb9xVzm2u
         rPVBBW0gaGL+RLFracdfh0RCNWJiGnekroYUMUdcal/e2JrPCxkXQrq1XFHwmpzDwMgx
         SLog1sbguLOV/w2p0CFaakDa3phu6PuFcSTK1u2qStcUuIGT4Q4NZzQq2Od5qVX4UYDz
         Hnlg==
X-Gm-Message-State: AOJu0YyWW231eHZ6DY1eeTd7ER/3fIR+Huw2l48zOAuaN3GawzfUcIzg
	QQ5sEuI/V+FrWsWPS4alYfSbtnDHB6wEIxVcDbc=
X-Google-Smtp-Source: AGHT+IHh1fcuPcdPOhBdaPwF8O9xydrNhcFq4NuYlKG6AKmt4I1tjj3aHTALHyCyOKYuMXrtnEIdhg==
X-Received: by 2002:a4a:765c:0:b0:56e:466c:7393 with SMTP id w28-20020a4a765c000000b0056e466c7393mr11572893ooe.5.1694474891320;
        Mon, 11 Sep 2023 16:28:11 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f1:e2c2:424f:fdef:90d5:8e0:d9])
        by smtp.gmail.com with ESMTPSA id l10-20020a9d7a8a000000b006b8c87551e8sm3534293otn.35.2023.09.11.16.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 16:28:11 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mleitner@redhat.com,
	vladbu@nvidia.com,
	horms@kernel.org,
	pctammela@mojatatu.com,
	netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH net-next v3 1/3] net/sched: Introduce tc block netdev tracking infra
Date: Mon, 11 Sep 2023 20:27:47 -0300
Message-ID: <20230911232749.14959-2-victor@mojatatu.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911232749.14959-1-victor@mojatatu.com>
References: <20230911232749.14959-1-victor@mojatatu.com>
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
and makes the tc block ports available to the datapath.

Suggested-by: Jiri Pirko <jiri@nvidia.com>
Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 include/net/sch_generic.h |  4 +++
 net/sched/cls_api.c       |  2 ++
 net/sched/sch_api.c       | 58 +++++++++++++++++++++++++++++++++++++++
 net/sched/sch_generic.c   | 34 +++++++++++++++++++++--
 4 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index f232512505f8..f002b0423efc 100644
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
index a193cc7b3241..06b55344a948 100644
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
index e9eaf637220e..66543e4d6cdc 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1180,6 +1180,60 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 	return 0;
 }
 
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
@@ -1350,6 +1404,10 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 	qdisc_hash_add(sch, false);
 	trace_qdisc_create(ops, dev, parent);
 
+	err = qdisc_block_add_dev(sch, dev, tca, extack);
+	if (err)
+		goto err_out4;
+
 	return sch;
 
 err_out4:
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


