Return-Path: <netdev+bounces-155109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D62ECA01159
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 01:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC06164B27
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 00:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D58481B1;
	Sat,  4 Jan 2025 00:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TEPstCbx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E383B42AAB
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 00:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735951427; cv=none; b=LHQqVNhRC90PLubWuj+0ysHO9LrWH6Wu6gP6cvv31XJyYeFu30WMFQDyB1fSedYv/r7QDhqizDLSiQYsmVLmdC/qCxwpsaJNjJcrxs/iulsph7vomb+GEIEbNz8hUFBDnNDF7kv9k5I9cS6HQ78vUsj0sY1gDR/USzLGHTAtaiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735951427; c=relaxed/simple;
	bh=/FN1qWtmI3LzLuF0G5JPbiYRKNZYDTNyeAQsh08UPvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgZtFE3NIveQiyhkH2qQZl6bnNDtZ1Z/FysDdCbGiYiMIUne/4XX0Q8BQ6u08mjcfJdUQraimTxZNYdd8Beh/uVY8G2sqJiJfgnaoo9/fhrd8vQ1HJG3MacFVSwqGmZWY8SC2WCTWPVGYSLwwgW0CAsa/zliK+Rn0XjrQeYjgBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TEPstCbx; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735951425; x=1767487425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/FN1qWtmI3LzLuF0G5JPbiYRKNZYDTNyeAQsh08UPvk=;
  b=TEPstCbxpmPRCi8frga6sLxctHJrkQKkrGkFtR+UR3ru5FxatuEmB3t5
   MXDzEuI+gkKqK46xH0h2Jh2mOKxLaL5lZ7dNnk1KxHNYas5WXIF5h3Fx1
   lZu4XefKjeaFDyck+4i3LXBs3KWKjBeNEKNZDOgkKjPYE7KgUZXAdeTDJ
   XZmYa8bL1pO9a6+6GVvPT5OE15gDywV9iAC4hbMNwVgucNgEUI2jKeHM7
   nhVJN4v5saJlYrDFLNNwo8+hrWLCMpDb0Kmf2sPQqsm+VPm4BJtbAKbit
   YMSpWF4CVY6Sh1lIf4xO/c+g6CW7uBUQqlqC8o6tFSKfDBDw4jS1kJltV
   Q==;
X-CSE-ConnectionGUID: Gz182lTyTT++rz31QoowmQ==
X-CSE-MsgGUID: 3AVbV9drSLy15Adno72mgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11304"; a="36075968"
X-IronPort-AV: E=Sophos;i="6.12,287,1728975600"; 
   d="scan'208";a="36075968"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 16:43:45 -0800
X-CSE-ConnectionGUID: MJJrnwg7Qw66uai3TxtGyA==
X-CSE-MsgGUID: s46I0+DKQbOttXqpuTZMQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,287,1728975600"; 
   d="scan'208";a="106879728"
Received: from spandruv-desk1.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.110.48])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 16:43:40 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	michael.chan@broadcom.com,
	tariqt@nvidia.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jdamato@fastly.com,
	shayd@nvidia.com,
	akpm@linux-foundation.org,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next v3 3/6] net: napi: add CPU affinity to napi_config
Date: Fri,  3 Jan 2025 17:43:11 -0700
Message-ID: <20250104004314.208259-4-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250104004314.208259-1-ahmed.zaki@intel.com>
References: <20250104004314.208259-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A common task for most drivers is to remember the user-set CPU affinity
to its IRQs. On each netdev reset, the driver should re-assign the
user's settings to the IRQs.

Add CPU affinity mask to napi_config. To delegate the CPU affinity
management to the core, drivers must:
 1 - set the new netdev flag "irq_affinity_auto":
                                       netif_enable_irq_affinity(netdev)
 2 - create the napi with persistent config:
                                       netif_napi_add_config()
 3 - bind an IRQ to the napi instance: netif_napi_set_irq()

the core will then make sure to use re-assign affinity to the napi's
IRQ.

The default IRQ mask is set to one cpu starting from the closest NUMA.

Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 include/linux/netdevice.h |  9 +++++++-
 net/core/dev.c            | 44 ++++++++++++++++++++++++++++++++-------
 2 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b0769f0a3795..37d3f954ccf6 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -351,6 +351,7 @@ struct napi_config {
 	u64 gro_flush_timeout;
 	u64 irq_suspend_timeout;
 	u32 defer_hard_irqs;
+	cpumask_t affinity_mask;
 	unsigned int napi_id;
 };
 
@@ -392,8 +393,8 @@ struct napi_struct {
 	struct list_head	dev_list;
 	struct hlist_node	napi_hash_node;
 	int			irq;
-#ifdef CONFIG_RFS_ACCEL
 	struct irq_affinity_notify notify;
+#ifdef CONFIG_RFS_ACCEL
 	int			napi_rmap_idx;
 #endif
 	int			index;
@@ -2402,6 +2403,7 @@ struct net_device {
 	struct lock_class_key	*qdisc_tx_busylock;
 	bool			proto_down;
 	bool			threaded;
+	bool			irq_affinity_auto;
 #ifdef CONFIG_RFS_ACCEL
 	bool			rx_cpu_rmap_auto;
 #endif
@@ -2637,6 +2639,11 @@ static inline void netdev_set_ml_priv(struct net_device *dev,
 	dev->ml_priv_type = type;
 }
 
+static inline void netif_enable_irq_affinity(struct net_device *dev)
+{
+	dev->irq_affinity_auto = true;
+}
+
 /*
  * Net namespace inlines
  */
diff --git a/net/core/dev.c b/net/core/dev.c
index 92b7a9d4c9b6..86274d974ef4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6736,22 +6736,30 @@ int netif_enable_cpu_rmap(struct net_device *dev, unsigned int num_irqs)
 	return 0;
 }
 EXPORT_SYMBOL(netif_enable_cpu_rmap);
+#endif
 
 static void
-netif_irq_cpu_rmap_notify(struct irq_affinity_notify *notify,
-			  const cpumask_t *mask)
+netif_napi_irq_notify(struct irq_affinity_notify *notify,
+		      const cpumask_t *mask)
 {
 	struct napi_struct *napi =
 		container_of(notify, struct napi_struct, notify);
+#ifdef CONFIG_RFS_ACCEL
 	struct cpu_rmap *rmap = napi->dev->rx_cpu_rmap;
 	int err;
+#endif
 
+	if (napi->config && napi->dev->irq_affinity_auto)
+		cpumask_copy(&napi->config->affinity_mask, mask);
+
+#ifdef CONFIG_RFS_ACCEL
 	if (rmap && napi->dev->rx_cpu_rmap_auto) {
 		err = cpu_rmap_update(rmap, napi->napi_rmap_idx, mask);
 		if (err)
 			pr_warn("%s: RMAP update failed (%d)\n",
 				__func__, err);
 	}
+#endif
 }
 
 static void
@@ -6759,6 +6767,7 @@ netif_napi_affinity_release(struct kref __always_unused *ref)
 {
 }
 
+#ifdef CONFIG_RFS_ACCEL
 static int napi_irq_cpu_rmap_add(struct napi_struct *napi, int irq)
 {
 	struct cpu_rmap *rmap = napi->dev->rx_cpu_rmap;
@@ -6766,7 +6775,7 @@ static int napi_irq_cpu_rmap_add(struct napi_struct *napi, int irq)
 
 	if (!napi || !rmap)
 		return -EINVAL;
-	napi->notify.notify = netif_irq_cpu_rmap_notify;
+	napi->notify.notify = netif_napi_irq_notify;
 	napi->notify.release = netif_napi_affinity_release;
 	cpu_rmap_get(rmap);
 	rc = cpu_rmap_add(rmap, napi);
@@ -6790,9 +6799,8 @@ static int napi_irq_cpu_rmap_add(struct napi_struct *napi, int irq)
 
 void netif_napi_set_irq(struct napi_struct *napi, int irq)
 {
-#ifdef CONFIG_RFS_ACCEL
 	int rc;
-#endif
+
 	napi->irq = irq;
 
 #ifdef CONFIG_RFS_ACCEL
@@ -6803,8 +6811,18 @@ void netif_napi_set_irq(struct napi_struct *napi, int irq)
 				    rc);
 			netif_disable_cpu_rmap(napi->dev);
 		}
-	}
+	} else if (irq > 0 && napi->config && napi->dev->irq_affinity_auto) {
+#else
+	if (irq > 0 && napi->config && napi->dev->irq_affinity_auto) {
 #endif
+		napi->notify.notify = netif_napi_irq_notify;
+		napi->notify.release = netif_napi_affinity_release;
+
+		rc = irq_set_affinity_notifier(irq, &napi->notify);
+		if (rc)
+			netdev_warn(napi->dev, "Unable to set IRQ notifier (%d)\n",
+				    rc);
+	}
 }
 EXPORT_SYMBOL(netif_napi_set_irq);
 
@@ -6813,6 +6831,10 @@ static void napi_restore_config(struct napi_struct *n)
 	n->defer_hard_irqs = n->config->defer_hard_irqs;
 	n->gro_flush_timeout = n->config->gro_flush_timeout;
 	n->irq_suspend_timeout = n->config->irq_suspend_timeout;
+
+	if (n->irq > 0 && n->config && n->dev->irq_affinity_auto)
+		irq_set_affinity(n->irq, &n->config->affinity_mask);
+
 	/* a NAPI ID might be stored in the config, if so use it. if not, use
 	 * napi_hash_add to generate one for us. It will be saved to the config
 	 * in napi_disable.
@@ -6829,6 +6851,10 @@ static void napi_save_config(struct napi_struct *n)
 	n->config->gro_flush_timeout = n->gro_flush_timeout;
 	n->config->irq_suspend_timeout = n->irq_suspend_timeout;
 	n->config->napi_id = n->napi_id;
+
+	if (n->irq > 0 && n->config && n->dev->irq_affinity_auto)
+		irq_set_affinity_notifier(n->irq, NULL);
+
 	napi_hash_del(n);
 }
 
@@ -11293,7 +11319,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 {
 	struct net_device *dev;
 	size_t napi_config_sz;
-	unsigned int maxqs;
+	unsigned int maxqs, i, numa;
 
 	BUG_ON(strlen(name) >= sizeof(dev->name));
 
@@ -11389,6 +11415,10 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	dev->napi_config = kvzalloc(napi_config_sz, GFP_KERNEL_ACCOUNT);
 	if (!dev->napi_config)
 		goto free_all;
+	numa = dev_to_node(&dev->dev);
+	for (i = 0; i < maxqs; i++)
+		cpumask_set_cpu(cpumask_local_spread(i, numa),
+				&dev->napi_config[i].affinity_mask);
 
 	strscpy(dev->name, name);
 	dev->name_assign_type = name_assign_type;
-- 
2.43.0


