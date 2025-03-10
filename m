Return-Path: <netdev+bounces-173525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 988BCA59485
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 13:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B483A2E99
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6CB226D02;
	Mon, 10 Mar 2025 12:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qm6IXENh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD698227E94
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 12:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741609716; cv=none; b=PGHYpbdmgvS0czZgvJ4SAsQOr/va7AJr2TeAgcLoE3WmbK6RHnRL4sNql+KseO2gJcFVUr0F/VsFF3cgABFfQF065G8y3aZLmGh+3KDpAduIMNUwHdwaZK6YELr2XFoj++naZR0vH+0QilASaNuFr+G8WHa+k7OjsFaBtZgdUKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741609716; c=relaxed/simple;
	bh=GTk9VP3N8vjJ6Ux0qJ5b3R0Yjtazu9WwJEl6y7bzQZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NBt0OQXEx39Z7GcRWPGZoMjmFsufKBy7c9nCPp0VeoJgDooISad9WW8C61ecdndvklbgI31wa60Nyr54F9I2lS0kzS3neFFBr/Vpm6QMNXJNVDQtgRBmFPbraLFAGBoM/pf3hoLOsxUHazgQO2YB+V3wHHJy4Kx87H1FQZrzElY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qm6IXENh; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741609714; x=1773145714;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GTk9VP3N8vjJ6Ux0qJ5b3R0Yjtazu9WwJEl6y7bzQZY=;
  b=Qm6IXENhmn+P6LrnqkhNF734xr3bV9WvLvhO3Iarpfpyi4TjqkFq3S2s
   jl8aX65+z1jSnZCwK3Hl/+TfwtjnOQimelYaGsa2FZb2LSKab3CPoNTcP
   9xkGQJYPFrRF7It2O6NstQg7dRNPfKu5Ob/yvKYiWISHcQkcVGctMf7lM
   2P8D9h+yi8ESpQT9i559SUa7K621h1x9fs6VQtCLtNyLTFgUN1BQF8ebG
   pclemef6gusA6tRYT4CBy8pt6m12BQ1xYvKRZwYpGVgNjiY0gX+MI4mH6
   +JuAUM6fMxKe+NxdGtKyVVPJQWPy6oLgHq/Rg9WLyYWxw/oPFTcXA4RxN
   g==;
X-CSE-ConnectionGUID: V3F20Y5+QnyZe6fSGv4mcA==
X-CSE-MsgGUID: GO2w3+LOTNWH5DQaEQ+isQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="53981110"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="53981110"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 05:28:32 -0700
X-CSE-ConnectionGUID: dwY4hyKnQsae9S83dzqXew==
X-CSE-MsgGUID: DP3Ri8LiSaORJePDHl+Swg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="119698214"
Received: from gklab-003-001.igk.intel.com ([10.211.3.1])
  by orviesa009.jf.intel.com with ESMTP; 10 Mar 2025 05:28:31 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH iwl-next v2 1/3] ice: remove SW side band access workaround for E825
Date: Mon, 10 Mar 2025 13:24:37 +0100
Message-Id: <20250310122439.3327908-2-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250310122439.3327908-1-grzegorz.nitka@intel.com>
References: <20250310122439.3327908-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Due to the bug in FW/NVM autoload mechanism (wrong default
SB_REM_DEV_CTL register settings), the access to peer PHY and CGU
clients was disabled by default.

As the workaround solution, the register value was overwritten by the
driver at the probe or reset handling.
Remove workaround as it's not needed anymore. The fix in autoload
procedure has been provided with NVM 3.80 version.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 23 ---------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 89bb8461284a..a5df081ffc19 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2630,25 +2630,6 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 	return 0;
 }
 
-/**
- * ice_sb_access_ena_eth56g - Enable SB devices (PHY and others) access
- * @hw: pointer to HW struct
- * @enable: Enable or disable access
- *
- * Enable sideband devices (PHY and others) access.
- */
-static void ice_sb_access_ena_eth56g(struct ice_hw *hw, bool enable)
-{
-	u32 val = rd32(hw, PF_SB_REM_DEV_CTL);
-
-	if (enable)
-		val |= BIT(eth56g_phy_0) | BIT(cgu) | BIT(eth56g_phy_1);
-	else
-		val &= ~(BIT(eth56g_phy_0) | BIT(cgu) | BIT(eth56g_phy_1));
-
-	wr32(hw, PF_SB_REM_DEV_CTL, val);
-}
-
 /**
  * ice_ptp_init_phc_e825 - Perform E825 specific PHC initialization
  * @hw: pointer to HW struct
@@ -2659,8 +2640,6 @@ static void ice_sb_access_ena_eth56g(struct ice_hw *hw, bool enable)
  */
 static int ice_ptp_init_phc_e825(struct ice_hw *hw)
 {
-	ice_sb_access_ena_eth56g(hw, true);
-
 	/* Initialize the Clock Generation Unit */
 	return ice_init_cgu_e82x(hw);
 }
@@ -2747,8 +2726,6 @@ static void ice_ptp_init_phy_e825(struct ice_hw *hw)
 	params->num_phys = 2;
 	ptp->ports_per_phy = 4;
 	ptp->num_lports = params->num_phys * ptp->ports_per_phy;
-
-	ice_sb_access_ena_eth56g(hw, true);
 }
 
 /* E822 family functions
-- 
2.39.3


