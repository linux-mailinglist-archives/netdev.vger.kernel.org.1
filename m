Return-Path: <netdev+bounces-262975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJDwIs82pmloMgAAu9opvQ
	(envelope-from <netdev+bounces-262975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 02:18:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3526A1E79B8
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 02:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 848F3306B4D5
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 01:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095E634A775;
	Tue,  3 Mar 2026 01:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZHYM4FK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9283535BDAC
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 01:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772500680; cv=none; b=MMtaWY8RH48tZKw4+mOyb/POa/ouZvkuaA2t5hhG5tqMWhvKGuBSy7g7l7BuNToYi08KoMST1m39QZXGBCisOmWY56X0ZinxcZ4/oeGMNypG1OS14gRkaprwdG5MQozfPuaOOed1PgnGiTf+BznjQ2PWZHEi0XyRKx5g1PguRVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772500680; c=relaxed/simple;
	bh=YyV/2W+rzuQDsuStd2bW++jjatn642X5DiNInwOahgE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ua1muCMg28RJn8/q6ScrZLPclrHGKoU7TMNe2jl5c40SmFUsuOh/rZ0MjK6Zi7OwTIEZo3+/y1MDvls+mZcHftpvtcKNXcdfOMImJIXLuDd8woPX+A/aGKCFZrdscKZC+FYbR7qA4IyPpDeEJ2GBEPwRLvfTxMc3fpwCDixZCTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZHYM4FK; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772500678; x=1804036678;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YyV/2W+rzuQDsuStd2bW++jjatn642X5DiNInwOahgE=;
  b=FZHYM4FK9stcAj/aGBN7C/us6iZRTGCO4Di4dMhO7wfniEgN0sdLtwEB
   W5ofbxOB+4Q1py0FHPe4DqoGvxPSuwHxh/UITlfCw1Qd91848kF+i/8+Z
   MXXx2/YlJJDkgpVscx0pW1n4efW6ke+T1QPXLr1XkpagUgtGgfCUYAhCL
   +duz6KVnYu9lCC3u1Sw4+QvHo0HPu3YOgrqyAWN97pdeB9EA93Am3uhZm
   a1FmMnG7/E2WKhqC0cwaTzkIc0r8A/JCv5NFQYGhlQPL5Apkyy15O5TZa
   w4F8R8MUOF5nZRfutISIzfhR03kCCLpIwep9+eRrGN/3/1R5dZEboDLAW
   w==;
X-CSE-ConnectionGUID: dlLOSBVXTN2urIf+jCwbpw==
X-CSE-MsgGUID: llO2CEDhTF6ZmacQK05AXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="96137598"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="96137598"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 17:17:57 -0800
X-CSE-ConnectionGUID: 7B/3Sl81TgG4P9UlbQocbg==
X-CSE-MsgGUID: r7+fbmdWQ/+ld7cGDSSWwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="217064310"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.14])
  by orviesa010.jf.intel.com with ESMTP; 02 Mar 2026 17:17:57 -0800
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Joshua Hay <joshua.a.hay@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-net] idpf: clear stale cdev_info ptr
Date: Mon,  2 Mar 2026 17:28:31 -0800
Message-Id: <20260303012831.662492-1-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3526A1E79B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262975-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[joshua.a.hay@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action

Deinit calls idpf_idc_deinit_core_aux_device to free the cdev_info
memory, but leaves the adapter->cdev_info field with a stale pointer
value. This will bypass subsequent "if (!cdev_info)" checks if cdev_info
is not reallocated. For example, if idc_init fails after a reset,
cdev_info will already have been freed during the reset handling, but it
will not have been reallocated. The next reset or rmmod will result in a
crash.

[  +0.000008] BUG: kernel NULL pointer dereference, address: 00000000000000d0
[  +0.000033] #PF: supervisor read access in kernel mode
[  +0.000020] #PF: error_code(0x0000) - not-present page
[  +0.000017] PGD 2097dfa067 P4D 0
[  +0.000017] Oops: Oops: 0000 [#1] SMP NOPTI
...
[  +0.000018] RIP: 0010:device_del+0x3e/0x3d0
[  +0.000010] Call Trace:
[  +0.000010]  <TASK>
[  +0.000012]  idpf_idc_deinit_core_aux_device+0x36/0x70 [idpf]
[  +0.000034]  idpf_vc_core_deinit+0x3e/0x180 [idpf]
[  +0.000035]  idpf_remove+0x40/0x1d0 [idpf]
[  +0.000035]  pci_device_remove+0x42/0xb0
[  +0.000020]  device_release_driver_internal+0x19c/0x200
[  +0.000024]  driver_detach+0x48/0x90
[  +0.000018]  bus_remove_driver+0x6d/0x100
[  +0.000023]  pci_unregister_driver+0x2e/0xb0
[  +0.000022]  __do_sys_delete_module.isra.0+0x18c/0x2b0
[  +0.000025]  ? kmem_cache_free+0x2c2/0x390
[  +0.000023]  do_syscall_64+0x107/0x7d0
[  +0.000023]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Pass the adapter struct into idpf_idc_deinit_core_aux_device instead and
clear the cdev_info ptr.

Fixes: f4312e6bfa2a ("idpf: implement core RDMA auxiliary dev create, init, and destroy")
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h          | 2 +-
 drivers/net/ethernet/intel/idpf/idpf_idc.c      | 6 ++++--
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index b206fba092c8..ec1b75f039bb 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -1066,7 +1066,7 @@ bool idpf_vport_set_hsplit(const struct idpf_vport *vport, u8 val);
 int idpf_idc_init(struct idpf_adapter *adapter);
 int idpf_idc_init_aux_core_dev(struct idpf_adapter *adapter,
 			       enum iidc_function_type ftype);
-void idpf_idc_deinit_core_aux_device(struct iidc_rdma_core_dev_info *cdev_info);
+void idpf_idc_deinit_core_aux_device(struct idpf_adapter *adapter);
 void idpf_idc_deinit_vport_aux_device(struct iidc_rdma_vport_dev_info *vdev_info);
 void idpf_idc_issue_reset_event(struct iidc_rdma_core_dev_info *cdev_info);
 void idpf_idc_vdev_mtu_event(struct iidc_rdma_vport_dev_info *vdev_info,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index bd4785fb8d3e..7e4f4ac92653 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -470,10 +470,11 @@ int idpf_idc_init_aux_core_dev(struct idpf_adapter *adapter,
 
 /**
  * idpf_idc_deinit_core_aux_device - de-initialize Auxiliary Device(s)
- * @cdev_info: IDC core device info pointer
+ * @adapter: driver private data structure
  */
-void idpf_idc_deinit_core_aux_device(struct iidc_rdma_core_dev_info *cdev_info)
+void idpf_idc_deinit_core_aux_device(struct idpf_adapter *adapter)
 {
+	struct iidc_rdma_core_dev_info *cdev_info = adapter->cdev_info;
 	struct iidc_rdma_priv_dev_info *privd;
 
 	if (!cdev_info)
@@ -485,6 +486,7 @@ void idpf_idc_deinit_core_aux_device(struct iidc_rdma_core_dev_info *cdev_info)
 	kfree(privd->mapped_mem_regions);
 	kfree(privd);
 	kfree(cdev_info);
+	adapter->cdev_info = NULL;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index d5a877e1fef8..113ecfc16dd7 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3668,7 +3668,7 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 
 	idpf_ptp_release(adapter);
 	idpf_deinit_task(adapter);
-	idpf_idc_deinit_core_aux_device(adapter->cdev_info);
+	idpf_idc_deinit_core_aux_device(adapter);
 	idpf_rel_rx_pt_lkup(adapter);
 	idpf_intr_rel(adapter);
 
-- 
2.39.2


