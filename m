Return-Path: <netdev+bounces-245308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6381DCCB3FE
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 10:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A1193043561
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 09:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DCB1F9F7A;
	Thu, 18 Dec 2025 09:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fnc/oOpr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C26221CC58
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 09:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766051228; cv=none; b=C7ETM9N5E3+xCTUt4eYBGDuiIP3DHycIFpcorKS/35Kaicbkm8d+c7cHYzI7odBwI9Ht41gR6Nv5VGKzu+Icwd+E5maF15mEcYPKl1uxdd0/ETEhu8HrImBXtt8mnq7UJHNAA0fhm55B/FFtHKv7GKFanTtEq56Fh/amivK+R+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766051228; c=relaxed/simple;
	bh=2l7sftU6c2VGwi3zbDZTUPbXZ3sqKJV8IEPxc4XG1bE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZuqtqPOmQTemACYj7LGEIkLWpdgwYCY4UFk6uL6oq7l+1duxQnySTVuaHMHJ4gquHjyzKdkwt7CvUNs19lu+U8hCWjdlgJKSBQ9N8TBE2LUteV6AJR+zajXxVopkbrjCYdEM9KLK8k0XCVIubvNs6sUGPAkVrUwTqC74R6JTQGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fnc/oOpr; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766051226; x=1797587226;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2l7sftU6c2VGwi3zbDZTUPbXZ3sqKJV8IEPxc4XG1bE=;
  b=Fnc/oOpr1BLGzhldA91UtaejgxOz4BAH9vdCQaw2yAShSM7TXu25byog
   rf8kp/h12juEt1uty63kYoNubwL0QJDVMQKEFlISwVXJ55tmYH3FjqvrP
   WtCjheLV5kDZV96g77m6GkqrRAgJA8V9COFU/D84f5Eq5sHlVoDfimf6U
   qZhDfz38IW8jPjv4wGzzxmbXuLhUrIqE3IedG7CZLAL3K6NBZr/vOjzXe
   PUkwarkeQfLEZtUNAibYzRx9Xe7//eShyuhIn0kBVXRCmLx62XZvDQ1df
   0HPdQ34AFDAL5IkQDh04TKQ0YqJLazCp/R96YcVHk/9+GEStUu6tHy/qC
   A==;
X-CSE-ConnectionGUID: fmQXPu/ASt6L9UeaLmEO0g==
X-CSE-MsgGUID: EkMi4b8nQwKgFVtF9T3V3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="68155798"
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; 
   d="scan'208";a="68155798"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 01:47:05 -0800
X-CSE-ConnectionGUID: IGeDR+cWRGCFTVmHvrH+5g==
X-CSE-MsgGUID: 2nuNSzGPQ12ToZJU0bV3Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; 
   d="scan'208";a="203060583"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa004.jf.intel.com with ESMTP; 18 Dec 2025 01:47:04 -0800
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-net] ice: fix 'adjust' timer programming for E830 devices
Date: Thu, 18 Dec 2025 10:44:28 +0100
Message-Id: <20251218094428.1762860-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix incorrect 'adjust the timer' programming sequence for E830 devices
series. Only shadow registers GLTSYN_SHADJ were programmed in the
current implementation. According to the specification [1], write to
command GLTSYN_CMD register is also required with CMD field set to
"Adjust the Time" value, for the timer adjustment to take the effect.

The flow was broken for the adjustment less than S32_MAX/MIN range
(around +/- 2 seconds). For bigger adjustment, non-atomic programming
flow is used, involving set timer programming. Non-atomic flow is
implemented correctly.

Testing hints:
Run command:
	phc_ctl /dev/ptpX get adj 2 get
Expected result:
	Returned timstamps differ at least by 2 seconds

[1] Intel® Ethernet Controller E830 Datasheet rev 1.3, chapter 9.7.5.4
https://cdrdv2.intel.com/v1/dl/getContent/787353?explicitVersion=true

Fixes: f00307522786 ("ice: Implement PTP support for E830 devices")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 35680dbe4a7f..161a0ae8599c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -5381,8 +5381,8 @@ int ice_ptp_write_incval_locked(struct ice_hw *hw, u64 incval)
  */
 int ice_ptp_adj_clock(struct ice_hw *hw, s32 adj)
 {
+	int err = 0;
 	u8 tmr_idx;
-	int err;
 
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
 
@@ -5399,8 +5399,8 @@ int ice_ptp_adj_clock(struct ice_hw *hw, s32 adj)
 		err = ice_ptp_prep_phy_adj_e810(hw, adj);
 		break;
 	case ICE_MAC_E830:
-		/* E830 sync PHYs automatically after setting GLTSYN_SHADJ */
-		return 0;
+		/* E830 sync PHYs automatically after setting cmd register */
+		break;
 	case ICE_MAC_GENERIC:
 		err = ice_ptp_prep_phy_adj_e82x(hw, adj);
 		break;

base-commit: 8282ed7f73cf08f99288d3d0131e07f149063fbe
-- 
2.39.3


