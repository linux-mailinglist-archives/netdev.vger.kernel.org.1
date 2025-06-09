Return-Path: <netdev+bounces-195796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BFEAD23ED
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 18:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25BDD18871B5
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 16:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4181D9A5F;
	Mon,  9 Jun 2025 16:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h8s4Bf3m"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9190D4A21
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 16:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486644; cv=none; b=QTc9hqX82Liye9rtNfeNNzVE6lMsrwM65GvSP1+btv775fvryNfGgvwCHrZFgMFzoaQMmWo56NMArkcsZS6RRXs529ATH83kqWOHlvJTipsOAdz/kpmVMxuSR3mla4AUi8I8Fi6fVAfAfZKHe9xsbUnnJHYMxwgzSvx0S9fjpsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486644; c=relaxed/simple;
	bh=VCIDEXG69TzvNMN9DuQrTdls76vDokMst2vOttWIPro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YRbUp0yFj/Vhhafl1EDMGeiIXWO44nuxq8zpil5HIS3DZ7KKcZpFLtDkaI7tXQGeYu30BxD7juNNNyVz8Z1FSlcoFbn+XFQLG8W2nPdffWH4jLfsGH7LOnclbVMYKdnpTJh5fJRQxFRPB0DmvCJ6PKqbopkxMoBEygg3CA6lNqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h8s4Bf3m; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749486643; x=1781022643;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VCIDEXG69TzvNMN9DuQrTdls76vDokMst2vOttWIPro=;
  b=h8s4Bf3mbgXFnsmBmxl5o+EaOhduDYTxm9KqNufc0Mpb78/jkUkX5Dc6
   u1AXXRCkaCEW/pHVzUrVQoIOXo/XOLwdKxZPjTmRauy7jTXZqbBw60B3c
   pW0kEojcdvYbLlqIj2/rdcfqcmX/8rdmcl7CDBf23exxXQ/1FfOsd2miX
   OCWBYe6VQcmGAQjdjKlT6tyxeuDaeVtK/ZQIyVPlcI682eJuxe1EJsT7P
   36E5f9vSMiydaEHmIv+yPDmtYajDMNsED81ffbVqhqt+g5+pFOLTi7zJa
   DuxN1+S3IUFC/3FRNq/t4nxU+YOpZnpcN8FY33GGwS/58wxCXKTdATpxa
   Q==;
X-CSE-ConnectionGUID: ObjPtICBSe6MFvrm6sZ9EQ==
X-CSE-MsgGUID: z96mN77wS+u/kTFKclLlDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="62607317"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="62607317"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 09:30:33 -0700
X-CSE-ConnectionGUID: meUgPIj0SmCtvitbTehL0Q==
X-CSE-MsgGUID: 5zxv/20OSs63knzf8yH8sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="146443819"
Received: from gklab-003-014.igk.intel.com ([10.91.173.44])
  by fmviesa006.fm.intel.com with ESMTP; 09 Jun 2025 09:30:30 -0700
From: Milena Olech <milena.olech@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Milena Olech <milena.olech@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH v2 iwl-next] idpf: add cross timestamping
Date: Mon,  9 Jun 2025 18:28:09 +0200
Message-ID: <20250609162845.167410-4-milena.olech@intel.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add cross timestamp support through virtchnl mailbox messages and directly,
through PCIe BAR registers. Cross timestamping assumes that both system
time and device clock time values are cached simultaneously, what is
triggered by HW. Feature is enabled for both ARM and x86 archs.

Signed-off-by: Milena Olech <milena.olech@intel.com>
Reviewed-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
v1 -> v2: rebase on the top of iXD, fix kernel doc, use IS_ENABLED
directly in the code flow

 drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 136 ++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_ptp.h    |  19 ++-
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  62 +++++++-
 3 files changed, 215 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
index cb46185da749..43b7efc88a85 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
@@ -49,6 +49,13 @@ void idpf_ptp_get_features_access(const struct idpf_adapter *adapter)
 							   direct,
 							   mailbox);
 
+	/* Get the cross timestamp */
+	direct = VIRTCHNL2_CAP_PTP_GET_CROSS_TIME;
+	mailbox = VIRTCHNL2_CAP_PTP_GET_CROSS_TIME_MB;
+	ptp->get_cross_tstamp_access = idpf_ptp_get_access(adapter,
+							   direct,
+							   mailbox);
+
 	/* Adjust the device clock time */
 	direct = VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK;
 	mailbox = VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK_MB;
@@ -171,6 +178,127 @@ static int idpf_ptp_read_src_clk_reg(struct idpf_adapter *adapter, u64 *src_clk,
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_ARM_ARCH_TIMER) || IS_ENABLED(CONFIG_X86)
+/**
+ * idpf_ptp_get_sync_device_time_direct - Get the cross time stamp values
+ *					  directly
+ * @adapter: Driver specific private structure
+ * @dev_time: 64bit main timer value
+ * @sys_time: 64bit system time value
+ */
+static void idpf_ptp_get_sync_device_time_direct(struct idpf_adapter *adapter,
+						 u64 *dev_time, u64 *sys_time)
+{
+	u32 dev_time_lo, dev_time_hi, sys_time_lo, sys_time_hi;
+	struct idpf_ptp *ptp = adapter->ptp;
+
+	spin_lock(&ptp->read_dev_clk_lock);
+
+	idpf_ptp_enable_shtime(adapter);
+
+	dev_time_lo = readl(ptp->dev_clk_regs.dev_clk_ns_l);
+	dev_time_hi = readl(ptp->dev_clk_regs.dev_clk_ns_h);
+
+	sys_time_lo = readl(ptp->dev_clk_regs.sys_time_ns_l);
+	sys_time_hi = readl(ptp->dev_clk_regs.sys_time_ns_h);
+
+	spin_unlock(&ptp->read_dev_clk_lock);
+
+	*dev_time = (u64)dev_time_hi << 32 | dev_time_lo;
+	*sys_time = (u64)sys_time_hi << 32 | sys_time_lo;
+}
+
+/**
+ * idpf_ptp_get_sync_device_time_mailbox - Get the cross time stamp values
+ *					   through mailbox
+ * @adapter: Driver specific private structure
+ * @dev_time: 64bit main timer value expressed in nanoseconds
+ * @sys_time: 64bit system time value expressed in nanoseconds
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int idpf_ptp_get_sync_device_time_mailbox(struct idpf_adapter *adapter,
+						 u64 *dev_time, u64 *sys_time)
+{
+	struct idpf_ptp_dev_timers cross_time;
+	int err;
+
+	err = idpf_ptp_get_cross_time(adapter, &cross_time);
+	if (err)
+		return err;
+
+	*dev_time = cross_time.dev_clk_time_ns;
+	*sys_time = cross_time.sys_time_ns;
+
+	return err;
+}
+
+/**
+ * idpf_ptp_get_sync_device_time - Get the cross time stamp info
+ * @device: Current device time
+ * @system: System counter value read synchronously with device time
+ * @ctx: Context provided by timekeeping code
+ *
+ * The device and the system clocks time read simultaneously.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int idpf_ptp_get_sync_device_time(ktime_t *device,
+					 struct system_counterval_t *system,
+					 void *ctx)
+{
+	struct idpf_adapter *adapter = ctx;
+	u64 ns_time_dev, ns_time_sys;
+	int err;
+
+	switch (adapter->ptp->get_cross_tstamp_access) {
+	case IDPF_PTP_NONE:
+		return -EOPNOTSUPP;
+	case IDPF_PTP_DIRECT:
+		idpf_ptp_get_sync_device_time_direct(adapter, &ns_time_dev,
+						     &ns_time_sys);
+		break;
+	case IDPF_PTP_MAILBOX:
+		err = idpf_ptp_get_sync_device_time_mailbox(adapter,
+							    &ns_time_dev,
+							    &ns_time_sys);
+		if (err)
+			return err;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	*device = ns_to_ktime(ns_time_dev);
+
+	system->cs_id = IS_ENABLED(CONFIG_X86) ? CSID_X86_ART
+					       : CSID_ARM_ARCH_COUNTER;
+	system->cycles = ns_time_sys;
+	system->use_nsecs = true;
+
+	return 0;
+}
+
+/**
+ * idpf_ptp_get_crosststamp - Capture a device cross timestamp
+ * @info: the driver's PTP info structure
+ * @cts: The memory to fill the cross timestamp info
+ *
+ * Capture a cross timestamp between the system time and the device PTP hardware
+ * clock.
+ *
+ * Return: cross timestamp value on success, -errno on failure.
+ */
+static int idpf_ptp_get_crosststamp(struct ptp_clock_info *info,
+				    struct system_device_crosststamp *cts)
+{
+	struct idpf_adapter *adapter = idpf_ptp_info_to_adapter(info);
+
+	return get_device_system_crosststamp(idpf_ptp_get_sync_device_time,
+					     adapter, NULL, cts);
+}
+#endif /* CONFIG_ARM_ARCH_TIMER || CONFIG_X86 */
+
 /**
  * idpf_ptp_gettimex64 - Get the time of the clock
  * @info: the driver's PTP info structure
@@ -664,6 +792,14 @@ static void idpf_ptp_set_caps(const struct idpf_adapter *adapter)
 	info->verify = idpf_ptp_verify_pin;
 	info->enable = idpf_ptp_gpio_enable;
 	info->do_aux_work = idpf_ptp_do_aux_work;
+#if IS_ENABLED(CONFIG_ARM_ARCH_TIMER)
+	info->getcrosststamp = idpf_ptp_get_crosststamp;
+#elif IS_ENABLED(CONFIG_X86)
+	if (pcie_ptm_enabled(adapter->pdev) &&
+	    boot_cpu_has(X86_FEATURE_ART) &&
+	    boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ))
+		info->getcrosststamp = idpf_ptp_get_crosststamp;
+#endif /* CONFIG_ARM_ARCH_TIMER */
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.h b/drivers/net/ethernet/intel/idpf/idpf_ptp.h
index a876749d6116..cd19f65f9fff 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.h
@@ -21,6 +21,8 @@ struct idpf_ptp_cmd {
  * @dev_clk_ns_h: high part of the device clock register
  * @phy_clk_ns_l: low part of the PHY clock register
  * @phy_clk_ns_h: high part of the PHY clock register
+ * @sys_time_ns_l: low part of the system time register
+ * @sys_time_ns_h: high part of the system time register
  * @incval_l: low part of the increment value register
  * @incval_h: high part of the increment value register
  * @shadj_l: low part of the shadow adjust register
@@ -42,6 +44,10 @@ struct idpf_ptp_dev_clk_regs {
 	void __iomem *phy_clk_ns_l;
 	void __iomem *phy_clk_ns_h;
 
+	/* System time */
+	void __iomem *sys_time_ns_l;
+	void __iomem *sys_time_ns_h;
+
 	/* Main timer adjustments */
 	void __iomem *incval_l;
 	void __iomem *incval_h;
@@ -162,6 +168,7 @@ struct idpf_ptp_vport_tx_tstamp_caps {
  * @dev_clk_regs: the set of registers to access the device clock
  * @caps: PTP capabilities negotiated with the Control Plane
  * @get_dev_clk_time_access: access type for getting the device clock time
+ * @get_cross_tstamp_access: access type for the cross timestamping
  * @set_dev_clk_time_access: access type for setting the device clock time
  * @adj_dev_clk_time_access: access type for the adjusting the device clock
  * @tx_tstamp_access: access type for the Tx timestamp value read
@@ -182,10 +189,11 @@ struct idpf_ptp {
 	struct idpf_ptp_dev_clk_regs dev_clk_regs;
 	u32 caps;
 	enum idpf_ptp_access get_dev_clk_time_access:2;
+	enum idpf_ptp_access get_cross_tstamp_access:2;
 	enum idpf_ptp_access set_dev_clk_time_access:2;
 	enum idpf_ptp_access adj_dev_clk_time_access:2;
 	enum idpf_ptp_access tx_tstamp_access:2;
-	u8 rsv;
+	u8 rsv:6;
 	struct idpf_ptp_secondary_mbx secondary_mbx;
 	spinlock_t read_dev_clk_lock;
 };
@@ -264,6 +272,8 @@ void idpf_ptp_get_features_access(const struct idpf_adapter *adapter);
 bool idpf_ptp_get_txq_tstamp_capability(struct idpf_tx_queue *txq);
 int idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,
 			      struct idpf_ptp_dev_timers *dev_clk_time);
+int idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
+			    struct idpf_ptp_dev_timers *cross_time);
 int idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter, u64 time);
 int idpf_ptp_adj_dev_clk_fine(struct idpf_adapter *adapter, u64 incval);
 int idpf_ptp_adj_dev_clk_time(struct idpf_adapter *adapter, s64 delta);
@@ -305,6 +315,13 @@ idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,
 	return -EOPNOTSUPP;
 }
 
+static inline int
+idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
+			struct idpf_ptp_dev_timers *cross_time)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter,
 					    u64 time)
 {
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
index 7dee41953c92..98a62d5583fd 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
@@ -29,6 +29,7 @@ int idpf_ptp_get_caps(struct idpf_adapter *adapter)
 		.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
 	};
 	struct libie_mmio_info	*mmio_info = &adapter->ctlq_ctx.mmio_info;
+	struct virtchnl2_ptp_cross_time_reg_offsets cross_tstamp_offsets;
 	struct virtchnl2_ptp_clk_adj_reg_offsets clk_adj_offsets;
 	struct virtchnl2_ptp_clk_reg_offsets clock_offsets;
 	struct idpf_ptp_secondary_mbx *scnd_mbx;
@@ -70,7 +71,7 @@ int idpf_ptp_get_caps(struct idpf_adapter *adapter)
 
 	access_type = ptp->get_dev_clk_time_access;
 	if (access_type != IDPF_PTP_DIRECT)
-		goto discipline_clock;
+		goto cross_tstamp;
 
 	clock_offsets = recv_ptp_caps_msg->clk_offsets;
 
@@ -90,6 +91,23 @@ int idpf_ptp_get_caps(struct idpf_adapter *adapter)
 	ptp->dev_clk_regs.cmd_sync =
 		libie_pci_get_mmio_addr(mmio_info, temp_offset);
 
+cross_tstamp:
+	access_type = ptp->get_cross_tstamp_access;
+	if (access_type != IDPF_PTP_DIRECT)
+		goto discipline_clock;
+
+	cross_tstamp_offsets = recv_ptp_caps_msg->cross_time_offsets;
+
+	temp_offset = le32_to_cpu(cross_tstamp_offsets.sys_time_ns_l);
+	ptp->dev_clk_regs.sys_time_ns_l =
+		libie_pci_get_mmio_addr(mmio_info, temp_offset);
+	temp_offset = le32_to_cpu(cross_tstamp_offsets.sys_time_ns_h);
+	ptp->dev_clk_regs.sys_time_ns_h =
+		libie_pci_get_mmio_addr(mmio_info, temp_offset);
+	temp_offset = le32_to_cpu(cross_tstamp_offsets.cmd_sync_trigger);
+	ptp->dev_clk_regs.cmd_sync =
+		libie_pci_get_mmio_addr(mmio_info, temp_offset);
+
 discipline_clock:
 	access_type = ptp->adj_dev_clk_time_access;
 	if (access_type != IDPF_PTP_DIRECT)
@@ -178,6 +196,48 @@ int idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,
 	return err;
 }
 
+/**
+ * idpf_ptp_get_cross_time - Send virtchnl get cross time message
+ * @adapter: Driver specific private structure
+ * @cross_time: Pointer to the device clock structure where the value is set
+ *
+ * Send virtchnl get cross time message to get the time of the clock and the
+ * system time.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
+			    struct idpf_ptp_dev_timers *cross_time)
+{
+	struct virtchnl2_ptp_get_cross_time *cross_time_resp;
+	struct virtchnl2_ptp_get_cross_time cross_time_msg;
+	struct libie_ctlq_xn_send_params xn_params = {
+		.chnl_opcode = VIRTCHNL2_OP_PTP_GET_CROSS_TIME,
+		.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
+	};
+	int reply_sz;
+	int err;
+
+	err = idpf_send_mb_msg(adapter, &xn_params, &cross_time_msg,
+			       sizeof(cross_time_msg));
+	if (err)
+		return err;
+
+	reply_sz = xn_params.recv_mem.iov_len;
+	if (reply_sz != sizeof(*cross_time_resp)) {
+		err = -EIO;
+		goto free_resp;
+	}
+
+	cross_time_resp = xn_params.recv_mem.iov_base;
+	cross_time->dev_clk_time_ns = le64_to_cpu(cross_time_resp->dev_time_ns);
+	cross_time->sys_time_ns = le64_to_cpu(cross_time_resp->sys_time_ns);
+
+free_resp:
+	libie_ctlq_release_rx_buf(&xn_params.recv_mem);
+	return err;
+}
+
 /**
  * idpf_ptp_set_dev_clk_time - Send virtchnl set device time message
  * @adapter: Driver specific private structure

base-commit: c1589adc4856d13b67b3cc8939c8af579fbdb5da
-- 
2.43.5


