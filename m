Return-Path: <netdev+bounces-187332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B77AA668D
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 00:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC239A8854
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 22:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5924F26B2B3;
	Thu,  1 May 2025 22:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XFeiVfWS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A834926E17A
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 22:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140084; cv=none; b=HI5Th/rTNHbVK4KShsSQuAi7ibPrGSdGWIvVYO0X+egXySHID8g1kNQth8aqqOdCoXFo9gtcAE/UhUwZ/6jgSUgUrBm4Gd3GGTRkpZD8/gVfJbNIDdCU5/1ZeAKqLJ8DmMfK7voN0T+1l69rUkeSKI65UvmaPAHfQIB49Swp7F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140084; c=relaxed/simple;
	bh=09z7P/iSewgSewd6YPYLw8RK4FGwxounHiayMufZKwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ENRHAoc4VvmMhDnglrQQFH5suwlAM1X64jWWE496ALYKCJEBOrU+ADOCSnPQzcdXd+asbpKcFeo3e5BylhSWA6huba7eoHvAr7MW/RmBCeWwkL6CUaBpVMVzt6IbsWj1aPP2lMw59srg5JE8n0ZlEjnYEK9m5efjSISICEsMsxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XFeiVfWS; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746140083; x=1777676083;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=09z7P/iSewgSewd6YPYLw8RK4FGwxounHiayMufZKwU=;
  b=XFeiVfWSBnpKddnyAVsawyjvNxGi2nl2Peeu6KuqS8fmn/V9vz7xQYVB
   vLsHwYDKR1dUuEbbkvOyemCps8cWDHdDaLPRNLSpVDrD3/lEadba5g7cL
   mD3tdf0pcfdYz4eS1PwqAtFiDNydacpNA9lj8fCV+e9o3Qh2Gdy9M+nMz
   D7d6+OZh7Da1f8ryy0Fof1Lu6Gof8PsZFOZJCUks2bsJWdBDqJmV1kGI3
   uh1eMGZt7gX9xxBb9OwUwrEyVKezrajNJW8uc4KWvjSjH3d7B/TtJr84n
   k9AuXi2HTCMqarIANdJLzaQoVfQCZRVeSZHFkLY01LUoCSlHR01PWlJVH
   A==;
X-CSE-ConnectionGUID: XcILTzCkTBqFeH9FRKZ6tg==
X-CSE-MsgGUID: EVdQagYsR6OFmwvqeH+KVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="58811755"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="58811755"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 15:54:38 -0700
X-CSE-ConnectionGUID: JvVTZTtiRTGVVfXFyRmJfQ==
X-CSE-MsgGUID: XfNLI6HhRaees9pxSeQsmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="138514320"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 15:54:37 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 01 May 2025 15:54:25 -0700
Subject: [PATCH v4 14/15] ice: move TSPLL init calls to ice_ptp.c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250501-kk-tspll-improvements-alignment-v4-14-24c83d0ce7a8@intel.com>
References: <20250501-kk-tspll-improvements-alignment-v4-0-24c83d0ce7a8@intel.com>
In-Reply-To: <20250501-kk-tspll-improvements-alignment-v4-0-24c83d0ce7a8@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Karol Kolacinski <karol.kolacinski@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Milena Olech <milena.olech@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>
X-Mailer: b4 0.14.2

From: Karol Kolacinski <karol.kolacinski@intel.com>

Initialize TSPLL after initializing PHC in ice_ptp.c instead of calling
for each product in PHC init in ice_ptp_hw.c.

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c    | 11 +++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 22 +---------------------
 drivers/net/ethernet/intel/ice/ice_tspll.c  |  5 +++++
 3 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 083f50f827441792d3b7a838c3359e05d2bbdf7c..3278b96d8f01cdf783db495db167e44c13e8c8da 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2891,6 +2891,10 @@ static int ice_ptp_rebuild_owner(struct ice_pf *pf)
 	if (err)
 		return err;
 
+	err = ice_tspll_init(hw);
+	if (err)
+		return err;
+
 	/* Acquire the global hardware lock */
 	if (!ice_ptp_lock(hw)) {
 		err = -EBUSY;
@@ -3058,6 +3062,13 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
 		return err;
 	}
 
+	err = ice_tspll_init(hw);
+	if (err) {
+		dev_err(ice_pf_to_dev(pf), "Failed to initialize CGU, status %d\n",
+			err);
+		return err;
+	}
+
 	/* Acquire the global hardware lock */
 	if (!ice_ptp_lock(hw)) {
 		err = -EBUSY;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 6da82025934cb709d06f12cc26f9b494c6f4d772..523f95271f353e72b72ac5ea0123869f2d387e98 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2115,20 +2115,6 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 	return 0;
 }
 
-/**
- * ice_ptp_init_phc_e825 - Perform E825 specific PHC initialization
- * @hw: pointer to HW struct
- *
- * Perform E825-specific PTP hardware clock initialization steps.
- *
- * Return: 0 on success, negative error code otherwise.
- */
-static int ice_ptp_init_phc_e825(struct ice_hw *hw)
-{
-	/* Initialize the Clock Generation Unit */
-	return ice_tspll_init(hw);
-}
-
 /**
  * ice_ptp_read_tx_hwtstamp_status_eth56g - Get TX timestamp status
  * @hw: pointer to the HW struct
@@ -2788,7 +2774,6 @@ static int ice_ptp_set_vernier_wl(struct ice_hw *hw)
  */
 static int ice_ptp_init_phc_e82x(struct ice_hw *hw)
 {
-	int err;
 	u32 val;
 
 	/* Enable reading switch and PHY registers over the sideband queue */
@@ -2798,11 +2783,6 @@ static int ice_ptp_init_phc_e82x(struct ice_hw *hw)
 	val |= (PF_SB_REM_DEV_CTL_SWITCH_READ | PF_SB_REM_DEV_CTL_PHY0);
 	wr32(hw, PF_SB_REM_DEV_CTL, val);
 
-	/* Initialize the Clock Generation Unit */
-	err = ice_tspll_init(hw);
-	if (err)
-		return err;
-
 	/* Set window length for all the ports */
 	return ice_ptp_set_vernier_wl(hw);
 }
@@ -5584,7 +5564,7 @@ int ice_ptp_init_phc(struct ice_hw *hw)
 	case ICE_MAC_GENERIC:
 		return ice_ptp_init_phc_e82x(hw);
 	case ICE_MAC_GENERIC_3K_E825:
-		return ice_ptp_init_phc_e825(hw);
+		return 0;
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index 7b61e1afe8b43a24c77edf0a0590562fbfa0ce3e..8f125ea5a80f5d145a412eee55a148b3ae3f830d 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -484,6 +484,11 @@ int ice_tspll_init(struct ice_hw *hw)
 	enum ice_clk_src clk_src;
 	int err;
 
+	/* Only E822, E823 and E825 products support TSPLL */
+	if (hw->mac_type != ICE_MAC_GENERIC &&
+	    hw->mac_type != ICE_MAC_GENERIC_3K_E825)
+		return 0;
+
 	tspll_freq = (enum ice_tspll_freq)ts_info->time_ref;
 	clk_src = (enum ice_clk_src)ts_info->clk_src;
 	if (!ice_tspll_check_params(hw, tspll_freq, clk_src))

-- 
2.48.1.397.gec9d649cc640


