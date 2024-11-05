Return-Path: <netdev+bounces-142119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A35B09BD880
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 23:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348441F21352
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 22:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9142170B6;
	Tue,  5 Nov 2024 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GyWebpgv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B282216DF2
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 22:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730845449; cv=none; b=WtqLsBNi2AeqAOG6NrKAL9drPzdprXfFUE/7Xb4gDh36PyGMNbBv15iogvHj3Xbz4jpKmhuRfAiSOgWra7t1UcDDVqW4lN7Sfs8RAFY3tcDUEUeBo25iaj0/ES56VezQh083uJ3rSVcWyzzSPJoQ3Teaj5nyZUgDssYuMZPp4go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730845449; c=relaxed/simple;
	bh=POPtQA4z4W0eeC2oRwOmJW+kOiHy0ZDICENVatY2/Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJnqYI/8RfekjvrEVq2NvlC9C2LWaNQLLREnvfVlNoYCSFFgpAAreMY06cj04KiiSzGtAW24k+74fRcPfj0DRQAq3mKQKvp5LWunBca/ScZGdG00a8AlJx7LJMxhntA+T+Y9BNNEgjB0lkOSIyYJquBun9tmPToR+BJqEwC1Sww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GyWebpgv; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730845448; x=1762381448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=POPtQA4z4W0eeC2oRwOmJW+kOiHy0ZDICENVatY2/Zs=;
  b=GyWebpgvhdXUcojeLDoQdtI97W7ByDQdIOxt6wspK16vmzHANX7bZ4zd
   xzuLUXbMP9d+OGjG+oO/BQ9fP+lR8zYr49S/bRiTsQI84vQW0OBcaEL4G
   RQRMjt2nxvUlqVA6XdEIyy7e39dRx3Kozq1HyEpVPuNRfOXHSTIDjmG+o
   8duRMLp3rotmvXnsWlqJmcM7pC4COSCyz8se835NpBZbuC7hMv1kuMNJq
   4c3WhO5QwnGVe/P8unLXtPOmUDJ3yENhM9zeOjgHqj7z6TiE9hdpteHux
   uAJkkwJf8RQURROc3p7kTQv5At5UsGSpVBQ1Es+D3Aatqoz4vq3RS9mKn
   w==;
X-CSE-ConnectionGUID: ZpxB4cgITMapHn2HrpfAPg==
X-CSE-MsgGUID: XOem1xatSvu6FVyiODPHqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34314321"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34314321"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 14:24:02 -0800
X-CSE-ConnectionGUID: YDUUg1MyQB+yx3q7XKG72Q==
X-CSE-MsgGUID: uxtwq+h6QzmEZjLCQPwucg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="84322470"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 05 Nov 2024 14:24:01 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Vitaly Lifshits <vitaly.lifshits@intel.com>,
	anthony.l.nguyen@intel.com,
	dima.ruinskiy@intel.com,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net-next 12/15] igc: remove autoneg parameter from igc_mac_info
Date: Tue,  5 Nov 2024 14:23:46 -0800
Message-ID: <20241105222351.3320587-13-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241105222351.3320587-1-anthony.l.nguyen@intel.com>
References: <20241105222351.3320587-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vitaly Lifshits <vitaly.lifshits@intel.com>

Since the igc driver doesn't support forced speed configuration and
its current related hardware doesn't support it either, there is no
use of the mac.autoneg parameter. Moreover, in one case this usage
might result in a NULL pointer dereference due to an uninitialized
function pointer, phy.ops.force_speed_duplex.

Therefore, remove this parameter from the igc code.

Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_diag.c    |   3 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c |  13 +-
 drivers/net/ethernet/intel/igc/igc_hw.h      |   1 -
 drivers/net/ethernet/intel/igc/igc_mac.c     | 316 +++++++++----------
 drivers/net/ethernet/intel/igc/igc_main.c    |   1 -
 drivers/net/ethernet/intel/igc/igc_phy.c     |  24 +-
 6 files changed, 163 insertions(+), 195 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_diag.c b/drivers/net/ethernet/intel/igc/igc_diag.c
index cc621970c0cd..a43d7244ee70 100644
--- a/drivers/net/ethernet/intel/igc/igc_diag.c
+++ b/drivers/net/ethernet/intel/igc/igc_diag.c
@@ -173,8 +173,7 @@ bool igc_link_test(struct igc_adapter *adapter, u64 *data)
 	*data = 0;
 
 	/* add delay to give enough time for autonegotioation to finish */
-	if (adapter->hw.mac.autoneg)
-		ssleep(5);
+	ssleep(5);
 
 	link_up = igc_has_link(adapter);
 	if (!link_up) {
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 5b0c6f433767..817838677817 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1821,11 +1821,8 @@ static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
 		ethtool_link_ksettings_add_link_mode(cmd, advertising, 2500baseT_Full);
 
 	/* set autoneg settings */
-	if (hw->mac.autoneg == 1) {
-		ethtool_link_ksettings_add_link_mode(cmd, supported, Autoneg);
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
-						     Autoneg);
-	}
+	ethtool_link_ksettings_add_link_mode(cmd, supported, Autoneg);
+	ethtool_link_ksettings_add_link_mode(cmd, advertising, Autoneg);
 
 	/* Set pause flow control settings */
 	ethtool_link_ksettings_add_link_mode(cmd, supported, Pause);
@@ -1878,10 +1875,7 @@ static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
 		cmd->base.duplex = DUPLEX_UNKNOWN;
 	}
 	cmd->base.speed = speed;
-	if (hw->mac.autoneg)
-		cmd->base.autoneg = AUTONEG_ENABLE;
-	else
-		cmd->base.autoneg = AUTONEG_DISABLE;
+	cmd->base.autoneg = AUTONEG_ENABLE;
 
 	/* MDI-X => 2; MDI =>1; Invalid =>0 */
 	if (hw->phy.media_type == igc_media_type_copper)
@@ -1955,7 +1949,6 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
 		advertised |= ADVERTISE_10_HALF;
 
 	if (cmd->base.autoneg == AUTONEG_ENABLE) {
-		hw->mac.autoneg = 1;
 		hw->phy.autoneg_advertised = advertised;
 		if (adapter->fc_autoneg)
 			hw->fc.requested_mode = igc_fc_default;
diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
index e1c572e0d4ef..d9d1a1a11daf 100644
--- a/drivers/net/ethernet/intel/igc/igc_hw.h
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -92,7 +92,6 @@ struct igc_mac_info {
 	bool asf_firmware_present;
 	bool arc_subsystem_valid;
 
-	bool autoneg;
 	bool autoneg_failed;
 	bool get_link_status;
 };
diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ethernet/intel/igc/igc_mac.c
index a5c4b19d71a2..d344e0a1cd5e 100644
--- a/drivers/net/ethernet/intel/igc/igc_mac.c
+++ b/drivers/net/ethernet/intel/igc/igc_mac.c
@@ -386,14 +386,6 @@ s32 igc_check_for_copper_link(struct igc_hw *hw)
 	 */
 	igc_check_downshift(hw);
 
-	/* If we are forcing speed/duplex, then we simply return since
-	 * we have already determined whether we have link or not.
-	 */
-	if (!mac->autoneg) {
-		ret_val = -IGC_ERR_CONFIG;
-		goto out;
-	}
-
 	/* Auto-Neg is enabled.  Auto Speed Detection takes care
 	 * of MAC speed/duplex configuration.  So we only need to
 	 * configure Collision Distance in the MAC.
@@ -468,173 +460,171 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
 		goto out;
 	}
 
-	/* Check for the case where we have copper media and auto-neg is
-	 * enabled.  In this case, we need to check and see if Auto-Neg
-	 * has completed, and if so, how the PHY and link partner has
-	 * flow control configured.
+	/* In auto-neg, we need to check and see if Auto-Neg has completed,
+	 * and if so, how the PHY and link partner has flow control
+	 * configured.
 	 */
-	if (mac->autoneg) {
-		/* Read the MII Status Register and check to see if AutoNeg
-		 * has completed.  We read this twice because this reg has
-		 * some "sticky" (latched) bits.
-		 */
-		ret_val = hw->phy.ops.read_reg(hw, PHY_STATUS,
-					       &mii_status_reg);
-		if (ret_val)
-			goto out;
-		ret_val = hw->phy.ops.read_reg(hw, PHY_STATUS,
-					       &mii_status_reg);
-		if (ret_val)
-			goto out;
 
-		if (!(mii_status_reg & MII_SR_AUTONEG_COMPLETE)) {
-			hw_dbg("Copper PHY and Auto Neg has not completed.\n");
-			goto out;
-		}
+	/* Read the MII Status Register and check to see if AutoNeg
+	 * has completed.  We read this twice because this reg has
+	 * some "sticky" (latched) bits.
+	 */
+	ret_val = hw->phy.ops.read_reg(hw, PHY_STATUS,
+				       &mii_status_reg);
+	if (ret_val)
+		goto out;
+	ret_val = hw->phy.ops.read_reg(hw, PHY_STATUS,
+				       &mii_status_reg);
+	if (ret_val)
+		goto out;
 
-		/* The AutoNeg process has completed, so we now need to
-		 * read both the Auto Negotiation Advertisement
-		 * Register (Address 4) and the Auto_Negotiation Base
-		 * Page Ability Register (Address 5) to determine how
-		 * flow control was negotiated.
-		 */
-		ret_val = hw->phy.ops.read_reg(hw, PHY_AUTONEG_ADV,
-					       &mii_nway_adv_reg);
-		if (ret_val)
-			goto out;
-		ret_val = hw->phy.ops.read_reg(hw, PHY_LP_ABILITY,
-					       &mii_nway_lp_ability_reg);
-		if (ret_val)
-			goto out;
-		/* Two bits in the Auto Negotiation Advertisement Register
-		 * (Address 4) and two bits in the Auto Negotiation Base
-		 * Page Ability Register (Address 5) determine flow control
-		 * for both the PHY and the link partner.  The following
-		 * table, taken out of the IEEE 802.3ab/D6.0 dated March 25,
-		 * 1999, describes these PAUSE resolution bits and how flow
-		 * control is determined based upon these settings.
-		 * NOTE:  DC = Don't Care
-		 *
-		 *   LOCAL DEVICE  |   LINK PARTNER
-		 * PAUSE | ASM_DIR | PAUSE | ASM_DIR | NIC Resolution
-		 *-------|---------|-------|---------|--------------------
-		 *   0   |    0    |  DC   |   DC    | igc_fc_none
-		 *   0   |    1    |   0   |   DC    | igc_fc_none
-		 *   0   |    1    |   1   |    0    | igc_fc_none
-		 *   0   |    1    |   1   |    1    | igc_fc_tx_pause
-		 *   1   |    0    |   0   |   DC    | igc_fc_none
-		 *   1   |   DC    |   1   |   DC    | igc_fc_full
-		 *   1   |    1    |   0   |    0    | igc_fc_none
-		 *   1   |    1    |   0   |    1    | igc_fc_rx_pause
-		 *
-		 * Are both PAUSE bits set to 1?  If so, this implies
-		 * Symmetric Flow Control is enabled at both ends.  The
-		 * ASM_DIR bits are irrelevant per the spec.
-		 *
-		 * For Symmetric Flow Control:
-		 *
-		 *   LOCAL DEVICE  |   LINK PARTNER
-		 * PAUSE | ASM_DIR | PAUSE | ASM_DIR | Result
-		 *-------|---------|-------|---------|--------------------
-		 *   1   |   DC    |   1   |   DC    | IGC_fc_full
-		 *
-		 */
-		if ((mii_nway_adv_reg & NWAY_AR_PAUSE) &&
-		    (mii_nway_lp_ability_reg & NWAY_LPAR_PAUSE)) {
-			/* Now we need to check if the user selected RX ONLY
-			 * of pause frames.  In this case, we had to advertise
-			 * FULL flow control because we could not advertise RX
-			 * ONLY. Hence, we must now check to see if we need to
-			 * turn OFF  the TRANSMISSION of PAUSE frames.
-			 */
-			if (hw->fc.requested_mode == igc_fc_full) {
-				hw->fc.current_mode = igc_fc_full;
-				hw_dbg("Flow Control = FULL.\n");
-			} else {
-				hw->fc.current_mode = igc_fc_rx_pause;
-				hw_dbg("Flow Control = RX PAUSE frames only.\n");
-			}
-		}
+	if (!(mii_status_reg & MII_SR_AUTONEG_COMPLETE)) {
+		hw_dbg("Copper PHY and Auto Neg has not completed.\n");
+		goto out;
+	}
 
-		/* For receiving PAUSE frames ONLY.
-		 *
-		 *   LOCAL DEVICE  |   LINK PARTNER
-		 * PAUSE | ASM_DIR | PAUSE | ASM_DIR | Result
-		 *-------|---------|-------|---------|--------------------
-		 *   0   |    1    |   1   |    1    | igc_fc_tx_pause
-		 */
-		else if (!(mii_nway_adv_reg & NWAY_AR_PAUSE) &&
-			 (mii_nway_adv_reg & NWAY_AR_ASM_DIR) &&
-			 (mii_nway_lp_ability_reg & NWAY_LPAR_PAUSE) &&
-			 (mii_nway_lp_ability_reg & NWAY_LPAR_ASM_DIR)) {
-			hw->fc.current_mode = igc_fc_tx_pause;
-			hw_dbg("Flow Control = TX PAUSE frames only.\n");
-		}
-		/* For transmitting PAUSE frames ONLY.
-		 *
-		 *   LOCAL DEVICE  |   LINK PARTNER
-		 * PAUSE | ASM_DIR | PAUSE | ASM_DIR | Result
-		 *-------|---------|-------|---------|--------------------
-		 *   1   |    1    |   0   |    1    | igc_fc_rx_pause
-		 */
-		else if ((mii_nway_adv_reg & NWAY_AR_PAUSE) &&
-			 (mii_nway_adv_reg & NWAY_AR_ASM_DIR) &&
-			 !(mii_nway_lp_ability_reg & NWAY_LPAR_PAUSE) &&
-			 (mii_nway_lp_ability_reg & NWAY_LPAR_ASM_DIR)) {
-			hw->fc.current_mode = igc_fc_rx_pause;
-			hw_dbg("Flow Control = RX PAUSE frames only.\n");
-		}
-		/* Per the IEEE spec, at this point flow control should be
-		 * disabled.  However, we want to consider that we could
-		 * be connected to a legacy switch that doesn't advertise
-		 * desired flow control, but can be forced on the link
-		 * partner.  So if we advertised no flow control, that is
-		 * what we will resolve to.  If we advertised some kind of
-		 * receive capability (Rx Pause Only or Full Flow Control)
-		 * and the link partner advertised none, we will configure
-		 * ourselves to enable Rx Flow Control only.  We can do
-		 * this safely for two reasons:  If the link partner really
-		 * didn't want flow control enabled, and we enable Rx, no
-		 * harm done since we won't be receiving any PAUSE frames
-		 * anyway.  If the intent on the link partner was to have
-		 * flow control enabled, then by us enabling RX only, we
-		 * can at least receive pause frames and process them.
-		 * This is a good idea because in most cases, since we are
-		 * predominantly a server NIC, more times than not we will
-		 * be asked to delay transmission of packets than asking
-		 * our link partner to pause transmission of frames.
+	/* The AutoNeg process has completed, so we now need to
+	 * read both the Auto Negotiation Advertisement
+	 * Register (Address 4) and the Auto_Negotiation Base
+	 * Page Ability Register (Address 5) to determine how
+	 * flow control was negotiated.
+	 */
+	ret_val = hw->phy.ops.read_reg(hw, PHY_AUTONEG_ADV,
+				       &mii_nway_adv_reg);
+	if (ret_val)
+		goto out;
+	ret_val = hw->phy.ops.read_reg(hw, PHY_LP_ABILITY,
+				       &mii_nway_lp_ability_reg);
+	if (ret_val)
+		goto out;
+	/* Two bits in the Auto Negotiation Advertisement Register
+	 * (Address 4) and two bits in the Auto Negotiation Base
+	 * Page Ability Register (Address 5) determine flow control
+	 * for both the PHY and the link partner.  The following
+	 * table, taken out of the IEEE 802.3ab/D6.0 dated March 25,
+	 * 1999, describes these PAUSE resolution bits and how flow
+	 * control is determined based upon these settings.
+	 * NOTE:  DC = Don't Care
+	 *
+	 *   LOCAL DEVICE  |   LINK PARTNER
+	 * PAUSE | ASM_DIR | PAUSE | ASM_DIR | NIC Resolution
+	 *-------|---------|-------|---------|--------------------
+	 *   0   |    0    |  DC   |   DC    | igc_fc_none
+	 *   0   |    1    |   0   |   DC    | igc_fc_none
+	 *   0   |    1    |   1   |    0    | igc_fc_none
+	 *   0   |    1    |   1   |    1    | igc_fc_tx_pause
+	 *   1   |    0    |   0   |   DC    | igc_fc_none
+	 *   1   |   DC    |   1   |   DC    | igc_fc_full
+	 *   1   |    1    |   0   |    0    | igc_fc_none
+	 *   1   |    1    |   0   |    1    | igc_fc_rx_pause
+	 *
+	 * Are both PAUSE bits set to 1?  If so, this implies
+	 * Symmetric Flow Control is enabled at both ends.  The
+	 * ASM_DIR bits are irrelevant per the spec.
+	 *
+	 * For Symmetric Flow Control:
+	 *
+	 *   LOCAL DEVICE  |   LINK PARTNER
+	 * PAUSE | ASM_DIR | PAUSE | ASM_DIR | Result
+	 *-------|---------|-------|---------|--------------------
+	 *   1   |   DC    |   1   |   DC    | IGC_fc_full
+	 *
+	 */
+	if ((mii_nway_adv_reg & NWAY_AR_PAUSE) &&
+	    (mii_nway_lp_ability_reg & NWAY_LPAR_PAUSE)) {
+		/* Now we need to check if the user selected RX ONLY
+		 * of pause frames.  In this case, we had to advertise
+		 * FULL flow control because we could not advertise RX
+		 * ONLY. Hence, we must now check to see if we need to
+		 * turn OFF  the TRANSMISSION of PAUSE frames.
 		 */
-		else if ((hw->fc.requested_mode == igc_fc_none) ||
-			 (hw->fc.requested_mode == igc_fc_tx_pause) ||
-			 (hw->fc.strict_ieee)) {
-			hw->fc.current_mode = igc_fc_none;
-			hw_dbg("Flow Control = NONE.\n");
+		if (hw->fc.requested_mode == igc_fc_full) {
+			hw->fc.current_mode = igc_fc_full;
+			hw_dbg("Flow Control = FULL.\n");
 		} else {
 			hw->fc.current_mode = igc_fc_rx_pause;
 			hw_dbg("Flow Control = RX PAUSE frames only.\n");
 		}
+	}
 
-		/* Now we need to do one last check...  If we auto-
-		 * negotiated to HALF DUPLEX, flow control should not be
-		 * enabled per IEEE 802.3 spec.
-		 */
-		ret_val = hw->mac.ops.get_speed_and_duplex(hw, &speed, &duplex);
-		if (ret_val) {
-			hw_dbg("Error getting link speed and duplex\n");
-			goto out;
-		}
+	/* For receiving PAUSE frames ONLY.
+	 *
+	 *   LOCAL DEVICE  |   LINK PARTNER
+	 * PAUSE | ASM_DIR | PAUSE | ASM_DIR | Result
+	 *-------|---------|-------|---------|--------------------
+	 *   0   |    1    |   1   |    1    | igc_fc_tx_pause
+	 */
+	else if (!(mii_nway_adv_reg & NWAY_AR_PAUSE) &&
+		 (mii_nway_adv_reg & NWAY_AR_ASM_DIR) &&
+		 (mii_nway_lp_ability_reg & NWAY_LPAR_PAUSE) &&
+		 (mii_nway_lp_ability_reg & NWAY_LPAR_ASM_DIR)) {
+		hw->fc.current_mode = igc_fc_tx_pause;
+		hw_dbg("Flow Control = TX PAUSE frames only.\n");
+	}
+	/* For transmitting PAUSE frames ONLY.
+	 *
+	 *   LOCAL DEVICE  |   LINK PARTNER
+	 * PAUSE | ASM_DIR | PAUSE | ASM_DIR | Result
+	 *-------|---------|-------|---------|--------------------
+	 *   1   |    1    |   0   |    1    | igc_fc_rx_pause
+	 */
+	else if ((mii_nway_adv_reg & NWAY_AR_PAUSE) &&
+		 (mii_nway_adv_reg & NWAY_AR_ASM_DIR) &&
+		 !(mii_nway_lp_ability_reg & NWAY_LPAR_PAUSE) &&
+		 (mii_nway_lp_ability_reg & NWAY_LPAR_ASM_DIR)) {
+		hw->fc.current_mode = igc_fc_rx_pause;
+		hw_dbg("Flow Control = RX PAUSE frames only.\n");
+	}
+	/* Per the IEEE spec, at this point flow control should be
+	 * disabled.  However, we want to consider that we could
+	 * be connected to a legacy switch that doesn't advertise
+	 * desired flow control, but can be forced on the link
+	 * partner.  So if we advertised no flow control, that is
+	 * what we will resolve to.  If we advertised some kind of
+	 * receive capability (Rx Pause Only or Full Flow Control)
+	 * and the link partner advertised none, we will configure
+	 * ourselves to enable Rx Flow Control only.  We can do
+	 * this safely for two reasons:  If the link partner really
+	 * didn't want flow control enabled, and we enable Rx, no
+	 * harm done since we won't be receiving any PAUSE frames
+	 * anyway.  If the intent on the link partner was to have
+	 * flow control enabled, then by us enabling RX only, we
+	 * can at least receive pause frames and process them.
+	 * This is a good idea because in most cases, since we are
+	 * predominantly a server NIC, more times than not we will
+	 * be asked to delay transmission of packets than asking
+	 * our link partner to pause transmission of frames.
+	 */
+	else if ((hw->fc.requested_mode == igc_fc_none) ||
+		 (hw->fc.requested_mode == igc_fc_tx_pause) ||
+		 (hw->fc.strict_ieee)) {
+		hw->fc.current_mode = igc_fc_none;
+		hw_dbg("Flow Control = NONE.\n");
+	} else {
+		hw->fc.current_mode = igc_fc_rx_pause;
+		hw_dbg("Flow Control = RX PAUSE frames only.\n");
+	}
 
-		if (duplex == HALF_DUPLEX)
-			hw->fc.current_mode = igc_fc_none;
+	/* Now we need to do one last check...  If we auto-
+	 * negotiated to HALF DUPLEX, flow control should not be
+	 * enabled per IEEE 802.3 spec.
+	 */
+	ret_val = hw->mac.ops.get_speed_and_duplex(hw, &speed, &duplex);
+	if (ret_val) {
+		hw_dbg("Error getting link speed and duplex\n");
+		goto out;
+	}
 
-		/* Now we call a subroutine to actually force the MAC
-		 * controller to use the correct flow control settings.
-		 */
-		ret_val = igc_force_mac_fc(hw);
-		if (ret_val) {
-			hw_dbg("Error forcing flow control settings\n");
-			goto out;
-		}
+	if (duplex == HALF_DUPLEX)
+		hw->fc.current_mode = igc_fc_none;
+
+	/* Now we call a subroutine to actually force the MAC
+	 * controller to use the correct flow control settings.
+	 */
+	ret_val = igc_force_mac_fc(hw);
+	if (ret_val) {
+		hw_dbg("Error forcing flow control settings\n");
+		goto out;
 	}
 
 out:
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 6e70bca15db1..27872bdea9bd 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7108,7 +7108,6 @@ static int igc_probe(struct pci_dev *pdev,
 
 	/* Initialize link properties that are user-changeable */
 	adapter->fc_autoneg = true;
-	hw->mac.autoneg = true;
 	hw->phy.autoneg_advertised = 0xaf;
 
 	hw->fc.requested_mode = igc_fc_default;
diff --git a/drivers/net/ethernet/intel/igc/igc_phy.c b/drivers/net/ethernet/intel/igc/igc_phy.c
index 2801e5f24df9..6c4d204aecfa 100644
--- a/drivers/net/ethernet/intel/igc/igc_phy.c
+++ b/drivers/net/ethernet/intel/igc/igc_phy.c
@@ -494,24 +494,12 @@ s32 igc_setup_copper_link(struct igc_hw *hw)
 	s32 ret_val = 0;
 	bool link;
 
-	if (hw->mac.autoneg) {
-		/* Setup autoneg and flow control advertisement and perform
-		 * autonegotiation.
-		 */
-		ret_val = igc_copper_link_autoneg(hw);
-		if (ret_val)
-			goto out;
-	} else {
-		/* PHY will be set to 10H, 10F, 100H or 100F
-		 * depending on user settings.
-		 */
-		hw_dbg("Forcing Speed and Duplex\n");
-		ret_val = hw->phy.ops.force_speed_duplex(hw);
-		if (ret_val) {
-			hw_dbg("Error Forcing Speed and Duplex\n");
-			goto out;
-		}
-	}
+	/* Setup autoneg and flow control advertisement and perform
+	 * autonegotiation.
+	 */
+	ret_val = igc_copper_link_autoneg(hw);
+	if (ret_val)
+		goto out;
 
 	/* Check link status. Wait up to 100 microseconds for link to become
 	 * valid.
-- 
2.42.0


