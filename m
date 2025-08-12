Return-Path: <netdev+bounces-212671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD8CB219B2
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 02:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62E09190703E
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 00:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5DC28B415;
	Tue, 12 Aug 2025 00:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/YjCsr9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A2A27FB31
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 00:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754957510; cv=none; b=k9mfTH2g6CxhC8QqwPXHWYamxaKMxec76ppZ1A2sGEUy/FP8OZaYMGj4shuqkDDG8tBRSQ0U6RoT/e3qhxImwLo4339miWNQ2zeKLsURGPlDHlLmWBig2FrZ+QAq3uYQvw3ydodIMqgpW46rPAbs3XiAULkimSM3Wjp/aGYd/Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754957510; c=relaxed/simple;
	bh=WLXAufMx4+moAqVJ6lJ70jpjz9qJ9rjFJFkOmpjLpQA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ps4r1fC/Ir+FPSJRK7qzHyuf9S4gbR3LYMtjOYh34CNCfo4GmwbvOdUsDknm8JvfpjMFFWrMislxxtac4K6HlxJ26HhxjBjxAWcoQsx4HpBnZ6ZMTXe9buW4Qpkz/KpQmL7h2zcQYnLnRhknqzJLoFrDFoUF0ArqU6V3Rka1j7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y/YjCsr9; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754957508; x=1786493508;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WLXAufMx4+moAqVJ6lJ70jpjz9qJ9rjFJFkOmpjLpQA=;
  b=Y/YjCsr9mInDVzPUVgt3ta1vUwhrkV+HauVkQVgKzzTSy7SCHk3y4nrE
   yU+sUghZ/eh1smamPbOBpBke90tOxOyhyU3dtOQMv/IJ7zTuTOEmnq59o
   u3WJZKaq8vw2/8WpF5Lm67PSRjF/FizLD1N0Lw+gDrACaPjeBZSikhXlS
   IV/ygLVEg4EYidqvESJWoqmw71sDoe0IVPV/9Ruuv/Irr4WOfQ8+3FTKZ
   X1STLq43HjAQRVTY3sD4oX2EG3dJjf/g+MJWIUQz86hBptKskxf4+JY3C
   Dj1pSMn19rHjjHmYalE6+UMUZTGIw0unuKms8OS1qBgBTXp+VocouPMqc
   Q==;
X-CSE-ConnectionGUID: MXHmzk1ySECGYIs7nVu2nA==
X-CSE-MsgGUID: zCPAiJ1tRHOXTBOU2B+r4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68593828"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="68593828"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 17:11:48 -0700
X-CSE-ConnectionGUID: mtx225MgRBK2vPqxHaRQWw==
X-CSE-MsgGUID: Yk1wtHI2SG27/l1lx5wQ0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="166044395"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.13])
  by orviesa007.jf.intel.com with ESMTP; 11 Aug 2025 17:11:48 -0700
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	larysa.zaremba@intel.com,
	Joshua Hay <joshua.a.hay@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [Intel-wired-lan][PATCH iwl-net] idpf: fix UAF in RDMA core aux dev deinitialization
Date: Mon, 11 Aug 2025 17:19:21 -0700
Message-Id: <20250812001921.4076454-1-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.39.2


