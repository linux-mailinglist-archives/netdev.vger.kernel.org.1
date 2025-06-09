Return-Path: <netdev+bounces-195879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE62AD28C2
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 23:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080C53B38BE
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 21:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139BB225A2C;
	Mon,  9 Jun 2025 21:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aDoRDbhC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445B12253B2
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749504431; cv=none; b=paWMulZh3IExeoOSTSy66Ti4walkjQgl/HYQPcqpNL2idvkwD6OtqsAUHMsYRTCQcYsxnkpXXPypAnVQrQrUVuKMa42GhLC8jDx5Ci6bs3gdrXEnvINjrBucmeQklerMUXupGMGE06ED8ZbKzh4buBrjCSMeccCPoEeWwW1hhMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749504431; c=relaxed/simple;
	bh=Aq19EqLsaM3bC3k8uaj61bq8E2D1x9qee0m2jbDyGM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wf/eY3mUjEow12659vwvpf1MgeGcq3LO5XXEclDF/5xpYSx4lRq5M4lbqpH7jDvWV7h2HiLZyINSG2oZDhz1k/efBs5ULSdsbUqXqHb6gHyUoPXLmWYy2z4WMAulvCpBFmpdLQveojYsaQcdl7IElHk8UHifYHm65DggVuPKjkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aDoRDbhC; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749504429; x=1781040429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Aq19EqLsaM3bC3k8uaj61bq8E2D1x9qee0m2jbDyGM4=;
  b=aDoRDbhC8NmfR0s1Yzj0vTJNF044FrQXbnRMGS+2cEbfllUTd2efn05O
   Bfmszx7ezDPTEx+X7hkTA3amzw3Go9cRl42P+L0cIKt0zUNRoI/sbcr45
   H0ieeWNXKPpHSTJAUOiXJmiT7u3AbUB9l3RBohSYTzjbFDfHLF1l0C7Kd
   0jmFa+O79NQiovu9V6LFryE3OixrLw4N/F0ZoQJgmd90MtZtw56vkIW7U
   anxDj7QulH/nEXRUTu83OBUlh/YOTwcbS9lRU3RELe9K3xcUcsMGDJqhc
   FVSPef6GIJn/F5skxKqfR1VmB1KCgNz8P1kIL6t0sxCxgZG4ffL77vvIS
   A==;
X-CSE-ConnectionGUID: 8ud8FQSRR0Kz2qiobPMknw==
X-CSE-MsgGUID: gdpG52+kST2hDjSJweMZyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="61864240"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="61864240"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 14:27:05 -0700
X-CSE-ConnectionGUID: gkscjmSHR2ulfMT8sCRzXw==
X-CSE-MsgGUID: cTeQND9uSfySBZxm5frWDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="150469062"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 09 Jun 2025 14:27:06 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Ahmed Zaki <ahmed.zaki@intel.com>,
	anthony.l.nguyen@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 10/11] iavf: convert to NAPI IRQ affinity API
Date: Mon,  9 Jun 2025 14:26:49 -0700
Message-ID: <20250609212652.1138933-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250609212652.1138933-1-anthony.l.nguyen@intel.com>
References: <20250609212652.1138933-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ahmed Zaki <ahmed.zaki@intel.com>

Commit bd7c00605ee0 ("net: move aRFS rmap management and CPU affinity
to core") allows the drivers to delegate the IRQ affinity to the NAPI
instance. However, the driver needs to use a persistent NAPI config
and explicitly set/unset the NAPI<->IRQ association.

Convert to the new IRQ affinity API.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h      |  2 -
 drivers/net/ethernet/intel/iavf/iavf_main.c | 58 ++++-----------------
 drivers/net/ethernet/intel/iavf/iavf_txrx.c |  3 +-
 3 files changed, 12 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index eb86cca38be2..a87e0c6d4017 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -114,8 +114,6 @@ struct iavf_q_vector {
 	u16 reg_idx;		/* register index of the interrupt */
 	char name[IFNAMSIZ + 15];
 	bool arm_wb_state;
-	cpumask_t affinity_mask;
-	struct irq_affinity_notify affinity_notify;
 };
 
 /* Helper macros to switch between ints/sec and what the register uses.
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 01e11ac5055b..2f501c8264b4 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -527,33 +527,6 @@ static void iavf_map_rings_to_vectors(struct iavf_adapter *adapter)
 	adapter->aq_required |= IAVF_FLAG_AQ_MAP_VECTORS;
 }
 
-/**
- * iavf_irq_affinity_notify - Callback for affinity changes
- * @notify: context as to what irq was changed
- * @mask: the new affinity mask
- *
- * This is a callback function used by the irq_set_affinity_notifier function
- * so that we may register to receive changes to the irq affinity masks.
- **/
-static void iavf_irq_affinity_notify(struct irq_affinity_notify *notify,
-				     const cpumask_t *mask)
-{
-	struct iavf_q_vector *q_vector =
-		container_of(notify, struct iavf_q_vector, affinity_notify);
-
-	cpumask_copy(&q_vector->affinity_mask, mask);
-}
-
-/**
- * iavf_irq_affinity_release - Callback for affinity notifier release
- * @ref: internal core kernel usage
- *
- * This is a callback function used by the irq_set_affinity_notifier function
- * to inform the current notification subscriber that they will no longer
- * receive notifications.
- **/
-static void iavf_irq_affinity_release(struct kref *ref) {}
-
 /**
  * iavf_request_traffic_irqs - Initialize MSI-X interrupts
  * @adapter: board private structure
@@ -568,7 +541,6 @@ iavf_request_traffic_irqs(struct iavf_adapter *adapter, char *basename)
 	unsigned int vector, q_vectors;
 	unsigned int rx_int_idx = 0, tx_int_idx = 0;
 	int irq_num, err;
-	int cpu;
 
 	iavf_irq_disable(adapter);
 	/* Decrement for Other and TCP Timer vectors */
@@ -603,17 +575,6 @@ iavf_request_traffic_irqs(struct iavf_adapter *adapter, char *basename)
 				 "Request_irq failed, error: %d\n", err);
 			goto free_queue_irqs;
 		}
-		/* register for affinity change notifications */
-		q_vector->affinity_notify.notify = iavf_irq_affinity_notify;
-		q_vector->affinity_notify.release =
-						   iavf_irq_affinity_release;
-		irq_set_affinity_notifier(irq_num, &q_vector->affinity_notify);
-		/* Spread the IRQ affinity hints across online CPUs. Note that
-		 * get_cpu_mask returns a mask with a permanent lifetime so
-		 * it's safe to use as a hint for irq_update_affinity_hint.
-		 */
-		cpu = cpumask_local_spread(q_vector->v_idx, -1);
-		irq_update_affinity_hint(irq_num, get_cpu_mask(cpu));
 	}
 
 	return 0;
@@ -622,8 +583,6 @@ iavf_request_traffic_irqs(struct iavf_adapter *adapter, char *basename)
 	while (vector) {
 		vector--;
 		irq_num = adapter->msix_entries[vector + NONQ_VECS].vector;
-		irq_set_affinity_notifier(irq_num, NULL);
-		irq_update_affinity_hint(irq_num, NULL);
 		free_irq(irq_num, &adapter->q_vectors[vector]);
 	}
 	return err;
@@ -665,6 +624,7 @@ static int iavf_request_misc_irq(struct iavf_adapter *adapter)
  **/
 static void iavf_free_traffic_irqs(struct iavf_adapter *adapter)
 {
+	struct iavf_q_vector *q_vector;
 	int vector, irq_num, q_vectors;
 
 	if (!adapter->msix_entries)
@@ -673,10 +633,10 @@ static void iavf_free_traffic_irqs(struct iavf_adapter *adapter)
 	q_vectors = adapter->num_msix_vectors - NONQ_VECS;
 
 	for (vector = 0; vector < q_vectors; vector++) {
+		q_vector = &adapter->q_vectors[vector];
+		netif_napi_set_irq_locked(&q_vector->napi, -1);
 		irq_num = adapter->msix_entries[vector + NONQ_VECS].vector;
-		irq_set_affinity_notifier(irq_num, NULL);
-		irq_update_affinity_hint(irq_num, NULL);
-		free_irq(irq_num, &adapter->q_vectors[vector]);
+		free_irq(irq_num, q_vector);
 	}
 }
 
@@ -1847,7 +1807,7 @@ static int iavf_init_rss(struct iavf_adapter *adapter)
  **/
 static int iavf_alloc_q_vectors(struct iavf_adapter *adapter)
 {
-	int q_idx = 0, num_q_vectors;
+	int q_idx = 0, num_q_vectors, irq_num;
 	struct iavf_q_vector *q_vector;
 
 	num_q_vectors = adapter->num_msix_vectors - NONQ_VECS;
@@ -1857,14 +1817,15 @@ static int iavf_alloc_q_vectors(struct iavf_adapter *adapter)
 		return -ENOMEM;
 
 	for (q_idx = 0; q_idx < num_q_vectors; q_idx++) {
+		irq_num = adapter->msix_entries[q_idx + NONQ_VECS].vector;
 		q_vector = &adapter->q_vectors[q_idx];
 		q_vector->adapter = adapter;
 		q_vector->vsi = &adapter->vsi;
 		q_vector->v_idx = q_idx;
 		q_vector->reg_idx = q_idx;
-		cpumask_copy(&q_vector->affinity_mask, cpu_possible_mask);
-		netif_napi_add_locked(adapter->netdev, &q_vector->napi,
-				      iavf_napi_poll);
+		netif_napi_add_config_locked(adapter->netdev, &q_vector->napi,
+					     iavf_napi_poll, q_idx);
+		netif_napi_set_irq_locked(&q_vector->napi, irq_num);
 	}
 
 	return 0;
@@ -5377,6 +5338,7 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_alloc_etherdev;
 	}
 
+	netif_set_affinity_auto(netdev);
 	SET_NETDEV_DEV(netdev, &pdev->dev);
 
 	pci_set_drvdata(pdev, netdev);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 422312b8b54a..23e786b9793d 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -1648,7 +1648,8 @@ int iavf_napi_poll(struct napi_struct *napi, int budget)
 		 * continue to poll, otherwise we must stop polling so the
 		 * interrupt can move to the correct cpu.
 		 */
-		if (!cpumask_test_cpu(cpu_id, &q_vector->affinity_mask)) {
+		if (!cpumask_test_cpu(cpu_id,
+				      &q_vector->napi.config->affinity_mask)) {
 			/* Tell napi that we are done polling */
 			napi_complete_done(napi, work_done);
 
-- 
2.47.1


