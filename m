Return-Path: <netdev+bounces-113836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 977D5940114
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 00:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443541F23097
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 22:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3478F18F2D7;
	Mon, 29 Jul 2024 22:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EQYDQqq9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B3F18EFD7
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722292484; cv=none; b=A/fnn9S0BdZ2G3l7Ss4PQ2FcnNeH1sbw3s+7yycx8pRvuxUCVwOwxZUyqlUSMZhxvx5BRFnCzgFjlZTqRonHjPIY+BJ9hvrIf/iD/iYI4NMEFwXtDEfYpIg7WSQ4x+0exdlQiw3XNr2x2beKBJHgHt9PpVDEsthjivgiGSjMuxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722292484; c=relaxed/simple;
	bh=yQuPQvJS1fQs3zzuzRlxQdih2XQKm6jjjrde7c7EA6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENm91emp5LbGO8OAGkO7cIgmEGAW5erlZokmgCppAW97X66wK8F869arJ1YYwC3qxdNoRo7UmmxzLbyJjcZfVfBSm8Fnrc+dDhxlUAiivfc43XTKgXGNGl1/24DAWUR0gLWbcY7Mg7/BuaIf7Wpwi2a9DvANGwwmdf+8iH3s8jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EQYDQqq9; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722292482; x=1753828482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yQuPQvJS1fQs3zzuzRlxQdih2XQKm6jjjrde7c7EA6E=;
  b=EQYDQqq9K9cchztqhqbLIbK3MEXjSAzlAry8BvmMrfz1odlLXQSbAQ81
   zYubBqwd7/YK1CzBYSEgTrsOIKd9lZWbhYkmASB2cMHrjM48gP0suRsxk
   CsruOMd2Z3gpbLlr2QREVRxBuu22YYrJZWmCPtx59a3SpJ8etJ7LVFNH/
   847L86NLucic3r1ptZxDxdcs1oCtG5O9OCNW5Yg/sXGKE+c70u/A3U84O
   69eLEXj8I2OxA0jaBtpwmbMKpWRS2g4xiBRgLJiP18b88LRwtx5E+ccGr
   ct6WLzgC9JVuPysDxduV7w+gNYfSJCwPa6fkxgcBvFPIMlnixjaSSajM3
   A==;
X-CSE-ConnectionGUID: 11ibkerZTgqaDNR8e9DFxQ==
X-CSE-MsgGUID: sMp5LabsRIuSmcIfv2vJgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="20216794"
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="20216794"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 15:34:40 -0700
X-CSE-ConnectionGUID: L0XALFPvTpiCykOjI0f3cg==
X-CSE-MsgGUID: e7oonnh4RcyPxhNFR/jhkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="77344552"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 29 Jul 2024 15:34:39 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 04/15] ice: treat subfunction VSI the same as PF VSI
Date: Mon, 29 Jul 2024 15:34:19 -0700
Message-ID: <20240729223431.681842-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240729223431.681842-1-anthony.l.nguyen@intel.com>
References: <20240729223431.681842-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

When subfunction VSI is open the same code as for PF VSI should be
executed. Also when up is complete. Reflect that in code by adding
subfunction VSI to consideration.

In case of stopping, PF doesn't have additional tasks, so the same
is with subfunction VSI.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f0ffdaae33d2..a329c8a2002c 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6728,7 +6728,8 @@ static int ice_up_complete(struct ice_vsi *vsi)
 
 	if (vsi->port_info &&
 	    (vsi->port_info->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
-	    vsi->netdev && vsi->type == ICE_VSI_PF) {
+	    ((vsi->netdev && vsi->type == ICE_VSI_PF) ||
+	     (vsi->netdev && vsi->type == ICE_VSI_SF))) {
 		ice_print_link_msg(vsi, true);
 		netif_tx_start_all_queues(vsi->netdev);
 		netif_carrier_on(vsi->netdev);
@@ -7426,7 +7427,7 @@ int ice_vsi_open(struct ice_vsi *vsi)
 
 	ice_vsi_cfg_netdev_tc(vsi, vsi->tc_cfg.ena_tc);
 
-	if (vsi->type == ICE_VSI_PF) {
+	if (vsi->type == ICE_VSI_PF || vsi->type == ICE_VSI_SF) {
 		/* Notify the stack of the actual queue counts. */
 		err = netif_set_real_num_tx_queues(vsi->netdev, vsi->num_txq);
 		if (err)
-- 
2.42.0


