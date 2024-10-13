Return-Path: <netdev+bounces-135124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160CA99C638
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 11:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9F8728397D
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 09:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6091715D5C5;
	Mon, 14 Oct 2024 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EKSp2C9x"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D8115AAB6
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728899049; cv=none; b=WddXG3FqDaeJtfNxu7nnP1kSPhLS/vaxehzrjrL9JtiQPIUNLiw8L/X1YTTnN7BTAiyrk41wp37u60E/myP/8i9fufuckvyaGsTI3GC4ciJ5uTfka2INfNHPWr9a/CZ3x7AX60kU3wxXFk2JGeP587XyRjAniLv2bruYDwnr9nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728899049; c=relaxed/simple;
	bh=jz78XiG/tpLFrq0Pvh+0C7bBr/QzNuRKfte5E79IF1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MxKFrJnGFg2WY/N11oPtCZwaDqI4CLCZN5q5zcvjDYNYzMOxd+0T+LKZu1Rz3lprU9mE1sLjPXJ/Oi5julrCycN3lpUgJWejN9TA8jpxMaMbyufKhxYQAlM+TKg+xDI6mHIyPh/a1Mv/Uwn3dKbh+4H1ZG9R8pH3/dMGrZid9gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EKSp2C9x; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728899047; x=1760435047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jz78XiG/tpLFrq0Pvh+0C7bBr/QzNuRKfte5E79IF1c=;
  b=EKSp2C9xKqX9kPMOO4xxHWLxopwqhdHHEgjckt5omB9O/p47cnStqa79
   etE4y1B4C91yW0ZBXO2P56krdD1WvcOU4GVUWFD9NAJNcbEZozOpWzr15
   xNRk57FPs80wyYzHyu0TMgsp9NvjPX03FmyZkuy2SI/6b7gvwFMkk3vo9
   u2pRCR3hH8QdzUnlqwjDig2vrZ93D8QSn1KdlD8nvRVcAmd3YnZvCUv6T
   dEOzAff98IyfcgC3xHDuZs94maCdgfrCNDB4C3dbrpbjXYeSJi6forN+T
   LZxfqOr6zcM+EGmDE1AQkwriXUZXkjxhDgYwNXsTbGvq+Go1iGyiZBEfy
   A==;
X-CSE-ConnectionGUID: K+E3tLFDQO+dxOM1o6tDkg==
X-CSE-MsgGUID: H7kknppBT9iP0VzlAmFycA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="45712167"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="45712167"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 02:44:07 -0700
X-CSE-ConnectionGUID: 9lzWK63OTj6TV9Tgel09yg==
X-CSE-MsgGUID: z+IS8ZluRS6UyVBNcIhUig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="77531818"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa009.fm.intel.com with ESMTP; 14 Oct 2024 02:44:04 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 1401D27BA0;
	Mon, 14 Oct 2024 10:44:03 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	aleksander.lobakin@intel.com
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Simon Horman <horms@kernel.org>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v11 06/14] iavf: add initial framework for registering PTP clock
Date: Sun, 13 Oct 2024 11:44:07 -0400
Message-Id: <20241013154415.20262-7-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241013154415.20262-1-mateusz.polchlopek@intel.com>
References: <20241013154415.20262-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

Add the iavf_ptp.c file and fill it in with a skeleton framework to
allow registering the PTP clock device.
Add implementation of helper functions to check if a PTP capability
is supported and handle change in PTP capabilities.
Enabling virtual clock would be possible, though it would probably
perform poorly due to the lack of direct time access.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Co-developed-by: Ahmed Zaki <ahmed.zaki@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 drivers/net/ethernet/intel/iavf/Makefile      |   2 +
 drivers/net/ethernet/intel/iavf/iavf_main.c   |   6 +
 drivers/net/ethernet/intel/iavf/iavf_ptp.c    | 122 ++++++++++++++++++
 drivers/net/ethernet/intel/iavf/iavf_ptp.h    |   5 +
 drivers/net/ethernet/intel/iavf/iavf_txrx.h   |   2 +
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |   8 ++
 6 files changed, 145 insertions(+)
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_ptp.c

diff --git a/drivers/net/ethernet/intel/iavf/Makefile b/drivers/net/ethernet/intel/iavf/Makefile
index 356ac9faa5bf..e13720a728ff 100644
--- a/drivers/net/ethernet/intel/iavf/Makefile
+++ b/drivers/net/ethernet/intel/iavf/Makefile
@@ -13,3 +13,5 @@ obj-$(CONFIG_IAVF) += iavf.o
 
 iavf-y := iavf_main.o iavf_ethtool.o iavf_virtchnl.o iavf_fdir.o \
 	  iavf_adv_rss.o iavf_txrx.o iavf_common.o iavf_adminq.o
+
+iavf-$(CONFIG_PTP_1588_CLOCK) += iavf_ptp.o
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 3b149bb7d840..be07e9f8e664 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4,6 +4,7 @@
 #include <linux/net/intel/libie/rx.h>
 
 #include "iavf.h"
+#include "iavf_ptp.h"
 #include "iavf_prototype.h"
 /* All iavf tracepoints are defined by the include below, which must
  * be included exactly once across the whole kernel with
@@ -2871,6 +2872,9 @@ static void iavf_init_config_adapter(struct iavf_adapter *adapter)
 	if (QOS_ALLOWED(adapter))
 		adapter->aq_required |= IAVF_FLAG_AQ_GET_QOS_CAPS;
 
+	/* Setup initial PTP configuration */
+	iavf_ptp_init(adapter);
+
 	iavf_schedule_finish_config(adapter);
 	return;
 
@@ -5645,6 +5649,8 @@ static void iavf_remove(struct pci_dev *pdev)
 		msleep(50);
 	}
 
+	iavf_ptp_release(adapter);
+
 	iavf_misc_irq_disable(adapter);
 	/* Shut down all the garbage mashers on the detention level */
 	cancel_work_sync(&adapter->reset_task);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.c b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
new file mode 100644
index 000000000000..5a1b5f8b87e5
--- /dev/null
+++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2024 Intel Corporation. */
+
+#include "iavf.h"
+#include "iavf_ptp.h"
+
+/**
+ * iavf_ptp_cap_supported - Check if a PTP capability is supported
+ * @adapter: private adapter structure
+ * @cap: the capability bitmask to check
+ *
+ * Return: true if every capability set in cap is also set in the enabled
+ *         capabilities reported by the PF, false otherwise.
+ */
+bool iavf_ptp_cap_supported(const struct iavf_adapter *adapter, u32 cap)
+{
+	if (!IAVF_PTP_ALLOWED(adapter))
+		return false;
+
+	/* Only return true if every bit in cap is set in hw_caps.caps */
+	return (adapter->ptp.hw_caps.caps & cap) == cap;
+}
+
+/**
+ * iavf_ptp_register_clock - Register a new PTP for userspace
+ * @adapter: private adapter structure
+ *
+ * Allocate and register a new PTP clock device if necessary.
+ *
+ * Return: 0 if success, error otherwise.
+ */
+static int iavf_ptp_register_clock(struct iavf_adapter *adapter)
+{
+	struct ptp_clock_info *ptp_info = &adapter->ptp.info;
+	struct device *dev = &adapter->pdev->dev;
+	struct ptp_clock *clock;
+
+	snprintf(ptp_info->name, sizeof(ptp_info->name), "%s-%s-clk",
+		 KBUILD_MODNAME, dev_name(dev));
+	ptp_info->owner = THIS_MODULE;
+
+	clock = ptp_clock_register(ptp_info, dev);
+	if (IS_ERR(clock))
+		return PTR_ERR(clock);
+
+	adapter->ptp.clock = clock;
+
+	dev_dbg(&adapter->pdev->dev, "PTP clock %s registered\n",
+		adapter->ptp.info.name);
+
+	return 0;
+}
+
+/**
+ * iavf_ptp_init - Initialize PTP support if capability was negotiated
+ * @adapter: private adapter structure
+ *
+ * Initialize PTP functionality, based on the capabilities that the PF has
+ * enabled for this VF.
+ */
+void iavf_ptp_init(struct iavf_adapter *adapter)
+{
+	int err;
+
+	if (!iavf_ptp_cap_supported(adapter, VIRTCHNL_1588_PTP_CAP_READ_PHC)) {
+		pci_notice(adapter->pdev,
+			   "Device does not have PTP clock support\n");
+		return;
+	}
+
+	err = iavf_ptp_register_clock(adapter);
+	if (err) {
+		pci_err(adapter->pdev,
+			"Failed to register PTP clock device (%p)\n",
+			ERR_PTR(err));
+		return;
+	}
+
+	for (int i = 0; i < adapter->num_active_queues; i++) {
+		struct iavf_ring *rx_ring = &adapter->rx_rings[i];
+
+		rx_ring->ptp = &adapter->ptp;
+	}
+}
+
+/**
+ * iavf_ptp_release - Disable PTP support
+ * @adapter: private adapter structure
+ *
+ * Release all PTP resources that were previously initialized.
+ */
+void iavf_ptp_release(struct iavf_adapter *adapter)
+{
+	if (!adapter->ptp.clock)
+		return;
+
+	pci_dbg(adapter->pdev, "removing PTP clock %s\n",
+		adapter->ptp.info.name);
+	ptp_clock_unregister(adapter->ptp.clock);
+	adapter->ptp.clock = NULL;
+}
+
+/**
+ * iavf_ptp_process_caps - Handle change in PTP capabilities
+ * @adapter: private adapter structure
+ *
+ * Handle any state changes necessary due to change in PTP capabilities, such
+ * as after a device reset or change in configuration from the PF.
+ */
+void iavf_ptp_process_caps(struct iavf_adapter *adapter)
+{
+	bool phc = iavf_ptp_cap_supported(adapter, VIRTCHNL_1588_PTP_CAP_READ_PHC);
+
+	/* Check if the device gained or lost necessary access to support the
+	 * PTP hardware clock. If so, driver must respond appropriately by
+	 * creating or destroying the PTP clock device.
+	 */
+	if (adapter->ptp.clock && !phc)
+		iavf_ptp_release(adapter);
+	else if (!adapter->ptp.clock && phc)
+		iavf_ptp_init(adapter);
+}
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.h b/drivers/net/ethernet/intel/iavf/iavf_ptp.h
index 65678e76c34f..c2ed24cef926 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ptp.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.h
@@ -6,4 +6,9 @@
 
 #include "iavf_types.h"
 
+void iavf_ptp_init(struct iavf_adapter *adapter);
+void iavf_ptp_release(struct iavf_adapter *adapter);
+void iavf_ptp_process_caps(struct iavf_adapter *adapter);
+bool iavf_ptp_cap_supported(const struct iavf_adapter *adapter, u32 cap);
+
 #endif /* _IAVF_PTP_H_ */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.h b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
index 15a05e30434d..c38b4ec2eaea 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
@@ -297,6 +297,8 @@ struct iavf_ring {
 					 * for this ring.
 					 */
 
+	struct iavf_ptp *ptp;
+
 	u32 rx_buf_len;
 	struct net_shaper q_shaper;
 	bool q_shaper_update;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 65b0028bb968..d009171e5f8a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -4,6 +4,7 @@
 #include <linux/net/intel/libie/rx.h>
 
 #include "iavf.h"
+#include "iavf_ptp.h"
 #include "iavf_prototype.h"
 
 /**
@@ -359,6 +360,7 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
 	int pairs = adapter->num_active_queues;
 	struct virtchnl_queue_pair_info *vqpi;
 	u32 i, max_frame;
+	u8 rx_flags = 0;
 	size_t len;
 
 	max_frame = LIBIE_MAX_RX_FRM_LEN(adapter->rx_rings->pp->p.offset);
@@ -376,6 +378,9 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
 	if (!vqci)
 		return;
 
+	if (iavf_ptp_cap_supported(adapter, VIRTCHNL_1588_PTP_CAP_RX_TSTAMP))
+		rx_flags |= VIRTCHNL_PTP_RX_TSTAMP;
+
 	vqci->vsi_id = adapter->vsi_res->vsi_id;
 	vqci->num_queue_pairs = pairs;
 	vqpi = vqci->qpair;
@@ -398,6 +403,7 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
 		if (CRC_OFFLOAD_ALLOWED(adapter))
 			vqpi->rxq.crc_disable = !!(adapter->netdev->features &
 						   NETIF_F_RXFCS);
+		vqpi->rxq.flags = rx_flags;
 		vqpi++;
 	}
 
@@ -2608,6 +2614,8 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 
 		adapter->ptp.hw_caps = *(struct virtchnl_ptp_caps *)msg;
 
+		/* process any state change needed due to new capabilities */
+		iavf_ptp_process_caps(adapter);
 		break;
 	case VIRTCHNL_OP_ENABLE_QUEUES:
 		/* enable transmits */
-- 
2.38.1


