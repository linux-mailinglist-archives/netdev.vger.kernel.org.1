Return-Path: <netdev+bounces-150231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD92A9E989F
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 15:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4C8164EBB
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50001B0405;
	Mon,  9 Dec 2024 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AZrPUwtU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCFA1ACED7;
	Mon,  9 Dec 2024 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754037; cv=none; b=dzBC66EsvxEmo/NswgoE44TBBuNHQjsKXizoMScJu5r3YlqdWrlSRbcqWJkEpM4U/aZI8dLUWRYVlOKxRXsu6BvYjxRfQJ+gDJEJ0d5MC+H93sBjSitESN/nDsi2WXdDIMCQS6iBaSV8t0sNHl7mzC1/RhuqEyNY/tuQeyB/1Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754037; c=relaxed/simple;
	bh=PLN8C0vyxeY0HZVJKEgoSC+dtNcyo3RDZ1X6tDGDsnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L8SbmOa0Mfz1TmBwRgmYox2qBucSd7MlIqbG7yTZV1QXRMJ+np4qUCUY7tHUkLtJKeyXUNUPge0EIse4UtMTLee0xIAHhCHHrfXAUEC62m3807w+PhYoZeY6+PmwzX5+V+VoXruSg+Im6TkA4q2Mq4GXehksExXH6HIYlyolzHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AZrPUwtU; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733754036; x=1765290036;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PLN8C0vyxeY0HZVJKEgoSC+dtNcyo3RDZ1X6tDGDsnU=;
  b=AZrPUwtUR06GQi+tEVqbQyZWkTTONvFHTYjK/5mmia/MURmdceEmUZyW
   wqsdA1rGKZGvOZqM1Jf7cfQwP9ZQIZK3tJdge7ndGC1TRROmfsbhCOMvK
   os0Muep3e1SY61uLt+KZjmPR1DYEEb20RJR6/+7S5jFUR5+25+EaM2Aax
   Lc/D21z/NFOQP4sf20pqxgtl8mNAEz0bMsRWg8ut00gjo/LvHrkehRLTT
   3XzaVz5jDtJuPS98vxeuvDfaeT31nrN8pRRS1/zEq52uDQW2ubeFXZNeC
   wIJlbZDNt6rHHNLgDPjn23pZI5eFxVMMbkJQ2eGbai7niMOR7Of8z9CwO
   Q==;
X-CSE-ConnectionGUID: oBsioNUGRgywWgd75C7qQA==
X-CSE-MsgGUID: cKfHM/iPRA6mjgx8YAHJQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="34110207"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="34110207"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 06:20:35 -0800
X-CSE-ConnectionGUID: 7JqJZmemSLmeRFeMvpV0dQ==
X-CSE-MsgGUID: Es16+6sTSQ+BlBm8KCAiIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="94923537"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa007.fm.intel.com with ESMTP; 09 Dec 2024 06:20:32 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id AEC55312FE;
	Mon,  9 Dec 2024 14:20:30 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH iwl-net] ice: do not configure destination override for switchdev
Date: Mon,  9 Dec 2024 15:08:53 +0100
Message-ID: <20241209140856.277801-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After switchdev is enabled and disabled later, LLDP packets sending stops,
despite working perfectly fine before and during switchdev state.
To reproduce (creating/destroying VF is what triggers the reconfiguration):

devlink dev eswitch set pci/<address> mode switchdev
echo '2' > /sys/class/net/<ifname>/device/sriov_numvfs
echo '0' > /sys/class/net/<ifname>/device/sriov_numvfs

This happens because LLDP relies on the destination override functionality.
It needs to 1) set a flag in the descriptor, 2) set the VSI permission to
make it valid. The permissions are set when the PF VSI is first configured,
but switchdev then enables it for the uplink VSI (which is always the PF)
once more when configured and disables when deconfigured, which leads to
software-generated LLDP packets being blocked.

Do not modify the destination override permissions when configuring
switchdev, as the enabled state is the default configuration that is never
modified.

Fixes: 1a1c40df2e80 ("ice: set and release switchdev environment")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c |  6 ------
 drivers/net/ethernet/intel/ice/ice_lib.c     | 18 ------------------
 drivers/net/ethernet/intel/ice/ice_lib.h     |  4 ----
 3 files changed, 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index fb527434b58b..b44a375e6365 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -50,9 +50,6 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
 	if (vlan_ops->dis_rx_filtering(uplink_vsi))
 		goto err_vlan_filtering;
 
-	if (ice_vsi_update_security(uplink_vsi, ice_vsi_ctx_set_allow_override))
-		goto err_override_uplink;
-
 	if (ice_vsi_update_local_lb(uplink_vsi, true))
 		goto err_override_local_lb;
 
@@ -64,8 +61,6 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
 err_up:
 	ice_vsi_update_local_lb(uplink_vsi, false);
 err_override_local_lb:
-	ice_vsi_update_security(uplink_vsi, ice_vsi_ctx_clear_allow_override);
-err_override_uplink:
 	vlan_ops->ena_rx_filtering(uplink_vsi);
 err_vlan_filtering:
 	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
@@ -276,7 +271,6 @@ static void ice_eswitch_release_env(struct ice_pf *pf)
 	vlan_ops = ice_get_compat_vsi_vlan_ops(uplink_vsi);
 
 	ice_vsi_update_local_lb(uplink_vsi, false);
-	ice_vsi_update_security(uplink_vsi, ice_vsi_ctx_clear_allow_override);
 	vlan_ops->ena_rx_filtering(uplink_vsi);
 	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
 			 ICE_FLTR_TX);
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index a7d45a8ce7ac..e07fc8851e1d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3930,24 +3930,6 @@ void ice_vsi_ctx_clear_antispoof(struct ice_vsi_ctx *ctx)
 				 ICE_AQ_VSI_SEC_TX_PRUNE_ENA_S);
 }
 
-/**
- * ice_vsi_ctx_set_allow_override - allow destination override on VSI
- * @ctx: pointer to VSI ctx structure
- */
-void ice_vsi_ctx_set_allow_override(struct ice_vsi_ctx *ctx)
-{
-	ctx->info.sec_flags |= ICE_AQ_VSI_SEC_FLAG_ALLOW_DEST_OVRD;
-}
-
-/**
- * ice_vsi_ctx_clear_allow_override - turn off destination override on VSI
- * @ctx: pointer to VSI ctx structure
- */
-void ice_vsi_ctx_clear_allow_override(struct ice_vsi_ctx *ctx)
-{
-	ctx->info.sec_flags &= ~ICE_AQ_VSI_SEC_FLAG_ALLOW_DEST_OVRD;
-}
-
 /**
  * ice_vsi_update_local_lb - update sw block in VSI with local loopback bit
  * @vsi: pointer to VSI structure
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 10d6fc479a32..6085039bac95 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -104,10 +104,6 @@ ice_vsi_update_security(struct ice_vsi *vsi, void (*fill)(struct ice_vsi_ctx *))
 void ice_vsi_ctx_set_antispoof(struct ice_vsi_ctx *ctx);
 
 void ice_vsi_ctx_clear_antispoof(struct ice_vsi_ctx *ctx);
-
-void ice_vsi_ctx_set_allow_override(struct ice_vsi_ctx *ctx);
-
-void ice_vsi_ctx_clear_allow_override(struct ice_vsi_ctx *ctx);
 int ice_vsi_update_local_lb(struct ice_vsi *vsi, bool set);
 int ice_vsi_add_vlan_zero(struct ice_vsi *vsi);
 int ice_vsi_del_vlan_zero(struct ice_vsi *vsi);
-- 
2.43.0


