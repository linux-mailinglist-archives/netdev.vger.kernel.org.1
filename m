Return-Path: <netdev+bounces-298754-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JptlHPhDLGphOgQAu9opvQ
	(envelope-from <netdev+bounces-298754-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:38:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 715AE67B658
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:37:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=QEoFY+KF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298754-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298754-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52F5E3014A31
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 17:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F29408012;
	Fri, 12 Jun 2026 17:36:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0432740628A
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 17:36:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781285815; cv=none; b=dFCyMXWXWQf3zOM0nMg8JVnG9nEl8Fxd2DLN1tu/2/oCfSSVRIhUPcmZarhQjOdtUp92qx/PAiQp59lZhIJ13DP+BXZYq1SzL/i4dBESglzJhby7bp2f347RH2u5/zoqOxikFW63xkzMqkd07R4dZlUT1778Kj/7aUg9OU54/vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781285815; c=relaxed/simple;
	bh=rXFphTeY1MLItaanBUlJajUJ/NbTofJP7DBOOoHQ0Dg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U3gtmeIjk0sTqTLSs0aWpChlpFkivwAZSwXt4wE7jOPWQzXWAbF6h4+DQdDrVh5x2Ff1F439DBNOWUuV5JYgQ8DX3MKAgmJ6uPlsN2kvYduch2BnIPVnEctEMqTA6OB9umYWjTMlKFaiCBPL5RjEDo7q+7WII1QDUuTv8X3lNYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tanshuhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QEoFY+KF; arc=none smtp.client-ip=74.125.82.201
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304f1820babso1973904eec.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 10:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781285812; x=1781890612; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aqAF30KpKdcq5sTUeKbILHPk2Mfwqo1yQa24lqVRy9g=;
        b=QEoFY+KFzB2uF669GiiTSRAbq5MOVjJfHjqkM5Y/I8FA1+dskQoS8zK0JpXRISWOqN
         uqTRpTd4vWida1VokxrrLO3bM4F1n4Mj09jKt8y1oyxJB3zTD6DBhqtv2pu58AuFv2ZI
         8tJYo0TcEyq4fjgtKpcxxxSUseUVw932w7vhst4h/NrALzjo3Dz9xJlSW/INctBDCXXw
         W6EJHt2/9lEY6BxET9YPuWZ0dCPEKQ1aR2mEs4qN0HcxyI9KfdRolVFchHA1dyYDx7YT
         oojXqZwJ/u8erT7gzY2BRrWM10VCPAyQpJFRW4keACuvh0zEYCVZjgnQbKe1z2ETcZyN
         WAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781285812; x=1781890612;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqAF30KpKdcq5sTUeKbILHPk2Mfwqo1yQa24lqVRy9g=;
        b=YNHJCgTd3DYqiFZe1kO69fIw1Q5qzF0TDVZ4/2DYNFENOkoZIrp2+JV8KJWCQxuZcn
         jg/uiVd9+pL5lLx79wCqDDv7SxWEzmPBUwBeVIrfZ+JIv3d4GMcF1NXpnlhTnAM57pyQ
         q8kWzn9wxlkanm3TwR+DnL2PVM545Kv6C1nIBE9k8NQNgE44PlCKqmYiIYX8nEUROdRH
         De/KmVmv2oG1I5n0gHEMM8e1lF2WWswjF2+61uXYSzShQ4XDnSGXJ5TCHpeOAFx18bds
         ApXAFwNxWd9hBXjjRq2ZbCM3/tJKNiw5FsXNvIv6kiLTkqmawp6r2qv/nJAt6PVVaf21
         kd+w==
X-Forwarded-Encrypted: i=1; AFNElJ9rMoHafIFl70uEhwROfGTy3zLO4flCOShQU9ObCUUhmpFoAEdMXkwhrCsPFL9Nna9KhyhOQqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRuTtUOBEdlBjxaxHWfRHVWCLmp7EyQT7cCR+UyB2fW2C1WfcG
	BzuwO5DB5HUhSLzdz6xTsvkfPIvfFqI0Q93uxQI4tUZW7LdvmT8rHo2Z+CV8L2wD+CCg74SCVyR
	kaR1Q+rLd6Sp9KSTRXQ==
X-Received: from dybpi5.prod.google.com ([2002:a05:7301:4205:b0:304:ebf6:da3b])
 (user=tanshuhao job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:6407:b0:2d9:f0b3:1d98 with SMTP id 5a478bee46e88-3081ff3ddc7mr2658629eec.7.1781285811647;
 Fri, 12 Jun 2026 10:36:51 -0700 (PDT)
Date: Fri, 12 Jun 2026 10:36:41 -0700
In-Reply-To: <20260612173644.380972-1-tanshuhao@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612173644.380972-1-tanshuhao@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612173644.380972-2-tanshuhao@google.com>
Subject: [RFC net-next v1 1/2] net: Save kthread of threaded NAPI in
 napi_config in napi_del and restore in napi_add
From: Shuhao Tan <tanshuhao@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Shuhao Tan <tanshuhao@google.com>, Mina Almasry <almasrymina@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:tanshuhao@google.com,m:almasrymina@google.com,m:skhawaja@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[tanshuhao@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298754-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tanshuhao@google.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 715AE67B658

Replace napi->thread with a new thread_node struct that has a back
pointer to napi_struct.

Make the NAPI thread to use the thread_node as data pointer so that
it can poll on different NAPIs thoughout its lifetime.

Park the thread and save the thread_node in napi_config on napi_del.
Restore the node and unpark the thread on napi_add_config.

Signed-off-by: Shuhao Tan <tanshuhao@google.com>
---
 include/linux/netdevice.h |  13 +++-
 net/core/dev.c            | 151 +++++++++++++++++++++++++++++---------
 net/core/netdev-genl.c    |  12 ++-
 3 files changed, 139 insertions(+), 37 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7f4f0837c09f..1cda88607e99 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -63,6 +63,7 @@ struct dsa_port;
 struct ip_tunnel_parm_kern;
 struct macsec_context;
 struct macsec_ops;
+struct napi_struct;
 struct netdev_config;
 struct netdev_name_node;
 struct sd_flow_limit;
@@ -363,10 +364,20 @@ struct gro_node {
 	u32			cached_napi_id;
 };
 
+/*
+ * Structure for persisting threaded NAPI kthread
+ */
+struct napi_thread_node {
+	struct task_struct *thread;
+	struct napi_struct *napi;
+	struct rcu_head rcu;
+};
+
 /*
  * Structure for per-NAPI config
  */
 struct napi_config {
+	struct napi_thread_node *thread_node;
 	u64 gro_flush_timeout;
 	u64 irq_suspend_timeout;
 	u32 defer_hard_irqs;
@@ -403,7 +414,7 @@ struct napi_struct {
 	struct gro_node		gro;
 	struct hrtimer		timer;
 	/* all fields past this point are write-protected by netdev_lock */
-	struct task_struct	*thread;
+	struct napi_thread_node __rcu *thread_node;
 	unsigned long		gro_flush_timeout;
 	unsigned long		irq_suspend_timeout;
 	u32			defer_hard_irqs;
diff --git a/net/core/dev.c b/net/core/dev.c
index 202e35acb15b..f5e3b9e526af 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1645,25 +1645,62 @@ EXPORT_SYMBOL(netdev_notify_peers);
 
 static int napi_threaded_poll(void *data);
 
-static int napi_kthread_create(struct napi_struct *n)
+static int napi_thread_node_create(struct napi_struct *n)
 {
+	struct napi_thread_node *thread_node = NULL;
+	struct task_struct *thread = NULL;
 	int err = 0;
 
+	thread_node = kvzalloc_obj(*thread_node);
+	if (!thread_node)
+		return -ENOMEM;
+
 	/* Create and wake up the kthread once to put it in
 	 * TASK_INTERRUPTIBLE mode to avoid the blocked task
 	 * warning and work with loadavg.
 	 */
-	n->thread = kthread_run(napi_threaded_poll, n, "napi/%s-%d",
-				n->dev->name, n->napi_id);
-	if (IS_ERR(n->thread)) {
-		err = PTR_ERR(n->thread);
+	thread_node->napi = n;
+	thread = kthread_run(napi_threaded_poll, thread_node, "napi/%s-%d",
+			     n->dev->name, n->napi_id);
+	if (IS_ERR(thread)) {
+		err = PTR_ERR(thread);
 		pr_err("kthread_run failed with err %d\n", err);
-		n->thread = NULL;
+		goto free_thread_node;
 	}
 
+	thread_node->thread = thread;
+	rcu_assign_pointer(n->thread_node, thread_node);
+
+	return 0;
+
+free_thread_node:
+	kvfree(thread_node);
+
 	return err;
 }
 
+static void napi_thread_node_stop(struct napi_thread_node *thread_node)
+{
+	kthread_stop(thread_node->thread);
+	kvfree_rcu(thread_node, rcu);
+}
+
+static int napi_kthread_create(struct napi_struct *n)
+{
+	struct napi_thread_node *thread_node;
+
+	if (n->config && n->config->thread_node) {
+		thread_node = n->config->thread_node;
+		rcu_assign_pointer(n->thread_node, thread_node);
+		n->config->thread_node = NULL;
+		WRITE_ONCE(thread_node->napi, n);
+		kthread_unpark(thread_node->thread);
+		return 0;
+	}
+
+	return napi_thread_node_create(n);
+}
+
 static int __dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
@@ -4949,7 +4986,7 @@ EXPORT_SYMBOL(__dev_direct_xmit);
 /*************************************************************************
  *			Receiver routines
  *************************************************************************/
-static DEFINE_PER_CPU(struct task_struct *, backlog_napi);
+static DEFINE_PER_CPU(struct napi_thread_node, backlog_napi);
 
 int weight_p __read_mostly = 64;           /* old backlog weight */
 int dev_weight_rx_bias __read_mostly = 1;  /* bias for backlog weight */
@@ -4959,10 +4996,11 @@ int dev_weight_tx_bias __read_mostly = 1;  /* bias for output_queue quota */
 static inline void ____napi_schedule(struct softnet_data *sd,
 				     struct napi_struct *napi)
 {
-	struct task_struct *thread;
+	struct napi_thread_node *thread_node;
 
 	lockdep_assert_irqs_disabled();
 
+	rcu_read_lock();
 	if (test_bit(NAPI_STATE_THREADED, &napi->state)) {
 		/* Paired with smp_mb__before_atomic() in
 		 * napi_enable()/netif_set_threaded().
@@ -4970,18 +5008,21 @@ static inline void ____napi_schedule(struct softnet_data *sd,
 		 * read on napi->thread. Only call
 		 * wake_up_process() when it's not NULL.
 		 */
-		thread = READ_ONCE(napi->thread);
-		if (thread) {
-			if (use_backlog_threads() && thread == raw_cpu_read(backlog_napi))
+		thread_node = rcu_dereference(napi->thread_node);
+		if (thread_node) {
+			if (use_backlog_threads() &&
+			    thread_node == this_cpu_ptr(&backlog_napi))
 				goto use_local_napi;
 
 			set_bit(NAPI_STATE_SCHED_THREADED, &napi->state);
-			wake_up_process(thread);
+			wake_up_process(thread_node->thread);
+			rcu_read_unlock();
 			return;
 		}
 	}
 
 use_local_napi:
+	rcu_read_unlock();
 	DEBUG_NET_WARN_ON_ONCE(!list_empty(&napi->poll_list));
 	list_add_tail(&napi->poll_list, &sd->poll_list);
 	WRITE_ONCE(napi->list_owner, smp_processor_id());
@@ -7148,6 +7189,7 @@ static enum hrtimer_restart napi_watchdog(struct hrtimer *timer)
 
 static void napi_stop_kthread(struct napi_struct *napi)
 {
+	struct napi_thread_node *thread_node;
 	unsigned long val, new;
 
 	/* Wait until the napi STATE_THREADED is unset. */
@@ -7180,8 +7222,9 @@ static void napi_stop_kthread(struct napi_struct *napi)
 		msleep(20);
 	}
 
-	kthread_stop(napi->thread);
-	napi->thread = NULL;
+	thread_node = netdev_lock_dereference(napi->thread_node, napi->dev);
+	rcu_assign_pointer(napi->thread_node, NULL);
+	napi_thread_node_stop(thread_node);
 }
 
 static void napi_set_threaded_state(struct napi_struct *napi,
@@ -7197,9 +7240,13 @@ static void napi_set_threaded_state(struct napi_struct *napi,
 int napi_set_threaded(struct napi_struct *napi,
 		      enum netdev_napi_threaded threaded)
 {
+	struct napi_thread_node *thread_node;
+
+	thread_node = netdev_lock_dereference(napi->thread_node, napi->dev);
+
 	if (threaded) {
-		if (!napi->thread) {
-			int err = napi_kthread_create(napi);
+		if (!thread_node) {
+			int err = napi_thread_node_create(napi);
 
 			if (err)
 				return err;
@@ -7215,7 +7262,7 @@ int napi_set_threaded(struct napi_struct *napi,
 	 * softirq mode will happen in the next round of napi_schedule().
 	 * This should not cause hiccups/stalls to the live traffic.
 	 */
-	if (!threaded && napi->thread) {
+	if (!threaded && thread_node) {
 		napi_stop_kthread(napi);
 	} else {
 		/* Make sure kthread is created before THREADED bit is set. */
@@ -7236,8 +7283,9 @@ int netif_set_threaded(struct net_device *dev,
 
 	if (threaded) {
 		list_for_each_entry(napi, &dev->napi_list, dev_list) {
-			if (!napi->thread) {
-				err = napi_kthread_create(napi);
+			/* protected by assertion above */
+			if (!rcu_dereference_protected(napi->thread_node, 1)) {
+				err = napi_thread_node_create(napi);
 				if (err) {
 					threaded = NETDEV_NAPI_THREADED_DISABLED;
 					break;
@@ -7253,8 +7301,14 @@ int netif_set_threaded(struct net_device *dev,
 		WARN_ON_ONCE(napi_set_threaded(napi, threaded));
 
 	/* Override the config for all NAPIs even if currently not listed */
-	for (i = 0; i < dev->num_napi_configs; i++)
+	for (i = 0; i < dev->num_napi_configs; i++) {
 		dev->napi_config[i].threaded = threaded;
+		/* Stop parked threads in inactive napi_configs */
+		if (!threaded && dev->napi_config[i].thread_node) {
+			napi_thread_node_stop(dev->napi_config[i].thread_node);
+			dev->napi_config[i].thread_node = NULL;
+		}
+	}
 
 	return err;
 }
@@ -7657,7 +7711,7 @@ void napi_enable_locked(struct napi_struct *n)
 		BUG_ON(!test_bit(NAPI_STATE_SCHED, &val));
 
 		new = val & ~(NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC);
-		if (n->dev->threaded && n->thread)
+		if (n->dev->threaded && n->thread_node)
 			new |= NAPIF_STATE_THREADED;
 	} while (!try_cmpxchg(&n->state, &val, new));
 }
@@ -7682,6 +7736,8 @@ EXPORT_SYMBOL(napi_enable);
 /* Must be called in process context */
 void __netif_napi_del_locked(struct napi_struct *napi)
 {
+	struct napi_thread_node *thread_node;
+
 	netdev_assert_locked(napi->dev);
 
 	if (!test_and_clear_bit(NAPI_STATE_LISTED, &napi->state))
@@ -7693,6 +7749,18 @@ void __netif_napi_del_locked(struct napi_struct *napi)
 	if (test_and_clear_bit(NAPI_STATE_HAS_NOTIFIER, &napi->state))
 		irq_set_affinity_notifier(napi->irq, NULL);
 
+	thread_node = netdev_lock_dereference(napi->thread_node, napi->dev);
+	if (thread_node) {
+		rcu_assign_pointer(napi->thread_node, NULL);
+		if (napi->config) {
+			kthread_park(thread_node->thread);
+			napi->config->thread_node = thread_node;
+			napi->config->thread_node->napi = NULL;
+		} else {
+			napi_thread_node_stop(thread_node);
+		}
+	}
+
 	if (napi->config) {
 		napi->index = -1;
 		napi->config = NULL;
@@ -7702,11 +7770,6 @@ void __netif_napi_del_locked(struct napi_struct *napi)
 	napi_free_frags(napi);
 
 	gro_cleanup(&napi->gro);
-
-	if (napi->thread) {
-		kthread_stop(napi->thread);
-		napi->thread = NULL;
-	}
 }
 EXPORT_SYMBOL(__netif_napi_del_locked);
 
@@ -7802,11 +7865,21 @@ static int napi_poll(struct napi_struct *n, struct list_head *repoll)
 	return work;
 }
 
-static int napi_thread_wait(struct napi_struct *napi)
+static struct napi_struct *
+napi_thread_wait(struct napi_thread_node *thread_node)
 {
+	struct napi_struct *napi = READ_ONCE(thread_node->napi);
+
 	set_current_state(TASK_INTERRUPTIBLE);
 
 	while (!kthread_should_stop()) {
+		if (kthread_should_park()) {
+			kthread_parkme();
+			napi = READ_ONCE(thread_node->napi);
+			/* Might be awakened for stopping */
+			continue;
+		}
+
 		/* Testing SCHED_THREADED bit here to make sure the current
 		 * kthread owns this napi and could poll on this napi.
 		 * Testing SCHED bit is not enough because SCHED bit might be
@@ -7815,7 +7888,7 @@ static int napi_thread_wait(struct napi_struct *napi)
 		if (test_bit(NAPI_STATE_SCHED_THREADED, &napi->state)) {
 			WARN_ON(!list_empty(&napi->poll_list));
 			__set_current_state(TASK_RUNNING);
-			return 0;
+			return napi;
 		}
 
 		schedule();
@@ -7823,7 +7896,7 @@ static int napi_thread_wait(struct napi_struct *napi)
 	}
 	__set_current_state(TASK_RUNNING);
 
-	return -1;
+	return NULL;
 }
 
 static void napi_threaded_poll_loop(struct napi_struct *napi,
@@ -7880,13 +7953,19 @@ static void napi_threaded_poll_loop(struct napi_struct *napi,
 
 static int napi_threaded_poll(void *data)
 {
-	struct napi_struct *napi = data;
+	struct napi_thread_node *thread_node = data;
 	unsigned long last_qs = jiffies;
+	struct napi_struct *napi;
 	bool want_busy_poll;
 	bool in_busy_poll;
 	unsigned long val;
 
-	while (!napi_thread_wait(napi)) {
+	while (1) {
+		napi = napi_thread_wait(thread_node);
+
+		if (!napi)
+			break;
+
 		val = READ_ONCE(napi->state);
 
 		want_busy_poll = val & NAPIF_STATE_THREADED_BUSY_POLL;
@@ -12155,6 +12234,8 @@ EXPORT_SYMBOL(alloc_netdev_mqs);
 
 static void netdev_napi_exit(struct net_device *dev)
 {
+	unsigned int i;
+
 	if (!list_empty(&dev->napi_list)) {
 		struct napi_struct *p, *n;
 
@@ -12166,6 +12247,10 @@ static void netdev_napi_exit(struct net_device *dev)
 		synchronize_net();
 	}
 
+	for (i = 0; i < dev->num_napi_configs; i++) {
+		if (dev->napi_config[i].thread_node)
+			napi_thread_node_stop(dev->napi_config[i].thread_node);
+	}
 	kvfree(dev->napi_config);
 }
 
@@ -13204,12 +13289,12 @@ static void backlog_napi_setup(unsigned int cpu)
 	struct softnet_data *sd = per_cpu_ptr(&softnet_data, cpu);
 	struct napi_struct *napi = &sd->backlog;
 
-	napi->thread = this_cpu_read(backlog_napi);
+	rcu_assign_pointer(napi->thread_node, this_cpu_ptr(&backlog_napi));
 	set_bit(NAPI_STATE_THREADED, &napi->state);
 }
 
 static struct smp_hotplug_thread backlog_threads = {
-	.store			= &backlog_napi,
+	.store			= &backlog_napi.thread,
 	.thread_should_run	= backlog_napi_should_run,
 	.thread_fn		= run_backlog_napi,
 	.thread_comm		= "backlog_napi/%u",
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 11b0b91683d7..f2ecdb26d6f1 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -162,6 +162,7 @@ static int
 netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 			const struct genl_info *info)
 {
+	struct napi_thread_node *thread_node;
 	unsigned long irq_suspend_timeout;
 	unsigned long gro_flush_timeout;
 	u32 napi_defer_hard_irqs;
@@ -188,11 +189,16 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 			 napi_get_threaded(napi)))
 		goto nla_put_failure;
 
-	if (napi->thread) {
-		pid = task_pid_nr(napi->thread);
-		if (nla_put_u32(rsp, NETDEV_A_NAPI_PID, pid))
+	rcu_read_lock();
+	thread_node = rcu_dereference(napi->thread_node);
+	if (thread_node) {
+		pid = task_pid_nr(thread_node->thread);
+		if (nla_put_u32(rsp, NETDEV_A_NAPI_PID, pid)) {
+			rcu_read_unlock();
 			goto nla_put_failure;
+		}
 	}
+	rcu_read_unlock();
 
 	napi_defer_hard_irqs = napi_get_defer_hard_irqs(napi);
 	if (nla_put_s32(rsp, NETDEV_A_NAPI_DEFER_HARD_IRQS,
-- 
2.54.0.1136.gdb2ca164c4-goog


