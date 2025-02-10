Return-Path: <netdev+bounces-164764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 187FBA2EF75
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 15:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAA0D164D16
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 14:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24A8236452;
	Mon, 10 Feb 2025 14:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mGIDevYB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDE42309B7
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739196908; cv=none; b=YM5fEYzJ3Dk5zm0C09CLQuUNEJkPfwjgxxvDA5/GZXA+ltRe9t5ysMQrs364Havqkhc61im5eavNgLKGpry3Af/+WQCeKh149eA0vuaF20nNZR7Rqg+sTjRy+6OdC3eY5NuSEiCXWN9i5VLr1IFqvDEJ77ogecDLUsj+qtAV8CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739196908; c=relaxed/simple;
	bh=PPVkgZx+AtQtXQ8oeZE/FkHs7vyn7TFeR6ufEITPCVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=caFs4d9ShH6z4PWcStXb1JFgKI3c0/g2Y2RHda5Q58K8iHp8XCjb0aWxVj2ZDY78CTwrp3wZJt5X596RlXrg9oAICWxpjoqTt6Uq9b89DEoVjr0gmurC1fgePO87bRMSDIDIO0EmMNuVR+duKHDn+cdyvEGQE9EYBKLo1/hGykQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mGIDevYB; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739196907; x=1770732907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PPVkgZx+AtQtXQ8oeZE/FkHs7vyn7TFeR6ufEITPCVs=;
  b=mGIDevYBjFz+2C5FkQU12q2XhV22EQHzkc2zeIbJsnmevkHIl2i9FSQI
   DpoJphoqIYL20vyIxMCmQEBlMQz1QmaKiv7VQOyW8b8AQKABKJ4zsE8uc
   Jmjb9j/PjPUEfncFGl5OdJ0hGfxe0fiOll3yuLesge9wUXobM0dmihdiM
   bmdWLLN+wq4P+KZ19rXcOVOVXf7m74w2jA2OWRzsmI/T4cAlOxjc4df56
   ar3lCikgVBaoORbTM+CFApSf2sfU3o5K73tm27PJbFHlRfaWyE4jecN7k
   s6V7HEFomMZW2DkKyuHgMaIggMy+bEw84PP3xjJFrnaifPAJGifNX85J6
   Q==;
X-CSE-ConnectionGUID: oAFJmUPlT3aiqoXeP4ajBg==
X-CSE-MsgGUID: 0HWqjauwRl+rNyMoW1ZkGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="39927469"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="39927469"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 06:15:07 -0800
X-CSE-ConnectionGUID: SU6UcNeeR5+lnQS0hNY1/A==
X-CSE-MsgGUID: rKQrHTaBTvC7OYRAdpVdzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117421090"
Received: from gklab-003-001.igk.intel.com ([10.211.3.1])
  by orviesa005.jf.intel.com with ESMTP; 10 Feb 2025 06:15:04 -0800
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH iwl-next v2 2/3] ice: Refactor E825C PHY registers info struct
Date: Mon, 10 Feb 2025 15:11:11 +0100
Message-Id: <20250210141112.3445723-3-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250210141112.3445723-1-grzegorz.nitka@intel.com>
References: <20250210141112.3445723-1-grzegorz.nitka@intel.com>
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
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  4 +-
 3 files changed, 20 insertions(+), 65 deletions(-)

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
index fbaf2819e40e..89bb8461284a 100644
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
index 8442d1d60351..cca81391b6ad 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -65,14 +65,14 @@ enum ice_eth56g_link_spd {
 
 /**
  * struct ice_phy_reg_info_eth56g - ETH56G PHY register parameters
- * @base: base address for each PHY block
+ * @base_addr: base address for each PHY block
  * @step: step between PHY lanes
  *
  * Characteristic information for the various PHY register parameters in the
  * ETH56G devices
  */
 struct ice_phy_reg_info_eth56g {
-	u32 base[NUM_ETH56G_PHY_RES];
+	u32 base_addr;
 	u32 step;
 };
 
-- 
2.39.3


