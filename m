Return-Path: <netdev+bounces-184739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AA5A97126
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 17:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 580533A47C3
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9559C28A3E0;
	Tue, 22 Apr 2025 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h572z2N3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9321F150B
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336249; cv=none; b=eJPaXYDWVmWkKoqm+CKYNPmCVG2V2zc1XKviadQoCgkPpEip7+aAcKhSnDGVikLTejCGGhvfvgL0a6baa5ULOvFi3Xy9eVhXLdHjW2RWtaGapARzsbOX1+RUpd3tr63EX57m/tSAht6g0IwlQg2sPLRj0ikMazHuRso9LmK1K9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336249; c=relaxed/simple;
	bh=jEuc8oG1zoj+1FvFFD0JTEeZGZF00r/3x6Ok+rnihfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QSIN245J63/2GG96VHV0zHCvaK6Jrk+2LZvG9gw7TpAp2yVwbMiwZwJ3v3RMrQ79H01Falc/52zEdDyc/AfreuETP9oWJtT9tXNxfFI4j0Dmei/7LCUIyr+ZM+txny9MR9hZPCJ4IdmIDP17IYL24Jr5vMFrvF59P1Cdy6tZjKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h572z2N3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745336248; x=1776872248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jEuc8oG1zoj+1FvFFD0JTEeZGZF00r/3x6Ok+rnihfY=;
  b=h572z2N3tr1B8Mzfag2sf7licaxHn9BPq7vAQngGjqleAChVljm34its
   BRq+2mmyzaQLCQfcAkGci9KTnP/GzUmA9uLekd5UN61I2wqPwLV9MwQYo
   xs4xUNZMKliMdskYGqwMweUzHm/l+sR1XkrSlRoRKCbI9iKuVG/ma3DyI
   6LYxVBFnGvU2bYTf9o9kdz2pldDXBlRVaOWgn9teeiHHISZD1UXwwGQtJ
   D8d8x+h8AsxIFQGz8tmjzktePBWuOT1JZ0U90FZRveJ0qKpyAbsF+EoB5
   45Ib3VwV7emJb3F5uRu0ouxUe+CMLh8pJNzFrvkhvYzqc8nAWSVkg8X5B
   g==;
X-CSE-ConnectionGUID: LsKdG7NyR6KUhpIaRGBSBw==
X-CSE-MsgGUID: oNa+DJs0TLa/VNu7YR01iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="64312349"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="64312349"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 08:37:21 -0700
X-CSE-ConnectionGUID: k8ICJBLaQiS+uxaTrM2UkA==
X-CSE-MsgGUID: 2yCqT0hoSsain78tEwRHWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="131947828"
Received: from gk3153-pr4-x299-22869.igk.intel.com (HELO localhost.igk.intel.com) ([10.102.21.130])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 08:37:18 -0700
From: Michal Kubiak <michal.kubiak@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: maciej.fijalkowski@intel.com,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	jacob.e.keller@intel.com,
	netdev@vger.kernel.org,
	Michal Kubiak <michal.kubiak@intel.com>
Subject: [PATCH iwl-net 2/3] ice: create new Tx scheduler nodes for new queues only
Date: Tue, 22 Apr 2025 17:36:58 +0200
Message-Id: <20250422153659.284868-3-michal.kubiak@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20250422153659.284868-1-michal.kubiak@intel.com>
References: <20250422153659.284868-1-michal.kubiak@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of the Tx scheduler tree attempts
to create nodes for all Tx queues, ignoring the fact that some
queues may already exist in the tree. For example, if the VSI
already has 128 Tx queues and the user requests for 16 new queues,
the Tx scheduler will compute the tree for 272 queues (128 existing
queues + 144 new queues), instead of 144 queues (128 existing queues
and 16 new queues).
Fix that by modifying the node count calculation algorithm to skip
the queues that already exist in the tree.

Fixes: 5513b920a4f7 ("ice: Update Tx scheduler tree for VSI multi-Tx queue support")
Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sched.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index 6ca13c5dcb14..6524875b34d3 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -1604,16 +1604,16 @@ ice_sched_get_agg_node(struct ice_port_info *pi, struct ice_sched_node *tc_node,
 /**
  * ice_sched_calc_vsi_child_nodes - calculate number of VSI child nodes
  * @hw: pointer to the HW struct
- * @num_qs: number of queues
+ * @num_new_qs: number of new queues that will be added to the tree
  * @num_nodes: num nodes array
  *
  * This function calculates the number of VSI child nodes based on the
  * number of queues.
  */
 static void
-ice_sched_calc_vsi_child_nodes(struct ice_hw *hw, u16 num_qs, u16 *num_nodes)
+ice_sched_calc_vsi_child_nodes(struct ice_hw *hw, u16 num_new_qs, u16 *num_nodes)
 {
-	u16 num = num_qs;
+	u16 num = num_new_qs;
 	u8 i, qgl, vsil;
 
 	qgl = ice_sched_get_qgrp_layer(hw);
@@ -1863,8 +1863,9 @@ ice_sched_update_vsi_child_nodes(struct ice_port_info *pi, u16 vsi_handle,
 			return status;
 	}
 
-	if (new_numqs)
-		ice_sched_calc_vsi_child_nodes(hw, new_numqs, new_num_nodes);
+	ice_sched_calc_vsi_child_nodes(hw, new_numqs - prev_numqs,
+				       new_num_nodes);
+
 	/* Keep the max number of queue configuration all the time. Update the
 	 * tree only if number of queues > previous number of queues. This may
 	 * leave some extra nodes in the tree if number of queues < previous
-- 
2.45.2


