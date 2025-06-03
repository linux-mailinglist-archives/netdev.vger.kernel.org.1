Return-Path: <netdev+bounces-194809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 962BAACCBDA
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 19:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB97F1897521
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 17:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1F51D7E54;
	Tue,  3 Jun 2025 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NYGi7I23"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866101A4F12
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 17:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971041; cv=none; b=O8ZXqC94D+wBSPhPIj7yfDEhWK1V+dEYueCeNcm8JSYtBq8YNmXSI/5v9etn20ckPu+/E+scWXTAbGJx47SVxL6W7R41Tm6vsz4hRKsvuhZcd7e6o2xxd2XyQjm+e+EyUX9sv/4hG2iWVS1fMrjcQg1K7nzFQRIwNUDgnfzf3T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971041; c=relaxed/simple;
	bh=bOhozc1QtSc5O9ByPpXgfZtm2w/7sc3mXkgjAtSORvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIT94C4r/gFPvOOpGYOINECL8z3EUIAY/8JHxpWwVIDTg7mTiYRLQ3682vnz9++F3Cq2/YmZ67kQKXjnpN73nEZh4nXqX/9zivYLmmdFAYmucTVn2p1+GlBMn1ZdDjQgNgT2JVlA1l2vHdq6QBtvWXEMu0mX9Kig7ChR9Bd4uxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NYGi7I23; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748971040; x=1780507040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bOhozc1QtSc5O9ByPpXgfZtm2w/7sc3mXkgjAtSORvI=;
  b=NYGi7I23UuFxrzVIiGYYqUWyZNkuL6XwqT57EIWy7dSiCsGkK72rORxq
   PMrzcPmPBqDXrj06hFWI6yor3sZV33RYzuhaB9srPnYNKOF7Pde/Qeol6
   IzMdpspOw1ItGp3o75gzpPzp5gsTr4nylneBHIfLu8Tx+PZ1XZHB95jwV
   f3ZQan3Rbia7jQqQjzqE0krlfJTh+w5bEGA3YmZZ3kxiaHADaOt2C7cqf
   Er2LcTN9t72OkaTS+r+heQwmOw+0bzXEMyVzpBdkRpdkDGMls8oIIhov1
   mhKdzMIGwNivRR+6D+HEb0BwFFxCOjG7Y4QDC58fYr9A7gmzcvAuh/ALY
   w==;
X-CSE-ConnectionGUID: hESBE5c5RIWfU9QxtDBSPQ==
X-CSE-MsgGUID: 7K2ymX4wRNOGnoAWUCeoWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="73556768"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="73556768"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 10:17:17 -0700
X-CSE-ConnectionGUID: 3X9jRCBCQ2KZ611cAkw7YA==
X-CSE-MsgGUID: a2dxYTpZS/u8P/eJlg7pfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="145546413"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 03 Jun 2025 10:17:17 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	sdf@fomichev.me,
	Jacob Keller <jacob.e.keller@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 2/6] iavf: centralize watchdog requeueing itself
Date: Tue,  3 Jun 2025 10:17:03 -0700
Message-ID: <20250603171710.2336151-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250603171710.2336151-1-anthony.l.nguyen@intel.com>
References: <20250603171710.2336151-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Centralize the unlock(critlock); unlock(netdev); queue_delayed_work(watchog_task);
pattern to one place.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 103 ++++++++------------
 1 file changed, 41 insertions(+), 62 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index a77c72643528..2c6e033c7341 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2911,6 +2911,8 @@ static void iavf_init_config_adapter(struct iavf_adapter *adapter)
 	iavf_change_state(adapter, __IAVF_INIT_FAILED);
 }
 
+static const int IAVF_NO_RESCHED = -1;
+
 /**
  * iavf_watchdog_task - Periodic call-back task
  * @work: pointer to work_struct
@@ -2922,6 +2924,7 @@ static void iavf_watchdog_task(struct work_struct *work)
 						    watchdog_task.work);
 	struct net_device *netdev = adapter->netdev;
 	struct iavf_hw *hw = &adapter->hw;
+	int msec_delay;
 	u32 reg_val;
 
 	netdev_lock(netdev);
@@ -2940,39 +2943,24 @@ static void iavf_watchdog_task(struct work_struct *work)
 	switch (adapter->state) {
 	case __IAVF_STARTUP:
 		iavf_startup(adapter);
-		mutex_unlock(&adapter->crit_lock);
-		netdev_unlock(netdev);
-		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
-				   msecs_to_jiffies(30));
-		return;
+		msec_delay = 30;
+		goto watchdog_done;
 	case __IAVF_INIT_VERSION_CHECK:
 		iavf_init_version_check(adapter);
-		mutex_unlock(&adapter->crit_lock);
-		netdev_unlock(netdev);
-		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
-				   msecs_to_jiffies(30));
-		return;
+		msec_delay = 30;
+		goto watchdog_done;
 	case __IAVF_INIT_GET_RESOURCES:
 		iavf_init_get_resources(adapter);
-		mutex_unlock(&adapter->crit_lock);
-		netdev_unlock(netdev);
-		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
-				   msecs_to_jiffies(1));
-		return;
+		msec_delay = 1;
+		goto watchdog_done;
 	case __IAVF_INIT_EXTENDED_CAPS:
 		iavf_init_process_extended_caps(adapter);
-		mutex_unlock(&adapter->crit_lock);
-		netdev_unlock(netdev);
-		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
-				   msecs_to_jiffies(1));
-		return;
+		msec_delay = 1;
+		goto watchdog_done;
 	case __IAVF_INIT_CONFIG_ADAPTER:
 		iavf_init_config_adapter(adapter);
-		mutex_unlock(&adapter->crit_lock);
-		netdev_unlock(netdev);
-		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
-				   msecs_to_jiffies(1));
-		return;
+		msec_delay = 1;
+		goto watchdog_done;
 	case __IAVF_INIT_FAILED:
 		if (test_bit(__IAVF_IN_REMOVE_TASK,
 			     &adapter->crit_section)) {
@@ -2980,27 +2968,21 @@ static void iavf_watchdog_task(struct work_struct *work)
 			 * watchdog task, iavf_remove should handle this state
 			 * as it can loop forever
 			 */
-			mutex_unlock(&adapter->crit_lock);
-			netdev_unlock(netdev);
-			return;
+			msec_delay = IAVF_NO_RESCHED;
+			goto watchdog_done;
 		}
 		if (++adapter->aq_wait_count > IAVF_AQ_MAX_ERR) {
 			dev_err(&adapter->pdev->dev,
 				"Failed to communicate with PF; waiting before retry\n");
 			adapter->flags |= IAVF_FLAG_PF_COMMS_FAILED;
 			iavf_shutdown_adminq(hw);
-			mutex_unlock(&adapter->crit_lock);
-			netdev_unlock(netdev);
-			queue_delayed_work(adapter->wq,
-					   &adapter->watchdog_task, (5 * HZ));
-			return;
+			msec_delay = 5000;
+			goto watchdog_done;
 		}
 		/* Try again from failed step*/
 		iavf_change_state(adapter, adapter->last_state);
-		mutex_unlock(&adapter->crit_lock);
-		netdev_unlock(netdev);
-		queue_delayed_work(adapter->wq, &adapter->watchdog_task, HZ);
-		return;
+		msec_delay = 1000;
+		goto watchdog_done;
 	case __IAVF_COMM_FAILED:
 		if (test_bit(__IAVF_IN_REMOVE_TASK,
 			     &adapter->crit_section)) {
@@ -3010,9 +2992,8 @@ static void iavf_watchdog_task(struct work_struct *work)
 			 */
 			iavf_change_state(adapter, __IAVF_INIT_FAILED);
 			adapter->flags &= ~IAVF_FLAG_PF_COMMS_FAILED;
-			mutex_unlock(&adapter->crit_lock);
-			netdev_unlock(netdev);
-			return;
+			msec_delay = IAVF_NO_RESCHED;
+			goto watchdog_done;
 		}
 		reg_val = rd32(hw, IAVF_VFGEN_RSTAT) &
 			  IAVF_VFGEN_RSTAT_VFR_STATE_MASK;
@@ -3030,18 +3011,11 @@ static void iavf_watchdog_task(struct work_struct *work)
 		}
 		adapter->aq_required = 0;
 		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
-		mutex_unlock(&adapter->crit_lock);
-		netdev_unlock(netdev);
-		queue_delayed_work(adapter->wq,
-				   &adapter->watchdog_task,
-				   msecs_to_jiffies(10));
-		return;
+		msec_delay = 10;
+		goto watchdog_done;
 	case __IAVF_RESETTING:
-		mutex_unlock(&adapter->crit_lock);
-		netdev_unlock(netdev);
-		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
-				   HZ * 2);
-		return;
+		msec_delay = 2000;
+		goto watchdog_done;
 	case __IAVF_DOWN:
 	case __IAVF_DOWN_PENDING:
 	case __IAVF_TESTING:
@@ -3068,9 +3042,8 @@ static void iavf_watchdog_task(struct work_struct *work)
 		break;
 	case __IAVF_REMOVE:
 	default:
-		mutex_unlock(&adapter->crit_lock);
-		netdev_unlock(netdev);
-		return;
+		msec_delay = IAVF_NO_RESCHED;
+		goto watchdog_done;
 	}
 
 	/* check for hw reset */
@@ -3080,24 +3053,30 @@ static void iavf_watchdog_task(struct work_struct *work)
 		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
 		dev_err(&adapter->pdev->dev, "Hardware reset detected\n");
 		iavf_schedule_reset(adapter, IAVF_FLAG_RESET_PENDING);
-		mutex_unlock(&adapter->crit_lock);
-		netdev_unlock(netdev);
-		queue_delayed_work(adapter->wq,
-				   &adapter->watchdog_task, HZ * 2);
-		return;
+		msec_delay = 2000;
+		goto watchdog_done;
 	}
 
 	mutex_unlock(&adapter->crit_lock);
 restart_watchdog:
 	netdev_unlock(netdev);
+
+	/* note that we schedule a different task */
 	if (adapter->state >= __IAVF_DOWN)
 		queue_work(adapter->wq, &adapter->adminq_task);
 	if (adapter->aq_required)
-		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
-				   msecs_to_jiffies(20));
+		msec_delay = 20;
 	else
+		msec_delay = 2000;
+	goto skip_unlock;
+watchdog_done:
+	mutex_unlock(&adapter->crit_lock);
+	netdev_unlock(netdev);
+skip_unlock:
+
+	if (msec_delay != IAVF_NO_RESCHED)
 		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
-				   HZ * 2);
+				   msecs_to_jiffies(msec_delay));
 }
 
 /**
-- 
2.47.1


