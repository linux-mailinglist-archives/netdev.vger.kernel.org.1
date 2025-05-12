Return-Path: <netdev+bounces-189743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18278AB3723
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 14:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8711B7AEFB1
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 12:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57ED02949EA;
	Mon, 12 May 2025 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MVKtGDNu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBE727978E
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053324; cv=none; b=QRFhJpRJskF/66uEXMAQA6muCD6L2ksZl5xTyl/RcgYYbVvV01eN3R/GG5tXKLWx4eQYxwBVzyiunxo2xZY1mvb+KdRbDHchqheST8NkzqajLM5EKHugb3me/AdFmptgwfbZmo3X2wWr3ov6Oh3zjWuom4BCHLl/i4PjGJOhcLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053324; c=relaxed/simple;
	bh=8mxm4wGjEbP+kLcEQBhBl17JtNOT6sDtVF107CFWD70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7uJwSOTc+ty98EMUmP9LmYKztJfZpfycrl9Xrz1k1JNH2fnk5bhQKPPRn7P5SJ7q4xrJXtVC1RXacxx92oMNg3bTntCMDWw0Drk5P5fpWtc4/bcemUXq4OEzyNCHVuM419jKZdLFCnPjwI5f9w5mkRokeErzMio4OhycnnJiWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MVKtGDNu; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747053322; x=1778589322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8mxm4wGjEbP+kLcEQBhBl17JtNOT6sDtVF107CFWD70=;
  b=MVKtGDNuf8Ds77I3/1SsqcUrTK1y9GdqnGhIQ4PohaZJXwA/SyGeKLom
   cYTzBFCzEcfH/nKENt0bUbZ57NknTmZgo2X0lb6UqO4OuRlKbeugJyHhd
   uLrwWyagBA6qLpgMUnsoM5YzoYxjlPw3GaksTQDHk272hbhKr/PO9INdq
   q38/xxO5BijRDENbnfp+ixDZ5xbEvyLuKuKMkSAl9Izesi5apqQ4e4ZxK
   /gUzRJk1c5CVe77Pap+w0dFrXX88aZgRsfaBteh277SKf6QiUkY1u2cJu
   fxJ7x0/hmUKuwJQ6HOlrACSPHBO1iUi03leCTJybMaOvUKZ3s3ZVSeZI0
   Q==;
X-CSE-ConnectionGUID: l82nvPqFRVKjKV76oiE7UA==
X-CSE-MsgGUID: HHbN7Ga+QU6PzEnNxyUlBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="48541793"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="48541793"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 05:35:22 -0700
X-CSE-ConnectionGUID: fdXcsObbRxSI0MCUw6r5LQ==
X-CSE-MsgGUID: EaEpZ4L8RdyxmvYHlhn2Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="138322798"
Received: from kkolacin-desk1.ger.corp.intel.com (HELO kkolacin-desk1.igk.intel.com) ([10.217.160.155])
  by fmviesa009.fm.intel.com with ESMTP; 12 May 2025 05:35:19 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH iwl-next 2/2] ice: update cached PHC time for all ports
Date: Mon, 12 May 2025 14:34:58 +0200
Message-ID: <20250512123509.1194023-4-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512123509.1194023-3-karol.kolacinski@intel.com>
References: <20250512123509.1194023-3-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cached PHC time can be updated simultaneously for all active ports
instead of each port updating it for itself.

This approach makes only one thread updating cached PHC time, which
results in less threads to prioritize and only one PHC time read instead
of 8 every 500 ms.

Remove per-PF PTP kworker and use do_aux_work for PTP periodic work and
system_unbound_wq for ov_work.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 223 +++++++++++------------
 drivers/net/ethernet/intel/ice/ice_ptp.h |   6 +-
 2 files changed, 110 insertions(+), 119 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 0a1f6e0e4a22..d9393be89b0e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -938,6 +938,7 @@ static int ice_ptp_init_tx(struct ice_pf *pf, struct ice_ptp_tx *tx, u8 port)
 /**
  * ice_ptp_update_cached_phctime - Update the cached PHC time values
  * @pf: Board specific private structure
+ * @systime: Cached PHC time to write
  *
  * This function updates the system time values which are cached in the PF
  * structure and the Rx rings.
@@ -952,11 +953,10 @@ static int ice_ptp_init_tx(struct ice_pf *pf, struct ice_ptp_tx *tx, u8 port)
  * * 0 - OK, successfully updated
  * * -EAGAIN - PF was busy, need to reschedule the update
  */
-static int ice_ptp_update_cached_phctime(struct ice_pf *pf)
+static int ice_ptp_update_cached_phctime(struct ice_pf *pf, u64 systime)
 {
 	struct device *dev = ice_pf_to_dev(pf);
 	unsigned long update_before;
-	u64 systime;
 	int i;
 
 	update_before = pf->ptp.cached_phc_jiffies + msecs_to_jiffies(2000);
@@ -969,13 +969,14 @@ static int ice_ptp_update_cached_phctime(struct ice_pf *pf)
 		pf->ptp.late_cached_phc_updates++;
 	}
 
-	/* Read the current PHC time */
-	systime = ice_ptp_read_src_clk_reg(pf, NULL);
-
 	/* Update the cached PHC time stored in the PF structure */
 	WRITE_ONCE(pf->ptp.cached_phc_time, systime);
 	WRITE_ONCE(pf->ptp.cached_phc_jiffies, jiffies);
 
+	/* Nothing to do if link is down */
+	if (!pf->ptp.port.link_up)
+		return 0;
+
 	if (test_and_set_bit(ICE_CFG_BUSY, pf->state))
 		return -EAGAIN;
 
@@ -1000,6 +1001,43 @@ static int ice_ptp_update_cached_phctime(struct ice_pf *pf)
 	return 0;
 }
 
+/**
+ * ice_ptp_update_cached_phctime_all - Update the cached PHC time for all ports
+ * @pf: Board specific private structure
+ *
+ * Return:
+ * * 0 - OK, successfully updated
+ * * -EAGAIN - PF was busy, need to reschedule the update
+ */
+static int ice_ptp_update_cached_phctime_all(struct ice_pf *pf)
+{
+	u64 time = ice_ptp_read_src_clk_reg(pf, NULL);
+	struct list_head *entry;
+	int ret = 0;
+
+	list_for_each(entry, &pf->adapter->ports.ports) {
+		struct ice_ptp_port *port = list_entry(entry,
+						       struct ice_ptp_port,
+						       list_node);
+		struct ice_pf *peer_pf = ptp_port_to_pf(port);
+		int err;
+
+		err = ice_ptp_update_cached_phctime(peer_pf, time);
+		if (err) {
+			/* If another thread is updating the Rx rings, we won't
+			 * properly reset them here. This could lead to
+			 * reporting of invalid timestamps, but there isn't much
+			 * we can do.
+			 */
+			dev_warn(ice_pf_to_dev(peer_pf), "Unable to immediately update cached PHC time, err=%d\n",
+				 err);
+			ret = err;
+		}
+	}
+
+	return ret;
+}
+
 /**
  * ice_ptp_reset_cached_phctime - Reset cached PHC time after an update
  * @pf: Board specific private structure
@@ -1015,24 +1053,12 @@ static int ice_ptp_update_cached_phctime(struct ice_pf *pf)
  */
 static void ice_ptp_reset_cached_phctime(struct ice_pf *pf)
 {
-	struct device *dev = ice_pf_to_dev(pf);
-	int err;
-
 	/* Update the cached PHC time immediately if possible, otherwise
 	 * schedule the work item to execute soon.
 	 */
-	err = ice_ptp_update_cached_phctime(pf);
-	if (err) {
-		/* If another thread is updating the Rx rings, we won't
-		 * properly reset them here. This could lead to reporting of
-		 * invalid timestamps, but there isn't much we can do.
-		 */
-		dev_warn(dev, "%s: ICE_CFG_BUSY, unable to immediately update cached PHC time\n",
-			 __func__);
-
+	if (ice_ptp_update_cached_phctime_all(pf)) {
 		/* Queue the work item to update the Rx rings when possible */
-		kthread_queue_delayed_work(pf->ptp.kworker, &pf->ptp.work,
-					   msecs_to_jiffies(10));
+		ptp_schedule_worker(pf->ptp.clock, msecs_to_jiffies(10));
 	}
 
 	/* Mark any outstanding timestamps as stale, since they might have
@@ -1157,7 +1183,7 @@ static int ice_ptp_check_tx_fifo(struct ice_ptp_port *port)
 
 /**
  * ice_ptp_wait_for_offsets - Check for valid Tx and Rx offsets
- * @work: Pointer to the kthread_work structure for this task
+ * @work: Pointer to the work_struct structure for this task
  *
  * Check whether hardware has completed measuring the Tx and Rx offset values
  * used to configure and enable vernier timestamp calibration.
@@ -1170,37 +1196,30 @@ static int ice_ptp_check_tx_fifo(struct ice_ptp_port *port)
  * This function reschedules itself until both Tx and Rx calibration have
  * completed.
  */
-static void ice_ptp_wait_for_offsets(struct kthread_work *work)
+static void ice_ptp_wait_for_offsets(struct work_struct *work)
 {
+	struct delayed_work *dwork = to_delayed_work(work);
 	struct ice_ptp_port *port;
+	int tx_err, rx_err;
 	struct ice_pf *pf;
-	struct ice_hw *hw;
-	int tx_err;
-	int rx_err;
 
-	port = container_of(work, struct ice_ptp_port, ov_work.work);
+	port = container_of(dwork, struct ice_ptp_port, ov_work);
 	pf = ptp_port_to_pf(port);
-	hw = &pf->hw;
 
-	if (ice_is_reset_in_progress(pf->state)) {
-		/* wait for device driver to complete reset */
-		kthread_queue_delayed_work(pf->ptp.kworker,
-					   &port->ov_work,
-					   msecs_to_jiffies(100));
-		return;
-	}
+	if (ice_is_reset_in_progress(pf->state))
+		goto err;
 
 	tx_err = ice_ptp_check_tx_fifo(port);
 	if (!tx_err)
-		tx_err = ice_phy_cfg_tx_offset_e82x(hw, port->port_num);
-	rx_err = ice_phy_cfg_rx_offset_e82x(hw, port->port_num);
-	if (tx_err || rx_err) {
-		/* Tx and/or Rx offset not yet configured, try again later */
-		kthread_queue_delayed_work(pf->ptp.kworker,
-					   &port->ov_work,
-					   msecs_to_jiffies(100));
+		tx_err = ice_phy_cfg_tx_offset_e82x(&pf->hw, port->port_num);
+
+	rx_err = ice_phy_cfg_rx_offset_e82x(&pf->hw, port->port_num);
+	if (tx_err || rx_err)
 		return;
-	}
+err:
+	/* Tx and/or Rx offset not yet configured, try again later */
+	queue_delayed_work(system_unbound_wq, &port->ov_work,
+			   msecs_to_jiffies(100));
 }
 
 /**
@@ -1223,7 +1242,7 @@ ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
 		err = 0;
 		break;
 	case ICE_MAC_GENERIC:
-		kthread_cancel_delayed_work_sync(&ptp_port->ov_work);
+		cancel_delayed_work_sync(&ptp_port->ov_work);
 
 		err = ice_stop_phy_timer_e82x(hw, port, true);
 		break;
@@ -1271,7 +1290,7 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 		break;
 	case ICE_MAC_GENERIC:
 		/* Start the PHY timer in Vernier mode */
-		kthread_cancel_delayed_work_sync(&ptp_port->ov_work);
+		cancel_delayed_work_sync(&ptp_port->ov_work);
 
 		/* temporarily disable Tx timestamps while calibrating
 		 * PHY offset
@@ -1291,11 +1310,7 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 		ptp_port->tx.calibrating = false;
 		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
 
-		kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work,
-					   0);
-		break;
-	case ICE_MAC_GENERIC_3K_E825:
-		err = ice_start_phy_timer_eth56g(hw, port);
+		queue_delayed_work(system_unbound_wq, &ptp_port->ov_work, 0);
 		break;
 	default:
 		err = -ENODEV;
@@ -2578,22 +2593,27 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
 	}
 }
 
-static void ice_ptp_periodic_work(struct kthread_work *work)
+/**
+ * ice_ptp_periodic_work - Do PTP periodic work
+ * @info: Driver's PTP info structure
+ *
+ * Return: delay of the next auxiliary work scheduling time (>=0) or negative
+ *         value in case further scheduling is not required
+ */
+static long ice_ptp_periodic_work(struct ptp_clock_info *info)
 {
-	struct ice_ptp *ptp = container_of(work, struct ice_ptp, work.work);
-	struct ice_pf *pf = container_of(ptp, struct ice_pf, ptp);
+	struct ice_pf *pf = ptp_info_to_pf(info);
 	int err;
 
 	if (pf->ptp.state != ICE_PTP_READY)
-		return;
+		return 0;
 
-	err = ice_ptp_update_cached_phctime(pf);
+	err = ice_ptp_update_cached_phctime_all(pf);
 
 	ice_ptp_maybe_trigger_tx_interrupt(pf);
 
-	/* Run twice a second or reschedule if phc update failed */
-	kthread_queue_delayed_work(ptp->kworker, &ptp->work,
-				   msecs_to_jiffies(err ? 10 : 500));
+	/* Run twice a second or reschedule if PHC update failed */
+	return msecs_to_jiffies(err ? 10 : MSEC_PER_SEC / 2);
 }
 
 /**
@@ -2617,6 +2637,7 @@ static void ice_ptp_set_caps(struct ice_pf *pf)
 	info->n_ext_ts = GLTSYN_EVNT_H_IDX_MAX;
 	info->enable = ice_ptp_gpio_enable;
 	info->verify = ice_verify_pin;
+	info->do_aux_work = ice_ptp_periodic_work;
 
 	info->supported_extts_flags = PTP_RISING_EDGE |
 				      PTP_FALLING_EDGE |
@@ -2850,7 +2871,8 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	/* Disable timestamping for both Tx and Rx */
 	ice_ptp_disable_timestamp_mode(pf);
 
-	kthread_cancel_delayed_work_sync(&ptp->work);
+	if (ice_pf_src_tmr_owned(pf))
+		ptp_cancel_worker_sync(ptp->clock);
 
 	if (reset_type == ICE_RESET_PFR)
 		return;
@@ -2858,6 +2880,9 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	if (ice_pf_src_tmr_owned(pf) && hw->mac_type == ICE_MAC_GENERIC_3K_E825)
 		ice_ptp_prepare_rebuild_sec(pf, false, reset_type);
 
+	if (hw->mac_type == ICE_MAC_GENERIC)
+		cancel_delayed_work_sync(&pf->ptp.port.ov_work);
+
 	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
 
 	/* Disable periodic outputs */
@@ -2964,17 +2989,18 @@ void ice_ptp_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 		goto err;
 	}
 
-	if (ice_pf_src_tmr_owned(pf) && reset_type != ICE_RESET_PFR) {
-		err = ice_ptp_rebuild_owner(pf);
-		if (err)
-			goto err;
+	if (ice_pf_src_tmr_owned(pf)) {
+		if (reset_type != ICE_RESET_PFR) {
+			err = ice_ptp_rebuild_owner(pf);
+			if (err)
+				goto err;
+		}
+
+		ptp_schedule_worker(ptp->clock, 0);
 	}
 
 	ptp->state = ICE_PTP_READY;
 
-	/* Start periodic work going */
-	kthread_queue_delayed_work(ptp->kworker, &ptp->work, 0);
-
 	dev_info(ice_pf_to_dev(pf), "PTP reset successful\n");
 	return;
 
@@ -3110,34 +3136,6 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
 	return err;
 }
 
-/**
- * ice_ptp_init_work - Initialize PTP work threads
- * @pf: Board private structure
- * @ptp: PF PTP structure
- */
-static int ice_ptp_init_work(struct ice_pf *pf, struct ice_ptp *ptp)
-{
-	struct kthread_worker *kworker;
-
-	/* Initialize work functions */
-	kthread_init_delayed_work(&ptp->work, ice_ptp_periodic_work);
-
-	/* Allocate a kworker for handling work required for the ports
-	 * connected to the PTP hardware clock.
-	 */
-	kworker = kthread_run_worker(0, "ice-ptp-%s",
-					dev_name(ice_pf_to_dev(pf)));
-	if (IS_ERR(kworker))
-		return PTR_ERR(kworker);
-
-	ptp->kworker = kworker;
-
-	/* Start periodic work going */
-	kthread_queue_delayed_work(ptp->kworker, &ptp->work, 0);
-
-	return 0;
-}
-
 /**
  * ice_ptp_init_port - Initialize PTP port structure
  * @pf: Board private structure
@@ -3157,8 +3155,7 @@ static int ice_ptp_init_port(struct ice_pf *pf, struct ice_ptp_port *ptp_port)
 	case ICE_MAC_GENERIC_3K_E825:
 		return ice_ptp_init_tx(pf, &ptp_port->tx, ptp_port->port_num);
 	case ICE_MAC_GENERIC:
-		kthread_init_delayed_work(&ptp_port->ov_work,
-					  ice_ptp_wait_for_offsets);
+		INIT_DELAYED_WORK(&ptp_port->ov_work, ice_ptp_wait_for_offsets);
 		return ice_ptp_init_tx_e82x(pf, &ptp_port->tx,
 					    ptp_port->port_num);
 	default:
@@ -3202,8 +3199,7 @@ static void ice_ptp_init_tx_interrupt_mode(struct ice_pf *pf)
  * functions connected to the clock hardware.
  *
  * The clock owner will allocate and register a ptp_clock with the
- * PTP_1588_CLOCK infrastructure. All functions allocate a kthread and work
- * items used for asynchronous work such as Tx timestamps and periodic work.
+ * PTP_1588_CLOCK infrastructure.
  */
 void ice_ptp_init(struct ice_pf *pf)
 {
@@ -3251,9 +3247,8 @@ void ice_ptp_init(struct ice_pf *pf)
 
 	ptp->state = ICE_PTP_READY;
 
-	err = ice_ptp_init_work(pf, ptp);
-	if (err)
-		goto err_exit;
+	if (ice_pf_src_tmr_owned(pf))
+		ptp_schedule_worker(ptp->clock, 0);
 
 	dev_info(ice_pf_to_dev(pf), "PTP init successful\n");
 	return;
@@ -3277,37 +3272,35 @@ void ice_ptp_init(struct ice_pf *pf)
  */
 void ice_ptp_release(struct ice_pf *pf)
 {
-	if (pf->ptp.state != ICE_PTP_READY)
+	struct ice_ptp *ptp = &pf->ptp;
+
+	if (ptp->state != ICE_PTP_READY)
 		return;
 
-	pf->ptp.state = ICE_PTP_UNINIT;
+	ptp->state = ICE_PTP_UNINIT;
 
 	/* Disable timestamping for both Tx and Rx */
 	ice_ptp_disable_timestamp_mode(pf);
 
 	ice_ptp_cleanup_pf(pf);
 
-	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
-
+	ice_ptp_release_tx_tracker(pf, &ptp->port.tx);
 	ice_ptp_disable_all_extts(pf);
+	if (pf->hw.mac_type == ICE_MAC_GENERIC)
+		cancel_delayed_work_sync(&ptp->port.ov_work);
+	ice_ptp_port_phy_stop(&ptp->port);
+	mutex_destroy(&ptp->port.ps_lock);
 
-	kthread_cancel_delayed_work_sync(&pf->ptp.work);
-
-	ice_ptp_port_phy_stop(&pf->ptp.port);
-	mutex_destroy(&pf->ptp.port.ps_lock);
-	if (pf->ptp.kworker) {
-		kthread_destroy_worker(pf->ptp.kworker);
-		pf->ptp.kworker = NULL;
-	}
-
-	if (!pf->ptp.clock)
+	if (!ptp->clock)
 		return;
 
 	/* Disable periodic outputs */
 	ice_ptp_disable_all_perout(pf);
+	if (ice_pf_src_tmr_owned(pf))
+		ptp_cancel_worker_sync(ptp->clock);
 
-	ptp_clock_unregister(pf->ptp.clock);
-	pf->ptp.clock = NULL;
+	ptp_clock_unregister(ptp->clock);
+	ptp->clock = NULL;
 
 	dev_info(ice_pf_to_dev(pf), "Removed PTP clock\n");
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index c8dac5a5bcd9..0f6154d7f473 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -139,7 +139,7 @@ struct ice_ptp_tx {
  *
  * @list_node: list member structure
  * @tx: Tx timestamp tracking for this port
- * @ov_work: delayed work task for tracking when PHY offset is valid
+ * @ov_work: delayed work for tracking when PHY offset is valid
  * @ps_lock: mutex used to protect the overall PTP PHY start procedure
  * @link_up: indicates whether the link is up
  * @tx_fifo_busy_cnt: number of times the Tx FIFO was busy
@@ -148,7 +148,7 @@ struct ice_ptp_tx {
 struct ice_ptp_port {
 	struct list_head list_node;
 	struct ice_ptp_tx tx;
-	struct kthread_delayed_work ov_work;
+	struct delayed_work ov_work;
 	struct mutex ps_lock; /* protects overall PTP PHY start procedure */
 	bool link_up;
 	u8 tx_fifo_busy_cnt;
@@ -227,7 +227,6 @@ struct ice_ptp_pin_desc {
  * @work: delayed work function for periodic tasks
  * @cached_phc_time: a cached copy of the PHC time for timestamp extension
  * @cached_phc_jiffies: jiffies when cached_phc_time was last updated
- * @kworker: kwork thread for handling periodic work
  * @ext_ts_irq: the external timestamp IRQ in use
  * @pin_desc: structure defining pins
  * @ice_pin_desc: internal structure describing pin relations
@@ -251,7 +250,6 @@ struct ice_ptp {
 	struct kthread_delayed_work work;
 	u64 cached_phc_time;
 	unsigned long cached_phc_jiffies;
-	struct kthread_worker *kworker;
 	u8 ext_ts_irq;
 	struct ptp_pin_desc pin_desc[ICE_N_PINS_MAX];
 	const struct ice_ptp_pin_desc *ice_pin_desc;
-- 
2.49.0


