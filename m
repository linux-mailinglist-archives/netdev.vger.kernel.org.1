Return-Path: <netdev+bounces-178703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2B2A78545
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 01:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 935813AB5F7
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 23:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15EF21D3D0;
	Tue,  1 Apr 2025 23:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BII44l/f"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C6021C176
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 23:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743550571; cv=none; b=stDxLGxa3+Sa0np4Ne1R0bkeDyNgK5HEY4A2dL4tHuz1FCMaUj8dRXVEt9D4sYn3fctWp+W+hbNGd8+SOiYK4iz9n88ihXh8Yfz2F6u96Znse+yG/B1s/DD5QvTUnH+5mUfC1xsPt81c66IHac9vDKFKR7P4QSUTz3wNCSGVWDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743550571; c=relaxed/simple;
	bh=2cCo3BggoMxwUtWv9qpieI0IjPMxkVF8/63I65QDqUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bGFyQy/5bNEdL3IjGpxfol8hd/wQuX7T/u9So1IK58uf/+NZMYdC7ehIB4Sf13Y+Wi/CSbP7vWBftn2wrGy/FDrvxEh4wlj+5/zp9l8d4gzkjMH13QBE8QVbd6T45AqnM1icL9Yyqt5dvPjGnpSlRvmBJbzjWmF28QXKjwqAhSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BII44l/f; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743550570; x=1775086570;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=2cCo3BggoMxwUtWv9qpieI0IjPMxkVF8/63I65QDqUg=;
  b=BII44l/fbZJ03dN+QJu0gC/MHif8nh0TQV743loUeZVRO4jUvCgq2xQr
   sP7IcDvJ9g5GBGSiPPp/0rr5lf3rQpDiiBp35x+/ZxBD1mX5CtBnFuljk
   nCpRGou2TUNU24S/R4L+beCb5o42WdwDfOImWfX81R7YZa34cB5NTmQ3z
   5RZYORCsTOMITSAAk8FI/3X5+P1u/2ve1G3PrAwhWh0/iJoLIC8mG+KpZ
   1XUlEVOSTZgQIGmgG+Cz32gN0yYmnVZV8/HrqTnDmU/GNGlbLrsWjYT+r
   hQ3GKj2Q468LnnPn5W+usWJDJ2oahFwkGddzKCAot6TOTMqqVU5g4VmHH
   w==;
X-CSE-ConnectionGUID: HRKpzwPTRBWrwPcTa7xeDA==
X-CSE-MsgGUID: ecbwb55yQzapRjiKdGkapA==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="55527617"
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="55527617"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 16:36:07 -0700
X-CSE-ConnectionGUID: Lhs1atT4T3SmCWJZiXH6+w==
X-CSE-MsgGUID: NrDtj4o2SzqRpoTdJWQHJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="127354861"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 16:36:06 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 01 Apr 2025 16:35:34 -0700
Subject: [PATCH iwl-net v4 6/6] igc: add lock preventing multiple
 simultaneous PTM transactions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250401-jk-igc-ptm-fixes-v4-v4-6-c0efb82bbf85@intel.com>
References: <20250401-jk-igc-ptm-fixes-v4-v4-0-c0efb82bbf85@intel.com>
In-Reply-To: <20250401-jk-igc-ptm-fixes-v4-v4-0-c0efb82bbf85@intel.com>
To: Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: david.zage@intel.com, vinicius.gomes@intel.com, 
 rodrigo.cadore@l-acoustics.com, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Christopher S M Hall <christopher.s.hall@intel.com>, 
 Corinna Vinschen <vinschen@redhat.com>
X-Mailer: b4 0.14.2

From: Christopher S M Hall <christopher.s.hall@intel.com>

Add a mutex around the PTM transaction to prevent multiple transactors

Multiple processes try to initiate a PTM transaction, one or all may
fail. This can be reproduced by running two instances of the
following:

$ sudo phc2sys -O 0 -i tsn0 -m

PHC2SYS exits with:

"ioctl PTP_OFFSET_PRECISE: Connection timed out" when the PTM transaction
 fails

Note: Normally two instance of PHC2SYS will not run, but one process
 should not break another.

Fixes: a90ec8483732 ("igc: Add support for PTP getcrosststamp()")
Signed-off-by: Christopher S M Hall <christopher.s.hall@intel.com>
Reviewed-by: Corinna Vinschen <vinschen@redhat.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h     |  1 +
 drivers/net/ethernet/intel/igc/igc_ptp.c | 20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index cd1d7b6c1782352094f6867a31b6958c929bbbf4..e03b5c89bdb1ab8b1a04b6e10ab8d666d383eee2 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -319,6 +319,7 @@ struct igc_adapter {
 	struct timespec64 prev_ptp_time; /* Pre-reset PTP clock */
 	ktime_t ptp_reset_start; /* Reset time in clock mono */
 	struct system_time_snapshot snapshot;
+	struct mutex ptm_lock; /* Only allow one PTM transaction at a time */
 
 	char fw_version[32];
 
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 343205bffc355022306bcb1db35109e2113bb430..612ed26a29c5d491cc3f2c2af803adc770d60fc2 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -974,6 +974,7 @@ static void igc_ptm_log_error(struct igc_adapter *adapter, u32 ptm_stat)
 	}
 }
 
+/* The PTM lock: adapter->ptm_lock must be held when calling igc_ptm_trigger() */
 static void igc_ptm_trigger(struct igc_hw *hw)
 {
 	u32 ctrl;
@@ -990,6 +991,7 @@ static void igc_ptm_trigger(struct igc_hw *hw)
 	wrfl();
 }
 
+/* The PTM lock: adapter->ptm_lock must be held when calling igc_ptm_reset() */
 static void igc_ptm_reset(struct igc_hw *hw)
 {
 	u32 ctrl;
@@ -1068,9 +1070,16 @@ static int igc_ptp_getcrosststamp(struct ptp_clock_info *ptp,
 {
 	struct igc_adapter *adapter = container_of(ptp, struct igc_adapter,
 						   ptp_caps);
+	int ret;
 
-	return get_device_system_crosststamp(igc_phc_get_syncdevicetime,
-					     adapter, &adapter->snapshot, cts);
+	/* This blocks until any in progress PTM transactions complete */
+	mutex_lock(&adapter->ptm_lock);
+
+	ret = get_device_system_crosststamp(igc_phc_get_syncdevicetime,
+					    adapter, &adapter->snapshot, cts);
+	mutex_unlock(&adapter->ptm_lock);
+
+	return ret;
 }
 
 static int igc_ptp_getcyclesx64(struct ptp_clock_info *ptp,
@@ -1169,6 +1178,7 @@ void igc_ptp_init(struct igc_adapter *adapter)
 	spin_lock_init(&adapter->ptp_tx_lock);
 	spin_lock_init(&adapter->free_timer_lock);
 	spin_lock_init(&adapter->tmreg_lock);
+	mutex_init(&adapter->ptm_lock);
 
 	adapter->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
 	adapter->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
@@ -1181,6 +1191,7 @@ void igc_ptp_init(struct igc_adapter *adapter)
 	if (IS_ERR(adapter->ptp_clock)) {
 		adapter->ptp_clock = NULL;
 		netdev_err(netdev, "ptp_clock_register failed\n");
+		mutex_destroy(&adapter->ptm_lock);
 	} else if (adapter->ptp_clock) {
 		netdev_info(netdev, "PHC added\n");
 		adapter->ptp_flags |= IGC_PTP_ENABLED;
@@ -1210,10 +1221,12 @@ static void igc_ptm_stop(struct igc_adapter *adapter)
 	struct igc_hw *hw = &adapter->hw;
 	u32 ctrl;
 
+	mutex_lock(&adapter->ptm_lock);
 	ctrl = rd32(IGC_PTM_CTRL);
 	ctrl &= ~IGC_PTM_CTRL_EN;
 
 	wr32(IGC_PTM_CTRL, ctrl);
+	mutex_unlock(&adapter->ptm_lock);
 }
 
 /**
@@ -1255,6 +1268,7 @@ void igc_ptp_stop(struct igc_adapter *adapter)
 		netdev_info(adapter->netdev, "PHC removed\n");
 		adapter->ptp_flags &= ~IGC_PTP_ENABLED;
 	}
+	mutex_destroy(&adapter->ptm_lock);
 }
 
 /**
@@ -1294,6 +1308,7 @@ void igc_ptp_reset(struct igc_adapter *adapter)
 		if (!igc_is_crosststamp_supported(adapter))
 			break;
 
+		mutex_lock(&adapter->ptm_lock);
 		wr32(IGC_PCIE_DIG_DELAY, IGC_PCIE_DIG_DELAY_DEFAULT);
 		wr32(IGC_PCIE_PHY_DELAY, IGC_PCIE_PHY_DELAY_DEFAULT);
 
@@ -1317,6 +1332,7 @@ void igc_ptp_reset(struct igc_adapter *adapter)
 			netdev_err(adapter->netdev, "Timeout reading IGC_PTM_STAT register\n");
 
 		igc_ptm_reset(hw);
+		mutex_unlock(&adapter->ptm_lock);
 		break;
 	default:
 		/* No work to do. */

-- 
2.48.1.397.gec9d649cc640


