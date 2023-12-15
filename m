Return-Path: <netdev+bounces-57884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 309C4814671
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0F428636C
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556811CF95;
	Fri, 15 Dec 2023 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="YjBA/o2c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B909241FB
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cd68a0de49so224841a12.2
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702638661; x=1703243461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygyEZwF1YR5z6jXZiQzk4XC6RBqvSSAX6vi7C2CpXTc=;
        b=YjBA/o2c2axts/fXb6QCqMy4jPd8SkPG8ULOvzdfHaXwpW12LraJfG7PhSCcufCVvC
         zPwlJ8FQ82q/TJNuxQ097WQDzgWutcbDYtprDdSyoVXTAE7pYjme5kvspUgrn05M0o15
         6eLN/qnYrIbgx3ntdsH5qBnDLOoODODc39+Tho2W3ftHKaefwqw14Cv3aKdMlGPRo/bv
         FT7UY6x/2Gjo7w3FfQoJ3hNRVqprLdME0wdsC9Boks/51sb1cwxcXIYsYE9QDOn6PSmH
         cEGMOpel7mJBHU/S6gFJPg80e5G4ttayrC11lkCO1zknR0E2oTwnuE9t3W1LBt0Qdxgj
         gLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702638661; x=1703243461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygyEZwF1YR5z6jXZiQzk4XC6RBqvSSAX6vi7C2CpXTc=;
        b=tVsYaE26BdjH0WIClWWrBjaPRt8OBpZechzsMGTSM2Sh5PPyROYxzBVPWe5iT5EAkL
         sAp3wxQrVE/z89FG/8WF8X6eXhxaZsJr63ddC+pAZCdNKL1db+a/y4Daw1+0/HAL4npb
         P1gKM9vdHEngrayj2RpT0MvzOdQf6Cm5N7QgK3KdzvF4AXNS+MCKvgel+m/eKtANsRtc
         zu6EZPH58NcDo07hALlXUipQgnwURM/wII/BbuUs2C5vPJpnE4pjaJILg35mrzg/mXUl
         Ka6buJ6bbmKaTIVjWn31uBDXbSouhivAyo6okbetxHJIC9UxAxCIhgnXiDlmpv6Gwc4X
         EnyQ==
X-Gm-Message-State: AOJu0Yygf3aqI0hxSnN07hKS2VdwcxmxOEl6NcwebAyVgCy7WWfCxNZN
	dq+LwBeOYVtMVqsPNt0qqdvYqg==
X-Google-Smtp-Source: AGHT+IGpKGqMh4iqrHgGr8PRGt914NyS8+xopMtgV+k3OmUM6uIFk1I4/U7JuPZtHRXTNuLaZlg4Xg==
X-Received: by 2002:a05:6a20:3d1e:b0:18b:f4c6:4334 with SMTP id y30-20020a056a203d1e00b0018bf4c64334mr14404612pzi.6.1702638661618;
        Fri, 15 Dec 2023 03:11:01 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c0:60e3:4c1:486f:7eda:5fb5])
        by smtp.gmail.com with ESMTPSA id s16-20020a056a00195000b006cb574445efsm13329045pfk.88.2023.12.15.03.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 03:11:01 -0800 (PST)
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
Subject: [PATCH net-next v7 1/3] net/sched: Introduce tc block netdev tracking infra
Date: Fri, 15 Dec 2023 08:10:48 -0300
Message-ID: <20231215111050.3624740-2-victor@mojatatu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215111050.3624740-1-victor@mojatatu.com>
References: <20231215111050.3624740-1-victor@mojatatu.com>
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
index 8dd0e5925342..32bed60dea9f 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1050,7 +1050,11 @@ static void qdisc_free_cb(struct rcu_head *head)
 
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
@@ -1061,11 +1065,34 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
 
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


