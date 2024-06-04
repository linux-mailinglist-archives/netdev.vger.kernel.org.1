Return-Path: <netdev+bounces-100572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E73E8FB38D
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53875287066
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 13:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3656146A72;
	Tue,  4 Jun 2024 13:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SA+qzLeC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464561474B8
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 13:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507342; cv=none; b=W7ReS+99kwwPqDS1huXoMr0uvOj8tg6phsbC7JfMHEZEIZ0HOd/sTYXMWhPmwQGdZRsXPlDFJrtCpWbXJUANYtYjliFcrFcHJgGG1hxN4vYsjUu5Pj71SryHQcIsJ+qv4BGmdvHM52h5CPG5jGVXSKbs38WfaPAAq8DrUM0v57U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507342; c=relaxed/simple;
	bh=vzNZnalUYBWq8TrGQh3xj3VWHF0JpnuUhGSw5Arc3dI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QDNWnJ6mTWTuZJ/Znh7jHkG4S7ZgGq3SE+RTpF0AZckfdtS1wrDhXH+6JOgfhcTibUk+mlmG3b+4CldSnaPrcsl0d1QBqIel7LI7sJBL89Q+BUeEqYYHoaQ6w550xTNoYOwbfBZiWeecS04f7TWepOfjbfgnaJE4q45clin+ajk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SA+qzLeC; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717507341; x=1749043341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vzNZnalUYBWq8TrGQh3xj3VWHF0JpnuUhGSw5Arc3dI=;
  b=SA+qzLeCpnqH4OOIJAXPtHf2nmnFeZrH01cYBystEObGHZjEVwswDhto
   Bkrc8+0Dye3G+vwuTyJ6JK7DMwsJLKsaawVbBeYWslwxViuv6AHpjMpdP
   34yN0zBaXgJNGv8+PTx0/oFNmc7TYdNB6ps6skhimB9WbjOWFrL4fLBY7
   ofzUj5+MjxPqfmrnhMy0lP+stug2OiNc2xuFScABGVPYT2Oxn2JG+dv2/
   nxRkazfy/MOCFe4q5azlFkhcyOAvartGjY2YmqYV9XY+MnBHbo8NfphxQ
   jO9oU0g3D4pWumW/NrvsZEUwVqqvJRw7J7MxyOrN3iGGKa5Z7lCuKUqlh
   w==;
X-CSE-ConnectionGUID: SeOQsuOOTSCWHCIkOv+oYw==
X-CSE-MsgGUID: Sr/VY0TWQVStsAen7/BG1A==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="31552896"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="31552896"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 06:22:21 -0700
X-CSE-ConnectionGUID: MOz+HNHjSTCpAR3wL+bfVg==
X-CSE-MsgGUID: +LFN7VwcTjOQkjoBUAX4Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37350186"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa009.fm.intel.com with ESMTP; 04 Jun 2024 06:22:19 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	michal.kubiak@intel.com,
	larysa.zaremba@intel.com,
	jacob.e.keller@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH v3 iwl-net 5/8] ice: toggle netif_carrier when setting up XSK pool
Date: Tue,  4 Jun 2024 15:21:52 +0200
Message-Id: <20240604132155.3573752-6-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240604132155.3573752-1-maciej.fijalkowski@intel.com>
References: <20240604132155.3573752-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This so we prevent Tx timeout issues. One of conditions checked on
running in the background dev_watchdog() is netif_carrier_ok(), so let
us turn it off when we disable the queues that belong to a q_vector
where XSK pool is being configured.

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 8ca7ff1a7e7f..21df6888961b 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -180,6 +180,7 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 	}
 
 	synchronize_net();
+	netif_carrier_off(vsi->netdev);
 	netif_tx_stop_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
 
 	ice_qvec_dis_irq(vsi, rx_ring, q_vector);
@@ -249,6 +250,7 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 	ice_qvec_ena_irq(vsi, q_vector);
 
 	netif_tx_start_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
+	netif_carrier_on(vsi->netdev);
 	clear_bit(ICE_CFG_BUSY, vsi->state);
 
 	return fail;
-- 
2.34.1


