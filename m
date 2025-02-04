Return-Path: <netdev+bounces-162774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C355A27E07
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 23:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29C3166EA6
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 22:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC9F217651;
	Tue,  4 Feb 2025 22:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sn5dzO0s"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17AA21A952
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 22:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738706823; cv=none; b=UWyaSwhKGjuZfNWl2kaHbIGkftx8dPDttgpkKKPfB/LIPgSu79xKN27l/XoKN7v9HQvj1mTYUnAA87OK/0y6SdrqNO5Yte8TiU7/cNhzf3p7KMTdjwbc2nmgtgOX0//DHiYjKMg4pHshB+yTi/tUDRCqJTkc4KR3CT0lYckykLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738706823; c=relaxed/simple;
	bh=dVk1dkQPn8T6bURcbvzmAl7vond6yg8EY9MAmGeLpNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oCJfa3MjNO+B7Y3i/gAqckMf+jzGoE7dJTcQmtXkUW0z3zVkcr0FSACwqa3frLTP6EMCrKz+E+9vonbGKuZwUjZSGnTIp5CSlvqDpJbll4Mo7VQjAiy3cUI7FUi3Ag4QBciBUwYOpu2aeMZT8O3CUh5u/5P2M1A2tGpwWhHaGrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sn5dzO0s; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738706822; x=1770242822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dVk1dkQPn8T6bURcbvzmAl7vond6yg8EY9MAmGeLpNs=;
  b=Sn5dzO0sluqTMv+tE+eXfc6rA6NRpPap/gMLON9jpSGRsvxly/ZJr5mE
   V7XptmCUm9lVyv8hdSYC5aJx8aSifeXv5zcmM3d4dRj9OCvOJFVK2IQqI
   9hcgLggQpIhCBuavbUwxUQ/HeVYPD2BpWgIsk0tVBUUhQUjMXKwN9arcl
   uaNNR4jwbRKLnadQ7Mx5ZWBBm3/g1jmn3CNFeO3NvBAJe1wZ10ZyXqu6o
   FdGpGoLF05w0+qSntbtmoWq85C/DL+41fuTreOphU8hR13SsYCpksjk3V
   wqGBne4N2IZtYYBkG/vCNyXwvG57iWVi7u2rwp8ywVSicmFTc6CDnvdXL
   w==;
X-CSE-ConnectionGUID: v9VxWtorR3eXfR75ZZAfcg==
X-CSE-MsgGUID: slywF6dTQfeju/FtkpU5gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43003440"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="43003440"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 14:07:01 -0800
X-CSE-ConnectionGUID: nPvFSIU5QhC+yhPRtXiuBw==
X-CSE-MsgGUID: RNn26uqAShi1bwinIB/8mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114771313"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.110.39])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 14:06:55 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	michael.chan@broadcom.com,
	tariqt@nvidia.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jdamato@fastly.com,
	shayd@nvidia.com,
	akpm@linux-foundation.org,
	shayagr@amazon.com,
	kalesh-anakkur.purayil@broadcom.com,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next v7 4/5] ice: use napi's irq affinity
Date: Tue,  4 Feb 2025 15:06:21 -0700
Message-ID: <20250204220622.156061-5-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250204220622.156061-1-ahmed.zaki@intel.com>
References: <20250204220622.156061-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delete the driver CPU affinity info and use the core's napi config
instead.

Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      |  3 --
 drivers/net/ethernet/intel/ice/ice_base.c |  7 +---
 drivers/net/ethernet/intel/ice/ice_lib.c  |  6 ---
 drivers/net/ethernet/intel/ice/ice_main.c | 47 ++---------------------
 4 files changed, 5 insertions(+), 58 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 71e05d30f0fd..a6e6c9e1edc1 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -478,9 +478,6 @@ struct ice_q_vector {
 	struct ice_ring_container rx;
 	struct ice_ring_container tx;
 
-	cpumask_t affinity_mask;
-	struct irq_affinity_notify affinity_notify;
-
 	struct ice_channel *ch;
 
 	char name[ICE_INT_NAME_STR_LEN];
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index b2af8e3586f7..86cf715de00f 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -147,10 +147,6 @@ static int ice_vsi_alloc_q_vector(struct ice_vsi *vsi, u16 v_idx)
 	q_vector->reg_idx = q_vector->irq.index;
 	q_vector->vf_reg_idx = q_vector->irq.index;
 
-	/* only set affinity_mask if the CPU is online */
-	if (cpu_online(v_idx))
-		cpumask_set_cpu(v_idx, &q_vector->affinity_mask);
-
 	/* This will not be called in the driver load path because the netdev
 	 * will not be created yet. All other cases with register the NAPI
 	 * handler here (i.e. resume, reset/rebuild, etc.)
@@ -276,7 +272,8 @@ static void ice_cfg_xps_tx_ring(struct ice_tx_ring *ring)
 	if (test_and_set_bit(ICE_TX_XPS_INIT_DONE, ring->xps_state))
 		return;
 
-	netif_set_xps_queue(ring->netdev, &ring->q_vector->affinity_mask,
+	netif_set_xps_queue(ring->netdev,
+			    &ring->q_vector->napi.config->affinity_mask,
 			    ring->q_index);
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 38a1c8372180..31fb09e30683 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2595,12 +2595,6 @@ void ice_vsi_free_irq(struct ice_vsi *vsi)
 		      vsi->q_vectors[i]->num_ring_rx))
 			continue;
 
-		/* clear the affinity notifier in the IRQ descriptor */
-		if (!IS_ENABLED(CONFIG_RFS_ACCEL))
-			irq_set_affinity_notifier(irq_num, NULL);
-
-		/* clear the affinity_hint in the IRQ descriptor */
-		irq_update_affinity_hint(irq_num, NULL);
 		synchronize_irq(irq_num);
 		devm_free_irq(ice_pf_to_dev(pf), irq_num, vsi->q_vectors[i]);
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c3a0fb97c5ee..a348a37d5ba3 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2527,34 +2527,6 @@ int ice_schedule_reset(struct ice_pf *pf, enum ice_reset_req reset)
 	return 0;
 }
 
-/**
- * ice_irq_affinity_notify - Callback for affinity changes
- * @notify: context as to what irq was changed
- * @mask: the new affinity mask
- *
- * This is a callback function used by the irq_set_affinity_notifier function
- * so that we may register to receive changes to the irq affinity masks.
- */
-static void
-ice_irq_affinity_notify(struct irq_affinity_notify *notify,
-			const cpumask_t *mask)
-{
-	struct ice_q_vector *q_vector =
-		container_of(notify, struct ice_q_vector, affinity_notify);
-
-	cpumask_copy(&q_vector->affinity_mask, mask);
-}
-
-/**
- * ice_irq_affinity_release - Callback for affinity notifier release
- * @ref: internal core kernel usage
- *
- * This is a callback function used by the irq_set_affinity_notifier function
- * to inform the current notification subscriber that they will no longer
- * receive notifications.
- */
-static void ice_irq_affinity_release(struct kref __always_unused *ref) {}
-
 /**
  * ice_vsi_ena_irq - Enable IRQ for the given VSI
  * @vsi: the VSI being configured
@@ -2618,19 +2590,6 @@ static int ice_vsi_req_irq_msix(struct ice_vsi *vsi, char *basename)
 				   err);
 			goto free_q_irqs;
 		}
-
-		/* register for affinity change notifications */
-		if (!IS_ENABLED(CONFIG_RFS_ACCEL)) {
-			struct irq_affinity_notify *affinity_notify;
-
-			affinity_notify = &q_vector->affinity_notify;
-			affinity_notify->notify = ice_irq_affinity_notify;
-			affinity_notify->release = ice_irq_affinity_release;
-			irq_set_affinity_notifier(irq_num, affinity_notify);
-		}
-
-		/* assign the mask for this irq */
-		irq_update_affinity_hint(irq_num, &q_vector->affinity_mask);
 	}
 
 	err = ice_set_cpu_rx_rmap(vsi);
@@ -2646,9 +2605,6 @@ static int ice_vsi_req_irq_msix(struct ice_vsi *vsi, char *basename)
 free_q_irqs:
 	while (vector--) {
 		irq_num = vsi->q_vectors[vector]->irq.virq;
-		if (!IS_ENABLED(CONFIG_RFS_ACCEL))
-			irq_set_affinity_notifier(irq_num, NULL);
-		irq_update_affinity_hint(irq_num, NULL);
 		devm_free_irq(dev, irq_num, &vsi->q_vectors[vector]);
 	}
 	return err;
@@ -3689,6 +3645,9 @@ void ice_set_netdev_features(struct net_device *netdev)
 	 */
 	netdev->hw_features |= NETIF_F_RXFCS;
 
+	/* Allow core to manage IRQs affinity */
+	netif_enable_irq_affinity(netdev);
+
 	netif_set_tso_max_size(netdev, ICE_MAX_TSO_SIZE);
 }
 
-- 
2.43.0


