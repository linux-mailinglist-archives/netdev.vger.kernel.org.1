Return-Path: <netdev+bounces-214198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE60B28746
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 22:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1DB21C26C52
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D312BEFE2;
	Fri, 15 Aug 2025 20:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aukOrrwp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EBC1487D1
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 20:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755290533; cv=none; b=Qc8xo+85gSMn+b1hvqZX/5TEBliraHMz8pfgBli0b6DGH3qj9KU4QhtLesNokU6rS2rsRvFl4skABXMkEMvJxfXeybGDqDqiQQtMTzLbj+8Y0m7iDVsrdcRwNnZ88jxaPz868IJYDlI54X6oyHQMVJ5vXwYnkt0pPGr6CMxtIxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755290533; c=relaxed/simple;
	bh=WiviLeEN8nUPxwEQFQYbq525nJhkfcVvcl91PLOIGF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5aiIwxUrnC0TeqgTT3+SmUC7GWFGv4LKy0A6N31J2KQ/mk/DxLxk58BqbIKDk0k55XklPj6D/fsd/hSBo8nHYJxfMu/8eDjodjTU53pvzKXJeskrBkx9r4I8Y4dMig9y3KUWMpJ4aJwIpO2NsXKCdLoERAlRBB8FL86sn58skI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aukOrrwp; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755290532; x=1786826532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WiviLeEN8nUPxwEQFQYbq525nJhkfcVvcl91PLOIGF0=;
  b=aukOrrwpQFIFfEo/1m5xpUsRfi/zr5lFbsC+VlPf83/nWuGS1Kx9TwNZ
   FY89A1q5KvySg3lP8PMfNIj93jE9eHFmOS4fAa08E49JqnYFAzws3po9B
   dX0+AS8v6EectDNL/ytAZJCumB9aUO4ixrdmwFno4in37upSkLexjdLpx
   GpVhYTRK7hgZ18ib+w1v/by6q1Kkaa8PaBmI5muLCBgBNpzZjy4OazoPh
   1mwwV53+Dm7EYQuZX96F0Qk3Naz72Tedo3W5LWGLoMlSRCZmC60nORBE2
   kfbfvnV4fKKMG+2QVEIExaYoUNp4TZIUj2HhpscYSdEltldc41f90SsGu
   w==;
X-CSE-ConnectionGUID: ZjiYrXNVSouX2EzpicGKQw==
X-CSE-MsgGUID: 8LaEelwLR7ussmAdAuxbuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="68320295"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68320295"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 13:42:10 -0700
X-CSE-ConnectionGUID: o5fURlVMR/mQkN+uCf8PlQ==
X-CSE-MsgGUID: s4fh4EsZRJK+EwhZAsfMmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="198084313"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 15 Aug 2025 13:42:10 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Emil Tantilov <emil.s.tantilov@intel.com>,
	anthony.l.nguyen@intel.com,
	david.m.ertman@intel.com,
	tatyana.e.nikolova@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net 1/6] ice: fix NULL pointer dereference in ice_unplug_aux_dev() on reset
Date: Fri, 15 Aug 2025 13:41:57 -0700
Message-ID: <20250815204205.1407768-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250815204205.1407768-1-anthony.l.nguyen@intel.com>
References: <20250815204205.1407768-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Tantilov <emil.s.tantilov@intel.com>

Issuing a reset when the driver is loaded without RDMA support, will
results in a crash as it attempts to remove RDMA's non-existent auxbus
device:
echo 1 > /sys/class/net/<if>/device/reset

BUG: kernel NULL pointer dereference, address: 0000000000000008
...
RIP: 0010:ice_unplug_aux_dev+0x29/0x70 [ice]
...
Call Trace:
<TASK>
ice_prepare_for_reset+0x77/0x260 [ice]
pci_dev_save_and_disable+0x2c/0x70
pci_reset_function+0x88/0x130
reset_store+0x5a/0xa0
kernfs_fop_write_iter+0x15e/0x210
vfs_write+0x273/0x520
ksys_write+0x6b/0xe0
do_syscall_64+0x79/0x3b0
entry_SYSCALL_64_after_hwframe+0x76/0x7e

ice_unplug_aux_dev() checks pf->cdev_info->adev for NULL pointer, but
pf->cdev_info will also be NULL, leading to the deref in the trace above.

Introduce a flag to be set when the creation of the auxbus device is
successful, to avoid multiple NULL pointer checks in ice_unplug_aux_dev().

Fixes: c24a65b6a27c7 ("iidc/ice/irdma: Update IDC to support multiple consumers")
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h     |  1 +
 drivers/net/ethernet/intel/ice/ice_idc.c | 10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 2098f00b3cd3..8a8a01a4bb40 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -510,6 +510,7 @@ enum ice_pf_flags {
 	ICE_FLAG_LINK_LENIENT_MODE_ENA,
 	ICE_FLAG_PLUG_AUX_DEV,
 	ICE_FLAG_UNPLUG_AUX_DEV,
+	ICE_FLAG_AUX_DEV_CREATED,
 	ICE_FLAG_MTU_CHANGED,
 	ICE_FLAG_GNSS,			/* GNSS successfully initialized */
 	ICE_FLAG_DPLL,			/* SyncE/PTP dplls initialized */
diff --git a/drivers/net/ethernet/intel/ice/ice_idc.c b/drivers/net/ethernet/intel/ice/ice_idc.c
index 6ab53e430f91..420d45c2558b 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc.c
+++ b/drivers/net/ethernet/intel/ice/ice_idc.c
@@ -336,6 +336,7 @@ int ice_plug_aux_dev(struct ice_pf *pf)
 	mutex_lock(&pf->adev_mutex);
 	cdev->adev = adev;
 	mutex_unlock(&pf->adev_mutex);
+	set_bit(ICE_FLAG_AUX_DEV_CREATED, pf->flags);
 
 	return 0;
 }
@@ -347,15 +348,16 @@ void ice_unplug_aux_dev(struct ice_pf *pf)
 {
 	struct auxiliary_device *adev;
 
+	if (!test_and_clear_bit(ICE_FLAG_AUX_DEV_CREATED, pf->flags))
+		return;
+
 	mutex_lock(&pf->adev_mutex);
 	adev = pf->cdev_info->adev;
 	pf->cdev_info->adev = NULL;
 	mutex_unlock(&pf->adev_mutex);
 
-	if (adev) {
-		auxiliary_device_delete(adev);
-		auxiliary_device_uninit(adev);
-	}
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
 }
 
 /**
-- 
2.47.1


