Return-Path: <netdev+bounces-176462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23902A6A705
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4660319C157D
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 13:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A4120AF6D;
	Thu, 20 Mar 2025 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cjF+BOYt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DD21DF749
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742476776; cv=none; b=q0YPyUAaaZT99/qiLjk/uqTsL32hpCh0NPY6t9IW158orJyI2ksjk4P+2zetembNXIP0nxdFflp26Kmxu8zwwuR7Skbn7/VoIWJZo7LLW0wE3KsLYpqAFCSDAI+sWVQl7UrdQacMsicvDAS3MJ53yt+fM84qHLU0HFwWp8PlqgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742476776; c=relaxed/simple;
	bh=+rKFdjeP+Hy9a/CmOyXaoOJBvGS+eLADxwEBQxqhnI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qmL1DMotG6DZ8TJCKTjoA/Zz9DRHuVdtcihVbu35uOtqVfKbeAgM9WevSdXmNoWcv8Nz40/Vjm5vARVkcag+Oxm366lVJWqvQILQb4pHNjFoNdmZlYXz8t1/QhCpetM1KFAs5aLBCTMk2iw6AHUWQSyi/g8bXfHuHdp2Dr8nDEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cjF+BOYt; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742476775; x=1774012775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+rKFdjeP+Hy9a/CmOyXaoOJBvGS+eLADxwEBQxqhnI8=;
  b=cjF+BOYtJalSflLZE2WQMscSHS28r2Sno5M8mmOAvwZPltMU5zfwN/12
   Z0xYvdEBRiuu5NqBQd5lMFe8bdvmXMz/9uaW0PFImq7ier51z0mklCpDH
   iC8UZAqmzXzZUDdXcKTS8JDDzeuQGaZQ9DzAwOdEIlDP+OFSVsodHlDur
   ZmV/WNbI14tWF5vXzaILIEgAH1ckRq5k6I1RcVeQ+WOKQV5+fO3zQyEpv
   iU2v8QeI5t1NrUn8QIKOGCdn4NLy9erb9ENIN/dTeOVrdCQOw++SxtH5q
   BvFIhDbayi1zl6/DvQE2jO3+v5XwNtaDPn4SnAyVzbCra6Ysu03Kx8E72
   w==;
X-CSE-ConnectionGUID: LR8yN+5iR0On0Xdd4o9eOg==
X-CSE-MsgGUID: rxL3WaroSRSA2+AqBa5GbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="55083740"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="55083740"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 06:19:35 -0700
X-CSE-ConnectionGUID: SOq9uumESCW21bdsvJBPRA==
X-CSE-MsgGUID: 8x1O74Y0RJ6vUI0hkLXJRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="160311385"
Received: from gklab-003-001.igk.intel.com ([10.211.3.1])
  by orviesa001.jf.intel.com with ESMTP; 20 Mar 2025 06:19:32 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	horms@kernel.org,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH iwl-next v3 1/3] ice: remove SW side band access workaround for E825
Date: Thu, 20 Mar 2025 14:15:36 +0100
Message-Id: <20250320131538.712326-2-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250320131538.712326-1-grzegorz.nitka@intel.com>
References: <20250320131538.712326-1-grzegorz.nitka@intel.com>
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

NOTE: at the time the fix was provided in NVM, the E825C product was
not officially available on the market, so it's not expected this change
will cause regression when running with older driver/kernel versions.

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


