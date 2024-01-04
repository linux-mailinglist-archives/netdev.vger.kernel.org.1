Return-Path: <netdev+bounces-61505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 744C482421E
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 13:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE14C2878A0
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 12:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3174021A1B;
	Thu,  4 Jan 2024 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ZYLleHS0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D258224D3
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 12:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50eaabc36bcso532201e87.2
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 04:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704373126; x=1704977926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fSKvcZ+Stv5TP4wzZxQYWoq+h0yXL7GY+rxeSOMByBg=;
        b=ZYLleHS0bbQWLiYNFFdPZrwCSG0ghYVHCw1TOmB13sXn2NKvEwCQCj96rFNwM1zMAV
         wCaobPZYBaLrhPQaJCJ9zwEirNJ0Yr+cKbYisifQxGWSrO6aRQCnu02lid/RXplNvT8v
         jqRaFLs3U1c97OFybhecPUvX3NkZgj3EkPiEwvdg1l+BcAgMRgRwKLsopD+fTPqjLDvI
         Fpzq/ZGa7CV67PzIrkMhmsnOkmtIGzYe2vYjwwE0oId/FSU61srp4hgGLUJbYq4lHVXC
         JosfX3jRuqdCXMtcRsj2RjfhsDBPp3scqI8/jDuTnoWvxOD3viH3aaoR+cPp0nK7cR7x
         uC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704373126; x=1704977926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fSKvcZ+Stv5TP4wzZxQYWoq+h0yXL7GY+rxeSOMByBg=;
        b=bAtbyibMEQpwK3jHlgq7qCJxOBH3HOy2rCCeAhfwZsTEdeNUqTSi+I2z+Cyxbl6VT1
         VTqeiYceBzFdZ3U5+tMUueqbPullS6N6cSEdL6Wfa8l09qWi+H7rA05VU90ApjFvR/yd
         PL7F+Mvvwb9uSfcApsBkfNPdVra/uIdoypg3kfFveIKjEreHgW2dEwv5YP3dWqClaPnL
         9VvyAhRe3vguRXn5Jo6Wj1kRKz6rR/K2brccGQ3Ny1p8bakuEAGBrpM+8Zalb8hIrQZs
         VS0cGmz3SDQeHINCiS6LoFSwqUJbyNhSVRptu/QDyVmfqeAMCfCCE5pYBv/wc0zowrK6
         JpIQ==
X-Gm-Message-State: AOJu0Yy9hcqvuiLVl/6NJoEj+7tyMhbauiktJrhMmWODPnfBgFGpc0kY
	GQRuHhfyWBWFTSvc6Q0EuumfuqM7dQbMnUEDNlm8fH3QVsyAow==
X-Google-Smtp-Source: AGHT+IHfPjgZMzfa/JIXMW0PLqCnTGdzoK7qLK6otqLy3cnjauHc/+Izhfu95eTDOt+IfpeRRlEEZg==
X-Received: by 2002:a05:6512:3cc:b0:50e:7b37:d17f with SMTP id w12-20020a05651203cc00b0050e7b37d17fmr322042lfp.114.1704373126310;
        Thu, 04 Jan 2024 04:58:46 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c500700b0040d81ca11casm5736118wmr.28.2024.01.04.04.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 04:58:45 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	victor@mojatatu.com,
	pctammela@mojatatu.com,
	idosch@idosch.org,
	mleitner@redhat.com,
	vladbu@nvidia.com,
	paulb@nvidia.com
Subject: [patch net-next] net: sched: move block device tracking into tcf_block_get/put_ext()
Date: Thu,  4 Jan 2024 13:58:44 +0100
Message-ID: <20240104125844.1522062-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Inserting the device to block xarray in qdisc_create() is not suitable
place to do this. As it requires use of tcf_block() callback, it causes
multiple issues. It is called for all qdisc types, which is incorrect.

So, instead, move it to more suitable place, which is tcf_block_get_ext()
and make sure it is only done for qdiscs that use block infrastructure
and also only for blocks which are shared.

Symmetrically, alter the cleanup path, move the xarray entry removal
into tcf_block_put_ext().

Fixes: 913b47d3424e ("net/sched: Introduce tc block netdev tracking infra")
Reported-by: Ido Schimmel <idosch@nvidia.com>
Closes: https://lore.kernel.org/all/ZY1hBb8GFwycfgvd@shredder/
Reported-by: Kui-Feng Lee <sinquersw@gmail.com>
Closes: https://lore.kernel.org/all/ce8d3e55-b8bc-409c-ace9-5cf1c4f7c88e@gmail.com/
Reported-and-tested-by: syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/0000000000007c85f5060dcc3a28@google.com/
Reported-and-tested-by: syzbot+806b0572c8d06b66b234@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/00000000000082f2f2060dcc3a92@google.com/
Reported-and-tested-by: syzbot+0039110f932d438130f9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/0000000000007fbc8c060dcc3a5c@google.com/
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/sched/cls_api.c     | 14 ++++++++++++++
 net/sched/sch_api.c     | 41 -----------------------------------------
 net/sched/sch_generic.c | 14 --------------
 3 files changed, 14 insertions(+), 55 deletions(-)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index adf5de1ff773..253b26f2eddd 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1428,6 +1428,7 @@ int tcf_block_get_ext(struct tcf_block **p_block, struct Qdisc *q,
 		      struct tcf_block_ext_info *ei,
 		      struct netlink_ext_ack *extack)
 {
+	struct net_device *dev = qdisc_dev(q);
 	struct net *net = qdisc_net(q);
 	struct tcf_block *block = NULL;
 	int err;
@@ -1461,9 +1462,18 @@ int tcf_block_get_ext(struct tcf_block **p_block, struct Qdisc *q,
 	if (err)
 		goto err_block_offload_bind;
 
+	if (tcf_block_shared(block)) {
+		err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
+		if (err) {
+			NL_SET_ERR_MSG(extack, "block dev insert failed");
+			goto err_dev_insert;
+		}
+	}
+
 	*p_block = block;
 	return 0;
 
+err_dev_insert:
 err_block_offload_bind:
 	tcf_chain0_head_change_cb_del(block, ei);
 err_chain0_head_change_cb_add:
@@ -1502,8 +1512,12 @@ EXPORT_SYMBOL(tcf_block_get);
 void tcf_block_put_ext(struct tcf_block *block, struct Qdisc *q,
 		       struct tcf_block_ext_info *ei)
 {
+	struct net_device *dev = qdisc_dev(q);
+
 	if (!block)
 		return;
+	if (tcf_block_shared(block))
+		xa_erase(&block->ports, dev->ifindex);
 	tcf_chain0_head_change_cb_del(block, ei);
 	tcf_block_owner_del(block, q, ei->binder_type);
 
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 2a2a48838eb9..36b025cc4fd2 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1209,43 +1209,6 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 	return 0;
 }
 
-static int qdisc_block_add_dev(struct Qdisc *sch, struct net_device *dev,
-			       struct netlink_ext_ack *extack)
-{
-	const struct Qdisc_class_ops *cl_ops = sch->ops->cl_ops;
-	struct tcf_block *block;
-	int err;
-
-	block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
-	if (block) {
-		err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
-		if (err) {
-			NL_SET_ERR_MSG(extack,
-				       "ingress block dev insert failed");
-			return err;
-		}
-	}
-
-	block = cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
-	if (block) {
-		err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
-		if (err) {
-			NL_SET_ERR_MSG(extack,
-				       "Egress block dev insert failed");
-			goto err_out;
-		}
-	}
-
-	return 0;
-
-err_out:
-	block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
-	if (block)
-		xa_erase(&block->ports, dev->ifindex);
-
-	return err;
-}
-
 static int qdisc_block_indexes_set(struct Qdisc *sch, struct nlattr **tca,
 				   struct netlink_ext_ack *extack)
 {
@@ -1416,10 +1379,6 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 	qdisc_hash_add(sch, false);
 	trace_qdisc_create(ops, dev, parent);
 
-	err = qdisc_block_add_dev(sch, dev, extack);
-	if (err)
-		goto err_out4;
-
 	return sch;
 
 err_out4:
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index e33568df97a5..9b3e9262040b 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1052,8 +1052,6 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
 {
 	const struct Qdisc_ops  *ops = qdisc->ops;
 	struct net_device *dev = qdisc_dev(qdisc);
-	const struct Qdisc_class_ops *cops;
-	struct tcf_block *block;
 
 #ifdef CONFIG_NET_SCHED
 	qdisc_hash_del(qdisc);
@@ -1064,18 +1062,6 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
 
 	qdisc_reset(qdisc);
 
-	cops = ops->cl_ops;
-	if (ops->ingress_block_get) {
-		block = cops->tcf_block(qdisc, TC_H_MIN_INGRESS, NULL);
-		if (block)
-			xa_erase(&block->ports, dev->ifindex);
-	}
-
-	if (ops->egress_block_get) {
-		block = cops->tcf_block(qdisc, TC_H_MIN_EGRESS, NULL);
-		if (block)
-			xa_erase(&block->ports, dev->ifindex);
-	}
 
 	if (ops->destroy)
 		ops->destroy(qdisc);
-- 
2.43.0


