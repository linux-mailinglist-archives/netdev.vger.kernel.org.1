Return-Path: <netdev+bounces-138067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 459FC9ABBA7
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 04:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E1E1F221C5
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 02:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5B255C29;
	Wed, 23 Oct 2024 02:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WddgkCPp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996C745C1C
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 02:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729651196; cv=none; b=SS02OGS9MscVPbhMbkIMYPGewim84QaTaTICdb9RimMl4N622jDlxi55FEvMq/yn4Gcmn/UqQFn1YPaXNkDgG+sNkiCaVPJBzx8tawc3Wu+P6/S3hLTmQKzghzA/HKNbubxd3VJs8To+e/QEH4AA52bqm+vBk9E4OZXTeBBd3HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729651196; c=relaxed/simple;
	bh=7N7L6+V9AbjKTlZz5/LnXcWC1kysGftafPvYuc5nQEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WYSdrJo8xhxsI3iP0KbarVp+bFVeZcvxjEKso/eZRxFS5Zycov4EML5IVb5QoZpxi/zF6LsD3jioDmK9tmEA843Ks9hPJv8yG7hU8scRoDQeecRukUODN/i76Fmu8pEfeM9a/9TvzrJ0uNCGeHlCuc8ZBpObBFU1QuzjO/gLPeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WddgkCPp; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729651195; x=1761187195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7N7L6+V9AbjKTlZz5/LnXcWC1kysGftafPvYuc5nQEM=;
  b=WddgkCPpQSW0JSY9rVNQxFwciLbihQO5OWAhzrPL8GgzXOogYcp2vJ58
   MD6kk+4rxTAqbKdt/4oZCySQzKTCnM34tsP8vmpCk+6jIrNsmBVTULq1O
   NavEEmJ9STW6xMD6uCBAZ915OJt+UIonfauHoP4yN7B78nGdAiT88XGwO
   W/lRkKrk7dk7pDltn5H4CXPNWDjVVUWX6K1x8pCObIYtEG5pPRDNpb7m/
   jObOY/XBvfRSafM8lqz99tQ3DYghNlz5cxYQbY6MTPISlqm/nXsMf+jqx
   Oy6cCNlzulsUvxeGvo0O7fq99Z5OHqKtrf47+lNRkkKyDq5ve4PLElmxW
   Q==;
X-CSE-ConnectionGUID: GXPijNs8QU6wRprUA3GlWQ==
X-CSE-MsgGUID: k/Kbsn2XSNeDb593lSudPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32918033"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32918033"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 19:39:54 -0700
X-CSE-ConnectionGUID: fj4BqAykT/CTozmcsRGvpQ==
X-CSE-MsgGUID: IOBX5pzHRRipojbChwK8yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="80396821"
Received: from timelab-spr11.ch.intel.com ([143.182.136.151])
  by fmviesa010.fm.intel.com with ESMTP; 22 Oct 2024 19:39:53 -0700
From: Chris H <christopher.s.hall@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: david.zage@intel.com,
	vinicius.gomes@intel.com,
	netdev@vger.kernel.org,
	rodrigo.cadore@l-acoustics.com,
	vinschen@redhat.com,
	Christopher S M Hall <christopher.s.hall@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-net v2 1/4] igc: Ensure the PTM cycle is reliably triggered
Date: Wed, 23 Oct 2024 02:30:37 +0000
Message-Id: <20241023023040.111429-2-christopher.s.hall@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023023040.111429-1-christopher.s.hall@intel.com>
References: <20241023023040.111429-1-christopher.s.hall@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christopher S M Hall <christopher.s.hall@intel.com>

Writing to clear the PTM status 'valid' bit while the PTM cycle is
triggered results in unreliable PTM operation. To fix this, clear the
PTM 'trigger' and status after each PTM transaction.

The issue can be reproduced with the following:

$ sudo phc2sys -R 1000 -O 0 -i tsn0 -m

Note: 1000 Hz (-R 1000) is unrealistically large, but provides a way to
quickly reproduce the issue.

PHC2SYS exits with:

"ioctl PTP_OFFSET_PRECISE: Connection timed out" when the PTM transaction
  fails

Fixes: a90ec8483732 ("igc: Add support for PTP getcrosststamp()")
Signed-off-by: Christopher S M Hall <christopher.s.hall@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h |  1 +
 drivers/net/ethernet/intel/igc/igc_ptp.c     | 70 ++++++++++++--------
 2 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 8e449904aa7d..afd0512dc9f8 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -593,6 +593,7 @@
 #define IGC_PTM_STAT_T4M1_OVFL		BIT(3) /* T4 minus T1 overflow */
 #define IGC_PTM_STAT_ADJUST_1ST		BIT(4) /* 1588 timer adjusted during 1st PTM cycle */
 #define IGC_PTM_STAT_ADJUST_CYC		BIT(5) /* 1588 timer adjusted during non-1st PTM cycle */
+#define IGC_PTM_STAT_ALL        	GENMASK(5, 0) /* Used to clear all status */
 
 /* PCIe PTM Cycle Control */
 #define IGC_PTM_CYCLE_CTRL_CYC_TIME(msec)	((msec) & 0x3ff) /* PTM Cycle Time (msec) */
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 946edbad4302..00cc80d8d164 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -974,11 +974,38 @@ static void igc_ptm_log_error(struct igc_adapter *adapter, u32 ptm_stat)
 	}
 }
 
+static void igc_ptm_trigger(struct igc_hw *hw)
+{
+	u32 ctrl;
+
+	/* To "manually" start the PTM cycle we need to set the
+	 * trigger (TRIG) bit
+	 */
+	ctrl = rd32(IGC_PTM_CTRL);
+	ctrl |= IGC_PTM_CTRL_TRIG;
+	wr32(IGC_PTM_CTRL, ctrl);
+	/* Perform flush after write to CTRL register otherwise
+	 * transaction may not start
+	 */
+	wrfl();
+}
+
+static void igc_ptm_reset(struct igc_hw *hw)
+{
+	u32 ctrl;
+
+	ctrl = rd32(IGC_PTM_CTRL);
+	ctrl &= ~IGC_PTM_CTRL_TRIG;
+	wr32(IGC_PTM_CTRL, ctrl);
+	/* Write to clear all status */
+	wr32(IGC_PTM_STAT, IGC_PTM_STAT_ALL);
+}
+
 static int igc_phc_get_syncdevicetime(ktime_t *device,
 				      struct system_counterval_t *system,
 				      void *ctx)
 {
-	u32 stat, t2_curr_h, t2_curr_l, ctrl;
+	u32 stat, t2_curr_h, t2_curr_l;
 	struct igc_adapter *adapter = ctx;
 	struct igc_hw *hw = &adapter->hw;
 	int err, count = 100;
@@ -994,25 +1021,13 @@ static int igc_phc_get_syncdevicetime(ktime_t *device,
 		 * are transitory. Repeating the process returns valid
 		 * data eventually.
 		 */
-
-		/* To "manually" start the PTM cycle we need to clear and
-		 * then set again the TRIG bit.
-		 */
-		ctrl = rd32(IGC_PTM_CTRL);
-		ctrl &= ~IGC_PTM_CTRL_TRIG;
-		wr32(IGC_PTM_CTRL, ctrl);
-		ctrl |= IGC_PTM_CTRL_TRIG;
-		wr32(IGC_PTM_CTRL, ctrl);
-
-		/* The cycle only starts "for real" when software notifies
-		 * that it has read the registers, this is done by setting
-		 * VALID bit.
-		 */
-		wr32(IGC_PTM_STAT, IGC_PTM_STAT_VALID);
+		igc_ptm_trigger(hw);
 
 		err = readx_poll_timeout(rd32, IGC_PTM_STAT, stat,
 					 stat, IGC_PTM_STAT_SLEEP,
 					 IGC_PTM_STAT_TIMEOUT);
+		igc_ptm_reset(hw);
+
 		if (err < 0) {
 			netdev_err(adapter->netdev, "Timeout reading IGC_PTM_STAT register\n");
 			return err;
@@ -1021,15 +1036,7 @@ static int igc_phc_get_syncdevicetime(ktime_t *device,
 		if ((stat & IGC_PTM_STAT_VALID) == IGC_PTM_STAT_VALID)
 			break;
 
-		if (stat & ~IGC_PTM_STAT_VALID) {
-			/* An error occurred, log it. */
-			igc_ptm_log_error(adapter, stat);
-			/* The STAT register is write-1-to-clear (W1C),
-			 * so write the previous error status to clear it.
-			 */
-			wr32(IGC_PTM_STAT, stat);
-			continue;
-		}
+		igc_ptm_log_error(adapter, stat);
 	} while (--count);
 
 	if (!count) {
@@ -1255,7 +1262,7 @@ void igc_ptp_stop(struct igc_adapter *adapter)
 void igc_ptp_reset(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
-	u32 cycle_ctrl, ctrl;
+	u32 cycle_ctrl, ctrl, stat;
 	unsigned long flags;
 	u32 timadj;
 
@@ -1290,14 +1297,19 @@ void igc_ptp_reset(struct igc_adapter *adapter)
 		ctrl = IGC_PTM_CTRL_EN |
 			IGC_PTM_CTRL_START_NOW |
 			IGC_PTM_CTRL_SHRT_CYC(IGC_PTM_SHORT_CYC_DEFAULT) |
-			IGC_PTM_CTRL_PTM_TO(IGC_PTM_TIMEOUT_DEFAULT) |
-			IGC_PTM_CTRL_TRIG;
+			IGC_PTM_CTRL_PTM_TO(IGC_PTM_TIMEOUT_DEFAULT);
 
 		wr32(IGC_PTM_CTRL, ctrl);
 
 		/* Force the first cycle to run. */
-		wr32(IGC_PTM_STAT, IGC_PTM_STAT_VALID);
+		igc_ptm_trigger(hw);
+
+		if (readx_poll_timeout_atomic(rd32, IGC_PTM_STAT, stat,
+					      stat, IGC_PTM_STAT_SLEEP,
+					      IGC_PTM_STAT_TIMEOUT))
+			netdev_err(adapter->netdev, "Timeout reading IGC_PTM_STAT register\n");
 
+		igc_ptm_reset(hw);
 		break;
 	default:
 		/* No work to do. */
-- 
2.34.1


