Return-Path: <netdev+bounces-32895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E529079AABA
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 20:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC7EF1C20999
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 18:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B49156FE;
	Mon, 11 Sep 2023 18:11:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F60156FA
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 18:11:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69C2106
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 11:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694455862; x=1725991862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UMA0ttmRO9KyiU5lR9u5zn79+BfqbArDwWt6rk+5h2E=;
  b=fJkuJVYifFzNlCSG0KNVE8YWZ+Re8hD6DpMV7DubLgF+VVJMJNEEe4Ai
   +cTenpYgfhsudmqVBCjD32jIsKVf37m3WxNiqWoN32xhXrx75Wp6spSqI
   C83S8bPLUTY0iYjTZc2YlGAvXwVPK5S3ZwgvzaE6BOjqwn5V9rSODuy27
   eoNC+bogIDBigQJkZAFVJH2vel0sUaiNh2Sbnr7btck0UVOiySKL7IRJV
   OamV5yLW3+O1folId/sQlxCp2f0e43hgaH1lC5FWtayIHVYgDOXdTANnY
   VSc5iXSigNf/vLM5+adLOV2cIJ+5B0Ba4i0nCDdcnMbO4T97M6ZISRzpL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378075603"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="378075603"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 11:11:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="917129922"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="917129922"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga005.jf.intel.com with ESMTP; 11 Sep 2023 11:11:00 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 01/13] ice: prefix clock timer command enumeration values with ICE_PTP
Date: Mon, 11 Sep 2023 11:03:02 -0700
Message-Id: <20230911180314.4082659-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230911180314.4082659-1-anthony.l.nguyen@intel.com>
References: <20230911180314.4082659-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>

The ice driver has an enumeration for the various commands that can be
programmed to the MAC and PHY for setting up hardware clock operations.
Prefix these with ICE_PTP so that they are clearly namespaced to the ice
driver.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 93 +++++++++++----------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 10 +--
 2 files changed, 52 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index f818dd215c05..d62016111c84 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -116,19 +116,19 @@ static void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 	cmd_val = tmr_idx << SEL_CPK_SRC;
 
 	switch (cmd) {
-	case INIT_TIME:
+	case ICE_PTP_INIT_TIME:
 		cmd_val |= GLTSYN_CMD_INIT_TIME;
 		break;
-	case INIT_INCVAL:
+	case ICE_PTP_INIT_INCVAL:
 		cmd_val |= GLTSYN_CMD_INIT_INCVAL;
 		break;
-	case ADJ_TIME:
+	case ICE_PTP_ADJ_TIME:
 		cmd_val |= GLTSYN_CMD_ADJ_TIME;
 		break;
-	case ADJ_TIME_AT_TIME:
+	case ICE_PTP_ADJ_TIME_AT_TIME:
 		cmd_val |= GLTSYN_CMD_ADJ_INIT_TIME;
 		break;
-	case READ_TIME:
+	case ICE_PTP_READ_TIME:
 		cmd_val |= GLTSYN_CMD_READ_TIME;
 		break;
 	case ICE_PTP_NOP:
@@ -1025,7 +1025,7 @@ static int ice_ptp_init_phc_e822(struct ice_hw *hw)
  * @time: Time to initialize the PHY port clocks to
  *
  * Program the PHY port registers with a new initial time value. The port
- * clock will be initialized once the driver issues an INIT_TIME sync
+ * clock will be initialized once the driver issues an ICE_PTP_INIT_TIME sync
  * command. The time value is the upper 32 bits of the PHY timer, usually in
  * units of nominal nanoseconds.
  */
@@ -1074,7 +1074,7 @@ ice_ptp_prep_phy_time_e822(struct ice_hw *hw, u32 time)
  *
  * Program the port for an atomic adjustment by writing the Tx and Rx timer
  * registers. The atomic adjustment won't be completed until the driver issues
- * an ADJ_TIME command.
+ * an ICE_PTP_ADJ_TIME command.
  *
  * Note that time is not in units of nanoseconds. It is in clock time
  * including the lower sub-nanosecond portion of the port timer.
@@ -1127,7 +1127,7 @@ ice_ptp_prep_port_adj_e822(struct ice_hw *hw, u8 port, s64 time)
  *
  * Prepare the PHY ports for an atomic time adjustment by programming the PHY
  * Tx and Rx port registers. The actual adjustment is completed by issuing an
- * ADJ_TIME or ADJ_TIME_AT_TIME sync command.
+ * ICE_PTP_ADJ_TIME or ICE_PTP_ADJ_TIME_AT_TIME sync command.
  */
 static int
 ice_ptp_prep_phy_adj_e822(struct ice_hw *hw, s32 adj)
@@ -1162,7 +1162,7 @@ ice_ptp_prep_phy_adj_e822(struct ice_hw *hw, s32 adj)
  *
  * Prepare each of the PHY ports for a new increment value by programming the
  * port's TIMETUS registers. The new increment value will be updated after
- * issuing an INIT_INCVAL command.
+ * issuing an ICE_PTP_INIT_INCVAL command.
  */
 static int
 ice_ptp_prep_phy_incval_e822(struct ice_hw *hw, u64 incval)
@@ -1248,19 +1248,19 @@ ice_ptp_write_port_cmd_e822(struct ice_hw *hw, u8 port, enum ice_ptp_tmr_cmd cmd
 	tmr_idx = ice_get_ptp_src_clock_index(hw);
 	cmd_val = tmr_idx << SEL_PHY_SRC;
 	switch (cmd) {
-	case INIT_TIME:
+	case ICE_PTP_INIT_TIME:
 		cmd_val |= PHY_CMD_INIT_TIME;
 		break;
-	case INIT_INCVAL:
+	case ICE_PTP_INIT_INCVAL:
 		cmd_val |= PHY_CMD_INIT_INCVAL;
 		break;
-	case ADJ_TIME:
+	case ICE_PTP_ADJ_TIME:
 		cmd_val |= PHY_CMD_ADJ_TIME;
 		break;
-	case READ_TIME:
+	case ICE_PTP_READ_TIME:
 		cmd_val |= PHY_CMD_READ_TIME;
 		break;
-	case ADJ_TIME_AT_TIME:
+	case ICE_PTP_ADJ_TIME_AT_TIME:
 		cmd_val |= PHY_CMD_ADJ_TIME_AT_TIME;
 		break;
 	case ICE_PTP_NOP:
@@ -2196,8 +2196,8 @@ int ice_phy_cfg_rx_offset_e822(struct ice_hw *hw, u8 port)
  * @phy_time: on return, the 64bit PHY timer value
  * @phc_time: on return, the lower 64bits of PHC time
  *
- * Issue a READ_TIME timer command to simultaneously capture the PHY and PHC
- * timer values.
+ * Issue a ICE_PTP_READ_TIME timer command to simultaneously capture the PHY
+ * and PHC timer values.
  */
 static int
 ice_read_phy_and_phc_time_e822(struct ice_hw *hw, u8 port, u64 *phy_time,
@@ -2210,15 +2210,15 @@ ice_read_phy_and_phc_time_e822(struct ice_hw *hw, u8 port, u64 *phy_time,
 
 	tmr_idx = ice_get_ptp_src_clock_index(hw);
 
-	/* Prepare the PHC timer for a READ_TIME capture command */
-	ice_ptp_src_cmd(hw, READ_TIME);
+	/* Prepare the PHC timer for a ICE_PTP_READ_TIME capture command */
+	ice_ptp_src_cmd(hw, ICE_PTP_READ_TIME);
 
-	/* Prepare the PHY timer for a READ_TIME capture command */
-	err = ice_ptp_one_port_cmd(hw, port, READ_TIME);
+	/* Prepare the PHY timer for a ICE_PTP_READ_TIME capture command */
+	err = ice_ptp_one_port_cmd(hw, port, ICE_PTP_READ_TIME);
 	if (err)
 		return err;
 
-	/* Issue the sync to start the READ_TIME capture */
+	/* Issue the sync to start the ICE_PTP_READ_TIME capture */
 	ice_ptp_exec_tmr_cmd(hw);
 
 	/* Read the captured PHC time from the shadow time registers */
@@ -2252,10 +2252,11 @@ ice_read_phy_and_phc_time_e822(struct ice_hw *hw, u8 port, u64 *phy_time,
  * @port: the PHY port to synchronize
  *
  * Perform an adjustment to ensure that the PHY and PHC timers are in sync.
- * This is done by issuing a READ_TIME command which triggers a simultaneous
- * read of the PHY timer and PHC timer. Then we use the difference to
- * calculate an appropriate 2s complement addition to add to the PHY timer in
- * order to ensure it reads the same value as the primary PHC timer.
+ * This is done by issuing a ICE_PTP_READ_TIME command which triggers a
+ * simultaneous read of the PHY timer and PHC timer. Then we use the
+ * difference to calculate an appropriate 2s complement addition to add
+ * to the PHY timer in order to ensure it reads the same value as the
+ * primary PHC timer.
  */
 static int ice_sync_phy_timer_e822(struct ice_hw *hw, u8 port)
 {
@@ -2285,7 +2286,7 @@ static int ice_sync_phy_timer_e822(struct ice_hw *hw, u8 port)
 	if (err)
 		goto err_unlock;
 
-	err = ice_ptp_one_port_cmd(hw, port, ADJ_TIME);
+	err = ice_ptp_one_port_cmd(hw, port, ICE_PTP_ADJ_TIME);
 	if (err)
 		goto err_unlock;
 
@@ -2408,7 +2409,7 @@ int ice_start_phy_timer_e822(struct ice_hw *hw, u8 port)
 	if (err)
 		return err;
 
-	err = ice_ptp_one_port_cmd(hw, port, INIT_INCVAL);
+	err = ice_ptp_one_port_cmd(hw, port, ICE_PTP_INIT_INCVAL);
 	if (err)
 		return err;
 
@@ -2436,7 +2437,7 @@ int ice_start_phy_timer_e822(struct ice_hw *hw, u8 port)
 	if (err)
 		return err;
 
-	err = ice_ptp_one_port_cmd(hw, port, INIT_INCVAL);
+	err = ice_ptp_one_port_cmd(hw, port, ICE_PTP_INIT_INCVAL);
 	if (err)
 		return err;
 
@@ -2757,7 +2758,7 @@ static int ice_ptp_init_phc_e810(struct ice_hw *hw)
  *
  * Program the PHY port ETH_GLTSYN_SHTIME registers in preparation setting the
  * initial clock time. The time will not actually be programmed until the
- * driver issues an INIT_TIME command.
+ * driver issues an ICE_PTP_INIT_TIME command.
  *
  * The time value is the upper 32 bits of the PHY timer, usually in units of
  * nominal nanoseconds.
@@ -2792,7 +2793,7 @@ static int ice_ptp_prep_phy_time_e810(struct ice_hw *hw, u32 time)
  *
  * Prepare the PHY port for an atomic adjustment by programming the PHY
  * ETH_GLTSYN_SHADJ_L and ETH_GLTSYN_SHADJ_H registers. The actual adjustment
- * is completed by issuing an ADJ_TIME sync command.
+ * is completed by issuing an ICE_PTP_ADJ_TIME sync command.
  *
  * The adjustment value only contains the portion used for the upper 32bits of
  * the PHY timer, usually in units of nominal nanoseconds. Negative
@@ -2832,7 +2833,7 @@ static int ice_ptp_prep_phy_adj_e810(struct ice_hw *hw, s32 adj)
  *
  * Prepare the PHY port for a new increment value by programming the PHY
  * ETH_GLTSYN_SHADJ_L and ETH_GLTSYN_SHADJ_H registers. The actual change is
- * completed by issuing an INIT_INCVAL command.
+ * completed by issuing an ICE_PTP_INIT_INCVAL command.
  */
 static int ice_ptp_prep_phy_incval_e810(struct ice_hw *hw, u64 incval)
 {
@@ -2875,19 +2876,19 @@ static int ice_ptp_port_cmd_e810(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 	int err;
 
 	switch (cmd) {
-	case INIT_TIME:
+	case ICE_PTP_INIT_TIME:
 		cmd_val = GLTSYN_CMD_INIT_TIME;
 		break;
-	case INIT_INCVAL:
+	case ICE_PTP_INIT_INCVAL:
 		cmd_val = GLTSYN_CMD_INIT_INCVAL;
 		break;
-	case ADJ_TIME:
+	case ICE_PTP_ADJ_TIME:
 		cmd_val = GLTSYN_CMD_ADJ_TIME;
 		break;
-	case READ_TIME:
+	case ICE_PTP_READ_TIME:
 		cmd_val = GLTSYN_CMD_READ_TIME;
 		break;
-	case ADJ_TIME_AT_TIME:
+	case ICE_PTP_ADJ_TIME_AT_TIME:
 		cmd_val = GLTSYN_CMD_ADJ_INIT_TIME;
 		break;
 	case ICE_PTP_NOP:
@@ -3219,7 +3220,7 @@ int ice_ptp_init_time(struct ice_hw *hw, u64 time)
 	if (err)
 		return err;
 
-	return ice_ptp_tmr_cmd(hw, INIT_TIME);
+	return ice_ptp_tmr_cmd(hw, ICE_PTP_INIT_TIME);
 }
 
 /**
@@ -3232,8 +3233,8 @@ int ice_ptp_init_time(struct ice_hw *hw, u64 time)
  *
  * 1) Write the increment value to the source timer shadow registers
  * 2) Write the increment value to the PHY timer shadow registers
- * 3) Issue an INIT_INCVAL timer command to synchronously switch both the
- *    source and port timers to the new increment value at the next clock
+ * 3) Issue an ICE_PTP_INIT_INCVAL timer command to synchronously switch both
+ *    the source and port timers to the new increment value at the next clock
  *    cycle.
  */
 int ice_ptp_write_incval(struct ice_hw *hw, u64 incval)
@@ -3254,7 +3255,7 @@ int ice_ptp_write_incval(struct ice_hw *hw, u64 incval)
 	if (err)
 		return err;
 
-	return ice_ptp_tmr_cmd(hw, INIT_INCVAL);
+	return ice_ptp_tmr_cmd(hw, ICE_PTP_INIT_INCVAL);
 }
 
 /**
@@ -3288,8 +3289,8 @@ int ice_ptp_write_incval_locked(struct ice_hw *hw, u64 incval)
  *
  * 1) Write the adjustment to the source timer shadow registers
  * 2) Write the adjustment to the PHY timer shadow registers
- * 3) Issue an ADJ_TIME timer command to synchronously apply the adjustment to
- *    both the source and port timers at the next clock cycle.
+ * 3) Issue an ICE_PTP_ADJ_TIME timer command to synchronously apply the
+ *    adjustment to both the source and port timers at the next clock cycle.
  */
 int ice_ptp_adj_clock(struct ice_hw *hw, s32 adj)
 {
@@ -3299,9 +3300,9 @@ int ice_ptp_adj_clock(struct ice_hw *hw, s32 adj)
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
 
 	/* Write the desired clock adjustment into the GLTSYN_SHADJ register.
-	 * For an ADJ_TIME command, this set of registers represents the value
-	 * to add to the clock time. It supports subtraction by interpreting
-	 * the value as a 2's complement integer.
+	 * For an ICE_PTP_ADJ_TIME command, this set of registers represents
+	 * the value to add to the clock time. It supports subtraction by
+	 * interpreting the value as a 2's complement integer.
 	 */
 	wr32(hw, GLTSYN_SHADJ_L(tmr_idx), 0);
 	wr32(hw, GLTSYN_SHADJ_H(tmr_idx), adj);
@@ -3313,7 +3314,7 @@ int ice_ptp_adj_clock(struct ice_hw *hw, s32 adj)
 	if (err)
 		return err;
 
-	return ice_ptp_tmr_cmd(hw, ADJ_TIME);
+	return ice_ptp_tmr_cmd(hw, ICE_PTP_ADJ_TIME);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 9aa10b0426fd..3e4e91322c72 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -5,11 +5,11 @@
 #define _ICE_PTP_HW_H_
 
 enum ice_ptp_tmr_cmd {
-	INIT_TIME,
-	INIT_INCVAL,
-	ADJ_TIME,
-	ADJ_TIME_AT_TIME,
-	READ_TIME,
+	ICE_PTP_INIT_TIME,
+	ICE_PTP_INIT_INCVAL,
+	ICE_PTP_ADJ_TIME,
+	ICE_PTP_ADJ_TIME_AT_TIME,
+	ICE_PTP_READ_TIME,
 	ICE_PTP_NOP,
 };
 
-- 
2.38.1


