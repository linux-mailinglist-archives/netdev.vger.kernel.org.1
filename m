Return-Path: <netdev+bounces-194811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 347F1ACCBDD
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 19:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71651897443
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 17:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4B11DFDAB;
	Tue,  3 Jun 2025 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DT2OfbNi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250C11D63CD
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971042; cv=none; b=obiRhDVijHmjQQL7U46VVa0n2VPAeBMhtoHS//tUhf6G3X7hF2nFnRk/12p/PG01B9BfQCgZUFpEjE54IFRKYbPFFDYu8rpf3DLYedSnOIMcfCA+Mo5QIMC0+yECNbFA2fFLGUFeQJBw993lOXcBUvBZD8bYHhtM75dv/21rhJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971042; c=relaxed/simple;
	bh=dWUkRjZh6kBgaYYodI4x8J9rRqG7diI89+kAladn6vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2+8fUoHjT7zSi8eGYVlL0hn/1qxxIOWMsQZKgCBQaSklh4ykY61QUHHMvDtR2IjH+38kx5ilR4mqkWEYA0TjengRsix263IU3w75K/o/HHNScMa28XLEDgWVDrrsYuGf2k2RPRPtdBpghHSEBAgugjziVziykQTPLShkDPBxQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DT2OfbNi; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748971041; x=1780507041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dWUkRjZh6kBgaYYodI4x8J9rRqG7diI89+kAladn6vk=;
  b=DT2OfbNiYSiFN/8KYx/yEJ3KFdWZY4nAOb5L+312SeBSUItBIGp71RGH
   E5brM6yB0KSssKz+1pzLuYYLugg2jrwh661pBM+dhvt5VQvmZ791AXgD2
   LzuZlxbP+U95XzTCVAE651IgErKHNNBev1OX7VE1MVwPsbyu16ThPdpJG
   0ZAeOQ+sNWGntRWsNyQnq2kX3yp8cn5TkMLlXw9Mj29YciHPxpj/g6zEF
   JXzGDECeQ/KVDHJrspW/1SocIWFR/RJ1p216juaUVTTsoo6HpsJIEV0Al
   pA+3fnCwd/j6EIMW9G2IjoLp/OJKi4vOkRFx6uMbvgeP7fa6NQUALtx2S
   w==;
X-CSE-ConnectionGUID: oZsI0oK8QjKdt+vexKB3+w==
X-CSE-MsgGUID: 21BdRqrRTJGN/bfFGztsPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="73556784"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="73556784"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 10:17:17 -0700
X-CSE-ConnectionGUID: H9VIggi+QamCzXmJR5eEXw==
X-CSE-MsgGUID: CXS/pRyYRI+Ic0tJzhklHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="145546433"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 03 Jun 2025 10:17:18 -0700
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
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 4/6] iavf: extract iavf_watchdog_step() out of iavf_watchdog_task()
Date: Tue,  3 Jun 2025 10:17:05 -0700
Message-ID: <20250603171710.2336151-5-anthony.l.nguyen@intel.com>
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

Finish up easy refactor of watchdog_task, total for this + prev two
commits is:
 1 file changed, 47 insertions(+), 82 deletions(-)

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 87 +++++++++------------
 1 file changed, 39 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 5efe44724d11..4b6963ffaba5 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2913,30 +2913,14 @@ static void iavf_init_config_adapter(struct iavf_adapter *adapter)
 
 static const int IAVF_NO_RESCHED = -1;
 
-/**
- * iavf_watchdog_task - Periodic call-back task
- * @work: pointer to work_struct
- **/
-static void iavf_watchdog_task(struct work_struct *work)
+/* return: msec delay for requeueing itself */
+static int iavf_watchdog_step(struct iavf_adapter *adapter)
 {
-	struct iavf_adapter *adapter = container_of(work,
-						    struct iavf_adapter,
-						    watchdog_task.work);
-	struct net_device *netdev = adapter->netdev;
 	struct iavf_hw *hw = &adapter->hw;
-	int msec_delay;
 	u32 reg_val;
 
-	netdev_lock(netdev);
-	if (!mutex_trylock(&adapter->crit_lock)) {
-		if (adapter->state == __IAVF_REMOVE) {
-			netdev_unlock(netdev);
-			return;
-		}
-
-		msec_delay = 20;
-		goto restart_watchdog;
-	}
+	netdev_assert_locked(adapter->netdev);
+	lockdep_assert_held(&adapter->crit_lock);
 
 	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED)
 		iavf_change_state(adapter, __IAVF_COMM_FAILED);
@@ -2944,24 +2928,19 @@ static void iavf_watchdog_task(struct work_struct *work)
 	switch (adapter->state) {
 	case __IAVF_STARTUP:
 		iavf_startup(adapter);
-		msec_delay = 30;
-		goto watchdog_done;
+		return 30;
 	case __IAVF_INIT_VERSION_CHECK:
 		iavf_init_version_check(adapter);
-		msec_delay = 30;
-		goto watchdog_done;
+		return 30;
 	case __IAVF_INIT_GET_RESOURCES:
 		iavf_init_get_resources(adapter);
-		msec_delay = 1;
-		goto watchdog_done;
+		return 1;
 	case __IAVF_INIT_EXTENDED_CAPS:
 		iavf_init_process_extended_caps(adapter);
-		msec_delay = 1;
-		goto watchdog_done;
+		return 1;
 	case __IAVF_INIT_CONFIG_ADAPTER:
 		iavf_init_config_adapter(adapter);
-		msec_delay = 1;
-		goto watchdog_done;
+		return 1;
 	case __IAVF_INIT_FAILED:
 		if (test_bit(__IAVF_IN_REMOVE_TASK,
 			     &adapter->crit_section)) {
@@ -2969,21 +2948,18 @@ static void iavf_watchdog_task(struct work_struct *work)
 			 * watchdog task, iavf_remove should handle this state
 			 * as it can loop forever
 			 */
-			msec_delay = IAVF_NO_RESCHED;
-			goto watchdog_done;
+			return IAVF_NO_RESCHED;
 		}
 		if (++adapter->aq_wait_count > IAVF_AQ_MAX_ERR) {
 			dev_err(&adapter->pdev->dev,
 				"Failed to communicate with PF; waiting before retry\n");
 			adapter->flags |= IAVF_FLAG_PF_COMMS_FAILED;
 			iavf_shutdown_adminq(hw);
-			msec_delay = 5000;
-			goto watchdog_done;
+			return 5000;
 		}
 		/* Try again from failed step*/
 		iavf_change_state(adapter, adapter->last_state);
-		msec_delay = 1000;
-		goto watchdog_done;
+		return 1000;
 	case __IAVF_COMM_FAILED:
 		if (test_bit(__IAVF_IN_REMOVE_TASK,
 			     &adapter->crit_section)) {
@@ -2993,8 +2969,7 @@ static void iavf_watchdog_task(struct work_struct *work)
 			 */
 			iavf_change_state(adapter, __IAVF_INIT_FAILED);
 			adapter->flags &= ~IAVF_FLAG_PF_COMMS_FAILED;
-			msec_delay = IAVF_NO_RESCHED;
-			goto watchdog_done;
+			return IAVF_NO_RESCHED;
 		}
 		reg_val = rd32(hw, IAVF_VFGEN_RSTAT) &
 			  IAVF_VFGEN_RSTAT_VFR_STATE_MASK;
@@ -3012,11 +2987,9 @@ static void iavf_watchdog_task(struct work_struct *work)
 		}
 		adapter->aq_required = 0;
 		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
-		msec_delay = 10;
-		goto watchdog_done;
+		return 10;
 	case __IAVF_RESETTING:
-		msec_delay = 2000;
-		goto watchdog_done;
+		return 2000;
 	case __IAVF_DOWN:
 	case __IAVF_DOWN_PENDING:
 	case __IAVF_TESTING:
@@ -3043,8 +3016,7 @@ static void iavf_watchdog_task(struct work_struct *work)
 		break;
 	case __IAVF_REMOVE:
 	default:
-		msec_delay = IAVF_NO_RESCHED;
-		goto watchdog_done;
+		return IAVF_NO_RESCHED;
 	}
 
 	/* check for hw reset */
@@ -3055,12 +3027,31 @@ static void iavf_watchdog_task(struct work_struct *work)
 		dev_err(&adapter->pdev->dev, "Hardware reset detected\n");
 		iavf_schedule_reset(adapter, IAVF_FLAG_RESET_PENDING);
 	}
-	if (adapter->aq_required)
+
+	return adapter->aq_required ? 20 : 2000;
+}
+
+static void iavf_watchdog_task(struct work_struct *work)
+{
+	struct iavf_adapter *adapter = container_of(work,
+						    struct iavf_adapter,
+						    watchdog_task.work);
+	struct net_device *netdev = adapter->netdev;
+	int msec_delay;
+
+	netdev_lock(netdev);
+	if (!mutex_trylock(&adapter->crit_lock)) {
+		if (adapter->state == __IAVF_REMOVE) {
+			netdev_unlock(netdev);
+			return;
+		}
+
 		msec_delay = 20;
-	else
-		msec_delay = 2000;
+		goto restart_watchdog;
+	}
+
+	msec_delay = iavf_watchdog_step(adapter);
 
-watchdog_done:
 	mutex_unlock(&adapter->crit_lock);
 restart_watchdog:
 	netdev_unlock(netdev);
-- 
2.47.1


