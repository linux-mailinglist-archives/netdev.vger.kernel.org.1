Return-Path: <netdev+bounces-219361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2CFB410B4
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BA30167553
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7E727F170;
	Tue,  2 Sep 2025 23:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U27wh44l"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D6127A91D
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 23:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756855302; cv=none; b=B3YXNLqs4EZtZouniUJs91Y2iwlqFtd3VNrislgimK8sZYlPSPde+7CKZQDfYuAl/CqJm9r6Lh4kXVOJHFDKs1DuEPW5WwmKM9YpqzpTyNOJCfkHE8uiepN/n6MaKqT4XayX0KFSbfWsqqGqrY2LnxzawBpDSeg4dFjcKxU9AIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756855302; c=relaxed/simple;
	bh=Rk3hU3jP25AnCRuBXa3eq3AexcC6eN3zR0CLqpL11mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQuRBEdFwH6rlIq9HDxp8pKW9oBrkTrDIZug++LPSVf8sOjz+2QI6dhOyiiD+Si2B6ujuOe+HDfGsFFa0pDMg9ahh0V+K6e13kETWqISCeeDNtyBtNGDLwrQj4EQt3VXyIXmKpp9yCVrLk/MTlrqsYO0xJy5rmIu8QxvLNU93Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U27wh44l; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756855301; x=1788391301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rk3hU3jP25AnCRuBXa3eq3AexcC6eN3zR0CLqpL11mw=;
  b=U27wh44l2rMfjsWZHTBE5Pv9pNp5Oye+XoJtVUMUSmFHaj7JHhrK8qbU
   6F5eZw54ufbcvMfcuBO53OGWZ7w78rNfq4/2d52SXiFWkGG225ZNCKDIj
   lCScn+eSK96sL3c5yI151svOZCyHnO1F3ilXM3Ypm36Z+mj2M4o4YHhiB
   03pPm9uuBHB1O3qszy/toaicsO/QOQBR7NbPL0PjGKFWzYBOATWrdaVVq
   UXQSduCD8pTkneLgGCNsDsD7DiAGSaK1hiG3JVclaUpRlPlgTkX5CgpIb
   HHiD8fxM/GRsY5/nOiKM0V5tG8CtvofWpRiHQURdGULBuCsmIXjYdirPT
   A==;
X-CSE-ConnectionGUID: aFibRPdISeeZq7f2hksJfA==
X-CSE-MsgGUID: zugZ4bXcRC+aN7olCYjrJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69767199"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="69767199"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 16:21:37 -0700
X-CSE-ConnectionGUID: OL0iF9uIT/qvzJ9rxYa6GA==
X-CSE-MsgGUID: p/1qDIy7QKWNpAMWZ6LtLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="171575896"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 02 Sep 2025 16:21:38 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Joshua Hay <joshua.a.hay@intel.com>,
	anthony.l.nguyen@intel.com,
	larysa.zaremba@intel.com,
	tatyana.e.nikolova@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Samuel Salin <Samuel.salin@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net 3/8] idpf: fix UAF in RDMA core aux dev deinitialization
Date: Tue,  2 Sep 2025 16:21:23 -0700
Message-ID: <20250902232131.2739555-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250902232131.2739555-1-anthony.l.nguyen@intel.com>
References: <20250902232131.2739555-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Hay <joshua.a.hay@intel.com>

Free the adev->id before auxiliary_device_uninit. The call to uninit
triggers the release callback, which frees the iadev memory containing the
adev. The previous flow results in a UAF during rmmod due to the adev->id
access.

[264939.604077] ==================================================================
[264939.604093] BUG: KASAN: slab-use-after-free in idpf_idc_deinit_core_aux_device+0xe4/0x100 [idpf]
[264939.604134] Read of size 4 at addr ff1100109eb6eaf8 by task rmmod/17842

...

[264939.604635] Allocated by task 17597:
[264939.604643]  kasan_save_stack+0x20/0x40
[264939.604654]  kasan_save_track+0x14/0x30
[264939.604663]  __kasan_kmalloc+0x8f/0xa0
[264939.604672]  idpf_idc_init_aux_core_dev+0x4bd/0xb60 [idpf]
[264939.604700]  idpf_idc_init+0x55/0xd0 [idpf]
[264939.604726]  process_one_work+0x658/0xfe0
[264939.604742]  worker_thread+0x6e1/0xf10
[264939.604750]  kthread+0x382/0x740
[264939.604762]  ret_from_fork+0x23a/0x310
[264939.604772]  ret_from_fork_asm+0x1a/0x30

[264939.604785] Freed by task 17842:
[264939.604790]  kasan_save_stack+0x20/0x40
[264939.604799]  kasan_save_track+0x14/0x30
[264939.604808]  kasan_save_free_info+0x3b/0x60
[264939.604820]  __kasan_slab_free+0x37/0x50
[264939.604830]  kfree+0xf1/0x420
[264939.604840]  device_release+0x9c/0x210
[264939.604850]  kobject_put+0x17c/0x4b0
[264939.604860]  idpf_idc_deinit_core_aux_device+0x4f/0x100 [idpf]
[264939.604886]  idpf_vc_core_deinit+0xba/0x3a0 [idpf]
[264939.604915]  idpf_remove+0xb0/0x7c0 [idpf]
[264939.604944]  pci_device_remove+0xab/0x1e0
[264939.604955]  device_release_driver_internal+0x371/0x530
[264939.604969]  driver_detach+0xbf/0x180
[264939.604981]  bus_remove_driver+0x11b/0x2a0
[264939.604991]  pci_unregister_driver+0x2a/0x250
[264939.605005]  __do_sys_delete_module.constprop.0+0x2eb/0x540
[264939.605014]  do_syscall_64+0x64/0x2c0
[264939.605024]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: f4312e6bfa2a ("idpf: implement core RDMA auxiliary dev create, init, and destroy")
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_idc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index 4d2905103215..7e20a07e98e5 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -247,10 +247,10 @@ static void idpf_unplug_aux_dev(struct auxiliary_device *adev)
 	if (!adev)
 		return;
 
+	ida_free(&idpf_idc_ida, adev->id);
+
 	auxiliary_device_delete(adev);
 	auxiliary_device_uninit(adev);
-
-	ida_free(&idpf_idc_ida, adev->id);
 }
 
 /**
-- 
2.47.1


