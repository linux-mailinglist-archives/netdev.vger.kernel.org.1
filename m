Return-Path: <netdev+bounces-174691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DD1A5FECB
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 19:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F5E1894880
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 18:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0422198E76;
	Thu, 13 Mar 2025 18:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WmZ/tLBn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E411EDA22
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 18:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889229; cv=none; b=C1FJ3RwbNVwbWrqJln9YpzPT8sgXf4HbH0ZgCZMNYSANdC6+lGbA3CLjE5dro16nR8b9GAAfln70FFVsfO108W15uZ+NcY62IFurAg3NUbcnZcniEQsPn6NCsLI3VIkyff/xA+N2KkDMVvP5R2O9gbSL7CRM+Y+fnNZ/NS0hoTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889229; c=relaxed/simple;
	bh=LOoataStIPlh9epL9tDLuA4wb1BifQIiNLpxpx9YD7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kf2B3v2WqvQo00l36pj1cL6mm6nf7WoQAStMGjlZSQm58gCWwuUD4zxDc0Ft5VDU0esSQDUJP9YGB8iGVbOCyxj6CIypURCRyXDxKHnkeEbj3Gz0nFzU/vZ2L84TDBhAn73u2NxgUu92PNRo3o+7TT6morv5LPkxOVYXy3Dc4os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WmZ/tLBn; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741889227; x=1773425227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LOoataStIPlh9epL9tDLuA4wb1BifQIiNLpxpx9YD7w=;
  b=WmZ/tLBnZoG1clfjvenFvhloAMU+CHL7CTSTVmfsFACiYPzrPXm9uGur
   wB8e3U6WGuQzextU7kXwjaIEws1MhXhhlWtlYFEa4fksigoUAzXk3JB9Y
   JAmAEjPdzCQu0zA7Gz11bUTA82/6esyvEr8wEy+s8O+rfEQAFSrrqIQt/
   UcnPkpdcgnsB+yZdJfh9btxCE+1YPzi7hU8nADdq4CY7zwayAgIiKaTwG
   GSLE+/xlUBWFYBVPbBXFlmg3U6WCF1udA8AQoB0p5xYSIP1t/Y8u2FqU1
   E/8I3SsZCf16yqFJHK+wcmrjvYfl5TcRbRHbOHcPWdfvITjVnK5JMukoF
   Q==;
X-CSE-ConnectionGUID: vpt7E5ELSBSADO0VTzohzg==
X-CSE-MsgGUID: 5pcLdrtbQBGjq7I2S79sAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="45795501"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="45795501"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 11:07:05 -0700
X-CSE-ConnectionGUID: h0OhgY3mS0CvlHOC9zHTlg==
X-CSE-MsgGUID: RPeCMfH6QZ2ft877u9cl8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="120989384"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.22.54])
  by orviesa010.jf.intel.com with ESMTP; 13 Mar 2025 11:07:03 -0700
From: Milena Olech <milena.olech@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Milena Olech <milena.olech@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH v9 iwl-next 01/10] idpf: add initial PTP support
Date: Thu, 13 Mar 2025 19:04:11 +0100
Message-Id: <20250313180417.2348593-2-milena.olech@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250313180417.2348593-1-milena.olech@intel.com>
References: <20250313180417.2348593-1-milena.olech@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PTP feature is supported if the VIRTCHNL2_CAP_PTP is negotiated during the
capabilities recognition. Initial PTP support includes PTP initialization
and registration of the clock.

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Tested-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
---
 drivers/net/ethernet/intel/idpf/Kconfig       |  1 +
 drivers/net/ethernet/intel/idpf/Makefile      |  1 +
 drivers/net/ethernet/intel/idpf/idpf.h        |  3 +
 drivers/net/ethernet/intel/idpf/idpf_main.c   |  4 +
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 89 +++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_ptp.h    | 32 +++++++
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  9 +-
 7 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ptp.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ptp.h

diff --git a/drivers/net/ethernet/intel/idpf/Kconfig b/drivers/net/ethernet/intel/idpf/Kconfig
index 1addd663acad..2c359a8551c7 100644
--- a/drivers/net/ethernet/intel/idpf/Kconfig
+++ b/drivers/net/ethernet/intel/idpf/Kconfig
@@ -4,6 +4,7 @@
 config IDPF
 	tristate "Intel(R) Infrastructure Data Path Function Support"
 	depends on PCI_MSI
+	depends on PTP_1588_CLOCK_OPTIONAL
 	select DIMLIB
 	select LIBETH
 	help
diff --git a/drivers/net/ethernet/intel/idpf/Makefile b/drivers/net/ethernet/intel/idpf/Makefile
index 2ce01a0b5898..1f38a9d7125c 100644
--- a/drivers/net/ethernet/intel/idpf/Makefile
+++ b/drivers/net/ethernet/intel/idpf/Makefile
@@ -17,3 +17,4 @@ idpf-y := \
 	idpf_vf_dev.o
 
 idpf-$(CONFIG_IDPF_SINGLEQ)	+= idpf_singleq_txrx.o
+idpf-$(CONFIG_PTP_1588_CLOCK)	+= idpf_ptp.o
diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 66544faab710..2e8b14dd9d96 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -530,6 +530,7 @@ struct idpf_vc_xn_manager;
  * @vector_lock: Lock to protect vector distribution
  * @queue_lock: Lock to protect queue distribution
  * @vc_buf_lock: Lock to protect virtchnl buffer
+ * @ptp: Storage for PTP-related data
  */
 struct idpf_adapter {
 	struct pci_dev *pdev;
@@ -587,6 +588,8 @@ struct idpf_adapter {
 	struct mutex vector_lock;
 	struct mutex queue_lock;
 	struct mutex vc_buf_lock;
+
+	struct idpf_ptp *ptp;
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index b6c515d14cbf..60bae3081035 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -163,6 +163,10 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_free;
 	}
 
+	err = pci_enable_ptm(pdev, NULL);
+	if (err)
+		pci_dbg(pdev, "PCIe PTM is not supported by PCIe bus/controller\n");
+
 	/* set up for high or low dma */
 	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
 	if (err) {
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
new file mode 100644
index 000000000000..1ac6367f5989
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2024 Intel Corporation */
+
+#include "idpf.h"
+#include "idpf_ptp.h"
+
+/**
+ * idpf_ptp_create_clock - Create PTP clock device for userspace
+ * @adapter: Driver specific private structure
+ *
+ * This function creates a new PTP clock device.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int idpf_ptp_create_clock(const struct idpf_adapter *adapter)
+{
+	struct ptp_clock *clock;
+
+	/* Attempt to register the clock before enabling the hardware. */
+	clock = ptp_clock_register(&adapter->ptp->info,
+				   &adapter->pdev->dev);
+	if (IS_ERR(clock)) {
+		pci_err(adapter->pdev, "PTP clock creation failed: %pe\n", clock);
+		return PTR_ERR(clock);
+	}
+
+	adapter->ptp->clock = clock;
+
+	return 0;
+}
+
+/**
+ * idpf_ptp_init - Initialize PTP hardware clock support
+ * @adapter: Driver specific private structure
+ *
+ * Set up the device for interacting with the PTP hardware clock for all
+ * functions. Function will allocate and register a ptp_clock with the
+ * PTP_1588_CLOCK infrastructure.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int idpf_ptp_init(struct idpf_adapter *adapter)
+{
+	int err;
+
+	if (!idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS, VIRTCHNL2_CAP_PTP)) {
+		pci_dbg(adapter->pdev, "PTP capability is not detected\n");
+		return -EOPNOTSUPP;
+	}
+
+	adapter->ptp = kzalloc(sizeof(*adapter->ptp), GFP_KERNEL);
+	if (!adapter->ptp)
+		return -ENOMEM;
+
+	/* add a back pointer to adapter */
+	adapter->ptp->adapter = adapter;
+
+	err = idpf_ptp_create_clock(adapter);
+	if (err)
+		goto free_ptp;
+
+	pci_dbg(adapter->pdev, "PTP init successful\n");
+
+	return 0;
+
+free_ptp:
+	kfree(adapter->ptp);
+	adapter->ptp = NULL;
+
+	return err;
+}
+
+/**
+ * idpf_ptp_release - Clear PTP hardware clock support
+ * @adapter: Driver specific private structure
+ */
+void idpf_ptp_release(struct idpf_adapter *adapter)
+{
+	struct idpf_ptp *ptp = adapter->ptp;
+
+	if (!ptp)
+		return;
+
+	if (ptp->clock)
+		ptp_clock_unregister(ptp->clock);
+
+	kfree(ptp);
+	adapter->ptp = NULL;
+}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.h b/drivers/net/ethernet/intel/idpf/idpf_ptp.h
new file mode 100644
index 000000000000..d009417bf947
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2024 Intel Corporation */
+
+#ifndef _IDPF_PTP_H
+#define _IDPF_PTP_H
+
+#include <linux/ptp_clock_kernel.h>
+
+/**
+ * struct idpf_ptp - PTP parameters
+ * @info: structure defining PTP hardware capabilities
+ * @clock: pointer to registered PTP clock device
+ * @adapter: back pointer to the adapter
+ */
+struct idpf_ptp {
+	struct ptp_clock_info info;
+	struct ptp_clock *clock;
+	struct idpf_adapter *adapter;
+};
+
+#if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
+int idpf_ptp_init(struct idpf_adapter *adapter);
+void idpf_ptp_release(struct idpf_adapter *adapter);
+#else /* CONFIG_PTP_1588_CLOCK */
+static inline int idpf_ptp_init(struct idpf_adapter *adapter)
+{
+	return 0;
+}
+
+static inline void idpf_ptp_release(struct idpf_adapter *adapter) { }
+#endif /* CONFIG_PTP_1588_CLOCK */
+#endif /* _IDPF_PTP_H */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 3d2413b8684f..7004289b974c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -5,6 +5,7 @@
 
 #include "idpf.h"
 #include "idpf_virtchnl.h"
+#include "idpf_ptp.h"
 
 #define IDPF_VC_XN_MIN_TIMEOUT_MSEC	2000
 #define IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC	(60 * 1000)
@@ -900,7 +901,8 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
 			    VIRTCHNL2_CAP_MACFILTER		|
 			    VIRTCHNL2_CAP_SPLITQ_QSCHED		|
 			    VIRTCHNL2_CAP_PROMISC		|
-			    VIRTCHNL2_CAP_LOOPBACK);
+			    VIRTCHNL2_CAP_LOOPBACK		|
+			    VIRTCHNL2_CAP_PTP);
 
 	xn_params.vc_op = VIRTCHNL2_OP_GET_CAPS;
 	xn_params.send_buf.iov_base = &caps;
@@ -3029,6 +3031,10 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 		goto err_intr_req;
 	}
 
+	err = idpf_ptp_init(adapter);
+	if (err)
+		pci_err(adapter->pdev, "PTP init failed, err=%pe\n", ERR_PTR(err));
+
 	idpf_init_avail_queues(adapter);
 
 	/* Skew the delay for init tasks for each function based on fn number
@@ -3091,6 +3097,7 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 	if (!remove_in_prog)
 		idpf_vc_xn_shutdown(adapter->vcxn_mngr);
 
+	idpf_ptp_release(adapter);
 	idpf_deinit_task(adapter);
 	idpf_intr_rel(adapter);
 
-- 
2.31.1


