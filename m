Return-Path: <netdev+bounces-164896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2889EA2F892
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF8B416904B
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B282586DC;
	Mon, 10 Feb 2025 19:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SCZH5KhZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99652566D1
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 19:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739215449; cv=none; b=a+w+E52yhmNeaNRdtofcskFakXuvgJrfCYbnNG+eTTmQJ5LWInwlNVMOCuCSfioloZvLoatz3xN7q9PP7UyuTLgJWJE0QeY0nVPm+JyRFaI9RMDq86OH3Z1vgFrs5Gk2FpJIwALffBFzR8oOLoFxtu3NvPbMp/a/OTat0I+uDaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739215449; c=relaxed/simple;
	bh=zt6AiKrVpwZQKXps4jSShpEJtPmsOtyoaAXxqkI+noc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=huMplbMds4AJLSOjjFj3h87I5CGHTLrMUzQaMk0cvmImcNtUki7OzB3ICRYwDHI+fCfKopeETAS1YUtutZtTqltBfa5hFkyT05iATJXztFMw6ii9Ui2YootKdOb06u0NAvb1jEhGNjoeTmzhodFcKoVYt0QYl4bqwn0pGD5QKiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SCZH5KhZ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739215447; x=1770751447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zt6AiKrVpwZQKXps4jSShpEJtPmsOtyoaAXxqkI+noc=;
  b=SCZH5KhZi1w97vI35EI2Q/RfBCyb3+B7s8EfbrGdcfjSwt2nKvgNEBN4
   b4FLhSiAQbGMSBc40+ua08ehibCqiPigUNfTu7uiR2TD7/oOTTK8nlO+p
   wsuxP2OJ1OiWBtj4o+96m5SdBtNn/X9E2mlvdec+hP+KzevUKzcTXvlAr
   pDN/fGRJUe1QOouCMK/XqKt4XexCj5dTuZW6JHckU+xTGU5wvpAn7AIXX
   RcpMvHs7x8mjygpsV2doTMJeEniu5yzSoIp4mmN7JZucbaG2na0n4YFW0
   Zhj4dWa+hNvA7c9Gi344JLtSTwGnXzujLW0MvP/JzElwBF3nf07e+H1GT
   A==;
X-CSE-ConnectionGUID: 2W9plwzRSEycbr0Wdj2yCw==
X-CSE-MsgGUID: mFO+WCkqQFy6/9zCOvT7KQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39929249"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="39929249"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 11:24:02 -0800
X-CSE-ConnectionGUID: LGqAJzygSx6CgEURnPJPjA==
X-CSE-MsgGUID: wLhU245yQKeP3y+2ULPLtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112733881"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 10 Feb 2025 11:24:02 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	grzegorz.nitka@intel.com,
	przemyslaw.kitszel@intel.com,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH net-next 07/10] ice: Implement PTP support for E830 devices
Date: Mon, 10 Feb 2025 11:23:45 -0800
Message-ID: <20250210192352.3799673-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210192352.3799673-1-anthony.l.nguyen@intel.com>
References: <20250210192352.3799673-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Michalik <michal.michalik@intel.com>

Add specific functions and definitions for E830 devices to enable
PTP support.

E830 devices support direct write to GLTSYN_ registers without shadow
registers and 64 bit read of PHC time.

Enable PTM for E830 device, which is required for cross timestamp and
and dependency on PCIE_PTM for ICE_HWTS.

Check X86_FEATURE_ART for E830 as it may not be present in the CPU.

Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Co-developed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
Co-developed-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Michal Michalik <michal.michalik@intel.com>
Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/Kconfig            |   2 +-
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |  12 ++
 drivers/net/ethernet/intel/ice/ice_main.c     |   9 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  71 +++++++-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 167 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   8 +
 6 files changed, 262 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 24ec9a4f1ffa..26b9938bc38d 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -336,7 +336,7 @@ config ICE_SWITCHDEV
 config ICE_HWTS
 	bool "Support HW cross-timestamp on platforms with PTM support"
 	default y
-	depends on ICE && X86
+	depends on ICE && X86 && PCIE_PTM
 	help
 	  Say Y to enable hardware supported cross-timestamping on platforms
 	  with PCIe PTM support. The cross-timestamp is available through
diff --git a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
index dc88aea9f473..aa4bfbcf85d2 100644
--- a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
+++ b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
@@ -541,10 +541,22 @@
 #define PFPM_WUS_MAG_M				BIT(1)
 #define PFPM_WUS_MNG_M				BIT(3)
 #define PFPM_WUS_FW_RST_WK_M			BIT(31)
+#define E830_PRTMAC_TS_TX_MEM_VALID_H		0x001E2020
+#define E830_PRTMAC_TS_TX_MEM_VALID_L		0x001E2000
 #define E830_PRTMAC_CL01_PS_QNT			0x001E32A0
 #define E830_PRTMAC_CL01_PS_QNT_CL0_M		GENMASK(15, 0)
 #define E830_PRTMAC_CL01_QNT_THR		0x001E3320
 #define E830_PRTMAC_CL01_QNT_THR_CL0_M		GENMASK(15, 0)
+#define E830_PRTTSYN_TXTIME_H(_i)		(0x001E5800 + ((_i) * 32))
+#define E830_PRTTSYN_TXTIME_L(_i)		(0x001E5000 + ((_i) * 32))
+#define E830_GLPTM_ART_CTL			0x00088B50
+#define E830_GLPTM_ART_CTL_ACTIVE_M		BIT(0)
+#define E830_GLPTM_ART_TIME_H			0x00088B54
+#define E830_GLPTM_ART_TIME_L			0x00088B58
+#define E830_GLTSYN_PTMTIME_H(_i)		(0x00088B48 + ((_i) * 4))
+#define E830_GLTSYN_PTMTIME_L(_i)		(0x00088B40 + ((_i) * 4))
+#define E830_PFPTM_SEM				0x00088B00
+#define E830_PFPTM_SEM_BUSY_M			BIT(0)
 #define VFINT_DYN_CTLN(_i)			(0x00003800 + ((_i) * 4))
 #define VFINT_DYN_CTLN_CLEARPBA_M		BIT(1)
 #define E830_MBX_PF_IN_FLIGHT_VF_MSGS_THRESH	0x00234000
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c402ab9f3456..b084839eb811 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4052,8 +4052,7 @@ static void ice_set_pf_caps(struct ice_pf *pf)
 	}
 
 	clear_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags);
-	if (func_caps->common_cap.ieee_1588 &&
-	    !(pf->hw.mac_type == ICE_MAC_E830))
+	if (func_caps->common_cap.ieee_1588)
 		set_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags);
 
 	pf->max_pf_txqs = func_caps->common_cap.num_txq;
@@ -5073,6 +5072,12 @@ static int ice_init(struct ice_pf *pf)
 	if (err)
 		return err;
 
+	if (pf->hw.mac_type == ICE_MAC_E830) {
+		err = pci_enable_ptm(pf->pdev, NULL);
+		if (err)
+			dev_dbg(ice_pf_to_dev(pf), "PCIe PTM not supported by PCIe bus/controller\n");
+	}
+
 	err = ice_alloc_vsis(pf);
 	if (err)
 		goto err_alloc_vsis;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 79ec8727388b..b65114ff487b 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -310,6 +310,15 @@ ice_ptp_read_src_clk_reg(struct ice_pf *pf, struct ptp_system_timestamp *sts)
 	/* Read the system timestamp pre PHC read */
 	ptp_read_system_prets(sts);
 
+	if (hw->mac_type == ICE_MAC_E830) {
+		u64 clk_time = rd64(hw, E830_GLTSYN_TIME_L(tmr_idx));
+
+		/* Read the system timestamp post PHC read */
+		ptp_read_system_postts(sts);
+
+		return clk_time;
+	}
+
 	lo = rd32(hw, GLTSYN_TIME_L(tmr_idx));
 
 	/* Read the system timestamp post PHC read */
@@ -1305,6 +1314,7 @@ ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
 
 	switch (hw->mac_type) {
 	case ICE_MAC_E810:
+	case ICE_MAC_E830:
 		err = 0;
 		break;
 	case ICE_MAC_GENERIC:
@@ -1351,6 +1361,7 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 
 	switch (hw->mac_type) {
 	case ICE_MAC_E810:
+	case ICE_MAC_E830:
 		err = 0;
 		break;
 	case ICE_MAC_GENERIC:
@@ -1418,7 +1429,8 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 
 	switch (hw->mac_type) {
 	case ICE_MAC_E810:
-		/* Do not reconfigure E810 PHY */
+	case ICE_MAC_E830:
+		/* Do not reconfigure E810 or E830 PHY */
 		return;
 	case ICE_MAC_GENERIC:
 	case ICE_MAC_GENERIC_3K_E825:
@@ -1451,6 +1463,7 @@ static int ice_ptp_cfg_phy_interrupt(struct ice_pf *pf, bool ena, u32 threshold)
 
 	switch (hw->mac_type) {
 	case ICE_MAC_E810:
+	case ICE_MAC_E830:
 		return 0;
 	case ICE_MAC_GENERIC: {
 		int quad;
@@ -2202,6 +2215,21 @@ static const struct ice_crosststamp_cfg ice_crosststamp_cfg_e82x = {
 	.dev_time_h[1] = GLTSYN_HHTIME_H(1),
 };
 
+#ifdef CONFIG_ICE_HWTS
+static const struct ice_crosststamp_cfg ice_crosststamp_cfg_e830 = {
+	.lock_reg = E830_PFPTM_SEM,
+	.lock_busy = E830_PFPTM_SEM_BUSY_M,
+	.ctl_reg = E830_GLPTM_ART_CTL,
+	.ctl_active = E830_GLPTM_ART_CTL_ACTIVE_M,
+	.art_time_l = E830_GLPTM_ART_TIME_L,
+	.art_time_h = E830_GLPTM_ART_TIME_H,
+	.dev_time_l[0] = E830_GLTSYN_PTMTIME_L(0),
+	.dev_time_h[0] = E830_GLTSYN_PTMTIME_H(0),
+	.dev_time_l[1] = E830_GLTSYN_PTMTIME_L(1),
+	.dev_time_h[1] = E830_GLTSYN_PTMTIME_H(1),
+};
+
+#endif /* CONFIG_ICE_HWTS */
 /**
  * struct ice_crosststamp_ctx - Device cross timestamp context
  * @snapshot: snapshot of system clocks for historic interpolation
@@ -2323,6 +2351,11 @@ static int ice_ptp_getcrosststamp(struct ptp_clock_info *info,
 	case ICE_MAC_GENERIC_3K_E825:
 		ctx.cfg = &ice_crosststamp_cfg_e82x;
 		break;
+#ifdef CONFIG_ICE_HWTS
+	case ICE_MAC_E830:
+		ctx.cfg = &ice_crosststamp_cfg_e830;
+		break;
+#endif /* CONFIG_ICE_HWTS */
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -2658,6 +2691,28 @@ static void ice_ptp_set_funcs_e810(struct ice_pf *pf)
 	}
 }
 
+/**
+ * ice_ptp_set_funcs_e830 - Set specialized functions for E830 support
+ * @pf: Board private structure
+ *
+ * Assign functions to the PTP capabiltiies structure for E830 devices.
+ * Functions which operate across all device families should be set directly
+ * in ice_ptp_set_caps. Only add functions here which are distinct for E830
+ * devices.
+ */
+static void ice_ptp_set_funcs_e830(struct ice_pf *pf)
+{
+#ifdef CONFIG_ICE_HWTS
+	if (pcie_ptm_enabled(pf->pdev) && boot_cpu_has(X86_FEATURE_ART))
+		pf->ptp.info.getcrosststamp = ice_ptp_getcrosststamp;
+
+#endif /* CONFIG_ICE_HWTS */
+	/* Rest of the config is the same as base E810 */
+	pf->ptp.ice_pin_desc = ice_pin_desc_e810;
+	pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e810);
+	ice_ptp_setup_pin_cfg(pf);
+}
+
 /**
  * ice_ptp_set_caps - Set PTP capabilities
  * @pf: Board private structure
@@ -2684,6 +2739,9 @@ static void ice_ptp_set_caps(struct ice_pf *pf)
 	case ICE_MAC_E810:
 		ice_ptp_set_funcs_e810(pf);
 		return;
+	case ICE_MAC_E830:
+		ice_ptp_set_funcs_e830(pf);
+		return;
 	case ICE_MAC_GENERIC:
 	case ICE_MAC_GENERIC_3K_E825:
 		ice_ptp_set_funcs_e82x(pf);
@@ -2844,6 +2902,16 @@ irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf)
 
 		set_bit(ICE_MISC_THREAD_TX_TSTAMP, pf->misc_thread);
 		return IRQ_WAKE_THREAD;
+	case ICE_MAC_E830:
+		/* E830 can read timestamps in the top half using rd32() */
+		if (ice_ptp_process_ts(pf) == ICE_TX_TSTAMP_WORK_PENDING) {
+			/* Process outstanding Tx timestamps. If there
+			 * is more work, re-arm the interrupt to trigger again.
+			 */
+			wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);
+			ice_flush(hw);
+		}
+		return IRQ_HANDLED;
 	default:
 		return IRQ_HANDLED;
 	}
@@ -3229,6 +3297,7 @@ static int ice_ptp_init_port(struct ice_pf *pf, struct ice_ptp_port *ptp_port)
 
 	switch (hw->mac_type) {
 	case ICE_MAC_E810:
+	case ICE_MAC_E830:
 	case ICE_MAC_GENERIC_3K_E825:
 		return ice_ptp_init_tx(pf, &ptp_port->tx, ptp_port->port_num);
 	case ICE_MAC_GENERIC:
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index a2a666e6df86..3e824f7b30c0 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -829,6 +829,7 @@ static u32 ice_ptp_tmr_cmd_to_port_reg(struct ice_hw *hw,
 	 */
 	switch (hw->mac_type) {
 	case ICE_MAC_E810:
+	case ICE_MAC_E830:
 		return ice_ptp_tmr_cmd_to_src_reg(hw, cmd) & TS_CMD_MASK_E810;
 	default:
 		break;
@@ -895,6 +896,17 @@ static void ice_ptp_exec_tmr_cmd(struct ice_hw *hw)
 	ice_flush(hw);
 }
 
+/**
+ * ice_ptp_cfg_sync_delay - Configure PHC to PHY synchronization delay
+ * @hw: pointer to HW struct
+ * @delay: delay between PHC and PHY SYNC command execution in nanoseconds
+ */
+static void ice_ptp_cfg_sync_delay(const struct ice_hw *hw, u32 delay)
+{
+	wr32(hw, GLTSYN_SYNC_DLAY, delay);
+	ice_flush(hw);
+}
+
 /* 56G PHY device functions
  *
  * The following functions operate on devices with the ETH 56G PHY.
@@ -5043,8 +5055,7 @@ static int ice_ptp_init_phc_e810(struct ice_hw *hw)
 	u8 tmr_idx;
 	int err;
 
-	/* Ensure synchronization delay is zero */
-	wr32(hw, GLTSYN_SYNC_DLAY, 0);
+	ice_ptp_cfg_sync_delay(hw, ICE_E810_E830_SYNC_DELAY);
 
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
 	err = ice_write_phy_reg_e810(hw, ETH_GLTSYN_ENA(tmr_idx),
@@ -5445,6 +5456,128 @@ static void ice_ptp_init_phy_e810(struct ice_ptp_hw *ptp)
 	init_waitqueue_head(&ptp->phy.e810.atqbal_wq);
 }
 
+/* E830 functions
+ *
+ * The following functions operate on the E830 series devices.
+ *
+ */
+
+/**
+ * ice_ptp_init_phc_e830 - Perform E830 specific PHC initialization
+ * @hw: pointer to HW struct
+ *
+ * Perform E830-specific PTP hardware clock initialization steps.
+ */
+static void ice_ptp_init_phc_e830(const struct ice_hw *hw)
+{
+	ice_ptp_cfg_sync_delay(hw, ICE_E810_E830_SYNC_DELAY);
+}
+
+/**
+ * ice_ptp_write_direct_incval_e830 - Prep PHY port increment value change
+ * @hw: pointer to HW struct
+ * @incval: The new 40bit increment value to prepare
+ *
+ * Prepare the PHY port for a new increment value by programming the PHC
+ * GLTSYN_INCVAL_L and GLTSYN_INCVAL_H registers. The actual change is
+ * completed by FW automatically.
+ */
+static void ice_ptp_write_direct_incval_e830(const struct ice_hw *hw,
+					     u64 incval)
+{
+	u8 tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
+
+	wr32(hw, GLTSYN_INCVAL_L(tmr_idx), lower_32_bits(incval));
+	wr32(hw, GLTSYN_INCVAL_H(tmr_idx), upper_32_bits(incval));
+}
+
+/**
+ * ice_ptp_write_direct_phc_time_e830 - Prepare PHY port with initial time
+ * @hw: Board private structure
+ * @time: Time to initialize the PHY port clock to
+ *
+ * Program the PHY port ETH_GLTSYN_SHTIME registers in preparation setting the
+ * initial clock time. The time will not actually be programmed until the
+ * driver issues an ICE_PTP_INIT_TIME command.
+ *
+ * The time value is the upper 32 bits of the PHY timer, usually in units of
+ * nominal nanoseconds.
+ */
+static void ice_ptp_write_direct_phc_time_e830(const struct ice_hw *hw,
+					       u64 time)
+{
+	u8 tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
+
+	wr32(hw, GLTSYN_TIME_0(tmr_idx), 0);
+	wr32(hw, GLTSYN_TIME_L(tmr_idx), lower_32_bits(time));
+	wr32(hw, GLTSYN_TIME_H(tmr_idx), upper_32_bits(time));
+}
+
+/**
+ * ice_ptp_port_cmd_e830 - Prepare all external PHYs for a timer command
+ * @hw: pointer to HW struct
+ * @cmd: Command to be sent to the port
+ *
+ * Prepare the external PHYs connected to this device for a timer sync
+ * command.
+ *
+ * Return: 0 on success, negative error code when PHY write failed
+ */
+static int ice_ptp_port_cmd_e830(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
+{
+	u32 val = ice_ptp_tmr_cmd_to_port_reg(hw, cmd);
+
+	return ice_write_phy_reg_e810(hw, E830_ETH_GLTSYN_CMD, val);
+}
+
+/**
+ * ice_read_phy_tstamp_e830 - Read a PHY timestamp out of the external PHY
+ * @hw: pointer to the HW struct
+ * @idx: the timestamp index to read
+ * @tstamp: on return, the 40bit timestamp value
+ *
+ * Read a 40bit timestamp value out of the timestamp block of the external PHY
+ * on the E830 device.
+ */
+static void ice_read_phy_tstamp_e830(const struct ice_hw *hw, u8 idx,
+				     u64 *tstamp)
+{
+	u32 hi, lo;
+
+	hi = rd32(hw, E830_PRTTSYN_TXTIME_H(idx));
+	lo = rd32(hw, E830_PRTTSYN_TXTIME_L(idx));
+
+	/* For E830 devices, the timestamp is reported with the lower 32 bits
+	 * in the low register, and the upper 8 bits in the high register.
+	 */
+	*tstamp = FIELD_PREP(PHY_EXT_40B_HIGH_M, hi) |
+		  FIELD_PREP(PHY_EXT_40B_LOW_M, lo);
+}
+
+/**
+ * ice_get_phy_tx_tstamp_ready_e830 - Read Tx memory status register
+ * @hw: pointer to the HW struct
+ * @port: the PHY port to read
+ * @tstamp_ready: contents of the Tx memory status register
+ */
+static void ice_get_phy_tx_tstamp_ready_e830(const struct ice_hw *hw, u8 port,
+					     u64 *tstamp_ready)
+{
+	*tstamp_ready = rd32(hw, E830_PRTMAC_TS_TX_MEM_VALID_H);
+	*tstamp_ready <<= 32;
+	*tstamp_ready |= rd32(hw, E830_PRTMAC_TS_TX_MEM_VALID_L);
+}
+
+/**
+ * ice_ptp_init_phy_e830 - initialize PHY parameters
+ * @ptp: pointer to the PTP HW struct
+ */
+static void ice_ptp_init_phy_e830(struct ice_ptp_hw *ptp)
+{
+	ptp->num_lports = 8;
+	ptp->ports_per_phy = 4;
+}
+
 /* Device agnostic functions
  *
  * The following functions implement shared behavior common to all devices,
@@ -5515,6 +5648,9 @@ void ice_ptp_init_hw(struct ice_hw *hw)
 	case ICE_MAC_E810:
 		ice_ptp_init_phy_e810(ptp);
 		break;
+	case ICE_MAC_E830:
+		ice_ptp_init_phy_e830(ptp);
+		break;
 	case ICE_MAC_GENERIC:
 		ice_ptp_init_phy_e82x(ptp);
 		break;
@@ -5612,6 +5748,8 @@ static int ice_ptp_port_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 	switch (hw->mac_type) {
 	case ICE_MAC_E810:
 		return ice_ptp_port_cmd_e810(hw, cmd);
+	case ICE_MAC_E830:
+		return ice_ptp_port_cmd_e830(hw, cmd);
 	default:
 		break;
 	}
@@ -5682,6 +5820,12 @@ int ice_ptp_init_time(struct ice_hw *hw, u64 time)
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
 
 	/* Source timers */
+	/* For E830 we don't need to use shadow registers, its automatic */
+	if (hw->mac_type == ICE_MAC_E830) {
+		ice_ptp_write_direct_phc_time_e830(hw, time);
+		return 0;
+	}
+
 	wr32(hw, GLTSYN_SHTIME_L(tmr_idx), lower_32_bits(time));
 	wr32(hw, GLTSYN_SHTIME_H(tmr_idx), upper_32_bits(time));
 	wr32(hw, GLTSYN_SHTIME_0(tmr_idx), 0);
@@ -5730,6 +5874,12 @@ int ice_ptp_write_incval(struct ice_hw *hw, u64 incval)
 
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
 
+	/* For E830 we don't need to use shadow registers, its automatic */
+	if (hw->mac_type == ICE_MAC_E830) {
+		ice_ptp_write_direct_incval_e830(hw, incval);
+		return 0;
+	}
+
 	/* Shadow Adjust */
 	wr32(hw, GLTSYN_SHADJ_L(tmr_idx), lower_32_bits(incval));
 	wr32(hw, GLTSYN_SHADJ_H(tmr_idx), upper_32_bits(incval));
@@ -5807,6 +5957,9 @@ int ice_ptp_adj_clock(struct ice_hw *hw, s32 adj)
 	case ICE_MAC_E810:
 		err = ice_ptp_prep_phy_adj_e810(hw, adj);
 		break;
+	case ICE_MAC_E830:
+		/* E830 sync PHYs automatically after setting GLTSYN_SHADJ */
+		return 0;
 	case ICE_MAC_GENERIC:
 		err = ice_ptp_prep_phy_adj_e82x(hw, adj);
 		break;
@@ -5839,6 +5992,9 @@ int ice_read_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx, u64 *tstamp)
 	switch (hw->mac_type) {
 	case ICE_MAC_E810:
 		return ice_read_phy_tstamp_e810(hw, block, idx, tstamp);
+	case ICE_MAC_E830:
+		ice_read_phy_tstamp_e830(hw, idx, tstamp);
+		return 0;
 	case ICE_MAC_GENERIC:
 		return ice_read_phy_tstamp_e82x(hw, block, idx, tstamp);
 	case ICE_MAC_GENERIC_3K_E825:
@@ -5961,6 +6117,9 @@ int ice_ptp_init_phc(struct ice_hw *hw)
 	switch (hw->mac_type) {
 	case ICE_MAC_E810:
 		return ice_ptp_init_phc_e810(hw);
+	case ICE_MAC_E830:
+		ice_ptp_init_phc_e830(hw);
+		return 0;
 	case ICE_MAC_GENERIC:
 		return ice_ptp_init_phc_e82x(hw);
 	case ICE_MAC_GENERIC_3K_E825:
@@ -5987,13 +6146,15 @@ int ice_get_phy_tx_tstamp_ready(struct ice_hw *hw, u8 block, u64 *tstamp_ready)
 	case ICE_MAC_E810:
 		return ice_get_phy_tx_tstamp_ready_e810(hw, block,
 							tstamp_ready);
+	case ICE_MAC_E830:
+		ice_get_phy_tx_tstamp_ready_e830(hw, block, tstamp_ready);
+		return 0;
 	case ICE_MAC_GENERIC:
 		return ice_get_phy_tx_tstamp_ready_e82x(hw, block,
 							tstamp_ready);
 	case ICE_MAC_GENERIC_3K_E825:
 		return ice_get_phy_tx_tstamp_ready_eth56g(hw, block,
 							  tstamp_ready);
-		break;
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 4381ef4a6c77..8442d1d60351 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -324,6 +324,7 @@ extern const struct ice_vernier_info_e82x e822_vernier[NUM_ICE_PTP_LNK_SPD];
  */
 #define ICE_E810_PLL_FREQ		812500000
 #define ICE_PTP_NOMINAL_INCVAL_E810	0x13b13b13bULL
+#define ICE_E810_E830_SYNC_DELAY	0
 
 /* Device agnostic functions */
 u8 ice_get_ptp_src_clock_index(struct ice_hw *hw);
@@ -432,6 +433,7 @@ static inline u64 ice_get_base_incval(struct ice_hw *hw)
 {
 	switch (hw->mac_type) {
 	case ICE_MAC_E810:
+	case ICE_MAC_E830:
 		return ICE_PTP_NOMINAL_INCVAL_E810;
 	case ICE_MAC_GENERIC:
 		return ice_e82x_nominal_incval(ice_e82x_time_ref(hw));
@@ -649,6 +651,12 @@ static inline bool ice_is_dual(struct ice_hw *hw)
 /* E810 timer command register */
 #define E810_ETH_GLTSYN_CMD		0x03000344
 
+/* E830 timer command register */
+#define E830_ETH_GLTSYN_CMD		0x00088814
+
+/* E810 PHC time register */
+#define E830_GLTSYN_TIME_L(_tmr_idx)	(0x0008A000 + 0x1000 * (_tmr_idx))
+
 /* Source timer incval macros */
 #define INCVAL_HIGH_M			0xFF
 
-- 
2.47.1


