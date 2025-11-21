Return-Path: <netdev+bounces-240594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6723BC76BB1
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 01:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2D6F73583B7
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 00:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BD4223DD6;
	Fri, 21 Nov 2025 00:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YCro1LeL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CCB218AAB
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 00:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763684360; cv=none; b=ushWyNJ4LP8DgUm3mxsmePb0q9khI/upes2L/MF1LIHrcb1MiaBQDjoHg8G6dNE0Wsbi1VhUy54HGhtCcQxqFRZkk9GUB46mPccLJowfOMfwMg7NCXmeu67NQMzD4xGxryWVyUTHYdveTofJmL/5onbW0DBCRRR0dbfr7oU14eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763684360; c=relaxed/simple;
	bh=WBReMd/4kyyzfFC4PN4BcAjrw+uONVzAFH3InTSJ9D8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=krZkWhyaPSgdSWBeI/8BxA84uOrNm6kj+4xYrkHSIgE6yfi5wux/vZtb6NVy0s/if5oX+z/Luzo458stqM7UpoeSz5pkN5AF5zkqerG7Rk2k/GO2NkRGhkc0HBsFdaAp6/o1Df/O35vh7mTKWAtLiKdn+nucQVPancOpqMeRKek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YCro1LeL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763684360; x=1795220360;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=WBReMd/4kyyzfFC4PN4BcAjrw+uONVzAFH3InTSJ9D8=;
  b=YCro1LeLS0K+A3jC/VFnbN1QkGlvXtlggfYB4w8L8M6Vlb3GXMD06wm7
   C4udj1v3ZLQ8FQvREfjyjV0tlJxmpqbYRcBVco2k2cT3C7J0//mDvVt0m
   Miuw5ExIwS6RLOIHLq62GJOsMN5Jd+8mHrVZjil8/KXnpGr3Vw3RXNp3o
   fNoaiOHgrsOVUsFvq4v+jgCxdOP+2i8PENYfLmEr3KGLVRK+B/Z9hl1ND
   pKjNUQ974p+7s6L0XIDWyuCoLKfyjNLaijhT2mlpUIySjJcjE1GOPWwth
   VPiWpxbdEdTYld4BcSY8lm9V8L92bmFTLWHdrytvFaOoA1EPxCpdGZu2A
   Q==;
X-CSE-ConnectionGUID: QgqciuONRbW+B7ONOQ1HgQ==
X-CSE-MsgGUID: 9EQY6kNYTxGvjl634281Kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="65704083"
X-IronPort-AV: E=Sophos;i="6.20,214,1758610800"; 
   d="scan'208";a="65704083"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 16:19:16 -0800
X-CSE-ConnectionGUID: A3hmL438R/uJjuxBMSU4HA==
X-CSE-MsgGUID: jMKo8rHLSjWvOg33LpUgqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,214,1758610800"; 
   d="scan'208";a="190815185"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by orviesa010.jf.intel.com with ESMTP; 20 Nov 2025 16:19:15 -0800
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Aleksandr.Loktionov@intel.com,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	decot@google.com,
	willemb@google.com,
	joshua.a.hay@intel.com,
	madhu.chittim@intel.com,
	aleksander.lobakin@intel.com,
	larysa.zaremba@intel.com,
	iamvivekkumar@google.com
Subject: [PATCH iwl-net v2 5/5] idpf: fix error handling in the init_task on load
Date: Thu, 20 Nov 2025 16:12:18 -0800
Message-Id: <20251121001218.4565-6-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20251121001218.4565-1-emil.s.tantilov@intel.com>
References: <20251121001218.4565-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

If the init_task fails during a driver load, we end up without vports and
netdevs, effectively failing the entire process. In that state a
subsequent reset will result in a crash as the service task attempts to
access uninitialized resources. Following trace is from an error in the
init_task where the CREATE_VPORT (op 501) is rejected by the FW:

[40922.763136] idpf 0000:83:00.0: Device HW Reset initiated
[40924.449797] idpf 0000:83:00.0: Transaction failed (op 501)
[40958.148190] idpf 0000:83:00.0: HW reset detected
[40958.161202] BUG: kernel NULL pointer dereference, address: 00000000000000a8
...
[40958.168094] Workqueue: idpf-0000:83:00.0-vc_event idpf_vc_event_task [idpf]
[40958.168865] RIP: 0010:idpf_vc_event_task+0x9b/0x350 [idpf]
...
[40958.177932] Call Trace:
[40958.178491]  <TASK>
[40958.179040]  process_one_work+0x226/0x6d0
[40958.179609]  worker_thread+0x19e/0x340
[40958.180158]  ? __pfx_worker_thread+0x10/0x10
[40958.180702]  kthread+0x10f/0x250
[40958.181238]  ? __pfx_kthread+0x10/0x10
[40958.181774]  ret_from_fork+0x251/0x2b0
[40958.182307]  ? __pfx_kthread+0x10/0x10
[40958.182834]  ret_from_fork_asm+0x1a/0x30
[40958.183370]  </TASK>

Fix the error handling in the init_task to make sure the service and
mailbox tasks are disabled if the error happens during load. These are
started in idpf_vc_core_init(), which spawns the init_task and has no way
of knowing if it failed. If the error happens on reset, following
successful driver load, the tasks can still run, as that will allow the
netdevs to attempt recovery through another reset. Stop the PTP callbacks
either way as those will be restarted by the call to idpf_vc_core_init()
during a successful reset.

Fixes: 0fe45467a104 ("idpf: add create vport and netdev configuration")
Reported-by: Vivek Kumar <iamvivekkumar@google.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 5193968c9bb1..89f3b46378c4 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1716,10 +1716,9 @@ void idpf_init_task(struct work_struct *work)
 		set_bit(IDPF_VPORT_REG_NETDEV, vport_config->flags);
 	}
 
-	/* As all the required vports are created, clear the reset flag
-	 * unconditionally here in case we were in reset and the link was down.
-	 */
+	/* Clear the reset and load bits as all vports are created */
 	clear_bit(IDPF_HR_RESET_IN_PROG, adapter->flags);
+	clear_bit(IDPF_HR_DRV_LOAD, adapter->flags);
 	/* Start the statistics task now */
 	queue_delayed_work(adapter->stats_wq, &adapter->stats_task,
 			   msecs_to_jiffies(10 * (pdev->devfn & 0x07)));
@@ -1733,6 +1732,15 @@ void idpf_init_task(struct work_struct *work)
 				idpf_vport_dealloc(adapter->vports[index]);
 		}
 	}
+	/* Cleanup after vc_core_init, which has no way of knowing the
+	 * init task failed on driver load.
+	 */
+	if (test_and_clear_bit(IDPF_HR_DRV_LOAD, adapter->flags)) {
+		cancel_delayed_work_sync(&adapter->serv_task);
+		cancel_delayed_work_sync(&adapter->mbx_task);
+	}
+	idpf_ptp_release(adapter);
+
 	clear_bit(IDPF_HR_RESET_IN_PROG, adapter->flags);
 }
 
@@ -1882,7 +1890,7 @@ static void idpf_init_hard_reset(struct idpf_adapter *adapter)
 	dev_info(dev, "Device HW Reset initiated\n");
 
 	/* Prepare for reset */
-	if (test_and_clear_bit(IDPF_HR_DRV_LOAD, adapter->flags)) {
+	if (test_bit(IDPF_HR_DRV_LOAD, adapter->flags)) {
 		reg_ops->trigger_reset(adapter, IDPF_HR_DRV_LOAD);
 	} else if (test_and_clear_bit(IDPF_HR_FUNC_RESET, adapter->flags)) {
 		bool is_reset = idpf_is_reset_detected(adapter);
-- 
2.37.3


