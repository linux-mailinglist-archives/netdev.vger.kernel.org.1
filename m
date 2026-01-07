Return-Path: <netdev+bounces-247507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A2CCFB6DC
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 01:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B2AD3088173
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 00:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF84715B971;
	Wed,  7 Jan 2026 00:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kfspnx26"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A099286A4
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 00:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767744420; cv=none; b=gbVhgVwmoZlt6c4vhJp0diagkrfjuSHWqQjF22hs1TcPClqOKr/uAmWNO0mg/w8HLmh+7ZC+iQ5M3Cj7C/FMP1iCGmb4nGN1SDuv7QEhAATel4GRPAJPw4PJn64KQxkbrbUr5KvxYRwbHDIb/C1g0YYiwRSiHstHV8EMMTXtvoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767744420; c=relaxed/simple;
	bh=AaiR5a9N/qk2HboRFlDk0rKdAT5fsQg1rDY5Y3JzOko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GH7Dogb3rxQ/C9LWRBK08m8RLI7mL3vq9jjn1E0XLh/tuUaIUxdE2GhnmUjLVMRov3D2U3CFTYS48vtEMaCgiGd00BQMvKjLQSGDwPYqr4lqiCUtJrUpkfpeS42TcbU3Q761nKEeKhwGcWVftP5ED6MrYgN6XKDG8xcPiP21bjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kfspnx26; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767744418; x=1799280418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AaiR5a9N/qk2HboRFlDk0rKdAT5fsQg1rDY5Y3JzOko=;
  b=kfspnx26nnFQRWxp19iPWn+ah9R0jinAZs7KDRPc8kSkJGaSG+DbqXNT
   xHlHivqMXQlk4rbwa1NpFIUIZKhQJkbR2IiMvHEK6epkiIYeK3+1k7uh2
   6Zpbs0Zu1zbUv17xoLJsngf9UTnrcZtud1D7hAOiPPCWVd/bWHNNugcw3
   h0Zq5yw5BbUZ8LnFg4+dz4OGr91/glC/Ji8Unlnoivq3pP/ulhjU0Qpbp
   WbAnIw8Qdh0yxfD5gi7e7FNewmDj434Tat7voF78nzqyLXpfzjufKVDAr
   IB7Vvw86Jx7/e76QznDoz6NLqCYR7MwLLNI8uNcr1kDl+ulo6qQyzkYW0
   w==;
X-CSE-ConnectionGUID: eljDAwtuQGGtR4a8+CkVkA==
X-CSE-MsgGUID: J+uIJYgtQYi2PHbWAn2AzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="69161640"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="69161640"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 16:06:54 -0800
X-CSE-ConnectionGUID: HLJRKZIoRpuftIuxfysp/w==
X-CSE-MsgGUID: AuJTzBGdSSi/CFmrUV2shg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="207841190"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 06 Jan 2026 16:06:54 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Emil Tantilov <emil.s.tantilov@intel.com>,
	anthony.l.nguyen@intel.com,
	joshua.a.hay@intel.com,
	madhu.chittim@intel.com,
	larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com,
	iamvivekkumar@google.com,
	decot@google.com,
	willemb@google.com,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 05/13] idpf: fix error handling in the init_task on load
Date: Tue,  6 Jan 2026 16:06:37 -0800
Message-ID: <20260107000648.1861994-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260107000648.1861994-1-anthony.l.nguyen@intel.com>
References: <20260107000648.1861994-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Tantilov <emil.s.tantilov@intel.com>

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
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 04af10cfaa8c..e2ee8b137421 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1690,10 +1690,9 @@ void idpf_init_task(struct work_struct *work)
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
@@ -1707,6 +1706,15 @@ void idpf_init_task(struct work_struct *work)
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
 
@@ -1856,7 +1864,7 @@ static void idpf_init_hard_reset(struct idpf_adapter *adapter)
 	dev_info(dev, "Device HW Reset initiated\n");
 
 	/* Prepare for reset */
-	if (test_and_clear_bit(IDPF_HR_DRV_LOAD, adapter->flags)) {
+	if (test_bit(IDPF_HR_DRV_LOAD, adapter->flags)) {
 		reg_ops->trigger_reset(adapter, IDPF_HR_DRV_LOAD);
 	} else if (test_and_clear_bit(IDPF_HR_FUNC_RESET, adapter->flags)) {
 		bool is_reset = idpf_is_reset_detected(adapter);
-- 
2.47.1


