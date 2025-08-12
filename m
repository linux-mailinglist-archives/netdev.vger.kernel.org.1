Return-Path: <netdev+bounces-212759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F40AB21C39
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 06:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66C481A25F5C
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 04:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5902E2DD7;
	Tue, 12 Aug 2025 04:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W/wU/IRE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDA92D6E48
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 04:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754974029; cv=none; b=gE8mL0l3ID6diEJu9fJG3jC14GDCCT4XuSRqiLHA5/XtPcfE+w66LtbTJQWcopNRLRhz+wdBEh1axefCBru5VX7kXef8gvlxhA4hx5VRZ82chl8bRibSLxiJj4/6INF+3Habk3AMAAlU1HsShOryPyg5svEWjXyqp1B4ePnlebo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754974029; c=relaxed/simple;
	bh=a4DVyQ2ZKjgg4V3riO5kyjID7KlRSJahiBK7W6tnirA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7IEs/XyaoBYwcpm+M6Y6Seb4xIBT9pItuj6pRaniUWFq/Pk/5b365yUrIEIFddQN03Q0BZxOAEid7DXz/cm/10Wl1nKKK8LHw4OJSEEmwJa1s4gwrbsp5S76FsANG6fst6TTRvd7fu7dRWLEc8GoVKJguvRRKVfR6KUUV3YUTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W/wU/IRE; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754974028; x=1786510028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a4DVyQ2ZKjgg4V3riO5kyjID7KlRSJahiBK7W6tnirA=;
  b=W/wU/IREY32R5i0YXxtQVZmwlwxog+jCAWYNFwUFBHMTGzhavQaqZ5Qj
   fYCqnaAcTFKInMSBWcweoP/Simw7d8mPMiGIsce6D7ldMFlaz7oAlZ1DE
   0DiR44lJT6J3gFkxWyn+tbPjVsTaDQL6yD59WbiTxGNvXB2xU5GefJFE5
   vHq26U9ZE/iPUzAwGRJQWBhki0YiIf8FGkLEavLxzRmims6ClZwt4meIn
   gPYuNp3DTk9tCx+ABaiDWO8yHE18kCDJDwB8dMJ5G4ZEb+rGpXzIkvjLy
   ZZjnY+O1KrfwsyCYbXQ1WPO5hunJLStOHtUmt57AOn/6Z//teigYTVBFf
   A==;
X-CSE-ConnectionGUID: HyWUwL6rSaSRVnHc4W7skw==
X-CSE-MsgGUID: phKEp17RSYS7aCRbY7viBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68612753"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="68612753"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 21:47:07 -0700
X-CSE-ConnectionGUID: YyMBrYXkQYGtUH0iWvuYpw==
X-CSE-MsgGUID: 9h5ELiN3T6a/Y06HpV8dLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="165327901"
Received: from unknown (HELO os-delivery.igk.intel.com) ([10.102.21.165])
  by orviesa010.jf.intel.com with ESMTP; 11 Aug 2025 21:47:06 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	horms@kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v2 07/15] ice: move out debugfs init from fwlog
Date: Tue, 12 Aug 2025 06:23:28 +0200
Message-ID: <20250812042337.1356907-8-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250812042337.1356907-1-michal.swiatkowski@linux.intel.com>
References: <20250812042337.1356907-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The root debugfs directory should be available from driver side, not
from library. Move it out from fwlog code.

Make similar to __fwlog_init() __fwlog_deinit() and deinit debugfs
there. In case of ice only fwlog is using debugfs.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |  1 +
 drivers/net/ethernet/intel/ice/ice_common.c  | 14 ++++++++++++--
 drivers/net/ethernet/intel/ice/ice_debugfs.c | 20 +++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_fwlog.c   |  2 --
 4 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index a6803b344540..ee2ae0cbc25e 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -909,6 +909,7 @@ static inline bool ice_is_adq_active(struct ice_pf *pf)
 }
 
 void ice_debugfs_fwlog_init(struct ice_pf *pf);
+int ice_debugfs_pf_init(struct ice_pf *pf);
 void ice_debugfs_pf_deinit(struct ice_pf *pf);
 void ice_debugfs_init(void);
 void ice_debugfs_exit(void);
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 7b4ff20f3346..9119d097eb08 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1000,6 +1000,11 @@ static int __fwlog_init(struct ice_hw *hw)
 		.send_cmd = __fwlog_send_cmd,
 		.priv = hw,
 	};
+	int err;
+
+	err = ice_debugfs_pf_init(pf);
+	if (err)
+		return err;
 
 	return ice_fwlog_init(hw, &hw->fwlog, &api);
 }
@@ -1179,6 +1184,12 @@ int ice_init_hw(struct ice_hw *hw)
 	return status;
 }
 
+static void __fwlog_deinit(struct ice_hw *hw)
+{
+	ice_debugfs_pf_deinit(hw->back);
+	ice_fwlog_deinit(hw, &hw->fwlog);
+}
+
 /**
  * ice_deinit_hw - unroll initialization operations done by ice_init_hw
  * @hw: pointer to the hardware structure
@@ -1197,8 +1208,7 @@ void ice_deinit_hw(struct ice_hw *hw)
 	ice_free_seg(hw);
 	ice_free_hw_tbls(hw);
 	mutex_destroy(&hw->tnl_lock);
-
-	ice_fwlog_deinit(hw, &hw->fwlog);
+	__fwlog_deinit(hw);
 	ice_destroy_all_ctrlq(hw);
 
 	/* Clear VSI contexts if not already cleared */
diff --git a/drivers/net/ethernet/intel/ice/ice_debugfs.c b/drivers/net/ethernet/intel/ice/ice_debugfs.c
index 9235ae099e17..c7d9e92d7f56 100644
--- a/drivers/net/ethernet/intel/ice/ice_debugfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_debugfs.c
@@ -584,7 +584,6 @@ static const struct file_operations ice_debugfs_data_fops = {
  */
 void ice_debugfs_fwlog_init(struct ice_pf *pf)
 {
-	const char *name = pci_name(pf->pdev);
 	struct dentry *fw_modules_dir;
 	struct dentry **fw_modules;
 	int i;
@@ -601,10 +600,6 @@ void ice_debugfs_fwlog_init(struct ice_pf *pf)
 	if (!fw_modules)
 		return;
 
-	pf->ice_debugfs_pf = debugfs_create_dir(name, ice_debugfs_root);
-	if (IS_ERR(pf->ice_debugfs_pf))
-		goto err_create_module_files;
-
 	pf->ice_debugfs_pf_fwlog = debugfs_create_dir("fwlog",
 						      pf->ice_debugfs_pf);
 	if (IS_ERR(pf->ice_debugfs_pf_fwlog))
@@ -645,6 +640,21 @@ void ice_debugfs_fwlog_init(struct ice_pf *pf)
 	kfree(fw_modules);
 }
 
+/**
+ * ice_debugfs_pf_init - create PF's debugfs
+ * @pf: pointer to the PF struct
+ */
+int ice_debugfs_pf_init(struct ice_pf *pf)
+{
+	const char *name = pci_name(pf->pdev);
+
+	pf->ice_debugfs_pf = debugfs_create_dir(name, ice_debugfs_root);
+	if (IS_ERR(pf->ice_debugfs_pf))
+		return PTR_ERR(pf->ice_debugfs_pf);
+
+	return 0;
+}
+
 /**
  * ice_debugfs_pf_deinit - cleanup PF's debugfs
  * @pf: pointer to the PF struct
diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.c b/drivers/net/ethernet/intel/ice/ice_fwlog.c
index 172905187a3e..f7dbcb5e11aa 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.c
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.c
@@ -300,8 +300,6 @@ void ice_fwlog_deinit(struct ice_hw *hw, struct ice_fwlog *fwlog)
 	if (hw->bus.func)
 		return;
 
-	ice_debugfs_pf_deinit(hw->back);
-
 	/* make sure FW logging is disabled to not put the FW in a weird state
 	 * for the next driver load
 	 */
-- 
2.49.0


