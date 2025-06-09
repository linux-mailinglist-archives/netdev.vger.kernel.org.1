Return-Path: <netdev+bounces-195878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64573AD28C1
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 23:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C92F3B3055
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 21:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F341822578E;
	Mon,  9 Jun 2025 21:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="np3MAqtQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EE32253A8
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749504430; cv=none; b=lC5CsKDQAE3lfYLzFmQpzGBUgYeWIZRqmG7eS7f9YDrwvIwmUDoD3IXAr4Ym2N4cfw6o1LAkBjHV5YWPKx36Eqcfd0A8w+B1r1K+a5IvRqFOuCc9Zv/Tq9NBgyl0TmfRSjXm3DAW6QerSqA6ILQfbwvTeznMN+GNDd6Uw87Y7uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749504430; c=relaxed/simple;
	bh=Y9u/sJcyUV4KAT9pMqfiNUMEYY1syoz/3I4d+ZdaPtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6d+wysQ0svstzpH+N8iFGDYVnwOmwkGfW5+Ozv7lHq6HWTxB+lEPVsqLWBAcQdmbHga1vNwws5ua4tDVnR0jrSytEi6l2h6U30P6qmY6ohIh/pzYfu2VOlTUmKbSdy0yQrMhpCgP+qD0WQo10be8Yr7hHvkuW1uPZSrn/CyR10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=np3MAqtQ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749504429; x=1781040429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y9u/sJcyUV4KAT9pMqfiNUMEYY1syoz/3I4d+ZdaPtg=;
  b=np3MAqtQC05407e2eyejC0zcETWaw+kVwTqnNbmuw3puoqITvvneso6E
   gjVP3pamIknT+E6W4PHsbjJeSBoIha+ORYF5qoawfQYWi7rfHVpyIqFvS
   PgBkgn1JMXDUm2dwfB6nTPL54m+yO1zLyeRALSuZEhCskmBxJC7kl9gbQ
   Feq9kp6BOrjVRk7uL41ySzdNT1dQPkHGfbFCWgg1hJ2i/uuOQtyaE+FBY
   rJ+nEaqFJw0dPPhKm8sfL9HdW5WWP2PVZldE0HEPy7XMsqAem0qsoBBdM
   354LNmD/efIzXvNZsyBn8OzOwoSg9/6KCKq7Osv4U4oFDt5P5BvZXbEZL
   w==;
X-CSE-ConnectionGUID: h/Gq+9NGR7aPKiTBL/xhhw==
X-CSE-MsgGUID: h9WVZGdoRGabT1z/2Ge7Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="61864247"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="61864247"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 14:27:08 -0700
X-CSE-ConnectionGUID: ro3WNvHjR3ych4sG5zStzw==
X-CSE-MsgGUID: 5hYJdmbtSFO+klyWejDb6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="150469066"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 09 Jun 2025 14:27:06 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Alok Tiwari <alok.a.tiwari@oracle.com>,
	anthony.l.nguyen@intel.com,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 11/11] ixgbe: Fix typos and clarify comments in X550 driver code
Date: Mon,  9 Jun 2025 14:26:50 -0700
Message-ID: <20250609212652.1138933-12-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250609212652.1138933-1-anthony.l.nguyen@intel.com>
References: <20250609212652.1138933-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alok Tiwari <alok.a.tiwari@oracle.com>

Corrected spelling errors such as "simular" -> "similar",
"excepted" -> "accepted", and "Determime" -> "Determine".
Fixed including incorrect word usage ("to MAC" -> "two MAC")
and improved awkward phrasing.

Aligned function header descriptions with their actual functionality
(e.g., "Writes a value" -> "Reads a value").
Corrected typo in error code from -ENIVAL to -EINVAL.
Improved overall clarity and consistency in comment across various
functions.

These changes improve maintainability and readability of the code
without affecting functionality.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 1d2acdb64f45..7461367a1868 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -20,7 +20,7 @@ static int ixgbe_get_invariants_X550_x(struct ixgbe_hw *hw)
 	struct ixgbe_phy_info *phy = &hw->phy;
 	struct ixgbe_link_info *link = &hw->link;
 
-	/* Start with X540 invariants, since so simular */
+	/* Start with X540 invariants, since so similar */
 	ixgbe_get_invariants_X540(hw);
 
 	if (mac->ops.get_media_type(hw) != ixgbe_media_type_copper)
@@ -48,7 +48,7 @@ static int ixgbe_get_invariants_X550_a(struct ixgbe_hw *hw)
 	struct ixgbe_mac_info *mac = &hw->mac;
 	struct ixgbe_phy_info *phy = &hw->phy;
 
-	/* Start with X540 invariants, since so simular */
+	/* Start with X540 invariants, since so similar */
 	ixgbe_get_invariants_X540(hw);
 
 	if (mac->ops.get_media_type(hw) != ixgbe_media_type_copper)
@@ -685,7 +685,7 @@ static int ixgbe_iosf_wait(struct ixgbe_hw *hw, u32 *ctrl)
 	return 0;
 }
 
-/** ixgbe_read_iosf_sb_reg_x550 - Writes a value to specified register of the
+/** ixgbe_read_iosf_sb_reg_x550 - Reads a value to specified register of the
  *  IOSF device
  *  @hw: pointer to hardware structure
  *  @reg_addr: 32 bit PHY register to write
@@ -847,7 +847,7 @@ static int ixgbe_read_iosf_sb_reg_x550a(struct ixgbe_hw *hw, u32 reg_addr,
 
 /** ixgbe_read_ee_hostif_buffer_X550- Read EEPROM word(s) using hostif
  *  @hw: pointer to hardware structure
- *  @offset: offset of  word in the EEPROM to read
+ *  @offset: offset of word in the EEPROM to read
  *  @words: number of words
  *  @data: word(s) read from the EEPROM
  *
@@ -1253,7 +1253,7 @@ static int ixgbe_get_bus_info_X550em(struct ixgbe_hw *hw)
 
 /**
  * ixgbe_fw_recovery_mode_X550 - Check FW NVM recovery mode
- * @hw: pointer t hardware structure
+ * @hw: pointer to hardware structure
  *
  * Returns true if in FW NVM recovery mode.
  */
@@ -1267,7 +1267,7 @@ static bool ixgbe_fw_recovery_mode_X550(struct ixgbe_hw *hw)
 
 /** ixgbe_disable_rx_x550 - Disable RX unit
  *
- *  Enables the Rx DMA unit for x550
+ *  Disables the Rx DMA unit for x550
  **/
 static void ixgbe_disable_rx_x550(struct ixgbe_hw *hw)
 {
@@ -1754,7 +1754,7 @@ ixgbe_setup_mac_link_sfp_n(struct ixgbe_hw *hw, ixgbe_link_speed speed,
 	ret_val = ixgbe_supported_sfp_modules_X550em(hw, &setup_linear);
 
 	/* If no SFP module present, then return success. Return success since
-	 * SFP not present error is not excepted in the setup MAC link flow.
+	 * SFP not present error is not accepted in the setup MAC link flow.
 	 */
 	if (ret_val == -ENOENT)
 		return 0;
@@ -1804,7 +1804,7 @@ ixgbe_setup_mac_link_sfp_x550a(struct ixgbe_hw *hw, ixgbe_link_speed speed,
 	ret_val = ixgbe_supported_sfp_modules_X550em(hw, &setup_linear);
 
 	/* If no SFP module present, then return success. Return success since
-	 * SFP not present error is not excepted in the setup MAC link flow.
+	 * SFP not present error is not accepted in the setup MAC link flow.
 	 */
 	if (ret_val == -ENOENT)
 		return 0;
@@ -2324,7 +2324,7 @@ static int ixgbe_get_link_capabilities_X550em(struct ixgbe_hw *hw,
  *	 PHY interrupt is lsc
  * @is_overtemp: indicate whether an overtemp event encountered
  *
- * Determime if external Base T PHY interrupt cause is high temperature
+ * Determine if external Base T PHY interrupt cause is high temperature
  * failure alarm or link status change.
  **/
 static int ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc,
@@ -2669,7 +2669,7 @@ static int ixgbe_setup_internal_phy_t_x550em(struct ixgbe_hw *hw)
 	if (status)
 		return status;
 
-	/* If link is not still up, then no setup is necessary so return */
+	/* If the link is still not up, no setup is necessary */
 	status = ixgbe_ext_phy_t_x550em_get_link(hw, &link_up);
 	if (status)
 		return status;
@@ -2768,7 +2768,7 @@ static int ixgbe_led_off_t_x550em(struct ixgbe_hw *hw, u32 led_idx)
  *  Sends driver version number to firmware through the manageability
  *  block.  On success return 0
  *  else returns -EBUSY when encountering an error acquiring
- *  semaphore, -EIO when command fails or -ENIVAL when incorrect
+ *  semaphore, -EIO when command fails or -EINVAL when incorrect
  *  params passed.
  **/
 int ixgbe_set_fw_drv_ver_x550(struct ixgbe_hw *hw, u8 maj, u8 min,
@@ -3175,7 +3175,7 @@ static void ixgbe_read_mng_if_sel_x550em(struct ixgbe_hw *hw)
 	hw->phy.nw_mng_if_sel = IXGBE_READ_REG(hw, IXGBE_NW_MNG_IF_SEL);
 
 	/* If X552 (X550EM_a) and MDIO is connected to external PHY, then set
-	 * PHY address. This register field was has only been used for X552.
+	 * PHY address. This register field has only been used for X552.
 	 */
 	if (hw->mac.type == ixgbe_mac_x550em_a &&
 	    hw->phy.nw_mng_if_sel & IXGBE_NW_MNG_IF_SEL_MDIO_ACT) {
@@ -3735,7 +3735,7 @@ static int ixgbe_acquire_swfw_sync_x550em_a(struct ixgbe_hw *hw, u32 mask)
  * @hw: pointer to hardware structure
  * @mask: Mask to specify which semaphore to release
  *
- * Release the SWFW semaphore and puts the shared PHY token as needed
+ * Release the SWFW semaphore and puts back the shared PHY token as needed
  */
 static void ixgbe_release_swfw_sync_x550em_a(struct ixgbe_hw *hw, u32 mask)
 {
@@ -3756,7 +3756,7 @@ static void ixgbe_release_swfw_sync_x550em_a(struct ixgbe_hw *hw, u32 mask)
  * @phy_data: Pointer to read data from PHY register
  *
  * Reads a value from a specified PHY register using the SWFW lock and PHY
- * Token. The PHY Token is needed since the MDIO is shared between to MAC
+ * Token. The PHY Token is needed since the MDIO is shared between two MAC
  * instances.
  */
 static int ixgbe_read_phy_reg_x550a(struct ixgbe_hw *hw, u32 reg_addr,
-- 
2.47.1


