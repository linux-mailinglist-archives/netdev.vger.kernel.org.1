Return-Path: <netdev+bounces-100393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA398FA5D5
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 00:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D471F23FB2
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 22:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC49140E5E;
	Mon,  3 Jun 2024 22:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SiwMWXky"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA72D13FD82
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454307; cv=none; b=Ytzcnc1SDvFfIeL90PVzZ0WK1Ed67ARED0wGnrp9hi6nrHVaZjShLdMjd8Ahghh8oOAzMzscCWaP4zrXOurNzLJAglvBFQfVEyx0FRhkQj2oVehU2tZODUquie4Rrm7TxZsFu0OXuKvFIExQfqdno2Ew0o5UEoR+MxUA0urMmqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454307; c=relaxed/simple;
	bh=ftoqpp2fmR6aU4PVMSgZDWfBw87I/MVDZ12Atu0W/ds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bq3uO3HbO3jjnhKyeyFwx1iP5eWVBtVqDu/jY35u5Kjlku3JegZ61NIoCvDAtr9ba79iGmG4YcXC/9oB1tdNqB6gAIRL6tvIxAir7U0mIvaPbzz7pC7rnSBaUbBgshF3mCd198wLTCUATkYZIV8m/ovOrOHN2NTsqnCEO3Wdvdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SiwMWXky; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717454306; x=1748990306;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ftoqpp2fmR6aU4PVMSgZDWfBw87I/MVDZ12Atu0W/ds=;
  b=SiwMWXky9PvHN/6cyhCTusRokAZvUxK6EIB2fqNWoDSWYMqVU2IEdwaY
   zq/3/YNmL6pldxTiqmEM3EjTxm5X0Gl7dIeuybqPmD6Of87LlStvr/Up6
   yyg/K7XLVXUy0X1pca+VOO8rwJYdeJoyvkGnR9IYsgdoFDtvF4d2MaFYP
   E9RfKhsfUU4ME0quQ1hKgqH/Mmqo1TP+fgGDkziJYMjSA2Cuf7akZDCTD
   J8aepPQSd3KhpsHXjPaWNkh0a0RGYxQ+8pbE3sU5HQQ0I1xtjYz9F28sC
   3vhkH3B8HJDlDBm59G1fZV+bPCEmTCvjjkyFBKRztmdcaNQunkFgwZG8e
   Q==;
X-CSE-ConnectionGUID: l611acIkT2G/pUtyvezX0g==
X-CSE-MsgGUID: V/jYc6rnTwW+OKAok2fN/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="13780119"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="13780119"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 15:38:22 -0700
X-CSE-ConnectionGUID: rscZBsu0TYmG70tAaAyuow==
X-CSE-MsgGUID: E+2GnvSRQyqaxRSeDm+3Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="41471188"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 15:38:21 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 03 Jun 2024 15:38:17 -0700
Subject: [PATCH 5/9] ice: update representor when VSI is ready
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-next-2024-06-03-intel-next-batch-v1-5-e0523b28f325@intel.com>
References: <20240603-next-2024-06-03-intel-next-batch-v1-0-e0523b28f325@intel.com>
In-Reply-To: <20240603-next-2024-06-03-intel-next-batch-v1-0-e0523b28f325@intel.com>
To: David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>, 
 Jiri Pirko <jiri@resnulli.us>
X-Mailer: b4 0.13.0

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

In case of reset of VF VSI can be reallocated. To handle this case it
should be properly updated.

Reload representor as vsi->vsi_num can be different than the one stored
when representor was created.

Instead of only changing antispoof do whole VSI configuration for
eswitch.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 21 ++++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_eswitch.h |  4 ++--
 drivers/net/ethernet/intel/ice/ice_vf_lib.c  |  2 +-
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 3f73f46111fc..4f539b1c7781 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -178,16 +178,16 @@ void ice_eswitch_decfg_vsi(struct ice_vsi *vsi, const u8 *mac)
  * @repr_id: representor ID
  * @vsi: VSI for which port representor is configured
  */
-void ice_eswitch_update_repr(unsigned long repr_id, struct ice_vsi *vsi)
+void ice_eswitch_update_repr(unsigned long *repr_id, struct ice_vsi *vsi)
 {
 	struct ice_pf *pf = vsi->back;
 	struct ice_repr *repr;
-	int ret;
+	int err;
 
 	if (!ice_is_switchdev_running(pf))
 		return;
 
-	repr = xa_load(&pf->eswitch.reprs, repr_id);
+	repr = xa_load(&pf->eswitch.reprs, *repr_id);
 	if (!repr)
 		return;
 
@@ -197,12 +197,19 @@ void ice_eswitch_update_repr(unsigned long repr_id, struct ice_vsi *vsi)
 	if (repr->br_port)
 		repr->br_port->vsi = vsi;
 
-	ret = ice_vsi_update_security(vsi, ice_vsi_ctx_clear_antispoof);
-	if (ret) {
-		ice_fltr_add_mac_and_broadcast(vsi, repr->parent_mac,
-					       ICE_FWD_TO_VSI);
+	err = ice_eswitch_cfg_vsi(vsi, repr->parent_mac);
+	if (err)
 		dev_err(ice_pf_to_dev(pf), "Failed to update VSI of port representor %d",
 			repr->id);
+
+	/* The VSI number is different, reload the PR with new id */
+	if (repr->id != vsi->vsi_num) {
+		xa_erase(&pf->eswitch.reprs, repr->id);
+		repr->id = vsi->vsi_num;
+		if (xa_insert(&pf->eswitch.reprs, repr->id, repr, GFP_KERNEL))
+			dev_err(ice_pf_to_dev(pf), "Failed to reload port representor %d",
+				repr->id);
+		*repr_id = repr->id;
 	}
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.h b/drivers/net/ethernet/intel/ice/ice_eswitch.h
index 9a25606e9740..09194d514f9b 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.h
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.h
@@ -18,7 +18,7 @@ ice_eswitch_mode_set(struct devlink *devlink, u16 mode,
 		     struct netlink_ext_ack *extack);
 bool ice_is_eswitch_mode_switchdev(struct ice_pf *pf);
 
-void ice_eswitch_update_repr(unsigned long repr_id, struct ice_vsi *vsi);
+void ice_eswitch_update_repr(unsigned long *repr_id, struct ice_vsi *vsi);
 
 void ice_eswitch_stop_all_tx_queues(struct ice_pf *pf);
 
@@ -47,7 +47,7 @@ ice_eswitch_set_target_vsi(struct sk_buff *skb,
 			   struct ice_tx_offload_params *off) { }
 
 static inline void
-ice_eswitch_update_repr(unsigned long repr_id, struct ice_vsi *vsi) { }
+ice_eswitch_update_repr(unsigned long *repr_id, struct ice_vsi *vsi) { }
 
 static inline int ice_eswitch_configure(struct ice_pf *pf)
 {
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 48a8d462d76a..5635e9da2212 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -948,7 +948,7 @@ int ice_reset_vf(struct ice_vf *vf, u32 flags)
 		goto out_unlock;
 	}
 
-	ice_eswitch_update_repr(vf->repr_id, vsi);
+	ice_eswitch_update_repr(&vf->repr_id, vsi);
 
 	/* if the VF has been reset allow it to come up again */
 	ice_mbx_clear_malvf(&vf->mbx_info);

-- 
2.44.0.53.g0f9d4d28b7e6


