Return-Path: <netdev+bounces-180226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15E7A80A65
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845BF8A6C26
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 12:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA5527CCD3;
	Tue,  8 Apr 2025 12:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ABkBuXsb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F67127CB3F;
	Tue,  8 Apr 2025 12:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116538; cv=none; b=H4NwWqfaOzpvhnGj1LDGdPNFoyTegirckESPcDRXAnXDf11oGY3GDec9/oRwbMTLJwuP6lyVFT7NRuLRvBi1AujyGf8uaVbX/CYYeJYcyTsNQ1M9PXhD/QcBGidvdBKV7VBZHKQQqGg9y0HRXtorBPt3u3j83r2jryzByax7u/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116538; c=relaxed/simple;
	bh=L2B4Qhta5zIxoa5iMgi8DsDaH24264A7rRsvmyXH5Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WkRJGZrMdTRLHnErvxyHy99GAZexltNwarJRHhHz8W0Zqp1p5CH4M9cp6odZ7U8abnSuxAfCBLl2JaUYDj1wmcDEUx0c1G0P54QRSPYSHOY1RzhMgm5nT+SlfeNVS/3+RTQdqTEKIGAXF16L5zBATk+zD52bbU1SHDWWm447URU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ABkBuXsb; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744116536; x=1775652536;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L2B4Qhta5zIxoa5iMgi8DsDaH24264A7rRsvmyXH5Qs=;
  b=ABkBuXsbs76n7qpn6JmSijtxpeCnDrb2rFXoe5UVAertspAKIE6nLLV0
   4bOKer4SSaq9XwPrMS6xyDeU80D3wWAyivgOhzotVAa24g0dVvXhFfqwc
   b+MKNGF/nnAHM6mgGZinuB8rrt/oQ7Va7IUdV588vZGBSzBUhjKhpOWsJ
   SD2x39avab8OXUoHIJI8tXO5gnL4TBaCufTLy4wE0LJkN0fLZdtRFSXZQ
   zpcLqxIQoB1MGX+08owvNI2vJARcvFT0b8vQCBpkSEKoJYQlDcM5foDe/
   cY5k+Q6koDFK7yHj1slNg+900QhUCn5qXfb7/G0xzX57rCq8WcNK/C5FB
   w==;
X-CSE-ConnectionGUID: lxT/JRSKRD+XLX7g6Qez4Q==
X-CSE-MsgGUID: iOfl2uQaSmeljVMo/hfbyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56184989"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="56184989"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 05:48:56 -0700
X-CSE-ConnectionGUID: VQN2Tu6oTE+omXk545PxLA==
X-CSE-MsgGUID: zcy/ki5nS1+Om0bpXgvO/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="133130799"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa003.jf.intel.com with ESMTP; 08 Apr 2025 05:48:48 -0700
Received: from mglak.igk.intel.com (mglak.igk.intel.com [10.237.112.146])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 10CB034316;
	Tue,  8 Apr 2025 13:48:45 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Lee Trager <lee@trager.us>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Wenjun Wu <wenjun1.wu@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Karlsson, Magnus" <magnus.karlsson@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Josh Hay <joshua.a.hay@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	pavan.kumar.linga@intel.com,
	"Singhai, Anjali" <anjali.singhai@intel.com>
Subject: [PATCH iwl-next 12/14] ixd: add reset checks and initialize the mailbox
Date: Tue,  8 Apr 2025 14:47:58 +0200
Message-ID: <20250408124816.11584-13-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250408124816.11584-1-larysa.zaremba@intel.com>
References: <20250408124816.11584-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the end of the probe, trigger hard reset, initialize and schedule the
after-reset task. If the reset is complete in a pre-determined time,
initialize the default mailbox, through which other resources will be
negotiated.

Co-developed-by: Amritha Nambiar <amritha.nambiar@intel.com>
Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ixd/Kconfig        |   1 +
 drivers/net/ethernet/intel/ixd/Makefile       |   2 +
 drivers/net/ethernet/intel/ixd/ixd.h          |  28 +++-
 drivers/net/ethernet/intel/ixd/ixd_dev.c      |  86 +++++++++++
 drivers/net/ethernet/intel/ixd/ixd_lan_regs.h |  40 +++++
 drivers/net/ethernet/intel/ixd/ixd_lib.c      | 143 ++++++++++++++++++
 drivers/net/ethernet/intel/ixd/ixd_main.c     |  26 +++-
 7 files changed, 318 insertions(+), 8 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_dev.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_lib.c

diff --git a/drivers/net/ethernet/intel/ixd/Kconfig b/drivers/net/ethernet/intel/ixd/Kconfig
index 3bf6e2407af6..bcaf06a874aa 100644
--- a/drivers/net/ethernet/intel/ixd/Kconfig
+++ b/drivers/net/ethernet/intel/ixd/Kconfig
@@ -5,6 +5,7 @@ config IXD
 	tristate "Intel(R) Control Plane Function Support"
 	depends on PCI_MSI
 	select LIBETH
+	select LIBETH_CP
 	select LIBETH_PCI
 	help
 	  This driver supports Intel(R) Control Plane PCI Function
diff --git a/drivers/net/ethernet/intel/ixd/Makefile b/drivers/net/ethernet/intel/ixd/Makefile
index 3849bc240600..164b2c86952f 100644
--- a/drivers/net/ethernet/intel/ixd/Makefile
+++ b/drivers/net/ethernet/intel/ixd/Makefile
@@ -6,3 +6,5 @@
 obj-$(CONFIG_IXD) += ixd.o
 
 ixd-y := ixd_main.o
+ixd-y += ixd_dev.o
+ixd-y += ixd_lib.o
diff --git a/drivers/net/ethernet/intel/ixd/ixd.h b/drivers/net/ethernet/intel/ixd/ixd.h
index b558803914f9..7efa8db8c5ba 100644
--- a/drivers/net/ethernet/intel/ixd/ixd.h
+++ b/drivers/net/ethernet/intel/ixd/ixd.h
@@ -4,14 +4,25 @@
 #ifndef _IXD_H_
 #define _IXD_H_
 
-#include <net/libeth/pci.h>
+#include <net/libeth/controlq.h>
 
 /**
  * struct ixd_adapter - Data structure representing a CPF
- * @hw: Device access data
+ * @cp_ctx: Control plane communication context
+ * @init_task: Delayed initialization after reset
+ * @xnm: virtchnl transaction manager
+ * @asq: Send control queue info
+ * @arq: Receive control queue info
  */
 struct ixd_adapter {
-	struct libeth_mmio_info hw;
+	struct libeth_ctlq_ctx cp_ctx;
+	struct {
+		struct delayed_work init_work;
+		u8 reset_retries;
+	} init_task;
+	struct libeth_ctlq_xn_manager *xnm;
+	struct libeth_ctlq_info *asq;
+	struct libeth_ctlq_info *arq;
 };
 
 /**
@@ -20,7 +31,16 @@ struct ixd_adapter {
  */
 static inline struct device *ixd_to_dev(struct ixd_adapter *adapter)
 {
-	return &adapter->hw.pdev->dev;
+	return &adapter->cp_ctx.mmio_info.pdev->dev;
 }
 
+void ixd_ctlq_reg_init(struct ixd_adapter *adapter,
+		       struct libeth_ctlq_reg *ctlq_reg_tx,
+		       struct libeth_ctlq_reg *ctlq_reg_rx);
+void ixd_trigger_reset(struct ixd_adapter *adapter);
+bool ixd_check_reset_complete(struct ixd_adapter *adapter);
+void ixd_init_task(struct work_struct *work);
+int ixd_init_dflt_mbx(struct ixd_adapter *adapter);
+void ixd_deinit_dflt_mbx(struct ixd_adapter *adapter);
+
 #endif /* _IXD_H_ */
diff --git a/drivers/net/ethernet/intel/ixd/ixd_dev.c b/drivers/net/ethernet/intel/ixd/ixd_dev.c
new file mode 100644
index 000000000000..9d68c2ce3bab
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixd/ixd_dev.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2025 Intel Corporation */
+
+#include "ixd.h"
+#include "ixd_lan_regs.h"
+
+/**
+ * ixd_ctlq_reg_init - Initialize default mailbox registers
+ * @adapter: PCI device driver-specific private data
+ * @ctlq_reg_tx: Transmit queue registers info to be filled
+ * @ctlq_reg_rx: Receive queue registers info to be filled
+ */
+void ixd_ctlq_reg_init(struct ixd_adapter *adapter,
+		       struct libeth_ctlq_reg *ctlq_reg_tx,
+		       struct libeth_ctlq_reg *ctlq_reg_rx)
+{
+	struct libeth_mmio_info *mmio_info = &adapter->cp_ctx.mmio_info;
+	*ctlq_reg_tx = (struct libeth_ctlq_reg) {
+		.head = libeth_pci_get_mmio_addr(mmio_info, PF_FW_ATQH),
+		.tail = libeth_pci_get_mmio_addr(mmio_info, PF_FW_ATQT),
+		.len = libeth_pci_get_mmio_addr(mmio_info, PF_FW_ATQLEN),
+		.addr_high = libeth_pci_get_mmio_addr(mmio_info, PF_FW_ATQBAH),
+		.addr_low = libeth_pci_get_mmio_addr(mmio_info, PF_FW_ATQBAL),
+		.len_mask = PF_FW_ATQLEN_ATQLEN_M,
+		.len_ena_mask = PF_FW_ATQLEN_ATQENABLE_M,
+		.head_mask = PF_FW_ATQH_ATQH_M,
+	};
+
+	*ctlq_reg_rx = (struct libeth_ctlq_reg) {
+		.head = libeth_pci_get_mmio_addr(mmio_info, PF_FW_ARQH),
+		.tail = libeth_pci_get_mmio_addr(mmio_info, PF_FW_ARQT),
+		.len = libeth_pci_get_mmio_addr(mmio_info, PF_FW_ARQLEN),
+		.addr_high = libeth_pci_get_mmio_addr(mmio_info, PF_FW_ARQBAH),
+		.addr_low = libeth_pci_get_mmio_addr(mmio_info, PF_FW_ARQBAL),
+		.len_mask = PF_FW_ARQLEN_ARQLEN_M,
+		.len_ena_mask = PF_FW_ARQLEN_ARQENABLE_M,
+		.head_mask = PF_FW_ARQH_ARQH_M,
+	};
+}
+
+static const struct ixd_reset_reg ixd_reset_reg = {
+	.rstat  = PFGEN_RSTAT,
+	.rstat_m = PFGEN_RSTAT_PFR_STATE_M,
+	.rstat_ok_v = 0b01,
+	.rtrigger = PFGEN_CTRL,
+	.rtrigger_m = PFGEN_CTRL_PFSWR,
+};
+
+/**
+ * ixd_trigger_reset - Trigger PFR reset
+ * @adapter: the device with mapped reset register
+ */
+void ixd_trigger_reset(struct ixd_adapter *adapter)
+{
+	void __iomem *addr;
+	u32 reg_val;
+
+	addr = libeth_pci_get_mmio_addr(&adapter->cp_ctx.mmio_info,
+					ixd_reset_reg.rtrigger);
+	reg_val = readl(addr);
+	writel(reg_val | ixd_reset_reg.rtrigger_m, addr);
+}
+
+/**
+ * ixd_check_reset_complete - Check if the PFR reset is completed
+ * @adapter: CPF being reset
+ */
+bool ixd_check_reset_complete(struct ixd_adapter *adapter)
+{
+	u32 reg_val, reset_status;
+	void __iomem *addr;
+
+	addr = libeth_pci_get_mmio_addr(&adapter->cp_ctx.mmio_info,
+					ixd_reset_reg.rstat);
+	reg_val = readl(addr);
+	reset_status = reg_val & ixd_reset_reg.rstat_m;
+
+	/* 0xFFFFFFFF might be read if the other side hasn't cleared
+	 * the register for us yet.
+	 */
+	if (reg_val != 0xFFFFFFFF &&
+	    reset_status == ixd_reset_reg.rstat_ok_v)
+		return true;
+
+	return false;
+}
diff --git a/drivers/net/ethernet/intel/ixd/ixd_lan_regs.h b/drivers/net/ethernet/intel/ixd/ixd_lan_regs.h
index a991eaa8a2aa..26b1e3cfcf20 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_lan_regs.h
+++ b/drivers/net/ethernet/intel/ixd/ixd_lan_regs.h
@@ -11,9 +11,33 @@
 #define PF_FW_MBX_REG_LEN		4096
 #define PF_FW_MBX			0x08400000
 
+#define PF_FW_ARQBAL			(PF_FW_MBX)
+#define PF_FW_ARQBAH			(PF_FW_MBX + 0x4)
+#define PF_FW_ARQLEN			(PF_FW_MBX + 0x8)
+#define PF_FW_ARQLEN_ARQLEN_M		GENMASK(12, 0)
+#define PF_FW_ARQLEN_ARQENABLE_S	31
+#define PF_FW_ARQLEN_ARQENABLE_M	BIT(PF_FW_ARQLEN_ARQENABLE_S)
+#define PF_FW_ARQH_ARQH_M		GENMASK(12, 0)
+#define PF_FW_ARQH			(PF_FW_MBX + 0xC)
+#define PF_FW_ARQT			(PF_FW_MBX + 0x10)
+
+#define PF_FW_ATQBAL			(PF_FW_MBX + 0x14)
+#define PF_FW_ATQBAH			(PF_FW_MBX + 0x18)
+#define PF_FW_ATQLEN			(PF_FW_MBX + 0x1C)
+#define PF_FW_ATQLEN_ATQLEN_M		GENMASK(9, 0)
+#define PF_FW_ATQLEN_ATQENABLE_S	31
+#define PF_FW_ATQLEN_ATQENABLE_M	BIT(PF_FW_ATQLEN_ATQENABLE_S)
+#define PF_FW_ATQH_ATQH_M		GENMASK(9, 0)
+#define PF_FW_ATQH			(PF_FW_MBX + 0x20)
+#define PF_FW_ATQT			(PF_FW_MBX + 0x24)
+
 /* Reset registers */
 #define PFGEN_RTRIG_REG_LEN		2048
 #define PFGEN_RTRIG			0x08407000	/* Device resets */
+#define PFGEN_RSTAT			0x08407008	/* PFR status */
+#define PFGEN_RSTAT_PFR_STATE_M		GENMASK(1, 0)
+#define PFGEN_CTRL			0x0840700C	/* PFR trigger */
+#define PFGEN_CTRL_PFSWR		BIT(0)
 
 /**
  * struct ixd_bar_region - BAR region description
@@ -25,4 +49,20 @@ struct ixd_bar_region {
 	resource_size_t size;
 };
 
+/**
+ * struct ixd_reset_reg - structure for reset registers
+ * @rstat: offset of status in register
+ * @rstat_m: status mask
+ * @rstat_ok_v: value that indicates PFR completed status
+ * @rtrigger: offset of reset trigger in register
+ * @rtrigger_m: reset trigger mask
+ */
+struct ixd_reset_reg {
+	u32	rstat;
+	u32	rstat_m;
+	u32	rstat_ok_v;
+	u32	rtrigger;
+	u32	rtrigger_m;
+};
+
 #endif /* _IXD_LAN_REGS_H_ */
diff --git a/drivers/net/ethernet/intel/ixd/ixd_lib.c b/drivers/net/ethernet/intel/ixd/ixd_lib.c
new file mode 100644
index 000000000000..42ba7e7da35c
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixd/ixd_lib.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2025 Intel Corporation */
+
+#include "ixd.h"
+
+#define IXD_DFLT_MBX_Q_LEN 64
+
+/**
+ * ixd_init_ctlq_create_info - Initialize control queue info for creation
+ * @info: destination
+ * @type: type of the queue to create
+ * @ctlq_reg: register assigned to the control queue
+ */
+static void ixd_init_ctlq_create_info(struct libeth_ctlq_create_info *info,
+				      enum virtchnl2_queue_type type,
+				      const struct libeth_ctlq_reg *ctlq_reg)
+{
+	*info = (struct libeth_ctlq_create_info) {
+		.type = type,
+		.id = -1,
+		.reg = *ctlq_reg,
+		.len = IXD_DFLT_MBX_Q_LEN,
+	};
+}
+
+/**
+ * ixd_init_libeth_xn_params - Initialize xn transaction manager creation info
+ * @params: destination
+ * @adapter: adapter info struct
+ * @ctlqs: list of the managed queues to create
+ * @num_queues: length of the queue list
+ */
+static void ixd_init_libeth_xn_params(struct libeth_ctlq_xn_init_params *params,
+				      struct ixd_adapter *adapter,
+				      struct libeth_ctlq_create_info *ctlqs,
+				      uint num_queues)
+{
+	*params = (struct libeth_ctlq_xn_init_params){
+		.cctlq_info = ctlqs,
+		.ctx = &adapter->cp_ctx,
+		.num_qs = num_queues,
+	};
+}
+
+/**
+ * ixd_adapter_fill_dflt_ctlqs - Find default control queues and store them
+ * @adapter: adapter info struct
+ */
+static void ixd_adapter_fill_dflt_ctlqs(struct ixd_adapter *adapter)
+{
+	guard(spinlock)(&adapter->cp_ctx.ctlqs_lock);
+	struct libeth_ctlq_info *cq;
+
+	list_for_each_entry(cq, &adapter->cp_ctx.ctlqs, list) {
+		if (cq->qid != -1)
+			continue;
+		if (cq->type == VIRTCHNL2_QUEUE_TYPE_RX)
+			adapter->arq = cq;
+		else if (cq->type == VIRTCHNL2_QUEUE_TYPE_TX)
+			adapter->asq = cq;
+	}
+}
+
+/**
+ * ixd_init_dflt_mbx - Setup default mailbox parameters and make request
+ * @adapter: adapter info struct
+ *
+ * Return: %0 on success, negative errno code on failure
+ */
+int ixd_init_dflt_mbx(struct ixd_adapter *adapter)
+{
+	struct libeth_ctlq_create_info ctlqs_info[2];
+	struct libeth_ctlq_xn_init_params xn_params;
+	struct libeth_ctlq_reg ctlq_reg_tx;
+	struct libeth_ctlq_reg ctlq_reg_rx;
+	int err;
+
+	ixd_ctlq_reg_init(adapter, &ctlq_reg_tx, &ctlq_reg_rx);
+	ixd_init_ctlq_create_info(&ctlqs_info[0], VIRTCHNL2_QUEUE_TYPE_TX,
+				  &ctlq_reg_tx);
+	ixd_init_ctlq_create_info(&ctlqs_info[1], VIRTCHNL2_QUEUE_TYPE_RX,
+				  &ctlq_reg_rx);
+	ixd_init_libeth_xn_params(&xn_params, adapter, ctlqs_info,
+				  ARRAY_SIZE(ctlqs_info));
+	err = libeth_ctlq_xn_init(&xn_params);
+	if (err)
+		return err;
+	adapter->xnm = xn_params.xnm;
+
+	ixd_adapter_fill_dflt_ctlqs(adapter);
+
+	if (!adapter->asq || !adapter->arq) {
+		libeth_ctlq_xn_deinit(adapter->xnm, &adapter->cp_ctx);
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+/**
+ * ixd_deinit_dflt_mbx - Deinitialize default mailbox
+ * @adapter: adapter info struct
+ */
+void ixd_deinit_dflt_mbx(struct ixd_adapter *adapter)
+{
+	if (adapter->arq || adapter->asq)
+		libeth_ctlq_xn_deinit(adapter->xnm, &adapter->cp_ctx);
+
+	adapter->arq = NULL;
+	adapter->asq = NULL;
+	adapter->xnm = NULL;
+}
+
+/**
+ * ixd_init_task - Initialize after reset
+ * @work: init work struct
+ */
+void ixd_init_task(struct work_struct *work)
+{
+	struct ixd_adapter *adapter;
+	int err;
+
+	adapter = container_of(work, struct ixd_adapter,
+			       init_task.init_work.work);
+
+	if (!ixd_check_reset_complete(adapter)) {
+		if (++adapter->init_task.reset_retries < 10)
+			queue_delayed_work(system_unbound_wq,
+					   &adapter->init_task.init_work,
+					   msecs_to_jiffies(500));
+		else
+			dev_err(ixd_to_dev(adapter),
+				"Device reset failed. The driver was unable to contact the device's firmware. Check that the FW is running.\n");
+		return;
+	}
+
+	adapter->init_task.reset_retries = 0;
+	err = ixd_init_dflt_mbx(adapter);
+	if (err)
+		dev_err(ixd_to_dev(adapter),
+			"Failed to initialize the default mailbox: %pe\n",
+			ERR_PTR(err));
+}
diff --git a/drivers/net/ethernet/intel/ixd/ixd_main.c b/drivers/net/ethernet/intel/ixd/ixd_main.c
index 1f59db0b8fe7..bba6fa2dda57 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_main.c
+++ b/drivers/net/ethernet/intel/ixd/ixd_main.c
@@ -5,6 +5,7 @@
 #include "ixd_lan_regs.h"
 
 MODULE_DESCRIPTION("Intel(R) Control Plane Function Device Driver");
+MODULE_IMPORT_NS("LIBETH_CP");
 MODULE_IMPORT_NS("LIBETH_PCI");
 MODULE_LICENSE("GPL");
 
@@ -16,7 +17,13 @@ static void ixd_remove(struct pci_dev *pdev)
 {
 	struct ixd_adapter *adapter = pci_get_drvdata(pdev);
 
-	libeth_pci_unmap_all_mmio_regions(&adapter->hw);
+	/* Do not mix removal with (re)initialization */
+	cancel_delayed_work_sync(&adapter->init_task.init_work);
+	/* Leave the device clean on exit */
+	ixd_trigger_reset(adapter);
+	ixd_deinit_dflt_mbx(adapter);
+
+	libeth_pci_unmap_all_mmio_regions(&adapter->cp_ctx.mmio_info);
 	libeth_pci_deinit_dev(pdev);
 }
 
@@ -52,7 +59,7 @@ static int ixd_iomap_regions(struct ixd_adapter *adapter)
 	};
 
 	for (int i = 0; i < ARRAY_SIZE(regions); i++) {
-		struct libeth_mmio_info *mmio_info = &adapter->hw;
+		struct libeth_mmio_info *mmio_info = &adapter->cp_ctx.mmio_info;
 		bool map_ok;
 
 		map_ok = libeth_pci_map_mmio_region(mmio_info,
@@ -82,11 +89,15 @@ static int ixd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct ixd_adapter *adapter;
 	int err;
 
+	if (WARN_ON(ent->device != IXD_DEV_ID_CPF))
+		return -EINVAL;
+
 	adapter = devm_kzalloc(&pdev->dev, sizeof(*adapter), GFP_KERNEL);
 	if (!adapter)
 		return -ENOMEM;
-	adapter->hw.pdev = pdev;
-	INIT_LIST_HEAD(&adapter->hw.mmio_list);
+
+	adapter->cp_ctx.mmio_info.pdev = pdev;
+	INIT_LIST_HEAD(&adapter->cp_ctx.mmio_info.mmio_list);
 
 	err = libeth_pci_init_dev(pdev);
 	if (err)
@@ -98,6 +109,13 @@ static int ixd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		goto deinit_dev;
 
+	INIT_DELAYED_WORK(&adapter->init_task.init_work,
+			  ixd_init_task);
+
+	ixd_trigger_reset(adapter);
+	queue_delayed_work(system_unbound_wq, &adapter->init_task.init_work,
+			   msecs_to_jiffies(500));
+
 	return 0;
 
 deinit_dev:
-- 
2.47.0


