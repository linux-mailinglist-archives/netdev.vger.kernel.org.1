Return-Path: <netdev+bounces-235545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA8CC32577
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 18:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0A91888A6C
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 17:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EBE337BB5;
	Tue,  4 Nov 2025 17:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LIivOAOi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADDF334C34
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 17:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277026; cv=none; b=c+GmtgDvtW5DaKGniEAbUuzs63q7/DWNPuypSoCvhKcsenY+pXzWTP4uh1LTPIdASLoEMcg1BYklFf27eJ7zQysdKmti7i1/mQgdiIY3Z/HEUqoTz58tZkiozveMfX0cEfAaxqmWC7lvfuyYFaIyBVi+GhvMfHi5TJIzsAOKR54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277026; c=relaxed/simple;
	bh=zTdE6ot2YoPISyyXbJPJDqsfSf8CveIpXWLD5UOMoy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UtjN3KbTECu45U8KyEVPA3uoiQlMo0LeY9fzecCJVl4kSdaCsCToGIpHffh066O8449Ml514DLgUFwwnW7+ZbsH2MyeUnEJ4/DvK52agYj/MRtcY8mASCL/xxRx8nO26VmOdhkCOmZnlm5IsN2/glrwIixAmMJ4d80qLpacLWDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LIivOAOi; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762277024; x=1793813024;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zTdE6ot2YoPISyyXbJPJDqsfSf8CveIpXWLD5UOMoy0=;
  b=LIivOAOiLQgOi6uCPk150Mfqk+zEljugFn4258KRoDcMao/5G/A/qPfm
   qhrPuMgTyu6g+gZrj/qRDv4qLqdX5HO51GO70ezpqubtHbtJlsJJLnoRT
   DZIy46U6Orzy8DbBLRbcJdndYVsi+OfnCUqWNp3ne+JYSPisMFLAL6IDF
   wrounB9lIUXN+UAHEG0P3c/+YomeXO/rkaK2R2jcVdcZbFMul69Uwagj5
   AMcGbrm0lwoea2iowocO91jsSKM9D5NQ1/F472Cha3fgNj7mfLfzyMtCO
   DGP3M2l4cj9Wx0fwrAWZvBol5Hcye1NqIA4zuQwirhcdPMmTXe0DrR05k
   w==;
X-CSE-ConnectionGUID: lK+nR7KDRVi56r3i1qfgBA==
X-CSE-MsgGUID: FHQ7uaN7SkWfqctLSCgyIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="63584333"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="63584333"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 09:23:43 -0800
X-CSE-ConnectionGUID: ywGV4p34S9Sm3/8f8ekPqA==
X-CSE-MsgGUID: parSmhIRTsGeEdegj9dstw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="186507930"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 04 Nov 2025 09:23:43 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	aleksander.lobakin@intel.com,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net] libie: depend on DEBUG_FS when building LIBIE_FWLOG
Date: Tue,  4 Nov 2025 09:23:31 -0800
Message-ID: <20251104172333.752445-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

LIBIE_FWLOG is unusable without DEBUG_FS. Mark it in Kconfig.

Fix build error on ixgbe when DEBUG_FS is not set. To not add another
layer of #if IS_ENABLED(LIBIE_FWLOG) in ixgbe fwlog code define debugfs
dentry even when DEBUG_FS isn't enabled. In this case the dummy
functions of LIBIE_FWLOG will be used, so not initialized dentry isn't a
problem.

Fixes: 641585bc978e ("ixgbe: fwlog support for e610")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/lkml/f594c621-f9e1-49f2-af31-23fbcb176058@roeck-us.net/
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
IWL: https://lore.kernel.org/intel-wired-lan/20251016072940.1661485-1-michal.swiatkowski@linux.intel.com/

 drivers/net/ethernet/intel/Kconfig       |  4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe.h |  2 --
 include/linux/net/intel/libie/fwlog.h    | 12 ++++++++++++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index a563a94e2780..122ee23497e6 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -146,7 +146,7 @@ config IXGBE
 	tristate "Intel(R) 10GbE PCI Express adapters support"
 	depends on PCI
 	depends on PTP_1588_CLOCK_OPTIONAL
-	select LIBIE_FWLOG
+	select LIBIE_FWLOG if DEBUG_FS
 	select MDIO
 	select NET_DEVLINK
 	select PLDMFW
@@ -298,7 +298,7 @@ config ICE
 	select DIMLIB
 	select LIBIE
 	select LIBIE_ADMINQ
-	select LIBIE_FWLOG
+	select LIBIE_FWLOG if DEBUG_FS
 	select NET_DEVLINK
 	select PACKING
 	select PLDMFW
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 14d275270123..dce4936708eb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -821,9 +821,7 @@ struct ixgbe_adapter {
 #ifdef CONFIG_IXGBE_HWMON
 	struct hwmon_buff *ixgbe_hwmon_buff;
 #endif /* CONFIG_IXGBE_HWMON */
-#ifdef CONFIG_DEBUG_FS
 	struct dentry *ixgbe_dbg_adapter;
-#endif /*CONFIG_DEBUG_FS*/
 
 	u8 default_up;
 	/* Bitmask indicating in use pools */
diff --git a/include/linux/net/intel/libie/fwlog.h b/include/linux/net/intel/libie/fwlog.h
index 36b13fabca9e..7273c78c826b 100644
--- a/include/linux/net/intel/libie/fwlog.h
+++ b/include/linux/net/intel/libie/fwlog.h
@@ -78,8 +78,20 @@ struct libie_fwlog {
 	);
 };
 
+#if IS_ENABLED(CONFIG_LIBIE_FWLOG)
 int libie_fwlog_init(struct libie_fwlog *fwlog, struct libie_fwlog_api *api);
 void libie_fwlog_deinit(struct libie_fwlog *fwlog);
 void libie_fwlog_reregister(struct libie_fwlog *fwlog);
 void libie_get_fwlog_data(struct libie_fwlog *fwlog, u8 *buf, u16 len);
+#else
+static inline int libie_fwlog_init(struct libie_fwlog *fwlog,
+				   struct libie_fwlog_api *api)
+{
+	return -EOPNOTSUPP;
+}
+static inline void libie_fwlog_deinit(struct libie_fwlog *fwlog) { }
+static inline void libie_fwlog_reregister(struct libie_fwlog *fwlog) { }
+static inline void libie_get_fwlog_data(struct libie_fwlog *fwlog, u8 *buf,
+					u16 len) { }
+#endif /* CONFIG_LIBIE_FWLOG */
 #endif /* _LIBIE_FWLOG_H_ */
-- 
2.47.1


