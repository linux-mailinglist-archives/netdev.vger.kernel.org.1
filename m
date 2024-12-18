Return-Path: <netdev+bounces-153075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB6A9F6BB3
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 316D7168167
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C3D1F8AE6;
	Wed, 18 Dec 2024 16:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k9gDS/nY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A4F1F2396
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 16:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541160; cv=none; b=Fxkdi/8yj0S51SLXMatrygUQdpAsVsasRJwvxeQa6AH2jyO3yjdelhb98o6uzJF2Kc34gnDGKb6cUZIa7EdlWewXsU9KXQTRe/vLKKsmPEgjj4/BgXeHCPAvUOp+g4aIkvhEfwKF3LDpdbnALtfu3YxQ7KCS8R0amy6KY5sS/IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541160; c=relaxed/simple;
	bh=KhIPNPJHmImcf0ZEs3qYAp8F5l15ZiL20/BE1f3GjZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXVv4rAA7XSkLfc9a16aemW2goTbtpmu4lwKSUELATyE+bqKx7WiXSp+DvU1gx70mVzOdxfY2USdlRdurtbWgNcIaBW63Hp1ifKVdST9IoVujThF+qoE1ea0UjVd5YBoaL5Zobq557KiWLfl/0/Fw/FvT0SvcZaRts1t9VCWA8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k9gDS/nY; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734541158; x=1766077158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KhIPNPJHmImcf0ZEs3qYAp8F5l15ZiL20/BE1f3GjZU=;
  b=k9gDS/nYKHqntheZ4tLrubYwzEu1hZyofzV801GDJJxXhopJ7tRlhyOi
   fLWlst5vmB10a9vIhtAIwA6nN8SLBDqeiq/2vt7483lGQR5wndCHes07+
   5sf0ZsLtcCEoJYLT9UZl/PAK2ExUDFpMNGtaGnhSrBwoPuencDhonYqsq
   C0ApihNM5D7zOl/07BrCmwz7yA30Gbv+2M4gWtD94EjMpa33AiAis71AW
   MWnArZU9q5sk670VSgFjJ9wvHR6iRKscsf3Y86NDFOcT/h9XnStXc71WS
   S/tLf4gic7pJq62M46owGCyy4Tsd/czsX0xgXF6MgOZ3aON7NuGg5OEOE
   Q==;
X-CSE-ConnectionGUID: RS4M8iVPR/+HnxYIPK9ZZg==
X-CSE-MsgGUID: RuaFlHMOSMe+HN9kawCHVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="46415500"
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; 
   d="scan'208";a="46415500"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 08:59:17 -0800
X-CSE-ConnectionGUID: 7AmGc/ESTnSYjFqyDm6Ltw==
X-CSE-MsgGUID: 89jf8hhdTV68B1m8NfKe7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102531675"
Received: from ldmartin-desk2.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.111.224])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 08:59:12 -0800
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
Subject: [PATCH net-next v2 2/8] net: allow ARFS rmap management in core
Date: Wed, 18 Dec 2024 09:58:37 -0700
Message-ID: <20241218165843.744647-3-ahmed.zaki@intel.com>
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

Add a new napi->irq flag; NAPIF_IRQ_ARFS_RMAP. A driver can use the flag
when binding an irq to a napi:

 netif_napi_set_irq(napi, irq, NAPIF_IRQ_ARFS_RMAP)

and the core will update the ARFS rmap with the assigned irq affinity.

Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c  | 19 ++++---------
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 25 ++++++-----------
 drivers/net/ethernet/intel/ice/ice_arfs.c     | 10 +------
 drivers/net/ethernet/intel/ice/ice_lib.c      |  5 ++++
 drivers/net/ethernet/qlogic/qede/qede_main.c  | 28 +++++++++----------
 drivers/net/ethernet/sfc/falcon/efx.c         |  9 ++++++
 drivers/net/ethernet/sfc/falcon/nic.c         | 10 -------
 drivers/net/ethernet/sfc/siena/efx_channels.c |  9 ++++++
 drivers/net/ethernet/sfc/siena/nic.c          | 10 -------
 include/linux/netdevice.h                     | 12 ++++++++
 net/core/dev.c                                | 14 ++++++++++
 11 files changed, 77 insertions(+), 74 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 4898c8be78ad..752b1c61b610 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -165,23 +165,9 @@ int ena_xmit_common(struct ena_adapter *adapter,
 static int ena_init_rx_cpu_rmap(struct ena_adapter *adapter)
 {
 #ifdef CONFIG_RFS_ACCEL
-	u32 i;
-	int rc;
-
 	adapter->netdev->rx_cpu_rmap = alloc_irq_cpu_rmap(adapter->num_io_queues);
 	if (!adapter->netdev->rx_cpu_rmap)
 		return -ENOMEM;
-	for (i = 0; i < adapter->num_io_queues; i++) {
-		int irq_idx = ENA_IO_IRQ_IDX(i);
-
-		rc = irq_cpu_rmap_add(adapter->netdev->rx_cpu_rmap,
-				      pci_irq_vector(adapter->pdev, irq_idx));
-		if (rc) {
-			free_irq_cpu_rmap(adapter->netdev->rx_cpu_rmap);
-			adapter->netdev->rx_cpu_rmap = NULL;
-			return rc;
-		}
-	}
 #endif /* CONFIG_RFS_ACCEL */
 	return 0;
 }
@@ -1712,7 +1698,12 @@ static int ena_request_io_irq(struct ena_adapter *adapter)
 	for (i = 0; i < io_queue_count; i++) {
 		irq_idx = ENA_IO_IRQ_IDX(i);
 		irq = &adapter->irq_tbl[irq_idx];
+#ifdef CONFIG_RFS_ACCEL
+		netif_napi_set_irq(&adapter->ena_napi[i].napi, irq->vector,
+				   NAPIF_IRQ_ARFS_RMAP);
+#else
 		netif_napi_set_irq(&adapter->ena_napi[i].napi, irq->vector, 0);
+#endif
 	}
 
 	return rc;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 4763c6300bd3..ac729a25ba52 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11192,11 +11192,8 @@ static void bnxt_free_irq(struct bnxt *bp)
 
 static int bnxt_request_irq(struct bnxt *bp)
 {
-	int i, j, rc = 0;
+	int i, rc = 0;
 	unsigned long flags = 0;
-#ifdef CONFIG_RFS_ACCEL
-	struct cpu_rmap *rmap;
-#endif
 
 	rc = bnxt_setup_int_mode(bp);
 	if (rc) {
@@ -11204,28 +11201,22 @@ static int bnxt_request_irq(struct bnxt *bp)
 			   rc);
 		return rc;
 	}
-#ifdef CONFIG_RFS_ACCEL
-	rmap = bp->dev->rx_cpu_rmap;
-#endif
-	for (i = 0, j = 0; i < bp->cp_nr_rings; i++) {
+
+	for (i = 0; i < bp->cp_nr_rings; i++) {
 		int map_idx = bnxt_cp_num_to_irq_num(bp, i);
 		struct bnxt_irq *irq = &bp->irq_tbl[map_idx];
 
-#ifdef CONFIG_RFS_ACCEL
-		if (rmap && bp->bnapi[i]->rx_ring) {
-			rc = irq_cpu_rmap_add(rmap, irq->vector);
-			if (rc)
-				netdev_warn(bp->dev, "failed adding irq rmap for ring %d\n",
-					    j);
-			j++;
-		}
-#endif
 		rc = request_irq(irq->vector, irq->handler, flags, irq->name,
 				 bp->bnapi[i]);
 		if (rc)
 			break;
 
+#ifdef CONFIG_RFS_ACCEL
+		netif_napi_set_irq(&bp->bnapi[i]->napi, irq->vector,
+				   NAPIF_IRQ_ARFS_RMAP);
+#else
 		netif_napi_set_irq(&bp->bnapi[i]->napi, irq->vector, 0);
+#endif
 		irq->requested = 1;
 
 		if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
diff --git a/drivers/net/ethernet/intel/ice/ice_arfs.c b/drivers/net/ethernet/intel/ice/ice_arfs.c
index 7cee365cc7d1..54d51d218cae 100644
--- a/drivers/net/ethernet/intel/ice/ice_arfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_arfs.c
@@ -590,14 +590,13 @@ void ice_free_cpu_rx_rmap(struct ice_vsi *vsi)
 }
 
 /**
- * ice_set_cpu_rx_rmap - setup CPU reverse map for each queue
+ * ice_set_cpu_rx_rmap - allocate CPU reverse map for a VSI
  * @vsi: the VSI to be forwarded to
  */
 int ice_set_cpu_rx_rmap(struct ice_vsi *vsi)
 {
 	struct net_device *netdev;
 	struct ice_pf *pf;
-	int i;
 
 	if (!vsi || vsi->type != ICE_VSI_PF)
 		return 0;
@@ -614,13 +613,6 @@ int ice_set_cpu_rx_rmap(struct ice_vsi *vsi)
 	if (unlikely(!netdev->rx_cpu_rmap))
 		return -EINVAL;
 
-	ice_for_each_q_vector(vsi, i)
-		if (irq_cpu_rmap_add(netdev->rx_cpu_rmap,
-				     vsi->q_vectors[i]->irq.virq)) {
-			ice_free_cpu_rx_rmap(vsi);
-			return -EINVAL;
-		}
-
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index ff91e70f596f..7c0b2d8e86ba 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2735,7 +2735,12 @@ void ice_vsi_set_napi_queues(struct ice_vsi *vsi)
 	ice_for_each_q_vector(vsi, v_idx) {
 		struct ice_q_vector *q_vector = vsi->q_vectors[v_idx];
 
+#ifdef CONFIG_RFS_ACCEL
+		netif_napi_set_irq(&q_vector->napi, q_vector->irq.virq,
+				   NAPIF_IRQ_ARFS_RMAP);
+#else
 		netif_napi_set_irq(&q_vector->napi, q_vector->irq.virq, 0);
+#endif
 	}
 }
 
diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index 99df00c30b8c..27c987435242 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -1944,12 +1944,24 @@ static void qede_napi_disable_remove(struct qede_dev *edev)
 
 static void qede_napi_add_enable(struct qede_dev *edev)
 {
+	struct qede_fastpath *fp = &edev->fp_array[i];
 	int i;
 
 	/* Add NAPI objects */
 	for_each_queue(i) {
-		netif_napi_add(edev->ndev, &edev->fp_array[i].napi, qede_poll);
-		napi_enable(&edev->fp_array[i].napi);
+		fp = &edev->fp_array[i];
+		netif_napi_add(edev->ndev, &fp->napi, qede_poll);
+		napi_enable(&fp->napi);
+		if (edev->ndev->rx_cpu_rmap && (fp->type & QEDE_FASTPATH_RX))
+#ifdef CONFIG_RFS_ACCEL
+			netif_napi_set_irq(&edev->fp_array[i].napi,
+					   edev->int_info.msix[i].vector,
+					   NAPIF_IRQ_ARFS_RMAP);
+#else
+			netif_napi_set_irq(&edev->fp_array[i].napi,
+					   edev->int_info.msix[i].vector,
+					   0);
+#endif
 	}
 }
 
@@ -1983,18 +1995,6 @@ static int qede_req_msix_irqs(struct qede_dev *edev)
 	}
 
 	for (i = 0; i < QEDE_QUEUE_CNT(edev); i++) {
-#ifdef CONFIG_RFS_ACCEL
-		struct qede_fastpath *fp = &edev->fp_array[i];
-
-		if (edev->ndev->rx_cpu_rmap && (fp->type & QEDE_FASTPATH_RX)) {
-			rc = irq_cpu_rmap_add(edev->ndev->rx_cpu_rmap,
-					      edev->int_info.msix[i].vector);
-			if (rc) {
-				DP_ERR(edev, "Failed to add CPU rmap\n");
-				qede_free_arfs(edev);
-			}
-		}
-#endif
 		rc = request_irq(edev->int_info.msix[i].vector,
 				 qede_msix_fp_int, 0, edev->fp_array[i].name,
 				 &edev->fp_array[i]);
diff --git a/drivers/net/ethernet/sfc/falcon/efx.c b/drivers/net/ethernet/sfc/falcon/efx.c
index b07f7e4e2877..8c2f850d4639 100644
--- a/drivers/net/ethernet/sfc/falcon/efx.c
+++ b/drivers/net/ethernet/sfc/falcon/efx.c
@@ -2004,6 +2004,15 @@ static void ef4_init_napi_channel(struct ef4_channel *channel)
 
 	channel->napi_dev = efx->net_dev;
 	netif_napi_add(channel->napi_dev, &channel->napi_str, ef4_poll);
+
+	if (efx->interrupt_mode == EF4_INT_MODE_MSIX &&
+	    channel->channel < efx->n_rx_channels)
+#ifdef CONFIG_RFS_ACCEL
+		netif_napi_set_irq(&channel->napi_str, channel->irq,
+				   NAPIF_IRQ_ARFS_RMAP);
+#else
+		netif_napi_set_irq(&channel->napi_str, channel->irq, 0);
+#endif
 }
 
 static void ef4_init_napi(struct ef4_nic *efx)
diff --git a/drivers/net/ethernet/sfc/falcon/nic.c b/drivers/net/ethernet/sfc/falcon/nic.c
index a6304686bc90..fa31d83e64e4 100644
--- a/drivers/net/ethernet/sfc/falcon/nic.c
+++ b/drivers/net/ethernet/sfc/falcon/nic.c
@@ -115,16 +115,6 @@ int ef4_nic_init_interrupt(struct ef4_nic *efx)
 			goto fail2;
 		}
 		++n_irqs;
-
-#ifdef CONFIG_RFS_ACCEL
-		if (efx->interrupt_mode == EF4_INT_MODE_MSIX &&
-		    channel->channel < efx->n_rx_channels) {
-			rc = irq_cpu_rmap_add(efx->net_dev->rx_cpu_rmap,
-					      channel->irq);
-			if (rc)
-				goto fail2;
-		}
-#endif
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/sfc/siena/efx_channels.c b/drivers/net/ethernet/sfc/siena/efx_channels.c
index d120b3c83ac0..6fed4f7b311f 100644
--- a/drivers/net/ethernet/sfc/siena/efx_channels.c
+++ b/drivers/net/ethernet/sfc/siena/efx_channels.c
@@ -1321,6 +1321,15 @@ static void efx_init_napi_channel(struct efx_channel *channel)
 
 	channel->napi_dev = efx->net_dev;
 	netif_napi_add(channel->napi_dev, &channel->napi_str, efx_poll);
+
+	if (efx->interrupt_mode == EFX_INT_MODE_MSIX &&
+	    channel->channel < efx->n_rx_channels)
+#ifdef CONFIG_RFS_ACCEL
+		netif_napi_set_irq(&channel->napi_str, channel->irq,
+				   NAPIF_IRQ_ARFS_RMAP);
+#else
+		netif_napi_set_irq(&channel->napi_str, channel->irq, 0);
+#endif
 }
 
 void efx_siena_init_napi(struct efx_nic *efx)
diff --git a/drivers/net/ethernet/sfc/siena/nic.c b/drivers/net/ethernet/sfc/siena/nic.c
index 32fce70085e3..28ef6222395e 100644
--- a/drivers/net/ethernet/sfc/siena/nic.c
+++ b/drivers/net/ethernet/sfc/siena/nic.c
@@ -117,16 +117,6 @@ int efx_siena_init_interrupt(struct efx_nic *efx)
 			goto fail2;
 		}
 		++n_irqs;
-
-#ifdef CONFIG_RFS_ACCEL
-		if (efx->interrupt_mode == EFX_INT_MODE_MSIX &&
-		    channel->channel < efx->n_rx_channels) {
-			rc = irq_cpu_rmap_add(efx->net_dev->rx_cpu_rmap,
-					      channel->irq);
-			if (rc)
-				goto fail2;
-		}
-#endif
 	}
 
 	efx->irqs_hooked = true;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ca91b6662bde..0df419052434 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -354,6 +354,18 @@ struct napi_config {
 	unsigned int napi_id;
 };
 
+enum {
+#ifdef CONFIG_RFS_ACCEL
+	NAPI_IRQ_ARFS_RMAP,		/* Core handles RMAP updates */
+#endif
+};
+
+enum {
+#ifdef CONFIG_RFS_ACCEL
+	NAPIF_IRQ_ARFS_RMAP		= BIT(NAPI_IRQ_ARFS_RMAP),
+#endif
+};
+
 /*
  * Structure for NAPI scheduling similar to tasklet but with weighting
  */
diff --git a/net/core/dev.c b/net/core/dev.c
index 88a7d4b6e71b..7c3abff48aea 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6707,8 +6707,22 @@ EXPORT_SYMBOL(netif_queue_set_napi);
 
 void netif_napi_set_irq(struct napi_struct *napi, int irq, unsigned long flags)
 {
+	int  rc;
+
 	napi->irq = irq;
 	napi->irq_flags = flags;
+
+#ifdef CONFIG_RFS_ACCEL
+	if (napi->dev->rx_cpu_rmap && flags & NAPIF_IRQ_ARFS_RMAP) {
+		rc = irq_cpu_rmap_add(napi->dev->rx_cpu_rmap, irq);
+		if (rc) {
+			netdev_warn(napi->dev, "Unable to update ARFS map (%d).\n",
+				    rc);
+			free_irq_cpu_rmap(napi->dev->rx_cpu_rmap);
+			napi->dev->rx_cpu_rmap = NULL;
+		}
+	}
+#endif
 }
 EXPORT_SYMBOL(netif_napi_set_irq);
 
-- 
2.43.0


