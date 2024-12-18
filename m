Return-Path: <netdev+bounces-153077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 621039F6BBD
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 18:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487F41894D46
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2661FA828;
	Wed, 18 Dec 2024 16:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G0AvZZBy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F7A1F9EA4
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541172; cv=none; b=RO/FPxM2YMOpo7dAkxyRm3VHWx66Wm8GUuDY4REtGtLd49NuKxScS2j4RHQNmd9GxOlavjJla0TCHtE7fv8qwefVxpuiVznyUHrpxfxA//SYfdaq9COYP+o46NRLes2Q3rcEVyjSVAw6gaQlzDjAdyHzx+R3OQ/wDnUXaKyV54w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541172; c=relaxed/simple;
	bh=uvohYjXV2F2dAriFn/q9+6q/VifOLx3veE1xtuRsoyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcghVO6IBzgcrboEoGlXkC/0HkyppxGOSxTax01GEVddtZZEjpKsHsZreIKBqZo0p3xaFJoBQffrVOIm/lSjKUpufh9tlOWBR7hMzNokw+LySGM1cx/tLev1LGQSghxl3XIh5U6L0YId73sgoQo7ek2olkacnPTr0FRa4O/d9cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G0AvZZBy; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734541170; x=1766077170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uvohYjXV2F2dAriFn/q9+6q/VifOLx3veE1xtuRsoyw=;
  b=G0AvZZByK0R+PTa8Xh51fL3X8JMBt+nk/YurRGJQMnkfR3UGhXGr+pU5
   c2tFsJfCsJRK19IWkh1E/ZQApMAd7cEr9zvkGWHlf5F9EAkumgjg+sddm
   4kA2cPbpvANeTRp9vep5YOrGCiNkMVh4ohVnfVoePzQ3sLWdzj5eNKSDI
   jTIf5dXnmHAEJvFmewuN/NTTVTbvRnogBuywtI7cT+saiSwFRgNTEfrcY
   VJDRLIBEMi6H/sIe6PPT22BFNHl2Eya0UEWCheWTUwiaNZ3V1lwONLIJm
   e8T8YYaaIiyM0bgvu+wTe0faHhAdRnMzYmzpP8LbtmuT4/pE3v9s19hZX
   w==;
X-CSE-ConnectionGUID: enTbx4NUTIG5vbZLha/F7Q==
X-CSE-MsgGUID: 7N6a+9dhQOqalQ8I4QNJbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="46415528"
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; 
   d="scan'208";a="46415528"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 08:59:30 -0800
X-CSE-ConnectionGUID: q4UprfIvSbC1nKl2eM83VQ==
X-CSE-MsgGUID: XwakriFQT2+ez7o8sMUxdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102531837"
Received: from ldmartin-desk2.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.111.224])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 08:59:24 -0800
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
Subject: [PATCH net-next v2 4/8] net: napi: add CPU affinity to napi->config
Date: Wed, 18 Dec 2024 09:58:39 -0700
Message-ID: <20241218165843.744647-5-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218165843.744647-1-ahmed.zaki@intel.com>
References: <20241218165843.744647-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A common task for most drivers is to remember the user-set CPU affinity
to its IRQs. On each netdev reset, the driver should re-assign the
user's setting to the IRQs.

Add CPU affinity mask to napi->config. To delegate the CPU affinity
management to the core, drivers must:
 1 - add a persistent napi config:     netif_napi_add_config()
 2 - bind an IRQ to the napi instance: netif_napi_set_irq() with the new
     flag NAPIF_IRQ_AFFINITY

the core will then make sure to use re-assign affinity to the napi's
IRQ.

The default mask set to all IRQs is all online CPUs.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 include/linux/netdevice.h |  5 +++
 net/core/dev.c            | 66 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0df419052434..4fa047fad8fb 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -351,6 +351,7 @@ struct napi_config {
 	u64 gro_flush_timeout;
 	u64 irq_suspend_timeout;
 	u32 defer_hard_irqs;
+	cpumask_t affinity_mask;
 	unsigned int napi_id;
 };
 
@@ -358,12 +359,16 @@ enum {
 #ifdef CONFIG_RFS_ACCEL
 	NAPI_IRQ_ARFS_RMAP,		/* Core handles RMAP updates */
 #endif
+	NAPI_IRQ_AFFINITY,		/* Core manages IRQ affinity */
+	NAPI_IRQ_NORMAP			/* Set by core (internal) */
 };
 
 enum {
 #ifdef CONFIG_RFS_ACCEL
 	NAPIF_IRQ_ARFS_RMAP		= BIT(NAPI_IRQ_ARFS_RMAP),
 #endif
+	NAPIF_IRQ_AFFINITY		= BIT(NAPI_IRQ_AFFINITY),
+	NAPIF_IRQ_NORMAP		= BIT(NAPI_IRQ_NORMAP),
 };
 
 /*
diff --git a/net/core/dev.c b/net/core/dev.c
index 7c3abff48aea..84745cea03a7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6705,8 +6705,44 @@ void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
 }
 EXPORT_SYMBOL(netif_queue_set_napi);
 
+static void
+netif_irq_cpu_rmap_notify(struct irq_affinity_notify *notify,
+			  const cpumask_t *mask)
+{
+	struct irq_glue *glue =
+		container_of(notify, struct irq_glue, notify);
+	struct napi_struct *napi = glue->data;
+	unsigned int flags;
+	int rc;
+
+	flags = napi->irq_flags;
+
+	if (napi->config && flags & NAPIF_IRQ_AFFINITY)
+		cpumask_copy(&napi->config->affinity_mask, mask);
+
+#ifdef CONFIG_RFS_ACCEL
+	if (napi->dev->rx_cpu_rmap && flags & NAPIF_IRQ_ARFS_RMAP) {
+		rc = cpu_rmap_update(glue->rmap, glue->index, mask);
+		if (rc)
+			pr_warn("%s: update failed: %d\n",
+				__func__, rc);
+	}
+#endif
+}
+
+static void
+netif_napi_affinity_release(struct kref __always_unused *ref)
+{
+	struct irq_glue *glue =
+		container_of(ref, struct irq_glue, notify.kref);
+
+	kfree(glue);
+}
+
 void netif_napi_set_irq(struct napi_struct *napi, int irq, unsigned long flags)
 {
+	struct irq_glue *glue = NULL;
+	bool glue_created;
 	int  rc;
 
 	napi->irq = irq;
@@ -6714,15 +6750,29 @@ void netif_napi_set_irq(struct napi_struct *napi, int irq, unsigned long flags)
 
 #ifdef CONFIG_RFS_ACCEL
 	if (napi->dev->rx_cpu_rmap && flags & NAPIF_IRQ_ARFS_RMAP) {
-		rc = irq_cpu_rmap_add(napi->dev->rx_cpu_rmap, irq);
+		rc = irq_cpu_rmap_add(napi->dev->rx_cpu_rmap, irq, napi,
+				      netif_irq_cpu_rmap_notify);
 		if (rc) {
 			netdev_warn(napi->dev, "Unable to update ARFS map (%d).\n",
 				    rc);
 			free_irq_cpu_rmap(napi->dev->rx_cpu_rmap);
 			napi->dev->rx_cpu_rmap = NULL;
+		} else {
+			glue_created = true;
 		}
 	}
 #endif
+
+	if (!glue_created && flags & NAPIF_IRQ_AFFINITY) {
+		glue = kzalloc(sizeof(*glue), GFP_KERNEL);
+		if (!glue)
+			return;
+		glue->notify.notify = netif_irq_cpu_rmap_notify;
+		glue->notify.release = netif_napi_affinity_release;
+		glue->data = napi;
+		glue->rmap = NULL;
+		napi->irq_flags |= NAPIF_IRQ_NORMAP;
+	}
 }
 EXPORT_SYMBOL(netif_napi_set_irq);
 
@@ -6731,6 +6781,10 @@ static void napi_restore_config(struct napi_struct *n)
 	n->defer_hard_irqs = n->config->defer_hard_irqs;
 	n->gro_flush_timeout = n->config->gro_flush_timeout;
 	n->irq_suspend_timeout = n->config->irq_suspend_timeout;
+
+	if (n->irq > 0 && n->irq_flags & NAPIF_IRQ_AFFINITY)
+		irq_set_affinity(n->irq, &n->config->affinity_mask);
+
 	/* a NAPI ID might be stored in the config, if so use it. if not, use
 	 * napi_hash_add to generate one for us. It will be saved to the config
 	 * in napi_disable.
@@ -6747,6 +6801,11 @@ static void napi_save_config(struct napi_struct *n)
 	n->config->gro_flush_timeout = n->gro_flush_timeout;
 	n->config->irq_suspend_timeout = n->irq_suspend_timeout;
 	n->config->napi_id = n->napi_id;
+
+	if (n->irq > 0 &&
+	    n->irq_flags & (NAPIF_IRQ_AFFINITY | NAPIF_IRQ_NORMAP))
+		irq_set_affinity_notifier(n->irq, NULL);
+
 	napi_hash_del(n);
 }
 
@@ -11211,7 +11270,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 {
 	struct net_device *dev;
 	size_t napi_config_sz;
-	unsigned int maxqs;
+	unsigned int maxqs, i;
 
 	BUG_ON(strlen(name) >= sizeof(dev->name));
 
@@ -11307,6 +11366,9 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	dev->napi_config = kvzalloc(napi_config_sz, GFP_KERNEL_ACCOUNT);
 	if (!dev->napi_config)
 		goto free_all;
+	for (i = 0; i < maxqs; i++)
+		cpumask_copy(&dev->napi_config[i].affinity_mask,
+			     cpu_online_mask);
 
 	strscpy(dev->name, name);
 	dev->name_assign_type = name_assign_type;
-- 
2.43.0


