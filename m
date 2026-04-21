Return-Path: <netdev+bounces-279960-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uK3RLEXK5ml40wEAu9opvQ
	(envelope-from <netdev+bounces-279960-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 02:52:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDFF4352BD
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 02:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E35863006238
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 00:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612211E8342;
	Tue, 21 Apr 2026 00:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="axkhj9Aj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF27C19D092
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 00:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776732729; cv=none; b=BYTfPUyKX55hp+jzfsDHbYa3ef/0w/IKeYYvBxlyKrREB6Y6ZQRrbGv77iYIzkzrw0fXodzEaZwe6ZpVGzAeQoxyzjUCynQU6JPsGG09eCVgVg/zM8CeQ6njIHpHoiQDWGeSXcbbwyU/QomQwNVzCJk3LO0h0iZRxLVq2I1mJBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776732729; c=relaxed/simple;
	bh=j2d3MsNh3px46DglOEiO8g/YXsWGAylIvQuJ9FXV13g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LsiqNnu11ejf8qI8HgkqbYpvk+WQm1mtgWsGV150OYD7KUGfZiwhqRT820fTgiWlBwP7z3N87FBMvBeG06/DBPjDjNcHeyh7BP5jplLmZWMFFtoKboLYlKU3BR3xDg4FvQTzBc1PmY/rdyWSxFBKKoRiTKxs069ibFkoqKRUDhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=axkhj9Aj; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776732727; x=1808268727;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=j2d3MsNh3px46DglOEiO8g/YXsWGAylIvQuJ9FXV13g=;
  b=axkhj9AjheUeWed9yWk8bMdqSwfY5tD8IGwNU4SFXfyu5e8ktkCoj5Uz
   IErVtryT/JYWLR0ZvpX+0CgfxRws40g9LYIohBgMGX+kOZk9tcezvnjV/
   AJCnnXxnMynfAaMjB7R5ih++P9YEs1KB/oz11xI5y7qA9Cfmb2Hnd45pd
   Fd320sy6cVtFbcJeBAkkRukOBBJJnG+7+mYhCdzQ6GjRP6CovboHg9dPh
   z8RCX1huugEpjYMgAWUcVHxEPWtnC84od5Roc4kCLXizTeHf2Bl+dPhDA
   4voDtxYTp880x/ELbKJs3YUc06qVjRXm2sCmmPAsrXK8E1sOWWdaa5Ks6
   g==;
X-CSE-ConnectionGUID: DiDuFW5EQXywcIiskmF6ig==
X-CSE-MsgGUID: 5z9+RRhPTb66DLLtiDPTiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77530403"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="77530403"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 17:52:04 -0700
X-CSE-ConnectionGUID: 5CxgIRtwTKuVUVMT3VCopw==
X-CSE-MsgGUID: fOTCi3eaRy6V3dnqz2yI+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="235886666"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 17:52:04 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 20 Apr 2026 17:51:26 -0700
Subject: [PATCH net 2/4] ice: perform PHY soft reset for E825C ports at
 initialization
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-jk-iwl-net-2026-04-20-ptp-e825c-phy-interrupt-fixes-v1-2-bc2240f42251@intel.com>
References: <20260420-jk-iwl-net-2026-04-20-ptp-e825c-phy-interrupt-fixes-v1-0-bc2240f42251@intel.com>
In-Reply-To: <20260420-jk-iwl-net-2026-04-20-ptp-e825c-phy-interrupt-fixes-v1-0-bc2240f42251@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Timothy Miskell <timothy.miskell@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Petr Oros <poros@redhat.com>, Sunitha Mekala <sunithax.d.mekala@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=7742;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=Wmq2AmsdT9Xcyn36ezqoFijUwREEJFwK31Ar+dg16+Y=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsxnp4xvmL/9cfRDiwXblYebEmOXOkbunLXtilnFXMkfK
 mtagrYxd5SyMIhxMciKKbIoOISsvG48IUzrjbMczBxWJpAhDFycAjCRinCG/xGdFRvMjrA4Omya
 GZh/7RLPtKPxGfp/45/q61i+3FGqvIaR4UFWmV/R4Yxptx++fbkid+GlI/vS95dMuF305fe76QX
 TXnEAAA==
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279960-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: CDDFF4352BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

In some cases the PHY timestamp block of the E825C can become stuck. This
is known to occur if the software writes 0 to the Tx timestamp threshold,
and with older versions of the ice driver the threshold configuration is
buggy and can race in such that hardware briefly operates with a zero
threshold enabled. There are no other known ways to trigger this behavior,
but once it occurs, the hardware is not recovered by normal reset, a driver
reload, or even a warm power cycle of the system. A cold power cycle is
sufficient to recover hardware, but this is extremely invasive and can
result in significant downtime on customer deployments.

The PHY for each port has a timestamping block which has its own reset
functionality accessible by programming the PHY_REG_GLOBAL register.
Writing to the PHY_REG_GLOBAL_SOFT_RESET_BIT triggers the hardware to
perform a complete reset of the timestamping block of the PHY. This
includes clearing the timestamp status for the port, clearing all
outstanding timestamps in the memory bank, and resetting the PHY timer.

The new ice_ptp_phy_soft_reset_eth56g() function toggles the
PHY_REG_GLOBAL soft reset bit with the required delays, ensuring the
PHY is properly reinitialized without requiring a full device reset.
The sequence clears the reset bit, asserts it, then clears it again,
with short waits between transitions to allow hardware stabilization.

Call this function in the new ice_ptp_init_phc_e825c(), implementing the
E825C device specific variant of the ice_ptp_init_phc(). Note that if
ice_ptp_init_phc() fails, PTP functionality may be disabled, but the driver
will still load to allow basic functionality to continue.

This causes the clock owning PF driver to perform a PHY soft reset for
every port during initialization. This ensures the driver begins life in a
known functional state regardless of how it was previously programmed.

This ensures that we properly reconfigure the hardware after a device reset
or when loading the driver, even if it was previously misconfigured with an
out-of-date or modified driver.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Signed-off-by: Timothy Miskell <timothy.miskell@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Petr Oros <poros@redhat.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  4 ++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 90 ++++++++++++++++++++++++++++-
 2 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 9bfd3e79c580..ac4611291052 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -374,6 +374,7 @@ int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port, bool soft_reset);
 int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port);
 int ice_phy_cfg_intr_eth56g(struct ice_hw *hw, u8 port, bool ena, u8 threshold);
 int ice_phy_cfg_ptp_1step_eth56g(struct ice_hw *hw, u8 port);
+int ice_ptp_phy_soft_reset_eth56g(struct ice_hw *hw, u8 port);
 
 #define ICE_ETH56G_NOMINAL_INCVAL	0x140000000ULL
 #define ICE_ETH56G_NOMINAL_PCS_REF_TUS	0x100000000ULL
@@ -676,6 +677,9 @@ static inline u64 ice_get_base_incval(struct ice_hw *hw)
 #define ICE_P0_GNSS_PRSNT_N	BIT(4)
 
 /* ETH56G PHY register addresses */
+#define PHY_REG_GLOBAL			0x0
+#define PHY_REG_GLOBAL_SOFT_RESET_M	BIT(11)
+
 /* Timestamp PHY incval registers */
 #define PHY_REG_TIMETUS_L		0x8
 #define PHY_REG_TIMETUS_U		0xC
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 7f2f7440e705..d4c2bb084255 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -377,6 +377,31 @@ static void ice_ptp_cfg_sync_delay(const struct ice_hw *hw, u32 delay)
  * The following functions operate on devices with the ETH 56G PHY.
  */
 
+/**
+ * ice_ptp_init_phc_e825c - Perform E825C specific PHC initialization
+ * @hw: pointer to HW struct
+ *
+ * Perform E825C-specific PTP hardware clock initialization steps.
+ *
+ * Return: 0 on success, or a negative error value on failure.
+ */
+static int ice_ptp_init_phc_e825c(struct ice_hw *hw)
+{
+	int err;
+
+	/* Soft reset all ports, to ensure everything is at a clean state */
+	for (int port = 0; port < hw->ptp.num_lports; port++) {
+		err = ice_ptp_phy_soft_reset_eth56g(hw, port);
+		if (err) {
+			ice_debug(hw, ICE_DBG_PTP, "Failed to soft reset port %d, err %d\n",
+				  port, err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * ice_ptp_get_dest_dev_e825 - get destination PHY for given port number
  * @hw: pointer to the HW struct
@@ -2179,6 +2204,69 @@ int ice_ptp_read_tx_hwtstamp_status_eth56g(struct ice_hw *hw, u32 *ts_status)
 	return 0;
 }
 
+/**
+ * ice_ptp_phy_soft_reset_eth56g - Perform a PHY soft reset on ETH56G
+ * @hw: pointer to the HW structure
+ * @port: PHY port number
+ *
+ * Trigger a soft reset of the ETH56G PHY by toggling the soft reset
+ * bit in the PHY global register. The reset sequence consists of:
+ *   1. Clearing the soft reset bit
+ *   2. Asserting the soft reset bit
+ *   3. Clearing the soft reset bit again
+ *
+ * Short delays are inserted between each step to allow the hardware
+ * to settle. This provides a controlled way to reinitialize the PHY
+ * without requiring a full device reset.
+ *
+ * Return: 0 on success, or a negative error code on failure when
+ *         reading or writing the PHY register.
+ */
+int ice_ptp_phy_soft_reset_eth56g(struct ice_hw *hw, u8 port)
+{
+	u32 global_val;
+	int err;
+
+	err = ice_read_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, &global_val);
+	if (err) {
+		ice_debug(hw, ICE_DBG_PTP, "Failed to read PHY_REG_GLOBAL for port %d, err %d\n",
+			  port, err);
+		return err;
+	}
+
+	global_val &= ~PHY_REG_GLOBAL_SOFT_RESET_M;
+	ice_debug(hw, ICE_DBG_PTP, "Clearing soft reset bit for port %d, val: 0x%x\n",
+		  port, global_val);
+	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, global_val);
+	if (err) {
+		ice_debug(hw, ICE_DBG_PTP, "Failed to write PHY_REG_GLOBAL for port %d, err %d\n",
+			  port, err);
+		return err;
+	}
+
+	usleep_range(5000, 6000);
+
+	global_val |= PHY_REG_GLOBAL_SOFT_RESET_M;
+	ice_debug(hw, ICE_DBG_PTP, "Set soft reset bit for port %d, val: 0x%x\n",
+		  port, global_val);
+	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, global_val);
+	if (err) {
+		ice_debug(hw, ICE_DBG_PTP, "Failed to write PHY_REG_GLOBAL for port %d, err %d\n",
+			  port, err);
+		return err;
+	}
+	usleep_range(5000, 6000);
+
+	global_val &= ~PHY_REG_GLOBAL_SOFT_RESET_M;
+	ice_debug(hw, ICE_DBG_PTP, "Clear soft reset bit for port %d, val: 0x%x\n",
+		  port, global_val);
+	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, global_val);
+	if (err)
+		ice_debug(hw, ICE_DBG_PTP, "Failed to write PHY_REG_GLOBAL for port %d, err %d\n",
+			  port, err);
+	return err;
+}
+
 /**
  * ice_get_phy_tx_tstamp_ready_eth56g - Read the Tx memory status register
  * @hw: pointer to the HW struct
@@ -5592,7 +5680,7 @@ int ice_ptp_init_phc(struct ice_hw *hw)
 	case ICE_MAC_GENERIC:
 		return ice_ptp_init_phc_e82x(hw);
 	case ICE_MAC_GENERIC_3K_E825:
-		return 0;
+		return ice_ptp_init_phc_e825c(hw);
 	default:
 		return -EOPNOTSUPP;
 	}

-- 
2.54.0.rc2.531.gaf818d63126a


