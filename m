Return-Path: <netdev+bounces-163413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3D1A2A364
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 09:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0C65166326
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 08:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A97225772;
	Thu,  6 Feb 2025 08:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H2nDE6Q/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990FC225A20
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738831234; cv=none; b=KEr7NR5QdEV/SJqGpEnEDRXFaNOpCJMcr3ggKLkQaSjOlpOOaabKrsFjBPCBQXfxoQKWLzIGbKJjEqGt7v90TNqNrDX29CyipMfUn2p3b+p4rG04t3B2CwsS183sKxkE8XDVnSImeP3sj/y3FxkxMrIcTStc0U76htFUYeushtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738831234; c=relaxed/simple;
	bh=z6PGNnGXoikoYsPEQiGiz3uQUXRt68IyszS2WX20zE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J9RwQvpBtAz51GCCHwt8kmC8tmvmONJdR2wHw1qaSFYayznc2Sq3slEac2OKj8gK0RFGarAp/mP7Fl7/ATGHEG8X9cn+FqpHF0/cehCzVHwm6zOaBWtsxxnBzrUFucryTvt2Zvff+dBVPcdiM5BkWoMP9AlPa4jEDXNc8EWwywA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H2nDE6Q/; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738831233; x=1770367233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z6PGNnGXoikoYsPEQiGiz3uQUXRt68IyszS2WX20zE0=;
  b=H2nDE6Q/+lUB/LgEzOE26Sci1bh9awVYufI/qkVWwP1ivJqwUjWjG2z3
   PCwcphTAMEG4OfZ9lf7ryLSeIaHtPCJkVbOKYVKo9zaKZwjjTsMLt06cs
   AzVzQqXotziVhXNXOh7dWok8XW8OO/KBT2WK4O98v9MrZLz1ECS5Gqo4U
   RiASudYxmuXkh3ub3qdzJj8FY0N0d6n/26hU+3su7a+nC+RRFkrEdH0RX
   hzA14NA7CRr+FFWNuwA8D0JZTkqQCHGwcS6+DXZeHYW3BTgtNH3egLdus
   NEpwVvdPgh0fH2aqNCnM51HPtjTi/qEux1MZdAGiCSICVej4+3RJAtxGy
   A==;
X-CSE-ConnectionGUID: AsVQYte+RwGTeaNPH7MX3A==
X-CSE-MsgGUID: 1B7j1qB9QESe0lUhPDV94A==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="49667825"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="49667825"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 00:40:32 -0800
X-CSE-ConnectionGUID: TsBTAi/DS6C1xxtiXa07Zg==
X-CSE-MsgGUID: pTCpoKX1TAeou44rFB7xMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="110979390"
Received: from gklab-003-001.igk.intel.com ([10.211.3.1])
  by fmviesa006.fm.intel.com with ESMTP; 06 Feb 2025 00:40:31 -0800
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH iwl-next v1 2/3] ice: Refactor E825C PHY registers info struct
Date: Thu,  6 Feb 2025 09:36:54 +0100
Message-Id: <20250206083655.3005151-3-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250206083655.3005151-1-grzegorz.nitka@intel.com>
References: <20250206083655.3005151-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Simplify ice_phy_reg_info_eth56g struct definition to include base
address for the very first quad. Use base address info and 'step'
value to determine address for specific PHY quad.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 .../net/ethernet/intel/ice/ice_ptp_consts.h   | 75 ++++---------------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  6 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  2 +-
 3 files changed, 19 insertions(+), 64 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
index ac46d1183300..003cdfada3ca 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
@@ -10,70 +10,25 @@
 /* Constants defined for the PTP 1588 clock hardware. */
 
 const struct ice_phy_reg_info_eth56g eth56g_phy_res[NUM_ETH56G_PHY_RES] = {
-	/* ETH56G_PHY_REG_PTP */
-	{
-		/* base_addr */
-		{
-			0x092000,
-			0x126000,
-			0x1BA000,
-			0x24E000,
-			0x2E2000,
-		},
-		/* step */
-		0x98,
+	[ETH56G_PHY_REG_PTP] = {
+		.base_addr = 0x092000,
+		.step = 0x98,
 	},
-	/* ETH56G_PHY_MEM_PTP */
-	{
-		/* base_addr */
-		{
-			0x093000,
-			0x127000,
-			0x1BB000,
-			0x24F000,
-			0x2E3000,
-		},
-		/* step */
-		0x200,
+	[ETH56G_PHY_MEM_PTP] = {
+		.base_addr = 0x093000,
+		.step = 0x200,
 	},
-	/* ETH56G_PHY_REG_XPCS */
-	{
-		/* base_addr */
-		{
-			0x000000,
-			0x009400,
-			0x128000,
-			0x1BC000,
-			0x250000,
-		},
-		/* step */
-		0x21000,
+	[ETH56G_PHY_REG_XPCS] = {
+		.base_addr = 0x000000,
+		.step = 0x21000,
 	},
-	/* ETH56G_PHY_REG_MAC */
-	{
-		/* base_addr */
-		{
-			0x085000,
-			0x119000,
-			0x1AD000,
-			0x241000,
-			0x2D5000,
-		},
-		/* step */
-		0x1000,
+	[ETH56G_PHY_REG_MAC] = {
+		.base_addr = 0x085000,
+		.step = 0x1000,
 	},
-	/* ETH56G_PHY_REG_GPCS */
-	{
-		/* base_addr */
-		{
-			0x084000,
-			0x118000,
-			0x1AC000,
-			0x240000,
-			0x2D4000,
-		},
-		/* step */
-		0x400,
+	[ETH56G_PHY_REG_GPCS] = {
+		.base_addr = 0x084000,
+		.step = 0x400,
 	},
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index c3dea6d61de4..5c61bc3a2c25 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -1010,7 +1010,7 @@ static int ice_phy_res_address_eth56g(struct ice_hw *hw, u8 lane,
 
 	/* Lanes 4..7 are in fact 0..3 on a second PHY */
 	lane %= hw->ptp.ports_per_phy;
-	*addr = eth56g_phy_res[res_type].base[0] +
+	*addr = eth56g_phy_res[res_type].base_addr +
 		lane * eth56g_phy_res[res_type].step + offset;
 
 	return 0;
@@ -1240,7 +1240,7 @@ static int ice_write_quad_ptp_reg_eth56g(struct ice_hw *hw, u8 port,
 	if (port >= hw->ptp.num_lports)
 		return -EIO;
 
-	addr = eth56g_phy_res[ETH56G_PHY_REG_PTP].base[0] + offset;
+	addr = eth56g_phy_res[ETH56G_PHY_REG_PTP].base_addr + offset;
 
 	return ice_write_phy_eth56g(hw, port, addr, val);
 }
@@ -1265,7 +1265,7 @@ static int ice_read_quad_ptp_reg_eth56g(struct ice_hw *hw, u8 port,
 	if (port >= hw->ptp.num_lports)
 		return -EIO;
 
-	addr = eth56g_phy_res[ETH56G_PHY_REG_PTP].base[0] + offset;
+	addr = eth56g_phy_res[ETH56G_PHY_REG_PTP].base_addr + offset;
 
 	return ice_read_phy_eth56g(hw, port, addr, val);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 10295fa9a383..63a63ef64aaa 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -72,7 +72,7 @@ enum ice_eth56g_link_spd {
  * ETH56G devices
  */
 struct ice_phy_reg_info_eth56g {
-	u32 base[NUM_ETH56G_PHY_RES];
+	u32 base_addr;
 	u32 step;
 };
 
-- 
2.39.3


