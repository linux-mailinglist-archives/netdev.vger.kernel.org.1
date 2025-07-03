Return-Path: <netdev+bounces-203897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 951B6AF7F48
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 19:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82E671CA2113
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 17:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C074A2F2C42;
	Thu,  3 Jul 2025 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BEDIOTUy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB592F2714
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751564574; cv=none; b=aF7JVcH3hJrokuum6df7xhG1EG+6B6PG31TstAP7EtUxbItk2cqziD6Q9iQTHqH1uTMqgOKcgIoE6umTPv8ewjKwP/VPrqUR+hqNSbDE58M1luraN5Vld6riU4mFKP2nCpU88PU3Nwg3KCbwNdH5KIZeV+w/gPceZD6vjC8TJu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751564574; c=relaxed/simple;
	bh=E9Ak6jttg05x6DXCtWvsSAfBWoMK7+awR0LxYUN3QIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVzB3wVzDrb2W7UPFlpdgD5/sz9Cu4Fv7DFgXIzO1mH7l8GZEj4YVBl7rwWiNeOU5IDXFLBBzfcQ1WjNdTypYPLqL/9d4OyBoZBkxczifFaU7dnETHfcs7lu3afIoBNKZN7cqK182lrgnLBeJGo4BLwLfno3NzA0+DNu6gPmNaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BEDIOTUy; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751564574; x=1783100574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E9Ak6jttg05x6DXCtWvsSAfBWoMK7+awR0LxYUN3QIU=;
  b=BEDIOTUyr3nHM9VGXQsRV9buyI4JmVIzpbQ39BhQDfYknzl1o3jR7Mcj
   JwzdDudDG6TAgebvFczZMn/1xR016xXniwFdqjVY1q+mTdeT+Cv9+BGQz
   uXsufbF4thW3CThhv5QmA9Jac0UvjBHAHCQYRGZaC8IbhNv89Bjh7seWh
   b4t3gvirjT7m9a/tPD5NNtK3ksg1/+g/msfasCGUB8XJji8dUdsCWZ5Cg
   edAw6FBlPZHkOGka6C9EFDF7uCf51fKbVyF/yDnvs+iGgW51MFmrnTcYg
   IizSwJcJZxEyP6gFBjCwfayacNIBi2C5Cs/TIluhBRJ++BmTFtinEC/HS
   w==;
X-CSE-ConnectionGUID: raZckS+PQ0+Qa4ln9Cr1Nw==
X-CSE-MsgGUID: GNdmGHLKS+upwUv33njd4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53767943"
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="53767943"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 10:42:51 -0700
X-CSE-ConnectionGUID: YjegntrNRAuK8YTsCpMjvA==
X-CSE-MsgGUID: HrQ5fO/vQI28F8DPRkuQeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="154997909"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 03 Jul 2025 10:42:49 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	jedrzej.jagielski@intel.com,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@intel.com,
	piotr.kwapulinski@intel.com,
	marcin.szycik@linux.intel.com,
	horms@kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 07/12] ixgbe: check for MDD events
Date: Thu,  3 Jul 2025 10:42:34 -0700
Message-ID: <20250703174242.3829277-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250703174242.3829277-1-anthony.l.nguyen@intel.com>
References: <20250703174242.3829277-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Don Skidmore <donald.c.skidmore@intel.com>

When an event is detected it is logged and, for the time being, the
queue is immediately re-enabled.  This is due to the lack of an API
to the hypervisor so it could deal with it as it chooses.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  3 ++
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    | 51 +++++++++++++++++++
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.h    |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  2 +
 4 files changed, 57 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 991cf24f3b9b..4db8e7136571 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7964,6 +7964,9 @@ static void ixgbe_watchdog_link_is_up(struct ixgbe_adapter *adapter)
 	netif_carrier_on(netdev);
 	ixgbe_check_vf_rate_limit(adapter);
 
+	if (adapter->num_vfs && hw->mac.ops.enable_mdd)
+		hw->mac.ops.enable_mdd(hw);
+
 	/* enable transmits */
 	netif_tx_wake_all_queues(adapter->netdev);
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 0dbbd2befd4d..bd9a054d7d94 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -207,6 +207,7 @@ void ixgbe_enable_sriov(struct ixgbe_adapter *adapter, unsigned int max_vfs)
 int ixgbe_disable_sriov(struct ixgbe_adapter *adapter)
 {
 	unsigned int num_vfs = adapter->num_vfs, vf;
+	struct ixgbe_hw *hw = &adapter->hw;
 	unsigned long flags;
 	int rss;
 
@@ -237,6 +238,9 @@ int ixgbe_disable_sriov(struct ixgbe_adapter *adapter)
 	if (!(adapter->flags & IXGBE_FLAG_SRIOV_ENABLED))
 		return 0;
 
+	if (hw->mac.ops.disable_mdd)
+		hw->mac.ops.disable_mdd(hw);
+
 #ifdef CONFIG_PCI_IOV
 	/*
 	 * If our VFs are assigned we cannot shut down SR-IOV
@@ -1353,12 +1357,59 @@ static void ixgbe_rcv_ack_from_vf(struct ixgbe_adapter *adapter, u32 vf)
 		ixgbe_write_mbx(hw, &msg, 1, vf);
 }
 
+/**
+ * ixgbe_check_mdd_event - check for MDD event on all VFs
+ * @adapter: pointer to ixgbe adapter
+ *
+ * Return: true if there is a VF on which MDD event occurred, false otherwise.
+ */
+bool ixgbe_check_mdd_event(struct ixgbe_adapter *adapter)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+	DECLARE_BITMAP(vf_bitmap, 64);
+	bool ret = false;
+	int i;
+
+	if (!hw->mac.ops.handle_mdd)
+		return false;
+
+	/* Did we have a malicious event */
+	bitmap_zero(vf_bitmap, 64);
+	hw->mac.ops.handle_mdd(hw, vf_bitmap);
+
+	/* Log any blocked queues and release lock */
+	for_each_set_bit(i, vf_bitmap, 64) {
+		dev_warn(&adapter->pdev->dev,
+			 "Malicious event on VF %d tx:%x rx:%x\n", i,
+			 IXGBE_READ_REG(hw, IXGBE_LVMMC_TX),
+			 IXGBE_READ_REG(hw, IXGBE_LVMMC_RX));
+
+		if (hw->mac.ops.restore_mdd_vf) {
+			u32 ping;
+
+			hw->mac.ops.restore_mdd_vf(hw, i);
+
+			/* get the VF to rebuild its queues */
+			adapter->vfinfo[i].clear_to_send = 0;
+			ping = IXGBE_PF_CONTROL_MSG |
+			       IXGBE_VT_MSGTYPE_CTS;
+			ixgbe_write_mbx(hw, &ping, 1, i);
+		}
+
+		ret = true;
+	}
+
+	return ret;
+}
+
 void ixgbe_msg_task(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	unsigned long flags;
 	u32 vf;
 
+	ixgbe_check_mdd_event(adapter);
+
 	spin_lock_irqsave(&adapter->vfs_lock, flags);
 	for (vf = 0; vf < adapter->num_vfs; vf++) {
 		/* process any reset requests */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h
index 0690ecb8dfa3..bc4cab976bf9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h
@@ -15,6 +15,7 @@
 #ifdef CONFIG_PCI_IOV
 void ixgbe_restore_vf_multicasts(struct ixgbe_adapter *adapter);
 #endif
+bool ixgbe_check_mdd_event(struct ixgbe_adapter *adapter);
 void ixgbe_msg_task(struct ixgbe_adapter *adapter);
 int ixgbe_vf_configuration(struct pci_dev *pdev, unsigned int event_mask);
 void ixgbe_ping_all_vfs(struct ixgbe_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 2a25abc0b17a..89df6f462302 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -402,6 +402,8 @@ struct ixgbe_nvm_version {
 #define IXGBE_MRCTL(_i)      (0x0F600 + ((_i) * 4))
 #define IXGBE_VMRVLAN(_i)    (0x0F610 + ((_i) * 4))
 #define IXGBE_VMRVM(_i)      (0x0F630 + ((_i) * 4))
+#define IXGBE_LVMMC_RX	     0x2FA8
+#define IXGBE_LVMMC_TX	     0x8108
 #define IXGBE_WQBR_RX(_i)    (0x2FB0 + ((_i) * 4)) /* 4 total */
 #define IXGBE_WQBR_TX(_i)    (0x8130 + ((_i) * 4)) /* 4 total */
 #define IXGBE_L34T_IMIR(_i)  (0x0E800 + ((_i) * 4)) /*128 of these (0-127)*/
-- 
2.47.1


