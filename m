Return-Path: <netdev+bounces-248601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CD5D0C40E
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 22:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B712A304420B
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 21:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA5B320A33;
	Fri,  9 Jan 2026 21:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RFperpKJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7006931ED73
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767992817; cv=none; b=C6Dqr2PHaFdcdwvwiwSOiKZYMcc3EQA3MUn3YGe1Ru3RvvnclovzRpN/Ef5EElUW+4/jHz8htYCiLxTN9ZvdKbYPCthaaNEpUEmpj2KMn3PUjNSNCdXnyRgZqNF70y4/jNwxRrLTGFZd+P49bjfHE8PigYirrxWrdTd/z5jbhHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767992817; c=relaxed/simple;
	bh=DQUPpliC5PRXALa6UUNiCz40ftWFxAWt9xaEG2hog00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XL7fYFppdBk2q5ZtwBzXiT4i5XnkczKHaAcc24C8AYEDg+8gwPmoNmycOaLe5yVqoNdWD74bGCK6liXyE37Coib3QAtipEYT5U6XalchzvqHesATEoxILP5Jt3bu/SStJuSKm7noFiLR8BTcb2GOsQq7Gh8+i1yfUgPzFFjfquk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RFperpKJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767992816; x=1799528816;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DQUPpliC5PRXALa6UUNiCz40ftWFxAWt9xaEG2hog00=;
  b=RFperpKJ2lI6P0OssAX65wVNOj3Dt6gXjnmVYmLWiykYbWY1eT4Ffbkc
   we6mL5yOG8u4pDD9dXZVKnvZ4Hg6i/5qd5dHGg0zlOM8X1ecCZ5Zeivsj
   m0EmLaNbah0hbko7nrbaAS+lQJoL1VwUoi7giNsfN2e0QnT6UoWdVGW+F
   lRes8ObGeuzdh5RsqC4o58JnJWQI4haIuIItpSQeaYs6wJCNruh4NuRhY
   t6dr5lIhjH0gThDITXXrOTtm11gQceKS3qB19pmLiAnAxhH+hu3VFidkB
   ANt9tQCPbmzYd/7M1Mfqt4dyYmQoZEL+fvgTDfpNrJ3P2rffFRwgr5Mmd
   Q==;
X-CSE-ConnectionGUID: H6hm9Pf9Svy3PvILEm9DLQ==
X-CSE-MsgGUID: bBBhmQoUSfKDvRrt0diCNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="73222060"
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="73222060"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 13:06:54 -0800
X-CSE-ConnectionGUID: Za6qN/hmQfyj8WvdlxpoSg==
X-CSE-MsgGUID: 0YBfrq1DStmduI8XAT0GFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="203571428"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 09 Jan 2026 13:06:54 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 3/5] ice: use netif_get_num_default_rss_queues()
Date: Fri,  9 Jan 2026 13:06:40 -0800
Message-ID: <20260109210647.3849008-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260109210647.3849008-1-anthony.l.nguyen@intel.com>
References: <20260109210647.3849008-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

On some high-core systems (like AMD EPYC Bergamo, Intel Clearwater
Forest) loading ice driver with default values can lead to queue/irq
exhaustion. It will result in no additional resources for SR-IOV.

In most cases there is no performance reason for more than half
num_cpus(). Limit the default value to it using generic
netif_get_num_default_rss_queues().

Still, using ethtool the number of queues can be changed up to
num_online_cpus(). It can be done by calling:
$ethtool -L ethX combined $(nproc)

This change affects only the default queue amount.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_irq.c |  5 +++--
 drivers/net/ethernet/intel/ice/ice_lib.c | 12 ++++++++----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_irq.c b/drivers/net/ethernet/intel/ice/ice_irq.c
index 30801fd375f0..1d9b2d646474 100644
--- a/drivers/net/ethernet/intel/ice/ice_irq.c
+++ b/drivers/net/ethernet/intel/ice/ice_irq.c
@@ -106,9 +106,10 @@ static struct ice_irq_entry *ice_get_irq_res(struct ice_pf *pf,
 #define ICE_RDMA_AEQ_MSIX 1
 static int ice_get_default_msix_amount(struct ice_pf *pf)
 {
-	return ICE_MIN_LAN_OICR_MSIX + num_online_cpus() +
+	return ICE_MIN_LAN_OICR_MSIX + netif_get_num_default_rss_queues() +
 	       (test_bit(ICE_FLAG_FD_ENA, pf->flags) ? ICE_FDIR_MSIX : 0) +
-	       (ice_is_rdma_ena(pf) ? num_online_cpus() + ICE_RDMA_AEQ_MSIX : 0);
+	       (ice_is_rdma_ena(pf) ? netif_get_num_default_rss_queues() +
+				      ICE_RDMA_AEQ_MSIX : 0);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 15621707fbf8..44f3c2bab308 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -159,12 +159,14 @@ static void ice_vsi_set_num_desc(struct ice_vsi *vsi)
 
 static u16 ice_get_rxq_count(struct ice_pf *pf)
 {
-	return min(ice_get_avail_rxq_count(pf), num_online_cpus());
+	return min(ice_get_avail_rxq_count(pf),
+		   netif_get_num_default_rss_queues());
 }
 
 static u16 ice_get_txq_count(struct ice_pf *pf)
 {
-	return min(ice_get_avail_txq_count(pf), num_online_cpus());
+	return min(ice_get_avail_txq_count(pf),
+		   netif_get_num_default_rss_queues());
 }
 
 /**
@@ -907,13 +909,15 @@ static void ice_vsi_set_rss_params(struct ice_vsi *vsi)
 		if (vsi->type == ICE_VSI_CHNL)
 			vsi->rss_size = min_t(u16, vsi->num_rxq, max_rss_size);
 		else
-			vsi->rss_size = min_t(u16, num_online_cpus(),
+			vsi->rss_size = min_t(u16,
+					      netif_get_num_default_rss_queues(),
 					      max_rss_size);
 		vsi->rss_lut_type = ICE_LUT_PF;
 		break;
 	case ICE_VSI_SF:
 		vsi->rss_table_size = ICE_LUT_VSI_SIZE;
-		vsi->rss_size = min_t(u16, num_online_cpus(), max_rss_size);
+		vsi->rss_size = min_t(u16, netif_get_num_default_rss_queues(),
+				      max_rss_size);
 		vsi->rss_lut_type = ICE_LUT_VSI;
 		break;
 	case ICE_VSI_VF:
-- 
2.47.1


