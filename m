Return-Path: <netdev+bounces-153076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5B39F6BB7
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E346D169C6A
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1220F1F9408;
	Wed, 18 Dec 2024 16:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZWrSebV9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3501F8F0B
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541166; cv=none; b=e+Q08vQJn7AYfsA/65/w/Sq0dz9K7G2pqXxfQCqY89FG6sWKiMn/MFYyRe9GmKs4IC+2+Si+tGUR4IAXNQZE/s+xCZuMjMhYILw9SZwkoZ7qd7aK/TbmNGB0NC5dWsqk3k6CCP+RphhgizF2byUW3moRg7RH7KiXKHNbr3lVLiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541166; c=relaxed/simple;
	bh=2fwKur69SkO2Al+4r9/Gm9fu59bB1iv1Ov283megPig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3b4Em/x0+vBrSlZpVQP3VKPYjp/4Pwcu/rRFxZ6tlMoBwWRxBCixa5n8wt2gO9/bSXXprrfDcWd/96+80Y/Zsd2MgRm1L4tNLwiF6iKKPcjmOkVkg0vM/bH3YjuRmXERfto6TgVxWmVxdoZK8KHbExWd0gFaukek5HXB8XLLT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZWrSebV9; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734541164; x=1766077164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2fwKur69SkO2Al+4r9/Gm9fu59bB1iv1Ov283megPig=;
  b=ZWrSebV9taYDIzAJpw0BrM8zyOTGC50XaiESRjgfaLGrkASVGQtrEfAg
   /L7pWbokoAybc5Z5i1ln9JDQDnjF3WEW+kJrD0FhF89AZXcczAXCNvd+n
   lTWhEaOnntG1Qhg27cNZsrgY59ppwpVzbWJ/dsnoJDf3nt4jgDD2h1bf+
   AY5ndgSBxJzAzr4acobqGRY7S+GAnbC26kmrssh8p0rH5DYHJ0PHCJZZe
   ablA7wiTAmciSNeoALfytxLcmmRl2CVsTDr7gwyx5HPJaEIH/U6AmskT6
   9DrhbDwt1loIRh2gYzIjWrw7M9u3ZQ5yk57UL3ZX86LPrtidhG2feyu0g
   Q==;
X-CSE-ConnectionGUID: ryt7TDdWSiae1TsKzS5n2g==
X-CSE-MsgGUID: U9P1dwk9QJij+hExWiAWdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="46415520"
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; 
   d="scan'208";a="46415520"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 08:59:24 -0800
X-CSE-ConnectionGUID: MY7m7WPISTqkaxg30e5H+w==
X-CSE-MsgGUID: RugHsvEfQw+fSFpUufel5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102531758"
Received: from ldmartin-desk2.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.111.224])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 08:59:18 -0800
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
Subject: [PATCH net-next v2 3/8] lib: cpu_rmap: allow passing a notifier callback
Date: Wed, 18 Dec 2024 09:58:38 -0700
Message-ID: <20241218165843.744647-4-ahmed.zaki@intel.com>
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

Allow the rmap users to pass a notifier callback function that can be
called instead of irq_cpu_rmap_notify().

Two modifications are made:
   * make struct irg_glue visible in cpu_rmap.h
   * pass a new "void* data" parameter that can be used by the cb
     function.

Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c   |  3 ++-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  2 +-
 drivers/net/ethernet/mellanox/mlx4/eq.c       |  2 +-
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c |  2 +-
 drivers/net/ethernet/sfc/nic.c                |  2 +-
 include/linux/cpu_rmap.h                      | 13 +++++++++++-
 lib/cpu_rmap.c                                | 20 +++++++++----------
 7 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 9913952ccb42..e384b975b8af 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -1657,7 +1657,8 @@ static void enic_set_rx_cpu_rmap(struct enic *enic)
 			return;
 		for (i = 0; i < enic->rq_count; i++) {
 			res = irq_cpu_rmap_add(enic->netdev->rx_cpu_rmap,
-					       enic->msix_entry[i].vector);
+					       enic->msix_entry[i].vector,
+					       NULL, NULL);
 			if (unlikely(res)) {
 				enic_free_rx_cpu_rmap(enic);
 				return;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 43377a7b2426..3f732516c8ee 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -697,7 +697,7 @@ static int hns3_set_rx_cpu_rmap(struct net_device *netdev)
 	for (i = 0; i < priv->vector_num; i++) {
 		tqp_vector = &priv->tqp_vector[i];
 		ret = irq_cpu_rmap_add(netdev->rx_cpu_rmap,
-				       tqp_vector->vector_irq);
+				       tqp_vector->vector_irq, NULL, NULL);
 		if (ret) {
 			hns3_free_rx_cpu_rmap(netdev);
 			return ret;
diff --git a/drivers/net/ethernet/mellanox/mlx4/eq.c b/drivers/net/ethernet/mellanox/mlx4/eq.c
index 9572a45f6143..d768a6a828c4 100644
--- a/drivers/net/ethernet/mellanox/mlx4/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx4/eq.c
@@ -1243,7 +1243,7 @@ int mlx4_init_eq_table(struct mlx4_dev *dev)
 				}
 
 				err = irq_cpu_rmap_add(
-					info->rmap, eq->irq);
+					info->rmap, eq->irq, NULL, NULL);
 				if (err)
 					mlx4_warn(dev, "Failed adding irq rmap\n");
 			}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index 7db9cab9bedf..4f2c4631aecb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -285,7 +285,7 @@ struct mlx5_irq *mlx5_irq_alloc(struct mlx5_irq_pool *pool, int i,
 
 	if (i && rmap && *rmap) {
 #ifdef CONFIG_RFS_ACCEL
-		err = irq_cpu_rmap_add(*rmap, irq->map.virq);
+		err = irq_cpu_rmap_add(*rmap, irq->map.virq, NULL, NULL);
 		if (err)
 			goto err_irq_rmap;
 #endif
diff --git a/drivers/net/ethernet/sfc/nic.c b/drivers/net/ethernet/sfc/nic.c
index 80aa5e9c732a..e7c6c3002826 100644
--- a/drivers/net/ethernet/sfc/nic.c
+++ b/drivers/net/ethernet/sfc/nic.c
@@ -122,7 +122,7 @@ int efx_nic_init_interrupt(struct efx_nic *efx)
 		if (efx->interrupt_mode == EFX_INT_MODE_MSIX &&
 		    channel->channel < efx->n_rx_channels) {
 			rc = irq_cpu_rmap_add(efx->net_dev->rx_cpu_rmap,
-					      channel->irq);
+					      channel->irq, NULL, NULL);
 			if (rc)
 				goto fail2;
 		}
diff --git a/include/linux/cpu_rmap.h b/include/linux/cpu_rmap.h
index 20b5729903d7..48f89d19bdb9 100644
--- a/include/linux/cpu_rmap.h
+++ b/include/linux/cpu_rmap.h
@@ -11,6 +11,15 @@
 #include <linux/gfp.h>
 #include <linux/slab.h>
 #include <linux/kref.h>
+#include <linux/interrupt.h>
+
+/* Glue between IRQ affinity notifiers and CPU rmaps */
+struct irq_glue {
+	struct irq_affinity_notify notify;
+	struct cpu_rmap *rmap;
+	void *data;
+	u16 index;
+};
 
 /**
  * struct cpu_rmap - CPU affinity reverse-map
@@ -61,6 +70,8 @@ static inline struct cpu_rmap *alloc_irq_cpu_rmap(unsigned int size)
 extern void free_irq_cpu_rmap(struct cpu_rmap *rmap);
 
 int irq_cpu_rmap_remove(struct cpu_rmap *rmap, int irq);
-extern int irq_cpu_rmap_add(struct cpu_rmap *rmap, int irq);
+extern int irq_cpu_rmap_add(struct cpu_rmap *rmap, int irq, void *data,
+			    void (*notify)(struct irq_affinity_notify *notify,
+					   const cpumask_t *mask));
 
 #endif /* __LINUX_CPU_RMAP_H */
diff --git a/lib/cpu_rmap.c b/lib/cpu_rmap.c
index 4c348670da31..0c9c1078143d 100644
--- a/lib/cpu_rmap.c
+++ b/lib/cpu_rmap.c
@@ -220,14 +220,6 @@ int cpu_rmap_update(struct cpu_rmap *rmap, u16 index,
 }
 EXPORT_SYMBOL(cpu_rmap_update);
 
-/* Glue between IRQ affinity notifiers and CPU rmaps */
-
-struct irq_glue {
-	struct irq_affinity_notify notify;
-	struct cpu_rmap *rmap;
-	u16 index;
-};
-
 /**
  * free_irq_cpu_rmap - free a CPU affinity reverse-map used for IRQs
  * @rmap: Reverse-map allocated with alloc_irq_cpu_map(), or %NULL
@@ -300,6 +292,8 @@ EXPORT_SYMBOL(irq_cpu_rmap_remove);
  * irq_cpu_rmap_add - add an IRQ to a CPU affinity reverse-map
  * @rmap: The reverse-map
  * @irq: The IRQ number
+ * @data: Generic data
+ * @notify: Callback function to update the CPU-IRQ rmap
  *
  * This adds an IRQ affinity notifier that will update the reverse-map
  * automatically.
@@ -307,16 +301,22 @@ EXPORT_SYMBOL(irq_cpu_rmap_remove);
  * Must be called in process context, after the IRQ is allocated but
  * before it is bound with request_irq().
  */
-int irq_cpu_rmap_add(struct cpu_rmap *rmap, int irq)
+int irq_cpu_rmap_add(struct cpu_rmap *rmap, int irq, void *data,
+		     void (*notify)(struct irq_affinity_notify *notify,
+				    const cpumask_t *mask))
 {
 	struct irq_glue *glue = kzalloc(sizeof(*glue), GFP_KERNEL);
 	int rc;
 
 	if (!glue)
 		return -ENOMEM;
-	glue->notify.notify = irq_cpu_rmap_notify;
+
+	if (!notify)
+		notify = irq_cpu_rmap_notify;
+	glue->notify.notify = notify;
 	glue->notify.release = irq_cpu_rmap_release;
 	glue->rmap = rmap;
+	glue->data = data;
 	cpu_rmap_get(rmap);
 	rc = cpu_rmap_add(rmap, glue);
 	if (rc < 0)
-- 
2.43.0


