Return-Path: <netdev+bounces-233443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6685EC135AA
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 08:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD4B5E2B99
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 07:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B58E221F20;
	Tue, 28 Oct 2025 07:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLFyB+kF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2DE7494
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 07:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761637163; cv=none; b=Nl8dp26E/kDcpN6nO6vszzXWwQqe7+yduRWQYG8IIPn74VU01fGX0vmFr8tR9Y8tmyR/77XwVvqYP3dUuNoahD+xublFH9YXhQd3x8yovgB7hZkaLFjCI5qCLnwPFLwIaHS5a43zAmGWP5K9XOM2vQfQUxXvzS4EAqaJUsgGiOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761637163; c=relaxed/simple;
	bh=UjeRE3qXwZy7hxTb+9+ah7JknOmhwGh2ga0aK+Okz4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BHx32rUYJhv5xKoVLAZQfHoH+zi8+WQ9D67mLD9zxrBaFgbwUTQTdxCUHfnFAJ8fpg7xh3VS/xKUYLssSfBIQh6acGDPynDXkQ/jnJAGSLXbfh2EAznYnQNi+4jKfBpo7iQ7SFyyTt/MgXlRWm6sXxdazdAIW06x4CA/7TNn3OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLFyB+kF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761637161; x=1793173161;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UjeRE3qXwZy7hxTb+9+ah7JknOmhwGh2ga0aK+Okz4o=;
  b=JLFyB+kFloC9Avq1vGZxHZ/xIYhfZiG12EDJ6zoH1H6ucm7xMAgbR40I
   4DhW0ZmUnWFUQtfl2SXBcdMpiBuNucmJZ/9G0Z+BWlM2J561i0jOZ0xP2
   gsNKTfAnrUG54iot1Vx19e7NfjtsJGcwaK3CtcNX01lIFpKNk2cbOhPbC
   WS+BxtpLoQkWYkdd2R7ynPAJLiBRqO7bME/FpnX328hNDN13tNUkaXchw
   CJv5FOuVM7nXAWGvBqoIpRBVYD/7+Zo8/RbcVi9T4PEL5R1hCpzVSYNG5
   a+UbIMWTuyKY6JUoMIrA30d42hf93ByVtH+YQLO7gpfXd2tjjtqnaBbww
   Q==;
X-CSE-ConnectionGUID: 7PdF2zfJRjmKIUje3z66kA==
X-CSE-MsgGUID: XAHa99g+TEmUd5agPKIOEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="75174225"
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="75174225"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 00:39:21 -0700
X-CSE-ConnectionGUID: Jb/ny1/iRRK2VB41FAA5DA==
X-CSE-MsgGUID: 12JVztAaRyCIq/i79Fp5vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="185358734"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by orviesa008.jf.intel.com with ESMTP; 28 Oct 2025 00:39:17 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	pmenzel@molgen.mpg.de,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v2] ice: use netif_get_num_default_rss_queues()
Date: Tue, 28 Oct 2025 08:06:34 +0100
Message-ID: <20251028070634.2124215-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some high-core systems (like AMD EPYC Bergamo, Intel Clearwater
Forest) loading ice driver with default values can lead to queue/irq
exhaustion. It will result in no additional resources for SR-IOV.

In most cases there is no performance reason for more than half
num_cpus(). Limit the default value to it using generic
netif_get_num_default_rss_queues().

Still, using ethtool the number of queues can be changed up to
num_online_cpus(). It can be done by calling:
$ethtool -L ethX combined max_cpu

This change affects only the default queue amount.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
v1 --> v2:
 * Follow Olek's comment and switch from custom limiting to the generic
   netif_...() function.
 * Add more info in commit message (Paul)
 * Dropping RB tags, as it is different patch now
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
index bac481e8140d..e366d089bef9 100644
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
2.49.0


