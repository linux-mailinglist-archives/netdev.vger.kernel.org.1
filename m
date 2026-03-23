Return-Path: <netdev+bounces-270739-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGTLHheqwWmUUQQAu9opvQ
	(envelope-from <netdev+bounces-270739-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:01:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D6B2FD83E
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D381307672F
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1B83E63B0;
	Mon, 23 Mar 2026 20:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XJIuiwEM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20963E5EF3
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 20:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774299536; cv=none; b=P3pH97O4Kz4YXDs2OB+nGmh+WNWkz/xvLZ3WkH41U7dwRc2rJy0uv/8smvO3LrU3yuZBXEf+Y9SxP6sYwBy6E4F1n/odfsQoxFc4CznaTDd6cBMpB+vN5Wf2hEHgZIBKQ0gSMu4p/n3/Bow9BuVcY6BKzDceXhSpYXZfG1pQs4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774299536; c=relaxed/simple;
	bh=Oekiu9iLX0LO+Sb2Dvg1frdS6OgkYUYzxnnNHvlUHXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XD1Yi01bBC8Y7jZkyUwd6fEdLFp7M4TTs24Jr/W4hgDsKLKvqbMu9myjJXGB/9aQxcoEwMO7QhSuXBXkpR+fGIaEdG6Ms4EP/ekipo1AbgkEolLbfGsl2WmDgOCszwntvBewJV0k5nqtX83k0oDknayn8hmTs/eBWR8ImVbHJRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XJIuiwEM; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774299534; x=1805835534;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Oekiu9iLX0LO+Sb2Dvg1frdS6OgkYUYzxnnNHvlUHXA=;
  b=XJIuiwEMoDIUByaZb1KcDewe+IKh43V+piBkAsjk1y9UgGD0Yra1+h1l
   oD1RHFP8ZzAYQ4gJM7yt2ZhoLsnRXTNoFPgSsfxFvZqBhhl15s9nMEKZK
   D3U1GPjrRLLfXj5YNHCoS3AIYAXPlzqBBU1TSnXWT6QJmG5r6zCE23ULQ
   6RDm2AuRITb+6+7eZv9iqlUzBmqMQnj/GDyX2W5+L2qfBmH0aqcIwZ0FN
   dZfVXl9WTue4O2qbw1ixj+P4XaHtSrZFO6zHcrOmYkFwh+dbxel9XgQSg
   Dp2dpo7oqlbvkWkV1TeZdur2bcb3INZ6Xy2nAXKTB5eOadFABhVyMDswK
   g==;
X-CSE-ConnectionGUID: SipxMC76SqK3DGcXVDJreg==
X-CSE-MsgGUID: 9kH3NgSpSxCz57Sx940R4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75375524"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75375524"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 13:58:50 -0700
X-CSE-ConnectionGUID: iz4MqkORSACqgle9YrHxQQ==
X-CSE-MsgGUID: q47LZ2kZQLO1TIgDXlyTnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="224114427"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 23 Mar 2026 13:58:50 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Joshua Hay <joshua.a.hay@intel.com>,
	anthony.l.nguyen@intel.com,
	tatyana.e.nikolova@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 5/6] idpf: clear stale cdev_info ptr
Date: Mon, 23 Mar 2026 13:58:40 -0700
Message-ID: <20260323205843.624704-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260323205843.624704-1-anthony.l.nguyen@intel.com>
References: <20260323205843.624704-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270739-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: E3D6B2FD83E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Joshua Hay <joshua.a.hay@intel.com>

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
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
2.47.1


