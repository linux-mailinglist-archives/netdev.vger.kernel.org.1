Return-Path: <netdev+bounces-156891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2AAA08388
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 00:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236BA168ECA
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 23:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE71205AD2;
	Thu,  9 Jan 2025 23:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XIzZyk/t"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0849F205AB4
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 23:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736465506; cv=none; b=tYK9LTF4NT58rwVqpWdrk44pv/eBETmR8OV5YMipJwbt5BZ52gNDl2BgHbsm+tqWESVp/QsPLlqa7zmubQ4X8QKm+sK6OjEbpVv5p+7k2bgppK8d01dI7xRgRJYPhWWoJfnrzgF4gd1xG2qdHdktAX5Z90k9RMZC5hR1emqd3Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736465506; c=relaxed/simple;
	bh=vEuEUak2e4V2UO9LeYnRYWF+ndykJaoTYWBSZuFDtRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VkQ3cMEGRaeQkRUogT/MYjHkHdlHGD9+y7O9G8kRZBFKqG6B1KO63mmKKbf0mPJMEfVSjhm5AXOaPT7FI+29LB/vKNaHC+qFbw8oLy1ABjtE/LA7tFwNn8/TZq9bKLgPMErPthTDh5OdnPkka7BYu36AZwj9y0xXKhTo/awK3Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XIzZyk/t; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736465505; x=1768001505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vEuEUak2e4V2UO9LeYnRYWF+ndykJaoTYWBSZuFDtRg=;
  b=XIzZyk/teX/fzpjxmTJTRHjOmVqvciRYhVQ/7/rb0TOUwRgfWxQGy1xS
   qXC6krC2HfuPXt1ixKXW2m+xZ6FdEJlJzH8IPGKEpCWjhXrAhaRK19vtT
   t8yPPyCdTp+JuDdPgzZ2kzHu8gVwnBls86fiHFrwpW2xpp6EyD8O/tvah
   qdtIs/gYWf7kmcREepR4VP6QM77+fa6JulH+wkjc0moeN6zGawnuQUydS
   irsIL2NY17ERdg58dDl5DirMgW8DE1VRI1QNXcDmSRDhyMdTGKdQANvKR
   cOXwlPEKndJFcJc7Ra+V6uUoIhXG6n7x/wW4c5bpB9/T43qA65lNqI3x7
   g==;
X-CSE-ConnectionGUID: OBMvZkwbTFOC7uy6CJADZQ==
X-CSE-MsgGUID: 1ic59y3iQduRkN8l9+B6Tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="47245170"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="47245170"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 15:31:45 -0800
X-CSE-ConnectionGUID: o7876VvNQGKCi3ms1OIo5w==
X-CSE-MsgGUID: 7tuMLtvWQzuyPCG3VclbUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="134399083"
Received: from kinlongk-mobl1.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.111.128])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 15:31:39 -0800
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
Subject: [PATCH net-next v4 4/6] bnxt: use napi's irq affinity
Date: Thu,  9 Jan 2025 16:31:05 -0700
Message-ID: <20250109233107.17519-5-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250109233107.17519-1-ahmed.zaki@intel.com>
References: <20250109233107.17519-1-ahmed.zaki@intel.com>
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
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 25 +++--------------------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  2 --
 2 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index cc3ca3440b0a..b11bd9d31e91 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11193,14 +11193,8 @@ static void bnxt_free_irq(struct bnxt *bp)
 		int map_idx = bnxt_cp_num_to_irq_num(bp, i);
 
 		irq = &bp->irq_tbl[map_idx];
-		if (irq->requested) {
-			if (irq->have_cpumask) {
-				irq_update_affinity_hint(irq->vector, NULL);
-				free_cpumask_var(irq->cpu_mask);
-				irq->have_cpumask = 0;
-			}
+		if (irq->requested)
 			free_irq(irq->vector, bp->bnapi[i]);
-		}
 
 		irq->requested = 0;
 	}
@@ -11229,21 +11223,6 @@ static int bnxt_request_irq(struct bnxt *bp)
 
 		netif_napi_set_irq(&bp->bnapi[i]->napi, irq->vector);
 		irq->requested = 1;
-
-		if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
-			int numa_node = dev_to_node(&bp->pdev->dev);
-
-			irq->have_cpumask = 1;
-			cpumask_set_cpu(cpumask_local_spread(i, numa_node),
-					irq->cpu_mask);
-			rc = irq_update_affinity_hint(irq->vector, irq->cpu_mask);
-			if (rc) {
-				netdev_warn(bp->dev,
-					    "Update affinity hint failed, IRQ = %d\n",
-					    irq->vector);
-				break;
-			}
-		}
 	}
 	return rc;
 }
@@ -16172,6 +16151,8 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 			    NETDEV_XDP_ACT_RX_SG;
 
+	netif_enable_irq_affinity(dev);
+
 #ifdef CONFIG_BNXT_SRIOV
 	init_waitqueue_head(&bp->sriov_cfg_wait);
 #endif
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 094c9e95b463..7be2f90d0c05 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1228,9 +1228,7 @@ struct bnxt_irq {
 	irq_handler_t	handler;
 	unsigned int	vector;
 	u8		requested:1;
-	u8		have_cpumask:1;
 	char		name[IFNAMSIZ + BNXT_IRQ_NAME_EXTRA];
-	cpumask_var_t	cpu_mask;
 };
 
 #define HWRM_RING_ALLOC_TX	0x1
-- 
2.43.0


