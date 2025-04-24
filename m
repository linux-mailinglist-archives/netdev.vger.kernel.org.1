Return-Path: <netdev+bounces-185579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B873BA9AF97
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7181626D2
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 13:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D46413C8EA;
	Thu, 24 Apr 2025 13:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jc/7nrV+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086491487E1
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 13:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745502358; cv=none; b=FsxjjzEI9q9FQvOSPzYqj7GHMzKiVUhKUH60RqR1ZZ4lc/STdO4N3Kt07/hsz0ENTcL0hyF73aqzvYD78cKzG3I+X5wBsjZ6BiIFM+ut5eEoq72DcMRaL2XpVs1SKLjFFOEZcUFuE9mcc2pTQpIQaZfPu4hiHlvsdUnUz1A6d60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745502358; c=relaxed/simple;
	bh=EaPlOOkwoaHOqnFnPKdZZ5bPFm4LG2Z/rj4vlbPNFOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hUQzTn1s/9p2MtU1Gxesi9y6ek6xw/C4g9M4rBB72553qcfuWSwv8llGJ9DnsHbwCKIqN88ciyJdAisTkSvjJc0tepB8FpcGqFyp0nNVvw2gZbcy3ipY9SLb3hVIEtrrAoxAM5saDKFF6nyhzBSyhXMARaG2GQKTLDRm5Vjp61k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jc/7nrV+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745502356; x=1777038356;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EaPlOOkwoaHOqnFnPKdZZ5bPFm4LG2Z/rj4vlbPNFOI=;
  b=Jc/7nrV+gPa9qwM5Uxh4KsDHBHDDb10ROr29GaV0TcMn3rN2GfpX0/oW
   7ewsqeY4D+WOo9JOIev7ymzUNn+MjV6dyCCt7QN3KptsIzLuczrkSizdQ
   T87PsjcfDGV1Cr+Jc5cWJK7pDF/Rq7xajnHUHGsD2XtGe+pvAS5TVn00e
   uIsGw4UXb09ms2k4257fKgNwgDqG2xB4foR3FgyiPan24x/4Wop7xXGCf
   pmMLX3vwaLFePAbf+Uo57MdkjJXWZfMRVdUENoEgZnVsb+ckaM0yb5YNa
   /rWidBLabps3jStc97Ik4/GuoJX8dJDnobh84xzitAg7POV9G3KFhs/oa
   Q==;
X-CSE-ConnectionGUID: Nj/WM6a7QQiwwEhiJBLpJw==
X-CSE-MsgGUID: pg3ITb4kS+6xd+HNQLpNGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47022352"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="47022352"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 06:45:55 -0700
X-CSE-ConnectionGUID: GdLgjI/JSOWaMWZJ+68j0w==
X-CSE-MsgGUID: Z7wFKSf+SByy2Zl5cK+YgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="132932036"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa008.fm.intel.com with ESMTP; 24 Apr 2025 06:45:53 -0700
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 4B878135C3;
	Thu, 24 Apr 2025 14:45:52 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-net] iavf: fix reset_task for early reset event
Date: Thu, 24 Apr 2025 15:50:13 +0200
Message-ID: <20250424135012.5138-2-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ahmed Zaki <ahmed.zaki@intel.com>

If a reset event is received from the PF early in the init cycle, the
state machine hangs for about 25 seconds.

Reproducer:
  echo 1 > /sys/class/net/$PF0/device/sriov_numvfs
  ip link set dev $PF0 vf 0 mac $NEW_MAC

The log shows:
  [792.620416] ice 0000:5e:00.0: Enabling 1 VFs
  [792.738812] iavf 0000:5e:01.0: enabling device (0000 -> 0002)
  [792.744182] ice 0000:5e:00.0: Enabling 1 VFs with 17 vectors and 16 queues per VF
  [792.839964] ice 0000:5e:00.0: Setting MAC 52:54:00:00:00:11 on VF 0. VF driver will be reinitialized
  [813.389684] iavf 0000:5e:01.0: Failed to communicate with PF; waiting before retry
  [818.635918] iavf 0000:5e:01.0: Hardware came out of reset. Attempting reinit.
  [818.766273] iavf 0000:5e:01.0: Multiqueue Enabled: Queue pair count = 16

Fix it by scheduling the reset task and making the reset task capable of
resetting early in the init cycle.

Fixes: ef8693eb90ae3 ("i40evf: refactor reset handling")
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Tested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
This should be applied after "iavf: get rid of the crit lock"
---
 drivers/net/ethernet/intel/iavf/iavf_main.c     | 11 +++++++++++
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 17 +++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 2c0bb41809a4..81d7249d1149 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3209,6 +3209,17 @@ static void iavf_reset_task(struct work_struct *work)
 	}
 
 continue_reset:
+	/* If we are still early in the state machine, just restart. */
+	if (adapter->state <= __IAVF_INIT_FAILED) {
+		iavf_shutdown_adminq(hw);
+		iavf_change_state(adapter, __IAVF_STARTUP);
+		iavf_startup(adapter);
+		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
+				   msecs_to_jiffies(30));
+		netdev_unlock(netdev);
+		return;
+	}
+
 	/* We don't use netif_running() because it may be true prior to
 	 * ndo_open() returning, so we can't assume it means all our open
 	 * tasks have finished, since we're not holding the rtnl_lock here.
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index a6f0e5990be2..07f0d0a0f1e2 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -79,6 +79,23 @@ iavf_poll_virtchnl_msg(struct iavf_hw *hw, struct iavf_arq_event_info *event,
 			return iavf_status_to_errno(status);
 		received_op =
 		    (enum virtchnl_ops)le32_to_cpu(event->desc.cookie_high);
+
+		if (received_op == VIRTCHNL_OP_EVENT) {
+			struct iavf_adapter *adapter = hw->back;
+			struct virtchnl_pf_event *vpe =
+				(struct virtchnl_pf_event *)event->msg_buf;
+
+			if (vpe->event != VIRTCHNL_EVENT_RESET_IMPENDING)
+				continue;
+
+			dev_info(&adapter->pdev->dev, "Reset indication received from the PF\n");
+			if (!(adapter->flags & IAVF_FLAG_RESET_PENDING))
+				iavf_schedule_reset(adapter,
+						    IAVF_FLAG_RESET_PENDING);
+
+			return -EIO;
+		}
+
 		if (op_to_poll == received_op)
 			break;
 	}
-- 
2.49.0


