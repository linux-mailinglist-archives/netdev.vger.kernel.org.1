Return-Path: <netdev+bounces-196241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45918AD4026
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 19:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E15A7A81E0
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 17:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CB6244696;
	Tue, 10 Jun 2025 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IvF5BAIA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA55424466F
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749575639; cv=none; b=UzmxsFWqDZIwWiaVeqOxLCOvBqCpzd2EdlT7N13Sn30cjsAehvzh9PhQZ1XymhJL5IyoAaJ7XOGltEVb+pAgdu+ZQ19slHAcfvNRTspyuxkQdBgJgfiiVGyok2wMMYKvubbBezXxHp9bIX0FBVaumeYplyBQon8gXkO2kcHmKNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749575639; c=relaxed/simple;
	bh=6vNKxZ4k/mjDCAC7wnHxsP8kYKKVeMGD8c/Z/z5v4G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ov2QdVN+nxQeoVBK9qq9fxcWueL2doy97h+Mzcm6JewLkIIMGENcuweSNzst+JsHqFxkZLDNGVilK5yQ83Eey8uZHz74FKbLLBojVDr/E6wluvpJU4tKl1zv8nsd4qk3CxK4wIixlfDtBlSF9FmcS8RhiwXX5OCmvAXo8PZ+j/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IvF5BAIA; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749575638; x=1781111638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6vNKxZ4k/mjDCAC7wnHxsP8kYKKVeMGD8c/Z/z5v4G8=;
  b=IvF5BAIA6AOc+r4gKAmmZ05yDINzuj7js/izqjQHbE0xljFFbQddEmwC
   dKBobPTEHDoZpsqdBVpXyUIVv6QzcPbI7PHT+XcqAwKeXiy9752sh+cnO
   6qJESWAyhDSx20P7FOw+oRgTOiv4NAfZe+AlT1kJM/uWJd4TAk5Op+wov
   sW8A2fjyN9mNhXbsFkSzAl4esuP1UVmSAMO9auFhW2t9GofblWuuC4rSr
   SJynmgDswQdqLKc7bKbTm/gzHnAS7N2QcVYWKmHQwou5mur9HeCblIe1Z
   jQyeeeP7gEFAj0YY+/YjPwMmJ82hTeDF8p0VXZGmGrOJfy+YKGWEY9n3H
   g==;
X-CSE-ConnectionGUID: mCxQnarbQ4KPo5tfzzvefQ==
X-CSE-MsgGUID: 3/ZXxOcvT52FRSuGNKceWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51554663"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="51554663"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 10:13:54 -0700
X-CSE-ConnectionGUID: vs0GhhyvRKW+uMfoyi+n0w==
X-CSE-MsgGUID: MJajWEV2TgqABcPd+h6f8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="147850443"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 10 Jun 2025 10:13:54 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Ahmed Zaki <ahmed.zaki@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 3/5] iavf: fix reset_task for early reset event
Date: Tue, 10 Jun 2025 10:13:43 -0700
Message-ID: <20250610171348.1476574-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250610171348.1476574-1-anthony.l.nguyen@intel.com>
References: <20250610171348.1476574-1-anthony.l.nguyen@intel.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
2.47.1


