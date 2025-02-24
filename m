Return-Path: <netdev+bounces-169237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD93A430C2
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 00:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E48C3BACFC
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 23:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA5B20CCCD;
	Mon, 24 Feb 2025 23:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eUs4RxNy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F8A20C488
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 23:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439374; cv=none; b=uI3XBoJVdGqis+5gMxatAsOVImnCGoKbGuDfQQR+TPop6cKYUPPREpdD1LO5dncnqh+Md87Dje06ARX9Z3tYGs65VYCPjtqLAnFzS6+N2HqC/Y0NDf8VZbzEzYJFHXZb+NSybGWB9sDgJEsbks3km8PPddmDFhqNEv2w5qpqWLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439374; c=relaxed/simple;
	bh=W3fPwahZBmhefKb6ZWdykoKfhNI+QJZyOsBRqs7FwmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UT0q6K7VTOPSzNgZfCpadK5svjr178IC0YAlkzWDgSRPtRr8jIp7KaBKrkWhOKFbyhA+eSlcouLEsTE11jEbwD+M2KABiitQCzC2bxa4YrJ6iyIwILTk2vFR5wYZbAPT+MefUtQgVCa7AfpeuG7J5Bz7ndm7RMwxhfjz++TFCXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eUs4RxNy; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740439373; x=1771975373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W3fPwahZBmhefKb6ZWdykoKfhNI+QJZyOsBRqs7FwmM=;
  b=eUs4RxNyohSBIgpTVD486aiSygZnPyZrHRad/vmXzWl+Zh7CHVwShDwH
   WEOKdtEAaP7iDJ4dP8Y+1B1OAa4TQnm1+Nw7DbogWeHMLwApkUi+loFq0
   0i1gT7hysAHs8XSCxvNjFtRdWohHo2bm1GE9sBE7WB0cTs4g/vRveiQmq
   yN+Bf4+7i5XlYBloaAGV7/b8V/qxPht047hr7+fnXDMNZ010aA+W2uLL1
   2kQzQI9mFHD+JHcG7avfImD+HbZPzzJaCVwciW/0Et5cN9nrUh47ZCLgX
   KbIXnZhs8O6xBJfnnayrLOw80VNXbxUv39Gf8qRcOITHez0wEzVGJHqdn
   g==;
X-CSE-ConnectionGUID: ytO0LHS6QRuouPeLNO8xYQ==
X-CSE-MsgGUID: XnGkchDBSleiJHbOAuCh5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="40406641"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="40406641"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 15:22:53 -0800
X-CSE-ConnectionGUID: Q1o1dBEaTsGcFBKM0zzBjQ==
X-CSE-MsgGUID: oqbw88BhRnySdvNnFULF6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="115997787"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.245.244.43])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 15:22:46 -0800
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
	Ahmed Zaki <ahmed.zaki@intel.com>,
	David Arinzon <darinzon@amazon.com>
Subject: [PATCH net-next v9 2/6] net: ena: use napi's aRFS rmap notifers
Date: Mon, 24 Feb 2025 16:22:23 -0700
Message-ID: <20250224232228.990783-3-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224232228.990783-1-ahmed.zaki@intel.com>
References: <20250224232228.990783-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the core's rmap notifiers and delete our own.

Acked-by: David Arinzon <darinzon@amazon.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 43 +-------------------
 1 file changed, 1 insertion(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index c1295dfad0d0..6aab85a7c60a 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -5,9 +5,6 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#ifdef CONFIG_RFS_ACCEL
-#include <linux/cpu_rmap.h>
-#endif /* CONFIG_RFS_ACCEL */
 #include <linux/ethtool.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -162,30 +159,6 @@ int ena_xmit_common(struct ena_adapter *adapter,
 	return 0;
 }
 
-static int ena_init_rx_cpu_rmap(struct ena_adapter *adapter)
-{
-#ifdef CONFIG_RFS_ACCEL
-	u32 i;
-	int rc;
-
-	adapter->netdev->rx_cpu_rmap = alloc_irq_cpu_rmap(adapter->num_io_queues);
-	if (!adapter->netdev->rx_cpu_rmap)
-		return -ENOMEM;
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
-#endif /* CONFIG_RFS_ACCEL */
-	return 0;
-}
-
 static void ena_init_io_rings_common(struct ena_adapter *adapter,
 				     struct ena_ring *ring, u16 qid)
 {
@@ -1596,7 +1569,7 @@ static int ena_enable_msix(struct ena_adapter *adapter)
 		adapter->num_io_queues = irq_cnt - ENA_ADMIN_MSIX_VEC;
 	}
 
-	if (ena_init_rx_cpu_rmap(adapter))
+	if (netif_enable_cpu_rmap(adapter->netdev, adapter->num_io_queues))
 		netif_warn(adapter, probe, adapter->netdev,
 			   "Failed to map IRQs to CPUs\n");
 
@@ -1742,13 +1715,6 @@ static void ena_free_io_irq(struct ena_adapter *adapter)
 	struct ena_irq *irq;
 	int i;
 
-#ifdef CONFIG_RFS_ACCEL
-	if (adapter->msix_vecs >= 1) {
-		free_irq_cpu_rmap(adapter->netdev->rx_cpu_rmap);
-		adapter->netdev->rx_cpu_rmap = NULL;
-	}
-#endif /* CONFIG_RFS_ACCEL */
-
 	for (i = ENA_IO_IRQ_FIRST_IDX; i < ENA_MAX_MSIX_VEC(io_queue_count); i++) {
 		irq = &adapter->irq_tbl[i];
 		irq_set_affinity_hint(irq->vector, NULL);
@@ -4131,13 +4097,6 @@ static void __ena_shutoff(struct pci_dev *pdev, bool shutdown)
 	ena_dev = adapter->ena_dev;
 	netdev = adapter->netdev;
 
-#ifdef CONFIG_RFS_ACCEL
-	if ((adapter->msix_vecs >= 1) && (netdev->rx_cpu_rmap)) {
-		free_irq_cpu_rmap(netdev->rx_cpu_rmap);
-		netdev->rx_cpu_rmap = NULL;
-	}
-
-#endif /* CONFIG_RFS_ACCEL */
 	/* Make sure timer and reset routine won't be called after
 	 * freeing device resources.
 	 */
-- 
2.43.0


