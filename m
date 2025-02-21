Return-Path: <netdev+bounces-168642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7473DA40016
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 20:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5FC19E1112
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 19:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D052253349;
	Fri, 21 Feb 2025 19:56:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F01A253329
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 19:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740167771; cv=none; b=BxHSaNbmOG3zlAM5jJaYgEzn7MsL6eCYQkH9WHpZfnlPdBg+yF4fg3XzMJJQAxmNwivp1eRTp7Dm00kTVwx2ZYCKpLNI3njh0oLifZ83uV8bmT0Z3kILBAfnK2IVkjLW8CWG2FcTm8JmJF/co5OXro2+AoeZiKmrEv/gCt+bkOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740167771; c=relaxed/simple;
	bh=jsfO3whW1qLkAJ8nnGWOZjIdPBxlPqq8myGQkYXX/1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGMpbLd8lywzzHbE9BD8hJ8AKisGADXT/zIiFCE99ni+5ygs6cNKyjEzOyCEscdOYwT5mPKOSN7yZSzSBL7sv+nfFEyS4ngC2Wrk+jPSh/c8fJe4Mce/qnTYZJfz1TjodUYqPNmMYMDynGt4LkWInVemDYiPcTdxmnXmabjyZII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22104c4de96so45180295ad.3
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 11:56:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740167768; x=1740772568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOzgkT05HuwXkvE6n0wiqNgWFoujwb5bFIwqMxJ0Ljc=;
        b=jlhU8DWU6aVkQP9tYscn9Ezvt0UzRzNekQEvG/GkHVTHqtJ9dHsCW8aSCupG6I517H
         wh8aJz/+zCH10ZGg2K8n/kaE51k766XICpgFeyJBzb9kJWWYFqUvl/BPEFG9qJCAIXJq
         PMCEEPTrTtC6jFZeZtdDwSeN0EG7p+c7rrdGaal0MYGCt7KJyLLwBhS3LiYq1e497yCY
         wTp/uh/YE9NxIvcR70Q+T/DP97kfLh5nsYJU2zZRWzfGgwe34f+TgW9dYRsNlvznP97f
         n8eFqrvV8d4MnHKu4b8gzGxl0tqQ0QfGiaNRPQN0ggX7UYXrf4awhb+ZluGCKE2mtNU3
         qnCQ==
X-Gm-Message-State: AOJu0YyxPK+XDxHO3H82lOKAOZgj2dtnEf1E1xFZckxR3N7D0S7thtRt
	xbQJwVfz6Jy05BKIledjXipDKkuowN5CRsmkfbl8ib0e9FTmtsu6450/
X-Gm-Gg: ASbGncsEHZAWebPWK2lwD3XbCwIF3zl+TZMsjgNcQkx22FygtcoDUUR65pVLJwZmK97
	GZf1bjqVWbexloh9+HxDF6bYbkM2ypCk0e5vmR5Nls6KjM8ht2ZUwKaQxqZ0iKTmdyWSED8uXLP
	iA3LoY52PZQUTaXN+f0nMs+nHIHlY0XKTPnoT/YxYEvw9/7/UYwqWqFOsw5MxDd9LHjVGnd4/Rj
	0EThZFo7sH4uXe/qoXeVfksyaghQzFaBDui4x2+e76Rw408LJRiVG/S+m78W9w9OLHoKZ7HiI2L
	XcaqX6rWumlFkP0TA1D4ZKdwGw==
X-Google-Smtp-Source: AGHT+IFQl6i5OuTmpXv9eYkysOxEbrcvKzsi+NUUqLSFYU+Qforc5WO7KjJBOf3u6tRYK0x9BIypMQ==
X-Received: by 2002:a17:902:d4cd:b0:21f:6546:9af0 with SMTP id d9443c01a7336-2219fffa862mr78148925ad.44.1740167768298;
        Fri, 21 Feb 2025 11:56:08 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73413894baesm3947428b3a.153.2025.02.21.11.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 11:56:07 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v6 02/12] net: hold netdev instance lock during ndo_setup_tc
Date: Fri, 21 Feb 2025 11:55:54 -0800
Message-ID: <20250221195604.2103132-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221195604.2103132-1-sdf@fomichev.me>
References: <20250221195604.2103132-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce new dev_setup_tc that handles the details and call it from
all qdiscs/classifiers. The instance lock is still applied only to
the drivers that implement shaper API so only iavf is affected.

Cc: Saeed Mahameed <saeed@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c |  2 --
 include/linux/netdevice.h                   |  2 ++
 net/core/dev.c                              | 18 ++++++++++++++++++
 net/dsa/user.c                              |  5 +----
 net/netfilter/nf_flow_table_offload.c       |  2 +-
 net/netfilter/nf_tables_offload.c           |  2 +-
 net/sched/cls_api.c                         |  2 +-
 net/sched/sch_api.c                         |  8 +++-----
 net/sched/sch_cbs.c                         |  8 +++-----
 net/sched/sch_etf.c                         |  8 +++-----
 net/sched/sch_ets.c                         |  4 ++--
 net/sched/sch_fifo.c                        |  4 ++--
 net/sched/sch_gred.c                        |  2 +-
 net/sched/sch_htb.c                         |  2 +-
 net/sched/sch_mq.c                          |  2 +-
 net/sched/sch_mqprio.c                      |  6 ++----
 net/sched/sch_prio.c                        |  2 +-
 net/sched/sch_red.c                         |  5 ++---
 net/sched/sch_taprio.c                      | 12 ++++--------
 net/sched/sch_tbf.c                         |  4 ++--
 20 files changed, 51 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 4cc8c55b8f95..200e0f871adb 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3890,10 +3890,8 @@ static int __iavf_setup_tc(struct net_device *netdev, void *type_data)
 	if (test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section))
 		return 0;
 
-	netdev_lock(netdev);
 	netif_set_real_num_rx_queues(netdev, total_qps);
 	netif_set_real_num_tx_queues(netdev, total_qps);
-	netdev_unlock(netdev);
 
 	return ret;
 }
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d074ad66766e..6b9dfdfb6c3b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3324,6 +3324,8 @@ int dev_alloc_name(struct net_device *dev, const char *name);
 int dev_open(struct net_device *dev, struct netlink_ext_ack *extack);
 void dev_close(struct net_device *dev);
 void dev_close_many(struct list_head *head, bool unlink);
+int dev_setup_tc(struct net_device *dev, enum tc_setup_type type,
+		 void *type_data);
 void dev_disable_lro(struct net_device *dev);
 int dev_loopback_xmit(struct net *net, struct sock *sk, struct sk_buff *newskb);
 u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
diff --git a/net/core/dev.c b/net/core/dev.c
index 6aaec16ffe50..fc4067e9bc93 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1786,6 +1786,24 @@ void dev_close(struct net_device *dev)
 }
 EXPORT_SYMBOL(dev_close);
 
+int dev_setup_tc(struct net_device *dev, enum tc_setup_type type,
+		 void *type_data)
+{
+	const struct net_device_ops *ops = dev->netdev_ops;
+	int ret;
+
+	ASSERT_RTNL();
+
+	if (!ops->ndo_setup_tc)
+		return -EOPNOTSUPP;
+
+	netdev_lock_ops(dev);
+	ret = ops->ndo_setup_tc(dev, type, type_data);
+	netdev_unlock_ops(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL(dev_setup_tc);
 
 /**
  *	dev_disable_lro - disable Large Receive Offload on a device
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 2296a4ead020..a2c0ab24a746 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1738,10 +1738,7 @@ static int dsa_user_setup_ft_block(struct dsa_switch *ds, int port,
 {
 	struct net_device *conduit = dsa_port_to_conduit(dsa_to_port(ds, port));
 
-	if (!conduit->netdev_ops->ndo_setup_tc)
-		return -EOPNOTSUPP;
-
-	return conduit->netdev_ops->ndo_setup_tc(conduit, TC_SETUP_FT, type_data);
+	return dev_setup_tc(conduit, TC_SETUP_FT, type_data);
 }
 
 static int dsa_user_setup_tc(struct net_device *dev, enum tc_setup_type type,
diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index e06bc36f49fe..0ec4abded10d 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -1175,7 +1175,7 @@ static int nf_flow_table_offload_cmd(struct flow_block_offload *bo,
 	nf_flow_table_block_offload_init(bo, dev_net(dev), cmd, flowtable,
 					 extack);
 	down_write(&flowtable->flow_block_lock);
-	err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_FT, bo);
+	err = dev_setup_tc(dev, TC_SETUP_FT, bo);
 	up_write(&flowtable->flow_block_lock);
 	if (err < 0)
 		return err;
diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index 64675f1c7f29..b761899c143c 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -390,7 +390,7 @@ static int nft_block_offload_cmd(struct nft_base_chain *chain,
 
 	nft_flow_block_offload_init(&bo, dev_net(dev), cmd, chain, &extack);
 
-	err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_BLOCK, &bo);
+	err = dev_setup_tc(dev, TC_SETUP_BLOCK, &bo);
 	if (err < 0)
 		return err;
 
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 4f648af8cfaa..4024275a5b0e 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -835,7 +835,7 @@ static int tcf_block_offload_cmd(struct tcf_block *block,
 	if (dev->netdev_ops->ndo_setup_tc) {
 		int err;
 
-		err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_BLOCK, &bo);
+		err = dev_setup_tc(dev, TC_SETUP_BLOCK, &bo);
 		if (err < 0) {
 			if (err != -EOPNOTSUPP)
 				NL_SET_ERR_MSG(extack, "Driver ndo_setup_tc failed");
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index e3e91cf867eb..118f0dceccd9 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -836,7 +836,7 @@ int qdisc_offload_dump_helper(struct Qdisc *sch, enum tc_setup_type type,
 	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
 		return 0;
 
-	err = dev->netdev_ops->ndo_setup_tc(dev, type, type_data);
+	err = dev_setup_tc(dev, type, type_data);
 	if (err == -EOPNOTSUPP)
 		return 0;
 
@@ -858,7 +858,7 @@ void qdisc_offload_graft_helper(struct net_device *dev, struct Qdisc *sch,
 	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
 		return;
 
-	err = dev->netdev_ops->ndo_setup_tc(dev, type, type_data);
+	err = dev_setup_tc(dev, type, type_data);
 
 	/* Don't report error if the graft is part of destroy operation. */
 	if (!err || !new || new == &noop_qdisc)
@@ -880,7 +880,6 @@ void qdisc_offload_query_caps(struct net_device *dev,
 			      enum tc_setup_type type,
 			      void *caps, size_t caps_len)
 {
-	const struct net_device_ops *ops = dev->netdev_ops;
 	struct tc_query_caps_base base = {
 		.type = type,
 		.caps = caps,
@@ -888,8 +887,7 @@ void qdisc_offload_query_caps(struct net_device *dev,
 
 	memset(caps, 0, caps_len);
 
-	if (ops->ndo_setup_tc)
-		ops->ndo_setup_tc(dev, TC_QUERY_CAPS, &base);
+	dev_setup_tc(dev, TC_QUERY_CAPS, &base);
 }
 EXPORT_SYMBOL(qdisc_offload_query_caps);
 
diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
index 8c9a0400c862..0c578f3edc32 100644
--- a/net/sched/sch_cbs.c
+++ b/net/sched/sch_cbs.c
@@ -251,7 +251,6 @@ static void cbs_disable_offload(struct net_device *dev,
 				struct cbs_sched_data *q)
 {
 	struct tc_cbs_qopt_offload cbs = { };
-	const struct net_device_ops *ops;
 	int err;
 
 	if (!q->offload)
@@ -260,14 +259,13 @@ static void cbs_disable_offload(struct net_device *dev,
 	q->enqueue = cbs_enqueue_soft;
 	q->dequeue = cbs_dequeue_soft;
 
-	ops = dev->netdev_ops;
-	if (!ops->ndo_setup_tc)
+	if (!dev->netdev_ops->ndo_setup_tc)
 		return;
 
 	cbs.queue = q->queue;
 	cbs.enable = 0;
 
-	err = ops->ndo_setup_tc(dev, TC_SETUP_QDISC_CBS, &cbs);
+	err = dev_setup_tc(dev, TC_SETUP_QDISC_CBS, &cbs);
 	if (err < 0)
 		pr_warn("Couldn't disable CBS offload for queue %d\n",
 			cbs.queue);
@@ -294,7 +292,7 @@ static int cbs_enable_offload(struct net_device *dev, struct cbs_sched_data *q,
 	cbs.idleslope = opt->idleslope;
 	cbs.sendslope = opt->sendslope;
 
-	err = ops->ndo_setup_tc(dev, TC_SETUP_QDISC_CBS, &cbs);
+	err = dev_setup_tc(dev, TC_SETUP_QDISC_CBS, &cbs);
 	if (err < 0) {
 		NL_SET_ERR_MSG(extack, "Specified device failed to setup cbs hardware offload");
 		return err;
diff --git a/net/sched/sch_etf.c b/net/sched/sch_etf.c
index c74d778c32a1..0273ec717f05 100644
--- a/net/sched/sch_etf.c
+++ b/net/sched/sch_etf.c
@@ -297,20 +297,18 @@ static void etf_disable_offload(struct net_device *dev,
 				struct etf_sched_data *q)
 {
 	struct tc_etf_qopt_offload etf = { };
-	const struct net_device_ops *ops;
 	int err;
 
 	if (!q->offload)
 		return;
 
-	ops = dev->netdev_ops;
-	if (!ops->ndo_setup_tc)
+	if (!dev->netdev_ops->ndo_setup_tc)
 		return;
 
 	etf.queue = q->queue;
 	etf.enable = 0;
 
-	err = ops->ndo_setup_tc(dev, TC_SETUP_QDISC_ETF, &etf);
+	err = dev_setup_tc(dev, TC_SETUP_QDISC_ETF, &etf);
 	if (err < 0)
 		pr_warn("Couldn't disable ETF offload for queue %d\n",
 			etf.queue);
@@ -331,7 +329,7 @@ static int etf_enable_offload(struct net_device *dev, struct etf_sched_data *q,
 	etf.queue = q->queue;
 	etf.enable = 1;
 
-	err = ops->ndo_setup_tc(dev, TC_SETUP_QDISC_ETF, &etf);
+	err = dev_setup_tc(dev, TC_SETUP_QDISC_ETF, &etf);
 	if (err < 0) {
 		NL_SET_ERR_MSG(extack, "Specified device failed to setup ETF hardware offload");
 		return err;
diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index 516038a44163..11164127c0ab 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -142,7 +142,7 @@ static void ets_offload_change(struct Qdisc *sch)
 		qopt.replace_params.weights[i] = weight;
 	}
 
-	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_ETS, &qopt);
+	dev_setup_tc(dev, TC_SETUP_QDISC_ETS, &qopt);
 }
 
 static void ets_offload_destroy(struct Qdisc *sch)
@@ -156,7 +156,7 @@ static void ets_offload_destroy(struct Qdisc *sch)
 	qopt.command = TC_ETS_DESTROY;
 	qopt.handle = sch->handle;
 	qopt.parent = sch->parent;
-	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_ETS, &qopt);
+	dev_setup_tc(dev, TC_SETUP_QDISC_ETS, &qopt);
 }
 
 static void ets_offload_graft(struct Qdisc *sch, struct Qdisc *new,
diff --git a/net/sched/sch_fifo.c b/net/sched/sch_fifo.c
index e6bfd39ff339..8a8205a6cff5 100644
--- a/net/sched/sch_fifo.c
+++ b/net/sched/sch_fifo.c
@@ -67,7 +67,7 @@ static void fifo_offload_init(struct Qdisc *sch)
 	qopt.command = TC_FIFO_REPLACE;
 	qopt.handle = sch->handle;
 	qopt.parent = sch->parent;
-	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_FIFO, &qopt);
+	dev_setup_tc(dev, TC_SETUP_QDISC_FIFO, &qopt);
 }
 
 static void fifo_offload_destroy(struct Qdisc *sch)
@@ -81,7 +81,7 @@ static void fifo_offload_destroy(struct Qdisc *sch)
 	qopt.command = TC_FIFO_DESTROY;
 	qopt.handle = sch->handle;
 	qopt.parent = sch->parent;
-	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_FIFO, &qopt);
+	dev_setup_tc(dev, TC_SETUP_QDISC_FIFO, &qopt);
 }
 
 static int fifo_offload_dump(struct Qdisc *sch)
diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
index ab6234b4fcd5..6c546d618f22 100644
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -348,7 +348,7 @@ static void gred_offload(struct Qdisc *sch, enum tc_gred_command command)
 		opt->set.qstats = &sch->qstats;
 	}
 
-	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_GRED, opt);
+	dev_setup_tc(dev, TC_SETUP_QDISC_GRED, opt);
 }
 
 static int gred_offload_dump_stats(struct Qdisc *sch)
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index c31bc5489bdd..ed406b3ceb7b 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -1041,7 +1041,7 @@ static void htb_work_func(struct work_struct *work)
 
 static int htb_offload(struct net_device *dev, struct tc_htb_qopt_offload *opt)
 {
-	return dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_HTB, opt);
+	return dev_setup_tc(dev, TC_SETUP_QDISC_HTB, opt);
 }
 
 static int htb_init(struct Qdisc *sch, struct nlattr *opt,
diff --git a/net/sched/sch_mq.c b/net/sched/sch_mq.c
index c860119a8f09..9be82a112ac9 100644
--- a/net/sched/sch_mq.c
+++ b/net/sched/sch_mq.c
@@ -32,7 +32,7 @@ static int mq_offload(struct Qdisc *sch, enum tc_mq_command cmd)
 	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
 		return -EOPNOTSUPP;
 
-	return dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_MQ, &opt);
+	return dev_setup_tc(dev, TC_SETUP_QDISC_MQ, &opt);
 }
 
 static int mq_offload_stats(struct Qdisc *sch)
diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index 51d4013b6121..2c9a90b83c2b 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -67,8 +67,7 @@ static int mqprio_enable_offload(struct Qdisc *sch,
 
 	mqprio_fp_to_offload(priv->fp, &mqprio);
 
-	err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_MQPRIO,
-					    &mqprio);
+	err = dev_setup_tc(dev, TC_SETUP_QDISC_MQPRIO, &mqprio);
 	if (err)
 		return err;
 
@@ -86,8 +85,7 @@ static void mqprio_disable_offload(struct Qdisc *sch)
 	switch (priv->mode) {
 	case TC_MQPRIO_MODE_DCB:
 	case TC_MQPRIO_MODE_CHANNEL:
-		dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_MQPRIO,
-					      &mqprio);
+		dev_setup_tc(dev, TC_SETUP_QDISC_MQPRIO, &mqprio);
 		break;
 	}
 }
diff --git a/net/sched/sch_prio.c b/net/sched/sch_prio.c
index cc30f7a32f1a..6d95ae61f9c9 100644
--- a/net/sched/sch_prio.c
+++ b/net/sched/sch_prio.c
@@ -158,7 +158,7 @@ static int prio_offload(struct Qdisc *sch, struct tc_prio_qopt *qopt)
 		opt.command = TC_PRIO_DESTROY;
 	}
 
-	return dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_PRIO, &opt);
+	return dev_setup_tc(dev, TC_SETUP_QDISC_PRIO, &opt);
 }
 
 static void
diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index ef8a2afed26b..50dafd0b58f2 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -209,7 +209,7 @@ static int red_offload(struct Qdisc *sch, bool enable)
 		opt.command = TC_RED_DESTROY;
 	}
 
-	return dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_RED, &opt);
+	return dev_setup_tc(dev, TC_SETUP_QDISC_RED, &opt);
 }
 
 static void red_destroy(struct Qdisc *sch)
@@ -460,8 +460,7 @@ static int red_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 				.xstats = &q->stats,
 			},
 		};
-		dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_RED,
-					      &hw_stats_request);
+		dev_setup_tc(dev, TC_SETUP_QDISC_RED, &hw_stats_request);
 	}
 	st.early = q->stats.prob_drop + q->stats.forced_drop;
 	st.pdrop = q->stats.pdrop;
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index a68e17891b0b..10548bb78da1 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1539,7 +1539,7 @@ static int taprio_enable_offload(struct net_device *dev,
 	for (tc = 0; tc < TC_MAX_QUEUE; tc++)
 		offload->max_sdu[tc] = q->max_sdu[tc];
 
-	err = ops->ndo_setup_tc(dev, TC_SETUP_QDISC_TAPRIO, offload);
+	err = dev_setup_tc(dev, TC_SETUP_QDISC_TAPRIO, offload);
 	if (err < 0) {
 		NL_SET_ERR_MSG_WEAK(extack,
 				    "Device failed to setup taprio offload");
@@ -1564,7 +1564,6 @@ static int taprio_disable_offload(struct net_device *dev,
 				  struct taprio_sched *q,
 				  struct netlink_ext_ack *extack)
 {
-	const struct net_device_ops *ops = dev->netdev_ops;
 	struct tc_taprio_qopt_offload *offload;
 	int err;
 
@@ -1579,7 +1578,7 @@ static int taprio_disable_offload(struct net_device *dev,
 	}
 	offload->cmd = TAPRIO_CMD_DESTROY;
 
-	err = ops->ndo_setup_tc(dev, TC_SETUP_QDISC_TAPRIO, offload);
+	err = dev_setup_tc(dev, TC_SETUP_QDISC_TAPRIO, offload);
 	if (err < 0) {
 		NL_SET_ERR_MSG(extack,
 			       "Device failed to disable offload");
@@ -2314,24 +2313,21 @@ static int taprio_dump_xstats(struct Qdisc *sch, struct gnet_dump *d,
 			      struct tc_taprio_qopt_stats *stats)
 {
 	struct net_device *dev = qdisc_dev(sch);
-	const struct net_device_ops *ops;
 	struct sk_buff *skb = d->skb;
 	struct nlattr *xstats;
 	int err;
 
-	ops = qdisc_dev(sch)->netdev_ops;
-
 	/* FIXME I could use qdisc_offload_dump_helper(), but that messes
 	 * with sch->flags depending on whether the device reports taprio
 	 * stats, and I'm not sure whether that's a good idea, considering
 	 * that stats are optional to the offload itself
 	 */
-	if (!ops->ndo_setup_tc)
+	if (!dev->netdev_ops->ndo_setup_tc)
 		return 0;
 
 	memset(stats, 0xff, sizeof(*stats));
 
-	err = ops->ndo_setup_tc(dev, TC_SETUP_QDISC_TAPRIO, offload);
+	err = dev_setup_tc(dev, TC_SETUP_QDISC_TAPRIO, offload);
 	if (err == -EOPNOTSUPP)
 		return 0;
 	if (err)
diff --git a/net/sched/sch_tbf.c b/net/sched/sch_tbf.c
index dc26b22d53c7..03090b074d0c 100644
--- a/net/sched/sch_tbf.c
+++ b/net/sched/sch_tbf.c
@@ -155,7 +155,7 @@ static void tbf_offload_change(struct Qdisc *sch)
 	qopt.replace_params.max_size = q->max_size;
 	qopt.replace_params.qstats = &sch->qstats;
 
-	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_TBF, &qopt);
+	dev_setup_tc(dev, TC_SETUP_QDISC_TBF, &qopt);
 }
 
 static void tbf_offload_destroy(struct Qdisc *sch)
@@ -169,7 +169,7 @@ static void tbf_offload_destroy(struct Qdisc *sch)
 	qopt.command = TC_TBF_DESTROY;
 	qopt.handle = sch->handle;
 	qopt.parent = sch->parent;
-	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_TBF, &qopt);
+	dev_setup_tc(dev, TC_SETUP_QDISC_TBF, &qopt);
 }
 
 static int tbf_offload_dump(struct Qdisc *sch)
-- 
2.48.1


