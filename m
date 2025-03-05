Return-Path: <netdev+bounces-172206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 184C0A50DBA
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 22:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED761635B7
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 21:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF3825C6E5;
	Wed,  5 Mar 2025 21:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="azQMfHjX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAD925743D
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 21:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210564; cv=none; b=RVUNtzU4YP0XQW18fCqztlB6QizBL4cvYsV7y7efsAaJOG0So+qZvVslmymb7AEom1+STo0Ee+7IOgbfQjaSf63ubLNg+9epWJKXVsDYY3j047NHO8k3ZhN8K22GnLRem3kTBYV0kCr+OhP0L2I8rGJ3aKdfR3g9xh8sOwTfR+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210564; c=relaxed/simple;
	bh=GuwR3mhZuYCpbs97AgybkQQLFzvRbxU8C1+NMIk78bE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qspp+z/Qy9kZSJPKRC6biVIn0Xw8Er2cc0A5tx91ilHCWGHkiTn12aCuTANk2NOMNJC/PA0KHCv4oOc6P7uU98XpAb3Clky/aSn1XK/plMVun3+wM+njykJnTplu5uAvHPgzus/WkkBK4JSghAL9z8q9thIJEQfcnXvgD4h5B2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=azQMfHjX; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741210562; x=1772746562;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GuwR3mhZuYCpbs97AgybkQQLFzvRbxU8C1+NMIk78bE=;
  b=azQMfHjXyWVuxJXh7IxWs+o8v4xevsiFyEqbSxG4lmmDxfsVKJu//btd
   q8GQfmJku1wTvKNPk5gBHtxz7mHy3MYEbG6C/O1RRY+dPB3Gdc4qj0DSF
   SO88jvL1gZw/J8zFm6GWFtvlZNJaLZMaAL8La0QRNZrfrIim31qMi4STa
   J1LlXX2ScVgGWvKFaZBJaI6DtThQp4qAdMSj7w0IQdJGM5b7wfa1vLh8L
   zjdgVGWQiL984n8amoMvWh1uAuVfRjIO/9ldAq8rSBvS7MWnG2ZRKCpUE
   Uurn3BAdGGC0iZV3LNlfsPN8qrmsrbvFxF9sFiwAYLwBIUEKIGMTpifu/
   Q==;
X-CSE-ConnectionGUID: gnLZwB+YRimqdJK4CUTPjQ==
X-CSE-MsgGUID: Pf1LNsq/QOCnpMfgupGBAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53606486"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="53606486"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 13:35:58 -0800
X-CSE-ConnectionGUID: npqG6Qf4Q7Szb3WKbwhW8A==
X-CSE-MsgGUID: yBTuF3EUThCSE/rMIeI8GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="123828479"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 05 Mar 2025 13:35:55 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	przemyslaw.kitszel@intel.com,
	Simon Horman <horms@kernel.org>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net 1/4] ice: do not configure destination override for switchdev
Date: Wed,  5 Mar 2025 13:35:43 -0800
Message-ID: <20250305213549.1514274-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305213549.1514274-1-anthony.l.nguyen@intel.com>
References: <20250305213549.1514274-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Larysa Zaremba <larysa.zaremba@intel.com>

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
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c |  6 ------
 drivers/net/ethernet/intel/ice/ice_lib.c     | 18 ------------------
 drivers/net/ethernet/intel/ice/ice_lib.h     |  4 ----
 3 files changed, 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index d649c197cf67..ed21d7f55ac1 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -49,9 +49,6 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
 	if (vlan_ops->dis_rx_filtering(uplink_vsi))
 		goto err_vlan_filtering;
 
-	if (ice_vsi_update_security(uplink_vsi, ice_vsi_ctx_set_allow_override))
-		goto err_override_uplink;
-
 	if (ice_vsi_update_local_lb(uplink_vsi, true))
 		goto err_override_local_lb;
 
@@ -63,8 +60,6 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
 err_up:
 	ice_vsi_update_local_lb(uplink_vsi, false);
 err_override_local_lb:
-	ice_vsi_update_security(uplink_vsi, ice_vsi_ctx_clear_allow_override);
-err_override_uplink:
 	vlan_ops->ena_rx_filtering(uplink_vsi);
 err_vlan_filtering:
 	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
@@ -275,7 +270,6 @@ static void ice_eswitch_release_env(struct ice_pf *pf)
 	vlan_ops = ice_get_compat_vsi_vlan_ops(uplink_vsi);
 
 	ice_vsi_update_local_lb(uplink_vsi, false);
-	ice_vsi_update_security(uplink_vsi, ice_vsi_ctx_clear_allow_override);
 	vlan_ops->ena_rx_filtering(uplink_vsi);
 	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
 			 ICE_FLTR_TX);
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 38a1c8372180..d0faa087793d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3936,24 +3936,6 @@ void ice_vsi_ctx_clear_antispoof(struct ice_vsi_ctx *ctx)
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
index eabb35834a24..b4c9cb28a016 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -105,10 +105,6 @@ ice_vsi_update_security(struct ice_vsi *vsi, void (*fill)(struct ice_vsi_ctx *))
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
2.47.1


