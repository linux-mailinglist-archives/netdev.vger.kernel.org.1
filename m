Return-Path: <netdev+bounces-166544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF50FA36624
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 20:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 838591729C4
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 19:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B0A1FBEAF;
	Fri, 14 Feb 2025 19:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XdMGmGVt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CC01DDA0C
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 19:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739561285; cv=none; b=NRlxX2/MX4v7bpnkkU9fHuoPdsZKCOljP/6gZh1tVxKpLGbMCzOYIAGhZlUms8qPhS8DtLhOlWVqUeADmNgwMPQNYx0Vam4rHiUrUY4GMuk+lsxRdcjxdWIrD3dD+XCHf/HjvX3l5k+znfyMXZgJzd6IRMGx2tiOmmPtc/aRUzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739561285; c=relaxed/simple;
	bh=HjxfxSGFzLZnZni3FKyBwJ8TzVARCP9s2XeKsuyvS24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=noALOpfdvoI0xqRTgQ8gL2iGoo7Di0LpFFicCVU/Y9pzqPU+5qKK2dksU1CMXB6jyM4/yPIWOR+JX+Cp0hvoZoybJlzVDCsKnxrE7aU8ZSq5X80KKMTwVdTnu/aCu3VnWFUAOud+6C6jUE3okuKAafwaw4jlQedN7u9AKw4rZr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XdMGmGVt; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739561283; x=1771097283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HjxfxSGFzLZnZni3FKyBwJ8TzVARCP9s2XeKsuyvS24=;
  b=XdMGmGVtyRFaZfsMHtOcnR8yd+GfvL9Vpdleq/Aqvskxq2uRpMyBjRLU
   MijbaitS9x4L07Q8aUDKmXLUOnTkPa+hwOCVTYpEb/Uw8ACgsOK8wUrKN
   PgMTF6qOCugk+4c+0iCyuzgPgu0tgKCb9ceG2iPxJi5uYn5jS1RaiDbgR
   qbDL7iVRPnfSO5blHeoOMEL1beTZcFtuYQ+7za5Lln9vjCfMUyZWik6es
   JEeSRrU4K7hzNT7clh4bgb0AQOK/Kkmz/jrHJHYpPVElMPpehV+ulda1J
   ZgyA0+b9eov2TehkB6uRD+UX19Fkzw6tBNQgTQgxj08quDYghN4M5Lke4
   g==;
X-CSE-ConnectionGUID: 2tVpvM8rQq63zKgIT+b2QA==
X-CSE-MsgGUID: meJxL1mMQvCKNmRMYdmihw==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40244175"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40244175"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 11:27:54 -0800
X-CSE-ConnectionGUID: RhIoEUusTiOryPwTtjDeYA==
X-CSE-MsgGUID: ldXQunOQRom1n0mnkyvbtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="144394018"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 14 Feb 2025 11:27:54 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	mateusz.polchlopek@intel.com,
	richardcochran@gmail.com,
	horms@kernel.org,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 13/14] iavf: handle set and get timestamps ops
Date: Fri, 14 Feb 2025 11:27:34 -0800
Message-ID: <20250214192739.1175740-14-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250214192739.1175740-1-anthony.l.nguyen@intel.com>
References: <20250214192739.1175740-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

Add handlers for the .ndo_hwtstamp_get and .ndo_hwtstamp_set ops which
allow userspace to request timestamp enablement for the device. This
support allows standard Linux applications to request the timestamping
desired.

As with other devices that support timestamping all packets, the driver
will upgrade any request for timestamping of a specific type of packet
to HWTSTAMP_FILTER_ALL.

The current configuration is stored, so that it can be retrieved by
calling .ndo_hwtstamp_get

The Tx timestamps are not implemented yet so calling set ops for
Tx path will end with EOPNOTSUPP error code.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c |  21 ++++
 drivers/net/ethernet/intel/iavf/iavf_ptp.c  | 100 ++++++++++++++++++++
 drivers/net/ethernet/intel/iavf/iavf_ptp.h  |   9 ++
 drivers/net/ethernet/intel/iavf/iavf_txrx.h |   1 +
 4 files changed, 131 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index d545b34496e7..2d908ff0152c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -5170,6 +5170,25 @@ static netdev_features_t iavf_fix_features(struct net_device *netdev,
 	return iavf_fix_strip_features(adapter, features);
 }
 
+static int iavf_hwstamp_get(struct net_device *netdev,
+			    struct kernel_hwtstamp_config *config)
+{
+	struct iavf_adapter *adapter = netdev_priv(netdev);
+
+	*config = adapter->ptp.hwtstamp_config;
+
+	return 0;
+}
+
+static int iavf_hwstamp_set(struct net_device *netdev,
+			    struct kernel_hwtstamp_config *config,
+			    struct netlink_ext_ack *extack)
+{
+	struct iavf_adapter *adapter = netdev_priv(netdev);
+
+	return iavf_ptp_set_ts_config(adapter, config, extack);
+}
+
 static int
 iavf_verify_shaper(struct net_shaper_binding *binding,
 		   const struct net_shaper *shaper,
@@ -5278,6 +5297,8 @@ static const struct net_device_ops iavf_netdev_ops = {
 	.ndo_set_features	= iavf_set_features,
 	.ndo_setup_tc		= iavf_setup_tc,
 	.net_shaper_ops		= &iavf_shaper_ops,
+	.ndo_hwtstamp_get	= iavf_hwstamp_get,
+	.ndo_hwtstamp_set	= iavf_hwstamp_set,
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.c b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
index c2e0d27552b0..4246ddfa6f0d 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ptp.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
@@ -7,6 +7,100 @@
 #define iavf_clock_to_adapter(info)				\
 	container_of_const(info, struct iavf_adapter, ptp.info)
 
+/**
+ * iavf_ptp_disable_rx_tstamp - Disable timestamping in Rx rings
+ * @adapter: private adapter structure
+ *
+ * Disable timestamp reporting for all Rx rings.
+ */
+static void iavf_ptp_disable_rx_tstamp(struct iavf_adapter *adapter)
+{
+	for (u32 i = 0; i < adapter->num_active_queues; i++)
+		adapter->rx_rings[i].flags &= ~IAVF_TXRX_FLAGS_HW_TSTAMP;
+}
+
+/**
+ * iavf_ptp_enable_rx_tstamp - Enable timestamping in Rx rings
+ * @adapter: private adapter structure
+ *
+ * Enable timestamp reporting for all Rx rings.
+ */
+static void iavf_ptp_enable_rx_tstamp(struct iavf_adapter *adapter)
+{
+	for (u32 i = 0; i < adapter->num_active_queues; i++)
+		adapter->rx_rings[i].flags |= IAVF_TXRX_FLAGS_HW_TSTAMP;
+}
+
+/**
+ * iavf_ptp_set_timestamp_mode - Set device timestamping mode
+ * @adapter: private adapter structure
+ * @config: pointer to kernel_hwtstamp_config
+ *
+ * Set the timestamping mode requested from the userspace.
+ *
+ * Note: this function always translates Rx timestamp requests for any packet
+ * category into HWTSTAMP_FILTER_ALL.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+static int iavf_ptp_set_timestamp_mode(struct iavf_adapter *adapter,
+				       struct kernel_hwtstamp_config *config)
+{
+	/* Reserved for future extensions. */
+	if (config->flags)
+		return -EINVAL;
+
+	switch (config->tx_type) {
+	case HWTSTAMP_TX_OFF:
+		break;
+	case HWTSTAMP_TX_ON:
+		return -EOPNOTSUPP;
+	default:
+		return -ERANGE;
+	}
+
+	if (config->rx_filter == HWTSTAMP_FILTER_NONE) {
+		iavf_ptp_disable_rx_tstamp(adapter);
+		return 0;
+	} else if (config->rx_filter > HWTSTAMP_FILTER_NTP_ALL) {
+		return -ERANGE;
+	} else if (!(iavf_ptp_cap_supported(adapter,
+					    VIRTCHNL_1588_PTP_CAP_RX_TSTAMP))) {
+		return -EOPNOTSUPP;
+	}
+
+	config->rx_filter = HWTSTAMP_FILTER_ALL;
+	iavf_ptp_enable_rx_tstamp(adapter);
+
+	return 0;
+}
+
+/**
+ * iavf_ptp_set_ts_config - Set timestamping configuration
+ * @adapter: private adapter structure
+ * @config: pointer to kernel_hwtstamp_config structure
+ * @extack: pointer to netlink_ext_ack structure
+ *
+ * Program the requested timestamping configuration to the device.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int iavf_ptp_set_ts_config(struct iavf_adapter *adapter,
+			   struct kernel_hwtstamp_config *config,
+			   struct netlink_ext_ack *extack)
+{
+	int err;
+
+	err = iavf_ptp_set_timestamp_mode(adapter, config);
+	if (err)
+		return err;
+
+	/* Save successful settings for future reference */
+	adapter->ptp.hwtstamp_config = *config;
+
+	return 0;
+}
+
 /**
  * iavf_ptp_cap_supported - Check if a PTP capability is supported
  * @adapter: private adapter structure
@@ -321,4 +415,10 @@ void iavf_ptp_process_caps(struct iavf_adapter *adapter)
 		iavf_ptp_release(adapter);
 	else if (!adapter->ptp.clock && phc)
 		iavf_ptp_init(adapter);
+
+	/* Check if the device lost access to Rx timestamp incoming packets */
+	if (!iavf_ptp_cap_supported(adapter, VIRTCHNL_1588_PTP_CAP_RX_TSTAMP)) {
+		adapter->ptp.hwtstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
+		iavf_ptp_disable_rx_tstamp(adapter);
+	}
 }
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.h b/drivers/net/ethernet/intel/iavf/iavf_ptp.h
index 8e2f1ed18b86..0801e3ff5a59 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ptp.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.h
@@ -12,6 +12,9 @@ void iavf_ptp_release(struct iavf_adapter *adapter);
 void iavf_ptp_process_caps(struct iavf_adapter *adapter);
 bool iavf_ptp_cap_supported(const struct iavf_adapter *adapter, u32 cap);
 void iavf_virtchnl_send_ptp_cmd(struct iavf_adapter *adapter);
+int iavf_ptp_set_ts_config(struct iavf_adapter *adapter,
+			   struct kernel_hwtstamp_config *config,
+			   struct netlink_ext_ack *extack);
 #else /* IS_ENABLED(CONFIG_PTP_1588_CLOCK) */
 static inline void iavf_ptp_init(struct iavf_adapter *adapter) { }
 static inline void iavf_ptp_release(struct iavf_adapter *adapter) { }
@@ -23,5 +26,11 @@ static inline bool iavf_ptp_cap_supported(const struct iavf_adapter *adapter,
 }
 
 static inline void iavf_virtchnl_send_ptp_cmd(struct iavf_adapter *adapter) { }
+static inline int iavf_ptp_set_ts_config(struct iavf_adapter *adapter,
+					 struct kernel_hwtstamp_config *config,
+					 struct netlink_ext_ack *extack)
+{
+	return -1;
+}
 #endif /* IS_ENABLED(CONFIG_PTP_1588_CLOCK) */
 #endif /* _IAVF_PTP_H_ */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.h b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
index dff5c8cd27ab..79ad554f2d53 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
@@ -252,6 +252,7 @@ struct iavf_ring {
 #define IAVF_TXRX_FLAGS_VLAN_TAG_LOC_L2TAG1	BIT(3)
 #define IAVF_TXR_FLAGS_VLAN_TAG_LOC_L2TAG2	BIT(4)
 #define IAVF_RXR_FLAGS_VLAN_TAG_LOC_L2TAG2_2	BIT(5)
+#define IAVF_TXRX_FLAGS_HW_TSTAMP		BIT(6)
 
 	/* stats structs */
 	struct iavf_queue_stats	stats;
-- 
2.47.1


